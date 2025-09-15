Return-Path: <linux-wireless+bounces-27299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 187F5B57217
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCDE1899E12
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954262EA175;
	Mon, 15 Sep 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="gLyaUc3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB502E9EC6
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923161; cv=none; b=tr1L5LvOE2GQfMMZ9ksC/JbblbV8/nKbc/SB2mMyAeg25IZXBrd+EQKXf9enYRRSAj7nfq4XdiLmW/CkcOvoUqGPeFm0Yf8j5sD5y/goiaNjuwlaSEjDPNPL9LDCApSZ86950dQctsjbMGs9cWqSEvHZvK4xGG1CzEidIbMyGvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923161; c=relaxed/simple;
	bh=Fb67vUPNRgzl/ttQWI7ip4fRSLoFTHw7p0IY/CaTG8E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUIQ1QMqEfWblX+RXZ6aFW3NFdYxSfZ83md0GJSVmA3w/XPbK/6G9X02p42B5pZZinpVD4cLQb5VSBbxNRn0aJYYir6au50itrWgp7wBmrQ7TGnixxAB2RH+siacnlmOoDkTSeenlEjdLkrhPacep2rKd1w8InUXRPAqpxXtBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=gLyaUc3D; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rZ6rdNoopVMfHbq4pDPy5hMoaztIMYOJCPPNglkMIFc=; b=gLyaUc3DWUAjZCpJ/MwqIUjXMJ
	T5LolOFjzc3zM2VJxHXi8cUAydRRanTlxnYO71B3et+Cz6kwFhDkMsJgb/sfCiPVkZPitKy1UfpYQ
	qWV4txYZZrIscJ4bMGtCOG5JVtIv6D3Rs5cgamAJZxSZI1ggEbbXdA39BcX2uqoKM+Ik=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47E-0078GN-0c
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:12 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 07/15] wifi: mt76: mt7996: fix key add/remove imbalance
Date: Mon, 15 Sep 2025 09:59:02 +0200
Message-ID: <20250915075910.47558-7-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915075910.47558-1-nbd@nbd.name>
References: <20250915075910.47558-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that a key for a link is only added and removed once.
When bringing up a link, only upload keys for that particular link, instead
of iterating over all of them.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 183 +++++++++---------
 1 file changed, 95 insertions(+), 88 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index a81f2133cdc9..d706b8bb244e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -182,107 +182,96 @@ mt7996_init_bitrate_mask(struct ieee80211_vif *vif, struct mt7996_vif_link *mlin
 static int
 mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
-		  struct ieee80211_key_conf *key)
+		  unsigned int link_id, struct ieee80211_key_conf *key)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_sta_link *msta_link;
+	struct mt7996_vif_link *link;
 	int idx = key->keyidx;
-	unsigned int link_id;
-	unsigned long links;
+	u8 *wcid_keyidx;
 
-	if (key->link_id >= 0)
-		links = BIT(key->link_id);
-	else if (sta && sta->valid_links)
-		links = sta->valid_links;
-	else if (vif->valid_links)
-		links = vif->valid_links;
-	else
-		links = BIT(0);
+	link = mt7996_vif_link(dev, vif, link_id);
+	if (!link)
+		return 0;
 
-	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct mt7996_sta_link *msta_link;
-		struct mt7996_vif_link *link;
-		u8 *wcid_keyidx;
-		int err;
+	if (!mt7996_vif_link_phy(link))
+		return 0;
 
-		link = mt7996_vif_link(dev, vif, link_id);
-		if (!link)
-			continue;
+	if (sta) {
+		struct mt7996_sta *msta;
 
-		if (sta) {
-			struct mt7996_sta *msta;
+		msta = (struct mt7996_sta *)sta->drv_priv;
+		msta_link = mt76_dereference(msta->link[link_id],
+					     &dev->mt76);
+		if (!msta_link)
+			return 0;
 
-			msta = (struct mt7996_sta *)sta->drv_priv;
-			msta_link = mt76_dereference(msta->link[link_id],
-						     &dev->mt76);
-			if (!msta_link)
-				continue;
+		if (!msta_link->wcid.sta)
+			return -EOPNOTSUPP;
+	} else {
+		msta_link = &link->msta_link;
+	}
+	wcid_keyidx = &msta_link->wcid.hw_key_idx;
 
-			if (!msta_link->wcid.sta)
-				return -EOPNOTSUPP;
-		} else {
-			msta_link = &link->msta_link;
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		if (key->keyidx == 6 || key->keyidx == 7) {
+			wcid_keyidx = &msta_link->wcid.hw_key_idx2;
+			key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
 		}
-		wcid_keyidx = &msta_link->wcid.hw_key_idx;
-
-		switch (key->cipher) {
-		case WLAN_CIPHER_SUITE_AES_CMAC:
-		case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-		case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-		case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-			if (key->keyidx == 6 || key->keyidx == 7) {
-				wcid_keyidx = &msta_link->wcid.hw_key_idx2;
-				key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
-			}
-			break;
-		default:
-			break;
-		}
-
-		if (cmd == SET_KEY && !sta && !link->mt76.cipher) {
-			struct ieee80211_bss_conf *link_conf;
-
-			link_conf = link_conf_dereference_protected(vif,
-								    link_id);
-			if (!link_conf)
-				link_conf = &vif->bss_conf;
-
-			link->mt76.cipher =
-				mt76_connac_mcu_get_cipher(key->cipher);
-			mt7996_mcu_add_bss_info(link->phy, vif, link_conf,
-						&link->mt76, msta_link, true);
-		}
-
-		if (cmd == SET_KEY)
-			*wcid_keyidx = idx;
-		else if (idx == *wcid_keyidx)
-			*wcid_keyidx = -1;
-
-		if (cmd != SET_KEY && sta)
-			continue;
-
-		mt76_wcid_key_setup(&dev->mt76, &msta_link->wcid, key);
-
-		err = mt7996_mcu_add_key(&dev->mt76, vif, key,
-					 MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
-					 &msta_link->wcid, cmd);
-		if (err)
-			return err;
+		break;
+	default:
+		break;
 	}
 
