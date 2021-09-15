Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709D040BD2E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 03:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhIOB0s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 21:26:48 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:51734 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhIOB0r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 21:26:47 -0400
X-UUID: 153fecff784846a0b127c441dcadd425-20210914
X-UUID: 153fecff784846a0b127c441dcadd425-20210914
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1043661838; Tue, 14 Sep 2021 18:25:25 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 18:15:56 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 09:15:56 +0800
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
        <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v1 16/16] mt76: mt7921s: add reset support
Date:   Wed, 15 Sep 2021 09:14:49 +0800
Message-ID: <d88e4c17f020399a9f136ec59f6cec229ab153f8.1631667941.git.objelf@gmail.com>
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

Introduce wifi chip reset support for mt7921 device to recover
mcu hangs or abnormal wifi system.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../wireless/mediatek/mt76/mt76_connac_sdio.c |  20 +++
 .../wireless/mediatek/mt76/mt76_connac_sdio.h |   3 +
 .../mediatek/mt76/mt76_connac_sdio_txrx.c     |  29 +++++
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   2 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |   1 +
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   5 +
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |   5 +-
 .../wireless/mediatek/mt76/mt7921/sdio_init.c |   1 +
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  | 114 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |   8 ++
 11 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3062cda2e770..a4e09373dcdc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -507,6 +507,7 @@ struct mt76_sdio {
 	void *intr_data;
 	int intr_size;
 	u8 hw_ver;
+	wait_queue_head_t wait;
 
 	struct {
 		int pse_data_quota;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.c
index c11f044841dd..075557844dfd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.c
@@ -338,6 +338,26 @@ int mt76_connac_sdio_init(struct mt76_dev *dev,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_sdio_init);
 
+void mt76_connac_sdio_enable_irq(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
+	sdio_release_host(sdio->func);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_sdio_enable_irq);
+
+void mt76_connac_sdio_disable_irq(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
+	sdio_release_host(sdio->func);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_sdio_disable_irq);
+
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.h
index a476e54361cc..e4395a332cff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.h
@@ -182,4 +182,7 @@ int mt76_connac_sdio_hw_init(struct mt76_dev *dev, struct sdio_func *func,
 			     int hw_ver, sdio_irq_handler_t *irq_handler);
 int mt76_connac_sdio_init(struct mt76_dev *dev,
 			  void (*txrx_worker)(struct mt76_worker *));
+void mt76_connac_sdio_enable_irq(struct mt76_dev *dev);
+void mt76_connac_sdio_disable_irq(struct mt76_dev *dev);
+bool mt76_connac_sdio_txqs_empty(struct mt76_dev *dev);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio_txrx.c
index 22a8058a1705..b4b96edfbdb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio_txrx.c
@@ -275,6 +275,9 @@ static int mt76_connac_sdio_tx_run_queue(struct mt76_dev *dev,
 
 		smp_rmb();
 
+		if (test_bit(MT76_MCU_RESET, &dev->phy.state))
+			goto next;
+
 		if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state)) {
 			__skb_put_zero(e->skb, 4);
 			err = __mt76_connac_sdio_xmit_queue(dev, e->skb->data,
@@ -327,6 +330,25 @@ static int mt76_connac_sdio_tx_run_queue(struct mt76_dev *dev,
 	return nframes;
 }
 
+bool mt76_connac_sdio_txqs_empty(struct mt76_dev *dev)
+{
+	struct mt76_queue *q;
+	int i;
+
+	for (i = 0; i <= MT_TXQ_PSD + 1; i++) {
+		if (i <= MT_TXQ_PSD)
+			q = dev->phy.q_tx[i];
+		else
+			q = dev->q_mcu[MT_MCUQ_WM];
+
+		if (q->first != q->head)
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_sdio_txqs_empty);
+
 void mt76_connac_sdio_txrx(struct mt76_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
@@ -353,6 +375,13 @@ void mt76_connac_sdio_txrx(struct mt76_dev *dev)
 		ret = mt76_connac_sdio_rx_handler(dev);
 		if (ret > 0)
 			nframes += ret;
+
+		if (test_bit(MT76_MCU_RESET, &dev->phy.state)) {
+			if (!mt76_connac_sdio_txqs_empty(dev))
+				continue;
+			else
+				wake_up(&sdio->wait);
+		}
 	} while (nframes > 0);
 
 	/* enable interrupt */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 2b7260be224f..87265045e2dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -217,6 +217,8 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	spin_lock_init(&dev->pm.wake.lock);
 	mutex_init(&dev->pm.mutex);
 	init_waitqueue_head(&dev->pm.wait);
+	if (mt76_is_sdio(&dev->mt76))
+		init_waitqueue_head(&dev->mt76.sdio.wait);
 	spin_lock_init(&dev->pm.txq_lock);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7921_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7921_scan_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index e20bfa5f05c4..d2e2aa6cfb49 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -441,6 +441,7 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 		mt7921_mcu_debug_msg_event(dev, skb);
 		break;
 	case MCU_EVENT_COREDUMP:
+		dev->fw_assert = true;
 		mt76_connac_mcu_coredump_event(&dev->mt76, skb,
 					       &dev->coredump);
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index a94baa024e3c..43e344aa6d97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -169,6 +169,7 @@ struct mt7921_dev {
 	struct work_struct reset_work;
 	bool hw_full_reset:1;
 	bool hw_init_done:1;
+	bool fw_assert:1;
 
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
@@ -412,6 +413,9 @@ int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
 int mt7921e_init_reset(struct mt7921_dev *dev);
 
 int mt7921s_mcu_init(struct mt7921_dev *dev);
+int mt7921s_wfsys_reset(struct mt7921_dev *dev);
+int mt7921s_mac_reset(struct mt7921_dev *dev);
+int mt7921s_init_reset(struct mt7921_dev *dev);
 void mt7921s_unregister_device(struct mt7921_dev *dev);
 int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev);
@@ -421,4 +425,5 @@ int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			   struct mt76_tx_info *tx_info);
 void mt7921s_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update);
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 786025360fcb..3afc23ff81c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -43,7 +43,8 @@ static void mt7921s_irq(struct sdio_func *func)
 	struct mt7921_dev *dev = sdio_get_drvdata(func);
 	struct mt76_sdio *sdio = &dev->mt76.sdio;
 
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.phy.state))
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.phy.state) ||
+	     test_bit(MT76_MCU_RESET, &dev->mt76.phy.state))
 		return;
 
 	mt76_worker_schedule(&sdio->txrx_worker);
