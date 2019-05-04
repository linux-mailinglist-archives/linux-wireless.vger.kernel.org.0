Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E13213AF0
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfEDP3l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 11:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfEDP3l (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 11:29:41 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4270120862;
        Sat,  4 May 2019 15:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556983779;
        bh=PAbEOdF76ySV4X7zqdAoZci7eOiLG6BL1ypkj64ujB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+g0ISiBGY76KKFAznCSx2rKz7YUUrTFkksXukiQWLOvMw4O+uui/S2rmA4/nd3eH
         glEo98juHQwoBkLo6VFUC1PCRAm8uKp+9vDF+vI7b55eAd3lT7JSpdKE1MKFDeRrDf
         9EJDtepgN60LQ2OlqaZeh2bto9/PMG6+mTfcBNpU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 08/17] mt7615: remove query from mt7615_mcu_msg_send signature
Date:   Sat,  4 May 2019 17:29:00 +0200
Message-Id: <a901d08caf363195c4f6cf145cadccda1252db30.1556981521.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556981521.git.lorenzo@kernel.org>
References: <cover.1556981521.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove query parameter from mt7615_mcu_msg_send routine signature since
it can be obtained from cmd value

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 53 +++++++++----------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b6f16ac16041..6b49db58ad0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -49,7 +49,7 @@ struct mt7615_fw_trailer {
 #define FW_START_WORKING_PDA_CR4	BIT(2)
 
 static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
-				 int cmd, int query, int dest, int *wait_seq)
+				 int cmd, int dest, int *wait_seq)
 {
 	struct mt7615_mcu_txd *mcu_txd;
 	u8 seq, q_idx, pkt_fmt;
@@ -94,15 +94,14 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 	mcu_txd->seq = seq;
 
 	if (cmd < 0) {
+		mcu_txd->set_query = MCU_Q_NA;
 		mcu_txd->cid = -cmd;
 	} else {
 		mcu_txd->cid = MCU_CMD_EXT_CID;
+		mcu_txd->set_query = MCU_Q_SET;
 		mcu_txd->ext_cid = cmd;
-		if (query != MCU_Q_NA)
-			mcu_txd->ext_cid_ack = 1;
+		mcu_txd->ext_cid_ack = 1;
 	}
-
-	mcu_txd->set_query = query;
 	mcu_txd->s2d_index = dest;
 
 	if (wait_seq)
@@ -116,9 +115,9 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, qid, skb, 0);
 }
 
-static int mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
-			       int cmd, int query, int dest,
-			       struct sk_buff **skb_ret)
+static int
+mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
+		    int cmd, int dest, struct sk_buff **skb_ret)
 {
 	unsigned long expires = jiffies + 10 * HZ;
 	struct mt7615_mcu_rxd *rxd;
@@ -126,7 +125,7 @@ static int mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 
 	mutex_lock(&dev->mt76.mmio.mcu.mutex);
 
-	ret = __mt7615_mcu_msg_send(dev, skb, cmd, query, dest, &seq);
+	ret = __mt7615_mcu_msg_send(dev, skb, cmd, dest, &seq);
 	if (ret)
 		goto out;
 
@@ -179,7 +178,7 @@ static int mt7615_mcu_init_download(struct mt7615_dev *dev, u32 addr,
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
 	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_TARGET_ADDRESS_LEN_REQ,
-				   MCU_Q_NA, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
@@ -197,7 +196,7 @@ static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
 			return -ENOMEM;
 
 		ret = __mt7615_mcu_msg_send(dev, skb, -MCU_CMD_FW_SCATTER,
-					    MCU_Q_NA, MCU_S2D_H2N, NULL);
+					    MCU_S2D_H2N, NULL);
 		if (ret)
 			break;
 
@@ -221,7 +220,7 @@ static int mt7615_mcu_start_firmware(struct mt7615_dev *dev, u32 addr,
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
 	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_FW_START_REQ,
-				   MCU_Q_NA, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 static int mt7615_mcu_restart(struct mt7615_dev *dev)
@@ -229,7 +228,7 @@ static int mt7615_mcu_restart(struct mt7615_dev *dev)
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(NULL, 0);
 
 	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_RESTART_DL_REQ,
-				   MCU_Q_NA, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
@@ -249,7 +248,7 @@ static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
 	int ret;
 
 	ret = mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_SEM_CONTROL,
-				  MCU_Q_NA, MCU_S2D_H2N, &skb_ret);
+				  MCU_S2D_H2N, &skb_ret);
 	if (ret)
 		goto out;
 
@@ -272,7 +271,7 @@ static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
 	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_FINISH_REQ,
-				   MCU_Q_NA, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 static int mt7615_driver_own(struct mt7615_dev *dev)
@@ -559,7 +558,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 		data[off - MT_EE_NIC_CONF_0].val = eep[off];
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
-				   MCU_Q_SET, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 int mt7615_mcu_init_mac(struct mt7615_dev *dev)
@@ -575,7 +574,7 @@ int mt7615_mcu_init_mac(struct mt7615_dev *dev)
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_MAC_INIT_CTRL,
-				   MCU_Q_SET, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
@@ -595,7 +594,7 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PROTECT_CTRL,
-				   MCU_Q_SET, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
@@ -634,7 +633,7 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 
 	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EDCA_UPDATE,
-				   MCU_Q_SET, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
@@ -665,7 +664,7 @@ int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PM_STATE_CTRL,
-				   MCU_Q_SET, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 static int __mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
@@ -713,7 +712,7 @@ static int __mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
 	memcpy(skb_push(skb, sizeof(req_hdr)), &req_hdr, sizeof(req_hdr));
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_DEV_INFO_UPDATE,
-				   MCU_Q_SET, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 int mt7615_mcu_set_dev_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
@@ -839,7 +838,7 @@ static int __mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 			bss_info_tag_handler[i].handler(dev, bss_info, skb);
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BSS_INFO_UPDATE,
-				   MCU_Q_SET, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
@@ -923,7 +922,7 @@ __mt7615_mcu_set_wtbl(struct mt7615_dev *dev, int wlan_idx,
 		memcpy(skb_put(skb, buf_len), buf, buf_len);
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_WTBL_UPDATE,
-				   MCU_Q_SET, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 static enum mt7615_cipher_type
@@ -1102,7 +1101,7 @@ __mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, int bss_idx,
 		memcpy(skb_put(skb, buf_len), buf, buf_len);
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_STA_REC_UPDATE,
-				   MCU_Q_SET, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *dev,
@@ -1231,7 +1230,7 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BCN_OFFLOAD,
-				   MCU_Q_SET, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 int mt7615_mcu_set_channel(struct mt7615_dev *dev)
@@ -1297,13 +1296,13 @@ int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 
 	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 	ret = mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_CHANNEL_SWITCH,
-				  MCU_Q_SET, MCU_S2D_H2N, NULL);
+				  MCU_S2D_H2N, NULL);
 	if (ret)
 		return ret;
 
 	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_SET_RX_PATH,
-				   MCU_Q_SET, MCU_S2D_H2N, NULL);
+				   MCU_S2D_H2N, NULL);
 }
 
 int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-- 
2.20.1

