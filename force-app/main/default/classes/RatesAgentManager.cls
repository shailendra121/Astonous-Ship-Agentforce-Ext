global with sharing class RatesAgentManager {

    @InvocableMethod(
        label='Get Shipping Rates'
        callout=true
        description='Fetches available shipping carrier rates for a recipient record and package weight.'
    )
    global static List<RatingRequestResult> getShippingRates(
        List<RatingRequestInput> inputs
    ) {
        List<RatingRequestResult> results = new List<RatingRequestResult>();

        if (inputs == null || inputs.isEmpty()) {
            return results;
        }

        for (RatingRequestInput input : inputs) {
            RatingRequestResult result = new RatingRequestResult();
            result.rates = new List<String>();

            if (input == null) {
                result.errorMessage = 'No input provided.';
                results.add(result);
                continue;
            }

            if (String.isBlank(input.recipientRecordId)) {
                result.errorMessage = 'Recipient record ID is required.';
                results.add(result);
                continue;
            }

            Decimal weight;
            try {
                weight = Decimal.valueOf(input.weight);
            } catch (Exception e) {
                result.errorMessage = 'Invalid weight value: ' + input.weight;
                results.add(result);
                continue;
            }

            try {
                // The managed package populates the recipient and shipping defaults.
                Astonous_SM.RatingRequest ratingRequest =
                    Astonous_SM.ShippingController.initRatingRequest(
                        input.recipientRecordId,
                        false,
                        null
                    );

                if (
                    ratingRequest == null ||
                    ratingRequest.packageList == null ||
                    ratingRequest.packageList.isEmpty()
                ) {
                    result.errorMessage = 'The package did not initialize a package for the rating request.';
                    results.add(result);
                    continue;
                }

                ratingRequest.packageList[0].weight = weight;

                List<Astonous_SM.ShippingRate> rates =
                    Astonous_SM.ShippingController.fetchAllShippingRates(ratingRequest);

                if (rates != null) {
                    for (Astonous_SM.ShippingRate rate : rates) {
                        result.rates.add(
                            'Carrier: ' + ratingRequest.shippingCarrier +
                            ', ServiceType: ' + rate.serviceType +
                            ', Amount: ' + rate.totalCharge +
                            ', DeliveryDate: ' + String.valueOf(rate.expectedDeliveryDate)
                        );
                    }
                }
            } catch (Exception e) {
                result.errorMessage = 'Error fetching rates: ' + e.getMessage();
            }

            results.add(result);
        }

        return results;
    }

    global class RatingRequestInput {
        @InvocableVariable(
            label='Recipient Record ID'
            description='Record used by the Astonous Shipping Manager package to initialize the rating request.'
            required=true
        )
        global String recipientRecordId;

        @InvocableVariable(label='Weight' description='Package weight as a number, e.g. 2.5' required=true)
        global String weight;
    }

    global class RatingRequestResult {
        @InvocableVariable(label='Shipping Rates' description='List of available shipping rate quotes.')
        global List<String> rates;

        @InvocableVariable(label='Error Message' description='Populated if the rate lookup failed for this input.')
        global String errorMessage;
    }
}
