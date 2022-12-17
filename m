Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1851264F92C
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiLQOM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiLQOM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:12:28 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC5613F2F
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:12:26 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id fc4so12180927ejc.12
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrIDSlIA9on0IvHscyOU6mAFz0E3mk0NHxmRp3jsPM4=;
        b=Fu/qtPbP+fcjSrSneoVNNtUjt3D9rM+iQG2l2MALW6kHlZHM6dYAnNc0xk4kCH2g1m
         kM2qV7KOp46rJkLOtTWhtFLiVuPNeBt3dj2EAXXcxURPHuBWMBN1V3oST4vKeCUvd16H
         8uHeF+BzwPfDusSjmxWqxP4ytPIWn3BZs8Em7boE6OH/wDoLiza8h7HlTOTxGi98DqwF
         tDh+UaYZ5zPOYZdH6DOszfy6woiHSrL81qBZY//GWiaWFs65hDR/ZFZA23+rWfe9gIEs
         xAJ1BAPJCyXeDxcSvZZ7/GI06LzEHYjH2VIIT43WYpFEzyecTVcLNPEA5XtySDfjELDH
         U9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NrIDSlIA9on0IvHscyOU6mAFz0E3mk0NHxmRp3jsPM4=;
        b=fA8SEmkRyhHYj7b8xMamTCxOPb/MTiYzI1UKV0XeB33o5qDOpfgiy7SLau4gHgFOLp
         d2HkFJetnTcEymoieAobI2ZZm5QeIx5KLG/5OblKaSNGyuVDsIhdTYoJA4YeOJn5AR0a
         nzx4Xof9Pag3+363TBKWvaFnGPzcdq8hz+ZuaH8AiNuc+4pRAOIBWGkYvaG18xcg7C6I
         na8Xvav5zoYpxWf9YhtnnViuw7Z/M3tL3QiXV7xp2WY3LoZse7VVYLH+NVPWqDhL3kYK
         2oCFSsztTD7b1WbRP3cdYdxuNepSy4gqgJa5q20w+NyvzqYERtM8DSREXIv7W0Y0G5nF
         Q37Q==
X-Gm-Message-State: ANoB5pnyoCSa8/RpOpX8jkBng6SdYixmUXQugPwJKQw6XtT529DIT2VU
        vZZ0xX83Flgqo0I2w4jSqsMbnv8wEdw=
X-Google-Smtp-Source: AA0mqf72PugwGedsxJ9j0U/XZFFIdg6mWUQVU7U2lVJlTsnJ1XBuVmYVwSE/xQVNAODX8FwrKuHN0g==
X-Received: by 2002:a17:906:14ce:b0:7c0:e0d9:c1df with SMTP id y14-20020a17090614ce00b007c0e0d9c1dfmr31572054ejc.10.1671286345308;
        Sat, 17 Dec 2022 06:12:25 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id lf24-20020a170906ae5800b0078de26f66b9sm2041984ejb.114.2022.12.17.06.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 06:12:24 -0800 (PST)
Message-ID: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
Date:   Sat, 17 Dec 2022 16:12:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v3 1/5] wifi: rtl8xxxu: Deduplicate the efuse dumping code
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Every chip family except RTL8723AU has a copy of the efuse dumping
code. Remove this and dump the efuse from a single place using a new
function rtl8xxxu_dump_efuse().

Also, use print_hex_dump() to print the efuse instead of a loop and
dev_info(). It shows the ASCII interpretation of the bytes, which is
nice.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - Implement suggestion from Ping-Ke Shih:
   - Use EFUSE_MAP_LEN instead of EFUSE_REAL_CONTENT_LEN_8723A.
     They have the same value.

