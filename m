Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE342AFE6
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 01:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhJLXEA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 19:04:00 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:34259 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbhJLXD6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 19:03:58 -0400
X-UUID: 5c5720f3e1d64831919db1ae8a94c4d7-20211012
X-UUID: 5c5720f3e1d64831919db1ae8a94c4d7-20211012
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1822481878; Tue, 12 Oct 2021 16:01:52 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 Oct 2021 15:52:26 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Oct 2021 06:52:25 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4 03/16] mt76: mt7921: refactor mcu.c to be bus independent
Date:   Wed, 13 Oct 2021 06:51:56 +0800
Message-ID: <6dc5a0a8778e55ed879f6b55e4a7f36de8db1c25.1634077769.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1634077769.git.objelf@gmail.com>
References: <cover.1634077769.git.objelf@gmail.com>
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
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/Makefile    |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  5 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 94 ++----------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 20 +++-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  3 +
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  2 +
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   | 97 +++++++++++++++++++
 8 files changed, 130 insertions(+), 95 deletions(-)
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
index 4ef54343cef3..7956a57510c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -304,6 +304,7 @@ void mt7921_unregister_device(struct mt7921_dev *dev)
 	mt7921_tx_token_put(dev);
 	mt7921_mcu_drv_pmctrl(dev);
 	mt7921_dma_cleanup(dev);
+	mt7921_wfsys_reset(dev);
 	mt7921_mcu_exit(dev);
 
 	tasklet_disable(&dev->irq_tasklet);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index eb27d8ab4a8b..bb6f0cea93bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1276,12 +1276,9 @@ void mt7921_mac_reset_work(struct work_struct *work)
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
index 3f6c9839d9d4..5553221b7f5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -160,9 +160,8 @@ mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
 	return 0;
 }
 
-static int
-mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
-			  struct sk_buff *skb, int seq)
+int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			      struct sk_buff *skb, int seq)
 {
 	struct mt7921_mcu_rxd *rxd;
 	int mcu_cmd = cmd & MCU_CMD_MASK;
@@ -224,9 +223,8 @@ mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	return ret;
 }
 
-static int
-mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
-			int cmd, int *wait_seq)
+int mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			    int cmd, int *wait_seq)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	int txd_len, mcu_cmd = cmd & MCU_CMD_MASK;
@@ -590,7 +588,7 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 				      enable, false);
 }
 
-static int mt7921_mcu_restart(struct mt76_dev *dev)
+int mt7921_mcu_restart(struct mt76_dev *dev)
 {
 	struct {
 		u8 power_mode;
@@ -603,20 +601,6 @@ static int mt7921_mcu_restart(struct mt76_dev *dev)
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
@@ -883,7 +867,6 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 	}
 
 fw_loaded:
-	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
 
 #ifdef CONFIG_PM
 	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
@@ -911,10 +894,6 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
 {
 	int err;
 
-	err = mt7921_driver_own(dev);
-	if (err)
-		return err;
-
 	err = mt7921_load_firmware(dev);
 	if (err)
 		return err;
@@ -925,23 +904,8 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
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
 
@@ -1231,35 +1195,6 @@ int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
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
@@ -1285,29 +1220,14 @@ int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
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
+	err = __mt7921_mcu_fw_pmctrl(dev);
 out:
 	mutex_unlock(&pm->mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index a6c3661b2bdd..9c15c9bdd41e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -133,9 +133,15 @@ struct mt7921_phy {
 	struct delayed_work scan_work;
 };
 
-#define mt7921_dev_reset(dev)	((dev)->hif_ops->reset(dev))
+#define mt7921_dev_reset(dev)		((dev)->hif_ops->reset(dev))
+#define mt7921_mcu_init(dev)		((dev)->hif_ops->mcu_init(dev))
+#define __mt7921_mcu_drv_pmctrl(dev)	((dev)->hif_ops->drv_own(dev))
+#define	__mt7921_mcu_fw_pmctrl(dev)	((dev)->hif_ops->fw_own(dev))
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
@@ -364,7 +369,6 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 			 bool enable);
 void mt7921_scan_work(struct work_struct *work);
 int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
-int __mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
 void mt7921_pm_wake_work(struct work_struct *work);
@@ -383,7 +387,17 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
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
index fb19cff4a697..171aa2daef4d 100644
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
index c11f19e8ab74..fccca15525aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -288,6 +288,8 @@ int mt7921e_mac_reset(struct mt7921_dev *dev)
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
-- 
2.25.1

