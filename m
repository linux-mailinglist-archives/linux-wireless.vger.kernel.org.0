Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824F463F48A
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 16:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiLAPyJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 10:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiLAPyH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 10:54:07 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9F92BB2F
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 07:54:00 -0800 (PST)
X-UUID: f6c52028c763489cb8be71c6b1e51a9b-20221201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=poouuqyeI1m5HVOs1wvpGYZufzXSznZNfD82HnANEHw=;
        b=VjJLkTPglransAqiAW82Q4IFpQ8wkujLJeAQfp8C/iqYWyA7ESnmV0ZZZAE79sVFgSbAIvFaX3cSCjOWumy+V+5dRA+sp7aTP1NuC2Wt/Y0dSTDmMii6WF+myZMTlLTS+I8K/Pni5iih//j8bjYwe+y90PqcXTcgt3KuZF1pzCs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:fb0b17c9-c2b0-40a2-98fc-560a0b09a6d5,IP:0,U
        RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:75
X-CID-INFO: VERSION:1.1.14,REQID:fb0b17c9-c2b0-40a2-98fc-560a0b09a6d5,IP:0,URL
        :0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:75
X-CID-META: VersionHash:dcaaed0,CLOUDID:3b77e21e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:22120123535679OIF5Z3,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:1,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f6c52028c763489cb8be71c6b1e51a9b-20221201
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 883000931; Thu, 01 Dec 2022 23:53:56 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 1 Dec 2022 23:53:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 1 Dec 2022 23:53:54 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt7921s: fix slab-out-of-bounds access in sdio host
Date:   Thu, 1 Dec 2022 23:53:37 +0800
Message-ID: <0cb01834f0cbcefddfd6facc27568178c139839e.1669909513.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SDIO may need addtional 511 bytes to align bus operation. If the tailroom
of this skb is not big enough, we would access invalid memory region.
For low level operation, increase skb size to keep valid memory access in
SDIO host.

Error message:
[69.951] BUG: KASAN: slab-out-of-bounds in sg_copy_buffer+0xe9/0x1a0
[69.951] Read of size 64 at addr ffff88811c9cf000 by task kworker/u16:7/451
[69.951] CPU: 4 PID: 451 Comm: kworker/u16:7 Tainted: G W  OE  6.1.0-rc5 #1
[69.951] Workqueue: kvub300c vub300_cmndwork_thread [vub300]
[69.951] Call Trace:
[69.951]  <TASK>
[69.952]  dump_stack_lvl+0x49/0x63
[69.952]  print_report+0x171/0x4a8
[69.952]  kasan_report+0xb4/0x130
[69.952]  kasan_check_range+0x149/0x1e0
[69.952]  memcpy+0x24/0x70
[69.952]  sg_copy_buffer+0xe9/0x1a0
[69.952]  sg_copy_to_buffer+0x12/0x20
[69.952]  __command_write_data.isra.0+0x23c/0xbf0 [vub300]
[69.952]  vub300_cmndwork_thread+0x17f3/0x58b0 [vub300]
[69.952]  process_one_work+0x7ee/0x1320
[69.952]  worker_thread+0x53c/0x1240
[69.952]  kthread+0x2b8/0x370
[69.952]  ret_from_fork+0x1f/0x30
[69.952]  </TASK>

[69.952] Allocated by task 854:
[69.952]  kasan_save_stack+0x26/0x50
[69.952]  kasan_set_track+0x25/0x30
[69.952]  kasan_save_alloc_info+0x1b/0x30
[69.952]  __kasan_kmalloc+0x87/0xa0
[69.952]  __kmalloc_node_track_caller+0x63/0x150
[69.952]  kmalloc_reserve+0x31/0xd0
[69.952]  __alloc_skb+0xfc/0x2b0
[69.952]  __mt76_mcu_msg_alloc+0xbf/0x230 [mt76]
[69.952]  mt76_mcu_send_and_get_msg+0xab/0x110 [mt76]
[69.952]  __mt76_mcu_send_firmware.cold+0x94/0x15d [mt76]
[69.952]  mt76_connac_mcu_send_ram_firmware+0x415/0x54d [mt76_connac_lib]
[69.952]  mt76_connac2_load_ram.cold+0x118/0x4bc [mt76_connac_lib]
[69.952]  mt7921_run_firmware.cold+0x2e9/0x405 [mt7921_common]
[69.952]  mt7921s_mcu_init+0x45/0x80 [mt7921s]
[69.953]  mt7921_init_work+0xe1/0x2a0 [mt7921_common]
[69.953]  process_one_work+0x7ee/0x1320
[69.953]  worker_thread+0x53c/0x1240
[69.953]  kthread+0x2b8/0x370
[69.953]  ret_from_fork+0x1f/0x30
[69.953] The buggy address belongs to the object at ffff88811c9ce800
             which belongs to the cache kmalloc-2k of size 2048
[69.953] The buggy address is located 0 bytes to the right of
             2048-byte region [ffff88811c9ce800, ffff88811c9cf000)

[69.953] Memory state around the buggy address:
[69.953]  ffff88811c9cef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[69.953]  ffff88811c9cef80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[69.953] >ffff88811c9cf000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[69.953]                    ^
[69.953]  ffff88811c9cf080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[69.953]  ffff88811c9cf100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Fixes: 764dee47e2c1 ("mt76: sdio: move common code in mt76_sdio module")
Suggested-by: Lorenzo Bianconi <lorenzo@kernel.org>
Tested-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
v2:
  - use __skb_grow to increase skb size
  - add suggested by Lorenzo
---
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index bfc4de50a4d2..ddd8c0cc744d 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -254,6 +254,10 @@ static int mt76s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 
 		if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state)) {
 			__skb_put_zero(e->skb, 4);
+			err = __skb_grow(e->skb, roundup(e->skb->len,
+							 sdio->func->cur_blksize));
+			if (err)
+				return err;
 			err = __mt76s_xmit_queue(dev, e->skb->data,
 						 e->skb->len);
 			if (err)
-- 
2.18.0

