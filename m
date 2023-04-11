Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36D6DE668
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDKVXW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 17:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDKVXV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 17:23:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9FF1BE8
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 14:23:19 -0700 (PDT)
X-UUID: 117cc828d8af11eda9a90f0bb45854f4-20230412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=O6xVJlFYJEMuNTibKVAvYMc8gRzK9AjQY/pazS15uUc=;
        b=qiGgnSb/nz+F3kbQ9NJ+JZvRNZcMFBvVFZ1Bndk0Q+9cXI21RetZz0tUX0bxiX6DAWrzYCLtAZ+Rm3mAzenaJiET18Q444c5B4tnfYTDJmc67ZqFd5gJpH0IwkYBHvA9DUZ4nF3fgEkp/dnelrFa31D6RjvZNxkd5kNLjQmfMro=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:411f82b0-42a9-437c-b0fa-04cefe06d032,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:411f82b0-42a9-437c-b0fa-04cefe06d032,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:045aa0ea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230412052317O3M0PWKU,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 117cc828d8af11eda9a90f0bb45854f4-20230412
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1852530396; Wed, 12 Apr 2023 05:23:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 12 Apr 2023 05:23:12 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 12 Apr 2023 05:23:12 +0800
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
Subject: [PATCH v2] mt76: mt7921: fix kernel panic by accessing unallocated eeprom.data
Date:   Wed, 12 Apr 2023 05:23:11 +0800
Message-ID: <e1404f1f77232a081b7c877046e06c195591132d.1681248077.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
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

Furthermore, it is possible to entirely eliminate the
mt7921_mcu_parse_eeprom function and solely depend on
mt7921_mcu_parse_response to divide the RxD header.

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
v2: fix the build warning caught with kernel test robot and entirely
    remove mt7921_mcu_parse_eeprom.
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index c5e7ad06f877..48f38dbbb91d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -16,24 +16,6 @@ static bool mt7921_disable_clc;
 module_param_named(disable_clc, mt7921_disable_clc, bool, 0644);
 MODULE_PARM_DESC(disable_clc, "disable CLC support");
 
-static int
-mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
-{
-	struct mt7921_mcu_eeprom_info *res;
-	u8 *buf;
-
-	if (!skb)
-		return -EINVAL;
-
-	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
-
-	res = (struct mt7921_mcu_eeprom_info *)skb->data;
-	buf = dev->eeprom.data + le32_to_cpu(res->addr);
-	memcpy(buf, res->data, 16);
-
-	return 0;
-}
-
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq)
 {
@@ -60,8 +42,6 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	} else if (cmd == MCU_EXT_CMD(THERMAL_CTRL)) {
 		skb_pull(skb, sizeof(*rxd) + 4);
 		ret = le32_to_cpu(*(__le32 *)skb->data);
-	} else if (cmd == MCU_EXT_CMD(EFUSE_ACCESS)) {
-		ret = mt7921_mcu_parse_eeprom(mdev, skb);
 	} else if (cmd == MCU_UNI_CMD(DEV_INFO_UPDATE) ||
 		   cmd == MCU_UNI_CMD(BSS_INFO_UPDATE) ||
 		   cmd == MCU_UNI_CMD(STA_REC_UPDATE) ||
-- 
2.25.1

