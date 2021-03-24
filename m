Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45933473CA
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 09:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhCXIiR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 04:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233906AbhCXIhr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 04:37:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CF1E619EC;
        Wed, 24 Mar 2021 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616575066;
        bh=Q32WzFIKonWf152z79tBkvAbqSFLiyveV8ySiu2cKJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lH4ZO5f9uaHNG8gyWGHSZju8ZkkSpPBdCy6zWRObIdIhQSwUqKx3/gFen+nsFOouy
         Bg1tlCgOzTe7Dt5zagWgachcydrMXaqaxMWr1FEN3DDcE6kAnRo2vN/Y23DDrVmitT
         agPYnzSoC2L9NiN5bDLHOXwcNhkmegQjK0HkudgznfQ+dg4/WRgbpnN1s9yIOZcW2c
         OQR09m0zrPdUNF+di1EV50YrMT9+gaPcc2mY4LbVdkQeYQV2IMjGqmGQ3g8uAG0wzJ
         2XTj9OsXGu+srfHR7ZbXimZTG63UnBz7zIP3BRwqVC2ada0+XPFcrAdJZavv0Tohxw
         7il8UXr/8+afw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Jayden.Kuo@mediatek.com
Subject: [PATCH 1/2] mt76: connac: introduce mt76_sta_cmd_info data structure
Date:   Wed, 24 Mar 2021 09:37:36 +0100
Message-Id: <403c3f01aef2db4902390294a42224f047e88ea8.1616574803.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616574803.git.lorenzo@kernel.org>
References: <cover.1616574803.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_sta_cmd_info data structure to contain parameters passed
to mt76_sta_cmd_info routine. This is preliminary patch to properly
configure rcpi for mt7921 devices.

Tested-by: Jayden.Kuo <jayden.kuo@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 13 ++++---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 35 ++++++++++---------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 19 +++++++---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 19 +++++++---
 4 files changed, 56 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 962a8abbca76..888d9e0d4eca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -979,7 +979,7 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 
 	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable);
 	if (enable && sta)
-		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif);
+		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0);
 
 	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
 						  WTBL_RESET_AND_SET, NULL,
@@ -1077,10 +1077,15 @@ __mt7615_mcu_add_sta(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		     struct ieee80211_sta *sta, bool enable, int cmd)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct mt76_wcid *wcid;
+	struct mt76_sta_cmd_info info = {
+		.sta = sta,
+		.vif = vif,
+		.enable = enable,
+		.cmd = cmd,
+	};
 
-	wcid = sta ? (struct mt76_wcid *)sta->drv_priv : &mvif->sta.wcid;
-	return mt76_connac_mcu_add_sta_cmd(phy, vif, sta, wcid, enable, cmd);
+	info.wcid = sta ? (struct mt76_wcid *)sta->drv_priv : &mvif->sta.wcid;
+	return mt76_connac_mcu_add_sta_cmd(phy, &info);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index e4ef5c86c42e..672d1dd7bd6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -674,7 +674,8 @@ mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_sta *sta,
-			     struct ieee80211_vif *vif)
+			     struct ieee80211_vif *vif,
+			     u8 rcpi)
 {
 	struct cfg80211_chan_def *chandef = &mphy->chandef;
 	enum nl80211_band band = chandef->chan->band;
@@ -723,6 +724,7 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 	phy = (struct sta_rec_phy *)tlv;
 	phy->phy_type = mt76_connac_get_phy_mode_v2(mphy, vif, band, sta);
 	phy->basic_rate = cpu_to_le16((u16)vif->bss_conf.basic_rates);
+	phy->rcpi = rcpi;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra_info));
 	ra_info = (struct sta_rec_ra_info *)tlv;
@@ -827,43 +829,42 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ht_tlv);
 
 int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
-				struct ieee80211_vif *vif,
-				struct ieee80211_sta *sta,
-				struct mt76_wcid *wcid,
-				bool enable, int cmd)
+				struct mt76_sta_cmd_info *info)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif *mvif = (struct mt76_vif *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
 	struct wtbl_req_hdr *wtbl_hdr;
 	struct tlv *sta_wtbl;
 	struct sk_buff *skb;
 
-	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
+	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt76_connac_mcu_sta_basic_tlv(skb, vif, sta, enable);
-	if (enable && sta)
-		mt76_connac_mcu_sta_tlv(phy, skb, sta, vif);
+	mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta, info->enable);
+	if (info->enable && info->sta)
+		mt76_connac_mcu_sta_tlv(phy, skb, info->sta, info->vif,
+					info->rcpi);
 
 	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
 					   sizeof(struct tlv));
 
