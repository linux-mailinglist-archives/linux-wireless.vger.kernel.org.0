Return-Path: <linux-wireless+bounces-20230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76E0A5DB27
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F2B3A71C2
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569BF23F28C;
	Wed, 12 Mar 2025 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6zC6CEa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE422E011
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778051; cv=none; b=Hcnnoi37bb9SzygzvasdrkVbh0XlycYwVMIQaoZGecphmr0RTK5GJPC7PQMJX6NU2MJIrXNQUYiGbb0snTxaNIJDdF3Fp8+31zE8Trtp3jQwZiB7Te0VsG2BK+V/P+vla19wBFE/MKBvj7PYGx3L6RLFxBl7EPvOROwpGomWjck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778051; c=relaxed/simple;
	bh=o3Z2HSX6Z36gmVMxakkW1a7pxF0mIQUNgh9OhFtnEOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=he9BCjIVPo5nkX9v4hHElwhlgJKK2JVJhkwB6Qp4vRopYYJjJOuC9NY6mwX5vp+F7r9yY29fZFVfeFFa8kRt4CHrZ9rjUMDvm+QPM4VIWjo/+5aR5oBMnko0Sb15hzkWm/DI0TFTz+vxfhqCdBaMMVKLZ1zJxU8vKdL8EZ0JyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6zC6CEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F084C4CEE3;
	Wed, 12 Mar 2025 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778050;
	bh=o3Z2HSX6Z36gmVMxakkW1a7pxF0mIQUNgh9OhFtnEOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z6zC6CEaySiq6vXfIe6SY1BmrqmCowR08aRORTmVEL+vQKJjV3PUOXVtIn9l7/bT7
	 opGQo7RLZCv4jsCCHu16Vj61p/WHngeZQCTx8b2jkV9t2ug8IiM0okoL+MMYqLqNvm
	 /kcK4vbsLASSZpKVuwluy9KYLtZI9YzcKT8Ns0DhMHa1Vxn/gaw1Gxgu+2EGdMHaBQ
	 DlzCenJMcB2SHAYWFeg4/TIGUDJW/67CQS9RUpHaIlbKRYaS3MNIs2TwGU1gM0k6Ky
	 mNWrhOgEZrep2RgSd+z/MaJoxaFy9+JxaxqN0HayvYLrOyrBazKIX4oc99VF2i7l2n
	 N+pyH+p5TlU7g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:13:48 +0100
Subject: [PATCH 04/21] wifi: mt76: mt7996: rework mt7996_mac_write_txwi()
 for MLO support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-4-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

Update mt7996_mac_write_txwi routine and all the called subroutines to
support MLO.
This is a preliminary patch to enable MLO for MT7996 driver

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 55 ++++++++++++++++++-------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 48ba975f069c5062f450326a359ff3442ac96f30..eed692cd64a6acedb2f6d9aaf6f459bf4a4f5b08 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -730,9 +730,8 @@ mt7996_mac_write_txwi_8023(struct mt7996_dev *dev, __le32 *txwi,
 	u32 val;
 
 	if (wcid->sta) {
-		struct ieee80211_sta *sta;
+		struct ieee80211_sta *sta = wcid_to_sta(wcid);
 
-		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
 		wmm = sta->wme;
 	}
 
@@ -759,7 +758,9 @@ mt7996_mac_write_txwi_8023(struct mt7996_dev *dev, __le32 *txwi,
 
 static void
 mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
-			    struct sk_buff *skb, struct ieee80211_key_conf *key)
+			    struct sk_buff *skb,
+			    struct ieee80211_key_conf *key,
+			    struct mt76_wcid *wcid)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
@@ -767,6 +768,7 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 	__le16 fc = hdr->frame_control, sc = hdr->seq_ctrl;
+	u16 seqno = le16_to_cpu(sc);
 	u8 fc_type, fc_stype;
 	u32 val;
 
@@ -816,9 +818,13 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
 	}
 
