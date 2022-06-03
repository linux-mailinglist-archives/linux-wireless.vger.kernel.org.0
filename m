Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B3053C7AC
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243099AbiFCJh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 05:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243105AbiFCJhV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 05:37:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAB112AAC
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 02:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6BAB7CE1F9A
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 09:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8565BC385A9;
        Fri,  3 Jun 2022 09:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654249031;
        bh=ApsndQblbG1V0+Z+mxqc1JfgPHvF7hZCzHnCLvaX9W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XG6+q/s36i24XoQceiRbg3dgGug5IvrgtTgXLKceuOmEqVsxjki88BLr2rS+lLmPM
         mUnDI3M159fViMWWx0IPPNXhzpTankENnpRi5AMw9H0DLYkyVWt2ZnvWCtE6/cQR7f
         1Y5+zq1RpDwnSM4MM6tYxEkbkRrjj83//0CzhOJtWAjFwGEP0tFnJJ1Tl3ANoqKemR
         yBzMt38Z6wifHXzKl9IFdQ/YqEJ0SE1xKO38FlVrhvKQWO8yM3nD+JJPGznsCAuHll
         ItUdQuEmbxZez/YpGpKLG0gpSSHbP6M4mbMme+3frkZqatw99D4mv7Uti7eTY1MxLR
         uTqYUMFOzCSyg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 4/5] mt76: connac: move mt76_connac2_load_patch in connac module
Date:   Fri,  3 Jun 2022 11:36:45 +0200
Message-Id: <76638e851276883eba9d35c459a2cea4a4ed6635.1654248715.git.lorenzo@kernel.org>
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

Move mt76_connac2_load_patch utility routine in mt76_connac module since
it is shared between mt7921 and mt7915. This is a preliminary patch to
support mt7902e driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 113 ++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   8 ++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  86 +-----------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 126 +-----------------
 4 files changed, 123 insertions(+), 210 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 1a2094778f0b..0dbcfbe00e4b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2917,5 +2917,118 @@ int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_load_ram);
 
