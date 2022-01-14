Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D9E48E2B7
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jan 2022 03:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbiANCxl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 21:53:41 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:36542 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236093AbiANCxk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 21:53:40 -0500
X-UUID: 0ff2ef2d125445589e47bb04f4a6477d-20220114
X-UUID: 0ff2ef2d125445589e47bb04f4a6477d-20220114
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2006902256; Fri, 14 Jan 2022 10:53:36 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Jan 2022 10:53:34 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 14 Jan
 2022 10:53:27 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 14 Jan 2022 10:53:26 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: net: wireless: mt76: document bindings for MT7986
Date:   Fri, 14 Jan 2022 10:53:20 +0800
Message-ID: <c6a6ddd797269ea92698f612d6b7c66c9ec03765.1642128031.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1642128031.git.Bo.Jiao@mediatek.com>
References: <cover.1642128031.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Add an entry for MT7986 SoC.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: devicetree@vger.kernel.org
---
v3:
 - fix yamllint warnings and errors
 - add 'minItems: 1' to keep 1 reg entry being valid
---
 .../bindings/net/wireless/mediatek,mt76.yaml  | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index 1489d3c..d630a7e 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -18,7 +18,7 @@ description: |
   wireless device. The node is expected to be specified as a child
   node of the PCI controller to which the wireless chip is connected.
   Alternatively, it can specify the wireless part of the MT7628/MT7688
-  or MT7622 SoC.
+  or MT7622/MT7986 SoC.
 
 allOf:
   - $ref: ieee80211.yaml#
@@ -29,9 +29,11 @@ properties:
       - mediatek,mt76
       - mediatek,mt7628-wmac
       - mediatek,mt7622-wmac
+      - mediatek,mt7986-wmac
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   interrupts:
     maxItems: 1
@@ -39,6 +41,17 @@ properties:
   power-domains:
     maxItems: 1
 
+  memory-region:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+    description:
+      Specify the consys reset for mt7986.
+
+  reset-name:
+    const: consys
+
   mediatek,infracfg:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -165,7 +178,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -231,3 +244,15 @@ examples:
 
       power-domains = <&scpsys 3>;
     };
+
+  - |
+    wifi@18000000 {
+        compatible = "mediatek,mt7986-wmac";
+        resets = <&watchdog 23>;
+        reset-names = "consys";
+        reg = <0x18000000 0x1000000>,
+              <0x10003000 0x1000>,
+              <0x11d10000 0x1000>;
+        interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
+        memory-region = <&wmcpu_emi>;
+    };
-- 
2.18.0

