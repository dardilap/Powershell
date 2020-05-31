function exec-dorian{

param(

[Parameter(Mandatory)]

[string] $strClase, 

[Parameter(Mandatory)]

[string] $strNameSpace 

)


# Creamos un nuevo objeto para refereniar al proveedor c# que nos ayudara a construir la clase que ejecutará el código powershell en memoria
$csharpProvider = New-Object Microsoft.CSharp.CSharpCodeProvider

# Creamos el compilador

$miCompilador = $csharpProvider.CreateCompiler()

# Asignamos los parámetros de compilación y referenciamos los ensamblados que vamos a necesitar

$Parametros=New-Object System.CodeDom.Compiler.CompilerParameters
$Parametros.GenerateExecutable=$False
$Parametros.GenerateInMemory=$True
$Parametros.IncludeDebugInformation=$False
$Parametros.ReferencedAssemblies.Add("System.dll") > $null
$Parametros.ReferencedAssemblies.Add("System.Core.dll") > $null
$Parametros.ReferencedAssemblies.Add("System.Management.dll") > $null 
$Parametros.ReferencedAssemblies.Add("C:\Windows\assembly\GAC_MSIL\System.Management.Automation\1.0.0.0__31bf3856ad364e35\System.Management.Automation.dll")> $null 

# Este es el string que contiene la clase que ejecutara el poweshell con la funcion

$Resultado=$csharpProvider.CompileAssemblyFromSource($Parametros,[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($strClase)))

$objClase = $Resultado.CompiledAssembly.CreateInstance($strNameSpace)

return $objClase

}