v2:
 - Patch is new in v2.
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c  | 11 -----------
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c  | 10 ----------
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c  |  9 ---------
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c  | 11 -----------
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c   | 13 +++++++++++++
 5 files changed, 13 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 2c4f403ba68f..ba28a4c00d3b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -716,7 +716,6 @@ static void rtl8188fu_init_statistics(struct rtl8xxxu_priv *priv)
 static int rtl8188fu_parse_efuse(struct rtl8xxxu_priv *priv)
 {
 	struct rtl8188fu_efuse *efuse = &priv->efuse_wifi.efuse8188fu;
-	int i;
 
 	if (efuse->rtl_id != cpu_to_le16(0x8129))
 		return -EINVAL;
@@ -738,16 +737,6 @@ static int rtl8188fu_parse_efuse(struct rtl8xxxu_priv *priv)
 	dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
 	dev_info(&priv->udev->dev, "Product: %.7s\n", efuse->device_name);
 
-	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE) {
-		unsigned char *raw = priv->efuse_wifi.raw;
-
-		dev_info(&priv->udev->dev,
-			 "%s: dumping efuse (0x%02zx bytes):\n",
-			 __func__, sizeof(struct rtl8188fu_efuse));
-		for (i = 0; i < sizeof(struct rtl8188fu_efuse); i += 8)
-			dev_info(&priv->udev->dev, "%02x: %8ph\n", i, &raw[i]);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index 3bef9ffc8b02..d43f8afeb876 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -404,7 +404,6 @@ static int rtl8192cu_load_firmware(struct rtl8xxxu_priv *priv)
 static int rtl8192cu_parse_efuse(struct rtl8xxxu_priv *priv)
 {
 	struct rtl8192cu_efuse *efuse = &priv->efuse_wifi.efuse8192;
-	int i;
 
 	if (efuse->rtl_id != cpu_to_le16(0x8129))
 		return -EINVAL;
@@ -457,15 +456,6 @@ static int rtl8192cu_parse_efuse(struct rtl8xxxu_priv *priv)
 		priv->power_base = &rtl8188r_power_base;
 	}
 
-	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE) {
-		unsigned char *raw = priv->efuse_wifi.raw;
-
-		dev_info(&priv->udev->dev,
-			 "%s: dumping efuse (0x%02zx bytes):\n",
-			 __func__, sizeof(struct rtl8192cu_efuse));
-		for (i = 0; i < sizeof(struct rtl8192cu_efuse); i += 8)
-			dev_info(&priv->udev->dev, "%02x: %8ph\n", i, &raw[i]);
-	}
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 6dc1e5858e77..91f018f6fca0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -704,15 +704,6 @@ static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
 	rtl8192eu_log_next_device_info(priv, "Product", efuse->device_info, &record_offset);
 	rtl8192eu_log_next_device_info(priv, "Serial", efuse->device_info, &record_offset);
 
-	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE) {
-		unsigned char *raw = priv->efuse_wifi.raw;
-
-		dev_info(&priv->udev->dev,
-			 "%s: dumping efuse (0x%02zx bytes):\n",
-			 __func__, sizeof(struct rtl8192eu_efuse));
-		for (i = 0; i < sizeof(struct rtl8192eu_efuse); i += 8)
-			dev_info(&priv->udev->dev, "%02x: %8ph\n", i, &raw[i]);
-	}
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index a0ec895b61a4..b26737447035 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -497,17 +497,6 @@ static int rtl8723bu_parse_efuse(struct rtl8xxxu_priv *priv)
 	dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
 	dev_info(&priv->udev->dev, "Product: %.41s\n", efuse->device_name);
 
-	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE) {
-		int i;
-		unsigned char *raw = priv->efuse_wifi.raw;
-
-		dev_info(&priv->udev->dev,
-			 "%s: dumping efuse (0x%02zx bytes):\n",
-			 __func__, sizeof(struct rtl8723bu_efuse));
-		for (i = 0; i < sizeof(struct rtl8723bu_efuse); i += 8)
-			dev_info(&priv->udev->dev, "%02x: %8ph\n", i, &raw[i]);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 3ed435401e57..7f2adb1a9c70 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1813,6 +1813,16 @@ static int rtl8xxxu_read_efuse(struct rtl8xxxu_priv *priv)
 	return ret;
 }
 
+static void rtl8xxxu_dump_efuse(struct rtl8xxxu_priv *priv)
+{
+	dev_info(&priv->udev->dev,
+		 "Dumping efuse for RTL%s (0x%02x bytes):\n",
+		 priv->chip_name, EFUSE_MAP_LEN);
+
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
+		       priv->efuse_wifi.raw, EFUSE_MAP_LEN, true);
+}
+
 void rtl8xxxu_reset_8051(struct rtl8xxxu_priv *priv)
 {
 	u8 val8;
@@ -6839,6 +6849,9 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		goto err_set_intfdata;
 	}
 
+	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE)
+		rtl8xxxu_dump_efuse(priv);
+
 	rtl8xxxu_print_chipinfo(priv);
 
 	ret = priv->fops->load_firmware(priv);
-- 
2.38.0
