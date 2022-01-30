Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5154A3506
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 08:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiA3H6l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 02:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiA3H6k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 02:58:40 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C005C061714;
        Sat, 29 Jan 2022 23:58:40 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id u129so20826137oib.4;
        Sat, 29 Jan 2022 23:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OEDRScsHhe+nmF5iDRzszv/uhY6Ae7OQ0DfDhJw94Q0=;
        b=lfbVUr3dgu4OVAF4oLulC1r2UufnannvJvMZSvvUVj+7p8YAzPk4dj5GJD96FgQ/oh
         1W5npgG6GNegIab/ZuTWyftVRgRBWTVxsuCCtjnnGeCOHBBJ2og7ydeLnP4y2QvnnXV+
         GRb4wQ84OgBXmQ4HjwjXIfPaSZ9a/cOxGmQUVvm2K2M+i3hh+v7wgSLaa2Nz4rbw7jZf
         B1XXBmRSMeLoVULq8diwPOKIeQg5EQF5jdX0VKtBttxdkACeNL/fgsxgjdF6OZ9AMfOO
         /bXJwaU3yOOFA7Sc+PBEGbN1kE5gx0twQAVxyrRhBJnxlh/m6JWI2v72iTpqweSAeCB+
         j1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OEDRScsHhe+nmF5iDRzszv/uhY6Ae7OQ0DfDhJw94Q0=;
        b=slUH6Di8ncQzpD5MZG2liMGnek8ke5NUHbX06LUKiY1vnjBu75fhfmPpFP+YEZ7YYH
         zBsWjwYelur2FjYT6sV2YrCExg5upZPXhnpCPJQiW46sHowIfPlxSThyfcp5qag9JsCC
         5qV6Z8GCRZigZFMRO9rwNdcY9IZFy59Bg0HSDgM4XfAbTR+9t/3WEdzrzQnVlEZwgw+C
         dIzUjsehoxxBTfJIYhXBe+Y8LSqprLwDclDm79qJBkfFQk9b0ZKnxqoO8XKfA7/HgyQp
         T8p7xwU8ijLhKKd6WasRT27xM8Ni4qafsoFOLbvaH4d1JJ00FsLOVp+pgJDW6TJGZGgs
         pwdw==
X-Gm-Message-State: AOAM533LI9Pqqf/d36Jwa94cCzW2LDU0S+h6hZZfsRex1w9dxKBjZapd
        bumkrRsIVgSdvsvbpuwpX+Bz5/tczhM=
X-Google-Smtp-Source: ABdhPJxRTym6tclJNO06bbKQgFjXmMcZv8lE8f2Ni1O339RUJ/CnEcR8TQzN7ypOG8yQXHZE2UBl9w==
X-Received: by 2002:a05:6808:e82:: with SMTP id k2mr10379872oil.10.1643529519049;
        Sat, 29 Jan 2022 23:58:39 -0800 (PST)
Received: from localhost ([2806:2f0:4000:7e37::2])
        by smtp.gmail.com with ESMTPSA id k13sm5949292ots.48.2022.01.29.23.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 23:58:38 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     stable@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, Felix Fietkau <nbd@nbd.name>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] mt76: connac: introduce MCU_CE_CMD macro
Date:   Sun, 30 Jan 2022 01:58:37 -0600
Message-Id: <20220130075837.5270-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 680a2ead741ad9b479a53adf154ed5eee74d2b9a ]

Similar to MCU_EXT_CMD, introduce MCU_CE_CMD for CE commands.

Upstream commit 547224024579 (mt76: connac: introduce MCU_UNI_CMD macro,
2021-12-09) introduced a bug by removing MCU_UNI_PREFIX, but not
updating MCU_CMD_MASK accordingly, so when commands are compared in
mt7921_mcu_parse_response() one has the extra bit __MCU_CMD_FIELD_UNI
set and the comparison fails:

  if (mcu_cmd != event->cid)
  if (20001 != 1)

The fix was sneaked by in the next commit 680a2ead741a (mt76: connac:
introduce MCU_CE_CMD macro, 2021-12-09):

-	int mcu_cmd = cmd & MCU_CMD_MASK;
+	int mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);

But it was never merged into linux-stable.

We need either both commits, or none.

Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 16 +++----
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 47 ++++++++++--------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 48 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 24 +++++-----
 .../wireless/mediatek/mt76/mt7921/testmode.c  |  4 +-
 5 files changed, 73 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index fcbcfc9f5a04..58be537adb1f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -145,7 +145,7 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 	mcu_txd->cid = mcu_cmd;
 	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
 
