Return-Path: <linux-wireless+bounces-1328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C981FCB3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 04:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505F51F242AF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 03:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE10A747E;
	Fri, 29 Dec 2023 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B1IioF6w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4536101
	for <linux-wireless@vger.kernel.org>; Fri, 29 Dec 2023 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b5c0ec82a5f711ee9e680517dc993faa-20231229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=S9gdR+a5LdIUu8TmfSBK1x9oXDqMPX0qjRHU75+Bsew=;
	b=B1IioF6wYIA0tO5IZX4d+7NvY/WhUmtH8wh5aCWdD4qhOKuw6xYBI+JWHayyJKosmDf4+DohUybydgthUpJ4hzssUYWTGg6hcN+pT4NPXH6afNCia52tupHJBjj/2r887UEpZfvLrTq0uaatxtUHWflz826nn4h1n6EBfF8uW0E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:34708d3e-9e71-48a0-a4c9-530bf5a6ef85,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:3903c97e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b5c0ec82a5f711ee9e680517dc993faa-20231229
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1892221994; Fri, 29 Dec 2023 11:09:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 29 Dec 2023 11:09:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 29 Dec 2023 11:09:40 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Hao Zhang <hao.zhang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH v2 03/10] wifi: mt76: mt7925: fix mcu query command fail
Date: Fri, 29 Dec 2023 11:09:30 +0800
Message-ID: <20231229030937.22605-4-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231229030937.22605-1-mingyen.hsieh@mediatek.com>
References: <20231229030937.22605-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Hao Zhang <hao.zhang@mediatek.com>

Apply query command type properly to make the chip send the response back.
Otherwise, we may see the command timeout in driver side.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Hao Zhang <hao.zhang@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 9a8db9b1a4f2..4811fccbe30e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2850,12 +2850,16 @@ int mt7925_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (cmd & __MCU_CMD_FIELD_UNI) {
 		uni_txd = (struct mt76_connac2_mcu_uni_txd *)txd;
 		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
-		uni_txd->option = MCU_CMD_UNI_EXT_ACK;
 		uni_txd->cid = cpu_to_le16(mcu_cmd);
 		uni_txd->s2d_index = MCU_S2D_H2N;
 		uni_txd->pkt_type = MCU_PKT_ID;
 		uni_txd->seq = seq;
 
+		if (cmd & __MCU_CMD_FIELD_QUERY)
+			uni_txd->option = MCU_CMD_UNI_QUERY_ACK;
+		else
+			uni_txd->option = MCU_CMD_UNI_EXT_ACK;
+
 		goto exit;
 	}
 
-- 
2.18.0


