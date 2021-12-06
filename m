Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67964694D7
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 12:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbhLFLTF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Dec 2021 06:19:05 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:38427 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242243AbhLFLTE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Dec 2021 06:19:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638789335; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=fl1apb7+urmR2/38O0MvaGw8/lSqGB1vgky91yBeifw=; b=bz6Yt9hagiNNvBa+EBmIzVMIfM9Fri/UpYLdNo7jfiOwud8rpiuv9t7v5fb/8uta0xHkdg6Q
 d8ReG24qCQYcPK+WvWXhv8Z/WwgirSPoCQBhSQJUvE7srqLE3nlHo2mufCipcax/Hdj1trgd
 O+0hXMUB8LW4DcBPj2ksBUjc9bU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61adf0d7e7d68470afd60421 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 06 Dec 2021 11:15:35
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6485C43619; Mon,  6 Dec 2021 11:15:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16196C4338F;
        Mon,  6 Dec 2021 11:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 16196C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v7 1/2] dt: bindings: add new DT entry for ath11k PCI device support
Date:   Mon,  6 Dec 2021 16:45:18 +0530
Message-Id: <1638789319-2950-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ath11k driver supports PCI devices such as QCN9074/QCA6390.
Ath11k firmware uses host DDR memory, DT entry is used to
reserve host DDR memory regions, send these memory base
addresses using DT entries.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
V4:
  - Fix dt_binding_check warnings (Rob)
V2:
  - Use reserved-memory (Rob)

 .../bindings/net/wireless/qcom,ath11k.yaml         | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 85c2f699d602..cdf7b873b419 100644
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
@@ -279,3 +285,27 @@ examples:
                           "tcl2host-status-ring";
         qcom,rproc = <&q6v5_wcss>;
     };
+
+  - |
+
+    reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        qcn9074_0: qcn9074_0@51100000 {
+            no-map;
+            reg = <0x0 0x51100000 0x0 0x03500000>;
+        };
+    };
+
+    pci {
+        pcie0 {
+            #size-cells = <2>;
+            #address-cells = <3>;
+ 
+            wifi_0: wifi@0 {
+                reg = <0 0 0 0 0>;
+                memory-region = <&qcn9074_0>;
+            };
+        };
+    };
-- 
2.7.4

