Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5876C47EE63
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 11:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352510AbhLXK6o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 05:58:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44448 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352500AbhLXK6n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 05:58:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD2A9B82288
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 10:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98604C36AEA;
        Fri, 24 Dec 2021 10:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640343521;
        bh=h/eSqmHlck/eza9NKAVOFn8HtBQgk1uODwvR48JAFCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohIMMKBmx8bnwy+Me8yIw64RsinDVkn4CtIYbSQcnp3biXsD0s7CkSg0GYhthUbg+
         SU+lY/F+m9xTZuIa0ov2FwR2h4NeH2V9J3sykHTiFcDf7JZ/ra7iWDwCaWeLRfuT/9
         9tLiPpxFZSYYGiaWrKNiLIw8TrSXZf2Lx8F4BqRIdBMRAhXK40s7cJ2+AQPSrFkeKW
         Kgl9yYtV1L82f0DbLlP8g3JeBPPN2IHw0mL7KhKXpYN0oiu0gDbkXvDi4fnl+YYKt3
         SM0fjlYJ7EYynFBQSoFqmtVemqJvyBsvqnQlpgw8UzLf4AM4CR1Te8CcfqYK+Df2Qz
         bMO6sHCRIJhMA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 08/10] mt76: connac: move mt76_connac_mcu_gen_dl_mode in mt76-connac module
Date:   Fri, 24 Dec 2021 11:58:09 +0100
Message-Id: <0b9101de463a896157b6f7b08aa2944102b3ff16.1640342400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640342400.git.lorenzo@kernel.org>
References: <cover.1640342400.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac_mcu_gen_dl_mode utility routine in mt76_connac_mcu.h
since it is shared by all drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 33 ++--------------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 38 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 33 +---------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 38 +------------------
 4 files changed, 46 insertions(+), 96 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 3b94e4f675ca..0a914494bb32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -71,19 +71,6 @@ struct mt7663_fw_buf {
 
 #define IMG_CRC_LEN			4
 
-#define FW_FEATURE_SET_ENCRYPT		BIT(0)
-#define FW_FEATURE_SET_KEY_IDX		GENMASK(2, 1)
-
-#define DL_MODE_ENCRYPT			BIT(0)
-#define DL_MODE_KEY_IDX			GENMASK(2, 1)
-#define DL_MODE_RESET_SEC_IV		BIT(3)
-#define DL_MODE_WORKING_PDA_CR4		BIT(4)
-#define DL_MODE_VALID_RAM_ENTRY         BIT(5)
-#define DL_MODE_NEED_RSP		BIT(31)
-
-#define FW_START_OVERRIDE		BIT(0)
-#define FW_START_WORKING_PDA_CR4	BIT(2)
-
 void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 			 int cmd, int *wait_seq)
 {
@@ -1303,20 +1290,6 @@ static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 	return ret;
 }
 
