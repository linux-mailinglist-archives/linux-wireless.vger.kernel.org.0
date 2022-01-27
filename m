Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543A449DA22
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 06:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiA0FZq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 00:25:46 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:6584 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiA0FZo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 00:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643261144; x=1674797144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=iaMIhpzzqIVueVu4CbfPorPRdKKm1rjacCwoYKP8zKE=;
  b=EEP6K/np4FPHShQ84kBB2gUWqwyzeMPV1uAi80UGFu4GLYorLOZ4Uc1m
   CPNAbRvjgWPyZ9kYY1CIQ6qAyIcq+ab5gcsdVui36NHiBAG3gcU3rljJW
   MmyPna3ns2K0uDLBOkLgC5NnM/XZM3JdZaF4kZWkq/f23bIHT6zfonzJZ
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 26 Jan 2022 21:25:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 21:25:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:25:22 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:25:20 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 1/2] dt: bindings: net: add bindings to add WoW support for WCN6750
Date:   Thu, 27 Jan 2022 10:54:52 +0530
Message-ID: <1643261093-12400-2-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643261093-12400-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1643261093-12400-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add required bindings to support WoW (Wake on Wireless) for
WCN6750 used by ATH11K driver.

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index dba1434..aead001 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -71,6 +71,14 @@ properties:
     required:
       - iommus
 
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: State bits used in WCN6750 to signal the firmware
+                 to exit from WoW.
+
+  qcom,smem-state-names:
+    description: The names of the state bits used for SMP2P output
+
 required:
   - compatible
   - reg
@@ -415,6 +423,13 @@ examples:
         };
     };
 
+    smp2p-wpss {
+        wlan_smp2p_out: wlan_smp2p_out {
+                qcom,entry-name = "wlan";
+                #qcom,smem-state-cells = <1>;
+        };
+    };
+
     wifi: wifi@17a10040 {
         compatible = "qcom,wcn6750-wifi";
         reg = <0x17A10040 0x0>;
@@ -454,6 +469,8 @@ examples:
                      <GIC_SPI 799 IRQ_TYPE_EDGE_RISING>;
         qcom,rproc = <&remoteproc_wpss>;
         memory-region = <&wlan_fw_mem &wlan_ce_mem>;
+        qcom,smem-states = <&wlan_smp2p_out 0>;
+        qcom,smem-state-names = "wlan-smp2p-out";
         wifi-firmware {
                 iommus = <&apps_smmu 0x1C02 0x1>;
         };
-- 
2.7.4

