Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23238B0AF0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 11:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfILJG7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 05:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730489AbfILJG6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 05:06:58 -0400
Received: from localhost.localdomain (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B26D9208C2;
        Thu, 12 Sep 2019 09:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568279217;
        bh=ZUf4J4yq+fPr1b2/uIUr7T15ST5OP0CluRQ92fpF38E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJ6vI183gOa7n4XuMseneYNDxB6i3gSMP/0uDNASwvTC4uP6krhmRZQGVsBG+IesD
         AlbMull89i2HUoDwfS5smc7GnAkoiRfXWQ2/xUZyVZLaLokHOlh8c/51xxWqArq0so
         YTlIlQONic1Z2WL+LN9rVDOYebxkn6Aa6JlAeFQ4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH 4/4] mt76: mt76x02u: move mt76x02u_mac_start in mt76x02-usb module
Date:   Thu, 12 Sep 2019 11:06:38 +0200
Message-Id: <ffc75bf0713cbadfff9d08718c2ded327be64818.1568278771.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568278771.git.lorenzo@kernel.org>
References: <cover.1568278771.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unify mt76x02u_mac_start between mt76x2u and mt76x0u since the
code is shared between both drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76x0/init.c  | 16 --------------
 .../wireless/mediatek/mt76/mt76x0/mt76x0.h    |  1 -
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_usb.h  |  1 +
 .../wireless/mediatek/mt76/mt76x02_usb_core.c | 21 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76x2/mt76x2u.h   |  1 -
 .../wireless/mediatek/mt76/mt76x2/usb_mac.c   | 17 ---------------
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  3 ++-
 8 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
index d7bac4961c7b..388b54cded1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
@@ -150,22 +150,6 @@ static void mt76x0_init_mac_registers(struct mt76x02_dev *dev)
 	mt76_rmw(dev, MT_WMM_CTRL, 0x3ff, 0x201);
 }
 
-int mt76x0_mac_start(struct mt76x02_dev *dev)
-{
-	mt76x02_mac_reset_counters(dev);
-	mt76_wr(dev, MT_MAC_SYS_CTRL, MT_MAC_SYS_CTRL_ENABLE_TX);
-
-	if (!mt76x02_wait_for_wpdma(&dev->mt76, 200000))
-		return -ETIMEDOUT;
-
-	mt76_wr(dev, MT_RX_FILTR_CFG, dev->mt76.rxfilter);
-	mt76_wr(dev, MT_MAC_SYS_CTRL,
-		MT_MAC_SYS_CTRL_ENABLE_TX | MT_MAC_SYS_CTRL_ENABLE_RX);
-
-	return !mt76x02_wait_for_wpdma(&dev->mt76, 50) ? -ETIMEDOUT : 0;
-}
-EXPORT_SYMBOL_GPL(mt76x0_mac_start);
-
 void mt76x0_mac_stop(struct mt76x02_dev *dev)
 {
 	int i = 200, ok = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
index 26517e062bdb..82f5b481b723 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
@@ -46,7 +46,6 @@ int mt76x0_init_hardware(struct mt76x02_dev *dev);
 int mt76x0_register_device(struct mt76x02_dev *dev);
 void mt76x0_chip_onoff(struct mt76x02_dev *dev, bool enable, bool reset);
 
-int mt76x0_mac_start(struct mt76x02_dev *dev);
 void mt76x0_mac_stop(struct mt76x02_dev *dev);
 
 int mt76x0_config(struct ieee80211_hw *hw, u32 changed);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 00a445d27599..4c2b66b53533 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -103,7 +103,7 @@ static int mt76x0u_start(struct ieee80211_hw *hw)
 	struct mt76x02_dev *dev = hw->priv;
 	int ret;
 
-	ret = mt76x0_mac_start(dev);
+	ret = mt76x02u_mac_start(dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb.h b/drivers/net/wireless/mediatek/mt76/mt76x02_usb.h
index 98329debc033..a57dcc8820aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb.h
@@ -8,6 +8,7 @@
 
 #include "mt76x02.h"
 
+int mt76x02u_mac_start(struct mt76x02_dev *dev);
 void mt76x02u_init_mcu(struct mt76_dev *dev);
 void mt76x02u_mcu_fw_reset(struct mt76x02_dev *dev);
 int mt76x02u_mcu_fw_send_data(struct mt76x02_dev *dev, const void *data,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 78dfc1e7f27b..203420087ac4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -23,6 +23,27 @@ void mt76x02u_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 }
 EXPORT_SYMBOL_GPL(mt76x02u_tx_complete_skb);
 
+int mt76x02u_mac_start(struct mt76x02_dev *dev)
+{
+	mt76x02_mac_reset_counters(dev);
+
+	mt76_wr(dev, MT_MAC_SYS_CTRL, MT_MAC_SYS_CTRL_ENABLE_TX);
+	if (!mt76x02_wait_for_wpdma(&dev->mt76, 200000))
+		return -ETIMEDOUT;
+
+	mt76_wr(dev, MT_RX_FILTR_CFG, dev->mt76.rxfilter);
+
+	mt76_wr(dev, MT_MAC_SYS_CTRL,
+		MT_MAC_SYS_CTRL_ENABLE_TX |
+		MT_MAC_SYS_CTRL_ENABLE_RX);
+
+	if (!mt76x02_wait_for_wpdma(&dev->mt76, 50))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76x02u_mac_start);
+
 int mt76x02u_skb_dma_info(struct sk_buff *skb, int port, u32 flags)
 {
 	struct sk_buff *iter, *last = skb;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h b/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h
index c876bac43751..f9d37c6cf1f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h
@@ -24,7 +24,6 @@ void mt76x2u_cleanup(struct mt76x02_dev *dev);
 void mt76x2u_stop_hw(struct mt76x02_dev *dev);
 
 int mt76x2u_mac_reset(struct mt76x02_dev *dev);
-int mt76x2u_mac_start(struct mt76x02_dev *dev);
 int mt76x2u_mac_stop(struct mt76x02_dev *dev);
 
 int mt76x2u_phy_set_channel(struct mt76x02_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c
index 95eb85653bbd..59cbe826188a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c
@@ -92,23 +92,6 @@ int mt76x2u_mac_reset(struct mt76x02_dev *dev)
 	return 0;
 }
 
-int mt76x2u_mac_start(struct mt76x02_dev *dev)
-{
-	mt76x02_mac_reset_counters(dev);
-
-	mt76_wr(dev, MT_MAC_SYS_CTRL, MT_MAC_SYS_CTRL_ENABLE_TX);
-	mt76x02_wait_for_wpdma(&dev->mt76, 1000);
-	usleep_range(50, 100);
-
-	mt76_wr(dev, MT_RX_FILTR_CFG, dev->mt76.rxfilter);
-
-	mt76_wr(dev, MT_MAC_SYS_CTRL,
-		MT_MAC_SYS_CTRL_ENABLE_TX |
-		MT_MAC_SYS_CTRL_ENABLE_RX);
-
-	return 0;
-}
-
 int mt76x2u_mac_stop(struct mt76x02_dev *dev)
 {
 	int i, count = 0, val;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index eb73cb856c81..1e6f78760dd8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -4,13 +4,14 @@
  */
 
 #include "mt76x2u.h"
+#include "../mt76x02_usb.h"
 
 static int mt76x2u_start(struct ieee80211_hw *hw)
 {
 	struct mt76x02_dev *dev = hw->priv;
 	int ret;
 
-	ret = mt76x2u_mac_start(dev);
+	ret = mt76x02u_mac_start(dev);
 	if (ret)
 		return ret;
 
-- 
2.21.0

