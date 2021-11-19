Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CCF45797E
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Nov 2021 00:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhKSXZW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 18:25:22 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:52116 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230351AbhKSXZV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 18:25:21 -0500
X-UUID: 92ab6a22ab374a32bc6fe5a19d56c29d-20211120
X-UUID: 92ab6a22ab374a32bc6fe5a19d56c29d-20211120
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2070822755; Sat, 20 Nov 2021 07:22:16 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 20 Nov 2021 07:22:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 20 Nov
 2021 07:22:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 20 Nov 2021 07:22:14 +0800
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
Subject: [PATCH 2/2] mt76: mt7921s: fix the device cannot sleep deeply in suspend
Date:   Sat, 20 Nov 2021 07:22:11 +0800
Message-ID: <a00f3858dd6896f56a5b730c457a8e825c664028.1637363831.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <92851c34c3758b7d50f3eaa24b1a27adccde2b1a.1637363831.git.objelf@gmail.com>
References: <92851c34c3758b7d50f3eaa24b1a27adccde2b1a.1637363831.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

According to the MT7921S firmware, the cmd MCU_UNI_CMD_HIF_CTRL have to
be last MCU command to execute in suspend handler and all data traffic
have to be stopped before the cmd MCU_UNI_CMD_HIF_CTRL starts as well
in order that mt7921 can successfully fall into the deep sleep mode.

Where we reuse the flag MT76_STATE_SUSPEND and avoid creating
another global flag to stop all of the traffic onto the SDIO bus.

Fixes: 48fab5bbef40 ("mt76: mt7921: introduce mt7921s support")
Reported-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 --
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  | 34 ++++++++++++-------
 drivers/net/wireless/mediatek/mt76/sdio.c     |  3 +-
 .../net/wireless/mediatek/mt76/sdio_txrx.c    |  3 +-
 5 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 26b4b875dcc0..61c4c86e79c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2461,7 +2461,7 @@ void mt76_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
 				      struct ieee80211_vif *vif)
 {
 	struct mt76_phy *phy = priv;
-	bool suspend = test_bit(MT76_STATE_SUSPEND, &phy->state);
+	bool suspend = !test_bit(MT76_STATE_RUNNING, &phy->state);
 	struct ieee80211_hw *hw = phy->hw;
 	struct cfg80211_wowlan *wowlan = hw->wiphy->wowlan_config;
 	int i;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index e022251b4006..0b2a6b7f22ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1242,8 +1242,6 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 	mt7921_mutex_acquire(dev);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
-
-	set_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt76_connac_mcu_set_suspend_iter,
@@ -1262,7 +1260,6 @@ static int mt7921_resume(struct ieee80211_hw *hw)
 	mt7921_mutex_acquire(dev);
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
-	clear_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt76_connac_mcu_set_suspend_iter,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 5fee489c7a99..5c88b6b8d097 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -206,6 +206,8 @@ static int mt7921s_suspend(struct device *__dev)
 	int err;
 
 	pm->suspended = true;
+	set_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
+
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
@@ -213,10 +215,6 @@ static int mt7921s_suspend(struct device *__dev)
 	if (err < 0)
 		goto restore_suspend;
 
-	err = mt76_connac_mcu_set_hif_suspend(mdev, true);
-	if (err)
-		goto restore_suspend;
-
 	/* always enable deep sleep during suspend to reduce
 	 * power consumption
 	 */
@@ -224,34 +222,45 @@ static int mt7921s_suspend(struct device *__dev)
 
 	mt76_txq_schedule_all(&dev->mphy);
 	mt76_worker_disable(&mdev->tx_worker);
-	mt76_worker_disable(&mdev->sdio.txrx_worker);
 	mt76_worker_disable(&mdev->sdio.status_worker);
-	mt76_worker_disable(&mdev->sdio.net_worker);
 	cancel_work_sync(&mdev->sdio.stat_work);
 	clear_bit(MT76_READING_STATS, &dev->mphy.state);
-
 	mt76_tx_status_check(mdev, true);
 
-	err = mt7921_mcu_fw_pmctrl(dev);
+	mt76_worker_schedule(&mdev->sdio.txrx_worker);
+	wait_event_timeout(dev->mt76.sdio.wait,
+			   mt76s_txqs_empty(&dev->mt76), 5 * HZ);
+
+	/* It is supposed that SDIO bus is idle at the point */
+	err = mt76_connac_mcu_set_hif_suspend(mdev, true);
 	if (err)
 		goto restore_worker;
 
+	mt76_worker_disable(&mdev->sdio.txrx_worker);
+	mt76_worker_disable(&mdev->sdio.net_worker);
+
+	err = mt7921_mcu_fw_pmctrl(dev);
+	if (err)
+		goto restore_txrx_worker;
+
 	sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
 
 	return 0;
 
+restore_txrx_worker:
+	mt76_worker_enable(&mdev->sdio.net_worker);
+	mt76_worker_enable(&mdev->sdio.txrx_worker);
+	mt76_connac_mcu_set_hif_suspend(mdev, false);
+
 restore_worker:
 	mt76_worker_enable(&mdev->tx_worker);
-	mt76_worker_enable(&mdev->sdio.txrx_worker);
 	mt76_worker_enable(&mdev->sdio.status_worker);
-	mt76_worker_enable(&mdev->sdio.net_worker);
 
 	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(mdev, false);
 
-	mt76_connac_mcu_set_hif_suspend(mdev, false);
-
 restore_suspend:
+	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
 	pm->suspended = false;
 
 	return err;
@@ -266,6 +275,7 @@ static int mt7921s_resume(struct device *__dev)
 	int err;
 
 	pm->suspended = false;
+	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
 
 	err = mt7921_mcu_drv_pmctrl(dev);
 	if (err < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index c99acc21225e..b0bc7be0fb1f 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -479,7 +479,8 @@ static void mt76s_status_worker(struct mt76_worker *w)
 			resched = true;
 
 		if (dev->drv->tx_status_data &&
-		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
+		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state) &&
+		    !test_bit(MT76_STATE_SUSPEND, &dev->phy.state))
 			queue_work(dev->wq, &dev->sdio.stat_work);
 	} while (nframes > 0);
 
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index 649a56790b89..801590a0a334 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -317,7 +317,8 @@ void mt76s_txrx_worker(struct mt76_sdio *sdio)
 		if (ret > 0)
 			nframes += ret;
 
-		if (test_bit(MT76_MCU_RESET, &dev->phy.state)) {
+		if (test_bit(MT76_MCU_RESET, &dev->phy.state) ||
+		    test_bit(MT76_STATE_SUSPEND, &dev->phy.state)) {
 			if (!mt76s_txqs_empty(dev))
 				continue;
 			else
-- 
2.25.1

