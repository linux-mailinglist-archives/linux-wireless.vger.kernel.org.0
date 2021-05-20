Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E62389C03
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 05:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhETDsP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 23:48:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44371 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229554AbhETDsO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 23:48:14 -0400
X-UUID: 9e049adfae294f568a8797ea30dfcafa-20210520
X-UUID: 9e049adfae294f568a8797ea30dfcafa-20210520
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1427075522; Thu, 20 May 2021 11:46:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 May 2021 11:46:48 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 May 2021 11:46:48 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 3/7] mt76: mt7921: fix reset under the deep sleep is enabled
Date:   Thu, 20 May 2021 11:46:37 +0800
Message-ID: <1621482401-29025-3-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1621482401-29025-1-git-send-email-sean.wang@mediatek.com>
References: <1621482401-29025-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

To fix possibly the race to access register between the WiFi reset
and the other context that is caused by explicitly cancelling ps_work
and wake_work to break PM_STATE consistency.

Deep sleep would cause the hardware into the inactive state,
so we forcely put device drv_own state before we start to reset.

The patch also ignore the reset request when the procedure is in
progress to avoid the consecutive WiFi resets.

localhost ~ # [ 2932.073966] SError Interrupt on CPU7, code 0xbe000011
[ 2932.073967] CPU: 7 PID: 8761 Comm: kworker/u16:2 Not tainted 5.4.112 #30
[ 2932.073968] Hardware name: MediaTek Asurada rev1 board (DT)
[ 2932.073968] Workqueue: phy0 ieee80211_reconfig_filter [mac80211]
[ 2932.073969] pstate: 80400089 (Nzcv daIf +PAN -UAO)
[ 2932.073969] pc : el1_irq+0x78/0x180
[ 2932.073970] lr : mt76_mmio_rmw+0x30/0x5c [mt76]
[ 2932.073970] sp : ffffffc01142bad0
[ 2932.073970] x29: ffffffc01142bc00 x28: ffffff8f96fb1e00
[ 2932.073971] x27: ffffffd2cdc12138 x26: ffffffd2cdaeb018
[ 2932.073972] x25: 0000000000000000 x24: ffffff8fa8e14c08
[ 2932.073973] x23: 0000000080c00009 x22: ffffffd2a5603918
[ 2932.073974] x21: ffffffc01142bc10 x20: 0000007fffffffff
[ 2932.073975] x19: 0000000000000000 x18: 0000000000000400
[ 2932.073975] x17: 0000000000000400 x16: ffffffd2cd2b87dc
[ 2932.073976] x15: 0000000000000000 x14: 0000000000000000
[ 2932.073977] x13: 0000000000000001 x12: 0000000000000001
[ 2932.073978] x11: 0000000000000001 x10: 000000000010e000
[ 2932.073978] x9 : 0000000000000000 x8 : ffffffc013921404
[ 2932.073979] x7 : 000000b2b5593519 x6 : 0000000000300000
[ 2932.073980] x5 : 0000000000000000 x4 : ffffffc01142bbc8
[ 2932.073980] x3 : 00000000000001f0 x2 : 0000000000000000
[ 2932.073981] x1 : 0000000000021404 x0 : ffffff8fa8e12300
[ 2932.073982] Kernel panic - not syncing: Asynchronous SError Interrupt
[ 2932.073983] CPU: 7 PID: 8761 Comm: kworker/u16:2 Not tainted 5.4.112 #30
[ 2932.073983] Hardware name: MediaTek Asurada rev1 board (DT)
[ 2932.073984] Workqueue: phy0 ieee80211_reconfig_filter [mac80211]
[ 2932.073984] Call trace:
[ 2932.073985]  dump_backtrace+0x0/0x14c
[ 2932.073985]  show_stack+0x20/0x2c
[ 2932.073985]  dump_stack+0xa0/0xf8
[ 2932.073986]  panic+0x154/0x360
[ 2932.073986]  test_taint+0x0/0x44
[ 2932.073986]  arm64_serror_panic+0x78/0x84
[ 2932.073987]  do_serror+0x0/0x118
[ 2932.073987]  do_serror+0xa4/0x118
[ 2932.073987]  el1_error+0x84/0xf8
[ 2932.073988]  el1_irq+0x78/0x180
[ 2932.073988]  mt76_mmio_rr+0x30/0xf0 [mt76]
[ 2932.073988]  mt76_mmio_rmw+0x30/0x5c [mt76]
[ 2932.073989]  mt7921_rmw+0x4c/0x5c [mt7921e]
[ 2932.073989]  mt7921_configure_filter+0x138/0x160 [mt7921e]
[ 2932.073990]  ieee80211_configure_filter+0x2f0/0x3e0 [mac80211]
[ 2932.073990]  ieee80211_reconfig_filter+0x1c/0x28 [mac80211]
[ 2932.073990]  process_one_work+0x208/0x3c8
[ 2932.073991]  worker_thread+0x23c/0x3e8
[ 2932.073991]  kthread+0x140/0x17c
[ 2932.073992]  ret_from_fork+0x10/0x18
[ 2932.074071] SMP: stopping secondary CPUs
[ 2932.074071] Kernel Offset: 0x12bc800000 from 0xffffffc010000000
[ 2932.074072] PHYS_OFFSET: 0xfffffff180000000
[ 2932.074072] CPU features: 0x080026,2a80aa18
[ 2932.074072] Memory Limit: none

