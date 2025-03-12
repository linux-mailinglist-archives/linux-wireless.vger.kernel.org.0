Return-Path: <linux-wireless+bounces-20235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED1A5DB2C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEAE7AB13C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA18523ED58;
	Wed, 12 Mar 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A56H0O3/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571322DFB5
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778064; cv=none; b=tQZMJCKGjbHjjiU3ev1W3/WBF9FiCyO4rxuhx84nIcjBSu5Il85Yt1Htuexw1k/g1IZMvroV8mt3mBcNG2V6SVTK3nRqUTmBb5MxeXrLMXBIl+BZtqcb75gqqqYj9cuz8Nzr4a8hWMRo4Y1LFb166EjjBnAKgQy2jyKIPehfQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778064; c=relaxed/simple;
	bh=Aibburdx4pDXw2h3KcFUvqvn1IC2b4XNGqhG/GlGhKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KoZEo1NPH9ARLTtGor5MRHAya7KFmlHdvMt040nkqxQRZpGh2Y8j6G3ZIfCx7vTkcqzfW8wcw9+CQhCyBrEOH3PEHBR7aW783alqamKFVX6VGsjiq3QDdYffhzBZj8ZNIV2FJflAskMvOv/dOCv6goKL2YmAVEMgOMJIuZEE7Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A56H0O3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD41C4CEE3;
	Wed, 12 Mar 2025 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778064;
	bh=Aibburdx4pDXw2h3KcFUvqvn1IC2b4XNGqhG/GlGhKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A56H0O3/vtjwF23/FqpuTzUSh1Bg+nmGmPp/dscRt18NL15Fe3l8S2nkAyEIKKiX0
	 vF7sl6s3xxtBe39ajZequ/hUvpV+ZJsZM7QkBLbeyID2l1Z6pGnU+T1+dbJa1izQYh
	 q/tuJLDyBJMVMYOFcSPmE5cL7WstKJ3t0PFoWzfAvg/yd7QVBsfGiAk4rDabIK80/M
	 DKMmyODBOVdaSXtxWnTdkJ4jA1V6Kum06epfag9Xwl0aBJ3ChafP64iC1ZqnsDmEFk
	 M1gY/CpreKyX/jNeLN9CyA1Ns6h9HWrMzy1/8jJuM+ixfqWJ5JQUJVdaCmiS6Oql+B
	 IxKjI3ArvztJA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:13:53 +0100
Subject: [PATCH 09/21] wifi: mt76: mt7996: rework mt7996_set_hw_key to
 support MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-9-015b3d6fd928@kernel.org>
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

Modify mt7996_set_hw_key routine to work in a multi-link setup.
This is a preliminary patch to enable MLO for MT7996 driver

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 138 +++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  18 +--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   4 +-
 3 files changed, 99 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 4abbe761b732f1ea7791ba1f86c2c87db1eea91d..a845c3e758adcc4802f704a99ac39aa9ca670c88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -158,62 +158,101 @@ mt7996_init_bitrate_mask(struct ieee80211_vif *vif, struct mt7996_vif_link *mlin
 static int
 mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
-		  struct mt7996_vif_link *mlink, struct ieee80211_key_conf *key)
+		  struct ieee80211_key_conf *key)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt76_wcid *wcid = &mlink->msta_link.wcid;
-	struct mt7996_phy *phy;
 	int idx = key->keyidx;
-	u8 *wcid_keyidx;
+	unsigned int link_id;
+	unsigned long links;
+
+	if (key->link_id >= 0)
+		links = BIT(key->link_id);
+	else if (sta && sta->valid_links)
+		links = sta->valid_links;
+	else if (vif->valid_links)
+		links = vif->valid_links;
+	else
+		links = BIT(0);
 
-	phy = mt7996_vif_link_phy(mlink);
-	if (!phy)
-		return -EINVAL;
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct mt7996_sta_link *msta_link;
+		struct mt7996_vif_link *link;
+		u8 *wcid_keyidx;
+		int err;
 
-	if (sta) {
-		struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link)
+			continue;
 
