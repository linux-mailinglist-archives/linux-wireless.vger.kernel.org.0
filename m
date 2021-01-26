Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A78303B67
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 12:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392248AbhAZLUl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 06:20:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404691AbhAZLO5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jan 2021 06:14:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C11EC2310C;
        Tue, 26 Jan 2021 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611659652;
        bh=DnT5xWDlRdFX1FhOq+X4VNqPHuqowSaa/x4BchyEG18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SarCFxly9NLIFh25Gf+zNlVICFkidNUw+Z0xd9Mqmo7dB9OvJgpckwRvEu6zNZ+pP
         vuP11kHcCX7h4xf3CzfDySk/5Yl74gd/+DiysQTWUEy8wpAnAyNJABWQL1P7F4a6Uy
         dUoTmiMxYB8oEJf+D2YKsAJy9XOrmzPOxmbQtMl02B6DrRf5bjTQZ951ySihxyAOHm
         /18zACaXJOHJlovheDZeI92awmwzmsnOI3F8j2iVurko4jPxDIbLbQ0kALTS2RLXvZ
         BtP6crHMvlqcSkvI/lns3qwpEh8ttMNu543qTTFulNI7Iw6fykPEGAMvtDT+H5BuEa
         UOV2y5JCZbF6Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v3 2/6] mt76: mt76_connac: create mcu library
Date:   Tue, 26 Jan 2021 12:13:52 +0100
Message-Id: <0650351a4958c6f91d5d4cdffb74b7ac2fa91b23.1611659413.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611659413.git.lorenzo@kernel.org>
References: <cover.1611659413.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_connac common mcu library for code sharing between mt7615 and
mt7921 devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/Kconfig    |    4 +
 drivers/net/wireless/mediatek/mt76/Makefile   |    3 +
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |    2 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |    6 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   27 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 1048 ++---------------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  446 +------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   31 +-
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |    1 +
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |    1 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  986 ++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  729 ++++++++++++
 12 files changed, 1864 insertions(+), 1420 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index 31015d2a8e7d..74f99f08d0b5 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -24,6 +24,10 @@ config MT76x02_USB
 	tristate
 	select MT76_USB
 
+config MT76_CONNAC_LIB
+	tristate
+	select MT76_CORE
+
 source "drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7603/Kconfig"
diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index e53584db0756..fd0a124335a0 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_MT76_USB) += mt76-usb.o
 obj-$(CONFIG_MT76_SDIO) += mt76-sdio.o
 obj-$(CONFIG_MT76x02_LIB) += mt76x02-lib.o
 obj-$(CONFIG_MT76x02_USB) += mt76x02-usb.o
+obj-$(CONFIG_MT76_CONNAC_LIB) += mt76-connac-lib.o
 
 mt76-y := \
 	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
@@ -26,6 +27,8 @@ mt76x02-lib-y := mt76x02_util.o mt76x02_mac.o mt76x02_mcu.o \
 
 mt76x02-usb-y := mt76x02_usb_mcu.o mt76x02_usb_core.o
 
+mt76-connac-lib-y := mt76_connac_mcu.o
+
 obj-$(CONFIG_MT76x0_COMMON) += mt76x0/
 obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
 obj-$(CONFIG_MT7603E) += mt7603/
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index f372fb629caf..5418bc96ee3b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -2,7 +2,7 @@
 
 config MT7615_COMMON
 	tristate
-	select MT76_CORE
+	select MT76_CONNAC_LIB
 
 config MT7615E
 	tristate "MediaTek MT7615E and MT7663E (PCIe) support"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index f345cb43cb01..87bcf264b370 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -10,6 +10,7 @@
 #include <linux/etherdevice.h>
 #include "mt7615.h"
 #include "mac.h"
+#include "mcu.h"
 #include "eeprom.h"
 
 static void
@@ -96,7 +97,7 @@ mt7615_mac_init(struct mt7615_dev *dev)
 		 MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN |
 		 MT_TMAC_CTCR0_INS_DDLMT_EN);
 
-	mt7615_mcu_set_rts_thresh(&dev->phy, 0x92b);
+	mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
 	mt7615_mac_set_scs(&dev->phy, true);
 
 	mt76_rmw(dev, MT_AGG_SCR, MT_AGG_SCR_NLNAV_MID_PTEC_DIS,
@@ -313,7 +314,8 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 
 	if (chandef->chan->flags & IEEE80211_CHAN_RADAR)
 		mt7615_dfs_init_radar_detector(phy);
-	mt7615_mcu_set_channel_domain(phy);
+	if (mt7615_firmware_offload(phy->dev))
+		mt76_connac_mcu_set_channel_domain(mphy);
 
 	mt7615_mutex_release(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 46a9e9927074..67eb2d345184 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -55,17 +55,19 @@ static int mt7615_start(struct ieee80211_hw *hw)
 
 	if (!running) {
 		mt7615_mcu_set_pm(dev, 0, 0);
-		mt7615_mcu_set_mac_enable(dev, 0, true);
+		mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, true, false);
 		mt7615_mac_enable_nf(dev, 0);
 	}
 
 	if (phy != &dev->phy) {
 		mt7615_mcu_set_pm(dev, 1, 0);
-		mt7615_mcu_set_mac_enable(dev, 1, true);
+		mt76_connac_mcu_set_mac_enable(&dev->mt76, 1, true, false);
 		mt7615_mac_enable_nf(dev, 1);
 	}
 
-	mt7615_mcu_set_channel_domain(phy);
+	if (mt7615_firmware_offload(dev))
+		mt76_connac_mcu_set_channel_domain(phy->mt76);
+
 	mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
@@ -104,12 +106,12 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 
 	if (phy != &dev->phy) {
 		mt7615_mcu_set_pm(dev, 1, 1);
-		mt7615_mcu_set_mac_enable(dev, 1, false);
+		mt76_connac_mcu_set_mac_enable(&dev->mt76, 1, false, false);
 	}
 
 	if (!mt7615_dev_running(dev)) {
 		mt7615_mcu_set_pm(dev, 0, 1);
-		mt7615_mcu_set_mac_enable(dev, 0, false);
+		mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, false, false);
 	}
 
 	mt7615_mutex_release(dev);
@@ -228,7 +230,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 		mtxq->wcid = &mvif->sta.wcid;
 	}
 
-	ret = mt7615_mcu_add_dev_info(dev, vif, true);
+	ret = mt7615_mcu_add_dev_info(phy, vif, true);
 	if (ret)
 		goto out;
 
@@ -259,7 +261,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	mt7615_free_pending_tx_skbs(dev, msta);
 
 	mt7615_mac_set_beacon_filter(phy, vif, false);
-	mt7615_mcu_add_dev_info(dev, vif, false);
+	mt7615_mcu_add_dev_info(phy, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
@@ -542,7 +544,7 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
 		mt7615_mcu_add_bss_info(phy, vif, NULL, info->enable_beacon);
-		mt7615_mcu_sta_add(dev, vif, NULL, info->enable_beacon);
+		mt7615_mcu_sta_add(phy, vif, NULL, info->enable_beacon);
 
 		if (vif->p2p && info->enable_beacon)
 			mt7615_mcu_set_p2p_oppps(hw, vif);
@@ -553,7 +555,7 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 		mt7615_mcu_add_beacon(dev, hw, vif, info->enable_beacon);
 
 	if (changed & BSS_CHANGED_PS)
-		mt7615_mcu_set_vif_ps(dev, vif);
+		mt76_connac_mcu_set_vif_ps(&dev->mt76, vif);
 
 	if (changed & BSS_CHANGED_ARP_FILTER)
 		mt7615_mcu_update_arp_filter(hw, vif, info);
@@ -603,7 +605,7 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	}
 	mt7615_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-	mt7615_mcu_sta_add(dev, vif, sta, true);
+	mt7615_mcu_sta_add(&dev->phy, vif, sta, true);
 
 	mt7615_pm_power_save_sched(dev);
 
@@ -620,7 +622,7 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7615_free_pending_tx_skbs(dev, msta);
 	mt7615_pm_wake(dev);
 
-	mt7615_mcu_sta_add(dev, vif, sta, false);
+	mt7615_mcu_sta_add(&dev->phy, vif, sta, false);
 	mt7615_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
@@ -737,9 +739,10 @@ static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	int band = phy != &dev->phy;
 
 	mt7615_mutex_acquire(dev);
-	mt7615_mcu_set_rts_thresh(phy, val);
+	mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, band);
 	mt7615_mutex_release(dev);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index aa744414f71b..36d7f6f08fa2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -480,30 +480,15 @@ mt7615_mcu_roc_event(struct mt7615_dev *dev, struct sk_buff *skb)
 		  round_jiffies_up(jiffies + msecs_to_jiffies(duration)));
 }
 
-static void
-mt7615_mcu_beacon_loss_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct mt7615_beacon_loss_event *event = priv;
-
-	if (mvif->mt76.idx != event->bss_idx)
-		return;
-
-	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER))
-		return;
-
-	ieee80211_beacon_loss(vif);
-}
-
 static void
 mt7615_mcu_beacon_loss_event(struct mt7615_dev *dev, struct sk_buff *skb)
 {
-	struct mt7615_beacon_loss_event *event;
+	struct mt76_connac_beacon_loss_event *event;
 	struct mt76_phy *mphy;
 	u8 band_idx = 0; /* DBDC support */
 
 	skb_pull(skb, sizeof(struct mt7615_mcu_rxd));
-	event = (struct mt7615_beacon_loss_event *)skb->data;
+	event = (struct mt76_connac_beacon_loss_event *)skb->data;
 	if (band_idx && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 	else
@@ -511,18 +496,19 @@ mt7615_mcu_beacon_loss_event(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
 					IEEE80211_IFACE_ITER_RESUME_ALL,
-					mt7615_mcu_beacon_loss_iter, event);
+					mt76_connac_mcu_beacon_loss_iter,
+					event);
 }
 
 static void
 mt7615_mcu_bss_event(struct mt7615_dev *dev, struct sk_buff *skb)
 {
-	struct mt7615_mcu_bss_event *event;
+	struct mt76_connac_mcu_bss_event *event;
 	struct mt76_phy *mphy;
 	u8 band_idx = 0; /* DBDC support */
 
-	event = (struct mt7615_mcu_bss_event *)(skb->data +
-						sizeof(struct mt7615_mcu_rxd));
+	skb_pull(skb, sizeof(struct mt7615_mcu_rxd));
+	event = (struct mt76_connac_mcu_bss_event *)skb->data;
 
 	if (band_idx && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
@@ -582,23 +568,6 @@ void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb)
 		mt76_mcu_rx_event(&dev->mt76, skb);
 }
 
-static int mt7615_mcu_init_download(struct mt7615_dev *dev, u32 addr,
-				    u32 len, u32 mode)
-{
-	struct {
-		__le32 addr;
-		__le32 len;
-		__le32 mode;
-	} req = {
-		.addr = cpu_to_le32(addr),
-		.len = cpu_to_le32(len),
-		.mode = cpu_to_le32(mode),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_TARGET_ADDRESS_LEN_REQ,
-				 &req, sizeof(req), true);
-}
-
 static int
 mt7615_mcu_muar_config(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		       bool bssid, bool enable)
@@ -636,10 +605,11 @@ mt7615_mcu_muar_config(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 }
 
 static int
-mt7615_mcu_add_dev(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+mt7615_mcu_add_dev(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		   bool enable)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt7615_dev *dev = phy->dev;
 	struct {
 		struct req_hdr {
 			u8 omac_idx;
@@ -774,86 +744,6 @@ mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int state)
 				 sizeof(req), true);
 }
 
-static struct sk_buff *
-mt7615_mcu_alloc_sta_req(struct mt7615_dev *dev, struct mt7615_vif *mvif,
-			 struct mt7615_sta *msta)
-{
-	struct sta_req_hdr hdr = {
-		.bss_idx = mvif->mt76.idx,
-		.wlan_idx = msta ? msta->wcid.idx : 0,
-		.muar_idx = msta ? mvif->mt76.omac_idx : 0,
-		.is_tlv_append = 1,
-	};
-	struct sk_buff *skb;
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, MT7615_STA_UPDATE_MAX_SIZE);
-	if (!skb)
-		return ERR_PTR(-ENOMEM);
-
-	skb_put_data(skb, &hdr, sizeof(hdr));
-
-	return skb;
-}
-
-static struct wtbl_req_hdr *
-mt7615_mcu_alloc_wtbl_req(struct mt7615_dev *dev, struct mt7615_sta *msta,
-			  int cmd, void *sta_wtbl, struct sk_buff **skb)
-{
-	struct tlv *sta_hdr = sta_wtbl;
-	struct wtbl_req_hdr hdr = {
-		.wlan_idx = msta->wcid.idx,
-		.operation = cmd,
-	};
-	struct sk_buff *nskb = *skb;
-
-	if (!nskb) {
-		nskb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-					  MT7615_WTBL_UPDATE_BA_SIZE);
-		if (!nskb)
-			return ERR_PTR(-ENOMEM);
-
-		*skb = nskb;
-	}
-
-	if (sta_hdr)
-		sta_hdr->len = cpu_to_le16(sizeof(hdr));
-
-	return skb_put_data(nskb, &hdr, sizeof(hdr));
-}
-
-static struct tlv *
-mt7615_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
-			  void *sta_ntlv, void *sta_wtbl)
-{
-	struct sta_ntlv_hdr *ntlv_hdr = sta_ntlv;
-	struct tlv *sta_hdr = sta_wtbl;
-	struct tlv *ptlv, tlv = {
-		.tag = cpu_to_le16(tag),
-		.len = cpu_to_le16(len),
-	};
-	u16 ntlv;
-
-	ptlv = skb_put(skb, len);
-	memcpy(ptlv, &tlv, sizeof(tlv));
-
-	ntlv = le16_to_cpu(ntlv_hdr->tlv_num);
-	ntlv_hdr->tlv_num = cpu_to_le16(ntlv + 1);
-
-	if (sta_hdr) {
-		u16 size = le16_to_cpu(sta_hdr->len);
-
-		sta_hdr->len = cpu_to_le16(size + len);
-	}
-
-	return ptlv;
-}
-
-static struct tlv *
-mt7615_mcu_add_tlv(struct sk_buff *skb, int tag, int len)
-{
-	return mt7615_mcu_add_nested_tlv(skb, tag, len, skb->data, NULL);
-}
-
 static int
 mt7615_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta, bool enable)
@@ -864,7 +754,7 @@ mt7615_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	u8 wlan_idx = mvif->sta.wcid.idx;
 	struct tlv *tlv;
 
-	tlv = mt7615_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
@@ -908,7 +798,7 @@ mt7615_mcu_bss_omac_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 	struct tlv *tlv;
 	u32 type = 0;
 
-	tlv = mt7615_mcu_add_tlv(skb, BSS_INFO_OMAC, sizeof(*omac));
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_OMAC, sizeof(*omac));
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
@@ -952,300 +842,13 @@ mt7615_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt7615_vif *mvif)
 	if (ext_bss_idx < 0)
 		return;
 
-	tlv = mt7615_mcu_add_tlv(skb, BSS_INFO_EXT_BSS, sizeof(*ext));
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_EXT_BSS, sizeof(*ext));
 
 	ext = (struct bss_info_ext_bss *)tlv;
 	tsf_offset = ext_bss_idx * BCN_TX_ESTIMATE_TIME;
 	ext->mbss_tsf_offset = cpu_to_le32(tsf_offset);
 }
 
