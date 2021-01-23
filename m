Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE24930148A
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 11:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbhAWKed (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 05:34:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbhAWKeJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 05:34:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0676822D5A;
        Sat, 23 Jan 2021 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611398007;
        bh=HKDdOYq6rm4MqUHMYR0aQCZlzu59Yq/iTzwpunpSwxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkKCcDqx6CDkaItmZWV6UcvnIafUFMAJeleYv8nkqGMvxSrOuJZ7wZmwBHPA2wsHE
         FjlVpdx0AvdyNyJLrqUo3uYfROf2FBgph2rBax7tNJvF5FsIRbcZQDG+PMNz0JsriL
         CIkJcxgxfQvoWSFfNni6y2+TytCEUBtMVfA0WJ4peLfzWqMqhrSpWYdYHhceXhJLWI
         4I5vRRoogKRMU9JloYN6rkKYLE5r1pFjtw2W4sZqKPVpHi/pEMni3GQC9zM5PqX3AP
         u6LS+qGbQP+6QPVIMsVrQp2mZ3EB8AwYjqMOuKSRbbp4NQZq2LC1ICrUdV9txDN5ZR
         dNKQ2C6XFRzYA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 4/6] mt76: mt76_connac: move WoW and suspend code in mt76_connac_mcu module
Date:   Sat, 23 Jan 2021 11:33:02 +0100
Message-Id: <798becbbfd819cae4eb5133cec2bcea3f487af34.1611397696.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611397696.git.lorenzo@kernel.org>
References: <cover.1611397696.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move WoW and suspend code in mt76_connac_mcu module in order to be reused in
mt7615 and mt7921 drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  16 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 310 +-----------------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 114 -------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   6 -
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |   4 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 307 +++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 124 ++++++-
 9 files changed, 449 insertions(+), 442 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index fcfec0197256..d4a56950d5cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1115,8 +1115,8 @@ static int mt7615_cancel_remain_on_channel(struct ieee80211_hw *hw,
 static int mt7615_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
-	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	int err = 0;
 
 	cancel_delayed_work_sync(&dev->pm.ps_work);
@@ -1131,10 +1131,11 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 	set_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    mt7615_mcu_set_suspend_iter, phy);
+					    mt76_connac_mcu_set_suspend_iter,
+					    phy->mt76);
 
 	if (!mt7615_dev_running(dev))
-		err = mt7615_mcu_set_hif_suspend(dev, true);
+		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true);
 
 	mt7615_mutex_release(dev);
 
@@ -1143,8 +1144,8 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 
 static int mt7615_resume(struct ieee80211_hw *hw)
 {
-	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	bool running;
 
 	mt7615_mutex_acquire(dev);
@@ -1155,7 +1156,7 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 	if (!running) {
 		int err;
 
-		err = mt7615_mcu_set_hif_suspend(dev, false);
+		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false);
 		if (err < 0) {
 			mt7615_mutex_release(dev);
 			return err;
@@ -1165,7 +1166,8 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 	clear_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    mt7615_mcu_set_suspend_iter, phy);
+					    mt76_connac_mcu_set_suspend_iter,
+					    phy->mt76);
 
 	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 				     MT7615_WATCHDOG_TIME);
@@ -1190,7 +1192,7 @@ static void mt7615_set_rekey_data(struct ieee80211_hw *hw,
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 
 	mt7615_mutex_acquire(dev);
-	mt7615_mcu_update_gtk_rekey(hw, vif, data);
+	mt76_connac_mcu_update_gtk_rekey(hw, vif, data);
 	mt7615_mutex_release(dev);
 }
 #endif /* CONFIG_PM */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 8be0e04472c4..71502b523609 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1384,15 +1384,6 @@ mt7615_mcu_send_ram_firmware(struct mt7615_dev *dev,
 	return 0;
 }
 
-static const struct wiphy_wowlan_support mt7615_wowlan_support = {
-	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT |
-		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY | WIPHY_WOWLAN_NET_DETECT,
-	.n_patterns = 1,
-	.pattern_min_len = 1,
-	.pattern_max_len = MT7615_WOW_PATTEN_MAX_LEN,
-	.max_nd_match_sets = 10,
-};
-
 static int mt7615_load_n9(struct mt7615_dev *dev, const char *name)
 {
 	const struct mt7615_fw_trailer *hdr;
@@ -1722,7 +1713,7 @@ int __mt7663_load_firmware(struct mt7615_dev *dev)
 
 #ifdef CONFIG_PM
 	if (mt7615_firmware_offload(dev))
-		dev->mt76.hw->wiphy->wowlan = &mt7615_wowlan_support;
+		dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
 #endif /* CONFIG_PM */
 
 	dev_dbg(dev->mt76.dev, "Firmware init done\n");
@@ -2541,301 +2532,6 @@ int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 				 sizeof(req), false);
 }
 
