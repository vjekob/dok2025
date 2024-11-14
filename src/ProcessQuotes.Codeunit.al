namespace Vjeko.Demos;

using System.Threading;
using Microsoft.Sales.Document;

codeunit 50011 ProcessQuotes
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        ProcessQuotes();
    end;

    procedure ProcessQuotes()
    var
        SalesQuote: Record "Sales Header";
    begin
        if not FindQuotes(SalesQuote) then
            exit;

        MakeAndPostOrders(SalesQuote);
    end;

    local procedure FindQuotes(var SalesQuote: Record "Sales Header"): Boolean
    begin

    end;

    local procedure MakeAndPostOrders(var SalesQuote: Record "Sales Header")
    begin

    end;
}
