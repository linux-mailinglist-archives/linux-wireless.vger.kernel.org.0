Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AFA27E879
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 14:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgI3MYr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbgI3MYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:45 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EF6C061755
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0xbOfL8uI+P+AhzECRIR8tUe+PO39vwIMjs5sBJam80=; b=Q1YHq2fHGa22qduvq2e9UNbHWA
        4hmlYYTiDnHrKtkjjCcUHBQNhZEC+ZyLr+av1yx2mJSqPYWtjmDpedLcXRS4uPsq5lgNpRymNdkS1
        j0By3gIiP2Npc68rL15xnUPKeP70LdJBnJmZlPMc+HHSHxyDdnGwtLstdLfi3HCOVnbo=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNbA3-0005MT-Vb
        for linux-wireless@vger.kernel.org; Wed, 30 Sep 2020 14:24:44 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 06/10] mt76: make mcu_ops->mcu_send_msg optional
Date:   Wed, 30 Sep 2020 14:24:37 +0200
Message-Id: <20200930122441.64523-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930122441.64523-1-nbd@nbd.name>
References: <20200930122441.64523-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove it from mt7615 and mt7915 and implement it in core code instead

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mcu.c         | 16 ++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h        |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 14 --------------
 .../net/wireless/mediatek/mt76/mt7615/mt7615.h   |  2 --
 .../net/wireless/mediatek/mt76/mt7615/sdio_mcu.c |  1 -
 .../net/wireless/mediatek/mt76/mt7615/usb_mcu.c  |  1 -
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  | 14 --------------
 7 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 118272cabe16..2bbe41e3b78f 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -51,6 +51,22 @@ void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(mt76_mcu_rx_event);
 
+int mt76_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data,
+		      int len, bool wait_resp)
+{
+	struct sk_buff *skb;
+
+	if (dev->mcu_ops->mcu_send_msg)
+		return dev->mcu_ops->mcu_send_msg(dev, cmd, data, len, wait_resp);
+
+	skb = mt76_mcu_msg_alloc(dev, data, len);
+	if (!skb)
+		return -ENOMEM;
+
+	return mt76_mcu_skb_send_msg(dev, skb, cmd, wait_resp);
+}
+EXPORT_SYMBOL_GPL(mt76_mcu_send_msg);
+
 int mt76_mcu_skb_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
 			  int cmd, bool wait_resp)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 82e333622c81..daa3d0b482a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -689,7 +689,6 @@ enum mt76_phy_type {
 #define mt76_rd_rp(dev, ...)	(dev)->mt76.bus->rd_rp(&((dev)->mt76), __VA_ARGS__)
 
 
-#define mt76_mcu_send_msg(dev, ...)	(dev)->mcu_ops->mcu_send_msg((dev), __VA_ARGS__)
 #define mt76_mcu_restart(dev, ...)	(dev)->mt76.mcu_ops->mcu_restart(&((dev)->mt76))
 #define __mt76_mcu_restart(dev, ...)	(dev)->mcu_ops->mcu_restart((dev))
 
@@ -1068,6 +1067,8 @@ mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
 void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb);
 struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 				      unsigned long expires);
+int mt76_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data,
+		      int len, bool wait_resp);
 int mt76_mcu_skb_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
 			  int cmd, bool wait_resp);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 0008d82d07f6..28730949dce7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -242,19 +242,6 @@ mt7615_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, qid, skb, 0);
 }
 
-int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
-			int len, bool wait_resp)
-{
-	struct sk_buff *skb;
-
-	skb = mt76_mcu_msg_alloc(mdev, data, len);
-	if (!skb)
-		return -ENOMEM;
-
-	return mt76_mcu_skb_send_msg(mdev, skb, cmd, wait_resp);
-}
-EXPORT_SYMBOL_GPL(mt7615_mcu_msg_send);
-
 u32 mt7615_rf_rr(struct mt7615_dev *dev, u32 wf, u32 reg)
 {
 	struct {
@@ -2429,7 +2416,6 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 	static const struct mt76_mcu_ops mt7615_mcu_ops = {
 		.headroom = sizeof(struct mt7615_mcu_txd),
 		.mcu_skb_send_msg = mt7615_mcu_send_message,
-		.mcu_send_msg = mt7615_mcu_msg_send,
 		.mcu_parse_response = mt7615_mcu_parse_response,
 		.mcu_restart = mt7615_mcu_restart,
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index e0102627c848..f72506d9f646 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -589,8 +589,6 @@ int mt7615_mac_wtbl_update_key(struct mt7615_dev *dev,
 void mt7615_mac_reset_work(struct work_struct *work);
 u32 mt7615_mac_get_sta_tid_sn(struct mt7615_dev *dev, int wcid, u8 tid);
 
-int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
-			int len, bool wait_resp);
 int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq);
 u32 mt7615_rf_rr(struct mt7615_dev *dev, u32 wf, u32 reg);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index e48169395077..2a387dcb23d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -120,7 +120,6 @@ int mt7663s_mcu_init(struct mt7615_dev *dev)
 		.headroom = sizeof(struct mt7615_mcu_txd),
 		.tailroom = MT_USB_TAIL_SIZE,
 		.mcu_skb_send_msg = mt7663s_mcu_send_message,
-		.mcu_send_msg = mt7615_mcu_msg_send,
 		.mcu_parse_response = mt7615_mcu_parse_response,
 		.mcu_restart = mt7615_mcu_restart,
 		.mcu_rr = mt7615_mcu_reg_rr,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index 6356d3d00c3b..c55698f9c49a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -48,7 +48,6 @@ int mt7663u_mcu_init(struct mt7615_dev *dev)
 		.headroom = MT_USB_HDR_SIZE + sizeof(struct mt7615_mcu_txd),
 		.tailroom = MT_USB_TAIL_SIZE,
 		.mcu_skb_send_msg = mt7663u_mcu_send_message,
-		.mcu_send_msg = mt7615_mcu_msg_send,
 		.mcu_parse_response = mt7615_mcu_parse_response,
 		.mcu_restart = mt7615_mcu_restart,
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index d278743d948e..cafcafe62c64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -350,19 +350,6 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, txq, skb, 0);
 }
 
-static int
-mt7915_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
-		    int len, bool wait_resp)
-{
-	struct sk_buff *skb;
-
-	skb = mt76_mcu_msg_alloc(mdev, data, len);
-	if (!skb)
-		return -ENOMEM;
-
-	return mt76_mcu_skb_send_msg(mdev, skb, cmd, wait_resp);
-}
-
 static void
 mt7915_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
@@ -2924,7 +2911,6 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 	static const struct mt76_mcu_ops mt7915_mcu_ops = {
 		.headroom = sizeof(struct mt7915_mcu_txd),
 		.mcu_skb_send_msg = mt7915_mcu_send_message,
-		.mcu_send_msg = mt7915_mcu_msg_send,
 		.mcu_parse_response = mt7915_mcu_parse_response,
 		.mcu_restart = mt7915_mcu_restart,
 	};
-- 
2.28.0

