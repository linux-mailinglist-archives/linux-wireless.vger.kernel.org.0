Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E78B0AED
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbfILJGw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 05:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730469AbfILJGv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 05:06:51 -0400
Received: from localhost.localdomain (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AC30208E4;
        Thu, 12 Sep 2019 09:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568279211;
        bh=Ova8ebWo8LSP1lN2VoHBrTMFGCTfKHHRC9Om0q8kvnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v2e9jeVliwsYm5MYnGd7sIClRXlwUck+Wp4KXayQQY5ybKHyyzpxBf3K9O2ORf+V/
         PuWkeeRurv6sMdL4H6Zo8PNesGOoEIuP68TeFFu3fdDo/v4ygDaSFbOtI6sjAykqks
         rtS086pnZVX4GhfG1iplchSN1D46IM8B9MF6wvQ4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH 1/4] mt76: mt76x02: move mac_reset_counter in mt76x02_lib module
Date:   Thu, 12 Sep 2019 11:06:35 +0200
Message-Id: <e1dae0a6551cf97080a98a05b1f4a02bee5a7de8.1568278771.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568278771.git.lorenzo@kernel.org>
References: <cover.1568278771.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unify mac_reset_counter routine and move it in mt76x02_lib module
since it is shared by all mt76x02 drivers (pci/usb)

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76x0/init.c  | 12 +----------
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 21 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  1 +
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  | 10 +--------
 .../wireless/mediatek/mt76/mt76x2/usb_mac.c   | 12 +----------
 5 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
index cf7fc307322b..541e81deba83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
@@ -150,16 +150,6 @@ static void mt76x0_init_mac_registers(struct mt76x02_dev *dev)
 	mt76_rmw(dev, MT_WMM_CTRL, 0x3ff, 0x201);
 }
 
-static void mt76x0_reset_counters(struct mt76x02_dev *dev)
-{
-	mt76_rr(dev, MT_RX_STAT_0);
-	mt76_rr(dev, MT_RX_STAT_1);
-	mt76_rr(dev, MT_RX_STAT_2);
-	mt76_rr(dev, MT_TX_STA_0);
-	mt76_rr(dev, MT_TX_STA_1);
-	mt76_rr(dev, MT_TX_STA_2);
-}
-
 int mt76x0_mac_start(struct mt76x02_dev *dev)
 {
 	mt76_wr(dev, MT_MAC_SYS_CTRL, MT_MAC_SYS_CTRL_ENABLE_TX);
@@ -244,7 +234,7 @@ int mt76x0_init_hardware(struct mt76x02_dev *dev)
 	for (i = 0; i < 256; i++)
 		mt76x02_mac_wcid_setup(dev, i, 0, NULL);
 
-	mt76x0_reset_counters(dev);
+	mt76x02_mac_reset_counters(dev);
 
 	ret = mt76x0_eeprom_init(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index abacb4ea7179..c681601f9114 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -7,6 +7,27 @@
 #include "mt76x02.h"
 #include "mt76x02_trace.h"
 
+void mt76x02_mac_reset_counters(struct mt76x02_dev *dev)
+{
+	int i;
+
+	mt76_rr(dev, MT_RX_STAT_0);
+	mt76_rr(dev, MT_RX_STAT_1);
+	mt76_rr(dev, MT_RX_STAT_2);
+	mt76_rr(dev, MT_TX_STA_0);
+	mt76_rr(dev, MT_TX_STA_1);
+	mt76_rr(dev, MT_TX_STA_2);
+
+	for (i = 0; i < 16; i++)
+		mt76_rr(dev, MT_TX_AGG_CNT(i));
+
+	for (i = 0; i < 16; i++)
+		mt76_rr(dev, MT_TX_STAT_FIFO);
+
+	memset(dev->aggr_stats, 0, sizeof(dev->aggr_stats));
+}
+EXPORT_SYMBOL_GPL(mt76x02_mac_reset_counters);
+
 static enum mt76x02_cipher_type
 mt76x02_mac_get_key_info(struct ieee80211_key_conf *key, u8 *key_data)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index efa4ef945e35..b687341236c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -161,6 +161,7 @@ static inline bool mt76x02_wait_for_mac(struct mt76_dev *dev)
 	return false;
 }
 
+void mt76x02_mac_reset_counters(struct mt76x02_dev *dev);
 void mt76x02_mac_set_short_preamble(struct mt76x02_dev *dev, bool enable);
 int mt76x02_mac_shared_key_setup(struct mt76x02_dev *dev, u8 vif_idx,
 				 u8 key_idx, struct ieee80211_key_conf *key);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index 343127f2d621..114e4fa4f4f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -148,15 +148,7 @@ int mt76x2_mac_reset(struct mt76x02_dev *dev, bool hard)
 
 int mt76x2_mac_start(struct mt76x02_dev *dev)
 {
-	int i;
-
-	for (i = 0; i < 16; i++)
-		mt76_rr(dev, MT_TX_AGG_CNT(i));
-
-	for (i = 0; i < 16; i++)
-		mt76_rr(dev, MT_TX_STAT_FIFO);
-
-	memset(dev->aggr_stats, 0, sizeof(dev->aggr_stats));
+	mt76x02_mac_reset_counters(dev);
 	mt76x02_mac_start(dev);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c
index e7fea3a6f1fd..95eb85653bbd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c
@@ -6,16 +6,6 @@
 #include "mt76x2u.h"
 #include "eeprom.h"
 
-static void mt76x2u_mac_reset_counters(struct mt76x02_dev *dev)
-{
-	mt76_rr(dev, MT_RX_STAT_0);
-	mt76_rr(dev, MT_RX_STAT_1);
-	mt76_rr(dev, MT_RX_STAT_2);
-	mt76_rr(dev, MT_TX_STA_0);
-	mt76_rr(dev, MT_TX_STA_1);
-	mt76_rr(dev, MT_TX_STA_2);
-}
-
 static void mt76x2u_mac_fixup_xtal(struct mt76x02_dev *dev)
 {
 	s8 offset = 0;
@@ -104,7 +94,7 @@ int mt76x2u_mac_reset(struct mt76x02_dev *dev)
 
 int mt76x2u_mac_start(struct mt76x02_dev *dev)
 {
-	mt76x2u_mac_reset_counters(dev);
+	mt76x02_mac_reset_counters(dev);
 
 	mt76_wr(dev, MT_MAC_SYS_CTRL, MT_MAC_SYS_CTRL_ENABLE_TX);
 	mt76x02_wait_for_wpdma(&dev->mt76, 1000);
-- 
2.21.0

