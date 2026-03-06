Return-Path: <linux-wireless+bounces-32627-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCWEDFOsqmnjVAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32627-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:28:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 130CF21EB3D
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE0A530089A2
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 10:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7108537C0F6;
	Fri,  6 Mar 2026 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfjB8Ubn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98D37C0F0
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792897; cv=none; b=Lp0ix9/qp1FHMdDPFNLaX4Gu+HaVPt9eM2kEm0A5bRc+m/GTcO7ioSBkJq9ZdbbkPs8OM7o9tgRi372Pl+YI60d98isgdmV48YQw04btIISyBHBRIVhVm99zjLdzp3Ahh0TQYMxqDdebP6xjLfB3vnmXOvvnM1gyo5NNYdBJEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792897; c=relaxed/simple;
	bh=OL0rgue66YdTnJUJbn4fjsELZT80r00fKL12WnmaKWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olDqBMgnVMdjs8KGG0G6AbKHTvrWiUpkbK/A/OA+7F4cfBp7eWMdpUsRNbO3djuyFmWkMtD1+hnKzU3Lfm5+xwLJrfGHYIhXsmvC2wyJ6+1ex0Q+xSKfH1ESsfGG5+FnRAFtr+6T4KmXpyjb5xfj4ssk5SzIjAxlempVBcFQQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfjB8Ubn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989FAC19422;
	Fri,  6 Mar 2026 10:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772792897;
	bh=OL0rgue66YdTnJUJbn4fjsELZT80r00fKL12WnmaKWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RfjB8UbngGuQpcUAiQST0fIUHPjQzGIfArct/EdZpi9oYo1ymOWaI2GWq2PS+Ch2y
	 2I3M+39bhy6ZU0wZJAek4Y8o0byqogzkMIZpxC0YQ0iViiPqPOZm/4pIjioSc3GmZr
	 kG4Q2PKM/A9EOQSYCQ6mrPpnBrs6VLVmTecUFmWN5Yk+cPFsWSdlb9Wny1MumENb8i
	 XaZEmNW3WPc1JE8SUFV5giwtsAWSyqo4UwN4Z0SAHwYsNTN8Huw9TV5M/2ysh8j5qY
	 COcBBmBeBWdIo9hnJcxiQVYhFtnDafOV9JlyuXFXzCKXvxsROPd4OxfUKoZQw4Krs+
	 gmE1/Eu62fLAg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 06 Mar 2026 11:27:55 +0100
