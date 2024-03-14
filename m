Return-Path: <linux-wireless+bounces-4748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ACD87BDFF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 14:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8821F2196D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB665B5DD;
	Thu, 14 Mar 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMXNJddk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FCF6F086
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424189; cv=none; b=WuqaRr8y/C6+Ze0Sxji4W6JPqZ3R1vYpix/tNV4HJcvm57IyN27QW9M8syNTeHwkrGnrgpeNZJQEXxeYbVkqLRjQ6/+jG3UA/uPKxmKTB8rUuXVxx5qPJ4eo7pJM+a4RgzS7xz77Wetf0Bo+uEEqeL9eIoso6m3BLbScrfKM1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424189; c=relaxed/simple;
	bh=Zz6SnVk9tgMQBvLB4IZv3fQB4v5VNvwEdjL4+jC3b80=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pHPV22MgvYfOgDuoYiz2A21sI+9ZcngRWmc51JQwmCYr63cNr8UNuUPfhdF4nDX+nuFbbuVbzEkxtMAHsVChnKTJAWsl7jMkzxZICGfAuF90oroCoznuRDlgT25yLWNRRCBSgqwt9EIg+C0FqcSEiZfVsHgMhpmo9/VxKP2xAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMXNJddk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso105191266b.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710424186; x=1711028986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9zN6ds5gGFuNudCMx3gEXJO4VDtaDTzyuQb9NeUKPg8=;
        b=ZMXNJddkpDiXot04n6VBXBI8knHKcv9IZ91+Fm9dmaP7fOGAjULwh0zpD9gZYvbzyI
         XwgvdVf6jwx8WVFArA8CDIYdhKbAqxxB20buG1Yz0OGu+bJcyuJ6GB1fw2hSkeiImaQJ
         GQvwW0zuW6lRfUQ2uLSB1r8T5/X8lq+2LvpoHO+FkZpt0klveRiMVh6TsjYCTNVcUlOG
         pq+ZAyCB1quBzwIw0U1cUjJMYaRLHVoZDuxZNxAnpVpa8N5dT6YFgaMf33EAqgWqK7F2
         OtwoQi7F9H/R7iey494vPFy2kkd8JQrE74PsUToSjS49AzI8fXv3FoejEB2j1/jJmh2o
         opoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710424186; x=1711028986;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9zN6ds5gGFuNudCMx3gEXJO4VDtaDTzyuQb9NeUKPg8=;
        b=BxhZRgtQdbJRHc9Ab2X2iGX2AmtLkvWV9AY/bm/geCTFl7Ly7QsL5dUVapWrfA+gx3
         O0XZ9qHD1/RoFWdH+B8a8fGu/6MLzUIKer7kWaZIeFxr/jW6U/1/gbyKkg/uOyEjk2PF
         biAy+23n4CC6utJZmiaX6XfNTl02peqf2T+4vTlqMyXsB2mwqn4yvYTN0yP8IH6pzaqv
         ddvUKXk7OUVXW2Y/APku6C7cEKllnq9iBbT7GGtfPUVllfuUWXSpClhLoQs/9PRtCYeX
         ff2scCDQo8c+K1XKvAGgfGBtIglE5VZKmq/HFBCtF7j43q5xONK+gDfxUsxTfJVjbC4j
         IOXw==
X-Forwarded-Encrypted: i=1; AJvYcCW5ras7gmerR+LAtjENZ4lyUcY9498yNN071gMaxw+FzfBkVVRSBcn3i5zrS2TAgTaJFIX+CQSHIa/qEKVgLHfpu8qx1bbDILwlAdOYddM=
X-Gm-Message-State: AOJu0YyV56rcU7PTbx+7SIEI0RO/8uor9M+wTyyPCkgvTtKfJKKNusxS
	d1O0W63ixRAXWqV2xPlqk4ppRhiTyP66ipdUo4xG60RC4k1gx+At
X-Google-Smtp-Source: AGHT+IHOt7wUyYd8zHnEl3Y50jWlEl/eVIVBjZxcBqJeXRJO2/KhTY2W1jrKn8HMdiX7Krgo5OfVsA==
X-Received: by 2002:a17:907:c783:b0:a45:a7f8:1b6b with SMTP id tz3-20020a170907c78300b00a45a7f81b6bmr1548367ejc.46.1710424185847;
        Thu, 14 Mar 2024 06:49:45 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090619cb00b00a3ce60b003asm730923ejd.176.2024.03.14.06.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 06:49:45 -0700 (PDT)
