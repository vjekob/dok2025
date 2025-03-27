namespace Vjeko.Demos.Test;

using Vjeko.Demos;
using System.TestLibraries.Utilities;
using Microsoft.Sales.Document;
using System.Security.User;

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

    [Test]
    procedure GetSalespersonCode_NoSetup_ReturnsEmptyCode()
    var
        UserSetup: Record "User Setup";
        SalespersonCode: Code[20];
    begin
        // Act
        SalespersonCode := SUT.GetSalespersonCode(UserSetup, false);

        // Assert
        Assert.AreEqual('', SalespersonCode, 'Salesperson code should be empty when no setup is found');
    end;

    [Test]
    procedure GetSalespersonCode_WithSetup_NotConfigured_Error()
    var
        UserSetup: Record "User Setup" temporary;
        SalespersonCode: Code[20];
    begin
        // Arrange
        UserSetup."User ID" := UserId;
        UserSetup."Salespers./Purch. Code" := '';
        UserSetup.Insert();

        // Act
        asserterror SUT.GetSalespersonCode(UserSetup, false);

        // Assert
        Assert.ExpectedErrorCode('TestField');
    end;

    [Test]
    procedure GetSalespersonCode_WithSetup_Configured_ReturnsCode()
    var
        UserSetup: Record "User Setup" temporary;
        SalespersonCode: Code[20];
    begin
        // Arrange
        UserSetup."User ID" := UserId;
        UserSetup."Salespers./Purch. Code" := 'SP001';
        UserSetup.Insert();

        // Act
        SalespersonCode := SUT.GetSalespersonCode(UserSetup, false);

        // Assert
        Assert.AreEqual('SP001', SalespersonCode, 'Salesperson code should match the setup');
    end;

    [Test]
    procedure SetFilters()
    var
        SalesHeader: Record "Sales Header" temporary;
        SalespersonCode: Code[20];
        CustomerPostingGroup: Code[20];
        AtDate: Date;
    begin
        // Act
        SUT.SetFilters(SalesHeader, 'SP001', 'CUST', WorkDate());

        // Assert
        Assert.AreEqual(SalesHeader."Salesperson Code", SalespersonCode, 'Salesperson code should be set correctly');
        Assert.AreEqual(SalesHeader."Customer Posting Group", CustomerPostingGroup, 'Customer posting group should be set correctly');
        Assert.AreEqual(SalesHeader."Shipment Date", AtDate, 'Shipment date should be set correctly');
        Assert.AreEqual(SalesHeader."Document Type", SalesHeader.GetRangeMin("Document Type"), 'Document type should be set to Quote');
        Assert.AreEqual(SalesHeader."Document Type", SalesHeader.GetRangeMax("Document Type"), 'Document type should be set to Quote');
        Assert.AreEqual(SalesHeader."Status", SalesHeader.GetRangeMin(Status), 'Status should be set to Open');
        Assert.AreEqual(SalesHeader."Status", SalesHeader.GetRangeMax(Status), 'Status should be set to Open');
    end;
}
