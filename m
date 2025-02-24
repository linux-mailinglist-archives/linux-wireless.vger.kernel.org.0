Return-Path: <linux-wireless+bounces-19369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73937A41FE6
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 14:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230301897E04
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 13:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9776E23BD1A;
	Mon, 24 Feb 2025 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eWt5ocmZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17C23BCF6
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402335; cv=none; b=uKAWUlQFBCBa3DGjo5zEqlXxc1mleXbfqUw8ydpLyiUUTLc6h0qPOKNG4mczX6ts5oJjQWMslB+YYGuFsHN2f8ZVG4VTPBBZAyKkDw15TxNgS+4B2DT5NpC5deDWUOaRLToaw8gns96O9dBSUQ9TV/FHdljOQjmA4Nkm0O9yPCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402335; c=relaxed/simple;
	bh=ARIAIXxMGeZPkoEUlwbrO9yUGSRMd3fYh8DiaMwKedI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RZZle2jc7rxcZC/1CLmpIL2zsqenxb3J7ks5CTdY+BXD5aF8YXwe2l5w7bz6A66M1eZa6R96Fg+9QNyeBLY2uZfdCF16ademRjbAOVVXwAIlqIvT1iINaiTTjrzbfW1tDO84yY9MjNZGab+aXkpSTrRYvbiGGw7U15/lGY8U2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eWt5ocmZ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 03fed64cf2b011ef8eb9c36241bbb6fb-20250224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XYp6nqL/SIf1dkq4IbZ5jeSHZcsYeSObKvTPW+JE3bg=;
	b=eWt5ocmZnWWfB2zK+oQWqlVwZ71Je1FEDuHrt+XWyR3QADcf2YetGoZFn4YjqlQbj6Aq+rQDrEutyEedx9zKsMZYjfoz+koRyG+uqcscePG5e3ZWnKAMM/4DRMg6hkvOMjhRymoUGQpfMjm0wWz+wIzFs5chjWjw5KWFFuo6CsI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:83100970-329b-4ba9-b91f-0ea10e1c0aab,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:60aa074,CLOUDID:43ef44dc-d480-4873-806f-0f365159227b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 03fed64cf2b011ef8eb9c36241bbb6fb-20250224
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1308122370; Mon, 24 Feb 2025 21:05:26 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 24 Feb 2025 21:05:25 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 24 Feb 2025 21:05:24 +0800
From: Quan Zhou <quan.zhou@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <Deren.Wu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
	Leon Yen <Leon.Yen@mediatek.com>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Allan Wang <allan.wang@mediatek.com>, KM Lin
	<km.lin@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Shengxi Xu
	<shengxi.xu@mediatek.com>, Eric-SY Chang <Eric-SY.Chang@mediatek.com>, CH Yeh
	<ch.yeh@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, linux-wireless
	<linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Quan Zhou <quan.zhou@mediatek.com>
Subject: [patch] wifi: mt76: mt7925: Simplify HIF suspend handling to avoid suspend fail
Date: Mon, 24 Feb 2025 21:05:14 +0800
Message-ID: <34208c7280325f57a651363d339399eb1744d3b7.1740400998.git.quan.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

System suspend failures may occur due to inappropriate
handling of traffic not idle event by the WiFi driver.
The WiFi firmware's traffic not idle indication does
not need to be tied to suspend. Fix the flow to ensuring
the system can suspend properly.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 04762a8eac51..740e5c62929a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -348,14 +348,10 @@ mt7925_mcu_handle_hif_ctrl_basic(struct mt792x_dev *dev, struct tlv *tlv)
 	basic = (struct mt7925_mcu_hif_ctrl_basic_tlv *)tlv;
 
 	if (basic->hifsuspend) {
-		if (basic->hif_tx_traffic_status == HIF_TRAFFIC_IDLE &&
-		    basic->hif_rx_traffic_status == HIF_TRAFFIC_IDLE)
-			/* success */
-			dev->hif_idle = true;
-		else
-			/* busy */
-			/* invalid */
-			dev->hif_idle = false;
+		dev->hif_idle = true;
+		if (!(basic->hif_tx_traffic_status == HIF_TRAFFIC_IDLE &&
+		      basic->hif_rx_traffic_status == HIF_TRAFFIC_IDLE))
+			dev_info(dev->mt76.dev, "Hif traffic not idle.\n");
 	} else {
 		dev->hif_resumed = true;
 	}
-- 
2.46.0


