Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCD9670B95
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 23:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjAQWY1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 17:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjAQWXa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 17:23:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD7C45F79
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:03:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l8so6242343wms.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xzk8b3fBqLsf5katRnJV2feS2sUT/0Rm8pDNg5Jrg8o=;
        b=c6Zq1tNb7QfP2GVSG9wrOsObblDAoWx6AThJG6HA05mWlMZ9lUZWy620JynGaG5USy
         IughVsceKmiHzISZ92mYWAKh8rrjRefAT8yGdGGTVgLcO7MpSro8xG1nZ+i208rpahcJ
         rUF+cGuEKOg236z8Dggzz2y4ij4buSTvgjDxTGNO5PNJNzSrnA4zThg6LUzcAzEX4CYw
         d28BtVrrF0Me14JX8GvC5UQ4Gv5DF4JNhXsrV82Bbft9Ub+81vvXmmYi3njHsqf2Ujcs
         inCbbqh0Zmxm3mBG3ZcyccQrwetlaFUFCYbPeiQoCSqAmnPsu4ftFDBGUIem0UMP1Zvp
         gNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xzk8b3fBqLsf5katRnJV2feS2sUT/0Rm8pDNg5Jrg8o=;
        b=CPWollwY2K6h1whgPDw/Lgb4uFtwwNPor3QI7wHZRtP/0iLrL6eTwEQfrvgo9kkDYG
         R+g+WUbUyYn1rfvd5e9IjTANu64dUcz0Ncu6WCURvcRsnJKgffDZbMgjmawaIAjbZU+l
         JrlgTiUbmsZzd0G9pfpgFE/UeeAoTbYy9tJSJNiud5k+4t2ikHwDVqBHooqb2hWfsNlV
         N1Gd1jb62AIP2udRTyq5lv6G7fQI6V5M4rCje/2S4+gY+UUPjtCI5ynhsxRcbmXGqxFY
         dQzX8/u7zsOroRZMNQ9CfnmdRiorL7AOx8G7c+L6d/+fjbAnErb6mTPJPqLDEGgDI49o
         JVqg==
X-Gm-Message-State: AFqh2koZB3baxOEQIa0EuTrg9XCjNAfKbCJ21tU1AY/a+jbphR5rnMK6
        cYzBATgCi3BXHfTrguKNHFNUQH+s3OI=
X-Google-Smtp-Source: AMrXdXtsFS+oEorqL5PF48d1Db1NbH67mDk4tQXqdSQXcZiaLQWWYRMwYdz8jmQW+MHsJUibtK8+EA==
X-Received: by 2002:a05:600c:4f92:b0:3cf:88c3:d008 with SMTP id n18-20020a05600c4f9200b003cf88c3d008mr13135043wmq.28.1673992980309;
        Tue, 17 Jan 2023 14:03:00 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id j35-20020a05600c1c2300b003c71358a42dsm112988wms.18.2023.01.17.14.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 14:02:59 -0800 (PST)
Message-ID: <5c03ae42-a2fd-b39a-e754-f52d8528a167@gmail.com>
Date:   Wed, 18 Jan 2023 00:02:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/4] wifi: rtl8xxxu: Register the LED and make it blink
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
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  8 +++++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 34 +++++++++++++++++++
 2 files changed, 42 insertions(+)

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
index 35dc777c1fba..b27edd503c23 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6955,6 +6955,34 @@ static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
 	return ret;
 }
 
+static void rtl8xxxu_init_led(struct rtl8xxxu_priv *priv)
+{
+	struct led_classdev *led = &priv->led_cdev;
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
+	priv->fops->led_classdev_brightness_set(led, LED_OFF);
+	led_classdev_unregister(led);
+}
+
 static int rtl8xxxu_probe(struct usb_interface *interface,
 			  const struct usb_device_id *id)
 {
@@ -7135,6 +7163,9 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		goto err_set_intfdata;
 	}
 
+	if (priv->fops->led_classdev_brightness_set)
+		rtl8xxxu_init_led(priv);
+
 	return 0;
 
 err_set_intfdata:
@@ -7159,6 +7190,9 @@ static void rtl8xxxu_disconnect(struct usb_interface *interface)
 	hw = usb_get_intfdata(interface);
 	priv = hw->priv;
 
+	if (priv->led_registered)
+		rtl8xxxu_deinit_led(priv);
+
 	ieee80211_unregister_hw(hw);
 
 	priv->fops->power_off(priv);
-- 
2.38.0