-#ifdef CONFIG_PM
-int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend)
-{
-	struct {
-		struct {
-			u8 hif_type; /* 0x0: HIF_SDIO
-				      * 0x1: HIF_USB
-				      * 0x2: HIF_PCIE
-				      */
-			u8 pad[3];
-		} __packed hdr;
-		struct hif_suspend_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 suspend;
-		} __packed hif_suspend;
-	} req = {
-		.hif_suspend = {
-			.tag = cpu_to_le16(0), /* 0: UNI_HIF_CTRL_BASIC */
-			.len = cpu_to_le16(sizeof(struct hif_suspend_tlv)),
-			.suspend = suspend,
-		},
-	};
-
-	if (mt76_is_mmio(&dev->mt76))
-		req.hdr.hif_type = 2;
-	else if (mt76_is_usb(&dev->mt76))
-		req.hdr.hif_type = 1;
-	else if (mt76_is_sdio(&dev->mt76))
-		req.hdr.hif_type = 0;
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_HIF_CTRL, &req,
-				 sizeof(req), true);
-}
-EXPORT_SYMBOL_GPL(mt7615_mcu_set_hif_suspend);
-
-static int
-mt7615_mcu_set_wow_ctrl(struct mt7615_phy *phy, struct ieee80211_vif *vif,
-			bool suspend, struct cfg80211_wowlan *wowlan)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct mt7615_dev *dev = phy->dev;
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct mt7615_wow_ctrl_tlv wow_ctrl_tlv;
-		struct mt7615_wow_gpio_param_tlv gpio_tlv;
-	} req = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.wow_ctrl_tlv = {
-			.tag = cpu_to_le16(UNI_SUSPEND_WOW_CTRL),
-			.len = cpu_to_le16(sizeof(struct mt7615_wow_ctrl_tlv)),
-			.cmd = suspend ? 1 : 2,
-		},
-		.gpio_tlv = {
-			.tag = cpu_to_le16(UNI_SUSPEND_WOW_GPIO_PARAM),
-			.len = cpu_to_le16(sizeof(struct mt7615_wow_gpio_param_tlv)),
-			.gpio_pin = 0xff, /* follow fw about GPIO pin */
-		},
-	};
-
-	if (wowlan->magic_pkt)
-		req.wow_ctrl_tlv.trigger |= BIT(0);
-	if (wowlan->disconnect)
-		req.wow_ctrl_tlv.trigger |= BIT(2);
-	if (wowlan->nd_config) {
-		mt76_connac_mcu_sched_scan_req(phy->mt76, vif,
-					       wowlan->nd_config);
-		req.wow_ctrl_tlv.trigger |= BIT(5);
-		mt76_connac_mcu_sched_scan_enable(phy->mt76, vif, suspend);
-	}
-
-	if (mt76_is_mmio(&dev->mt76))
-		req.wow_ctrl_tlv.wakeup_hif = WOW_PCIE;
-	else if (mt76_is_usb(&dev->mt76))
-		req.wow_ctrl_tlv.wakeup_hif = WOW_USB;
-	else if (mt76_is_sdio(&dev->mt76))
-		req.wow_ctrl_tlv.wakeup_hif = WOW_GPIO;
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_SUSPEND, &req,
-				 sizeof(req), true);
-}
-
-static int
-mt7615_mcu_set_wow_pattern(struct mt7615_dev *dev,
-			   struct ieee80211_vif *vif,
-			   u8 index, bool enable,
-			   struct cfg80211_pkt_pattern *pattern)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct mt7615_wow_pattern_tlv *ptlv;
-	struct sk_buff *skb;
-	struct req_hdr {
-		u8 bss_idx;
-		u8 pad[3];
-	} __packed hdr = {
-		.bss_idx = mvif->mt76.idx,
-	};
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-				 sizeof(hdr) + sizeof(*ptlv));
-	if (!skb)
-		return -ENOMEM;
-
-	skb_put_data(skb, &hdr, sizeof(hdr));
-	ptlv = (struct mt7615_wow_pattern_tlv *)skb_put(skb, sizeof(*ptlv));
-	ptlv->tag = cpu_to_le16(UNI_SUSPEND_WOW_PATTERN);
-	ptlv->len = cpu_to_le16(sizeof(*ptlv));
-	ptlv->data_len = pattern->pattern_len;
-	ptlv->enable = enable;
-	ptlv->index = index;
-
-	memcpy(ptlv->pattern, pattern->pattern, pattern->pattern_len);
-	memcpy(ptlv->mask, pattern->mask, pattern->pattern_len / 8);
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_UNI_CMD_SUSPEND,
-				     true);
-}
-
-static int
-mt7615_mcu_set_suspend_mode(struct mt7615_dev *dev,
-			    struct ieee80211_vif *vif,
-			    bool enable, u8 mdtim, bool wow_suspend)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct mt7615_suspend_tlv suspend_tlv;
-	} req = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.suspend_tlv = {
-			.tag = cpu_to_le16(UNI_SUSPEND_MODE_SETTING),
-			.len = cpu_to_le16(sizeof(struct mt7615_suspend_tlv)),
-			.enable = enable,
-			.mdtim = mdtim,
-			.wow_suspend = wow_suspend,
-		},
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_SUSPEND, &req,
-				 sizeof(req), true);
-}
-
-static int
-mt7615_mcu_set_gtk_rekey(struct mt7615_dev *dev,
-			 struct ieee80211_vif *vif,
-			 bool suspend)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct mt7615_gtk_rekey_tlv gtk_tlv;
-	} __packed req = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.gtk_tlv = {
-			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_GTK_REKEY),
-			.len = cpu_to_le16(sizeof(struct mt7615_gtk_rekey_tlv)),
-			.rekey_mode = !suspend,
-		},
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_OFFLOAD, &req,
-				 sizeof(req), true);
-}
-
-static int
-mt7615_mcu_set_arp_filter(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-			  bool suspend)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct mt7615_arpns_tlv arpns;
-	} req = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.arpns = {
-			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
-			.len = cpu_to_le16(sizeof(struct mt7615_arpns_tlv)),
-			.mode = suspend,
-		},
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_OFFLOAD, &req,
-				 sizeof(req), true);
-}
-
-void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
-				 struct ieee80211_vif *vif)
-{
-	struct mt7615_phy *phy = priv;
-	bool suspend = test_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
-	struct ieee80211_hw *hw = phy->mt76->hw;
-	struct cfg80211_wowlan *wowlan = hw->wiphy->wowlan_config;
-	int i;
-
-	mt7615_mcu_set_gtk_rekey(phy->dev, vif, suspend);
-	mt7615_mcu_set_arp_filter(phy->dev, vif, suspend);
-
-	mt7615_mcu_set_suspend_mode(phy->dev, vif, suspend, 1, true);
-
-	for (i = 0; i < wowlan->n_patterns; i++)
-		mt7615_mcu_set_wow_pattern(phy->dev, vif, i, suspend,
-					   &wowlan->patterns[i]);
-	mt7615_mcu_set_wow_ctrl(phy, vif, suspend, wowlan);
-}
-
-static void
-mt7615_mcu_key_iter(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		    struct ieee80211_sta *sta, struct ieee80211_key_conf *key,
-		    void *data)
-{
-	struct mt7615_gtk_rekey_tlv *gtk_tlv = data;
-	u32 cipher;
-
-	if (key->cipher != WLAN_CIPHER_SUITE_AES_CMAC &&
-	    key->cipher != WLAN_CIPHER_SUITE_CCMP &&
-	    key->cipher != WLAN_CIPHER_SUITE_TKIP)
-		return;
-
-	if (key->cipher == WLAN_CIPHER_SUITE_TKIP) {
-		gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_1);
-		cipher = BIT(3);
-	} else {
-		gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_2);
-		cipher = BIT(4);
-	}
-
-	/* we are assuming here to have a single pairwise key */
-	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
-		gtk_tlv->pairwise_cipher = cpu_to_le32(cipher);
-		gtk_tlv->group_cipher = cpu_to_le32(cipher);
-		gtk_tlv->keyid = key->keyidx;
-	}
-}
-
-int mt7615_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif,
-				struct cfg80211_gtk_rekey_data *key)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct mt7615_dev *dev = mt7615_hw_dev(hw);
-	struct mt7615_gtk_rekey_tlv *gtk_tlv;
-	struct sk_buff *skb;
-	struct {
-		u8 bss_idx;
-		u8 pad[3];
-	} __packed hdr = {
-		.bss_idx = mvif->mt76.idx,
-	};
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-				 sizeof(hdr) + sizeof(*gtk_tlv));
-	if (!skb)
-		return -ENOMEM;
-
-	skb_put_data(skb, &hdr, sizeof(hdr));
-	gtk_tlv = (struct mt7615_gtk_rekey_tlv *)skb_put(skb,
-							 sizeof(*gtk_tlv));
-	gtk_tlv->tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_GTK_REKEY);
-	gtk_tlv->len = cpu_to_le16(sizeof(*gtk_tlv));
-	gtk_tlv->rekey_mode = 2;
-	gtk_tlv->option = 1;
-
-	rcu_read_lock();
-	ieee80211_iter_keys_rcu(hw, vif, mt7615_mcu_key_iter, gtk_tlv);
-	rcu_read_unlock();
-
-	memcpy(gtk_tlv->kek, key->kek, NL80211_KEK_LEN);
-	memcpy(gtk_tlv->kck, key->kck, NL80211_KCK_LEN);
-	memcpy(gtk_tlv->replay_ctr, key->replay_ctr, NL80211_REPLAY_CTR_LEN);
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_UNI_CMD_OFFLOAD,
-				     true);
-}
-#endif /* CONFIG_PM */
-
 int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_channel *chan, int duration)
 {
@@ -2870,14 +2566,14 @@ int mt7615_mcu_update_arp_filter(struct ieee80211_hw *hw,
 			u8 bss_idx;
 			u8 pad[3];
 		} __packed hdr;
-		struct mt7615_arpns_tlv arp;
+		struct mt76_connac_arpns_tlv arp;
 	} req_hdr = {
 		.hdr = {
 			.bss_idx = mvif->mt76.idx,
 		},
 		.arp = {
 			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
-			.len = cpu_to_le16(sizeof(struct mt7615_arpns_tlv)),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)),
 			.ips_num = len,
 			.mode = 2,  /* update */
 			.option = 1,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 69f94b766938..446c6abf44d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -254,96 +254,6 @@ struct mt7615_mcu_reg_event {
 	__le32 val;
 } __packed;
 
