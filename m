Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912977409DC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjF1Hwh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:37 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38820 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230215AbjF1Hw3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:29 -0400
X-UUID: 6aae0ac8158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3d6Y5h3deoeRQVXRToJsOR7S+TC03V3+VyJuAMdL1Cs=;
        b=kTAGSCK7rXpaKXM5TZiPYP/55FsYTRszg+uujTCYpepB+hX0b5UUh3L57iu22Vdy73nBr5THyWpbpAtHbe+PtMgh1gObfIuCTAxTvpRGuDyYwtzpkJgL9OLqlCoOgxNSWqPHtY5V/O1Kf26EdFq7uciBHal3EEtvAXngU9sQTmc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:98f99b1e-0339-402e-9e19-328689c034f1,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:01c9525,CLOUDID:90d05eda-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6aae0ac8158211ee9cb5633481061a41-20230628
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 583780874; Wed, 28 Jun 2023 15:07:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:16 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 15/16] wifi: mt76: mt7921: move init shared code in mt792x-lib module
Date:   Wed, 28 Jun 2023 15:06:01 +0800
Message-ID: <0506a2ae3a52ac23d092a5d0369c935672d4fe95.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687919628.git.deren.wu@mediatek.com>
References: <cover.1687919628.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Reduce duplicated code moving init shared code in mt792x-lib module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 254 +-----------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   5 -
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  22 ++
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 227 ++++++++++++++++
 .../net/wireless/mediatek/mt76/mt792x_mac.c   |  29 ++
 8 files changed, 288 insertions(+), 261 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 449ce34a6dcf..0a6f8f42b2e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -10,50 +10,6 @@
 #include "../mt76_connac2_mac.h"
 #include "mcu.h"
 
-static const struct ieee80211_iface_limit if_limits[] = {
-	{
-		.max = MT792x_MAX_INTERFACES,
-		.types = BIT(NL80211_IFTYPE_STATION)
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_AP)
-	}
-};
-
-static const struct ieee80211_iface_combination if_comb[] = {
-	{
-		.limits = if_limits,
-		.n_limits = ARRAY_SIZE(if_limits),
-		.max_interfaces = MT792x_MAX_INTERFACES,
-		.num_different_channels = 1,
-		.beacon_int_infra_match = true,
-	},
-};
-
-static const struct ieee80211_iface_limit if_limits_chanctx[] = {
-	{
-		.max = 2,
-		.types = BIT(NL80211_IFTYPE_STATION) |
-			 BIT(NL80211_IFTYPE_P2P_CLIENT)
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_AP) |
-			 BIT(NL80211_IFTYPE_P2P_GO)
-	}
-};
-
-static const struct ieee80211_iface_combination if_comb_chanctx[] = {
-	{
-		.limits = if_limits_chanctx,
-		.n_limits = ARRAY_SIZE(if_limits_chanctx),
-		.max_interfaces = 2,
-		.num_different_channels = 2,
-		.beacon_int_infra_match = false,
-	}
-};
-
 static ssize_t mt7921_thermal_temp_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -123,192 +79,6 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 	mt792x_mutex_release(dev);
 }
 
