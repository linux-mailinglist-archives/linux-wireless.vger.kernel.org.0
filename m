Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20605AE893
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 14:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiIFMkF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 08:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiIFMkD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 08:40:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B4DA184
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 05:39:54 -0700 (PDT)
X-UUID: 47ed7dbbd2f94310a0f516223f05bff5-20220906
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WEgvbtBsCFeZ50c9fMqUTAwLSZshYL4FjCd/clXuW18=;
        b=bD2hzbQVmtRMp5h+Fap5NSYlhQM3vVchl2CH7Q7lAGjURKnR43hYGrU1q0K7J7D9/OgbuEDdmN5Vm87eMvfktkDkQr+J4q36b86UgyzBR5LDCHRsXork7tXbxgjear3YZdEafoKtV1GJHOX79zXWWEeLynWdl4vG9k9zUDo4gjM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:5b130fe4-f2dd-4b80-a4a6-87ae243efa0b,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:5b130fe4-f2dd-4b80-a4a6-87ae243efa0b,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS98
        1B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:0906dfd0-20bd-4e5e-ace8-00692b7ab380,C
        OID:8b8077ea9c6d,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 47ed7dbbd2f94310a0f516223f05bff5-20220906
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 595268623; Tue, 06 Sep 2022 20:39:51 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 6 Sep 2022 20:39:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Sep 2022 20:39:50 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
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
Subject: [PATCH] wifi: mt76: mt7921e: fix rmmod crash in driver reload test
Date:   Tue, 6 Sep 2022 20:39:43 +0800
Message-ID: <152c474c6d9a0871b040e54261cf45d8229d09c3.1662467716.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

In insmod/rmmod stress test, the following crash dump shows up immediately.
The problem is caused by missing mt76_dev in mt7921_pci_remove(). We
should make sure the drvdata is ready before probe() finished.

[168.862789] ==================================================================
[168.862797] BUG: KASAN: user-memory-access in try_to_grab_pending+0x59/0x480
[168.862805] Write of size 8 at addr 0000000000006df0 by task rmmod/5361
[168.862812] CPU: 7 PID: 5361 Comm: rmmod Tainted: G           OE     5.19.0-rc6 #1
[168.862816] Hardware name: Intel(R) Client Systems NUC8i7BEH/NUC8BEB, 05/04/2020
[168.862820] Call Trace:
[168.862822]  <TASK>
[168.862825]  dump_stack_lvl+0x49/0x63
[168.862832]  print_report.cold+0x493/0x6b7
[168.862845]  kasan_report+0xa7/0x120
[168.862857]  kasan_check_range+0x163/0x200
[168.862861]  __kasan_check_write+0x14/0x20
[168.862866]  try_to_grab_pending+0x59/0x480
[168.862870]  __cancel_work_timer+0xbb/0x340
[168.862898]  cancel_work_sync+0x10/0x20
[168.862902]  mt7921_pci_remove+0x61/0x1c0 [mt7921e]
[168.862909]  pci_device_remove+0xa3/0x1d0
[168.862914]  device_remove+0xc4/0x170
[168.862920]  device_release_driver_internal+0x163/0x300
[168.862925]  driver_detach+0xc7/0x1a0
[168.862930]  bus_remove_driver+0xeb/0x2d0
[168.862935]  driver_unregister+0x71/0xb0
[168.862939]  pci_unregister_driver+0x30/0x230
[168.862944]  mt7921_pci_driver_exit+0x10/0x1b [mt7921e]
[168.862949]  __x64_sys_delete_module+0x2f9/0x4b0
[168.862968]  do_syscall_64+0x38/0x90
[168.862973]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Test steps:
1. insmode
2. do not ifup
3. rmmod quickly (within 1 second)

Fixes: 1c71e03afe4b ("mt76: mt7921: move mt7921_init_hw in a dedicated work")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 9d1ba838e54f..be77026e8974 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -284,6 +284,8 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		goto err_free_pci_vec;
 	}
 
+	pci_set_drvdata(pdev, mdev);
+
 	dev = container_of(mdev, struct mt7921_dev, mt76);
 	dev->hif_ops = &mt7921_pcie_ops;
 
-- 
2.18.0

