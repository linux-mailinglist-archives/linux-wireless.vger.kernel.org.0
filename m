Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E6C48A8E0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 08:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348708AbiAKHvS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 02:51:18 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:58602 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235911AbiAKHvS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 02:51:18 -0500
X-UUID: a1ca0a13e6284976ab4dfc0aaf695c46-20220111
X-UUID: a1ca0a13e6284976ab4dfc0aaf695c46-20220111
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1076703475; Tue, 11 Jan 2022 15:51:14 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Jan 2022 15:51:13 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 11 Jan
 2022 15:51:13 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 11 Jan 2022 15:51:12 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        "Peter Chiu" <chui-hao.chiu@mediatek.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/5] dt-bindings: net: wireless: mt76: document bindings for MT7986
Date:   Tue, 11 Jan 2022 15:51:04 +0800
Message-ID: <351271a274dc236f027c58487df6b21c7dbf9fd0.1641886298.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Add an entry for MT7986 SoC.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Cc: devicetree@vger.kernel.org
---
 .../bindings/net/wireless/mediatek,mt76.yaml  | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index 1489d3c..4444524 100644
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
@@ -29,9 +29,10 @@ properties:
       - mediatek,mt76
       - mediatek,mt7628-wmac
       - mediatek,mt7622-wmac
+      - mediatek,mt7986-wmac
 
   reg:
-    maxItems: 1
+    maxItems: 3
 
   interrupts:
     maxItems: 1
@@ -39,6 +40,17 @@ properties:
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
@@ -231,3 +243,16 @@ examples:
 
       power-domains = <&scpsys 3>;
     };
+
+  - |
+    #include <dt-bindings/reset/mt7986-resets.h>
+    wifi@18000000 {
+        compatible = "mediatek,mt7986-wmac";
+        resets = <&watchdog MT7986_TOPRGU_CONSYS_RST>;
+        reset-names = "consys";
+        reg = <0 0x18000000 0 0x1000000>,
+              <0 0x10003000 0 0x1000>,
+              <0 0x011d1000 0 0x1000>;
+        interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
+        memory-region = <&wmcpu_emi>;
+    };
-- 
2.18.0

