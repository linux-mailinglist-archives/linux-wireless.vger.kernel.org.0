Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C32397D08
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 01:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhFAXbB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 19:31:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38558 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235137AbhFAXbB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 19:31:01 -0400
X-UUID: a6fe5b76ac224fceb111e6d586737761-20210602
X-UUID: a6fe5b76ac224fceb111e6d586737761-20210602
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 302526353; Wed, 02 Jun 2021 07:29:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Jun 2021 07:29:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 07:29:13 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/3] mt76: connac: add mt76_connac_mcu_update_sta_cmd support
Date:   Wed, 2 Jun 2021 07:29:09 +0800
Message-ID: <37cd2b61bfeeb4fd6c14bd3eb2ff611d6b127e1a.1622589640.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add mt76_connac_mcu_update_sta_cmd support that is the prerequisite patch
for we are able to update the station record with the current state the
station has into the offload firmware at runtime.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  6 ++--
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 32 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 16 ++++++++--
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  8 +++--
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  3 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +-
 6 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index fc9cd8da2a11..3352c3559c09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1024,9 +1024,10 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	if (IS_ERR(sskb))
 		return PTR_ERR(sskb);
 
-	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable);
+	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable, true);
 	if (enable && sta)
-		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0);
+		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0,
+					MT76_STA_INFO_STATE_3);
 
 	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
 						  WTBL_RESET_AND_SET, NULL,
@@ -1152,6 +1153,7 @@ __mt7615_mcu_add_sta(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		.vif = vif,
 		.enable = enable,
 		.cmd = cmd,
+		.state = MT76_STA_INFO_STATE_3,
 	};
 
 	info.wcid = sta ? (struct mt76_wcid *)sta->drv_priv : &mvif->sta.wcid;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 73359defa176..c49e4763fa4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -304,7 +304,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_alloc_wtbl_req);
 void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
-				   bool enable)
+				   bool enable, bool newly)
 {
 	struct sta_rec_basic *basic;
 	struct tlv *tlv;
@@ -316,7 +316,8 @@ void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
 	basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
 
 	if (enable) {
-		basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
+		if (newly)
+			basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
 		basic->conn_state = CONN_STATE_PORT_SECURE;
 	} else {
 		basic->conn_state = CONN_STATE_DISCONNECT;
@@ -709,7 +710,7 @@ mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_sta *sta,
 			     struct ieee80211_vif *vif,
-			     u8 rcpi)
+			     u8 rcpi, u8 sta_state)
 {
 	struct cfg80211_chan_def *chandef = &mphy->chandef;
 	enum nl80211_band band = chandef->chan->band;
@@ -770,7 +771,7 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_STATE, sizeof(*state));
 	state = (struct sta_rec_state *)tlv;
-	state->state = 2;
+	state->state = sta_state;
 
 	if (sta->vht_cap.vht_supported) {
 		state->vht_opmode = sta->bandwidth;
@@ -862,8 +863,9 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ht_tlv);
 
-int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
-				struct mt76_sta_cmd_info *info)
+static int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
+				   struct mt76_sta_cmd_info *info,
+				   bool newly)
 {
 	struct mt76_vif *mvif = (struct mt76_vif *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
@@ -875,10 +877,11 @@ int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta, info->enable);
+	mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta, info->enable,
+				      newly);
 	if (info->enable && info->sta)
 		mt76_connac_mcu_sta_tlv(phy, skb, info->sta, info->vif,
-					info->rcpi);
+					info->rcpi, info->state);
 
 	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
 					   sizeof(struct tlv));
@@ -902,8 +905,21 @@ int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
 
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
 }
+
+int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
+				struct mt76_sta_cmd_info *info)
+{
+	return mt76_connac_mcu_sta_cmd(phy, info, true);
+}
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_sta_cmd);
 