-	if (mcu_txd->ext_cid || (cmd & MCU_CE_PREFIX)) {
+	if (mcu_txd->ext_cid || (cmd & __MCU_CMD_FIELD_CE)) {
 		if (cmd & __MCU_CMD_FIELD_QUERY)
 			mcu_txd->set_query = MCU_Q_QUERY;
 		else
@@ -193,7 +193,7 @@ int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		skb_pull(skb, sizeof(*rxd));
 		event = (struct mt7615_mcu_uni_event *)skb->data;
 		ret = le32_to_cpu(event->status);
-	} else if (cmd == MCU_CMD_REG_READ) {
+	} else if (cmd == MCU_CE_QUERY(REG_READ)) {
 		struct mt7615_mcu_reg_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
@@ -2737,13 +2737,13 @@ int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return 0;
 
-	err = mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_ABORT, &req_hdr,
-				sizeof(req_hdr), false);
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_BSS_ABORT),
+				&req_hdr, sizeof(req_hdr), false);
 	if (err < 0 || !enable)
 		return err;
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_BSS_CONNECTED),
+				 &req, sizeof(req), false);
 }
 
 int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
@@ -2762,6 +2762,6 @@ int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 
 	phy->roc_grant = false;
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_ROC, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_ROC),
+				 &req, sizeof(req), false);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 7733c8fad241..1fb8432aa27c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -160,7 +160,8 @@ int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy)
 
 	memcpy(__skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
 
-	return mt76_mcu_skb_send_msg(dev, skb, MCU_CMD_SET_CHAN_DOMAIN, false);
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_CE_CMD(SET_CHAN_DOMAIN),
+				     false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_channel_domain);
 
@@ -198,8 +199,8 @@ int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif)
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_SET_PS_PROFILE, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(dev, MCU_CE_CMD(SET_PS_PROFILE),
+				 &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_vif_ps);
 
@@ -1523,7 +1524,8 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		req->scan_func |= SCAN_FUNC_RANDOM_MAC;
 	}
 
-	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_CMD_START_HW_SCAN, false);
+	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_CE_CMD(START_HW_SCAN),
+				    false);
 	if (err < 0)
 		clear_bit(MT76_HW_SCANNING, &phy->state);
 
@@ -1551,8 +1553,8 @@ int mt76_connac_mcu_cancel_hw_scan(struct mt76_phy *phy,
 		ieee80211_scan_completed(phy->hw, &info);
 	}
 
-	return mt76_mcu_send_msg(phy->dev, MCU_CMD_CANCEL_HW_SCAN, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(phy->dev, MCU_CE_CMD(CANCEL_HW_SCAN),
+				 &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_cancel_hw_scan);
 
@@ -1638,7 +1640,8 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
 		memcpy(skb_put(skb, sreq->ie_len), sreq->ie, sreq->ie_len);
 	}
 
-	return mt76_mcu_skb_send_msg(mdev, skb, MCU_CMD_SCHED_SCAN_REQ, false);
+	return mt76_mcu_skb_send_msg(mdev, skb, MCU_CE_CMD(SCHED_SCAN_REQ),
+				     false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sched_scan_req);
 
@@ -1658,8 +1661,8 @@ int mt76_connac_mcu_sched_scan_enable(struct mt76_phy *phy,
 	else
 		clear_bit(MT76_HW_SCHED_SCANNING, &phy->state);
 
-	return mt76_mcu_send_msg(phy->dev, MCU_CMD_SCHED_SCAN_ENABLE, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(phy->dev, MCU_CE_CMD(SCHED_SCAN_ENABLE),
+				 &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sched_scan_enable);
 
@@ -1671,8 +1674,8 @@ int mt76_connac_mcu_chip_config(struct mt76_dev *dev)
 
 	memcpy(req.data, "assert", 7);
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_CHIP_CONFIG, &req, sizeof(req),
-				 false);
+	return mt76_mcu_send_msg(dev, MCU_CE_CMD(CHIP_CONFIG),
+				 &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_chip_config);
 
@@ -1684,8 +1687,8 @@ int mt76_connac_mcu_set_deep_sleep(struct mt76_dev *dev, bool enable)
 
 	snprintf(req.data, sizeof(req.data), "KeepFullPwr %d", !enable);
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_CHIP_CONFIG, &req, sizeof(req),
-				 false);
+	return mt76_mcu_send_msg(dev, MCU_CE_CMD(CHIP_CONFIG),
+				 &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_deep_sleep);
 
@@ -1787,8 +1790,8 @@ int mt76_connac_mcu_get_nic_capability(struct mt76_phy *phy)
 	struct sk_buff *skb;
 	int ret, i;
 
-	ret = mt76_mcu_send_and_get_msg(phy->dev, MCU_CMD_GET_NIC_CAPAB, NULL,
-					0, true, &skb);
+	ret = mt76_mcu_send_and_get_msg(phy->dev, MCU_CE_CMD(GET_NIC_CAPAB),
+					NULL, 0, true, &skb);
 	if (ret)
 		return ret;
 