-enum {
-	WOW_USB = 1,
-	WOW_PCIE = 2,
-	WOW_GPIO = 3,
-};
-
-struct mt7615_wow_ctrl_tlv {
-	__le16 tag;
-	__le16 len;
-	u8 cmd; /* 0x1: PM_WOWLAN_REQ_START
-		 * 0x2: PM_WOWLAN_REQ_STOP
-		 * 0x3: PM_WOWLAN_PARAM_CLEAR
-		 */
-	u8 trigger; /* 0: NONE
-		     * BIT(0): NL80211_WOWLAN_TRIG_MAGIC_PKT
-		     * BIT(1): NL80211_WOWLAN_TRIG_ANY
-		     * BIT(2): NL80211_WOWLAN_TRIG_DISCONNECT
-		     * BIT(3): NL80211_WOWLAN_TRIG_GTK_REKEY_FAILURE
-		     * BIT(4): BEACON_LOST
-		     * BIT(5): NL80211_WOWLAN_TRIG_NET_DETECT
-		     */
-	u8 wakeup_hif; /* 0x0: HIF_SDIO
-			* 0x1: HIF_USB
-			* 0x2: HIF_PCIE
-			* 0x3: HIF_GPIO
-			*/
-	u8 pad;
-	u8 rsv[4];
-} __packed;
-
-struct mt7615_wow_gpio_param_tlv {
-	__le16 tag;
-	__le16 len;
-	u8 gpio_pin;
-	u8 trigger_lvl;
-	u8 pad[2];
-	__le32 gpio_interval;
-	u8 rsv[4];
-} __packed;
-
-#define MT7615_WOW_MASK_MAX_LEN		16
-#define MT7615_WOW_PATTEN_MAX_LEN	128
-struct mt7615_wow_pattern_tlv {
-	__le16 tag;
-	__le16 len;
-	u8 index; /* pattern index */
-	u8 enable; /* 0: disable
-		    * 1: enable
-		    */
-	u8 data_len; /* pattern length */
-	u8 pad;
-	u8 mask[MT7615_WOW_MASK_MAX_LEN];
-	u8 pattern[MT7615_WOW_PATTEN_MAX_LEN];
-	u8 rsv[4];
-} __packed;
-
-struct mt7615_suspend_tlv {
-	__le16 tag;
-	__le16 len;
-	u8 enable; /* 0: suspend mode disabled
-		    * 1: suspend mode enabled
-		    */
-	u8 mdtim; /* LP parameter */
-	u8 wow_suspend; /* 0: update by origin policy
-			 * 1: update by wow dtim
-			 */
-	u8 pad[5];
-} __packed;
-
-struct mt7615_gtk_rekey_tlv {
-	__le16 tag;
-	__le16 len;
-	u8 kek[NL80211_KEK_LEN];
-	u8 kck[NL80211_KCK_LEN];
-	u8 replay_ctr[NL80211_REPLAY_CTR_LEN];
-	u8 rekey_mode; /* 0: rekey offload enable
-			* 1: rekey offload disable
-			* 2: rekey update
-			*/
-	u8 keyid;
-	u8 pad[2];
-	__le32 proto; /* WPA-RSN-WAPI-OPSN */
-	__le32 pairwise_cipher;
-	__le32 group_cipher;
-	__le32 key_mgmt; /* NONE-PSK-IEEE802.1X */
-	__le32 mgmt_group_cipher;
-	u8 option; /* 1: rekey data update without enabling offload */
-	u8 reserverd[3];
-} __packed;
-
 struct mt7615_roc_tlv {
 	u8 bss_idx;
 	u8 token;
@@ -361,30 +271,6 @@ struct mt7615_roc_tlv {
 	u8 rsv1[8];
 } __packed;
 
-struct mt7615_arpns_tlv {
-	__le16 tag;
-	__le16 len;
-	u8 mode;
-	u8 ips_num;
-	u8 option;
-	u8 pad[1];
-} __packed;
-
-enum {
-	UNI_SUSPEND_MODE_SETTING,
-	UNI_SUSPEND_WOW_CTRL,
-	UNI_SUSPEND_WOW_GPIO_PARAM,
-	UNI_SUSPEND_WOW_WAKEUP_PORT,
-	UNI_SUSPEND_WOW_PATTERN,
-};
-
-enum {
-	UNI_OFFLOAD_OFFLOAD_ARP,
-	UNI_OFFLOAD_OFFLOAD_ND,
-	UNI_OFFLOAD_OFFLOAD_GTK_REKEY,
-	UNI_OFFLOAD_OFFLOAD_BMC_RPY_DETECT,
-};
-
 enum {
 	PATCH_NOT_DL_SEM_FAIL	 = 0x0,
 	PATCH_IS_DL		 = 0x1,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 0173db8fd0f7..20fef779ab43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -574,12 +574,6 @@ int mt7615_mac_set_beacon_filter(struct mt7615_phy *phy,
 				 bool enable);
 int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
-int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend);
-void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
-				 struct ieee80211_vif *vif);
-int mt7615_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif,
-				struct cfg80211_gtk_rekey_data *key);
 int mt7615_mcu_update_arp_filter(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *info);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index b78014926f1f..5ac4193b770c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -83,7 +83,7 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	hif_suspend = !test_bit(MT76_STATE_SUSPEND, &dev->mphy.state) &&
 		      mt7615_firmware_offload(dev);
 	if (hif_suspend) {
-		err = mt7615_mcu_set_hif_suspend(dev, true);
+		err = mt76_connac_mcu_set_hif_suspend(mdev, true);
 		if (err)
 			return err;
 	}
