Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B886DCC35
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Apr 2023 22:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjDJUgS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 16:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJUgR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 16:36:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EAE19A0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 13:36:08 -0700 (PDT)
X-UUID: 4dbd35dcd7df11edb6b9f13eb10bd0fe-20230411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zWUdyMpU+iGkYFiLEAInzUtt7sxCmqq/KzLX2XFpftE=;
        b=Z42C/AbS1SXV3giMAUvlvHwKyLPzGz0eUjHay+QUfEDTY4JwUUeLqw0dvbxU/uVK0sUewgrkHtY8e14gtVrt8RmujATKbac3N7NeX0ayx/Kzq445bCUpzYg8tJ7v2uCGslQOGkmHcPWdKr6mjcGhVOW01Z8itEzDGxNib2FV7us=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:0b10d754-ddfa-4948-843d-9669dbfc6bff,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:87f17eea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 4dbd35dcd7df11edb6b9f13eb10bd0fe-20230411
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 95306223; Tue, 11 Apr 2023 04:36:00 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Apr 2023 04:35:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 11 Apr 2023 04:35:59 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <arowa@google.org>, <frankgor@google.com>,
        <kuabhs@google.com>, <druth@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: mt7921: fix kernel panic by accessing unallocated eeprom.data
Date:   Tue, 11 Apr 2023 04:35:57 +0800
Message-ID: <c9e2a44da4daa00166c802a8c10527359358219d.1681158440.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The MT7921 driver no longer uses eeprom.data, but the relevant code has not
been removed completely since
commit 16d98b548365 ("mt76: mt7921: rely on mcu_get_nic_capability").
This could result in potential invalid memory access.

To fix the kernel panic issue in mt7921, it is necessary to avoid accessing
unallocated eeprom.data which can lead to invalid memory access.

[2.702735] BUG: kernel NULL pointer dereference, address: 0000000000000550
[2.702740] #PF: supervisor write access in kernel mode
[2.702741] #PF: error_code(0x0002) - not-present page
[2.702743] PGD 0 P4D 0
[2.702747] Oops: 0002 [#1] PREEMPT SMP NOPTI
[2.702755] RIP: 0010:mt7921_mcu_parse_response+0x147/0x170 [mt7921_common]
[2.702758] RSP: 0018:ffffae7c00fef828 EFLAGS: 00010286
[2.702760] RAX: ffffa367f57be024 RBX: ffffa367cc7bf500 RCX: 0000000000000000
[2.702762] RDX: 0000000000000550 RSI: 0000000000000000 RDI: ffffa367cc7bf500
[2.702763] RBP: ffffae7c00fef840 R08: ffffa367cb167000 R09: 0000000000000005
[2.702764] R10: 0000000000000000 R11: ffffffffc04702e4 R12: ffffa367e8329f40
[2.702766] R13: 0000000000000000 R14: 0000000000000001 R15: ffffa367e8329f40
[2.702768] FS:  000079ee6cf20c40(0000) GS:ffffa36b2f940000(0000) knlGS:0000000000000000
[2.702769] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[2.702775] CR2: 0000000000000550 CR3: 00000001233c6004 CR4: 0000000000770ee0
[2.702776] PKRU: 55555554
[2.702777] Call Trace:
[2.702782]  mt76_mcu_skb_send_and_get_msg+0xc3/0x11e [mt76 <HASH:1bc4 5>]
[2.702785]  mt7921_run_firmware+0x241/0x853 [mt7921_common <HASH:6a2f 6>]
[2.702789]  mt7921e_mcu_init+0x2b/0x56 [mt7921e <HASH:d290 7>]
[2.702792]  mt7921_register_device+0x2eb/0x5a5 [mt7921_common <HASH:6a2f 6>]
[2.702795]  ? mt7921_irq_tasklet+0x1d4/0x1d4 [mt7921e <HASH:d290 7>]
[2.702797]  mt7921_pci_probe+0x2d6/0x319 [mt7921e <HASH:d290 7>]
[2.702799]  pci_device_probe+0x9f/0x12a

Fixes: 16d98b548365 ("mt76: mt7921: rely on mcu_get_nic_capability")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index c5e7ad06f877..00c84680c723 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -20,7 +20,6 @@ static int
 mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
 {
 	struct mt7921_mcu_eeprom_info *res;
-	u8 *buf;
 
 	if (!skb)
 		return -EINVAL;
@@ -28,8 +27,6 @@ mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
 	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
 
 	res = (struct mt7921_mcu_eeprom_info *)skb->data;
-	buf = dev->eeprom.data + le32_to_cpu(res->addr);
-	memcpy(buf, res->data, 16);
 
 	return 0;
 }
-- 
2.25.1

