Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9A92E9C82
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 19:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbhADSCE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 13:02:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33101 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726336AbhADSCE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 13:02:04 -0500
X-UUID: f90b90135b924d28be22d35ddfb049aa-20210105
X-UUID: f90b90135b924d28be22d35ddfb049aa-20210105
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 437892185; Tue, 05 Jan 2021 02:00:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 02:00:21 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 02:00:21 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v5 08/15] mt76: mt7921: introduce mt7921e support
Date:   Tue, 5 Jan 2021 02:00:12 +0800
Message-ID: <1c7f92c74b24be22fe8315eb6d6a9dfdc18d8f1f.1609781247.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1609781247.git.objelf@gmail.com>
References: <cover.1609781247.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DDA3C5B25FE1A6C4A0BA21F81750FC1ECA3646D22F3C54D6C0FEC389263D65892000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce support for mt7921e 802.11ax (Wi-Fi 6) 2x2:2SS chipset.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 247 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 184 +++++++++++++
 2 files changed, 431 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
new file mode 100644
index 000000000000..099ebdb23700
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/etherdevice.h>
+#include "mt7921.h"
+#include "mac.h"
+#include "eeprom.h"
+
+#define CCK_RATE(_idx, _rate) {						\
+	.bitrate = _rate,						\
+	.flags = IEEE80211_RATE_SHORT_PREAMBLE,				\
+	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),			\
+	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (4 + (_idx)),	\
+}
+
+#define OFDM_RATE(_idx, _rate) {					\
+	.bitrate = _rate,						\
+	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),			\
+	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
+}
+
+static struct ieee80211_rate mt7921_rates[] = {
+	CCK_RATE(0, 10),
+	CCK_RATE(1, 20),
+	CCK_RATE(2, 55),
+	CCK_RATE(3, 110),
+	OFDM_RATE(11, 60),
+	OFDM_RATE(15, 90),
+	OFDM_RATE(10, 120),
+	OFDM_RATE(14, 180),
+	OFDM_RATE(9,  240),
+	OFDM_RATE(13, 360),
+	OFDM_RATE(8,  480),
+	OFDM_RATE(12, 540),
+};
+
+static const struct ieee80211_iface_limit if_limits[] = {
+	{
+		.max = MT7921_MAX_INTERFACES,
+		.types = BIT(NL80211_IFTYPE_STATION)
+	}
+};
+
+static const struct ieee80211_iface_combination if_comb[] = {
+	{
+		.limits = if_limits,
+		.n_limits = ARRAY_SIZE(if_limits),
+		.max_interfaces = MT7921_MAX_INTERFACES,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = true,
+	}
+};
+
+static void
+mt7921_init_wiphy(struct ieee80211_hw *hw)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct wiphy *wiphy = hw->wiphy;
+
+	hw->queues = 4;
+	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+
+	phy->slottime = 9;
+
+	hw->sta_data_size = sizeof(struct mt7921_sta);
+	hw->vif_data_size = sizeof(struct mt7921_vif);
+
+	wiphy->iface_combinations = if_comb;
+	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	wiphy->max_scan_ie_len = MT7921_SCAN_IE_LEN;
+	wiphy->max_scan_ssids = 4;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
+
+	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
+	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+
+	hw->max_tx_fragments = 4;
+}
+
+static void
+mt7921_mac_init_band(struct mt7921_dev *dev, u8 band)
+{
+	u32 mask, set;
+
+	mt76_rmw_field(dev, MT_TMAC_CTCR0(band),
+		       MT_TMAC_CTCR0_INS_DDLMT_REFTIME, 0x3f);
+	mt76_set(dev, MT_TMAC_CTCR0(band),
+		 MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN |
+		 MT_TMAC_CTCR0_INS_DDLMT_EN);
+
+	mask = MT_MDP_RCFR0_MCU_RX_MGMT |
+	       MT_MDP_RCFR0_MCU_RX_CTL_NON_BAR |
+	       MT_MDP_RCFR0_MCU_RX_CTL_BAR;
+	set = FIELD_PREP(MT_MDP_RCFR0_MCU_RX_MGMT, MT_MDP_TO_HIF) |
+	      FIELD_PREP(MT_MDP_RCFR0_MCU_RX_CTL_NON_BAR, MT_MDP_TO_HIF) |
+	      FIELD_PREP(MT_MDP_RCFR0_MCU_RX_CTL_BAR, MT_MDP_TO_HIF);
+	mt76_rmw(dev, MT_MDP_BNRCFR0(band), mask, set);
+
+	mask = MT_MDP_RCFR1_MCU_RX_BYPASS |
+	       MT_MDP_RCFR1_RX_DROPPED_UCAST |
+	       MT_MDP_RCFR1_RX_DROPPED_MCAST;
+	set = FIELD_PREP(MT_MDP_RCFR1_MCU_RX_BYPASS, MT_MDP_TO_HIF) |
+	      FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_UCAST, MT_MDP_TO_HIF) |
+	      FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_MCAST, MT_MDP_TO_HIF);
+	mt76_rmw(dev, MT_MDP_BNRCFR1(band), mask, set);
+
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
+
+	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 1536);
+	/* disable rx rate report by default due to hw issues */
+	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
+}
+
+static void mt7921_mac_init(struct mt7921_dev *dev)
+{
+	int i;
+
+	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, 1536);
+	/* disable hardware de-agg */
+	mt76_clear(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
+
+	for (i = 0; i < MT7921_WTBL_SIZE; i++)
+		mt7921_mac_wtbl_update(dev, i,
+				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	for (i = 0; i < 2; i++)
+		mt7921_mac_init_band(dev, i);
+
+	mt7921_mcu_set_rts_thresh(&dev->phy, 0x92b);
+}
+
+static void mt7921_init_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
+				 init_work);
+
+	mt7921_mcu_set_eeprom(dev);
+	mt7921_mac_init(dev);
+}
+
+static int mt7921_init_hardware(struct mt7921_dev *dev)
+{
+	int ret, idx;
+
+	INIT_WORK(&dev->init_work, mt7921_init_work);
+	spin_lock_init(&dev->token_lock);
+	idr_init(&dev->token);
+
+	ret = mt7921_dma_init(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+
+	/* force firmware operation mode into normal state,
+	 * which should be set before firmware download stage.
+	 */
+	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
+
+	ret = mt7921_mcu_init(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7921_eeprom_init(dev);
+	if (ret < 0)
+		return ret;
+
+	/* Beacon and mgmt frames should occupy wcid 0 */
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
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
+int mt7921_register_device(struct mt7921_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	int ret;
+
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
+	INIT_LIST_HEAD(&dev->phy.stats_list);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7921_mac_work);
+	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7921_scan_work);
+	skb_queue_head_init(&dev->phy.scan_event_list);
+	INIT_LIST_HEAD(&dev->sta_poll_list);
+	spin_lock_init(&dev->sta_poll_lock);
+
+	init_waitqueue_head(&dev->reset_wait);
+	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
+
+	ret = mt7921_init_hardware(dev);
+	if (ret)
+		return ret;
+
+	mt7921_init_wiphy(hw);
+	dev->mphy.sband_2g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+	dev->mphy.sband_5g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+	dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+	dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_SHORT_GI_160 |
+			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
+	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
+	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
+
+	mt76_set_stream_caps(&dev->mphy, true);
+	mt7921_set_stream_he_caps(&dev->phy);
+
+	ret = mt76_register_device(&dev->mt76, true, mt7921_rates,
+				   ARRAY_SIZE(mt7921_rates));
+	if (ret)
+		return ret;
+
+	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
+
+	return 0;
+}
+
+void mt7921_unregister_device(struct mt7921_dev *dev)
+{
+	mt76_unregister_device(&dev->mt76);
+	mt7921_mcu_exit(dev);
+	mt7921_dma_cleanup(dev);
+
+	mt7921_tx_token_put(dev);
+
+	tasklet_disable(&dev->irq_tasklet);
+	mt76_free_device(&dev->mt76);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
new file mode 100644
index 000000000000..6808bc749583
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "mt7921.h"
+#include "mac.h"
+#include "../trace.h"
+
+static const struct pci_device_id mt7921_pci_device_table[] = {
+	{ PCI_DEVICE(0x14c3, 0x7961) },
+	{ },
+};
+
+static void
+mt7921_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	if (q == MT_RXQ_MAIN)
+		mt7921_irq_enable(dev, MT_INT_RX_DONE_DATA);
+	else if (q == MT_RXQ_MCU_WA)
+		mt7921_irq_enable(dev, MT_INT_RX_DONE_WM2);
+	else
+		mt7921_irq_enable(dev, MT_INT_RX_DONE_WM);
+}
+
+static irqreturn_t mt7921_irq_handler(int irq, void *dev_instance)
+{
+	struct mt7921_dev *dev = dev_instance;
+
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+		return IRQ_NONE;
+
+	tasklet_schedule(&dev->irq_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+static void mt7921_irq_tasklet(unsigned long data)
+{
+	struct mt7921_dev *dev = (struct mt7921_dev *)data;
+	u32 intr, mask = 0;
+
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+
+	intr = mt76_rr(dev, MT_WFDMA0_HOST_INT_STA);
+	intr &= dev->mt76.mmio.irqmask;
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_STA, intr);
+
+	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
+
+	mask |= intr & MT_INT_RX_DONE_ALL;
+	if (intr & MT_INT_TX_DONE_MCU)
+		mask |= MT_INT_TX_DONE_MCU;
+
+	mt76_set_irq_mask(&dev->mt76, MT_WFDMA0_HOST_INT_ENA, mask, 0);
+
+	if (intr & MT_INT_TX_DONE_ALL)
+		napi_schedule(&dev->mt76.tx_napi);
+
+	if (intr & MT_INT_RX_DONE_WM)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU]);
+
+	if (intr & MT_INT_RX_DONE_WM2)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU_WA]);
+
+	if (intr & MT_INT_RX_DONE_DATA)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
+}
+
+static int mt7921_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		/* txwi_size = txd size + txp size */
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7921_txp_common),
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ |
+			     MT_DRV_AMSDU_OFFLOAD,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.tx_prepare_skb = mt7921_tx_prepare_skb,
+		.tx_complete_skb = mt7921_tx_complete_skb,
+		.rx_skb = mt7921_queue_rx_skb,
+		.rx_poll_complete = mt7921_rx_poll_complete,
+		.sta_ps = mt7921_sta_ps,
+		.sta_add = mt7921_mac_sta_add,
+		.sta_remove = mt7921_mac_sta_remove,
+		.update_survey = mt7921_update_channel,
+	};
+	struct mt7921_dev *dev;
+	struct mt76_dev *mdev;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
+	if (ret < 0)
+		return ret;
+
+	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (ret)
+		goto err_free_pci_vec;
+
+	mt76_pci_disable_aspm(pdev);
+
+	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7921_ops,
+				 &drv_ops);
+	if (!mdev) {
+		ret = -ENOMEM;
+		goto err_free_pci_vec;
+	}
+
+	dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
+	tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
+	mdev->rev = (mt7921_l1_rr(dev, MT_HW_CHIPID) << 16) |
+		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
+	dev_err(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+
+	mt7921_l1_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+
+	ret = devm_request_irq(mdev->dev, pdev->irq, mt7921_irq_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, dev);
+	if (ret)
+		goto err_free_dev;
+
+	ret = mt7921_register_device(dev);
+	if (ret)
+		goto err_free_dev;
+
+	return 0;
+
+err_free_dev:
+	mt76_free_device(&dev->mt76);
+err_free_pci_vec:
+	pci_free_irq_vectors(pdev);
+
+	return ret;
+}
+
+static void mt7921_pci_remove(struct pci_dev *pdev)
+{
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	mt7921_unregister_device(dev);
+	devm_free_irq(&pdev->dev, pdev->irq, dev);
+	pci_free_irq_vectors(pdev);
+}
+
+struct pci_driver mt7921_pci_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= mt7921_pci_device_table,
+	.probe		= mt7921_pci_probe,
+	.remove		= mt7921_pci_remove,
+};
+
+module_pci_driver(mt7921_pci_driver);
+
+MODULE_DEVICE_TABLE(pci, mt7921_pci_device_table);
+MODULE_FIRMWARE(MT7921_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7921_ROM_PATCH);
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

