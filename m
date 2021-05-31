Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92DD39557F
	for <lists+linux-wireless@lfdr.de>; Mon, 31 May 2021 08:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhEaGfF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 02:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhEaGfD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 02:35:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A622D60241;
        Mon, 31 May 2021 06:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622442803;
        bh=msFzLWwwh1Ulc47nPnwkM1sfXwQxdpKaFnvhlACc3Do=;
        h=From:To:Cc:Subject:Date:From;
        b=HtjoNvX+5Ckp6Z5CZYHFM80Ca2YC+NdOF4piLBKP792aVBCntuHfG0zATvA+Wa7Nl
         MwEI7z9W5V9KGYx6o0bvHd2syjuuks92wPWTZDhUEbc/ed0wqY5339vg5SHp6DJEv2
         WBp5HO+/ulk2JSAjRubsVMOMJ6rg0WL7DDTBKCCbIZbujs4rKJ69sGuvO+vsuklmuW
         9xsG/T8FHccxFEO48/qSdQHa5bMivX48cp/NWWdrxSmFIjkRFnAL26iNfnQbZaaA2M
         9bqqw5BtmSd1FrkkFezyihM3DpCZLH5+U8MkhS6RSYD8uRe72lk/geznf+ncuAAoOQ
         4ThEdvuZ3XVIw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        deren.wu@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: enable hw offloading for wep keys
Date:   Mon, 31 May 2021 08:33:18 +0200
Message-Id: <7a8326eb7648f5e617e429484142ed948cbc8647.1622442697.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable wep key hw offloading for sta mode. This patch fixes
WoW support for wep connections.

Tested-by: Deren.Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 22 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 472afd4ea487..84930ad5ebc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -377,6 +377,10 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
 		wcid_keyidx = &wcid->hw_key_idx2;
 		break;
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+		if (!mvif->wep_sta)
+			return -EOPNOTSUPP;
 	case WLAN_CIPHER_SUITE_TKIP:
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_CCMP_256:
@@ -384,8 +388,6 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	case WLAN_CIPHER_SUITE_GCMP_256:
 	case WLAN_CIPHER_SUITE_SMS4:
 		break;
-	case WLAN_CIPHER_SUITE_WEP40:
-	case WLAN_CIPHER_SUITE_WEP104:
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -403,6 +405,12 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			    cmd == SET_KEY ? key : NULL);
 
 	err = mt7921_mcu_add_key(dev, vif, msta, key, cmd);
+	if (err)
+		goto out;
+
+	if (key->cipher == WLAN_CIPHER_SUITE_WEP104 ||
+	    key->cipher == WLAN_CIPHER_SUITE_WEP40)
+		err = mt7921_mcu_add_key(dev, vif, mvif->wep_sta, key, cmd);
 out:
 	mt7921_mutex_release(dev);
 
@@ -609,9 +617,12 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
-	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
-		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
-					    true);
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		mvif->wep_sta = msta;
+		if (!sta->tdls)
+			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
+						    &mvif->sta.wcid, true);
+	}
 
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -641,6 +652,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 
+		mvif->wep_sta = NULL;
 		ewma_rssi_init(&mvif->rssi);
 		if (!sta->tdls)
 			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index a9b21fcc321c..30902231a4bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -102,6 +102,8 @@ struct mt7921_vif {
 	struct mt76_vif mt76; /* must be first */
 
 	struct mt7921_sta sta;
+	struct mt7921_sta *wep_sta;
+
 	struct mt7921_phy *phy;
 
 	struct ewma_rssi rssi;
-- 
2.31.1

