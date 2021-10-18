Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E336432A15
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhJRXPN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:15:13 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:49105 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhJRXPM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:15:12 -0400
X-UUID: 96f300e84c2a4b9da00d1d25f14ce75d-20211018
X-UUID: 96f300e84c2a4b9da00d1d25f14ce75d-20211018
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 945009941; Mon, 18 Oct 2021 16:12:52 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 16:12:40 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Oct 2021 07:12:39 +0800
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
        <linux-mediatek@lists.infradead.org>,
        "Deren Wu" <deren.wu@mediatek.com>
Subject: [PATCH v5 17/17] mt76: mt7921s: add reset support
Date:   Tue, 19 Oct 2021 07:11:47 +0800
Message-ID: <3dd4af1dd597ce6d0cab81ca0b5ae0256174817f.1634598341.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1634598341.git.objelf@gmail.com>
References: <cover.1634598341.git.objelf@gmail.com>
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
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   2 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   2 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |   1 +
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   4 +
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |   3 +
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  | 133 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |   8 ++
 .../net/wireless/mediatek/mt76/sdio_txrx.c    |  32 ++++-
 8 files changed, 184 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 46e8fe3869c2..32d68ecf4c3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -507,6 +507,7 @@ struct mt76_sdio {
 	struct sdio_func *func;
 	void *intr_data;
 	u8 hw_ver;
+	wait_queue_head_t wait;
 
 	struct {
 		int pse_data_quota;
@@ -1255,6 +1256,7 @@ int mt76s_alloc_tx(struct mt76_dev *dev);
 void mt76s_deinit(struct mt76_dev *dev);
 void mt76s_sdio_irq(struct sdio_func *func);
 void mt76s_txrx_worker(struct mt76_sdio *sdio);
+bool mt76s_txqs_empty(struct mt76_dev *dev);
 int mt76s_hw_init(struct mt76_dev *dev, struct sdio_func *func,
 		  int hw_ver);
 u32 mt76s_rr(struct mt76_dev *dev, u32 offset);
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
index 571f559d3363..6ada1ebe7d68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -438,6 +438,7 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 		mt7921_mcu_debug_msg_event(dev, skb);
 		break;
 	case MCU_EVENT_COREDUMP:
+		dev->fw_assert = true;
 		mt76_connac_mcu_coredump_event(&dev->mt76, skb,
 					       &dev->coredump);
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 05e0d4371d32..eebf367be296 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -182,6 +182,7 @@ struct mt7921_dev {
 	struct work_struct reset_work;
 	bool hw_full_reset:1;
 	bool hw_init_done:1;
+	bool fw_assert:1;
 
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
@@ -425,6 +426,9 @@ void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			  struct sk_buff *skb);
 int mt7921e_mac_reset(struct mt7921_dev *dev);
 int mt7921e_mcu_init(struct mt7921_dev *dev);
+int mt7921s_wfsys_reset(struct mt7921_dev *dev);
+int mt7921s_mac_reset(struct mt7921_dev *dev);
+int mt7921s_init_reset(struct mt7921_dev *dev);
 int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index e0ad97f27fea..ddf0eeb8b688 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -46,6 +46,7 @@ static void mt7921s_unregister_device(struct mt7921_dev *dev)
 	cancel_work_sync(&pm->wake_work);
 
 	mt76s_deinit(&dev->mt76);
+	mt7921s_wfsys_reset(dev);
 	mt7921_mcu_exit(dev);
 
 	mt76_free_device(&dev->mt76);
@@ -104,6 +105,8 @@ static int mt7921s_probe(struct sdio_func *func,
 		.type = MT76_BUS_SDIO,
 	};
 	static const struct mt7921_hif_ops mt7921_sdio_ops = {
+		.init_reset = mt7921s_init_reset,
+		.reset = mt7921s_mac_reset,
 		.mcu_init = mt7921s_mcu_init,
 		.drv_own = mt7921s_mcu_drv_pmctrl,
 		.fw_own = mt7921s_mcu_fw_pmctrl,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index 91a7acd49ee4..137f86a6dbf8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -5,6 +5,139 @@
 #include <linux/mmc/sdio_func.h>
 #include "mt7921.h"
 #include "mac.h"
+#include "../sdio.h"
+
+static void mt7921s_enable_irq(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
+	sdio_release_host(sdio->func);
+}
+
+static void mt7921s_disable_irq(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
+	sdio_release_host(sdio->func);
+}
+
+static u32 mt7921s_read_whcr(struct mt76_dev *dev)
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
+	readx_poll_timeout(mt7921s_read_whcr, &dev->mt76, status,
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
+			   mt76s_txqs_empty(&dev->mt76), 5 * HZ);
+	mt76_worker_disable(&dev->mt76.sdio.txrx_worker);
+
+	mt7921s_disable_irq(&dev->mt76);
+	mt7921s_wfsys_reset(dev);
+
+	mt76_worker_enable(&dev->mt76.sdio.txrx_worker);
+	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	mt7921s_enable_irq(&dev->mt76);
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
+			   mt76s_txqs_empty(&dev->mt76), 5 * HZ);
+	mt76_worker_disable(&dev->mt76.sdio.txrx_worker);
+	mt76_worker_disable(&dev->mt76.sdio.status_worker);
+	mt76_worker_disable(&dev->mt76.sdio.net_worker);
+	cancel_work_sync(&dev->mt76.sdio.stat_work);
+
+	mt7921s_disable_irq(&dev->mt76);
+	mt7921s_wfsys_reset(dev);
+
+	mt76_worker_enable(&dev->mt76.sdio.txrx_worker);
+	mt76_worker_enable(&dev->mt76.sdio.status_worker);
+	mt76_worker_enable(&dev->mt76.sdio.net_worker);
+
+	dev->fw_assert = false;
+	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	mt7921s_enable_irq(&dev->mt76);
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
 
 static void
 mt7921s_write_txwi(struct mt7921_dev *dev, struct mt76_wcid *wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index 049e06d7c3fb..437cddad9a90 100644
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
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index 9b4c95a47d47..649a56790b89 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -235,6 +235,9 @@ static int mt76s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 
 		smp_rmb();
 
+		if (test_bit(MT76_MCU_RESET, &dev->phy.state))
+			goto next;
+
 		if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state)) {
 			__skb_put_zero(e->skb, 4);
 			err = __mt76s_xmit_queue(dev, e->skb->data,
@@ -313,6 +316,13 @@ void mt76s_txrx_worker(struct mt76_sdio *sdio)
 		ret = mt76s_rx_handler(dev);
 		if (ret > 0)
 			nframes += ret;
+
+		if (test_bit(MT76_MCU_RESET, &dev->phy.state)) {
+			if (!mt76s_txqs_empty(dev))
+				continue;
+			else
+				wake_up(&sdio->wait);
+		}
 	} while (nframes > 0);
 
 	/* enable interrupt */
@@ -326,9 +336,29 @@ void mt76s_sdio_irq(struct sdio_func *func)
 	struct mt76_dev *dev = sdio_get_drvdata(func);
 	struct mt76_sdio *sdio = &dev->sdio;
 
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state) ||
+	    test_bit(MT76_MCU_RESET, &dev->phy.state))
 		return;
 
 	mt76_worker_schedule(&sdio->txrx_worker);
 }
 EXPORT_SYMBOL_GPL(mt76s_sdio_irq);
+
+bool mt76s_txqs_empty(struct mt76_dev *dev)
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
+EXPORT_SYMBOL_GPL(mt76s_txqs_empty);
-- 
2.25.1

