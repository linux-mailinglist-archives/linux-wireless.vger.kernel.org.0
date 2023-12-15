Return-Path: <linux-wireless+bounces-821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DB4814013
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 03:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15444287060
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 02:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518FC6FA1;
	Fri, 15 Dec 2023 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z4tU6NHl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03C63CB;
	Fri, 15 Dec 2023 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0bc5f6f09af311eea5db2bebc7c28f94-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3lY7FhYW8bydCyV35uXnsb7aKIt29uMlfMFuMzxU/KU=;
	b=Z4tU6NHlAbGCVf6ZBrTkok8pS2mLub+sy97qOkgRNJxmpEKNHsiSuSbv71DtwSq7cjt6T6WLu8J1TK8gMbYNqUD+Dy623ZoUz+TdAqqtu/NdkR6XLzyXRAO0YUBcmi8PpBFLoB1h8erSGQrdKqfGAdgmDOm/RMNm2prMsrX1yo8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ea1dfc99-a864-4737-bb6b-df1979981e88,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:52d8cf73-1bd3-4f48-b671-ada88705968c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0bc5f6f09af311eea5db2bebc7c28f94-20231215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <chui-hao.chiu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 682648289; Fri, 15 Dec 2023 10:38:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 10:38:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 10:38:34 +0800
From: Peter Chiu <chui-hao.chiu@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Rob Herring <robh+dt@kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Ryder Lee
	<ryder.Lee@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
	<linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v3] dt-bindings: net: wireless: mt76: add interrupts description for MT7986
Date: Fri, 15 Dec 2023 10:38:33 +0800
Message-ID: <20231215023833.8881-1-chui-hao.chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.915200-8.000000
X-TMASE-MatchedRID: w/VW/btTjlN2W20gLTzAqYei/mZCYVwuONP4Z3dggBYY0A95tjAn+/pZ
	jWQiqBlhCqcYnzgqPbuQgj4GwqRgEGYcIRLN0eUlD9eI/GwXvmabKpAlY2y6SXJOfTLfZoT/o8W
	MkQWv6iUoTQl7wNH8PuTCMddcL/gjymsk/wUE4hou6Qpk47HQBHyiiLj01f1g2O88rCZjUyM4D/
	FQUsFVY46jMlFISqvqwL6SxPpr1/I=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.915200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 1B0291CB557CA8917F3562BB33DC795A87AF8765363D6618AD047A22F62B8F2A2000:8
X-MTK: N

The mt7986 can support four interrupts to distribute the interrupts
to different CPUs.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
v2: Change to use description instead of using items.
v3: Change to use items and set different minItems for mediatek,mt7986-wmac
---
 .../bindings/net/wireless/mediatek,mt76.yaml  | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index 252207adbc54..58bbddabd388 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -38,7 +38,12 @@ properties:
       MT7986 should contain 3 regions consys, dcm, and sku, in this order.
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: major interrupt for rings
+      - description: additional interrupt for ring 19
+      - description: additional interrupt for ring 4
+      - description: additional interrupt for ring 5
 
   power-domains:
     maxItems: 1
@@ -213,6 +218,22 @@ properties:
                     description:
                       Half-dBm power delta for different numbers of antennas
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - mediatek,mt7986-wmac
+then:
+  properties:
+    interrupts:
+      minItems: 4
+else:
+  properties:
+    interrupts:
+      maxItems: 1
+
+
 required:
   - compatible
   - reg
@@ -293,7 +314,10 @@ examples:
         reg = <0x18000000 0x1000000>,
               <0x10003000 0x1000>,
               <0x11d10000 0x1000>;
-        interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
+        interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&topckgen 50>,
                  <&topckgen 62>;
         clock-names = "mcu", "ap2conn";
-- 
2.18.0


