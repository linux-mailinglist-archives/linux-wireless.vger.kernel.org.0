Return-Path: <linux-wireless+bounces-27190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75067B501B7
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 17:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5D37BF884
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 15:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3372D12EF;
	Tue,  9 Sep 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7SJVp9N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69294233134
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432162; cv=none; b=Ddve+uc1ahHKLWFPcCAi3n2DK5qtD566J+mNfrZOv7ebJHp2B2VBzuyrvM6YNsg8lvHZJ9ZOSSVyXIoj3zYFMmXxTu8OUcUBeAdeBVnRR7bLblr5EDZBxwnWCGpCdSSOc1+W2JlPFjsKXEOJ4vYwGwH6xqAWafsbdX+vp/xerqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432162; c=relaxed/simple;
	bh=lQuR3S6Fb68MG0x3R5/9HIN+tmeTsVTdNchH6j9B5Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=El8YnQJbuSvVnGyNghcq+hlGdwMO5QCCSnPCkyTOC6p2Vmfgg7POZut5l3CHCf4HRtdu4oi/l+9zIgBYJAWvNoD2ub4zYZXzLBjy6xeNJJkeLBKY184ziMPXOY347cO3X25+dRt2Mm0gNu12fmpA/QZ81pEf6mTwD+OZIMsXQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7SJVp9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D47FC4CEF4;
	Tue,  9 Sep 2025 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757432162;
	bh=lQuR3S6Fb68MG0x3R5/9HIN+tmeTsVTdNchH6j9B5Ws=;
	h=From:Date:Subject:To:Cc:From;
	b=d7SJVp9NhgaOupr5Z0oNaq4Y/nGQE4d67mznnvCrMZ0WMeZNzU0BB4VRIPYntgOj5
	 LlsXCsApviNjj1baniwlni7FPoJaNF2vNL5ucwOjhzKvI+ApA+h7lmxEMlthIIjhES
	 ZPv73igBaJ+4QzxW+6sv8myVxBhaVtPbfZfGK6rxoN2xQqskffSjWLgzVQa4CoaZEC
	 ZsMr9TvECkMTmy5jcKPll+9KPo4OuEEmewP5i8rB1/3lukq3QCUXAb5/2cXl6jyxt2
	 XC4yWdNLpHaw7kGX3/6XrkgDp0JgrenTg1u+YBHcj4VsSPLsD4+otZRcWImzHsnHFO
	 i2F1HPl4RFShQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 09 Sep 2025 17:35:49 +0200
Subject: [PATCH mt76] wifi: mt76: mt7996: support writing MAC TXD for AddBA
 Request
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mt7996-addba-txd-fix-v1-1-feec16f0c6f0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFRJwGgC/x2MSQqAMAwAvyI5G6jVKvUr4iGaqDm40IoI4t8tH
 mdg5oEoQSVCmz0Q5NKo+5agyDMYF9pmQeXEYI11xhuP69l4XyMxD4TnzTjpjaU4psqxrQqClB5
 Bkv63Xf++H9fO/SFmAAAA
X-Change-ID: 20250909-mt7996-addba-txd-fix-3e5da45d241a
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Howard Hsu <howard-yh.hsu@mediatek.com>
X-Mailer: b4 0.14.2

From: Howard Hsu <howard-yh.hsu@mediatek.com>

Support writing MAC TXD for the AddBA Req. Without this commit, the
start sequence number in AddBA Req will be unexpected value for MT7996
and MT7992. This can result in certain stations (e.g., AX200) dropping
packets, leading to ping failures and degraded connectivity. Ensuring
the correct MAC TXD and TXP helps maintain reliable packet transmission
and prevents interoperability issues with affected stations.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |  7 ++
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 91 +++++++++++++++-------
 2 files changed, 69 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 1013cad57a7ff3ad3ca2ddce8ea94f7ef704fead..c5eaedca11e09769302e93755998e9601b2fd05b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -294,6 +294,13 @@ enum tx_frag_idx {
 #define MT_TXP_BUF_LEN			GENMASK(11, 0)
 #define MT_TXP_DMA_ADDR_H		GENMASK(15, 12)
 
+#define MT_TXP0_TOKEN_ID0		GENMASK(14, 0)
+#define MT_TXP0_TOKEN_ID0_VALID_MASK	BIT(15)
+
+#define MT_TXP1_TID_ADDBA		GENMASK(14, 12)
+#define MT_TXP3_ML0_MASK		BIT(15)
+#define MT_TXP3_DMA_ADDR_H		GENMASK(13, 12)
+
 #define MT_TX_RATE_STBC			BIT(14)
 #define MT_TX_RATE_NSS			GENMASK(13, 10)
 #define MT_TX_RATE_MODE			GENMASK(9, 6)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 588f4aed31eda30aa48eeb06cfcbf36a0e147682..20861413303a6b6c980876e4d2638f6afeaa1e34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -802,6 +802,9 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ) {
 		if (is_mt7990(&dev->mt76))
 			txwi[6] |= cpu_to_le32(FIELD_PREP(MT_TXD6_TID_ADDBA, tid));
+		else
+			txwi[7] |= cpu_to_le32(MT_TXD7_MAC_TXD);
+
 		tid = MT_TX_ADDBA;
 	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
 		tid = MT_TX_NORMAL;
@@ -1031,10 +1034,10 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct ieee80211_vif *vif = info->control.vif;
-	struct mt76_connac_txp_common *txp;
 	struct mt76_txwi_cache *t;
 	int id, i, pid, nbuf = tx_info->nbuf - 1;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	__le32 *ptr = (__le32 *)txwi_ptr;
 	u8 *txwi = (u8 *)txwi_ptr;
 
 	if (unlikely(tx_info->skb->len <= ETH_HLEN))
@@ -1086,46 +1089,76 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
 				      pid, qid, 0);
 
