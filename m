Return-Path: <linux-wireless+bounces-11540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6CA954636
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94F9285311
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25953171E76;
	Fri, 16 Aug 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UqKUxdPx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D82174ECD
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801829; cv=none; b=uS+A5pIsWg/YLa6R2XBaFxR0hqaCiRmrGuHWNKACMcMTULtOOctc0E/yfUSvI5LDfIaPt5cx2rtweZA2CCVQwEQMi4xcE9+I2/ZftqMZf/NcJjRuUfoOtGGsEx+1tpPGZSE0cYZz36FH3Nb/dW+EnsO0A3K19ieeNeUCb08Iz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801829; c=relaxed/simple;
	bh=8mvVp0WLL2pvogUxXxAk73hTN+Zm4LSdfVAaBiE9VUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXQclWIVcCynPZCuu5c2e5bXYzlib6N2vG9BG9D4mFY53+yt6y2AH6gOub5HZ1V2/B5dIZJtTIiqCCbnYkrH2YGe+SWthP8k7C9NriaCoKXNBBSBV6oldQuXGp70HaIrOQD9JM3wWbvtITpmst3WRpNCtZhqybOK9s/pRSwNXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UqKUxdPx; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ef59a4b65bb411ef8593d301e5c8a9c0-20240816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZbZskdAAPEfBiyTDM8Q3uhcblEGxlN0tOBCY1ZY5png=;
	b=UqKUxdPxhewhgPQEoQggvpEGhPs5r6HmSC1MaGjix45vz8u/34hBV4C2BSratLM6qminvlqV36dIL6cb9SWg0yZAQAih6j7IQD1FCOLefcql7Syhi9SiLmi+PbOI2ONFtBUKKbas/OQO/fEIDXLkdJvuP8UdaSVPBGSwhNWWVIM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:1e1decb5-d999-4bd6-8a67-7b80d7bf4997,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:1fad403f-6019-4002-9080-12f7f4711092,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ef59a4b65bb411ef8593d301e5c8a9c0-20240816
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1226736048; Fri, 16 Aug 2024 17:50:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Aug 2024 17:50:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Aug 2024 17:50:16 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Benjamin Lin
	<benjamin-jw.lin@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 11/12] wifi: mt76: connac: add IEEE 802.11 fragmentation support for mt7996
Date: Fri, 16 Aug 2024 17:46:34 +0800
Message-ID: <20240816094635.2391-10-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240816094635.2391-1-shayne.chen@mediatek.com>
References: <20240816094635.2391-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.424500-8.000000
X-TMASE-MatchedRID: d+baqQ3qUqfRpd8KAFU/vQPZZctd3P4BX5TqQagR07c1LB46LFAAklEJ
	QTCrPCv47l/5JtDtWGBMP01kejT9opWEhYv0US43tG07VELUSnQ7r2Gtb9iBYVsJAgsSNy6Uo8W
	MkQWv6iXBcIE78YqRWvcUt5lc1lLgoGRyAacnhaYZupxFsZSItKPMaYOuAHv0eM44NSba8IscNQ
	MmxiKDCX7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.424500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: C375A4A6DEECFF71A1D168E8EE4F909F880E11583EA294EFB2AA2509C4034E8D2000:8
X-MTK: N

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

Add fragment index into TXD.DW2 to support IEEE 802.11 fragmentation.

Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h   |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c     | 13 +++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index ef003d1620a5..db0c29e65185 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -197,6 +197,13 @@ enum tx_mgnt_type {
 	MT_TX_ADDBA,
 };
 
+enum tx_frag_idx {
+	MT_TX_FRAG_NONE,
+	MT_TX_FRAG_FIRST,
+	MT_TX_FRAG_MID,
+	MT_TX_FRAG_LAST
+};
+
 #define MT_CT_INFO_APPLY_TXD		BIT(0)
 #define MT_CT_INFO_COPY_HOST_TXD_ALL	BIT(1)
 #define MT_CT_INFO_MGMT_FRAME		BIT(2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index fd5fe96c32e3..0d21414e2c88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -746,7 +746,7 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
-	__le16 fc = hdr->frame_control;
+	__le16 fc = hdr->frame_control, sc = hdr->seq_ctrl;
 	u8 fc_type, fc_stype;
 	u32 val;
 
@@ -780,6 +780,15 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
 	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
 
+	if (ieee80211_has_morefrags(fc) && ieee80211_is_first_frag(sc))
+		val |= FIELD_PREP(MT_TXD2_FRAG, MT_TX_FRAG_FIRST);
+	else if (ieee80211_has_morefrags(fc) && !ieee80211_is_first_frag(sc))
+		val |= FIELD_PREP(MT_TXD2_FRAG, MT_TX_FRAG_MID);
+	else if (!ieee80211_has_morefrags(fc) && !ieee80211_is_first_frag(sc))
+		val |= FIELD_PREP(MT_TXD2_FRAG, MT_TX_FRAG_LAST);
+	else
+		val |= FIELD_PREP(MT_TXD2_FRAG, MT_TX_FRAG_NONE);
+
 	txwi[2] |= cpu_to_le32(val);
 
 	txwi[3] |= cpu_to_le32(FIELD_PREP(MT_TXD3_BCM, multicast));
@@ -789,7 +798,7 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 	}
 
 	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
-		u16 seqno = le16_to_cpu(hdr->seq_ctrl);
+		u16 seqno = le16_to_cpu(sc);
 
 		if (ieee80211_is_back_req(hdr->frame_control)) {
 			struct ieee80211_bar *bar;
-- 
2.39.2


