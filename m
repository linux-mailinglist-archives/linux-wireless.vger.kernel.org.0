Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD547EE5D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 11:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352498AbhLXK6f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 05:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbhLXK6e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 05:58:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67183C061401
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 02:58:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7097DB82288
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 10:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F330C36AE8;
        Fri, 24 Dec 2021 10:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640343511;
        bh=qavknFH/KVS9mxRiBPZaq25DGpDA8S1mdcuQfK2nGYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ltdh0ewZ0aNh42A7zfFzZxEkUH1FKcMJURoyrpgHXti45YkPruAnd1QFpxOUMGhuN
         okwycFO2IEiElyh8QwAiIbGNbfzlxxEFo8abCtIDOn+++d6ajRZExFndLv0Ktv9+lI
         6IzFbHBua/Fnjr+tAliI8Ev1W9lWFW7q+C/o3sjLpipkWMBaVKaF0r8RbN2OS2Yz1I
         BemXKv2M/Qy+TWrHA1KpWQuZoJe7nw4X+C24gBuAvpQRrlvN92BvwzVCjeTzeMh1uR
         Dmude+nQFJrqyIeQ3jkSAukxlNoUFbWbecc7tnrBjNw6ojdPLhVW6XCNzAz3qOrcqQ
         nW1nHs1I92ezg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 01/10] mt76: connac: introduce is_connac_v1 utility routine
Date:   Fri, 24 Dec 2021 11:58:02 +0100
Message-Id: <10564e6d4040a5c4a408bd96e59d9104c13ccf20.1640342400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640342400.git.lorenzo@kernel.org>
References: <cover.1640342400.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce is_connac_v1 inline utility routine to check if the device is
generation v1.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 18 ---------------
 .../net/wireless/mediatek/mt76/mt76_connac.h  | 23 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 11 ++++-----
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 +-
 4 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 6ff6d5800918..07b833654920 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -409,24 +409,6 @@ int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev);
 int mt7615_mcu_fw_log_2_host(struct mt7615_dev *dev, u8 ctrl);
 
-static inline bool is_mt7622(struct mt76_dev *dev)
-{
-	if (!IS_ENABLED(CONFIG_MT7622_WMAC))
-		return false;
-
-	return mt76_chip(dev) == 0x7622;
-}
-
-static inline bool is_mt7615(struct mt76_dev *dev)
-{
-	return mt76_chip(dev) == 0x7615 || mt76_chip(dev) == 0x7611;
-}
-
-static inline bool is_mt7611(struct mt76_dev *dev)
-{
-	return mt76_chip(dev) == 0x7611;
-}
-
 static inline void mt7615_irq_enable(struct mt7615_dev *dev, u32 mask)
 {
 	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 8701f04a28e3..426adbb56a2d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -115,6 +115,29 @@ static inline bool is_mt7916(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7906;
 }
 
+static inline bool is_mt7622(struct mt76_dev *dev)
+{
+	if (!IS_ENABLED(CONFIG_MT7622_WMAC))
+		return false;
+
+	return mt76_chip(dev) == 0x7622;
+}
+
+static inline bool is_mt7615(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7615 || mt76_chip(dev) == 0x7611;
+}
+
+static inline bool is_mt7611(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7611;
+}
+
+static inline bool is_connac_v1(struct mt76_dev *dev)
+{
+	return is_mt7615(dev) || is_mt7663(dev) || is_mt7622(dev);
+}
+
 static inline u8 mt76_connac_chan_bw(struct cfg80211_chan_def *chandef)
 {
 	static const u8 width_to_bw[] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 33ea01486035..142017457f72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -553,8 +553,7 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 		generic->muar_idx = mvif->omac_idx;
 		generic->qos = sta->wme;
 	} else {
-		if ((is_mt7921(dev) || is_mt7915(dev)) &&
-		    vif->type == NL80211_IFTYPE_STATION)
+		if (!is_connac_v1(dev) && vif->type == NL80211_IFTYPE_STATION)
 			memcpy(generic->peer_addr, vif->bss_conf.bssid,
 			       ETH_ALEN);
 		else
@@ -571,7 +570,7 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 	rx->rca2 = 1;
 	rx->rv = 1;
 
-	if (is_mt7921(dev) || is_mt7915(dev))
+	if (!is_connac_v1(dev))
 		return;
 
 	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_SPE, sizeof(*spe),
@@ -937,7 +936,7 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 
 	mt76_connac_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
 
-	if (!is_mt7921(dev) && !is_mt7915(dev) && sta->ht_cap.ht_supported) {
+	if (is_connac_v1(dev) && sta->ht_cap.ht_supported) {
 		/* sgi */
 		u32 msk = MT_WTBL_W5_SHORT_GI_20 | MT_WTBL_W5_SHORT_GI_40 |
 			  MT_WTBL_W5_SHORT_GI_80 | MT_WTBL_W5_SHORT_GI_160;
@@ -1039,7 +1038,7 @@ void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		ba->rst_ba_sb = 1;
 	}
 
-	if (is_mt7921(dev) || is_mt7915(dev)) {
+	if (!is_connac_v1(dev)) {
 		ba->ba_winsize = enable ? cpu_to_le16(params->buf_size) : 0;
 		return;
 	}
@@ -1218,7 +1217,7 @@ u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	struct ieee80211_sta_ht_cap *ht_cap;
 	u8 mode = 0;
 
-	if (!is_mt7921(dev) && !is_mt7915(dev))
+	if (is_connac_v1(dev))
 		return 0x38;
 
 	if (sta) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 2c41d81c230e..0908d30552d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1464,7 +1464,7 @@ mt76_connac_mcu_get_wlan_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
 {
 	*wlan_idx_hi = 0;
 
-	if (is_mt7921(dev) || is_mt7915(dev) || is_mt7916(dev)) {
+	if (!is_connac_v1(dev)) {
 		*wlan_idx_lo = wcid ? to_wcid_lo(wcid->idx) : 0;
 		*wlan_idx_hi = wcid ? to_wcid_hi(wcid->idx) : 0;
 	} else {
-- 
2.33.1

