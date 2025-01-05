Return-Path: <linux-wireless+bounces-17087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72078A01AB7
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2025 18:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8ABA3A1B42
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2025 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C55211CA9;
	Sun,  5 Jan 2025 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KokNltwO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8962A920
	for <linux-wireless@vger.kernel.org>; Sun,  5 Jan 2025 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736096590; cv=none; b=nNdqja8N4doy/VCGnfxDvvZGtcvRoEvw54XuapcQQmSPeroQsNrHvWr9Hhhhvc5jOORo+MV97Wz/eFJy/cn9x3oUH+sHDX5NDW1RYbxlNreMH+DwCOTHzImFANSxQP+7a2gvHsS4z2aiPp485E1N6/0Omvs6QKsGRaBOe/gBkHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736096590; c=relaxed/simple;
	bh=mycG5so4P3kW/bgJOrZN50QaVKzeM9Fh0hAaK1Br6Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QR20dWcSidXhjLNNH5dAtbZcIoNuhO3vI2lNiCIo+J9B+OR1t/0+nq0OrQDQEJx2Oqv542Y2bz0jHmqXGhr0ruuBT48v2+oGzuHXCI/J+yb6wmGIGkeGsOFkdaXMvNQgUlo3Qbpd7Q8wDCB1Cm8/XdTK53XQWx+lGv880xqBSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KokNltwO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa67ac42819so1959337766b.0
        for <linux-wireless@vger.kernel.org>; Sun, 05 Jan 2025 09:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736096587; x=1736701387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdLMloHrp8HEzPqCTZjkdFJB8RYidavlCMgLxDyHHdY=;
        b=KokNltwOp1Qrha7g6TUJRembeU+1hIlm07i6iOgmF3nVz4g1Z0nDAbF4ThfOt0C6Ud
         abklCsmBYei2iX0g7DfAunUub3ZaOn1CAPJz5+EdvUtP0PL2sFsJHrGq7WcJ53RZFDTn
         qGNFDb2mo/nvDLvS0K7OZfauEyYrX0lhDsU8I6gFzqN3AfTlh63sb/5muLtnqyfdH9O2
         DQEaxQkQ3Y+/xs1eAbvbPry0CfFK9GSlUO0Cb6mEo/svPzEi+9cutRqEnbAWWWhDMFPM
         R3JP71I0LD4U0EpIoiLc2YsVRt0OG76OvJTreNLyPyDJTxV7gQIBdMRxBxo7lhiCE9t7
         WPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736096587; x=1736701387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdLMloHrp8HEzPqCTZjkdFJB8RYidavlCMgLxDyHHdY=;
        b=gJ59RglKp2PIL/2/ACdnBxw1riIQZUIVVnIrpFJmxF4dXtej4F4SCuFuKE1t8w8bnD
         QjHY1dTxU2vayf/CqLkmNlrP7RTbUn4n52hCjNVcsu4HQMgk5UCa27efVVJMZkiiwtOW
         ga1gI1u4hjwkJWGuOmo3JOxjOceuNyfFVoDGd9lp4x+AIDkt2FsE8Ms5r0NuMOCQ0Jm7
         AW/EmGsVlk+GQRECJLc8AsVY6uxbGYT3S9GzX/uGZId3xQ6fxR+8+fmhDFg7MYrVD6Cc
         LDF0QxIFL1WxLjSb9boDewx0ihtlM4FDjzieq1JMibOSoUZhrP3PSXvtZnpQmzIXuXIb
         fOWA==
X-Forwarded-Encrypted: i=1; AJvYcCW9TVG2YH2+1PJjoH53blTgfure7p1+T/zTse5avzFZRexVmPCPqdgoli5n3Gfzo8lmIyb1zP8VyRIFMysUeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzskL7kdKvoCWO6SoC7LYHI2paTO2s7wnWRYKwATYrPPrPhJrOD
	pmhDoJawK+AJ7mfXjzn+4MLJMHZHgPYoZeSuMKJw/J2eOS6HJ5HDs1H1qw==
