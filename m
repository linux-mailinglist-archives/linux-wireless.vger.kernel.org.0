Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB3E53C7AA
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbiFCJhZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 05:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243101AbiFCJhV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 05:37:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEF011A01
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 02:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D92BB821BD
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 09:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84235C34115;
        Fri,  3 Jun 2022 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654249026;
        bh=9c3ltcn6Ia9BiUQ7XWRzHVFrAPrucUmmQS22MP93MDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJnj0ncSRffYjw2vrY2HDkL7z2S2uU+lnWHhUOwib04oheY7rzipsCYecsKc/B/O/
         fmH0IxogIPkG7GKJGiELPSeg799oAj3+/hgzC6VA277WtCyyWYq1ZN//MMOoFwGDni
         QwttzsX1K1WMsNrMUABtxVYdxZdualwO99SvRe5JosVxnqoVAxOGXn863ZGl0QGYD9
         K86AcvkV6YK3YJh05d8yCTTlazI/lLBTcdtNojNKRgWO3DhE3/O27FW53nU6EG8DRk
         4pzZpmCoeKVinclkY18IDXmSbwdMNSuXarpnqEDOQhzBED34khXNOgvnF3sIIKVmxe
         uwU0bdbhGmt0A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 1/5] mt76: connac: move shared fw structures in connac module
Date:   Fri,  3 Jun 2022 11:36:42 +0200
Message-Id: <d15f534ac1edfc8b597a3c86d15c3cca80a1f8cd.1654248715.git.lorenzo@kernel.org>
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

Move mt76_connac2 fw structures in connac module since they are shared
between mt7921 and mt7915 drivers. This is a preliminary patch to add
mt7902e support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 56 ++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 85 +++----------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 81 +++---------------
 3 files changed, 79 insertions(+), 143 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 561fb0368708..ccc17cf2fb0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -26,6 +26,62 @@
 #define PATCH_SEC_TYPE_MASK		GENMASK(15, 0)
 #define PATCH_SEC_TYPE_INFO		0x2
 
