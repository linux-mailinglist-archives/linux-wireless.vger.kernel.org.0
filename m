Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F45D3A4AA2
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jun 2021 23:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFKVei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Jun 2021 17:34:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56877 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230040AbhFKVeh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Jun 2021 17:34:37 -0400
X-UUID: 11a2737a98cd455f8feba1a6c9e74961-20210612
X-UUID: 11a2737a98cd455f8feba1a6c9e74961-20210612
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1589366803; Sat, 12 Jun 2021 05:32:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 12 Jun 2021 05:32:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 12 Jun 2021 05:32:33 +0800
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
Subject: [PATCH v6] mt76: mt7921: fix sta_state incorrect implementation
Date:   Sat, 12 Jun 2021 05:32:32 +0800
Message-ID: <945bcd85bf950d00dd79162dbf87c50376285b10.1623446820.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

When .sta_state is implemented, mac80211 assumes that the station entry is
usable after the NOTEXIST->NONE transition.

So we should create the sta entry as early as possible in order that
mac80211 pass assoc/auth frames to mt76 with the newly created sta entry,
and add .sta_assoc to mt76 core to refresh the sta entry again when sta is
being associated.

Fixes: 8aa5a9b7361c ("mt76: mt7921: enable deep sleep at runtime")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v1->v2: Put back the careless change not belonged to the patch to keep
	mt7921_mcu_sta_add for BC entry and mt76_connac_mcu_uni_add_bss
	on the association.
v2->v3: 1. rebase the latest mt76
	2. squashing 2/3 to the one
	3. add the proper lock in mt7921_mac_sta_assoc
v3->v4: 1. drop mt76_connac_mcu_add_sta_cmd, call mt76_connac_mcu_sta_cmd
	   instead
	2. drop mt76_connac_mcu_update_sta_cmd, call
	   mt76_connac_mcu_sta_cmd instead
	3. squash the patch 1/2
	4. drop mt7921_mcu_sta_add, call mt7921_mcu_sta_update instead
	5. rebase onto the top of the latest mt76 plus
	   “mt76: connac: fix UC entry is being overwritten”
	6. move .newly to be one of parameters in struct mt76_sta_cmd_info
v4->v5: include back the changelog
v5->v6: rebase the latest mt76
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  8 ++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 20 +++---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 17 ++++--
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 61 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  9 ++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  7 ++-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  1 +
 7 files changed, 69 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index ea1f23e99ca1..f8a09692d3e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1028,9 +1028,10 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	if (IS_ERR(sskb))
 		return PTR_ERR(sskb);
 
-	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable);
+	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable, true);
 	if (enable && sta)
-		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0);
+		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0,
+					MT76_STA_INFO_STATE_ASSOC);
 
 	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
 						  WTBL_RESET_AND_SET, NULL,
@@ -1157,11 +1158,12 @@ __mt7615_mcu_add_sta(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		.vif = vif,
 		.offload_fw = offload_fw,
 		.enable = enable,
+		.newly = true,
 		.cmd = cmd,
 	};
 
 	info.wcid = sta ? (struct mt76_wcid *)sta->drv_priv : &mvif->sta.wcid;
-	return mt76_connac_mcu_add_sta_cmd(phy, &info);
+	return mt76_connac_mcu_sta_cmd(phy, &info);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 8fe09e7363ca..ac155c85b93b 100644
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
@@ -862,8 +863,8 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ht_tlv);
 
-int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
-				struct mt76_sta_cmd_info *info)
+int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
+			    struct mt76_sta_cmd_info *info)
 {
 	struct mt76_vif *mvif = (struct mt76_vif *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
@@ -877,10 +878,11 @@ int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
 
 	if (info->sta || !info->offload_fw)
 		mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta,
-					      info->enable);
+					      info->enable, info->newly);
 	if (info->sta && info->enable)
 		mt76_connac_mcu_sta_tlv(phy, skb, info->sta,
-					info->vif, info->rcpi);
+					info->vif, info->rcpi,
+					info->state);
 
 	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
 					   sizeof(struct tlv));
@@ -904,7 +906,7 @@ int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
 
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
 }
-EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_sta_cmd);
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_cmd);
 
 void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				 struct ieee80211_ampdu_params *params,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index bb0d7b28fe24..1c73beb22677 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -927,6 +927,12 @@ struct mt76_connac_suspend_tlv {
 	u8 pad[5];
 } __packed;
 
+enum mt76_sta_info_state {
+	MT76_STA_INFO_STATE_NONE,
+	MT76_STA_INFO_STATE_AUTH,
+	MT76_STA_INFO_STATE_ASSOC
+};
+
 struct mt76_sta_cmd_info {
 	struct ieee80211_sta *sta;
 	struct mt76_wcid *wcid;
@@ -935,8 +941,10 @@ struct mt76_sta_cmd_info {
 
 	bool offload_fw;
 	bool enable;
+	bool newly;
 	int cmd;
 	u8 rcpi;
+	u8 state;
 };
 
 #define MT_SKU_POWER_LIMIT	161
@@ -1006,7 +1014,8 @@ int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy);
 int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif);
 void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
 				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta, bool enable);
+				   struct ieee80211_sta *sta, bool enable,
+				   bool newly);
 void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta, void *sta_wtbl,
@@ -1021,7 +1030,7 @@ int mt76_connac_mcu_sta_update_hdr_trans(struct mt76_dev *dev,
 void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_sta *sta,
 			     struct ieee80211_vif *vif,
-			     u8 rcpi);
+			     u8 rcpi, u8 state);
 void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				 struct ieee80211_sta *sta, void *sta_wtbl,
 				 void *wtbl_tlv);
