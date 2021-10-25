Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B50439A6C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 17:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhJYPab (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 11:30:31 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:10807 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbhJYPaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 11:30:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635175688; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3zTsPRswybeqkW/NN/9MmGt5qZUFbx0X45N/ZZo5/Fc=; b=NY0jLHEsnwe8X0JB+zf5SbhcyrngDGPpi+/E5nM9jt6ZCES/tobCj5u+HF8xOICRk3Od+rOT
 5K/aYE5AC6dp5a1tsWVTzZO3cphIzFJ8VRQ0kUdHpTk7dIcvxb7hThzpVezt6RnWomcxi+TO
 Y6IsqD6kJJC32739LRPSyMKRnZk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6176ccf3fd91319f0fd4f864 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 15:27:47
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29FF9C43616; Mon, 25 Oct 2021 15:27:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EFDEDC4338F;
        Mon, 25 Oct 2021 15:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org EFDEDC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 1/2] dt: bindings: add new DT entry for ath11k PCI device support
Date:   Mon, 25 Oct 2021 20:57:27 +0530
Message-Id: <1635175648-23491-1-git-send-email-akolli@codeaurora.org>
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
 .../bindings/net/wireless/qcom,ath11k.yaml         | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 5ac9616c9239..c7e6612e949c 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -19,6 +19,10 @@ description: |
   These devices use HOST DDR memory, HOST DDR memory can be reserved
   and send to ath11k driver from DT.
 
+  ATH11K supports PCI devices like QCA6390,QCN9074.
+  These devices use host DDR memory, host DDR memory can be reserved
+  and send to ath11k driver from DT.
+
 properties:
   compatible:
     enum:
@@ -177,6 +181,29 @@ properties:
     description:
       HOST DDR end address.
 
+  qcom,base-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Host DDR base address for firmware. QCN9074 firmware uses 45 MB of host
+      DDR memory in mode-0 and 15 MB of host DDR memory in mode-2.
+
+  qcom,caldb-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Host DDR address to store CALDB. CALDB is calibration data base
+      for WLAN channel and tx power.
+
+  qcom,start-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Host DDR start address. For example on x86 it is 0x0,
+      on IPQ8074 it is 0x41000000.
+
+  qcom,end-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Host DDR end address.
+
 required:
   - compatible
   - reg
@@ -317,3 +344,14 @@ examples:
         qcom,end-addr = <0x80000000>;
       };
     };
+
+  - |
+
+    pcie0_rp {
+      ath11k0 {
+        qcom,base-addr = <0x50F00000>;
+        qcom,caldb-addr = <0x53E00000>;
+        qcom,start-addr = <0x41000000>;
+        qcom,end-addr = <0x80000000>;
+      };
+    };
-- 
2.7.4

