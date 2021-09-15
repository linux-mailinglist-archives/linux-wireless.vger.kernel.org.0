Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC140BD02
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 03:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhIOBQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 21:16:34 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:17842 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhIOBQe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 21:16:34 -0400
X-UUID: f1834cb9cfb44ea09678a4b54b453cec-20210914
X-UUID: f1834cb9cfb44ea09678a4b54b453cec-20210914
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 741266399; Tue, 14 Sep 2021 18:15:13 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 18:15:11 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 09:15:11 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <steve.lee@mediatek.com>, <jemele@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 03/16] mt76: mt7921: refactor mcu.c to be bus independent
Date:   Wed, 15 Sep 2021 09:14:36 +0800
Message-ID: <37519dafa02723a1fff0ccaea73c8b4f860cad7b.1631667941.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1631667941.git.objelf@gmail.com>
References: <cover.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This is a preliminary patch to introduce mt7921s support.

Make mcu.c reusable between mt7921s and mt7921e

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/Makefile    |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  5 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 90 ++---------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 18 +++-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  3 +
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  2 +
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   | 97 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/testmode.c  |  2 +-
 9 files changed, 129 insertions(+), 92 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 554202358470..4cb0b000cfe1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_MT7921E) += mt7921e.o
 
 CFLAGS_trace.o := -I$(src)
 
-mt7921e-y := pci.o pci_mac.o mac.o mcu.o dma.o eeprom.o main.o init.o debugfs.o trace.o
+mt7921e-y := pci.o pci_mac.o pci_mcu.o mac.o mcu.o dma.o eeprom.o main.o \
+	     init.o debugfs.o trace.o
 mt7921e-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 97b931ea07c1..7c7a26102e11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -304,6 +304,7 @@ void mt7921_unregister_device(struct mt7921_dev *dev)
 	mt7921_tx_token_put(dev);
 	mt7921_mcu_drv_pmctrl(dev);
 	mt7921_dma_cleanup(dev);
+	mt7921_wfsys_reset(dev);
 	mt7921_mcu_exit(dev);
 	mt7921_mcu_fw_pmctrl(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 580a88b7841e..c26d986e08e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1282,12 +1282,9 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	cancel_work_sync(&pm->wake_work);
 
 	mutex_lock(&dev->mt76.mutex);
-	for (i = 0; i < 10; i++) {
-		__mt7921_mcu_drv_pmctrl(dev);
-
+	for (i = 0; i < 10; i++)
 		if (!mt7921_dev_reset(dev))
 			break;
-	}
 	mutex_unlock(&dev->mt76.mutex);
 
 	if (i == 10)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 6ba431347b3b..0648443eb283 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -160,7 +160,7 @@ mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
 	return 0;
 }
 
-static int
+int
 mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			  struct sk_buff *skb, int seq)
 {
@@ -224,7 +224,7 @@ mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	return ret;
 }
 
-static int
+int
 mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			int cmd, int *wait_seq)
 {
@@ -590,7 +590,7 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 				      enable, false);
 }
 
-static int mt7921_mcu_restart(struct mt76_dev *dev)
+int mt7921_mcu_restart(struct mt76_dev *dev)
 {
 	struct {
 		u8 power_mode;
@@ -603,20 +603,6 @@ static int mt7921_mcu_restart(struct mt76_dev *dev)
 				 sizeof(req), false);
 }
 
