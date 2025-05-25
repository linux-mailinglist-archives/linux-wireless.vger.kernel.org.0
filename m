Return-Path: <linux-wireless+bounces-23393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E746AC3729
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 23:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300011893585
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AEE14A09C;
	Sun, 25 May 2025 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEitWhg2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA23FD4
	for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748210342; cv=none; b=liu/oIhn6Le3e7YnQpLxO/i5rf2/veB2EIxBGMVjEwrwQmBObRcHT8sn5Z6fR1kjI4ey0ZeP69p41fMAPpr554e7jI+wVEjOASISOdrnuS/iUO7FlxhmOxX1sQN7EDV4lwYIBOJ5KeD4swyVIG4in0mwAypZD80Nbl1YXJ8xhOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748210342; c=relaxed/simple;
	bh=4XD+6bPA7Luf3kvriXgOkRGwNlN03mQLe2xlpKs8wm8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=d/UhSmDKcTwDYKONn4a/yzQPKdGdb0/7/3crPOvB+u0SuTJFdPlxPxbDhu2NIjLuQR1AvWlOwEXKaFZGPhiYhOpJoxmqw5d/pFQUXS3scWNnlRaMVupMP03h4HP+j33GY1RwHKNjS7GxIeLBJ/YkuTnwbPHyOwn4HiNkMDodQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEitWhg2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-603fdd728ccso1944726a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 14:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748210339; x=1748815139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/q/bgTyU835PyY0/jYXW+/i7feieAk6IMrcMvWsZV7k=;
        b=iEitWhg2vgh5kn/X3HCFS2EC6SiYGN9VWltyHZ9gTAaTy7+DYZzGbJzsVr7aYfpUQ2
         67tdCZWzP/TJmP1kdE4uihR9PrbKA+jRAsp5i9Otq9EIwPo9FrkHwOn0/UUPF9WA6wT+
         vxUiAktOs6bHStgQzBSYFbvWgIrgO79z7WE33Seoh2D1jgCw28gyHeZMsjtww3GkPfh+
         2hFD55jRXiNwRpA2YnyZ8Wa8S739XNeG/w8m1w9gmiDuO81XbzXgQeVrfn+ySX6M/Kcd
         06NdSCnAQ+Q+fmuHWEY/sK0vSRC3Ua3ancP/GBXDy6OHYtlrpRtSCkl1MqTA9rpqcK4W
         BdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748210339; x=1748815139;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/q/bgTyU835PyY0/jYXW+/i7feieAk6IMrcMvWsZV7k=;
        b=D6WwH2UWg4QQH8bViWhIqiTiuXOUnHBjOZlSl2Zz9xmsqgs4Kh5CztnCl0X/Nw4huZ
         IIkPCksbBwIjMY+RxOSoENjx2oUXTSvEVWA4VYZsCd3tAurUxH/D6z10+MWG1pweP4cD
         Bqew9RnjxGnMxqXpvlnzKKkFzfoDPOtJLMVufvOhPDZwRO42FIdmdPIP+o8V/VfeAM+E
         Cfj/a987RZQ8/mHwHOBp5YokBaNqllMx6oVfSjAe1FES2x6PwfCerIxA1eJy8VlI/NYV
         D+EBkpoWVnNM/7dUCF/cUSDogfA2IJcy3w5xK+p/auW9QiPhFC2pAFxyNak53e1DpeMv
         0x0A==
X-Forwarded-Encrypted: i=1; AJvYcCW4xPQz1hjW2/eAfv3lbpmqH/j9KFZDQnBtia7jLjOwffr0fde0CxKcJitnXy89668BFzDFHKshpJ7RV9/7ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg51twMVN/Hl25d5LfWdjhpsCSugLHVFRTor5LceIULjHXs4HD
	U7xVnd5iYPr7NH5PutvR2UZoMDgBPFCAAnk4tZ+wi/JteIbDflSOY0FDl6ANlg==
X-Gm-Gg: ASbGnctwVZ9XpTrYu0KvlZOwlzDAfi5VJpZHOBoMN3JRoODRDKbrKj/RpMy4OhD2Bqv
	mYJBckUiKIEv+3pyac4Ih/79oRi18wp/9TfC8SQwBTYBCBO16tnojSgaMc6htZiGhJbfaoepy+T
	VDng7typL07Rm4rKsB9k5XeTsonTAI234Of4EZyQyOWWlFlLXZM3Tn60/wrEkPlIT3lHa9iefib
	iA6E8x1WP+7UiWSuv8jgOHFPa6vGVNIaetzV6QP9i2k0v1RDadTwEDQhasH4ezykmLwbzAwy6IN
	vQ+3gCWZFdzJKd2X78bF85LQVA5+iswGI+W5teMBBqYdXKrQLV7Nt8bX9sk=
X-Google-Smtp-Source: AGHT+IGjwmmKvXup0iAHG7KOXTpcQ1BTPz8lQOpQImeOVDqFNaWi0pZOuUkNV1F6e2kzOF6DRL1SnQ==
X-Received: by 2002:a05:6402:26c1:b0:5ff:addb:653e with SMTP id 4fb4d7f45d1cf-602da304c36mr5015603a12.23.1748210338985;
        Sun, 25 May 2025 14:58:58 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60453cd1abdsm2048851a12.69.2025.05.25.14.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 14:58:57 -0700 (PDT)
