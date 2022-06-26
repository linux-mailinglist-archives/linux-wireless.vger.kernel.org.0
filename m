Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A2A55B46F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jun 2022 01:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiFZX1W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jun 2022 19:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZX1U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jun 2022 19:27:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE2E2D
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jun 2022 16:27:15 -0700 (PDT)
X-UUID: e3da3f0019a84c96934257bb1c8ac89f-20220627
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:2ba650ba-d138-4d92-9e8b-7bf2460b5ba9,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:100
X-CID-INFO: VERSION:1.1.6,REQID:2ba650ba-d138-4d92-9e8b-7bf2460b5ba9,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:100
X-CID-META: VersionHash:b14ad71,CLOUDID:b5628bea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:5ae0a4363cec,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: e3da3f0019a84c96934257bb1c8ac89f-20220627
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1614424464; Mon, 27 Jun 2022 07:27:09 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 27 Jun 2022 07:27:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 27 Jun 2022 07:27:08 +0800
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
Subject: [PATCH v2 2/2] mt76: mt7921: reduce the mutex lock scope during reset
Date:   Mon, 27 Jun 2022 07:27:06 +0800
Message-ID: <77f2b8ccced3cfe659823fa86270a42423d4ba00.1656221826.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <0f3f0b2c6910f685a04bb13699c85f4a3e9f1996.1656221826.git.objelf@gmail.com>
References: <0f3f0b2c6910f685a04bb13699c85f4a3e9f1996.1656221826.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Suggested-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>

---
v2: add Reviewed-by from AngeloGioacchino
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 3ea7d8f43118..81c528298913 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -738,7 +738,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 					      reset_work);
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt76_connac_pm *pm = &dev->pm;
-	int i;
+	int i, ret;
 
 	dev_dbg(dev->mt76.dev, "chip reset\n");
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