Message-ID: <f734bd50-8a04-447b-b1e8-11eb6c958f34@gmail.com>
Date: Thu, 14 Mar 2024 15:49:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 2/3] wifi: rtlwifi: Adjust rtl8192d-common for USB
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
 <d70dc39c-a3e5-43f6-9cb4-612d08035c57@gmail.com>
 <fdd95844c3a127356bab4250dfc46b16041829ee.camel@realtek.com>
 <a674d357-c917-413a-a4fb-1ee22f43d9ff@gmail.com>
 <f07686170eed48c21f18ce2850ffde4401c25bf5.camel@realtek.com>
Content-Language: en-US
In-Reply-To: <f07686170eed48c21f18ce2850ffde4401c25bf5.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 03:20, Ping-Ke Shih wrote:
> On Thu, 2024-03-14 at 00:47 +0200, Bitterblue Smith wrote:
>>
>> On 13/03/2024 05:46, Ping-Ke Shih wrote:
>>> On Wed, 2024-03-13 at 00:20 +0200, Bitterblue Smith wrote:
>>>>
>>>> @@ -966,12 +980,17 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
>>>>                 break;
>>>>         }
>>>>
>>>> -       value[0] = (ratr_bitmap & 0x0fffffff) | (ratr_index << 28);
>>>> -       value[1] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
>>>> +       *(u32 *)&rate_mask = (ratr_bitmap & 0x0fffffff) |
>>>> +                                    (ratr_index << 28);
>>>
>>> 'u32' is weird to me. Shouldn't it be __le32?
>>> But I prefer a struct of rate_mask.
>>>
>>
>> I don't like this either, but it was easy to copy from rtl8192cu.
>>
>> Something like this?
>>
>> #define RAID_MASK               GENMASK(31, 28)
>> #define RATE_MASK_MASK          GENMASK(27, 0)
>> #define SHORT_GI_MASK           BIT(5)
>> #define MACID_MASK              GENMASK(4, 0)
>>
>> struct rtl92d_rate_mask {
>>         __le32 rate_mask_and_raid;
>>         u8 macid_and_short_gi;
>> } __packed;
> 
> Yes, something like that, but struct size should be 5.
> 
>>>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
>>>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
>>>> index 487628ac491b..1e39940a3ba7 100644
>>>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
>>>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
>>>> @@ -81,11 +81,13 @@ u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path
>>>> rfpath,
>>>>         rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
>>>>                 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
>>>>                 regaddr, rfpath, bitmask);
>>>> -       spin_lock(&rtlpriv->locks.rf_lock);
>>>> +       if (rtlpriv->rtlhal.interface == INTF_PCI)
>>>> +               spin_lock(&rtlpriv->locks.rf_lock);
>>>
>>> Does it mean USB never read/write RF registers simultaneously? How can you
>>> ensure that?
>>>
>>
>> I don't know. It seems to work fine. The out-of-tree driver
>> doesn't have locks here:
>> https://github.com/lwfinger/rtl8192du/blob/2c5450dd3783e1085f09a8c7a632318c7d0f1d39/hal/rtl8192d_phycfg.c#L637
>>
>> rtl8xxxu and rtl8192cu don't have locks either.
> 
> Not sure if race condition is existing to read/write RF registers, but
> no idea to dig the problem. Maybe, current code has no problem though.
> At least, your newly changes don't affect original PCI behavior, right?
> 

Yes, the PCI driver should behave like before.

> 
>>>> diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c
>>>> b/drivers/net/wireless/realtek/rtlwifi/usb.c
>>>> index 6e8c87a2fae4..2ea72d9e3957 100644
>>>> --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
>>>> +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
>>>> @@ -979,6 +979,9 @@ int rtl_usb_probe(struct usb_interface *intf,
>>>>         usb_priv->dev.intf = intf;
>>>>         usb_priv->dev.udev = udev;
>>>>         usb_set_intfdata(intf, hw);
>>>> +       /* For dual MAC RTL8192DU, which has two interfaces. */
>>>> +       rtlpriv->rtlhal.interfaceindex =
>>>> +               intf->altsetting[0].desc.bInterfaceNumber;
>>>
>>> So, you will see two USB adapters when you plug 8192DU?
>>>
>>
>> When you plug the dual MAC version, lsusb will show one device,
>> with two interfaces. rtl_usb_probe() is called twice. This is
>> copied from linux-hardware.org:
>>
>> Mine is the single MAC version:
>>
> 
> Does it mean you only tested single MAC version? But, your code will support
> two MAC version, right?
> 
> 

Theoretically all the code for dual MAC is there. But I only
tested the single MAC version, and Stefan also has the single
MAC version.