Message-ID: <2c6d27e3-49bf-4fe8-87ea-4cd9f5b1d4df@gmail.com>
Date: Mon, 26 May 2025 00:58:56 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v1 09/13] wifi: rtw89: Fix
 rtw89_mac_power_switch() for USB
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <3df912fb-3a56-40d7-940f-c82a23212adc@gmail.com>
 <87a865d6dfc647cd8e14118904cb5d07@realtek.com>
Content-Language: en-US
In-Reply-To: <87a865d6dfc647cd8e14118904cb5d07@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/05/2025 06:50, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Clear some bits in some registers in order to allow RTL8851BU to power
>> on. Also tested with RTL8832BU and RTL8832CU.
> 
> I see mac_pwr_on_pcie_8851b() and mac_pwr_on_usb_8851b() at least in
> vendor driver. If you use the power on/off functions for USB devices,
> the problem may disappear. 
> 

I modified rtw8851b_pwr_on_func() and rtw8851b_pwr_off_func() to match
mac_pwr_on_usb_8851b() and mac_pwr_off_usb_8851b(). It wasn't enough.
Without this patch the firmware upload still fails:

[ 1238.299960] rtw89_8851bu 1-2:1.2: Firmware version 0.29.41.3 (65cefb31), cmd version 0, type 5                                                                          
[ 1238.299970] rtw89_8851bu 1-2:1.2: Firmware version 0.29.41.3 (65cefb31), cmd version 0, type 3                                                                          
[ 1238.523187] Bluetooth: hci1: RTL: fw version 0x048ad230                                                                                                                 
[ 1238.607110] Bluetooth: hci1: AOSP extensions version v1.00                                                                                                              
[ 1238.622986] Bluetooth: MGMT ver 1.23                                                                                                                                    
[ 1388.109364] rtw89_8851bu 1-2:1.2: [ERR]H2C path ready                                                                                                                   
[ 1388.109751] rtw89_8851bu 1-2:1.2: [ERR]fwdl 0x1E0 = 0xc1                                                                                                                
[ 1388.110115] rtw89_8851bu 1-2:1.2: [ERR]fwdl 0x83F0 = 0x120090                                                                                                           
[ 1388.111615] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cd07                                                                                                               
[ 1388.111984] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cde5                                                                                                               
[ 1388.112358] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cd2b                                                                                                               
[ 1388.112740] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890ef05                                                                                                               
[ 1388.113110] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cd2b                                                                                                               
[ 1388.113510] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cce3                                                                                                               
[ 1388.113868] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cce3                                                                                                               
[ 1388.114234] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cded                         
[ 1388.114693] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cce3                                                                                                               
[ 1388.114986] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cce3                                                                                                               
[ 1388.115358] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cde9                                                                                                               
[ 1388.115735] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cce3                                                                                                               
[ 1388.116109] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cce3                                                                                                               
[ 1388.116480] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb89957b3                                                                                                               
[ 1388.116867] rtw89_8851bu 1-2:1.2: [ERR]fw PC = 0xb890cce3                                                                                                               

(By the way, 150 seconds is a long time and this is just the first batch
of error messages. There are at least two more like the above and each
takes another 150 seconds to appear. Things freeze:

[ 1475.693454] INFO: task systemd-journal:284 blocked for more than 122 seconds.
[ 1475.693750] INFO: task kded6:853 blocked for more than 122 seconds.
[ 1598.573772] INFO: task upowerd:1021 blocked for more than 122 seconds.

I haven't figured out how to fix this long delay yet.)

>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw89/mac.c | 8 ++++++++
>>  drivers/net/wireless/realtek/rtw89/reg.h | 1 +
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
>> index 99f01fff90fe..d3cf67dfabc9 100644
>> --- a/drivers/net/wireless/realtek/rtw89/mac.c
>> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
>> @@ -1458,6 +1458,14 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>>         int ret;
>>         u8 val;
>>
>> +       if (rtwdev->hci.type == RTW89_HCI_TYPE_USB &&
>> +           rtw89_read32_mask(rtwdev, R_AX_GPIO_MUXCFG, B_AX_BOOT_MODE)) {
> 
> Not prefer calling a function in if-statement. Suggest to add a function. 
> 

Do you mean add a variable?

	boot_mode = rtw89_read32_mask(rtwdev, R_AX_GPIO_MUXCFG, B_AX_BOOT_MODE);

	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB && boot_mode) {


>> +               rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFN_ONMAC);
>> +               rtw89_write32_clr(rtwdev, R_AX_SYS_STATUS1, B_AX_AUTO_WLPON);
>> +               rtw89_write32_clr(rtwdev, R_AX_GPIO_MUXCFG, B_AX_BOOT_MODE);
>> +               rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
>> +       }
>> +
>>         if (on) {
>>                 cfg_seq = chip->pwr_on_seq;
>>                 cfg_func = chip->ops->pwr_on_func;
> 