-static int
-mt7921_init_wiphy(struct ieee80211_hw *hw)
-{
-	struct mt792x_phy *phy = mt792x_hw_phy(hw);
-	struct mt792x_dev *dev = phy->dev;
-	struct wiphy *wiphy = hw->wiphy;
-
-	hw->queues = 4;
-	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
-	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
-	hw->netdev_features = NETIF_F_RXCSUM;
-
-	hw->radiotap_timestamp.units_pos =
-		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
-
-	phy->slottime = 9;
-
-	hw->sta_data_size = sizeof(struct mt792x_sta);
-	hw->vif_data_size = sizeof(struct mt792x_vif);
-
-	if (dev->fw_features & MT7921_FW_CAP_CNM) {
-		wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-		wiphy->iface_combinations = if_comb_chanctx;
-		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb_chanctx);
-	} else {
-		wiphy->flags &= ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-		wiphy->iface_combinations = if_comb;
-		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
-	}
-	wiphy->flags &= ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
-			  WIPHY_FLAG_4ADDR_STATION);
-	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
-				 BIT(NL80211_IFTYPE_AP) |
-				 BIT(NL80211_IFTYPE_P2P_CLIENT) |
-				 BIT(NL80211_IFTYPE_P2P_GO);
-	wiphy->max_remain_on_channel_duration = 5000;
-	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
-	wiphy->max_scan_ssids = 4;
-	wiphy->max_sched_scan_plan_interval =
-		MT76_CONNAC_MAX_TIME_SCHED_SCAN_INTERVAL;
-	wiphy->max_sched_scan_ie_len = IEEE80211_MAX_DATA_LEN;
-	wiphy->max_sched_scan_ssids = MT76_CONNAC_MAX_SCHED_SCAN_SSID;
-	wiphy->max_match_sets = MT76_CONNAC_MAX_SCAN_MATCH;
-	wiphy->max_sched_scan_reqs = 1;
-	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH |
-			WIPHY_FLAG_SPLIT_SCAN_6GHZ;
-	wiphy->reg_notifier = mt7921_regd_notifier;
-
-	wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
-			   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
-	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
-	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
-	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HT);
-	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_VHT);
-	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
-	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
-	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
-
-	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
-	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
-	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
-	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
-	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
-	ieee80211_hw_set(hw, SUPPORTS_PS);
-	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
-	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
-	ieee80211_hw_set(hw, CONNECTION_MONITOR);
-
-	if (dev->pm.enable)
-		ieee80211_hw_set(hw, CONNECTION_MONITOR);
-
-	hw->max_tx_fragments = 4;
-
-	return 0;
-}
-
-static void
-mt7921_mac_init_band(struct mt792x_dev *dev, u8 band)
-{
-	u32 mask, set;
-
-	mt76_rmw_field(dev, MT_TMAC_CTCR0(band),
-		       MT_TMAC_CTCR0_INS_DDLMT_REFTIME, 0x3f);
-	mt76_set(dev, MT_TMAC_CTCR0(band),
-		 MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN |
-		 MT_TMAC_CTCR0_INS_DDLMT_EN);
-
-	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
-	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
-
-	/* enable MIB tx-rx time reporting */
-	mt76_set(dev, MT_MIB_SCR1(band), MT_MIB_TXDUR_EN);
-	mt76_set(dev, MT_MIB_SCR1(band), MT_MIB_RXDUR_EN);
-
-	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 1536);
-	/* disable rx rate report by default due to hw issues */
-	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
-
-	/* filter out non-resp frames and get instantaneous signal reporting */
-	mask = MT_WTBLOFF_TOP_RSCR_RCPI_MODE | MT_WTBLOFF_TOP_RSCR_RCPI_PARAM;
-	set = FIELD_PREP(MT_WTBLOFF_TOP_RSCR_RCPI_MODE, 0) |
-	      FIELD_PREP(MT_WTBLOFF_TOP_RSCR_RCPI_PARAM, 0x3);
-	mt76_rmw(dev, MT_WTBLOFF_TOP_RSCR(band), mask, set);
-}
-
-static u8
-mt7921_get_offload_capability(struct device *dev, const char *fw_wm)
-{
-	const struct mt76_connac2_fw_trailer *hdr;
-	struct mt7921_realease_info *rel_info;
-	const struct firmware *fw;
-	int ret, i, offset = 0;
-	const u8 *data, *end;
-	u8 offload_caps = 0;
-
-	ret = request_firmware(&fw, fw_wm, dev);
-	if (ret)
-		return ret;
-
-	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
-		dev_err(dev, "Invalid firmware\n");
-		goto out;
-	}
-
-	data = fw->data;
-	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
-
-	for (i = 0; i < hdr->n_region; i++) {
-		const struct mt76_connac2_fw_region *region;
-
-		region = (const void *)((const u8 *)hdr -
-					(hdr->n_region - i) * sizeof(*region));
-		offset += le32_to_cpu(region->len);
-	}
-
-	data += offset + 16;
-	rel_info = (struct mt7921_realease_info *)data;
-	data += sizeof(*rel_info);
-	end = data + le16_to_cpu(rel_info->len);
-
-	while (data < end) {
-		rel_info = (struct mt7921_realease_info *)data;
-		data += sizeof(*rel_info);
-
-		if (rel_info->tag == MT7921_FW_TAG_FEATURE) {
-			struct mt7921_fw_features *features;
-
-			features = (struct mt7921_fw_features *)data;
-			offload_caps = features->data;
-			break;
-		}
-
-		data += le16_to_cpu(rel_info->len) + rel_info->pad_len;
-	}
-
-out:
-	release_firmware(fw);
-
-	return offload_caps;
-}
-
-struct ieee80211_ops *
-mt7921_get_mac80211_ops(struct device *dev, void *drv_data, u8 *fw_features)
-{
-	struct ieee80211_ops *ops;
-
-	ops = devm_kmemdup(dev, &mt7921_ops, sizeof(mt7921_ops), GFP_KERNEL);
-	if (!ops)
-		return NULL;
-
-	*fw_features = mt7921_get_offload_capability(dev, drv_data);
-	if (!(*fw_features & MT7921_FW_CAP_CNM)) {
-		ops->remain_on_channel = NULL;
-		ops->cancel_remain_on_channel = NULL;
-		ops->add_chanctx = NULL;
-		ops->remove_chanctx = NULL;
-		ops->change_chanctx = NULL;
-		ops->assign_vif_chanctx = NULL;
-		ops->unassign_vif_chanctx = NULL;
-		ops->mgd_prepare_tx = NULL;
-		ops->mgd_complete_tx = NULL;
-	}
-	return ops;
-}
-EXPORT_SYMBOL_GPL(mt7921_get_mac80211_ops);
-
 int mt7921_mac_init(struct mt792x_dev *dev)
 {
 	int i;
@@ -323,7 +93,7 @@ int mt7921_mac_init(struct mt792x_dev *dev)
 		mt7921_mac_wtbl_update(dev, i,
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 	for (i = 0; i < 2; i++)
-		mt7921_mac_init_band(dev, i);
+		mt792x_mac_init_band(dev, i);
 
 	return mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
 }
@@ -374,23 +144,6 @@ static int mt7921_init_hardware(struct mt792x_dev *dev)
 	return 0;
 }
 
