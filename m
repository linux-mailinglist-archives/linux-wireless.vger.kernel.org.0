Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82776213611
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGCIQ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgGCIQ1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:27 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6D95206A1;
        Fri,  3 Jul 2020 08:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764186;
        bh=BiZERL4ReZj8xSnCihCITNO1DsQRIwcuC06sShjEOlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ND53uu0M1tb1wuhFL6QMX0ntUBDC3luebY8z5reBsm9dt/EQI4lq9bd0jf0vrLoYo
         3wUKqu3BYJqcY+zarv3BoIb7LPoLkXmL63WhnUBgbIryYchCAiA9T5/gL06EN/yWCB
         f6YXqSbJkRZjl5uziM9/bNUB+BldJm6qSwsl+wqY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 03/22] mt76: mt7615: add mt7615_pm_wake utility routine
Date:   Fri,  3 Jul 2020 10:15:42 +0200
Message-Id: <0bda930bba3b61477e9063779e7eff7c8c1a3463.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_pm_wake utility routine to wake the device from
runtime low-power state (lower-power state is currently supported by
offload firmware for pcie devices).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  3 ++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 42 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 25 ++++++++---
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  8 ++++
 6 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f7be1d5f71a0..265ee55d22f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -291,6 +291,7 @@ enum {
 	MT76_STATE_POWER_OFF,
 	MT76_STATE_SUSPEND,
 	MT76_STATE_ROC,
+	MT76_STATE_PM,
 };
 
 struct mt76_hw_cap {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 7daaab277b26..b5632c71cbbd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -444,6 +444,9 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	dev->phy.dev = dev;
 	dev->phy.mt76 = &dev->mt76.phy;
 	dev->mt76.phy.priv = &dev->phy;
+
+	INIT_WORK(&dev->pm.wake_work, mt7615_pm_wake_work);
+	init_completion(&dev->pm.wake_cmpl);
 	INIT_DELAYED_WORK(&dev->phy.mac_work, mt7615_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7615_scan_work);
 	skb_queue_head_init(&dev->phy.scan_event_list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index c1a802366172..4d8cd88473dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1808,6 +1808,48 @@ mt7615_mac_update_mib_stats(struct mt7615_phy *phy)
 	}
 }
 
+void mt7615_pm_wake_work(struct work_struct *work)
+{
+	struct mt7615_dev *dev;
+	struct mt76_phy *mphy;
+
+	dev = (struct mt7615_dev *)container_of(work, struct mt7615_dev,
+						pm.wake_work);
+	mphy = dev->phy.mt76;
+
+	if (mt7615_driver_own(dev))
+		dev_err(mphy->dev->dev, "failed to wake device\n");
+
+	complete_all(&dev->pm.wake_cmpl);
+}
+
+int mt7615_pm_wake(struct mt7615_dev *dev)
+{
+	struct mt76_phy *mphy = dev->phy.mt76;
+
+	if (!mt7615_firmware_offload(dev))
+		return 0;
+
+	if (!mt76_is_mmio(mphy->dev))
+		return 0;
+
+	if (!test_bit(MT76_STATE_PM, &mphy->state))
+		return 0;
+
+	if (test_bit(MT76_HW_SCANNING, &mphy->state) ||
+	    test_bit(MT76_HW_SCHED_SCANNING, &mphy->state))
+		return 0;
+
+	if (queue_work(dev->mt76.wq, &dev->pm.wake_work))
+		reinit_completion(&dev->pm.wake_cmpl);
+
+	if (!wait_for_completion_timeout(&dev->pm.wake_cmpl, 3 * HZ))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7615_pm_wake);
+
 void mt7615_mac_work(struct work_struct *work)
 {
 	struct mt7615_phy *phy;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 3bcbd13c26d7..1e7f7b9b1388 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -74,6 +74,8 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
+	cancel_work_sync(&dev->pm.wake_work);
+
 	mutex_lock(&dev->mt76.mutex);
 
 	mt76_testmode_reset(&dev->mt76, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 89a09745df08..b72c824e5c15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1916,28 +1916,36 @@ static void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
 
 int mt7615_driver_own(struct mt7615_dev *dev)
 {
+	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_dev *mdev = &dev->mt76;
+	int err = 0;
 	u32 addr;
 
+	mt7622_trigger_hif_int(dev, true);
+
 	addr = is_mt7663(mdev) ? MT_PCIE_DOORBELL_PUSH : MT_CFG_LPCR_HOST;
 	mt76_wr(dev, addr, MT_CFG_LPCR_HOST_DRV_OWN);
 
-	mt7622_trigger_hif_int(dev, true);
-
 	addr = is_mt7663(mdev) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
 	if (!mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN, 0, 3000)) {
 		dev_err(dev->mt76.dev, "Timeout for driver own\n");
-		return -EIO;
+		err = -EIO;
+		goto out;
 	}
 
+	clear_bit(MT76_STATE_PM, &mphy->state);
+
+out:
 	mt7622_trigger_hif_int(dev, false);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(mt7615_driver_own);
 
 int mt7615_firmware_own(struct mt7615_dev *dev)
 {
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	int err = 0;
 	u32 addr;
 
 	addr = is_mt7663(&dev->mt76) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
@@ -1949,11 +1957,16 @@ int mt7615_firmware_own(struct mt7615_dev *dev)
 	    !mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN,
 			    MT_CFG_LPCR_HOST_FW_OWN, 300)) {
 		dev_err(dev->mt76.dev, "Timeout for firmware own\n");
-		return -EIO;
+		err = -EIO;
+		goto out;
 	}
+
+	set_bit(MT76_STATE_PM, &mphy->state);
+
+out:
 	mt7622_trigger_hif_int(dev, false);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(mt7615_firmware_own);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 1ae6ea5b4f16..194ae43091d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -4,6 +4,7 @@
 #ifndef __MT7615_H
 #define __MT7615_H
 
+#include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/ktime.h>
 #include <linux/regmap.h>
@@ -296,6 +297,11 @@ struct mt7615_dev {
 		s8 last_wb_rssi;
 	} test;
 #endif
+
+	struct {
+		struct work_struct wake_work;
+		struct completion wake_cmpl;
+	} pm;
 };
 
 enum tx_pkt_queue_idx {
@@ -425,6 +431,8 @@ bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev);
 void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates);
+void mt7615_pm_wake_work(struct work_struct *work);
+int mt7615_pm_wake(struct mt7615_dev *dev);
 int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev);
 int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd);
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
-- 
2.26.2

