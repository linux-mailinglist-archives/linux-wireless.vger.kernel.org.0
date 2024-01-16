Return-Path: <linux-wireless+bounces-1986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0A82F1AF
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 16:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993B52851FC
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADED1C684;
	Tue, 16 Jan 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn1KSv7n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88341C683
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-559b9664257so738151a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 07:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705419476; x=1706024276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkpI5ZlAya5lYIVyKdrXQpxTUC8WuzgWwc/JDdo0sCQ=;
        b=Qn1KSv7nSWjEqj6OWa6SCPcOZ45nl76tRNpYXbuGYFy5VXHqMS0wc8sFCTqCEbJUXj
         MDvwYX9FMJr3fDs/KsDr8u9M8bOvZouqaLj/Qrlo2ns2gKRpnIZaFPT20duTCvIw/4Tm
         FxRmQMByypCLkHvr4RK4Aiy6VKcUnsl25Bg2sQiDgaZ1pAdnsTmvsMpuaotS5apLEk9F
         kvLTvemQAz+rHvjY9xqD9qwMDJZMoNyufln+DQhx0PvIGVKmjUgMDapFb6WO+Ti9In4i
         KWW1uQuuQfkT34VV6MKYij+d0R1khHnqihizbAHSh6fEWMoT/7ECQGym5cjuvklXNfPs
         i4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705419476; x=1706024276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkpI5ZlAya5lYIVyKdrXQpxTUC8WuzgWwc/JDdo0sCQ=;
        b=h6kaoOMAB4xtC3UhZMM8tBfM2aUNzsJgAXMNR8jniuJEV4ZBj5kf6RfUJPCOrSPifj
         PxUtRVA7zU1feokqmceSLDc+bo2KHHwBGufLl9YQ2QEF8tpdlZKjmpF411O2ZUOul2L8
         0TRngJw5Um1bTkOYi41gB59fWhyNlHOg/Yx3THZxSiblgBQGlBP+WCkdTWQ+FulwJLfW
         K/EuTqoU+IDprVojtCZDB9WxqAG1O12q81RFP0yaUDaHiGuHsYoo6pkMB5Q3cZA255aN
         9kbTI7qDcYcodTr1FyzXLAmGTthHQd31XlVLrqqcOc8F8wmANkmRkMoX+iAVsexMzDYw
         fljA==
X-Gm-Message-State: AOJu0YyYBTyOigeLQ1DXJll2+ge1TewWlKfUqHXdXM0b1pqh9rHT0luk
	FXbLUHpqntqWhOf8kq/7zlE=
X-Google-Smtp-Source: AGHT+IHoA9RgcAdvyy/MAo7eoZcruAlt1L5LlF5QntMSsZhkm8P8ukwJFjhnjcy21iuw2PpS+ucJVA==
X-Received: by 2002:a17:906:b7c8:b0:a2c:572c:b5e7 with SMTP id fy8-20020a170906b7c800b00a2c572cb5e7mr3421891ejb.63.1705419475859;
        Tue, 16 Jan 2024 07:37:55 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id m27-20020a1709060d9b00b00a2c7d34157asm6305853eji.180.2024.01.16.07.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 07:37:55 -0800 (PST)
Message-ID: <78d5f49b-1c97-4a7a-b366-ddcb6c102f6b@gmail.com>
Date: Tue, 16 Jan 2024 17:37:53 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
References: <81b6c452-e940-423a-acf7-4a7b7c5e7847@gmail.com>
 <c369eeb8b3014f068d1c60b42b44e206@realtek.com>
 <d4fa544d-46fc-4795-8da1-5dd6199bdea9@gmail.com>
 <508550165dc24c3d932565d1adaf3766@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <508550165dc24c3d932565d1adaf3766@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 02:56, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Monday, January 15, 2024 8:51 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless@vger.kernel.org
>> Cc: Larry Finger <Larry.Finger@lwfinger.net>
>> Subject: Re: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
>>
>>
>> diff --git a/hal/rtl8192d_hal_init.c b/hal/rtl8192d_hal_init.c
>> index 156541b..175c856 100644
>> --- a/hal/rtl8192d_hal_init.c
>> +++ b/hal/rtl8192d_hal_init.c
>> @@ -1565,6 +1565,8 @@ hal_EfuseUpdateNormalChipVersion_92D(
>>         ReadEFuseByte(Adapter,EEPROME_CHIP_VERSION_L,&CutValue[0], _FALSE);
>>
>>         ChipValue= (CutValue[1]<<8)|CutValue[0];
>> +
>> +       pr_err("%s: EEPROME_CHIP_VERSION_H: %#x EEPROME_CHIP_VERSION_L: %#x CutValue[1]: %#x CutValue[0]:
>> %#x ChipValue: %#x\n", __func__, EEPROME_CHIP_VERSION_H, EEPROME_CHIP_VERSION_L, CutValue[1], CutValue[0],
>> ChipValue);
>>         switch(ChipValue){
>>                 case 0xAA55:
>>                         //ChipVer |= CHIP_92D_C_CUT;
>>
>> This is the output:
>>
>> Jan 15 14:35:21 ideapad2 kernel: hal_EfuseUpdateNormalChipVersion_92D: EEPROME_CHIP_VERSION_H: 0x3fe
>> EEPROME_CHIP_VERSION_L: 0x3ff CutValue[1]: 0x33 CutValue[0]: 0xcc ChipValue: 0x33cc
> 
> With the same branch and the same changes you mentioned, output is: 
> 
> hal_EfuseUpdateNormalChipVersion_92D: EEPROME_CHIP_VERSION_H: 0x3fe EEPROME_CHIP_VERSION_L: 0x3ff CutValue[1]: 0xcc CutValue[0]: 0x33 ChipValue: 0xcc33
> 
>>
>> Maybe my device really is a different version.
> 
> Not sure what happens. I feel no one can remember the definition of these values. 
> Maybe, we can just add an new value 0x33CC, and test if it works normal. 
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
> index 743ac6871bf4..c336d4b362f5 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
> @@ -1684,6 +1684,7 @@ static void _rtl92de_efuse_update_chip_version(struct ieee80211_hw *hw)
>                 rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "D-CUT!!!\n");
>                 break;
>         case 0xCC33:
> +       case 0x33CC:
>                 chipver |= CHIP_92D_E_CUT;
>                 rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "E-CUT!!!\n");
>                 break;
> 
> How did you find this weird value? Vendor driver doesn't work for you?
> 

It works fine. I just saw the message "Unkown CUT!" and got curious:
https://github.com/lwfinger/rtl8192du/issues/92#issuecomment-1155420291

If the addresses in the efuse are correct, then my device doesn't need
any patch. Unknown cut is treated the same as D cut, which is treated
the same as E cut.

> Ping-Ke
> 


