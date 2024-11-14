namespace Vjeko.Demos.Test;

using Vjeko.Demos;
using System.TestLibraries.Utilities;
using Microsoft.Sales.Document;

codeunit 60003 "Test - ProcessQuotes"
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit "Library Assert";
        LibrarySales: Codeunit "Library - Sales";
        LibraryInventory: Codeunit "Library - Inventory";
        SUT: Codeunit ProcessQuotes;

    [Test]
    procedure ProcessQuotes_FindsQuotes_MakesAndPostsOrders()
    var
        ProcessQuotesMock: Codeunit "ProcessQuotesMock";
        SalesQuote: Record "Sales Header";
    begin
        // Arrange
        ProcessQuotesMock.SetResult_FindQuotes(true);

        // Act
        SUT.ProcessQuotes(ProcessQuotesMock);

        // Assert
        Assert.IsTrue(ProcessQuotesMock.IsInvoked_MakeAndPostOrders(SalesQuote), 'MakeAndPostOrders should be invoked');
    end;

    [Test]
    procedure ProcessQuotes_DoesNotFindQuotes_DoesNotMakeAndPostOrders()
    var
        ProcessQuotesMock: Codeunit "ProcessQuotesMock";
        SalesQuote: Record "Sales Header";
    begin
        // Arrange
        ProcessQuotesMock.SetResult_FindQuotes(false);

        // Act
        SUT.ProcessQuotes(ProcessQuotesMock);

        // Assert
        Assert.IsFalse(ProcessQuotesMock.IsInvoked_MakeAndPostOrders(SalesQuote), 'MakeAndPostOrders should not be invoked');
    end;
}
