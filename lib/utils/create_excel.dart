import 'dart:convert';
import 'dart:html';
import 'dart:ui';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:neirobankadmin/models/excel_user.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart' show AnchorElement;



  Future<void> createExcel(List<ExcelUser> excelUser) async{
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    for(int i = 0; i< excelUser.length; i++){
      sheet.getRangeByName('A${i+1}').setText(excelUser[i].eMail);
      sheet.getRangeByName('B${i+1}').setText(excelUser[i].userCode);
      sheet.getRangeByName('C${i+1}').setText(excelUser[i].userLink);
      sheet.getRangeByName('D${i+1}').setText(excelUser[i].qrCode);
    }


    final List<int> bytes = workbook.saveAsStream();
    final zipEncoder = ZipEncoder();
    final zipFile = ArchiveFile('file.xlsx', bytes.length, bytes);
    final archive = Archive();
    archive.addFile(zipFile);

    for (int i = 0; i < excelUser.length; i++) {
      archive.addFile(ArchiveFile('qr/${excelUser[i].eMail}.svg', excelUser[i].qrCode.codeUnits.length, excelUser[i].qrCode.codeUnits));


    }
    workbook.dispose();
    if(kIsWeb){
      AnchorElement(href: 'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(zipEncoder.encode(archive))}')
        ..setAttribute('download', 'Output.zip')
        ..click();
    }
  }


