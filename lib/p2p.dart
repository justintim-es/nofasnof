import 'dart:io';
import 'dart:convert';
import 'dart:isolate';
import 'package:nofiftyone/models/gladiator.dart';
import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';
import 'package:nofiftyone/models/humanify.dart';
import 'package:nofiftyone/models/pera.dart';
import 'package:nofiftyone/models/obstructionum.dart';
import 'package:nofiftyone/models/constantes.dart';
import 'package:nofiftyone/models/scan.dart';
import 'package:nofiftyone/models/utils.dart';
import 'package:nofiftyone/models/transaction.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
class P2PMessage {
  String type;
  String? from;
  P2PMessage(this.type, this.from);
  P2PMessage.fromJson(Map<String, dynamic> jsoschon):
    type = jsoschon['type'].toString(), from = jsoschon['from'].toString();
  Map<String, dynamic> toJson() => {
    'type': type,
    'from': from
  };
}
class SingleSocketP2PMessage extends P2PMessage {
  String socket;
  SingleSocketP2PMessage(this.socket, String type, String from): super(type, from);
  SingleSocketP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    socket = jsoschon['socket'].toString(),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'socket': socket,
    'type': type,
  };
}
class ConnectBootnodeP2PMessage extends P2PMessage {
  String socket;
  ConnectBootnodeP2PMessage(this.socket, String type, String from): super(type, from);
  ConnectBootnodeP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    socket = jsoschon['socket'].toString(),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'socket': socket,
    'type': type
  };
}
class OnConnectP2PMessage extends P2PMessage {
  List<String> sockets;
  List<Propter> propters;
  List<Transaction> liberTxs;
  List<Transaction> fixumTxs;
  OnConnectP2PMessage(this.sockets, this.propters, this.liberTxs, this.fixumTxs, String type, String from): super(type, from);
  OnConnectP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    sockets = List<String>.from(jsoschon['sockets'] as List<dynamic>),
    propters = List<Propter>.from(jsoschon['propters'].map((x) => Propter.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>),
    liberTxs = List<Transaction>.from(jsoschon['liberTxs'].map((x) => Transaction.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>),
    fixumTxs = List<Transaction>.from(jsoschon['fixumTxs'].map((x) => Transaction.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'sockets': sockets,
    'propters': propters.map((p) => p.toJson()).toList(),
    'liberTxs': liberTxs.map((liber) => liber.toJson()).toList(),
    'fixumTxs': fixumTxs.map((liber) => liber.toJson()).toList(),
    'type': type
  };
}
class SocketsP2PMessage extends P2PMessage {
  List<String> sockets;
  SocketsP2PMessage(this.sockets, String type, String from): super(type, from);
  SocketsP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    sockets = List<String>.from(jsoschon['sockets'] as List<dynamic>),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'sockets': sockets
  };
}

class ScanP2PMessage extends P2PMessage {
  Scan scan;
  ScanP2PMessage(this.scan, String type, String from): super(type, from);
  ScanP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    scan = Scan.fromJson(jsoschon['scan'] as Map<String, dynamic>),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'scan': scan.toJson(),
    'type': type,
    'from': from
  };
}
class PropterP2PMessage extends P2PMessage {
  Propter propter;
  PropterP2PMessage(this.propter, String type, String from): super(type, from);
  PropterP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    propter = Propter.fromJson(jsoschon['propter'] as Map<String, dynamic>),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'propter': propter.toJson(),
    'type': type,
    'from': from
  };
}
class HumanifyP2PMessage extends P2PMessage {
  Humanify humanify;
  HumanifyP2PMessage(this.humanify, String type, String from): super(type, from);
  HumanifyP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    humanify = Humanify.fromJson(jsoschon['humanify'] as Map<String, dynamic>),
    super.fromJson(jsoschon);

