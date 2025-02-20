Return-Path: <linux-wireless+bounces-19203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB3A3DB24
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C08219C10AA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13F21F8AC0;
	Thu, 20 Feb 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV+vhirD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FA1F540C
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057560; cv=none; b=DHflkumsaDnCns0ZQMu6cUVmLdshdyVfbQqxO1pQiMaCM1IPAYvoYAFNsRxDiuqb2yWvHO9fQxj4ZRZkzX0QoA3RyxE069g8M46NDrSSwULBoezElzdbQfUnOmDaCtfre25QYskKt7GqNNFI3csdSj1x92P4BEO8/UFc/409SHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057560; c=relaxed/simple;
	bh=S+D8W7z7Jhypw2JZpyWsRpFI3+bxe9KTb6aEXTU5jtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=si24pBno2N0mJac20IMsaoBMZfRJzM6E4mum46njENFaB+nDM2MCH4bVc/AblxjVi5XgO1vuC5P9l9a8fzgaz6tx0kIaAXSFVMME70sbkBPvco98vChYTKiJhUdtsq0qaIZk5ETRyI169w72kv/MtyXaLrOf01alK1bO05b0xjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV+vhirD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C54C4CED1;
	Thu, 20 Feb 2025 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057560;
	bh=S+D8W7z7Jhypw2JZpyWsRpFI3+bxe9KTb6aEXTU5jtE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jV+vhirDhTVEaw4Cc6W904gJnHDHQrJP4/PKzdbFUjYcE+DrRUDuKBJOL6YHsJP5B
	 OPr6DBLV4G7faQrX+0i4oJ8XlOZJ/CCaD/PmDBVWAajHIVV+S34bDBhzM3Bd8jDexb
	 LSfpJEK/Qvq1YV8pY/VEJCTFWqp4Jb96OK1oEuPBdoLC+zAo1g3MydCufH/9zWRBw5
	 1vwoK8HCg/iP12gJ5+g+RkpgdIFS51pQX053VHyRAB3TlkIIB12toc5O/VhDHZn5aR
	 CPVTzFstfaJGLtkMJ50rtxNQRZI0+XTySa+8akU2efdMtncku5JT1vhpfZ7bbevHfL
	 UW59TAJcGY0IQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 20 Feb 2025 14:18:49 +0100
Subject: [PATCH 03/14] wifi: mt76: mt7996: Add mt7996_sta_link struct in
 mt7996_vif_link
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mt7996-mlo-v1-3-34c4abb37158@kernel.org>
References: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
In-Reply-To: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce mt7996_sta_link field in mt7996_vif_link structure instead of
mt7996_sta. This is a preliminary patch to support MLO in MT7996 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 24 ++++++++++++----------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 10 ++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  2 +-
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index a2983b23fbe1cef7512eb056b0dcefc9aa928b67..32b011e7945a603e06b543e0b302211ce83af1ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -72,10 +72,10 @@ static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
 	msta_link = container_of(wcid, struct mt7996_sta_link, wcid);
 	msta = msta_link->sta;
 
-	if (!msta->vif)
+	if (!msta || !msta->vif)
 		return NULL;
 
-	return &msta->vif->deflink.sta.deflink.wcid;
+	return &msta->vif->deflink.msta_link.wcid;
 }
 
 bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask)
@@ -202,7 +202,7 @@ void mt7996_mac_enable_rtscts(struct mt7996_dev *dev,
 			      struct ieee80211_vif *vif, bool enable)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_sta_link *msta_link = &mvif->deflink.sta.deflink;
+	struct mt7996_sta_link *msta_link = &mvif->deflink.msta_link;
 	u32 addr;
 
 	addr = mt7996_mac_wtbl_lmac_addr(dev, msta_link->wcid.idx, 5);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index b1f325e062b84ad344836050ad0d5fa6ec414514..e4ea5a37296167400a39e8d80f1fe2c3b0f1af5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -161,19 +161,23 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		  struct mt7996_vif_link *mlink, struct ieee80211_key_conf *key)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_sta *msta = sta ? (struct mt7996_sta *)sta->drv_priv :
-				  &mlink->sta;
-	struct mt76_wcid *wcid = &msta->deflink.wcid;
-	u8 *wcid_keyidx = &wcid->hw_key_idx;
+	struct mt76_wcid *wcid = &mlink->msta_link.wcid;
 	struct mt7996_phy *phy;
 	int idx = key->keyidx;
