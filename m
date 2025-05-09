Return-Path: <linux-wireless+bounces-22761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F58AB075C
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 03:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA44E4E5E49
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 01:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0693C376F1;
	Fri,  9 May 2025 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LzU24JKy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4B20E6;
	Fri,  9 May 2025 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746752672; cv=none; b=WCQRATFMqZSKUcLF5KzlPnCiSLXninMqggiJ3gnR/6AlLKUJfKDACTOSE+QRPGgi2JXIhOKotaLERNwB8oDhx1QHWqRv5l7e3INg5gCviDr8+/3V3Ba67mIn2u/KS2/Yad7VOsYsRkkciD963KeZdfihlLNUkZpVI4v5ET/Wrv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746752672; c=relaxed/simple;
	bh=d5tRvZCmJBVCc6MoiOu5zf+hcKgcc+Z6A6RFbN4W7rY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dms9Iu/+y0v3Pw0rZIUJh667AsNCrw0zeuMbFrSvJR2altCivObyL4i4g2p3EAO/s/P3KgHQfL3q2kmDCxvwlHydhrQ7nz4m5l8Qfu9dXMAKPACg6RE5PplLGEEXtFpui5ZF11QJqSsQB7JsJjg8xUPYWgGyv/Zx5cVUBCRfZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LzU24JKy; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8bdeb7f82c7111f0813e4fe1310efc19-20250509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0vPECswObQPRV1ipuOt1lHBTvRNdDtkZAdIDJlDmFKY=;
	b=LzU24JKyOU33svUeHPRxmMjtgLL1/N4E2R8puiajLVEYffRR0UJSOYR8IeJ+1W4owZOWD0BpgApjpnjvSjbD2ij+bAEBHDFLaoxJ4KtMFzAorEizex8Xa+G223M/1k8km8K6UB2Dj5mVRPpjMtrwMcMxbmCwrBWcFA9ga+df8cI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:22f903f5-b47e-47f1-81e9-94b367fae313,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:841c7480-1eec-4f76-b81b-944fecd9abcd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 8bdeb7f82c7111f0813e4fe1310efc19-20250509
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1904332798; Fri, 09 May 2025 09:04:23 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 9 May 2025 09:04:21 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 9 May 2025 09:04:21 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, <stable@vger.kernel.org>, Benjamin Xiao
	<fossben@pm.me>, Niklas Schnelle <niks@kernel.org>
Subject: [PATCH v3] wifi: mt76: mt7925: fix missing hdr_trans_tlv command for broadcast wtbl
Date: Fri, 9 May 2025 09:04:20 +0800
Message-ID: <20250509010421.403022-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Ensure that the hdr_trans_tlv command is included in the broadcast wtbl to
prevent the IPv6 and multicast packet from being dropped by the chip.

Cc: stable@vger.kernel.org
Fixes: cb1353ef3473 ("wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd")
Reported-by: Benjamin Xiao <fossben@pm.me>
Tested-by: Niklas Schnelle <niks@kernel.org>
Link: https://lore.kernel.org/lkml/EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=@pm.me/
---
v2:
    add tested-by tag
v3:
    add more info in commit
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a42b584634ab..fd756f0d18f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2183,14 +2183,14 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 			mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
 			mt7925_mcu_sta_eht_mld_tlv(skb, info->vif, info->link_sta->sta);
 		}
-
-		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
 	}
 
 	if (!info->enable) {
 		mt7925_mcu_sta_remove_tlv(skb);
 		mt76_connac_mcu_add_tlv(skb, STA_REC_MLD_OFF,
 					sizeof(struct tlv));
+	} else {
+		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
 	}
 
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
-- 
2.34.1


