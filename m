Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E6A47CCB8
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 06:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbhLVF4f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 00:56:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51062 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232036AbhLVF4e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 00:56:34 -0500
X-UUID: 8b73f4f79f804d138c78c542d009aa19-20211222
X-UUID: 8b73f4f79f804d138c78c542d009aa19-20211222
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1231233857; Wed, 22 Dec 2021 13:56:31 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Dec 2021 13:56:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Dec
 2021 13:56:29 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Dec 2021 13:56:28 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: sdio: lock sdio when it is needed
Date:   Wed, 22 Dec 2021 13:56:28 +0800
Message-ID: <7aaf68bc8073c4f1cef063d1e0989e5402ac358c.1640151426.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Acquire the SDIO as needed as possible because either MT7663S or MT7921S
is a multiple-function device that always includes Bluetooth that would
share with the same SDIO bus. So not to avoid breaking Bluetooth pairing,
audio, and HID such kind of time critical application on that, we only
lock sdio bus when it is necessary in WiFi driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 3 +++
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c   | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 31c4a76b7f91..71162befdae8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -56,7 +56,10 @@ static int mt7663s_parse_intr(struct mt76_dev *dev, struct mt76s_intr *intr)
 	struct mt7663s_intr *irq_data = sdio->intr_data;
 	int i, err;
 
+	sdio_claim_host(sdio->func);
 	err = sdio_readsb(sdio->func, irq_data, MCR_WHISR, sizeof(*irq_data));
+	sdio_release_host(sdio->func);
+
 	if (err)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 65d693902c22..743b63f66efa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -58,7 +58,10 @@ static int mt7921s_parse_intr(struct mt76_dev *dev, struct mt76s_intr *intr)
 	struct mt7921_sdio_intr *irq_data = sdio->intr_data;
 	int i, err;
 
+	sdio_claim_host(sdio->func);
 	err = sdio_readsb(sdio->func, irq_data, MCR_WHISR, sizeof(*irq_data));
+	sdio_release_host(sdio->func);
+
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index 801590a0a334..f2b46975d831 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -102,7 +102,10 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 
 	buf = page_address(page);
 
+	sdio_claim_host(sdio->func);
 	err = sdio_readsb(sdio->func, buf, MCR_WRDR(qid), len);
+	sdio_release_host(sdio->func);
+
 	if (err < 0) {
 		dev_err(dev->dev, "sdio read data failed:%d\n", err);
 		put_page(page);
@@ -214,7 +217,10 @@ static int __mt76s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
 	if (len > sdio->func->cur_blksize)
 		len = roundup(len, sdio->func->cur_blksize);
 
+	sdio_claim_host(sdio->func);
 	err = sdio_writesb(sdio->func, MCR_WTDR1, data, len);
+	sdio_release_host(sdio->func);
+
 	if (err)
 		dev_err(dev->dev, "sdio write failed: %d\n", err);
 
@@ -298,6 +304,7 @@ void mt76s_txrx_worker(struct mt76_sdio *sdio)
 	/* disable interrupt */
 	sdio_claim_host(sdio->func);
 	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
+	sdio_release_host(sdio->func);
 
 	do {
 		nframes = 0;
@@ -327,6 +334,7 @@ void mt76s_txrx_worker(struct mt76_sdio *sdio)
 	} while (nframes > 0);
 
 	/* enable interrupt */
+	sdio_claim_host(sdio->func);
 	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
 	sdio_release_host(sdio->func);
 }
-- 
2.25.1

