
class OSs {
  OSs({
    required this.data,
    required this.id,
    required this.msg,
    required this.estrutura,
    required this.estruturaDescricao,
    required this.osAssuntoId,
    required this.assunto,
    required this.endereco,
    required this.bairro,
    required this.cidade,
    required this.complemento,
    required this.referencia,
    required this.razao,
    required this.cnpjCpf,
    required this.contratoStatus,
    required this.loginStatus,
    required this.login,
    required this.senha,
  });

  String data;
  String id;
  String msg;
  String estrutura;
  String estruturaDescricao;
  String osAssuntoId;
  String assunto;
  String endereco;
  String bairro;
  String cidade;
  String complemento;
  String referencia;
  String razao;
  String cnpjCpf;
  String contratoStatus;
  String loginStatus;
  String login;
  String senha;

  factory OSs.fromJson(Map<String, dynamic> json) => OSs(
    data: json["data"],
    id: json["id"],
    msg: json["msg"],
    estrutura: json["estrutura"],
    estruturaDescricao: json["estrutura_descricao"],
    osAssuntoId: json["os_assunto_id"],
    assunto: json["assunto"],
    endereco: json["endereco"],
    bairro: json["bairro"],
    cidade: json["cidade"],
    complemento: json["complemento"],
    referencia: json["referencia"],
    razao: json["razao"],
    cnpjCpf: json["cnpj_cpf"],
    contratoStatus: json["contrato_status"],
    loginStatus: json["login_status"],
    login: json["login"],
    senha: json["senha"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "id": id,
    "msg": msg,
    "estrutura": estrutura,
    "estrutura_descricao": estruturaDescricao,
    "os_assunto_id": osAssuntoId,
    "assunto": assunto,
    "endereco": endereco,
    "bairro": bairro,
    "cidade": cidade,
    "complemento": complemento,
    "referencia": referencia,
    "razao": razao,
    "cnpj_cpf": cnpjCpf,
    "contrato_status": contratoStatus,
    "login_status": loginStatus,
    "login": login,
    "senha": senha,
  };
}