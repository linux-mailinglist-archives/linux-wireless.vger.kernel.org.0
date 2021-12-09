Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DA546E8C8
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 14:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhLINK0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 08:10:26 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39024 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbhLINK0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 08:10:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5178CE25AC
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 13:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A3AC004DD;
        Thu,  9 Dec 2021 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055210;
        bh=C0S5X6S7ZRkGxYfp+i0hloS8Om9Vrw9EGfKzHlkrfrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKmwR/5hBtDJDnqyKLceLDlINq430m9XrcMK/cn1QxzKm1/sjMWEVoch1AyXp3wXE
         4VcRzi3smlm6KOGeMzqlfv6/rBfKl8MtLgZ/niiTRzObJc3igMxux2AVU62juDlBl6
         +d3weGSa6NRlHhWp7mBoyuMqT/4897STVEuj3tZvjsKCKqcTIcOoVH0kRsOxtlgGZO
         OME9/R3hKWrxZ3/PINCV2fng5oIJww7OGP8GQRLhxyXx6J6nkaPEN1pSRHwdnBGU39
         0SQujASOiQG4Fdk68UszwpARrrBOY69tBzqcNYK8WOe3a0lbYX/4yajafLCJm0K0XR
         1nmFI/+bdBsEw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 2/7] mt76: connac: align MCU_EXT definitions with 7915 driver
Date:   Thu,  9 Dec 2021 14:06:24 +0100
Message-Id: <2f147e3172ec6529dad1992f0132a752c90639be.1639054861.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1639054861.git.lorenzo@kernel.org>
References: <cover.1639054861.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Align MCU_EXT and MCU_FW definitions between mt76_connac and mt7915
driver. This is a preliminary patch to reuse mt76_connac in mt7915
driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 16 ++++++-------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 24 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  2 +-
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 397a8bb67ffb..2232afed7291 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -176,7 +176,7 @@ int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	if (cmd == MCU_CMD_PATCH_SEM_CONTROL) {
 		skb_pull(skb, sizeof(*rxd) - 4);
 		ret = *skb->data;
-	} else if (cmd == MCU_EXT_CMD(GET_TEMP)) {
+	} else if (cmd == MCU_EXT_CMD(THERMAL_CTRL)) {
 		skb_pull(skb, sizeof(*rxd));
 		ret = le32_to_cpu(*(__le32 *)skb->data);
 	} else if (cmd == MCU_EXT_QUERY(RF_REG_ACCESS)) {
@@ -2095,8 +2095,8 @@ int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val)
 		.min_lpn = cpu_to_le16(val),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_TH), &req,
-				 sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RADAR_TH),
+				 &req, sizeof(req), true);
 }
 
 int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
@@ -2124,8 +2124,8 @@ int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
 #undef  __req_field
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_TH), &req,
-				 sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RADAR_TH),
+				 &req, sizeof(req), true);
 }
 
 int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
@@ -2171,8 +2171,8 @@ int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
 #undef __req_field_u32
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_TH), &req,
-				 sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RADAR_TH),
+				 &req, sizeof(req), true);
 }
 
 int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev)
