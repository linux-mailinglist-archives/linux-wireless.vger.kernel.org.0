Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66CBA55A7C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 00:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfFYWCB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 18:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfFYWCB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 18:02:01 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09EDB20883;
        Tue, 25 Jun 2019 22:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561500120;
        bh=OvgBHbG3DjdCaEv19Oi/VoTyaco/I91f94LMl06eb2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkU1xBe3LwZpUksHRLIGicloOXYhr1BTpQ2V04kCmKjvFUAR57/2Xj2sG5e07wEI8
         aRVgn4hY70xQB1ErQ0+VatZbLJ+CVVUoNDvV8KuxAyG4xCZREKVhZB45gIlBzm4QI1
         CHx0+FdkhzG/SnS5zXC+WbHGa7feT6pc9WVtNd7g=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com, yf.luo@mediatek.com
Subject: [RFC 5/5] mt76: mt7615: add radar pattern test knob to debugfs
Date:   Wed, 26 Jun 2019 00:01:26 +0200
Message-Id: <5ad5f416fd73d6659ed53f70faaeca3d3c9fe0ad.1561499275.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561499275.git.lorenzo@kernel.org>
References: <cover.1561499275.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_mcu_rdd_send_pattern routine to trigger a radar pattern
detection. Moreover move debugfs related routines in a dedicated source
file.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/Makefile    |  3 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 38 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 13 -------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 31 +++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  9 +++++
 6 files changed, 81 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index 6397552f6ee3..5aaac69849d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_MT7615E) += mt7615e.o
 
-mt7615e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o
+mt7615e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
+	     debugfs.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
new file mode 100644
index 000000000000..e884fad9b7ac
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: ISC */
+
+#include "mt7615.h"
+
+static int
+mt7615_radar_pattern_set(void *data, u64 val)
+{
+	struct mt7615_dev *dev = data;
+
+	return mt7615_mcu_rdd_send_pattern(dev);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_pattern, NULL,
+			 mt7615_radar_pattern_set, "%lld\n");
+
+int mt7615_init_debugfs(struct mt7615_dev *dev)
+{
+	struct dentry *dir;
+
+	dir = mt76_register_debugfs(&dev->mt76);
+	if (!dir)
+		return -ENOMEM;
+
+	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
+	/* test pattern knobs */
+	debugfs_create_u8("pattern_len", 0600, dir,
+			  &dev->radar_pattern.n_pulses);
+	debugfs_create_u32("pattern_period", 0600, dir,
+			   &dev->radar_pattern.period);
+	debugfs_create_u16("pulse_width", 0600, dir,
+			   &dev->radar_pattern.width);
+	debugfs_create_u16("pulse_power", 0600, dir,
+			   &dev->radar_pattern.power);
+	debugfs_create_file("radar_trigger", 0200, dir, dev,
+			    &fops_radar_pattern);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 6d336d82cafe..2b9b001a3fc9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -161,19 +161,6 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	}
 };
 
-static int mt7615_init_debugfs(struct mt7615_dev *dev)
-{
-	struct dentry *dir;
-
-	dir = mt76_register_debugfs(&dev->mt76);
-	if (!dir)
-		return -ENOMEM;
-
-	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
-
-	return 0;
-}
-
 static void
 mt7615_init_txpower(struct mt7615_dev *dev,
 		    struct ieee80211_supported_band *sband)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 31bdab1b5df6..a738770439ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1277,6 +1277,37 @@ int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 				   &req, sizeof(req), true);
 }
 
+int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev)
+{
+	struct {
+		u8 pulse_num;
+		u8 rsv[3];
+		struct {
+			u32 start_time;
+			u16 width;
+			s16 power;
+		} pattern[32];
+	} req = {
+		.pulse_num = dev->radar_pattern.n_pulses,
+	};
+	u32 start_time = ktime_to_ms(ktime_get_boottime());
+	int i;
+
+	if (dev->radar_pattern.n_pulses > ARRAY_SIZE(req.pattern))
+		return -EINVAL;
+
+	/* TODO: add some noise here */
+	for (i = 0; i < dev->radar_pattern.n_pulses; i++) {
+		req.pattern[i].width = dev->radar_pattern.width;
+		req.pattern[i].power = dev->radar_pattern.power;
+		req.pattern[i].start_time = start_time +
+					    i * dev->radar_pattern.period;
+	}
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_PATTERN,
+				   &req, sizeof(req), false);
+}
+
 int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 {
 	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 5fe492189f56..ae14ee380626 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -103,6 +103,7 @@ enum {
 	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
 	MCU_EXT_CMD_BCN_OFFLOAD = 0x49,
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
+	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index d113fa30115e..3713db874ef4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -68,6 +68,12 @@ struct mt7615_dev {
 	u32 vif_mask;
 	u32 omac_mask;
 
+	struct {
+		u8 n_pulses;
+		u32 period;
+		u16 width;
+		s16 power;
+	} radar_pattern;
 	u32 hw_pattern;
 	int dfs_state;
 
@@ -177,6 +183,7 @@ int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 		       u8 rx_sel, u8 val);
 int mt7615_dfs_start_radar_detector(struct mt7615_dev *dev);
 int mt7615_dfs_stop_radar_detector(struct mt7615_dev *dev);
+int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev);
 
 static inline void mt7615_dfs_check_channel(struct mt7615_dev *dev)
 {
@@ -240,4 +247,6 @@ void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 int mt76_dfs_start_rdd(struct mt7615_dev *dev, bool force);
 int mt7615_dfs_init_radar_detector(struct mt7615_dev *dev);
 
+int mt7615_init_debugfs(struct mt7615_dev *dev);
+
 #endif
-- 
2.21.0