@@ -131,7 +131,7 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	}
 	napi_enable(&mdev->tx_napi);
 	if (hif_suspend)
-		mt7615_mcu_set_hif_suspend(dev, false);
+		mt76_connac_mcu_set_hif_suspend(mdev, false);
 
 	return err;
 }
@@ -173,7 +173,7 @@ static int mt7615_pci_resume(struct pci_dev *pdev)
 
 	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state) &&
 	    mt7615_firmware_offload(dev))
-		err = mt7615_mcu_set_hif_suspend(dev, false);
+		err = mt76_connac_mcu_set_hif_suspend(mdev, false);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index ff757c4a2377..305bb8597531 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -414,7 +414,7 @@ static int mt7663s_suspend(struct device *dev)
 	    mt7615_firmware_offload(mdev)) {
 		int err;
 
-		err = mt7615_mcu_set_hif_suspend(mdev, true);
+		err = mt76_connac_mcu_set_hif_suspend(&mdev->mt76, true);
 		if (err < 0)
 			return err;
 	}
@@ -453,7 +453,7 @@ static int mt7663s_resume(struct device *dev)
 
 	if (!test_bit(MT76_STATE_SUSPEND, &mdev->mphy.state) &&
 	    mt7615_firmware_offload(mdev))
-		err = mt7615_mcu_set_hif_suspend(mdev, false);
+		err = mt76_connac_mcu_set_hif_suspend(&mdev->mt76, false);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 5438b0ba461f..0396ad532ba6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -169,7 +169,7 @@ static int mt7663u_suspend(struct usb_interface *intf, pm_message_t state)
 	    mt7615_firmware_offload(dev)) {
 		int err;
 
-		err = mt7615_mcu_set_hif_suspend(dev, true);
+		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true);
 		if (err < 0)
 			return err;
 	}
