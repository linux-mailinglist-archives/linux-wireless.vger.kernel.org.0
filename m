Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B5F643AC1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 02:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiLFBba (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 20:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiLFBb2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 20:31:28 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF7E1EC75
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 17:31:26 -0800 (PST)
X-UUID: 0bee2fcb5b6b4231b5a20a4bd1d84324-20221206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2q+cYyA+eU3efar4YrIT4KglvWnkd7xCksdSU/9600Y=;
        b=bUAxt1mZeEq+b1kq14gsAjTcoALWQUw0OCs/hPscIWZGMq1TM7DSPAfiTyc7VrXdlfqztXvzL3bQvmryRw3hE3GsFde7wgFGQq3HZsLaZ5mHYbls8HPxWk+sCnneRdyh1W5/juyzAUAxYsAqitQ7loJH31BKMgTmzTb4jjbvzYg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:6ccda5ef-45bb-4a03-9493-d6a5e3209e37,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:8172a016-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0bee2fcb5b6b4231b5a20a4bd1d84324-20221206
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 499356346; Tue, 06 Dec 2022 09:31:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 6 Dec 2022 09:31:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 6 Dec 2022 09:31:18 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/3] wifi: mt76: mt7915: rework mt7915_thermal_set_cur_throttle_state()
Date:   Tue, 6 Dec 2022 09:29:49 +0800
Message-ID: <20221206012951.10719-2-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221206012951.10719-1-howard-yh.hsu@mediatek.com>
References: <20221206012951.10719-1-howard-yh.hsu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch includes 3 changes:
1. The maximum throttle state can be set to 100 to fix the problem that maximum tx
cyle can only be set to 99.
2. Throttle state do not need to be different from the previous state.
This will make it is impossible for users to just change the
trigger/restore temp but not the throttle state.
3. Add dev_err so that it is easier to see invalid setting while looking at dmesg.

Fixes: 9fee8f3736eb ("mt76: mt7915e: Fix degraded performance after temporary overheat")
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c   | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index c810c31fbd6e..abeecf15f1c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -131,14 +131,17 @@ mt7915_thermal_set_cur_throttle_state(struct thermal_cooling_device *cdev,
 	u8 throttling = MT7915_THERMAL_THROTTLE_MAX - state;
 	int ret;
 
-	if (state > MT7915_CDEV_THROTTLE_MAX)
+	if (state > MT7915_THERMAL_THROTTLE_MAX) {
+		dev_err(phy->dev->mt76.dev,
+			"please specify a valid throttling state\n");
 		return -EINVAL;
+	}
 
-	if (phy->throttle_temp[0] > phy->throttle_temp[1])
-		return 0;
-
-	if (state == phy->cdev_state)
-		return 0;
+	if (phy->throttle_temp[0] > phy->throttle_temp[1]) {
+		dev_err(phy->dev->mt76.dev,
+			"temp1_crit shall not be greater than temp1_max\n");
+		return -EINVAL;
+	}
 
 	/*
 	 * cooling_device convention: 0 = no cooling, more = more cooling
@@ -164,7 +167,7 @@ static void mt7915_unregister_thermal(struct mt7915_phy *phy)
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
 
 	if (!phy->cdev)
-	    return;
+		return;
 
 	sysfs_remove_link(&wiphy->dev.kobj, "cooling_device");
 	thermal_cooling_device_unregister(phy->cdev);
@@ -1101,7 +1104,6 @@ static void mt7915_stop_hardware(struct mt7915_dev *dev)
 		mt7986_wmac_disable(dev);
 }
 
-
 int mt7915_register_device(struct mt7915_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
-- 
2.18.0