+static u32 mt76_connac2_get_data_mode(struct mt76_dev *dev, u32 info)
+{
+	u32 mode = DL_MODE_NEED_RSP;
+
+	if (!is_mt7921(dev) || info == PATCH_SEC_NOT_SUPPORT)
+		return mode;
+
+	switch (FIELD_GET(PATCH_SEC_ENC_TYPE_MASK, info)) {
+	case PATCH_SEC_ENC_TYPE_PLAIN:
+		break;
+	case PATCH_SEC_ENC_TYPE_AES:
+		mode |= DL_MODE_ENCRYPT;
+		mode |= FIELD_PREP(DL_MODE_KEY_IDX,
+				(info & PATCH_SEC_ENC_AES_KEY_MASK)) & DL_MODE_KEY_IDX;
+		mode |= DL_MODE_RESET_SEC_IV;
+		break;
+	case PATCH_SEC_ENC_TYPE_SCRAMBLE:
+		mode |= DL_MODE_ENCRYPT;
+		mode |= DL_CONFIG_ENCRY_MODE_SEL;
+		mode |= DL_MODE_RESET_SEC_IV;
+		break;
+	default:
+		dev_err(dev->dev, "Encryption type not support!\n");
+	}
+
+	return mode;
+}
+
+int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
+{
+	int i, ret, sem, max_len = mt76_is_sdio(dev) ? 2048 : 4096;
+	const struct mt76_connac2_patch_hdr *hdr;
+	const struct firmware *fw = NULL;
+
+	sem = mt76_connac_mcu_patch_sem_ctrl(dev, true);
+	switch (sem) {
+	case PATCH_IS_DL:
+		return 0;
+	case PATCH_NOT_DL_SEM_SUCCESS:
+		break;
+	default:
+		dev_err(dev->dev, "Failed to get patch semaphore\n");
+		return -EAGAIN;
+	}
+
+	ret = request_firmware(&fw, fw_name, dev->dev);
+	if (ret)
+		goto out;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const void *)fw->data;
+	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
+		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
+
+	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
+		struct mt76_connac2_patch_sec *sec;
+		u32 len, addr, mode;
+		const u8 *dl;
+		u32 sec_info;
+
+		sec = (void *)(fw->data + sizeof(*hdr) + i * sizeof(*sec));
+		if ((be32_to_cpu(sec->type) & PATCH_SEC_TYPE_MASK) !=
+		    PATCH_SEC_TYPE_INFO) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		addr = be32_to_cpu(sec->info.addr);
+		len = be32_to_cpu(sec->info.len);
+		dl = fw->data + be32_to_cpu(sec->offs);
+		sec_info = be32_to_cpu(sec->info.sec_key_idx);
+		mode = mt76_connac2_get_data_mode(dev, sec_info);
+
+		ret = mt76_connac_mcu_init_download(dev, addr, len, mode);
+		if (ret) {
+			dev_err(dev->dev, "Download request failed\n");
+			goto out;
+		}
+
+		ret = __mt76_mcu_send_firmware(dev, MCU_CMD(FW_SCATTER),
+					       dl, len, max_len);
+		if (ret) {
+			dev_err(dev->dev, "Failed to send patch\n");
+			goto out;
+		}
+	}
+
+	ret = mt76_connac_mcu_start_patch(dev);
+	if (ret)
+		dev_err(dev->dev, "Failed to start patch\n");
+
+out:
+	sem = mt76_connac_mcu_patch_sem_ctrl(dev, false);
+	switch (sem) {
+	case PATCH_REL_SEM_SUCCESS:
+		break;
+	default:
+		ret = -EAGAIN;
+		dev_err(dev->dev, "Failed to release patch semaphore\n");
+		break;
+	}
+
+	release_firmware(fw);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_load_patch);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 355ed5e5d0ec..d65b3cba1ace 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -26,6 +26,13 @@
 #define PATCH_SEC_TYPE_MASK		GENMASK(15, 0)
 #define PATCH_SEC_TYPE_INFO		0x2
 
+#define PATCH_SEC_ENC_TYPE_MASK			GENMASK(31, 24)
+#define PATCH_SEC_ENC_TYPE_PLAIN		0x00
+#define PATCH_SEC_ENC_TYPE_AES			0x01
+#define PATCH_SEC_ENC_TYPE_SCRAMBLE		0x02
+#define PATCH_SEC_ENC_SCRAMBLE_INFO_MASK	GENMASK(15, 0)
+#define PATCH_SEC_ENC_AES_KEY_MASK		GENMASK(7, 0)
+
 struct mt76_connac2_patch_hdr {
 	char build_date[16];
 	char platform[4];
@@ -1711,4 +1718,5 @@ int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
 			    u8 rx_sel, u8 val);
 int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
 			  const char *fw_wa);
+int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index af2bc2a90769..836cceac5174 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: ISC
 /* Copyright (C) 2020 MediaTek Inc. */
 
-#include <linux/firmware.h>
 #include <linux/fs.h>
 #include "mt7915.h"
 #include "mcu.h"
@@ -2078,89 +2077,6 @@ static int mt7915_driver_own(struct mt7915_dev *dev, u8 band)
 	return 0;
 }
 
