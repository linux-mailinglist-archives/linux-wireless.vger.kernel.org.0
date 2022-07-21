Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC957D707
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jul 2022 00:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiGUWjz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jul 2022 18:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiGUWjx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jul 2022 18:39:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02B16168
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jul 2022 15:39:47 -0700 (PDT)
X-UUID: 15a343c844fd4153b01dd48f2597bd91-20220722
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:089c47ec-62d8-4f8f-8958-15c1d2ba139e,OB:10,L
        OB:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:089c47ec-62d8-4f8f-8958-15c1d2ba139e,OB:10,LOB
        :0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:85c321d8-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:948705251075,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 15a343c844fd4153b01dd48f2597bd91-20220722
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1650163712; Fri, 22 Jul 2022 06:39:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 22 Jul 2022 06:39:38 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 22 Jul 2022 06:39:38 +0800
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
Subject: [PATCH v2 1/2] mt76: sdio: fix the deadlock caused by sdio->stat_work
Date:   Fri, 22 Jul 2022 06:39:35 +0800
Message-ID: <940842e68716b513a5482c9c465befbd987ca38b.1658441953.git.sean.wang@kernel.org>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Because wake_work and sdio->stat_work share the same workqueue mt76->wq,
if sdio->stat_work cannot acquire the mutex lock such as that was possibly
held up by [mt7615, mt7921]_mutex_acquire. Additionally, if
[mt7615, mt7921]_mutex_acquire was called by sdio->stat_work self, the wake
would be blocked by itself. Thus, we move the stat_work into
ieee80211_workqueue instead to break the deadlock.

Fixes: d39b52e31aa6 ("mt76: introduce mt76_sdio module")
Co-developed-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: move state_work to ieee80211_workqueue and update git message
---
 drivers/net/wireless/mediatek/mt76/sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index aba2a9865821..fb2caeae6dba 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -481,7 +481,7 @@ static void mt76s_status_worker(struct mt76_worker *w)
 		if (dev->drv->tx_status_data &&
 		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state) &&
 		    !test_bit(MT76_STATE_SUSPEND, &dev->phy.state))
-			queue_work(dev->wq, &dev->sdio.stat_work);
+			ieee80211_queue_work(dev->hw, &dev->sdio.stat_work);
 	} while (nframes > 0);
 
 	if (resched)
@@ -508,7 +508,7 @@ static void mt76s_tx_status_data(struct work_struct *work)
 	}
 
 	if (count && test_bit(MT76_STATE_RUNNING, &dev->phy.state))
-		queue_work(dev->wq, &sdio->stat_work);
+		ieee80211_queue_work(dev->hw, &sdio->stat_work);
 	else
 		clear_bit(MT76_READING_STATS, &dev->phy.state);
 }
-- 
2.25.1