-static int mt7921_init_wcid(struct mt792x_dev *dev)
-{
-	int idx;
-
-	/* Beacon and mgmt frames should occupy wcid 0 */
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
-	if (idx)
-		return -ENOSPC;
-
-	dev->mt76.global_wcid.idx = idx;
-	dev->mt76.global_wcid.hw_key_idx = -1;
-	dev->mt76.global_wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
-
-	return 0;
-}
-
 static void mt7921_init_work(struct work_struct *work)
 {
 	struct mt792x_dev *dev = container_of(work, struct mt792x_dev,
@@ -479,14 +232,15 @@ int mt7921_register_device(struct mt792x_dev *dev)
 
 	mt7921_init_acpi_sar(dev);
 
-	ret = mt7921_init_wcid(dev);
+	ret = mt792x_init_wcid(dev);
 	if (ret)
 		return ret;
 
-	ret = mt7921_init_wiphy(hw);
+	ret = mt792x_init_wiphy(hw);
 	if (ret)
 		return ret;
 
+	hw->wiphy->reg_notifier = mt7921_regd_notifier;
 	dev->mphy.sband_2g.sband.ht_cap.cap |=
 			IEEE80211_HT_CAP_LDPC_CODING |
 			IEEE80211_HT_CAP_MAX_AMSDU;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index b8699c942b34..fc952c30ca07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -22,9 +22,6 @@
 #define MT7921_MCU_INIT_RETRY_COUNT	10
 #define MT7921_WFSYS_INIT_RETRY_COUNT	2
 
-#define MT7921_FW_TAG_FEATURE		4
-#define MT7921_FW_CAP_CNM		BIT(7)
-
 #define MT7921_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
 #define MT7921_ROM_PATCH		"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
 
@@ -400,6 +397,4 @@ int mt7921_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 		       enum mt7921_roc_req type, u8 token_id);
 int mt7921_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			 u8 token_id);
