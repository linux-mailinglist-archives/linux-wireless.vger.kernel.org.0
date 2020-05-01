Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7521C10EA
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgEAKgs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 06:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbgEAKgr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 06:36:47 -0400
Received: from lore-desk.lan (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4B37206B8;
        Fri,  1 May 2020 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588329406;
        bh=i+8+/mBWqs8bnmiabW9odTI3AUBw9IsXGitE8FI/EGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwU2NGOPLJdDLhubUWcun2SFC9s492B7SHIs6jYcPrxAIKGit70sAYywWp1Aaw1kz
         7TuCMc6leLn1KsdwuKnEcmI4emN8jI6N8SuI+y3zt7R2oXiUHq3WG422vIqnh5eUAP
         EkfchuWFii3RVz6RgxnKx0MJQFbCwp5FsVhtbZcQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org,
        soul.huang@mediatek.com
Subject: [PATCH 6/7] mt76: mt7615: add gtk rekey offload support
Date:   Fri,  1 May 2020 12:36:16 +0200
Message-Id: <f524edd6f8b13c986931a03de76ae330a93d3c80.1588329170.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588329170.git.lorenzo@kernel.org>
References: <cover.1588329170.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add KCK and KEK offload support to mt7615 driver in order to
support GTK rekeying during PM suspend

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Wan-Feng Jiang <Wan-Feng.Jiang@mediatek.com>
Signed-off-by: Wan-Feng Jiang <Wan-Feng.Jiang@mediatek.com>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   1 +
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   9 ++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 102 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  29 +++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   3 +
 5 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 7da0bf425061..0ec93ddab074 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -145,6 +145,7 @@ void mt7615_check_offload_capability(struct mt7615_dev *dev)
 		dev->ops->cancel_hw_scan = NULL;
 		dev->ops->sched_scan_start = NULL;
 		dev->ops->sched_scan_stop = NULL;
+		dev->ops->set_rekey_data = NULL;
 
 		wiphy->max_sched_scan_plan_interval = 0;
 		wiphy->max_sched_scan_ie_len = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 1346d5124a2a..61b2afb3fdb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -937,6 +937,14 @@ mt7615_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 	device_set_wakeup_enable(mdev->dev, enabled);
 }
 
+static void __maybe_unused
+mt7615_set_rekey_data(struct ieee80211_hw *hw,
+		      struct ieee80211_vif *vif,
+		      struct cfg80211_gtk_rekey_data *data)
+{
+	mt7615_mcu_update_gtk_rekey(hw, vif, data);
+}
+
 const struct ieee80211_ops mt7615_ops = {
 	.tx = mt7615_tx,
 	.start = mt7615_start,
@@ -974,6 +982,7 @@ const struct ieee80211_ops mt7615_ops = {
 	.suspend = mt7615_suspend,
 	.resume = mt7615_resume,
 	.set_wakeup = mt7615_set_wakeup,
+	.set_rekey_data = mt7615_set_rekey_data,
 #endif /* CONFIG_PM */
 };
 EXPORT_SYMBOL_GPL(mt7615_ops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 22e532aeb3cf..84d4b96028f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -196,6 +196,7 @@ mt7615_mcu_parse_response(struct mt7615_dev *dev, int cmd,
 	case MCU_UNI_CMD_BSS_INFO_UPDATE:
 	case MCU_UNI_CMD_STA_REC_UPDATE:
 	case MCU_UNI_CMD_HIF_CTRL:
+	case MCU_UNI_CMD_OFFLOAD:
 	case MCU_UNI_CMD_SUSPEND: {
 		struct mt7615_mcu_uni_event *event;
 
@@ -1833,7 +1834,8 @@ mt7615_mcu_send_ram_firmware(struct mt7615_dev *dev,
 }
 
 static const struct wiphy_wowlan_support mt7615_wowlan_support = {
-	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT |
+		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY,
 	.n_patterns = 1,
 	.pattern_min_len = 1,
 	.pattern_max_len = MT7615_WOW_PATTEN_MAX_LEN,
@@ -3362,6 +3364,33 @@ mt7615_mcu_set_suspend_mode(struct mt7615_dev *dev,
 				   &req, sizeof(req), true);
 }
 
+static int
+mt7615_mcu_set_gtk_rekey(struct mt7615_dev *dev,
+			 struct ieee80211_vif *vif,
+			 bool suspend)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7615_gtk_rekey_tlv gtk_tlv;
+	} __packed req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.gtk_tlv = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_GTK_REKEY),
+			.len = cpu_to_le16(sizeof(struct mt7615_gtk_rekey_tlv)),
+			.rekey_mode = !suspend,
+		},
+	};
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_OFFLOAD,
+				   &req, sizeof(req), true);
+}
+
 void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
 				 struct ieee80211_vif *vif)
 {
@@ -3373,6 +3402,8 @@ void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
 
 	mt7615_mcu_set_bss_pm(phy->dev, vif, suspend);
 
+	mt7615_mcu_set_gtk_rekey(phy->dev, vif, suspend);
+
 	mt7615_mcu_set_suspend_mode(phy->dev, vif, suspend, 1, true);
 
 	for (i = 0; i < wowlan->n_patterns; i++)
@@ -3380,3 +3411,72 @@ void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
 					   &wowlan->patterns[i]);
 	mt7615_mcu_set_wow_ctrl(phy->dev, vif, suspend, wowlan);
 }