X-Gm-Gg: ASbGncvBjVWCKIrOyJjj8OvraGTLhAX5/10Zr1IpZhu28TmWRIESzrHa+Hoi+kjSXQ9
	/YGT4SWB5D7AqCMLx0s6Lb9EnPFNZDM1KOp94Ulx+s2P31yK1lHooc5+JrFEN5J4GH0i0XAmrux
	d671IjfQJgn6eRCVVEjYrNDh63cYaCRlBpiJb8W8FKat1Z6NVl5ggq6wi9zn7hRZOLD7nrajSbR
	rwZeTMwcOfwUb6ot5Y2yHqIbkt+zLrtT8PbpAmG3qYGgJTtiYFLoFFwNaV83YgD
X-Google-Smtp-Source: AGHT+IFV5bkp+5SdCADxw5+xy2H5A1fuRXwXG7Wv9rYch//UthiV7st/pgSb7pzWZLlE3J59YjFqGw==
X-Received: by 2002:a17:906:7314:b0:aa6:8cbc:8d15 with SMTP id a640c23a62f3a-aac2ad9e06emr4651296266b.14.1736096586591;
        Sun, 05 Jan 2025 09:03:06 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f015b3csm2142868566b.161.2025.01.05.09.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2025 09:03:06 -0800 (PST)
Message-ID: <7fa4233a-89e4-4ea1-bd0a-ddcce2053686@gmail.com>
Date: Sun, 5 Jan 2025 19:03:04 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: Add support for LED blinking
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <1dfa20d1-5fee-4e75-a2db-a59d723babe2@gmail.com>
 <487122e41b4c43bd83e2df54ef16f399@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <487122e41b4c43bd83e2df54ef16f399@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/01/2025 03:48, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Register a struct led_classdev with the kernel's LED subsystem and
