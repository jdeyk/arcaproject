pragma solidity >= 0.5.0 < 0.6.0;

contract Arca {
    uint public idgatito = 0;

    struct gatito{
        uint id;
        string raza;
        string sexo;
        string nombre;
        string color;
        uint edad;
        address adoptante;
        bool adoptado;
    }
    
    mapping (address => gatito[]) public adoptantes;
    mapping (uint => gatito) public todosGatitos;
    
    
    // Modificadores
    address public owner;
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    // Crear un constructor para nuestro ADMIMISTRADOR (Proteger contrato)
    constructor() public{
        owner = msg.sender;
    }
    
    
    function recibirGatito(
        string memory _raza,
        string memory _sexo,
        string memory _nombre,
        string memory _color,
        uint _edad
        ) public onlyOwner returns (bool){
        gatito memory nuevoGatito = gatito({raza: _raza, sexo: _sexo, nombre: _nombre, color: _color, edad: _edad, id: idgatito++, adoptado: false, adoptante: address(0)});
        // adoptantes[msg.sender].push(nuevoGatito);
        todosGatitos[nuevoGatito.id] = nuevoGatito;    
        return true;
    }

    function adoptarGatito(uint _gatito) public returns (bool){
        //Validar si el gatito existe
        require(_gatito <= idgatito, "El gatito no existe");
        // Validar si gatito no esta adoptado
        require(!todosGatitos[_gatito].adoptado, "El tatito ya se encuentra adoptado");
        // Actualizamos gatitos
        todosGatitos[_gatito].adoptante = msg.sender;
        todosGatitos[_gatito].adoptado = true;
        // Agregar adoptantes
        adoptantes[msg.sender].push(todosGatitos[_gatito]);
        return true;
        
    }
}