Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4575A2E9C83
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 19:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbhADSCJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 13:02:09 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33089 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727630AbhADSCJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 13:02:09 -0500
X-UUID: d4d4f80a4032480da6d2d8738808b9be-20210105
X-UUID: d4d4f80a4032480da6d2d8738808b9be-20210105
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1444318778; Tue, 05 Jan 2021 02:00:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 02:00:22 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 02:00:23 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v5 15/15] mt76: mt7921: introduce PM support
Date:   Tue, 5 Jan 2021 02:00:19 +0800
Message-ID: <b82d602153b75ecad239f1bcd187d15684f1df84.1609781247.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1609781247.git.objelf@gmail.com>
References: <cover.1609781247.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D7C3A44D49B89045792F6A829479D754E0D36196F317A46C170D6F450DE500B92000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce suspend/resume and WoW (Wake-on-WoWLAN) support to mt7921
driver to allow remote wakeu-up from the suspend state.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  79 +++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 307 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  99 ++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   9 +
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  95 ++++++
 5 files changed, 589 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 0af5e536e5cc..390ea23c92d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -938,6 +938,79 @@ mt7921_sta_rc_update(struct ieee80211_hw *hw,
 {
 }
 
+#ifdef CONFIG_PM
+static int mt7921_suspend(struct ieee80211_hw *hw,
+			  struct cfg80211_wowlan *wowlan)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int err;
+
+	cancel_delayed_work_sync(&phy->scan_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+
+	set_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7921_mcu_set_suspend_iter, phy);
+
+	err = mt7921_mcu_set_hif_suspend(dev, true);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+
+static int mt7921_resume(struct ieee80211_hw *hw)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int err;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	err = mt7921_mcu_set_hif_suspend(dev, false);
+	if (err < 0)
+		goto out;
+
+	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	clear_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7921_mcu_set_suspend_iter, phy);
+
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
+				     MT7921_WATCHDOG_TIME);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+
+static void mt7921_set_wakeup(struct ieee80211_hw *hw, bool enabled)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_dev *mdev = &dev->mt76;
+
+	device_set_wakeup_enable(mdev->dev, enabled);
+}
+
+static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct cfg80211_gtk_rekey_data *data)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7921_mcu_update_gtk_rekey(hw, vif, data);
+	mutex_unlock(&dev->mt76.mutex);
+}
+#endif /* CONFIG_PM */
+
 const struct ieee80211_ops mt7921_ops = {
 	.tx = mt7921_tx,
 	.start = mt7921_start,
@@ -969,4 +1042,10 @@ const struct ieee80211_ops mt7921_ops = {
 	.cancel_hw_scan = mt7921_cancel_hw_scan,
 	.sched_scan_start = mt7921_start_sched_scan,
 	.sched_scan_stop = mt7921_stop_sched_scan,
+#ifdef CONFIG_PM
+	.suspend = mt7921_suspend,
+	.resume = mt7921_resume,
+	.set_wakeup = mt7921_set_wakeup,
+	.set_rekey_data = mt7921_set_rekey_data,
+#endif /* CONFIG_PM */
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 57f8b7b770dc..becb31e09c82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1704,6 +1704,15 @@ static int mt7921_load_ram(struct mt7921_dev *dev)
 	return ret;
 }
 
+static const struct wiphy_wowlan_support mt7921_wowlan_support = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT |
+		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY | WIPHY_WOWLAN_NET_DETECT,
+	.n_patterns = 1,
+	.pattern_min_len = 1,
+	.pattern_max_len = MT7921_WOW_PATTEN_MAX_LEN,
+	.max_nd_match_sets = 10,
+};
+
 static int mt7921_load_firmware(struct mt7921_dev *dev)
 {
 	int ret;
@@ -1731,6 +1740,10 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
 
+#ifdef CONFIG_PM
+	dev->mt76.hw->wiphy->wowlan = &mt7921_wowlan_support;
+#endif /* CONFIG_PM */
+
 	dev_err(dev->mt76.dev, "Firmware init done\n");
 
 	return 0;
@@ -2623,3 +2636,297 @@ int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED, &req,
 				 sizeof(req), false);
 }
