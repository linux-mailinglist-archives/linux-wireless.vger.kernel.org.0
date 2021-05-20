Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08974389C05
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 05:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhETDsW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 23:48:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44451 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229554AbhETDsU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 23:48:20 -0400
X-UUID: 0e109272833742f7aac13c37bc65eb3e-20210520
X-UUID: 0e109272833742f7aac13c37bc65eb3e-20210520
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 324472826; Thu, 20 May 2021 11:46:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 May 2021 11:46:55 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 May 2021 11:46:54 +0800
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
Subject: [PATCH 5/7] mt76: mt7921: fix invalid register access in wake_work
Date:   Thu, 20 May 2021 11:46:39 +0800
Message-ID: <1621482401-29025-5-git-send-email-sean.wang@mediatek.com>
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

Make sure mt7921_pm_wake_work wouldn't be scheduled after the driver is
in suspend mode to fix the following the kernel crash.

[ 3515.390012] mt7921e 0000:01:00.0: calling pci_pm_suspend+0x0/0x22c @ 2869, parent: 0000:00:00.0
[ 3515.390015] mt7921e 0000:01:00.0: mt7921_pci_suspend +
[ 3515.396395] anx7625 3-0058: anx7625_suspend+0x0/0x6c returned 0 after 0 usecs
[ 3515.405965] mt7921e 0000:01:00.0: mt7921_pci_suspend -
[ 3515.411336] usb 1-1.4: usb_dev_suspend+0x0/0x2c returned 0 after 1 usecs
[ 3515.411513] SError Interrupt on CPU7, code 0xbe000011 -- SError
[ 3515.411515] CPU: 7 PID: 2849 Comm: kworker/u16:27 Not tainted 5.4.114 #44
[ 3515.411516] Hardware name: MediaTek Asurada rev1 board (DT)
[ 3515.411517] Workqueue: mt76 mt7921_pm_wake_work [mt7921e]
[ 3515.411518] pstate: 80c00009 (Nzcv daif +PAN +UAO)
[ 3515.411519] pc : mt76_mmio_rr+0x30/0xf0 [mt76]
[ 3515.411520] lr : mt7921_rr+0x38/0x44 [mt7921e]
[ 3515.411520] sp : ffffffc015813c50
[ 3515.411521] x29: ffffffc015813c50 x28: 0000000000000402
[ 3515.411522] x27: ffffffe5a2012138 x26: ffffffe5a1eea018
[ 3515.411524] x25: 00000000328be505 x24: 00000000000a0002
[ 3515.411525] x23: 0000000000000006 x22: ffffffbd29b7a300
[ 3515.411527] x21: ffffffbd29b7a300 x20: 00000000000e0010
[ 3515.411528] x19: 00000000eac08f43 x18: 0000000000000000
[ 3515.411529] x17: 0000000000000000 x16: ffffffe5a16b2914
[ 3515.411531] x15: 0000000000000010 x14: 0000000000000010
[ 3515.411532] x13: 00000000003dd3a2 x12: 0000000000010000
[ 3515.411533] x11: ffffffe597abec14 x10: 0000000000000010
[ 3515.411535] x9 : ffffffe597abeba8 x8 : ffffffc013ce0010
[ 3515.411536] x7 : 000000b2b5593519 x6 : 0000000000300000
[ 3515.411537] x5 : 0000000000000000 x4 : 0000000000000032
[ 3515.411539] x3 : 0000000000000000 x2 : 0000000000000004
[ 3515.411540] x1 : 00000000000e0010 x0 : ffffffbd29b7a300
[ 3515.411542] Kernel panic - not syncing: Asynchronous SError Interrupt
[ 3515.411543] CPU: 7 PID: 2849 Comm: kworker/u16:27 Not tainted 5.4.114 #44
[ 3515.411544] Hardware name: MediaTek Asurada rev1 board (DT)
[ 3515.411544] Workqueue: mt76 mt7921_pm_wake_work [mt7921e]
[ 3515.411545] Call trace:
[ 3515.411546]  dump_backtrace+0x0/0x14c
[ 3515.411546]  show_stack+0x20/0x2c
[ 3515.411547]  dump_stack+0xa0/0xfc
[ 3515.411548]  panic+0x154/0x350
[ 3515.411548]  panic+0x0/0x350
[ 3515.411549]  arm64_serror_panic+0x78/0x84
[ 3515.411550]  do_serror+0x0/0x118
[ 3515.411550]  do_serror+0xa4/0x118
[ 3515.411551]  el1_error+0x84/0xf8
[ 3515.411552]  mt76_mmio_rr+0x30/0xf0 [mt76]
[ 3515.411552]  mt7921_rr+0x38/0x44 [mt7921e]
[ 3515.411553]  __mt76_poll_msec+0x5c/0x9c [mt76]
[ 3515.411554]  __mt7921_mcu_drv_pmctrl+0x50/0x94 [mt7921e]
[ 3515.411555]  mt7921_mcu_drv_pmctrl+0x38/0xb0 [mt7921e]
[ 3515.411555]  mt7921_pm_wake_work+0x34/0xd4 [mt7921e]
[ 3515.411556]  process_one_work+0x208/0x3c8
[ 3515.411557]  worker_thread+0x23c/0x3e8
[ 3515.411557]  kthread+0x144/0x178
[ 3515.411558]  ret_from_fork+0x10/0x18
[ 3515.418831] SMP: stopping secondary CPUs
[ 3515.418832] Kernel Offset: 0x2590c00000 from 0xffffffc010000000
[ 3515.418832] PHYS_OFFSET: 0xffffffc400000000
[ 3515.418833] CPU features: 0x080026,2a80aa18
[ 3515.418834] Memory Limit: none
[DL] 00000000 00000000 010701

