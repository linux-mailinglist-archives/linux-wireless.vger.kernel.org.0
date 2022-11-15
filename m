Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320D8628E07
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Nov 2022 01:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiKOALo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 19:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbiKOALl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 19:11:41 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FB013E07
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 16:11:35 -0800 (PST)
X-UUID: 21fa2a80c6fa423d8237528ae69e3380-20221115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8aeeIobrpIB+TZumGtSSdh3MIa6q1VUaAfM0G7D3fJo=;
        b=qKgg4inEkt7TbT9TfKgP3VJHqIZ8sI/pO0TuMK1BrOPDrUE0Luk4AHeWosTBpiLsusdjsov8Td/QvYWkPzv1u+lVk5mF+XDOihlFJ1WZg/vbZUDhClITaCgmDavjb5buX1CtYpHiff1HYmRBsYSEk5mjYGPpIh6AKDfJ++6z7nY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:9b861916-dd80-44dd-98e7-43c60e158cfe,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.13,REQID:9b861916-dd80-44dd-98e7-43c60e158cfe,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:d12e911,CLOUDID:fd178073-e2f1-446d-b75e-e1f2a8186d19,B
        ulkID:2211150811318IR8ZNJS,BulkQuantity:1,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 21fa2a80c6fa423d8237528ae69e3380-20221115
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 789309016; Tue, 15 Nov 2022 08:11:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 15 Nov 2022 08:11:27 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 15 Nov 2022 08:11:27 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v4 1/2] wifi: mt76: mt7921: introduce remain_on_channel support
Date:   Tue, 15 Nov 2022 08:11:23 +0800
Message-ID: <5de5ade093c96639edd3839482f30f771f107fce.1668467719.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1668467719.git.objelf@gmail.com>
References: <cover.1668467719.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce remain_on_channel support. Additionally, we add
mt7921_check_offload_capability to disable .remain_on_channel and
.cancel_remain_on_channel and related configuration because those
operations would rely on the fundamental MCU commands that will be only
supported with newer firmware.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  63 ++++++++++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 112 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  24 ++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  48 ++++++++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  33 ++++--
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  23 +++-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  13 +-
 7 files changed, 304 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index dcdb3cf04ac1..e9353e9929a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/etherdevice.h>
+#include <linux/firmware.h>
 #include "mt7921.h"
 #include "mac.h"
 #include "mcu.h"
@@ -65,12 +66,18 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	hw->sta_data_size = sizeof(struct mt7921_sta);
 	hw->vif_data_size = sizeof(struct mt7921_vif);
 
+	if (dev->fw_features & MT7921_FW_CAP_CNM)
+		wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
+	else
+		wiphy->flags &= ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
+
 	wiphy->iface_combinations = if_comb;
 	wiphy->flags &= ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
 			  WIPHY_FLAG_4ADDR_STATION);
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				 BIT(NL80211_IFTYPE_AP);
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	wiphy->max_remain_on_channel_duration = 5000;
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
 	wiphy->max_sched_scan_plan_interval =
@@ -129,6 +136,58 @@ mt7921_mac_init_band(struct mt7921_dev *dev, u8 band)
 	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
 }
 
+u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
+{
+	struct mt7921_fw_features *features = NULL;
+	const struct mt76_connac2_fw_trailer *hdr;
+	struct mt7921_realease_info *rel_info;
+	const struct firmware *fw;
+	int ret, i, offset = 0;
+	const u8 *data, *end;
+
+	ret = request_firmware(&fw, fw_wm, dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev, "Invalid firmware\n");
+		return -EINVAL;
+	}
+
+	data = fw->data;
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
+
+	for (i = 0; i < hdr->n_region; i++) {
+		const struct mt76_connac2_fw_region *region;
+
+		region = (const void *)((const u8 *)hdr -
+					(hdr->n_region - i) * sizeof(*region));
+		offset += le32_to_cpu(region->len);
+	}
+
+	data += offset + 16;
+	rel_info = (struct mt7921_realease_info *)data;
+	data += sizeof(*rel_info);
+	end = data + le16_to_cpu(rel_info->len);
+
+	while (data < end) {
+		rel_info = (struct mt7921_realease_info *)data;
+		data += sizeof(*rel_info);
+
+		if (rel_info->tag == MT7921_FW_TAG_FEATURE) {
+			features = (struct mt7921_fw_features *)data;
+			break;
+		}
+
+		data += le16_to_cpu(rel_info->len) + rel_info->pad_len;
+	}
+
+	release_firmware(fw);
+
+	return features ? features->data : 0;
+}
+EXPORT_SYMBOL_GPL(mt7921_check_offload_capability);
+
 int mt7921_mac_init(struct mt7921_dev *dev)
 {
 	int i;
@@ -278,6 +337,10 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
 	INIT_WORK(&dev->init_work, mt7921_init_work);
 
+	INIT_WORK(&dev->phy.roc_work, mt7921_roc_work);
+	timer_setup(&dev->phy.roc_timer, mt7921_roc_timer, 0);
+	init_waitqueue_head(&dev->phy.roc_wait);
+
 	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index cc3365c4f8c5..012c92d49f49 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -386,6 +386,116 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
 }
 
