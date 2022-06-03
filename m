Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6853753C7A8
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 11:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbiFCJhX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 05:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243103AbiFCJhV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 05:37:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE25111832
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 02:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98E7619B2
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 09:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D616FC34114;
        Fri,  3 Jun 2022 09:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654249030;
        bh=76q8D0sK+RacTvLY1MpAM4sf0D2iBJwRLk6JIFroHkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvskQ42odNc5B8Mx9kttNaxzRvB+CTS2OCViP7SMcUvTZNqYeEP79LzbeFlFBp1EU
         YyVI52B34UWNPPmCmd4IEtoIaLaZSYWHjxAZuhnDK1FspBBrcfbDVeYlfnj48JAQ/K
         rK2vmmHpdO+nMqN/DE0aw5ZHev45DAgGOf3VHCeon0ATvuN3aSp669/LCeefw0rfJP
         /jdtjkaotZsOJBD1d7teHVaEd3uhpOZ8BdSh6BOHb54kcj8GntLPZmnCqYiOcsqOkM
         crBeE4tDyvUofx20bLcuPOYpj5hA6MskLoJhqqn5aZMkNPr+RhJLKCvtrTPkVyFW25
         hCGFtGL7WC5Hw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 3/5] mt76: connac: move mt76_connac2_load_ram in connac module
Date:   Fri,  3 Jun 2022 11:36:44 +0200
Message-Id: <0f9cb2aeefdaa0181673ba28f67900b281b9b9c3.1654248715.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654248715.git.lorenzo@kernel.org>
References: <cover.1654248715.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac2_load_ram utility routine in mt76_connac module since
it is shared between mt7921 and mt7915. This is a preliminary patch to
support mt7902e driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 111 +++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   2 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 112 +-----------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  89 +-------------
 4 files changed, 116 insertions(+), 198 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index faa279bbbcb2..1a2094778f0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: ISC
 /* Copyright (C) 2020 MediaTek Inc. */
 
+#include <linux/firmware.h>
 #include "mt76_connac_mcu.h"
 
 int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option)
@@ -2806,5 +2807,115 @@ int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_rdd_cmd);
 
+static int
+mt76_connac_mcu_send_ram_firmware(struct mt76_dev *dev,
+				  const struct mt76_connac2_fw_trailer *hdr,
+				  const u8 *data, bool is_wa)
+{
+	int i, offset = 0, max_len = mt76_is_sdio(dev) ? 2048 : 4096;
+	u32 override = 0, option = 0;
+
+	for (i = 0; i < hdr->n_region; i++) {
+		const struct mt76_connac2_fw_region *region;
+		u32 len, addr, mode;
+		int err;
+
+		region = (const void *)((const u8 *)hdr -
+					(hdr->n_region - i) * sizeof(*region));
+		mode = mt76_connac_mcu_gen_dl_mode(dev, region->feature_set,
+						   is_wa);
+		len = le32_to_cpu(region->len);
+		addr = le32_to_cpu(region->addr);
+
+		if (region->feature_set & FW_FEATURE_OVERRIDE_ADDR)
+			override = addr;
+
+		err = mt76_connac_mcu_init_download(dev, addr, len, mode);
+		if (err) {
+			dev_err(dev->dev, "Download request failed\n");
+			return err;
+		}
+
+		err = __mt76_mcu_send_firmware(dev, MCU_CMD(FW_SCATTER),
+					       data + offset, len, max_len);
+		if (err) {
+			dev_err(dev->dev, "Failed to send firmware.\n");
+			return err;
+		}
+
+		offset += len;
+	}
+
+	if (override)
+		option |= FW_START_OVERRIDE;
+	if (is_wa)
+		option |= FW_START_WORKING_PDA_CR4;
+
+	return mt76_connac_mcu_start_firmware(dev, override, option);
+}
+
+int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
+			  const char *fw_wa)
+{
+	const struct mt76_connac2_fw_trailer *hdr;
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, fw_wm, dev->dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
+	dev_info(dev->dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
+		 hdr->fw_ver, hdr->build_date);
+
+	ret = mt76_connac_mcu_send_ram_firmware(dev, hdr, fw->data, false);
+	if (ret) {
+		dev_err(dev->dev, "Failed to start WM firmware\n");
+		goto out;
+	}
+
+	release_firmware(fw);
+
+	if (!fw_wa)
+		return 0;
+
+	ret = request_firmware(&fw, fw_wa, dev->dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
+	dev_info(dev->dev, "WA Firmware Version: %.10s, Build Time: %.15s\n",
+		 hdr->fw_ver, hdr->build_date);
+
+	ret = mt76_connac_mcu_send_ram_firmware(dev, hdr, fw->data, true);
+	if (ret) {
+		dev_err(dev->dev, "Failed to start WA firmware\n");
+		goto out;
+	}
+
+	snprintf(dev->hw->wiphy->fw_version,
+		 sizeof(dev->hw->wiphy->fw_version),
+		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_load_ram);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ccc17cf2fb0a..355ed5e5d0ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1709,4 +1709,6 @@ int mt76_connac_mcu_set_pm(struct mt76_dev *dev, int band, int enter);
 int mt76_connac_mcu_restart(struct mt76_dev *dev);
 int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
 			    u8 rx_sel, u8 val);
+int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
+			  const char *fw_wa);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 402f34d36d38..af2bc2a90769 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2161,115 +2161,6 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 	return ret;
 }
 
