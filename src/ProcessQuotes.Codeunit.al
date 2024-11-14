namespace Vjeko.Demos;

using System.Threading;
using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using System.Security.User;

codeunit 50011 ProcessQuotes implements IProcessQuotes
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        ProcessQuotes();
    end;

    procedure ProcessQuotes()
    begin
        ProcessQuotes(this);
    end;

    internal procedure ProcessQuotes(Controller: Interface IProcessQuotes)
    var
        SalesQuote: Record "Sales Header";
    begin
        if not Controller.FindQuotes(SalesQuote, Controller) then
            exit;

        Controller.MakeAndPostOrders(SalesQuote);
    end;

    internal procedure FindQuotes(var SalesQuote: Record "Sales Header"; Controller: Interface IProcessQuotes): Boolean
    var
        SalesSetup: Record "Sales & Receivables Setup";
        UserSetup: Record "User Setup";
        CustPostGroup: Code[20];
        SalespersonCode: Code[20];
        AtDate: Date;
    begin
        CustPostGroup := Controller.GetDomesticCustomerPostingGroup(SalesSetup);
        SalespersonCode := Controller.GetSalespersonCode(UserSetup, GuiAllowed);
        AtDate := WorkDate();
        Controller.SetFilters(SalesQuote, SalespersonCode, CustPostGroup, AtDate);
        exit(SalesQuote.FindSet(true));
    end;

    internal procedure MakeAndPostOrders(var SalesQuote: Record "Sales Header")
    begin

    end;

    procedure GetDomesticCustomerPostingGroup(var SalesSetup: Record "Sales & Receivables Setup"): Code[20]
    begin

    end;

    procedure GetSalespersonCode(var UserSetup: Record "User Setup"; GuiAllowed: Boolean): Code[20]
    begin

    end;

    procedure SetFilters(var SalesHeader: Record "Sales Header"; SalespersonCode: Code[20]; CustomerPostingGroup: Code[20]; AtDate: Date)
    begin

    end;
}