+static void mt7921_roc_iter(void *priv, u8 *mac,
+			    struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_phy *phy = priv;
+
+	mt7921_mcu_abort_roc(phy, mvif, phy->roc_token_id);
+}
+
+void mt7921_roc_work(struct work_struct *work)
+{
+	struct mt7921_phy *phy;
+
+	phy = (struct mt7921_phy *)container_of(work, struct mt7921_phy,
+						roc_work);
+
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return;
+
+	mt7921_mutex_acquire(phy->dev);
+	ieee80211_iterate_active_interfaces(phy->mt76->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7921_roc_iter, phy);
+	mt7921_mutex_release(phy->dev);
+	ieee80211_remain_on_channel_expired(phy->mt76->hw);
+}
+
+void mt7921_roc_timer(struct timer_list *timer)
+{
+	struct mt7921_phy *phy = from_timer(phy, timer, roc_timer);
+
+	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
+}
+
+static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif)
+{
+	int err;
+
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return 0;
+
+	del_timer_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
+	err = mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
+	clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+
+	return err;
+}
+
+static int mt7921_set_roc(struct mt7921_phy *phy,
+			  struct mt7921_vif *vif,
+			  struct ieee80211_channel *chan,
+			  int duration,
+			  enum mt7921_roc_req type)
+{
+	int err;
+
+	if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return -EBUSY;
+
+	phy->roc_grant = false;
+
+	err = mt7921_mcu_set_roc(phy, vif, chan, duration, type,
+				 ++phy->roc_token_id);
+	if (err < 0) {
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		goto out;
+	}
+
+	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, HZ)) {
+		mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		err = -ETIMEDOUT;
+	}
+
+out:
+	return err;
+}
+
+static int mt7921_remain_on_channel(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_channel *chan,
+				    int duration,
+				    enum ieee80211_roc_type type)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int err;
+
+	mt7921_mutex_acquire(phy->dev);
+	err = mt7921_set_roc(phy, mvif, chan, duration, MT7921_ROC_REQ_ROC);
+	mt7921_mutex_release(phy->dev);
+
+	return err;
+}
+
+static int mt7921_cancel_remain_on_channel(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int err;
+
+	mt7921_mutex_acquire(phy->dev);
+	err = mt7921_abort_roc(phy, mvif);
+	mt7921_mutex_release(phy->dev);
+
+	return err;
+}
+
 static int mt7921_set_channel(struct mt7921_phy *phy)
 {
 	struct mt7921_dev *dev = phy->dev;
@@ -1623,6 +1733,8 @@ const struct ieee80211_ops mt7921_ops = {
 #endif /* CONFIG_PM */
 	.flush = mt7921_flush,
 	.set_sar_specs = mt7921_set_sar_specs,
+	.remain_on_channel = mt7921_remain_on_channel,
+	.cancel_remain_on_channel = mt7921_cancel_remain_on_channel,
 };
 EXPORT_SYMBOL_GPL(mt7921_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 7a74abecb269..fb9c0f66cb27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -154,6 +154,29 @@ void mt7921_mcu_set_suspend_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 
 #endif /* CONFIG_PM */
 
+static void
+mt7921_mcu_uni_roc_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_roc_grant_tlv *grant;
+	struct mt76_connac2_mcu_rxd *rxd;
+	int duration;
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+	grant = (struct mt7921_roc_grant_tlv *)(rxd->tlv + 4);
+
+	/* should never happen */
+	WARN_ON_ONCE((le16_to_cpu(grant->tag) != UNI_EVENT_ROC_GRANT));
+
+	if (grant->reqtype == MT7921_ROC_REQ_ROC)
+		ieee80211_ready_on_channel(dev->mt76.phy.hw);
+
+	dev->phy.roc_grant = true;
+	wake_up(&dev->phy.roc_wait);
+	duration = le32_to_cpu(grant->max_interval);
+	mod_timer(&dev->phy.roc_timer,
+		  round_jiffies_up(jiffies + msecs_to_jiffies(duration)));
+}
+
 static void
 mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
@@ -295,6 +318,7 @@ mt7921_mcu_uni_rx_unsolicited_event(struct mt7921_dev *dev,
 
 	switch (rxd->eid) {
 	case MCU_UNI_EVENT_ROC:
+		mt7921_mcu_uni_roc_event(dev, skb);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index d9d78f6b088e..4f0147e40bc3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -32,6 +32,9 @@
 #define MT7921_MCU_INIT_RETRY_COUNT	10
 #define MT7921_WFSYS_INIT_RETRY_COUNT	2
 
+#define MT7921_FW_TAG_FEATURE		4
+#define MT7921_FW_CAP_CNM		BIT(7)
+
 #define MT7921_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
 #define MT7921_ROM_PATCH		"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
 
@@ -67,6 +70,41 @@ enum mt7921_roc_req {
 	MT7921_ROC_REQ_NUM
 };
 
+enum {
+	UNI_EVENT_ROC_GRANT = 0,
+	UNI_EVENT_ROC_TAG_NUM
+};
+
+struct mt7921_realease_info {
+	__le16 len;
+	u8 pad_len;
+	u8 tag;
+} __packed;
+
+struct mt7921_fw_features {
+	u8 segment;
+	u8 data;
+	u8 rsv[14];
+} __packed;
+
+struct mt7921_roc_grant_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 bss_idx;
+	u8 tokenid;
+	u8 status;
+	u8 primarychannel;
+	u8 rfsco;
+	u8 rfband;
+	u8 channelwidth;
+	u8 centerfreqseg1;
+	u8 centerfreqseg2;
+	u8 reqtype;
+	u8 dbdcband;
+	u8 rsv[1];
+	__le32 max_interval;
+} __packed;
+
 enum mt7921_sdio_pkt_type {
 	MT7921_SDIO_TXD,
 	MT7921_SDIO_DATA,
@@ -214,6 +252,12 @@ struct mt7921_phy {
 #endif
 
 	struct mt7921_clc *clc[MT7921_CLC_MAX_NUM];
+
+	struct work_struct roc_work;
+	struct timer_list roc_timer;
+	wait_queue_head_t roc_wait;
+	u8 roc_token_id;
+	bool roc_grant;
 };
 
 #define mt7921_init_reset(dev)		((dev)->hif_ops->init_reset(dev))
@@ -250,6 +294,7 @@ struct mt7921_dev {
 	struct work_struct init_work;
 
 	u8 fw_debug;
+	u8 fw_features;
 
 	struct mt76_connac_pm pm;
 	struct mt76_connac_coredump coredump;
@@ -439,6 +484,8 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 void mt7921_scan_work(struct work_struct *work);
+void mt7921_roc_work(struct work_struct *work);
+void mt7921_roc_timer(struct timer_list *timer);
 int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
@@ -527,4 +574,5 @@ int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
 		       enum mt7921_roc_req type, u8 token_id);
 int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
 			 u8 token_id);
+u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index b38d119b2ea9..32ad26ef3a68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -13,10 +13,14 @@
 #include "../trace.h"
 
 static const struct pci_device_id mt7921_pci_device_table[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7961) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7922) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0608) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7961),
