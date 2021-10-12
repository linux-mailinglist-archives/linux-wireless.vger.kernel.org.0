Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B65542AFEC
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 01:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhJLXEz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 19:04:55 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:31520 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbhJLXEy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 19:04:54 -0400
X-UUID: 32416450fb034d93b2c42dd7d17c552e-20211012
X-UUID: 32416450fb034d93b2c42dd7d17c552e-20211012
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 911336742; Tue, 12 Oct 2021 16:02:50 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 Oct 2021 15:52:48 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Oct 2021 06:52:47 +0800
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
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v4 11/16] mt76: sdio: extend sdio module to support CONNAC2
Date:   Wed, 13 Oct 2021 06:52:04 +0800
Message-ID: <654f1b4b4f5c5b566e8a64795a3c8ebcc19a7593.1634077769.git.objelf@gmail.com>
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

Extend sdio module to support CONNAC2 hw that mt7921s rely on.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  5 +-
 drivers/net/wireless/mediatek/mt76/sdio.c     | 23 ++++++-
 drivers/net/wireless/mediatek/mt76/sdio.h     | 50 ++++++++++++++-
 .../net/wireless/mediatek/mt76/sdio_txrx.c    | 62 ++++++++++++++++---
 5 files changed, 128 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e2f33956a122..06f0d1348d52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -505,6 +505,8 @@ struct mt76_sdio {
 
 	struct sdio_func *func;
 	void *intr_data;
+	int intr_size;
+	u8 hw_ver;
 
 	struct {
 		int pse_data_quota;
@@ -1249,7 +1251,8 @@ int mt76s_alloc_queues(struct mt76_dev *dev);
 void mt76s_deinit(struct mt76_dev *dev);
 void mt76s_sdio_irq(struct sdio_func *func);
 void mt76s_txrx_worker(struct mt76_sdio *sdio);
-int mt76s_hw_init(struct mt76_dev *dev, struct sdio_func *func);
+int mt76s_hw_init(struct mt76_dev *dev, struct sdio_func *func,
+		  int hw_ver);
 u32 mt76s_rr(struct mt76_dev *dev, u32 offset);
 void mt76s_wr(struct mt76_dev *dev, u32 offset, u32 val);
 u32 mt76s_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32 val);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index f47e25f6dedb..a6b5d536d962 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -100,7 +100,7 @@ static int mt7663s_probe(struct sdio_func *func,
 	if (ret < 0)
 		goto error;
 
-	ret = mt76s_hw_init(mdev, func);
+	ret = mt76s_hw_init(mdev, func, MT76_CONNAC_SDIO);
 	if (ret)
 		goto error;
 
@@ -108,8 +108,9 @@ static int mt7663s_probe(struct sdio_func *func,
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	mdev->sdio.intr_size = sizeof(struct mt76_connac_sdio_intr);
 	mdev->sdio.intr_data = devm_kmalloc(mdev->dev,
-					    sizeof(struct mt76s_intr),
+					    mdev->sdio.intr_size,
 					    GFP_KERNEL);
 	if (!mdev->sdio.intr_data) {
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 82fb4c110b90..bb40cc3e9c2b 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -221,11 +221,13 @@ int mt76s_rd_rp(struct mt76_dev *dev, u32 base,
 }
 EXPORT_SYMBOL_GPL(mt76s_rd_rp);
 
-int mt76s_hw_init(struct mt76_dev *dev, struct sdio_func *func)
+int mt76s_hw_init(struct mt76_dev *dev, struct sdio_func *func, int hw_ver)
 {
 	u32 status, ctrl;
 	int ret;
 
+	dev->sdio.hw_ver = hw_ver;
+
 	sdio_claim_host(func);
 
 	ret = sdio_enable_func(func);
@@ -255,12 +257,27 @@ int mt76s_hw_init(struct mt76_dev *dev, struct sdio_func *func)
 		goto disable_func;
 
 	ctrl = WHIER_RX0_DONE_INT_EN | WHIER_TX_DONE_INT_EN;
+	if (hw_ver == MT76_CONNAC2_SDIO)
+		ctrl |= WHIER_RX1_DONE_INT_EN;
 	sdio_writel(func, ctrl, MCR_WHIER, &ret);
 	if (ret < 0)
 		goto disable_func;
 
-	/* set WHISR as read clear and Rx aggregation number as 16 */
-	ctrl = FIELD_PREP(MAX_HIF_RX_LEN_NUM, 16);
+	switch (hw_ver) {
+	case MT76_CONNAC_SDIO:
+		/* set WHISR as read clear and Rx aggregation number as 16 */
+		ctrl = FIELD_PREP(MAX_HIF_RX_LEN_NUM, 16);
+		break;
+	default:
+		ctrl = sdio_readl(func, MCR_WHCR, &ret);
+		if (ret < 0)
+			goto disable_func;
+		ctrl &= ~MAX_HIF_RX_LEN_NUM_CONNAC2;
+		ctrl &= ~W_INT_CLR_CTRL; /* read clear */
+		ctrl |= FIELD_PREP(MAX_HIF_RX_LEN_NUM_CONNAC2, 0);
+		break;
+	}
+
 	sdio_writel(func, ctrl, MCR_WHCR, &ret);
 	if (ret < 0)
 		goto disable_func;
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.h b/drivers/net/wireless/mediatek/mt76/sdio.h
index 03877d89e152..7d2ec044dcb1 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.h
+++ b/drivers/net/wireless/mediatek/mt76/sdio.h
@@ -21,7 +21,12 @@
 #define MCR_WHCR			0x000C
 #define W_INT_CLR_CTRL			BIT(1)
 #define RECV_MAILBOX_RD_CLR_EN		BIT(2)
+#define WF_SYS_RSTB			BIT(4) /* supported in CONNAC2 */
+#define WF_WHOLE_PATH_RSTB		BIT(5) /* supported in CONNAC2 */
+#define WF_SDIO_WF_PATH_RSTB		BIT(6) /* supported in CONNAC2 */
 #define MAX_HIF_RX_LEN_NUM		GENMASK(13, 8)
+#define MAX_HIF_RX_LEN_NUM_CONNAC2	GENMASK(14, 8) /* supported in CONNAC2 */
+#define WF_RST_DONE			BIT(15) /* supported in CONNAC2 */
 #define RX_ENHANCE_MODE			BIT(16)
 
 #define MCR_WHISR			0x0010
@@ -29,6 +34,7 @@
 #define WHIER_D2H_SW_INT		GENMASK(31, 8)
 #define WHIER_FW_OWN_BACK_INT_EN	BIT(7)
 #define WHIER_ABNORMAL_INT_EN		BIT(6)
+#define WHIER_WDT_INT_EN		BIT(5) /* supported in CONNAC2 */
 #define WHIER_RX1_DONE_INT_EN		BIT(2)
 #define WHIER_RX0_DONE_INT_EN		BIT(1)
 #define WHIER_TX_DONE_INT_EN		BIT(0)
@@ -100,7 +106,37 @@
 
 #define MCR_SWPCDBGR			0x0154
 
-struct mt76s_intr {
+#define MCR_H2DSM2R			0x0160 /* supported in CONNAC2 */
+#define MCR_H2DSM3R			0x0164 /* supported in CONNAC2 */
+#define MCR_D2HRM3R			0x0174 /* supported in CONNAC2 */
+#define MCR_WTQCR8			0x0190 /* supported in CONNAC2 */
+#define MCR_WTQCR9			0x0194 /* supported in CONNAC2 */
+#define MCR_WTQCR10			0x0198 /* supported in CONNAC2 */
+#define MCR_WTQCR11			0x019C /* supported in CONNAC2 */
+#define MCR_WTQCR12			0x01A0 /* supported in CONNAC2 */
+#define MCR_WTQCR13			0x01A4 /* supported in CONNAC2 */
+#define MCR_WTQCR14			0x01A8 /* supported in CONNAC2 */
+#define MCR_WTQCR15			0x01AC /* supported in CONNAC2 */
+
+enum mt76_connac_sdio_ver {
+	MT76_CONNAC_SDIO,
+	MT76_CONNAC2_SDIO,
+};
+
+struct mt76_connac2_sdio_intr {
+	u32 isr;
+	struct {
+		u32 wtqcr[16];
+	} tx;
+	struct {
+		u16 num[2];
+		u16 len0[16];
+		u16 len1[128];
+	} rx;
+	u32 rec_mb[2];
+} __packed;
+
+struct mt76_connac_sdio_intr {
 	u32 isr;
 	struct {
 		u32 wtqcr[8];
@@ -112,4 +148,16 @@ struct mt76s_intr {
 	u32 rec_mb[2];
 } __packed;
 
+struct mt76s_intr {
+	u32 isr;
+	struct {
+		u32 *wtqcr;
+	} tx;
+	struct {
+		u16 num[2];
+		u16 *len[2];
+	} rx;
+	u32 rec_mb[2];
+};
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index ceb3dc0613d6..73289a9845d7 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -81,7 +81,7 @@ static int
 mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 		   struct mt76s_intr *intr)
 {
-	struct mt76_queue *q = &dev->q_rx[qid];
+	struct mt76_queue *q = &dev->q_rx[0];
 	struct mt76_sdio *sdio = &dev->sdio;
 	int len = 0, err, i;
 	struct page *page;
@@ -112,8 +112,10 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	for (i = 0; i < intr->rx.num[qid]; i++) {
 		int index = (q->head + i) % q->ndesc;
 		struct mt76_queue_entry *e = &q->entry[index];
+		__le32 *rxd = (__le32 *)buf;
 
-		len = intr->rx.len[qid][i];
+		/* parse rxd to get the actual packet length */
+		len = FIELD_GET(GENMASK(15, 0), le32_to_cpu(rxd[0]));
 		e->skb = mt76s_build_rx_skb(buf, len, round_up(len + 4, 4));
 		if (!e->skb)
 			break;
@@ -132,35 +134,72 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	return i;
 }
 
+static void mt76s_intr_parse(struct mt76_dev *dev, void *data,
+			     struct mt76s_intr *intr)
+{
+	struct mt76_connac_sdio_intr *intr_v1;
+	struct mt76_connac2_sdio_intr *intr_v2;
+	int i;
+
+	switch (dev->sdio.hw_ver) {
+	case MT76_CONNAC_SDIO:
+		intr_v1 = data;
+		intr->isr =  intr_v1->isr;
+		intr->tx.wtqcr = intr_v1->tx.wtqcr;
+		for (i = 0; i < 2 ; i++) {
+			intr->rx.num[i] = intr_v1->rx.num[i];
+			intr->rx.len[i] = intr_v1->rx.len[i];
+			intr->rec_mb[i] = intr_v1->rec_mb[i];
+		}
+		break;
+	default:
+		intr_v2 = data;
+		intr->isr =  intr_v2->isr;
+		intr->tx.wtqcr = intr_v2->tx.wtqcr;
+		for (i = 0; i < 2 ; i++) {
+			intr->rx.num[i] = intr_v2->rx.num[i];
+			if (!i)
+				intr->rx.len[0] = intr_v2->rx.len0;
+			else
+				intr->rx.len[1] = intr_v2->rx.len1;
+			intr->rec_mb[i] = intr_v2->rec_mb[i];
+		}
+		break;
+	}
+}
+
 static int mt76s_rx_handler(struct mt76_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
-	struct mt76s_intr *intr = sdio->intr_data;
+	void *data = sdio->intr_data;
+	struct mt76s_intr intr;
 	int nframes = 0, ret;
 
-	ret = sdio_readsb(sdio->func, intr, MCR_WHISR, sizeof(*intr));
+	ret = sdio_readsb(sdio->func, data, MCR_WHISR, sdio->intr_size);
 	if (ret < 0)
 		return ret;
 
-	trace_dev_irq(dev, intr->isr, 0);
+	mt76s_intr_parse(dev, data, &intr);
 
-	if (intr->isr & WHIER_RX0_DONE_INT_EN) {
-		ret = mt76s_rx_run_queue(dev, 0, intr);
+	trace_dev_irq(dev, intr.isr, 0);
+
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
@@ -173,6 +212,9 @@ mt76s_tx_pick_quota(struct mt76_sdio *sdio, bool mcu, int buf_sz,
 
 	pse_sz = DIV_ROUND_UP(buf_sz + sdio->sched.deficit, MT_PSE_PAGE_SZ);
 
+	if (mcu && sdio->hw_ver == MT76_CONNAC2_SDIO)
+		pse_sz = 1;
+
 	if (mcu) {
 		if (sdio->sched.pse_mcu_quota < *pse_size + pse_sz)
 			return -EBUSY;
-- 
2.25.1