-static void
-mt7615_mcu_sta_ba_tlv(struct sk_buff *skb,
-		      struct ieee80211_ampdu_params *params,
-		      bool enable, bool tx)
-{
-	struct sta_rec_ba *ba;
-	struct tlv *tlv;
-
-	tlv = mt7615_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));
-
-	ba = (struct sta_rec_ba *)tlv;
-	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT;
-	ba->winsize = cpu_to_le16(params->buf_size);
-	ba->ssn = cpu_to_le16(params->ssn);
-	ba->ba_en = enable << params->tid;
-	ba->amsdu = params->amsdu;
-	ba->tid = params->tid;
-}
-
-static void
-mt7615_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta, bool enable)
-{
-	struct sta_rec_basic *basic;
-	struct tlv *tlv;
-	int conn_type;
-
-	tlv = mt7615_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic));
-
-	basic = (struct sta_rec_basic *)tlv;
-	basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
-
-	if (enable) {
-		basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
-		basic->conn_state = CONN_STATE_PORT_SECURE;
-	} else {
-		basic->conn_state = CONN_STATE_DISCONNECT;
-	}
-
-	if (!sta) {
-		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
-		eth_broadcast_addr(basic->peer_addr);
-		return;
-	}
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
-		if (vif->p2p)
-			conn_type = CONNECTION_P2P_GC;
-		else
-			conn_type = CONNECTION_INFRA_STA;
-		basic->conn_type = cpu_to_le32(conn_type);
-		basic->aid = cpu_to_le16(sta->aid);
-		break;
-	case NL80211_IFTYPE_STATION:
-		if (vif->p2p)
-			conn_type = CONNECTION_P2P_GO;
-		else
-			conn_type = CONNECTION_INFRA_AP;
-		basic->conn_type = cpu_to_le32(conn_type);
-		basic->aid = cpu_to_le16(vif->bss_conf.aid);
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
-		basic->aid = cpu_to_le16(sta->aid);
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	memcpy(basic->peer_addr, sta->addr, ETH_ALEN);
-	basic->qos = sta->wme;
-}
-
-static void
-mt7615_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
-{
-	struct tlv *tlv;
-
-	if (sta->ht_cap.ht_supported) {
-		struct sta_rec_ht *ht;
-
-		tlv = mt7615_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
-		ht = (struct sta_rec_ht *)tlv;
-		ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
-	}
-	if (sta->vht_cap.vht_supported) {
-		struct sta_rec_vht *vht;
-
-		tlv = mt7615_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
-		vht = (struct sta_rec_vht *)tlv;
-		vht->vht_rx_mcs_map = sta->vht_cap.vht_mcs.rx_mcs_map;
-		vht->vht_tx_mcs_map = sta->vht_cap.vht_mcs.tx_mcs_map;
-		vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
-	}
-}
-
-static void
-mt7615_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
-		     struct ieee80211_sta *sta)
-{
-	struct sta_rec_uapsd *uapsd;
-	struct tlv *tlv;
-
-	if (vif->type != NL80211_IFTYPE_AP || !sta->wme)
-		return;
-
-	tlv = mt7615_mcu_add_tlv(skb, STA_REC_APPS, sizeof(*uapsd));
-	uapsd = (struct sta_rec_uapsd *)tlv;
-
-	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO) {
-		uapsd->dac_map |= BIT(3);
-		uapsd->tac_map |= BIT(3);
-	}
-	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VI) {
-		uapsd->dac_map |= BIT(2);
-		uapsd->tac_map |= BIT(2);
-	}
-	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BE) {
-		uapsd->dac_map |= BIT(1);
-		uapsd->tac_map |= BIT(1);
-	}
-	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BK) {
-		uapsd->dac_map |= BIT(0);
-		uapsd->tac_map |= BIT(0);
-	}
-	uapsd->max_sp = sta->max_sp;
-}
-
-static void
-mt7615_mcu_wtbl_ba_tlv(struct sk_buff *skb,
-		       struct ieee80211_ampdu_params *params,
-		       bool enable, bool tx, void *sta_wtbl,
-		       void *wtbl_tlv)
-{
-	struct wtbl_ba *ba;
-	struct tlv *tlv;
-
-	tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_BA, sizeof(*ba),
-					wtbl_tlv, sta_wtbl);
-
-	ba = (struct wtbl_ba *)tlv;
-	ba->tid = params->tid;
-
-	if (tx) {
-		ba->ba_type = MT_BA_TYPE_ORIGINATOR;
-		ba->sn = enable ? cpu_to_le16(params->ssn) : 0;
-		ba->ba_winsize = cpu_to_le16(params->buf_size);
-		ba->ba_en = enable;
-	} else {
-		memcpy(ba->peer_addr, params->sta->addr, ETH_ALEN);
-		ba->ba_type = MT_BA_TYPE_RECIPIENT;
-		ba->rst_ba_tid = params->tid;
-		ba->rst_ba_sel = RST_BA_MAC_TID_MATCH;
-		ba->rst_ba_sb = 1;
-	}
-
-	if (enable && tx) {
-		u8 ba_range[] = { 4, 8, 12, 24, 36, 48, 54, 64 };
-		int i;
-
-		for (i = 7; i > 0; i--) {
-			if (params->buf_size >= ba_range[i])
-				break;
-		}
-		ba->ba_winsize_idx = i;
-	}
-}
-
-static void
-mt7615_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, void *sta_wtbl,
-			    void *wtbl_tlv)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct wtbl_generic *generic;
-	struct wtbl_rx *rx;
-	struct wtbl_spe *spe;
-	struct tlv *tlv;
-
-	tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_GENERIC, sizeof(*generic),
-					wtbl_tlv, sta_wtbl);
-
-	generic = (struct wtbl_generic *)tlv;
-
-	if (sta) {
-		if (vif->type == NL80211_IFTYPE_STATION)
-			generic->partial_aid = cpu_to_le16(vif->bss_conf.aid);
-		else
-			generic->partial_aid = cpu_to_le16(sta->aid);
-		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
-		generic->muar_idx = mvif->mt76.omac_idx;
-		generic->qos = sta->wme;
-	} else {
-		eth_broadcast_addr(generic->peer_addr);
-		generic->muar_idx = 0xe;
-	}
-
-	tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_RX, sizeof(*rx),
-					wtbl_tlv, sta_wtbl);
-
-	rx = (struct wtbl_rx *)tlv;
-	rx->rca1 = sta ? vif->type != NL80211_IFTYPE_AP : 1;
-	rx->rca2 = 1;
-	rx->rv = 1;
-
-	tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_SPE, sizeof(*spe),
-					wtbl_tlv, sta_wtbl);
-	spe = (struct wtbl_spe *)tlv;
-	spe->spe_idx = 24;
-}
-
-static void
-mt7615_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
-		       void *sta_wtbl, void *wtbl_tlv)
-{
-	struct tlv *tlv;
-	struct wtbl_ht *ht = NULL;
-	u32 flags = 0;
-
-	if (sta->ht_cap.ht_supported) {
-		tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
-						wtbl_tlv, sta_wtbl);
-		ht = (struct wtbl_ht *)tlv;
-		ht->ldpc = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
-		ht->af = sta->ht_cap.ampdu_factor;
-		ht->mm = sta->ht_cap.ampdu_density;
-		ht->ht = 1;
-
-		if (sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20)
-			flags |= MT_WTBL_W5_SHORT_GI_20;
-		if (sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_40)
-			flags |= MT_WTBL_W5_SHORT_GI_40;
-	}
-
-	if (sta->vht_cap.vht_supported) {
-		struct wtbl_vht *vht;
-		u8 af;
-
-		tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_VHT, sizeof(*vht),
-						wtbl_tlv, sta_wtbl);
-		vht = (struct wtbl_vht *)tlv;
-		vht->ldpc = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
-		vht->vht = 1;
-
-		af = (sta->vht_cap.cap &
-		      IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK) >>
-		      IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
-
-		if (ht)
-		    ht->af = max(ht->af, af);
-
-		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
-			flags |= MT_WTBL_W5_SHORT_GI_80;
-		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160)
-			flags |= MT_WTBL_W5_SHORT_GI_160;
-	}
-
-	/* wtbl smps */
-	if (sta->smps_mode == IEEE80211_SMPS_DYNAMIC) {
-		struct wtbl_smps *smps;
-
-		tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
-						wtbl_tlv, sta_wtbl);
-		smps = (struct wtbl_smps *)tlv;
-		smps->smps = 1;
-	}
-
-	if (sta->ht_cap.ht_supported) {
-		/* sgi */
-		u32 msk = MT_WTBL_W5_SHORT_GI_20 | MT_WTBL_W5_SHORT_GI_40 |
-			  MT_WTBL_W5_SHORT_GI_80 | MT_WTBL_W5_SHORT_GI_160;
-		struct wtbl_raw *raw;
-
-		tlv = mt7615_mcu_add_nested_tlv(skb, WTBL_RAW_DATA,
-						sizeof(*raw), wtbl_tlv,
-						sta_wtbl);
-		raw = (struct wtbl_raw *)tlv;
-		raw->val = cpu_to_le32(flags);
-		raw->msk = cpu_to_le32(~msk);
-		raw->wtbl_idx = 1;
-		raw->dw = 5;
-	}
-}
-
 static int
 mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta, bool enable)
@@ -1257,7 +860,7 @@ mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	if (mvif->mt76.omac_idx >= REPEATER_BSSID_START)
 		mt7615_mcu_muar_config(dev, vif, true, enable);
 
-	skb = mt7615_mcu_alloc_sta_req(dev, mvif, NULL);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76, NULL);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1285,22 +888,25 @@ mt7615_mcu_wtbl_tx_ba(struct mt7615_dev *dev,
 	struct sk_buff *skb = NULL;
 	int err;
 
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, NULL, &skb);
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
+						  WTBL_SET, NULL, &skb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
-	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, true, NULL, wtbl_hdr);
+	mt76_connac_mcu_wtbl_ba_tlv(&dev->mt76, skb, params, enable, true,
+				    NULL, wtbl_hdr);
 
 	err = mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
 				    true);
 	if (err < 0)
 		return err;
 
-	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt7615_mcu_sta_ba_tlv(skb, params, enable, true);
+	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, true);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_EXT_CMD_STA_REC_UPDATE, true);
@@ -1317,11 +923,12 @@ mt7615_mcu_wtbl_rx_ba(struct mt7615_dev *dev,
 	struct sk_buff *skb;
 	int err;
 
-	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt7615_mcu_sta_ba_tlv(skb, params, enable, false);
+	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, false);
 
 	err = mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				    MCU_EXT_CMD_STA_REC_UPDATE, true);
@@ -1329,47 +936,52 @@ mt7615_mcu_wtbl_rx_ba(struct mt7615_dev *dev,
 		return err;
 
 	skb = NULL;
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, NULL, &skb);
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
+						  WTBL_SET, NULL, &skb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
-	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, false, NULL, wtbl_hdr);
+	mt76_connac_mcu_wtbl_ba_tlv(&dev->mt76, skb, params, enable, false,
+				    NULL, wtbl_hdr);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
 				     true);
 }
 
 static int
-mt7615_mcu_wtbl_sta_add(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, bool enable)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct sk_buff *skb, *sskb, *wskb = NULL;
+	struct mt7615_dev *dev = phy->dev;
 	struct wtbl_req_hdr *wtbl_hdr;
 	struct mt7615_sta *msta;
 	int cmd, err;
 
 	msta = sta ? (struct mt7615_sta *)sta->drv_priv : &mvif->sta;
 
-	sskb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
+	sskb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					     &msta->wcid);
 	if (IS_ERR(sskb))
 		return PTR_ERR(sskb);
 
-	mt7615_mcu_sta_basic_tlv(sskb, vif, sta, enable);
-	if (enable && sta) {
-		mt7615_mcu_sta_ht_tlv(sskb, sta);
-		mt7615_mcu_sta_uapsd(sskb, vif, sta);
-	}
+	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable);
+	if (enable && sta)
+		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif);
 
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
-					     NULL, &wskb);
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
+						  WTBL_RESET_AND_SET, NULL,
+						  &wskb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
 	if (enable) {
-		mt7615_mcu_wtbl_generic_tlv(wskb, vif, sta, NULL, wtbl_hdr);
+		mt76_connac_mcu_wtbl_generic_tlv(&dev->mt76, wskb, vif, sta,
+						 NULL, wtbl_hdr);
 		if (sta)
-			mt7615_mcu_wtbl_ht_tlv(wskb, sta, NULL, wtbl_hdr);
+			mt76_connac_mcu_wtbl_ht_tlv(&dev->mt76, wskb, sta,
+						    NULL, wtbl_hdr);
 	}
 
 	cmd = enable ? MCU_EXT_CMD_WTBL_UPDATE : MCU_EXT_CMD_STA_REC_UPDATE;
@@ -1412,17 +1024,19 @@ mt7615_mcu_sta_ba(struct mt7615_dev *dev,
 	struct tlv *sta_wtbl;
 	struct sk_buff *skb;
 
-	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt7615_mcu_sta_ba_tlv(skb, params, enable, tx);
+	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, tx);
 
-	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
-					     &skb);
-	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
+						  WTBL_SET, sta_wtbl, &skb);
+	mt76_connac_mcu_wtbl_ba_tlv(&dev->mt76, skb, params, enable, tx,
+				    sta_wtbl, wtbl_hdr);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_EXT_CMD_STA_REC_UPDATE, true);
@@ -1445,46 +1059,22 @@ mt7615_mcu_sta_rx_ba(struct mt7615_dev *dev,
 }
 
 static int
-mt7615_mcu_add_sta_cmd(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, bool enable, int cmd)
+__mt7615_mcu_add_sta(struct mt76_phy *phy, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta, bool enable, int cmd)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct wtbl_req_hdr *wtbl_hdr;
-	struct mt7615_sta *msta;
-	struct tlv *sta_wtbl;
-	struct sk_buff *skb;
-
-	msta = sta ? (struct mt7615_sta *)sta->drv_priv : &mvif->sta;
-
-	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	mt7615_mcu_sta_basic_tlv(skb, vif, sta, enable);
-	if (enable && sta) {
-		mt7615_mcu_sta_ht_tlv(skb, sta);
-		mt7615_mcu_sta_uapsd(skb, vif, sta);
-	}
-
-	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
-
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
-					     sta_wtbl, &skb);
-	if (enable) {
-		mt7615_mcu_wtbl_generic_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
-		if (sta)
-			mt7615_mcu_wtbl_ht_tlv(skb, sta, sta_wtbl, wtbl_hdr);
-	}
+	struct mt76_wcid *wcid;
 
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+	wcid = sta ? (struct mt76_wcid *)sta->drv_priv : &mvif->sta.wcid;
+	return mt76_connac_mcu_add_sta_cmd(phy, vif, sta, wcid, enable, cmd);
 }
 
 static int