@@ -197,7 +197,7 @@ static int mt7663u_resume(struct usb_interface *intf)
 
 	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state) &&
 	    mt7615_firmware_offload(dev))
-		err = mt7615_mcu_set_hif_suspend(dev, false);
+		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ed0e605d1c0b..ee5ebd7259a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1179,5 +1179,312 @@ int mt76_connac_mcu_sched_scan_enable(struct mt76_phy *phy,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sched_scan_enable);
 
+#ifdef CONFIG_PM
+
+const struct wiphy_wowlan_support mt76_connac_wowlan_support = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT |
+		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY | WIPHY_WOWLAN_NET_DETECT,
+	.n_patterns = 1,
+	.pattern_min_len = 1,
+	.pattern_max_len = MT76_CONNAC_WOW_PATTEN_MAX_LEN,
+	.max_nd_match_sets = 10,
+};
+EXPORT_SYMBOL_GPL(mt76_connac_wowlan_support);
+
+static void
+mt76_connac_mcu_key_iter(struct ieee80211_hw *hw,
+			 struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta,
+			 struct ieee80211_key_conf *key,
+			 void *data)
+{
+	struct mt76_connac_gtk_rekey_tlv *gtk_tlv = data;
+	u32 cipher;
+
+	if (key->cipher != WLAN_CIPHER_SUITE_AES_CMAC &&
+	    key->cipher != WLAN_CIPHER_SUITE_CCMP &&
+	    key->cipher != WLAN_CIPHER_SUITE_TKIP)
+		return;
+
+	if (key->cipher == WLAN_CIPHER_SUITE_TKIP) {
+		gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_1);
+		cipher = BIT(3);
+	} else {
+		gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_2);
+		cipher = BIT(4);
+	}
+
+	/* we are assuming here to have a single pairwise key */
+	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
+		gtk_tlv->pairwise_cipher = cpu_to_le32(cipher);
+		gtk_tlv->group_cipher = cpu_to_le32(cipher);
+		gtk_tlv->keyid = key->keyidx;
+	}
+}
+
+int mt76_connac_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct cfg80211_gtk_rekey_data *key)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_connac_gtk_rekey_tlv *gtk_tlv;
+	struct mt76_phy *phy = hw->priv;
+	struct sk_buff *skb;
+	struct {
+		u8 bss_idx;
+		u8 pad[3];
+	} __packed hdr = {
+		.bss_idx = mvif->idx,
+	};
+
+	skb = mt76_mcu_msg_alloc(phy->dev, NULL,
+				 sizeof(hdr) + sizeof(*gtk_tlv));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+	gtk_tlv = (struct mt76_connac_gtk_rekey_tlv *)skb_put(skb,
+							 sizeof(*gtk_tlv));
+	gtk_tlv->tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_GTK_REKEY);
+	gtk_tlv->len = cpu_to_le16(sizeof(*gtk_tlv));
+	gtk_tlv->rekey_mode = 2;
+	gtk_tlv->option = 1;
+
+	rcu_read_lock();
+	ieee80211_iter_keys_rcu(hw, vif, mt76_connac_mcu_key_iter, gtk_tlv);
+	rcu_read_unlock();
+
+	memcpy(gtk_tlv->kek, key->kek, NL80211_KEK_LEN);
+	memcpy(gtk_tlv->kck, key->kck, NL80211_KCK_LEN);
+	memcpy(gtk_tlv->replay_ctr, key->replay_ctr, NL80211_REPLAY_CTR_LEN);
+
+	return mt76_mcu_skb_send_msg(phy->dev, skb, MCU_UNI_CMD_OFFLOAD, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_update_gtk_rekey);
+
+static int
+mt76_connac_mcu_set_arp_filter(struct mt76_dev *dev, struct ieee80211_vif *vif,
+			       bool suspend)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_arpns_tlv arpns;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.arpns = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)),
+			.mode = suspend,
+		},
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_OFFLOAD, &req, sizeof(req),
+				 true);
+}
+
+static int
+mt76_connac_mcu_set_gtk_rekey(struct mt76_dev *dev, struct ieee80211_vif *vif,
+			      bool suspend)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_gtk_rekey_tlv gtk_tlv;
+	} __packed req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.gtk_tlv = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_GTK_REKEY),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_gtk_rekey_tlv)),
+			.rekey_mode = !suspend,
+		},
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_OFFLOAD, &req, sizeof(req),
+				 true);
+}
+
+static int
+mt76_connac_mcu_set_suspend_mode(struct mt76_dev *dev,
+				 struct ieee80211_vif *vif,
+				 bool enable, u8 mdtim,
+				 bool wow_suspend)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_suspend_tlv suspend_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.suspend_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_MODE_SETTING),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_suspend_tlv)),
+			.enable = enable,
+			.mdtim = mdtim,
+			.wow_suspend = wow_suspend,
+		},
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_SUSPEND, &req, sizeof(req),
+				 true);
+}
+
+static int
+mt76_connac_mcu_set_wow_pattern(struct mt76_dev *dev,
+				struct ieee80211_vif *vif,
+				u8 index, bool enable,
+				struct cfg80211_pkt_pattern *pattern)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_connac_wow_pattern_tlv *ptlv;
+	struct sk_buff *skb;
+	struct req_hdr {
+		u8 bss_idx;
+		u8 pad[3];
+	} __packed hdr = {
+		.bss_idx = mvif->idx,
+	};
+
+	skb = mt76_mcu_msg_alloc(dev, NULL, sizeof(hdr) + sizeof(*ptlv));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+	ptlv = (struct mt76_connac_wow_pattern_tlv *)skb_put(skb, sizeof(*ptlv));
+	ptlv->tag = cpu_to_le16(UNI_SUSPEND_WOW_PATTERN);
+	ptlv->len = cpu_to_le16(sizeof(*ptlv));
+	ptlv->data_len = pattern->pattern_len;
+	ptlv->enable = enable;
+	ptlv->index = index;
+
+	memcpy(ptlv->pattern, pattern->pattern, pattern->pattern_len);
+	memcpy(ptlv->mask, pattern->mask, pattern->pattern_len / 8);
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD_SUSPEND, true);
+}
+
+static int
+mt76_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			     bool suspend, struct cfg80211_wowlan *wowlan)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_wow_ctrl_tlv wow_ctrl_tlv;
+		struct mt76_connac_wow_gpio_param_tlv gpio_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.wow_ctrl_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_WOW_CTRL),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_wow_ctrl_tlv)),
+			.cmd = suspend ? 1 : 2,
+		},
+		.gpio_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_WOW_GPIO_PARAM),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_wow_gpio_param_tlv)),
+			.gpio_pin = 0xff, /* follow fw about GPIO pin */
+		},
+	};
+
+	if (wowlan->magic_pkt)
+		req.wow_ctrl_tlv.trigger |= BIT(0);
+	if (wowlan->disconnect)
+		req.wow_ctrl_tlv.trigger |= BIT(2);
+	if (wowlan->nd_config) {
+		mt76_connac_mcu_sched_scan_req(phy, vif, wowlan->nd_config);
+		req.wow_ctrl_tlv.trigger |= BIT(5);
+		mt76_connac_mcu_sched_scan_enable(phy, vif, suspend);
+	}
+
+	if (mt76_is_mmio(dev))
+		req.wow_ctrl_tlv.wakeup_hif = WOW_PCIE;
+	else if (mt76_is_usb(dev))
+		req.wow_ctrl_tlv.wakeup_hif = WOW_USB;
+	else if (mt76_is_sdio(dev))
+		req.wow_ctrl_tlv.wakeup_hif = WOW_GPIO;
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_SUSPEND, &req, sizeof(req),
+				 true);
+}
+
+int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend)
+{
+	struct {
+		struct {
+			u8 hif_type; /* 0x0: HIF_SDIO
+				      * 0x1: HIF_USB
+				      * 0x2: HIF_PCIE
+				      */
+			u8 pad[3];
+		} __packed hdr;
+		struct hif_suspend_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 suspend;
+		} __packed hif_suspend;
+	} req = {
+		.hif_suspend = {
+			.tag = cpu_to_le16(0), /* 0: UNI_HIF_CTRL_BASIC */
+			.len = cpu_to_le16(sizeof(struct hif_suspend_tlv)),
+			.suspend = suspend,
+		},
+	};
+
+	if (mt76_is_mmio(dev))
+		req.hdr.hif_type = 2;
+	else if (mt76_is_usb(dev))
+		req.hdr.hif_type = 1;
+	else if (mt76_is_sdio(dev))
+		req.hdr.hif_type = 0;
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_HIF_CTRL, &req, sizeof(req),
+				 true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_hif_suspend);
+
+void mt76_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
+				      struct ieee80211_vif *vif)
+{
+	struct mt76_phy *phy = priv;
+	bool suspend = test_bit(MT76_STATE_SUSPEND, &phy->state);
+	struct ieee80211_hw *hw = phy->hw;
+	struct cfg80211_wowlan *wowlan = hw->wiphy->wowlan_config;
+	int i;
+
+	mt76_connac_mcu_set_gtk_rekey(phy->dev, vif, suspend);
+	mt76_connac_mcu_set_arp_filter(phy->dev, vif, suspend);
+
+	mt76_connac_mcu_set_suspend_mode(phy->dev, vif, suspend, 1, true);
+
+	for (i = 0; i < wowlan->n_patterns; i++)
+		mt76_connac_mcu_set_wow_pattern(phy->dev, vif, i, suspend,
+						&wowlan->patterns[i]);
+	mt76_connac_mcu_set_wow_ctrl(phy, vif, suspend, wowlan);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_suspend_iter);
+
+#endif /* CONFIG_PM */
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 8b6c1cd012f6..c8f5565e1f3c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -611,6 +611,27 @@ enum {
 	UNI_BSS_INFO_UAPSD = 19,
 };
 