-	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, wcid,
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, info->wcid,
 						  WTBL_RESET_AND_SET,
 						  sta_wtbl, &skb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
-	if (enable) {
-		mt76_connac_mcu_wtbl_generic_tlv(dev, skb, vif, sta, sta_wtbl,
+	if (info->enable) {
+		mt76_connac_mcu_wtbl_generic_tlv(dev, skb, info->vif,
+						 info->sta, sta_wtbl,
 						 wtbl_hdr);
-		if (sta)
-			mt76_connac_mcu_wtbl_ht_tlv(dev, skb, sta, sta_wtbl,
-						    wtbl_hdr);
+		if (info->sta)
+			mt76_connac_mcu_wtbl_ht_tlv(dev, skb, info->sta,
+						    sta_wtbl, wtbl_hdr);
 	}
 
-	return mt76_mcu_skb_send_msg(dev, skb, cmd, true);
+	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_sta_cmd);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 5b3f2d9bc029..5dedbef2ad07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -953,6 +953,17 @@ struct mt76_connac_tx_power_limit_tlv {
 	u8 pad2[32];
 } __packed;
 
+struct mt76_sta_cmd_info {
+	struct ieee80211_sta *sta;
+	struct mt76_wcid *wcid;
+
+	struct ieee80211_vif *vif;
+
+	bool enable;
+	int cmd;
+	u8 rcpi;
+};
+
 #define to_wcid_lo(id)		FIELD_GET(GENMASK(7, 0), (u16)id)
 #define to_wcid_hi(id)		FIELD_GET(GENMASK(9, 8), (u16)id)
 
@@ -1000,7 +1011,8 @@ void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
 					void *sta_wtbl, void *wtbl_tlv);
 void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_sta *sta,
-			     struct ieee80211_vif *vif);
+			     struct ieee80211_vif *vif,
+			     u8 rcpi);
 void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				 struct ieee80211_sta *sta, void *sta_wtbl,
 				 void *wtbl_tlv);
@@ -1023,10 +1035,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 				struct mt76_wcid *wcid,
 				bool enable);
 int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
-				struct ieee80211_vif *vif,
-				struct ieee80211_sta *sta,
-				struct mt76_wcid *wcid,
-				bool enable, int cmd);
+				struct mt76_sta_cmd_info *info);
 void mt76_connac_mcu_beacon_loss_iter(void *priv, u8 *mac,
 				      struct ieee80211_vif *vif);
 int mt76_connac_mcu_set_rts_thresh(struct mt76_dev *dev, u32 val, u8 band);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index e4f742530382..9db2442fa11f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -634,6 +634,13 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt76_sta_cmd_info info = {
+		.sta = sta,
+		.vif = vif,
+		.enable = true,
+		.cmd = MCU_UNI_CMD_STA_REC_UPDATE,
+		.wcid = &msta->wcid,
+	};
 	int ret, idx;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
@@ -660,8 +667,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	ret = mt76_connac_mcu_add_sta_cmd(&dev->mphy, vif, sta, &msta->wcid,
-					  true, MCU_UNI_CMD_STA_REC_UPDATE);
+	ret = mt76_connac_mcu_add_sta_cmd(&dev->mphy, &info);
 	if (ret)
 		return ret;
 
@@ -675,12 +681,17 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt76_sta_cmd_info info = {
+		.sta = sta,
+		.vif = vif,
+		.cmd = MCU_UNI_CMD_STA_REC_UPDATE,
+		.wcid = &msta->wcid,
+	};
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
-	mt76_connac_mcu_add_sta_cmd(&dev->mphy, vif, sta, &msta->wcid, false,
-				    MCU_UNI_CMD_STA_REC_UPDATE);
+	mt76_connac_mcu_add_sta_cmd(&dev->mphy, &info);
 
 	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-- 
2.30.2