-	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
-		u16 seqno = le16_to_cpu(sc);
+	if (multicast && ieee80211_vif_is_mld(info->control.vif)) {
+		val = MT_TXD3_SN_VALID |
+		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
+		txwi[3] |= cpu_to_le32(val);
+	}
 
+	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
 		if (ieee80211_is_back_req(hdr->frame_control)) {
 			struct ieee80211_bar *bar;
 
@@ -831,6 +837,19 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 		txwi[3] |= cpu_to_le32(val);
 		txwi[3] &= ~cpu_to_le32(MT_TXD3_HW_AMSDU);
 	}
+
+	if (ieee80211_vif_is_mld(info->control.vif) &&
+	    (multicast || unlikely(skb->protocol == cpu_to_be16(ETH_P_PAE))))
+		txwi[5] |= cpu_to_le32(MT_TXD5_FL);
+
+	if (ieee80211_is_nullfunc(fc) && ieee80211_has_a4(fc) &&
+	    ieee80211_vif_is_mld(info->control.vif)) {
+		txwi[5] |= cpu_to_le32(MT_TXD5_FL);
+		txwi[6] |= cpu_to_le32(MT_TXD6_DIS_MAT);
+	}
+
+	if (!wcid->sta && ieee80211_is_mgmt(fc))
+		txwi[6] |= cpu_to_le32(MT_TXD6_DIS_MAT);
 }
 
 void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
@@ -846,6 +865,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	struct mt76_vif_link *mlink = NULL;
 	struct mt7996_vif *mvif;
+	unsigned int link_id;
 	u16 tx_count = 15;
 	u32 val;
 	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
@@ -853,13 +873,15 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
 				    BSS_CHANGED_BEACON_ENABLED)) && (!inband_disc);
 
-	if (vif) {
-		mvif = (struct mt7996_vif *)vif->drv_priv;
-		if (wcid->offchannel)
-			mlink = rcu_dereference(mvif->mt76.offchannel_link);
-		if (!mlink)
-			mlink = &mvif->deflink.mt76;
-	}
+	if (wcid != &dev->mt76.global_wcid)
+		link_id = wcid->link_id;
+	else
+		link_id = u32_get_bits(info->control.flags,
+				       IEEE80211_TX_CTRL_MLO_LINK);
+
+	mvif = vif ? (struct mt7996_vif *)vif->drv_priv : NULL;
+	if (mvif)
+		mlink = rcu_dereference(mvif->mt76.link[link_id]);
 
 	if (mlink) {
 		omac_idx = mlink->omac_idx;
@@ -911,7 +933,10 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		val |= MT_TXD5_TX_STATUS_HOST;
 	txwi[5] = cpu_to_le32(val);
 
-	val = MT_TXD6_DIS_MAT | MT_TXD6_DAS;
+	val = MT_TXD6_DAS;
+	if (q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0)
+		val |= MT_TXD6_DIS_MAT;
+
 	if (is_mt7996(&dev->mt76))
 		val |= FIELD_PREP(MT_TXD6_MSDU_CNT, 1);
 	else if (is_8023 || !ieee80211_is_mgmt(hdr->frame_control))
@@ -923,7 +948,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	if (is_8023)
 		mt7996_mac_write_txwi_8023(dev, txwi, skb, wcid);
 	else
-		mt7996_mac_write_txwi_80211(dev, txwi, skb, key);
+		mt7996_mac_write_txwi_80211(dev, txwi, skb, key, wcid);
 
 	if (txwi[1] & cpu_to_le32(MT_TXD1_FIXED_RATE)) {
 		bool mcast = ieee80211_is_data(hdr->frame_control) &&
@@ -940,6 +965,8 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		}
 
 		val = FIELD_PREP(MT_TXD6_TX_RATE, idx) | MT_TXD6_FIXED_BW;
+		if (mcast)
+			val |= MT_TXD6_DIS_MAT;
 		txwi[6] |= cpu_to_le32(val);
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}

-- 
2.48.1


