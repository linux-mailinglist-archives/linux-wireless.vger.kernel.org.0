Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0AC5369BD
	for <lists+linux-wireless@lfdr.de>; Sat, 28 May 2022 03:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355254AbiE1BdT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 21:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiE1BdS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 21:33:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0972132A1B
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 18:33:17 -0700 (PDT)
X-UUID: a5484e01654e4a31925f51b82f6a7627-20220528
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:f432c878-e79f-4933-8928-26ee9f714845,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:105
X-CID-INFO: VERSION:1.1.5,REQID:f432c878-e79f-4933-8928-26ee9f714845,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:105
X-CID-META: VersionHash:2a19b09,CLOUDID:1a1fc847-4fb1-496b-8f1d-39e733fed1ea,C
        OID:7183b74a9de8,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: a5484e01654e4a31925f51b82f6a7627-20220528
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1457100579; Sat, 28 May 2022 09:33:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sat, 28 May 2022 09:33:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sat, 28 May 2022 09:33:12 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        YN Chen <yn.chen@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7921s: fix firmware download random fail
Date:   Sat, 28 May 2022 09:28:54 +0800
Message-ID: <0683e81c29ec4fa88c206ae99805d81a91a953c1.1653699683.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1653699683.git.deren.wu@mediatek.com>
References: <cover.1653699683.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: YN Chen <yn.chen@mediatek.com>

To avoid racing problems in chip, mt7921s should reacquire drv-own after
firmware semaphore is released.

Fixes: 78b217580c509 ("mt76: mt7921s: fix bus hang with wrong privilege")
Signed-off-by: YN Chen <yn.chen@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 617f0a452f71..d0a7c3128d5a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -583,13 +583,6 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 	if (ret)
 		dev_err(dev->mt76.dev, "Failed to start patch\n");
 
-	if (mt76_is_sdio(&dev->mt76)) {
-		/* activate again */
-		ret = __mt7921_mcu_fw_pmctrl(dev);
-		if (!ret)
-			ret = __mt7921_mcu_drv_pmctrl(dev);
-	}
-
 out:
 	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
 	switch (sem) {
@@ -600,6 +593,14 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 		dev_err(dev->mt76.dev, "Failed to release patch semaphore\n");
 		break;
 	}
+
+	if (!ret && mt76_is_sdio(&dev->mt76)) {
+		/* activate again */
+		ret = __mt7921_mcu_fw_pmctrl(dev);
+		if (!ret)
+			ret = __mt7921_mcu_drv_pmctrl(dev);
+	}
+
 	release_firmware(fw);
 
 	return ret;
-- 
2.18.0

