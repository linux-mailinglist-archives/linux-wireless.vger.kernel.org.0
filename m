Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D276D5775
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 06:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjDDEVO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 00:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjDDEVM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 00:21:12 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0EE1FC0
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 21:21:06 -0700 (PDT)
X-UUID: 1ac92bf2d2a011eda9a90f0bb45854f4-20230404
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6pXtxpunBGWQbbxA1BqK+EKuyhc9FBBJVsdKbI1mz+M=;
        b=nxfsOSBOwfKOO4kJ65tz3Z2iCjk7jWxYClAVKcIzshFgQtmu4uk4Lu6/UOmFbGR4+v5/HT9c0iXKdIOJlQHfJY8JvMUqZLG4QCg9FSq1hWqZ/2ik+vCCEAPjd+QH5MhG8mkXMzmrsMo4PJqWCY0wTWOMhareq2y1pXG3m08lc+4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:a518d565-ff35-4371-9709-0b2b5e5fabde,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:c1c932b5-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 1ac92bf2d2a011eda9a90f0bb45854f4-20230404
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 581417914; Tue, 04 Apr 2023 12:21:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 4 Apr 2023 12:20:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 4 Apr 2023 12:20:59 +0800
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
Subject: [PATCH 2/2] wifi: mt76: mt7921e: stop chip reset worker in unregister hook
Date:   Tue, 4 Apr 2023 12:20:47 +0800
Message-ID: <ae405c4e73af31603ebdb3a691a77c78f6966f95.1680581282.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <d2ca8717d03241ddbd613a6731e5b84aefda8999.1680581282.git.deren.wu@mediatek.com>
References: <d2ca8717d03241ddbd613a6731e5b84aefda8999.1680581282.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Quan Zhou <quan.zhou@mediatek.com>

If chip reset worker triggered in remove process, chip dma may not be
pushed back to idle state properly. Since chip reset may corrupt the dma
flow, stop it before dma finalized.

mt7921_mcu_drv_pmctrl() may trigger reset worker, take
__mt7921_mcu_drv_pmctrl() instead.

Fixes: 033ae79b3830 ("mt76: mt7921: refactor init.c to be bus independent")
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 1a8a54a46dcc..c592903157d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -115,9 +115,10 @@ static void mt7921e_unregister_device(struct mt7921_dev *dev)
 		napi_disable(&dev->mt76.napi[i]);
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
+	cancel_work_sync(&dev->reset_work);
 
 	mt7921_tx_token_put(dev);
-	mt7921_mcu_drv_pmctrl(dev);
+	__mt7921_mcu_drv_pmctrl(dev);
 	mt7921_dma_cleanup(dev);
 	mt7921_wfsys_reset(dev);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
-- 
2.18.0

