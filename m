Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406AA45ABD3
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 19:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbhKWSz3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 13:55:29 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:15079 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237943AbhKWSzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 13:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637693532; x=1669229532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tUutZixuLn0phZnZdsKnkraIoen2KrQXTd0LiOaUqOg=;
  b=whQvT7W0KCWd0G8f2ndPj37Ll1y0P5MCj3P3vRZQeOvhQJpDWU5niYyS
   DEemq6YGnffvcYvmAhmJikla8QAr1baMo1pT3BcUQdSSA8l8ipQRargOa
   rehq14qb3VaeWHNHAbjRQQHgAvJhPSWlOESylZXAANAQ+DAvIbLshoNxX
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Nov 2021 10:52:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 10:52:11 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:52:02 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:52:00 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 19/19] dt: bindings: net: add bindings of WCN6750 for ath11k
Date:   Wed, 24 Nov 2021 00:20:34 +0530
Message-ID: <1637693434-15462-20-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add WCN6750 wireless driver support, its based on ath11k driver.

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 .../bindings/net/wireless/qcom,ath11k.yaml         | 333 ++++++++++++++-------
 1 file changed, 225 insertions(+), 108 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 85c2f69..60bda6d 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -20,120 +20,21 @@ properties:
     enum:
       - qcom,ipq8074-wifi
       - qcom,ipq6018-wifi
+      - qcom,wcn6750-wifi
 
   reg:
     maxItems: 1
 
-  interrupts:
-    items:
-      - description: misc-pulse1 interrupt events
-      - description: misc-latch interrupt events
-      - description: sw exception interrupt events
-      - description: watchdog interrupt events
-      - description: interrupt event for ring CE0
-      - description: interrupt event for ring CE1
-      - description: interrupt event for ring CE2
-      - description: interrupt event for ring CE3
-      - description: interrupt event for ring CE4
-      - description: interrupt event for ring CE5
-      - description: interrupt event for ring CE6
-      - description: interrupt event for ring CE7
-      - description: interrupt event for ring CE8
-      - description: interrupt event for ring CE9
-      - description: interrupt event for ring CE10
-      - description: interrupt event for ring CE11
-      - description: interrupt event for ring host2wbm-desc-feed
-      - description: interrupt event for ring host2reo-re-injection
-      - description: interrupt event for ring host2reo-command
-      - description: interrupt event for ring host2rxdma-monitor-ring3
-      - description: interrupt event for ring host2rxdma-monitor-ring2
-      - description: interrupt event for ring host2rxdma-monitor-ring1
-      - description: interrupt event for ring reo2ost-exception
-      - description: interrupt event for ring wbm2host-rx-release
-      - description: interrupt event for ring reo2host-status
-      - description: interrupt event for ring reo2host-destination-ring4
-      - description: interrupt event for ring reo2host-destination-ring3
-      - description: interrupt event for ring reo2host-destination-ring2
-      - description: interrupt event for ring reo2host-destination-ring1
-      - description: interrupt event for ring rxdma2host-monitor-destination-mac3
-      - description: interrupt event for ring rxdma2host-monitor-destination-mac2
-      - description: interrupt event for ring rxdma2host-monitor-destination-mac1
-      - description: interrupt event for ring ppdu-end-interrupts-mac3
-      - description: interrupt event for ring ppdu-end-interrupts-mac2
-      - description: interrupt event for ring ppdu-end-interrupts-mac1
-      - description: interrupt event for ring rxdma2host-monitor-status-ring-mac3
-      - description: interrupt event for ring rxdma2host-monitor-status-ring-mac2
-      - description: interrupt event for ring rxdma2host-monitor-status-ring-mac1
-      - description: interrupt event for ring host2rxdma-host-buf-ring-mac3
-      - description: interrupt event for ring host2rxdma-host-buf-ring-mac2
-      - description: interrupt event for ring host2rxdma-host-buf-ring-mac1
-      - description: interrupt event for ring rxdma2host-destination-ring-mac3
-      - description: interrupt event for ring rxdma2host-destination-ring-mac2
-      - description: interrupt event for ring rxdma2host-destination-ring-mac1
-      - description: interrupt event for ring host2tcl-input-ring4
-      - description: interrupt event for ring host2tcl-input-ring3
-      - description: interrupt event for ring host2tcl-input-ring2
-      - description: interrupt event for ring host2tcl-input-ring1
-      - description: interrupt event for ring wbm2host-tx-completions-ring3
-      - description: interrupt event for ring wbm2host-tx-completions-ring2
-      - description: interrupt event for ring wbm2host-tx-completions-ring1
-      - description: interrupt event for ring tcl2host-status-ring
+  reg-names:
+    maxItems: 1
 
+  interrupts:
+    minItems: 32
+    maxItems: 52
 
   interrupt-names:
