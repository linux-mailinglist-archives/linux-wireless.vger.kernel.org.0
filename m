Return-Path: <linux-wireless+bounces-6462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E48D8A8A2E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 19:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318901C21B84
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404E171657;
	Wed, 17 Apr 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYgKAmRb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD47171099
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374967; cv=none; b=aTgKQLiJGD3QzYF0Vmxk4UDolU/q3uE2w3MN9k+J49OV/ZLcD5NAd8zZsApXGJbkv9NbaBMHW9bIEhg0k/faziytFk/kdqtucFeeVmkZT252yU6H6Dj7RQEQ8neFdj0akeQke/XOKxtFituJcTcPl4DXWPR+Z7MtgIgphS4nFBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374967; c=relaxed/simple;
	bh=v8tDy/4yAUVu2IlNW8qGRdsTkYl3wnI8HGYtsN6hC+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdQnX4YGF7jjchP0WIWOk6ixDgn3tWxfiHunKetm5av0hkbfpuktf9BuF5h2VT3uE2wgnIIUQ7A/wyuN8rK5Qr9dX3whaoQKqp/lgwVX2lxlFN08TBjmWXmPb8Dy+utgWUz158RVeQfBMYCHkNxp1qIgINuY4i1Kr3QpirPHVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYgKAmRb; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so5206062a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713374963; x=1713979763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Mh1QuTaHfLsxhEJdgf+KYAyjWD7nnGf9n1i9P2Bbg8=;
        b=nYgKAmRb05L+Umjc06XZxdjrolsJ1JuKwZROlJeGVdPvr5cHN0gLAI9dFYnP4Ztt8l
         xzructWcQCLU1/3r/WN5ndzxU6LEriKnQVEC3GcvGCamXDIPorJeLTyr15Evjftwm6mD
         olGsK/8KzrxMtJsc2SlAg4XziKms0p4L80eyTDwUcCcuaD5riMgM4cA17PuRbjXmKiAd
         2WsQhE0KgGWVo0LmKo04j5+nnO72SE1dRv54vTq253DV/vqim6071Ry+Z8rvf4h2g4ro
         cIuAIUxKuWMyg6CUbp1hJqxy5/gyF+Cef1v7F8cQ3SwCNvQZybqTvD40XCqlBq5ntnsO
         UfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713374963; x=1713979763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mh1QuTaHfLsxhEJdgf+KYAyjWD7nnGf9n1i9P2Bbg8=;
        b=rsOGsx96wMTSDXSoXvflwSOl6jf7HEi11JKD8xAbXBGK1CbrSonRAA9Zgu0Ehu+4NJ
         44Y9jGLVlc95OkKv+pCiJRKLBV0M5XBgdYx/1zxOWb0eCpRjWRVBeRTOYMZdDZfhzwzV
         eEoDm0p0rNVV57CCc6dDUApJbxHbaCgioUtkj3wfbrSFaet6Dm5IEJ60opaiaWbJSKCQ
         IxNugfa1/bu2tUFZAT5Yb2HVHwC4vyYqgWQzjiiAft5My96XvKfbk9FZi9Q//nwE5blZ
         Fg3JrNzAGpqPv29+ma+M3jIEEQks76m+zAReR3aegMuswb4xsnXCVQkdgKp8gucwjnTG
         bmTg==
X-Forwarded-Encrypted: i=1; AJvYcCVoQH8kzmHJNRPD/PJsR7aXgnNxXbx95c9/jtyi6abTPeTkXbdj0UZy74GXX3mfIzl9oy0kcVdUuCZXoVQ7hTKW25DUzyquONPEpepxeno=
X-Gm-Message-State: AOJu0YzK/Q5vUfcJJ3xsdtTmWf4tNwRFVqGdwsN3tSN+83u5WPekh9mh
	K3p+F81KhlTp1QRa+cPHRxeHzo39FWpxx0cV8D6LN1dkrlqPoh6m
X-Google-Smtp-Source: AGHT+IFquOZ+uSG6OqiTG42UlOv/K6k5R7rVvznOxNIHe75EviZKGyRqiZL+tzk3jy+0Fdoiy+fJrQ==
X-Received: by 2002:a17:907:bb90:b0:a51:e5ac:7b7 with SMTP id xo16-20020a170907bb9000b00a51e5ac07b7mr84833ejc.71.1713374962447;
        Wed, 17 Apr 2024 10:29:22 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id gf14-20020a170906e20e00b00a51e6222200sm8376733ejb.156.2024.04.17.10.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 10:29:22 -0700 (PDT)
