Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF4A64C243
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 03:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiLNC2b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Dec 2022 21:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiLNC23 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Dec 2022 21:28:29 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A769A1F9F3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 18:28:28 -0800 (PST)
X-UUID: f301869136394011a3be5bb182399f41-20221214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qAl+m1OTr5en6yAHBXyL88TpRTYUyea0S1uSD/4DSXE=;
        b=vBzqekjkuFQbKIc5ALOS5OjaaPKfDPIRe5h89BnAaK0besoWChudU39KOMMfIbeZH8A+NjN8iPOqeWwoKJIQjiezpkm+JWXxgUrxls8Swvy9rjkCz0EV+a4GFr8Qt/AtnlaEGmENIGg+w74/Rc8HhUbF75ySvpsNULXd9mVLhjI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:cde0644f-65e0-49b5-9d2c-451da0731650,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:dcaaed0,CLOUDID:02173625-4387-4253-a41d-4f6f2296b154,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f301869136394011a3be5bb182399f41-20221214
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 206152887; Wed, 14 Dec 2022 10:28:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 14 Dec 2022 10:28:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 14 Dec 2022 10:28:24 +0800
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
Subject: [PATCH v3 4/4] wifi: mt76: mt7915: add error message in mt7915_thermal_set_cur_throttle_state()
Date:   Wed, 14 Dec 2022 10:28:09 +0800
Message-ID: <20221214022809.32087-5-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221214022809.32087-1-howard-yh.hsu@mediatek.com>
References: <20221214022809.32087-1-howard-yh.hsu@mediatek.com>
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

Add dev_err so that it is easier to see invalid setting while looking at
dmesg.

Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   | 12 +++++++-----
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |  2 ++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 0ab9e1320fac..a89b37a320c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -145,8 +145,11 @@ mt7915_thermal_set_cur_throttle_state(struct thermal_cooling_device *cdev,
 	u8 throttling = MT7915_THERMAL_THROTTLE_MAX - state;
 	int ret;
 
-	if (state > MT7915_CDEV_THROTTLE_MAX)
+	if (state > MT7915_CDEV_THROTTLE_MAX) {
+		dev_err(phy->dev->mt76.dev,
+			"please specify a valid throttling state\n");
 		return -EINVAL;
+	}
 
 	if (state == phy->cdev_state)
 		return 0;
@@ -175,7 +178,7 @@ static void mt7915_unregister_thermal(struct mt7915_phy *phy)
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
 
 	if (!phy->cdev)
-	    return;
+		return;
 
 	sysfs_remove_link(&wiphy->dev.kobj, "cooling_device");
 	thermal_cooling_device_unregister(phy->cdev);
@@ -209,8 +212,8 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 		return PTR_ERR(hwmon);
 
 	/* initialize critical/maximum high temperature */
-	phy->throttle_temp[MT7915_CRIT_TEMP_IDX] = 110;
-	phy->throttle_temp[MT7915_MAX_TEMP_IDX] = 120;
+	phy->throttle_temp[MT7915_CRIT_TEMP_IDX] = MT7915_CRIT_TEMP;
+	phy->throttle_temp[MT7915_MAX_TEMP_IDX] = MT7915_MAX_TEMP;
 
 	return 0;
 }
@@ -1182,7 +1185,6 @@ static void mt7915_stop_hardware(struct mt7915_dev *dev)
 		mt7986_wmac_disable(dev);
 }
 
-
 int mt7915_register_device(struct mt7915_dev *dev)
 {
 	struct mt7915_phy *phy2;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index e58650bbbd14..942d70c53825 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -72,6 +72,8 @@
 
 #define MT7915_CRIT_TEMP_IDX		0
 #define MT7915_MAX_TEMP_IDX		1
+#define MT7915_CRIT_TEMP		110
+#define MT7915_MAX_TEMP			120
 
 struct mt7915_vif;
 struct mt7915_sta;
-- 
2.18.0

