Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DE348AD2A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 12:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbiAKL7h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 06:59:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56434 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239003AbiAKL7a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 06:59:30 -0500
X-UUID: 1032d274aca149f38879a35bf6dcd56a-20220111
X-UUID: 1032d274aca149f38879a35bf6dcd56a-20220111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 551868623; Tue, 11 Jan 2022 19:59:26 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 11 Jan 2022 19:59:25 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 11 Jan
 2022 19:59:25 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 11 Jan 2022 19:59:24 +0800
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
Subject: [PATCH v2 1/5] dt-bindings: net: wireless: mt76: document bindings for MT7986
Date:   Tue, 11 Jan 2022 19:59:17 +0800
Message-ID: <67eb9adaa2ed281cb6b8f3c74afc0cc7081f0f6b.1641901681.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1641901681.git.Bo.Jiao@mediatek.com>
References: <cover.1641901681.git.Bo.Jiao@mediatek.com>
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

