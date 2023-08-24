Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF484787660
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbjHXRJS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 13:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242855AbjHXRIx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 13:08:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915C919A3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 10:08:45 -0700 (PDT)
X-UUID: df04490a42a011ee9cb5633481061a41-20230825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ATrXCM7+qSOheR+SJgfPJ9Nees7z4bkd7+kSh3wvmIE=;
        b=QBwSREAKif2TGXY/DJDuAcHsgOxxB2Md/Bioo7/JUezqWe0p29tkfQUQKaOIe4AhAfEFmW4zS3Jbd8NXkTkcVAcjaGJ5R6pmgC32Rbirr/v4uYdgrYgIH+B5lFUURuHd1AK0Bw8EpejJCRJzygUBmdOQfpkYgMCzjatxfks1WIQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:4d0ac132-426f-4a90-b3e2-521c42baa2d6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:06102713-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: df04490a42a011ee9cb5633481061a41-20230825
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 53636015; Fri, 25 Aug 2023 01:08:39 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Aug 2023 01:08:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Aug 2023 01:08:38 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Alexey D . Filimonov" <alexey@filimonic.net>
Subject: [PATCH] wifi: mt76: add ability to explicitly forbid LED registration with DT
Date:   Fri, 25 Aug 2023 01:08:37 +0800
Message-ID: <b08ef4d7c91c54e273c61784272e5c6f70c3c137.1692896654.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add ability to explicitly forbid LED registration using DT led\status = "disabled".

Tested-by: Alexey D. Filimonov <alexey@filimonic.net>
Signed-off-by: Alexey D. Filimonov <alexey@filimonic.net>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 39 ++++++++++++-------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index c0ff36a98bed..f768d9aed456 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -198,10 +198,33 @@ static int mt76_led_init(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_hw *hw = phy->hw;
+	struct device_node *np = dev->dev->of_node;
 
 	if (!phy->leds.cdev.brightness_set && !phy->leds.cdev.blink_set)
 		return 0;
 
+	np = of_get_child_by_name(np, "led");
+	if (np) {
+		if (!of_device_is_available(np)) {
+			of_node_put(np);
+			dev_info(dev->dev,
+				"led registration was explicitly disabled by dts\n");
+			return 0;
+		}
+
+		if (phy == &dev->phy) {
+			int led_pin;
+
+			if (!of_property_read_u32(np, "led-sources", &led_pin))
+				phy->leds.pin = led_pin;
+
+			phy->leds.al =
+				of_property_read_bool(np, "led-active-low");
+		}
+
+		of_node_put(np);
+	}
+
 	snprintf(phy->leds.name, sizeof(phy->leds.name), "mt76-%s",
 		 wiphy_name(hw->wiphy));
 
@@ -212,20 +235,8 @@ static int mt76_led_init(struct mt76_phy *phy)
 					mt76_tpt_blink,
 					ARRAY_SIZE(mt76_tpt_blink));
 
-	if (phy == &dev->phy) {
-		struct device_node *np = dev->dev->of_node;
-
-		np = of_get_child_by_name(np, "led");
-		if (np) {
-			int led_pin;
-
-			if (!of_property_read_u32(np, "led-sources", &led_pin))
-				phy->leds.pin = led_pin;
-			phy->leds.al = of_property_read_bool(np,
-							     "led-active-low");
-			of_node_put(np);
-		}
-	}
+	dev_info(dev->dev,
+		"registering led '%s'\n", phy->leds.name);
 
 	return led_classdev_register(dev->dev, &phy->leds.cdev);
 }
-- 
2.18.0

