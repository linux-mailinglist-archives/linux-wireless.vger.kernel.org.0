Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E9963BCBC
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 10:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiK2JRN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 04:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiK2JRM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 04:17:12 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7675655F
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 01:17:07 -0800 (PST)
X-UUID: 470a8632d5264003a1798683f8a55651-20221129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vPZP8OXAsUHf4FSEg8/nwXU6njDiIjCMBp/8fZvopqI=;
        b=Kh8a4iLaWFBBw1W1JG/j113TLlO4YdsCdOydnClfdB9pZWxMfsTwLhvkdp0TYOoGN+gik/g+NCYbdTYP5kwZTdkQlm5fRPnOBcvUlWTbQbeKAde/JSyM0ZuQfdFII8fonH5hB7C3EzhcFy7oglUQ3oBWZxpi5MEbWTPe425O+L0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:bd631a99-6455-483a-b545-b6aa740feca3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:80749d1e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 470a8632d5264003a1798683f8a55651-20221129
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 830181379; Tue, 29 Nov 2022 17:17:02 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 29 Nov 2022 17:17:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 29 Nov 2022 17:17:00 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2 1/2] wifi: mt76: introduce reboot notifier support
Date:   Tue, 29 Nov 2022 17:16:37 +0800
Message-ID: <d44631bcc74cce3f32a72f616a99d1bd2837690f.1669711916.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some combinations of hosts cannnot detect wifi chip after reboot. The
interoperability issue is caused by the status mismatch between host
and chip fw. In such cases, the driver should stop chip activities
and reset chip to default state before reboot.

This is a preliminary patch to add mt7921e reboot notifier support.

Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 21 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index fc608b369b3c..a8515cb2527e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -230,6 +230,22 @@ static void mt76_led_cleanup(struct mt76_dev *dev)
 	led_classdev_unregister(&dev->led_cdev);
 }
 
+static int mt76_notifier_init(struct mt76_dev *dev)
+{
+	if (!dev->reboot_nb.notifier_call)
+		return 0;
+
+	return register_reboot_notifier(&dev->reboot_nb);
+}
+
+static void mt76_notifier_cleanup(struct mt76_dev *dev)
+{
+	if (!dev->reboot_nb.notifier_call)
+		return;
+
+	unregister_reboot_notifier(&dev->reboot_nb);
+}
+
 static void mt76_init_stream_cap(struct mt76_phy *phy,
 				 struct ieee80211_supported_band *sband,
 				 bool vht)
@@ -658,6 +674,10 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 			return ret;
 	}
 
+	ret = mt76_notifier_init(dev);
+	if (ret)
+		return ret;
+
 	ret = ieee80211_register_hw(hw);
 	if (ret)
 		return ret;
@@ -675,6 +695,7 @@ void mt76_unregister_device(struct mt76_dev *dev)
 
 	if (IS_ENABLED(CONFIG_MT76_LEDS))
 		mt76_led_cleanup(dev);
+	mt76_notifier_cleanup(dev);
 	mt76_tx_status_check(dev, true);
 	ieee80211_unregister_hw(hw);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 32a77a0ae9da..73a504016288 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -13,6 +13,7 @@
 #include <linux/leds.h>
 #include <linux/usb.h>
 #include <linux/average.h>
+#include <linux/reboot.h>
 #include <linux/soc/mediatek/mtk_wed.h>
 #include <net/mac80211.h>
 #include "util.h"
@@ -835,6 +836,7 @@ struct mt76_dev {
 		struct mt76_usb usb;
 		struct mt76_sdio sdio;
 	};
+	struct notifier_block reboot_nb;
 };
 
 struct mt76_power_limits {
-- 
2.18.0