+		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7922),
+		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0608),
+		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
+		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
 	{ },
 };
 
@@ -253,9 +257,11 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.fw_own = mt7921e_mcu_fw_pmctrl,
 	};
 
+	struct ieee80211_ops *ops;
 	struct mt76_bus_ops *bus_ops;
 	struct mt7921_dev *dev;
 	struct mt76_dev *mdev;
+	u8 features;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -279,8 +285,21 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (mt7921_disable_aspm)
 		mt76_pci_disable_aspm(pdev);
 
-	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7921_ops,
-				 &drv_ops);
+	features = mt7921_check_offload_capability(&pdev->dev, (const char *)
+						   id->driver_data);
+	ops = devm_kmemdup(&pdev->dev, &mt7921_ops, sizeof(mt7921_ops),
+			   GFP_KERNEL);
+	if (!ops) {
+		ret = -ENOMEM;
+		goto err_free_pci_vec;
+	}
+
+	if (!(features & MT7921_FW_CAP_CNM)) {
+		ops->remain_on_channel = NULL;
+		ops->cancel_remain_on_channel = NULL;
+	}
+
+	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev) {
 		ret = -ENOMEM;
 		goto err_free_pci_vec;
@@ -289,8 +308,8 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, mdev);
 
 	dev = container_of(mdev, struct mt7921_dev, mt76);
