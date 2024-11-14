
namespace Vjeko.Demos;

using Microsoft.Sales.Document;

codeunit 50100 ProcessQuotesMock implements IProcessQuotes
{
    var
        _findQuotesResult: Boolean;
        _isInvokedMakeAndPostOrders: Boolean;
        _lastMakeAndPostOrdersParam: Record "Sales Header";

    procedure SetResult_FindQuotes(NewResult: Boolean)
    begin
        _findQuotesResult := NewResult;
    end;

    procedure IsInvoked_MakeAndPostOrders(var SalesQuote: Record "Sales Header"): Boolean
    begin
        SalesQuote := _lastMakeAndPostOrdersParam;
        exit(_isInvokedMakeAndPostOrders);
    end;

    procedure FindQuotes(var SalesQuote: Record "Sales Header"): Boolean;
    begin
        exit(_findQuotesResult);
    end;

    procedure MakeAndPostOrders(var SalesQuote: Record "Sales Header");
    begin
        _isInvokedMakeAndPostOrders := true;
        _lastMakeAndPostOrdersParam := SalesQuote;
    end;
}