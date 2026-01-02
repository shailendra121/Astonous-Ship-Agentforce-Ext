public with sharing class ShippingRateInvoker {
  public class ShippingRateInputWrapper {
    @InvocableVariable(required=true)
    public String senderPostalCode;

    @InvocableVariable(required=true)
    public String recipientPostalCode;

    @InvocableVariable(required=true)
    public String Packageweight;
  }

  public class ShippingRateOutputWrapper {
    @InvocableVariable
    @AuraEnabled
    public String message;
  }

  @InvocableMethod(label='Get Shipping Rates')
  public static List<ShippingRateOutputWrapper> getData(
    List<ShippingRateInputWrapper> inputs
  ) {
    List<ShippingRateOutputWrapper> outputs = new List<ShippingRateOutputWrapper>();

    for (ShippingRateInputWrapper input : inputs) {
      Astonous_SM.RatingRequest req = new Astonous_SM.RatingRequest();

      req.shippingCarrier = 'FedEx';
      req.serviceType = 'All';
      req.currencyUnit = 'USD';
      req.dropoffType = '01';

      req.weightUnit = 'LB';
      req.senderInfomration.country = 'US';
      req.senderInfomration.postalCode = input.senderPostalCode;

      req.recipientInfomration.country = 'US';
      req.recipientInfomration.postalCode = input.recipientPostalCode;

      Astonous_SM.RatingRequest.ShippingPackage pkg = req.packageList[0];
      pkg.weight = Decimal.valueOf(input.Packageweight);

      List<Astonous_SM.ShippingRate> rates = Astonous_SM.ShippingController.fetchAllShippingRates(
        req
      );

      String allRatesText = '';

      for (Astonous_SM.ShippingRate rate : rates) {
        allRatesText +=
          'Service -' +
          ' ' +
          rate.serviceType +
          '\n' +
          'Shipping rate' +
          ' ' +
          rate.totalCharge +
          '\n' +
          'Expected delivery Date' +
          ' ' +
          rate.expectedDeliveryDate +
          '\n' +
          '\n';
      }
      ShippingRateOutputWrapper output = new ShippingRateOutputWrapper();
      output.message = allRatesText;
      outputs.add(output);
    }

    return outputs;
  }
}
