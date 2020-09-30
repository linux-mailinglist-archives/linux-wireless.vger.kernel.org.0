Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25D27E87B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 14:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgI3MYq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 08:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbgI3MYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:45 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F3C0613D1
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RjmasvURFVDYA7JG+eJx5AAVIzlnj+QTteNCKqAE1jE=; b=slRuyJkUoj1QfXFVpM2b6ROits
        zrgMFUcBinyRHWEOf1ancANV/JqZrcB1WbracHMlDaD6m7Fj96H3evXE664e0Uop8Bj95FhbVdpQw
        2gkudikoRTnV9+UqivXPYzVgZoN0sqOwb7ynNVa/AcdNhzfZS92QJnEvD5amJkxFtGNI=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNbA3-0005MT-DM
        for linux-wireless@vger.kernel.org; Wed, 30 Sep 2020 14:24:43 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 03/10] mt76: implement .mcu_parse_response in struct mt76_mcu_ops
Date:   Wed, 30 Sep 2020 14:24:34 +0200
Message-Id: <20200930122441.64523-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930122441.64523-1-nbd@nbd.name>
References: <20200930122441.64523-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not free skb inside that function
Preparation for further cleanup

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 ++
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   | 24 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 18 +++++++-------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 ++
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  1 +
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |  1 +
 .../wireless/mediatek/mt76/mt76x0/pci_mcu.c   |  1 +
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  | 23 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt76x02_mcu.h  |  2 ++
 .../wireless/mediatek/mt76/mt76x02_usb_mcu.c  |  1 +
 .../wireless/mediatek/mt76/mt76x2/pci_mcu.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 15 ++++++------
 12 files changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 47cf3ecfa8c7..2856cb1d1cf6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -148,6 +148,8 @@ struct mt76_mcu_ops {
 			    int len, bool wait_resp);
 	int (*mcu_skb_send_msg)(struct mt76_dev *dev, struct sk_buff *skb,
 				int cmd, bool wait_resp);
+	int (*mcu_parse_response)(struct mt76_dev *dev, int cmd,
+				  struct sk_buff *skb, int seq);
 	u32 (*mcu_rr)(struct mt76_dev *dev, u32 offset);
 	void (*mcu_wr)(struct mt76_dev *dev, u32 offset, u32 val);
 	int (*mcu_wr_rp)(struct mt76_dev *dev, u32 base,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index ddef085f930d..6cd947df6429 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -13,6 +13,18 @@ struct mt7603_fw_trailer {
 	__le32 dl_len;
 } __packed;
 
+static int
+mt7603_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			  struct sk_buff *skb, int seq)
+{
+	struct mt7603_mcu_rxd *rxd = (struct mt7603_mcu_rxd *)skb->data;
+
+	if (seq != rxd->seq)
+		return -EAGAIN;
+
+	return 0;
+}
+
 static int
 __mt7603_mcu_msg_send(struct mt7603_dev *dev, struct sk_buff *skb,
 		      int cmd, int *wait_seq)
@@ -58,7 +70,6 @@ mt7603_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 {
 	struct mt7603_dev *dev = container_of(mdev, struct mt7603_dev, mt76);
 	unsigned long expires = jiffies + 3 * HZ;
-	struct mt7603_mcu_rxd *rxd;
 	struct sk_buff *skb;
 	int ret, seq;
 
@@ -73,8 +84,6 @@ mt7603_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 		goto out;
 
 	while (wait_resp) {
-		bool check_seq = false;
-
 		skb = mt76_mcu_get_response(&dev->mt76, expires);
 		if (!skb) {
 			dev_err(mdev->dev,
@@ -85,13 +94,9 @@ mt7603_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 			break;
 		}
 
-		rxd = (struct mt7603_mcu_rxd *)skb->data;
-		if (seq == rxd->seq)
-			check_seq = true;
-
+		ret = mt7603_mcu_parse_response(mdev, cmd, skb, seq);
 		dev_kfree_skb(skb);
-
-		if (check_seq)
+		if (ret != -EAGAIN)
 			break;
 	}
 
@@ -266,6 +271,7 @@ int mt7603_mcu_init(struct mt7603_dev *dev)
 	static const struct mt76_mcu_ops mt7603_mcu_ops = {
 		.headroom = sizeof(struct mt7603_mcu_txd),
 		.mcu_send_msg = mt7603_mcu_msg_send,
+		.mcu_parse_response = mt7603_mcu_parse_response,
 		.mcu_restart = mt7603_mcu_restart,
 	};
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 48ac583a64e3..f042299b110e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -179,17 +179,14 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, qid, skb, 0);
 }
 
