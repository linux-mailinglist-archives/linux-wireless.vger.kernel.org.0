Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6B633784
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 09:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiKVIwQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 03:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiKVIwK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 03:52:10 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F932F012
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 00:52:05 -0800 (PST)
X-UUID: 55b9a392e6684438851bd8918e9b299d-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JJ4E6hf8jHF/odwar398hnIKZOpKaMFGKvTAigJudKI=;
        b=RHuG1+DjeAAJCWZoyAzDijdGaGfAkZaAitZk7Ay5wMTTdqcAMK+ElA8Esq+ZaVFh2o8PKtmoBTUE8Q+77miAfzhALRs14w8OJI7/t+yDvZoSk/9QYgpBD6SIyDPQLMuiwTlkEuOOfppKG9sw3tYTUfbuShavfc2H91iV+w2som8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:8deeedfa-354f-493f-837b-779c77451d67,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:d12e911,CLOUDID:f25ff7f8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:1
X-UUID: 55b9a392e6684438851bd8918e9b299d-20221122
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 251746100; Tue, 22 Nov 2022 16:51:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 16:51:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 22 Nov 2022 16:51:58 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 5/9] wifi: mt76: mt7996: add MAC support
Date:   Tue, 22 Nov 2022 16:45:50 +0800
Message-ID: <20221122084554.9494-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221122084554.9494-1-shayne.chen@mediatek.com>
References: <20221122084554.9494-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Split the big patch into smaller intermediate patches by functionality
for easier review. Refer to the cover letter for more info.)

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  816 ++++++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 2468 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mac.h   |  398 +++
 3 files changed, 3682 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mac.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