+enum {
+	UNI_OFFLOAD_OFFLOAD_ARP,
+	UNI_OFFLOAD_OFFLOAD_ND,
+	UNI_OFFLOAD_OFFLOAD_GTK_REKEY,
+	UNI_OFFLOAD_OFFLOAD_BMC_RPY_DETECT,
+};
+
+enum {
+	UNI_SUSPEND_MODE_SETTING,
+	UNI_SUSPEND_WOW_CTRL,
+	UNI_SUSPEND_WOW_GPIO_PARAM,
+	UNI_SUSPEND_WOW_WAKEUP_PORT,
+	UNI_SUSPEND_WOW_PATTERN,
+};
+
+enum {
+	WOW_USB = 1,
+	WOW_PCIE = 2,
+	WOW_GPIO = 3,
+};
+
 struct mt76_connac_bss_basic_tlv {
 	__le16 tag;
 	__le16 len;
@@ -790,6 +811,102 @@ struct bss_info_uni_he {
 	u8 rsv[2];
 } __packed;
 
+struct mt76_connac_gtk_rekey_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 kek[NL80211_KEK_LEN];
+	u8 kck[NL80211_KCK_LEN];
+	u8 replay_ctr[NL80211_REPLAY_CTR_LEN];
+	u8 rekey_mode; /* 0: rekey offload enable
+			* 1: rekey offload disable
+			* 2: rekey update
+			*/
+	u8 keyid;
+	u8 pad[2];
+	__le32 proto; /* WPA-RSN-WAPI-OPSN */
+	__le32 pairwise_cipher;
+	__le32 group_cipher;
+	__le32 key_mgmt; /* NONE-PSK-IEEE802.1X */
+	__le32 mgmt_group_cipher;
+	u8 option; /* 1: rekey data update without enabling offload */
+	u8 reserverd[3];
+} __packed;
+
+#define MT76_CONNAC_WOW_MASK_MAX_LEN			16
+#define MT76_CONNAC_WOW_PATTEN_MAX_LEN			128
+
+struct mt76_connac_wow_pattern_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 index; /* pattern index */
+	u8 enable; /* 0: disable
+		    * 1: enable
+		    */
+	u8 data_len; /* pattern length */
+	u8 pad;
+	u8 mask[MT76_CONNAC_WOW_MASK_MAX_LEN];
+	u8 pattern[MT76_CONNAC_WOW_PATTEN_MAX_LEN];
+	u8 rsv[4];
+} __packed;
+
+struct mt76_connac_wow_ctrl_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 cmd; /* 0x1: PM_WOWLAN_REQ_START
+		 * 0x2: PM_WOWLAN_REQ_STOP
+		 * 0x3: PM_WOWLAN_PARAM_CLEAR
+		 */
+	u8 trigger; /* 0: NONE
+		     * BIT(0): NL80211_WOWLAN_TRIG_MAGIC_PKT
+		     * BIT(1): NL80211_WOWLAN_TRIG_ANY
+		     * BIT(2): NL80211_WOWLAN_TRIG_DISCONNECT
+		     * BIT(3): NL80211_WOWLAN_TRIG_GTK_REKEY_FAILURE
+		     * BIT(4): BEACON_LOST
+		     * BIT(5): NL80211_WOWLAN_TRIG_NET_DETECT
+		     */
+	u8 wakeup_hif; /* 0x0: HIF_SDIO
+			* 0x1: HIF_USB
+			* 0x2: HIF_PCIE
+			* 0x3: HIF_GPIO
+			*/
+	u8 pad;
+	u8 rsv[4];
+} __packed;
+
+struct mt76_connac_wow_gpio_param_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 gpio_pin;
+	u8 trigger_lvl;
+	u8 pad[2];
+	__le32 gpio_interval;
+	u8 rsv[4];
+} __packed;
+
+struct mt76_connac_arpns_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 mode;
+	u8 ips_num;
+	u8 option;
+	u8 pad[1];
+} __packed;
+
+struct mt76_connac_suspend_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 enable; /* 0: suspend mode disabled
+		    * 1: suspend mode enabled
+		    */
+	u8 mdtim; /* LP parameter */
+	u8 wow_suspend; /* 0: update by origin policy
+			 * 1: update by wow dtim
+			 */
+	u8 pad[5];
+} __packed;
+
+extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
+
 struct sk_buff *
 mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
 			      struct mt76_wcid *wcid);
@@ -864,5 +981,10 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
 int mt76_connac_mcu_sched_scan_enable(struct mt76_phy *phy,
 				      struct ieee80211_vif *vif,
 				      bool enable);
-
+int mt76_connac_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct cfg80211_gtk_rekey_data *key);
+int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend);
+void mt76_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
+				      struct ieee80211_vif *vif);
 #endif /* __MT76_CONNAC_MCU_H */
-- 
2.29.2

