Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB506E4EC2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 19:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjDQRFt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 13:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQRFs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 13:05:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3951448B
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 10:05:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sz19so8954127ejc.2
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 10:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681751145; x=1684343145;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJBu1cDB2rDY4+OXJSC6bVwdAj9BGhH8dohZ1ZZQ5ug=;
        b=OfQOvzY9hZ9XckrRNfjM+O8UEq3Luwe/FD6aa2S1/y4lFfNcmcJ8VxYLCD4/EB1mOO
         cBh71VeBTy9oO2PNk+G9hhZxehVhddGsoudkgJhpOwrEcCoQ70oPWjyTb4Bh5ttva3oT
         IEPFDi7cZ6N6LdTtm9cyJpZnN5APoF20kV7yI7Fcs5gZ2/vJEyYvOmqgo/yB7qlV/d19
         u9Q8yHbQ9STOqYszVDQZvt+kaBR32lS5R7JlR5DlHvXRKJZSPBB4v34HgEsrxFfCUdmR
         2jGZzoCzrXFOLX2BXxZhTzkZQSdxXQUpInf/hYA5VWQ0Skq5yC4aPAtPcrBsUFjipuB/
         Tw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681751145; x=1684343145;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WJBu1cDB2rDY4+OXJSC6bVwdAj9BGhH8dohZ1ZZQ5ug=;
        b=JwF/Br38AdwzgDg+4yj3EpkuKzas8hvRstNpzed0+Iczt9BGb8e/y0roUEh2q1KVnY
         lu9rFUZfNX78NcwnrGhFsiHmFkR/0KTznBhnbJ4bPcpRwy/lN9VGoW1biuO+VBQ8ODwm
         Nv40722bJJ1yJHo4AHj+UZqvKmpX5Sbjg9qo3s4SUWpTNl1q+mQCTNeonCBNxJU1Q4Lq
         jwXJNrqmKRGW0uQWp47rcKb3oI4RtBHJfVsCdmYcW1awYDSgSnDrFv/sEQESkB26Td42
         vp3u770TT7JBH3QpdTjzCF9PSHziwkByPhDI3A0fZomRTKQHjlimse7UpPRA9gSakLlq
         cOpg==
X-Gm-Message-State: AAQBX9dHl5+xqFdO04pJ+9AR+1sw2bUUbZkfbGfhFSBis6DNNoSwstUG
        539m5A2HGb5XW6gwNPAckIRciKIuQiU=
X-Google-Smtp-Source: AKy350Zh/G0QEYAUlP9YZocnv5ly+kdTaoKjWJ4cy95p0Lw4q6/XOfrssPNwK/OXUFpMJDPMaDvbdQ==
X-Received: by 2002:a17:906:3d71:b0:94f:61b2:c991 with SMTP id r17-20020a1709063d7100b0094f61b2c991mr4246330ejf.74.1681751145204;
        Mon, 17 Apr 2023 10:05:45 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id wy6-20020a170906fe0600b0094ee88207d5sm5155806ejb.191.2023.04.17.10.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 10:05:44 -0700 (PDT)
Message-ID: <a2a7d9df-0529-7890-3522-48dce613753f@gmail.com>
Date:   Mon, 17 Apr 2023 20:05:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/3] wifi: rtl8xxxu: Don't print the vendor/product/serial
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Most devices have a vendor name, product name, and serial number in the
efuse, but it's pretty useless. It duplicates the information already
printed by the USB subsystem:

   usb 1-4: New USB device found, idVendor=0bda, idProduct=8178, bcdDevice= 2.00
   usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
   usb 1-4: Product: 802.11n WLAN Adapter
   usb 1-4: Manufacturer: Realtek
   usb 1-4: SerialNumber: 00e04c000001
-> usb 1-4: Vendor: Realtek
-> usb 1-4: Product: 802.11n WLAN Adapter

   usb 1-4: New USB device found, idVendor=0bda, idProduct=818b, bcdDevice= 2.00
   usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
   usb 1-4: Product: 802.11n NIC
   usb 1-4: Manufacturer: Realtek
   usb 1-4: SerialNumber: 00e04c000001
-> usb 1-4: Vendor: Realtek
-> usb 1-4: Product: 802.11n NIC
-> usb 1-4: Serial not available.

   usb 1-4: New USB device found, idVendor=0bda, idProduct=f179, bcdDevice= 0.00
   usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
   usb 1-4: Product: 802.11n
   usb 1-4: Manufacturer: Realtek
   usb 1-4: SerialNumber: 002E2DC0041F
-> usb 1-4: Vendor: Realtek
-> usb 1-4: Product: 802.11n

   usb 1-4: New USB device found, idVendor=0bda, idProduct=8179, bcdDevice= 0.00
   usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
   usb 1-4: Product: 802.11n NIC
   usb 1-4: Manufacturer: Realtek
   usb 1-4: SerialNumber: 00E04C0001
-> usb 1-4: Vendor: Realtek
-> usb 1-4: Product: 802.11n NIC
-> usb 1-4: Serial: 00E04C0001

Also, that data is not interpreted correctly in all cases:

