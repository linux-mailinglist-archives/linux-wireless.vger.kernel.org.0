Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA91556F86
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 02:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359771AbiFWAfj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 20:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359642AbiFWAfi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 20:35:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E4539829
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 17:35:38 -0700 (PDT)
X-UUID: 18901446cc514ee0b7f521dbdc258dd5-20220623
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:0ce1e10d-28d3-4c8e-b1d3-d028a049946e,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:5aa13638-5e4b-44d7-80b2-bb618cb09d29,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 18901446cc514ee0b7f521dbdc258dd5-20220623
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1499927563; Thu, 23 Jun 2022 08:35:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 23 Jun 2022 08:35:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jun 2022 08:35:29 +0800
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
Subject: [PATCH 2/2] mt76: mt7921: reduce the mutex lock scope during reset
Date:   Thu, 23 Jun 2022 08:35:27 +0800
Message-ID: <b10be44b0f968475268895b99864973d18a3b86e.1655944385.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <753f19393f169ad4a5fc127f68e16074f1617306.1655944385.git.objelf@gmail.com>
References: <753f19393f169ad4a5fc127f68e16074f1617306.1655944385.git.objelf@gmail.com>
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

From: Sean Wang <sean.wang@mediatek.com>

Reduce the mutex lock scope for reset to get rid of possible task hung
e.g wpa_supplicant and to allow the user-space process to keep running
during we need more retries to complete the reset.

Suggested-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 2ce3a833176e..c7bca83e7686 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -738,7 +738,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 					      reset_work);
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt76_connac_pm *pm = &dev->pm;
-	int i;
+	int i, ret;
 
 	dev_info(dev->mt76.dev, "chip reset\n");
 	dev->hw_full_reset = true;
@@ -748,11 +748,14 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
-	mutex_lock(&dev->mt76.mutex);
-	for (i = 0; i < 10; i++)
-		if (!mt7921_dev_reset(dev))
+	for (i = 0; i < 10; i++) {
+		mutex_lock(&dev->mt76.mutex);
+		ret = mt7921_dev_reset(dev);
+		mutex_unlock(&dev->mt76.mutex);
+
+		if (!ret)
 			break;
-	mutex_unlock(&dev->mt76.mutex);
+	}
 
 	if (i == 10)
 		dev_err(dev->mt76.dev, "chip reset failed\n");
-- 
2.25.1

