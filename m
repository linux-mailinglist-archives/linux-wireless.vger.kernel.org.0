Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE0F4627BE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 00:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhK2XJp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 18:09:45 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:52442 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236175AbhK2XIw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 18:08:52 -0500
X-UUID: baca8b863f1d409b8c35099b061f4002-20211130
X-UUID: baca8b863f1d409b8c35099b061f4002-20211130
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 84700670; Tue, 30 Nov 2021 07:05:31 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Nov 2021 07:05:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Nov
 2021 07:05:29 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Nov 2021 07:05:29 +0800
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
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: mt7921s: fix possible kernel crash due to invalid Rx count
Date:   Tue, 30 Nov 2021 07:05:28 +0800
Message-ID: <46ec9ad003b425f55c75a0de76b5f98fb066508f.1638225611.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Return the proper error code when out-of-range the Rx aggregation count
are reported from the hardware that would create the unreasonable extreme
large Rx buffer.

[  100.873810]  show_stack+0x20/0x2c
[  100.873823]  dump_stack+0xc4/0x140
[  100.873839]  bad_page+0x110/0x114
[  100.873854]  check_new_pages+0xf8/0xfc
[  100.873869]  rmqueue+0x5a0/0x640
[  100.873884]  get_page_from_freelist+0x124/0x20c
[  100.873898]  __alloc_pages_nodemask+0x114/0x2a4
[  100.873918]  mt76s_rx_run_queue+0xd4/0x2e4 [mt76_sdio 8280a88a0c8c9cf203f16e194f99ac293bdbb2f5]
[  100.873938]  mt76s_rx_handler+0xd4/0x2a0 [mt76_sdio 8280a88a0c8c9cf203f16e194f99ac293bdbb2f5]
[  100.873957]  mt76s_txrx_worker+0xac/0x17c [mt76_sdio 8280a88a0c8c9cf203f16e194f99ac293bdbb2f5]
[  100.873977]  mt7921s_txrx_worker+0x5c/0xd8 [mt7921s d0bdbc018082dbc8dc1407614be3c2e7bd64423b]
[  100.874003]  __mt76_worker_fn+0xe8/0x170 [mt76 b80af3483a8f9d48e916c12d8dbfaa0d3cd15337]
[  100.874018]  kthread+0x148/0x3ac
[  100.874032]  ret_from_fork+0x10/0x30
[  100.874067] Kernel Offset: 0x1fe2000000 from 0xffffffc010000000
[  100.874079] PHYS_OFFSET: 0xffffffe800000000
[  100.874090] CPU features: 0x0240002,2188200c

Fixes: 48fab5bbef40 ("mt76: mt7921: introduce mt7921s support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 5c88b6b8d097..84be229a899d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -62,6 +62,10 @@ static int mt7921s_parse_intr(struct mt76_dev *dev, struct mt76s_intr *intr)
 	if (err < 0)
 		return err;
 
+	if (irq_data->rx.num[0] > 16 ||
+	    irq_data->rx.num[1] > 128)
+		return -EINVAL;
+
 	intr->isr = irq_data->isr;
 	intr->rec_mb = irq_data->rec_mb;
 	intr->tx.wtqcr = irq_data->tx.wtqcr;
-- 
2.25.1