-static int mt7915_load_patch(struct mt7915_dev *dev)
-{
-	const struct mt76_connac2_patch_hdr *hdr;
-	const struct firmware *fw = NULL;
-	int i, ret, sem;
-
-	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, 1);
-	switch (sem) {
-	case PATCH_IS_DL:
-		return 0;
-	case PATCH_NOT_DL_SEM_SUCCESS:
-		break;
-	default:
-		dev_err(dev->mt76.dev, "Failed to get patch semaphore\n");
-		return -EAGAIN;
-	}
-
-	ret = request_firmware(&fw, fw_name_var(dev, ROM_PATCH),
-			       dev->mt76.dev);
-	if (ret)
-		goto out;
-
-	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
-		dev_err(dev->mt76.dev, "Invalid firmware\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	hdr = (const struct mt76_connac2_patch_hdr *)fw->data;
-
-	dev_info(dev->mt76.dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
-		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
-
-	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
-		struct mt76_connac2_patch_sec *sec;
-		const u8 *dl;
-		u32 len, addr;
-
-		sec = (void *)(fw->data + sizeof(*hdr) + i * sizeof(*sec));
-		if ((be32_to_cpu(sec->type) & PATCH_SEC_TYPE_MASK) !=
-		    PATCH_SEC_TYPE_INFO) {
-			ret = -EINVAL;
-			goto out;
-		}
-
-		addr = be32_to_cpu(sec->info.addr);
-		len = be32_to_cpu(sec->info.len);
-		dl = fw->data + be32_to_cpu(sec->offs);
-
-		ret = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
-						    DL_MODE_NEED_RSP);
-		if (ret) {
-			dev_err(dev->mt76.dev, "Download request failed\n");
-			goto out;
-		}
-
-		ret = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
-					       dl, len, 4096);
-		if (ret) {
-			dev_err(dev->mt76.dev, "Failed to send patch\n");
-			goto out;
-		}
-	}
-
-	ret = mt76_connac_mcu_start_patch(&dev->mt76);
-	if (ret)
-		dev_err(dev->mt76.dev, "Failed to start patch\n");
-
-out:
-	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, 0);
-	switch (sem) {
-	case PATCH_REL_SEM_SUCCESS:
-		break;
-	default:
-		ret = -EAGAIN;
-		dev_err(dev->mt76.dev, "Failed to release patch semaphore\n");
-		break;
-	}
-	release_firmware(fw);
-
-	return ret;
-}
-
 static int
 mt7915_firmware_state(struct mt7915_dev *dev, bool wa)
 {
@@ -2191,7 +2107,7 @@ static int mt7915_load_firmware(struct mt7915_dev *dev)
 		}
 	}
 
-	ret = mt7915_load_patch(dev);
+	ret = mt76_connac2_load_patch(&dev->mt76, fw_name_var(dev, ROM_PATCH));
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 025dab3ac4e5..67052be7e5f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: ISC
 /* Copyright (C) 2020 MediaTek Inc. */
 
-#include <linux/firmware.h>
 #include <linux/fs.h>
 #include "mt7921.h"
 #include "mt7921_trace.h"
@@ -11,13 +10,6 @@
 #define MT_STA_BFER			BIT(0)
 #define MT_STA_BFEE			BIT(1)
 
-#define PATCH_SEC_ENC_TYPE_MASK		GENMASK(31, 24)
-#define PATCH_SEC_ENC_TYPE_PLAIN		0x00
-#define PATCH_SEC_ENC_TYPE_AES			0x01
-#define PATCH_SEC_ENC_TYPE_SCRAMBLE		0x02
-#define PATCH_SEC_ENC_SCRAMBLE_INFO_MASK	GENMASK(15, 0)
-#define PATCH_SEC_ENC_AES_KEY_MASK		GENMASK(7, 0)
-
 static int
 mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
 {
@@ -414,34 +406,6 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 				      enable, false);
 }
 