Subject: [PATCH mt76 4/4] wifi: mt76: mt7996: Remove unnecessary phy filed
 in mt7996_vif_link struct
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-mt7996-deflink-lookup-link-remove-v1-4-7162b332873c@kernel.org>
References: <20260306-mt7996-deflink-lookup-link-remove-v1-0-7162b332873c@kernel.org>
In-Reply-To: <20260306-mt7996-deflink-lookup-link-remove-v1-0-7162b332873c@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 130CF21EB3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	TAGGED_FROM(0.00)[bounces-32627-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Remove unnecessary phy pointer in mt7996_vif_link struct and rely on
mt7996_vif_link_phy() utility routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    | 14 +++-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  7 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 43 +++++++++----
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 74 ++++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  2 -
 5 files changed, 101 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 76d623b2cafb4d55ddeee04b1e84be08e149860e..6cc63f87b2226e9165eeeaf56b61c1c6d4d34052 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -626,13 +626,18 @@ mt7996_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_vif *mvif = msta->vif;
-	struct mt7996_dev *dev = mvif->deflink.phy->dev;
+	struct mt7996_phy *phy = mt7996_vif_link_phy(&mvif->deflink);
 	struct ieee80211_link_sta *link_sta;
 	struct seq_file *s = data;
 	struct ieee80211_vif *vif;
+	struct mt7996_dev *dev;
 	unsigned int link_id;
 
+	if (!phy)
+		return;
+
 	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+	dev = phy->dev;
 
 	rcu_read_lock();
 
@@ -979,13 +984,17 @@ static ssize_t mt7996_link_sta_fixed_rate_set(struct file *file,
 #define LONG_PREAMBLE 1
 	struct ieee80211_link_sta *link_sta = file->private_data;
 	struct mt7996_sta *msta = (struct mt7996_sta *)link_sta->sta->drv_priv;
-	struct mt7996_dev *dev = msta->vif->deflink.phy->dev;
+	struct mt7996_phy *link_phy = mt7996_vif_link_phy(&msta->vif->deflink);
 	struct mt7996_sta_link *msta_link;
 	struct ra_rate phy = {};
+	struct mt7996_dev *dev;
 	char buf[100];
 	int ret;
 	u16 gi, ltf;
 
+	if (!link_phy)
+		return -EINVAL;
+
 	if (count >= sizeof(buf))
 		return -EINVAL;
 
@@ -1008,6 +1017,7 @@ static ssize_t mt7996_link_sta_fixed_rate_set(struct file *file,
 	 * spe - off: 0, on: 1
 	 * ltf - 1xltf: 0, 2xltf: 1, 4xltf: 2
 	 */
+	dev = link_phy->dev;
 	if (sscanf(buf, "%hhu %hhu %hhu %hhu %hu %hhu %hhu %hhu %hhu %hu",
 		   &phy.mode, &phy.bw, &phy.mcs, &phy.nss, &gi,
 		   &phy.preamble, &phy.stbc, &phy.ldpc, &phy.spe, &ltf) != 10) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index a415cc610eeec8cb160aeac8219f421742d75bad..382b2d873021c6ae253e8ff71bce77bdedff75a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2167,9 +2167,14 @@ mt7996_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
 
 	for_each_vif_active_link(vif, link_conf, link_id) {
 		struct mt7996_vif_link *link;
+		struct mt7996_phy *link_phy;
 
 		link = mt7996_vif_link(dev, vif, link_id);
-		if (!link || link->phy != phy)
+		if (!link)
+			continue;
+
+		link_phy = mt7996_vif_link_phy(link);
+		if (link_phy != phy)
 			continue;
 
 		mt7996_mcu_add_beacon(dev->mt76.hw, vif, link_conf,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index b659d173268981f25344be4b3176a1e7636db7a4..745e01f0eb67dfb7f6474bc39ad25146474e2011 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -239,10 +239,13 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		link_conf = &vif->bss_conf;
 
 	if (cmd == SET_KEY && !sta && !link->mt76.cipher) {
+		struct mt7996_phy *phy = mt7996_vif_link_phy(link);
+
 		link->mt76.cipher =
 			mt76_connac_mcu_get_cipher(key->cipher);
-		mt7996_mcu_add_bss_info(link->phy, vif, link_conf,
-					&link->mt76, msta_link, true);
+		if (phy)
+			mt7996_mcu_add_bss_info(phy, vif, link_conf,
+						&link->mt76, msta_link, true);
 	}
 
 	if (cmd == SET_KEY)
@@ -316,7 +319,6 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		return -ENOSPC;
 
 	link->mld_idx = mld_idx;
-	link->phy = phy;
 	mlink->omac_idx = idx;
 	mlink->band_idx = band_idx;
 	mlink->wmm_idx = vif->type == NL80211_IFTYPE_AP ? 0 : 3;
@@ -823,15 +825,17 @@ mt7996_vif_cfg_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 		for_each_vif_active_link(vif, link_conf, link_id) {
 			struct mt7996_vif_link *link;
+			struct mt7996_phy *phy;
 
 			link = mt7996_vif_link(dev, vif, link_id);
 			if (!link)
 				continue;
 
-			if (!link->phy)
+			phy = mt7996_vif_link_phy(link);
+			if (!phy)
 				continue;
 
-			mt7996_mcu_add_bss_info(link->phy, vif, link_conf,
+			mt7996_mcu_add_bss_info(phy, vif, link_conf,
 						&link->mt76, &link->msta_link,
 						true);
 			mt7996_mcu_add_sta(dev, link_conf, NULL, link, NULL,
@@ -950,10 +954,15 @@ mt7996_channel_switch_beacon(struct ieee80211_hw *hw,
 	mutex_lock(&dev->mt76.mutex);
 
 	for_each_vif_active_link(vif, link_conf, link_id) {
-		struct mt7996_vif_link *link =
-			mt7996_vif_link(dev, vif, link_id);
+		struct mt7996_vif_link *link;
+		struct mt7996_phy *link_phy;
+
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link)
+			continue;
 
-		if (!link || link->phy != phy)
+		link_phy = mt7996_vif_link_phy(link);
+		if (link_phy != phy)
 			continue;
 
 		/* Reset beacon when channel switch triggered during CAC to let
@@ -1024,10 +1033,13 @@ mt7996_mac_sta_init_link(struct mt7996_dev *dev,
 {
 	struct ieee80211_sta *sta = link_sta->sta;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_phy *phy = link->phy;
+	struct mt7996_phy *phy = mt7996_vif_link_phy(link);
 	struct mt7996_sta_link *msta_link;
 	int idx;
 
+	if (!phy)
+		return -EINVAL;
+
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
 	if (idx < 0)
 		return -ENOSPC;
@@ -1571,8 +1583,8 @@ mt7996_get_stats(struct ieee80211_hw *hw,
 
 u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif_link *link)
 {
+	struct mt7996_phy *phy = mt7996_vif_link_phy(link);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = link->phy;
 	union {
 		u64 t64;
 		u32 t32[2];
@@ -1631,7 +1643,7 @@ mt7996_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	n = link->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
 					       : link->mt76.omac_idx;
-	phy = link->phy;
+	phy = mt7996_vif_link_phy(link);
 	if (!phy)
 		goto unlock;
 
@@ -1665,7 +1677,7 @@ mt7996_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (!link)
 		goto unlock;
 
-	phy = link->phy;
+	phy = mt7996_vif_link_phy(link);
 	if (!phy)
 		goto unlock;
 
@@ -1795,9 +1807,14 @@ static void mt7996_link_rate_ctrl_update(void *data,
 					 struct mt7996_sta_link *msta_link)
 {
 	struct mt7996_sta *msta = msta_link->sta;
-	struct mt7996_dev *dev = msta->vif->deflink.phy->dev;
+	struct mt7996_phy *phy = mt7996_vif_link_phy(&msta->vif->deflink);
+	struct mt7996_dev *dev;
 	u32 *changed = data;
 
+	if (!phy)
+		return;
+
+	dev = phy->dev;
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 
 	msta_link->changed |= *changed;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index bdb9e30c54c14cb70e548bf347d0449ad8207848..fe9dcc6b08b88aebb5d5242a50aa6d48d16f502a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -128,9 +128,16 @@ mt7996_mcu_set_sta_he_mcs(struct ieee80211_link_sta *link_sta,
 			  struct mt7996_vif_link *link,
 			  __le16 *he_mcs, u16 mcs_map)
 {
+	struct mt76_phy *mphy = mt76_vif_link_phy(&link->mt76);
 	int nss, max_nss = link_sta->rx_nss > 3 ? 4 : link_sta->rx_nss;
-	enum nl80211_band band = link->phy->mt76->chandef.chan->band;
-	const u16 *mask = link->bitrate_mask.control[band].he_mcs;
+	enum nl80211_band band;
+	const u16 *mask;
+
+	if (!mphy)
+		return;
+
+	band = mphy->chandef.chan->band;
+	mask = link->bitrate_mask.control[band].he_mcs;
 
 	for (nss = 0; nss < max_nss; nss++) {
 		int mcs;
@@ -1968,9 +1975,8 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 #define EBF_MODE	BIT(0)
 #define IBF_MODE	BIT(1)
 #define BF_MAT_ORDER	4
+	struct mt7996_phy *phy = mt7996_vif_link_phy(link);
 	struct ieee80211_vif *vif = link_conf->vif;
-	struct mt7996_phy *phy = link->phy;
-	int tx_ant = hweight16(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
 	static const u8 matrix[BF_MAT_ORDER][BF_MAT_ORDER] = {
@@ -1979,8 +1985,12 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 		{2, 4, 4, 0},	/* 3x1, 3x2, 3x3, 3x4 */
 		{3, 5, 6, 0}	/* 4x1, 4x2, 4x3, 4x4 */
 	};
+	int tx_ant;
 	bool ebf;
 
+	if (!phy)
+		return;
+
 	if (!(link_sta->ht_cap.ht_supported || link_sta->he_cap.has_he))
 		return;
 
@@ -1996,17 +2006,18 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	 * ht: iBF only, since mac80211 lacks of eBF support
 	 */
 	if (link_sta->eht_cap.has_eht)
-		mt7996_mcu_sta_bfer_eht(link_sta, vif, link->phy, bf, ebf);
+		mt7996_mcu_sta_bfer_eht(link_sta, vif, phy, bf, ebf);
 	else if (link_sta->he_cap.has_he)
-		mt7996_mcu_sta_bfer_he(link_sta, vif, link->phy, bf, ebf);
+		mt7996_mcu_sta_bfer_he(link_sta, vif, phy, bf, ebf);
 	else if (link_sta->vht_cap.vht_supported)
-		mt7996_mcu_sta_bfer_vht(link_sta, link->phy, bf, ebf);
+		mt7996_mcu_sta_bfer_vht(link_sta, phy, bf, ebf);
 	else if (link_sta->ht_cap.ht_supported)
-		mt7996_mcu_sta_bfer_ht(link_sta, link->phy, bf, ebf);
+		mt7996_mcu_sta_bfer_ht(link_sta, phy, bf, ebf);
 	else
 		return;
 
 	bf->bf_cap = ebf ? EBF_MODE : (dev->ibf ? IBF_MODE : 0);
+	tx_ant = hweight16(phy->mt76->chainmask) - 1;
 	if (is_mt7992(&dev->mt76) && tx_ant == 4)
 		bf->bf_cap |= IBF_MODE;
 
@@ -2038,11 +2049,14 @@ mt7996_mcu_sta_bfee_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 			struct ieee80211_link_sta *link_sta,
 			struct mt7996_vif_link *link)
 {
-	struct mt7996_phy *phy = link->phy;
-	int tx_ant = hweight8(phy->mt76->antenna_mask) - 1;
+	struct mt7996_phy *phy = mt7996_vif_link_phy(link);
 	struct sta_rec_bfee *bfee;
 	struct tlv *tlv;
 	u8 nrow = 0;
+	int tx_ant;
+
+	if (!phy)
+		return;
 
 	if (!(link_sta->vht_cap.vht_supported || link_sta->he_cap.has_he))
 		return;
@@ -2066,6 +2080,7 @@ mt7996_mcu_sta_bfee_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	}
 
 	/* reply with identity matrix to avoid 2x2 BF negative gain */
+	tx_ant = hweight8(phy->mt76->antenna_mask) - 1;
 	bfee->fb_identity_matrix = (nrow == 1 && tx_ant == 2);
 }
 
@@ -2249,6 +2264,7 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct mt7996_sta *msta,
 	struct ieee80211_sta *sta;
 	int ret, nrates = 0, idx;
 	enum nl80211_band band;
+	struct mt76_phy *mphy;
 	bool has_he;
 
 #define __sta_phy_bitrate_mask_check(_mcs, _gi, _ht, _he)			\
@@ -2282,7 +2298,11 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct mt7996_sta *msta,
 	if (!link_sta)
 		goto error_unlock;
 
-	band = link->phy->mt76->chandef.chan->band;
+	mphy = mt76_vif_link_phy(&link->mt76);
+	if (!mphy)
+		goto error_unlock;
+
+	band = mphy->chandef.chan->band;
 	has_he = link_sta->he_cap.has_he;
 	mask = link->bitrate_mask;
 	idx = msta_link->wcid.idx;
@@ -2362,18 +2382,25 @@ mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 			     struct mt7996_vif_link *link)
 {
 #define INIT_RCPI 180
-	struct mt76_phy *mphy = link->phy->mt76;
-	struct cfg80211_chan_def *chandef = &mphy->chandef;
+	struct mt76_phy *mphy = mt76_vif_link_phy(&link->mt76);
 	struct cfg80211_bitrate_mask *mask = &link->bitrate_mask;
 	u32 cap = link_sta->sta->wme ? STA_CAP_WMM : 0;
-	enum nl80211_band band = chandef->chan->band;
+	struct cfg80211_chan_def *chandef;
 	struct sta_rec_ra_uni *ra;
+	enum nl80211_band band;
 	struct tlv *tlv;
-	u32 supp_rate = link_sta->supp_rates[band];
+	u32 supp_rate;
+
+	if (!mphy)
+		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra));
 	ra = (struct sta_rec_ra_uni *)tlv;
 
+	chandef = &mphy->chandef;
+	band = chandef->chan->band;
+	supp_rate = link_sta->supp_rates[band];
+
 	ra->valid = true;
 	ra->auto_rate = true;
 	ra->phy_mode = mt76_connac_get_phy_mode(mphy, vif, band, link_sta);
@@ -2722,6 +2749,7 @@ void mt7996_mcu_update_sta_rec_bw(void *data, struct ieee80211_sta *sta)
 {
 	struct mt7996_vif_link *link = (struct mt7996_vif_link *)data;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_phy *phy = mt7996_vif_link_phy(link);
 	struct mt7996_sta_link *msta_link;
 	struct mt7996_dev *dev;
 	struct ieee80211_bss_conf *link_conf;
@@ -2730,10 +2758,13 @@ void mt7996_mcu_update_sta_rec_bw(void *data, struct ieee80211_sta *sta)
 	struct sk_buff *skb;
 	int link_id;
 
+	if (!phy)
+		return;
+
 	if (link->mt76.mvif != &msta->vif->mt76)
 		return;
 
-	dev = link->phy->dev;
+	dev = phy->dev;
 	link_id = link->msta_link.wcid.link_id;
 	link_sta = link_sta_dereference_protected(sta, link_id);
 	if (!link_sta)
@@ -3010,6 +3041,7 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_vif_link *link = mt7996_vif_conf_link(dev, vif, link_conf);
+	struct mt76_phy *mphy = link ? mt76_vif_link_phy(&link->mt76) : NULL;
 	struct mt76_vif_link *mlink = link ? &link->mt76 : NULL;
 	struct ieee80211_mutable_offsets offs;
 	struct ieee80211_tx_info *info;
@@ -3024,7 +3056,7 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (!mlink)
 		return -EINVAL;
 
-	if (link->phy && link->phy->mt76->offchannel)
+	if (mphy && mphy->offchannel)
 		enabled = false;
 
 	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, mlink,
@@ -3075,9 +3107,9 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 {
 #define OFFLOAD_TX_MODE_SU	BIT(0)
 #define OFFLOAD_TX_MODE_MU	BIT(1)
+	struct mt76_phy *mphy = mt76_vif_link_phy(&link->mt76);
 	struct ieee80211_vif *vif = link_conf->vif;
 	struct ieee80211_hw *hw = mt76_hw(dev);
-	struct mt7996_phy *phy = link->phy;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
 	struct bss_inband_discovery_tlv *discov;
 	struct ieee80211_tx_info *info;
@@ -3088,10 +3120,10 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 	u8 *buf, interval;
 	int len;
 
-	if (!phy)
+	if (!mphy)
 		return -EINVAL;
 
-	chandef = &phy->mt76->chandef;
+	chandef = &mphy->chandef;
 	band = chandef->chan->band;
 
 	if (link_conf->nontransmitted)
@@ -3129,7 +3161,7 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 	info = IEEE80211_SKB_CB(skb);
 	info->control.vif = vif;
 	info->band = band;
-	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->mt76->band_idx);
+	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, mphy->band_idx);
 
 	len = ALIGN(sizeof(*discov) + MT_TXD_SIZE + skb->len, 4);
 	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_OFFLOAD, len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index ee3564c0115a36ea592741f34025a9f9f701315c..d18f8794351eca4e3d3b3a314d0ac2fe7a6d8249 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -276,8 +276,6 @@ struct mt7996_vif_link {
 	struct mt76_vif_link mt76; /* must be first */
 
 	struct mt7996_sta_link msta_link;
-	struct mt7996_phy *phy;
-
 	struct cfg80211_bitrate_mask bitrate_mask;
 
 	u8 mld_idx;

-- 
2.53.0