+
+static void
+mt7615_mcu_key_iter(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		    struct ieee80211_sta *sta, struct ieee80211_key_conf *key,
+		    void *data)
+{
+	struct mt7615_gtk_rekey_tlv *gtk_tlv = data;
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
+int mt7615_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct cfg80211_gtk_rekey_data *key)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_gtk_rekey_tlv *gtk_tlv;
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
+	gtk_tlv = (struct mt7615_gtk_rekey_tlv *)skb_put(skb,
+							 sizeof(*gtk_tlv));
+	gtk_tlv->tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_GTK_REKEY);
+	gtk_tlv->len = cpu_to_le16(sizeof(*gtk_tlv));
+	gtk_tlv->rekey_mode = 2;
+	gtk_tlv->option = 1;
+
+	rcu_read_lock();
+	ieee80211_iter_keys_rcu(hw, vif, mt7615_mcu_key_iter, gtk_tlv);
+	rcu_read_unlock();
+
+	memcpy(gtk_tlv->kek, key->kek, NL80211_KEK_LEN);
+	memcpy(gtk_tlv->kck, key->kck, NL80211_KCK_LEN);
+	memcpy(gtk_tlv->replay_ctr, key->replay_ctr, NL80211_REPLAY_CTR_LEN);
+
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				       MCU_UNI_CMD_OFFLOAD, true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 960ff234c72d..890a202acfc9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -281,6 +281,7 @@ enum {
 	MCU_UNI_CMD_BSS_INFO_UPDATE = MCU_UNI_PREFIX | 0x02,
 	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
 	MCU_UNI_CMD_SUSPEND = MCU_UNI_PREFIX | 0x05,
+	MCU_UNI_CMD_OFFLOAD = MCU_UNI_PREFIX | 0x06,
 	MCU_UNI_CMD_HIF_CTRL = MCU_UNI_PREFIX | 0x07,
 };
 
@@ -469,6 +470,27 @@ struct mt7615_suspend_tlv {
 	u8 pad[5];
 } __packed;
 
+struct mt7615_gtk_rekey_tlv {
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
 /* offload mcu commands */
 enum {
 	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
@@ -501,6 +523,13 @@ enum {
 	UNI_SUSPEND_WOW_PATTERN,
 };
 
+enum {
+	UNI_OFFLOAD_OFFLOAD_ARPNS_IPV4,
+	UNI_OFFLOAD_OFFLOAD_ARPNS_IPV6,
+	UNI_OFFLOAD_OFFLOAD_GTK_REKEY,
+	UNI_OFFLOAD_OFFLOAD_BMC_RPY_DETECT,
+};
+
 enum {
 	PATCH_SEM_RELEASE = 0x0,
 	PATCH_SEM_GET	  = 0x1
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index be9188e40259..d3a83f3ed54e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -537,6 +537,9 @@ int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend);
 void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
 				 struct ieee80211_vif *vif);
+int mt7615_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct cfg80211_gtk_rekey_data *key);
 
 int __mt7663_load_firmware(struct mt7615_dev *dev);
 
-- 
2.25.4