-mt7615_mcu_add_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+mt7615_mcu_add_sta(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta, bool enable)
 {
-	return mt7615_mcu_add_sta_cmd(dev, vif, sta, enable,
-				      MCU_EXT_CMD_STA_REC_UPDATE);
+	return __mt7615_mcu_add_sta(phy->mt76, vif, sta, enable,
+				    MCU_EXT_CMD_STA_REC_UPDATE);
 }
 
 static const struct mt7615_mcu_ops sta_update_ops = {
@@ -1499,249 +1089,12 @@ static const struct mt7615_mcu_ops sta_update_ops = {
 	.set_fw_ctrl = mt7615_mcu_fw_pmctrl,
 };
 
-static int
-mt7615_mcu_uni_add_dev(struct mt7615_dev *dev,
-		       struct ieee80211_vif *vif, bool enable)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	u8 omac_idx = mvif->mt76.omac_idx;
-	struct {
-		struct {
-			u8 omac_idx;
-			u8 band_idx;
-			__le16 pad;
-		} __packed hdr;
-		struct req_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 active;
-			u8 pad;
-			u8 omac_addr[ETH_ALEN];
-		} __packed tlv;
-	} dev_req = {
-		.hdr = {
-			.omac_idx = omac_idx,
-			.band_idx = mvif->mt76.band_idx,
-		},
-		.tlv = {
-			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
-			.len = cpu_to_le16(sizeof(struct req_tlv)),
-			.active = enable,
-		},
-	};
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct mt7615_bss_basic_tlv basic;
-	} basic_req = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.basic = {
-			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
-			.len = cpu_to_le16(sizeof(struct mt7615_bss_basic_tlv)),
-			.omac_idx = omac_idx,
-			.band_idx = mvif->mt76.band_idx,
-			.wmm_idx = mvif->mt76.wmm_idx,
-			.active = enable,
-			.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx),
-			.sta_idx = cpu_to_le16(mvif->sta.wcid.idx),
-			.conn_state = 1,
-		},
-	};
-	int err, idx, cmd, len;
-	void *data;
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
-		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
-		break;
-	case NL80211_IFTYPE_STATION:
-		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	idx = omac_idx > EXT_BSSID_START ? HW_BSSID_0 : omac_idx;
-	basic_req.basic.hw_bss_idx = idx;
-
-	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
-
-	cmd = enable ? MCU_UNI_CMD_DEV_INFO_UPDATE : MCU_UNI_CMD_BSS_INFO_UPDATE;
-	data = enable ? (void *)&dev_req : (void *)&basic_req;
-	len = enable ? sizeof(dev_req) : sizeof(basic_req);
-
-	err = mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
-	if (err < 0)
-		return err;
-
-	cmd = enable ? MCU_UNI_CMD_BSS_INFO_UPDATE : MCU_UNI_CMD_DEV_INFO_UPDATE;
-	data = enable ? (void *)&basic_req : (void *)&dev_req;
-	len = enable ? sizeof(basic_req) : sizeof(dev_req);
-
-	return mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
-}
-
 static int
 mt7615_mcu_uni_ctrl_pm_state(struct mt7615_dev *dev, int band, int state)
 {
 	return 0;
 }
 
-static int
-mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, bool enable)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
-	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
-	u8 omac_idx = mvif->mt76.omac_idx;
-	struct mt7615_dev *dev = phy->dev;
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct mt7615_bss_basic_tlv basic;
-		struct mt7615_bss_qos_tlv qos;
-	} basic_req = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.basic = {
-			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
-			.len = cpu_to_le16(sizeof(struct mt7615_bss_basic_tlv)),
-			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
-			.dtim_period = vif->bss_conf.dtim_period,
-			.omac_idx = omac_idx,
-			.band_idx = mvif->mt76.band_idx,
-			.wmm_idx = mvif->mt76.wmm_idx,
-			.active = true, /* keep bss deactivated */
-			.phymode = 0x38,
-		},
-		.qos = {
-			.tag = cpu_to_le16(UNI_BSS_INFO_QBSS),
-			.len = cpu_to_le16(sizeof(struct mt7615_bss_qos_tlv)),
-			.qos = vif->bss_conf.qos,
-		},
-	};
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct rlm_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 control_channel;
-			u8 center_chan;
-			u8 center_chan2;
-			u8 bw;
-			u8 tx_streams;
-			u8 rx_streams;
-			u8 short_st;
-			u8 ht_op_info;
-			u8 sco;
-			u8 pad[3];
-		} __packed rlm;
-	} __packed rlm_req = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.rlm = {
-			.tag = cpu_to_le16(UNI_BSS_INFO_RLM),
-			.len = cpu_to_le16(sizeof(struct rlm_tlv)),
-			.control_channel = chandef->chan->hw_value,
-			.center_chan = ieee80211_frequency_to_channel(freq1),
-			.center_chan2 = ieee80211_frequency_to_channel(freq2),
-			.tx_streams = hweight8(phy->mt76->antenna_mask),
-			.rx_streams = phy->mt76->chainmask,
-			.short_st = true,
-		},
-	};
-	int err, conn_type;
-	u8 idx;
-
-	idx = omac_idx > EXT_BSSID_START ? HW_BSSID_0 : omac_idx;
-	basic_req.basic.hw_bss_idx = idx;
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
-		if (vif->p2p)
-			conn_type = CONNECTION_P2P_GO;
-		else
-			conn_type = CONNECTION_INFRA_AP;
-		basic_req.basic.conn_type = cpu_to_le32(conn_type);
-		break;
-	case NL80211_IFTYPE_STATION:
-		if (vif->p2p)
-			conn_type = CONNECTION_P2P_GC;
-		else
-			conn_type = CONNECTION_INFRA_STA;
-		basic_req.basic.conn_type = cpu_to_le32(conn_type);
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	memcpy(basic_req.basic.bssid, vif->bss_conf.bssid, ETH_ALEN);
-	basic_req.basic.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx);
-	basic_req.basic.sta_idx = cpu_to_le16(mvif->sta.wcid.idx);
-	basic_req.basic.conn_state = !enable;
-
-	err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
-				&basic_req, sizeof(basic_req), true);
-	if (err < 0)
-		return err;
-
-	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_40:
-		rlm_req.rlm.bw = CMD_CBW_40MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_80:
-		rlm_req.rlm.bw = CMD_CBW_80MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_80P80:
-		rlm_req.rlm.bw = CMD_CBW_8080MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_160:
-		rlm_req.rlm.bw = CMD_CBW_160MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_5:
-		rlm_req.rlm.bw = CMD_CBW_5MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_10:
-		rlm_req.rlm.bw = CMD_CBW_10MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_20_NOHT:
-	case NL80211_CHAN_WIDTH_20:
-	default:
-		rlm_req.rlm.bw = CMD_CBW_20MHZ;
-		break;
-	}
-
-	if (rlm_req.rlm.control_channel < rlm_req.rlm.center_chan)
-		rlm_req.rlm.sco = 1; /* SCA */
-	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
-		rlm_req.rlm.sco = 3; /* SCB */
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
-				 &rlm_req, sizeof(rlm_req), true);
-}
-
 static int
 mt7615_mcu_uni_add_beacon_offload(struct mt7615_dev *dev,
 				  struct ieee80211_hw *hw,
@@ -1815,44 +1168,42 @@ mt7615_mcu_uni_add_beacon_offload(struct mt7615_dev *dev,
 }
 
 static int
-mt7615_mcu_uni_tx_ba(struct mt7615_dev *dev,
-		     struct ieee80211_ampdu_params *params,
-		     bool enable)
+mt7615_mcu_uni_add_dev(struct mt7615_phy *phy, struct ieee80211_vif *vif,
+		       bool enable)
 {
-	struct mt7615_sta *msta = (struct mt7615_sta *)params->sta->drv_priv;
-	struct mt7615_vif *mvif = msta->vif;
-	struct wtbl_req_hdr *wtbl_hdr;
-	struct tlv *sta_wtbl;
-	struct sk_buff *skb;
-	int err;
-
-	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
-					     &skb);
-	if (IS_ERR(wtbl_hdr))
-		return PTR_ERR(wtbl_hdr);
+	return mt76_connac_mcu_uni_add_dev(phy->mt76, vif, &mvif->sta.wcid,
+					   enable);
+}
 
-	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, true, sta_wtbl,
-			       wtbl_hdr);
+static int
+mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 
-	err =  mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_UNI_CMD_STA_REC_UPDATE, true);
-	if (err < 0)
-		return err;
+	return mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
+					   enable);
+}
 
-	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
+static inline int
+mt7615_mcu_uni_add_sta(struct mt7615_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable)
+{
+	return __mt7615_mcu_add_sta(phy->mt76, vif, sta, enable,
+				    MCU_UNI_CMD_STA_REC_UPDATE);
+}
 
-	mt7615_mcu_sta_ba_tlv(skb, params, enable, true);
+static int
+mt7615_mcu_uni_tx_ba(struct mt7615_dev *dev,
+		     struct ieee80211_ampdu_params *params,
+		     bool enable)
+{
+	struct mt7615_sta *sta = (struct mt7615_sta *)params->sta->drv_priv;
 
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_UNI_CMD_STA_REC_UPDATE, true);
+	return mt76_connac_mcu_sta_ba(&dev->mt76, &sta->vif->mt76, params,
+				      enable, true);
 }
 
 static int
@@ -1867,43 +1218,38 @@ mt7615_mcu_uni_rx_ba(struct mt7615_dev *dev,
 	struct sk_buff *skb;
 	int err;
 
-	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt7615_mcu_sta_ba_tlv(skb, params, enable, false);
+	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, false);
 
 	err = mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				    MCU_UNI_CMD_STA_REC_UPDATE, true);
 	if (err < 0 || !enable)
 		return err;
 
-	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
+					   sizeof(struct tlv));
 
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
-					     &skb);
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
+						  WTBL_SET, sta_wtbl, &skb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
-	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, false, sta_wtbl,
-			       wtbl_hdr);
+	mt76_connac_mcu_wtbl_ba_tlv(&dev->mt76, skb, params, enable, false,
+				    sta_wtbl, wtbl_hdr);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_UNI_CMD_STA_REC_UPDATE, true);
 }
 
-static int
-mt7615_mcu_uni_add_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, bool enable)
-{
-	return mt7615_mcu_add_sta_cmd(dev, vif, sta, enable,
-				      MCU_UNI_CMD_STA_REC_UPDATE);
-}
-
 static const struct mt7615_mcu_ops uni_update_ops = {
 	.add_beacon_offload = mt7615_mcu_uni_add_beacon_offload,
 	.set_pm_state = mt7615_mcu_uni_ctrl_pm_state,
@@ -1916,59 +1262,19 @@ static const struct mt7615_mcu_ops uni_update_ops = {
 	.set_fw_ctrl = mt7615_mcu_fw_pmctrl,
 };
 
-static int mt7615_mcu_start_firmware(struct mt7615_dev *dev, u32 addr,
-				     u32 option)
-{
-	struct {
-		__le32 option;
-		__le32 addr;
-	} req = {
-		.option = cpu_to_le32(option),
-		.addr = cpu_to_le32(addr),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_START_REQ, &req,
-				 sizeof(req), true);
-}
-
 int mt7615_mcu_restart(struct mt76_dev *dev)
 {
 	return mt76_mcu_send_msg(dev, MCU_CMD_RESTART_DL_REQ, NULL, 0, true);
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_restart);
 
-static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
-{
-	struct {
-		__le32 op;
-	} req = {
-		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_SEM_CONTROL, &req,
-				 sizeof(req), true);
-}
-
-static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
-{
-	struct {
-		u8 check_crc;
-		u8 reserved[3];
-	} req = {
-		.check_crc = 0,
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_FINISH_REQ, &req,
-				 sizeof(req), true);
-}
-
 static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 {
 	const struct mt7615_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
 	int len, ret, sem;
 
-	sem = mt7615_mcu_patch_sem_ctrl(dev, 1);
+	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, true);
 	switch (sem) {
 	case PATCH_IS_DL:
 		return 0;
@@ -1996,7 +1302,8 @@ static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 
 	len = fw->size - sizeof(*hdr);
 
-	ret = mt7615_mcu_init_download(dev, addr, len, DL_MODE_NEED_RSP);
+	ret = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
+					    DL_MODE_NEED_RSP);
 	if (ret) {
 		dev_err(dev->mt76.dev, "Download request failed\n");
 		goto out;
@@ -2009,14 +1316,14 @@ static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 		goto out;
 	}
 
-	ret = mt7615_mcu_start_patch(dev);
+	ret = mt76_connac_mcu_start_patch(&dev->mt76);
 	if (ret)
 		dev_err(dev->mt76.dev, "Failed to start patch\n");
 
 out:
 	release_firmware(fw);
 
-	sem = mt7615_mcu_patch_sem_ctrl(dev, 0);
+	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
 	switch (sem) {
 	case PATCH_REL_SEM_SUCCESS:
 		break;
@@ -2057,7 +1364,8 @@ mt7615_mcu_send_ram_firmware(struct mt7615_dev *dev,
 		len = le32_to_cpu(hdr[i].len) + IMG_CRC_LEN;
 		addr = le32_to_cpu(hdr[i].addr);
 
-		err = mt7615_mcu_init_download(dev, addr, len, mode);
+		err = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
+						    mode);
 		if (err) {
 			dev_err(dev->mt76.dev, "Download request failed\n");
 			return err;
@@ -2111,8 +1419,9 @@ static int mt7615_load_n9(struct mt7615_dev *dev, const char *name)
 	if (ret)
 		goto out;
 
-	ret = mt7615_mcu_start_firmware(dev, le32_to_cpu(hdr->addr),
-					FW_START_OVERRIDE);
+	ret = mt76_connac_mcu_start_firmware(&dev->mt76,
+					     le32_to_cpu(hdr->addr),
+					     FW_START_OVERRIDE);
 	if (ret) {
 		dev_err(dev->mt76.dev, "Failed to start N9 firmware\n");
 		goto out;
@@ -2162,7 +1471,8 @@ static int mt7615_load_cr4(struct mt7615_dev *dev, const char *name)
 	if (ret)
 		goto out;
 
-	ret = mt7615_mcu_start_firmware(dev, 0, FW_START_WORKING_PDA_CR4);
+	ret = mt76_connac_mcu_start_firmware(&dev->mt76, 0,
+					     FW_START_WORKING_PDA_CR4);
 	if (ret) {
 		dev_err(dev->mt76.dev, "Failed to start CR4 firmware\n");
 		goto out;
@@ -2299,7 +1609,8 @@ static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 		addr = le32_to_cpu(buf->img_dest_addr);
 		len = le32_to_cpu(buf->img_size);
 
-		ret = mt7615_mcu_init_download(dev, addr, len, mode);
+		ret = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
+						    mode);
 		if (ret) {
 			dev_err(dev->mt76.dev, "Download request failed\n");
 			goto out;
@@ -2326,7 +1637,7 @@ static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 	dev_info(dev->mt76.dev, "override_addr = 0x%08x, option = %d\n",
 		 override_addr, flag);
 
-	ret = mt7615_mcu_start_firmware(dev, override_addr, flag);
+	ret = mt76_connac_mcu_start_firmware(&dev->mt76, override_addr, flag);
 	if (ret) {
 		dev_err(dev->mt76.dev, "Failed to start N9 firmware\n");
 		goto out;
@@ -2524,41 +1835,6 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 				     MCU_EXT_CMD_EFUSE_BUFFER_MODE, true);
 }
 
-int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable)
-{
-	struct {
-		u8 enable;
-		u8 band;
-		u8 rsv[2];
-	} __packed req = {
-		.enable = enable,
-		.band = band,
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MAC_INIT_CTRL, &req,
-				 sizeof(req), true);
-}
-
-int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val)
-{
-	struct mt7615_dev *dev = phy->dev;
-	struct {
-		u8 prot_idx;
-		u8 band;
-		u8 rsv[2];
-		__le32 len_thresh;
-		__le32 pkt_thresh;
-	} __packed req = {
-		.prot_idx = 1,
-		.band = phy != &dev->phy,
-		.len_thresh = cpu_to_le32(val),
-		.pkt_thresh = cpu_to_le32(0x2),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PROTECT_CTRL, &req,
-				 sizeof(req), true);
-}
-
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 		       const struct ieee80211_tx_queue_params *params)
 {
@@ -2955,106 +2231,6 @@ int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable)
 				 sizeof(req), true);
 }
 
