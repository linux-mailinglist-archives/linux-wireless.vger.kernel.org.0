Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A15B2BA2CB
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Sep 2019 15:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfIVNgL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Sep 2019 09:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbfIVNgL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Sep 2019 09:36:11 -0400
Received: from localhost.localdomain (unknown [151.66.30.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12FC220640;
        Sun, 22 Sep 2019 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569159370;
        bh=OHnKkd0kn494hdcDkX3kqoCXlJAfw4aAB9cUs/oofmI=;
        h=From:To:Cc:Subject:Date:From;
        b=dEyhYqETovSYE9LNKcLDF+4/KUDqVIY7z2mE0ZAm/KP/X8HcrTK+p3YlWnH2AiCfW
         jI4ex+iGSLTBWAUzZQsiEcxi9IydHcCC9z2Il+GwotmYdU/BxjIgnZDeCMMZ6vY8Jz
         BTg+Ra1c2PEQhz6vEdFERhSHyJTj7KSXZC1kBzBs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7615: fix mt7615 firmware path definitions
Date:   Sun, 22 Sep 2019 15:36:03 +0200
Message-Id: <9e132c0949139155a4fb3375e4c83218159efce7.1569159209.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7615 patch/n9/cr4 firmwares are available in mediatek folder in
linux-firmware repository. Fix path definitions.
Moreover remove useless firmware name pointers and use definitions
directly

Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    | 11 ++++-------
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |  6 +++---
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 275d5eaed3b7..842cd81704db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -333,7 +333,6 @@ static int mt7615_driver_own(struct mt7615_dev *dev)
 
 static int mt7615_load_patch(struct mt7615_dev *dev)
 {
-	const char *firmware = MT7615_ROM_PATCH;
 	const struct mt7615_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
 	int len, ret, sem;
@@ -349,7 +348,7 @@ static int mt7615_load_patch(struct mt7615_dev *dev)
 		return -EAGAIN;
 	}
 
-	ret = request_firmware(&fw, firmware, dev->mt76.dev);
+	ret = request_firmware(&fw, MT7615_ROM_PATCH, dev->mt76.dev);
 	if (ret)
 		goto out;
 
@@ -447,13 +446,11 @@ mt7615_mcu_send_ram_firmware(struct mt7615_dev *dev,
 
 static int mt7615_load_ram(struct mt7615_dev *dev)
 {
-	const struct firmware *fw;
 	const struct mt7615_fw_trailer *hdr;
-	const char *n9_firmware = MT7615_FIRMWARE_N9;
-	const char *cr4_firmware = MT7615_FIRMWARE_CR4;
+	const struct firmware *fw;
 	int ret;
 
-	ret = request_firmware(&fw, n9_firmware, dev->mt76.dev);
+	ret = request_firmware(&fw, MT7615_FIRMWARE_N9, dev->mt76.dev);
 	if (ret)
 		return ret;
 
@@ -482,7 +479,7 @@ static int mt7615_load_ram(struct mt7615_dev *dev)
 
 	release_firmware(fw);
 
-	ret = request_firmware(&fw, cr4_firmware, dev->mt76.dev);
+	ret = request_firmware(&fw, MT7615_FIRMWARE_CR4, dev->mt76.dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index cef3fd43cb00..7963e302d705 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -26,9 +26,9 @@
 #define MT7615_RX_RING_SIZE		1024
 #define MT7615_RX_MCU_RING_SIZE		512
 
-#define MT7615_FIRMWARE_CR4		"mt7615_cr4.bin"
-#define MT7615_FIRMWARE_N9		"mt7615_n9.bin"
-#define MT7615_ROM_PATCH		"mt7615_rom_patch.bin"
+#define MT7615_FIRMWARE_CR4		"mediatek/mt7615_cr4.bin"
+#define MT7615_FIRMWARE_N9		"mediatek/mt7615_n9.bin"
+#define MT7615_ROM_PATCH		"mediatek/mt7615_rom_patch.bin"
 
 #define MT7615_EEPROM_SIZE		1024
 #define MT7615_TOKEN_SIZE		4096
-- 
2.21.0

