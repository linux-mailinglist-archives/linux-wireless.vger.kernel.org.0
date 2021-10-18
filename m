Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F11432A16
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhJRXPO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:15:14 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:49105 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhJRXPM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:15:12 -0400
X-UUID: 70bd22d7221c453eb461ba6d17af8d3e-20211018
X-UUID: 70bd22d7221c453eb461ba6d17af8d3e-20211018
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1569291864; Mon, 18 Oct 2021 16:12:52 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 16:12:23 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Oct 2021 07:12:23 +0800
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
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v5 11/17] mt76: sdio: introduce parse_irq callback
Date:   Tue, 19 Oct 2021 07:11:41 +0800
Message-ID: <a2e0fa1a7537fc5319590979e9d2770661a55623.1634598341.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1634598341.git.objelf@gmail.com>
References: <cover.1634598341.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Add parse_irq to handle that interrupt status structure is
different between mt7663s and mt7921s.

This is a preliminary patch to introduce mt7921s driver

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 +++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 12 ++++++++++
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  | 23 ++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/sdio.h     | 10 ++++----
 .../net/wireless/mediatek/mt76/sdio_txrx.c    | 18 +++++++--------
 5 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8dc4bbaca15d..a3fc0c920f46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -29,6 +29,7 @@
 struct mt76_dev;
 struct mt76_phy;
 struct mt76_wcid;
+struct mt76s_intr;
 
 struct mt76_reg_pair {
 	u32 reg;
@@ -512,6 +513,8 @@ struct mt76_sdio {
 		int pse_mcu_quota;
 		int deficit;
 	} sched;
+
+	int (*parse_irq)(struct mt76_dev *dev, struct mt76s_intr *intr);
 };
 
 struct mt76_mmio {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 77bd59813d47..6ff6d5800918 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -107,6 +107,18 @@ struct mt7615_wtbl_rate_desc {
 	struct mt7615_sta *sta;
 };
 
+struct mt7663s_intr {
+	u32 isr;
+	struct {
+		u32 wtqcr[8];
+	} tx;
+	struct {
+		u16 num[2];
+		u16 len[2][16];
+	} rx;
+	u32 rec_mb[2];
+} __packed;
+
 struct mt7615_sta {
 	struct mt76_wcid wcid; /* must be first */
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 14108e3fadda..8d23dd4d5457 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -50,6 +50,26 @@ static void mt7663s_init_work(struct work_struct *work)
 	mt7615_init_work(dev);
 }
 
+static int mt7663s_parse_intr(struct mt76_dev *dev, struct mt76s_intr *intr)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	struct mt7663s_intr *irq_data = sdio->intr_data;
+	int i, err;
+
+	err = sdio_readsb(sdio->func, irq_data, MCR_WHISR, sizeof(*irq_data));
+	if (err)
+		return err;
+
+	intr->isr = irq_data->isr;
+	intr->rec_mb = irq_data->rec_mb;
+	intr->tx.wtqcr = irq_data->tx.wtqcr;
+	intr->rx.num = irq_data->rx.num;
+	for (i = 0; i < 2 ; i++)
+		intr->rx.len[i] = irq_data->rx.len[i];
+
+	return 0;
+}
+
 static int mt7663s_probe(struct sdio_func *func,
 			 const struct sdio_device_id *id)
 {
@@ -108,8 +128,9 @@ static int mt7663s_probe(struct sdio_func *func,
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	mdev->sdio.parse_irq = mt7663s_parse_intr;
 	mdev->sdio.intr_data = devm_kmalloc(mdev->dev,
-					    sizeof(struct mt76s_intr),
+					    sizeof(struct mt7663s_intr),
 					    GFP_KERNEL);
 	if (!mdev->sdio.intr_data) {
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.h b/drivers/net/wireless/mediatek/mt76/sdio.h
index 03877d89e152..dfcba5e3786c 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.h
+++ b/drivers/net/wireless/mediatek/mt76/sdio.h
@@ -102,14 +102,14 @@
 
 struct mt76s_intr {
 	u32 isr;
+	u32 *rec_mb;
 	struct {
-		u32 wtqcr[8];
+		u32 *wtqcr;
 	} tx;
 	struct {
-		u16 num[2];
-		u16 len[2][16];
+		u16 *len[2];
+		u16 *num;
 	} rx;
-	u32 rec_mb[2];
-} __packed;
+};
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index ceb3dc0613d6..f94de48ebadc 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -135,32 +135,32 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 static int mt76s_rx_handler(struct mt76_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
-	struct mt76s_intr *intr = sdio->intr_data;
+	struct mt76s_intr intr;
 	int nframes = 0, ret;
 
-	ret = sdio_readsb(sdio->func, intr, MCR_WHISR, sizeof(*intr));
-	if (ret < 0)
+	ret = sdio->parse_irq(dev, &intr);
+	if (ret)
 		return ret;
 
-	trace_dev_irq(dev, intr->isr, 0);
+	trace_dev_irq(dev, intr.isr, 0);
 
-	if (intr->isr & WHIER_RX0_DONE_INT_EN) {
-		ret = mt76s_rx_run_queue(dev, 0, intr);
+	if (intr.isr & WHIER_RX0_DONE_INT_EN) {
+		ret = mt76s_rx_run_queue(dev, 0, &intr);
 		if (ret > 0) {
 			mt76_worker_schedule(&sdio->net_worker);
 			nframes += ret;
 		}
 	}
 
-	if (intr->isr & WHIER_RX1_DONE_INT_EN) {
-		ret = mt76s_rx_run_queue(dev, 1, intr);
+	if (intr.isr & WHIER_RX1_DONE_INT_EN) {
+		ret = mt76s_rx_run_queue(dev, 1, &intr);
 		if (ret > 0) {
 			mt76_worker_schedule(&sdio->net_worker);
 			nframes += ret;
 		}
 	}
 
-	nframes += !!mt76s_refill_sched_quota(dev, intr->tx.wtqcr);
+	nframes += !!mt76s_refill_sched_quota(dev, intr.tx.wtqcr);
 
 	return nframes;
 }
-- 
2.25.1