-    items:
-      - const: misc-pulse1
-      - const: misc-latch
-      - const: sw-exception
-      - const: watchdog
-      - const: ce0
-      - const: ce1
-      - const: ce2
-      - const: ce3
-      - const: ce4
-      - const: ce5
-      - const: ce6
-      - const: ce7
-      - const: ce8
-      - const: ce9
-      - const: ce10
-      - const: ce11
-      - const: host2wbm-desc-feed
-      - const: host2reo-re-injection
-      - const: host2reo-command
-      - const: host2rxdma-monitor-ring3
-      - const: host2rxdma-monitor-ring2
-      - const: host2rxdma-monitor-ring1
-      - const: reo2ost-exception
-      - const: wbm2host-rx-release
-      - const: reo2host-status
-      - const: reo2host-destination-ring4
-      - const: reo2host-destination-ring3
-      - const: reo2host-destination-ring2
-      - const: reo2host-destination-ring1
-      - const: rxdma2host-monitor-destination-mac3
-      - const: rxdma2host-monitor-destination-mac2
-      - const: rxdma2host-monitor-destination-mac1
-      - const: ppdu-end-interrupts-mac3
-      - const: ppdu-end-interrupts-mac2
-      - const: ppdu-end-interrupts-mac1
-      - const: rxdma2host-monitor-status-ring-mac3
-      - const: rxdma2host-monitor-status-ring-mac2
-      - const: rxdma2host-monitor-status-ring-mac1
-      - const: host2rxdma-host-buf-ring-mac3
-      - const: host2rxdma-host-buf-ring-mac2
-      - const: host2rxdma-host-buf-ring-mac1
-      - const: rxdma2host-destination-ring-mac3
-      - const: rxdma2host-destination-ring-mac2
-      - const: rxdma2host-destination-ring-mac1
-      - const: host2tcl-input-ring4
-      - const: host2tcl-input-ring3
-      - const: host2tcl-input-ring2
-      - const: host2tcl-input-ring1
-      - const: wbm2host-tx-completions-ring3
-      - const: wbm2host-tx-completions-ring2
-      - const: wbm2host-tx-completions-ring1
-      - const: tcl2host-status-ring
+    minItems: 32
+    maxItems: 52
 
   qcom,rproc:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -150,15 +51,164 @@ properties:
       string to uniquely identify variant of the calibration data in the
       board-2.bin for designs with colliding bus and device specific ids
 
+  memory-region:
+    maxItems: 1
+    description:
+        If present, reference to the reserved-memory for the msa region
+        and CE region used by the wifi firmware running in Q6.
+
+  iommus:
+    maxItems: 1
+
+  wifi-firmware:
+    type: object
+    description: |
+      WCN6750 wifi node can contain one optional firmware subnode.
+      Firmware subnode is needed when the platform does not have TustZone.
+    properties:
+      iommus:
+        maxItems: 1
+    required:
+      - iommus
+
 required:
   - compatible
   - reg
   - interrupts