-struct ieee80211_ops *mt7921_get_mac80211_ops(struct device *dev,
-					      void *drv_data, u8 *fw_features);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 4d929cf8d854..58f6f5a76498 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -288,8 +288,8 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (mt7921_disable_aspm)
 		mt76_pci_disable_aspm(pdev);
 
-	ops = mt7921_get_mac80211_ops(&pdev->dev, (void *)id->driver_data,
-				      &features);
+	ops = mt792x_get_mac80211_ops(&pdev->dev, &mt7921_ops,
+				      (void *)id->driver_data, &features);
 	if (!ops) {
 		ret = -ENOMEM;
 		goto err_free_pci_vec;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index f0117ac34594..84b388656941 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -127,8 +127,8 @@ static int mt7921s_probe(struct sdio_func *func,
 	u8 features;
 	int ret;
 
-	ops = mt7921_get_mac80211_ops(&func->dev, (void *)id->driver_data,
-				      &features);
+	ops = mt792x_get_mac80211_ops(&func->dev, &mt7921_ops,
+				      (void *)id->driver_data, &features);
 	if (!ops)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index c7368cf676a9..0a31e7076324 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -212,8 +212,8 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	u8 features;
 	int ret;
 
-	ops = mt7921_get_mac80211_ops(&usb_intf->dev, (void *)id->driver_info,
-				      &features);
+	ops = mt792x_get_mac80211_ops(&usb_intf->dev, &mt7921_ops,
+				      (void *)id->driver_info, &features);
 	if (!ops)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 1fd53a29fef1..f13779d19983 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -18,6 +18,9 @@
 #define MT792x_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
 #define MT792x_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
 
+#define MT792x_FW_TAG_FEATURE	4
+#define MT792x_FW_CAP_CNM	BIT(7)
+
 /* NOTE: used to map mt76_rates. idx may change if firmware expands table */
 #define MT792x_BASIC_RATES_TBL	11
 
@@ -26,6 +29,18 @@
 struct mt792x_vif;
 struct mt792x_sta;
 
+struct mt792x_realease_info {
+	__le16 len;
+	u8 pad_len;
+	u8 tag;
+} __packed;
+
+struct mt792x_fw_features {
+	u8 segment;
+	u8 data;
+	u8 rsv[14];
+} __packed;
+
 enum {
 	MT792x_CLC_POWER,
 	MT792x_CLC_CHAN,
@@ -183,6 +198,7 @@ static inline bool mt792x_dma_need_reinit(struct mt792x_dev *dev)
 void mt792x_reset(struct mt76_dev *mdev);
 void mt792x_update_channel(struct mt76_phy *mphy);
 void mt792x_mac_reset_counters(struct mt792x_phy *phy);
+void mt792x_mac_init_band(struct mt792x_dev *dev, u8 band);
 void mt792x_mac_assoc_rssi(struct mt792x_dev *dev, struct sk_buff *skb);
 struct mt76_wcid *mt792x_rx_get_wcid(struct mt792x_dev *dev, u16 idx,
 				     bool unicast);
@@ -235,5 +251,11 @@ int mt792x_queues_read(struct seq_file *s, void *data);
 int mt792x_pm_stats(struct seq_file *s, void *data);
 int mt792x_pm_idle_timeout_set(void *data, u64 val);
 int mt792x_pm_idle_timeout_get(void *data, u64 *val);
+int mt792x_init_wiphy(struct ieee80211_hw *hw);
+struct ieee80211_ops *
+mt792x_get_mac80211_ops(struct device *dev,
+			const struct ieee80211_ops *mac80211_ops,
+			void *drv_data, u8 *fw_features);
+int mt792x_init_wcid(struct mt792x_dev *dev);
 
 #endif /* __MT7925_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index b176ce53996e..87d2a614e590 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -2,10 +2,55 @@
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/module.h>
+#include <linux/firmware.h>
 
 #include "mt792x.h"
 #include "dma.h"
 
+static const struct ieee80211_iface_limit if_limits[] = {
+	{
+		.max = MT792x_MAX_INTERFACES,
+		.types = BIT(NL80211_IFTYPE_STATION)
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_AP)
+	}
+};
+
+static const struct ieee80211_iface_combination if_comb[] = {
+	{
+		.limits = if_limits,
+		.n_limits = ARRAY_SIZE(if_limits),
+		.max_interfaces = MT792x_MAX_INTERFACES,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = true,
+	},
+};
+
+static const struct ieee80211_iface_limit if_limits_chanctx[] = {
+	{
+		.max = 2,
+		.types = BIT(NL80211_IFTYPE_STATION) |
+			 BIT(NL80211_IFTYPE_P2P_CLIENT)
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_AP) |
+			 BIT(NL80211_IFTYPE_P2P_GO)
+	}
+};
+
+static const struct ieee80211_iface_combination if_comb_chanctx[] = {
+	{
+		.limits = if_limits_chanctx,
+		.n_limits = ARRAY_SIZE(if_limits_chanctx),
+		.max_interfaces = 2,
+		.num_different_channels = 2,
+		.beacon_int_infra_match = false,
+	}
+};
+
 void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 	       struct sk_buff *skb)
 {
@@ -561,5 +606,187 @@ int mt792x_wfsys_reset(struct mt792x_dev *dev, u32 addr)
 }
 EXPORT_SYMBOL_GPL(mt792x_wfsys_reset);
 
