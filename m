Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8161464BAF0
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Dec 2022 18:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiLMR1K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Dec 2022 12:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiLMR1J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Dec 2022 12:27:09 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6127F209BC
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 09:27:08 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id tz12so15598345ejc.9
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 09:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRW4cYKTrXvxJj+ji69ZZx3AFdjHRwZvDb8fHYqEcm0=;
        b=bVLwUJ9CWgPcYcCmy+8zB2zcss9HF4KeihpI5ycg8BrytkTwUIoXwfREFcNRcHANU+
         OiO+mSsNq6/UcxJzCMjYc148+VEMoHH+pe8z3mIOS0gjU2cdHhSrIJzis1e7Hd0ug45s
         QNg1v+efswOLCzDYbK9oRotGls5mlUC/NHk25Rr971za7uEDSnl4tnHeLb/sx1AnbHyp
         F6Xu58VsLjL9A+jrP7avXah4zRc7Kl8SI4h4X4ZbSjBAfl2zFQ6TvEy9/Ay7u8YgJ/U9
         q4UeYDMXqyrPC4IvNaBRaFGCsU1x1z1OYmkWP2vBM00HOaQalew+2uj5XtfoSB3ZLtB5
         8JtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VRW4cYKTrXvxJj+ji69ZZx3AFdjHRwZvDb8fHYqEcm0=;
        b=F3ydz/dcaUe/4ZAtBD13kdXXuj9XeREKUVORDnhr0DUpjfCt9pAbaUcDqtvI/UO0M/
         7BuAnioM+QWFWM7MHAxmUbIXumVGpDWkRaF8B0SHbid4U8A/M+ZXVSCqkM1DnxyrMREE
         igQHZWaLx/Klejlz/LhBDrV/K57a/X/9O0ucp/BLjaLoyJjzZ7G+cHj2RDbJrVxiJK4E
         ji4/Hco7NCt7EICHO2SLq+vy3lKmiijCcl39cUC7Fgw2Kq2TsRQ+8OiQ0a3RoDBjhwJi
         915A9vMsU9sDqcwUbWyNeAxFU3InkM1uoUCGa4BpBo6CvruK6h3BtwnKj7MjNyIOKDkp
         gn/A==
X-Gm-Message-State: ANoB5plXIDaWdRy6z++OJyMs9sgB06eTaroLiIAS8FOuTowE66kLGQ7J
        oMH39shXg5lL+EtpewwCHKPYotqd/sc=
X-Google-Smtp-Source: AA0mqf4CV/0xu+Gug9e5y4UaagfRsIMocbOETlx02Pfkd7hhMFIj2M0x9jrHlV6xjg3AIOXgQKt1rw==
X-Received: by 2002:a17:907:6743:b0:7c1:7c3a:5c65 with SMTP id qm3-20020a170907674300b007c17c3a5c65mr6706751ejc.4.1670952426916;
        Tue, 13 Dec 2022 09:27:06 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id gg9-20020a170906e28900b0078db5bddd9csm4798099ejb.22.2022.12.13.09.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:27:06 -0800 (PST)
Message-ID: <c9619d20-ba6b-1611-dafb-9fe14617e1ee@gmail.com>
Date:   Tue, 13 Dec 2022 19:27:04 +0200
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
Subject: [PATCH v2 1/5] wifi: rtl8xxxu: Deduplicate the efuse dumping code
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
v2:
 - Patch is new in v2.
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 11 -----------
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c | 10 ----------
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |  9 ---------
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 11 -----------
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 14 ++++++++++++++
 5 files changed, 14 insertions(+), 41 deletions(-)

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
index 3ed435401e57..827672ce953d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1813,6 +1813,17 @@ static int rtl8xxxu_read_efuse(struct rtl8xxxu_priv *priv)
 	return ret;
 }
 
+static void rtl8xxxu_dump_efuse(struct rtl8xxxu_priv *priv)
+{
+	dev_info(&priv->udev->dev,
+		 "Dumping efuse for RTL%s (0x%02x bytes):\n",
+		 priv->chip_name, EFUSE_REAL_CONTENT_LEN_8723A);
+
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
+		       priv->efuse_wifi.raw, EFUSE_REAL_CONTENT_LEN_8723A,
+		       true);
+}
+
 void rtl8xxxu_reset_8051(struct rtl8xxxu_priv *priv)
 {
 	u8 val8;
@@ -6839,6 +6850,9 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		goto err_set_intfdata;
 	}
 
+	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE)
+		rtl8xxxu_dump_efuse(priv);
+
 	rtl8xxxu_print_chipinfo(priv);
 
 	ret = priv->fops->load_firmware(priv);
-- 
2.38.0