@@ -2372,7 +2372,7 @@ int mt7615_mcu_get_temperature(struct mt7615_dev *dev)
 		u8 rsv[3];
 	} req = {};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(GET_TEMP),
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_CTRL),
 				 &req, sizeof(req), true);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 2c9aa82c2455..c1016bf33809 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -517,17 +517,21 @@ enum {
 enum {
 	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
 	MCU_EXT_CMD_RF_REG_ACCESS = 0x02,
+	MCU_EXT_CMD_RF_TEST = 0x04,
 	MCU_EXT_CMD_PM_STATE_CTRL = 0x07,
 	MCU_EXT_CMD_CHANNEL_SWITCH = 0x08,
 	MCU_EXT_CMD_SET_TX_POWER_CTRL = 0x11,
 	MCU_EXT_CMD_FW_LOG_2_HOST = 0x13,
+	MCU_EXT_CMD_TXBF_ACTION = 0x1e,
 	MCU_EXT_CMD_EFUSE_BUFFER_MODE = 0x21,
+	MCU_EXT_CMD_THERMAL_PROT = 0x23,
 	MCU_EXT_CMD_STA_REC_UPDATE = 0x25,
 	MCU_EXT_CMD_BSS_INFO_UPDATE = 0x26,
 	MCU_EXT_CMD_EDCA_UPDATE = 0x27,
 	MCU_EXT_CMD_DEV_INFO_UPDATE = 0x2A,
-	MCU_EXT_CMD_GET_TEMP = 0x2c,
+	MCU_EXT_CMD_THERMAL_CTRL = 0x2c,
 	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
+	MCU_EXT_CMD_SET_DRR_CTRL = 0x36,
 	MCU_EXT_CMD_SET_RDD_CTRL = 0x3a,
 	MCU_EXT_CMD_ATE_CTRL = 0x3d,
 	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
@@ -536,13 +540,28 @@ enum {
 	MCU_EXT_CMD_RX_HDR_TRANS = 0x47,
 	MCU_EXT_CMD_MUAR_UPDATE = 0x48,
 	MCU_EXT_CMD_BCN_OFFLOAD = 0x49,
+	MCU_EXT_CMD_RX_AIRTIME_CTRL = 0x4a,
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
+	MCU_EXT_CMD_EFUSE_FREE_BLOCK = 0x4f,
 	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
 	MCU_EXT_CMD_RXDCOC_CAL = 0x59,
+	MCU_EXT_CMD_GET_MIB_INFO = 0x5a,
 	MCU_EXT_CMD_TXDPD_CAL = 0x60,
 	MCU_EXT_CMD_CAL_CACHE = 0x67,
-	MCU_EXT_CMD_SET_RDD_TH = 0x7c,
+	MCU_EXT_CMD_SET_RADAR_TH = 0x7c,
 	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
+	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
+	MCU_EXT_CMD_SET_SER_TRIGGER = 0x81,
+	MCU_EXT_CMD_SCS_CTRL = 0x82,
+	MCU_EXT_CMD_TWT_AGRT_UPDATE = 0x94,
+	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
+	MCU_EXT_CMD_OFFCH_SCAN_CTRL = 0x9a,
+	MCU_EXT_CMD_SET_RDD_TH = 0x9d,
+	MCU_EXT_CMD_MURU_CTRL = 0x9f,
+	MCU_EXT_CMD_SET_SPR = 0xa8,
+	MCU_EXT_CMD_GROUP_PRE_CAL_INFO = 0xab,
+	MCU_EXT_CMD_DPD_PRE_CAL_INFO = 0xac,
+	MCU_EXT_CMD_PHY_STAT_INFO = 0xad,
 };
 
 enum {
@@ -562,6 +581,7 @@ enum {
 	MCU_CMD_PATCH_START_REQ = MCU_FW_PREFIX | 0x05,
 	MCU_CMD_PATCH_FINISH_REQ = MCU_FW_PREFIX | 0x07,
 	MCU_CMD_PATCH_SEM_CONTROL = MCU_FW_PREFIX | 0x10,
+	MCU_CMD_WA_PARAM = 0xc4,
 	MCU_CMD_EXT_CID = 0xed,
 	MCU_CMD_FW_SCATTER = MCU_FW_PREFIX | 0xee,
 	MCU_CMD_RESTART_DL_REQ = MCU_FW_PREFIX | 0xef,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index bac9a9b424ea..cb29e0c3e3c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -182,7 +182,7 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	if (cmd == MCU_CMD_PATCH_SEM_CONTROL) {
 		skb_pull(skb, sizeof(*rxd) - 4);
 		ret = *skb->data;
-	} else if (cmd == MCU_EXT_CMD(GET_TEMP)) {
+	} else if (cmd == MCU_EXT_CMD(THERMAL_CTRL)) {
 		skb_pull(skb, sizeof(*rxd) + 4);
 		ret = le32_to_cpu(*(__le32 *)skb->data);
 	} else if (cmd == MCU_EXT_CMD(EFUSE_ACCESS)) {
-- 
2.31.1