@@ -1043,8 +1052,8 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 				struct ieee80211_vif *vif,
 				struct mt76_wcid *wcid,
 				bool enable);
-int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
-				struct mt76_sta_cmd_info *info);
+int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
+			    struct mt76_sta_cmd_info *info);
 void mt76_connac_mcu_beacon_loss_iter(void *priv, u8 *mac,
 				      struct ieee80211_vif *vif);
 int mt76_connac_mcu_set_rts_thresh(struct mt76_dev *dev, u32 val, u8 band);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index f062088780c2..bc5643f485c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -578,7 +578,8 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 		mt7921_mcu_uni_bss_ps(dev, vif);
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		mt7921_mcu_sta_add(dev, NULL, vif, true);
+		mt7921_mcu_sta_update(dev, NULL, vif, true,
+				      MT76_STA_INFO_STATE_ASSOC);
 		mt7921_bss_bcnft_apply(dev, vif, info->assoc);
 	}
 
@@ -617,17 +618,14 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
-	if (vif->type == NL80211_IFTYPE_STATION) {
+	if (vif->type == NL80211_IFTYPE_STATION)
 		mvif->wep_sta = msta;
-		if (!sta->tdls)
-			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
-						    &mvif->sta.wcid, true);
-	}
 
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	ret = mt7921_mcu_sta_add(dev, sta, vif, true);
+	ret = mt7921_mcu_sta_update(dev, sta, vif, true,
+				    MT76_STA_INFO_STATE_NONE);
 	if (ret)
 		return ret;
 
@@ -636,6 +634,27 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	return 0;
 }
 
+void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+	mt7921_mutex_acquire(dev);
+
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
+					    true);
+
+	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	mt7921_mcu_sta_update(dev, sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
+
+	mt7921_mutex_release(dev);
+}
+
 void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
 {
@@ -645,7 +664,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
-	mt7921_mcu_sta_add(dev, sta, vif, false);
+	mt7921_mcu_sta_update(dev, sta, vif, false, MT76_STA_INFO_STATE_NONE);
 	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
@@ -791,22 +810,6 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return ret;
 }
 
-static int
-mt7921_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-	       struct ieee80211_sta *sta)
-{
-	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NOTEXIST,
-			      IEEE80211_STA_NONE);
-}
-
-static int
-mt7921_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		  struct ieee80211_sta *sta)
-{
-	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NONE,
-			      IEEE80211_STA_NOTEXIST);
-}
-
 static int mt7921_sta_state(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta,
@@ -821,15 +824,7 @@ static int mt7921_sta_state(struct ieee80211_hw *hw,
 		mt7921_mutex_release(dev);
 	}
 
-	if (old_state == IEEE80211_STA_AUTH &&
-	    new_state == IEEE80211_STA_ASSOC) {
-		return mt7921_sta_add(hw, vif, sta);
-	} else if (old_state == IEEE80211_STA_ASSOC &&
-		   new_state == IEEE80211_STA_AUTH) {
-		return mt7921_sta_remove(hw, vif, sta);
-	}
-
-	return 0;
+	return mt76_sta_state(hw, vif, sta, old_state, new_state);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index ca481e37d22c..23ec0c816d64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1267,8 +1267,9 @@ int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 				 sizeof(req), false);
 }
 
-int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
-		       struct ieee80211_vif *vif, bool enable)
+int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
+			  struct ieee80211_vif *vif, bool enable,
+			  enum mt76_sta_info_state state)
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 	int rssi = -ewma_rssi_read(&mvif->rssi);
@@ -1277,6 +1278,7 @@ int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 		.vif = vif,
 		.enable = enable,
 		.cmd = MCU_UNI_CMD_STA_REC_UPDATE,
+		.state = state,
 		.offload_fw = true,
 		.rcpi = to_rcpi(rssi),
 	};
@@ -1284,8 +1286,9 @@ int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 
 	msta = sta ? (struct mt7921_sta *)sta->drv_priv : NULL;
 	info.wcid = msta ? &msta->wcid : &mvif->sta.wcid;
+	info.newly = msta ? state != MT76_STA_INFO_STATE_ASSOC : true;
 
-	return mt76_connac_mcu_add_sta_cmd(&dev->mphy, &info);
+	return mt76_connac_mcu_sta_cmd(&dev->mphy, &info);
 }
 
 int __mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 087067e7ea5b..a249ce34b44b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -261,8 +261,9 @@ int mt7921_mcu_init(struct mt7921_dev *dev);
 int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
 		       enum set_key_cmd cmd);
-int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
-		       struct ieee80211_vif *vif, bool enable);
+int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
+			  struct ieee80211_vif *vif, bool enable,
+			  enum mt76_sta_info_state state);
 int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
 int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
@@ -334,6 +335,8 @@ void mt7921_mac_fill_rx_vector(struct mt7921_dev *dev, struct sk_buff *skb);
 void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb);
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
+void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta);
 void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void mt7921_mac_work(struct work_struct *work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 13263f50dc00..27906b2cd912 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -106,6 +106,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.rx_poll_complete = mt7921_rx_poll_complete,
 		.sta_ps = mt7921_sta_ps,
 		.sta_add = mt7921_mac_sta_add,
+		.sta_assoc = mt7921_mac_sta_assoc,
 		.sta_remove = mt7921_mac_sta_remove,
 		.update_survey = mt7921_update_channel,
 	};
-- 
2.25.1

