Return-Path: <linux-wireless+bounces-27302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7679FB5721A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D273B8EDD
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9940E2EA74D;
	Mon, 15 Sep 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="U0h4yRl6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5672E9EB1
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923162; cv=none; b=BlRydVNT9PSCgsx0ejX7XXL0ChgVZ6kWNx7Eg64RsmdQcvuZFNywif2hcjzMoEQYrLw9IMtrviZaMcUFrO70k7Y+JcR/7ILNV8gOR3W5FP5mI7KB1H06xt5Sc2IU9Bs6KnFrcf0V9wNcI5ZyD7oVjaYNGAodW4MR87lvMa0HCtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923162; c=relaxed/simple;
	bh=P3zRRv7p8ejrZhrj3DBEeiG7Qs6qjcMgzAH01oK1Yzg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZnLd3tF5zktEsZsNn/iLhgu+vRYj/v9KddTkdRR9ZTtTY/PaU39Lk49c+0qrGzktTC9YH+Hmi5n2h4HytsOmW3B8OuAQyFEydxYuC45EAWTQOgrzIgOqhITVORKtjH0rtWc1zmSFXvVvN9J+mO0taNCNZTl6SGJ8EgNuRT9AEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=U0h4yRl6; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5Nfo2Ilu3k3chGNEYf6OUmpjN4kAAxJHfUfHHXkaqB4=; b=U0h4yRl6ZV26PPhBrpp2LMdlRa
	vkR/MnrDHeoqmj0twKDrOgDG8nbGgamgkJcFS90K2uTgMc3XF5zvdfG+RRmFJz0GRLuU5T4lledhJ
	uVM8vBaHpJo2/wQq/xSXADWkLcOB4lmq/dTGIZ5zmqe+2n8vq1l22UajLcFxIBPHpxDk=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47E-0078GN-1D
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:12 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 08/15] wifi: mt76: mt7996: fix updating beacon protection with beacons enabled
Date: Mon, 15 Sep 2025 09:59:03 +0200
Message-ID: <20250915075910.47558-8-nbd@nbd.name>
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

Disable and re-enable beacon after beacon protection key change, in order
to fully apply the changes.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 35 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  3 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 +-
 4 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index fd57569a7da7..289f69cc2bdf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2176,7 +2176,8 @@ mt7996_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
 		if (!link || link->phy != phy)
 			continue;
 
-		mt7996_mcu_add_beacon(dev->mt76.hw, vif, link_conf);
+		mt7996_mcu_add_beacon(dev->mt76.hw, vif, link_conf,
+				      link_conf->enable_beacon);
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index d706b8bb244e..581314368c5b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -185,10 +185,13 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		  unsigned int link_id, struct ieee80211_key_conf *key)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct ieee80211_bss_conf *link_conf;
 	struct mt7996_sta_link *msta_link;
 	struct mt7996_vif_link *link;
 	int idx = key->keyidx;
 	u8 *wcid_keyidx;
+	bool is_bigtk;
+	int err;
 
 	link = mt7996_vif_link(dev, vif, link_id);
 	if (!link)
@@ -213,12 +216,13 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	}
 	wcid_keyidx = &msta_link->wcid.hw_key_idx;
 
+	is_bigtk = key->keyidx == 6 || key->keyidx == 7;
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		if (key->keyidx == 6 || key->keyidx == 7) {
+		if (is_bigtk) {
 			wcid_keyidx = &msta_link->wcid.hw_key_idx2;
 			key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
 		}
@@ -227,14 +231,11 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		break;
 	}
 
+	link_conf = link_conf_dereference_protected(vif, link_id);
+	if (!link_conf)
+		link_conf = &vif->bss_conf;
+
 	if (cmd == SET_KEY && !sta && !link->mt76.cipher) {
-		struct ieee80211_bss_conf *link_conf;
-
-		link_conf = link_conf_dereference_protected(vif,
-							    link_id);
-		if (!link_conf)
-			link_conf = &vif->bss_conf;
-
 		link->mt76.cipher =
 			mt76_connac_mcu_get_cipher(key->cipher);
 		mt7996_mcu_add_bss_info(link->phy, vif, link_conf,
@@ -251,9 +252,17 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	mt76_wcid_key_setup(&dev->mt76, &msta_link->wcid, key);
 
-	return mt7996_mcu_add_key(&dev->mt76, vif, key,
-				  MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
-				  &msta_link->wcid, cmd);
+	err = mt7996_mcu_add_key(&dev->mt76, vif, key,
+				 MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
+				 &msta_link->wcid, cmd);
+
+	/* remove and add beacon in order to enable beacon protection */
+	if (cmd == SET_KEY && is_bigtk && link_conf->enable_beacon) {
+		mt7996_mcu_add_beacon(hw, vif, link_conf, false);
+		mt7996_mcu_add_beacon(hw, vif, link_conf, true);
+	}
+
+	return err;
 }
 
 struct mt7996_key_iter_data {
@@ -900,7 +909,7 @@ mt7996_link_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		link->mt76.beacon_rates_idx =
 			mt7996_get_rates_table(phy, info, true, false);
 
-		mt7996_mcu_add_beacon(hw, vif, info);
+		mt7996_mcu_add_beacon(hw, vif, info, info->enable_beacon);
 	}
 
 	if (changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
@@ -928,7 +937,7 @@ mt7996_channel_switch_beacon(struct ieee80211_hw *hw,
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7996_mcu_add_beacon(hw, vif, &vif->bss_conf);
+	mt7996_mcu_add_beacon(hw, vif, &vif->bss_conf, vif->bss_conf.enable_beacon);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 5707e6b59aea..07a1e542571c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2760,7 +2760,7 @@ mt7996_mcu_beacon_cont(struct mt7996_dev *dev,
 }
 
 int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			  struct ieee80211_bss_conf *link_conf)
+			  struct ieee80211_bss_conf *link_conf, bool enabled)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_vif_link *link = mt7996_vif_conf_link(dev, vif, link_conf);
@@ -2771,7 +2771,6 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 	struct bss_bcn_content_tlv *bcn;
 	int len, extra_len = 0;
-	bool enabled = link_conf->enable_beacon;
 
 	if (link_conf->nontransmitted)
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index fa10aa6f517a..8ec2acdb3319 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -682,7 +682,7 @@ int mt7996_mcu_update_bss_color(struct mt7996_dev *dev,
 				struct mt76_vif_link *mlink,
 				struct cfg80211_he_bss_color *he_bss_color);
 int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			  struct ieee80211_bss_conf *link_conf);
+			  struct ieee80211_bss_conf *link_conf, bool enabled);
 int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 				    struct ieee80211_bss_conf *link_conf,
 				    struct mt7996_vif_link *link, u32 changed);
-- 
2.51.0