-static int
-mt7915_mcu_send_ram_firmware(struct mt7915_dev *dev,
-			     const struct mt76_connac2_fw_trailer *hdr,
-			     const u8 *data, bool is_wa)
-{
-	int i, offset = 0;
-	u32 override = 0, option = 0;
-
-	for (i = 0; i < hdr->n_region; i++) {
-		const struct mt76_connac2_fw_region *region;
-		u32 len, addr, mode;
-		int err;
-
-		region = (const void *)((const u8 *)hdr -
-					(hdr->n_region - i) * sizeof(*region));
-		mode = mt76_connac_mcu_gen_dl_mode(&dev->mt76,
-						   region->feature_set, is_wa);
-		len = le32_to_cpu(region->len);
-		addr = le32_to_cpu(region->addr);
-
-		if (region->feature_set & FW_FEATURE_OVERRIDE_ADDR)
-			override = addr;
-
-		err = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
-						    mode);
-		if (err) {
-			dev_err(dev->mt76.dev, "Download request failed\n");
-			return err;
-		}
-
-		err = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
-					       data + offset, len, 4096);
-		if (err) {
-			dev_err(dev->mt76.dev, "Failed to send firmware.\n");
-			return err;
-		}
-
-		offset += len;
-	}
-
-	if (override)
-		option |= FW_START_OVERRIDE;
-
-	if (is_wa)
-		option |= FW_START_WORKING_PDA_CR4;
-
-	return mt76_connac_mcu_start_firmware(&dev->mt76, override, option);
-}
-
-static int mt7915_load_ram(struct mt7915_dev *dev)
-{
-	const struct mt76_connac2_fw_trailer *hdr;
-	const struct firmware *fw;
-	int ret;
-
-	ret = request_firmware(&fw, fw_name_var(dev, FIRMWARE_WM),
-			       dev->mt76.dev);
-	if (ret)
-		return ret;
-
-	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
-		dev_err(dev->mt76.dev, "Invalid firmware\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
-	dev_info(dev->mt76.dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
-		 hdr->fw_ver, hdr->build_date);
-
-	ret = mt7915_mcu_send_ram_firmware(dev, hdr, fw->data, false);
-	if (ret) {
-		dev_err(dev->mt76.dev, "Failed to start WM firmware\n");
-		goto out;
-	}
-
-	release_firmware(fw);
-
-	ret = request_firmware(&fw, fw_name(dev, FIRMWARE_WA),
-			       dev->mt76.dev);
-	if (ret)
-		return ret;
-
-	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
-		dev_err(dev->mt76.dev, "Invalid firmware\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
-	dev_info(dev->mt76.dev, "WA Firmware Version: %.10s, Build Time: %.15s\n",
-		 hdr->fw_ver, hdr->build_date);
-
-	ret = mt7915_mcu_send_ram_firmware(dev, hdr, fw->data, true);
-	if (ret) {
-		dev_err(dev->mt76.dev, "Failed to start WA firmware\n");
-		goto out;
-	}
-
-	snprintf(dev->mt76.hw->wiphy->fw_version,
-		 sizeof(dev->mt76.hw->wiphy->fw_version),
-		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
-
-out:
-	release_firmware(fw);
-
-	return ret;
-}
-
 static int
 mt7915_firmware_state(struct mt7915_dev *dev, bool wa)
 {
@@ -2304,7 +2195,8 @@ static int mt7915_load_firmware(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt7915_load_ram(dev);
+	ret = mt76_connac2_load_ram(&dev->mt76, fw_name_var(dev, FIRMWARE_WM),
+				    fw_name(dev, FIRMWARE_WA));
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index bf1648b02ab5..025dab3ac4e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -542,57 +542,6 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 	return ret;
 }
 
-static int
-mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
-			     const struct mt76_connac2_fw_trailer *hdr,
-			     const u8 *data, bool is_wa)
-{
-	int i, offset = 0, max_len;
-	u32 override = 0, option = 0;
-
-	max_len = mt76_is_sdio(&dev->mt76) ? 2048 : 4096;
-
-	for (i = 0; i < hdr->n_region; i++) {
-		const struct mt76_connac2_fw_region *region;
-		u32 len, addr, mode;
-		int err;
-
-		region = (const void *)((const u8 *)hdr -
-					(hdr->n_region - i) * sizeof(*region));
-		mode = mt76_connac_mcu_gen_dl_mode(&dev->mt76,
-						   region->feature_set, is_wa);
-		len = le32_to_cpu(region->len);
-		addr = le32_to_cpu(region->addr);
-
-		if (region->feature_set & FW_FEATURE_OVERRIDE_ADDR)
-			override = addr;
-
-		err = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
-						    mode);
-		if (err) {
-			dev_err(dev->mt76.dev, "Download request failed\n");
-			return err;
-		}
-
-		err = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
-					       data + offset, len, max_len);
-		if (err) {
-			dev_err(dev->mt76.dev, "Failed to send firmware.\n");
-			return err;
-		}
-
-		offset += len;
-	}
-
-	if (override)
-		option |= FW_START_OVERRIDE;
-
-	if (is_wa)
-		option |= FW_START_WORKING_PDA_CR4;
-
-	return mt76_connac_mcu_start_firmware(&dev->mt76, override, option);
-}
-
 static char *mt7921_ram_name(struct mt7921_dev *dev)
 {
 	char *ret;
@@ -605,42 +554,6 @@ static char *mt7921_ram_name(struct mt7921_dev *dev)
 	return ret;
 }
 
-static int mt7921_load_ram(struct mt7921_dev *dev)
-{
-	const struct mt76_connac2_fw_trailer *hdr;
-	const struct firmware *fw;
-	int ret;
-
-	ret = request_firmware(&fw, mt7921_ram_name(dev), dev->mt76.dev);
-	if (ret)
-		return ret;
-
-	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
-		dev_err(dev->mt76.dev, "Invalid firmware\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
-	dev_info(dev->mt76.dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
-		 hdr->fw_ver, hdr->build_date);
-
-	ret = mt7921_mcu_send_ram_firmware(dev, hdr, fw->data, false);
-	if (ret) {
-		dev_err(dev->mt76.dev, "Failed to start WM firmware\n");
-		goto out;
-	}
-
-	snprintf(dev->mt76.hw->wiphy->fw_version,
-		 sizeof(dev->mt76.hw->wiphy->fw_version),
-		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
-
-out:
-	release_firmware(fw);
-
-	return ret;
-}
-
 static int mt7921_load_firmware(struct mt7921_dev *dev)
 {
 	int ret;
@@ -662,7 +575,7 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 			ret = __mt7921_mcu_drv_pmctrl(dev);
 	}
 
-	ret = mt7921_load_ram(dev);
+	ret = mt76_connac2_load_ram(&dev->mt76, mt7921_ram_name(dev), NULL);
 	if (ret)
 		return ret;
 
-- 
2.35.3