-static int
-mt7615_mcu_parse_response(struct mt7615_dev *dev, int cmd,
-			  struct sk_buff *skb, int seq)
+int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			      struct sk_buff *skb, int seq)
 {
 	struct mt7615_mcu_rxd *rxd = (struct mt7615_mcu_rxd *)skb->data;
 	int ret = 0;
 
-	if (seq != rxd->seq) {
-		ret = -EAGAIN;
-		goto out;
-	}
+	if (seq != rxd->seq)
+		return -EAGAIN;
 
 	switch (cmd) {
 	case MCU_CMD_PATCH_SEM_CONTROL:
@@ -228,11 +225,10 @@ mt7615_mcu_parse_response(struct mt7615_dev *dev, int cmd,
 	default:
 		break;
 	}
-out:
-	dev_kfree_skb(skb);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt7615_mcu_parse_response);
 
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq)
 {
@@ -248,7 +244,8 @@ int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq)
 			return -ETIMEDOUT;
 		}
 
-		ret = mt7615_mcu_parse_response(dev, cmd, skb, seq);
+		ret = mt7615_mcu_parse_response(&dev->mt76, cmd, skb, seq);
+		dev_kfree_skb(skb);
 		if (ret != -EAGAIN)
 			break;
 	}
@@ -2467,6 +2464,7 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 		.headroom = sizeof(struct mt7615_mcu_txd),
 		.mcu_skb_send_msg = mt7615_mcu_send_message,
 		.mcu_send_msg = mt7615_mcu_msg_send,
+		.mcu_parse_response = mt7615_mcu_parse_response,
 		.mcu_restart = mt7615_mcu_restart,
 	};
 	int ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 43d8256af66a..66356ed42f73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -592,6 +592,8 @@ u32 mt7615_mac_get_sta_tid_sn(struct mt7615_dev *dev, int wcid, u8 tid);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 			int len, bool wait_resp);
+int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			      struct sk_buff *skb, int seq);
 u32 mt7615_rf_rr(struct mt7615_dev *dev, u32 wf, u32 reg);
 int mt7615_rf_wr(struct mt7615_dev *dev, u32 wf, u32 reg, u32 val);
 int mt7615_mcu_set_dbdc(struct mt7615_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index 38670c00380c..263f3a65878f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -128,6 +128,7 @@ int mt7663s_mcu_init(struct mt7615_dev *dev)
 		.tailroom = MT_USB_TAIL_SIZE,
 		.mcu_skb_send_msg = mt7663s_mcu_send_message,
 		.mcu_send_msg = mt7615_mcu_msg_send,
+		.mcu_parse_response = mt7615_mcu_parse_response,
 		.mcu_restart = mt7615_mcu_restart,
 		.mcu_rr = mt7615_mcu_reg_rr,
 		.mcu_wr = mt7615_mcu_reg_wr,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index 4d8be366af31..4bac8fda4714 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -57,6 +57,7 @@ int mt7663u_mcu_init(struct mt7615_dev *dev)
 		.tailroom = MT_USB_TAIL_SIZE,
 		.mcu_skb_send_msg = mt7663u_mcu_send_message,
 		.mcu_send_msg = mt7615_mcu_msg_send,
+		.mcu_parse_response = mt7615_mcu_parse_response,
 		.mcu_restart = mt7615_mcu_restart,
 	};
 	int ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c
