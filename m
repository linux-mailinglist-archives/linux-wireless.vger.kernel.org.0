Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C326BF87F
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Mar 2023 08:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCRHl3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Mar 2023 03:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCRHl2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Mar 2023 03:41:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C69128D00
        for <linux-wireless@vger.kernel.org>; Sat, 18 Mar 2023 00:41:22 -0700 (PDT)
X-UUID: 442b517ac56011edbd2e61cc88cc8f98-20230318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fqOYchM3sN717212k9sSd4y8uXJcpGdc4LtjYRsPJ0o=;
        b=rN9DoNcjfa1CUzq6GQQCiIbDkpm4XLGZDa1x9cT4Of70Imluh7k5Ra9RERCLu/X7TZn8h6In3Oe9dxcJWpqoU1H2WTmY+9QA5muIY3snmURugoKGUOBED4j+WXQLcfvdnvLPdHKxAUJEYPtNeYO8xEinz3AwHFcRxxVaqHD/3jI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:0bb5b7ce-9fea-4a7c-942d-55a2085ebf7b,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:83295aa,CLOUDID:436b9eb3-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 442b517ac56011edbd2e61cc88cc8f98-20230318
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 734650461; Sat, 18 Mar 2023 15:41:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Sat, 18 Mar 2023 15:41:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Sat, 18 Mar 2023 15:41:15 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921e: fix probe timeout after reboot
Date:   Sat, 18 Mar 2023 15:41:12 +0800
Message-ID: <53f713fe1c543037c8b49d80dae0d1eaeb2a3457.1679123603.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Quan Zhou <quan.zhou@mediatek.com>

In system warm reboot scene, due to the polling timeout(now 1000us)
is too short to wait dma idle in time, it may make driver probe fail
with error code -ETIMEDOUT. Meanwhile, we also found the dma may take
around 70ms to enter idle state. Change the polling idle timeout to
100ms to avoid the probabilistic probe fail.

Tested pass with 5000 times warm reboot on x86 platform.

[4.477496] pci 0000:01:00.0: attach allowed to drvr mt7921e [internal device]
[4.478306] mt7921e 0000:01:00.0: ASIC revision: 79610010
[4.480063] mt7921e: probe of 0000:01:00.0 failed with error -110

Fixes: 0a1059d0f060 ("mt76: mt7921: move mt7921_dma_reset in dma.c")
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index d1f10f6d9adc..dc4ccfef4b04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -90,9 +90,9 @@ static int mt7921_dma_disable(struct mt7921_dev *dev, bool force)
 		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
 		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
 
-	if (!mt76_poll(dev, MT_WFDMA0_GLO_CFG,
-		       MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
-		       MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000))
+	if (!mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
+				 MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+				 MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1))
 		return -ETIMEDOUT;
 
 	return 0;
-- 
2.18.0

