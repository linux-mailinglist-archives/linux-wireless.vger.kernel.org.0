Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E235501EC9
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Apr 2022 00:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347387AbiDNW6o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 18:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347377AbiDNW6n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 18:58:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F469399E
        for <linux-wireless@vger.kernel.org>; Thu, 14 Apr 2022 15:56:13 -0700 (PDT)
X-UUID: dc81b414a0ba4fb197bfe0ee06e92b9d-20220415
X-UUID: dc81b414a0ba4fb197bfe0ee06e92b9d-20220415
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 224464746; Fri, 15 Apr 2022 06:56:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 15 Apr 2022 06:56:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Apr 2022 06:56:06 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Deren Wu" <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921: fix kernel crash at mt7921_pci_remove
Date:   Fri, 15 Apr 2022 06:56:05 +0800
Message-ID: <a8cd712777d9f6b5c23e65225c37c3360593de3e.1649976504.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The crash log shown it is possible that mt7921_irq_handler is called while
devm_free_irq is being handled so mt76_free_device need to be postponed
until devm_free_irq is completed to solve the crash we free the mt76 device
too early.

[ 9299.339655] BUG: kernel NULL pointer dereference, address: 0000000000000008
[ 9299.339705] #PF: supervisor read access in kernel mode
[ 9299.339735] #PF: error_code(0x0000) - not-present page
[ 9299.339768] PGD 0 P4D 0
[ 9299.339786] Oops: 0000 [#1] SMP PTI
[ 9299.339812] CPU: 1 PID: 1624 Comm: prepare-suspend Not tainted 5.15.14-1.fc32.qubes.x86_64 #1
[ 9299.339863] Hardware name: Xen HVM domU, BIOS 4.14.3 01/20/2022
[ 9299.339901] RIP: 0010:mt7921_irq_handler+0x1e/0x70 [mt7921e]
[ 9299.340048] RSP: 0018:ffffa81b80c27cb0 EFLAGS: 00010082
[ 9299.340081] RAX: 0000000000000000 RBX: ffff98a4cb752020 RCX: ffffffffa96211c5
[ 9299.340123] RDX: 0000000000000000 RSI: 00000000000d4204 RDI: ffff98a4cb752020
[ 9299.340165] RBP: ffff98a4c28a62a4 R08: ffff98a4c37a96c0 R09: 0000000080150011
[ 9299.340207] R10: 0000000040000000 R11: 0000000000000000 R12: ffff98a4c4eaa080
[ 9299.340249] R13: ffff98a4c28a6360 R14: ffff98a4cb752020 R15: ffff98a4c28a6228
[ 9299.340297] FS: 00007260840d3740(0000) GS:ffff98a4ef700000(0000) knlGS:0000000000000000
[ 9299.340345] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9299.340383] CR2: 0000000000000008 CR3: 0000000004c56001 CR4: 0000000000770ee0
[ 9299.340432] PKRU: 55555554
[ 9299.340449] Call Trace:
[ 9299.340467] <TASK>
[ 9299.340485] __free_irq+0x221/0x350
[ 9299.340527] free_irq+0x30/0x70
[ 9299.340553] devm_free_irq+0x55/0x80
[ 9299.340579] mt7921_pci_remove+0x2f/0x40 [mt7921e]
[ 9299.340616] pci_device_remove+0x3b/0xa0
[ 9299.340651] __device_release_driver+0x17a/0x240
[ 9299.340686] device_driver_detach+0x3c/0xa0
[ 9299.340714] unbind_store+0x113/0x130
[ 9299.340740] kernfs_fop_write_iter+0x124/0x1b0
[ 9299.340775] new_sync_write+0x15c/0x1f0
[ 9299.340806] vfs_write+0x1d2/0x270
[ 9299.340831] ksys_write+0x67/0xe0
[ 9299.340857] do_syscall_64+0x3b/0x90
[ 9299.340887] entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: 5c14a5f944b9 ("mt76: mt7921: introduce mt7921e support")
Reported-by: ThinerLogoer <logoerthiner1@163.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 062e2b422478..b5fb22b8e086 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -119,7 +119,6 @@ static void mt7921e_unregister_device(struct mt7921_dev *dev)
 	mt7921_mcu_exit(dev);
 
 	tasklet_disable(&dev->irq_tasklet);
-	mt76_free_device(&dev->mt76);
 }
 
 static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
@@ -356,6 +355,7 @@ static void mt7921_pci_remove(struct pci_dev *pdev)
 
 	mt7921e_unregister_device(dev);
 	devm_free_irq(&pdev->dev, pdev->irq, dev);
+	mt76_free_device(&dev->mt76);
 	pci_free_irq_vectors(pdev);
 }
 
-- 
2.25.1

