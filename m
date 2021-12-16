Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D094779E4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 18:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhLPRCn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 12:02:43 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:47686 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238387AbhLPRCn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 12:02:43 -0500
X-UUID: 3d777150ab2e4956969f3f2a77c2e5cd-20211217
X-UUID: 3d777150ab2e4956969f3f2a77c2e5cd-20211217
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1353091513; Fri, 17 Dec 2021 01:02:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Dec 2021 01:02:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Dec 2021 01:02:39 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921s: fix cmd timeout in throughput test
Date:   Fri, 17 Dec 2021 01:02:09 +0800
Message-ID: <d187e530a37a7941912e356e356606ffaad88b8a.1639673722.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

During heavy loading throughtput test, the RX buffer (128)
would be exhausted and some RX pkts dropped randomly. Increase
buffer size from 128 to 512 (a safer length) to avoid tput degrade
or cmd-timeout problem.

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 2 ++
 drivers/net/wireless/mediatek/mt76/sdio.c | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 239742112e16..2a4120f71534 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -495,6 +495,8 @@ struct mt76_usb {
 };
 
 #define MT76S_XMIT_BUF_SZ	(16 * PAGE_SIZE)
+#define MT76S_NUM_TX_ENTRIES	256
+#define MT76S_NUM_RX_ENTRIES	512
 struct mt76_sdio {
 	struct mt76_worker txrx_worker;
 	struct mt76_worker status_worker;
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index b0bc7be0fb1f..54f72d215948 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -305,12 +305,12 @@ int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 
 	spin_lock_init(&q->lock);
 	q->entry = devm_kcalloc(dev->dev,
-				MT_NUM_RX_ENTRIES, sizeof(*q->entry),
+				MT76S_NUM_RX_ENTRIES, sizeof(*q->entry),
 				GFP_KERNEL);
 	if (!q->entry)
 		return -ENOMEM;
 
-	q->ndesc = MT_NUM_RX_ENTRIES;
+	q->ndesc = MT76S_NUM_RX_ENTRIES;
 	q->head = q->tail = 0;
 	q->queued = 0;
 
@@ -328,12 +328,12 @@ static struct mt76_queue *mt76s_alloc_tx_queue(struct mt76_dev *dev)
 
 	spin_lock_init(&q->lock);
 	q->entry = devm_kcalloc(dev->dev,
-				MT_NUM_TX_ENTRIES, sizeof(*q->entry),
+				MT76S_NUM_TX_ENTRIES, sizeof(*q->entry),
 				GFP_KERNEL);
 	if (!q->entry)
 		return ERR_PTR(-ENOMEM);
 
-	q->ndesc = MT_NUM_TX_ENTRIES;
+	q->ndesc = MT76S_NUM_TX_ENTRIES;
 
 	return q;
 }
-- 
2.18.0

