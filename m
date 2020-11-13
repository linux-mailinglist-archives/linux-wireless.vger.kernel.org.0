Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3262B18E5
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 11:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKMKSF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 05:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMKSE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 05:18:04 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821B7C0613D1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 02:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6WgvLB8ao87Q/FUPHij8W4BqNwQ5M0gAG/PA4k+puRI=; b=aAf7doSy8ulkuSFInCw4Y4JvJU
        ipfDMchamJg0nIwZVzFhfL+RStRuGR9vXHgejuVAqlK7KxrWfS19HOUPnj5nzRKs6qDcZ4GkdZO4z
        dYwEim1V1ITwAS3cghqlnFsW6BgBNdcK/kuxM38tld+EZGaicYXKcU5bvXeQdVh4be6E=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kdW9b-000456-4a
        for linux-wireless@vger.kernel.org; Fri, 13 Nov 2020 11:18:03 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: fix endian issues
Date:   Fri, 13 Nov 2020 11:18:02 +0100
Message-Id: <20201113101802.46339-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Multiple MCU messages were using u16/u32 fields without endian annotations
or conversions

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Fixes: 5517f78b0063 ("mt76: mt7915: enable firmware module debug support")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 87 +++++++++++++++----
 1 file changed, 68 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index eeb9bd4c3bea..1b2f76250923 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2824,7 +2824,7 @@ int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level)
 	struct {
 		u8 ver;
 		u8 pad;
-		u16 len;
+		__le16 len;
 		u8 level;
 		u8 rsv[3];
 		__le32 module_idx;
@@ -3073,12 +3073,12 @@ int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev,
 int mt7915_mcu_set_fcc5_lpn(struct mt7915_dev *dev, int val)
 {
 	struct {
-		u32 tag;
-		u16 min_lpn;
+		__le32 tag;
+		__le16 min_lpn;
 		u8 rsv[2];
 	} __packed req = {
-		.tag = 0x1,
-		.min_lpn = val,
+		.tag = cpu_to_le32(0x1),
+		.min_lpn = cpu_to_le16(val),
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
@@ -3089,14 +3089,29 @@ int mt7915_mcu_set_pulse_th(struct mt7915_dev *dev,
 			    const struct mt7915_dfs_pulse *pulse)
 {
 	struct {
-		u32 tag;
-		struct mt7915_dfs_pulse pulse;
+		__le32 tag;
+
+		__le32 max_width;		/* us */
+		__le32 max_pwr;			/* dbm */
+		__le32 min_pwr;			/* dbm */
+		__le32 min_stgr_pri;		/* us */
+		__le32 max_stgr_pri;		/* us */
+		__le32 min_cr_pri;		/* us */
+		__le32 max_cr_pri;		/* us */
 	} __packed req = {
-		.tag = 0x3,
+		.tag = cpu_to_le32(0x3),
+
+#define __req_field(field) .field = cpu_to_le32(pulse->field)
+		__req_field(max_width),
+		__req_field(max_pwr),
+		__req_field(min_pwr),
+		__req_field(min_stgr_pri),
+		__req_field(max_stgr_pri),
+		__req_field(min_cr_pri),
+		__req_field(max_cr_pri),
+#undef __req_field
 	};
 
-	memcpy(&req.pulse, pulse, sizeof(*pulse));
-
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
 				 sizeof(req), true);
 }
@@ -3105,16 +3120,50 @@ int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 			    const struct mt7915_dfs_pattern *pattern)
 {
 	struct {
-		u32 tag;
-		u16 radar_type;
-		struct mt7915_dfs_pattern pattern;
+		__le32 tag;
+		__le16 radar_type;
+
+		u8 enb;
+		u8 stgr;
+		u8 min_crpn;
+		u8 max_crpn;
+		u8 min_crpr;
+		u8 min_pw;
+		u32 min_pri;
+		u32 max_pri;
+		u8 max_pw;
+		u8 min_crbn;
+		u8 max_crbn;
+		u8 min_stgpn;
+		u8 max_stgpn;
+		u8 min_stgpr;
+		u8 rsv[2];
+		u32 min_stgpr_diff;
 	} __packed req = {
-		.tag = 0x2,
-		.radar_type = index,
+		.tag = cpu_to_le32(0x2),
+		.radar_type = cpu_to_le16(index),
+
+#define __req_field_u8(field) .field = pattern->field
+#define __req_field_u32(field) .field = cpu_to_le32(pattern->field)
+		__req_field_u8(enb),
+		__req_field_u8(stgr),
+		__req_field_u8(min_crpn),
+		__req_field_u8(max_crpn),
+		__req_field_u8(min_crpr),
+		__req_field_u8(min_pw),
+		__req_field_u32(min_pri),
+		__req_field_u32(max_pri),
+		__req_field_u8(max_pw),
+		__req_field_u8(min_crbn),
+		__req_field_u8(max_crbn),
+		__req_field_u8(min_stgpn),
+		__req_field_u8(max_stgpn),
+		__req_field_u8(min_stgpr),
+		__req_field_u32(min_stgpr_diff),
+#undef __req_field_u8
+#undef __req_field_u32
 	};
 
-	memcpy(&req.pattern, pattern, sizeof(*pattern));
-
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
 				 sizeof(req), true);
 }
@@ -3389,12 +3438,12 @@ int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		u8 drop_tx_idx;
 		u8 sta_idx;	/* 256 sta */
 		u8 rsv[2];
-		u32 val;
+		__le32 val;
 	} __packed req = {
 		.action = MT_SPR_ENABLE,
 		.arg_num = 1,
 		.band_idx = mvif->band_idx,
-		.val = enable,
+		.val = cpu_to_le32(enable),
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_SPR, &req,
-- 
2.28.0