@@ -2071,7 +2074,8 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 		memcpy(skb->data, &tx_power_tlv, sizeof(tx_power_tlv));
 
 		err = mt76_mcu_skb_send_msg(dev, skb,
-					    MCU_CMD_SET_RATE_TX_POWER, false);
+					    MCU_CE_CMD(SET_RATE_TX_POWER),
+					    false);
 		if (err < 0)
 			return err;
 	}
@@ -2163,8 +2167,8 @@ int mt76_connac_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 		.bss_idx = mvif->idx,
 	};
 
-	return mt76_mcu_send_msg(phy->dev, MCU_CMD_SET_P2P_OPPPS, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(phy->dev, MCU_CE_CMD(SET_P2P_OPPPS),
+				 &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_p2p_oppps);
 
@@ -2490,8 +2494,8 @@ u32 mt76_connac_mcu_reg_rr(struct mt76_dev *dev, u32 offset)
 		.addr = cpu_to_le32(offset),
 	};
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_REG_READ, &req, sizeof(req),
-				 true);
+	return mt76_mcu_send_msg(dev, MCU_CE_QUERY(REG_READ), &req,
+				 sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_reg_rr);
 
@@ -2505,7 +2509,8 @@ void mt76_connac_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val)
 		.val = cpu_to_le32(val),
 	};
 
-	mt76_mcu_send_msg(dev, MCU_CMD_REG_WRITE, &req, sizeof(req), false);
+	mt76_mcu_send_msg(dev, MCU_CE_CMD(REG_WRITE), &req,
+			  sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_reg_wr);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 5c5fab9154e5..acb9a286d354 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -496,13 +496,11 @@ enum {
 #define MCU_CMD_UNI_EXT_ACK			(MCU_CMD_ACK | MCU_CMD_UNI | \
 						 MCU_CMD_QUERY)
 
-#define MCU_CE_PREFIX				BIT(29)
-#define MCU_CMD_MASK				~(MCU_CE_PREFIX)
-
 #define __MCU_CMD_FIELD_ID			GENMASK(7, 0)
 #define __MCU_CMD_FIELD_EXT_ID			GENMASK(15, 8)
 #define __MCU_CMD_FIELD_QUERY			BIT(16)
 #define __MCU_CMD_FIELD_UNI			BIT(17)
+#define __MCU_CMD_FIELD_CE			BIT(18)
 
 #define MCU_CMD(_t)				FIELD_PREP(__MCU_CMD_FIELD_ID,		\
 							   MCU_CMD_##_t)
