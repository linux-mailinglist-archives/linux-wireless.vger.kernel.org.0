Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E766210AB5
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 18:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfEAQIH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 12:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfEAQIH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 12:08:07 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9005D2177B;
        Wed,  1 May 2019 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726885;
        bh=eXd3wZy6MafCOBDI5f+wdo3nn9Isa1QbCsycCvTenac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKwtK0WQ+zwTFmr2OpAL+eAGz/hWOvY2stTCny7JDPdZcYMvndHzE8L6csYW6Q3IU
         VwU1UsRY3rmNsfc/geMVCHp/0JVge3z4d1HHN7zUcXkM/4YM+4FvU1uu1R6LgGxX7x
         BHiHtQNPSAU1QEWRcQqIR2PkmxE2DU9U5sCU1w9U=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [RFC 09/17] mt7615: remove dest from mt7615_mcu_msg_send signature
Date:   Wed,  1 May 2019 18:07:31 +0200
Message-Id: <8c99fa4b0973d5c9fcf6c24bec5ba9147f4bfb0c.1556726268.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556726268.git.lorenzo@kernel.org>
References: <cover.1556726268.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 56 ++++++++-----------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 8aca5ac9c383..b8d928e8949c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -49,7 +49,7 @@ struct mt7615_fw_trailer {
 #define FW_START_WORKING_PDA_CR4	BIT(2)
 
 static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
-				 int cmd, int dest, int *wait_seq)
+				 int cmd, int *wait_seq)
 {
 	struct mt7615_mcu_txd *mcu_txd;
 	u8 seq, q_idx, pkt_fmt;
@@ -102,7 +102,7 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 		mcu_txd->ext_cid = cmd;
 		mcu_txd->ext_cid_ack = 1;
 	}
-	mcu_txd->s2d_index = dest;
+	mcu_txd->s2d_index = MCU_S2D_H2N;
 
 	if (wait_seq)
 		*wait_seq = seq;
@@ -117,7 +117,7 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 
 static int
 mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
-		    int cmd, int dest, struct sk_buff **skb_ret)
+		    int cmd, struct sk_buff **skb_ret)
 {
 	unsigned long expires = jiffies + 10 * HZ;
 	struct mt7615_mcu_rxd *rxd;
@@ -125,7 +125,7 @@ mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 
 	mutex_lock(&dev->mt76.mmio.mcu.mutex);
 
-	ret = __mt7615_mcu_msg_send(dev, skb, cmd, dest, &seq);
+	ret = __mt7615_mcu_msg_send(dev, skb, cmd, &seq);
 	if (ret)
 		goto out;
 
@@ -178,7 +178,7 @@ static int mt7615_mcu_init_download(struct mt7615_dev *dev, u32 addr,
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
 	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_TARGET_ADDRESS_LEN_REQ,
-				   MCU_S2D_H2N, NULL);
+				   NULL);
 }
 
 static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
@@ -196,7 +196,7 @@ static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
 			return -ENOMEM;
 
 		ret = __mt7615_mcu_msg_send(dev, skb, -MCU_CMD_FW_SCATTER,
-					    MCU_S2D_H2N, NULL);
+					    NULL);
 		if (ret)
 			break;
 
@@ -219,16 +219,14 @@ static int mt7615_mcu_start_firmware(struct mt7615_dev *dev, u32 addr,
 	};
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_FW_START_REQ,
-				   MCU_S2D_H2N, NULL);
+	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_FW_START_REQ, NULL);
 }
 
 static int mt7615_mcu_restart(struct mt7615_dev *dev)
 {
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(NULL, 0);
 
-	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_RESTART_DL_REQ,
-				   MCU_S2D_H2N, NULL);
+	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_RESTART_DL_REQ, NULL);
 }
 
 static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
@@ -248,7 +246,7 @@ static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
 	int ret;
 
 	ret = mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_SEM_CONTROL,
-				  MCU_S2D_H2N, &skb_ret);
+				  &skb_ret);
 	if (ret)
 		goto out;
 
@@ -270,8 +268,7 @@ static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
 	};
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_FINISH_REQ,
-				   MCU_S2D_H2N, NULL);
+	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_FINISH_REQ, NULL);
 }
 
 static int mt7615_driver_own(struct mt7615_dev *dev)
@@ -558,7 +555,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 		data[off - MT_EE_NIC_CONF_0].val = eep[off];
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
-				   MCU_S2D_H2N, NULL);
+				   NULL);
 }
 
 int mt7615_mcu_init_mac(struct mt7615_dev *dev)
@@ -573,8 +570,7 @@ int mt7615_mcu_init_mac(struct mt7615_dev *dev)
 	};
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_MAC_INIT_CTRL,
-				   MCU_S2D_H2N, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_MAC_INIT_CTRL, NULL);
 }
 
 int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
@@ -593,8 +589,7 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
 	};
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PROTECT_CTRL,
-				   MCU_S2D_H2N, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PROTECT_CTRL, NULL);
 }
 
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
@@ -632,8 +627,7 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 	}
 
 	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EDCA_UPDATE,
-				   MCU_S2D_H2N, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EDCA_UPDATE, NULL);
 }
 
 int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
@@ -663,8 +657,7 @@ int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
 	};
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PM_STATE_CTRL,
-				   MCU_S2D_H2N, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PM_STATE_CTRL, NULL);
 }
 
 static int __mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
@@ -712,7 +705,7 @@ static int __mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
 	memcpy(skb_push(skb, sizeof(req_hdr)), &req_hdr, sizeof(req_hdr));
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_DEV_INFO_UPDATE,
-				   MCU_S2D_H2N, NULL);
+				   NULL);
 }
 
 int mt7615_mcu_set_dev_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
@@ -838,7 +831,7 @@ static int __mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 			bss_info_tag_handler[i].handler(dev, bss_info, skb);
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BSS_INFO_UPDATE,
-				   MCU_S2D_H2N, NULL);
+				   NULL);
 }
 
 int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
@@ -921,8 +914,7 @@ __mt7615_mcu_set_wtbl(struct mt7615_dev *dev, int wlan_idx,
 	if (buf && buf_len)
 		memcpy(skb_put(skb, buf_len), buf, buf_len);
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_WTBL_UPDATE,
-				   MCU_S2D_H2N, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_WTBL_UPDATE, NULL);
 }
 
 static enum mt7615_cipher_type
@@ -1100,8 +1092,7 @@ __mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, int bss_idx,
 	if (buf && buf_len)
 		memcpy(skb_put(skb, buf_len), buf, buf_len);
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_STA_REC_UPDATE,
-				   MCU_S2D_H2N, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_STA_REC_UPDATE, NULL);
 }
 
 int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *dev,
@@ -1229,8 +1220,7 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 
 	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BCN_OFFLOAD,
-				   MCU_S2D_H2N, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BCN_OFFLOAD, NULL);
 }
 
 int mt7615_mcu_set_channel(struct mt7615_dev *dev)
@@ -1295,14 +1285,12 @@ int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 	memset(req.txpower_sku, 0x3f, 49);
 
 	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
-	ret = mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_CHANNEL_SWITCH,
-				  MCU_S2D_H2N, NULL);
+	ret = mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_CHANNEL_SWITCH, NULL);
 	if (ret)
 		return ret;
 
 	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_SET_RX_PATH,
-				   MCU_S2D_H2N, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_SET_RX_PATH, NULL);
 }
 
 int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-- 
2.20.1