index 007c762c6db1..f0962507f72f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c
@@ -117,6 +117,7 @@ int mt76x0e_mcu_init(struct mt76x02_dev *dev)
 {
 	static const struct mt76_mcu_ops mt76x0e_mcu_ops = {
 		.mcu_send_msg = mt76x02_mcu_msg_send,
+		.mcu_parse_response = mt76x02_mcu_parse_response,
 	};
 	int err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 1c2e3d16f89c..e35b3a253f82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -10,6 +10,18 @@
 
 #include "mt76x02_mcu.h"
 
+int mt76x02_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			       struct sk_buff *skb, int seq)
+{
+	u32 *rxfce = (u32 *)skb->cb;
+
+	if (seq != FIELD_GET(MT_RX_FCE_INFO_CMD_SEQ, *rxfce))
+		return -EAGAIN;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76x02_mcu_parse_response);
+
 int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 			 int len, bool wait_resp)
 {
@@ -44,9 +56,6 @@ int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 		goto out;
 
 	while (wait_resp) {
-		u32 *rxfce;
-		bool check_seq = false;
-
 		skb = mt76_mcu_get_response(&dev->mt76, expires);
 		if (!skb) {
 			dev_err(mdev->dev,
@@ -57,13 +66,9 @@ int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 			break;
 		}
 
-		rxfce = (u32 *)skb->cb;
-
-		if (seq == FIELD_GET(MT_RX_FCE_INFO_CMD_SEQ, *rxfce))
-			check_seq = true;
-
+		ret = mt76x02_mcu_parse_response(mdev, cmd, skb, seq);
 		dev_kfree_skb(skb);
-		if (check_seq)
+		if (ret != -EAGAIN)
 			break;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h
index 5fba1266c648..e187ed52968e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h
@@ -89,6 +89,8 @@ int mt76x02_mcu_cleanup(struct mt76x02_dev *dev);
 int mt76x02_mcu_calibrate(struct mt76x02_dev *dev, int type, u32 param);
 int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 			 int len, bool wait_resp);
+int mt76x02_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			       struct sk_buff *skb, int seq);
 int mt76x02_mcu_function_select(struct mt76x02_dev *dev, enum mcu_function func,
 				u32 val);
 int mt76x02_mcu_set_radio_state(struct mt76x02_dev *dev, bool on);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
index e43d13d7c988..2953df7d8388 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
@@ -297,6 +297,7 @@ void mt76x02u_init_mcu(struct mt76_dev *dev)
 		.headroom = MT_CMD_HDR_LEN,
 		.tailroom = 8,
 		.mcu_send_msg = mt76x02u_mcu_send_msg,
+		.mcu_parse_response = mt76x02_mcu_parse_response,
 		.mcu_wr_rp = mt76x02u_mcu_wr_rp,
 		.mcu_rd_rp = mt76x02u_mcu_rd_rp,
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c
index ca6f968411ac..e5b6282d1a6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c
@@ -179,6 +179,7 @@ int mt76x2_mcu_init(struct mt76x02_dev *dev)
 	static const struct mt76_mcu_ops mt76x2_mcu_ops = {
 		.mcu_restart = mt76pci_mcu_restart,
 		.mcu_send_msg = mt76x02_mcu_msg_send,
+		.mcu_parse_response = mt76x02_mcu_parse_response,
 	};
 	int ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0600ca7016ee..946fe139b9f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -309,16 +309,15 @@ mt7915_mcu_parse_eeprom(struct mt7915_dev *dev, struct sk_buff *skb)
 }
 
 static int
-mt7915_mcu_parse_response(struct mt7915_dev *dev, int cmd,
+mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			  struct sk_buff *skb, int seq)
 {
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	struct mt7915_mcu_rxd *rxd = (struct mt7915_mcu_rxd *)skb->data;
 	int ret = 0;
 
-	if (seq != rxd->seq) {
-		ret = -EAGAIN;
-		goto out;
-	}
+	if (seq != rxd->seq)
+		return -EAGAIN;
 
 	switch (cmd) {
 	case -MCU_CMD_PATCH_SEM_CONTROL:
@@ -335,8 +334,6 @@ mt7915_mcu_parse_response(struct mt7915_dev *dev, int cmd,
 	default:
 		break;
 	}
-out:
-	dev_kfree_skb(skb);
 
 	return ret;
 }
@@ -356,7 +353,8 @@ mt7915_mcu_wait_response(struct mt7915_dev *dev, int cmd, int seq)
 			return -ETIMEDOUT;
 		}
 
-		ret = mt7915_mcu_parse_response(dev, cmd, skb, seq);
+		ret = mt7915_mcu_parse_response(&dev->mt76, cmd, skb, seq);
+		dev_kfree_skb(skb);
 		if (ret != -EAGAIN)
 			break;
 	}
@@ -2961,6 +2959,7 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 		.headroom = sizeof(struct mt7915_mcu_txd),
 		.mcu_skb_send_msg = mt7915_mcu_send_message,
 		.mcu_send_msg = mt7915_mcu_msg_send,
+		.mcu_parse_response = mt7915_mcu_parse_response,
 		.mcu_restart = mt7915_mcu_restart,
 	};
 	int ret;
-- 
2.28.0