+	u8 *wcid_keyidx;
 
 	phy = mt7996_vif_link_phy(mlink);
 	if (!phy)
 		return -EINVAL;
 
-	if (sta && !wcid->sta)
-		return -EOPNOTSUPP;
+	if (sta) {
+		struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+
+		wcid = &msta->deflink.wcid;
+		if (!wcid->sta)
+			return -EOPNOTSUPP;
+	}
+	wcid_keyidx = &wcid->hw_key_idx;
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_AES_CMAC:
@@ -229,7 +233,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 			struct mt76_vif_link *mlink)
 {
 	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
-	struct mt7996_sta_link *msta_link = &link->sta.deflink;
+	struct mt7996_sta_link *msta_link = &link->msta_link;
 	struct mt7996_phy *phy = mphy->priv;
 	struct mt7996_dev *dev = phy->dev;
 	u8 band_idx = phy->mt76->band_idx;
@@ -260,7 +264,6 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	idx = MT7996_WTBL_RESERVED - mlink->idx;
 
 	INIT_LIST_HEAD(&msta_link->rc_list);
-	msta_link->sta = &link->sta;
 	msta_link->wcid.idx = idx;
 	msta_link->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mt76_wcid_init(&msta_link->wcid, band_idx);
@@ -302,10 +305,9 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 			    struct mt76_vif_link *mlink)
 {
 	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
+	struct mt7996_sta_link *msta_link = &link->msta_link;
 	struct mt7996_phy *phy = mphy->priv;
 	struct mt7996_dev *dev = phy->dev;
-	struct mt7996_sta *msta = &link->sta;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
 	int idx = msta_link->wcid.idx;
 
 	mt7996_mcu_add_sta(dev, vif, mlink, NULL, CONN_STATE_DISCONNECT, false);
@@ -864,7 +866,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 		struct mt7996_vif *mvif;
 
 		mvif = (struct mt7996_vif *)vif->drv_priv;
-		wcid = &mvif->deflink.sta.deflink.wcid;
+		wcid = &mvif->deflink.msta_link.wcid;
 
 		if (mvif->mt76.roc_phy &&
 		    (info->flags & IEEE80211_TX_CTL_TX_OFFCHAN)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 51d2c541801f998014b2eecb8d34dd49e5598df7..4c29cfd2c3ec1a889ec917d986eb966758566f1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2171,8 +2171,8 @@ mt7996_mcu_add_group(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		.val = cpu_to_le32(mvif->deflink.mt76.idx % 16),
 	};
 
-	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->deflink.sta;
-	msta_link = &msta->deflink;
+	msta = sta ? (struct mt7996_sta *)sta->drv_priv : NULL;
+	msta_link = msta ? &msta->deflink : &mvif->deflink.msta_link;
 	req.wlan_idx = cpu_to_le16(msta_link->wcid.idx);
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(VOW), &req,
@@ -2319,7 +2319,7 @@ static int mt7996_mcu_get_pn(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 {
 #define TSC_TYPE_BIGTK_PN 2
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_sta_link *msta_link = &mvif->deflink.sta.deflink;
+	struct mt7996_sta_link *msta_link = &mvif->deflink.msta_link;
 	struct sta_rec_pn_info *pn_info;
 	struct sk_buff *skb, *rskb;
 	struct tlv *tlv;
@@ -4357,8 +4357,8 @@ int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 	struct mt7996_sta *msta;
 	struct sk_buff *skb;
 
-	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->deflink.sta;
-	msta_link = &msta->deflink;
+	msta = sta ? (struct mt7996_sta *)sta->drv_priv : NULL;
+	msta_link = msta ? &msta->deflink : &mvif->deflink.msta_link;
 
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
 					      &msta_link->wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index d0a4240f12a482895659e3a359daadcdca7bf7c9..ac5b94e1315ec610f5182563e3fb9d504a67c16f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -215,7 +215,7 @@ struct mt7996_sta {
 struct mt7996_vif_link {
 	struct mt76_vif_link mt76; /* must be first */
 
-	struct mt7996_sta sta;
+	struct mt7996_sta_link msta_link;
 	struct mt7996_phy *phy;
 
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];

-- 
2.48.1