+
+#ifdef CONFIG_PM
+int mt7921_mcu_set_hif_suspend(struct mt7921_dev *dev, bool suspend)
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
+	if (mt76_is_mmio(&dev->mt76))
+		req.hdr.hif_type = 2;
+	else if (mt76_is_usb(&dev->mt76))
+		req.hdr.hif_type = 1;
+	else if (mt76_is_sdio(&dev->mt76))
+		req.hdr.hif_type = 0;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_HIF_CTRL, &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt7921_mcu_set_hif_suspend);
+
+static int
+mt7921_mcu_set_wow_ctrl(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+			bool suspend, struct cfg80211_wowlan *wowlan)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7921_wow_ctrl_tlv wow_ctrl_tlv;
+		struct mt7921_wow_gpio_param_tlv gpio_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.wow_ctrl_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_WOW_CTRL),
+			.len = cpu_to_le16(sizeof(struct mt7921_wow_ctrl_tlv)),
+			.cmd = suspend ? 1 : 2,
+		},
+		.gpio_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_WOW_GPIO_PARAM),
+			.len = cpu_to_le16(sizeof(struct mt7921_wow_gpio_param_tlv)),
+			.gpio_pin = 0xff, /* follow fw about GPIO pin */
+		},
+	};
+
+	if (wowlan->magic_pkt)
+		req.wow_ctrl_tlv.trigger |= BIT(0);
+	if (wowlan->disconnect)
+		req.wow_ctrl_tlv.trigger |= BIT(2);
+	if (wowlan->nd_config) {
+		mt7921_mcu_sched_scan_req(phy, vif, wowlan->nd_config);
+		req.wow_ctrl_tlv.trigger |= BIT(5);
+		mt7921_mcu_sched_scan_enable(phy, vif, suspend);
+	}
+
+	if (mt76_is_mmio(&dev->mt76))
+		req.wow_ctrl_tlv.wakeup_hif = WOW_PCIE;
+	else if (mt76_is_usb(&dev->mt76))
+		req.wow_ctrl_tlv.wakeup_hif = WOW_USB;
+	else if (mt76_is_sdio(&dev->mt76))
+		req.wow_ctrl_tlv.wakeup_hif = WOW_GPIO;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_SUSPEND, &req,
+				 sizeof(req), true);
+}
+
+static int
+mt7921_mcu_set_wow_pattern(struct mt7921_dev *dev,
+			   struct ieee80211_vif *vif,
+			   u8 index, bool enable,
+			   struct cfg80211_pkt_pattern *pattern)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_wow_pattern_tlv *ptlv;
+	struct sk_buff *skb;
+	struct req_hdr {
+		u8 bss_idx;
+		u8 pad[3];
+	} __packed hdr = {
+		.bss_idx = mvif->idx,
+	};
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+				 sizeof(hdr) + sizeof(*ptlv));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+	ptlv = (struct mt7921_wow_pattern_tlv *)skb_put(skb, sizeof(*ptlv));
+	ptlv->tag = cpu_to_le16(UNI_SUSPEND_WOW_PATTERN);
+	ptlv->len = cpu_to_le16(sizeof(*ptlv));
+	ptlv->data_len = pattern->pattern_len;
+	ptlv->enable = enable;
+	ptlv->index = index;
+
+	memcpy(ptlv->pattern, pattern->pattern, pattern->pattern_len);
+	memcpy(ptlv->mask, pattern->mask, pattern->pattern_len / 8);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_UNI_CMD_SUSPEND,
+				     true);
+}
+
+static int
+mt7921_mcu_set_suspend_mode(struct mt7921_dev *dev,
+			    struct ieee80211_vif *vif,
+			    bool enable, u8 mdtim, bool wow_suspend)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7921_suspend_tlv suspend_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.suspend_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_MODE_SETTING),
+			.len = cpu_to_le16(sizeof(struct mt7921_suspend_tlv)),
+			.enable = enable,
+			.mdtim = mdtim,
+			.wow_suspend = wow_suspend,
+		},
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_SUSPEND, &req,
+				 sizeof(req), true);
+}
+
+static int
+mt7921_mcu_set_gtk_rekey(struct mt7921_dev *dev,
+			 struct ieee80211_vif *vif,
+			 bool suspend)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7921_gtk_rekey_tlv gtk_tlv;
+	} __packed req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.gtk_tlv = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_GTK_REKEY),
+			.len = cpu_to_le16(sizeof(struct mt7921_gtk_rekey_tlv)),
+			.rekey_mode = !suspend,
+		},
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_OFFLOAD, &req,
+				 sizeof(req), true);
+}
+
+static int
+mt7921_mcu_set_arp_filter(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+			  bool suspend)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7921_arpns_tlv arpns;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.arpns = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
+			.len = cpu_to_le16(sizeof(struct mt7921_arpns_tlv)),
+			.mode = suspend,
+		},
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_OFFLOAD, &req,
+				 sizeof(req), true);
+}
+
+void mt7921_mcu_set_suspend_iter(void *priv, u8 *mac,
+				 struct ieee80211_vif *vif)
+{
+	struct mt7921_phy *phy = priv;
+	bool suspend = test_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
+	struct ieee80211_hw *hw = phy->mt76->hw;
+	struct cfg80211_wowlan *wowlan = hw->wiphy->wowlan_config;
+	int i;
+
+	mt7921_mcu_set_gtk_rekey(phy->dev, vif, suspend);
+	mt7921_mcu_set_arp_filter(phy->dev, vif, suspend);
+
+	mt7921_mcu_set_suspend_mode(phy->dev, vif, suspend, 1, true);
+
+	for (i = 0; i < wowlan->n_patterns; i++)
+		mt7921_mcu_set_wow_pattern(phy->dev, vif, i, suspend,
+					   &wowlan->patterns[i]);
+	mt7921_mcu_set_wow_ctrl(phy, vif, suspend, wowlan);
+}
+
+static void
+mt7921_mcu_key_iter(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		    struct ieee80211_sta *sta, struct ieee80211_key_conf *key,
+		    void *data)
+{
+	struct mt7921_gtk_rekey_tlv *gtk_tlv = data;
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
+int mt7921_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct cfg80211_gtk_rekey_data *key)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_gtk_rekey_tlv *gtk_tlv;
+	struct sk_buff *skb;
+	struct {
+		u8 bss_idx;
+		u8 pad[3];
+	} __packed hdr = {
+		.bss_idx = mvif->idx,
+	};
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+				 sizeof(hdr) + sizeof(*gtk_tlv));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+	gtk_tlv = (struct mt7921_gtk_rekey_tlv *)skb_put(skb,
+							 sizeof(*gtk_tlv));
+	gtk_tlv->tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_GTK_REKEY);
+	gtk_tlv->len = cpu_to_le16(sizeof(*gtk_tlv));
+	gtk_tlv->rekey_mode = 2;
+	gtk_tlv->option = 1;
+
+	rcu_read_lock();
+	ieee80211_iter_keys_rcu(hw, vif, mt7921_mcu_key_iter, gtk_tlv);
+	rcu_read_unlock();
+
+	memcpy(gtk_tlv->kek, key->kek, NL80211_KEK_LEN);
+	memcpy(gtk_tlv->kck, key->kck, NL80211_KCK_LEN);
+	memcpy(gtk_tlv->replay_ctr, key->replay_ctr, NL80211_REPLAY_CTR_LEN);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_UNI_CMD_OFFLOAD,
+				     true);
+}
+#endif /* CONFIG_PM */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index d6cb062619db..151a36f1b878 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -182,6 +182,105 @@ struct mt7921_mcu_uni_event {
 	__le32 status; /* 0: success, others: fail */
 } __packed;
 
