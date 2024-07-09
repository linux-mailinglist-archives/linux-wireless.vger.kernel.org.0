Return-Path: <linux-wireless+bounces-10121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0004492B6A2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 13:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB259285104
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DB4158D8D;
	Tue,  9 Jul 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAdg3Rgp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2D158D72
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523719; cv=none; b=LArj6e1HilwNz4OpWZR2ZCyIDI1uI1l9LBtFZpQce8CCqLivclmmnolzAc8l3ZSj3Opjk2EYI57IjZlIGLn1Zn7Kqz/qV96KUzd+J5yhPTqcRrEp7KoqBsIq/VbcFnNkrTYAV3x8CKSGqBqDUyF+xaRCI5zl1tVlTvUc6QjO6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523719; c=relaxed/simple;
	bh=1Do8uaglhgDbs2cr17G2JbT3hhCGrs5YMW1kpjtejFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frjV+3/OWKu02XYnxMfyah5x4Fuwo9TwBJHu8pRmWzr4180E3zBbaTcAEO2fAZk8f0AwnVvCfyFV448flA/P8tRw4DBp9MSMzAK+Q18rQt8ENchduse6yL+pbJyzMMXdfmtdJr586kWKGFSuPOkj/W7nssbZaitORBE0IbKIqwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAdg3Rgp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso6774651a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2024 04:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720523716; x=1721128516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3jiWm7JyZA1sMFX6jdc8qVCWeZAcZ+Hmp1mzjCIo8c=;
        b=bAdg3RgpSsu9ari21jmIP2y5cd03+0/4NjoegNiPZ6kVFPcZ0BP7TXmJMSReJVz6Wx
         sFVoisDk0C3a6F9xyEb97LIwPXnT1lE3hve2SCJmougPOV+QVQWx6e3uhdAPf/jf8Eh8
         YrDrR11gU11dMrZTJYQVN5LcSid+mNH8XkvowyQp7p0PGiHHzHBWrbL1TAsVa26w70mI
         1HNqpktEt2/Fq2m0iiMjJUlPnh7uEqiezxH+wIu7oKaywMCTieUKgxC8JWgY4NGFYlfg
         deX3ZNqLh1TZmDS4/Hmfq6IjOVrzjvVxM3OP5cRb+GLyPb04M4EiiUKcKRzmd5TCL5qr
         7v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523716; x=1721128516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3jiWm7JyZA1sMFX6jdc8qVCWeZAcZ+Hmp1mzjCIo8c=;
        b=gQ52D7BVbT97fjsv6PLNLk/wi5x0sDx5Wxq4FVp8RhZ+XGG4+OVPbtelwweqAPPiOL
         WpHG1EEJU5vS5giivfOSjRCyFlTQU1nEOpbj+8hyQVyA7r1bOIAWgNCtJPnenUVrDXSG
         lyakNpRvrpbjAd4dn6JmFKMiZELqTbIAMEiD60yR3DweO5ShNpX6CFF1Ox5BMtCshdVk
         qgnxT0I7KminL5BMHWzJMABuAUXQpJ7DW9CCk4/33IIYfdknG8BP19UK5c6AYomByAwS
         pqk81LBxGN/Hs584W+pmY3JKGJeFtW5BjdOWrRS9O1qs7sEuP84NGe9S7Glo/iq88KwM
         RMlA==
X-Forwarded-Encrypted: i=1; AJvYcCX+0KNhKISv5fPZy6R0zrhUH1b3dimITcEIZwFP0OObSuOzi+6R2ch7iFEX2pOSqoY3T0vtHTWkmvxF6Sv0aeH+Dx35h/OctXaL5sTW/jw=
X-Gm-Message-State: AOJu0Yz5N1E4+VdtsX5PeohpaBs5HTgOKGifusWFeDVIoY2uxu1yOSBp
	vOZHq3bCv8ZE1kV8X84Jr+ID0KFxEkZGQhbpofLYlfve8B+1RQWm
X-Google-Smtp-Source: AGHT+IHcVW3I3y3NXgLcGEbjNCdgyIsiiDsU7aOCOzt8xvCPjb0wfGaavL8xdAF/RMO/6Iv5p0snDg==
X-Received: by 2002:a05:6402:c03:b0:58d:10a0:36e2 with SMTP id 4fb4d7f45d1cf-594bb580676mr1254945a12.20.1720523716411;
        Tue, 09 Jul 2024 04:15:16 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd459ae5sm937956a12.74.2024.07.09.04.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 04:15:16 -0700 (PDT)
Message-ID: <d75cd47e-2619-4bb5-857d-0814e1c2cd1a@gmail.com>
Date: Tue, 9 Jul 2024 14:15:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
References: <2378105e-041a-4973-937f-e3efdc9ce0e8@gmail.com>
 <a60a7a6d0ab04b3ab1690a2c473b8e69@realtek.com>
 <3f2900e7-9a98-4bc9-bc0d-631dd9de7da0@gmail.com>
 <57eec7c0f23b40059840086066ed74be@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <57eec7c0f23b40059840086066ed74be@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2024 03:55, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 08/07/2024 12:19, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> @@ -896,6 +972,14 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>>>>                 goto err_destroy_rxwq;
>>>>         }
>>>>
>>>> +       ret = rtw_usb_switch_mode(rtwdev);
>>>> +       if (ret) {
>>>> +               /* Not a fail, but we do need to skip rtw_register_hw. */
>>>> +               rtw_info(rtwdev, "switching to USB 3 mode\n");
>>>
>>> All logs in this patches should be rtw_dbg(), because these messages are not
>>> important to users.
>>>
>>
>> Okay, I will add RTW_DBG_USB to enum rtw_debug_mask.
>>
>>>
>>>> +               ret = 0;
> 
> I missed this point "ret = 0" that rtw_usb_disconnect() will be called when
> USB disconnect. Can't we just return an error code? any negative effect?
> 
> My point is to avoid calling rtw_usb_disconnect() for the case of switching
> USB 3, because all stuffs have been freed by following error handles. 
> 

If we return an error code instead of 0, it still switches
to USB 3, but we get an error message:

Jul 09 13:47:54 ideapad2 kernel: rtw_8812au 1-4:1.0: probe with driver rtw_8812au failed with error 1                                                                      

>>>> +               goto err_destroy_rxwq;
>>>> +       }
>>>> +
>>>>         ret = rtw_register_hw(rtwdev, rtwdev->hw);
>>>>         if (ret) {
>>>>                 rtw_err(rtwdev, "failed to register hw\n");
>>>> --
>>>> 2.45.1
>>>
> 


