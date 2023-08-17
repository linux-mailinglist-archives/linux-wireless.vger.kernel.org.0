Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A175177F1B1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 10:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346313AbjHQICb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 04:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348722AbjHQICX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 04:02:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3539A2D57
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 01:02:17 -0700 (PDT)
X-UUID: 5fd36a163cd411eeb20a276fd37b9834-20230817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=35RsuwsRgKIMIZu+oVUCnueoPyLNnhvnHPtjk0veQVg=;
        b=o30remYyR5+awzWoDWxFjjqOAIK9JSnKmwIS6YJ6/dD7zhl5cJe/bnGmN/UR0NBc08zXXMvLU3n5EOVtt2k84Dry4mayWp8j4NeO3l7EBfm5m5A+PqlWx6rJlDlqU6aikh3NQA5wvuEeodne7B6t2/Vrue6trtlnWBBfhTVRT44=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:0bf9091e-3c27-43f3-a8c3-d77aaf2d9b9c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:164ddf12-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5fd36a163cd411eeb20a276fd37b9834-20230817
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 29763282; Thu, 17 Aug 2023 16:02:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Aug 2023 16:02:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Aug 2023 16:02:12 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Jen-Hao Cheng <jen-hao.cheng@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 9/9] wifi: mt76: mt7996: support per-band LED control
Date:   Thu, 17 Aug 2023 16:01:54 +0800
Message-ID: <20230817080154.16475-9-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230817080154.16475-1-shayne.chen@mediatek.com>
References: <20230817080154.16475-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jen-Hao Cheng <jen-hao.cheng@mediatek.com>

Extend settings of LED registers to support per-band configuration.

Signed-off-by: Jen-Hao Cheng <jen-hao.cheng@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 34 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  1 +
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index de090416c19d..f16f738e30db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -53,23 +53,31 @@ static void mt7996_led_set_config(struct led_classdev *led_cdev,
 	dev = container_of(mphy->dev, struct mt7996_dev, mt76);
 
 	/* select TX blink mode, 2: only data frames */
-	mt76_rmw_field(dev, MT_TMAC_TCR0(0), MT_TMAC_TCR0_TX_BLINK, 2);
+	mt76_rmw_field(dev, MT_TMAC_TCR0(mphy->band_idx), MT_TMAC_TCR0_TX_BLINK, 2);
 
 	/* enable LED */
-	mt76_wr(dev, MT_LED_EN(0), 1);
+	mt76_wr(dev, MT_LED_EN(mphy->band_idx), 1);
 
 	/* set LED Tx blink on/off time */
 	val = FIELD_PREP(MT_LED_TX_BLINK_ON_MASK, delay_on) |
 	      FIELD_PREP(MT_LED_TX_BLINK_OFF_MASK, delay_off);
-	mt76_wr(dev, MT_LED_TX_BLINK(0), val);
+	mt76_wr(dev, MT_LED_TX_BLINK(mphy->band_idx), val);
+
+	/* turn LED off */
+	if (delay_off == 0xff && delay_on == 0x0) {
+		val = MT_LED_CTRL_POLARITY | MT_LED_CTRL_KICK;
+	} else {
+		/* control LED */
+		val = MT_LED_CTRL_BLINK_MODE | MT_LED_CTRL_KICK;
+		if (mphy->band_idx == MT_BAND1)
+			val |= MT_LED_CTRL_BLINK_BAND_SEL;
+	}
 
-	/* control LED */
-	val = MT_LED_CTRL_BLINK_MODE | MT_LED_CTRL_KICK;
 	if (mphy->leds.al)
 		val |= MT_LED_CTRL_POLARITY;
 
-	mt76_wr(dev, MT_LED_CTRL(0), val);
-	mt76_clear(dev, MT_LED_CTRL(0), MT_LED_CTRL_KICK);
+	mt76_wr(dev, MT_LED_CTRL(mphy->band_idx), val);
+	mt76_clear(dev, MT_LED_CTRL(mphy->band_idx), MT_LED_CTRL_KICK);
 }
 
 static int mt7996_led_set_blink(struct led_classdev *led_cdev,
@@ -222,6 +230,12 @@ mt7996_init_wiphy(struct ieee80211_hw *hw)
 		ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 	}
 
+	/* init led callbacks */
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		phy->mt76->leds.cdev.brightness_set = mt7996_led_set_brightness;
+		phy->mt76->leds.cdev.blink_set = mt7996_led_set_blink;
+	}
+
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7996_set_stream_vht_txbf_caps(phy);
 	mt7996_set_stream_he_eht_caps(phy);
@@ -870,12 +884,6 @@ int mt7996_register_device(struct mt7996_dev *dev)
 
 	mt7996_init_wiphy(hw);
 
-	/* init led callbacks */
-	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		dev->mphy.leds.cdev.brightness_set = mt7996_led_set_brightness;
-		dev->mphy.leds.cdev.blink_set = mt7996_led_set_blink;
-	}
-
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
 				   ARRAY_SIZE(mt76_rates));
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 97beab924517..57022906216c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -509,6 +509,7 @@ enum base_rev {
 
 #define MT_LED_CTRL(_n)				MT_LED_PHYS(0x00 + ((_n) * 4))
 #define MT_LED_CTRL_KICK			BIT(7)
+#define MT_LED_CTRL_BLINK_BAND_SEL		BIT(4)
 #define MT_LED_CTRL_BLINK_MODE			BIT(2)
 #define MT_LED_CTRL_POLARITY			BIT(1)
 
-- 
2.39.2