-static int mt7921_driver_own(struct mt7921_dev *dev)
-{
-	u32 reg = mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
-
-	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_DRV_OWN);
-	if (!mt76_poll_msec(dev, reg, MT_TOP_LPCR_HOST_FW_OWN,
-			    0, 500)) {
-		dev_err(dev->mt76.dev, "Timeout for driver own\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
 static u32 mt7921_get_data_mode(struct mt7921_dev *dev, u32 info)
 {
 	u32 mode = DL_MODE_NEED_RSP;
@@ -883,7 +869,6 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 	}
 
 fw_loaded:
-	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
 
 #ifdef CONFIG_PM
 	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
@@ -911,10 +896,6 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
 {
 	int err;
 
-	err = mt7921_driver_own(dev);
-	if (err)
-		return err;
-
 	err = mt7921_load_firmware(dev);
 	if (err)
 		return err;
@@ -925,23 +906,8 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
 	return mt76_connac_mcu_get_nic_capability(&dev->mphy);
 }
 
-int mt7921_mcu_init(struct mt7921_dev *dev)
-{
-	static const struct mt76_mcu_ops mt7921_mcu_ops = {
-		.headroom = sizeof(struct mt7921_mcu_txd),
-		.mcu_skb_send_msg = mt7921_mcu_send_message,
-		.mcu_parse_response = mt7921_mcu_parse_response,
-		.mcu_restart = mt7921_mcu_restart,
-	};
-
-	dev->mt76.mcu_ops = &mt7921_mcu_ops;
-
-	return mt7921_run_firmware(dev);
-}
-
 void mt7921_mcu_exit(struct mt7921_dev *dev)
 {
-	mt7921_wfsys_reset(dev);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
 
@@ -1231,35 +1197,6 @@ int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 	return mt76_connac_mcu_sta_cmd(&dev->mphy, &info);
 }
 
-int __mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
-{
-	struct mt76_phy *mphy = &dev->mt76.phy;
-	struct mt76_connac_pm *pm = &dev->pm;
-	int i, err = 0;
-
-	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
-		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_CLR_OWN);
-		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
-				   PCIE_LPCR_HOST_OWN_SYNC, 0, 50))
-			break;
-	}
-
-	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
-		dev_err(dev->mt76.dev, "driver own failed\n");
-		err = -EIO;
-		goto out;
-	}
-
-	mt7921_wpdma_reinit_cond(dev);
-	clear_bit(MT76_STATE_PM, &mphy->state);
-
-	pm->stats.last_wake_event = jiffies;
-	pm->stats.doze_time += pm->stats.last_wake_event -
-			       pm->stats.last_doze_event;
-out:
-	return err;
-}
-
 int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
@@ -1271,7 +1208,7 @@ int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 	if (!test_bit(MT76_STATE_PM, &mphy->state))
 		goto out;
 
-	err = __mt7921_mcu_drv_pmctrl(dev);
+	err = mt7921_drv_own(dev);
 out:
 	mutex_unlock(&pm->mutex);
 
@@ -1285,29 +1222,14 @@ int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_connac_pm *pm = &dev->pm;
-	int i, err = 0;
+	int err = 0;
 
 	mutex_lock(&pm->mutex);
 
 	if (mt76_connac_skip_fw_pmctrl(mphy, pm))
 		goto out;
 
-	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
-		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_SET_OWN);
-		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
-				   PCIE_LPCR_HOST_OWN_SYNC, 4, 50))
-			break;
-	}
-
-	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
-		dev_err(dev->mt76.dev, "firmware own failed\n");
-		clear_bit(MT76_STATE_PM, &mphy->state);
-		err = -EIO;
-	}
-
-	pm->stats.last_doze_event = jiffies;
-	pm->stats.awake_time += pm->stats.last_doze_event -
-				pm->stats.last_wake_event;
+	err = mt7921_fw_own(dev);
 out:
 	mutex_unlock(&pm->mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 4c1c7c4eafac..dbace154bfa5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -134,8 +134,14 @@ struct mt7921_phy {
 };
 
 #define mt7921_dev_reset(dev)	((dev)->hif_ops->reset(dev))
+#define mt7921_mcu_init(dev)	((dev)->hif_ops->mcu_init(dev))
+#define mt7921_drv_own(dev)	((dev)->hif_ops->drv_own(dev))
+#define mt7921_fw_own(dev)	((dev)->hif_ops->fw_own(dev))
 struct mt7921_hif_ops {
 	int (*reset)(struct mt7921_dev *dev);
+	int (*mcu_init)(struct mt7921_dev *dev);
+	int (*drv_own)(struct mt7921_dev *dev);
+	int (*fw_own)(struct mt7921_dev *dev);
 };
 
 struct mt7921_dev {
@@ -250,7 +256,6 @@ int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force);
 int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev);
 void mt7921_dma_cleanup(struct mt7921_dev *dev);
 int mt7921_run_firmware(struct mt7921_dev *dev);
-int mt7921_mcu_init(struct mt7921_dev *dev);
 int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
 		       enum set_key_cmd cmd);
@@ -359,7 +364,6 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 			 bool enable);
 void mt7921_scan_work(struct work_struct *work);
 int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
