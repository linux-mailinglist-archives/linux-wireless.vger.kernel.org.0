Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CA8678415
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 19:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjAWSFp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 13:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjAWSFp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 13:05:45 -0500
X-Greylist: delayed 590 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 10:05:22 PST
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D06303D7
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 10:05:22 -0800 (PST)
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0EDFA22509B
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 17:55:33 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 50AAC900080
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 17:55:31 +0000 (UTC)
Received: from carson-dt.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id B7DB013C2B0;
        Mon, 23 Jan 2023 09:55:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B7DB013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1674496530;
        bh=o4zhEB0ZlSZFGzFu+924v82SgbHbMX7DSAx+W5xf1ko=;
        h=From:To:Cc:Subject:Date:From;
        b=U9IcgX7sP/jWufbgMQHqEWmcD7A1yRWLRl34IjQll35qb0szY4w4jkAnGsF4a4pcH
         BrcG2O7a3e0LCXLgPi99a+LuqWVxvn+nW7Sf4qWXq4h+5LHu4mES3zlDh3N5dGU7fS
         74mlL4bLiXGepQ7BXopxde8sgsqTIeDUfe44S6rA=
From:   carson.vandegriffe@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Carson Vandegriffe <carson.vandegriffe@candelatech.com>
Subject: [RFC PATCH] wifi: mt76: mt7916: Support per-radio configuration 'firmware' file.
Date:   Mon, 23 Jan 2023 09:55:00 -0800
Message-Id: <20230123175500.3375542-1-carson.vandegriffe@candelatech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1674496532-EQLu4qy0ZLys
X-MDID-O: us5-at1-1674496532-EQLu4qy0ZLys
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carson Vandegriffe <carson.vandegriffe@candelatech.com>

This lets users specify the upper band that the 7916 radio should use.
Upon reboot, the 7916 will be using that upper band.

Example config file:

myhost@: cat /usr/lib/firmware/mediatek/fwcfg-mmio-0000\:04\:00.0.txt

high_band=6

Signed-off-by: Carson Vandegriffe <carson.vandegriffe@candelatech.com>
---
 This patch is against the 5.19.17+ kernel.
 drivers/net/wireless/mediatek/mt76/mt76.h     |  14 ++
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 164 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   3 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  10 ++
 4 files changed, 190 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 812c1eb8866a..2b1b730aeb2d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -961,6 +961,20 @@ struct mt76_sta_stats {
 	u32 rx_ampdu_len[15];
 };
 
+static inline const char *mt76_bus_str(enum mt76_bus_type bus)
+{
+	switch (bus) {
+	case MT76_BUS_MMIO:
+		return "mmio";
+	case MT76_BUS_USB:
+		return "usb";
+	case MT76_BUS_SDIO:
+		return "sdio";
+	}
+
+	return "unknown";
+}
+
 static inline
 void mt76_inc_ampdu_bucket(int ampdu_len, struct mt76_sta_stats *stats)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index fdef6a3a6cb3..04edadcf5107 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -108,6 +108,28 @@ mt7915_eeprom_load_default(struct mt7915_dev *dev)
 	return ret;
 }
 
+static const struct firmware
+*mt7915_eeprom_load_file(struct mt7915_dev *dev, const char *dir, const char *file)
+{
+	char filename[100];
+	const struct firmware *fw = NULL;
+	int ret;
+
+	if (!file)
+		return ERR_PTR(-ENOENT);
+
+	if (!dir)
+		dir = ".";
+
+	snprintf(filename, sizeof(filename), "%s/%s", dir, file);
+	ret = request_firmware(&fw, filename, dev->mt76.dev);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	return fw;
+}
+
 static int mt7915_eeprom_load(struct mt7915_dev *dev)
 {
 	int ret;
@@ -139,6 +161,122 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 	return mt7915_check_eeprom(dev);
 }
 