-int mt7615_mcu_set_vif_ps(struct mt7615_dev *dev, struct ieee80211_vif *vif)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct {
-		u8 bss_idx;
-		u8 ps_state; /* 0: device awake
-			      * 1: static power save
-			      * 2: dynamic power saving
-			      */
-	} req = {
-		.bss_idx = mvif->mt76.idx,
-		.ps_state = vif->bss_conf.ps ? 2 : 0,
-	};
-
-	if (vif->type != NL80211_IFTYPE_STATION)
-		return -ENOTSUPP;
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_PS_PROFILE, &req,
-				 sizeof(req), false);
-}
-
-int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
-{
-	struct mt76_phy *mphy = phy->mt76;
-	struct mt7615_dev *dev = phy->dev;
-	struct mt7615_mcu_channel_domain {
-		u8 alpha2[4]; /* regulatory_request.alpha2 */
-		u8 bw_2g; /* BW_20_40M		0
-			   * BW_20M		1
-			   * BW_20_40_80M	2
-			   * BW_20_40_80_160M	3
-			   * BW_20_40_80_8080M	4
-			   */
-		u8 bw_5g;
-		__le16 pad;
-		u8 n_2ch;
-		u8 n_5ch;
-		__le16 pad2;
-	} __packed hdr = {
-		.bw_2g = 0,
-		.bw_5g = 3,
-	};
-	struct mt7615_mcu_chan {
-		__le16 hw_value;
-		__le16 pad;
-		__le32 flags;
-	} __packed channel;
-	int len, i, n_max_channels, n_2ch = 0, n_5ch = 0;
-	struct ieee80211_channel *chan;
-	struct sk_buff *skb;
-
-	if (!mt7615_firmware_offload(dev))
-		return 0;
-
-	n_max_channels = mphy->sband_2g.sband.n_channels +
-			 mphy->sband_5g.sband.n_channels;
-	len = sizeof(hdr) + n_max_channels * sizeof(channel);
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
-	if (!skb)
-		return -ENOMEM;
-
-	skb_reserve(skb, sizeof(hdr));
-
-	for (i = 0; i < mphy->sband_2g.sband.n_channels; i++) {
-		chan = &mphy->sband_2g.sband.channels[i];
-		if (chan->flags & IEEE80211_CHAN_DISABLED)
-			continue;
-
-		channel.hw_value = cpu_to_le16(chan->hw_value);
-		channel.flags = cpu_to_le32(chan->flags);
-		channel.pad = 0;
-
-		skb_put_data(skb, &channel, sizeof(channel));
-		n_2ch++;
-	}
-	for (i = 0; i < mphy->sband_5g.sband.n_channels; i++) {
-		chan = &mphy->sband_5g.sband.channels[i];
-		if (chan->flags & IEEE80211_CHAN_DISABLED)
-			continue;
-
-		channel.hw_value = cpu_to_le16(chan->hw_value);
-		channel.flags = cpu_to_le32(chan->flags);
-		channel.pad = 0;
-
-		skb_put_data(skb, &channel, sizeof(channel));
-		n_5ch++;
-	}
-
-	BUILD_BUG_ON(sizeof(dev->mt76.alpha2) > sizeof(hdr.alpha2));
-	memcpy(hdr.alpha2, dev->mt76.alpha2, sizeof(dev->mt76.alpha2));
-	hdr.n_2ch = n_2ch;
-	hdr.n_5ch = n_5ch;
-
-	memcpy(__skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_SET_CHAN_DOMAIN,
-				     false);
-}
-
 #define MT7615_SCAN_CHANNEL_TIME	60
 int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 6ef5670211d1..79fb1af2d8a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -4,6 +4,8 @@
 #ifndef __MT7615_MCU_H
 #define __MT7615_MCU_H
 