-		wcid = &msta->deflink.wcid;
-		if (!wcid->sta)
-			return -EOPNOTSUPP;
-	}
-	wcid_keyidx = &wcid->hw_key_idx;
+		if (sta) {
+			struct mt7996_sta *msta;
 
-	switch (key->cipher) {
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		if (key->keyidx == 6 || key->keyidx == 7) {
-			wcid_keyidx = &wcid->hw_key_idx2;
-			key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+			msta = (struct mt7996_sta *)sta->drv_priv;
+			msta_link = mt76_dereference(msta->link[link_id],
+						     &dev->mt76);
+			if (!msta_link)
+				continue;
+
+			if (!msta_link->wcid.sta)
+				return -EOPNOTSUPP;
+		} else {
+			msta_link = &link->msta_link;
+		}
+		wcid_keyidx = &msta_link->wcid.hw_key_idx;
+
+		switch (key->cipher) {
+		case WLAN_CIPHER_SUITE_AES_CMAC:
+		case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+		case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+		case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+			if (key->keyidx == 6 || key->keyidx == 7) {
+				wcid_keyidx = &msta_link->wcid.hw_key_idx2;
+				key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+			}
+			break;
+		default:
+			break;
 		}
-		break;
-	default:
-		break;
-	}
 
-	if (cmd == SET_KEY && !sta && !mlink->mt76.cipher) {
-		mlink->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
-		mt7996_mcu_add_bss_info(phy, vif, &vif->bss_conf, &mlink->mt76,
-					&mlink->msta_link, true);
-	}
+		if (cmd == SET_KEY && !sta && !link->mt76.cipher) {
+			struct ieee80211_bss_conf *link_conf;
 
-	if (cmd == SET_KEY) {
-		*wcid_keyidx = idx;
-	} else {
-		if (idx == *wcid_keyidx)
-			*wcid_keyidx = -1;
-		return 0;
-	}
+			link_conf = link_conf_dereference_protected(vif,
+								    link_id);
+			if (!link_conf)
+				link_conf = &vif->bss_conf;
 
-	mt76_wcid_key_setup(&dev->mt76, wcid, key);
+			link->mt76.cipher =
+				mt76_connac_mcu_get_cipher(key->cipher);
+			mt7996_mcu_add_bss_info(link->phy, vif, link_conf,
+						&link->mt76, msta_link, true);
+		}
 
-	if (key->keyidx == 6 || key->keyidx == 7)
-		return mt7996_mcu_bcn_prot_enable(dev, vif, key);
+		if (cmd == SET_KEY) {
+			*wcid_keyidx = idx;
+		} else {
+			if (idx == *wcid_keyidx)
+				*wcid_keyidx = -1;
+			continue;
+		}
 
-	return mt7996_mcu_add_key(&dev->mt76, vif, key,
-				  MCU_WMWA_UNI_CMD(STA_REC_UPDATE), wcid, cmd);
+		mt76_wcid_key_setup(&dev->mt76, &msta_link->wcid, key);
+
+		if (key->keyidx == 6 || key->keyidx == 7) {
+			err = mt7996_mcu_bcn_prot_enable(dev, link,
+							 msta_link, key);
+			if (err)
+				return err;
+		}
+
+		err = mt7996_mcu_add_key(&dev->mt76, vif, key,
+					 MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
+					 &msta_link->wcid, cmd);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static void
@@ -221,12 +260,10 @@ mt7996_key_iter(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta, struct ieee80211_key_conf *key,
 		void *data)
 {
-	struct mt7996_vif_link *mlink = data;
-
 	if (sta)
 		return;
 
-	WARN_ON(mt7996_set_hw_key(hw, SET_KEY, vif, NULL, mlink, key));
+	WARN_ON(mt7996_set_hw_key(hw, SET_KEY, vif, NULL, key));
 }
 
 int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
@@ -298,7 +335,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 				   CONN_STATE_PORT_SECURE, true);
 	rcu_assign_pointer(dev->mt76.wcid[idx], &msta_link->wcid);
 
-	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, link);
+	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, NULL);
 
 	return 0;
 }
@@ -486,7 +523,6 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_vif_link *mlink = &mvif->deflink;
 	int err;
 
 	/* The hardware does not support per-STA RX GTK, fallback
@@ -521,11 +557,11 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		return -EOPNOTSUPP;
 	}
 
-	if (!mt7996_vif_link_phy(mlink))
-	    return 0; /* defer until after link add */
+	if (!mt7996_vif_link_phy(&mvif->deflink))
+		return 0; /* defer until after link add */
 
 	mutex_lock(&dev->mt76.mutex);
-	err = mt7996_set_hw_key(hw, cmd, vif, sta, mlink, key);
+	err = mt7996_set_hw_key(hw, cmd, vif, sta, key);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index d1a0dd4698fbe5cf248796ed6f13b99f3c191af1..b9f689436bfd3859e01ff7025a1f77cec8348824 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2430,18 +2430,17 @@ int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
 }
 
-static int mt7996_mcu_get_pn(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-			     u8 *pn)
+static int mt7996_mcu_get_pn(struct mt7996_dev *dev,
+			     struct mt7996_vif_link *link,
+			     struct mt7996_sta_link *msta_link, u8 *pn)
 {
 #define TSC_TYPE_BIGTK_PN 2
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_sta_link *msta_link = &mvif->deflink.msta_link;
 	struct sta_rec_pn_info *pn_info;
 	struct sk_buff *skb, *rskb;
 	struct tlv *tlv;
 	int ret;
 
-	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &link->mt76,
 					    &msta_link->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -2466,10 +2465,11 @@ static int mt7996_mcu_get_pn(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	return 0;
 }
 
-int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev,
+			       struct mt7996_vif_link *link,
+			       struct mt7996_sta_link *msta_link,
 			       struct ieee80211_key_conf *key)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_mcu_bcn_prot_tlv *bcn_prot;
 	struct sk_buff *skb;
 	struct tlv *tlv;
@@ -2478,7 +2478,7 @@ int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev, struct ieee80211_vif *vif
 		  sizeof(struct mt7996_mcu_bcn_prot_tlv);
 	int ret;
 
-	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->deflink.mt76, len);
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &link->mt76, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -2486,7 +2486,7 @@ int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev, struct ieee80211_vif *vif
 
 	bcn_prot = (struct mt7996_mcu_bcn_prot_tlv *)tlv;
 
-	ret = mt7996_mcu_get_pn(dev, vif, pn);
+	ret = mt7996_mcu_get_pn(dev, link, msta_link, pn);
 	if (ret) {
 		dev_kfree_skb(skb);
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 4d5ab3f4b78ee6fc584370372fe34b44292e4594..1e79757b7a5197426438532a2f0c39e54d6ebae5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -746,7 +746,9 @@ bool mt7996_debugfs_rx_log(struct mt7996_dev *dev, const void *data, int len);
 int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		       struct ieee80211_key_conf *key, int mcu_cmd,
 		       struct mt76_wcid *wcid, enum set_key_cmd cmd);
-int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev,
+			       struct mt7996_vif_link *link,
+			       struct mt7996_sta_link *msta_link,
 			       struct ieee80211_key_conf *key);
 int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 				     struct ieee80211_vif *vif,

-- 
2.48.1


