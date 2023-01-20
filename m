Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0C7675919
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 16:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjATPvl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 10:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjATPvi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 10:51:38 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F535C9260
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 07:51:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d2so5213200wrp.8
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jji6c1AytbJ/adGMKBmPccCwXiPMA40IqqAENpcIbdM=;
        b=ZTQshhzu20g5AnxPUDMenwYAdejQDMjbIk0849zA8MX2atuBKZSxZbIP6eBsMDu481
         6cxsI3JgUqfiWXNv2V0MlfQIETLyy1hnOq+ECzz6dSZtb1s0LAUezAjFG9C3j6cjCPXd
         c/mTK5dX+NwoHSPW8xZND47jongT5i3Kz5w4P5cc7wNyZ/AnVZLd80v1lkpZnnznNfWr
         WpVB020TxYvhid2d6P8bBWjGvXFceM1Oaq/5d3UNshxxmEGghWprZxhk1SzmpyhWBzO/
         7wdoqtBjsfKSsMwKKUmLoha4rf3O0vnsh1nSr/XyXnCLtJKKRblwtgUuKV3wkaMiZgUT
         GKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jji6c1AytbJ/adGMKBmPccCwXiPMA40IqqAENpcIbdM=;
        b=Tu2QXJhZKqxfqvg9vCr/YNBCAPv7wTtDJ50kAtsxLQLwRsXwA1KtYbMRYbko74+jY9
         vlUMPLGgLlQvxa+R/1J0qOCAGblOY4Baa+1JIYetuXwEpjHkn320dKZP/HfyKeigVmzx
         0bC5K71/11JWW9DNNBhnJK/g3P4v975zT3ct/A1iZOCvVf3MJvnGWJc4pEkO+zn7nxRV
         Ow1g6OfQF9bHCu2+hUoKU2sqdbXfL4UUag19c0oYLq6uFN55MjnY5OpPRk8F8TL/h/T1
         bzD5XW4lyleb//yriPQZPgM6F8I8AkfEuacZqYA9WWw5FYjgfd7TQs/aycwu8550BsrT
         J6iw==
X-Gm-Message-State: AFqh2krmhZR5C/M/vV56JcFDN41BAHLdm+GfyFlOTRBGcuc/4I/8+j36
        dt8wwioE0TNeoCgSgCXgJ9tpJrbu+zk=
X-Google-Smtp-Source: AMrXdXs72+qb1PQYolScog7WuqQM9AyXW1XidTFmIkVI0qeKDl06gseewPzeMNd3PaLhYrqPnUYtRQ==
X-Received: by 2002:a05:6000:a03:b0:2b9:9e7b:be6b with SMTP id co3-20020a0560000a0300b002b99e7bbe6bmr14346480wrb.45.1674229885977;
        Fri, 20 Jan 2023 07:51:25 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.25])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002bdd21f25ebsm21678853wrq.71.2023.01.20.07.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 07:51:25 -0800 (PST)
Message-ID: <b8235bca-60c3-d0fe-a958-53c6dd3ba3f6@gmail.com>
Date:   Fri, 20 Jan 2023 17:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 1/4] wifi: rtl8xxxu: Register the LED and make it blink
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

If the chip can have an LED, register a struct led_classdev and enable
hardware-controlled blinking. When the chip is not transmitting or
receiving anything the LED is off. Otherwise the LED will blink
faster or slower according to the throughput.

The LED can be controlled from userspace by writing 0, 1, or 2 to
/sys/class/leds/rtl8xxxu-usbX-Y/brightness:
0 - solid off.
1 - solid on.
2 - hardware-controlled blinking.

In this patch none of the chips advertise having an LED. That will be
added in the next patches.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Suggestion from Ping-Ke Shih:
   - Check for led_classdev_brightness_set inside rtl8xxxu_init_led()
     and for led_registered inside rtl8xxxu_deinit_led() instead of
     checking for them in the caller functions.
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  8 ++++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 38 +++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 90268479d3ad..c8cee4a24755 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1443,6 +1443,8 @@ struct rtl8xxxu_cfo_tracking {
 	u32 packet_count_pre;
 };
 
+#define RTL8XXXU_HW_LED_CONTROL	2
+
 struct rtl8xxxu_priv {
 	struct ieee80211_hw *hw;
 	struct usb_device *udev;
@@ -1564,6 +1566,10 @@ struct rtl8xxxu_priv {
 	struct rtl8xxxu_ra_report ra_report;
 	struct rtl8xxxu_cfo_tracking cfo_tracking;
 	struct rtl8xxxu_ra_info ra_info;
+
+	bool led_registered;
+	char led_name[32];
+	struct led_classdev led_cdev;
 };
 
 struct rtl8xxxu_rx_urb {
@@ -1613,6 +1619,8 @@ struct rtl8xxxu_fileops {
 			     u32 rts_rate);
 	void (*set_crystal_cap) (struct rtl8xxxu_priv *priv, u8 crystal_cap);
 	s8 (*cck_rssi) (struct rtl8xxxu_priv *priv, u8 cck_agc_rpt);
+	int (*led_classdev_brightness_set) (struct led_classdev *led_cdev,
+					    enum led_brightness brightness);
 	int writeN_block_size;
 	int rx_agg_buf_size;
 	char tx_desc_size;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 35dc777c1fba..b25c7efcdec8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6955,6 +6955,40 @@ static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
 	return ret;
 }
 
+static void rtl8xxxu_init_led(struct rtl8xxxu_priv *priv)
+{
+	struct led_classdev *led = &priv->led_cdev;
+
+	if (!priv->fops->led_classdev_brightness_set)
+		return;
+
+	led->brightness_set_blocking = priv->fops->led_classdev_brightness_set;
+
+	snprintf(priv->led_name, sizeof(priv->led_name),
+		 "rtl8xxxu-usb%s", dev_name(&priv->udev->dev));
+	led->name = priv->led_name;
+	led->max_brightness = RTL8XXXU_HW_LED_CONTROL;
+
+	if (led_classdev_register(&priv->udev->dev, led))
+		return;
+
+	priv->led_registered = true;
+
+	led->brightness = led->max_brightness;
+	priv->fops->led_classdev_brightness_set(led, led->brightness);
+}
+
+static void rtl8xxxu_deinit_led(struct rtl8xxxu_priv *priv)
+{
+	struct led_classdev *led = &priv->led_cdev;
+
+	if (!priv->led_registered)
+		return;
+
+	priv->fops->led_classdev_brightness_set(led, LED_OFF);
+	led_classdev_unregister(led);
+}
+
 static int rtl8xxxu_probe(struct usb_interface *interface,
 			  const struct usb_device_id *id)
 {
@@ -7135,6 +7169,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		goto err_set_intfdata;
 	}
 
+	rtl8xxxu_init_led(priv);
+
 	return 0;
 
 err_set_intfdata:
@@ -7159,6 +7195,8 @@ static void rtl8xxxu_disconnect(struct usb_interface *interface)
 	hw = usb_get_intfdata(interface);
 	priv = hw->priv;
 
+	rtl8xxxu_deinit_led(priv);
+
 	ieee80211_unregister_hw(hw);
 
 	priv->fops->power_off(priv);
-- 
2.39.1
