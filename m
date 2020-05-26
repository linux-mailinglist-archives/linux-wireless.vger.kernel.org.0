Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048081C10E6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 12:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgEAKgm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 06:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgEAKgl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 06:36:41 -0400
Received: from lore-desk.lan (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9485B2166E;
        Fri,  1 May 2020 10:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588329401;
        bh=rUDzcXAodGW2DBoi78CjRlY3cg2fYy8osYYCux9/Miw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YiivNjhFwXpJAFtHinjvjTPhFr+myq9BUzSCP5vxgGnQomELcFa6f8kuuIwAydx0W
         jxjk62zBTwAFGLjE5V3yEItOw3ruDTVqVQBTm7W34KvW5NwmbjTFnozem872QUFJkg
         2/LbKJYMkfPESh6H84Cf5Z4rIPGF0iNGhBTGmnzk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org,
        soul.huang@mediatek.com
Subject: [PATCH 3/7] mt76: mt7615: add WoW support
Date:   Fri,  1 May 2020 12:36:13 +0200
Message-Id: <ca5b2dba585ac0a3bb841f3196abf49be60a9b0d.1588329170.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588329170.git.lorenzo@kernel.org>
References: <cover.1588329170.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce WoW support to mt7615 driver.
Current supported trigger are:
- magic-packet
- disconnect
- user-pattern

Co-developed-by: Wan-Feng Jiang <Wan-Feng.Jiang@mediatek.com>
Signed-off-by: Wan-Feng Jiang <Wan-Feng.Jiang@mediatek.com>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  78 ++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 138 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  62 ++++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   4 +-
 5 files changed, 278 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6106dc4fea44..f1c9116b6ab4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -287,6 +287,7 @@ enum {
 	MT76_READING_STATS,
 	MT76_STATE_POWER_OFF,
 	MT76_STATE_PS,
+	MT76_STATE_SUSPEND,
 };
 
 struct mt76_hw_cap {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 5e54c7ffae0b..1346d5124a2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -864,6 +864,79 @@ mt7615_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	return mt7615_mcu_sched_scan_enable(mphy->priv, vif, false);
 }
 
+static int __maybe_unused
+mt7615_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
+{
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	bool ext_phy = phy != &dev->phy;
+	int err = 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	cancel_delayed_work_sync(&phy->scan_work);
+	cancel_delayed_work_sync(&phy->mac_work);
+
+	mt76_set(dev, MT_WF_RFCR(ext_phy), MT_WF_RFCR_DROP_OTHER_BEACON);
+
+	set_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7615_mcu_set_suspend_iter, phy);
+
+	if (!mt7615_dev_running(dev))
+		err = mt7615_mcu_set_hif_suspend(dev, true);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+
+static int __maybe_unused mt7615_resume(struct ieee80211_hw *hw)
+{
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	bool running, ext_phy = phy != &dev->phy;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	running = mt7615_dev_running(dev);
+	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+
+	if (!running) {
+		int err;
+
+		err = mt7615_mcu_set_hif_suspend(dev, false);
+		if (err < 0) {
+			mutex_unlock(&dev->mt76.mutex);
+			return err;
+		}
+	}
+
+	clear_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7615_mcu_set_suspend_iter, phy);
+
+	ieee80211_queue_delayed_work(hw, &phy->mac_work,
+				     MT7615_WATCHDOG_TIME);
+	mt76_clear(dev, MT_WF_RFCR(ext_phy), MT_WF_RFCR_DROP_OTHER_BEACON);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static void __maybe_unused
+mt7615_set_wakeup(struct ieee80211_hw *hw, bool enabled)
+{
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt76_dev *mdev = &dev->mt76;
+
+	device_set_wakeup_enable(mdev->dev, enabled);
+}
+
 const struct ieee80211_ops mt7615_ops = {
 	.tx = mt7615_tx,
 	.start = mt7615_start,
@@ -897,6 +970,11 @@ const struct ieee80211_ops mt7615_ops = {
 	.cancel_hw_scan = mt7615_cancel_hw_scan,
 	.sched_scan_start = mt7615_start_sched_scan,
 	.sched_scan_stop = mt7615_stop_sched_scan,
+#ifdef CONFIG_PM
+	.suspend = mt7615_suspend,
+	.resume = mt7615_resume,
+	.set_wakeup = mt7615_set_wakeup,
+#endif /* CONFIG_PM */
 };
 EXPORT_SYMBOL_GPL(mt7615_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 95cb239b03e5..2d077c18a4b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -195,7 +195,8 @@ mt7615_mcu_parse_response(struct mt7615_dev *dev, int cmd,
 	case MCU_UNI_CMD_DEV_INFO_UPDATE:
 	case MCU_UNI_CMD_BSS_INFO_UPDATE:
 	case MCU_UNI_CMD_STA_REC_UPDATE:
-	case MCU_UNI_CMD_HIF_CTRL: {
+	case MCU_UNI_CMD_HIF_CTRL:
+	case MCU_UNI_CMD_SUSPEND: {
 		struct mt7615_mcu_uni_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
@@ -1829,6 +1830,13 @@ mt7615_mcu_send_ram_firmware(struct mt7615_dev *dev,
 	return 0;
 }
 
+static const struct wiphy_wowlan_support mt7615_wowlan_support = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+	.n_patterns = 1,
+	.pattern_min_len = 1,
+	.pattern_max_len = MT7615_WOW_PATTEN_MAX_LEN,
+};
+
 static int mt7615_load_n9(struct mt7615_dev *dev, const char *name)
 {
 	const struct mt7615_fw_trailer *hdr;
@@ -2151,6 +2159,9 @@ int __mt7663_load_firmware(struct mt7615_dev *dev)
 		return -EIO;
 	}
 
+	if (IS_ENABLED(CONFIG_PM) && mt7615_firmware_offload(dev))
+		dev->mt76.hw->wiphy->wowlan = &mt7615_wowlan_support;
+
 	dev_dbg(dev->mt76.dev, "Firmware init done\n");
 
 	return 0;
@@ -2647,8 +2658,9 @@ void m7615_mcu_set_ps_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 				    &req, sizeof(req), false);
 }
 
-int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-			  bool enable)
+static int
+mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+		      bool enable)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct {
@@ -3246,3 +3258,123 @@ int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend)
 				   &req, sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_set_hif_suspend);
