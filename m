Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A888A57C005
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jul 2022 00:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiGTWZ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 18:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTWZ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 18:25:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E172D5F5B
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 15:25:49 -0700 (PDT)
X-UUID: 7303a5cbfcee482ebc19e8e599b5ae40-20220721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:32d62e1f-1f76-4e4c-a03b-6bba437f19f6,OB:20,L
        OB:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:32d62e1f-1f76-4e4c-a03b-6bba437f19f6,OB:20,LOB
        :0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:5a9f06d8-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:dfdc1513ed4c,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7303a5cbfcee482ebc19e8e599b5ae40-20220721
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1451868277; Thu, 21 Jul 2022 06:25:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 21 Jul 2022 06:25:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 21 Jul 2022 06:25:41 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/4] mt76: mt7921s: fix race issue between reset and suspend/resume
Date:   Thu, 21 Jul 2022 06:25:38 +0800
Message-ID: <0a8e8ed3b179da75d4e141e0384992864e36b33a.1658355599.git.sean.wang@kernel.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5f835553ee8b76e4a4ed83f9562eaa0b1a24c1e6.1658355599.git.sean.wang@kernel.org>
References: <5f835553ee8b76e4a4ed83f9562eaa0b1a24c1e6.1658355599.git.sean.wang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

It is unexpected that the reset work is running simultaneously with
the suspend or resume context and it is possible that reset work is still
running even after mt7921 is suspended if we don't fix the race issue.

Thus, the suspend procedure should be waiting until the reset is completed
at the beginning and ignore the subsequent the reset requests.

In case there is an error that happens during either suspend or resume
handler, we will schedule a reset task to recover the error before
returning the error code to ensure we can immediately fix the error there.

Fixes: ca74b9b907f9 ("mt76: mt7921s: add reset support")
Co-developed-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: use flush_work instead of cancel_work_sync
---
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 487acd6e2be8..2face849fb4f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -206,6 +206,7 @@ static int mt7921s_suspend(struct device *__dev)
 	pm->suspended = true;
 	set_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
 
+	flush_work(&dev->reset_work);
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
@@ -261,6 +262,9 @@ static int mt7921s_suspend(struct device *__dev)
 	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
 	pm->suspended = false;
 
+	if (err < 0)
+		mt7921_reset(&dev->mt76);
+
 	return err;
 }
 
@@ -276,7 +280,7 @@ static int mt7921s_resume(struct device *__dev)
 
 	err = mt7921_mcu_drv_pmctrl(dev);
 	if (err < 0)
-		return err;
+		goto failed;
 
 	mt76_worker_enable(&mdev->tx_worker);
 	mt76_worker_enable(&mdev->sdio.txrx_worker);
@@ -288,11 +292,12 @@ static int mt7921s_resume(struct device *__dev)
 		mt76_connac_mcu_set_deep_sleep(mdev, false);
 
 	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
-	if (err)
-		return err;
-
+failed:
 	pm->suspended = false;
 
+	if (err < 0)
+		mt7921_reset(&dev->mt76);
+
 	return err;
 }
 
-- 
2.25.1