-int __mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
 void mt7921_pm_wake_work(struct work_struct *work);
@@ -378,7 +382,17 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 			   bool beacon);
 void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
 void mt7921_mac_sta_poll(struct mt7921_dev *dev);
+int mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			    int cmd, int *wait_seq);
+int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			      struct sk_buff *skb, int seq);
+int mt7921_mcu_restart(struct mt76_dev *dev);
+
 void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			  struct sk_buff *skb);
 int mt7921e_mac_reset(struct mt7921_dev *dev);
+int mt7921e_mcu_init(struct mt7921_dev *dev);
+int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
+int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index b01b9b7c42b4..b16bcee08cd7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -117,6 +117,9 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 
 	static const struct mt7921_hif_ops mt7921_pcie_ops = {
 		.reset = mt7921e_mac_reset,
+		.mcu_init = mt7921e_mcu_init,
+		.drv_own = mt7921e_mcu_drv_pmctrl,
+		.fw_own = mt7921e_mcu_fw_pmctrl,
 	};
 
 	struct mt7921_dev *dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index f211dafa311c..f0734be57dce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -286,6 +286,8 @@ mt7921e_mac_reset(struct mt7921_dev *dev)
 {
 	int i, err;
 
+	mt7921e_mcu_drv_pmctrl(dev);
+
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
new file mode 100644
index 000000000000..9ac3bc25f067
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc. */
+
+#include "mt7921.h"
+#include "mcu.h"
+
+static int mt7921e_driver_own(struct mt7921_dev *dev)
+{
+	u32 reg = mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
+
+	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_DRV_OWN);
+	if (!mt76_poll_msec(dev, reg, MT_TOP_LPCR_HOST_FW_OWN,
+			    0, 500)) {
+		dev_err(dev->mt76.dev, "Timeout for driver own\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int mt7921e_mcu_init(struct mt7921_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7921_mcu_ops = {
+		.headroom = sizeof(struct mt7921_mcu_txd),
+		.mcu_skb_send_msg = mt7921_mcu_send_message,
+		.mcu_parse_response = mt7921_mcu_parse_response,
+		.mcu_restart = mt7921_mcu_restart,
+	};
+	int err;
+
+	dev->mt76.mcu_ops = &mt7921_mcu_ops;
+
+	err = mt7921e_driver_own(dev);
+	if (err)
+		return err;
+
+	err = mt7921_run_firmware(dev);
+
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
+
+	return err;
+}
+
+int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	int i, err = 0;
+
+	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
+		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_CLR_OWN);
+		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
+				   PCIE_LPCR_HOST_OWN_SYNC, 0, 50))
+			break;
+	}
+
+	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
+		dev_err(dev->mt76.dev, "driver own failed\n");
+		err = -EIO;
+		goto out;
+	}
+
+	mt7921_wpdma_reinit_cond(dev);
+	clear_bit(MT76_STATE_PM, &mphy->state);
+
+	pm->stats.last_wake_event = jiffies;
+	pm->stats.doze_time += pm->stats.last_wake_event -
+			       pm->stats.last_doze_event;
+out:
+	return err;
+}
+
+int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	int i, err = 0;
+
+	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
+		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_SET_OWN);
+		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
+				   PCIE_LPCR_HOST_OWN_SYNC, 4, 50))
+			break;
+	}
+
+	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
+		dev_err(dev->mt76.dev, "firmware own failed\n");
+		clear_bit(MT76_STATE_PM, &mphy->state);
+		err = -EIO;
+	}
+
+	pm->stats.last_doze_event = jiffies;
+	pm->stats.awake_time += pm->stats.last_doze_event -
+				pm->stats.last_wake_event;
+
+	return err;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
index 8bd43879dd6f..d22bbd9da58f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
@@ -57,7 +57,7 @@ mt7921_tm_set(struct mt7921_dev *dev, struct mt7921_tm_cmd *req)
 		pm->enable = false;
 		cancel_delayed_work_sync(&pm->ps_work);
 		cancel_work_sync(&pm->wake_work);
-		__mt7921_mcu_drv_pmctrl(dev);
+		mt7921_drv_own(dev);
 
 		mt76_wr(dev, MT_WF_RFCR(0), dev->mt76.rxfilter);
 		phy->test.state = MT76_TM_STATE_ON;
-- 
2.25.1

