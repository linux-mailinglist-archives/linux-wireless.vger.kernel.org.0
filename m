Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C75B4A8554
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 14:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347761AbiBCNgF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 08:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243939AbiBCNgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 08:36:04 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135ABC06173D
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 05:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BoSA3cWrIM0e0O1396vnvgBaXWTtieiiKblKqr9RbF4=; b=P8JHz4rKegXZKjPCqufVBFyIWQ
        JZaUbK7hPUxhsrQLF15KzzjdVvBpdwHshicQ1q9XwqRLkbXX7FAKk7G6ow1j/bqay2IIiWKm7pKt4
        Fe/VQKRMtEYlE8GMvSav8VLSgawk2AhUnK4rHpEkjtgUoUgL8NoVZZIRskozGMoLOyUE=;
Received: from p200300daa71e0b007cedb37d167c1481.dip0.t-ipconnect.de ([2003:da:a71e:b00:7ced:b37d:167c:1481] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nFcHJ-0001Et-VJ
        for linux-wireless@vger.kernel.org; Thu, 03 Feb 2022 14:36:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/5] mt76x02: improve mac error check/reset reliability
Date:   Thu,  3 Feb 2022 14:35:56 +0100
Message-Id: <20220203133600.92211-1-nbd@nbd.name>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On AP mode devices, check beacon tx counters to detect MAC errors.
When an error is detected, stop the MAC before resetting it

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  1 +
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 25 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt76x02_regs.h |  2 ++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 44d1a92d9a90..3232083e9916 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -104,6 +104,7 @@ struct mt76x02_dev {
 
 	u32 tx_hang_reset;
 	u8 tx_hang_check;
+	u8 beacon_hang_check;
 	u8 mcu_timeout;
 
 	struct mt76x02_calibration cal;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index a404fd7ea968..dc2aeaab72ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -1040,12 +1040,26 @@ EXPORT_SYMBOL_GPL(mt76x02_update_channel);
 
 static void mt76x02_check_mac_err(struct mt76x02_dev *dev)
 {
-	u32 val = mt76_rr(dev, 0x10f4);
+	if (dev->mt76.beacon_mask) {
+		if (mt76_rr(dev, MT_TX_STA_0) & MT_TX_STA_0_BEACONS) {
+			dev->beacon_hang_check = 0;
+			return;
+		}
 
-	if (!(val & BIT(29)) || !(val & (BIT(7) | BIT(5))))
-		return;
+		if (++dev->beacon_hang_check < 10)
+			return;
+
+		dev->beacon_hang_check = 0;
+	} else {
+		u32 val = mt76_rr(dev, 0x10f4);
+		if (!(val & BIT(29)) || !(val & (BIT(7) | BIT(5))))
+			return;
+	}
+
+	dev_err(dev->mt76.dev, "MAC error detected\n");
 
-	dev_err(dev->mt76.dev, "mac specific condition occurred\n");
+	mt76_wr(dev, MT_MAC_SYS_CTRL, 0);
+	mt76x02_wait_for_txrx_idle(&dev->mt76);
 
 	mt76_set(dev, MT_MAC_SYS_CTRL, MT_MAC_SYS_CTRL_RESET_CSR);
 	udelay(10);
@@ -1178,8 +1192,7 @@ void mt76x02_mac_work(struct work_struct *work)
 		dev->mt76.aggr_stats[idx++] += val >> 16;
 	}
 
-	if (!dev->mt76.beacon_mask)
-		mt76x02_check_mac_err(dev);
+	mt76x02_check_mac_err(dev);
 
 	if (dev->ed_monitor)
 		mt76x02_edcca_check(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
index fa7872ac22bf..fe0c5e3298bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
@@ -571,6 +571,8 @@
 #define MT_RX_STAT_2_OVERFLOW_ERRORS	GENMASK(31, 16)
 
 #define MT_TX_STA_0			0x170c
+#define MT_TX_STA_0_BEACONS		GENMASK(31, 16)
+
 #define MT_TX_STA_1			0x1710
 #define MT_TX_STA_2			0x1714
 
-- 
2.32.0 (Apple Git-132)

