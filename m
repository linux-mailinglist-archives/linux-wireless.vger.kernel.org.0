Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20605DDD90
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfJTKEO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:04:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41000 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJTKEO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:04:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E0B2560D60; Sun, 20 Oct 2019 10:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565852;
        bh=E2evcjlIysbpAHuLf7aToetJCajyx42bDRwDPZXBm60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIzMj2GDA9aldCF7+vTKHy7FODSDl52fTrlP5gq2S1WW4eIH1/x/kMN5+IIAwWJBh
         F09Fm+98h5mPOK8idKvO2KQDbehaH/Xw0vXu0cfCUWmCR9+9B/yFcRawuB/iLEKxmP
         8jCFuU4Tyg6jCPeykvsReZME2yiW5NTnU70d34q0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0572E607EB;
        Sun, 20 Oct 2019 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565852;
        bh=E2evcjlIysbpAHuLf7aToetJCajyx42bDRwDPZXBm60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIzMj2GDA9aldCF7+vTKHy7FODSDl52fTrlP5gq2S1WW4eIH1/x/kMN5+IIAwWJBh
         F09Fm+98h5mPOK8idKvO2KQDbehaH/Xw0vXu0cfCUWmCR9+9B/yFcRawuB/iLEKxmP
         8jCFuU4Tyg6jCPeykvsReZME2yiW5NTnU70d34q0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0572E607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 01/49] dt: bindings: net: add qcom,ath11k.yaml
