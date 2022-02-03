Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEDC4A8551
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 14:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350746AbiBCNgF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 08:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiBCNgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 08:36:04 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1248DC061714
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 05:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6ZaaB4vPBFn2UTw/P9txM+UQliDw8hbJHP2H91LhnmE=; b=OuW/WyrPFduTs+U2Xe+suf0/ej
        hiVjio92D4+AB7oP8TZCJuZ5ETiECDQqFw7OaoLT+k13KTT/qAqqMRfeH7G9eXEmz4eyet+rWaHkz
        mY9wzIF3spGIxBmOWihCfHWY0scI1p18ZrZcA1I4IyeBOXd+rfOIHSV1kLEMyPcE/epU=;
Received: from p200300daa71e0b007cedb37d167c1481.dip0.t-ipconnect.de ([2003:da:a71e:b00:7ced:b37d:167c:1481] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nFcHK-0001Et-5d
        for linux-wireless@vger.kernel.org; Thu, 03 Feb 2022 14:36:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/5] mt76: mt76x02: improve tx hang detection
Date:   Thu,  3 Feb 2022 14:35:57 +0100
Message-Id: <20220203133600.92211-2-nbd@nbd.name>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220203133600.92211-1-nbd@nbd.name>
References: <20220203133600.92211-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of checking if any queue has not made progress since the last run,
only trigger hang detection if one of the queues has not made any progress
in 10 subsequent runs. This should reduce false positive firmware restarts

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 30 +++++++------------
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 3232083e9916..f76fd22ee035 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -103,7 +103,7 @@ struct mt76x02_dev {
 	u8 tbtt_count;
 
 	u32 tx_hang_reset;
-	u8 tx_hang_check;
+	u8 tx_hang_check[4];
 	u8 beacon_hang_check;
 	u8 mcu_timeout;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index ec0de691129a..8bcd8afa0d3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -348,18 +348,20 @@ static bool mt76x02_tx_hang(struct mt76x02_dev *dev)
 	for (i = 0; i < 4; i++) {
 		q = dev->mphy.q_tx[i];
 
-		if (!q->queued)
-			continue;
-
 		prev_dma_idx = dev->mt76.tx_dma_idx[i];
 		dma_idx = readl(&q->regs->dma_idx);
 		dev->mt76.tx_dma_idx[i] = dma_idx;
 
-		if (prev_dma_idx == dma_idx)
-			break;
+		if (!q->queued || prev_dma_idx != dma_idx) {
+			dev->tx_hang_check[i] = 0;
+			continue;
+		}
+
+		if (++dev->tx_hang_check[i] >= MT_TX_HANG_TH)
+			return true;
 	}
 
-	return i < 4;
+	return false;
 }
 
 static void mt76x02_key_sync(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
@@ -530,23 +532,13 @@ static void mt76x02_check_tx_hang(struct mt76x02_dev *dev)
 	if (test_bit(MT76_RESTART, &dev->mphy.state))
 		return;
 
-	if (mt76x02_tx_hang(dev)) {
-		if (++dev->tx_hang_check >= MT_TX_HANG_TH)
-			goto restart;
-	} else {
-		dev->tx_hang_check = 0;
-	}
-
-	if (dev->mcu_timeout)
-		goto restart;
-
-	return;
+	if (!mt76x02_tx_hang(dev) && !dev->mcu_timeout)
+		return;
 
-restart:
 	mt76x02_watchdog_reset(dev);
 
 	dev->tx_hang_reset++;
-	dev->tx_hang_check = 0;
+	memset(dev->tx_hang_check, 0, sizeof(dev->tx_hang_check));
 	memset(dev->mt76.tx_dma_idx, 0xff,
 	       sizeof(dev->mt76.tx_dma_idx));
 }
-- 
2.32.0 (Apple Git-132)

