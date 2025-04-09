Return-Path: <linux-wireless+bounces-21316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1563DA82748
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 16:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2E1178453
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 14:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEC2265CA0;
	Wed,  9 Apr 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oJHKoK1/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF8515530C
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207726; cv=none; b=fa+ZBGCSJwhpMC0+5zK7PQhBCjnAzFPuoc4MCSXA6+gZNZpIQXsEqHA1IDCrKwgLLWQSci1wYiSwGP6qoWsTphFMqpTWsy1EdHu1r1YKUeiI2V6WVMQdZOnacVybp7ZN4BPxmvwC59pEnAMccjmK26ac49/286uYMUbocHTW4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207726; c=relaxed/simple;
	bh=UxFNjTwkoY0b0bq8cmkDkuA2u5iRt9ZGedNuVj9xxXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwa2svNn4YjUo0x95f69FHcM74SBMTfBpVg4AogoUZbF5P3RtAZYcZ2PlvCnDtBi+hxj8G7cnj0F2xbTyyV4tgtigMUKD5x93UTdDs8C4x6rp2uVX+zP0oDJTpghxTl6TpB/8pMqcwo8oV5asZJ+7/lxKyYfLAPkVf6F7u2P71M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oJHKoK1/; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 21d7f414154c11f08eb9c36241bbb6fb-20250409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NO/8kC52jO5K7X5WlueyKyCmE6RphgAvdD/ilcQoADw=;
	b=oJHKoK1/DYGGgNQQ8Y8AGRyAWkjxuN8ys1qT/hdCYC8dCRxnxQeqY/EjkRYXMGc4F5ZFgLHG1PcZoPWNjJCEYRz0n2dknKM0ua8/qjq6wz4HwMdUaffA17XHSvnwT3Fe+aOAHxN8rhb7drOU8XLh6ZIXpE5k/gWrizEYWAYHGv8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:6567d25c-4235-499a-b7e4-11128bd4560c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:e51f688d-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 21d7f414154c11f08eb9c36241bbb6fb-20250409
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1277472259; Wed, 09 Apr 2025 22:08:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 9 Apr 2025 22:08:37 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 9 Apr 2025 22:08:37 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>, Benjamin Lin
	<benjamin-jw.lin@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH mt76-next v3 08/10] wifi: mt76: connac: rework TX descriptor and TX free for mt7990
Date: Wed, 9 Apr 2025 22:07:48 +0800
Message-ID: <20250409140750.724437-9-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250409140750.724437-1-shayne.chen@mediatek.com>
References: <20250409140750.724437-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Adjust the TX descriptor and TX free for updated hardware fields.
This is a preliminary patch to support mt7990 chipset.

Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Co-developed-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac3_mac.h |  1 +
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 42 ++++++++++++++++---
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 487ad716f872..1013cad57a7f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -273,6 +273,7 @@ enum tx_frag_idx {
 #define MT_TXD6_TX_RATE			GENMASK(21, 16)
 #define MT_TXD6_TIMESTAMP_OFS_EN	BIT(15)
 #define MT_TXD6_TIMESTAMP_OFS_IDX	GENMASK(14, 10)
+#define MT_TXD6_TID_ADDBA		GENMASK(10, 8)
 #define MT_TXD6_MSDU_CNT		GENMASK(9, 4)
 #define MT_TXD6_MSDU_CNT_V2		GENMASK(15, 10)
 #define MT_TXD6_DIS_MAT			BIT(3)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index baa4aea109bc..95f5532971eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -789,10 +789,13 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 
 	if (ieee80211_is_action(fc) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
-	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ)
+	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ) {
+		if (is_mt7990(&dev->mt76))
+			txwi[6] |= cpu_to_le32(FIELD_PREP(MT_TXD6_TID_ADDBA, tid));
 		tid = MT_TX_ADDBA;
-	else if (ieee80211_is_mgmt(hdr->frame_control))
+	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
 		tid = MT_TX_NORMAL;
+	}
 
 	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
 	      FIELD_PREP(MT_TXD1_HDR_INFO,
@@ -987,12 +990,32 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	}
 }
 
+static bool
+mt7996_tx_use_mgmt(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
+	if (ieee80211_is_mgmt(hdr->frame_control))
+		return true;
+
+	/* for SDO to bypass specific data frame */
+	if (!mt7996_has_wa(dev)) {
+		if (unlikely(skb->protocol == cpu_to_be16(ETH_P_PAE)))
+			return true;
+
+		if (ieee80211_has_a4(hdr->frame_control) &&
+		    !ieee80211_is_data_present(hdr->frame_control))
+			return true;
+	}
+
+	return false;
+}
+
 int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info)
 {
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx_info->skb->data;
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
@@ -1046,7 +1069,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (!key)
 		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
 
-	if (!is_8023 && ieee80211_is_mgmt(hdr->frame_control))
+	if (!is_8023 && mt7996_tx_use_mgmt(dev, tx_info->skb))
 		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
 
 	if (vif) {
@@ -1184,6 +1207,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 	void *end = data + len;
 	bool wake = false;
 	u16 total, count = 0;
+	u8 ver;
 
 	/* clean DMA queues and unmap buffers first */
 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
@@ -1197,7 +1221,8 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 		mt76_queue_tx_cleanup(dev, phy3->q_tx[MT_TXQ_BE], false);
 	}
 
-	if (WARN_ON_ONCE(le32_get_bits(tx_free[1], MT_TXFREE1_VER) < 5))
+	ver = le32_get_bits(tx_free[1], MT_TXFREE1_VER);
+	if (WARN_ON_ONCE(ver < 5))
 		return;
 
 	total = le32_get_bits(tx_free[0], MT_TXFREE0_MSDU_CNT);
@@ -1219,11 +1244,16 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 			wcid = rcu_dereference(dev->mt76.wcid[idx]);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
-				continue;
+				goto next;
 
 			msta_link = container_of(wcid, struct mt7996_sta_link,
 						 wcid);
 			mt76_wcid_add_poll(&dev->mt76, &msta_link->wcid);
+next:
+			/* ver 7 has a new DW with pair = 1, skip it */
+			if (ver == 7 && ((void *)(cur_info + 1) < end) &&
+			    (le32_to_cpu(*(cur_info + 1)) & MT_TXFREE_INFO_PAIR))
+				cur_info++;
 			continue;
 		} else if (info & MT_TXFREE_INFO_HEADER) {
 			u32 tx_retries = 0, tx_failed = 0;
-- 
2.39.2


