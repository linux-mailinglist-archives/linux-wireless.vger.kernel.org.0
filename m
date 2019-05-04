Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8E5413AF2
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 17:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfEDP3o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 11:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfEDP3o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 11:29:44 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A03DC2086A;
        Sat,  4 May 2019 15:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556983782;
        bh=KhBd7NVUp9ZZ+OesbXX4LqD0JILD4E1RL8RMieAiuNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZXTBi+9HUAu7LsFskGN2WTQUgRMWfruTJrJZtKbHIZFfLAWifoNQcgoCPTvgUdY6
         W/OBfpa7AUfzVGhzW4Ivm8y0mHiP/dQBnQYNtYue3JSWP9uJoEnunWkT7a+W82UVVf
         WuAsEIlsR9VUBXzfueRRIXM/j7snCdFSaT2zhPxM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 10/17] mt7615: mcu: remove skb_ret from mt7615_mcu_msg_send
Date:   Sat,  4 May 2019 17:29:02 +0200
Message-Id: <5079853374567be746424fc30a5a6c622d59f9f0.1556981521.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556981521.git.lorenzo@kernel.org>
References: <cover.1556981521.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove skb_ret parameter from mt7615_mcu_msg_send signature since it is
actually used just by mt7615_mcu_patch_sem_ctrl. This is a prelimanry
patch to use mt76 common mcu API

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 77 ++++++-------------
 1 file changed, 24 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 1fad0a7fbb4e..39fc36ad0052 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -116,8 +116,7 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 }
 
 static int
-mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
-		    int cmd, struct sk_buff **skb_ret)
+mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb, int cmd)
 {
 	unsigned long expires = jiffies + 10 * HZ;
 	struct mt7615_mcu_rxd *rxd;
@@ -142,18 +141,11 @@ mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 		if (seq != rxd->seq)
 			continue;
 
-		if (skb_ret) {
-			int hdr_len = sizeof(*rxd);
-
-			if (!test_bit(MT76_STATE_MCU_RUNNING,
-				      &dev->mt76.state))
-				hdr_len -= 4;
-			skb_pull(skb, hdr_len);
-			*skb_ret = skb;
-		} else {
-			dev_kfree_skb(skb);
+		if (cmd == -MCU_CMD_PATCH_SEM_CONTROL) {
+			skb_pull(skb, sizeof(*rxd) - 4);
+			ret = *skb->data;
 		}
-
+		dev_kfree_skb(skb);
 		break;
 	}
 
@@ -177,8 +169,7 @@ static int mt7615_mcu_init_download(struct mt7615_dev *dev, u32 addr,
 	};
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_TARGET_ADDRESS_LEN_REQ,
-				   NULL);
+	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_TARGET_ADDRESS_LEN_REQ);
 }
 
 static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
@@ -219,43 +210,26 @@ static int mt7615_mcu_start_firmware(struct mt7615_dev *dev, u32 addr,
 	};
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_FW_START_REQ, NULL);
+	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_FW_START_REQ);
 }
 
 static int mt7615_mcu_restart(struct mt7615_dev *dev)
 {
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(NULL, 0);
 
-	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_RESTART_DL_REQ, NULL);
+	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_RESTART_DL_REQ);
 }
 
 static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
 {
 	struct {
-		__le32 operation;
+		__le32 op;
 	} req = {
-		.operation = cpu_to_le32(get ? PATCH_SEM_GET :
-					 PATCH_SEM_RELEASE),
+		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
 	};
-	struct event {
-		u8 status;
-		u8 reserved[3];
-	} *resp;
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
-	struct sk_buff *skb_ret;
-	int ret;
 
-	ret = mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_SEM_CONTROL,
-				  &skb_ret);
-	if (ret)
-		goto out;
-
-	resp = (struct event *)(skb_ret->data);
-	ret = resp->status;
-	dev_kfree_skb(skb_ret);
-
-out:
-	return ret;
+	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_SEM_CONTROL);
 }
 
 static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
@@ -268,7 +242,7 @@ static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
 	};
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_FINISH_REQ, NULL);
+	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_FINISH_REQ);
 }
 
 static int mt7615_driver_own(struct mt7615_dev *dev)
@@ -554,8 +528,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 	for (off = MT_EE_NIC_CONF_0; off < __MT_EE_MAX; off++)
 		data[off - MT_EE_NIC_CONF_0].val = eep[off];
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
-				   NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EFUSE_BUFFER_MODE);
 }
 
 int mt7615_mcu_init_mac(struct mt7615_dev *dev)
@@ -570,7 +543,7 @@ int mt7615_mcu_init_mac(struct mt7615_dev *dev)
 	};
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_MAC_INIT_CTRL, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_MAC_INIT_CTRL);
 }
 
 int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
@@ -589,7 +562,7 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
 	};
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PROTECT_CTRL, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PROTECT_CTRL);
 }
 
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
@@ -627,7 +600,7 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 	}
 
 	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EDCA_UPDATE, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EDCA_UPDATE);
 }
 
 int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
@@ -657,7 +630,7 @@ int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
 	};
 	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PM_STATE_CTRL, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PM_STATE_CTRL);
 }
 
 static int __mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
@@ -704,8 +677,7 @@ static int __mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
 
 	memcpy(skb_push(skb, sizeof(req_hdr)), &req_hdr, sizeof(req_hdr));
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_DEV_INFO_UPDATE,
-				   NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_DEV_INFO_UPDATE);
 }
 
 int mt7615_mcu_set_dev_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
@@ -830,8 +802,7 @@ static int __mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 		    bss_info_tag_handler[i].handler)
 			bss_info_tag_handler[i].handler(dev, bss_info, skb);
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BSS_INFO_UPDATE,
-				   NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BSS_INFO_UPDATE);
 }
 
 int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
@@ -914,7 +885,7 @@ __mt7615_mcu_set_wtbl(struct mt7615_dev *dev, int wlan_idx,
 	if (buf && buf_len)
 		memcpy(skb_put(skb, buf_len), buf, buf_len);
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_WTBL_UPDATE, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_WTBL_UPDATE);
 }
 
 static enum mt7615_cipher_type
@@ -1092,7 +1063,7 @@ __mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, int bss_idx,
 	if (buf && buf_len)
 		memcpy(skb_put(skb, buf_len), buf, buf_len);
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_STA_REC_UPDATE, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_STA_REC_UPDATE);
 }
 
 int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *dev,
@@ -1220,7 +1191,7 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	dev_kfree_skb(skb);
 	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BCN_OFFLOAD, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BCN_OFFLOAD);
 }
 
 int mt7615_mcu_set_channel(struct mt7615_dev *dev)
@@ -1285,12 +1256,12 @@ int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 	memset(req.txpower_sku, 0x3f, 49);
 
 	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
-	ret = mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_CHANNEL_SWITCH, NULL);
+	ret = mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_CHANNEL_SWITCH);
 	if (ret)
 		return ret;
 
 	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_SET_RX_PATH, NULL);
+	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_SET_RX_PATH);
 }
 
 int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-- 
2.20.1