>> create a throughput-based trigger for it. Then mac80211 makes the LED
>> blink.
>>
>> Tested with Tenda U12 (RTL8812AU), Tenda U9 (RTL8811CU), TP-Link Archer
>> T2U Nano (RTL8811AU), TP-Link Archer T3U Plus (RTL8812BU), Edimax
>> EW-7611UCB (RTL8821AU), LM842 (RTL8822CU).
>>
>> Also tested with devices which don't have LEDs: the laptop's internal
>> RTL8822CE and a no-name RTL8723DU.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/main.c     | 91 ++++++++++++++++++-
>>  drivers/net/wireless/realtek/rtw88/main.h     |  9 ++
>>  drivers/net/wireless/realtek/rtw88/reg.h      | 12 +++
>>  drivers/net/wireless/realtek/rtw88/rtw8812a.c | 23 +++++
>>  drivers/net/wireless/realtek/rtw88/rtw8821a.c | 32 +++++++
>>  drivers/net/wireless/realtek/rtw88/rtw8821c.c | 25 +++++
>>  drivers/net/wireless/realtek/rtw88/rtw8822b.c | 25 +++++
>>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 25 +++++
>>  8 files changed, 240 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
>> index 6993f93c8f06..387940839f8b 100644
>> --- a/drivers/net/wireless/realtek/rtw88/main.c
>> +++ b/drivers/net/wireless/realtek/rtw88/main.c
>> @@ -2221,6 +2221,86 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
>>  }
>>  EXPORT_SYMBOL(rtw_core_deinit);
>>
>> +#ifdef CONFIG_LEDS_CLASS
> 
> Not prefer to have #ifdef in code. Please add a led.c and add an entry
>   obj-$(CONFIG_LEDS_CLASS) += led.c 
> to Makefile. 
> 
> Since you enclose whole functions, it looks not a big problem for this case.
> But I still want to avoid using of #ifdef to prevent people imitate this wrongly. 
> 
>> +
>> +static int rtw_led_set_blocking(struct led_classdev *led,
>> +                               enum led_brightness brightness)
>> +{
>> +       struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
>> +
>> +       rtwdev->chip->ops->led_set(led, brightness);
>> +
>> +       return 0;
>> +}
>> +
>> +static void rtw_led_init(struct rtw_dev *rtwdev)
>> +{
>> +       static const struct ieee80211_tpt_blink rtw_tpt_blink[] = {
>> +               { .throughput = 0 * 1024, .blink_time = 334 },
>> +               { .throughput = 1 * 1024, .blink_time = 260 },
>> +               { .throughput = 5 * 1024, .blink_time = 220 },
>> +               { .throughput = 10 * 1024, .blink_time = 190 },
>> +               { .throughput = 20 * 1024, .blink_time = 170 },
>> +               { .throughput = 50 * 1024, .blink_time = 150 },
>> +               { .throughput = 70 * 1024, .blink_time = 130 },
>> +               { .throughput = 100 * 1024, .blink_time = 110 },
>> +               { .throughput = 200 * 1024, .blink_time = 80 },
>> +               { .throughput = 300 * 1024, .blink_time = 50 },
>> +       };
>> +       struct led_classdev *led = &rtwdev->led_cdev;
>> +       int err;
>> +
>> +       if (!rtwdev->chip->ops->led_set)
>> +               return;
>> +
>> +       if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB)
>> +               led->brightness_set_blocking = rtw_led_set_blocking;
>> +       else
>> +               led->brightness_set = rtwdev->chip->ops->led_set;
>> +
>> +       snprintf(rtwdev->led_name, sizeof(rtwdev->led_name),
>> +                "rtw88-%s", dev_name(rtwdev->dev));
>> +
>> +       led->name = rtwdev->led_name;
>> +       led->max_brightness = LED_ON;
>> +       led->default_trigger =
>> +               ieee80211_create_tpt_led_trigger(rtwdev->hw,
>> +                                                IEEE80211_TPT_LEDTRIG_FL_RADIO,
>> +                                                rtw_tpt_blink,
>> +                                                ARRAY_SIZE(rtw_tpt_blink));
>> +
>> +       err = led_classdev_register(rtwdev->dev, led);
>> +       if (err) {
>> +               rtw_warn(rtwdev, "Failed to register the LED, error %d\n", err);
>> +               return;
>> +       }
>> +
>> +       rtwdev->led_registered = true;
>> +}
>> +
>> +static void rtw_led_deinit(struct rtw_dev *rtwdev)
>> +{
>> +       struct led_classdev *led = &rtwdev->led_cdev;
>> +
>> +       if (!rtwdev->led_registered)
>> +               return;
>> +
>> +       rtwdev->chip->ops->led_set(led, LED_OFF);
>> +       led_classdev_unregister(led);
>> +}
>> +
>> +#else
>> +
>> +static void rtw_led_init(struct rtw_dev *rtwdev)
>> +{
>> +}
>> +
>> +static void rtw_led_deinit(struct rtw_dev *rtwdev)
>> +{
>> +}
>> +
>> +#endif
>> +
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
>> b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
>> index 21795286a1a0..e16ba8d8a792 100644
>> --- a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
>> @@ -868,6 +868,26 @@ static void rtw8812a_pwr_track(struct rtw_dev *rtwdev)
>>         dm_info->pwr_trk_triggered = false;
>>  }
>>
>> +#ifdef CONFIG_LEDS_CLASS
>> +
>> +static void rtw8812a_led_set(struct led_classdev *led,
>> +                            enum led_brightness brightness)
>> +{
>> +       struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
>> +       u8 ledcfg;
>> +
>> +       ledcfg = rtw_read8(rtwdev, REG_LED_CFG);
>> +       ledcfg &= BIT(6) | BIT(4);
>> +       ledcfg |= BIT(5);
>> +
>> +       if (brightness == LED_OFF)
>> +               ledcfg |= BIT(3);
>> +
>> +       rtw_write8(rtwdev, REG_LED_CFG, ledcfg);
>> +}
>> +
>> +#endif
>> +
>>  static void rtw8812a_fill_txdesc_checksum(struct rtw_dev *rtwdev,
>>                                           struct rtw_tx_pkt_info *pkt_info,
>>                                           u8 *txdesc)
>> @@ -916,6 +936,9 @@ static const struct rtw_chip_ops rtw8812a_ops = {
>>         .config_bfee            = NULL,
>>         .set_gid_table          = NULL,
>>         .cfg_csi_rate           = NULL,
>> +#ifdef CONFIG_LEDS_CLASS
>> +       .led_set                = rtw8812a_led_set,
>> +#endif
> 
> Just build the code without checking CONFIG_LEDS_CLASS.
> It will waste some space, but acceptable. 
> 
>             before  after   delta
> rtw8812a.o  15619   15771   152
> rtw8821a.o  12922   13186   264
> rtw8821c.o  18890   19034   144
> rtw8822b.o  24860   25004   144
> rtw8822c.o  65963   66155   192
> 
> Also I'm thinking if we can move rtw8812a_led_set to led.c as well. However,
> it looks very different from chip to chip. 
> 
> 

Yes, and RTL8814A will add one more unique led_set function.