Fixes: 87843566e581 ("mt76: mt7921: enable deep sleep at runtime")
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 21 +++++++++--------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 23 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index e29d4fdab572..ebd365ceb70d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1284,9 +1284,10 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
-	clear_bit(MT76_STATE_PM, &dev->mphy.state);
 
-	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA,
+		MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
+		MT_INT_MCU_CMD);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 
 	err = mt7921_run_firmware(dev);
@@ -1304,22 +1305,23 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 /* system error recovery */
 void mt7921_mac_reset_work(struct work_struct *work)
 {
-	struct ieee80211_hw *hw;
-	struct mt7921_dev *dev;
+	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
+					      reset_work);
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt76_connac_pm *pm = &dev->pm;
 	int i;
 
-	dev = container_of(work, struct mt7921_dev, reset_work);
-	hw = mt76_hw(dev);
-
 	dev_err(dev->mt76.dev, "chip reset\n");
 	ieee80211_stop_queues(hw);
 
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
-	cancel_delayed_work_sync(&dev->pm.ps_work);
-	cancel_work_sync(&dev->pm.wake_work);
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
 
 	mutex_lock(&dev->mt76.mutex);
 	for (i = 0; i < 10; i++) {
+		__mt7921_mcu_drv_pmctrl(dev);
+
 		if (!mt7921_mac_reset(dev))
 			break;
 	}
@@ -1340,6 +1342,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_vif_connect_iter, NULL);
+	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
 }
 
 void mt7921_reset(struct mt76_dev *mdev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 5a4c695f73c9..486e5593d99a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1296,17 +1296,12 @@ int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 	return mt76_connac_mcu_add_sta_cmd(&dev->mphy, &info);
 }
 
-int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
+int __mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_connac_pm *pm = &dev->pm;
 	int i, err = 0;
 
-	mutex_lock(&pm->mutex);
-
-	if (!test_bit(MT76_STATE_PM, &mphy->state))
-		goto out;
-
 	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
 		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_CLR_OWN);
 		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
@@ -1326,6 +1321,22 @@ int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 	pm->stats.last_wake_event = jiffies;
 	pm->stats.doze_time += pm->stats.last_wake_event -
 			       pm->stats.last_doze_event;
+out:
+	return err;
+}
+
+int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	int err = 0;
+
+	mutex_lock(&pm->mutex);
+
+	if (!test_bit(MT76_STATE_PM, &mphy->state))
+		goto out;
+
+	err = __mt7921_mcu_drv_pmctrl(dev);
 out:
 	mutex_unlock(&pm->mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 59862ea4951c..03bcb210c357 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -368,6 +368,7 @@ int mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			     bool enable);
 int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
+int __mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
 void mt7921_pm_wake_work(struct work_struct *work);
-- 
2.25.1

