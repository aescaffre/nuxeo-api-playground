library nx_batch_upload;

import 'dart:html';
import 'dart:math' as Math;

import 'package:polymer/polymer.dart';

import 'nx_batch.dart';
import 'nx_batch_reference.dart';
import 'ui_module.dart';
import 'semantic.dart';


class BatchUpload extends Module {
  String title = "Batch Upload",
         icon = "batch_upload.png",
         description = "Create batches by uploading any number of files. These batches can later be referenced in Resource endpoints methods by clicking on the “Reference a batch” button",
         action = "Upload",
         tag = NXBatchUpload.TAG;
}

@CustomTag(NXBatchUpload.TAG)
class NXBatchUpload extends NXModule with SemanticUI {

  static const String TAG = "nx-batch-upload";

  factory NXBatchUpload() => new Element.tag(TAG);

  NXBatchUpload.created() : super.created() {
  }

  domReady() {
    _newBatch();
  }

  onUpload(Event event) {
    ($["batches"] as NXBatchReference).addBatch((event.target as NXBatch).batchId);
    _newBatch();
  }

  void _newBatch() {
    var batch = new Element.tag(NXBatch.TAG) as NXBatch
    ..connectionId = connectionId
    ..batchId = "batch-" +
        new DateTime.now().millisecondsSinceEpoch.toString() +
        "-" + new Math.Random().nextInt(100000).toString()
    ..on[NXBatch.UPLOAD_EVENT].listen(onUpload);

    $["batch"]
    ..nodes.clear()
    ..append(batch);
  }
}