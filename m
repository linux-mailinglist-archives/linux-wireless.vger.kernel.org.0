Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2271B27E876
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 14:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgI3MYq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 08:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgI3MYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:45 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0841DC0613D2
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2SzTG17fWCnNh0HkuGaG49QDwRtE8g3VmpfeUnzM/LM=; b=E4UvtF1pE+/88FoDr8HaU3MDT2
        7GomyGWByNbamHbcMz4SAf//dQSyPD7R5yRWnkvmLh4NGtJcu9dXMgllUX0ooRGHao9SzO4xGHHqf
        KysWqFKnTyqC8OCgMjRSa6yzFFAQoAJ64ju/Q7ccU8C1RpPHmu0RVPq7EGVYM/xwUDvM=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNbA3-0005MT-Jl
        for linux-wireless@vger.kernel.org; Wed, 30 Sep 2020 14:24:43 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 04/10] mt76: move mcu timeout handling to .mcu_parse_response
Date:   Wed, 30 Sep 2020 14:24:35 +0200
Message-Id: <20200930122441.64523-4-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930122441.64523-1-nbd@nbd.name>
References: <20200930122441.64523-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Preparation for further cleanup

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   | 21 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 15 ++++++-------
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  | 21 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 15 ++++++-------
 4 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 6cd947df6429..f787c9d3088e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -17,8 +17,18 @@ static int
 mt7603_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			  struct sk_buff *skb, int seq)
 {
-	struct mt7603_mcu_rxd *rxd = (struct mt7603_mcu_rxd *)skb->data;
+	struct mt7603_dev *dev = container_of(mdev, struct mt7603_dev, mt76);
+	struct mt7603_mcu_rxd *rxd;
+
+	if (!skb) {
+		dev_err(mdev->dev,
+			"MCU message %d (seq %d) timed out\n",
+			cmd, seq);
+		dev->mcu_hang = MT7603_WATCHDOG_TIMEOUT;
+		return -ETIMEDOUT;
+	}
 
+	rxd = (struct mt7603_mcu_rxd *)skb->data;
 	if (seq != rxd->seq)
 		return -EAGAIN;
 
@@ -85,15 +95,6 @@ mt7603_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 
 	while (wait_resp) {
 		skb = mt76_mcu_get_response(&dev->mt76, expires);
-		if (!skb) {
-			dev_err(mdev->dev,
-				"MCU message %d (seq %d) timed out\n",
-				cmd, seq);
-			dev->mcu_hang = MT7603_WATCHDOG_TIMEOUT;
-			ret = -ETIMEDOUT;
-			break;
-		}
-
 		ret = mt7603_mcu_parse_response(mdev, cmd, skb, seq);
 		dev_kfree_skb(skb);
 		if (ret != -EAGAIN)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index f042299b110e..fb0dce401b9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -182,9 +182,16 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq)
 {
-	struct mt7615_mcu_rxd *rxd = (struct mt7615_mcu_rxd *)skb->data;
+	struct mt7615_mcu_rxd *rxd;
 	int ret = 0;
 
+	if (!skb) {
+		dev_err(mdev->dev, "Message %ld (seq %d) timeout\n",
+			cmd & MCU_CMD_MASK, seq);
+		return -ETIMEDOUT;
+	}
+
+	rxd = (struct mt7615_mcu_rxd *)skb->data;
 	if (seq != rxd->seq)
 		return -EAGAIN;
 
@@ -238,12 +245,6 @@ int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq)
 
 	while (true) {
 		skb = mt76_mcu_get_response(&dev->mt76, expires);
-		if (!skb) {
-			dev_err(dev->mt76.dev, "Message %ld (seq %d) timeout\n",
-				cmd & MCU_CMD_MASK, seq);
-			return -ETIMEDOUT;
-		}
-
 		ret = mt7615_mcu_parse_response(&dev->mt76, cmd, skb, seq);
 		dev_kfree_skb(skb);
 		if (ret != -EAGAIN)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index e35b3a253f82..3b2184254ae9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -13,8 +13,18 @@
 int mt76x02_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			       struct sk_buff *skb, int seq)
 {
-	u32 *rxfce = (u32 *)skb->cb;
+	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
+	u32 *rxfce;
+
+	if (!skb) {
+		dev_err(mdev->dev,
+			"MCU message %d (seq %d) timed out\n", cmd,
+			seq);
+		dev->mcu_timeout = 1;
+		return -ETIMEDOUT;
+	}
 
+	rxfce = (u32 *)skb->cb;
 	if (seq != FIELD_GET(MT_RX_FCE_INFO_CMD_SEQ, *rxfce))
 		return -EAGAIN;
 
@@ -57,15 +67,6 @@ int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 
 	while (wait_resp) {
 		skb = mt76_mcu_get_response(&dev->mt76, expires);
-		if (!skb) {
-			dev_err(mdev->dev,
-				"MCU message %d (seq %d) timed out\n", cmd,
-				seq);
-			ret = -ETIMEDOUT;
-			dev->mcu_timeout = 1;
-			break;
-		}
-
 		ret = mt76x02_mcu_parse_response(mdev, cmd, skb, seq);
 		dev_kfree_skb(skb);
 		if (ret != -EAGAIN)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 946fe139b9f7..e89fb44f8d75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -313,9 +313,16 @@ mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			  struct sk_buff *skb, int seq)
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	struct mt7915_mcu_rxd *rxd = (struct mt7915_mcu_rxd *)skb->data;
+	struct mt7915_mcu_rxd *rxd;
 	int ret = 0;
 
+	if (!skb) {
+		dev_err(mdev->dev, "Message %d (seq %d) timeout\n",
+			cmd, seq);
+		return -ETIMEDOUT;
+	}
+
+	rxd = (struct mt7915_mcu_rxd *)skb->data;
 	if (seq != rxd->seq)
 		return -EAGAIN;
 
@@ -347,12 +354,6 @@ mt7915_mcu_wait_response(struct mt7915_dev *dev, int cmd, int seq)
 
 	while (true) {
 		skb = mt76_mcu_get_response(&dev->mt76, expires);
-		if (!skb) {
-			dev_err(dev->mt76.dev, "Message %d (seq %d) timeout\n",
-				cmd, seq);
-			return -ETIMEDOUT;
-		}
-
 		ret = mt7915_mcu_parse_response(&dev->mt76, cmd, skb, seq);
 		dev_kfree_skb(skb);
 		if (ret != -EAGAIN)
-- 
2.28.0

