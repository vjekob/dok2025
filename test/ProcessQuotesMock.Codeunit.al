namespace Vjeko.Demos;

using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using System.Security.User;

codeunit 50100 ProcessQuotesMock implements IProcessQuotes
{
    Access = Internal;

    var
        _findQuotesResult: Boolean;
        _isInvokedMakeAndPostOrders: Boolean;
        _lastMakeAndPostOrdersParam: Record "Sales Header";
        _domesticCustomerPostingGroup: Code[20];
        _salespersonCode: Code[20];
        _isInvokedSetFilters: Boolean;
        _lastSetFiltersParam: Record "Sales Header";

    procedure SetResult_FindQuotes(NewResult: Boolean)
    begin
        _findQuotesResult := NewResult;
    end;

    procedure IsInvoked_MakeAndPostOrders(var SalesQuote: Record "Sales Header"): Boolean
    begin
        SalesQuote := _lastMakeAndPostOrdersParam;
        exit(_isInvokedMakeAndPostOrders);
    end;

    procedure FindQuotes(var SalesQuote: Record "Sales Header"; Controller: Interface IProcessQuotes): Boolean;
    begin
        exit(_findQuotesResult);
    end;

    procedure MakeAndPostOrders(var SalesQuote: Record "Sales Header");
    begin
        _isInvokedMakeAndPostOrders := true;
        _lastMakeAndPostOrdersParam := SalesQuote;
    end;

    procedure GetDomesticCustomerPostingGroup(var SalesSetup: Record "Sales & Receivables Setup"): Code[20]
    begin
        exit(_domesticCustomerPostingGroup);
    end;

    procedure GetSalespersonCode(var UserSetup: Record "User Setup"; WithGui: Boolean): Code[20]
    begin
        exit(_salespersonCode);
    end;

    procedure SetFilters(var SalesHeader: Record "Sales Header"; SalespersonCode: Code[20]; CustomerPostingGroup: Code[20]; AtDate: Date)
    begin
        _isInvokedSetFilters := true;
        _lastSetFiltersParam := SalesHeader;
    end;

    procedure SetResult_DomesticCustomerPostingGroup(NewPostingGroup: Code[20])
    begin
        _domesticCustomerPostingGroup := NewPostingGroup;
    end;

    procedure SetResult_SalespersonCode(NewSalespersonCode: Code[20])
    begin
        _salespersonCode := NewSalespersonCode;
    end;

    procedure IsInvoked_SetFilters(var SalesQuote: Record "Sales Header"): Boolean
    begin
        SalesQuote := _lastSetFiltersParam;
        exit(_isInvokedSetFilters);
    end;
}