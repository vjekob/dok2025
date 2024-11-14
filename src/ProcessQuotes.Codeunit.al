namespace Vjeko.Demos;

using System.Threading;
using Microsoft.Sales.Document;

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
        if not Controller.FindQuotes(SalesQuote) then
            exit;

        Controller.MakeAndPostOrders(SalesQuote);
    end;

    internal procedure FindQuotes(var SalesQuote: Record "Sales Header"): Boolean
    begin

    end;

    internal procedure MakeAndPostOrders(var SalesQuote: Record "Sales Header")
    begin

    end;
}