usb 3-1.1.2: New USB device found, idVendor=0bda, idProduct=8179, bcdDevice= 0.00
usb 3-1.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-1.1.2: Product: 802.11n NIC
usb 3-1.1.2: Manufacturer: Realtek
usb 3-1.1.2: Vendor: Realtek
usb 3-1.1.2: Product: \x03802.11n NI
usb 3-1.1.2: Serial: \xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217231
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |  4 --
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  3 --
 .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         |  5 --
 .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         | 54 -------------------
 .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         |  4 --
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |  3 --
 6 files changed, 73 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
index af8436070ba7..8986783ae8fa 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
@@ -568,10 +568,6 @@ static int rtl8188eu_parse_efuse(struct rtl8xxxu_priv *priv)
 
 	priv->default_crystal_cap = efuse->xtal_k & 0x3f;
 
-	dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
-	dev_info(&priv->udev->dev, "Product: %.11s\n", efuse->device_name);
-	dev_info(&priv->udev->dev, "Serial: %.11s\n", efuse->serial);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index dfb250adb168..dbdfd7787465 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -734,9 +734,6 @@ static int rtl8188fu_parse_efuse(struct rtl8xxxu_priv *priv)
 
 	priv->default_crystal_cap = efuse->xtal_k & 0x3f;
 
-	dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
-	dev_info(&priv->udev->dev, "Product: %.7s\n", efuse->device_name);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index caeba56241fc..b30a9a513cb8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -441,11 +441,6 @@ static int rtl8192cu_parse_efuse(struct rtl8xxxu_priv *priv)
 	       efuse->ht20_max_power_offset,
 	       sizeof(efuse->ht20_max_power_offset));
 
-	dev_info(&priv->udev->dev, "Vendor: %.7s\n",
-		 efuse->vendor_name);
-	dev_info(&priv->udev->dev, "Product: %.20s\n",
-		 efuse->device_name);
-
 	priv->power_base = &rtl8192c_power_base;
 
 	if (efuse->rf_regulatory & 0x20) {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 4498748164af..fcc2926ea938 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -601,43 +601,9 @@ rtl8192e_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 	}
 }
 
-static void rtl8192eu_log_next_device_info(struct rtl8xxxu_priv *priv,
-					   char *record_name,
-					   char *device_info,
-					   unsigned int *record_offset)
-{
-	char *record = device_info + *record_offset;
-
-	/* A record is [ total length | 0x03 | value ] */
-	unsigned char l = record[0];
-
-	/*
-	 * The whole device info section seems to be 80 characters, make sure
-	 * we don't read further.
-	 */
-	if (*record_offset + l > 80) {
-		dev_warn(&priv->udev->dev,
-			 "invalid record length %d while parsing \"%s\" at offset %u.\n",
-			 l, record_name, *record_offset);
-		return;
-	}
-
-	if (l >= 2) {
-		char value[80];
-
-		memcpy(value, &record[2], l - 2);
-		value[l - 2] = '\0';
-		dev_info(&priv->udev->dev, "%s: %s\n", record_name, value);
-		*record_offset = *record_offset + l;
-	} else {
-		dev_info(&priv->udev->dev, "%s not available.\n", record_name);
-	}
-}
-
 static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
 {
 	struct rtl8192eu_efuse *efuse = &priv->efuse_wifi.efuse8192eu;
-	unsigned int record_offset;
 	int i;
 
 	if (efuse->rtl_id != cpu_to_le16(0x8129))
@@ -684,26 +650,6 @@ static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
 
 	priv->default_crystal_cap = priv->efuse_wifi.efuse8192eu.xtal_k & 0x3f;
 
-	/*
-	 * device_info section seems to be laid out as records
-	 * [ total length | 0x03 | value ] so:
-	 * - vendor length + 2
-	 * - 0x03
-	 * - vendor string (not null terminated)
-	 * - product length + 2
-	 * - 0x03
-	 * - product string (not null terminated)
-	 * Then there is one or 2 0x00 on all the 4 devices I own or found
-	 * dumped online.
-	 * As previous version of the code handled an optional serial
-	 * string, I now assume there may be a third record if the
-	 * length is not 0.
-	 */
-	record_offset = 0;
-	rtl8192eu_log_next_device_info(priv, "Vendor", efuse->device_info, &record_offset);
-	rtl8192eu_log_next_device_info(priv, "Product", efuse->device_info, &record_offset);
-	rtl8192eu_log_next_device_info(priv, "Serial", efuse->device_info, &record_offset);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index d219be19d07f..15a30e496221 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -222,10 +222,6 @@ static int rtl8723au_parse_efuse(struct rtl8xxxu_priv *priv)
 
 	priv->power_base = &rtl8723a_power_base;
 
-	dev_info(&priv->udev->dev, "Vendor: %.7s\n",
-		 efuse->vendor_name);
-	dev_info(&priv->udev->dev, "Product: %.41s\n",
-		 efuse->device_name);
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index c31c2b52ac77..abc56c7de6f7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -494,9 +494,6 @@ static int rtl8723bu_parse_efuse(struct rtl8xxxu_priv *priv)
 
 	priv->default_crystal_cap = priv->efuse_wifi.efuse8723bu.xtal_k & 0x3f;
 
-	dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
-	dev_info(&priv->udev->dev, "Product: %.41s\n", efuse->device_name);
-
 	return 0;
 }
 
-- 
2.39.2
