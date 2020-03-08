Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B6617D6A6
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 23:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgCHWJR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 18:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgCHWJR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 18:09:17 -0400
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8BF320848;
        Sun,  8 Mar 2020 22:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583705356;
        bh=cUnOmIT5EXyOr1ej+HzSCw1RnxE5kvobRb+D7MrnwQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VIPpRo1RGIGZJc92NPL7L1cbjUb1muFER5plKwjU86BlJtYO/G88EigsBGPgabPqg
         U6fZqkQyreiGAOdma+ED49rKaaCZ8ewd+4ckoie26o+BSmuNyRg0iU5QmfdaObyfWN
         SIZBhnoCqCoPUgO/JL0QkSlQDLOGonRNxINQynrA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: [PATCH v2 06/25] mt76: mt7615: introduce mt7615_mcu_send_message routine
Date:   Sun,  8 Mar 2020 23:08:18 +0100
Message-Id: <207931883fc4cf8236ccf40d2cce861b9cafb7fc.1583705012.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583705012.git.lorenzo@kernel.org>
References: <cover.1583705012.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_mcu_send_message routine in order to allocate mcu skb
out of mcu sending routine. This approach is useful when the mcu
message is complicated and it is convenient to rely on skb buffer API

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 23 +++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index aca477434858..8e4759bc8f59 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -139,6 +139,8 @@ struct mt76_sw_queue {
 struct mt76_mcu_ops {
 	int (*mcu_send_msg)(struct mt76_dev *dev, int cmd, const void *data,
 			    int len, bool wait_resp);
+	int (*mcu_skb_send_msg)(struct mt76_dev *dev, struct sk_buff *skb,
+				int cmd, bool wait_resp);
 	int (*mcu_wr_rp)(struct mt76_dev *dev, u32 base,
 			 const struct mt76_reg_pair *rp, int len);
 	int (*mcu_rd_rp)(struct mt76_dev *dev, u32 base,
@@ -588,7 +590,9 @@ enum mt76_phy_type {
 #define mt76_rd_rp(dev, ...)	(dev)->mt76.bus->rd_rp(&((dev)->mt76), __VA_ARGS__)
 
 #define mt76_mcu_send_msg(dev, ...)	(dev)->mt76.mcu_ops->mcu_send_msg(&((dev)->mt76), __VA_ARGS__)
+
 #define __mt76_mcu_send_msg(dev, ...)	(dev)->mcu_ops->mcu_send_msg((dev), __VA_ARGS__)
+#define __mt76_mcu_skb_send_msg(dev, ...)	(dev)->mcu_ops->mcu_skb_send_msg((dev), __VA_ARGS__)
 #define mt76_mcu_restart(dev, ...)	(dev)->mt76.mcu_ops->mcu_restart(&((dev)->mt76))
 #define __mt76_mcu_restart(dev, ...)	(dev)->mcu_ops->mcu_restart((dev))
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b94b1b73fd1a..eb6867a316b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -166,17 +166,12 @@ int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq)
 }
 
 static int
-mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
-		    int len, bool wait_resp)
+mt7615_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			int cmd, bool wait_resp)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	struct sk_buff *skb;
 	int ret, seq;
 
-	skb = mt7615_mcu_msg_alloc(data, len);
-	if (!skb)
-		return -ENOMEM;
-
 	mutex_lock(&mdev->mcu.mutex);
 
 	ret = __mt7615_mcu_msg_send(dev, skb, cmd, &seq);
@@ -192,6 +187,19 @@ mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	return ret;
 }
 
+static int
+mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
+		    int len, bool wait_resp)
+{
+	struct sk_buff *skb;
+
+	skb = mt7615_mcu_msg_alloc(data, len);
+	if (!skb)
+		return -ENOMEM;
+
+	return __mt76_mcu_skb_send_msg(mdev, skb, cmd, wait_resp);
+}
+
 static void
 mt7615_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
@@ -704,6 +712,7 @@ int mt7615_mcu_fw_log_2_host(struct mt7615_dev *dev, u8 ctrl)
 int mt7615_mcu_init(struct mt7615_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7615_mcu_ops = {
+		.mcu_skb_send_msg = mt7615_mcu_send_message,
 		.mcu_send_msg = mt7615_mcu_msg_send,
 		.mcu_restart = mt7615_mcu_restart,
 	};
-- 
2.24.1