Message-ID: <fb3c2dcd-f9ea-434d-beaa-be3bdceb611e@gmail.com>
Date: Wed, 17 Apr 2024 20:29:20 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] wifi: rtlwifi: Adjust rtl8192d-common for USB
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
 <2d0d22e1-c4c5-46cb-8d54-63a4a16d22c6@gmail.com>
 <44aae72b9e2c441f9d667d98d0e779f6@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <44aae72b9e2c441f9d667d98d0e779f6@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 10:33, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> 
>> A few of the shared functions need small changes for the USB driver:
>>  - firmware loading
>>  - efuse reading
>>  - rate mask updating
>>  - rf register reading
>>  - initial gain for scanning
>>
>> Also, add a few macros to wifi.h, add some new members to struct
>> rtl_priv, and initialise rtlhal.interfaceindex for USB devices.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v5:
>>  - No change.
>>
>> v4:
>>  - Update the commit message.
>>  - Move _rtl92d_pci_lock and _rtl92d_pci_unlock to phy_common.h to
>>    silence a checkpatch warning.
>>  - Move rate_mask declaration higher (sorted by length).
>>  - Add some bit definitions to reg.h.
>>  - Add to struct rtl_priv the things shared by the two USB interfaces
>>    of a dual MAC RTL8192DU:
>>         u32 *curveindex_2g;
>>         u32 *curveindex_5g;
>>         struct mutex *mutex_for_power_on_off;
>>         struct mutex *mutex_for_hw_init;
>>
>> v3:
>>  - Silence sparse warnings about locks in phy_common.c by using helper
>>    functions _rtl92d_pci_lock() and _rtl92d_pci_unlock().
>>
>> v2:
>>  - Delete the macro IS_NORMAL_CHIP. It wasn't actually used.
>>  - Add RTL_USB_DELAY_FACTOR macro.
>>  - Use FEN_CPUEN macro.
>>  - Make params_pci and params_usb arrays static const, and make
>>    rtl_get_hwinfo() take a const pointer.
>>  - Put the rate mask, macid, etc. in a struct in
>>    rtl92de_update_hal_rate_mask().
>>  - Use sizeof(rtlpriv->rate_mask) in memcpy instead of hardcoded 5.
>>  - Rename temp variable to phy_ctrl.
>>  - Define _TXDMA_*_MAP and _HPQ, _LPQ, _PUBQ macros using GENMASK and
>>    remove the leading underscore.
>>  - Delete _NPQ macro because it's not very useful.
> 
> [...]
> 
> 
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
>> index 33b8ba363ca2..3d994238985f 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
>> @@ -25,6 +25,16 @@
>>  #define GET_FIRMWARE_HDR_SUB_VER(__fwhdr)              \
>>         le32_get_bits(*(__le32 *)((__fwhdr) + 4), GENMASK(23, 16))
>>
>> +#define RAID_MASK               GENMASK(31, 28)
>> +#define RATE_MASK_MASK          GENMASK(27, 0)
>> +#define SHORT_GI_MASK           BIT(5)
>> +#define MACID_MASK              GENMASK(4, 0)
>> +
>> +struct rtl92d_rate_mask_h2c {
>> +       __le32 rate_mask_and_raid;
>> +       u8 macid_and_short_gi;
>> +} __packed;
>> +
> 
> You asked me to drop a patch that looks very like this. Is this part correct?
> 

Yes, it is correct in rtl8192d-common. This is what rtl92d_fill_h2c_cmd()
expects. It was not correct in rtl8xxxu because rtl8xxxu_gen1_h2c_cmd()
expects something else.

> [...]
> 
>> @@ -2768,6 +2773,12 @@ struct rtl_priv {
>>          */
>>         bool use_new_trx_flow;
>>
>> +       /* For dual MAC RTL8192DU, things shared by the 2 USB interfaces */
>> +       u32 *curveindex_2g;
>> +       u32 *curveindex_5g;
>> +       struct mutex *mutex_for_power_on_off; /* for power on/off */
>> +       struct mutex *mutex_for_hw_init; /* for hardware init */
> 
> It would be better to introduce these locks along with consumers. Then, I will
> not miss to review them carefully.
> 

Okay, I will remove them from this patch set.

> By the way, I don't review remaining patches of v4 until this new (smaller)
> patchset gets merged. 
> 

That makes sense.