-	txp = (struct mt76_connac_txp_common *)(txwi + MT_TXD_SIZE);
-	for (i = 0; i < nbuf; i++) {
-		u16 len;
+	/* MT7996 and MT7992 require driver to provide the MAC TXP for AddBA
+	 * req
+	 */
+	if (le32_to_cpu(ptr[7]) & MT_TXD7_MAC_TXD) {
+		u32 val;
+
+		ptr = (__le32 *)(txwi + MT_TXD_SIZE);
+		memset((void *)ptr, 0, sizeof(struct mt76_connac_fw_txp));
+
+		val = FIELD_PREP(MT_TXP0_TOKEN_ID0, id) |
+		      MT_TXP0_TOKEN_ID0_VALID_MASK;
+		ptr[0] = cpu_to_le32(val);
 
-		len = FIELD_PREP(MT_TXP_BUF_LEN, tx_info->buf[i + 1].len);
+		val = FIELD_PREP(MT_TXP1_TID_ADDBA,
+				 tx_info->skb->priority &
+				 IEEE80211_QOS_CTL_TID_MASK);
+		ptr[1] = cpu_to_le32(val);
+		ptr[2] = cpu_to_le32(tx_info->buf[1].addr & 0xFFFFFFFF);
+
+		val = FIELD_PREP(MT_TXP_BUF_LEN, tx_info->buf[1].len) |
+		      MT_TXP3_ML0_MASK;
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-		len |= FIELD_PREP(MT_TXP_DMA_ADDR_H,
-				  tx_info->buf[i + 1].addr >> 32);
+		val |= FIELD_PREP(MT_TXP3_DMA_ADDR_H,
+				  tx_info->buf[1].addr >> 32);
 #endif
+		ptr[3] = cpu_to_le32(val);
+	} else {
+		struct mt76_connac_txp_common *txp;
 
-		txp->fw.buf[i] = cpu_to_le32(tx_info->buf[i + 1].addr);
-		txp->fw.len[i] = cpu_to_le16(len);
-	}
-	txp->fw.nbuf = nbuf;
+		txp = (struct mt76_connac_txp_common *)(txwi + MT_TXD_SIZE);
+		for (i = 0; i < nbuf; i++) {
+			u16 len;
+
+			len = FIELD_PREP(MT_TXP_BUF_LEN, tx_info->buf[i + 1].len);
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+			len |= FIELD_PREP(MT_TXP_DMA_ADDR_H,
+					  tx_info->buf[i + 1].addr >> 32);
+#endif
 
-	txp->fw.flags = cpu_to_le16(MT_CT_INFO_FROM_HOST);
+			txp->fw.buf[i] = cpu_to_le32(tx_info->buf[i + 1].addr);
+			txp->fw.len[i] = cpu_to_le16(len);
+		}
+		txp->fw.nbuf = nbuf;
 
-	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
-		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_APPLY_TXD);
+		txp->fw.flags = cpu_to_le16(MT_CT_INFO_FROM_HOST);
 
-	if (!key)
-		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
+		if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
+			txp->fw.flags |= cpu_to_le16(MT_CT_INFO_APPLY_TXD);
 
-	if (!is_8023 && mt7996_tx_use_mgmt(dev, tx_info->skb))
-		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
+		if (!key)
+			txp->fw.flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
 
-	if (vif) {
-		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-		struct mt76_vif_link *mlink = NULL;
+		if (!is_8023 && mt7996_tx_use_mgmt(dev, tx_info->skb))
+			txp->fw.flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
 
-		if (wcid->offchannel)
-			mlink = rcu_dereference(mvif->mt76.offchannel_link);
-		if (!mlink)
-			mlink = rcu_dereference(mvif->mt76.link[wcid->link_id]);
+		if (vif) {
+			struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+			struct mt76_vif_link *mlink = NULL;
 
-		txp->fw.bss_idx = mlink ? mlink->idx : mvif->deflink.mt76.idx;
-	}
+			if (wcid->offchannel)
+				mlink = rcu_dereference(mvif->mt76.offchannel_link);
+			if (!mlink)
+				mlink = rcu_dereference(mvif->mt76.link[wcid->link_id]);
+
+			txp->fw.bss_idx = mlink ? mlink->idx : mvif->deflink.mt76.idx;
+		}
 
-	txp->fw.token = cpu_to_le16(id);
-	txp->fw.rept_wds_wcid = cpu_to_le16(sta ? wcid->idx : 0xfff);
+		txp->fw.token = cpu_to_le16(id);
+		txp->fw.rept_wds_wcid = cpu_to_le16(sta ? wcid->idx : 0xfff);
+	}
 
 	tx_info->skb = NULL;
 

---
base-commit: b054061870ecbed6305c0f559ae90f459f17637d
change-id: 20250909-mt7996-addba-txd-fix-3e5da45d241a

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