  @override
  Map<String, dynamic> toJson() => {
    'humanify': humanify.toJson(),
    'type': type,
    'from': from
  };

}
class RemoveProptersP2PMessage extends P2PMessage {
  List<String> ids;
  RemoveProptersP2PMessage(this.ids, String type, String from): super(type, from);
  RemoveProptersP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    ids = List<String>.from(jsoschon['ids'] as List<dynamic>),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'ids': ids,
    'type': type
  };
}
class TransactionP2PMessage extends P2PMessage {
  Transaction tx;
  TransactionP2PMessage(this.tx, String type, String from): super(type, from);
  TransactionP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    tx = Transaction.fromJson(jsoschon['tx'] as Map<String, dynamic>),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'tx': tx.toJson(),
    'type': type
  };
}
class RemoveTransactionsP2PMessage extends P2PMessage {
  List<String> ids;
  RemoveTransactionsP2PMessage(this.ids, String type, String from): super(type, from);
  RemoveTransactionsP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    ids = List<String>.from(jsoschon['ids'] as List<dynamic>),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'ids': ids,
    'type': type
  };
}
class ObstructionumP2PMessage extends P2PMessage {
  String secret;
  Obstructionum obstructionum;
  ObstructionumP2PMessage(this.secret, this.obstructionum, String type, String from): super(type, from);
  ObstructionumP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    obstructionum = Obstructionum.fromJson(jsoschon['obstructionum'] as Map<String, dynamic>),
    secret = jsoschon['secret'] as String,
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'obstructionum': obstructionum.toJson(),
    'secret': secret,
    'type': type
  };
}
class RequestObstructionumP2PMessage extends P2PMessage {
  List<int> numerus;
  RequestObstructionumP2PMessage(this.numerus, String type, String from): super(type, from);
  RequestObstructionumP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    numerus = List<int>.from(jsoschon['numerus'] as List<dynamic>),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'numerus': numerus,
    'type': type
  };
}
class ProbationemP2PMessage extends P2PMessage {
  String probationem;
  String secret;
  ProbationemP2PMessage(this.probationem, this.secret, String type, String from): super(type, from);
  ProbationemP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    probationem = jsoschon['probationem'].toString(),
    secret = jsoschon['secret'].toString(),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'probationem': probationem,
    'secret': secret,
    'type': type
  };
}
class P2P {
  int maxPeers;
  String secret;
  String from;
  List<String> sockets = [];
  List<Propter> propters = [];
  List<Transaction> liberTxs = [];
  List<Transaction> fixumTxs = [];
  List<Transaction> expressieTxs = [];
  List<Isolate> syncBlocks = [];
  Directory dir;
  ReceivePort efectusRp = ReceivePort();
  ReceivePort confussusRp = ReceivePort();
  ReceivePort expressiRp = ReceivePort();
  bool isEfectusActive = false;
  bool isConfussusActive = false;
  bool isExpressiActive = false;

  List<Scan> scans = [];
  List<Humanify> humanifies = [];


