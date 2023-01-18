Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1651671F1A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 15:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjAROMK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 09:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjAROLp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 09:11:45 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF007E48B
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 05:53:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so1486499wmb.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 05:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X6UjTCKRyADatla2C1Rx/VjvGNqEVoBMD02ZdH9LNII=;
        b=o6y5x2RxVZl9wRkxX16l2innobNp5NkoN0TCXmoYZUsW9liJ0ej36lhKUaIITYP1ds
         y3w3we2YojgRonPgVcbOOyqPRxwzvuXbXoKuK1o2vn5TGYlNfsSlPBoF73+7axl0ahHn
         ol6frjc8d35reMpikGZRgME5Fpoj2AWGo3O1L/SwqXVY+VhGw3Mq58EDc/c+T/5tJSUZ
         RWdIehBQFFKHstKmnrUuec+dD/Wg8JNQuA54VwXeV+FE0MRkHJAlinSvEGemfmKGyjEt
         b1tKid8KT55gw1R72SaE/6wISDtzi11519Tc3H1WYwb+EFQ1b15yYYXD9LKn+wInbPxm
         M8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6UjTCKRyADatla2C1Rx/VjvGNqEVoBMD02ZdH9LNII=;
        b=n0vGSpFRIbowcaUA5b5V9hO6iGpFI/49Dm7j04xeX+j3uCPl3xxj7HaVWKuWHT5+sx
         zlRlKIYtdiSAgcbTPjb5gaRQXuGwIZy4tTdjUqLfmRmE2IHzlyK7WrxW3dj3rJKvb0/u
         xlq7/5TcciGYU2Rw1hAeigLBIjTCseeYhgsL8jeLSKqp6Ph6nwcZN+C2IQXBN8U89HYY
         GK4CsmkhTG5DSiUnPPegleg69vr2fZwQ9CmF/16SMMnqWymHqaruyBp94dNaAjmv/Ogu
         etfDTXUca0UspSqhzq7zrxY5bdIdMBEa5zp5XOHlFr70XybqdPrM8zso7p8WonmYohGd
         KEjA==
X-Gm-Message-State: AFqh2koBcxb1KUjyB16+00atBGgCjcV5j1qtpR+1ZJ9zYFi6x7i2FEtr
        3IzEvxpTU+JwV6gZxa2tRLDRF66fhOU=
X-Google-Smtp-Source: AMrXdXt9ScC4Ujf+fG1vU0vKzeG2vxMo2yYKe0kcTnsv3T273mP4jCTtst4gaMogJNioIj9YS7J/VQ==
X-Received: by 2002:a05:600c:3549:b0:3da:acb1:2f09 with SMTP id i9-20020a05600c354900b003daacb12f09mr2797291wmq.19.1674049981203;
        Wed, 18 Jan 2023 05:53:01 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c379000b003db15b1fb3csm1511732wmr.13.2023.01.18.05.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 05:53:00 -0800 (PST)
Message-ID: <668921d6-cff5-7b42-3406-f42f445a15ef@gmail.com>
Date:   Wed, 18 Jan 2023 15:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/4] wifi: rtl8xxxu: Register the LED and make it blink
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <5c03ae42-a2fd-b39a-e754-f52d8528a167@gmail.com>
 <f2f52496d4274861b5870c1f425fa8e8@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <f2f52496d4274861b5870c1f425fa8e8@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 18/01/2023 02:52, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Wednesday, January 18, 2023 6:03 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH 1/4] wifi: rtl8xxxu: Register the LED and make it blink
>>
>> If the chip can have an LED, register a struct led_classdev and enable
>> hardware-controlled blinking. When the chip is not transmitting or
>> receiving anything the LED is off. Otherwise the LED will blink
>> faster or slower according to the throughput.
>>
>> The LED can be controlled from userspace by writing 0, 1, or 2 to
>> /sys/class/leds/rtl8xxxu-usbX-Y/brightness:
>> 0 - solid off.
>> 1 - solid on.
>> 2 - hardware-controlled blinking.
> 
> So, do you like
> 
> #define RTL8XXXU_HW_LED_BLINKING	2
> 
I'm not sure what you mean. Can you elaborate?