-	return 0;
+	if (cmd == SET_KEY && !sta && !link->mt76.cipher) {
+		struct ieee80211_bss_conf *link_conf;
+
+		link_conf = link_conf_dereference_protected(vif,
+							    link_id);
+		if (!link_conf)
+			link_conf = &vif->bss_conf;
+
+		link->mt76.cipher =
+			mt76_connac_mcu_get_cipher(key->cipher);
+		mt7996_mcu_add_bss_info(link->phy, vif, link_conf,
+					&link->mt76, msta_link, true);
+	}
+
+	if (cmd == SET_KEY)
+		*wcid_keyidx = idx;
+	else if (idx == *wcid_keyidx)
+		*wcid_keyidx = -1;
+
+	if (cmd != SET_KEY && sta)
+		return 0;
+
+	mt76_wcid_key_setup(&dev->mt76, &msta_link->wcid, key);
+
+	return mt7996_mcu_add_key(&dev->mt76, vif, key,
+				  MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
+				  &msta_link->wcid, cmd);
 }
 
+struct mt7996_key_iter_data {
+    enum set_key_cmd cmd;
+    unsigned int link_id;
+};
+
 static void
 mt7996_key_iter(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta, struct ieee80211_key_conf *key,
 		void *data)
 {
-	enum set_key_cmd *cmd = data;
+	struct mt7996_key_iter_data *it = data;
 
 	if (sta)
 		return;
 
-	WARN_ON(mt7996_set_hw_key(hw, *cmd, vif, NULL, key));
+	WARN_ON(mt7996_set_hw_key(hw, it->cmd, vif, NULL, it->link_id, key));
 }
 
 int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
@@ -293,9 +282,12 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta_link *msta_link = &link->msta_link;
 	struct mt7996_phy *phy = mphy->priv;
-	enum set_key_cmd key_cmd = SET_KEY;
 	struct mt7996_dev *dev = phy->dev;
 	u8 band_idx = phy->mt76->band_idx;
+	struct mt7996_key_iter_data it = {
+		.cmd = SET_KEY,
+		.link_id = link_conf->link_id,
+	};
 	struct mt76_txq *mtxq;
 	int mld_idx, idx, ret;
 
@@ -373,7 +365,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 				   CONN_STATE_PORT_SECURE, true);
 	rcu_assign_pointer(dev->mt76.wcid[idx], &msta_link->wcid);
 
-	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &key_cmd);
+	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
 
 	if (mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED)
 		mvif->mt76.deflink_id = link_conf->link_id;
@@ -388,12 +380,15 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta_link *msta_link = &link->msta_link;
-	enum set_key_cmd key_cmd = DISABLE_KEY;
 	struct mt7996_phy *phy = mphy->priv;
 	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_key_iter_data it = {
+		.cmd = SET_KEY,
+		.link_id = link_conf->link_id,
+	};
 	int idx = msta_link->wcid.idx;
 
-	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &key_cmd);
+	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
 
 	mt7996_mcu_add_sta(dev, link_conf, NULL, link, NULL,
 			   CONN_STATE_DISCONNECT, false);
@@ -594,8 +589,9 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_key_conf *key)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	int err;
+	unsigned int link_id;
+	unsigned long links;
+	int err = 0;
 
 	/* The hardware does not support per-STA RX GTK, fallback
 	 * to software mode for these.
@@ -629,11 +625,22 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		return -EOPNOTSUPP;
 	}
 
-	if (!mt7996_vif_link_phy(&mvif->deflink))
-		return 0; /* defer until after link add */
-
 	mutex_lock(&dev->mt76.mutex);
-	err = mt7996_set_hw_key(hw, cmd, vif, sta, key);
+
+	if (key->link_id >= 0)
+		links = BIT(key->link_id);
+	else if (sta && sta->valid_links)
+		links = sta->valid_links;
+	else if (vif->valid_links)
+		links = vif->valid_links;
+	else
+		links = BIT(0);
+
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		err = mt7996_set_hw_key(hw, cmd, vif, sta, link_id, key);
+		if (err)
+			break;
+	}
 	mutex_unlock(&dev->mt76.mutex);
 
 	return err;
-- 
2.51.0


