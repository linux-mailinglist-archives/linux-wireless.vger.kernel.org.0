Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057B52B7212
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Nov 2020 00:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgKQXSZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 18:18:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgKQXSZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 18:18:25 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CFBB2225B;
        Tue, 17 Nov 2020 23:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605655104;
        bh=cCujwmeV2ZPTZ83teXtF0JwJR0Pk0rqCELeQ5n7jj48=;
        h=From:To:Cc:Subject:Date:From;
        b=ucJb2qOVHFsP6YnQjuv6BWBh2228lThqyOxRB/xpw3DwAzZkJY1gMiUzwwFilC3Fu
         ZjSGJlNfafWJsKlrGmM4BsyC03FGuRne+W40VFDCViPCLWavdqlZfbXZOyOn5ylKNc
         4TnVRyUoCPKWGgtCdu6rKpoCt/GrdLK1mdYh9ws0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: fix rdd mcu cmd endianness
Date:   Wed, 18 Nov 2020 00:18:18 +0100
Message-Id: <b1b593914b88c98122d0c13a344b2a96d60ccae4.1605654677.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7915 driver, fix mt7615 radar mcu command endianness

Fixes: 2ce73efe0f8e5 ("mt76: mt7615: initialize radar specs from host driver")
Fixes: 70911d9638069 ("mt76: mt7615: add radar pattern test knob to debugfs")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 89 ++++++++++++++-----
 1 file changed, 66 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 2a03c658427a..a44b7766dec6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2690,11 +2690,11 @@ int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val)
 {
 	struct {
-		u16 tag;
-		u16 min_lpn;
+		__le16 tag;
+		__le16 min_lpn;
 	} req = {
-		.tag = 0x1,
-		.min_lpn = val,
+		.tag = cpu_to_le16(0x1),
+		.min_lpn = cpu_to_le16(val),
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
@@ -2705,14 +2705,27 @@ int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
 			    const struct mt7615_dfs_pulse *pulse)
 {
 	struct {
-		u16 tag;
-		struct mt7615_dfs_pulse pulse;
+		__le16 tag;
+		__le32 max_width;	/* us */
+		__le32 max_pwr;		/* dbm */
+		__le32 min_pwr;		/* dbm */
+		__le32 min_stgr_pri;	/* us */
+		__le32 max_stgr_pri;	/* us */
+		__le32 min_cr_pri;	/* us */
+		__le32 max_cr_pri;	/* us */
 	} req = {
-		.tag = 0x3,
+		.tag = cpu_to_le16(0x3),
+#define __req_field(field) .field = cpu_to_le32(pulse->field)
+		__req_field(max_width),
+		__req_field(max_pwr),
+		__req_field(min_pwr),
+		__req_field(min_stgr_pri),
+		__req_field(max_stgr_pri),
+		__req_field(min_cr_pri),
+		__req_field(max_cr_pri),
+#undef  __req_field
 	};
 
-	memcpy(&req.pulse, pulse, sizeof(*pulse));
-
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
 				 sizeof(req), true);
 }
@@ -2721,16 +2734,45 @@ int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
 			    const struct mt7615_dfs_pattern *pattern)
 {
 	struct {
-		u16 tag;
-		u16 radar_type;
-		struct mt7615_dfs_pattern pattern;
+		__le16 tag;
+		__le16 radar_type;
+		u8 enb;
+		u8 stgr;
+		u8 min_crpn;
+		u8 max_crpn;
+		u8 min_crpr;
+		u8 min_pw;
+		u8 max_pw;
+		__le32 min_pri;
+		__le32 max_pri;
+		u8 min_crbn;
+		u8 max_crbn;
+		u8 min_stgpn;
+		u8 max_stgpn;
+		u8 min_stgpr;
 	} req = {
-		.tag = 0x2,
-		.radar_type = index,
+		.tag = cpu_to_le16(0x2),
+		.radar_type = cpu_to_le16(index),
+#define __req_field_u8(field) .field = pattern->field
+#define __req_field_u32(field) .field = cpu_to_le32(pattern->field)
+		__req_field_u8(enb),
+		__req_field_u8(stgr),
+		__req_field_u8(min_crpn),
+		__req_field_u8(max_crpn),
+		__req_field_u8(min_crpr),
+		__req_field_u8(min_pw),
+		__req_field_u8(max_pw),
+		__req_field_u32(min_pri),
+		__req_field_u32(max_pri),
+		__req_field_u8(min_crbn),
+		__req_field_u8(max_crbn),
+		__req_field_u8(min_stgpn),
+		__req_field_u8(max_stgpn),
+		__req_field_u8(min_stgpr),
+#undef __req_field_u8
+#undef __req_field_u32
 	};
 
-	memcpy(&req.pattern, pattern, sizeof(*pattern));
-
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
 				 sizeof(req), true);
 }
@@ -2741,9 +2783,9 @@ int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev)
 		u8 pulse_num;
 		u8 rsv[3];
 		struct {
-			u32 start_time;
-			u16 width;
-			s16 power;
+			__le32 start_time;
+			__le16 width;
+			__le16 power;
 		} pattern[32];
 	} req = {
 		.pulse_num = dev->radar_pattern.n_pulses,
@@ -2756,10 +2798,11 @@ int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev)
 
 	/* TODO: add some noise here */
 	for (i = 0; i < dev->radar_pattern.n_pulses; i++) {
-		req.pattern[i].width = dev->radar_pattern.width;
-		req.pattern[i].power = dev->radar_pattern.power;
-		req.pattern[i].start_time = start_time +
-					    i * dev->radar_pattern.period;
+		u32 ts = start_time + i * dev->radar_pattern.period;
+
+		req.pattern[i].width = cpu_to_le16(dev->radar_pattern.width);
+		req.pattern[i].power = cpu_to_le16(dev->radar_pattern.power);
+		req.pattern[i].start_time = cpu_to_le32(ts);
 	}
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_PATTERN,
-- 
2.26.2