+	dev->fw_features = features;
 	dev->hif_ops = &mt7921_pcie_ops;
-
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
 	tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 377ca5fa3f6e..e07a8fb87421 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -17,7 +17,8 @@
 #include "mcu.h"
 
 static const struct sdio_device_id mt7921s_table[] = {
-	{ SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7901) },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7901),
+		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
 	{ }	/* Terminating entry */
 };
 
@@ -122,18 +123,32 @@ static int mt7921s_probe(struct sdio_func *func,
 		.fw_own = mt7921s_mcu_fw_pmctrl,
 	};
 
+	struct ieee80211_ops *ops;
 	struct mt7921_dev *dev;
 	struct mt76_dev *mdev;
+	u8 features;
 	int ret;
 
-	mdev = mt76_alloc_device(&func->dev, sizeof(*dev), &mt7921_ops,
-				 &drv_ops);
+	features = mt7921_check_offload_capability(&func->dev, (const char *)
+						   id->driver_data);
+
+	ops = devm_kmemdup(&func->dev, &mt7921_ops, sizeof(mt7921_ops),
+			   GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	if (!(features & MT7921_FW_CAP_CNM)) {
+		ops->remain_on_channel = NULL;
+		ops->cancel_remain_on_channel = NULL;
+	}
+
+	mdev = mt76_alloc_device(&func->dev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev)
 		return -ENOMEM;
 
 	dev = container_of(mdev, struct mt7921_dev, mt76);
+	dev->fw_features = features;
 	dev->hif_ops = &mt7921_sdio_ops;
-
 	sdio_set_drvdata(func, dev);
 
 	ret = mt76s_init(mdev, func, &mt7921s_ops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 89249f0b6aba..3e4ddc6715f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -13,7 +13,8 @@
 #include "mac.h"
 
 static const struct usb_device_id mt7921u_device_table[] = {
-	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7961, 0xff, 0xff, 0xff) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7961, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
 	{ },
 };
 
@@ -204,13 +205,22 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	struct ieee80211_hw *hw;
 	struct mt7921_dev *dev;
 	struct mt76_dev *mdev;
+	const void *ops_src;
+	u8 features;
 	int ret;
 
+	features = mt7921_check_offload_capability(&usb_intf->dev, (const char *)
+						   id->driver_info);
 	ops = devm_kmemdup(&usb_intf->dev, &mt7921_ops, sizeof(mt7921_ops),
 			   GFP_KERNEL);
 	if (!ops)
 		return -ENOMEM;
 
+	if (!(features & MT7921_FW_CAP_CNM)) {
+		ops->remain_on_channel = NULL;
+		ops->cancel_remain_on_channel = NULL;
+	}
+
 	ops->stop = mt7921u_stop;
 
 	mdev = mt76_alloc_device(&usb_intf->dev, sizeof(*dev), ops, &drv_ops);
@@ -218,6 +228,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 		return -ENOMEM;
 
 	dev = container_of(mdev, struct mt7921_dev, mt76);
+	dev->fw_features = features;
 	dev->hif_ops = &hif_ops;
 
 	udev = usb_get_dev(udev);
-- 
2.25.1