-static u32 mt7615_mcu_gen_dl_mode(u8 feature_set, bool is_cr4)
-{
-	u32 ret = 0;
-
-	ret |= (feature_set & FW_FEATURE_SET_ENCRYPT) ?
-	       (DL_MODE_ENCRYPT | DL_MODE_RESET_SEC_IV) : 0;
-	ret |= FIELD_PREP(DL_MODE_KEY_IDX,
-			  FIELD_GET(FW_FEATURE_SET_KEY_IDX, feature_set));
-	ret |= DL_MODE_NEED_RSP;
-	ret |= is_cr4 ? DL_MODE_WORKING_PDA_CR4 : 0;
-
-	return ret;
-}
-
 static int
 mt7615_mcu_send_ram_firmware(struct mt7615_dev *dev,
 			     const struct mt7615_fw_trailer *hdr,
@@ -1327,7 +1300,8 @@ mt7615_mcu_send_ram_firmware(struct mt7615_dev *dev,
 	u32 len, addr, mode;
 
 	for (i = 0; i < n_region; i++) {
-		mode = mt7615_mcu_gen_dl_mode(hdr[i].feature_set, is_cr4);
+		mode = mt76_connac_mcu_gen_dl_mode(&dev->mt76,
+						   hdr[i].feature_set, is_cr4);
 		len = le32_to_cpu(hdr[i].len) + IMG_CRC_LEN;
 		addr = le32_to_cpu(hdr[i].addr);
 
@@ -1575,7 +1549,8 @@ static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 		dev_info(dev->mt76.dev, "Parsing tailer Region: %d\n", i);
 
 		buf = (const struct mt7663_fw_buf *)(base_addr - shift);
-		mode = mt7615_mcu_gen_dl_mode(buf->feature_set, false);
+		mode = mt76_connac_mcu_gen_dl_mode(&dev->mt76,
+						   buf->feature_set, false);
 		addr = le32_to_cpu(buf->img_dest_addr);
 		len = le32_to_cpu(buf->img_size);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 0dd02d79a297..bce3134e36a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -6,6 +6,26 @@
 
 #include "mt76_connac.h"
 
+#define FW_FEATURE_SET_ENCRYPT		BIT(0)
+#define FW_FEATURE_SET_KEY_IDX		GENMASK(2, 1)
+#define FW_FEATURE_ENCRY_MODE		BIT(4)
+#define FW_FEATURE_OVERRIDE_ADDR	BIT(5)
+
+#define DL_MODE_ENCRYPT			BIT(0)
+#define DL_MODE_KEY_IDX			GENMASK(2, 1)
+#define DL_MODE_RESET_SEC_IV		BIT(3)
+#define DL_MODE_WORKING_PDA_CR4		BIT(4)
+#define DL_MODE_VALID_RAM_ENTRY         BIT(5)
+#define DL_CONFIG_ENCRY_MODE_SEL	BIT(6)
+#define DL_MODE_NEED_RSP		BIT(31)
+
+#define FW_START_OVERRIDE		BIT(0)
+#define FW_START_WORKING_PDA_CR4	BIT(2)
+
+#define PATCH_SEC_NOT_SUPPORT		GENMASK(31, 0)
+#define PATCH_SEC_TYPE_MASK		GENMASK(15, 0)
+#define PATCH_SEC_TYPE_INFO		0x2
+
 struct tlv {
 	__le16 tag;
 	__le16 len;
@@ -1455,6 +1475,24 @@ mt76_connac_mcu_get_cipher(int cipher)
 	}
 }
 
+static inline u32
+mt76_connac_mcu_gen_dl_mode(struct mt76_dev *dev, u8 feature_set, bool is_wa)
+{
+	u32 ret = 0;
+
+	ret |= feature_set & FW_FEATURE_SET_ENCRYPT ?
+	       DL_MODE_ENCRYPT | DL_MODE_RESET_SEC_IV : 0;
+	if (is_mt7921(dev))
+		ret |= feature_set & FW_FEATURE_ENCRY_MODE ?
+		       DL_CONFIG_ENCRY_MODE_SEL : 0;
+	ret |= FIELD_PREP(DL_MODE_KEY_IDX,
+			  FIELD_GET(FW_FEATURE_SET_KEY_IDX, feature_set));
+	ret |= DL_MODE_NEED_RSP;
+	ret |= is_wa ? DL_MODE_WORKING_PDA_CR4 : 0;
+
+	return ret;
+}
+
 #define to_wcid_lo(id)		FIELD_GET(GENMASK(7, 0), (u16)id)
 #define to_wcid_hi(id)		FIELD_GET(GENMASK(9, 8), (u16)id)
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 3f4b04582879..cc09677e99de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -66,22 +66,6 @@ struct mt7915_fw_region {
 
 #define MCU_PATCH_ADDRESS		0x200000
 
-#define FW_FEATURE_SET_ENCRYPT		BIT(0)
-#define FW_FEATURE_SET_KEY_IDX		GENMASK(2, 1)
-#define FW_FEATURE_OVERRIDE_ADDR	BIT(5)
-
-#define DL_MODE_ENCRYPT			BIT(0)
-#define DL_MODE_KEY_IDX			GENMASK(2, 1)
-#define DL_MODE_RESET_SEC_IV		BIT(3)
-#define DL_MODE_WORKING_PDA_CR4		BIT(4)
-#define DL_MODE_NEED_RSP		BIT(31)
-
-#define FW_START_OVERRIDE		BIT(0)
-#define FW_START_WORKING_PDA_CR4	BIT(2)
-
-#define PATCH_SEC_TYPE_MASK		GENMASK(15, 0)
-#define PATCH_SEC_TYPE_INFO		0x2
-
 #define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
 #define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
 
@@ -2042,20 +2026,6 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 	return ret;
 }
 
-static u32 mt7915_mcu_gen_dl_mode(u8 feature_set, bool is_wa)
-{
-	u32 ret = 0;
-
-	ret |= (feature_set & FW_FEATURE_SET_ENCRYPT) ?
-	       (DL_MODE_ENCRYPT | DL_MODE_RESET_SEC_IV) : 0;
-	ret |= FIELD_PREP(DL_MODE_KEY_IDX,
-			  FIELD_GET(FW_FEATURE_SET_KEY_IDX, feature_set));
-	ret |= DL_MODE_NEED_RSP;
-	ret |= is_wa ? DL_MODE_WORKING_PDA_CR4 : 0;
-
-	return ret;
-}
-
 static int
 mt7915_mcu_send_ram_firmware(struct mt7915_dev *dev,
 			     const struct mt7915_fw_trailer *hdr,
@@ -2071,7 +2041,8 @@ mt7915_mcu_send_ram_firmware(struct mt7915_dev *dev,
 
 		region = (const struct mt7915_fw_region *)((const u8 *)hdr -
 			 (hdr->n_region - i) * sizeof(*region));
-		mode = mt7915_mcu_gen_dl_mode(region->feature_set, is_wa);
+		mode = mt76_connac_mcu_gen_dl_mode(&dev->mt76,
+						   region->feature_set, is_wa);
 		len = le32_to_cpu(region->len);
 		addr = le32_to_cpu(region->addr);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index fa6c0d8d3b22..e4d6dd3698d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -67,25 +67,6 @@ struct mt7921_fw_region {
 #define MT_STA_BFER			BIT(0)
 #define MT_STA_BFEE			BIT(1)
 
-#define FW_FEATURE_SET_ENCRYPT		BIT(0)
-#define FW_FEATURE_SET_KEY_IDX		GENMASK(2, 1)
-#define FW_FEATURE_ENCRY_MODE		BIT(4)
-#define FW_FEATURE_OVERRIDE_ADDR	BIT(5)
-
-#define DL_MODE_ENCRYPT			BIT(0)
-#define DL_MODE_KEY_IDX			GENMASK(2, 1)
-#define DL_MODE_RESET_SEC_IV		BIT(3)
-#define DL_MODE_WORKING_PDA_CR4		BIT(4)
-#define DL_CONFIG_ENCRY_MODE_SEL	BIT(6)
-#define DL_MODE_NEED_RSP		BIT(31)
-
-#define FW_START_OVERRIDE		BIT(0)
-#define FW_START_WORKING_PDA_CR4	BIT(2)
-
-#define PATCH_SEC_NOT_SUPPORT		GENMASK(31, 0)
-#define PATCH_SEC_TYPE_MASK		GENMASK(15, 0)
-#define PATCH_SEC_TYPE_INFO		0x2
-
 #define PATCH_SEC_ENC_TYPE_MASK		GENMASK(31, 24)
 #define PATCH_SEC_ENC_TYPE_PLAIN		0x00
 #define PATCH_SEC_ENC_TYPE_AES			0x01
@@ -583,22 +564,6 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 	return ret;
 }
 
-static u32 mt7921_mcu_gen_dl_mode(u8 feature_set, bool is_wa)
-{
-	u32 ret = 0;
-
-	ret |= (feature_set & FW_FEATURE_SET_ENCRYPT) ?
-	       (DL_MODE_ENCRYPT | DL_MODE_RESET_SEC_IV) : 0;
-	ret |= (feature_set & FW_FEATURE_ENCRY_MODE) ?
-	       DL_CONFIG_ENCRY_MODE_SEL : 0;
-	ret |= FIELD_PREP(DL_MODE_KEY_IDX,
-			  FIELD_GET(FW_FEATURE_SET_KEY_IDX, feature_set));
-	ret |= DL_MODE_NEED_RSP;
-	ret |= is_wa ? DL_MODE_WORKING_PDA_CR4 : 0;
-
-	return ret;
-}
-
 static int
 mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
 			     const struct mt7921_fw_trailer *hdr,
@@ -616,7 +581,8 @@ mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
 
 		region = (const struct mt7921_fw_region *)((const u8 *)hdr -
 			 (hdr->n_region - i) * sizeof(*region));
-		mode = mt7921_mcu_gen_dl_mode(region->feature_set, is_wa);
+		mode = mt76_connac_mcu_gen_dl_mode(&dev->mt76,
+						   region->feature_set, is_wa);
 		len = le32_to_cpu(region->len);
 		addr = le32_to_cpu(region->addr);
 
-- 
2.33.1