-  - interrupt-names
   - qcom,rproc
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8074-wifi
+              - qcom,ipq6018-wifi
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: misc-pulse1 interrupt events
+            - description: misc-latch interrupt events
+            - description: sw exception interrupt events
+            - description: watchdog interrupt events
+            - description: interrupt event for ring CE0
+            - description: interrupt event for ring CE1
+            - description: interrupt event for ring CE2
+            - description: interrupt event for ring CE3
+            - description: interrupt event for ring CE4
+            - description: interrupt event for ring CE5
+            - description: interrupt event for ring CE6
+            - description: interrupt event for ring CE7
+            - description: interrupt event for ring CE8
+            - description: interrupt event for ring CE9
+            - description: interrupt event for ring CE10
+            - description: interrupt event for ring CE11
+            - description: interrupt event for ring host2wbm-desc-feed
+            - description: interrupt event for ring host2reo-re-injection
+            - description: interrupt event for ring host2reo-command
+            - description: interrupt event for ring host2rxdma-monitor-ring3
+            - description: interrupt event for ring host2rxdma-monitor-ring2
+            - description: interrupt event for ring host2rxdma-monitor-ring1
+            - description: interrupt event for ring reo2ost-exception
+            - description: interrupt event for ring wbm2host-rx-release
+            - description: interrupt event for ring reo2host-status
+            - description: interrupt event for ring reo2host-destination-ring4
+            - description: interrupt event for ring reo2host-destination-ring3
+            - description: interrupt event for ring reo2host-destination-ring2
+            - description: interrupt event for ring reo2host-destination-ring1
+            - description: interrupt event for ring rxdma2host-monitor-destination-mac3
+            - description: interrupt event for ring rxdma2host-monitor-destination-mac2
+            - description: interrupt event for ring rxdma2host-monitor-destination-mac1
+            - description: interrupt event for ring ppdu-end-interrupts-mac3
+            - description: interrupt event for ring ppdu-end-interrupts-mac2
+            - description: interrupt event for ring ppdu-end-interrupts-mac1
+            - description: interrupt event for ring rxdma2host-monitor-status-ring-mac3
+            - description: interrupt event for ring rxdma2host-monitor-status-ring-mac2
+            - description: interrupt event for ring rxdma2host-monitor-status-ring-mac1
+            - description: interrupt event for ring host2rxdma-host-buf-ring-mac3
+            - description: interrupt event for ring host2rxdma-host-buf-ring-mac2
+            - description: interrupt event for ring host2rxdma-host-buf-ring-mac1
+            - description: interrupt event for ring rxdma2host-destination-ring-mac3
+            - description: interrupt event for ring rxdma2host-destination-ring-mac2
+            - description: interrupt event for ring rxdma2host-destination-ring-mac1
+            - description: interrupt event for ring host2tcl-input-ring4
+            - description: interrupt event for ring host2tcl-input-ring3
+            - description: interrupt event for ring host2tcl-input-ring2
+            - description: interrupt event for ring host2tcl-input-ring1
+            - description: interrupt event for ring wbm2host-tx-completions-ring3
+            - description: interrupt event for ring wbm2host-tx-completions-ring2
+            - description: interrupt event for ring wbm2host-tx-completions-ring1
+            - description: interrupt event for ring tcl2host-status-ring
+        interrupt-names:
+          items:
+            - const: misc-pulse1
+            - const: misc-latch
+            - const: sw-exception
+            - const: watchdog
+            - const: ce0
+            - const: ce1
+            - const: ce2
+            - const: ce3
+            - const: ce4
+            - const: ce5
+            - const: ce6
+            - const: ce7
+            - const: ce8
+            - const: ce9
+            - const: ce10
+            - const: ce11
+            - const: host2wbm-desc-feed
+            - const: host2reo-re-injection
+            - const: host2reo-command
+            - const: host2rxdma-monitor-ring3
+            - const: host2rxdma-monitor-ring2
+            - const: host2rxdma-monitor-ring1
+            - const: reo2ost-exception
+            - const: wbm2host-rx-release
+            - const: reo2host-status
+            - const: reo2host-destination-ring4
+            - const: reo2host-destination-ring3
+            - const: reo2host-destination-ring2
+            - const: reo2host-destination-ring1
+            - const: rxdma2host-monitor-destination-mac3
+            - const: rxdma2host-monitor-destination-mac2
+            - const: rxdma2host-monitor-destination-mac1
+            - const: ppdu-end-interrupts-mac3
+            - const: ppdu-end-interrupts-mac2
+            - const: ppdu-end-interrupts-mac1
+            - const: rxdma2host-monitor-status-ring-mac3
+            - const: rxdma2host-monitor-status-ring-mac2
+            - const: rxdma2host-monitor-status-ring-mac1
+            - const: host2rxdma-host-buf-ring-mac3
+            - const: host2rxdma-host-buf-ring-mac2
+            - const: host2rxdma-host-buf-ring-mac1
+            - const: rxdma2host-destination-ring-mac3
+            - const: rxdma2host-destination-ring-mac2
+            - const: rxdma2host-destination-ring-mac1
+            - const: host2tcl-input-ring4
+            - const: host2tcl-input-ring3
+            - const: host2tcl-input-ring2
+            - const: host2tcl-input-ring1
+            - const: wbm2host-tx-completions-ring3
+            - const: wbm2host-tx-completions-ring2
+            - const: wbm2host-tx-completions-ring1
+            - const: tcl2host-status-ring
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8074-wifi
+              - qcom,ipq6018-wifi
+    then:
+      required:
+        - interrupt-names
+
 examples:
   - |
 
@@ -279,3 +329,70 @@ examples:
                           "tcl2host-status-ring";
         qcom,rproc = <&q6v5_wcss>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        wlan_ce_mem: wlan_ce_mem@4cd000 {
+            no-map;
+            reg = <0x0 0x4cd000 0x0 0x1000>;
+        };
+
+        wlan_fw_mem: wlan_fw_mem@80c00000 {
+            no-map;
+            reg = <0x0 0x80c00000 0x0 0xc00000>;
+        };
+    };
+
+    remoteproc_wpss: remoteproc@8a00000 {
+        compatible = "qcom,sc7280-wpss-pil";
+        reg = <0x08a00000 0x10000>;
+    };
+
+    wifi: wifi@17a10040 {
+        compatible = "qcom,wcn6750-wifi";
+        reg = <0x17A10040 0x0>;
+        reg-names = "msi_addr";
+        iommus = <&apps_smmu 0x1C00 0x1>;
+        interrupts = <GIC_SPI 768 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 769 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 770 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 771 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 772 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 773 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 774 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 775 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 776 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 777 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 778 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 779 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 780 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 781 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 782 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 783 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 784 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 785 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 786 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 787 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 788 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 789 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 790 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 791 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 792 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 793 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 794 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 795 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 796 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 797 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 798 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 799 IRQ_TYPE_EDGE_RISING>;
+        qcom,rproc = <&remoteproc_wpss>;
+        memory-region = <&wlan_fw_mem &wlan_ce_mem>;
+        wifi-firmware {
+                iommus = <&apps_smmu 0x1C02 0x1>;
+        };
+    };
-- 
2.7.4

