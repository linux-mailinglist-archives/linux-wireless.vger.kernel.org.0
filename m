Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 536B5C196B
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2019 22:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfI2ULo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Sep 2019 16:11:44 -0400
Received: from nbd.name ([46.4.11.11]:49644 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfI2ULo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Sep 2019 16:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pRTz2pw7iVLqX/8lNfiUebhUQuDRc/3/8pZtCCj4+f4=; b=K/erp3TOTxT48cQoFHr9qzV2za
        O437uTVS5HNTcbhaJah4yxW5YJVtjn8yhmKDa4ZtN3fFJbi6tqk1WFAA/YaDoIQr/2/Dwv7ga+MTO
        AkMuqXETvKazZgu4i29T9AooH9yI6gSB9a4MIpRPKzk+5LJDM2Ay8Yrl5xCy6bUN7szQ=;
Received: from p5b20652d.dip0.t-ipconnect.de ([91.32.101.45] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iEfXi-000420-T4
        for linux-wireless@vger.kernel.org; Sun, 29 Sep 2019 22:11:42 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 1B0936A0074B; Sun, 29 Sep 2019 22:11:41 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: do not use devm API for led classdev
Date:   Sun, 29 Sep 2019 22:11:41 +0200
Message-Id: <20190929201141.50613-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With the devm API, the unregister happens after the device cleanup is done,
after which the struct mt76_dev which contains the led_cdev has already been
freed. This leads to a use-after-free bug that can crash the system.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 9a59a1b54c97..a962abce98f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -105,7 +105,15 @@ static int mt76_led_init(struct mt76_dev *dev)
 		dev->led_al = of_property_read_bool(np, "led-active-low");
 	}
 
-	return devm_led_classdev_register(dev->dev, &dev->led_cdev);
+	return led_classdev_register(dev->dev, &dev->led_cdev);
+}
+
+static void mt76_led_cleanup(struct mt76_dev *dev)
+{
+	if (!dev->led_cdev.brightness_set && !dev->led_cdev.blink_set)
+		return;
+
+	led_classdev_unregister(&dev->led_cdev);
 }
 
 static void mt76_init_stream_cap(struct mt76_dev *dev,
@@ -362,6 +370,7 @@ void mt76_unregister_device(struct mt76_dev *dev)
 {
 	struct ieee80211_hw *hw = dev->hw;
 
+	mt76_led_cleanup(dev);
 	mt76_tx_status_check(dev, NULL, true);
 	ieee80211_unregister_hw(hw);
 }
-- 
2.17.0