Fixes: 1d8efc741df80 ("mt76: mt7921: introduce Runtime PM support")
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  1 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  6 +++++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 25 +++++++++++++------
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 337c5ece7ec3..63c1d1a68a70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -45,6 +45,7 @@ enum {
 
 struct mt76_connac_pm {
 	bool enable;
+	bool suspended;
 
 	spinlock_t txq_lock;
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 6f180c92d413..5f2705fbd680 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -17,6 +17,9 @@ int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 	if (!test_bit(MT76_STATE_PM, &phy->state))
 		return 0;
 
+	if (pm->suspended)
+		return 0;
+
 	queue_work(dev->wq, &pm->wake_work);
 	if (!wait_event_timeout(pm->wait,
 				!test_bit(MT76_STATE_PM, &phy->state),
@@ -40,6 +43,9 @@ void mt76_connac_power_save_sched(struct mt76_phy *phy,
 	if (!pm->enable)
 		return;
 
+	if (pm->suspended)
+		return;
+
 	pm->last_activity = jiffies;
 
 	if (!test_bit(MT76_STATE_PM, &phy->state)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index fa02d934f0bf..13263f50dc00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -188,21 +188,26 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt76_connac_pm *pm = &dev->pm;
 	bool hif_suspend;
 	int i, err;
 
-	err = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
+	pm->suspended = true;
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	err = mt7921_mcu_drv_pmctrl(dev);
 	if (err < 0)
-		return err;
+		goto restore_suspend;
 
 	hif_suspend = !test_bit(MT76_STATE_SUSPEND, &dev->mphy.state);
 	if (hif_suspend) {
 		err = mt76_connac_mcu_set_hif_suspend(mdev, true);
 		if (err)
-			return err;
+			goto restore_suspend;
 	}
 
-	if (!dev->pm.enable)
+	if (!pm->enable)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, true);
 
 	napi_disable(&mdev->tx_napi);
@@ -231,27 +236,30 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 
 	err = mt7921_mcu_fw_pmctrl(dev);
 	if (err)
-		goto restore;
+		goto restore_napi;
 
 	pci_save_state(pdev);
 	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	if (err)
-		goto restore;
+		goto restore_napi;
 
 	return 0;
 
-restore:
+restore_napi:
 	mt76_for_each_q_rx(mdev, i) {
 		napi_enable(&mdev->napi[i]);
 	}
 	napi_enable(&mdev->tx_napi);
 
-	if (!dev->pm.enable)
+	if (!pm->enable)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
 
 	if (hif_suspend)
 		mt76_connac_mcu_set_hif_suspend(mdev, false);
 
+restore_suspend:
+	pm->suspended = false;
+
 	return err;
 }
 
@@ -261,6 +269,7 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	int i, err;
 
+	dev->pm.suspended = false;
 	err = pci_set_power_state(pdev, PCI_D0);
 	if (err)
 		return err;
-- 
2.25.1

