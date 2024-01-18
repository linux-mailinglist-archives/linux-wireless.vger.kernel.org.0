Return-Path: <linux-wireless+bounces-2193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60417831D09
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 16:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FC51F221CA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 15:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040C228DA0;
	Thu, 18 Jan 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfZEE4pW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E5428DAB
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593391; cv=none; b=Pf5O0Q2bKhAyl6De9MFjBvtZYUV1uDi+yDrA1CAU/5x433pYRJs4EPXrTo+eDyxTmuMovCn2htyGLGd+2ndJkTsKcMnMzRrN3uCJH6z+NKUZekq71qpPLXI2HXR6AnhFw1wTuprfrKr7pvWu636obpjE6G/tqCWnx/g7BQVswvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593391; c=relaxed/simple;
	bh=ZWYQp0/LhJLAsiWoCjJd95828/CsH52TAgIVuGWJsL0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=pcYOb0sDz7WlvzhBb4ZFdJeuMjbp0meCfqoYkNQ16iXCdqSORO63XhZHmR52aNRN7spe7Rn3zVxZZetW9ZQdc8NhpGrvybmzIKiznv0v1FMa4qV1zMZGaFHaVi0gjCUagM/eGDzAr/wjV3UD1uvVvvGAJl4YfxmAybY9yCRDRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfZEE4pW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a34e08775so907811a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 07:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705593387; x=1706198187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgWrE5zngMChPwhdZqNrNnSDJ6F0mXRLEZGMGRQhaVQ=;
        b=SfZEE4pWNKqBK8IkdTlAVJfZUZf66k1C1rceUMu3DLXvgNvcsOhGKn5Ria8gNVdRGo
         gc9nJ7k53XSkE4aoqSlLX23Ch101WX6cpOoe8exHY4u8eZZfKBzwTQdpXd1uP121zCTy
         9xDt8PWQu593ylHhdfUzVU3ouNtcKGWwmsc+WbWdm4/MqVzWE6kk/J4pzUDdue8m8AIU
         KbBrKzAlX+mzwIvxGAxe0OrFHag5+siF37l9GvHEaS+jico0qTNaObLvuKhCSxZg2wUx
         K/hl1AEvCLLzUAq8MC3gICmlt19LJlnbo5NasphUZrrXNu1tz78YFV9ag5+F21vuKz8e
         Ubug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705593387; x=1706198187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgWrE5zngMChPwhdZqNrNnSDJ6F0mXRLEZGMGRQhaVQ=;
        b=TdYCaci4OSvevwFRizGW7dF/PEg2PjwJCl29Kq12+d1QqzdzkxZ0QlhHnVSyGnWtpj
         eGvoI0zLGG5SU16ij6G53hsYp8pG5wPqRoDEPSN3HQ2lBTNKfnvelGUoIJjDZ4jMKYQ6
         g7OcD8m0vm7zfB+aFelPia3debFWAtMhAbU+BR3DVGkSodMgJ2tJCHPwFHkQC020SUY7
         02azNlbHlVw10gT9blkKuxmy5XsCN0Wzu2nAlIWjCswSy1nmb4pObRwrAYei3fvgaTsf
         LYKY9zQdx6ZHTDHasFElxMCH5BSnjAkVcsOx9kA4N8Vrm6bTXbhyOtFg+r38YfIipgOK
         HAOg==
X-Gm-Message-State: AOJu0Yz/W3tz+pj6ZDVF8oMSwsPlrL5irJffFF0/4Tvo4hen+6fg8UGT
	vWPkjdKscTSkyv0qN1oKhzL4gtlYFlfIYec48qtT0uHoTLlC/loVv/qlg+Zp
X-Google-Smtp-Source: AGHT+IG4H4aapWO4Idz3IjlZC+tv+PVOj/L/B4jyrii+YGMZiLzyO5oKsewsNvWepgtAlKSftJE2hQ==
X-Received: by 2002:a17:906:dfd8:b0:a2d:b3f8:ef54 with SMTP id jt24-20020a170906dfd800b00a2db3f8ef54mr1270071ejc.40.1705593387286;
        Thu, 18 Jan 2024 07:56:27 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id l18-20020a17090612d200b00a28fd9607a8sm9211490ejb.81.2024.01.18.07.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 07:56:26 -0800 (PST)
Message-ID: <1314347a-a7a7-4021-bcd5-58ff7cfa0fba@gmail.com>
Date: Thu, 18 Jan 2024 17:56:25 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: rtlwifi: Speed up firmware loading for USB
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
References: <d9bd4949-6e92-4f35-8b60-3b45f9ad74ab@gmail.com>
 <69d5e71d354b48ef839fb3d3c47f09c7@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <69d5e71d354b48ef839fb3d3c47f09c7@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/01/2024 02:37, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Thursday, January 18, 2024 4:12 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Ping-Ke Shih <pkshih@realtek.com>; Larry Finger <Larry.Finger@lwfinger.net>
>> Subject: [PATCH v2] wifi: rtlwifi: Speed up firmware loading for USB
>>
>> Currently it takes almost 6 seconds to upload the firmware for RTL8192CU
>> (and 11 seconds for RTL8192DU). That's because the firmware is uploaded
>> one byte at a time.
>>
>> Also, after plugging the device, the firmware gets uploaded three times
>> before a connection to the AP is established.
>>
>> Maybe this is fine for most users, but when testing changes to the
>> driver it's really annoying to wait so long.
>>
>> Speed up the firmware upload by writing chunks of 64 bytes at a time.
>> This way it takes about 110 ms for RTL8192CU (and about 210 ms for
>> RTL8192DU).
>>
>> PCI devices could upload it in chunks of 4 bytes, but I don't have any
>> to test and commit 89d32c9071aa ("rtlwifi: Download firmware as bytes
>> rather than as dwords") decided otherwise anyway.
>>
>> Allocate memory for the firmware image with kmalloc instead of vzalloc
>> because this memory is passed directly to usb_control_msg(), which
>> can't take memory allocated by vmalloc.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
>> index 07a7e6fa46af..1fc480fe18ad 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
>> @@ -125,6 +125,14 @@ static void _usb_write32_sync(struct rtl_priv *rtlpriv, u32 addr, u32 val)
>>         _usb_write_sync(rtlpriv, addr, val, 4);
>>  }
>>
>> +static void _usb_write_chunk_sync(struct rtl_priv *rtlpriv, u32 addr,
>> +                                 u32 length, u8 *data)
>> +{
>> +       struct usb_device *udev = to_usb_device(rtlpriv->io.dev);
>> +
>> +       _usbctrl_vendorreq_sync(udev, REALTEK_USB_VENQT_WRITE, addr, data, length);
> 
> Just curious. Originally, it uses 1/2/4 as length for write8/16/32, and this
> patch additionally uses 8/64 as length. Any limitation of argument 'length' of
> this function? Is arbitrary number disallowed? 
> 

I didn't find anything in the usb_control_msg() documentation.
I only found this issue, where some people say 0xffff is fine,
but older hardware may have a limit of 4096:
https://github.com/libusb/libusb/issues/125

rtl8xxxu uses lengths of 32, 94, 124, 126, 128, 156, 254 bytes.
Some other Realtek wifi drivers use 196 bytes.