@@ -513,6 +511,10 @@ enum {
 #define MCU_UNI_CMD(_t)				(__MCU_CMD_FIELD_UNI |			\
 						 FIELD_PREP(__MCU_CMD_FIELD_ID,		\
 							    MCU_UNI_CMD_##_t))
+#define MCU_CE_CMD(_t)				(__MCU_CMD_FIELD_CE |			\
+						 FIELD_PREP(__MCU_CMD_FIELD_ID,		\
+							   MCU_CE_CMD_##_t))
+#define MCU_CE_QUERY(_t)			(MCU_CE_CMD(_t) | __MCU_CMD_FIELD_QUERY)
 
 enum {
 	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
@@ -589,26 +591,26 @@ enum {
 
 /* offload mcu commands */
 enum {
-	MCU_CMD_TEST_CTRL = MCU_CE_PREFIX | 0x01,
-	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
-	MCU_CMD_SET_PS_PROFILE = MCU_CE_PREFIX | 0x05,
-	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
-	MCU_CMD_SET_BSS_CONNECTED = MCU_CE_PREFIX | 0x16,
-	MCU_CMD_SET_BSS_ABORT = MCU_CE_PREFIX | 0x17,
-	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
-	MCU_CMD_SET_ROC = MCU_CE_PREFIX | 0x1d,
-	MCU_CMD_SET_P2P_OPPPS = MCU_CE_PREFIX | 0x33,
-	MCU_CMD_SET_RATE_TX_POWER = MCU_CE_PREFIX | 0x5d,
-	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
-	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
-	MCU_CMD_GET_NIC_CAPAB = MCU_CE_PREFIX | 0x8a,
-	MCU_CMD_SET_MU_EDCA_PARMS = MCU_CE_PREFIX | 0xb0,
-	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
-	MCU_CMD_REG_READ = MCU_CE_PREFIX | __MCU_CMD_FIELD_QUERY | 0xc0,
-	MCU_CMD_CHIP_CONFIG = MCU_CE_PREFIX | 0xca,
-	MCU_CMD_FWLOG_2_HOST = MCU_CE_PREFIX | 0xc5,
-	MCU_CMD_GET_WTBL = MCU_CE_PREFIX | 0xcd,
-	MCU_CMD_GET_TXPWR = MCU_CE_PREFIX | 0xd0,
+	MCU_CE_CMD_TEST_CTRL = 0x01,
+	MCU_CE_CMD_START_HW_SCAN = 0x03,
+	MCU_CE_CMD_SET_PS_PROFILE = 0x05,
+	MCU_CE_CMD_SET_CHAN_DOMAIN = 0x0f,
+	MCU_CE_CMD_SET_BSS_CONNECTED = 0x16,
+	MCU_CE_CMD_SET_BSS_ABORT = 0x17,
+	MCU_CE_CMD_CANCEL_HW_SCAN = 0x1b,
+	MCU_CE_CMD_SET_ROC = 0x1d,
+	MCU_CE_CMD_SET_P2P_OPPPS = 0x33,
+	MCU_CE_CMD_SET_RATE_TX_POWER = 0x5d,
+	MCU_CE_CMD_SCHED_SCAN_ENABLE = 0x61,
+	MCU_CE_CMD_SCHED_SCAN_REQ = 0x62,
+	MCU_CE_CMD_GET_NIC_CAPAB = 0x8a,
+	MCU_CE_CMD_SET_MU_EDCA_PARMS = 0xb0,
+	MCU_CE_CMD_REG_WRITE = 0xc0,
+	MCU_CE_CMD_REG_READ = 0xc0,
+	MCU_CE_CMD_CHIP_CONFIG = 0xca,
+	MCU_CE_CMD_FWLOG_2_HOST = 0xc5,
+	MCU_CE_CMD_GET_WTBL = 0xcd,
+	MCU_CE_CMD_GET_TXPWR = 0xd0,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 484a8c57b862..4c6adbb96955 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -163,8 +163,8 @@ mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq)
 {
+	int mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
 	struct mt7921_mcu_rxd *rxd;
-	int mcu_cmd = cmd & MCU_CMD_MASK;
 	int ret = 0;
 
 	if (!skb) {
@@ -201,7 +201,7 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		/* skip invalid event */
 		if (mcu_cmd != event->cid)
 			ret = -EAGAIN;
-	} else if (cmd == MCU_CMD_REG_READ) {
+	} else if (cmd == MCU_CE_QUERY(REG_READ)) {
 		struct mt7921_mcu_reg_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
@@ -274,7 +274,7 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	mcu_txd->s2d_index = MCU_S2D_H2N;
 	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
 
-	if (mcu_txd->ext_cid || (cmd & MCU_CE_PREFIX)) {
+	if (mcu_txd->ext_cid || (cmd & __MCU_CMD_FIELD_CE)) {
 		if (cmd & __MCU_CMD_FIELD_QUERY)
 			mcu_txd->set_query = MCU_Q_QUERY;
 		else
@@ -883,8 +883,8 @@ int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl)
 		.ctrl_val = ctrl
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FWLOG_2_HOST, &data,
-				 sizeof(data), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(FWLOG_2_HOST),
+				 &data, sizeof(data), false);
 }
 
 int mt7921_run_firmware(struct mt7921_dev *dev)
@@ -1009,8 +1009,8 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 		e->timer = q->mu_edca_timer;
 	}
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_MU_EDCA_PARMS, &req_mu,
-				 sizeof(req_mu), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_MU_EDCA_PARMS),
+				 &req_mu, sizeof(req_mu), false);
 }
 
 int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
@@ -1214,13 +1214,13 @@ mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return 0;
 
-	err = mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_ABORT, &req_hdr,
-				sizeof(req_hdr), false);
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_BSS_ABORT),
+				&req_hdr, sizeof(req_hdr), false);
 	if (err < 0 || !enable)
 		return err;
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_BSS_CONNECTED),
+				 &req, sizeof(req), false);
 }
 
 int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
@@ -1330,7 +1330,7 @@ int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr)
 	struct sk_buff *skb;
 	int ret;
 
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CMD_GET_TXPWR,
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CE_CMD(GET_TXPWR),
 					&req, sizeof(req), true, &skb);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
index 8bd43879dd6f..bdec8684ce94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
@@ -66,7 +66,7 @@ mt7921_tm_set(struct mt7921_dev *dev, struct mt7921_tm_cmd *req)
 	if (!mt76_testmode_enabled(phy))
 		goto out;
 
-	ret = mt76_mcu_send_msg(&dev->mt76, MCU_CMD_TEST_CTRL, &cmd,
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(TEST_CTRL), &cmd,
 				sizeof(cmd), false);
 	if (ret)
 		goto out;
@@ -95,7 +95,7 @@ mt7921_tm_query(struct mt7921_dev *dev, struct mt7921_tm_cmd *req,
 	struct sk_buff *skb;
 	int ret;
 
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CMD_TEST_CTRL,
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CE_CMD(TEST_CTRL),
 					&cmd, sizeof(cmd), true, &skb);
 	if (ret)
 		goto out;
-- 
2.35.1

