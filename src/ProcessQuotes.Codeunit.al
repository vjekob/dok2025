namespace Vjeko.Demos;

using System.Threading;

codeunit 50011 ProcessQuotes
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        ProcessQuotes();
    end;

    procedure ProcessQuotes()
    begin
    end;
}