@@ -78,6 +79,8 @@ static int mt7921s_probe(struct sdio_func *func,
 		.type = MT76_BUS_SDIO,
 	};
 	static const struct mt7921_hif_ops mt7921_sdio_ops = {
+		.init_reset = mt7921s_init_reset,
+		.reset = mt7921s_mac_reset,
 		.mcu_init = mt7921s_mcu_init,
 		.drv_own = mt7921s_mcu_drv_pmctrl,
 		.fw_own = mt7921s_mcu_fw_pmctrl,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_init.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_init.c
index 2ede48efa989..d87a4b2dfda2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_init.c
@@ -16,6 +16,7 @@ void mt7921s_unregister_device(struct mt7921_dev *dev)
 	cancel_work_sync(&pm->wake_work);
 
 	mt76s_deinit(&dev->mt76);
+	mt7921s_wfsys_reset(dev);
 	mt7921_mcu_exit(dev);
 
 	mt76_free_device(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index 4d53a9281a75..9c899c11c60f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -7,6 +7,120 @@
 #include "mac.h"
 #include "../mt76_connac_sdio.h"
 
+static u32 mt7921s_sdio_read_whcr(struct mt76_dev *dev)
+{
+	return sdio_readl(dev->sdio.func, MCR_WHCR, NULL);
+}
+
+int mt7921s_wfsys_reset(struct mt7921_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	u32 val, status;
+
+	mt7921s_mcu_drv_pmctrl(dev);
+
+	sdio_claim_host(sdio->func);
+
+	val = sdio_readl(sdio->func, MCR_WHCR, NULL);
+	val &= ~WF_WHOLE_PATH_RSTB;
+	sdio_writel(sdio->func, val, MCR_WHCR, NULL);
+
+	msleep(50);
+
+	val = sdio_readl(sdio->func, MCR_WHCR, NULL);
+	val &= ~WF_SDIO_WF_PATH_RSTB;
+	sdio_writel(sdio->func, val, MCR_WHCR, NULL);
+
+	usleep_range(1000, 2000);
+
+	val = sdio_readl(sdio->func, MCR_WHCR, NULL);
+	val |= WF_WHOLE_PATH_RSTB;
+	sdio_writel(sdio->func, val, MCR_WHCR, NULL);
+
+	readx_poll_timeout(mt7921s_sdio_read_whcr, &dev->mt76, status,
+			   status & WF_RST_DONE, 50000, 2000000);
+
+	sdio_release_host(sdio->func);
+
+	/* activate mt7921s again */
+	mt7921s_mcu_fw_pmctrl(dev);
+	mt7921s_mcu_drv_pmctrl(dev);
+
+	return 0;
+}
+
+int mt7921s_init_reset(struct mt7921_dev *dev)
+{
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+
+	wake_up(&dev->mt76.mcu.wait);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+	wait_event_timeout(dev->mt76.sdio.wait,
+			   mt76_connac_sdio_txqs_empty(&dev->mt76), 5 * HZ);
+	mt76_worker_disable(&dev->mt76.sdio.txrx_worker);
+
+	mt76_connac_sdio_disable_irq(&dev->mt76);
+	mt7921s_wfsys_reset(dev);
+
+	mt76_worker_enable(&dev->mt76.sdio.txrx_worker);
+	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	mt76_connac_sdio_enable_irq(&dev->mt76);
+
+	return 0;
+}
+
+int mt7921s_mac_reset(struct mt7921_dev *dev)
+{
+	int err;
+
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+	mt76_txq_schedule_all(&dev->mphy);
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+	wait_event_timeout(dev->mt76.sdio.wait,
+			   mt76_connac_sdio_txqs_empty(&dev->mt76), 5 * HZ);
+	mt76_worker_disable(&dev->mt76.sdio.txrx_worker);
+	mt76_worker_disable(&dev->mt76.sdio.status_worker);
+	mt76_worker_disable(&dev->mt76.sdio.net_worker);
+	cancel_work_sync(&dev->mt76.sdio.stat_work);
+
+	mt76_connac_sdio_disable_irq(&dev->mt76);
+	mt7921s_wfsys_reset(dev);
+
+	mt76_worker_enable(&dev->mt76.sdio.txrx_worker);
+	mt76_worker_enable(&dev->mt76.sdio.status_worker);
+	mt76_worker_enable(&dev->mt76.sdio.net_worker);
+
+	dev->fw_assert = false;
+	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	mt76_connac_sdio_enable_irq(&dev->mt76);
+
+	err = mt7921_run_firmware(dev);
+	if (err)
+		goto out;
+
+	err = mt7921_mcu_set_eeprom(dev);
+	if (err)
+		goto out;
+
+	err = mt7921_mac_init(dev);
+	if (err)
+		goto out;
+
+	err = __mt7921_start(&dev->phy);
+out:
+	clear_bit(MT76_RESET, &dev->mphy.state);
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	return err;
+}
+
 static void
 mt7921s_write_txwi(struct mt7921_dev *dev, struct mt76_wcid *wcid,
 		   enum mt76_txq_id qid, struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index 12cb7e8bb9f0..2b5544aa1c16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -21,6 +21,14 @@ mt7921s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	enum mt76_mcuq_id txq = MT_MCUQ_WM;
 	int ret, pad;
 
+	/* We just return in case firmware assertion to avoid blocking the
+	 * common workqueue to run, for example, the coredump work might be
+	 * blocked by mt7921_mac_work that is excuting register access via sdio
+	 * bus.
+	 */
+	if (dev->fw_assert)
+		return -EBUSY;
+
 	ret = mt7921_mcu_fill_message(mdev, skb, cmd, seq);
 	if (ret)
 		return ret;
-- 
2.25.1

