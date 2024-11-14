namespace Vjeko.Demos;

using Microsoft.Sales.Document;

interface IProcessQuotes
{
    Access = Internal;

    procedure FindQuotes(var SalesQuote: Record "Sales Header"): Boolean;
    procedure MakeAndPostOrders(var SalesQuote: Record "Sales Header");
}