  List<int> summaNumerus;
  P2P(this.maxPeers, this.secret, this.from, this.dir, this.summaNumerus);
  listen(String internalIp, int port) async {
    ServerSocket serverSocket = await ServerSocket.bind(internalIp, port);
    print(serverSocket.address);
    print(serverSocket.port);
    serverSocket.listen((client) {
      client.listen((data) async {
        print(client.address.address);
        print(client.port);
        
        P2PMessage msg = P2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
        if(msg.type == 'connect-bootnode') {
          ConnectBootnodeP2PMessage cbp2pm = ConnectBootnodeP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          client.write(json.encode(OnConnectP2PMessage(sockets, propters, liberTxs, fixumTxs, 'on-connect', '${client.address.address}:${client.port}').toJson()));
          // client.destroy();
          for(String socket in sockets) {
            Socket s = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
            s.write(json.encode(SingleSocketP2PMessage(cbp2pm.socket, 'single-socket', '${client.address.address}:${client.port}')));
          }
          if(sockets.length < maxPeers && !sockets.contains(cbp2pm.socket) && cbp2pm.socket != '$internalIp:$port') {
            sockets.add(cbp2pm.socket);
          }
        } else if (msg.type == 'single-socket') {
          SingleSocketP2PMessage ssp2pm = SingleSocketP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          if(sockets.length < maxPeers && ssp2pm.socket != '$internalIp:$port') {
            sockets.add(ssp2pm.socket);
          }
          client.destroy();
        } else if (msg.type == 'humanify') {
          HumanifyP2PMessage hp2pm = HumanifyP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          if (hp2pm.humanify.probationem == HEX.encode(sha256.convert(utf8.encode(json.encode(hp2pm.humanify.interiore.toJson()))).bytes)) {
            if (humanifies.any((h) => h.interiore.id == hp2pm.humanify.interiore.id)) {
              humanifies.removeWhere((element) => element.interiore.id == hp2pm.humanify.interiore.id);
            }
            humanifies.add(hp2pm.humanify);
            client.destroy();
          } 
        } else if (msg.type == 'scan') {
          ScanP2PMessage sp2pm = ScanP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          List<Obstructionum> obss = await Utils.getObstructionums(dir);
          for (List<Scan> scans in obss.map((e) => e.interioreObstructionum.scans)) {
          if(!scans.any((element) => element.input!.passphraseIndex == sp2pm.scan.input!.passphraseIndex && element.input!.probationem == sp2pm.scan.input!.probationem)) {
            scans.add(sp2pm.scan);
          }
          client.destroy();
        }
        } else if(msg.type == 'propter') {
          PropterP2PMessage pp2pm = PropterP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          if(pp2pm.propter.probationem == HEX.encode(sha256.convert(utf8.encode(json.encode(pp2pm.propter.interioreRationem.toJson()))).bytes)) {
            if(propters.any((p) => p.interioreRationem.id == pp2pm.propter.interioreRationem.id)) {
              propters.removeWhere((p) => p.interioreRationem.id == pp2pm.propter.interioreRationem.id);
            }
            propters.add(pp2pm.propter);
            client.destroy();
          }
        } else if (msg.type == 'remove-propters') {
          RemoveProptersP2PMessage rpp2pm = RemoveProptersP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          propters.removeWhere((p) => rpp2pm.ids.any((id) => id == p.interioreRationem.id));
          client.destroy();
        } else if (msg.type == 'expressi-tx') {
          TransactionP2PMessage tp2pm = TransactionP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          //maby some validation
          expressieTxs.add(tp2pm.tx);
        } else if (msg.type == 'liber-tx') {
          TransactionP2PMessage tp2pm = TransactionP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          List<Obstructionum> obs = await Obstructionum.getBlocks(dir);
          if (await tp2pm.tx.validateLiber(dir)) {
              if (liberTxs.any((tx) => tx.interioreTransaction.id == tp2pm.tx.interioreTransaction.id)) {
                liberTxs.removeWhere((tx) => tx.interioreTransaction.id == tp2pm.tx.interioreTransaction.id);
              }
              liberTxs.add(tp2pm.tx);
          } else {
            client.write(json.encode(RemoveProptersP2PMessage(List<String>.from([tp2pm.tx.interioreTransaction.id]), 'remove-liber-txs', '${client.address.address}:${client.port}').toJson()));
          }
        } else if (msg.type == 'fixum-tx') {
          TransactionP2PMessage tp2pm = TransactionP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          List<Obstructionum> obs = await Obstructionum.getBlocks(dir);
          if (await tp2pm.tx.validateFixum(dir)) {
              if (fixumTxs.any((tx) => tx.interioreTransaction.id == tp2pm.tx.interioreTransaction.id)) {
                fixumTxs.removeWhere((tx) => tx.interioreTransaction.id == tp2pm.tx.interioreTransaction.id);
              }
              fixumTxs.add(tp2pm.tx);
          } else {
            client.write(json.encode(RemoveProptersP2PMessage(List<String>.from([tp2pm.tx.interioreTransaction.id]), 'remove-fixum-txs', '${client.address.address}:${client.port}').toJson()));
          }
        } else if (msg.type == 'remove-liber-txs') {
          RemoveTransactionsP2PMessage rtp2pm = RemoveTransactionsP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          liberTxs.removeWhere((l) => rtp2pm.ids.any((id) => id == l.interioreTransaction.id));
          client.destroy();
        } else if (msg.type == 'remove-fixum-txs') {
          RemoveTransactionsP2PMessage rtp2pm = RemoveTransactionsP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          fixumTxs.removeWhere((l) => rtp2pm.ids.any((id) => id == l.interioreTransaction.id));
          client.destroy();
        } else if (msg.type == 'obstructionum') {
          ObstructionumP2PMessage op2pm = ObstructionumP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          print('recieved obstructionum ${op2pm.obstructionum.interioreObstructionum.obstructionumNumerus}');
          if (dir.listSync().isEmpty && op2pm.obstructionum.interioreObstructionum.generare == Generare.INCIPIO) {
            await op2pm.obstructionum.salvareIncipio(dir);
            client.write(json.encode(RequestObstructionumP2PMessage([1], 'request-obstructionum', '${client.address.address}:${client.port}').toJson()));
            print('requested incipio block');
          } else if (dir.listSync().isEmpty && op2pm.obstructionum.interioreObstructionum.generare != Generare.INCIPIO) {
              client.write(json.encode(RequestObstructionumP2PMessage([0], 'request-obstructionum', '${client.address.address}:${client.port}').toJson()));
              print('requested block one');
          } else {
            Obstructionum obs = await Utils.priorObstructionum(dir);
            summaNumerus = obs.interioreObstructionum.obstructionumNumerus;
            if (!op2pm.obstructionum.isProbationem()) {
              print('invalid probationem');
              return;
            }
            // because here the difficulty isnt reater
            if (
              op2pm.obstructionum.interioreObstructionum.summaObstructionumDifficultas >= 
              obs.interioreObstructionum.summaObstructionumDifficultas || 
              op2pm.secret == secret) {
              List<Obstructionum> obss = await Obstructionum.getBlocks(dir);
              print(obs.probationem);
              print(op2pm.obstructionum.interioreObstructionum.priorProbationem);
              if (
                obs.probationem == op2pm.obstructionum.interioreObstructionum.priorProbationem
              ) {
                secret = Utils.randomHex(32);
                if (op2pm.obstructionum.interioreObstructionum.forumCap != await Obstructionum.accipereForumCap(dir)) {
                  print("Corrumpere forum cap");
                  return;
                }
                if (op2pm.obstructionum.interioreObstructionum.summaObstructionumDifficultas != await Obstructionum.utSummaDifficultas(dir)) {
                  print("corrumpere summaObstructionumDifficultas");
                  return;
                }
                BigInt nuschum = BigInt.zero;
                for (int n in await Obstructionum.utObstructionumNumerus(dir)) {
                  nuschum += BigInt.parse(n.toString());
                }
                if ((nuschum / (await Obstructionum.utSummaDifficultas(dir)) != op2pm.obstructionum.interioreObstructionum.divisa)) {
                  print('corrumpere divisa');
                  print('corrupt divisa');
                  return;
                }
                for (Transaction tx in op2pm.obstructionum.interioreObstructionum.liberTransactions) {
                  for (TransactionOutput output in tx.interioreTransaction.outputs) {
                    if (!await Pera.isPublicaClavisDefended(output.publicKey, dir)) {
                      print('publicarum clavium non defenditur');
                      print('one of the public keys is not defended');
                      return;
                    }
                  }
                }
                List<Transaction> transformOutputs = [];
                for (Transaction tx in op2pm.obstructionum.interioreObstructionum.fixumTransactions) {
                  if (tx.probationem == 'transform') {
                      transformOutputs.add(tx);
                  } else {
                    if (!await tx.validateFixum(dir) || !tx.validateProbationem()) {
                      print("Corrumpere negotium in obstructionum");
                    }
                  }
                }
                List<Transaction> transformInputs = [];
                for (Transaction tx in op2pm.obstructionum.interioreObstructionum.liberTransactions) {
                  switch(tx.probationem) {
                    case 'ardeat': {
                      if (!await tx.validateBurn(dir)) {
                        print("irritum ardeat");
                        return;
                      }
                      break;
                    }
                    case 'transform': {
                      transformInputs.add(tx);
                      break;
                    }
                    case 'obstructionum praemium': {
                      if (!tx.validateBlockreward()) {
                        print('irritum obstructionum praemium');
                        return;
                      }
                      break;
                    }
                    default: {
                      if (!await tx.validateLiber(dir) || !tx.validateProbationem())  {
                        print("irritum tx");
                        return;
                      };
                      break;
                    }
                  }
                }
                BigInt transformAble = BigInt.zero;
                for (List<TransactionInput> inputs in transformInputs.map((tx) => tx.interioreTransaction.inputs)) {
                  for (TransactionInput input in inputs) {
                      Obstructionum obstructionum = obss.singleWhere((ob) => ob.interioreObstructionum.liberTransactions.any((tx) => tx.interioreTransaction.id == input.transactionId));
                      Transaction tx = obstructionum.interioreObstructionum.liberTransactions.singleWhere((liber) => liber.interioreTransaction.id == input.transactionId);
                      if (!Utils.cognoscere(PublicKey.fromHex(Pera.curve(), tx.interioreTransaction.outputs[input.index].publicKey), Signature.fromASN1Hex(input.signature), tx.interioreTransaction.outputs[input.index])) {
                        print("irritum tx");
                        return;
                      } else {
                        transformAble += tx.interioreTransaction.outputs[input.index].nof;
                      }
                  }
                }
                BigInt transformed = BigInt.zero;
          
                for (List<TransactionOutput> outputs in transformOutputs.map((tx) => tx.interioreTransaction.outputs)) {
                  for (TransactionOutput output in outputs) {
                    transformed += output.nof;
                  }
                }
                if (transformAble != transformed) {
                  print("irritum transform");
                  return;
                }
                if(op2pm.obstructionum.interioreObstructionum.generare == Generare.EFECTUS) {
                  if(isExpressiActive) {
                    expressiRp.sendPort.send(true);
                  }
                  for (GladiatorOutput output in op2pm.obstructionum.interioreObstructionum.gladiator.outputs) {
                    for (Propter propter in output.rationem) {
                      if (!propter.isProbationem()) {
                        print('invalidum probationem pro ratione');
                        return;
                      }
                    }
                  }
                  if(op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.txObstructionumPraemium).length != 1) {
                    print("Insufficient obstructionum munera");
                    return;
                  }
                  if (op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.transform).isNotEmpty) {
                    print("Insufficient transforms");
                    return;
                  }
                  if (!op2pm.obstructionum.probationem.startsWith('0' * op2pm.obstructionum.interioreObstructionum.obstructionumDifficultas)) {
                    print("Insufficient leading zeros");
                  }
                } else if (op2pm.obstructionum.interioreObstructionum.generare == Generare.CONFUSSUS) {
                  String gladiatorId = op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId;
                  int index = op2pm.obstructionum.interioreObstructionum.gladiator.input!.index;
                  if (op2pm.obstructionum.interioreObstructionum.gladiator.outputs.isNotEmpty) {
                    print("outputs arent liceat ad confossum");
                    return;
                  } else if (
                    await Obstructionum.gladiatorConfodiantur(op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId, op2pm.obstructionum.interioreObstructionum.producentis, dir)
                  ) {
                    print('clausus potest non oppugnare publica clavem');
                    print("block can't attack the same public key");
                    return;
                  }
                  Defensio turpiaDefensio = await Pera.turpiaGladiatoriaDefensione(index, gladiatorId, dir);
                  List<Defensio> deschefLiber = await Pera.maximeDefensiones(true, index, gladiatorId, dir);
                  List<Defensio> deschefFixum = await Pera.maximeDefensiones(false, index, gladiatorId, dir);
                  List<String> defensionesLiber = deschefLiber.map((x) => x.defensio).toList();
                  List<String> defensionesFixum = deschefFixum.map((x) => x.defensio).toList();
                  List<String> defensiones = [];
                  defensiones.add(turpiaDefensio.defensio);
                  defensiones.addAll(defensionesLiber);
                  defensiones.addAll(defensionesFixum);
                  bool coschon =  false;
                  for (int i = 0; i < defensiones.length; i++) {  
                      if (op2pm.obstructionum.probationem.contains(defensiones[i])) {
                        coschon = true;
                      } else {
                        coschon = false;
                        break;
                      }
                  }
                  if (!coschon) {
                    print('gladiator non defeaten');
                    return;
                  }
                  int ardet = 0;
                  for (GladiatorOutput output in obs.interioreObstructionum.gladiator.outputs) {
                    for (String propter in output.rationem.map((x) => x.interioreRationem.publicaClavis)) {
                      final balance = await Pera.statera(true, propter, dir);
                      if (balance > BigInt.zero) {
                        ardet += 1;
                      }
                    }
                  }
                  if (op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.ardeat).length != ardet) {
                    print("Insufficiens ardet");
                    return;
                  }
                  if (op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.transform).length != 1) {
                    print("Insufficiens transforms");
                    return;
                  }
                  Obstructionum utCognoscereObstructionum = obss.singleWhere((o) => o.interioreObstructionum.gladiator.id == op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId);
                  GladiatorOutput utCognoscere = utCognoscereObstructionum.interioreObstructionum.gladiator.outputs[op2pm.obstructionum.interioreObstructionum.gladiator.input!.index];
                  if(
                    !Utils.cognoscereVictusGladiator(
                      PublicKey.fromHex(Pera.curve(), op2pm.obstructionum.interioreObstructionum.producentis), 
                      Signature.fromASN1Hex(op2pm.obstructionum.interioreObstructionum.gladiator.input!.signature), 
                      utCognoscere
                    )) {
                      print('invalidum confossus gladiator');
                      print('invalid stabbed gladiator');
                    }
                } else if (op2pm.obstructionum.interioreObstructionum.generare == Generare.EXPRESSI) {
                  expressiRp.sendPort.send(false);                  
                  String gladiatorId = op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId;
                  int index = op2pm.obstructionum.interioreObstructionum.gladiator.input!.index;
                  if (op2pm.obstructionum.interioreObstructionum.gladiator.outputs.isNotEmpty) {
                    print("outputs arent liceat ad confossum");
                    return;
                  } else if (
                    await Obstructionum.gladiatorConfodiantur(op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId, op2pm.obstructionum.interioreObstructionum.producentis, dir)
                  ) {
                    print('clausus potest non oppugnare publica clavem');
                    print("block can't attack the same public key");
                    return;
                  } else if (obs.interioreObstructionum.generare != Generare.EFECTUS) {
                    print('reproducat scandalum non potest esse nisi super efectus fi');
                    print('reproduce block can only be on top of an efectus block');
                    return;
                  }
                  Defensio turpiaDefensio = await Pera.turpiaGladiatoriaDefensione(index, gladiatorId, dir);
                  List<Defensio> deschefLiber = await Pera.maximeDefensiones(true, index, gladiatorId, dir);
                  List<Defensio> deschefFixum = await Pera.maximeDefensiones(false, index, gladiatorId, dir);
                  List<String> defensionesLiber = deschefLiber.map((x) => x.defensio).toList();
                  List<String> defensionesFixum = deschefFixum.map((x) => x.defensio).toList();
                  List<String> defensiones = [];
                  defensiones.add(turpiaDefensio.defensio);
                  defensiones.addAll(defensionesLiber);
                  defensiones.addAll(defensionesFixum);
                  bool coschon =  false;
                  for (int i = 0; i < defensiones.length; i++) {
                      if (op2pm.obstructionum.probationem.contains(defensiones[i])) {
                        coschon = true;
                      } else {
                        coschon = false;
                        break;
                      }
                  }
                  if (!coschon) {
                    print('gladiator non defeaten');
                    return;
                  }
                  int ardet = 0;
                  for (GladiatorOutput output in obs.interioreObstructionum.gladiator.outputs) {
                    for (String propter in output.rationem.map((x) => x.interioreRationem.publicaClavis)) {
                      final balance = await Pera.statera(true, propter, dir);
                      if (balance > BigInt.zero) {
                        ardet += 1;
                      }
                    }
                  }
                  if (op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.ardeat).length != ardet) {
                    print("Insufficiens ardet");
                    return;
                  }
                  if (op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.transform).length != 1) {
                    print("Insufficiens transforms");
                    return;
                  }
                  Obstructionum utCognoscereObstructionum = obss.singleWhere((o) => o.interioreObstructionum.gladiator.id == op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId);
                  GladiatorOutput utCognoscere = utCognoscereObstructionum.interioreObstructionum.gladiator.outputs[op2pm.obstructionum.interioreObstructionum.gladiator.input!.index];
                  if(
                    !Utils.cognoscereVictusGladiator(
                      PublicKey.fromHex(Pera.curve(), op2pm.obstructionum.interioreObstructionum.producentis), 
                      Signature.fromASN1Hex(op2pm.obstructionum.interioreObstructionum.gladiator.input!.signature), 
                      utCognoscere
                    )) {
                      print('invalidum confossus gladiator');
                      print('invalid stabbed gladiator');
                    }
                  if (!op2pm.obstructionum.probationem.startsWith('0' * (op2pm.obstructionum.interioreObstructionum.obstructionumDifficultas / 2).floor())) {
                    print('Insufficient leading zxeros');
                    return;
                  } else if (!op2pm.obstructionum.probationem.endsWith('0' * (op2pm.obstructionum.interioreObstructionum.obstructionumDifficultas / 2).floor())) {
                    print('Insufficient trailing zeros');
                    return;
                  } else if (op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.txObstructionumPraemium).isNotEmpty) {
                    print("Insufficient obstructionum praemium");
                    return;
                  } else if (obs.interioreObstructionum.generare == Generare.EXPRESSI) {
                    print('non duo expressi cursus sustentabatur');
                    print('cannot produce two expressi blocks in a row');
                    return;
                  } else if (await Obstructionum.gladiatorConfodiantur(op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId, op2pm.obstructionum.interioreObstructionum.producentis, dir)) {
                    print('clausus potest non oppugnare publica clavem');
                    print("block can't attack the same public key");
                    return;
                  }
                }
                await op2pm.obstructionum.salvare(dir);
                print('synced block ${op2pm.obstructionum.interioreObstructionum.obstructionumNumerus}');
                print('synced obstructionum ${op2pm.obstructionum.interioreObstructionum.obstructionumNumerus}');
                summaNumerus = op2pm.obstructionum.interioreObstructionum.obstructionumNumerus;
                if (isEfectusActive) {
                  efectusRp.sendPort.send("");
                }
                if (isConfussusActive) {
                  confussusRp.sendPort.send("");
                }
                P2P.syncBlock(List<dynamic>.from([op2pm.obstructionum, sockets.length > 1 ? sockets.skip(sockets.indexOf('$from')).toList() : sockets, dir, '${client.address.address}:${client.port}']));
                // for (ReceivePort rp in efectusMiners) {
                //
                // }
                // sp.send("yupdate miner");

                // obs = await Utils.priorObstructionum(dir);
                if (summaNumerus.last < Constantes.maximeCaudicesFile) {
                  summaNumerus[summaNumerus.length-1] = summaNumerus.last + 1;
                } else {
                  summaNumerus.add(0);
                }

                client.write(json.encode(RequestObstructionumP2PMessage(summaNumerus, 'request-obstructionum', '${client.address.address}:${client.port}').toJson()));
                print('requested block $summaNumerus');
                // await syncBlock(obs);
              } else {
                print('secrets');
                print(op2pm.secret);
                print(secret);
                if (op2pm.obstructionum.interioreObstructionum.divisa > obs.interioreObstructionum.divisa && op2pm.secret != secret) {
                  print('divisa is greater than block to replace');
                  print('divisa est maior quam obstructionum reponere');
                  return;
                }
                print('had lover divisa');
                // we remove our highest probationem
                // here it could remove block one or the latest block
                // it works with one blocks difference
                // we dont have the matching probationem here we only have the prior probationem
                // and so we remove one block from our chain which could work to
                // ut it has to stay in the loop untill it found a matching one-
                // we send back the highest probationem but stays the difficulty greater than
                // yes it does but if the probationem doesnt match any 
                //but than we remove the block that is new
                print('remota summum obstructionum cum probationem ${obs.probationem}');
                await Utils.removeObstructionumsUntilProbationem(dir);
                client.write(json.encode(ProbationemP2PMessage(obs.probationem, secret, 'probationem', '${client.address.address}:${client.port}').toJson()));
              } 
            }
          }
        }
        //  else if (msg.type == 'remove-obstructionum') {
        //     ProbationemP2PMessage pp2pm = ProbationemP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
        //     await Utils.removeObstructionumsUntilProbationem(pp2pm.probationem, dir);
        //     print('remota obstructionum cum probationem ${pp2pm.probationem}');
        //     Obstructionum prior = await Utils.priorObstructionum(dir);
        //     client.write(json.encode(ProbationemP2PMessage(prior.interioreObstructionum.priorProbationem, 'probationem').toJson()));
        // }
      });
    });
  }
  void connect(String bootnode, String me) async {
    sockets.add(bootnode);
    Socket socket = await Socket.connect(bootnode.split(':')[0], int.parse(bootnode.split(':')[1]));
    socket.write(json.encode(ConnectBootnodeP2PMessage(me, 'connect-bootnode', me).toJson()));
    socket.listen((data) async {
      OnConnectP2PMessage ocp2pm = OnConnectP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
      if(sockets.length < maxPeers) {
        sockets.addAll(ocp2pm.sockets.take((maxPeers - sockets.length)));
      }
      propters.addAll(ocp2pm.propters);
      liberTxs.addAll(ocp2pm.liberTxs);
      fixumTxs.addAll(ocp2pm.fixumTxs);
    });
  }
  void syncPropter(Propter propter) async {
    if(propters.any((p) => p.interioreRationem.id == propter.interioreRationem.id)) {
      propters.removeWhere((p) => p.interioreRationem.id == propter.interioreRationem.id);
    }
    propters.add(propter);
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(PropterP2PMessage(propter, 'propter', from).toJson()));
    }
  }
  void syncHumanify(Humanify humanify) async {
    if(humanifies.any((element) => element.interiore.id == humanify.interiore.id)) {
      humanifies.removeWhere((element) => element.interiore.id == humanify.interiore.id);
    }
    humanifies.add(humanify);
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(HumanifyP2PMessage(humanify, 'humanify', from).toJson()));
    }
  }
  void syncLiberTx(Transaction tx) async {
    if (liberTxs.any((t) => t.interioreTransaction.id == tx.interioreTransaction.id)) {
      liberTxs.removeWhere((t) => t.interioreTransaction.id == tx.interioreTransaction.id);
    }
    liberTxs.add(tx);
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(TransactionP2PMessage(tx, 'liber-tx', from).toJson()));
      soschock.listen((data) async {
        RemoveTransactionsP2PMessage rtp2pm = RemoveTransactionsP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
        liberTxs.removeWhere((liber) => rtp2pm.ids.contains(liber.interioreTransaction.id));
      });
    }
  }
  void syncExpressiTx(Transaction tx) async {
    expressieTxs.add(tx);
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(TransactionP2PMessage(tx, 'expressi-tx', from).toJson()));
    }
  }
  void syncFixumTx(Transaction tx) async {
    if (fixumTxs.any((t) => t.interioreTransaction.id == tx.interioreTransaction.id)) {
      fixumTxs.removeWhere((t) => t.interioreTransaction.id == tx.interioreTransaction.id);
    }
    fixumTxs.add(tx);
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(TransactionP2PMessage(tx, 'fixum-tx', from).toJson()));
      soschock.listen((data) async {
        RemoveTransactionsP2PMessage rtp2pm = RemoveTransactionsP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
        fixumTxs.removeWhere((fixum) => rtp2pm.ids.contains(fixum.interioreTransaction.id));
      });
    }
  }
  void syncScan(Scan scan) async {
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(ScanP2PMessage(scan, 'scan', from)));
    }    
  }
  void removePropters(List<String> ids) async {
    propters.removeWhere((p) => ids.any((i) => i == p.interioreRationem.id));
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(RemoveProptersP2PMessage(ids, 'remove-propters', from).toJson()));
    }
  }
  void removeLiberTxs(List<String> ids) async {
    liberTxs.removeWhere((l) => ids.any((i) => i == l.interioreTransaction.id));
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(RemoveTransactionsP2PMessage(ids, 'remove-liber-txs', from).toJson()));
    }
  }
  void removeFixumTxs(List<String> ids) async {
    fixumTxs.removeWhere((f) => ids.contains(f.interioreTransaction.id));
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(RemoveTransactionsP2PMessage(ids, 'remove-fixum-txs', from).toJson()));
    }
  }
  static void syncBlock(List<dynamic> args) async {
    Obstructionum obs = args[0] as Obstructionum;
    List<String> sockets = args[1] as List<String>;
    Directory dir = args[2] as Directory;
    String from = args[3] as String;
    // if(obs.interioreObstructionum.generare == Generare.EFECTUS || obs.interioreObstructionum.generare == Generare.EXPRESSI) {
    //   expressieTxs = [];
    // }
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      List<List<String>> hashes = [];
      // for (int i = 0; i < dir.listSync().length; i++) {
      //   hashes.add([]);
      //   List<String> lines = await Utils.fileAmnis(File('${dir.path}/${Constantes.fileNomen}$i.txt')).toList();
      //   for (String line in lines) {
      //     if (total < 100) {
      //       hashes[idx].add(Obstructionum.fromJson(json.decode(line)).probationem);
      //       total++;
      //     }
      //   }
      //   idx++;
      // }
      soschock.write(json.encode(ObstructionumP2PMessage('', obs, 'obstructionum', from).toJson()));
      print('sended ${obs.interioreObstructionum.obstructionumNumerus}');
      soschock.listen((data) async {
        // List<List<String>> lines = [];
        // for (int i = dir.listSync().length-1; i > -1 ; i--) {
        //   List<String> lines = await Utils.fileAmnis(File('${dir.path}/${Constantes.fileNomen}$i.txt')).toList();
        //   lines.addAll(lines);
        // }
        P2PMessage p2pm = P2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
        if(p2pm.type == 'request-obstructionum') {
          RequestObstructionumP2PMessage rop2pm = RequestObstructionumP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>);
          print('recieved request obstructionum ${rop2pm.numerus}');
          print(rop2pm.numerus.length);
          File caudices = File('${dir.path}/${Constantes.fileNomen}${rop2pm.numerus.length-1}.txt');

        // if (await Utils.fileAmnis(caudices).length > rop2pm.numerus.last) {
          if (rop2pm.numerus.last <= Constantes.maximeCaudicesFile) {
            String obs = await Utils.fileAmnis(caudices).elementAt(rop2pm.numerus.last);
            Obstructionum obsObs = Obstructionum.fromJson(json.decode(obs) as Map<String, dynamic>);
            soschock.write(json.encode(ObstructionumP2PMessage('', obsObs, 'obstructionum', from).toJson()));
            print('sended block ${rop2pm.numerus}');
          } else {
            rop2pm.numerus.add(0);
            String obs = await Utils.fileAmnis(caudices).elementAt(rop2pm.numerus.last);
            Obstructionum obsObs = Obstructionum.fromJson(json.decode(obs) as Map<String, dynamic>);
            soschock.write(json.encode(ObstructionumP2PMessage('', obsObs, 'obstructionum', from).toJson()));
            print('sended block ${rop2pm.numerus}');
          }
        } else if (p2pm.type == 'probationem') {
          ProbationemP2PMessage ropp2pm = ProbationemP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()) as Map<String, dynamic>); 
          print('recieved probationem ${ropp2pm.probationem}');
          //all you have todo is find out the difference in numbers of that array we speak of
          //
          // Obstructionum? obst = await Utils.accipereObstructionumPriorProbationem(ropp2pm.probationem, dir);
          // the prior obstructionum is our highest block and we wanna have the prior obstructionum of the nodes highest block
          // we have to compare arrays of blocknumbers and find out the difference
          // so we have this index and if it is thhis index we would like to increment the index
          // is it time for the difference
          // as soon as the difficulty is greater than one it still fails
          // we just grab a prior probationem untill we found it and then we should send it
          // we have more right so we will find the s
          Obstructionum priorObstructionumProbationem = await Utils.priorObstructionumProbationem(0, dir);
          // if the probationem euals the priorProbationem of the block we have to send
          // 
          int index = 0;
          bool found = true;
          //when it doesnt find a match here it sends the incipio block of which the total difficulty isnt greater than-
          while (ropp2pm.probationem != priorObstructionumProbationem.interioreObstructionum.priorProbationem)  {
            // its kind a double
            // this is mroe ore like a obstructionum
            //maby this is enough
            // if it found the incipio we go one block back
            // it does remove for each block we press sync but this should be a loop to sync
            // so actually it should find the first efectus instead of the incipio and quit there
            if(priorObstructionumProbationem.interioreObstructionum.generare == Generare.INCIPIO) {
              index--;
              priorObstructionumProbationem = await Utils.priorObstructionumProbationem(index, dir);
              break;             
            }
            priorObstructionumProbationem = await Utils.priorObstructionumProbationem(index, dir);
            print(priorObstructionumProbationem.toJson());
            index++;
          }
          // so that remove probationem was handy because we cant remove if the difficulty isnt greater than
          //so wif we send the incipio block the difficulty isnt greater so it does nothing
          // one of the solutions would be a different obstructionum listener to accept blocks with a lower difficulty
          // but the problem that occurs is that everyone can hit this endpoint and replace the chain
          // so you would need a certain proof too proof your total chain has a greater difficulty
          // so we need to invent a proof
          // how do we proof we have a greater difficulty without a greater difficulty
          // maby we dont need a proof like that because when it syncs it keeps on checking for a greater difficulty
          // once we sync the greater difficulty we can create a secret and resude that secret when we send a block with a lower difficulty
          // a different approach would be to delete so that total difficulty decreases too too messy
          soschock.write(json.encode(ObstructionumP2PMessage(ropp2pm.secret, priorObstructionumProbationem, 'obstructionum', from).toJson()));          
          print('sended ${priorObstructionumProbationem.interioreObstructionum.obstructionumNumerus}');
          // if (ropp2pm.probationem != priorObstructionum.interioreObstructionum.probationem) {
          //   soschock.write(json.encode(RequestProbationemP2PMessage(ropp2pm.index, 'request-probationem').toJson()));
          //   print('couldnt find block with probationem request previous probationem');
          // } else {
          //   soschock.write(json.encode(ObstructionumP2PMessage(priorObstructionum, hashes, 'obstructionum').toJson()));
          //   print('sended block ${obst.interioreObstructionum.obstructionumNumerus}');
          // }
        }
      });
    }
  }
}