>>
>> In this patch none of the chips advertise having an LED. That will be
>> added in the next patches.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  8 +++++
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 34 +++++++++++++++++++
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> index 90268479d3ad..c8cee4a24755 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> @@ -1443,6 +1443,8 @@ struct rtl8xxxu_cfo_tracking {
>>  	u32 packet_count_pre;
>>  };
>>
>> +#define RTL8XXXU_HW_LED_CONTROL	2
>> +
>>  struct rtl8xxxu_priv {
>>  	struct ieee80211_hw *hw;
>>  	struct usb_device *udev;
>> @@ -1564,6 +1566,10 @@ struct rtl8xxxu_priv {
>>  	struct rtl8xxxu_ra_report ra_report;
>>  	struct rtl8xxxu_cfo_tracking cfo_tracking;
>>  	struct rtl8xxxu_ra_info ra_info;
>> +
>> +	bool led_registered;
>> +	char led_name[32];
>> +	struct led_classdev led_cdev;
>>  };
>>
>>  struct rtl8xxxu_rx_urb {
>> @@ -1613,6 +1619,8 @@ struct rtl8xxxu_fileops {
>>  			     u32 rts_rate);
>>  	void (*set_crystal_cap) (struct rtl8xxxu_priv *priv, u8 crystal_cap);
>>  	s8 (*cck_rssi) (struct rtl8xxxu_priv *priv, u8 cck_agc_rpt);
>> +	int (*led_classdev_brightness_set) (struct led_classdev *led_cdev,
>> +					    enum led_brightness brightness);
>>  	int writeN_block_size;
>>  	int rx_agg_buf_size;
>>  	char tx_desc_size;
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 35dc777c1fba..b27edd503c23 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -6955,6 +6955,34 @@ static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
>>  	return ret;
>>  }
>>
>> +static void rtl8xxxu_init_led(struct rtl8xxxu_priv *priv)
>> +{
>> +	struct led_classdev *led = &priv->led_cdev;
>> +
>> +	led->brightness_set_blocking = priv->fops->led_classdev_brightness_set;
>> +
>> +	snprintf(priv->led_name, sizeof(priv->led_name),
>> +		 "rtl8xxxu-usb%s", dev_name(&priv->udev->dev));
>> +	led->name = priv->led_name;
>> +	led->max_brightness = RTL8XXXU_HW_LED_CONTROL;
>> +
>> +	if (led_classdev_register(&priv->udev->dev, led))
>> +		return;
>> +
>> +	priv->led_registered = true;
>> +
>> +	led->brightness = led->max_brightness;
>> +	priv->fops->led_classdev_brightness_set(led, led->brightness);
>> +}
>> +
>> +static void rtl8xxxu_deinit_led(struct rtl8xxxu_priv *priv)
>> +{
>> +	struct led_classdev *led = &priv->led_cdev;
>> +
>> +	priv->fops->led_classdev_brightness_set(led, LED_OFF);
>> +	led_classdev_unregister(led);
>> +}
>> +
>>  static int rtl8xxxu_probe(struct usb_interface *interface,
>>  			  const struct usb_device_id *id)
>>  {
>> @@ -7135,6 +7163,9 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>>  		goto err_set_intfdata;
>>  	}
>>
>> +	if (priv->fops->led_classdev_brightness_set)
> 
> I prefer to move this checking statement into rtl8xxxu_init_led(). Then,
> the flow of rtl8xxxu_probe() looks clean. As well as rtl8xxxu_deinit_led().
> Just soft suggestion.
> 
Okay. That works too.

>> +		rtl8xxxu_init_led(priv);
>> +
>>  	return 0;
>>
>>  err_set_intfdata:
>> @@ -7159,6 +7190,9 @@ static void rtl8xxxu_disconnect(struct usb_interface *interface)
>>  	hw = usb_get_intfdata(interface);
>>  	priv = hw->priv;
>>
>> +	if (priv->led_registered)
>> +		rtl8xxxu_deinit_led(priv);
>> +
>>  	ieee80211_unregister_hw(hw);
>>
>>  	priv->fops->power_off(priv);
>> --
>> 2.38.0
>>
>> ------Please consider the environment before printing this e-mail.

