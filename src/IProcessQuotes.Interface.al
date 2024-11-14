namespace Vjeko.Demos;

using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using System.Security.User;

interface IProcessQuotes
{
    Access = Internal;

    procedure FindQuotes(var SalesQuote: Record "Sales Header"; Controller: Interface IProcessQuotes): Boolean;
    procedure MakeAndPostOrders(var SalesQuote: Record "Sales Header");
    procedure GetDomesticCustomerPostingGroup(var SalesSetup: Record "Sales & Receivables Setup"): Code[20];
    procedure GetSalespersonCode(var UserSetup: Record "User Setup"; WithGui: Boolean): Code[20];
    procedure SetFilters(var SalesHeader: Record "Sales Header"; SalespersonCode: Code[20]; CustomerPostingGroup: Code[20]; AtDate: Date);
}