+static int mt7915_fetch_fwcfg_file(struct mt7915_dev *dev)
+{
+	char filename[100];
+	const struct firmware *fw;
+	const char *buf;
+	size_t i = 0;
+	char val[100];
+	size_t key_idx;
+	size_t val_idx;
+	char c;
+	long t;
+
+	dev->fwcfg.flags = 0;
+
+	/* fwcfg-<bus>-<id>.txt */
+	scnprintf(filename, sizeof(filename), "fwcfg-%s-%s.txt",
+		  mt76_bus_str(dev->mt76.bus->type), dev_name(dev->mt76.dev));
+
+	fw = mt7915_eeprom_load_file(dev, MT7915_FIRMWARE_BD, filename);
+	if (IS_ERR(fw))
+		return PTR_ERR(fw);
+
+	/* Now, attempt to parse results.
+	 * Format is key=value
+	 */
+	buf = (const char *)(fw->data);
+	while (i < fw->size) {
+start_again:
+		/* First, eat space, or entire line if we have # as first char */
+		c = buf[i];
+		while (isspace(c)) {
+			i++;
+			if (i >= fw->size)
+				goto done;
+			c = buf[i];
+		}
+		/* Eat comment ? */
+		if (c == '#') {
+			i++;
+			while (i < fw->size) {
+				c = buf[i];
+				i++;
+				if (c == '\n')
+					goto start_again;
+			}
+			/* Found no newline, must be done. */
+			goto done;
+		}
+
+		/* If here, we have start of token, store it in 'filename' to save space */
+		key_idx = 0;
+		while (i < fw->size) {
+			c = buf[i];
+			if (c == '=') {
+				i++;
+				c = buf[i];
+				/* Eat any space after the '=' sign. */
+				while (i < fw->size) {
+					if (!isspace(c))
+						break;
+					i++;
+					c = buf[i];
+				}
+				break;
+			}
+			if (isspace(c)) {
+				i++;
+				continue;
+			}
+			filename[key_idx] = c;
+			key_idx++;
+			if (key_idx >= sizeof(filename)) {
+				/* Too long, bail out. */
+				goto done;
+			}
+			i++;
+		}
+		filename[key_idx] = 0; /* null terminate */
+
+		/* We have found the key, now find the value */
+		val_idx = 0;
+		while (i < fw->size) {
+			c = buf[i];
+			if (isspace(c))
+				break;
+			val[val_idx] = c;
+			val_idx++;
+			if (val_idx >= sizeof(val)) {
+				/* Too long, bail out. */
+				goto done;
+			}
+			i++;
+		}
+		val[val_idx] = 0; /* null terminate value */
+
+		/* We have key and value now. */
+		dev_warn(dev->mt76.dev, "fwcfg key: %s  val: %s\n",
+			 filename, val);
+
+		/* Assign key and values as appropriate */
+		if (strcasecmp(filename, "high_band") == 0) {
+			if (kstrtol(val, 0, &t) == 0) {
+				dev->fwcfg.high_band = t;
+				dev->fwcfg.flags |= MT7915_FWCFG_HIGH_BAND;
+			}
+		} else {
+			dev_warn(dev->mt76.dev, "Unknown fwcfg key name -:%s:-, val: %s\n",
+				 filename, val);
+		}
+	}
+
+done:
+	release_firmware(fw);
+	return 0;
+}
+
 static void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
@@ -149,6 +287,29 @@ static void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 	val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
 
 	if (!is_mt7915(&dev->mt76)) {
+		/* fwcfg intervention to set upper band to 5GHz or 6GHz */
+		if ((dev->fwcfg.flags & MT7915_FWCFG_HIGH_BAND) &&
+		    val == MT_EE_V2_BAND_SEL_5GHZ_6GHZ) {
+			dev_info(dev->mt76.dev, "FWCFG: Overriding 7916 high_band with %luGHz\n",
+				 (unsigned long)dev->fwcfg.high_band);
+
+			if (dev->fwcfg.high_band == 5) {
+				u8p_replace_bits(&eeprom[MT_EE_WIFI_CONF + phy->band_idx],
+						 MT_EE_V2_BAND_SEL_5GHZ,
+						 MT_EE_WIFI_CONF0_BAND_SEL);
+			}
+			if (dev->fwcfg.high_band == 6) {
+				u8p_replace_bits(&eeprom[MT_EE_WIFI_CONF + phy->band_idx],
+						 MT_EE_V2_BAND_SEL_6GHZ,
+						 MT_EE_WIFI_CONF0_BAND_SEL);
+			}
+
+			/* force to buffer mode */
+			dev->flash_mode = true;
+			val = eeprom[MT_EE_WIFI_CONF + phy->band_idx];
+			val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
+		}
+
 		switch (val) {
 		case MT_EE_V2_BAND_SEL_5GHZ:
 			phy->mt76->cap.has_5ghz = true;
@@ -270,6 +431,9 @@ int mt7915_eeprom_init(struct mt7915_dev *dev)
 {
 	int ret;
 
+	/* First, see if we have a special config file for this firmware */
+	mt7915_fetch_fwcfg_file(dev);
+
 	dev->bin_file_mode = mt76_check_bin_file_mode(&dev->mt76);
 
 	if (dev->bin_file_mode) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index f82e36664994..2a31b973c843 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1195,7 +1195,6 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	if (ret)
 		goto unreg_dev;
 
-	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
 
 	if (phy2) {
 		ret = mt7915_register_ext_phy(dev, phy2);
@@ -1203,6 +1202,8 @@ int mt7915_register_device(struct mt7915_dev *dev)
 			goto unreg_thermal;
 	}
 
+	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
+
 	mt7915_init_debugfs(&dev->phy);
 
 	dev->ser.hw_init_done = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index dabf9dce7ed6..f8266de129dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -5,6 +5,7 @@
 #define __MT7915_H
 
 #include <linux/interrupt.h>
+#include <linux/firmware.h>
 #include <linux/ktime.h>
 #include "../mt76_connac.h"
 #include "regs.h"
@@ -28,6 +29,8 @@
 #define MT7915_RX_RING_SIZE		1536
 #define MT7915_RX_MCU_RING_SIZE		512
 
+#define MT7915_FIRMWARE_BD		"mediatek"
+
 #define MT7915_FIRMWARE_WA		"mediatek/mt7915_wa.bin"
 #define MT7915_FIRMWARE_WM		"mediatek/mt7915_wm.bin"
 #define MT7915_ROM_PATCH		"mediatek/mt7915_rom_patch.bin"
@@ -467,6 +470,13 @@ struct mt7915_dev {
 	u8 dpd_chan_num_5g;
 	u8 dpd_chan_num_6g;
 
+	struct {
+#define MT7915_FWCFG_HIGH_BAND	BIT(1)
+
+		u32 flags; /* let us know which fields have been set */
+		u32 high_band;	/* sets upper-band to use ('5' or '6')GHz */
+	} fwcfg;
+
 	struct {
 		u8 debug_wm;
 		u8 debug_wa;
-- 
2.34.1

