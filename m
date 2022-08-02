Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA92587EDE
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbiHBPQM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiHBPPs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 11:15:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0F0DEF3
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 08:15:21 -0700 (PDT)
X-UUID: 42a35e3ee0054f9393e873b4f24db304-20220802
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:dd02c323-b9cf-48a2-9615-ae7d30db90fd,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:8c621025-a982-4824-82d2-9da3b6056c2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 42a35e3ee0054f9393e873b4f24db304-20220802
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 411085948; Tue, 02 Aug 2022 23:15:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 2 Aug 2022 23:15:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 2 Aug 2022 23:15:14 +0800
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
Subject: [PATCH] mt76: mt7921e: fix crash in chip reset fail
Date:   Tue, 2 Aug 2022 23:15:07 +0800
Message-ID: <727eb5ffd3c7c805245e512da150ecf0a7154020.1659452909.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

In case of drv own fail in reset, we may need to run mac_reset several
times. The sequence would trigger system crash as the log below.

Because we do not re-enable/schedule "tx_napi" before disable it again,
the process would keep waiting for state change in napi_diable(). To
avoid the problem and keep status synchronize for each run, goto final
resource handling if drv own failed.

[ 5857.353423] mt7921e 0000:3b:00.0: driver own failed
[ 5858.433427] mt7921e 0000:3b:00.0: Timeout for driver own
[ 5859.633430] mt7921e 0000:3b:00.0: driver own failed
[ 5859.633444] ------------[ cut here ]------------
[ 5859.633446] WARNING: CPU: 6 at kernel/kthread.c:659 kthread_park+0x11d
[ 5859.633717] Workqueue: mt76 mt7921_mac_reset_work [mt7921_common]
[ 5859.633728] RIP: 0010:kthread_park+0x11d/0x150
[ 5859.633736] RSP: 0018:ffff8881b676fc68 EFLAGS: 00010202
......
[ 5859.633766] Call Trace:
[ 5859.633768]  <TASK>
[ 5859.633771]  mt7921e_mac_reset+0x176/0x6f0 [mt7921e]
[ 5859.633778]  mt7921_mac_reset_work+0x184/0x3a0 [mt7921_common]
[ 5859.633785]  ? mt7921_mac_set_timing+0x520/0x520 [mt7921_common]
[ 5859.633794]  ? __kasan_check_read+0x11/0x20
[ 5859.633802]  process_one_work+0x7ee/0x1320
[ 5859.633810]  worker_thread+0x53c/0x1240
[ 5859.633818]  kthread+0x2b8/0x370
[ 5859.633824]  ? process_one_work+0x1320/0x1320
[ 5859.633828]  ? kthread_complete_and_exit+0x30/0x30
[ 5859.633834]  ret_from_fork+0x1f/0x30
[ 5859.633842]  </TASK>

Fixes: 0efaf31dec57 ("mt76: mt7921: fix MT7921E reset failure")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index e1800674089a..576a0149251b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -261,7 +261,7 @@ int mt7921e_mac_reset(struct mt7921_dev *dev)
 
 	err = mt7921e_driver_own(dev);
 	if (err)
-		return err;
+		goto out;
 
 	err = mt7921_run_firmware(dev);
 	if (err)
-- 
2.18.0

