Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4737827E87F
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 14:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgI3MY5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 08:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbgI3MYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:45 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0A5C061755
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Bq2kR3N41Brk83foe2VA8ohvQMVDSLBAQZrIYI6AxHM=; b=mJhpbBXuz5e22GSn5V4UcUOEX9
        hZdEsNembfH3k7BuyooOxIEoJk1qVrn++9gLAQAZcoEkGWGPkSA4csglfWJhpVJ2lfjQN98ssjELi
        CHWjaXBFEkJFy9FaF049m5EBGBmsJzT1nQVS+lf/F0qS4ARKLJuDNroIYTrXrMlsX4YM=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNbA4-0005MT-At
        for linux-wireless@vger.kernel.org; Wed, 30 Sep 2020 14:24:44 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 08/10] mt76: implement functions to get the response skb for MCU calls
Date:   Wed, 30 Sep 2020 14:24:39 +0200
Message-Id: <20200930122441.64523-8-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930122441.64523-1-nbd@nbd.name>
References: <20200930122441.64523-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Can be used by the caller to get the response data directly instead of using the
hack of storing the result in internal data structures from .mcu_parse_response

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mcu.c  | 23 +++++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt76.h | 21 +++++++++++++++++----
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 2bbe41e3b78f..76dadef7ccfe 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -51,8 +51,8 @@ void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(mt76_mcu_rx_event);
 
-int mt76_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data,
-		      int len, bool wait_resp)
+int mt76_mcu_send_and_get_msg(struct mt76_dev *dev, int cmd, const void *data,
+			      int len, bool wait_resp, struct sk_buff **ret_skb)
 {
 	struct sk_buff *skb;
 
@@ -63,16 +63,20 @@ int mt76_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data,
 	if (!skb)
 		return -ENOMEM;
 
-	return mt76_mcu_skb_send_msg(dev, skb, cmd, wait_resp);
+	return mt76_mcu_skb_send_and_get_msg(dev, skb, cmd, wait_resp, ret_skb);
 }
-EXPORT_SYMBOL_GPL(mt76_mcu_send_msg);
+EXPORT_SYMBOL_GPL(mt76_mcu_send_and_get_msg);
 
-int mt76_mcu_skb_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
-			  int cmd, bool wait_resp)
+int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
+				  int cmd, bool wait_resp,
+				  struct sk_buff **ret_skb)
 {
 	unsigned long expires;
 	int ret, seq;
 
+	if (ret_skb)
+		*ret_skb = NULL;
+
 	mutex_lock(&dev->mcu.mutex);
 
 	ret = dev->mcu_ops->mcu_skb_send_msg(dev, skb, cmd, &seq);
@@ -89,7 +93,10 @@ int mt76_mcu_skb_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
 	do {
 		skb = mt76_mcu_get_response(dev, expires);
 		ret = dev->mcu_ops->mcu_parse_response(dev, cmd, skb, seq);
-		dev_kfree_skb(skb);
+		if (!ret && ret_skb)
+			*ret_skb = skb;
+		else
+			dev_kfree_skb(skb);
 	} while (ret == -EAGAIN);
 
 out:
@@ -97,4 +104,4 @@ int mt76_mcu_skb_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mt76_mcu_skb_send_msg);
+EXPORT_SYMBOL_GPL(mt76_mcu_skb_send_and_get_msg);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index daa3d0b482a6..e1a3338c5723 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1067,10 +1067,23 @@ mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
 void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb);
 struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 				      unsigned long expires);
-int mt76_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data,
-		      int len, bool wait_resp);
-int mt76_mcu_skb_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
-			  int cmd, bool wait_resp);
+int mt76_mcu_send_and_get_msg(struct mt76_dev *dev, int cmd, const void *data,
+			      int len, bool wait_resp, struct sk_buff **ret);
+int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
+				  int cmd, bool wait_resp, struct sk_buff **ret);
+static inline int
+mt76_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data, int len,
+		  bool wait_resp)
+{
+	return mt76_mcu_send_and_get_msg(dev, cmd, data, len, wait_resp, NULL);
+}
+
+static inline int
+mt76_mcu_skb_send_msg(struct mt76_dev *dev, struct sk_buff *skb, int cmd,
+		      bool wait_resp)
+{
+	return mt76_mcu_skb_send_and_get_msg(dev, skb, cmd, wait_resp, NULL);
+}
 
 void mt76_set_irq_mask(struct mt76_dev *dev, u32 addr, u32 clear, u32 set);
 
-- 
2.28.0

