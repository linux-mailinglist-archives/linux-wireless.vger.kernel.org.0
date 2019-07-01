Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 257645AA37
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 12:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfF2Kgl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 06:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfF2Kgl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 06:36:41 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766CA2086D;
        Sat, 29 Jun 2019 10:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561804599;
        bh=udCZMiqUS9eCiH/FEC5z8u4jd052mXt3FMnP06YPKsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vuQmhCXJkZto0TdfEqy796FplfZ3PvX2mZVpBqaEM5jvEMyHPPyRbfxeF1LbQ5iMW
         /+9dGHkC+gJCOWvkOTCY9y3KZV3vcokM0hnoGYEsEhkulSCl/NFsXE6jk/oJAHbUWr
         PI+NldEHjDrP1yXWMTTFeS7Xxif+h1o+9VqNlF+I=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com, yf.luo@mediatek.com
Subject: [PATCH 6/6] mt76: mt7615: add radar pattern test knob to debugfs
Date:   Sat, 29 Jun 2019 12:36:11 +0200
Message-Id: <0e4bcdda11b73ee7af17732dc847a4d6b06724c7.1561804422.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561804422.git.lorenzo@kernel.org>
References: <cover.1561804422.git.lorenzo@kernel.org>
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
index 000000000000..ed605fcc99f9
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
+	debugfs_create_u32("pulse_period", 0600, dir,
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
index dbeffe5866aa..3d814e9a31ef 100644
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
index 951849e4dd09..06d146198e33 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1294,6 +1294,37 @@ int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
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
index 73ce9fe8bfed..17d22bfb1722 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -104,6 +104,7 @@ enum {
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

