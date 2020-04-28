Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C60E1BBFA0
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 15:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgD1NeU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 09:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgD1NeU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 09:34:20 -0400
Received: from localhost.localdomain.com (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13458206D6;
        Tue, 28 Apr 2020 13:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588080859;
        bh=/lAvAVfc2XJMF76KRRCnfMzEaU/zSr3rPcqiWH0cLvE=;
        h=From:To:Cc:Subject:Date:From;
        b=nqQoYRa7niiyM7JYmuDkdgWmNjatj0KdZzIa0agdQTbLIsOtozbMDhr8tvpyg3uaM
         y0BGPt194UO9PGZhivnn6ZPxx6Wtxq5x9DHP+0TRxZPNtl6xM1VZsl/yne6aQNrH+j
         6kvNLEtPQCKn1uI5VBTmwXuZ2+r4EX4aRupvgeJg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v2] mt76: mt7663: add the possibility to load firmware v2
Date:   Tue, 28 Apr 2020 15:34:09 +0200
Message-Id: <1b8ba4db0fd127de4ed3d07466b143f0eaac1c2c.1588080532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7663 firmware v2 is used for embedded devices since it has more completed
features in AP mode.
Add the capability to specify which firmware load first (v3 or v2)
using prefer_offload_fw kernel parameter and fallback to the other one
if the selected firmware fails to load

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- use a kernel parameter instead of a Kconfig entry
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 55 +++++++++++++++++--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  6 +-
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  2 +
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  2 +
 4 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index aee9ee43436f..071c29ac425f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -11,6 +11,11 @@
 #include "mac.h"
 #include "eeprom.h"
 
+static bool prefer_offload_fw = true;
+module_param(prefer_offload_fw, bool, 0644);
+MODULE_PARM_DESC(prefer_offload_fw,
+		 "Prefer client mode offload firmware (MT7663)");
+
 struct mt7615_patch_hdr {
 	char build_date[16];
 	char platform[4];
@@ -1728,7 +1733,7 @@ static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 		return -EAGAIN;
 	}
 
-	ret = request_firmware(&fw, name, dev->mt76.dev);
+	ret = firmware_request_nowarn(&fw, name, dev->mt76.dev);
 	if (ret)
 		goto out;
 
@@ -2081,8 +2086,49 @@ static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 	return ret;
 }
 
+static int
+mt7663_load_rom_patch(struct mt7615_dev *dev, const char **n9_firmware)
+{
+	const char *selected_rom, *secondary_rom = MT7663_ROM_PATCH;
+	const char *primary_rom = MT7663_OFFLOAD_ROM_PATCH;
+	int ret;
+
+	if (!prefer_offload_fw) {
+		secondary_rom = MT7663_OFFLOAD_ROM_PATCH;
+		primary_rom = MT7663_ROM_PATCH;
+	}
+	selected_rom = primary_rom;
+
+	ret = mt7615_load_patch(dev, MT7663_PATCH_ADDRESS, primary_rom);
+	if (ret) {
+		dev_info(dev->mt76.dev, "%s not found, switching to %s",
+			 primary_rom, secondary_rom);
+		ret = mt7615_load_patch(dev, MT7663_PATCH_ADDRESS,
+					secondary_rom);
+		if (ret) {
+			dev_err(dev->mt76.dev, "failed to load %s",
+				secondary_rom);
+			return ret;
+		}
+		selected_rom = secondary_rom;
+	}
+
+	if (!strcmp(selected_rom, MT7663_OFFLOAD_ROM_PATCH)) {
+		*n9_firmware = MT7663_OFFLOAD_FIRMWARE_N9;
+		dev->fw_ver = MT7615_FIRMWARE_V3;
+		dev->mcu_ops = &uni_update_ops;
+	} else {
+		*n9_firmware = MT7663_FIRMWARE_N9;
+		dev->fw_ver = MT7615_FIRMWARE_V2;
+		dev->mcu_ops = &sta_update_ops;
+	}
+
+	return 0;
+}
+
 int __mt7663_load_firmware(struct mt7615_dev *dev)
 {
+	const char *n9_firmware;
 	int ret;
 
 	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
@@ -2091,14 +2137,11 @@ int __mt7663_load_firmware(struct mt7615_dev *dev)
 		return -EIO;
 	}
 
-	ret = mt7615_load_patch(dev, MT7663_PATCH_ADDRESS, MT7663_ROM_PATCH);
+	ret = mt7663_load_rom_patch(dev, &n9_firmware);
 	if (ret)
 		return ret;
 
-	dev->fw_ver = MT7615_FIRMWARE_V3;
-	dev->mcu_ops = &uni_update_ops;
-
-	ret = mt7663_load_n9(dev, MT7663_FIRMWARE_N9);
+	ret = mt7663_load_n9(dev, n9_firmware);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 44eb3d8dca78..0476b9426b03 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -42,8 +42,10 @@
 #define MT7615_FIRMWARE_V2		2
 #define MT7615_FIRMWARE_V3		3
 
-#define MT7663_ROM_PATCH		"mediatek/mt7663pr2h.bin"
-#define MT7663_FIRMWARE_N9              "mediatek/mt7663_n9_v3.bin"
+#define MT7663_OFFLOAD_ROM_PATCH	"mediatek/mt7663pr2h.bin"
+#define MT7663_OFFLOAD_FIRMWARE_N9	"mediatek/mt7663_n9_v3.bin"
+#define MT7663_ROM_PATCH		"mediatek/mt7663pr2h_rebb.bin"
+#define MT7663_FIRMWARE_N9		"mediatek/mt7663_n9_rebb.bin"
 
 #define MT7615_EEPROM_SIZE		1024
 #define MT7615_TOKEN_SIZE		4096
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 21b3ec29aa12..f9469198cabd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -68,5 +68,7 @@ MODULE_DEVICE_TABLE(pci, mt7615_pci_device_table);
 MODULE_FIRMWARE(MT7615_FIRMWARE_CR4);
 MODULE_FIRMWARE(MT7615_FIRMWARE_N9);
 MODULE_FIRMWARE(MT7615_ROM_PATCH);
+MODULE_FIRMWARE(MT7663_OFFLOAD_FIRMWARE_N9);
+MODULE_FIRMWARE(MT7663_OFFLOAD_ROM_PATCH);
 MODULE_FIRMWARE(MT7663_FIRMWARE_N9);
 MODULE_FIRMWARE(MT7663_ROM_PATCH);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index bcd131969923..9353175b139b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -386,6 +386,8 @@ mt7663u_resume(struct usb_interface *intf)
 }
 
 MODULE_DEVICE_TABLE(usb, mt7615_device_table);
+MODULE_FIRMWARE(MT7663_OFFLOAD_FIRMWARE_N9);
+MODULE_FIRMWARE(MT7663_OFFLOAD_ROM_PATCH);
 MODULE_FIRMWARE(MT7663_FIRMWARE_N9);
 MODULE_FIRMWARE(MT7663_ROM_PATCH);
 
-- 
2.25.4