+#include "../mt76_connac_mcu.h"
+
 struct mt7615_mcu_txd {
 	__le32 txd[8];
 
@@ -236,64 +238,6 @@ enum {
 	MCU_S2D_H2CN
 };
 
-#define MCU_FW_PREFIX		BIT(31)
-#define MCU_UNI_PREFIX		BIT(30)
-#define MCU_CE_PREFIX		BIT(29)
-#define MCU_QUERY_PREFIX	BIT(28)
-#define MCU_CMD_MASK		~(MCU_FW_PREFIX | MCU_UNI_PREFIX |	\
-				  MCU_CE_PREFIX | MCU_QUERY_PREFIX)
-
-#define MCU_QUERY_MASK		BIT(16)
-
-enum {
-	MCU_CMD_TARGET_ADDRESS_LEN_REQ = MCU_FW_PREFIX | 0x01,
-	MCU_CMD_FW_START_REQ = MCU_FW_PREFIX | 0x02,
-	MCU_CMD_INIT_ACCESS_REG = 0x3,
-	MCU_CMD_PATCH_START_REQ = 0x05,
-	MCU_CMD_PATCH_FINISH_REQ = MCU_FW_PREFIX | 0x07,
-	MCU_CMD_PATCH_SEM_CONTROL = MCU_FW_PREFIX | 0x10,
-	MCU_CMD_EXT_CID = 0xED,
-	MCU_CMD_FW_SCATTER = MCU_FW_PREFIX | 0xEE,
-	MCU_CMD_RESTART_DL_REQ = MCU_FW_PREFIX | 0xEF,
-};
-
-enum {
-	MCU_EXT_CMD_RF_REG_ACCESS = 0x02,
-	MCU_EXT_CMD_PM_STATE_CTRL = 0x07,
-	MCU_EXT_CMD_CHANNEL_SWITCH = 0x08,
-	MCU_EXT_CMD_SET_TX_POWER_CTRL = 0x11,
-	MCU_EXT_CMD_FW_LOG_2_HOST = 0x13,
-	MCU_EXT_CMD_EFUSE_BUFFER_MODE = 0x21,
-	MCU_EXT_CMD_STA_REC_UPDATE = 0x25,
-	MCU_EXT_CMD_BSS_INFO_UPDATE = 0x26,
-	MCU_EXT_CMD_EDCA_UPDATE = 0x27,
-	MCU_EXT_CMD_DEV_INFO_UPDATE = 0x2A,
-	MCU_EXT_CMD_GET_TEMP = 0x2c,
-	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
-	MCU_EXT_CMD_SET_RDD_CTRL = 0x3a,
-	MCU_EXT_CMD_ATE_CTRL = 0x3d,
-	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
-	MCU_EXT_CMD_DBDC_CTRL = 0x45,
-	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
-	MCU_EXT_CMD_MUAR_UPDATE = 0x48,
-	MCU_EXT_CMD_BCN_OFFLOAD = 0x49,
-	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
-	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
-	MCU_EXT_CMD_RXDCOC_CAL = 0x59,
-	MCU_EXT_CMD_TXDPD_CAL = 0x60,
-	MCU_EXT_CMD_SET_RDD_TH = 0x7c,
-	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
-};
-
-enum {
-	MCU_UNI_CMD_DEV_INFO_UPDATE = MCU_UNI_PREFIX | 0x01,
-	MCU_UNI_CMD_BSS_INFO_UPDATE = MCU_UNI_PREFIX | 0x02,
-	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
-	MCU_UNI_CMD_SUSPEND = MCU_UNI_PREFIX | 0x05,
-	MCU_UNI_CMD_OFFLOAD = MCU_UNI_PREFIX | 0x06,
-	MCU_UNI_CMD_HIF_CTRL = MCU_UNI_PREFIX | 0x07,
-};
-
 enum {
 	MCU_ATE_SET_FREQ_OFFSET = 0xa,
 	MCU_ATE_SET_TX_POWER_CONTROL = 0x15,
@@ -305,12 +249,6 @@ struct mt7615_mcu_uni_event {
 	__le32 status; /* 0: success, others: fail */
 } __packed;
 
-struct mt7615_beacon_loss_event {
-	u8 bss_idx;
-	u8 reason;
-	u8 pad[2];
-} __packed;
-
 struct mt7615_mcu_scan_ssid {
 	__le32 ssid_len;
 	u8 ssid[IEEE80211_MAX_SSID_LEN];
@@ -438,46 +376,6 @@ struct mt7615_mcu_reg_event {
 	__le32 val;
 } __packed;
 
-struct mt7615_mcu_bss_event {
-	u8 bss_idx;
-	u8 is_absent;
-	u8 free_quota;
-	u8 pad;
-} __packed;
-
-struct mt7615_bss_basic_tlv {
-	__le16 tag;
-	__le16 len;
-	u8 active;
-	u8 omac_idx;
-	u8 hw_bss_idx;
-	u8 band_idx;
-	__le32 conn_type;
-	u8 conn_state;
-	u8 wmm_idx;
-	u8 bssid[ETH_ALEN];
-	__le16 bmc_tx_wlan_idx;
-	__le16 bcn_interval;
-	u8 dtim_period;
-	u8 phymode; /* bit(0): A
-		     * bit(1): B
-		     * bit(2): G
-		     * bit(3): GN
-		     * bit(4): AN
-		     * bit(5): AC
-		     */
-	__le16 sta_idx;
-	u8 nonht_basic_phy;
-	u8 pad[3];
-} __packed;
-
-struct mt7615_bss_qos_tlv {
-	__le16 tag;
-	__le16 len;
-	u8 qos;
-	u8 pad[3];
-} __packed;
-
 enum {
 	WOW_USB = 1,
 	WOW_PCIE = 2,
@@ -594,36 +492,6 @@ struct mt7615_arpns_tlv {
 	u8 pad[1];
 } __packed;
 
-/* offload mcu commands */
-enum {
-	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
-	MCU_CMD_SET_PS_PROFILE = MCU_CE_PREFIX | 0x05,
-	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
-	MCU_CMD_SET_BSS_CONNECTED = MCU_CE_PREFIX | 0x16,
-	MCU_CMD_SET_BSS_ABORT = MCU_CE_PREFIX | 0x17,
-	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
-	MCU_CMD_SET_ROC = MCU_CE_PREFIX | 0x1c,
-	MCU_CMD_SET_P2P_OPPPS = MCU_CE_PREFIX | 0x33,
-	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
-	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
-	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
-	MCU_CMD_REG_READ = MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
-};
-
-#define MCU_CMD_ACK		BIT(0)
-#define MCU_CMD_UNI		BIT(1)
-#define MCU_CMD_QUERY		BIT(2)
-
-#define MCU_CMD_UNI_EXT_ACK	(MCU_CMD_ACK | MCU_CMD_UNI | MCU_CMD_QUERY)
-
-enum {
-	UNI_BSS_INFO_BASIC = 0,
-	UNI_BSS_INFO_RLM = 2,
-	UNI_BSS_INFO_BCN_CONTENT = 7,
-	UNI_BSS_INFO_QBSS = 15,
-	UNI_BSS_INFO_UAPSD = 19,
-};
-
 enum {
 	UNI_SUSPEND_MODE_SETTING,
 	UNI_SUSPEND_WOW_CTRL,
@@ -639,11 +507,6 @@ enum {
 	UNI_OFFLOAD_OFFLOAD_BMC_RPY_DETECT,
 };
 
-enum {
-	PATCH_SEM_RELEASE = 0x0,
-	PATCH_SEM_GET	  = 0x1
-};
-
 enum {
 	PATCH_NOT_DL_SEM_FAIL	 = 0x0,
 	PATCH_IS_DL		 = 0x1,
@@ -664,34 +527,6 @@ enum {
 	FW_STATE_N9_RDY = 2,
 };
 
-#define STA_TYPE_STA		BIT(0)
-#define STA_TYPE_AP		BIT(1)
-#define STA_TYPE_ADHOC		BIT(2)
-#define STA_TYPE_WDS		BIT(4)
-#define STA_TYPE_BC		BIT(5)
-
-#define NETWORK_INFRA		BIT(16)
-#define NETWORK_P2P		BIT(17)
-#define NETWORK_IBSS		BIT(18)
-#define NETWORK_WDS		BIT(21)
-
-#define CONNECTION_INFRA_STA	(STA_TYPE_STA | NETWORK_INFRA)
-#define CONNECTION_INFRA_AP	(STA_TYPE_AP | NETWORK_INFRA)
-#define CONNECTION_P2P_GC	(STA_TYPE_STA | NETWORK_P2P)
-#define CONNECTION_P2P_GO	(STA_TYPE_AP | NETWORK_P2P)
-#define CONNECTION_IBSS_ADHOC	(STA_TYPE_ADHOC | NETWORK_IBSS)
-#define CONNECTION_WDS		(STA_TYPE_WDS | NETWORK_WDS)
-#define CONNECTION_INFRA_BC	(STA_TYPE_BC | NETWORK_INFRA)
-
-#define CONN_STATE_DISCONNECT	0
-#define CONN_STATE_CONNECT	1
-#define CONN_STATE_PORT_SECURE	2
-
-enum {
-	DEV_INFO_ACTIVE,
-	DEV_INFO_MAX_NUM
-};
-
 enum {
 	DBDC_TYPE_WMM,
 	DBDC_TYPE_MGMT,
@@ -704,11 +539,6 @@ enum {
 	__DBDC_TYPE_MAX,
 };
 
-struct tlv {
-	__le16 tag;
-	__le16 len;
-} __packed;
-
 struct bss_info_omac {
 	__le16 tag;
 	__le16 len;
@@ -767,157 +597,6 @@ enum {
 	BSS_INFO_MAX_NUM
 };
 
-enum {
-	WTBL_RESET_AND_SET = 1,
-	WTBL_SET,
-	WTBL_QUERY,
-	WTBL_RESET_ALL
-};
-
-struct wtbl_req_hdr {
-	u8 wlan_idx;
-	u8 operation;
-	__le16 tlv_num;
-	u8 rsv[4];
-} __packed;
-
-struct wtbl_generic {
-	__le16 tag;
-	__le16 len;
-	u8 peer_addr[ETH_ALEN];
-	u8 muar_idx;
-	u8 skip_tx;
-	u8 cf_ack;
-	u8 qos;
-	u8 mesh;
-	u8 adm;
-	__le16 partial_aid;
-	u8 baf_en;
-	u8 aad_om;
-} __packed;
-
-struct wtbl_rx {
-	__le16 tag;
-	__le16 len;
-	u8 rcid;
-	u8 rca1;
-	u8 rca2;
-	u8 rv;
-	u8 rsv[4];
-} __packed;
-
-struct wtbl_ht {
-	__le16 tag;
-	__le16 len;
-	u8 ht;
-	u8 ldpc;
-	u8 af;
-	u8 mm;
-	u8 rsv[4];
-} __packed;
-
-struct wtbl_vht {
-	__le16 tag;
-	__le16 len;
-	u8 ldpc;
-	u8 dyn_bw;
-	u8 vht;
-	u8 txop_ps;
-	u8 rsv[4];
-} __packed;
-
-struct wtbl_tx_ps {
-	__le16 tag;
-	__le16 len;
-	u8 txps;
-	u8 rsv[3];
-} __packed;
-
-struct wtbl_hdr_trans {
-	__le16 tag;
-	__le16 len;
-	u8 to_ds;
-	u8 from_ds;
-	u8 disable_rx_trans;
-	u8 rsv;
-} __packed;
-
-enum {
-	MT_BA_TYPE_INVALID,
-	MT_BA_TYPE_ORIGINATOR,
-	MT_BA_TYPE_RECIPIENT
-};
-
-enum {
-	RST_BA_MAC_TID_MATCH,
-	RST_BA_MAC_MATCH,
-	RST_BA_NO_MATCH
-};
-
-struct wtbl_ba {
-	__le16 tag;
-	__le16 len;
-	/* common */
-	u8 tid;
-	u8 ba_type;
-	u8 rsv0[2];
-	/* originator only */
-	__le16 sn;
-	u8 ba_en;
-	u8 ba_winsize_idx;
-	__le16 ba_winsize;
-	/* recipient only */
-	u8 peer_addr[ETH_ALEN];
-	u8 rst_ba_tid;
-	u8 rst_ba_sel;
-	u8 rst_ba_sb;
-	u8 band_idx;
-	u8 rsv1[4];
-} __packed;
-
-struct wtbl_bf {
-	__le16 tag;
-	__le16 len;
-	u8 ibf;
-	u8 ebf;
-	u8 ibf_vht;
-	u8 ebf_vht;
-	u8 gid;
-	u8 pfmu_idx;
-	u8 rsv[2];
-} __packed;
-
-struct wtbl_smps {
-	__le16 tag;
-	__le16 len;
-	u8 smps;
-	u8 rsv[3];
-} __packed;
-
-struct wtbl_pn {
-	__le16 tag;
-	__le16 len;
-	u8 pn[6];
-	u8 rsv[2];
-} __packed;
-
-struct wtbl_spe {
-	__le16 tag;
-	__le16 len;
-	u8 spe_idx;
-	u8 rsv[3];
-} __packed;
-
-struct wtbl_raw {
-	__le16 tag;
-	__le16 len;
-	u8 wtbl_idx;
-	u8 dw;
-	u8 rsv[2];
-	__le32 msk;
-	__le32 val;
-} __packed;
-
 #define MT7615_WTBL_UPDATE_MAX_SIZE	(sizeof(struct wtbl_req_hdr) +	\
 					 sizeof(struct wtbl_generic) +	\
 					 sizeof(struct wtbl_rx) +	\
@@ -942,127 +621,6 @@ struct wtbl_raw {
 #define MT7615_WTBL_UPDATE_BA_SIZE	(sizeof(struct wtbl_req_hdr) +	\
 					 sizeof(struct wtbl_ba))
 
-enum {
-	WTBL_GENERIC,
-	WTBL_RX,
-	WTBL_HT,
-	WTBL_VHT,
-	WTBL_PEER_PS, /* not used */
-	WTBL_TX_PS,
-	WTBL_HDR_TRANS,
-	WTBL_SEC_KEY,
-	WTBL_BA,
-	WTBL_RDG, /* obsoleted */
-	WTBL_PROTECT, /* not used */
-	WTBL_CLEAR, /* not used */
-	WTBL_BF,
-	WTBL_SMPS,
-	WTBL_RAW_DATA, /* debug only */
-	WTBL_PN,
-	WTBL_SPE,
-	WTBL_MAX_NUM
-};
-
-struct sta_ntlv_hdr {
-	u8 rsv[2];
-	__le16 tlv_num;
-} __packed;
-
-struct sta_req_hdr {
-	u8 bss_idx;
-	u8 wlan_idx;
-	__le16 tlv_num;
-	u8 is_tlv_append;
-	u8 muar_idx;
-	u8 rsv[2];
-} __packed;
-
-struct sta_rec_state {
-	__le16 tag;
-	__le16 len;
-	u8 state;
-	__le32 flags;
-	u8 vhtop;
-	u8 pad[2];
-} __packed;
-
-struct sta_rec_basic {
-	__le16 tag;
-	__le16 len;
-	__le32 conn_type;
-	u8 conn_state;
-	u8 qos;
-	__le16 aid;
-	u8 peer_addr[ETH_ALEN];
-#define EXTRA_INFO_VER	BIT(0)
-#define EXTRA_INFO_NEW	BIT(1)
-	__le16 extra_info;
-} __packed;
-
-struct sta_rec_ht {
-	__le16 tag;
-	__le16 len;
-	__le16 ht_cap;
-	u16 rsv;
-} __packed;
-
-struct sta_rec_vht {
-	__le16 tag;
-	__le16 len;
-	__le32 vht_cap;
-	__le16 vht_rx_mcs_map;
-	__le16 vht_tx_mcs_map;
-} __packed;
-
-struct sta_rec_ba {
-	__le16 tag;
-	__le16 len;
-	u8 tid;
-	u8 ba_type;
-	u8 amsdu;
-	u8 ba_en;
-	__le16 ssn;
-	__le16 winsize;
-} __packed;
-
-struct sta_rec_uapsd {
-	__le16 tag;
-	__le16 len;
-	u8 dac_map;
-	u8 tac_map;
-	u8 max_sp;
-	u8 rsv0;
-	__le16 listen_interval;
-	u8 rsv1[2];
-} __packed;
-
-enum {
-	STA_REC_BASIC,
-	STA_REC_RA,
-	STA_REC_RA_CMM_INFO,
-	STA_REC_RA_UPDATE,
-	STA_REC_BF,
-	STA_REC_AMSDU, /* for CR4 */
-	STA_REC_BA,
-	STA_REC_STATE,
-	STA_REC_TX_PROC, /* for hdr trans and CSO in CR4 */
-	STA_REC_HT,
-	STA_REC_VHT,
-	STA_REC_APPS,
-	STA_REC_WTBL = 13,
-	STA_REC_MAX_NUM
-};
-
-enum {
-	CMD_CBW_20MHZ,
-	CMD_CBW_40MHZ,
-	CMD_CBW_80MHZ,
-	CMD_CBW_160MHZ,
-	CMD_CBW_10MHZ,
-	CMD_CBW_5MHZ,
-	CMD_CBW_8080MHZ
-};
-
 enum {
 	CH_SWITCH_NORMAL = 0,
 	CH_SWITCH_SCAN = 3,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index ba820f85063b..2ed59a141b14 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -200,9 +200,9 @@ struct mt7615_phy {
 
 #define mt7615_mcu_add_tx_ba(dev, ...)	(dev)->mcu_ops->add_tx_ba((dev), __VA_ARGS__)
 #define mt7615_mcu_add_rx_ba(dev, ...)	(dev)->mcu_ops->add_rx_ba((dev), __VA_ARGS__)
-#define mt7615_mcu_sta_add(dev, ...)	(dev)->mcu_ops->sta_add((dev),  __VA_ARGS__)
-#define mt7615_mcu_add_dev_info(dev, ...) (dev)->mcu_ops->add_dev_info((dev),  __VA_ARGS__)
-#define mt7615_mcu_add_bss_info(phy, ...) (phy->dev)->mcu_ops->add_bss_info((phy),  __VA_ARGS__)
+#define mt7615_mcu_sta_add(phy, ...)	((phy)->dev)->mcu_ops->sta_add((phy),  __VA_ARGS__)
+#define mt7615_mcu_add_dev_info(phy, ...) ((phy)->dev)->mcu_ops->add_dev_info((phy),  __VA_ARGS__)
+#define mt7615_mcu_add_bss_info(phy, ...) ((phy)->dev)->mcu_ops->add_bss_info((phy),  __VA_ARGS__)
 #define mt7615_mcu_add_beacon(dev, ...)	(dev)->mcu_ops->add_beacon_offload((dev),  __VA_ARGS__)
 #define mt7615_mcu_set_pm(dev, ...)	(dev)->mcu_ops->set_pm_state((dev),  __VA_ARGS__)
 #define mt7615_mcu_set_drv_ctrl(dev)	(dev)->mcu_ops->set_drv_ctrl((dev))
@@ -214,11 +214,10 @@ struct mt7615_mcu_ops {
 	int (*add_rx_ba)(struct mt7615_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
-	int (*sta_add)(struct mt7615_dev *dev,
-		       struct ieee80211_vif *vif,
+	int (*sta_add)(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta, bool enable);
-	int (*add_dev_info)(struct mt7615_dev *dev,
-			    struct ieee80211_vif *vif, bool enable);
+	int (*add_dev_info)(struct mt7615_phy *phy, struct ieee80211_vif *vif,
+			    bool enable);
 	int (*add_bss_info)(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, bool enable);
 	int (*add_beacon_offload)(struct mt7615_dev *dev,
@@ -315,20 +314,6 @@ enum tx_pkt_queue_idx {
 	MT_LMAC_PSMP1,
 };
 
-enum {
-	HW_BSSID_0 = 0x0,
-	HW_BSSID_1,
-	HW_BSSID_2,
-	HW_BSSID_3,
-	HW_BSSID_MAX = HW_BSSID_3,
-	EXT_BSSID_START = 0x10,
-	EXT_BSSID_1,
-	EXT_BSSID_15 = 0x1f,
-	EXT_BSSID_MAX = EXT_BSSID_15,
-	REPEATER_BSSID_START = 0x20,
-	REPEATER_BSSID_MAX = 0x3f,
-};
-
 enum {
 	MT_RX_SEL0,
 	MT_RX_SEL1,
@@ -546,14 +531,11 @@ u32 mt7615_rf_rr(struct mt7615_dev *dev, u32 wf, u32 reg);
 int mt7615_rf_wr(struct mt7615_dev *dev, u32 wf, u32 reg, u32 val);
 int mt7615_mcu_set_dbdc(struct mt7615_dev *dev);
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
-int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable);
-int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val);
 int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index);
 int mt7615_mcu_set_tx_power(struct mt7615_phy *phy);
 void mt7615_mcu_exit(struct mt7615_dev *dev);
 void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 			 int cmd, int *wait_seq);
-int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy);
 int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req);
 int mt7615_mcu_cancel_hw_scan(struct mt7615_phy *phy,
@@ -592,7 +574,6 @@ int mt7615_mcu_set_test_param(struct mt7615_dev *dev, u8 param, bool test_mode,
 int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable);
 int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy);
 int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy);
-int mt7615_mcu_set_vif_ps(struct mt7615_dev *dev, struct ieee80211_vif *vif);
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
 int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index dbd29d897b29..b78014926f1f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 
 #include "mt7615.h"
+#include "mcu.h"
 
 static const struct pci_device_id mt7615_pci_device_table[] = {
 	{ PCI_DEVICE(0x14c3, 0x7615) },
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 26b29115c16f..ff757c4a2377 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -17,6 +17,7 @@
 #include "mt7615.h"
 #include "sdio.h"
 #include "mac.h"
+#include "mcu.h"
 
 static const struct sdio_device_id mt7663s_table[] = {
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7603) },
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
new file mode 100644
index 000000000000..c48ccda6935d
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -0,0 +1,986 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include "mt76_connac_mcu.h"
+
+int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option)
+{
+	struct {
+		__le32 option;
+		__le32 addr;
+	} req = {
+		.option = cpu_to_le32(option),
+		.addr = cpu_to_le32(addr),
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD_FW_START_REQ, &req, sizeof(req),
+				 true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_start_firmware);
+
+int mt76_connac_mcu_patch_sem_ctrl(struct mt76_dev *dev, bool get)
+{
+	u32 op = get ? PATCH_SEM_GET : PATCH_SEM_RELEASE;
+	struct {
+		__le32 op;
+	} req = {
+		.op = cpu_to_le32(op),
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD_PATCH_SEM_CONTROL, &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_patch_sem_ctrl);
+
+int mt76_connac_mcu_start_patch(struct mt76_dev *dev)
+{
+	struct {
+		u8 check_crc;
+		u8 reserved[3];
+	} req = {
+		.check_crc = 0,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD_PATCH_FINISH_REQ, &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_start_patch);
+
+#define MCU_PATCH_ADDRESS	0x200000
+
+int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
+				  u32 mode)
+{
+	struct {
+		__le32 addr;
+		__le32 len;
+		__le32 mode;
+	} req = {
+		.addr = cpu_to_le32(addr),
+		.len = cpu_to_le32(len),
+		.mode = cpu_to_le32(mode),
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD_TARGET_ADDRESS_LEN_REQ, &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_init_download);
+
+int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy)
+{
+	struct mt76_dev *dev = phy->dev;
+	struct mt76_connac_mcu_channel_domain {
+		u8 alpha2[4]; /* regulatory_request.alpha2 */
+		u8 bw_2g; /* BW_20_40M		0
+			   * BW_20M		1
+			   * BW_20_40_80M	2
+			   * BW_20_40_80_160M	3
+			   * BW_20_40_80_8080M	4
+			   */
+		u8 bw_5g;
+		__le16 pad;
+		u8 n_2ch;
+		u8 n_5ch;
+		__le16 pad2;
+	} __packed hdr = {
+		.bw_2g = 0,
+		.bw_5g = 3,
+	};
+	struct mt76_connac_mcu_chan {
+		__le16 hw_value;
+		__le16 pad;
+		__le32 flags;
+	} __packed channel;
+	int len, i, n_max_channels, n_2ch = 0, n_5ch = 0;
+	struct ieee80211_channel *chan;
+	struct sk_buff *skb;
+
+	n_max_channels = phy->sband_2g.sband.n_channels +
+			 phy->sband_5g.sband.n_channels;
+	len = sizeof(hdr) + n_max_channels * sizeof(channel);
+
+	skb = mt76_mcu_msg_alloc(dev, NULL, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_reserve(skb, sizeof(hdr));
+
+	for (i = 0; i < phy->sband_2g.sband.n_channels; i++) {
+		chan = &phy->sband_2g.sband.channels[i];
+		if (chan->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		channel.hw_value = cpu_to_le16(chan->hw_value);
+		channel.flags = cpu_to_le32(chan->flags);
+		channel.pad = 0;
+
+		skb_put_data(skb, &channel, sizeof(channel));
+		n_2ch++;
+	}
+	for (i = 0; i < phy->sband_5g.sband.n_channels; i++) {
+		chan = &phy->sband_5g.sband.channels[i];
+		if (chan->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		channel.hw_value = cpu_to_le16(chan->hw_value);
+		channel.flags = cpu_to_le32(chan->flags);
+		channel.pad = 0;
+
+		skb_put_data(skb, &channel, sizeof(channel));
+		n_5ch++;
+	}
+
+	BUILD_BUG_ON(sizeof(dev->alpha2) > sizeof(hdr.alpha2));
+	memcpy(hdr.alpha2, dev->alpha2, sizeof(dev->alpha2));
+	hdr.n_2ch = n_2ch;
+	hdr.n_5ch = n_5ch;
+
+	memcpy(__skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_CMD_SET_CHAN_DOMAIN, false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_channel_domain);
+
+int mt76_connac_mcu_set_mac_enable(struct mt76_dev *dev, int band, bool enable,
+				   bool hdr_trans)
+{
+	struct {
+		u8 enable;
+		u8 band;
+		u8 rsv[2];
+	} __packed req_mac = {
+		.enable = enable,
+		.band = band,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD_MAC_INIT_CTRL, &req_mac,
+				 sizeof(req_mac), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_mac_enable);
+
+int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct {
+		u8 bss_idx;
+		u8 ps_state; /* 0: device awake
+			      * 1: static power save
+			      * 2: dynamic power saving
+			      */
+	} req = {
+		.bss_idx = mvif->idx,
+		.ps_state = vif->bss_conf.ps ? 2 : 0,
+	};
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return -EOPNOTSUPP;
+
+	return mt76_mcu_send_msg(dev, MCU_CMD_SET_PS_PROFILE, &req,
+				 sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_vif_ps);
+
+int mt76_connac_mcu_set_rts_thresh(struct mt76_dev *dev, u32 val, u8 band)
+{
+	struct {
+		u8 prot_idx;
+		u8 band;
+		u8 rsv[2];
+		__le32 len_thresh;
+		__le32 pkt_thresh;
+	} __packed req = {
+		.prot_idx = 1,
+		.band = band,
+		.len_thresh = cpu_to_le32(val),
+		.pkt_thresh = cpu_to_le32(0x2),
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD_PROTECT_CTRL, &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_rts_thresh);
+
+void mt76_connac_mcu_beacon_loss_iter(void *priv, u8 *mac,
+				      struct ieee80211_vif *vif)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_connac_beacon_loss_event *event = priv;
+
+	if (mvif->idx != event->bss_idx)
+		return;
+
+	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER))
+		return;
+
+	ieee80211_beacon_loss(vif);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_beacon_loss_iter);
+
+struct tlv *
+mt76_connac_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
+			       void *sta_ntlv, void *sta_wtbl)
+{
+	struct sta_ntlv_hdr *ntlv_hdr = sta_ntlv;
+	struct tlv *sta_hdr = sta_wtbl;
+	struct tlv *ptlv, tlv = {
+		.tag = cpu_to_le16(tag),
+		.len = cpu_to_le16(len),
+	};
+	u16 ntlv;
+
+	ptlv = skb_put(skb, len);
+	memcpy(ptlv, &tlv, sizeof(tlv));
+
+	ntlv = le16_to_cpu(ntlv_hdr->tlv_num);
+	ntlv_hdr->tlv_num = cpu_to_le16(ntlv + 1);
+
+	if (sta_hdr) {
+		u16 size = le16_to_cpu(sta_hdr->len);
+
+		sta_hdr->len = cpu_to_le16(size + len);
+	}
+
+	return ptlv;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_nested_tlv);
+
+struct sk_buff *
+mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
+			      struct mt76_wcid *wcid)
+{
+	struct sta_req_hdr hdr = {
+		.bss_idx = mvif->idx,
+		.muar_idx = wcid ? mvif->omac_idx : 0,
+		.wlan_idx_lo = wcid ? wcid->idx : 0,
+		.is_tlv_append = 1,
+	};
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(dev, NULL, MT76_CONNAC_STA_UPDATE_MAX_SIZE);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_alloc_sta_req);
+
+struct wtbl_req_hdr *
+mt76_connac_mcu_alloc_wtbl_req(struct mt76_dev *dev, struct mt76_wcid *wcid,
+			       int cmd, void *sta_wtbl, struct sk_buff **skb)
+{
+	struct tlv *sta_hdr = sta_wtbl;
+	struct wtbl_req_hdr hdr = {
+		.wlan_idx_lo = wcid ? wcid->idx : 0,
+		.operation = cmd,
+	};
+	struct sk_buff *nskb = *skb;
+
+	if (!nskb) {
+		nskb = mt76_mcu_msg_alloc(dev, NULL,
+					  MT76_CONNAC_WTBL_UPDATE_BA_SIZE);
+		if (!nskb)
+			return ERR_PTR(-ENOMEM);
+
+		*skb = nskb;
+	}
+
+	if (sta_hdr)
+		sta_hdr->len = cpu_to_le16(sizeof(hdr));
+
+	return skb_put_data(nskb, &hdr, sizeof(hdr));
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_alloc_wtbl_req);
+
+void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta,
+				   bool enable)
+{
+	struct sta_rec_basic *basic;
+	struct tlv *tlv;
+	int conn_type;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic));
+
+	basic = (struct sta_rec_basic *)tlv;
+	basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
+
+	if (enable) {
+		basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
+		basic->conn_state = CONN_STATE_PORT_SECURE;
+	} else {
+		basic->conn_state = CONN_STATE_DISCONNECT;
+	}
+
+	if (!sta) {
+		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
+		eth_broadcast_addr(basic->peer_addr);
+		return;
+	}
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic->conn_type = cpu_to_le32(conn_type);
+		basic->aid = cpu_to_le16(sta->aid);
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic->conn_type = cpu_to_le32(conn_type);
+		basic->aid = cpu_to_le16(vif->bss_conf.aid);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		basic->aid = cpu_to_le16(sta->aid);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	memcpy(basic->peer_addr, sta->addr, ETH_ALEN);
+	basic->qos = sta->wme;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_basic_tlv);
+
+static void
+mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta)
+{
+	struct sta_rec_uapsd *uapsd;
+	struct tlv *tlv;
+
+	if (vif->type != NL80211_IFTYPE_AP || !sta->wme)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_APPS, sizeof(*uapsd));
+	uapsd = (struct sta_rec_uapsd *)tlv;
+
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO) {
+		uapsd->dac_map |= BIT(3);
+		uapsd->tac_map |= BIT(3);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VI) {
+		uapsd->dac_map |= BIT(2);
+		uapsd->tac_map |= BIT(2);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BE) {
+		uapsd->dac_map |= BIT(1);
+		uapsd->tac_map |= BIT(1);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BK) {
+		uapsd->dac_map |= BIT(0);
+		uapsd->tac_map |= BIT(0);
+	}
+	uapsd->max_sp = sta->max_sp;
+}
+
+void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
+				      struct sk_buff *skb,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_sta *sta,
+				      void *sta_wtbl, void *wtbl_tlv)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct wtbl_generic *generic;
+	struct wtbl_rx *rx;
+	struct wtbl_spe *spe;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_GENERIC,
+					     sizeof(*generic),
+					     wtbl_tlv, sta_wtbl);
+
+	generic = (struct wtbl_generic *)tlv;
+
+	if (sta) {
+		if (vif->type == NL80211_IFTYPE_STATION)
+			generic->partial_aid = cpu_to_le16(vif->bss_conf.aid);
+		else
+			generic->partial_aid = cpu_to_le16(sta->aid);
+		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
+		generic->muar_idx = mvif->omac_idx;
+		generic->qos = sta->wme;
+	} else {
+		eth_broadcast_addr(generic->peer_addr);
+		generic->muar_idx = 0xe;
+	}
+
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_RX, sizeof(*rx),
+					     wtbl_tlv, sta_wtbl);
+
+	rx = (struct wtbl_rx *)tlv;
+	rx->rca1 = sta ? vif->type != NL80211_IFTYPE_AP : 1;
+	rx->rca2 = 1;
+	rx->rv = 1;
+
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_SPE, sizeof(*spe),
+					     wtbl_tlv, sta_wtbl);
+	spe = (struct wtbl_spe *)tlv;
+	spe->spe_idx = 24;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_generic_tlv);
+
+void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
+			     struct ieee80211_sta *sta,
+			     struct ieee80211_vif *vif)
+{
+	struct tlv *tlv;
+
+	/* starec ht */
+	if (sta->ht_cap.ht_supported) {
+		struct sta_rec_ht *ht;
+
+		tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
+		ht = (struct sta_rec_ht *)tlv;
+		ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
+	}
+
+	/* starec vht */
+	if (sta->vht_cap.vht_supported) {
+		struct sta_rec_vht *vht;
+
+		tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_VHT,
+					      sizeof(*vht) - 4);
+		vht = (struct sta_rec_vht *)tlv;
+		vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
+		vht->vht_rx_mcs_map = sta->vht_cap.vht_mcs.rx_mcs_map;
+		vht->vht_tx_mcs_map = sta->vht_cap.vht_mcs.tx_mcs_map;
+	}
+
+	/* starec uapsd */
+	mt76_connac_mcu_sta_uapsd(skb, vif, sta);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_tlv);
+
+static void
+mt76_connac_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+			      void *sta_wtbl, void *wtbl_tlv)
+{
+	struct wtbl_smps *smps;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
+					     wtbl_tlv, sta_wtbl);
+	smps = (struct wtbl_smps *)tlv;
+
+	if (sta->smps_mode == IEEE80211_SMPS_DYNAMIC)
+		smps->smps = true;
+}
+
+void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
+				 struct ieee80211_sta *sta, void *sta_wtbl,
+				 void *wtbl_tlv)
+{
+	struct wtbl_ht *ht = NULL;
+	struct tlv *tlv;
+	u32 flags = 0;
+
+	if (sta->ht_cap.ht_supported) {
+		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
+						     wtbl_tlv, sta_wtbl);
+		ht = (struct wtbl_ht *)tlv;
+		ht->ldpc = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
+		ht->af = sta->ht_cap.ampdu_factor;
+		ht->mm = sta->ht_cap.ampdu_density;
+		ht->ht = true;
+	}
+
+	if (sta->vht_cap.vht_supported) {
+		struct wtbl_vht *vht;
+		u8 af;
+
+		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_VHT,
+						     sizeof(*vht), wtbl_tlv,
+						     sta_wtbl);
+		vht = (struct wtbl_vht *)tlv;
+		vht->ldpc = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
+		vht->vht = true;
+
+		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+			       sta->vht_cap.cap);
+		if (ht)
+			ht->af = max(ht->af, af);
+	}
+
+	mt76_connac_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
+
+	if (sta->ht_cap.ht_supported) {
+		/* sgi */
+		u32 msk = MT_WTBL_W5_SHORT_GI_20 | MT_WTBL_W5_SHORT_GI_40 |
+			  MT_WTBL_W5_SHORT_GI_80 | MT_WTBL_W5_SHORT_GI_160;
+		struct wtbl_raw *raw;
+
+		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_RAW_DATA,
+						     sizeof(*raw), wtbl_tlv,
+						     sta_wtbl);
+
+		if (sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20)
+			flags |= MT_WTBL_W5_SHORT_GI_20;
+		if (sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_40)
+			flags |= MT_WTBL_W5_SHORT_GI_40;
+
+		if (sta->vht_cap.vht_supported) {
+			if (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
+				flags |= MT_WTBL_W5_SHORT_GI_80;
+			if (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160)
+				flags |= MT_WTBL_W5_SHORT_GI_160;
+		}
+		raw = (struct wtbl_raw *)tlv;
+		raw->val = cpu_to_le32(flags);
+		raw->msk = cpu_to_le32(~msk);
+		raw->wtbl_idx = 1;
+		raw->dw = 5;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ht_tlv);
+
+int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				struct mt76_wcid *wcid,
+				bool enable, int cmd)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_dev *dev = phy->dev;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+
+	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt76_connac_mcu_sta_basic_tlv(skb, vif, sta, enable);
+	if (enable && sta)
+		mt76_connac_mcu_sta_tlv(phy, skb, sta, vif);
+
+	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
+					   sizeof(struct tlv));
+
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, wcid,
+						  WTBL_RESET_AND_SET,
+						  sta_wtbl, &skb);
+	if (enable) {
+		mt76_connac_mcu_wtbl_generic_tlv(dev, skb, vif, sta, sta_wtbl,
+						 wtbl_hdr);
+		if (sta)
+			mt76_connac_mcu_wtbl_ht_tlv(dev, skb, sta, sta_wtbl,
+						    wtbl_hdr);
+	}
+
+	return mt76_mcu_skb_send_msg(dev, skb, cmd, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_sta_cmd);
+
+void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
+				 struct ieee80211_ampdu_params *params,
+				 bool enable, bool tx, void *sta_wtbl,
+				 void *wtbl_tlv)
+{
+	struct wtbl_ba *ba;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_BA, sizeof(*ba),
+					     wtbl_tlv, sta_wtbl);
+
+	ba = (struct wtbl_ba *)tlv;
+	ba->tid = params->tid;
+
+	if (tx) {
+		ba->ba_type = MT_BA_TYPE_ORIGINATOR;
+		ba->sn = enable ? cpu_to_le16(params->ssn) : 0;
+		ba->ba_winsize = enable ? cpu_to_le16(params->buf_size) : 0;
+		ba->ba_en = enable;
+	} else {
+		memcpy(ba->peer_addr, params->sta->addr, ETH_ALEN);
+		ba->ba_type = MT_BA_TYPE_RECIPIENT;
+		ba->rst_ba_tid = params->tid;
+		ba->rst_ba_sel = RST_BA_MAC_TID_MATCH;
+		ba->rst_ba_sb = 1;
+	}
+
+	if (enable && tx) {
+		u8 ba_range[] = { 4, 8, 12, 24, 36, 48, 54, 64 };
+		int i;
+
+		for (i = 7; i > 0; i--) {
+			if (params->buf_size >= ba_range[i])
+				break;
+		}
+		ba->ba_winsize_idx = i;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ba_tlv);
+
+int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
+				struct ieee80211_vif *vif,
+				struct mt76_wcid *wcid,
+				bool enable)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 pad;
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 pad;
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} dev_req = {
+		.hdr = {
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = enable,
+		},
+	};
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_bss_basic_tlv basic;
+	} basic_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_basic_tlv)),
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = enable,
+			.bmc_tx_wlan_idx = cpu_to_le16(wcid->idx),
+			.sta_idx = cpu_to_le16(wcid->idx),
+			.conn_state = 1,
+		},
+	};
+	int err, idx, cmd, len;
+	void *data;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
+		break;
+	case NL80211_IFTYPE_STATION:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	basic_req.basic.hw_bss_idx = idx;
+
+	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+
+	cmd = enable ? MCU_UNI_CMD_DEV_INFO_UPDATE : MCU_UNI_CMD_BSS_INFO_UPDATE;
+	data = enable ? (void *)&dev_req : (void *)&basic_req;
+	len = enable ? sizeof(dev_req) : sizeof(basic_req);
+
+	err = mt76_mcu_send_msg(dev, cmd, data, len, true);
+	if (err < 0)
+		return err;
+
+	cmd = enable ? MCU_UNI_CMD_BSS_INFO_UPDATE : MCU_UNI_CMD_DEV_INFO_UPDATE;
+	data = enable ? (void *)&basic_req : (void *)&dev_req;
+	len = enable ? sizeof(basic_req) : sizeof(dev_req);
+
+	return mt76_mcu_send_msg(dev, cmd, data, len, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_dev);
+
+void mt76_connac_mcu_sta_ba_tlv(struct sk_buff *skb,
+				struct ieee80211_ampdu_params *params,
+				bool enable, bool tx)
+{
+	struct sta_rec_ba *ba;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));
+
+	ba = (struct sta_rec_ba *)tlv;
+	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT;
+	ba->winsize = cpu_to_le16(params->buf_size);
+	ba->ssn = cpu_to_le16(params->ssn);
+	ba->ba_en = enable << params->tid;
+	ba->amsdu = params->amsdu;
+	ba->tid = params->tid;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba_tlv);
+
+int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
+			   struct ieee80211_ampdu_params *params,
+			   bool enable, bool tx)
+{
+	struct mt76_wcid *wcid = (struct mt76_wcid *)params->sta->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
+					   sizeof(struct tlv));
+
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, wcid, WTBL_SET,
+						  sta_wtbl, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	mt76_connac_mcu_wtbl_ba_tlv(dev, skb, params, enable, tx, sta_wtbl,
+				    wtbl_hdr);
+
+	ret = mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD_STA_REC_UPDATE, true);
+	if (ret)
+		return ret;
+
+	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, tx);
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD_STA_REC_UPDATE,
+				     true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba);
+
+static const struct ieee80211_sta_he_cap *
+mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif)
+{
+	enum nl80211_band band = phy->chandef.chan->band;
+	struct ieee80211_supported_band *sband;
+
+	sband = phy->hw->wiphy->bands[band];
+
+	return ieee80211_get_he_iftype_cap(sband, vif->type);
+}
+
+#define DEFAULT_HE_PE_DURATION		4
+#define DEFAULT_HE_DURATION_RTS_THRES	1023
+static void
+mt76_connac_mcu_uni_bss_he_tlv(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			       struct tlv *tlv)
+{
+	const struct ieee80211_sta_he_cap *cap;
+	struct bss_info_uni_he *he;
+
+	cap = mt76_connac_get_he_phy_cap(phy, vif);
+
+	he = (struct bss_info_uni_he *)tlv;
+	he->he_pe_duration = vif->bss_conf.htc_trig_based_pkt_ext;
+	if (!he->he_pe_duration)
+		he->he_pe_duration = DEFAULT_HE_PE_DURATION;
+
+	he->he_rts_thres = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
+	if (!he->he_rts_thres)
+		he->he_rts_thres = cpu_to_le16(DEFAULT_HE_DURATION_RTS_THRES);
+
+	he->max_nss_mcs[CMD_HE_MCS_BW80] = cap->he_mcs_nss_supp.tx_mcs_80;
+	he->max_nss_mcs[CMD_HE_MCS_BW160] = cap->he_mcs_nss_supp.tx_mcs_160;
+	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
+}
+
+int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
+				struct ieee80211_vif *vif,
+				struct mt76_wcid *wcid,
+				bool enable)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = &phy->chandef;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	struct mt76_dev *mdev = phy->dev;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_bss_basic_tlv basic;
+		struct mt76_connac_bss_qos_tlv qos;
+	} basic_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_basic_tlv)),
+			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+			.dtim_period = vif->bss_conf.dtim_period,
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = true, /* keep bss deactivated */
+			.phymode = 0x38,
+		},
+		.qos = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_QBSS),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_qos_tlv)),
+			.qos = vif->bss_conf.qos,
+		},
+	};
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct rlm_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 control_channel;
+			u8 center_chan;
+			u8 center_chan2;
+			u8 bw;
+			u8 tx_streams;
+			u8 rx_streams;
+			u8 short_st;
+			u8 ht_op_info;
+			u8 sco;
+			u8 pad[3];
+		} __packed rlm;
+	} __packed rlm_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.rlm = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_RLM),
+			.len = cpu_to_le16(sizeof(struct rlm_tlv)),
+			.control_channel = chandef->chan->hw_value,
+			.center_chan = ieee80211_frequency_to_channel(freq1),
+			.center_chan2 = ieee80211_frequency_to_channel(freq2),
+			.tx_streams = hweight8(phy->antenna_mask),
+			.rx_streams = phy->chainmask,
+			.short_st = true,
+		},
+	};
+	int err, conn_type;
+	u8 idx;
+
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	basic_req.basic.hw_bss_idx = idx;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic_req.basic.conn_type = cpu_to_le32(conn_type);
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic_req.basic.conn_type = cpu_to_le32(conn_type);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	memcpy(basic_req.basic.bssid, vif->bss_conf.bssid, ETH_ALEN);
+	basic_req.basic.bmc_tx_wlan_idx = cpu_to_le16(wcid->idx);
+	basic_req.basic.sta_idx = cpu_to_le16(wcid->idx);
+	basic_req.basic.conn_state = !enable;
+
+	err = mt76_mcu_send_msg(mdev, MCU_UNI_CMD_BSS_INFO_UPDATE, &basic_req,
+				sizeof(basic_req), true);
+	if (err < 0)
+		return err;
+
+	if (vif->bss_conf.he_support) {
+		struct {
+			struct {
+				u8 bss_idx;
+				u8 pad[3];
+			} __packed hdr;
+			struct bss_info_uni_he he;
+		} he_req = {
+			.hdr = {
+				.bss_idx = mvif->idx,
+			},
+			.he = {
+				.tag = cpu_to_le16(UNI_BSS_INFO_HE_BASIC),
+				.len = cpu_to_le16(sizeof(struct bss_info_uni_he)),
+			},
+		};
+
+		mt76_connac_mcu_uni_bss_he_tlv(phy, vif,
+					       (struct tlv *)&he_req.he);
+		err = mt76_mcu_send_msg(mdev, MCU_UNI_CMD_BSS_INFO_UPDATE,
+					&he_req, sizeof(he_req), true);
+		if (err < 0)
+			return err;
+	}
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_40:
+		rlm_req.rlm.bw = CMD_CBW_40MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		rlm_req.rlm.bw = CMD_CBW_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+		rlm_req.rlm.bw = CMD_CBW_8080MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		rlm_req.rlm.bw = CMD_CBW_160MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_5:
+		rlm_req.rlm.bw = CMD_CBW_5MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_10:
+		rlm_req.rlm.bw = CMD_CBW_10MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+	default:
+		rlm_req.rlm.bw = CMD_CBW_20MHZ;
+		break;
+	}
+
+	if (rlm_req.rlm.control_channel < rlm_req.rlm.center_chan)
+		rlm_req.rlm.sco = 1; /* SCA */
+	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
+		rlm_req.rlm.sco = 3; /* SCB */
+
+	return mt76_mcu_send_msg(mdev, MCU_UNI_CMD_BSS_INFO_UPDATE, &rlm_req,
+				 sizeof(rlm_req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_bss);
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
new file mode 100644
index 000000000000..eb5e7b817d31
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -0,0 +1,729 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT76_CONNAC_MCU_H
+#define __MT76_CONNAC_MCU_H
+
+#include "mt76.h"
+
+enum {
+	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
+	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
+	CMD_CBW_80MHZ = IEEE80211_STA_RX_BW_80,
+	CMD_CBW_160MHZ = IEEE80211_STA_RX_BW_160,
+	CMD_CBW_10MHZ,
+	CMD_CBW_5MHZ,
+	CMD_CBW_8080MHZ,
+
+	CMD_HE_MCS_BW80 = 0,
+	CMD_HE_MCS_BW160,
+	CMD_HE_MCS_BW8080,
+	CMD_HE_MCS_BW_NUM
+};
+
+enum {
+	HW_BSSID_0 = 0x0,
+	HW_BSSID_1,
+	HW_BSSID_2,
+	HW_BSSID_3,
+	HW_BSSID_MAX = HW_BSSID_3,
+	EXT_BSSID_START = 0x10,
+	EXT_BSSID_1,
+	EXT_BSSID_15 = 0x1f,
+	EXT_BSSID_MAX = EXT_BSSID_15,
+	REPEATER_BSSID_START = 0x20,
+	REPEATER_BSSID_MAX = 0x3f,
+};
+
+struct tlv {
+	__le16 tag;
+	__le16 len;
+} __packed;
+
+/* sta_rec */
+
+struct sta_ntlv_hdr {
+	u8 rsv[2];
+	__le16 tlv_num;
+} __packed;
+
+struct sta_req_hdr {
+	u8 bss_idx;
+	u8 wlan_idx_lo;
+	__le16 tlv_num;
+	u8 is_tlv_append;
+	u8 muar_idx;
+	u8 wlan_idx_hi;
+	u8 rsv;
+} __packed;
+
+struct sta_rec_basic {
+	__le16 tag;
+	__le16 len;
+	__le32 conn_type;
+	u8 conn_state;
+	u8 qos;
+	__le16 aid;
+	u8 peer_addr[ETH_ALEN];
+#define EXTRA_INFO_VER	BIT(0)
+#define EXTRA_INFO_NEW	BIT(1)
+	__le16 extra_info;
+} __packed;
+
+struct sta_rec_ht {
+	__le16 tag;
+	__le16 len;
+	__le16 ht_cap;
+	u16 rsv;
+} __packed;
+
+struct sta_rec_vht {
+	__le16 tag;
+	__le16 len;
+	__le32 vht_cap;
+	__le16 vht_rx_mcs_map;
+	__le16 vht_tx_mcs_map;
+	/* mt7921 */
+	u8 rts_bw_sig;
+	u8 rsv[3];
+} __packed;
+
+struct sta_rec_uapsd {
+	__le16 tag;
+	__le16 len;
+	u8 dac_map;
+	u8 tac_map;
+	u8 max_sp;
+	u8 rsv0;
+	__le16 listen_interval;
+	u8 rsv1[2];
+} __packed;
+
+struct sta_rec_ba {
+	__le16 tag;
+	__le16 len;
+	u8 tid;
+	u8 ba_type;
+	u8 amsdu;
+	u8 ba_en;
+	__le16 ssn;
+	__le16 winsize;
+} __packed;
+
+struct sta_rec_he {
+	__le16 tag;
+	__le16 len;
+
+	__le32 he_cap;
+
+	u8 t_frame_dur;
+	u8 max_ampdu_exp;
+	u8 bw_set;
+	u8 device_class;
+	u8 dcm_tx_mode;
+	u8 dcm_tx_max_nss;
+	u8 dcm_rx_mode;
+	u8 dcm_rx_max_nss;
+	u8 dcm_max_ru;
+	u8 punc_pream_rx;
+	u8 pkt_ext;
+	u8 rsv1;
+
+	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
+
+	u8 rsv2[2];
+} __packed;
+
+struct sta_rec_amsdu {
+	__le16 tag;
+	__le16 len;
+	u8 max_amsdu_num;
+	u8 max_mpdu_size;
+	u8 amsdu_en;
+	u8 rsv;
+} __packed;
+
+struct sta_rec_state {
+	__le16 tag;
+	__le16 len;
+	__le32 flags;
+	u8 state;
+	u8 vht_opmode;
+	u8 action;
+	u8 rsv[1];
+} __packed;
+
+#define HT_MCS_MASK_NUM 10
+struct sta_rec_ra_info {
+	__le16 tag;
+	__le16 len;
+	__le16 legacy;
+	u8 rx_mcs_bitmask[HT_MCS_MASK_NUM];
+} __packed;
+
+struct sta_rec_phy {
+	__le16 tag;
+	__le16 len;
+	__le16 basic_rate;
+	u8 phy_type;
+	u8 ampdu;
+	u8 rts_policy;
+	u8 rcpi;
+	u8 rsv[2];
+} __packed;
+
+/* wtbl_rec */
+
+struct wtbl_req_hdr {
+	u8 wlan_idx_lo;
+	u8 operation;
+	__le16 tlv_num;
+	u8 wlan_idx_hi;
+	u8 rsv[3];
+} __packed;
+
+struct wtbl_generic {
+	__le16 tag;
+	__le16 len;
+	u8 peer_addr[ETH_ALEN];
+	u8 muar_idx;
+	u8 skip_tx;
+	u8 cf_ack;
+	u8 qos;
+	u8 mesh;
+	u8 adm;
+	__le16 partial_aid;
+	u8 baf_en;
+	u8 aad_om;
+} __packed;
+
+struct wtbl_rx {
+	__le16 tag;
+	__le16 len;
+	u8 rcid;
+	u8 rca1;
+	u8 rca2;
+	u8 rv;
+	u8 rsv[4];
+} __packed;
+
+struct wtbl_ht {
+	__le16 tag;
+	__le16 len;
+	u8 ht;
+	u8 ldpc;
+	u8 af;
+	u8 mm;
+	u8 rsv[4];
+} __packed;
+
+struct wtbl_vht {
+	__le16 tag;
+	__le16 len;
+	u8 ldpc;
+	u8 dyn_bw;
+	u8 vht;
+	u8 txop_ps;
+	u8 rsv[4];
+} __packed;
+
+struct wtbl_tx_ps {
+	__le16 tag;
+	__le16 len;
+	u8 txps;
+	u8 rsv[3];
+} __packed;
+
+struct wtbl_hdr_trans {
+	__le16 tag;
+	__le16 len;
+	u8 to_ds;
+	u8 from_ds;
+	u8 disable_rx_trans;
+	u8 rsv;
+} __packed;
+
+struct wtbl_ba {
+	__le16 tag;
+	__le16 len;
+	/* common */
+	u8 tid;
+	u8 ba_type;
+	u8 rsv0[2];
+	/* originator only */
+	__le16 sn;
+	u8 ba_en;
+	u8 ba_winsize_idx;
+	__le16 ba_winsize;
+	/* recipient only */
+	u8 peer_addr[ETH_ALEN];
+	u8 rst_ba_tid;
+	u8 rst_ba_sel;
+	u8 rst_ba_sb;
+	u8 band_idx;
+	u8 rsv1[4];
+} __packed;
+
+struct wtbl_smps {
+	__le16 tag;
+	__le16 len;
+	u8 smps;
+	u8 rsv[3];
+} __packed;
+
+/* mt7615 only */
+
+struct wtbl_bf {
+	__le16 tag;
+	__le16 len;
+	u8 ibf;
+	u8 ebf;
+	u8 ibf_vht;
+	u8 ebf_vht;
+	u8 gid;
+	u8 pfmu_idx;
+	u8 rsv[2];
+} __packed;
+
+struct wtbl_pn {
+	__le16 tag;
+	__le16 len;
+	u8 pn[6];
+	u8 rsv[2];
+} __packed;
+
+struct wtbl_spe {
+	__le16 tag;
+	__le16 len;
+	u8 spe_idx;
+	u8 rsv[3];
+} __packed;
+
+struct wtbl_raw {
+	__le16 tag;
+	__le16 len;
+	u8 wtbl_idx;
+	u8 dw;
+	u8 rsv[2];
+	__le32 msk;
+	__le32 val;
+} __packed;
+
+#define MT76_CONNAC_WTBL_UPDATE_MAX_SIZE (sizeof(struct wtbl_req_hdr) +	\
+					  sizeof(struct wtbl_generic) +	\
+					  sizeof(struct wtbl_rx) +	\
+					  sizeof(struct wtbl_ht) +	\
+					  sizeof(struct wtbl_vht) +	\
+					  sizeof(struct wtbl_tx_ps) +	\
+					  sizeof(struct wtbl_hdr_trans) +\
+					  sizeof(struct wtbl_ba) +	\
+					  sizeof(struct wtbl_bf) +	\
+					  sizeof(struct wtbl_smps) +	\
+					  sizeof(struct wtbl_pn) +	\
+					  sizeof(struct wtbl_spe))
+
+#define MT76_CONNAC_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
+					 sizeof(struct sta_rec_basic) +	\
+					 sizeof(struct sta_rec_ht) +	\
+					 sizeof(struct sta_rec_he) +	\
+					 sizeof(struct sta_rec_ba) +	\
+					 sizeof(struct sta_rec_vht) +	\
+					 sizeof(struct sta_rec_uapsd) + \
+					 sizeof(struct sta_rec_amsdu) +	\
+					 sizeof(struct tlv) +		\
+					 MT76_CONNAC_WTBL_UPDATE_MAX_SIZE)
+
+#define MT76_CONNAC_WTBL_UPDATE_BA_SIZE	(sizeof(struct wtbl_req_hdr) +	\
+					 sizeof(struct wtbl_ba))
+
+enum {
+	STA_REC_BASIC,
+	STA_REC_RA,
+	STA_REC_RA_CMM_INFO,
+	STA_REC_RA_UPDATE,
+	STA_REC_BF,
+	STA_REC_AMSDU,
+	STA_REC_BA,
+	STA_REC_STATE,
+	STA_REC_TX_PROC,	/* for hdr trans and CSO in CR4 */
+	STA_REC_HT,
+	STA_REC_VHT,
+	STA_REC_APPS,
+	STA_REC_KEY,
+	STA_REC_WTBL,
+	STA_REC_HE,
+	STA_REC_HW_AMSDU,
+	STA_REC_WTBL_AADOM,
+	STA_REC_KEY_V2,
+	STA_REC_MURU,
+	STA_REC_MUEDCA,
+	STA_REC_BFEE,
+	STA_REC_PHY = 0x15,
+	STA_REC_MAX_NUM
+};
+
+enum {
+	WTBL_GENERIC,
+	WTBL_RX,
+	WTBL_HT,
+	WTBL_VHT,
+	WTBL_PEER_PS,		/* not used */
+	WTBL_TX_PS,
+	WTBL_HDR_TRANS,
+	WTBL_SEC_KEY,
+	WTBL_BA,
+	WTBL_RDG,		/* obsoleted */
+	WTBL_PROTECT,		/* not used */
+	WTBL_CLEAR,		/* not used */
+	WTBL_BF,
+	WTBL_SMPS,
+	WTBL_RAW_DATA,		/* debug only */
+	WTBL_PN,
+	WTBL_SPE,
+	WTBL_MAX_NUM
+};
+
+#define STA_TYPE_STA			BIT(0)
+#define STA_TYPE_AP			BIT(1)
+#define STA_TYPE_ADHOC			BIT(2)
+#define STA_TYPE_WDS			BIT(4)
+#define STA_TYPE_BC			BIT(5)
+
+#define NETWORK_INFRA			BIT(16)
+#define NETWORK_P2P			BIT(17)
+#define NETWORK_IBSS			BIT(18)
+#define NETWORK_WDS			BIT(21)
+
+#define CONNECTION_INFRA_STA		(STA_TYPE_STA | NETWORK_INFRA)
+#define CONNECTION_INFRA_AP		(STA_TYPE_AP | NETWORK_INFRA)
+#define CONNECTION_P2P_GC		(STA_TYPE_STA | NETWORK_P2P)
+#define CONNECTION_P2P_GO		(STA_TYPE_AP | NETWORK_P2P)
+#define CONNECTION_IBSS_ADHOC		(STA_TYPE_ADHOC | NETWORK_IBSS)
+#define CONNECTION_WDS			(STA_TYPE_WDS | NETWORK_WDS)
+#define CONNECTION_INFRA_BC		(STA_TYPE_BC | NETWORK_INFRA)
+
+#define CONN_STATE_DISCONNECT		0
+#define CONN_STATE_CONNECT		1
+#define CONN_STATE_PORT_SECURE		2
+
+/* HE MAC */
+#define STA_REC_HE_CAP_HTC			BIT(0)
+#define STA_REC_HE_CAP_BQR			BIT(1)
+#define STA_REC_HE_CAP_BSR			BIT(2)
+#define STA_REC_HE_CAP_OM			BIT(3)
+#define STA_REC_HE_CAP_AMSDU_IN_AMPDU		BIT(4)
+/* HE PHY */
+#define STA_REC_HE_CAP_DUAL_BAND		BIT(5)
+#define STA_REC_HE_CAP_LDPC			BIT(6)
+#define STA_REC_HE_CAP_TRIG_CQI_FK		BIT(7)
+#define STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE	BIT(8)
+/* STBC */
+#define STA_REC_HE_CAP_LE_EQ_80M_TX_STBC	BIT(9)
+#define STA_REC_HE_CAP_LE_EQ_80M_RX_STBC	BIT(10)
+#define STA_REC_HE_CAP_GT_80M_TX_STBC		BIT(11)
+#define STA_REC_HE_CAP_GT_80M_RX_STBC		BIT(12)
+/* GI */
+#define STA_REC_HE_CAP_SU_PPDU_1LTF_8US_GI	BIT(13)
+#define STA_REC_HE_CAP_SU_MU_PPDU_4LTF_8US_GI	BIT(14)
+#define STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI	BIT(15)
+#define STA_REC_HE_CAP_ER_SU_PPDU_4LTF_8US_GI	BIT(16)
+#define STA_REC_HE_CAP_NDP_4LTF_3DOT2MS_GI	BIT(17)
+/* 242 TONE */
+#define STA_REC_HE_CAP_BW20_RU242_SUPPORT	BIT(18)
+#define STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242	BIT(19)
+#define STA_REC_HE_CAP_RX_1024QAM_UNDER_RU242	BIT(20)
+
+#define PHY_MODE_A				BIT(0)
+#define PHY_MODE_B				BIT(1)
+#define PHY_MODE_G				BIT(2)
+#define PHY_MODE_GN				BIT(3)
+#define PHY_MODE_AN				BIT(4)
+#define PHY_MODE_AC				BIT(5)
+#define PHY_MODE_AX_24G				BIT(6)
+#define PHY_MODE_AX_5G				BIT(7)
+#define PHY_MODE_AX_6G				BIT(8)
+
+#define MODE_CCK				BIT(0)
+#define MODE_OFDM				BIT(1)
+#define MODE_HT					BIT(2)
+#define MODE_VHT				BIT(3)
+#define MODE_HE					BIT(4)
+
+enum {
+	PHY_TYPE_HR_DSSS_INDEX = 0,
+	PHY_TYPE_ERP_INDEX,
+	PHY_TYPE_ERP_P2P_INDEX,
+	PHY_TYPE_OFDM_INDEX,
+	PHY_TYPE_HT_INDEX,
+	PHY_TYPE_VHT_INDEX,
+	PHY_TYPE_HE_INDEX,
+	PHY_TYPE_INDEX_NUM
+};
+
+#define PHY_TYPE_BIT_HR_DSSS			BIT(PHY_TYPE_HR_DSSS_INDEX)
+#define PHY_TYPE_BIT_ERP			BIT(PHY_TYPE_ERP_INDEX)
+#define PHY_TYPE_BIT_OFDM			BIT(PHY_TYPE_OFDM_INDEX)
+#define PHY_TYPE_BIT_HT				BIT(PHY_TYPE_HT_INDEX)
+#define PHY_TYPE_BIT_VHT			BIT(PHY_TYPE_VHT_INDEX)
+#define PHY_TYPE_BIT_HE				BIT(PHY_TYPE_HE_INDEX)
+
+#define MT_WTBL_RATE_TX_MODE			GENMASK(9, 6)
+#define MT_WTBL_RATE_MCS			GENMASK(5, 0)
+#define MT_WTBL_RATE_NSS			GENMASK(12, 10)
+#define MT_WTBL_RATE_HE_GI			GENMASK(7, 4)
+#define MT_WTBL_RATE_GI				GENMASK(3, 0)
+
+#define MT_WTBL_W5_CHANGE_BW_RATE		GENMASK(7, 5)
+#define MT_WTBL_W5_SHORT_GI_20			BIT(8)
+#define MT_WTBL_W5_SHORT_GI_40			BIT(9)
+#define MT_WTBL_W5_SHORT_GI_80			BIT(10)
+#define MT_WTBL_W5_SHORT_GI_160			BIT(11)
+#define MT_WTBL_W5_BW_CAP			GENMASK(13, 12)
+#define MT_WTBL_W5_MPDU_FAIL_COUNT		GENMASK(25, 23)
+#define MT_WTBL_W5_MPDU_OK_COUNT		GENMASK(28, 26)
+#define MT_WTBL_W5_RATE_IDX			GENMASK(31, 29)
+
+enum {
+	WTBL_RESET_AND_SET = 1,
+	WTBL_SET,
+	WTBL_QUERY,
+	WTBL_RESET_ALL
+};
+
+enum {
+	MT_BA_TYPE_INVALID,
+	MT_BA_TYPE_ORIGINATOR,
+	MT_BA_TYPE_RECIPIENT
+};
+
+enum {
+	RST_BA_MAC_TID_MATCH,
+	RST_BA_MAC_MATCH,
+	RST_BA_NO_MATCH
+};
+
+enum {
+	DEV_INFO_ACTIVE,
+	DEV_INFO_MAX_NUM
+};
+
+#define MCU_CMD_ACK				BIT(0)
+#define MCU_CMD_UNI				BIT(1)
+#define MCU_CMD_QUERY				BIT(2)
+
+#define MCU_CMD_UNI_EXT_ACK			(MCU_CMD_ACK | MCU_CMD_UNI | \
+						 MCU_CMD_QUERY)
+
+#define MCU_FW_PREFIX				BIT(31)
+#define MCU_UNI_PREFIX				BIT(30)
+#define MCU_CE_PREFIX				BIT(29)
+#define MCU_QUERY_PREFIX			BIT(28)
+#define MCU_CMD_MASK				~(MCU_FW_PREFIX | MCU_UNI_PREFIX |	\
+						  MCU_CE_PREFIX | MCU_QUERY_PREFIX)
+
+#define MCU_QUERY_MASK				BIT(16)
+
+enum {
+	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
+	MCU_EXT_CMD_RF_REG_ACCESS = 0x02,
+	MCU_EXT_CMD_PM_STATE_CTRL = 0x07,
+	MCU_EXT_CMD_CHANNEL_SWITCH = 0x08,
+	MCU_EXT_CMD_SET_TX_POWER_CTRL = 0x11,
+	MCU_EXT_CMD_FW_LOG_2_HOST = 0x13,
+	MCU_EXT_CMD_EFUSE_BUFFER_MODE = 0x21,
+	MCU_EXT_CMD_STA_REC_UPDATE = 0x25,
+	MCU_EXT_CMD_BSS_INFO_UPDATE = 0x26,
+	MCU_EXT_CMD_EDCA_UPDATE = 0x27,
+	MCU_EXT_CMD_DEV_INFO_UPDATE = 0x2A,
+	MCU_EXT_CMD_GET_TEMP = 0x2c,
+	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
+	MCU_EXT_CMD_SET_RDD_CTRL = 0x3a,
+	MCU_EXT_CMD_ATE_CTRL = 0x3d,
+	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
+	MCU_EXT_CMD_DBDC_CTRL = 0x45,
+	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
+	MCU_EXT_CMD_RX_HDR_TRANS = 0x47,
+	MCU_EXT_CMD_MUAR_UPDATE = 0x48,
+	MCU_EXT_CMD_BCN_OFFLOAD = 0x49,
+	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
+	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
+	MCU_EXT_CMD_RXDCOC_CAL = 0x59,
+	MCU_EXT_CMD_TXDPD_CAL = 0x60,
+	MCU_EXT_CMD_SET_RDD_TH = 0x7c,
+	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
+};
+
+enum {
+	MCU_UNI_CMD_DEV_INFO_UPDATE = MCU_UNI_PREFIX | 0x01,
+	MCU_UNI_CMD_BSS_INFO_UPDATE = MCU_UNI_PREFIX | 0x02,
+	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
+	MCU_UNI_CMD_SUSPEND = MCU_UNI_PREFIX | 0x05,
+	MCU_UNI_CMD_OFFLOAD = MCU_UNI_PREFIX | 0x06,
+	MCU_UNI_CMD_HIF_CTRL = MCU_UNI_PREFIX | 0x07,
+};
+
+enum {
+	MCU_CMD_TARGET_ADDRESS_LEN_REQ = MCU_FW_PREFIX | 0x01,
+	MCU_CMD_FW_START_REQ = MCU_FW_PREFIX | 0x02,
+	MCU_CMD_INIT_ACCESS_REG = 0x3,
+	MCU_CMD_NIC_POWER_CTRL = MCU_FW_PREFIX | 0x4,
+	MCU_CMD_PATCH_START_REQ = MCU_FW_PREFIX | 0x05,
+	MCU_CMD_PATCH_FINISH_REQ = MCU_FW_PREFIX | 0x07,
+	MCU_CMD_PATCH_SEM_CONTROL = MCU_FW_PREFIX | 0x10,
+	MCU_CMD_EXT_CID = 0xed,
+	MCU_CMD_FW_SCATTER = MCU_FW_PREFIX | 0xee,
+	MCU_CMD_RESTART_DL_REQ = MCU_FW_PREFIX | 0xef,
+};
+
+/* offload mcu commands */
+enum {
+	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
+	MCU_CMD_SET_PS_PROFILE = MCU_CE_PREFIX | 0x05,
+	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
+	MCU_CMD_SET_BSS_CONNECTED = MCU_CE_PREFIX | 0x16,
+	MCU_CMD_SET_BSS_ABORT = MCU_CE_PREFIX | 0x17,
+	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
+	MCU_CMD_SET_ROC = MCU_CE_PREFIX | 0x1d,
+	MCU_CMD_SET_P2P_OPPPS = MCU_CE_PREFIX | 0x33,
+	MCU_CMD_SET_RATE_TX_POWER = MCU_CE_PREFIX | 0x5d,
+	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
+	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
+	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
+	MCU_CMD_REG_READ = MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
+};
+
+enum {
+	PATCH_SEM_RELEASE,
+	PATCH_SEM_GET
+};
+
+enum {
+	UNI_BSS_INFO_BASIC = 0,
+	UNI_BSS_INFO_RLM = 2,
+	UNI_BSS_INFO_HE_BASIC = 5,
+	UNI_BSS_INFO_BCN_CONTENT = 7,
+	UNI_BSS_INFO_QBSS = 15,
+	UNI_BSS_INFO_UAPSD = 19,
+};
+
+struct mt76_connac_bss_basic_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 active;
+	u8 omac_idx;
+	u8 hw_bss_idx;
+	u8 band_idx;
+	__le32 conn_type;
+	u8 conn_state;
+	u8 wmm_idx;
+	u8 bssid[ETH_ALEN];
+	__le16 bmc_tx_wlan_idx;
+	__le16 bcn_interval;
+	u8 dtim_period;
+	u8 phymode; /* bit(0): A
+		     * bit(1): B
+		     * bit(2): G
+		     * bit(3): GN
+		     * bit(4): AN
+		     * bit(5): AC
+		     */
+	__le16 sta_idx;
+	u8 nonht_basic_phy;
+	u8 pad[3];
+} __packed;
+
+struct mt76_connac_bss_qos_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 qos;
+	u8 pad[3];
+} __packed;
+
+struct mt76_connac_beacon_loss_event {
+	u8 bss_idx;
+	u8 reason;
+	u8 pad[2];
+} __packed;
+
+struct mt76_connac_mcu_bss_event {
+	u8 bss_idx;
+	u8 is_absent;
+	u8 free_quota;
+	u8 pad;
+} __packed;
+
+struct bss_info_uni_he {
+	__le16 tag;
+	__le16 len;
+	__le16 he_rts_thres;
+	u8 he_pe_duration;
+	u8 su_disable;
+	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
+	u8 rsv[2];
+} __packed;
+
+struct sk_buff *
+mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
+			      struct mt76_wcid *wcid);
+struct wtbl_req_hdr *
+mt76_connac_mcu_alloc_wtbl_req(struct mt76_dev *dev, struct mt76_wcid *wcid,
+			       int cmd, void *sta_wtbl, struct sk_buff **skb);
+struct tlv *mt76_connac_mcu_add_nested_tlv(struct sk_buff *skb, int tag,
+					   int len, void *sta_ntlv,
+					   void *sta_wtbl);
+static inline struct tlv *
+mt76_connac_mcu_add_tlv(struct sk_buff *skb, int tag, int len)
+{
+	return mt76_connac_mcu_add_nested_tlv(skb, tag, len, skb->data, NULL);
+}
+
+int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy);
+int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif);
+void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta, bool enable);
+void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_sta *sta, void *sta_wtbl,
+				      void *wtbl_tlv);
+void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
+			     struct ieee80211_sta *sta,
+			     struct ieee80211_vif *vif);
+void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
+				 struct ieee80211_sta *sta, void *sta_wtbl,
+				 void *wtbl_tlv);
+void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
+				 struct ieee80211_ampdu_params *params,
+				 bool enable, bool tx, void *sta_wtbl,
+				 void *wtbl_tlv);
+void mt76_connac_mcu_sta_ba_tlv(struct sk_buff *skb,
+				struct ieee80211_ampdu_params *params,
+				bool enable, bool tx);
+int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
+				struct ieee80211_vif *vif,
+				struct mt76_wcid *wcid,
+				bool enable);
+int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
+			   struct ieee80211_ampdu_params *params,
+			   bool enable, bool tx);
+int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
+				struct ieee80211_vif *vif,
+				struct mt76_wcid *wcid,
+				bool enable);
+int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				struct mt76_wcid *wcid,
+				bool enable, int cmd);
+void mt76_connac_mcu_beacon_loss_iter(void *priv, u8 *mac,
+				      struct ieee80211_vif *vif);
+int mt76_connac_mcu_set_rts_thresh(struct mt76_dev *dev, u32 val, u8 band);
+int mt76_connac_mcu_set_mac_enable(struct mt76_dev *dev, int band, bool enable,
+				   bool hdr_trans);
+int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
+				  u32 mode);
+int mt76_connac_mcu_start_patch(struct mt76_dev *dev);
+int mt76_connac_mcu_patch_sem_ctrl(struct mt76_dev *dev, bool get);
+int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option);
+
+#endif /* __MT76_CONNAC_MCU_H */
-- 
2.29.2