+int mt792x_init_wiphy(struct ieee80211_hw *hw)
+{
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt792x_dev *dev = phy->dev;
+	struct wiphy *wiphy = hw->wiphy;
+
+	hw->queues = 4;
+	if (dev->has_eht) {
+		hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_EHT;
+		hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_EHT;
+	} else {
+		hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+		hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	}
+	hw->netdev_features = NETIF_F_RXCSUM;
+
+	hw->radiotap_timestamp.units_pos =
+		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
+
+	phy->slottime = 9;
+
+	hw->sta_data_size = sizeof(struct mt792x_sta);
+	hw->vif_data_size = sizeof(struct mt792x_vif);
+
+	if (dev->fw_features & MT792x_FW_CAP_CNM) {
+		wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
+		wiphy->iface_combinations = if_comb_chanctx;
+		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb_chanctx);
+	} else {
+		wiphy->flags &= ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
+		wiphy->iface_combinations = if_comb;
+		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	}
+	wiphy->flags &= ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
+			  WIPHY_FLAG_4ADDR_STATION);
+	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				 BIT(NL80211_IFTYPE_AP) |
+				 BIT(NL80211_IFTYPE_P2P_CLIENT) |
+				 BIT(NL80211_IFTYPE_P2P_GO);
+	wiphy->max_remain_on_channel_duration = 5000;
+	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
+	wiphy->max_scan_ssids = 4;
+	wiphy->max_sched_scan_plan_interval =
+		MT76_CONNAC_MAX_TIME_SCHED_SCAN_INTERVAL;
+	wiphy->max_sched_scan_ie_len = IEEE80211_MAX_DATA_LEN;
+	wiphy->max_sched_scan_ssids = MT76_CONNAC_MAX_SCHED_SCAN_SSID;
+	wiphy->max_match_sets = MT76_CONNAC_MAX_SCAN_MATCH;
+	wiphy->max_sched_scan_reqs = 1;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH |
+			WIPHY_FLAG_SPLIT_SCAN_6GHZ;
+
+	wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
+			   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_VHT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
+
+	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
+	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
+	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	ieee80211_hw_set(hw, SUPPORTS_PS);
+	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
+	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
+	ieee80211_hw_set(hw, CONNECTION_MONITOR);
+
+	if (dev->pm.enable)
+		ieee80211_hw_set(hw, CONNECTION_MONITOR);
+
+	hw->max_tx_fragments = 4;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_init_wiphy);
+
+static u8
+mt792x_get_offload_capability(struct device *dev, const char *fw_wm)
+{
+	const struct mt76_connac2_fw_trailer *hdr;
+	struct mt792x_realease_info *rel_info;
+	const struct firmware *fw;
+	int ret, i, offset = 0;
+	const u8 *data, *end;
+	u8 offload_caps = 0;
+
+	ret = request_firmware(&fw, fw_wm, dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev, "Invalid firmware\n");
+		goto out;
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
+	rel_info = (struct mt792x_realease_info *)data;
+	data += sizeof(*rel_info);
+	end = data + le16_to_cpu(rel_info->len);
+
+	while (data < end) {
+		rel_info = (struct mt792x_realease_info *)data;
+		data += sizeof(*rel_info);
+
+		if (rel_info->tag == MT792x_FW_TAG_FEATURE) {
+			struct mt792x_fw_features *features;
+
+			features = (struct mt792x_fw_features *)data;
+			offload_caps = features->data;
+			break;
+		}
+
+		data += le16_to_cpu(rel_info->len) + rel_info->pad_len;
+	}
+
+out:
+	release_firmware(fw);
+
+	return offload_caps;
+}
+
+struct ieee80211_ops *
+mt792x_get_mac80211_ops(struct device *dev,
+			const struct ieee80211_ops *mac80211_ops,
+			void *drv_data, u8 *fw_features)
+{
+	struct ieee80211_ops *ops;
+
+	ops = devm_kmemdup(dev, mac80211_ops, sizeof(struct ieee80211_ops),
+			   GFP_KERNEL);
+	if (!ops)
+		return NULL;
+
+	*fw_features = mt792x_get_offload_capability(dev, drv_data);
+	if (!(*fw_features & MT792x_FW_CAP_CNM)) {
+		ops->remain_on_channel = NULL;
+		ops->cancel_remain_on_channel = NULL;
+		ops->add_chanctx = NULL;
+		ops->remove_chanctx = NULL;
+		ops->change_chanctx = NULL;
+		ops->assign_vif_chanctx = NULL;
+		ops->unassign_vif_chanctx = NULL;
+		ops->mgd_prepare_tx = NULL;
+		ops->mgd_complete_tx = NULL;
+	}
+	return ops;
+}
+EXPORT_SYMBOL_GPL(mt792x_get_mac80211_ops);
+
+int mt792x_init_wcid(struct mt792x_dev *dev)
+{
+	int idx;
+
+	/* Beacon and mgmt frames should occupy wcid 0 */
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
+	if (idx)
+		return -ENOSPC;
+
+	dev->mt76.global_wcid.idx = idx;
+	dev->mt76.global_wcid.hw_key_idx = -1;
+	dev->mt76.global_wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_init_wcid);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 130b4352cf92..9603c4eedb2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -282,3 +282,32 @@ void mt792x_reset(struct mt76_dev *mdev)
 	queue_work(dev->mt76.wq, &dev->reset_work);
 }
 EXPORT_SYMBOL_GPL(mt792x_reset);
