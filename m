Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F8455DBD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 15:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhKROSF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 09:18:05 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:30834 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhKROSF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 09:18:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637244905; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=VU8pidLC2r5304DrVYrsbQSM+ifrch1Vq/R8dz9gwts=; b=s2KCbYPYgNETg3BIPyv/9xrR1iAD9FuOLH6oSp0wJgbzSMQnTScgUUnVDTIjZoZB+wl17nGr
 1S30FbGO+sA7gDST305ugn9SoibHOQzD+GH3hxr+2FJTx7TNJx7qeo9wQpi6vDFko1Bbcev8
 fn3P4Rh8E44bc+ILKare2/f/wMY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61965fe8b920912d579d4822 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Nov 2021 14:15:04
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 342B3C4360C; Thu, 18 Nov 2021 14:15:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE1AFC4338F;
        Thu, 18 Nov 2021 14:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BE1AFC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATH v3 1/2] dt: bindings: add new DT entry for ath11k PCI device support
Date:   Thu, 18 Nov 2021 19:44:51 +0530
Message-Id: <1637244892-27267-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ath11k driver supports PCI devices such as QCN9074/QCA6390.
Ath11k firmware uses host DDR memory, DT entry is used to reserve
these host DDR memory regions, send these memory base
addresses using DT entries.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
V2:
  - Use reserved-memory (Rob)

 .../bindings/net/wireless/qcom,ath11k.yaml         | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 85c2f699d602..5a8994f6cb10 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -150,6 +150,12 @@ properties:
       string to uniquely identify variant of the calibration data in the
       board-2.bin for designs with colliding bus and device specific ids
 
+  memory-region:
+    maxItems: 1
+    description:
+      phandle to a node describing reserved memory (System RAM memory)
+      used by ath11k firmware (see bindings/reserved-memory/reserved-memory.txt)
+
 required:
   - compatible
   - reg
@@ -279,3 +285,45 @@ examples:
                           "tcl2host-status-ring";
         qcom,rproc = <&q6v5_wcss>;
     };
+
+    memory {
+        device_type = "memory";
+        reg = <0x0 0x40000000 0x0 0x20000000>;
+    };
+
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        qcn9074_pcie0: qcn9074_pcie0@51100000 {
+            no-map;
+            reg = <0x0 0x51100000 0x0 0x03500000>;
+        };
+
+        qcn9074_pcie1: qcn9074_pcie1@54600000 {
+            no-map;
+            reg = <0x0 0x54600000 0x0 0x03500000>;
+        };
+    };
+
+    pcie0_rp: pcie0_rp {
+        reg = <0 0 0 0 0>;
+
+        status = "ok";
+        ath11k_0: ath11k@0 {
+            reg = <0 0 0 0 0 >;
+            memory-region = <&qcn9074_pcie0>;
+        };
+    };
+
+    pcie1_rp: pcie1_rp {
+        reg = <0 0 0 0 0>;
+
+        status = "ok";
+        ath11k_1: ath11k@1 {
+            reg = <0 0 0 0 0 >;
+            memory-region = <&qcn9074_pcie1>;
+        };
+    };
+
-- 
2.7.4

