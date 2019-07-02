Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E285CE97
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 13:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfGBLj7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 07:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfGBLj7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 07:39:59 -0400
Received: from localhost.localdomain (unknown [151.66.29.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B12BE21473;
        Tue,  2 Jul 2019 11:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562067598;
        bh=9Qqn4i0MSUoOkjIHWTa8RP8tbecSIHQfju/9lV3nL9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=duFTLTLS0fsQ0CWUJGGCpXSpjd6phvTkGhRSH0aAyxVdapxaybqsdv+MkvjjkpRu0
         SAcf9WpRjdSZ3Laf0pm6+68UDTAiAl2apxUSIktjCpowdEyGWLWl9v2r7wh1Sv02os
         AnzZFUQsMBvZKo0MY3LfBC1uZ/YcY0hXbf+nqHeM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: introduce mt7615_mcu_send_ram_firmware routine
Date:   Tue,  2 Jul 2019 13:39:49 +0200
Message-Id: <098e55399748582b802c3369b8e1ec57037d8bbe.1562067471.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add mt7615_mcu_send_ram_firmware routine since mt7615_load_ram runs the
same code to send ram firmware to cr4 and n9 mcus. Moreover rename
gen_dl_mode in mt7615_mcu_gen_dl_mode.
This patch does not introduce any behaviour change, it is just code
refactor.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 90 +++++++++----------
 1 file changed, 42 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 0e72cda52343..03aedf5076ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -380,7 +380,7 @@ static int mt7615_load_patch(struct mt7615_dev *dev)
 	return ret;
 }
 
-static u32 gen_dl_mode(u8 feature_set, bool is_cr4)
+static u32 mt7615_mcu_gen_dl_mode(u8 feature_set, bool is_cr4)
 {
 	u32 ret = 0;
 
@@ -394,14 +394,45 @@ static u32 gen_dl_mode(u8 feature_set, bool is_cr4)
 	return ret;
 }
 
+static int
+mt7615_mcu_send_ram_firmware(struct mt7615_dev *dev,
+			     const struct mt7615_fw_trailer *hdr,
+			     const u8 *data, bool is_cr4)
+{
+	int n_region = is_cr4 ? CR4_REGION_NUM : N9_REGION_NUM;
+	int err, i, offset = 0;
+	u32 len, addr, mode;
+
+	for (i = 0; i < n_region; i++) {
+		mode = mt7615_mcu_gen_dl_mode(hdr[i].feature_set, is_cr4);
+		len = le32_to_cpu(hdr[i].len) + IMG_CRC_LEN;
+		addr = le32_to_cpu(hdr[i].addr);
+
+		err = mt7615_mcu_init_download(dev, addr, len, mode);
+		if (err) {
+			dev_err(dev->mt76.dev, "Download request failed\n");
+			return err;
+		}
+
+		err = mt7615_mcu_send_firmware(dev, data + offset, len);
+		if (err) {
+			dev_err(dev->mt76.dev, "Failed to send firmware to device\n");
+			return err;
+		}
+
+		offset += len;
+	}
+
+	return 0;
+}
+
 static int mt7615_load_ram(struct mt7615_dev *dev)
 {
 	const struct firmware *fw;
 	const struct mt7615_fw_trailer *hdr;
 	const char *n9_firmware = MT7615_FIRMWARE_N9;
 	const char *cr4_firmware = MT7615_FIRMWARE_CR4;
-	u32 n9_ilm_addr, offset;
-	int i, ret;
+	int ret;
 
 	ret = request_firmware(&fw, n9_firmware, dev->mt76.dev);
 	if (ret)
@@ -419,31 +450,12 @@ static int mt7615_load_ram(struct mt7615_dev *dev)
 	dev_info(dev->mt76.dev, "N9 Firmware Version: %.10s, Build Time: %.15s\n",
 		 hdr->fw_ver, hdr->build_date);
 
-	n9_ilm_addr = le32_to_cpu(hdr->addr);
-
-	for (offset = 0, i = 0; i < N9_REGION_NUM; i++) {
-		u32 len, addr, mode;
-
-		len = le32_to_cpu(hdr[i].len) + IMG_CRC_LEN;
-		addr = le32_to_cpu(hdr[i].addr);
-		mode = gen_dl_mode(hdr[i].feature_set, false);
-
-		ret = mt7615_mcu_init_download(dev, addr, len, mode);
-		if (ret) {
-			dev_err(dev->mt76.dev, "Download request failed\n");
-			goto out;
-		}
-
-		ret = mt7615_mcu_send_firmware(dev, fw->data + offset, len);
-		if (ret) {
-			dev_err(dev->mt76.dev, "Failed to send firmware to device\n");
-			goto out;
-		}
-
-		offset += len;
-	}
+	ret = mt7615_mcu_send_ram_firmware(dev, hdr, fw->data, false);
+	if (ret)
+		goto out;
 
-	ret = mt7615_mcu_start_firmware(dev, n9_ilm_addr, FW_START_OVERRIDE);
+	ret = mt7615_mcu_start_firmware(dev, le32_to_cpu(hdr->addr),
+					FW_START_OVERRIDE);
 	if (ret) {
 		dev_err(dev->mt76.dev, "Failed to start N9 firmware\n");
 		goto out;
@@ -467,27 +479,9 @@ static int mt7615_load_ram(struct mt7615_dev *dev)
 	dev_info(dev->mt76.dev, "CR4 Firmware Version: %.10s, Build Time: %.15s\n",
 		 hdr->fw_ver, hdr->build_date);
 
-	for (offset = 0, i = 0; i < CR4_REGION_NUM; i++) {
-		u32 len, addr, mode;
-
-		len = le32_to_cpu(hdr[i].len) + IMG_CRC_LEN;
-		addr = le32_to_cpu(hdr[i].addr);
-		mode = gen_dl_mode(hdr[i].feature_set, true);
-
-		ret = mt7615_mcu_init_download(dev, addr, len, mode);
-		if (ret) {
-			dev_err(dev->mt76.dev, "Download request failed\n");
-			goto out;
-		}
-
-		ret = mt7615_mcu_send_firmware(dev, fw->data + offset, len);
-		if (ret) {
-			dev_err(dev->mt76.dev, "Failed to send firmware to device\n");
-			goto out;
-		}
-
-		offset += len;
-	}
+	ret = mt7615_mcu_send_ram_firmware(dev, hdr, fw->data, true);
+	if (ret)
+		goto out;
 
 	ret = mt7615_mcu_start_firmware(dev, 0, FW_START_WORKING_PDA_CR4);
 	if (ret)
-- 
2.21.0