+int mt76_connac_mcu_update_sta_cmd(struct mt76_phy *phy,
+				   struct mt76_sta_cmd_info *info)
+{
+	return mt76_connac_mcu_sta_cmd(phy, info, false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_update_sta_cmd);
+
 void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				 struct ieee80211_ampdu_params *params,
 				 bool enable, bool tx, void *sta_wtbl,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index d64b8058b744..6666507f43ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -902,6 +902,14 @@ struct mt76_connac_suspend_tlv {
 	u8 pad[5];
 } __packed;
 
+ /* 0: state 1 - unauthenticated & unassociated
+  * 1: state 2 - authenticated & unassociated
+  * 2: state 3 - authenticated & associated
+  */
+#define MT76_STA_INFO_STATE_1	0
+#define MT76_STA_INFO_STATE_2	1
+#define MT76_STA_INFO_STATE_3	2
+
 struct mt76_sta_cmd_info {
 	struct ieee80211_sta *sta;
 	struct mt76_wcid *wcid;
@@ -911,6 +919,7 @@ struct mt76_sta_cmd_info {
 	bool enable;
 	int cmd;
 	u8 rcpi;
+	u8 state;
 };
 
 #define MT_SKU_POWER_LIMIT	161
@@ -980,7 +989,8 @@ int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy);
 int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif);
 void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
 				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta, bool enable);
+				   struct ieee80211_sta *sta, bool enable,
+				   bool newly);
 void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta, void *sta_wtbl,
@@ -995,7 +1005,7 @@ int mt76_connac_mcu_sta_update_hdr_trans(struct mt76_dev *dev,
 void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_sta *sta,
 			     struct ieee80211_vif *vif,
-			     u8 rcpi);
+			     u8 rcpi, u8 state);
 void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				 struct ieee80211_sta *sta, void *sta_wtbl,
 				 void *wtbl_tlv);
@@ -1019,6 +1029,8 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 				bool enable);
 int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
 				struct mt76_sta_cmd_info *info);
+int mt76_connac_mcu_update_sta_cmd(struct mt76_phy *phy,
+				   struct mt76_sta_cmd_info *info);
 void mt76_connac_mcu_beacon_loss_iter(void *priv, u8 *mac,
 				      struct ieee80211_vif *vif);
 int mt76_connac_mcu_set_rts_thresh(struct mt76_dev *dev, u32 val, u8 band);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 472afd4ea487..ece0cecf049d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -570,7 +570,8 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 		mt7921_mcu_uni_bss_ps(dev, vif);
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		mt7921_mcu_sta_add(dev, NULL, vif, true);
+		mt7921_mcu_sta_add(dev, NULL, vif, true,
+				   MT76_STA_INFO_STATE_3);
 		mt7921_bss_bcnft_apply(dev, vif, info->assoc);
 	}
 
@@ -616,7 +617,8 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	ret = mt7921_mcu_sta_add(dev, sta, vif, true);
+	ret = mt7921_mcu_sta_add(dev, sta, vif, true,
+				 MT76_STA_INFO_STATE_3);
 	if (ret)
 		return ret;
 
@@ -634,7 +636,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
-	mt7921_mcu_sta_add(dev, sta, vif, false);
+	mt7921_mcu_sta_add(dev, sta, vif, false, MT76_STA_INFO_STATE_1);
 	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 4c97c5bdbf86..631f408520c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1322,7 +1322,7 @@ int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 }
 
 int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
-		       struct ieee80211_vif *vif, bool enable)
+		       struct ieee80211_vif *vif, bool enable, u8 state)
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 	int rssi = -ewma_rssi_read(&mvif->rssi);
@@ -1330,6 +1330,7 @@ int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 		.sta = sta,
 		.vif = vif,
 		.enable = enable,
+		.state = state,
 		.cmd = MCU_UNI_CMD_STA_REC_UPDATE,
 		.rcpi = to_rcpi(rssi),
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index a9b21fcc321c..694f85e52222 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -261,7 +261,7 @@ int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 		       enum set_key_cmd cmd);
 int mt7921_set_channel(struct mt7921_phy *phy);
 int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
-		       struct ieee80211_vif *vif, bool enable);
+		       struct ieee80211_vif *vif, bool enable, u8 state);
 int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
 int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
-- 
2.25.1