-static u32 mt7921_get_data_mode(struct mt7921_dev *dev, u32 info)
-{
-	u32 mode = DL_MODE_NEED_RSP;
-
-	if (info == PATCH_SEC_NOT_SUPPORT)
-		return mode;
-
-	switch (FIELD_GET(PATCH_SEC_ENC_TYPE_MASK, info)) {
-	case PATCH_SEC_ENC_TYPE_PLAIN:
-		break;
-	case PATCH_SEC_ENC_TYPE_AES:
-		mode |= DL_MODE_ENCRYPT;
-		mode |= FIELD_PREP(DL_MODE_KEY_IDX,
-				(info & PATCH_SEC_ENC_AES_KEY_MASK)) & DL_MODE_KEY_IDX;
-		mode |= DL_MODE_RESET_SEC_IV;
-		break;
-	case PATCH_SEC_ENC_TYPE_SCRAMBLE:
-		mode |= DL_MODE_ENCRYPT;
-		mode |= DL_CONFIG_ENCRY_MODE_SEL;
-		mode |= DL_MODE_RESET_SEC_IV;
-		break;
-	default:
-		dev_err(dev->mt76.dev, "Encryption type not support!\n");
-	}
-
-	return mode;
-}
-
 static char *mt7921_patch_name(struct mt7921_dev *dev)
 {
 	char *ret;
@@ -454,94 +418,6 @@ static char *mt7921_patch_name(struct mt7921_dev *dev)
 	return ret;
 }
 
-static int mt7921_load_patch(struct mt7921_dev *dev)
-{
-	const struct mt76_connac2_patch_hdr *hdr;
-	const struct firmware *fw = NULL;
-	int i, ret, sem, max_len;
-
-	max_len = mt76_is_sdio(&dev->mt76) ? 2048 : 4096;
-
-	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, true);
-	switch (sem) {
-	case PATCH_IS_DL:
-		return 0;
-	case PATCH_NOT_DL_SEM_SUCCESS:
-		break;
-	default:
-		dev_err(dev->mt76.dev, "Failed to get patch semaphore\n");
-		return -EAGAIN;
-	}
-
-	ret = request_firmware(&fw, mt7921_patch_name(dev), dev->mt76.dev);
-	if (ret)
-		goto out;
-
-	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
-		dev_err(dev->mt76.dev, "Invalid firmware\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	hdr = (const struct mt76_connac2_patch_hdr *)fw->data;
-
-	dev_info(dev->mt76.dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
-		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
-
-	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
-		struct mt76_connac2_patch_sec *sec;
-		const u8 *dl;
-		u32 len, addr, mode;
-		u32 sec_info = 0;
-
-		sec = (void *)(fw->data + sizeof(*hdr) + i * sizeof(*sec));
-		if ((be32_to_cpu(sec->type) & PATCH_SEC_TYPE_MASK) !=
-		    PATCH_SEC_TYPE_INFO) {
-			ret = -EINVAL;
-			goto out;
-		}
-
-		addr = be32_to_cpu(sec->info.addr);
-		len = be32_to_cpu(sec->info.len);
-		dl = fw->data + be32_to_cpu(sec->offs);
-		sec_info = be32_to_cpu(sec->info.sec_key_idx);
-		mode = mt7921_get_data_mode(dev, sec_info);
-
-		ret = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
-						    mode);
-		if (ret) {
-			dev_err(dev->mt76.dev, "Download request failed\n");
-			goto out;
-		}
-
-		ret = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
-					       dl, len, max_len);
-		if (ret) {
-			dev_err(dev->mt76.dev, "Failed to send patch\n");
-			goto out;
-		}
-	}
-
-	ret = mt76_connac_mcu_start_patch(&dev->mt76);
-	if (ret)
-		dev_err(dev->mt76.dev, "Failed to start patch\n");
-
-out:
-	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
-	switch (sem) {
-	case PATCH_REL_SEM_SUCCESS:
-		break;
-	default:
-		ret = -EAGAIN;
-		dev_err(dev->mt76.dev, "Failed to release patch semaphore\n");
-		break;
-	}
-
-	release_firmware(fw);
-
-	return ret;
-}
-
 static char *mt7921_ram_name(struct mt7921_dev *dev)
 {
 	char *ret;
@@ -564,7 +440,7 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 		goto fw_loaded;
 	}
 
-	ret = mt7921_load_patch(dev);
+	ret = mt76_connac2_load_patch(&dev->mt76, mt7921_patch_name(dev));
 	if (ret)
 		return ret;
 
-- 
2.35.3