+
+static int
+mt7615_mcu_set_wow_ctrl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+			bool suspend, struct cfg80211_wowlan *wowlan)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7615_wow_ctrl_tlv wow_ctrl_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.wow_ctrl_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_WOW_CTRL),
+			.len = cpu_to_le16(sizeof(struct mt7615_wow_ctrl_tlv)),
+			.cmd = suspend ? 1 : 2,
+		},
+	};
+
+	if (wowlan->magic_pkt)
+		req.wow_ctrl_tlv.trigger |= BIT(0);
+	if (wowlan->disconnect)
+		req.wow_ctrl_tlv.trigger |= BIT(2);
+
+	if (mt76_is_mmio(&dev->mt76))
+		req.wow_ctrl_tlv.wakeup_hif = 2;
+	else if (mt76_is_usb(&dev->mt76))
+		req.wow_ctrl_tlv.wakeup_hif = 1;
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_SUSPEND,
+				   &req, sizeof(req), true);
+}
+
+static int
+mt7615_mcu_set_wow_pattern(struct mt7615_dev *dev,
+			   struct ieee80211_vif *vif,
+			   u8 index, bool enable,
+			   struct cfg80211_pkt_pattern *pattern)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt7615_wow_pattern_tlv *ptlv;
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
+	ptlv = (struct mt7615_wow_pattern_tlv *)skb_put(skb, sizeof(*ptlv));
+	ptlv->tag = cpu_to_le16(UNI_SUSPEND_WOW_PATTERN);
+	ptlv->len = cpu_to_le16(sizeof(*ptlv));
+	ptlv->data_len = pattern->pattern_len;
+	ptlv->enable = enable;
+	ptlv->index = index;
+
+	memcpy(ptlv->pattern, pattern->pattern, pattern->pattern_len);
+	memcpy(ptlv->mask, pattern->mask, pattern->pattern_len / 8);
+
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				       MCU_UNI_CMD_SUSPEND, true);
+}
+
+static int
+mt7615_mcu_set_suspend_mode(struct mt7615_dev *dev,
+			    struct ieee80211_vif *vif,
+			    bool enable, u8 mdtim, bool wow_suspend)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7615_suspend_tlv suspend_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.suspend_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_MODE_SETTING),
+			.len = cpu_to_le16(sizeof(struct mt7615_suspend_tlv)),
+			.enable = enable,
+			.mdtim = mdtim,
+			.wow_suspend = wow_suspend,
+		},
+	};
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_SUSPEND,
+				   &req, sizeof(req), true);
+}
+
+void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
+				 struct ieee80211_vif *vif)
+{
+	struct mt7615_phy *phy = priv;
+	bool suspend = test_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
+	struct ieee80211_hw *hw = phy->mt76->hw;
+	struct cfg80211_wowlan *wowlan = hw->wiphy->wowlan_config;
+	int i;
+
+	mt7615_mcu_set_bss_pm(phy->dev, vif, suspend);
+
+	mt7615_mcu_set_suspend_mode(phy->dev, vif, suspend, 1, true);
+
+	for (i = 0; i < wowlan->n_patterns; i++)
+		mt7615_mcu_set_wow_pattern(phy->dev, vif, i, suspend,
+					   &wowlan->patterns[i]);
+	mt7615_mcu_set_wow_ctrl(phy->dev, vif, suspend, wowlan);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 1579ad944479..960ff234c72d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -280,6 +280,7 @@ enum {
 	MCU_UNI_CMD_DEV_INFO_UPDATE = MCU_UNI_PREFIX | 0x01,
 	MCU_UNI_CMD_BSS_INFO_UPDATE = MCU_UNI_PREFIX | 0x02,
 	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
+	MCU_UNI_CMD_SUSPEND = MCU_UNI_PREFIX | 0x05,
 	MCU_UNI_CMD_HIF_CTRL = MCU_UNI_PREFIX | 0x07,
 };
 
@@ -415,6 +416,59 @@ struct mt7615_mcu_bss_event {
 	u8 pad;
 } __packed;
 
+struct mt7615_wow_ctrl_tlv {
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
+#define MT7615_WOW_MASK_MAX_LEN		16
+#define MT7615_WOW_PATTEN_MAX_LEN	128
+struct mt7615_wow_pattern_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 index; /* pattern index */
+	u8 enable; /* 0: disable
+		    * 1: enable
+		    */
+	u8 data_len; /* pattern length */
+	u8 pad;
+	u8 mask[MT7615_WOW_MASK_MAX_LEN];
+	u8 pattern[MT7615_WOW_PATTEN_MAX_LEN];
+	u8 rsv[4];
+} __packed;
+
+struct mt7615_suspend_tlv {
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
 /* offload mcu commands */
 enum {
 	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
@@ -439,6 +493,14 @@ enum {
 	UNI_BSS_INFO_BCN_CONTENT = 7,
 };
 
+enum {
+	UNI_SUSPEND_MODE_SETTING,
+	UNI_SUSPEND_WOW_CTRL,
+	UNI_SUSPEND_WOW_GPIO_PARAM,
+	UNI_SUSPEND_WOW_WAKEUP_PORT,
+	UNI_SUSPEND_WOW_PATTERN,
+};
+
 enum {
 	PATCH_SEM_RELEASE = 0x0,
 	PATCH_SEM_GET	  = 0x1
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 6a26555dcce6..3e6bc3ce914a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -474,8 +474,6 @@ int mt7615_mac_wtbl_update_key(struct mt7615_dev *dev,
 			       enum set_key_cmd cmd);
 void mt7615_mac_reset_work(struct work_struct *work);
 
-int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-			  bool enable);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 			int len, bool wait_resp);
@@ -532,6 +530,8 @@ int mt7615_init_debugfs(struct mt7615_dev *dev);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 
 int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend);
+void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
+				 struct ieee80211_vif *vif);
 
 int __mt7663_load_firmware(struct mt7615_dev *dev);
 
-- 
2.25.4