+
+void mt792x_mac_init_band(struct mt792x_dev *dev, u8 band)
+{
+	u32 mask, set;
+
+	mt76_rmw_field(dev, MT_TMAC_CTCR0(band),
+		       MT_TMAC_CTCR0_INS_DDLMT_REFTIME, 0x3f);
+	mt76_set(dev, MT_TMAC_CTCR0(band),
+		 MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN |
+		 MT_TMAC_CTCR0_INS_DDLMT_EN);
+
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
+
+	/* enable MIB tx-rx time reporting */
+	mt76_set(dev, MT_MIB_SCR1(band), MT_MIB_TXDUR_EN);
+	mt76_set(dev, MT_MIB_SCR1(band), MT_MIB_RXDUR_EN);
+
+	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 1536);
+	/* disable rx rate report by default due to hw issues */
+	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
+
+	/* filter out non-resp frames and get instantaneous signal reporting */
+	mask = MT_WTBLOFF_TOP_RSCR_RCPI_MODE | MT_WTBLOFF_TOP_RSCR_RCPI_PARAM;
+	set = FIELD_PREP(MT_WTBLOFF_TOP_RSCR_RCPI_MODE, 0) |
+	      FIELD_PREP(MT_WTBLOFF_TOP_RSCR_RCPI_PARAM, 0x3);
+	mt76_rmw(dev, MT_WTBLOFF_TOP_RSCR(band), mask, set);
+}
+EXPORT_SYMBOL_GPL(mt792x_mac_init_band);
-- 
2.18.0

