unit untNetwork.Intf;

interface

uses
  untNetwork.Element;
type
  INetwork = interface
    ['{2038E6FA-0796-47D7-86C6-3004C521F9CD}']

    procedure Connect(AFirstElement, ASecondElement : integer);
    function Query(AFirstElement, ASecondElement : integer) : boolean;
    function Element(AIdx : integer) : TNetworkElement;
  end;


implementation

end.