+struct mt76_connac2_patch_hdr {
+	char build_date[16];
+	char platform[4];
+	__be32 hw_sw_ver;
+	__be32 patch_ver;
+	__be16 checksum;
+	u16 rsv;
+	struct {
+		__be32 patch_ver;
+		__be32 subsys;
+		__be32 feature;
+		__be32 n_region;
+		__be32 crc;
+		u32 rsv[11];
+	} desc;
+} __packed;
+
+struct mt76_connac2_patch_sec {
+	__be32 type;
+	__be32 offs;
+	__be32 size;
+	union {
+		__be32 spec[13];
+		struct {
+			__be32 addr;
+			__be32 len;
+			__be32 sec_key_idx;
+			__be32 align_len;
+			u32 rsv[9];
+		} info;
+	};
+} __packed;
+
+struct mt76_connac2_fw_trailer {
+	u8 chip_id;
+	u8 eco_code;
+	u8 n_region;
+	u8 format_ver;
+	u8 format_flag;
+	u8 rsv[2];
+	char fw_ver[10];
+	char build_date[15];
+	__le32 crc;
+} __packed;
+
+struct mt76_connac2_fw_region {
+	__le32 decomp_crc;
+	__le32 decomp_len;
+	__le32 decomp_blk_sz;
+	u8 rsv[4];
+	__le32 addr;
+	__le32 len;
+	u8 feature_set;
+	u8 rsv1[15];
+} __packed;
+
 struct tlv {
 	__le16 tag;
 	__le16 len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b7e2b365356c..402f34d36d38 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -8,62 +8,6 @@
 #include "mac.h"
 #include "eeprom.h"
 
-struct mt7915_patch_hdr {
-	char build_date[16];
-	char platform[4];
-	__be32 hw_sw_ver;
-	__be32 patch_ver;
-	__be16 checksum;
-	u16 reserved;
-	struct {
-		__be32 patch_ver;
-		__be32 subsys;
-		__be32 feature;
-		__be32 n_region;
-		__be32 crc;
-		u32 reserved[11];
-	} desc;
-} __packed;
-
-struct mt7915_patch_sec {
-	__be32 type;
-	__be32 offs;
-	__be32 size;
-	union {
-		__be32 spec[13];
-		struct {
-			__be32 addr;
-			__be32 len;
-			__be32 sec_key_idx;
-			__be32 align_len;
-			u32 reserved[9];
-		} info;
-	};
-} __packed;
-
-struct mt7915_fw_trailer {
-	u8 chip_id;
-	u8 eco_code;
-	u8 n_region;
-	u8 format_ver;
-	u8 format_flag;
-	u8 reserved[2];
-	char fw_ver[10];
-	char build_date[15];
-	u32 crc;
-} __packed;
-
-struct mt7915_fw_region {
-	__le32 decomp_crc;
-	__le32 decomp_len;
-	__le32 decomp_blk_sz;
-	u8 reserved[4];
-	__le32 addr;
-	__le32 len;
-	u8 feature_set;
-	u8 reserved1[15];
-} __packed;
-
 #define fw_name(_dev, name, ...)	({			\
 	char *_fw;						\
 	switch (mt76_chip(&(_dev)->mt76)) {			\
@@ -2136,7 +2080,7 @@ static int mt7915_driver_own(struct mt7915_dev *dev, u8 band)
 
 static int mt7915_load_patch(struct mt7915_dev *dev)
 {
-	const struct mt7915_patch_hdr *hdr;
+	const struct mt76_connac2_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
 	int i, ret, sem;
 
@@ -2162,18 +2106,17 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 		goto out;
 	}
 
-	hdr = (const struct mt7915_patch_hdr *)(fw->data);
+	hdr = (const struct mt76_connac2_patch_hdr *)fw->data;
 
 	dev_info(dev->mt76.dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
 		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
 
 	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
-		struct mt7915_patch_sec *sec;
+		struct mt76_connac2_patch_sec *sec;
 		const u8 *dl;
 		u32 len, addr;
 
-		sec = (struct mt7915_patch_sec *)(fw->data + sizeof(*hdr) +
-						  i * sizeof(*sec));
+		sec = (void *)(fw->data + sizeof(*hdr) + i * sizeof(*sec));
 		if ((be32_to_cpu(sec->type) & PATCH_SEC_TYPE_MASK) !=
 		    PATCH_SEC_TYPE_INFO) {
 			ret = -EINVAL;
@@ -2220,19 +2163,19 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 
 static int
 mt7915_mcu_send_ram_firmware(struct mt7915_dev *dev,
-			     const struct mt7915_fw_trailer *hdr,
+			     const struct mt76_connac2_fw_trailer *hdr,
 			     const u8 *data, bool is_wa)
 {
 	int i, offset = 0;
 	u32 override = 0, option = 0;
 
 	for (i = 0; i < hdr->n_region; i++) {
-		const struct mt7915_fw_region *region;
-		int err;
+		const struct mt76_connac2_fw_region *region;
 		u32 len, addr, mode;
+		int err;
 
-		region = (const struct mt7915_fw_region *)((const u8 *)hdr -
-			 (hdr->n_region - i) * sizeof(*region));
+		region = (const void *)((const u8 *)hdr -
+					(hdr->n_region - i) * sizeof(*region));
 		mode = mt76_connac_mcu_gen_dl_mode(&dev->mt76,
 						   region->feature_set, is_wa);
 		len = le32_to_cpu(region->len);
@@ -2269,7 +2212,7 @@ mt7915_mcu_send_ram_firmware(struct mt7915_dev *dev,
 
 static int mt7915_load_ram(struct mt7915_dev *dev)
 {
-	const struct mt7915_fw_trailer *hdr;
+	const struct mt76_connac2_fw_trailer *hdr;
 	const struct firmware *fw;
 	int ret;
 
@@ -2284,9 +2227,7 @@ static int mt7915_load_ram(struct mt7915_dev *dev)
 		goto out;
 	}
 
-	hdr = (const struct mt7915_fw_trailer *)(fw->data + fw->size -
-					sizeof(*hdr));
-
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
 	dev_info(dev->mt76.dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
 		 hdr->fw_ver, hdr->build_date);
 
@@ -2309,9 +2250,7 @@ static int mt7915_load_ram(struct mt7915_dev *dev)
 		goto out;
 	}
 
-	hdr = (const struct mt7915_fw_trailer *)(fw->data + fw->size -
-					sizeof(*hdr));
-
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
 	dev_info(dev->mt76.dev, "WA Firmware Version: %.10s, Build Time: %.15s\n",
 		 hdr->fw_ver, hdr->build_date);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 4217c35acb82..1f1c270a4d81 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -8,62 +8,6 @@
 #include "mcu.h"
 #include "mac.h"
 
-struct mt7921_patch_hdr {
-	char build_date[16];
-	char platform[4];
-	__be32 hw_sw_ver;
-	__be32 patch_ver;
-	__be16 checksum;
-	u16 reserved;
-	struct {
-		__be32 patch_ver;
-		__be32 subsys;
-		__be32 feature;
-		__be32 n_region;
-		__be32 crc;
-		u32 reserved[11];
-	} desc;
-} __packed;
-
-struct mt7921_patch_sec {
-	__be32 type;
-	__be32 offs;
-	__be32 size;
-	union {
-		__be32 spec[13];
-		struct {
-			__be32 addr;
-			__be32 len;
-			__be32 sec_key_idx;
-			__be32 align_len;
-			u32 reserved[9];
-		} info;
-	};
-} __packed;
-
-struct mt7921_fw_trailer {
-	u8 chip_id;
-	u8 eco_code;
-	u8 n_region;
-	u8 format_ver;
-	u8 format_flag;
-	u8 reserved[2];
-	char fw_ver[10];
-	char build_date[15];
-	u32 crc;
-} __packed;
-
-struct mt7921_fw_region {
-	__le32 decomp_crc;
-	__le32 decomp_len;
-	__le32 decomp_blk_sz;
-	u8 reserved[4];
-	__le32 addr;
-	__le32 len;
-	u8 feature_set;
-	u8 reserved1[15];
-} __packed;
-
 #define MT_STA_BFER			BIT(0)
 #define MT_STA_BFEE			BIT(1)
 
@@ -512,7 +456,7 @@ static char *mt7921_patch_name(struct mt7921_dev *dev)
 
 static int mt7921_load_patch(struct mt7921_dev *dev)
 {
-	const struct mt7921_patch_hdr *hdr;
+	const struct mt76_connac2_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
 	int i, ret, sem, max_len;
 
@@ -539,19 +483,18 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 		goto out;
 	}
 
-	hdr = (const struct mt7921_patch_hdr *)(fw->data);
+	hdr = (const struct mt76_connac2_patch_hdr *)fw->data;
 
 	dev_info(dev->mt76.dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
 		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
 
 	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
-		struct mt7921_patch_sec *sec;
+		struct mt76_connac2_patch_sec *sec;
 		const u8 *dl;
 		u32 len, addr, mode;
 		u32 sec_info = 0;
 
-		sec = (struct mt7921_patch_sec *)(fw->data + sizeof(*hdr) +
-						  i * sizeof(*sec));
+		sec = (void *)(fw->data + sizeof(*hdr) + i * sizeof(*sec));
 		if ((be32_to_cpu(sec->type) & PATCH_SEC_TYPE_MASK) !=
 		    PATCH_SEC_TYPE_INFO) {
 			ret = -EINVAL;
@@ -608,7 +551,7 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 
 static int
 mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
-			     const struct mt7921_fw_trailer *hdr,
+			     const struct mt76_connac2_fw_trailer *hdr,
 			     const u8 *data, bool is_wa)
 {
 	int i, offset = 0, max_len;
@@ -617,12 +560,12 @@ mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
 	max_len = mt76_is_sdio(&dev->mt76) ? 2048 : 4096;
 
 	for (i = 0; i < hdr->n_region; i++) {
-		const struct mt7921_fw_region *region;
-		int err;
+		const struct mt76_connac2_fw_region *region;
 		u32 len, addr, mode;
+		int err;
 
-		region = (const struct mt7921_fw_region *)((const u8 *)hdr -
-			 (hdr->n_region - i) * sizeof(*region));
+		region = (const void *)((const u8 *)hdr -
+					(hdr->n_region - i) * sizeof(*region));
 		mode = mt76_connac_mcu_gen_dl_mode(&dev->mt76,
 						   region->feature_set, is_wa);
 		len = le32_to_cpu(region->len);
@@ -671,7 +614,7 @@ static char *mt7921_ram_name(struct mt7921_dev *dev)
 
 static int mt7921_load_ram(struct mt7921_dev *dev)
 {
-	const struct mt7921_fw_trailer *hdr;
+	const struct mt76_connac2_fw_trailer *hdr;
 	const struct firmware *fw;
 	int ret;
 
@@ -685,9 +628,7 @@ static int mt7921_load_ram(struct mt7921_dev *dev)
 		goto out;
 	}
 
-	hdr = (const struct mt7921_fw_trailer *)(fw->data + fw->size -
-					sizeof(*hdr));
-
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
 	dev_info(dev->mt76.dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
 		 hdr->fw_ver, hdr->build_date);
 
-- 
2.35.3

