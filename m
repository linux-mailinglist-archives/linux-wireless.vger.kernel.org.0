Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1973EDD2F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhHPSiQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 14:38:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37834 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232148AbhHPSiO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 14:38:14 -0400
X-UUID: cdde079049b844768b90ed18d8efb245-20210817
X-UUID: cdde079049b844768b90ed18d8efb245-20210817
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1966111769; Tue, 17 Aug 2021 02:37:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 17 Aug 2021 02:37:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Aug 2021 02:37:38 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 3/3] mt76: mt7915: rename debugfs tx-queues
Date:   Tue, 17 Aug 2021 02:37:35 +0800
Message-ID: <e6a59c0299c7c8569d843c85a8289534708ec8bf.1629133569.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <3f393508b9ed8251f4e2408356110af092c8ad3e.1629133569.git.ryder.lee@mediatek.com>
References: <3f393508b9ed8251f4e2408356110af092c8ad3e.1629133569.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rename "queues" to "tx-queues" to reflect its meaning.

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

