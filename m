Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921D562BA4E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 11:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiKPKzD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 05:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbiKPKyd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 05:54:33 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEFC10D7
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 02:43:23 -0800 (PST)
X-UUID: a7c81315aefc489e9b3b95146e7205d6-20221116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DYZzixU+G9Z13P/mjEXm5tqsN/MuV+82bQqD6HGEpiU=;
        b=t0pDbap9nkrC1JRWRXSf69A39HMTlv6c/R7jMl2caHhooM0wo/7+aWn18+6HUeCInimkch2jwoiZ8CZZSbt5Ud2T9L5Z/rc2UkXjlkT4WYPeQLw5y50cJc0oj/0vl2TAkZiiQIsSavJ6xWWa+WZgtqCKW94vSmuJQ6Nu2hWSkAg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:59f145fe-9081-495b-8364-eb912e4838f2,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d12e911,CLOUDID:91585528-7328-4d53-af97-37d3ca89e562,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a7c81315aefc489e9b3b95146e7205d6-20221116
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1289238884; Wed, 16 Nov 2022 18:43:19 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 16 Nov 2022 18:43:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Nov 2022 18:43:17 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7996: fix gcc warnings with sparc options
Date:   Wed, 16 Nov 2022 18:42:26 +0800
Message-ID: <20221116104226.4174-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following warnings:

>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:2377:5: warning: no previous prototype for 'mt7996_mcu_restart' [-Wmissing-prototypes]
    2377 | int mt7996_mcu_restart(struct mt76_dev *dev)
         |     ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/byteorder/big_endian.h:5,
                    from arch/sparc/include/uapi/asm/byteorder.h:5,
                    from include/asm-generic/qrwlock_types.h:6,
                    from arch/sparc/include/asm/spinlock_types.h:17,
                    from include/linux/spinlock_types_raw.h:7,
                    from include/linux/ratelimit_types.h:7,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/firmware.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:6:
   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c: In function 'mt7996_mcu_set_tx':
>> include/uapi/linux/byteorder/big_endian.h:36:26: warning: conversion from 'short unsigned int' to 'u8' {aka 'unsigned char'} changes value from '2560' to '0' [-Woverflow]
      36 | #define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
         |                          ^
   include/linux/byteorder/generic.h:90:21: note: in expansion of macro '__cpu_to_le16'
      90 | #define cpu_to_le16 __cpu_to_le16
         |                     ^~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:2546:37: note: in expansion of macro 'cpu_to_le16'
    2546 |                         e->cw_max = cpu_to_le16(10);
         |                                     ^~~~~~~~~~~

Fixes: 23c307666f69 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
@Felix, could you please help to fold this patch? Thanks.
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index adc80b9930bd..bf83d0862988 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2373,7 +2373,8 @@ mt7996_mcu_init_rx_airtime(struct mt7996_dev *dev)
 				     MCU_WM_UNI_CMD(VOW), true);
 }
 
-int mt7996_mcu_restart(struct mt76_dev *dev)
+static int
+mt7996_mcu_restart(struct mt76_dev *dev)
 {
 	struct {
 		u8 __rsv1[4];
@@ -2540,10 +2541,11 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif)
 			e->cw_min = 5;
 
 		if (q->cw_max)
-			e->cw_max = cpu_to_le16(fls(q->cw_max));
+			e->cw_max = fls(q->cw_max);
 		else
-			e->cw_max = cpu_to_le16(10);
+			e->cw_max = 10;
 	}
+
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WM_UNI_CMD(EDCA_UPDATE), true);
 }
-- 
2.25.1

