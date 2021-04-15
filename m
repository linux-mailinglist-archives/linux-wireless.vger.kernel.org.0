Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F7F360F5F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 17:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhDOPuc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 11:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhDOPub (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 11:50:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C38B610CE;
        Thu, 15 Apr 2021 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618501808;
        bh=NisZBAhrB8qRrjarKe0ZbpObJNgvhZhbw1RM+83/XNc=;
        h=From:To:Cc:Subject:Date:From;
        b=iZhCcPmh+kgajJA5QE0VEUtq7Icot1rBqcXPmoADS1RXpSkx3n2BPhG0w3nigFbSr
         o1mMmiF4J1lBB7KgwJ7GYJPaD9OKCg6WhA7e+0UsKD05kAnUxjyRGFCz32FWP1ASM2
         Vx3Llq2VgJLZR25RcY9u51Fz4gle2ouKwwn7QHRrwvfH8Jbi54H7yeJVWzqeeIq08A
         YfI7i4Y0TScgwzX/2DL77A1Iko8gkyWVOuQNGmxf6JIRfl6dxVcwuQr8GAwculWDII
         kuO6dC87I5PCbjxEwW+39uR79AlilITucM8wb8qAvefrSYOMhY7zU5Hf5xq2TU3w3C
         jzgGfqQeyS+dg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: improve mcu error logging
Date:   Thu, 15 Apr 2021 17:50:02 +0200
Message-Id: <a93ba78fc7ed4577c7a4dfac73a842ba32ca23a4.1618501534.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dump mcu command code in hex and related prefix to help debugging

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c  | 5 ++---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c | 5 ++---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c  | 2 +-
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 96b6c8916730..6abfe6b19afa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -21,9 +21,8 @@ mt7603_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	struct mt7603_mcu_rxd *rxd;
 
 	if (!skb) {
-		dev_err(mdev->dev,
-			"MCU message %d (seq %d) timed out\n",
-			cmd, seq);
+		dev_err(mdev->dev, "MCU message %02x (seq %d) timed out\n",
+			abs(cmd), seq);
 		dev->mcu_hang = MT7603_WATCHDOG_TIMEOUT;
 		return -ETIMEDOUT;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index eab490d07255..6f6d33494b33 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -175,8 +175,8 @@ int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	int ret = 0;
 
 	if (!skb) {
-		dev_err(mdev->dev, "Message %ld (seq %d) timeout\n",
-			cmd & MCU_CMD_MASK, seq);
+		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
+			cmd, seq);
 		return -ETIMEDOUT;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 4aa5c36afeaf..75978820a260 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -17,9 +17,8 @@ int mt76x02_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	u32 *rxfce;
 
 	if (!skb) {
-		dev_err(mdev->dev,
-			"MCU message %d (seq %d) timed out\n", cmd,
-			seq);
+		dev_err(mdev->dev, "MCU message %02x (seq %d) timed out\n",
+			abs(cmd), seq);
 		dev->mcu_timeout = 1;
 		return -ETIMEDOUT;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0b739ed8ce33..5d992740e076 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -217,7 +217,7 @@ mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	int ret = 0;
 
 	if (!skb) {
-		dev_err(mdev->dev, "Message %d (seq %d) timeout\n",
+		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
 			cmd, seq);
 		return -ETIMEDOUT;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 1f231088f287..a360929983ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -160,7 +160,7 @@ mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	int ret = 0;
 
 	if (!skb) {
-		dev_err(mdev->dev, "Message %d (seq %d) timeout\n",
+		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
 			cmd, seq);
 		return -ETIMEDOUT;
 	}
-- 
2.30.2