+enum {
+	WOW_USB = 1,
+	WOW_PCIE = 2,
+	WOW_GPIO = 3,
+};
+
+struct mt7921_wow_ctrl_tlv {
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
+struct mt7921_wow_gpio_param_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 gpio_pin;
+	u8 trigger_lvl;
+	u8 pad[2];
+	__le32 gpio_interval;
+	u8 rsv[4];
+} __packed;
+
+#define MT7921_WOW_MASK_MAX_LEN		16
+#define MT7921_WOW_PATTEN_MAX_LEN	128
+struct mt7921_wow_pattern_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 index; /* pattern index */
+	u8 enable; /* 0: disable
+		    * 1: enable
+		    */
+	u8 data_len; /* pattern length */
+	u8 pad;
+	u8 mask[MT7921_WOW_MASK_MAX_LEN];
+	u8 pattern[MT7921_WOW_PATTEN_MAX_LEN];
+	u8 rsv[4];
+} __packed;
+
+struct mt7921_suspend_tlv {
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
+struct mt7921_gtk_rekey_tlv {
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
+struct mt7921_arpns_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 mode;
+	u8 ips_num;
+	u8 option;
+	u8 pad[1];
+} __packed;
+
 /* offload mcu commands */
 enum {
 	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 54d3d21abf91..8d3af412d75c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -365,4 +365,13 @@ u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx);
 int mt7921_mcu_set_vif_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
+int mt7921_mcu_set_hif_suspend(struct mt7921_dev *dev, bool suspend);
+void mt7921_mcu_set_suspend_iter(void *priv, u8 *mac,
+				 struct ieee80211_vif *vif);
+int mt7921_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct cfg80211_gtk_rekey_data *key);
+int mt7921_mcu_update_arp_filter(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_bss_conf *info);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 6808bc749583..202cde1b6289 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -167,11 +167,106 @@ static void mt7921_pci_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
+#ifdef CONFIG_PM
+static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	bool hif_suspend;
+	int i, err;
+
+	hif_suspend = !test_bit(MT76_STATE_SUSPEND, &dev->mphy.state);
+	if (hif_suspend) {
+		err = mt7921_mcu_set_hif_suspend(dev, true);
+		if (err)
+			return err;
+	}
+
+	napi_disable(&mdev->tx_napi);
+	mt76_worker_disable(&mdev->tx_worker);
+
+	mt76_for_each_q_rx(mdev, i) {
+		napi_disable(&mdev->napi[i]);
+	}
+	tasklet_kill(&dev->irq_tasklet);
+
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), true);
+
+	/* wait until dma is idle  */
+	mt76_poll(dev, MT_WFDMA0_GLO_CFG,
+		  MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+		  MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000);
+
+	/* put dma disabled */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	/* disable interrupt */
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+
+	pci_save_state(pdev);
+	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
+	if (err)
+		goto restore;
+
+	return 0;
+
+restore:
+	mt76_for_each_q_rx(mdev, i) {
+		napi_enable(&mdev->napi[i]);
+	}
+	napi_enable(&mdev->tx_napi);
+	if (hif_suspend)
+		mt7921_mcu_set_hif_suspend(dev, false);
+
+	return err;
+}
+
+static int mt7921_pci_resume(struct pci_dev *pdev)
+{
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	int i, err;
+
+	err = pci_set_power_state(pdev, PCI_D0);
+	if (err)
+		return err;
+
+	pci_restore_state(pdev);
+
+	/* enable interrupt */
+	mt7921_l1_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+	mt7921_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
+			  MT_INT_MCU_CMD);
+
+	/* put dma enabled */
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	mt76_worker_enable(&mdev->tx_worker);
+	mt76_for_each_q_rx(mdev, i) {
+		napi_enable(&mdev->napi[i]);
+		napi_schedule(&mdev->napi[i]);
+	}
+	napi_enable(&mdev->tx_napi);
+	napi_schedule(&mdev->tx_napi);
+
+	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state))
+		err = mt7921_mcu_set_hif_suspend(dev, false);
+
+	return err;
+}
+#endif /* CONFIG_PM */
+
 struct pci_driver mt7921_pci_driver = {
 	.name		= KBUILD_MODNAME,
 	.id_table	= mt7921_pci_device_table,
 	.probe		= mt7921_pci_probe,
 	.remove		= mt7921_pci_remove,
+#ifdef CONFIG_PM
+	.suspend	= mt7921_pci_suspend,
+	.resume		= mt7921_pci_resume,
+#endif /* CONFIG_PM */
 };
 
 module_pci_driver(mt7921_pci_driver);
-- 
2.25.1

