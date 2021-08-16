Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8003ECC1A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 02:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhHPAfX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Aug 2021 20:35:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49806 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230124AbhHPAfX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Aug 2021 20:35:23 -0400
X-UUID: 18f3ef5e2f454b038c9c73ca86488c78-20210816
X-UUID: 18f3ef5e2f454b038c9c73ca86488c78-20210816
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 593691845; Mon, 16 Aug 2021 08:34:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 16 Aug 2021 08:34:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 16 Aug 2021 08:34:48 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/3] mt76: mt7915: rename debugfs tx-queues
Date:   Mon, 16 Aug 2021 08:32:28 +0800
Message-ID: <20ff58d2856ca5f3ee45250ee0dbc7d517134a3a.1629073504.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <3f393508b9ed8251f4e2408356110af092c8ad3e.1629073504.git.ryder.lee@mediatek.com>
References: <3f393508b9ed8251f4e2408356110af092c8ad3e.1629073504.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rename "queues" to "tx-queues" and remove a duplicated MT_TXQ_BE.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index fdb4017e1ff9..f626e367151a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -379,12 +379,11 @@ mt7915_queues_read(struct seq_file *s, void *data)
 		struct mt76_queue *q;
 		char *queue;
 	} queue_map[] = {
-		{ dev->mphy.q_tx[MT_TXQ_BE],	 "WFDMA0" },
-		{ ext_q,			 "WFDMA1" },
-		{ dev->mphy.q_tx[MT_TXQ_BE],	 "WFDMA0" },
+		{ dev->mphy.q_tx[MT_TXQ_BE],	 "MAIN" },
+		{ ext_q,			 "EXT" },
 		{ dev->mt76.q_mcu[MT_MCUQ_WM],	 "MCUWM"  },
 		{ dev->mt76.q_mcu[MT_MCUQ_WA],	 "MCUWA"  },
-		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWQ" },
+		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWDL" },
 	};
 	int i;
 
@@ -451,7 +450,7 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 	if (!dir)
 		return -ENOMEM;
 
-	debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
+	debugfs_create_devm_seqfile(dev->mt76.dev, "tx-queues", dir,
 				    mt7915_queues_read);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "hw-queues", dir,
 				    mt7915_hw_queues_read);
-- 
2.29.2