Date:   Sun, 20 Oct 2019 13:03:19 +0300
Message-Id: <1571565847-10338-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
References: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath11k is a driver for Qualcomm IEEE 802.11ax devices. Add a
bindings document for the driver, first documenting IPQ8074 which is the
only device ath11k currently supports.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 .../bindings/net/wireless/qcom,ath11k.yaml         | 277 +++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
new file mode 100644
index 000000000000..5d25542f85f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -0,0 +1,277 @@
+# SPDX-License-Identifier: BSD-3-Clause-Clear
+# Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/qcom,ath11k.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies ath11k wireless devices Generic Binding
+
+maintainers:
+  - Kalle Valo <kvalo@codeaurora.org>
+
+description: |
+  These are dt entries used on ath11k driver. AHB based ipq8074 uses most of the properties defined in this doc.
+
+properties:
+  compatible:
+    const: "qcom,ipq8074-wifi"
+
+  reg:
+    description: Address and length of the register set for the device
+    maxItems: 1
+
+  interrupts:
+    minItems: 53
+    maxItems: 53
+    items:
+      - description: misc-pulse1 interrupt events
+      - description: misc-latch interrupt events
+      - description: sw exception interrupt events
+      - description: watchdog interrupt events
+      - description: interrupt event for ring CE0
+      - description: interrupt event for ring CE1
+      - description: interrupt event for ring CE2
+      - description: interrupt event for ring CE3
+      - description: interrupt event for ring CE4
+      - description: interrupt event for ring CE5
+      - description: interrupt event for ring CE6
+      - description: interrupt event for ring CE7
+      - description: interrupt event for ring CE8
+      - description: interrupt event for ring CE9
+      - description: interrupt event for ring CE10
+      - description: interrupt event for ring CE11
+      - description: interrupt event for ring host2wbm-desc-feed
+      - description: interrupt event for ring host2reo-re-injection
+      - description: interrupt event for ring host2reo-command
+      - description: interrupt event for ring host2rxdma-monitor-ring3
+      - description: interrupt event for ring host2rxdma-monitor-ring2
+      - description: interrupt event for ring host2rxdma-monitor-ring1
+      - description: interrupt event for ring reo2ost-exception
+      - description: interrupt event for ring wbm2host-rx-release
+      - description: interrupt event for ring reo2host-status
+      - description: interrupt event for ring reo2host-destination-ring4
+      - description: interrupt event for ring reo2host-destination-ring3
+      - description: interrupt event for ring reo2host-destination-ring2
+      - description: interrupt event for ring reo2host-destination-ring1
+      - description: interrupt event for ring rxdma2host-monitor-destination-mac3
+      - description: interrupt event for ring rxdma2host-monitor-destination-mac2
+      - description: interrupt event for ring rxdma2host-monitor-destination-mac1
+      - description: interrupt event for ring ppdu-end-interrupts-mac3
+      - description: interrupt event for ring ppdu-end-interrupts-mac2
+      - description: interrupt event for ring ppdu-end-interrupts-mac1
+      - description: interrupt event for ring rxdma2host-monitor-status-ring-mac3
+      - description: interrupt event for ring rxdma2host-monitor-status-ring-mac2
+      - description: interrupt event for ring rxdma2host-monitor-status-ring-mac1
+      - description: interrupt event for ring host2rxdma-host-buf-ring-mac3
+      - description: interrupt event for ring host2rxdma-host-buf-ring-mac2
+      - description: interrupt event for ring host2rxdma-host-buf-ring-mac1
+      - description: interrupt event for ring rxdma2host-destination-ring-mac3
+      - description: interrupt event for ring rxdma2host-destination-ring-mac2
+      - description: interrupt event for ring rxdma2host-destination-ring-mac1
+      - description: interrupt event for ring host2tcl-input-ring4
+      - description: interrupt event for ring host2tcl-input-ring3
+      - description: interrupt event for ring host2tcl-input-ring2
+      - description: interrupt event for ring host2tcl-input-ring1
+      - description: interrupt event for ring wbm2host-tx-completions-ring3
+      - description: interrupt event for ring wbm2host-tx-completions-ring2
+      - description: interrupt event for ring wbm2host-tx-completions-ring1
+      - description: interrupt event for ring tcl2host-status-ring
+
+
+  interrupt-names:
+    minItems: 53
+    maxItems: 53
+    items:
+      - const: misc-pulse1
+      - const: misc-latch
+      - const: sw-exception
+      - const: watchdog
+      - const: ce0
+      - const: ce1
+      - const: ce2
+      - const: ce3
+      - const: ce4
+      - const: ce5
+      - const: ce6
+      - const: ce7
+      - const: ce8
+      - const: ce9
+      - const: ce10
+      - const: ce11
+      - const: host2wbm-desc-feed
+      - const: host2reo-re-injection
+      - const: host2reo-command
+      - const: host2rxdma-monitor-ring3
+      - const: host2rxdma-monitor-ring2
+      - const: host2rxdma-monitor-ring1
+      - const: reo2ost-exception
+      - const: wbm2host-rx-release
+      - const: reo2host-status
+      - const: reo2host-destination-ring4
+      - const: reo2host-destination-ring3
+      - const: reo2host-destination-ring2
+      - const: reo2host-destination-ring1
+      - const: rxdma2host-monitor-destination-mac3
+      - const: rxdma2host-monitor-destination-mac2
+      - const: rxdma2host-monitor-destination-mac1
+      - const: ppdu-end-interrupts-mac3
+      - const: ppdu-end-interrupts-mac2
+      - const: ppdu-end-interrupts-mac1
+      - const: rxdma2host-monitor-status-ring-mac3
+      - const: rxdma2host-monitor-status-ring-mac2
+      - const: rxdma2host-monitor-status-ring-mac1
+      - const: host2rxdma-host-buf-ring-mac3
+      - const: host2rxdma-host-buf-ring-mac2
+      - const: host2rxdma-host-buf-ring-mac1
+      - const: rxdma2host-destination-ring-mac3
+      - const: rxdma2host-destination-ring-mac2
+      - const: rxdma2host-destination-ring-mac1
+      - const: host2tcl-input-ring4
+      - const: host2tcl-input-ring3
+      - const: host2tcl-input-ring2
+      - const: host2tcl-input-ring1
+      - const: wbm2host-tx-completions-ring3
+      - const: wbm2host-tx-completions-ring2
+      - const: wbm2host-tx-completions-ring1
+      - const: tcl2host-status-ring
+
+  qcom,rproc:
+    $ref: /schemas/types.yaml#definitions/phandle
+    description:
+      DT entry of q6v5-wcss remoteproc driver.
+      Phandle to a node that can contain the following properties
+        * compatible
+        * reg
+        * reg-names
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - qcom,rproc
+
+additionalProperties: false
+
+examples:
+  - |
+
+    q6v5_wcss: q6v5_wcss@CD00000 {
+    	compatible = "qcom,ipq8074-wcss-pil";
+    	reg = <0xCD00000 0x4040>,
+    	      <0x4AB000 0x20>;
+    	reg-names = "qdsp6",
+    		    "rmb";
+    };
+
+    wifi0: wifi@c000000 {
+        	compatible = "qcom,ipq8074-wifi";
+    	reg = <0xc000000 0x2000000>;
+    	interrupts = <0 320 1>,
+    		     <0 319 1>,
+    		     <0 318 1>,
+    		     <0 317 1>,
+    		     <0 316 1>,
+    		     <0 315 1>,
+    		     <0 314 1>,
+    		     <0 311 1>,
+    		     <0 310 1>,
+    		     <0 411 1>,
+    		     <0 410 1>,
+    		     <0 40 1>,
+    		     <0 39 1>,
+    		     <0 302 1>,
+    		     <0 301 1>,
+    		     <0 37 1>,
+    		     <0 36 1>,
+    		     <0 296 1>,
+    		     <0 295 1>,
+    		     <0 294 1>,
+    		     <0 293 1>,
+    		     <0 292 1>,
+    		     <0 291 1>,
+    		     <0 290 1>,
+    		     <0 289 1>,
+    		     <0 288 1>,
+    		     <0 239 1>,
+    		     <0 236 1>,
+    		     <0 235 1>,
+    		     <0 234 1>,
+    		     <0 233 1>,
+    		     <0 232 1>,
+    		     <0 231 1>,
+    		     <0 230 1>,
+    		     <0 229 1>,
+    		     <0 228 1>,
+    		     <0 224 1>,
+    		     <0 223 1>,
+    		     <0 203 1>,
+    		     <0 183 1>,
+    		     <0 180 1>,
+    		     <0 179 1>,
+    		     <0 178 1>,
+    		     <0 177 1>,
+    		     <0 176 1>,
+    		     <0 163 1>,
+    		     <0 162 1>,
+    		     <0 160 1>,
+    		     <0 159 1>,
+    		     <0 158 1>,
+    		     <0 157 1>,
+    		     <0 156 1>;
+    	interrupt-names = "misc-pulse1",
+    			  "misc-latch",
+    			  "sw-exception",
+    			  "watchdog",
+    			  "ce0",
+    			  "ce1",
+    			  "ce2",
+    			  "ce3",
+    			  "ce4",
+    			  "ce5",
+    			  "ce6",
+    			  "ce7",
+    			  "ce8",
+    			  "ce9",
+    			  "ce10",
+    			  "ce11",
+    			  "host2wbm-desc-feed",
+    			  "host2reo-re-injection",
+    			  "host2reo-command",
+    			  "host2rxdma-monitor-ring3",
+    			  "host2rxdma-monitor-ring2",
+    			  "host2rxdma-monitor-ring1",
+    			  "reo2ost-exception",
+    			  "wbm2host-rx-release",
+    			  "reo2host-status",
+    			  "reo2host-destination-ring4",
+    			  "reo2host-destination-ring3",
+    			  "reo2host-destination-ring2",
+    			  "reo2host-destination-ring1",
+    			  "rxdma2host-monitor-destination-mac3",
+    			  "rxdma2host-monitor-destination-mac2",
+    			  "rxdma2host-monitor-destination-mac1",
+    			  "ppdu-end-interrupts-mac3",
+    			  "ppdu-end-interrupts-mac2",
+    			  "ppdu-end-interrupts-mac1",
+    			  "rxdma2host-monitor-status-ring-mac3",
+    			  "rxdma2host-monitor-status-ring-mac2",
+    			  "rxdma2host-monitor-status-ring-mac1",
+    			  "host2rxdma-host-buf-ring-mac3",
+    			  "host2rxdma-host-buf-ring-mac2",
+    			  "host2rxdma-host-buf-ring-mac1",
+    			  "rxdma2host-destination-ring-mac3",
+    			  "rxdma2host-destination-ring-mac2",
+    			  "rxdma2host-destination-ring-mac1",
+    			  "host2tcl-input-ring4",
+    			  "host2tcl-input-ring3",
+    			  "host2tcl-input-ring2",
+    			  "host2tcl-input-ring1",
+    			  "wbm2host-tx-completions-ring3",
+    			  "wbm2host-tx-completions-ring2",
+    			  "wbm2host-tx-completions-ring1",
+    			  "tcl2host-status-ring";
+    	qcom,rproc = <&q6v5_wcss>;
+    };

