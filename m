Return-Path: <linux-wireless+bounces-372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01ED802DF4
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 10:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670451F2110D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B07125BE;
	Mon,  4 Dec 2023 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YEnvCHmZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CD1CD;
	Mon,  4 Dec 2023 01:12:09 -0800 (PST)
X-UUID: 2dd54a82928511ee8051498923ad61e6-20231204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/uzFrjt8aUKTbxRLxmdKkdFySY3RzU5L+0QmsGF+qqA=;
	b=YEnvCHmZ3gS12RzwrrOzj6SLxflwouk/XBuF9Q1AOfRPOs7D77wi3rSNIOfGwkV1woztgLNkLvBjKljghAAEroRM8Wlqx0hEQUwrWISzUW9K9safCjQTR5cfvzkygcDIDhjEcC8LawYjN5rQ+LmYOvrZcZsjaBGo2tF3tF47o5A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:32bffc3b-33b5-4140-8e21-b0aa60661ec3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:c569ca60-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2dd54a82928511ee8051498923ad61e6-20231204
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chui-hao.chiu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 407980655; Mon, 04 Dec 2023 17:11:59 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Dec 2023 17:11:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Dec 2023 17:11:57 +0800
From: Peter Chiu <chui-hao.chiu@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Rob Herring <robh+dt@kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Ryder Lee
	<ryder.Lee@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
	<linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v2] dt-bindings: net: wireless: mt76: add interrupts description for MT7986
Date: Mon, 4 Dec 2023 17:11:56 +0800
Message-ID: <20231204091156.6535-1-chui-hao.chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.679900-8.000000
X-TMASE-MatchedRID: v+sphrBU45F2W20gLTzAqYei/mZCYVwuONP4Z3dggBYY0A95tjAn+/pZ
	jWQiqBlhCqcYnzgqPbt4xIuyG0zHEJDCbn5v5k09Y7jepwkpr699LQinZ4QefPcjNeVeWlqY+gt
	Hj7OwNO34ZhR52Rc1au7UdPYHaiHyW5kMCPJeUiSb6ByuLYX+T07zv/KPifYCLRhCjkNLcoSRBq
	5lu6PnXv3uL/cp+ftvKHEBTVoCjqueU8bDRAXvQkma3zYT97IFAYfQIAUhBayZvmCbKVb49sZL6
	x5U/HridGByp+zdaDg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.679900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	34C5B0D5B06512149F2AAE3C5D7C8D78FEA92A61C60D7458B60A76B5E78195422000:8
X-MTK: N

The mt7986 can support four interrupts to distribute the interrupts
to different CPUs.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
v2: Change to use description instead of using items.
---
 .../devicetree/bindings/net/wireless/mediatek,mt76.yaml     | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index 252207adbc54..933bc7bdda01 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -38,7 +38,11 @@ properties:
       MT7986 should contain 3 regions consys, dcm, and sku, in this order.
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
+    description:
+      MT7986 provides up to 4 interrupts including one primary interrupt and
+      three additional interrupts for ring 4, 5, and 19.
 
   power-domains:
     maxItems: 1
-- 
2.18.0