new file mode 100644
index 000000000000..cd1657e3585d
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -0,0 +1,816 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/thermal.h>
+#include "mt7996.h"
+#include "mac.h"
+#include "mcu.h"
+#include "eeprom.h"
+
+static const struct ieee80211_iface_limit if_limits[] = {
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_ADHOC)
+	}, {
+		.max = 16,
+		.types = BIT(NL80211_IFTYPE_AP)
+#ifdef CONFIG_MAC80211_MESH
+			 | BIT(NL80211_IFTYPE_MESH_POINT)
+#endif
+	}, {
+		.max = MT7996_MAX_INTERFACES,
+		.types = BIT(NL80211_IFTYPE_STATION)
+	}
+};
+
+static const struct ieee80211_iface_combination if_comb[] = {
+	{
+		.limits = if_limits,
+		.n_limits = ARRAY_SIZE(if_limits),
+		.max_interfaces = MT7996_MAX_INTERFACES,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = true,
+		.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+				       BIT(NL80211_CHAN_WIDTH_20) |
+				       BIT(NL80211_CHAN_WIDTH_40) |
+				       BIT(NL80211_CHAN_WIDTH_80) |
+				       BIT(NL80211_CHAN_WIDTH_160) |
+				       BIT(NL80211_CHAN_WIDTH_80P80),
+	}
+};
+
+static void mt7996_led_set_config(struct led_classdev *led_cdev,
+				  u8 delay_on, u8 delay_off)
+{
+	struct mt7996_dev *dev;
+	struct mt76_dev *mt76;
+	u32 val;
+
+	mt76 = container_of(led_cdev, struct mt76_dev, led_cdev);
+	dev = container_of(mt76, struct mt7996_dev, mt76);
+
+	/* select TX blink mode, 2: only data frames */
+	mt76_rmw_field(dev, MT_TMAC_TCR0(0), MT_TMAC_TCR0_TX_BLINK, 2);
+
+	/* enable LED */
+	mt76_wr(dev, MT_LED_EN(0), 1);
+
+	/* set LED Tx blink on/off time */
+	val = FIELD_PREP(MT_LED_TX_BLINK_ON_MASK, delay_on) |
+	      FIELD_PREP(MT_LED_TX_BLINK_OFF_MASK, delay_off);
+	mt76_wr(dev, MT_LED_TX_BLINK(0), val);
+
+	/* control LED */
+	val = MT_LED_CTRL_BLINK_MODE | MT_LED_CTRL_KICK;
+	if (dev->mt76.led_al)
+		val |= MT_LED_CTRL_POLARITY;
+
+	mt76_wr(dev, MT_LED_CTRL(0), val);
+	mt76_clear(dev, MT_LED_CTRL(0), MT_LED_CTRL_KICK);
+}
+
+static int mt7996_led_set_blink(struct led_classdev *led_cdev,
+				unsigned long *delay_on,
+				unsigned long *delay_off)
+{
+	u16 delta_on = 0, delta_off = 0;
+
+#define HW_TICK		10
+#define TO_HW_TICK(_t)	(((_t) > HW_TICK) ? ((_t) / HW_TICK) : HW_TICK)
+
+	if (*delay_on)
+		delta_on = TO_HW_TICK(*delay_on);
+	if (*delay_off)
+		delta_off = TO_HW_TICK(*delay_off);
+
+	mt7996_led_set_config(led_cdev, delta_on, delta_off);
+
+	return 0;
+}
+
+static void mt7996_led_set_brightness(struct led_classdev *led_cdev,
+				      enum led_brightness brightness)
+{
+	if (!brightness)
+		mt7996_led_set_config(led_cdev, 0, 0xff);
+	else
+		mt7996_led_set_config(led_cdev, 0xff, 0);
+}
+
+static void
+mt7996_init_txpower(struct mt7996_dev *dev,
+		    struct ieee80211_supported_band *sband)
+{
+	int i, nss = hweight8(dev->mphy.antenna_mask);
+	int nss_delta = mt76_tx_power_nss_delta(nss);
+	int pwr_delta = mt7996_eeprom_get_power_delta(dev, sband->band);
+	struct mt76_power_limits limits;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		struct ieee80211_channel *chan = &sband->channels[i];
+		int target_power = mt7996_eeprom_get_target_power(dev, chan);
+
+		target_power += pwr_delta;
+		target_power = mt76_get_rate_power_limits(&dev->mphy, chan,
+							  &limits,
+							  target_power);
+		target_power += nss_delta;
+		target_power = DIV_ROUND_UP(target_power, 2);
+		chan->max_power = min_t(int, chan->max_reg_power,
+					target_power);
+		chan->orig_mpwr = target_power;
+	}
+}
+
+static void
+mt7996_regd_notifier(struct wiphy *wiphy,
+		     struct regulatory_request *request)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+
+	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
+	dev->mt76.region = request->dfs_region;
+
+	if (dev->mt76.region == NL80211_DFS_UNSET)
+		mt7996_mcu_rdd_background_enable(phy, NULL);
+
+	mt7996_init_txpower(dev, &phy->mt76->sband_2g.sband);
+	mt7996_init_txpower(dev, &phy->mt76->sband_5g.sband);
+	mt7996_init_txpower(dev, &phy->mt76->sband_6g.sband);
+
+	phy->mt76->dfs_state = MT_DFS_STATE_UNKNOWN;
+	mt7996_dfs_init_radar_detector(phy);
+}
+
+static void
+mt7996_init_wiphy(struct ieee80211_hw *hw)
+{
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt76_dev *mdev = &phy->dev->mt76;
+	struct wiphy *wiphy = hw->wiphy;
+
+	hw->queues = 4;
+	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	hw->netdev_features = NETIF_F_RXCSUM;
+
+	hw->radiotap_timestamp.units_pos =
+		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
+
+	phy->slottime = 9;
+
+	hw->sta_data_size = sizeof(struct mt7996_sta);
+	hw->vif_data_size = sizeof(struct mt7996_vif);
+
+	wiphy->iface_combinations = if_comb;
+	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	wiphy->reg_notifier = mt7996_regd_notifier;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BSS_COLOR);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_VHT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_DISCOVERY);
+
+	if (!mdev->dev->of_node ||
+	    !of_property_read_bool(mdev->dev->of_node,
+				   "mediatek,disable-radar-background"))
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_RADAR_BACKGROUND);
+
+	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
+	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+
+	hw->max_tx_fragments = 4;
+
+	if (phy->mt76->cap.has_2ghz)
+		phy->mt76->sband_2g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+
+	if (phy->mt76->cap.has_5ghz) {
+		phy->mt76->sband_5g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+
+		phy->mt76->sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
+			IEEE80211_VHT_CAP_SHORT_GI_160 |
+			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ;
+	}
+
+	mt76_set_stream_caps(phy->mt76, true);
+	mt7996_set_stream_vht_txbf_caps(phy);
+	mt7996_set_stream_he_caps(phy);
+
+	wiphy->available_antennas_rx = phy->mt76->antenna_mask;
+	wiphy->available_antennas_tx = phy->mt76->antenna_mask;
+}
+
+static void
+mt7996_mac_init_band(struct mt7996_dev *dev, u8 band)
+{
+	u32 mask, set;
+
+	/* clear estimated value of EIFS for Rx duration & OBSS time */
+	mt76_wr(dev, MT_WF_RMAC_RSVD0(band), MT_WF_RMAC_RSVD0_EIFS_CLR);
+
+	/* clear backoff time for Rx duration  */
+	mt76_clear(dev, MT_WF_RMAC_MIB_AIRTIME1(band),
+		   MT_WF_RMAC_MIB_NONQOSD_BACKOFF);
+	mt76_clear(dev, MT_WF_RMAC_MIB_AIRTIME3(band),
+		   MT_WF_RMAC_MIB_QOS01_BACKOFF);
+	mt76_clear(dev, MT_WF_RMAC_MIB_AIRTIME4(band),
+		   MT_WF_RMAC_MIB_QOS23_BACKOFF);
+
+	/* clear backoff time and set software compensation for OBSS time */
+	mask = MT_WF_RMAC_MIB_OBSS_BACKOFF | MT_WF_RMAC_MIB_ED_OFFSET;
+	set = FIELD_PREP(MT_WF_RMAC_MIB_OBSS_BACKOFF, 0) |
+	      FIELD_PREP(MT_WF_RMAC_MIB_ED_OFFSET, 4);
+	mt76_rmw(dev, MT_WF_RMAC_MIB_AIRTIME0(band), mask, set);
+}
+
+static void mt7996_mac_init(struct mt7996_dev *dev)
+{
+#define HIF_TXD_V2_1	4
+	int i;
+
+	mt76_clear(dev, MT_MDP_DCR2, MT_MDP_DCR2_RX_TRANS_SHORT);
+
+	for (i = 0; i < MT7996_WTBL_SIZE; i++)
+		mt7996_mac_wtbl_update(dev, i,
+				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		i = dev->mt76.led_pin ? MT_LED_GPIO_MUX3 : MT_LED_GPIO_MUX2;
+		mt76_rmw_field(dev, i, MT_LED_GPIO_SEL_MASK, 4);
+	}
+
+	/* txs report queue */
+	mt76_rmw_field(dev, MT_DMA_TCRF1(0), MT_DMA_TCRF1_QIDX, 0);
+	mt76_rmw_field(dev, MT_DMA_TCRF1(1), MT_DMA_TCRF1_QIDX, 6);
+	mt76_rmw_field(dev, MT_DMA_TCRF1(2), MT_DMA_TCRF1_QIDX, 0);
+
+	/* rro module init */
+	mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE, 2);
+	mt7996_mcu_set_rro(dev, UNI_RRO_SET_BYPASS_MODE, 3);
+	mt7996_mcu_set_rro(dev, UNI_RRO_SET_TXFREE_PATH, 1);
+
+	mt7996_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+			  MCU_WA_PARAM_HW_PATH_HIF_VER,
+			  HIF_TXD_V2_1, 0);
+
+	for (i = MT_BAND0; i <= MT_BAND2; i++)
+		mt7996_mac_init_band(dev, i);
+}
+
+static int mt7996_txbf_init(struct mt7996_dev *dev)
+{
+	int ret;
+
+	if (dev->dbdc_support) {
+		ret = mt7996_mcu_set_txbf(dev, BF_MOD_EN_CTRL);
+		if (ret)
+			return ret;
+	}
+
+	/* trigger sounding packets */
+	ret = mt7996_mcu_set_txbf(dev, BF_SOUNDING_ON);
+	if (ret)
+		return ret;
+
+	/* enable eBF */
+	return mt7996_mcu_set_txbf(dev, BF_HW_EN_UPDATE);
+}
+
+static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
+			       enum mt76_band_id band)
+{
+	struct mt76_phy *mphy;
+	u32 mac_ofs, hif1_ofs = 0;
+	int ret;
+
+	if (band != MT_BAND1 && band != MT_BAND2)
+		return 0;
+
+	if ((band == MT_BAND1 && !dev->dbdc_support) ||
+	    (band == MT_BAND2 && !dev->tbtc_support))
+		return 0;
+
+	if (phy)
+		return 0;
+
+	if (band == MT_BAND2 && dev->hif2)
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+
+	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7996_ops, band);
+	if (!mphy)
+		return -ENOMEM;
+
+	phy = mphy->priv;
+	phy->dev = dev;
+	phy->mt76 = mphy;
+	mphy->dev->phys[band] = mphy;
+
+	INIT_DELAYED_WORK(&mphy->mac_work, mt7996_mac_work);
+
+	ret = mt7996_eeprom_parse_hw_cap(dev, phy);
+	if (ret)
+		goto error;
+
+	mac_ofs = band == MT_BAND2 ? MT_EE_MAC_ADDR3 : MT_EE_MAC_ADDR2;
+	memcpy(mphy->macaddr, dev->mt76.eeprom.data + mac_ofs, ETH_ALEN);
+	/* Make the extra PHY MAC address local without overlapping with
+	 * the usual MAC address allocation scheme on multiple virtual interfaces
+	 */
+	if (!is_valid_ether_addr(mphy->macaddr)) {
+		memcpy(mphy->macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
+		       ETH_ALEN);
+		mphy->macaddr[0] |= 2;
+		mphy->macaddr[0] ^= BIT(7);
+		if (band == MT_BAND2)
+			mphy->macaddr[0] ^= BIT(6);
+	}
+	mt76_eeprom_override(mphy);
+
+	/* init wiphy according to mphy and phy */
+	mt7996_init_wiphy(mphy->hw);
+	ret = mt76_connac_init_tx_queues(phy->mt76,
+					 MT_TXQ_ID(band),
+					 MT7996_TX_RING_SIZE,
+					 MT_TXQ_RING_BASE(band) + hif1_ofs, 0);
+	if (ret)
+		goto error;
+
+	ret = mt76_register_phy(mphy, true, mt76_rates,
+				ARRAY_SIZE(mt76_rates));
+	if (ret)
+		goto error;
+
+	ret = mt7996_init_debugfs(phy);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	mphy->dev->phys[band] = NULL;
+	ieee80211_free_hw(mphy->hw);
+	return ret;
+}
+
+static void
+mt7996_unregister_phy(struct mt7996_phy *phy, enum mt76_band_id band)
+{
+	struct mt76_phy *mphy;
+
+	if (!phy)
+		return;
+
+	mphy = phy->dev->mt76.phys[band];
+	mt76_unregister_phy(mphy);
+	ieee80211_free_hw(mphy->hw);
+	phy->dev->mt76.phys[band] = NULL;
+}
+
+static void mt7996_init_work(struct work_struct *work)
+{
+	struct mt7996_dev *dev = container_of(work, struct mt7996_dev,
+				 init_work);
+
+	mt7996_mcu_set_eeprom(dev);
+	mt7996_mac_init(dev);
+	mt7996_init_txpower(dev, &dev->mphy.sband_2g.sband);
+	mt7996_init_txpower(dev, &dev->mphy.sband_5g.sband);
+	mt7996_init_txpower(dev, &dev->mphy.sband_6g.sband);
+	mt7996_txbf_init(dev);
+}
+
+void mt7996_wfsys_reset(struct mt7996_dev *dev)
+{
+	mt76_set(dev, MT_WF_SUBSYS_RST, 0x1);
+	msleep(20);
+
+	mt76_clear(dev, MT_WF_SUBSYS_RST, 0x1);
+	msleep(20);
+}
+
+static int mt7996_init_hardware(struct mt7996_dev *dev)
+{
+	int ret, idx;
+
+	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
+
+	INIT_WORK(&dev->init_work, mt7996_init_work);
+
+	dev->dbdc_support = true;
+	dev->tbtc_support = true;
+
+	ret = mt7996_dma_init(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+
+	ret = mt7996_mcu_init(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7996_eeprom_init(dev);
+	if (ret < 0)
+		return ret;
+
+	/* Beacon and mgmt frames should occupy wcid 0 */
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
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
+
+void mt7996_set_stream_vht_txbf_caps(struct mt7996_phy *phy)
+{
+	int sts;
+	u32 *cap;
+
+	if (!phy->mt76->cap.has_5ghz)
+		return;
+
+	sts = hweight16(phy->mt76->chainmask);
+	cap = &phy->mt76->sband_5g.sband.vht_cap.cap;
+
+	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+		IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
+		(3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
+
+	*cap &= ~(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK |
+		  IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
+		  IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
+
+	if (sts < 2)
+		return;
+
+	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
+		IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE |
+		FIELD_PREP(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK, sts - 1);
+}
+
+static void
+mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
+			       struct ieee80211_sta_he_cap *he_cap, int vif)
+{
+	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+	int sts = hweight16(phy->mt76->chainmask);
+	u8 c;
+
+#ifdef CONFIG_MAC80211_MESH
+	if (vif == NL80211_IFTYPE_MESH_POINT)
+		return;
+#endif
+
+	elem->phy_cap_info[3] &= ~IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
+	elem->phy_cap_info[4] &= ~IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
+
+	c = IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK |
+	    IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK;
+	elem->phy_cap_info[5] &= ~c;
+
+	c = IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
+	    IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB;
+	elem->phy_cap_info[6] &= ~c;
+
+	elem->phy_cap_info[7] &= ~IEEE80211_HE_PHY_CAP7_MAX_NC_MASK;
+
+	c = IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
+	    IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
+	    IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
+	elem->phy_cap_info[2] |= c;
+
+	c = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
+	    IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4 |
+	    IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4;
+	elem->phy_cap_info[4] |= c;
+
+	/* do not support NG16 due to spec D4.0 changes subcarrier idx */
+	c = IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_42_SU |
+	    IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU;
+
+	if (vif == NL80211_IFTYPE_STATION)
+		c |= IEEE80211_HE_PHY_CAP6_PARTIAL_BANDWIDTH_DL_MUMIMO;
+
+	elem->phy_cap_info[6] |= c;
+
+	if (sts < 2)
+		return;
+
+	/* the maximum cap is 4 x 3, (Nr, Nc) = (3, 2) */
+	elem->phy_cap_info[7] |= min_t(int, sts - 1, 2) << 3;
+
+	if (vif != NL80211_IFTYPE_AP)
+		return;
+
+	elem->phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
+	elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
+
+	c = FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
+		       sts - 1) |
+	    FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
+		       sts - 1);
+	elem->phy_cap_info[5] |= c;
+
+	c = IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
+	    IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB;
+	elem->phy_cap_info[6] |= c;
+
+	c = IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ |
+	    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ;
+	elem->phy_cap_info[7] |= c;
+}
+
+static void
+mt7996_gen_ppe_thresh(u8 *he_ppet, int nss)
+{
+	u8 i, ppet_bits, ppet_size, ru_bit_mask = 0x7; /* HE80 */
+	static const u8 ppet16_ppet8_ru3_ru0[] = {0x1c, 0xc7, 0x71};
+
+	he_ppet[0] = FIELD_PREP(IEEE80211_PPE_THRES_NSS_MASK, nss - 1) |
+		     FIELD_PREP(IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK,
+				ru_bit_mask);
+
+	ppet_bits = IEEE80211_PPE_THRES_INFO_PPET_SIZE *
+		    nss * hweight8(ru_bit_mask) * 2;
+	ppet_size = DIV_ROUND_UP(ppet_bits, 8);
+
+	for (i = 0; i < ppet_size - 1; i++)
+		he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3];
+
+	he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3] &
+			 (0xff >> (8 - (ppet_bits - 1) % 8));
+}
+
+static int
+mt7996_init_he_caps(struct mt7996_phy *phy, enum nl80211_band band,
+		    struct ieee80211_sband_iftype_data *data)
+{
+	int i, idx = 0, nss = hweight8(phy->mt76->antenna_mask);
+	u16 mcs_map = 0;
+
+	for (i = 0; i < 8; i++) {
+		if (i < nss)
+			mcs_map |= (IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2));
+		else
+			mcs_map |= (IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+	}
+
+	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
+		struct ieee80211_sta_he_cap *he_cap = &data[idx].he_cap;
+		struct ieee80211_he_cap_elem *he_cap_elem =
+				&he_cap->he_cap_elem;
+		struct ieee80211_he_mcs_nss_supp *he_mcs =
+				&he_cap->he_mcs_nss_supp;
+
+		switch (i) {
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_AP:
+#ifdef CONFIG_MAC80211_MESH
+		case NL80211_IFTYPE_MESH_POINT:
+#endif
+			break;
+		default:
+			continue;
+		}
+
+		data[idx].types_mask = BIT(i);
+		he_cap->has_he = true;
+
+		he_cap_elem->mac_cap_info[0] =
+			IEEE80211_HE_MAC_CAP0_HTC_HE;
+		he_cap_elem->mac_cap_info[3] =
+			IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
+			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3;
+		he_cap_elem->mac_cap_info[4] =
+			IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
+
+		if (band == NL80211_BAND_2GHZ)
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+		else
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+
+		he_cap_elem->phy_cap_info[1] =
+			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
+		he_cap_elem->phy_cap_info[2] =
+			IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
+			IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ;
+
+		switch (i) {
+		case NL80211_IFTYPE_AP:
+			he_cap_elem->mac_cap_info[0] |=
+				IEEE80211_HE_MAC_CAP0_TWT_RES;
+			he_cap_elem->mac_cap_info[2] |=
+				IEEE80211_HE_MAC_CAP2_BSR;
+			he_cap_elem->mac_cap_info[4] |=
+				IEEE80211_HE_MAC_CAP4_BQR;
+			he_cap_elem->mac_cap_info[5] |=
+				IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX;
+			he_cap_elem->phy_cap_info[3] |=
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+			break;
+		case NL80211_IFTYPE_STATION:
+			he_cap_elem->mac_cap_info[1] |=
+				IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
+
+			if (band == NL80211_BAND_2GHZ)
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G;
+			else
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G;
+
+			he_cap_elem->phy_cap_info[1] |=
+				IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+				IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
+			he_cap_elem->phy_cap_info[3] |=
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
+				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			he_cap_elem->phy_cap_info[7] |=
+				IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
+				IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
+			he_cap_elem->phy_cap_info[8] |=
+				IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
+				IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
+				IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU |
+				IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_484;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
+				IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
+			break;
+		}
+
+		he_mcs->rx_mcs_80 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_80 = cpu_to_le16(mcs_map);
+		he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
+		he_mcs->rx_mcs_80p80 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_80p80 = cpu_to_le16(mcs_map);
+
+		mt7996_set_stream_he_txbf_caps(phy, he_cap, i);
+
+		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
+		if (he_cap_elem->phy_cap_info[6] &
+		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+			mt7996_gen_ppe_thresh(he_cap->ppe_thres, nss);
+		} else {
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US;
+		}
+
+		if (band == NL80211_BAND_6GHZ) {
+			u16 cap = IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS |
+				  IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
+
+			cap |= u16_encode_bits(IEEE80211_HT_MPDU_DENSITY_2,
+					       IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
+			       u16_encode_bits(IEEE80211_VHT_MAX_AMPDU_1024K,
+					       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP) |
+			       u16_encode_bits(IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+					       IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
+
+			data[idx].he_6ghz_capa.capa = cpu_to_le16(cap);
+		}
+
+		idx++;
+	}
+
+	return idx;
+}
+
+void mt7996_set_stream_he_caps(struct mt7996_phy *phy)
+{
+	struct ieee80211_sband_iftype_data *data;
+	struct ieee80211_supported_band *band;
+	int n;
+
+	if (phy->mt76->cap.has_2ghz) {
+		data = phy->iftype[NL80211_BAND_2GHZ];
+		n = mt7996_init_he_caps(phy, NL80211_BAND_2GHZ, data);
+
+		band = &phy->mt76->sband_2g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+	}
+
+	if (phy->mt76->cap.has_5ghz) {
+		data = phy->iftype[NL80211_BAND_5GHZ];
+		n = mt7996_init_he_caps(phy, NL80211_BAND_5GHZ, data);
+
+		band = &phy->mt76->sband_5g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+	}
+
+	if (phy->mt76->cap.has_6ghz) {
+		data = phy->iftype[NL80211_BAND_6GHZ];
+		n = mt7996_init_he_caps(phy, NL80211_BAND_6GHZ, data);
+
+		band = &phy->mt76->sband_6g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+	}
+}
+
+int mt7996_register_device(struct mt7996_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	int ret;
+
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
+	INIT_WORK(&dev->rc_work, mt7996_mac_sta_rc_work);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7996_mac_work);
+	INIT_LIST_HEAD(&dev->sta_rc_list);
+	INIT_LIST_HEAD(&dev->sta_poll_list);
+	INIT_LIST_HEAD(&dev->twt_list);
+	spin_lock_init(&dev->sta_poll_lock);
+
+	init_waitqueue_head(&dev->reset_wait);
+	INIT_WORK(&dev->reset_work, mt7996_mac_reset_work);
+
+	ret = mt7996_init_hardware(dev);
+	if (ret)
+		return ret;
+
+	mt7996_init_wiphy(hw);
+
+	/* init led callbacks */
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		dev->mt76.led_cdev.brightness_set = mt7996_led_set_brightness;
+		dev->mt76.led_cdev.blink_set = mt7996_led_set_blink;
+	}
+
+	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
+				   ARRAY_SIZE(mt76_rates));
+	if (ret)
+		return ret;
+
+	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
+
+	ret = mt7996_register_phy(dev, mt7996_phy2(dev), MT_BAND1);
+	if (ret)
+		return ret;
+
+	ret = mt7996_register_phy(dev, mt7996_phy3(dev), MT_BAND2);
+	if (ret)
+		return ret;
+
+	return mt7996_init_debugfs(&dev->phy);
+}
+
+void mt7996_unregister_device(struct mt7996_dev *dev)
+{
+	mt7996_unregister_phy(mt7996_phy3(dev), MT_BAND2);
+	mt7996_unregister_phy(mt7996_phy2(dev), MT_BAND1);
+	mt76_unregister_device(&dev->mt76);
+	mt7996_mcu_exit(dev);
+	mt7996_tx_token_put(dev);
+	mt7996_dma_cleanup(dev);
+	tasklet_disable(&dev->irq_tasklet);
+
+	mt76_free_device(&dev->mt76);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
new file mode 100644
index 000000000000..9650590a5d4b
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -0,0 +1,2468 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/timekeeping.h>
+#include "mt7996.h"
+#include "../dma.h"
+#include "mac.h"
+#include "mcu.h"
+
+#define to_rssi(field, rxv)	((FIELD_GET(field, rxv) - 220) / 2)
+
+#define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
+#define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
+						 IEEE80211_RADIOTAP_HE_##f)
+
+static const struct mt7996_dfs_radar_spec etsi_radar_specs = {
+	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
+	.radar_pattern = {
+		[5] =  { 1, 0,  6, 32, 28, 0,  990, 5010, 17, 1, 1 },
+		[6] =  { 1, 0,  9, 32, 28, 0,  615, 5010, 27, 1, 1 },
+		[7] =  { 1, 0, 15, 32, 28, 0,  240,  445, 27, 1, 1 },
+		[8] =  { 1, 0, 12, 32, 28, 0,  240,  510, 42, 1, 1 },
+		[9] =  { 1, 1,  0,  0,  0, 0, 2490, 3343, 14, 0, 0, 12, 32, 28, { }, 126 },
+		[10] = { 1, 1,  0,  0,  0, 0, 2490, 3343, 14, 0, 0, 15, 32, 24, { }, 126 },
+		[11] = { 1, 1,  0,  0,  0, 0,  823, 2510, 14, 0, 0, 18, 32, 28, { },  54 },
+		[12] = { 1, 1,  0,  0,  0, 0,  823, 2510, 14, 0, 0, 27, 32, 24, { },  54 },
+	},
+};
+
+static const struct mt7996_dfs_radar_spec fcc_radar_specs = {
+	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
+	.radar_pattern = {
+		[0] = { 1, 0,  8,  32, 28, 0, 508, 3076, 13, 1,  1 },
+		[1] = { 1, 0, 12,  32, 28, 0, 140,  240, 17, 1,  1 },
+		[2] = { 1, 0,  8,  32, 28, 0, 190,  510, 22, 1,  1 },
+		[3] = { 1, 0,  6,  32, 28, 0, 190,  510, 32, 1,  1 },
+		[4] = { 1, 0,  9, 255, 28, 0, 323,  343, 13, 1, 32 },
+	},
+};
+
+static const struct mt7996_dfs_radar_spec jp_radar_specs = {
+	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
+	.radar_pattern = {
+		[0] =  { 1, 0,  8,  32, 28, 0,  508, 3076,  13, 1,  1 },
+		[1] =  { 1, 0, 12,  32, 28, 0,  140,  240,  17, 1,  1 },
+		[2] =  { 1, 0,  8,  32, 28, 0,  190,  510,  22, 1,  1 },
+		[3] =  { 1, 0,  6,  32, 28, 0,  190,  510,  32, 1,  1 },
+		[4] =  { 1, 0,  9, 255, 28, 0,  323,  343,  13, 1, 32 },
+		[13] = { 1, 0,  7,  32, 28, 0, 3836, 3856,  14, 1,  1 },
+		[14] = { 1, 0,  6,  32, 28, 0,  615, 5010, 110, 1,  1 },
+		[15] = { 1, 1,  0,   0,  0, 0,   15, 5010, 110, 0,  0, 12, 32, 28 },
+	},
+};
+
+static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
+					    u16 idx, bool unicast)
+{
+	struct mt7996_sta *sta;
+	struct mt76_wcid *wcid;
+
+	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
+		return NULL;
+
+	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	if (unicast || !wcid)
+		return wcid;
+
+	if (!wcid->sta)
+		return NULL;
+
+	sta = container_of(wcid, struct mt7996_sta, wcid);
+	if (!sta->vif)
+		return NULL;
+
+	return &sta->vif->sta.wcid;
+}
+
+void mt7996_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
+{
+}
+
+bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask)
+{
+	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
+		 FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, idx) | mask);
+
+	return mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY,
+			 0, 5000);
+}
+
+u32 mt7996_mac_wtbl_lmac_addr(struct mt7996_dev *dev, u16 wcid, u8 dw)
+{
+	mt76_wr(dev, MT_WTBLON_TOP_WDUCR,
+		FIELD_PREP(MT_WTBLON_TOP_WDUCR_GROUP, (wcid >> 7)));
+
+	return MT_WTBL_LMAC_OFFS(wcid, dw);
+}
+
+static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
+{
+	static const u8 ac_to_tid[] = {
+		[IEEE80211_AC_BE] = 0,
+		[IEEE80211_AC_BK] = 1,
+		[IEEE80211_AC_VI] = 4,
+		[IEEE80211_AC_VO] = 6
+	};
+	struct ieee80211_sta *sta;
+	struct mt7996_sta *msta;
+	struct rate_info *rate;
+	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
+	LIST_HEAD(sta_poll_list);
+	int i;
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
+	rcu_read_lock();
+
+	while (true) {
+		bool clear = false;
+		u32 addr, val;
+		u16 idx;
+		u8 bw;
+
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&sta_poll_list)) {
+			spin_unlock_bh(&dev->sta_poll_lock);
+			break;
+		}
+		msta = list_first_entry(&sta_poll_list,
+					struct mt7996_sta, poll_list);
+		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+
+		idx = msta->wcid.idx;
+		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 20);
+
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u32 tx_last = msta->airtime_ac[i];
+			u32 rx_last = msta->airtime_ac[i + 4];
+
+			msta->airtime_ac[i] = mt76_rr(dev, addr);
+			msta->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
+
+			tx_time[i] = msta->airtime_ac[i] - tx_last;
+			rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
+
+			if ((tx_last | rx_last) & BIT(30))
+				clear = true;
+
+			addr += 8;
+		}
+
+		if (clear) {
+			mt7996_mac_wtbl_update(dev, idx,
+					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+		}
+
+		if (!msta->wcid.sta)
+			continue;
+
+		sta = container_of((void *)msta, struct ieee80211_sta,
+				   drv_priv);
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u8 q = mt76_connac_lmac_mapping(i);
+			u32 tx_cur = tx_time[q];
+			u32 rx_cur = rx_time[q];
+			u8 tid = ac_to_tid[i];
+
+			if (!tx_cur && !rx_cur)
+				continue;
+
+			ieee80211_sta_register_airtime(sta, tid, tx_cur, rx_cur);
+		}
+
+		/* We don't support reading GI info from txs packets.
+		 * For accurate tx status reporting and AQL improvement,
+		 * we need to make sure that flags match so polling GI
+		 * from per-sta counters directly.
+		 */
+		rate = &msta->wcid.rate;
+
+		switch (rate->bw) {
+		case RATE_INFO_BW_160:
+			bw = IEEE80211_STA_RX_BW_160;
+			break;
+		case RATE_INFO_BW_80:
+			bw = IEEE80211_STA_RX_BW_80;
+			break;
+		case RATE_INFO_BW_40:
+			bw = IEEE80211_STA_RX_BW_40;
+			break;
+		default:
+			bw = IEEE80211_STA_RX_BW_20;
+			break;
+		}
+
+		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 6);
+		val = mt76_rr(dev, addr);
+		if (rate->flags & RATE_INFO_FLAGS_HE_MCS) {
+			u8 offs = 24 + 2 * bw;
+
+			rate->he_gi = (val & (0x3 << offs)) >> offs;
+		} else if (rate->flags &
+			   (RATE_INFO_FLAGS_VHT_MCS | RATE_INFO_FLAGS_MCS)) {
+			if (val & BIT(12 + bw))
+				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
+			else
+				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
+		}
+	}
+
+	rcu_read_unlock();
+}
+
+static void
+mt7996_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
+				 struct ieee80211_radiotap_he *he,
+				 __le32 *rxv)
+{
+	u32 ru_h, ru_l;
+	u8 ru, offs = 0;
+
+	ru_l = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC_L);
+	ru_h = le32_get_bits(rxv[1], MT_PRXV_HE_RU_ALLOC_H);
+	ru = (u8)(ru_l | ru_h << 4);
+
+	status->bw = RATE_INFO_BW_HE_RU;
+
+	switch (ru) {
+	case 0 ... 36:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		offs = ru;
+		break;
+	case 37 ... 52:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_52;
+		offs = ru - 37;
+		break;
+	case 53 ... 60:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		offs = ru - 53;
+		break;
+	case 61 ... 64:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+		offs = ru - 61;
+		break;
+	case 65 ... 66:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+		offs = ru - 65;
+		break;
+	case 67:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+		break;
+	case 68:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+		break;
+	}
+
+	he->data1 |= HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+	he->data2 |= HE_BITS(DATA2_RU_OFFSET_KNOWN) |
+		     le16_encode_bits(offs,
+				      IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET);
+}
+
+static void
+mt7996_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	static const struct ieee80211_radiotap_he_mu mu_known = {
+		.flags1 = HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
+			  HE_BITS(MU_FLAGS1_CH1_RU_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN),
+		.flags2 = HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN),
+	};
+	struct ieee80211_radiotap_he_mu *he_mu = NULL;
+
+	status->flag |= RX_FLAG_RADIOTAP_HE_MU;
+
+	he_mu = skb_push(skb, sizeof(mu_known));
+	memcpy(he_mu, &mu_known, sizeof(mu_known));
+
+#define MU_PREP(f, v)	le16_encode_bits(v, IEEE80211_RADIOTAP_HE_MU_##f)
+
+	he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_MCS, status->rate_idx);
+	if (status->he_dcm)
+		he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_DCM, status->he_dcm);
+
+	he_mu->flags2 |= MU_PREP(FLAGS2_BW_FROM_SIG_A_BW, status->bw) |
+			 MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
+				 le32_get_bits(rxv[2], MT_CRXV_HE_NUM_USER));
+
+	he_mu->ru_ch1[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU0);
+
+	if (status->bw >= RATE_INFO_BW_40) {
+		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
+		he_mu->ru_ch2[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU1);
+	}
+
+	if (status->bw >= RATE_INFO_BW_80) {
+		he_mu->ru_ch1[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU2);
+		he_mu->ru_ch2[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU3);
+	}
+}
+
+static void
+mt7996_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u8 mode)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	static const struct ieee80211_radiotap_he known = {
+		.data1 = HE_BITS(DATA1_DATA_MCS_KNOWN) |
+			 HE_BITS(DATA1_DATA_DCM_KNOWN) |
+			 HE_BITS(DATA1_STBC_KNOWN) |
+			 HE_BITS(DATA1_CODING_KNOWN) |
+			 HE_BITS(DATA1_LDPC_XSYMSEG_KNOWN) |
+			 HE_BITS(DATA1_DOPPLER_KNOWN) |
+			 HE_BITS(DATA1_SPTL_REUSE_KNOWN) |
+			 HE_BITS(DATA1_BSS_COLOR_KNOWN),
+		.data2 = HE_BITS(DATA2_GI_KNOWN) |
+			 HE_BITS(DATA2_TXBF_KNOWN) |
+			 HE_BITS(DATA2_PE_DISAMBIG_KNOWN) |
+			 HE_BITS(DATA2_TXOP_KNOWN),
+	};
+	struct ieee80211_radiotap_he *he = NULL;
+	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
+
+	status->flag |= RX_FLAG_RADIOTAP_HE;
+
+	he = skb_push(skb, sizeof(known));
+	memcpy(he, &known, sizeof(known));
+
+	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[14]) |
+		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[2]);
+	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
+	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
+		    le16_encode_bits(ltf_size,
+				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
+	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
+		he->data5 |= HE_BITS(DATA5_TXBF);
+	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
+		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
+
+	switch (mode) {
+	case MT_PHY_TYPE_HE_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
+			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
+			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		break;
+	case MT_PHY_TYPE_HE_EXT_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		break;
+	case MT_PHY_TYPE_HE_MU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[7]);
+
+		mt7996_mac_decode_he_radiotap_ru(status, he, rxv);
+		mt7996_mac_decode_he_mu_radiotap(skb, rxv);
+		break;
+	case MT_PHY_TYPE_HE_TB:
+		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
+			     HE_BITS(DATA1_SPTL_REUSE2_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
+
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
+
+		mt7996_mac_decode_he_radiotap_ru(status, he, rxv);
+		break;
+	default:
+		break;
+	}
+}
+
+/* The HW does not translate the mac header to 802.3 for mesh point */
+static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_gap);
+	struct mt7996_sta *msta = (struct mt7996_sta *)status->wcid;
+	__le32 *rxd = (__le32 *)skb->data;
+	struct ieee80211_sta *sta;
+	struct ieee80211_vif *vif;
+	struct ieee80211_hdr hdr;
+	u16 frame_control;
+
+	if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=
+	    MT_RXD3_NORMAL_U2M)
+		return -EINVAL;
+
+	if (!(le32_to_cpu(rxd[1]) & MT_RXD1_NORMAL_GROUP_4))
+		return -EINVAL;
+
+	if (!msta || !msta->vif)
+		return -EINVAL;
+
+	sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
+	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
+
+	/* store the info from RXD and ethhdr to avoid being overridden */
+	frame_control = le32_get_bits(rxd[8], MT_RXD8_FRAME_CONTROL);
+	hdr.frame_control = cpu_to_le16(frame_control);
+	hdr.seq_ctrl = cpu_to_le16(le32_get_bits(rxd[10], MT_RXD10_SEQ_CTRL));
+	hdr.duration_id = 0;
+
+	ether_addr_copy(hdr.addr1, vif->addr);
+	ether_addr_copy(hdr.addr2, sta->addr);
+	switch (frame_control & (IEEE80211_FCTL_TODS |
+				 IEEE80211_FCTL_FROMDS)) {
+	case 0:
+		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
+		break;
+	case IEEE80211_FCTL_FROMDS:
+		ether_addr_copy(hdr.addr3, eth_hdr->h_source);
+		break;
+	case IEEE80211_FCTL_TODS:
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
+		break;
+	case IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS:
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
+		ether_addr_copy(hdr.addr4, eth_hdr->h_source);
+		break;
+	default:
+		break;
+	}
+
+	skb_pull(skb, hdr_gap + sizeof(struct ethhdr) - 2);
+	if (eth_hdr->h_proto == cpu_to_be16(ETH_P_AARP) ||
+	    eth_hdr->h_proto == cpu_to_be16(ETH_P_IPX))
+		ether_addr_copy(skb_push(skb, ETH_ALEN), bridge_tunnel_header);
+	else if (be16_to_cpu(eth_hdr->h_proto) >= ETH_P_802_3_MIN)
+		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
+	else
+		skb_pull(skb, 2);
+
+	if (ieee80211_has_order(hdr.frame_control))
+		memcpy(skb_push(skb, IEEE80211_HT_CTL_LEN), &rxd[11],
+		       IEEE80211_HT_CTL_LEN);
+	if (ieee80211_is_data_qos(hdr.frame_control)) {
+		__le16 qos_ctrl;
+
+		qos_ctrl = cpu_to_le16(le32_get_bits(rxd[10], MT_RXD10_QOS_CTL));
+		memcpy(skb_push(skb, IEEE80211_QOS_CTL_LEN), &qos_ctrl,
+		       IEEE80211_QOS_CTL_LEN);
+	}
+
+	if (ieee80211_has_a4(hdr.frame_control))
+		memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
+	else
+		memcpy(skb_push(skb, sizeof(hdr) - 6), &hdr, sizeof(hdr) - 6);
+
+	return 0;
+}
+
+static int
+mt7996_mac_fill_rx_rate(struct mt7996_dev *dev,
+			struct mt76_rx_status *status,
+			struct ieee80211_supported_band *sband,
+			__le32 *rxv, u8 *mode)
+{
+	u32 v0, v2;
+	u8 stbc, gi, bw, dcm, nss;
+	int i, idx;
+	bool cck = false;
+
+	v0 = le32_to_cpu(rxv[0]);
+	v2 = le32_to_cpu(rxv[2]);
+
+	idx = FIELD_GET(MT_PRXV_TX_RATE, v0);
+	i = idx;
+	nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+
+	stbc = FIELD_GET(MT_PRXV_HT_STBC, v2);
+	gi = FIELD_GET(MT_PRXV_HT_SHORT_GI, v2);
+	*mode = FIELD_GET(MT_PRXV_TX_MODE, v2);
+	dcm = FIELD_GET(MT_PRXV_DCM, v2);
+	bw = FIELD_GET(MT_PRXV_FRAME_MODE, v2);
+
+	switch (*mode) {
+	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
+	case MT_PHY_TYPE_OFDM:
+		i = mt76_get_rate(&dev->mt76, sband, i, cck);
+		break;
+	case MT_PHY_TYPE_HT_GF:
+	case MT_PHY_TYPE_HT:
+		status->encoding = RX_ENC_HT;
+		if (gi)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		if (i > 31)
+			return -EINVAL;
+		break;
+	case MT_PHY_TYPE_VHT:
+		status->nss = nss;
+		status->encoding = RX_ENC_VHT;
+		if (gi)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		if (i > 11)
+			return -EINVAL;
+		break;
+	case MT_PHY_TYPE_HE_MU:
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+		status->nss = nss;
+		status->encoding = RX_ENC_HE;
+		i &= GENMASK(3, 0);
+
+		if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
+			status->he_gi = gi;
+
+		status->he_dcm = dcm;
+		break;
+	default:
+		return -EINVAL;
+	}
+	status->rate_idx = i;
+
+	switch (bw) {
+	case IEEE80211_STA_RX_BW_20:
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		if (*mode & MT_PHY_TYPE_HE_EXT_SU &&
+		    (idx & MT_PRXV_TX_ER_SU_106T)) {
+			status->bw = RATE_INFO_BW_HE_RU;
+			status->he_ru =
+				NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		} else {
+			status->bw = RATE_INFO_BW_40;
+		}
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		status->bw = RATE_INFO_BW_80;
+		break;
+	case IEEE80211_STA_RX_BW_160:
+		status->bw = RATE_INFO_BW_160;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
+	if (*mode < MT_PHY_TYPE_HE_SU && gi)
+		status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+
+	return 0;
+}
+
+static int
+mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7996_phy *phy = &dev->phy;
+	struct ieee80211_supported_band *sband;
+	__le32 *rxd = (__le32 *)skb->data;
+	__le32 *rxv = NULL;
+	u32 rxd0 = le32_to_cpu(rxd[0]);
+	u32 rxd1 = le32_to_cpu(rxd[1]);
+	u32 rxd2 = le32_to_cpu(rxd[2]);
+	u32 rxd3 = le32_to_cpu(rxd[3]);
+	u32 rxd4 = le32_to_cpu(rxd[4]);
+	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
+	u32 csum_status = *(u32 *)skb->cb;
+	bool unicast, insert_ccmp_hdr = false;
+	u8 remove_pad, amsdu_info, band_idx;
+	u8 mode = 0, qos_ctl = 0;
+	bool hdr_trans;
+	u16 hdr_gap;
+	u16 seq_ctrl = 0;
+	__le16 fc = 0;
+	int idx;
+
+	memset(status, 0, sizeof(*status));
+
+	band_idx = FIELD_GET(MT_RXD1_NORMAL_BAND_IDX, rxd1);
+	mphy = dev->mt76.phys[band_idx];
+	phy = mphy->priv;
+	status->phy_idx = mphy->band_idx;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
+		return -EINVAL;
+
+	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
+		return -EINVAL;
+
+	hdr_trans = rxd2 & MT_RXD2_NORMAL_HDR_TRANS;
+	if (hdr_trans && (rxd1 & MT_RXD1_NORMAL_CM))
+		return -EINVAL;
+
+	/* ICV error or CCMP/BIP/WPI MIC error */
+	if (rxd1 & MT_RXD1_NORMAL_ICV_ERR)
+		status->flag |= RX_FLAG_ONLY_MONITOR;
+
+	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
+	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
+	status->wcid = mt7996_rx_get_wcid(dev, idx, unicast);
+
+	if (status->wcid) {
+		struct mt7996_sta *msta;
+
+		msta = container_of(status->wcid, struct mt7996_sta, wcid);
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&msta->poll_list))
+			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+	}
+
+	status->freq = mphy->chandef.chan->center_freq;
+	status->band = mphy->chandef.chan->band;
+	if (status->band == NL80211_BAND_5GHZ)
+		sband = &mphy->sband_5g.sband;
+	else if (status->band == NL80211_BAND_6GHZ)
+		sband = &mphy->sband_6g.sband;
+	else
+		sband = &mphy->sband_2g.sband;
+
+	if (!sband->channels)
+		return -EINVAL;
+
+	if ((rxd0 & csum_mask) == csum_mask &&
+	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	if (rxd1 & MT_RXD3_NORMAL_FCS_ERR)
+		status->flag |= RX_FLAG_FAILED_FCS_CRC;
+
+	if (rxd1 & MT_RXD1_NORMAL_TKIP_MIC_ERR)
+		status->flag |= RX_FLAG_MMIC_ERROR;
+
+	if (FIELD_GET(MT_RXD2_NORMAL_SEC_MODE, rxd2) != 0 &&
+	    !(rxd1 & (MT_RXD1_NORMAL_CLM | MT_RXD1_NORMAL_CM))) {
+		status->flag |= RX_FLAG_DECRYPTED;
+		status->flag |= RX_FLAG_IV_STRIPPED;
+		status->flag |= RX_FLAG_MMIC_STRIPPED | RX_FLAG_MIC_STRIPPED;
+	}
+
+	remove_pad = FIELD_GET(MT_RXD2_NORMAL_HDR_OFFSET, rxd2);
+
+	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
+		return -EINVAL;
+
+	rxd += 8;
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
+		u32 v0 = le32_to_cpu(rxd[0]);
+		u32 v2 = le32_to_cpu(rxd[2]);
+
+		fc = cpu_to_le16(FIELD_GET(MT_RXD8_FRAME_CONTROL, v0));
+		qos_ctl = FIELD_GET(MT_RXD10_QOS_CTL, v2);
+		seq_ctrl = FIELD_GET(MT_RXD10_SEQ_CTRL, v2);
+
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_1) {
+		u8 *data = (u8 *)rxd;
+
+		if (status->flag & RX_FLAG_DECRYPTED) {
+			switch (FIELD_GET(MT_RXD2_NORMAL_SEC_MODE, rxd2)) {
+			case MT_CIPHER_AES_CCMP:
+			case MT_CIPHER_CCMP_CCX:
+			case MT_CIPHER_CCMP_256:
+				insert_ccmp_hdr =
+					FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+				fallthrough;
+			case MT_CIPHER_TKIP:
+			case MT_CIPHER_TKIP_NO_MIC:
+			case MT_CIPHER_GCMP:
+			case MT_CIPHER_GCMP_256:
+				status->iv[0] = data[5];
+				status->iv[1] = data[4];
+				status->iv[2] = data[3];
+				status->iv[3] = data[2];
+				status->iv[4] = data[1];
+				status->iv[5] = data[0];
+				break;
+			default:
+				break;
+			}
+		}
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_2) {
+		status->timestamp = le32_to_cpu(rxd[0]);
+		status->flag |= RX_FLAG_MACTIME_START;
+
+		if (!(rxd2 & MT_RXD2_NORMAL_NON_AMPDU)) {
+			status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+			/* all subframes of an A-MPDU have the same timestamp */
+			if (phy->rx_ampdu_ts != status->timestamp) {
+				if (!++phy->ampdu_ref)
+					phy->ampdu_ref++;
+			}
+			phy->rx_ampdu_ts = status->timestamp;
+
+			status->ampdu_ref = phy->ampdu_ref;
+		}
+
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	/* RXD Group 3 - P-RXV */
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
+		u32 v3;
+		int ret;
+
+		rxv = rxd;
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+
+		v3 = le32_to_cpu(rxv[3]);
+
+		status->chains = mphy->antenna_mask;
+		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v3);
+		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v3);
+		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v3);
+		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v3);
+
+		/* RXD Group 5 - C-RXV */
+		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
+			rxd += 24;
+			if ((u8 *)rxd - skb->data >= skb->len)
+				return -EINVAL;
+		}
+
+		ret = mt7996_mac_fill_rx_rate(dev, status, sband, rxv, &mode);
+		if (ret < 0)
+			return ret;
+	}
+
+	amsdu_info = FIELD_GET(MT_RXD4_NORMAL_PAYLOAD_FORMAT, rxd4);
+	status->amsdu = !!amsdu_info;
+	if (status->amsdu) {
+		status->first_amsdu = amsdu_info == MT_RXD4_FIRST_AMSDU_FRAME;
+		status->last_amsdu = amsdu_info == MT_RXD4_LAST_AMSDU_FRAME;
+	}
+
+	hdr_gap = (u8 *)rxd - skb->data + 2 * remove_pad;
+	if (hdr_trans && ieee80211_has_morefrags(fc)) {
+		if (mt7996_reverse_frag0_hdr_trans(skb, hdr_gap))
+			return -EINVAL;
+		hdr_trans = false;
+	} else {
+		int pad_start = 0;
+
+		skb_pull(skb, hdr_gap);
+		if (!hdr_trans && status->amsdu) {
+			pad_start = ieee80211_get_hdrlen_from_skb(skb);
+		} else if (hdr_trans && (rxd2 & MT_RXD2_NORMAL_HDR_TRANS_ERROR)) {
+			/* When header translation failure is indicated,
+			 * the hardware will insert an extra 2-byte field
+			 * containing the data length after the protocol
+			 * type field.
+			 */
+			pad_start = 12;
+			if (get_unaligned_be16(skb->data + pad_start) == ETH_P_8021Q)
+				pad_start += 4;
+			else
+				pad_start = 0;
+		}
+
+		if (pad_start) {
+			memmove(skb->data + 2, skb->data, pad_start);
+			skb_pull(skb, 2);
+		}
+	}
+
+	if (!hdr_trans) {
+		struct ieee80211_hdr *hdr;
+
+		if (insert_ccmp_hdr) {
+			u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
+
+			mt76_insert_ccmp_hdr(skb, key_id);
+		}
+
+		hdr = mt76_skb_get_hdr(skb);
+		fc = hdr->frame_control;
+		if (ieee80211_is_data_qos(fc)) {
+			seq_ctrl = le16_to_cpu(hdr->seq_ctrl);
+			qos_ctl = *ieee80211_get_qos_ctl(hdr);
+		}
+	} else {
+		status->flag |= RX_FLAG_8023;
+	}
+
+	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
+		mt7996_mac_decode_he_radiotap(skb, rxv, mode);
+
+	if (!status->wcid || !ieee80211_is_data_qos(fc))
+		return 0;
+
+	status->aggr = unicast &&
+		       !ieee80211_is_qos_nullfunc(fc);
+	status->qos_ctl = qos_ctl;
+	status->seqno = IEEE80211_SEQ_TO_SN(seq_ctrl);
+
+	return 0;
+}
+
+static void
+mt7996_mac_write_txwi_8023(struct mt7996_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid)
+{
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	u8 fc_type, fc_stype;
+	u16 ethertype;
+	bool wmm = false;
+	u32 val;
+
+	if (wcid->sta) {
+		struct ieee80211_sta *sta;
+
+		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
+		wmm = sta->wme;
+	}
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+
+	ethertype = get_unaligned_be16(&skb->data[12]);
+	if (ethertype >= ETH_P_802_3_MIN)
+		val |= MT_TXD1_ETH_802_3;
+
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = IEEE80211_FTYPE_DATA >> 2;
+	fc_stype = wmm ? IEEE80211_STYPE_QOS_DATA >> 4 : 0;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
+
+	txwi[2] |= cpu_to_le32(val);
+}
+
+static void
+mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
+			    struct sk_buff *skb, struct ieee80211_key_conf *key)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	bool multicast = is_multicast_ether_addr(hdr->addr1);
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	__le16 fc = hdr->frame_control;
+	u8 fc_type, fc_stype;
+	u32 val;
+
+	if (ieee80211_is_action(fc) &&
+	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
+	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ)
+		tid = MT_TX_ADDBA;
+	else if (ieee80211_is_mgmt(hdr->frame_control))
+		tid = MT_TX_NORMAL;
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
+	      FIELD_PREP(MT_TXD1_HDR_INFO,
+			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+
+	if (!ieee80211_is_data(fc) || multicast ||
+	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
+		val |= MT_TXD1_FIXED_RATE;
+
+	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
+	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
+		val |= MT_TXD1_BIP;
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
+	}
+
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
+	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
+
+	txwi[2] |= cpu_to_le32(val);
+
+	txwi[3] |= FIELD_PREP(MT_TXD3_BCM, multicast);
+	if (ieee80211_is_beacon(fc)) {
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
+		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
+	}
+
+	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
+		u16 seqno = le16_to_cpu(hdr->seq_ctrl);
+
+		if (ieee80211_is_back_req(hdr->frame_control)) {
+			struct ieee80211_bar *bar;
+
+			bar = (struct ieee80211_bar *)skb->data;
+			seqno = le16_to_cpu(bar->start_seq_num);
+		}
+
+		val = MT_TXD3_SN_VALID |
+		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
+		txwi[3] |= cpu_to_le32(val);
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_HW_AMSDU);
+	}
+}
+
+static u16
+mt7996_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+		       bool beacon, bool mcast)
+{
+	u8 mode = 0, band = mphy->chandef.chan->band;
+	int rateidx = 0, mcast_rate;
+
+	if (beacon) {
+		struct cfg80211_bitrate_mask *mask;
+
+		mask = &vif->bss_conf.beacon_tx_rate;
+		if (hweight16(mask->control[band].he_mcs[0]) == 1) {
+			rateidx = ffs(mask->control[band].he_mcs[0]) - 1;
+			mode = MT_PHY_TYPE_HE_SU;
+			goto out;
+		} else if (hweight16(mask->control[band].vht_mcs[0]) == 1) {
+			rateidx = ffs(mask->control[band].vht_mcs[0]) - 1;
+			mode = MT_PHY_TYPE_VHT;
+			goto out;
+		} else if (hweight8(mask->control[band].ht_mcs[0]) == 1) {
+			rateidx = ffs(mask->control[band].ht_mcs[0]) - 1;
+			mode = MT_PHY_TYPE_HT;
+			goto out;
+		} else if (hweight32(mask->control[band].legacy) == 1) {
+			rateidx = ffs(mask->control[band].legacy) - 1;
+			goto legacy;
+		}
+	}
+
+	mcast_rate = vif->bss_conf.mcast_rate[band];
+	if (mcast && mcast_rate > 0)
+		rateidx = mcast_rate - 1;
+	else
+		rateidx = ffs(vif->bss_conf.basic_rates) - 1;
+
+legacy:
+	rateidx = mt76_calculate_default_rate(mphy, rateidx);
+	mode = rateidx >> 8;
+	rateidx &= GENMASK(7, 0);
+
+out:
+	return FIELD_PREP(MT_TX_RATE_IDX, rateidx) |
+	       FIELD_PREP(MT_TX_RATE_MODE, mode);
+}
+
+void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
+			   struct ieee80211_key_conf *key, u32 changed)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_phy *mphy = &dev->mphy;
+	u8 band_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
+	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
+	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	u16 tx_count = 15;
+	u32 val;
+	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
+				    BSS_CHANGED_BEACON_ENABLED));
+	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
+					 BSS_CHANGED_FILS_DISCOVERY));
+
+	if (vif) {
+		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+
+		omac_idx = mvif->mt76.omac_idx;
+		wmm_idx = mvif->mt76.wmm_idx;
+		band_idx = mvif->mt76.band_idx;
+	}
+
+	mphy = mt76_dev_phy(&dev->mt76, band_idx);
+
+	if (inband_disc) {
+		p_fmt = MT_TX_TYPE_FW;
+		q_idx = MT_LMAC_ALTX0;
+	} else if (beacon) {
+		p_fmt = MT_TX_TYPE_FW;
+		q_idx = MT_LMAC_BCN0;
+	} else if (skb_get_queue_mapping(skb) >= MT_TXQ_PSD) {
+		p_fmt = MT_TX_TYPE_CT;
+		q_idx = MT_LMAC_ALTX0;
+	} else {
+		p_fmt = MT_TX_TYPE_CT;
+		q_idx = wmm_idx * MT7996_MAX_WMM_SETS +
+			mt76_connac_lmac_mapping(skb_get_queue_mapping(skb));
+	}
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + MT_TXD_SIZE) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, p_fmt) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
+	txwi[0] = cpu_to_le32(val);
+
+	val = FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
+	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
+
+	if (band_idx)
+		val |= FIELD_PREP(MT_TXD1_TGID, band_idx);
+
+	txwi[1] = cpu_to_le32(val);
+	txwi[2] = 0;
+
+	val = MT_TXD3_SW_POWER_MGMT |
+	      FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
+	if (key)
+		val |= MT_TXD3_PROTECT_FRAME;
+	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
+		val |= MT_TXD3_NO_ACK;
+	if (wcid->amsdu)
+		val |= MT_TXD3_HW_AMSDU;
+
+	txwi[3] = cpu_to_le32(val);
+	txwi[4] = 0;
+
+	val = FIELD_PREP(MT_TXD5_PID, pid);
+	if (pid >= MT_PACKET_ID_FIRST)
+		val |= MT_TXD5_TX_STATUS_HOST;
+	txwi[5] = cpu_to_le32(val);
+
+	val = MT_TXD6_DIS_MAT | MT_TXD6_DAS |
+	      FIELD_PREP(MT_TXD6_MSDU_CNT, 1);
+	txwi[6] = cpu_to_le32(val);
+	txwi[7] = 0;
+
+	if (is_8023)
+		mt7996_mac_write_txwi_8023(dev, txwi, skb, wcid);
+	else
+		mt7996_mac_write_txwi_80211(dev, txwi, skb, key);
+
+	if (txwi[1] & cpu_to_le32(MT_TXD1_FIXED_RATE)) {
+		/* Fixed rata is available just for 802.11 txd */
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+		bool multicast = is_multicast_ether_addr(hdr->addr1);
+		u16 rate = mt7996_mac_tx_rate_val(mphy, vif, beacon, multicast);
+
+		/* fix to bw 20 */
+		val = MT_TXD6_FIXED_BW |
+		      FIELD_PREP(MT_TXD6_BW, 0) |
+		      FIELD_PREP(MT_TXD6_TX_RATE, rate);
+
+		txwi[6] |= cpu_to_le32(val);
+		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
+	}
+}
+
+int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			  struct ieee80211_sta *sta,
+			  struct mt76_tx_info *tx_info)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx_info->skb->data;
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_txwi_cache *t;
+	struct mt7996_txp *txp;
+	int id, i, pid, nbuf = tx_info->nbuf - 1;
+	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	u8 *txwi = (u8 *)txwi_ptr;
+
+	if (unlikely(tx_info->skb->len <= ETH_HLEN))
+		return -EINVAL;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	if (sta) {
+		struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+
+		if (time_after(jiffies, msta->jiffies + HZ / 4)) {
+			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			msta->jiffies = jiffies;
+		}
+	}
+
+	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
+	t->skb = tx_info->skb;
+
+	id = mt76_token_consume(mdev, &t);
+	if (id < 0)
+		return id;
+
+	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
+	memset(txwi_ptr, 0, MT_TXD_SIZE);
+	/* Transmit non qos data by 802.11 header and need to fill txd by host*/
+	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
+		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, pid,
+				      key, 0);
+
+	txp = (struct mt7996_txp *)(txwi + MT_TXD_SIZE);
+	for (i = 0; i < nbuf; i++) {
+		txp->buf[i] = cpu_to_le32(tx_info->buf[i + 1].addr);
+		txp->len[i] = cpu_to_le16(tx_info->buf[i + 1].len);
+	}
+	txp->nbuf = nbuf;
+
+	txp->flags = cpu_to_le16(MT_CT_INFO_FROM_HOST);
+
+	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
+		txp->flags |= cpu_to_le16(MT_CT_INFO_APPLY_TXD);
+
+	if (!key)
+		txp->flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
+
+	if (!is_8023 && ieee80211_is_mgmt(hdr->frame_control))
+		txp->flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
+
+	if (vif) {
+		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+
+		txp->bss_idx = mvif->mt76.idx;
+	}
+
+	txp->token = cpu_to_le16(id);
+	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags))
+		txp->rept_wds_wcid = cpu_to_le16(wcid->idx);
+	else
+		txp->rept_wds_wcid = cpu_to_le16(0xfff);
+	tx_info->skb = DMA_DUMMY_DATA;
+
+	/* pass partial skb header to fw */
+	tx_info->buf[1].len = MT_CT_PARSE_LEN;
+	tx_info->buf[1].skip_unmap = true;
+	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
+
+	return 0;
+}
+
+static void
+mt7996_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
+{
+	struct mt7996_sta *msta;
+	u16 fc, tid;
+	u32 val;
+
+	if (!sta || !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
+		return;
+
+	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
+	if (tid >= 6) /* skip VO queue */
+		return;
+
+	val = le32_to_cpu(txwi[2]);
+	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
+	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
+	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
+		return;
+
+	msta = (struct mt7996_sta *)sta->drv_priv;
+	if (!test_and_set_bit(tid, &msta->ampdu_state))
+		ieee80211_start_tx_ba_session(sta, tid, 0);
+}
+
+static void
+mt7996_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	struct mt7996_txp *txp;
+	int i;
+
+	txp = mt7996_txwi_to_txp(dev, t);
+	for (i = 0; i < txp->nbuf; i++)
+		dma_unmap_single(dev->dev, le32_to_cpu(txp->buf[i]),
+				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
+}
+
+static void
+mt7996_txwi_free(struct mt7996_dev *dev, struct mt76_txwi_cache *t,
+		 struct ieee80211_sta *sta, struct list_head *free_list)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_wcid *wcid;
+	__le32 *txwi;
+	u16 wcid_idx;
+
+	mt7996_txp_skb_unmap(mdev, t);
+	if (!t->skb)
+		goto out;
+
+	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
+	if (sta) {
+		wcid = (struct mt76_wcid *)sta->drv_priv;
+		wcid_idx = wcid->idx;
+
+		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+			mt7996_tx_check_aggr(sta, txwi);
+	} else {
+		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+	}
+
+	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
+
+out:
+	t->skb = NULL;
+	mt76_put_txwi(mdev, t);
+}
+
+static void
+mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
+{
+	__le32 *tx_free = (__le32 *)data, *cur_info;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_phy *phy2 = mdev->phys[MT_BAND1];
+	struct mt76_phy *phy3 = mdev->phys[MT_BAND2];
+	struct mt76_txwi_cache *txwi;
+	struct ieee80211_sta *sta = NULL;
+	LIST_HEAD(free_list);
+	struct sk_buff *skb, *tmp;
+	void *end = data + len;
+	bool wake = false;
+	u16 total, count = 0;
+
+	/* clean DMA queues and unmap buffers first */
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
+	if (phy2) {
+		mt76_queue_tx_cleanup(dev, phy2->q_tx[MT_TXQ_PSD], false);
+		mt76_queue_tx_cleanup(dev, phy2->q_tx[MT_TXQ_BE], false);
+	}
+	if (phy3) {
+		mt76_queue_tx_cleanup(dev, phy3->q_tx[MT_TXQ_PSD], false);
+		mt76_queue_tx_cleanup(dev, phy3->q_tx[MT_TXQ_BE], false);
+	}
+
+	if (WARN_ON_ONCE(le32_get_bits(tx_free[1], MT_TXFREE1_VER) < 4))
+		return;
+
+	total = le32_get_bits(tx_free[0], MT_TXFREE0_MSDU_CNT);
+	for (cur_info = &tx_free[2]; count < total; cur_info++) {
+		u32 msdu, info;
+		u8 i;
+
+		if (WARN_ON_ONCE((void *)cur_info >= end))
+			return;
+		/* 1'b1: new wcid pair.
+		 * 1'b0: msdu_id with the same 'wcid pair' as above.
+		 */
+		info = le32_to_cpu(*cur_info);
+		if (info & MT_TXFREE_INFO_PAIR) {
+			struct mt7996_sta *msta;
+			struct mt76_wcid *wcid;
+			u16 idx;
+
+			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
+			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			sta = wcid_to_sta(wcid);
+			if (!sta)
+				continue;
+
+			msta = container_of(wcid, struct mt7996_sta, wcid);
+			spin_lock_bh(&dev->sta_poll_lock);
+			if (list_empty(&msta->poll_list))
+				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+			spin_unlock_bh(&dev->sta_poll_lock);
+			continue;
+		}
+
+		if (info & MT_TXFREE_INFO_HEADER)
+			continue;
+
+		for (i = 0; i < 2; i++) {
+			msdu = (info >> (15 * i)) & MT_TXFREE_INFO_MSDU_ID;
+			if (msdu == MT_TXFREE_INFO_MSDU_ID)
+				continue;
+
+			count++;
+			txwi = mt76_token_release(mdev, msdu, &wake);
+			if (!txwi)
+				continue;
+
+			mt7996_txwi_free(dev, txwi, sta, &free_list);
+		}
+	}
+
+	mt7996_mac_sta_poll(dev);
+
+	if (wake)
+		mt76_set_tx_blocked(&dev->mt76, false);
+
+	mt76_worker_schedule(&dev->mt76.tx_worker);
+
+	list_for_each_entry_safe(skb, tmp, &free_list, list) {
+		skb_list_del_init(skb);
+		napi_consume_skb(skb, 1);
+	}
+}
+
+static bool
+mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid, int pid,
+		       __le32 *txs_data, struct mt76_sta_stats *stats)
+{
+	struct ieee80211_supported_band *sband;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_phy *mphy;
+	struct ieee80211_tx_info *info;
+	struct sk_buff_head list;
+	struct rate_info rate = {};
+	struct sk_buff *skb;
+	bool cck = false;
+	u32 txrate, txs, mode, stbc;
+
+	mt76_tx_status_lock(mdev, &list);
+	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
+	if (!skb)
+		goto out_no_skb;
+
+	txs = le32_to_cpu(txs_data[0]);
+
+	info = IEEE80211_SKB_CB(skb);
+	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
+		info->flags |= IEEE80211_TX_STAT_ACK;
+
+	info->status.ampdu_len = 1;
+	info->status.ampdu_ack_len = !!(info->flags &
+					IEEE80211_TX_STAT_ACK);
+
+	info->status.rates[0].idx = -1;
+
+	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
+
+	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
+	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
+	stbc = le32_get_bits(txs_data[3], MT_TXS3_RATE_STBC);
+
+	if (stbc && rate.nss > 1)
+		rate.nss >>= 1;
+
+	if (rate.nss - 1 < ARRAY_SIZE(stats->tx_nss))
+		stats->tx_nss[rate.nss - 1]++;
+	if (rate.mcs < ARRAY_SIZE(stats->tx_mcs))
+		stats->tx_mcs[rate.mcs]++;
+
+	mode = FIELD_GET(MT_TX_RATE_MODE, txrate);
+	switch (mode) {
+	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
+	case MT_PHY_TYPE_OFDM:
+		mphy = mt76_dev_phy(mdev, wcid->phy_idx);
+
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else if (mphy->chandef.chan->band == NL80211_BAND_6GHZ)
+			sband = &mphy->sband_6g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
+		rate.legacy = sband->bitrates[rate.mcs].bitrate;
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+		if (rate.mcs > 31)
+			goto out;
+
+		rate.flags = RATE_INFO_FLAGS_MCS;
+		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
+			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_VHT:
+		if (rate.mcs > 9)
+			goto out;
+
+		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		break;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+	case MT_PHY_TYPE_HE_MU:
+		if (rate.mcs > 11)
+			goto out;
+
+		rate.he_gi = wcid->rate.he_gi;
+		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
+		rate.flags = RATE_INFO_FLAGS_HE_MCS;
+		break;
+	default:
+		goto out;
+	}
+
+	stats->tx_mode[mode]++;
+
+	switch (FIELD_GET(MT_TXS0_BW, txs)) {
+	case IEEE80211_STA_RX_BW_160:
+		rate.bw = RATE_INFO_BW_160;
+		stats->tx_bw[3]++;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		rate.bw = RATE_INFO_BW_80;
+		stats->tx_bw[2]++;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		rate.bw = RATE_INFO_BW_40;
+		stats->tx_bw[1]++;
+		break;
+	default:
+		rate.bw = RATE_INFO_BW_20;
+		stats->tx_bw[0]++;
+		break;
+	}
+	wcid->rate = rate;
+
+out:
+	mt76_tx_status_skb_done(mdev, skb, &list);
+
+out_no_skb:
+	mt76_tx_status_unlock(mdev, &list);
+
+	return !!skb;
+}
+
+static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
+{
+	struct mt7996_sta *msta = NULL;
+	struct mt76_wcid *wcid;
+	__le32 *txs_data = data;
+	u16 wcidx;
+	u8 pid;
+
+	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) > 1)
+		return;
+
+	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
+
+	if (pid < MT_PACKET_ID_FIRST)
+		return;
+
+	if (wcidx >= MT7996_WTBL_SIZE)
+		return;
+
+	rcu_read_lock();
+
+	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	if (!wcid)
+		goto out;
+
+	msta = container_of(wcid, struct mt7996_sta, wcid);
+
+	mt7996_mac_add_txs_skb(dev, wcid, pid, txs_data, &msta->stats);
+
+	if (!wcid->sta)
+		goto out;
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (list_empty(&msta->poll_list))
+		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
+out:
+	rcu_read_unlock();
+}
+
+bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	__le32 *rxd = (__le32 *)data;
+	__le32 *end = (__le32 *)&rxd[len / 4];
+	enum rx_pkt_type type;
+
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+	if (type != PKT_TYPE_NORMAL) {
+		u32 sw_type = le32_get_bits(rxd[0], MT_RXD0_SW_PKT_TYPE_MASK);
+
+		if (unlikely((sw_type & MT_RXD0_SW_PKT_TYPE_MAP) ==
+			     MT_RXD0_SW_PKT_TYPE_FRAME))
+			return true;
+	}
+
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		mt7996_mac_tx_free(dev, data, len);
+		return false;
+	case PKT_TYPE_TXS:
+		for (rxd += 4; rxd + 8 <= end; rxd += 8)
+			mt7996_mac_add_txs(dev, rxd);
+		return false;
+	case PKT_TYPE_RX_FW_MONITOR:
+		mt7996_debugfs_rx_fw_monitor(dev, data, len);
+		return false;
+	default:
+		return true;
+	}
+}
+
+void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	__le32 *rxd = (__le32 *)skb->data;
+	__le32 *end = (__le32 *)&skb->data[skb->len];
+	enum rx_pkt_type type;
+
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+	if (type != PKT_TYPE_NORMAL) {
+		u32 sw_type = le32_get_bits(rxd[0], MT_RXD0_SW_PKT_TYPE_MASK);
+
+		if (unlikely((sw_type & MT_RXD0_SW_PKT_TYPE_MAP) ==
+			     MT_RXD0_SW_PKT_TYPE_FRAME))
+			type = PKT_TYPE_NORMAL;
+	}
+
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		mt7996_mac_tx_free(dev, skb->data, skb->len);
+		napi_consume_skb(skb, 1);
+		break;
+	case PKT_TYPE_RX_EVENT:
+		mt7996_mcu_rx_event(dev, skb);
+		break;
+	case PKT_TYPE_TXS:
+		for (rxd += 4; rxd + 8 <= end; rxd += 8)
+			mt7996_mac_add_txs(dev, rxd);
+		dev_kfree_skb(skb);
+		break;
+	case PKT_TYPE_RX_FW_MONITOR:
+		mt7996_debugfs_rx_fw_monitor(dev, skb->data, skb->len);
+		dev_kfree_skb(skb);
+		break;
+	case PKT_TYPE_NORMAL:
+		if (!mt7996_mac_fill_rx(dev, skb)) {
+			mt76_rx(&dev->mt76, q, skb);
+			return;
+		}
+		fallthrough;
+	default:
+		dev_kfree_skb(skb);
+		break;
+	}
+}
+
+void mt7996_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
+{
+	if (!e->txwi) {
+		dev_kfree_skb_any(e->skb);
+		return;
+	}
+
+	/* error path */
+	if (e->skb == DMA_DUMMY_DATA) {
+		struct mt76_txwi_cache *t;
+		struct mt7996_txp *txp;
+
+		txp = mt7996_txwi_to_txp(mdev, e->txwi);
+		t = mt76_token_put(mdev, le16_to_cpu(txp->token));
+		e->skb = t ? t->skb : NULL;
+	}
+
+	if (e->skb)
+		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
+}
+
+void mt7996_mac_cca_stats_reset(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+	u32 reg = MT_WF_PHYRX_BAND_RX_CTRL1(phy->mt76->band_idx);
+
+	mt76_clear(dev, reg, MT_WF_PHYRX_BAND_RX_CTRL1_STSCNT_EN);
+	mt76_set(dev, reg, BIT(11) | BIT(9));
+}
+
+void mt7996_mac_reset_counters(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+	u8 band_idx = phy->mt76->band_idx;
+	int i;
+
+	for (i = 0; i < 16; i++)
+		mt76_rr(dev, MT_TX_AGG_CNT(band_idx, i));
+
+	phy->mt76->survey_time = ktime_get_boottime();
+
+	memset(phy->mt76->aggr_stats, 0, sizeof(phy->mt76->aggr_stats));
+
+	/* reset airtime counters */
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(band_idx),
+		 MT_WF_RMAC_MIB_RXTIME_CLR);
+
+	mt7996_mcu_get_chan_mib_info(phy, true);
+}
+
+void mt7996_mac_set_timing(struct mt7996_phy *phy)
+{
+	s16 coverage_class = phy->coverage_class;
+	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_phy *phy2 = mt7996_phy2(dev);
+	struct mt7996_phy *phy3 = mt7996_phy3(dev);
+	u32 val, reg_offset;
+	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
+		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
+	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
+		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
+	u8 band_idx = phy->mt76->band_idx;
+	int offset;
+	bool a_band = !(phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ);
+
+	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+		return;
+
+	if (phy2)
+		coverage_class = max_t(s16, dev->phy.coverage_class,
+				       phy2->coverage_class);
+
+	if (phy3)
+		coverage_class = max_t(s16, coverage_class,
+				       phy3->coverage_class);
+
+	mt76_set(dev, MT_ARB_SCR(band_idx),
+		 MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
+	udelay(1);
+
+	offset = 3 * coverage_class;
+	reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
+		     FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
+
+	mt76_wr(dev, MT_TMAC_CDTR(band_idx), cck + reg_offset);
+	mt76_wr(dev, MT_TMAC_ODTR(band_idx), ofdm + reg_offset);
+	mt76_wr(dev, MT_TMAC_ICR0(band_idx),
+		FIELD_PREP(MT_IFS_EIFS_OFDM, a_band ? 84 : 78) |
+		FIELD_PREP(MT_IFS_RIFS, 2) |
+		FIELD_PREP(MT_IFS_SIFS, 10) |
+		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
+
+	if (!a_band)
+		mt76_wr(dev, MT_TMAC_ICR1(band_idx),
+			FIELD_PREP(MT_IFS_EIFS_CCK, 314));
+
+	if (phy->slottime < 20 || a_band)
+		val = MT7996_CFEND_RATE_DEFAULT;
+	else
+		val = MT7996_CFEND_RATE_11B;
+
+	mt76_rmw_field(dev, MT_AGG_ACR0(band_idx), MT_AGG_ACR_CFEND_RATE, val);
+	mt76_clear(dev, MT_ARB_SCR(band_idx),
+		   MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
+}
+
+void mt7996_mac_enable_nf(struct mt7996_dev *dev, u8 band)
+{
+	mt76_set(dev, MT_WF_PHYRX_CSD_BAND_RXTD12(band),
+		 MT_WF_PHYRX_CSD_BAND_RXTD12_IRPI_SW_CLR_ONLY |
+		 MT_WF_PHYRX_CSD_BAND_RXTD12_IRPI_SW_CLR);
+
+	mt76_set(dev, MT_WF_PHYRX_BAND_RX_CTRL1(band),
+		 FIELD_PREP(MT_WF_PHYRX_BAND_RX_CTRL1_IPI_EN, 0x5));
+}
+
+static u8
+mt7996_phy_get_nf(struct mt7996_phy *phy, u8 band_idx)
+{
+	static const u8 nf_power[] = { 92, 89, 86, 83, 80, 75, 70, 65, 60, 55, 52 };
+	struct mt7996_dev *dev = phy->dev;
+	u32 val, sum = 0, n = 0;
+	int ant, i;
+
+	for (ant = 0; ant < hweight8(phy->mt76->antenna_mask); ant++) {
+		u32 reg = MT_WF_PHYRX_CSD_IRPI(band_idx, ant);
+
+		for (i = 0; i < ARRAY_SIZE(nf_power); i++, reg += 4) {
+			val = mt76_rr(dev, reg);
+			sum += val * nf_power[i];
+			n += val;
+		}
+	}
+
+	return n ? sum / n : 0;
+}
+
+void mt7996_update_channel(struct mt76_phy *mphy)
+{
+	struct mt7996_phy *phy = (struct mt7996_phy *)mphy->priv;
+	struct mt76_channel_state *state = mphy->chan_state;
+	int nf;
+
+	mt7996_mcu_get_chan_mib_info(phy, false);
+
+	nf = mt7996_phy_get_nf(phy, mphy->band_idx);
+	if (!phy->noise)
+		phy->noise = nf << 4;
+	else if (nf)
+		phy->noise += nf - (phy->noise >> 4);
+
+	state->noise = -(phy->noise >> 4);
+}
+
+static bool
+mt7996_wait_reset_state(struct mt7996_dev *dev, u32 state)
+{
+	bool ret;
+
+	ret = wait_event_timeout(dev->reset_wait,
+				 (READ_ONCE(dev->reset_state) & state),
+				 MT7996_RESET_TIMEOUT);
+
+	WARN(!ret, "Timeout waiting for MCU reset state %x\n", state);
+	return ret;
+}
+
+static void
+mt7996_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct ieee80211_hw *hw = priv;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_AP:
+		mt7996_mcu_add_beacon(hw, vif, vif->bss_conf.enable_beacon);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+mt7996_update_beacons(struct mt7996_dev *dev)
+{
+	struct mt76_phy *phy2, *phy3;
+
+	ieee80211_iterate_active_interfaces(dev->mt76.hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7996_update_vif_beacon, dev->mt76.hw);
+
+	phy2 = dev->mt76.phys[MT_BAND1];
+	if (!phy2)
+		return;
+
+	ieee80211_iterate_active_interfaces(phy2->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7996_update_vif_beacon, phy2->hw);
+
+	phy3 = dev->mt76.phys[MT_BAND2];
+	if (!phy3)
+		return;
+
+	ieee80211_iterate_active_interfaces(phy3->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7996_update_vif_beacon, phy3->hw);
+}
+
+static void
+mt7996_dma_reset(struct mt7996_dev *dev)
+{
+	struct mt76_phy *phy2 = dev->mt76.phys[MT_BAND1];
+	struct mt76_phy *phy3 = dev->mt76.phys[MT_BAND2];
+	u32 hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+	int i;
+
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	if (dev->hif2)
+		mt76_clear(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+			   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			   MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	usleep_range(1000, 2000);
+
+	for (i = 0; i < __MT_TXQ_MAX; i++) {
+		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
+		if (phy2)
+			mt76_queue_tx_cleanup(dev, phy2->q_tx[i], true);
+		if (phy3)
+			mt76_queue_tx_cleanup(dev, phy3->q_tx[i], true);
+	}
+
+	for (i = 0; i < __MT_MCUQ_MAX; i++)
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_rx_reset(dev, i);
+
+	mt76_tx_status_check(&dev->mt76, true);
+
+	/* re-init prefetch settings after reset */
+	mt7996_dma_prefetch(dev);
+
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	if (dev->hif2)
+		mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+			 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			 MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+}
+
+void mt7996_tx_token_put(struct mt7996_dev *dev)
+{
+	struct mt76_txwi_cache *txwi;
+	int id;
+
+	spin_lock_bh(&dev->mt76.token_lock);
+	idr_for_each_entry(&dev->mt76.token, txwi, id) {
+		mt7996_txwi_free(dev, txwi, NULL, NULL);
+		dev->mt76.token_count--;
+	}
+	spin_unlock_bh(&dev->mt76.token_lock);
+	idr_destroy(&dev->mt76.token);
+}
+
+/* system error recovery */
+void mt7996_mac_reset_work(struct work_struct *work)
+{
+	struct mt7996_phy *phy2, *phy3;
+	struct mt7996_dev *dev;
+	int i;
+
+	dev = container_of(work, struct mt7996_dev, reset_work);
+	phy2 = mt7996_phy2(dev);
+	phy3 = mt7996_phy3(dev);
+
+	if (!(READ_ONCE(dev->reset_state) & MT_MCU_CMD_STOP_DMA))
+		return;
+
+	ieee80211_stop_queues(mt76_hw(dev));
+	if (phy2)
+		ieee80211_stop_queues(phy2->mt76->hw);
+	if (phy3)
+		ieee80211_stop_queues(phy3->mt76->hw);
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
+	if (phy2) {
+		set_bit(MT76_RESET, &phy2->mt76->state);
+		cancel_delayed_work_sync(&phy2->mt76->mac_work);
+	}
+	if (phy3) {
+		set_bit(MT76_RESET, &phy3->mt76->state);
+		cancel_delayed_work_sync(&phy3->mt76->mac_work);
+	}
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	mt76_for_each_q_rx(&dev->mt76, i)
+		napi_disable(&dev->mt76.napi[i]);
+	napi_disable(&dev->mt76.tx_napi);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
+
+	if (mt7996_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
+		mt7996_dma_reset(dev);
+
+		mt7996_tx_token_put(dev);
+		idr_init(&dev->mt76.token);
+
+		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_INIT);
+		mt7996_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
+	}
+
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
+	if (phy2)
+		clear_bit(MT76_RESET, &phy2->mt76->state);
+	if (phy3)
+		clear_bit(MT76_RESET, &phy3->mt76->state);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		napi_enable(&dev->mt76.napi[i]);
+		napi_schedule(&dev->mt76.napi[i]);
+	}
+	local_bh_enable();
+
+	tasklet_schedule(&dev->irq_tasklet);
+
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
+	mt7996_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	local_bh_disable();
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+	local_bh_enable();
+
+	ieee80211_wake_queues(mt76_hw(dev));
+	if (phy2)
+		ieee80211_wake_queues(phy2->mt76->hw);
+	if (phy3)
+		ieee80211_wake_queues(phy3->mt76->hw);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	mt7996_update_beacons(dev);
+
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
+				     MT7996_WATCHDOG_TIME);
+	if (phy2)
+		ieee80211_queue_delayed_work(phy2->mt76->hw,
+					     &phy2->mt76->mac_work,
+					     MT7996_WATCHDOG_TIME);
+	if (phy3)
+		ieee80211_queue_delayed_work(phy3->mt76->hw,
+					     &phy3->mt76->mac_work,
+					     MT7996_WATCHDOG_TIME);
+}
+
+void mt7996_mac_update_stats(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct mib_stats *mib = &phy->mib;
+	u8 band_idx = phy->mt76->band_idx;
+	u32 cnt;
+	int i;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR1(band_idx));
+	mib->fcs_err_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR33(band_idx));
+	mib->rx_fifo_full_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR31(band_idx));
+	mib->rx_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_SDR6(band_idx));
+	mib->channel_idle_cnt += FIELD_GET(MT_MIB_SDR6_CHANNEL_IDL_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_RVSR0(band_idx));
+	mib->rx_vector_mismatch_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR35(band_idx));
+	mib->rx_delimiter_fail_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR36(band_idx));
+	mib->rx_len_mismatch_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR0(band_idx));
+	mib->tx_ampdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR2(band_idx));
+	mib->tx_stop_q_empty_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR3(band_idx));
+	mib->tx_mpdu_attempts_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR4(band_idx));
+	mib->tx_mpdu_success_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR27(band_idx));
+	mib->rx_ampdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR28(band_idx));
+	mib->rx_ampdu_bytes_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR29(band_idx));
+	mib->rx_ampdu_valid_subframe_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR30(band_idx));
+	mib->rx_ampdu_valid_subframe_bytes_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_SDR27(band_idx));
+	mib->tx_rwp_fail_cnt += FIELD_GET(MT_MIB_SDR27_TX_RWP_FAIL_CNT, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR28(band_idx));
+	mib->tx_rwp_need_cnt += FIELD_GET(MT_MIB_SDR28_TX_RWP_NEED_CNT, cnt);
+
+	cnt = mt76_rr(dev, MT_UMIB_RPDCR(band_idx));
+	mib->rx_pfdrop_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RVSR1(band_idx));
+	mib->rx_vec_queue_overflow_drop_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR1(band_idx));
+	mib->rx_ba_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR0(band_idx));
+	mib->tx_bf_ebf_ppdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR1(band_idx));
+	mib->tx_bf_ibf_ppdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR2(band_idx));
+	mib->tx_mu_bf_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR5(band_idx));
+	mib->tx_mu_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR6(band_idx));
+	mib->tx_mu_acked_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR7(band_idx));
+	mib->tx_su_acked_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR3(band_idx));
+	mib->tx_bf_rx_fb_ht_cnt += cnt;
+	mib->tx_bf_rx_fb_all_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR4(band_idx));
+	mib->tx_bf_rx_fb_vht_cnt += cnt;
+	mib->tx_bf_rx_fb_all_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR5(band_idx));
+	mib->tx_bf_rx_fb_he_cnt += cnt;
+	mib->tx_bf_rx_fb_all_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR6(band_idx));
+	mib->tx_bf_rx_fb_eht_cnt += cnt;
+	mib->tx_bf_rx_fb_all_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CONT(band_idx));
+	mib->tx_bf_rx_fb_bw = FIELD_GET(MT_ETBF_RX_FB_BW, cnt);
+	mib->tx_bf_rx_fb_nc_cnt += FIELD_GET(MT_ETBF_RX_FB_NC, cnt);
+	mib->tx_bf_rx_fb_nr_cnt += FIELD_GET(MT_ETBF_RX_FB_NR, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR7(band_idx));
+	mib->tx_bf_fb_trig_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR17(band_idx));
+	mib->tx_bf_fb_cpl_cnt += cnt;
+
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++) {
+		cnt = mt76_rr(dev, MT_PLE_AMSDU_PACK_MSDU_CNT(i));
+		mib->tx_amsdu[i] += cnt;
+		mib->tx_amsdu_cnt += cnt;
+	}
+
+	/* rts count */
+	cnt = mt76_rr(dev, MT_MIB_BTSCR5(band_idx));
+	mib->rts_cnt += cnt;
+
+	/* rts retry count */
+	cnt = mt76_rr(dev, MT_MIB_BTSCR6(band_idx));
+	mib->rts_retries_cnt += cnt;
+
+	/* ba miss count */
+	cnt = mt76_rr(dev, MT_MIB_BTSCR0(band_idx));
+	mib->ba_miss_cnt += cnt;
+
+	/* ack fail count */
+	cnt = mt76_rr(dev, MT_MIB_BFTFCR(band_idx));
+	mib->ack_fail_cnt += cnt;
+
+	for (i = 0; i < 16; i++) {
+		cnt = mt76_rr(dev, MT_TX_AGG_CNT(band_idx, i));
+		phy->mt76->aggr_stats[i] += cnt;
+	}
+}
+
+void mt7996_mac_sta_rc_work(struct work_struct *work)
+{
+	struct mt7996_dev *dev = container_of(work, struct mt7996_dev, rc_work);
+	struct ieee80211_sta *sta;
+	struct ieee80211_vif *vif;
+	struct mt7996_sta *msta;
+	u32 changed;
+	LIST_HEAD(list);
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&dev->sta_rc_list, &list);
+
+	while (!list_empty(&list)) {
+		msta = list_first_entry(&list, struct mt7996_sta, rc_list);
+		list_del_init(&msta->rc_list);
+		changed = msta->changed;
+		msta->changed = 0;
+		spin_unlock_bh(&dev->sta_poll_lock);
+
+		sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
+		vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
+
+		if (changed & (IEEE80211_RC_SUPP_RATES_CHANGED |
+			       IEEE80211_RC_NSS_CHANGED |
+			       IEEE80211_RC_BW_CHANGED))
+			mt7996_mcu_add_rate_ctrl(dev, vif, sta, true);
+
+		/* TODO: smps change */
+
+		spin_lock_bh(&dev->sta_poll_lock);
+	}
+
+	spin_unlock_bh(&dev->sta_poll_lock);
+}
+
+void mt7996_mac_work(struct work_struct *work)
+{
+	struct mt7996_phy *phy;
+	struct mt76_phy *mphy;
+
+	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
+					       mac_work.work);
+	phy = mphy->priv;
+
+	mutex_lock(&mphy->dev->mutex);
+
+	mt76_update_survey(mphy);
+	if (++mphy->mac_work_count == 5) {
+		mphy->mac_work_count = 0;
+
+		mt7996_mac_update_stats(phy);
+	}
+
+	mutex_unlock(&mphy->dev->mutex);
+
+	mt76_tx_status_check(mphy->dev, false);
+
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+				     MT7996_WATCHDOG_TIME);
+}
+
+static void mt7996_dfs_stop_radar_detector(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+
+	if (phy->rdd_state & BIT(0))
+		mt7996_mcu_rdd_cmd(dev, RDD_STOP, 0,
+				   MT_RX_SEL0, 0);
+	if (phy->rdd_state & BIT(1))
+		mt7996_mcu_rdd_cmd(dev, RDD_STOP, 1,
+				   MT_RX_SEL0, 0);
+}
+
+static int mt7996_dfs_start_rdd(struct mt7996_dev *dev, int chain)
+{
+	int err, region;
+
+	switch (dev->mt76.region) {
+	case NL80211_DFS_ETSI:
+		region = 0;
+		break;
+	case NL80211_DFS_JP:
+		region = 2;
+		break;
+	case NL80211_DFS_FCC:
+	default:
+		region = 1;
+		break;
+	}
+
+	err = mt7996_mcu_rdd_cmd(dev, RDD_START, chain,
+				 MT_RX_SEL0, region);
+	if (err < 0)
+		return err;
+
+	return mt7996_mcu_rdd_cmd(dev, RDD_DET_MODE, chain,
+				 MT_RX_SEL0, 1);
+}
+
+static int mt7996_dfs_start_radar_detector(struct mt7996_phy *phy)
+{
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	struct mt7996_dev *dev = phy->dev;
+	u8 band_idx = phy->mt76->band_idx;
+	int err;
+
+	/* start CAC */
+	err = mt7996_mcu_rdd_cmd(dev, RDD_CAC_START, band_idx,
+				 MT_RX_SEL0, 0);
+	if (err < 0)
+		return err;
+
+	err = mt7996_dfs_start_rdd(dev, band_idx);
+	if (err < 0)
+		return err;
+
+	phy->rdd_state |= BIT(band_idx);
+
+	if (chandef->width == NL80211_CHAN_WIDTH_160 ||
+	    chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		err = mt7996_dfs_start_rdd(dev, 1);
+		if (err < 0)
+			return err;
+
+		phy->rdd_state |= BIT(1);
+	}
+
+	return 0;
+}
+
+static int
+mt7996_dfs_init_radar_specs(struct mt7996_phy *phy)
+{
+	const struct mt7996_dfs_radar_spec *radar_specs;
+	struct mt7996_dev *dev = phy->dev;
+	int err, i;
+
+	switch (dev->mt76.region) {
+	case NL80211_DFS_FCC:
+		radar_specs = &fcc_radar_specs;
+		err = mt7996_mcu_set_fcc5_lpn(dev, 8);
+		if (err < 0)
+			return err;
+		break;
+	case NL80211_DFS_ETSI:
+		radar_specs = &etsi_radar_specs;
+		break;
+	case NL80211_DFS_JP:
+		radar_specs = &jp_radar_specs;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(radar_specs->radar_pattern); i++) {
+		err = mt7996_mcu_set_radar_th(dev, i,
+					      &radar_specs->radar_pattern[i]);
+		if (err < 0)
+			return err;
+	}
+
+	return mt7996_mcu_set_pulse_th(dev, &radar_specs->pulse_th);
+}
+
+int mt7996_dfs_init_radar_detector(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+	enum mt76_dfs_state dfs_state, prev_state;
+	int err;
+
+	prev_state = phy->mt76->dfs_state;
+	dfs_state = mt76_phy_dfs_state(phy->mt76);
+
+	if (prev_state == dfs_state)
+		return 0;
+
+	if (prev_state == MT_DFS_STATE_UNKNOWN)
+		mt7996_dfs_stop_radar_detector(phy);
+
+	if (dfs_state == MT_DFS_STATE_DISABLED)
+		goto stop;
+
+	if (prev_state <= MT_DFS_STATE_DISABLED) {
+		err = mt7996_dfs_init_radar_specs(phy);
+		if (err < 0)
+			return err;
+
+		err = mt7996_dfs_start_radar_detector(phy);
+		if (err < 0)
+			return err;
+
+		phy->mt76->dfs_state = MT_DFS_STATE_CAC;
+	}
+
+	if (dfs_state == MT_DFS_STATE_CAC)
+		return 0;
+
+	err = mt7996_mcu_rdd_cmd(dev, RDD_CAC_END,
+				 phy->mt76->band_idx, MT_RX_SEL0, 0);
+	if (err < 0) {
+		phy->mt76->dfs_state = MT_DFS_STATE_UNKNOWN;
+		return err;
+	}
+
+	phy->mt76->dfs_state = MT_DFS_STATE_ACTIVE;
+	return 0;
+
+stop:
+	err = mt7996_mcu_rdd_cmd(dev, RDD_NORMAL_START,
+				 phy->mt76->band_idx, MT_RX_SEL0, 0);
+	if (err < 0)
+		return err;
+
+	mt7996_dfs_stop_radar_detector(phy);
+	phy->mt76->dfs_state = MT_DFS_STATE_DISABLED;
+
+	return 0;
+}
+
+static int
+mt7996_mac_twt_duration_align(int duration)
+{
+	return duration << 8;
+}
+
+static u64
+mt7996_mac_twt_sched_list_add(struct mt7996_dev *dev,
+			      struct mt7996_twt_flow *flow)
+{
+	struct mt7996_twt_flow *iter, *iter_next;
+	u32 duration = flow->duration << 8;
+	u64 start_tsf;
+
+	iter = list_first_entry_or_null(&dev->twt_list,
+					struct mt7996_twt_flow, list);
+	if (!iter || !iter->sched || iter->start_tsf > duration) {
+		/* add flow as first entry in the list */
+		list_add(&flow->list, &dev->twt_list);
+		return 0;
+	}
+
+	list_for_each_entry_safe(iter, iter_next, &dev->twt_list, list) {
+		start_tsf = iter->start_tsf +
+			    mt7996_mac_twt_duration_align(iter->duration);
+		if (list_is_last(&iter->list, &dev->twt_list))
+			break;
+
+		if (!iter_next->sched ||
+		    iter_next->start_tsf > start_tsf + duration) {
+			list_add(&flow->list, &iter->list);
+			goto out;
+		}
+	}
+
+	/* add flow as last entry in the list */
+	list_add_tail(&flow->list, &dev->twt_list);
+out:
+	return start_tsf;
+}
+
+static int mt7996_mac_check_twt_req(struct ieee80211_twt_setup *twt)
+{
+	struct ieee80211_twt_params *twt_agrt;
+	u64 interval, duration;
+	u16 mantissa;
+	u8 exp;
+
+	/* only individual agreement supported */
+	if (twt->control & IEEE80211_TWT_CONTROL_NEG_TYPE_BROADCAST)
+		return -EOPNOTSUPP;
+
+	/* only 256us unit supported */
+	if (twt->control & IEEE80211_TWT_CONTROL_WAKE_DUR_UNIT)
+		return -EOPNOTSUPP;
+
+	twt_agrt = (struct ieee80211_twt_params *)twt->params;
+
+	/* explicit agreement not supported */
+	if (!(twt_agrt->req_type & cpu_to_le16(IEEE80211_TWT_REQTYPE_IMPLICIT)))
+		return -EOPNOTSUPP;
+
+	exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP,
+			le16_to_cpu(twt_agrt->req_type));
+	mantissa = le16_to_cpu(twt_agrt->mantissa);
+	duration = twt_agrt->min_twt_dur << 8;
+
+	interval = (u64)mantissa << exp;
+	if (interval < duration)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_twt_setup *twt)
+{
+	enum ieee80211_twt_setup_cmd setup_cmd = TWT_SETUP_CMD_REJECT;
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct ieee80211_twt_params *twt_agrt = (void *)twt->params;
+	u16 req_type = le16_to_cpu(twt_agrt->req_type);
+	enum ieee80211_twt_setup_cmd sta_setup_cmd;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_twt_flow *flow;
+	int flowid, table_id;
+	u8 exp;
+
+	if (mt7996_mac_check_twt_req(twt))
+		goto out;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (dev->twt.n_agrt == MT7996_MAX_TWT_AGRT)
+		goto unlock;
+
+	if (hweight8(msta->twt.flowid_mask) == ARRAY_SIZE(msta->twt.flow))
+		goto unlock;
+
+	flowid = ffs(~msta->twt.flowid_mask) - 1;
+	le16p_replace_bits(&twt_agrt->req_type, flowid,
+			   IEEE80211_TWT_REQTYPE_FLOWID);
+
+	table_id = ffs(~dev->twt.table_mask) - 1;
+	exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP, req_type);
+	sta_setup_cmd = FIELD_GET(IEEE80211_TWT_REQTYPE_SETUP_CMD, req_type);
+
+	flow = &msta->twt.flow[flowid];
+	memset(flow, 0, sizeof(*flow));
+	INIT_LIST_HEAD(&flow->list);
+	flow->wcid = msta->wcid.idx;
+	flow->table_id = table_id;
+	flow->id = flowid;
+	flow->duration = twt_agrt->min_twt_dur;
+	flow->mantissa = twt_agrt->mantissa;
+	flow->exp = exp;
+	flow->protection = !!(req_type & IEEE80211_TWT_REQTYPE_PROTECTION);
+	flow->flowtype = !!(req_type & IEEE80211_TWT_REQTYPE_FLOWTYPE);
+	flow->trigger = !!(req_type & IEEE80211_TWT_REQTYPE_TRIGGER);
+
+	if (sta_setup_cmd == TWT_SETUP_CMD_REQUEST ||
+	    sta_setup_cmd == TWT_SETUP_CMD_SUGGEST) {
+		u64 interval = (u64)le16_to_cpu(twt_agrt->mantissa) << exp;
+		u64 flow_tsf, curr_tsf;
+		u32 rem;
+
+		flow->sched = true;
+		flow->start_tsf = mt7996_mac_twt_sched_list_add(dev, flow);
+		curr_tsf = __mt7996_get_tsf(hw, msta->vif);
+		div_u64_rem(curr_tsf - flow->start_tsf, interval, &rem);
+		flow_tsf = curr_tsf + interval - rem;
+		twt_agrt->twt = cpu_to_le64(flow_tsf);
+	} else {
+		list_add_tail(&flow->list, &dev->twt_list);
+	}
+	flow->tsf = le64_to_cpu(twt_agrt->twt);
+
+	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow, MCU_TWT_AGRT_ADD))
+		goto unlock;
+
+	setup_cmd = TWT_SETUP_CMD_ACCEPT;
+	dev->twt.table_mask |= BIT(table_id);
+	msta->twt.flowid_mask |= BIT(flowid);
+	dev->twt.n_agrt++;
+
+unlock:
+	mutex_unlock(&dev->mt76.mutex);
+out:
+	le16p_replace_bits(&twt_agrt->req_type, setup_cmd,
+			   IEEE80211_TWT_REQTYPE_SETUP_CMD);
+	twt->control = (twt->control & IEEE80211_TWT_CONTROL_WAKE_DUR_UNIT) |
+		       (twt->control & IEEE80211_TWT_CONTROL_RX_DISABLED);
+}
+
+void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
+				  struct mt7996_sta *msta,
+				  u8 flowid)
+{
+	struct mt7996_twt_flow *flow;
+
+	lockdep_assert_held(&dev->mt76.mutex);
+
+	if (flowid >= ARRAY_SIZE(msta->twt.flow))
+		return;
+
+	if (!(msta->twt.flowid_mask & BIT(flowid)))
+		return;
+
+	flow = &msta->twt.flow[flowid];
+	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow,
+				       MCU_TWT_AGRT_DELETE))
+		return;
+
+	list_del_init(&flow->list);
+	msta->twt.flowid_mask &= ~BIT(flowid);
+	dev->twt.table_mask &= ~BIT(flow->table_id);
+	dev->twt.n_agrt--;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
new file mode 100644
index 000000000000..9f68852012b9
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
@@ -0,0 +1,398 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#ifndef __MT7996_MAC_H
+#define __MT7996_MAC_H
+
+#define MT_CT_PARSE_LEN			72
+#define MT_CT_DMA_BUF_NUM		2
+
+#define MT_RXD0_LENGTH			GENMASK(15, 0)
+#define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
+
+#define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
+#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
+#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
+
+#define MT_RXD0_SW_PKT_TYPE_MASK	GENMASK(31, 16)
+#define MT_RXD0_SW_PKT_TYPE_MAP		0x380F
+#define MT_RXD0_SW_PKT_TYPE_FRAME	0x3801
+
+enum rx_pkt_type {
+	PKT_TYPE_TXS,
+	PKT_TYPE_TXRXV,
+	PKT_TYPE_NORMAL,
+	PKT_TYPE_RX_DUP_RFB,
+	PKT_TYPE_RX_TMR,
+	PKT_TYPE_RETRIEVE,
+	PKT_TYPE_TXRX_NOTIFY,
+	PKT_TYPE_RX_EVENT,
+	PKT_TYPE_RX_FW_MONITOR = 0x0c,
+};
+
+/* RXD DW1 */
+#define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(11, 0)
+#define MT_RXD1_NORMAL_GROUP_1		BIT(16)
+#define MT_RXD1_NORMAL_GROUP_2		BIT(17)
+#define MT_RXD1_NORMAL_GROUP_3		BIT(18)
+#define MT_RXD1_NORMAL_GROUP_4		BIT(19)
+#define MT_RXD1_NORMAL_GROUP_5		BIT(20)
+#define MT_RXD1_NORMAL_KEY_ID		GENMASK(22, 21)
+#define MT_RXD1_NORMAL_CM		BIT(23)
+#define MT_RXD1_NORMAL_CLM		BIT(24)
+#define MT_RXD1_NORMAL_ICV_ERR		BIT(25)
+#define MT_RXD1_NORMAL_TKIP_MIC_ERR	BIT(26)
+#define MT_RXD1_NORMAL_BAND_IDX		GENMASK(28, 27)
+#define MT_RXD1_NORMAL_SPP_EN		BIT(29)
+#define MT_RXD1_NORMAL_ADD_OM		BIT(30)
+#define MT_RXD1_NORMAL_SEC_DONE		BIT(31)
+
+/* RXD DW2 */
+#define MT_RXD2_NORMAL_BSSID		GENMASK(5, 0)
+#define MT_RXD2_NORMAL_MAC_HDR_LEN	GENMASK(12, 8)
+#define MT_RXD2_NORMAL_HDR_TRANS	BIT(7)
+#define MT_RXD2_NORMAL_HDR_OFFSET	GENMASK(15, 13)
+#define MT_RXD2_NORMAL_SEC_MODE		GENMASK(20, 16)
+#define MT_RXD2_NORMAL_MU_BAR		BIT(21)
+#define MT_RXD2_NORMAL_SW_BIT		BIT(22)
+#define MT_RXD2_NORMAL_AMSDU_ERR	BIT(23)
+#define MT_RXD2_NORMAL_MAX_LEN_ERROR	BIT(24)
+#define MT_RXD2_NORMAL_HDR_TRANS_ERROR	BIT(25)
+#define MT_RXD2_NORMAL_INT_FRAME	BIT(26)
+#define MT_RXD2_NORMAL_FRAG		BIT(27)
+#define MT_RXD2_NORMAL_NULL_FRAME	BIT(28)
+#define MT_RXD2_NORMAL_NDATA		BIT(29)
+#define MT_RXD2_NORMAL_NON_AMPDU	BIT(30)
+#define MT_RXD2_NORMAL_BF_REPORT	BIT(31)
+
+/* RXD DW3 */
+#define MT_RXD3_NORMAL_RXV_SEQ		GENMASK(7, 0)
+#define MT_RXD3_NORMAL_CH_FREQ		GENMASK(15, 8)
+#define MT_RXD3_NORMAL_ADDR_TYPE	GENMASK(17, 16)
+#define MT_RXD3_NORMAL_U2M		BIT(0)
+#define MT_RXD3_NORMAL_HTC_VLD		BIT(18)
+#define MT_RXD3_NORMAL_BEACON_MC	BIT(20)
+#define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
+#define MT_RXD3_NORMAL_CO_ANT		BIT(22)
+#define MT_RXD3_NORMAL_FCS_ERR		BIT(24)
+#define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
+
+/* RXD DW4 */
+#define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
+#define MT_RXD4_FIRST_AMSDU_FRAME	GENMASK(1, 0)
+#define MT_RXD4_MID_AMSDU_FRAME		BIT(1)
+#define MT_RXD4_LAST_AMSDU_FRAME	BIT(0)
+
+#define MT_RXV_HDR_BAND_IDX		BIT(24)
+
+/* RXD GROUP4 */
+#define MT_RXD8_FRAME_CONTROL		GENMASK(15, 0)
+
+#define MT_RXD10_SEQ_CTRL		GENMASK(15, 0)
+#define MT_RXD10_QOS_CTL		GENMASK(31, 16)
+
+#define MT_RXD11_HT_CONTROL		GENMASK(31, 0)
+
+/* P-RXV */
+#define MT_PRXV_TX_RATE			GENMASK(6, 0)
+#define MT_PRXV_TX_DCM			BIT(4)
+#define MT_PRXV_TX_ER_SU_106T		BIT(5)
+#define MT_PRXV_NSTS			GENMASK(10, 7)
+#define MT_PRXV_TXBF			BIT(11)
+#define MT_PRXV_HT_AD_CODE		BIT(12)
+#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
+#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
+#define MT_PRXV_RCPI3			GENMASK(31, 24)
+#define MT_PRXV_RCPI2			GENMASK(23, 16)
+#define MT_PRXV_RCPI1			GENMASK(15, 8)
+#define MT_PRXV_RCPI0			GENMASK(7, 0)
+#define MT_PRXV_HT_SHORT_GI		GENMASK(4, 3)
+#define MT_PRXV_HT_STBC			GENMASK(10, 9)
+#define MT_PRXV_TX_MODE			GENMASK(14, 11)
+#define MT_PRXV_FRAME_MODE		GENMASK(2, 0)
+#define MT_PRXV_DCM			BIT(5)
+#define MT_PRXV_NUM_RX			BIT(8, 6)
+
+/* C-RXV */
+#define MT_CRXV_HT_STBC			GENMASK(1, 0)
+#define MT_CRXV_TX_MODE			GENMASK(7, 4)
+#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
+#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
+#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
+#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
+#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
+#define MT_CRXV_HE_NUM_USER		GENMASK(30, 24)
+#define MT_CRXV_HE_UPLINK		BIT(31)
+#define MT_CRXV_HE_RU0			GENMASK(7, 0)
+#define MT_CRXV_HE_RU1			GENMASK(15, 8)
+#define MT_CRXV_HE_RU2			GENMASK(23, 16)
+#define MT_CRXV_HE_RU3			GENMASK(31, 24)
+
+#define MT_CRXV_HE_MU_AID		GENMASK(30, 20)
+
+#define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
+#define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
+#define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
+#define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
+
+#define MT_CRXV_HE_BSS_COLOR		GENMASK(5, 0)
+#define MT_CRXV_HE_TXOP_DUR		GENMASK(12, 6)
+#define MT_CRXV_HE_BEAM_CHNG		BIT(13)
+#define MT_CRXV_HE_DOPPLER		BIT(16)
+
+enum tx_header_format {
+	MT_HDR_FORMAT_802_3,
+	MT_HDR_FORMAT_CMD,
+	MT_HDR_FORMAT_802_11,
+	MT_HDR_FORMAT_802_11_EXT,
+};
+
+enum tx_pkt_type {
+	MT_TX_TYPE_CT,
+	MT_TX_TYPE_SF,
+	MT_TX_TYPE_CMD,
+	MT_TX_TYPE_FW,
+};
+
+enum tx_port_idx {
+	MT_TX_PORT_IDX_LMAC,
+	MT_TX_PORT_IDX_MCU
+};
+
+enum tx_mcu_port_q_idx {
+	MT_TX_MCU_PORT_RX_Q0 = 0x20,
+	MT_TX_MCU_PORT_RX_Q1,
+	MT_TX_MCU_PORT_RX_Q2,
+	MT_TX_MCU_PORT_RX_Q3,
+	MT_TX_MCU_PORT_RX_FWDL = 0x3e
+};
+
+enum tx_mgnt_type {
+	MT_TX_NORMAL,
+	MT_TX_TIMING,
+	MT_TX_ADDBA,
+};
+
+#define MT_CT_INFO_APPLY_TXD		BIT(0)
+#define MT_CT_INFO_COPY_HOST_TXD_ALL	BIT(1)
+#define MT_CT_INFO_MGMT_FRAME		BIT(2)
+#define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
+#define MT_CT_INFO_HSR2_TX		BIT(4)
+#define MT_CT_INFO_FROM_HOST		BIT(7)
+
+#define MT_TXD_SIZE			(8 * 4)
+
+#define MT_TXD0_Q_IDX			GENMASK(31, 25)
+#define MT_TXD0_PKT_FMT			GENMASK(24, 23)
+#define MT_TXD0_ETH_TYPE_OFFSET		GENMASK(22, 16)
+#define MT_TXD0_TX_BYTES		GENMASK(15, 0)
+
+#define MT_TXD1_FIXED_RATE		BIT(31)
+#define MT_TXD1_OWN_MAC			GENMASK(30, 25)
+#define MT_TXD1_TID			GENMASK(24, 21)
+#define MT_TXD1_BIP			BIT(24)
+#define MT_TXD1_ETH_802_3		BIT(20)
+#define MT_TXD1_HDR_INFO		GENMASK(20, 16)
+#define MT_TXD1_HDR_FORMAT		GENMASK(15, 14)
+#define MT_TXD1_TGID			GENMASK(13, 12)
+#define MT_TXD1_WLAN_IDX		GENMASK(11, 0)
+
+#define MT_TXD2_POWER_OFFSET		GENMASK(31, 26)
+#define MT_TXD2_MAX_TX_TIME		GENMASK(25, 16)
+#define MT_TXD2_FRAG			GENMASK(15, 14)
+#define MT_TXD2_HTC_VLD			BIT(13)
+#define MT_TXD2_DURATION		BIT(12)
+#define MT_TXD2_HDR_PAD			GENMASK(11, 10)
+#define MT_TXD2_RTS			BIT(9)
+#define MT_TXD2_OWN_MAC_MAP		BIT(8)
+#define MT_TXD2_BF_TYPE			GENMASK(6, 7)
+#define MT_TXD2_FRAME_TYPE		GENMASK(5, 4)
+#define MT_TXD2_SUB_TYPE		GENMASK(3, 0)
+
+#define MT_TXD3_SN_VALID		BIT(31)
+#define MT_TXD3_PN_VALID		BIT(30)
+#define MT_TXD3_SW_POWER_MGMT		BIT(29)
+#define MT_TXD3_BA_DISABLE		BIT(28)
+#define MT_TXD3_SEQ			GENMASK(27, 16)
+#define MT_TXD3_REM_TX_COUNT		GENMASK(15, 11)
+#define MT_TXD3_TX_COUNT		GENMASK(10, 6)
+#define MT_TXD3_HW_AMSDU		BIT(5)
+#define MT_TXD3_BCM			BIT(4)
+#define MT_TXD3_EEOSP			BIT(3)
+#define MT_TXD3_EMRD			BIT(2)
+#define MT_TXD3_PROTECT_FRAME		BIT(1)
+#define MT_TXD3_NO_ACK			BIT(0)
+
+#define MT_TXD4_PN_LOW			GENMASK(31, 0)
+
+#define MT_TXD5_PN_HIGH			GENMASK(31, 16)
+#define MT_TXD5_FL			BIT(15)
+#define MT_TXD5_BYPASS_TBB		BIT(14)
+#define MT_TXD5_BYPASS_RBB		BIT(13)
+#define MT_TXD5_BSS_COLOR_ZERO		BIT(12)
+#define MT_TXD5_TX_STATUS_HOST		BIT(10)
+#define MT_TXD5_TX_STATUS_MCU		BIT(9)
+#define MT_TXD5_TX_STATUS_FMT		BIT(8)
+#define MT_TXD5_PID			GENMASK(7, 0)
+
+#define MT_TXD6_TX_SRC			GENMASK(31, 30)
+#define MT_TXD6_VTA			BIT(28)
+#define MT_TXD6_FIXED_BW		BIT(25)
+#define MT_TXD6_BW			GENMASK(24, 22)
+#define MT_TXD6_TX_RATE			GENMASK(21, 16)
+#define MT_TXD6_TIMESTAMP_OFS_EN	BIT(15)
+#define MT_TXD6_TIMESTAMP_OFS_IDX	GENMASK(14, 10)
+#define MT_TXD6_MSDU_CNT		GENMASK(9, 4)
+#define MT_TXD6_SPE_ID_IDX		BIT(10)
+#define MT_TXD6_ANT_ID			GENMASK(7, 4)
+#define MT_TXD6_DIS_MAT			BIT(3)
+#define MT_TXD6_DAS			BIT(2)
+#define MT_TXD6_AMSDU_CAP		BIT(1)
+
+#define MT_TXD7_TXD_LEN			GENMASK(31, 30)
+#define MT_TXD7_IP_SUM			BIT(29)
+#define MT_TXD7_DROP_BY_SDO		BIT(28)
+#define MT_TXD7_MAC_TXD			BIT(27)
+#define MT_TXD7_CTXD			BIT(26)
+#define MT_TXD7_CTXD_CNT		GENMASK(25, 22)
+#define MT_TXD7_UDP_TCP_SUM		BIT(15)
+#define MT_TXD7_TX_TIME			GENMASK(9, 0)
+
+#define MT_TX_RATE_STBC			BIT(13)
+#define MT_TX_RATE_NSS			GENMASK(13, 10)
+#define MT_TX_RATE_MODE			GENMASK(9, 6)
+#define MT_TX_RATE_SU_EXT_TONE		BIT(5)
+#define MT_TX_RATE_DCM			BIT(4)
+/* VHT/HE only use bits 0-3 */
+#define MT_TX_RATE_IDX			GENMASK(5, 0)
+
+struct mt7996_txp {
+	__le16 flags;
+	__le16 token;
+	u8 bss_idx;
+	__le16 rept_wds_wcid;
+	u8 nbuf;
+#define MT_TXP_MAX_BUF_NUM	6
+	__le32 buf[MT_TXP_MAX_BUF_NUM];
+	__le16 len[MT_TXP_MAX_BUF_NUM];
+} __packed __aligned(4);
+
+#define MT_TXFREE0_PKT_TYPE		GENMASK(31, 27)
+#define MT_TXFREE0_MSDU_CNT		GENMASK(25, 16)
+#define MT_TXFREE0_RX_BYTE		GENMASK(15, 0)
+
+#define MT_TXFREE1_VER			GENMASK(18, 16)
+
+#define MT_TXFREE_INFO_PAIR		BIT(31)
+#define MT_TXFREE_INFO_HEADER		BIT(30)
+#define MT_TXFREE_INFO_WLAN_ID		GENMASK(23, 12)
+#define MT_TXFREE_INFO_MSDU_ID		GENMASK(14, 0)
+
+#define MT_TXS0_BW			GENMASK(31, 29)
+#define MT_TXS0_TID			GENMASK(28, 26)
+#define MT_TXS0_AMPDU			BIT(25)
+#define MT_TXS0_TXS_FORMAT		GENMASK(24, 23)
+#define MT_TXS0_BA_ERROR		BIT(22)
+#define MT_TXS0_PS_FLAG			BIT(21)
+#define MT_TXS0_TXOP_TIMEOUT		BIT(20)
+#define MT_TXS0_BIP_ERROR		BIT(19)
+
+#define MT_TXS0_QUEUE_TIMEOUT		BIT(18)
+#define MT_TXS0_RTS_TIMEOUT		BIT(17)
+#define MT_TXS0_ACK_TIMEOUT		BIT(16)
+#define MT_TXS0_ACK_ERROR_MASK		GENMASK(18, 16)
+
+#define MT_TXS0_TX_STATUS_HOST		BIT(15)
+#define MT_TXS0_TX_STATUS_MCU		BIT(14)
+#define MT_TXS0_TX_RATE			GENMASK(13, 0)
+
+#define MT_TXS1_SEQNO			GENMASK(31, 20)
+#define MT_TXS1_RESP_RATE		GENMASK(19, 16)
+#define MT_TXS1_RXV_SEQNO		GENMASK(15, 8)
+#define MT_TXS1_TX_POWER_DBM		GENMASK(7, 0)
+
+#define MT_TXS2_BF_STATUS		GENMASK(31, 30)
+#define MT_TXS2_BAND			GENMASK(29, 28)
+#define MT_TXS2_WCID			GENMASK(27, 16)
+#define MT_TXS2_TX_DELAY		GENMASK(15, 0)
+
+#define MT_TXS3_PID			GENMASK(31, 24)
+#define MT_TXS3_RATE_STBC		BIT(7)
+#define MT_TXS3_FIXED_RATE		BIT(6)
+#define MT_TXS3_SRC			GENMASK(5, 4)
+#define MT_TXS3_SHARED_ANTENNA		BIT(3)
+#define MT_TXS3_LAST_TX_RATE		GENMASK(2, 0)
+
+#define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
+
+#define MT_TXS5_F0_FINAL_MPDU		BIT(31)
+#define MT_TXS5_F0_QOS			BIT(30)
+#define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)
+#define MT_TXS5_F0_FRONT_TIME		GENMASK(24, 0)
+#define MT_TXS5_F1_MPDU_TX_COUNT	GENMASK(31, 24)
+#define MT_TXS5_F1_MPDU_TX_BYTES	GENMASK(23, 0)
+
+#define MT_TXS6_F0_NOISE_3		GENMASK(31, 24)
+#define MT_TXS6_F0_NOISE_2		GENMASK(23, 16)
+#define MT_TXS6_F0_NOISE_1		GENMASK(15, 8)
+#define MT_TXS6_F0_NOISE_0		GENMASK(7, 0)
+#define MT_TXS6_F1_MPDU_FAIL_COUNT	GENMASK(31, 24)
+#define MT_TXS6_F1_MPDU_FAIL_BYTES	GENMASK(23, 0)
+
+#define MT_TXS7_F0_RCPI_3		GENMASK(31, 24)
+#define MT_TXS7_F0_RCPI_2		GENMASK(23, 16)
+#define MT_TXS7_F0_RCPI_1		GENMASK(15, 8)
+#define MT_TXS7_F0_RCPI_0		GENMASK(7, 0)
+#define MT_TXS7_F1_MPDU_RETRY_COUNT	GENMASK(31, 24)
+#define MT_TXS7_F1_MPDU_RETRY_BYTES	GENMASK(23, 0)
+
+struct mt7996_dfs_pulse {
+	u32 max_width;		/* us */
+	int max_pwr;		/* dbm */
+	int min_pwr;		/* dbm */
+	u32 min_stgr_pri;	/* us */
+	u32 max_stgr_pri;	/* us */
+	u32 min_cr_pri;		/* us */
+	u32 max_cr_pri;		/* us */
+};
+
+struct mt7996_dfs_pattern {
+	u8 enb;
+	u8 stgr;
+	u8 min_crpn;
+	u8 max_crpn;
+	u8 min_crpr;
+	u8 min_pw;
+	u32 min_pri;
+	u32 max_pri;
+	u8 max_pw;
+	u8 min_crbn;
+	u8 max_crbn;
+	u8 min_stgpn;
+	u8 max_stgpn;
+	u8 min_stgpr;
+	u8 rsv[2];
+	u32 min_stgpr_diff;
+} __packed;
+
+struct mt7996_dfs_radar_spec {
+	struct mt7996_dfs_pulse pulse_th;
+	struct mt7996_dfs_pattern radar_pattern[16];
+};
+
+static inline struct mt7996_txp *
+mt7996_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	u8 *txwi;
+
+	if (!t)
+		return NULL;
+
+	txwi = mt76_get_txwi_ptr(dev, t);
+
+	return (struct mt7996_txp *)(txwi + MT_TXD_SIZE);
+}
+
+#endif
-- 
2.25.1

