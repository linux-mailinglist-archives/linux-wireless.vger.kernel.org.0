Return-Path: <linux-wireless+bounces-25937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4F9B0F0FE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 13:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1F31652A6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 11:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A926283FE9;
	Wed, 23 Jul 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBJcVJSC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A328D8FF
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269293; cv=none; b=Fsyz+y2OfIiwtM9RuAXATDBv34LST3qAYsnV8Yqk00SXG/528cy8F/4mAzbLkq4VpUUDePE7/5pFSX0NZqYr+/ACOiOKhgaxMI4IiRiAnxTqMCAuITYM2qQg/QhuN/uk8UXCGvaJDNxbym/SEMXG3lWNQqHacRciiu9ucG9kUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269293; c=relaxed/simple;
	bh=062CGusiFuKOECyZ6s7vcxIce4KCPaAgoogi3KJXq/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+vI4JTW73iTNWFz8LUCTKqBBUI3uSD4vOZaj3yHmV/LdobSf5UGZD7uJo8iSwYkHOzn5zArzvJOKVN7bCvtvAbaDKCRlF9fD5tOszy/31+pP1VrEBsnFJ1c8yfTxRRwN6vVLN8xlQnOwyMhV0jGK2wwVnayxBMKEFGkRdr6QCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBJcVJSC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so10196996a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 04:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753269290; x=1753874090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4u3PQHOYq4Nd5NqOcXQOWshGA0oh4aHr+INQjfQL+M=;
        b=hBJcVJSCBnGNGH9ftaJCUXfwYQCkWMP++R7gMcBiyG+WK10Hb13WTumP8IFJBIvs3y
         BvsdLmuqfe91k571NHpIvG84G4Hk3RCNhLls0H49A4RFOI5XmAWBVgz4XlIJG+6Iag5K
         W3t88NwbWg2hWQLkVO/BXckf9Ol74Yvy/xdLfHNGI+fU902DSR6i2MHigei8vX1coBJ4
         UzGqyspGPtN9+TmDRWnavnik5ed3aFoBoPB3Pg0F7KFapF+6RZF/ww1O6xToyV9RAcL4
         smM3WxUi25+rECkWFcVBtqZ97Mwt/3fbCZru7gN3bUJ5eLYFR3Ohngq+Qye9ydNVJ8gi
         yFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269290; x=1753874090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4u3PQHOYq4Nd5NqOcXQOWshGA0oh4aHr+INQjfQL+M=;
        b=EDTzi73WgXSFmaPUE6K9s2lGSxNdJkQvBidgqHcEHtAiikezOD+G6xTMca/psLrC2R
         yAa3l76T2+U8qDdgbJBjq6r137Jyf0ydmr8z76jib1YIB0hOSR5kpid9p6p/XRIQmesO
         qWco8lUKF8apa+UBAuk4lgE38nkrKRYEHCUASWzhvnXSf9YJL3Jar9p/EYrxHsNiIEjW
         lgcrE7rf/5x5L2pcVPdzwOa7RaHlfCbk/HtWHNM25H33+AXCMsGCPHsgnqVLJ1cfx7WT
         huK2APncVDn0fAKo16OimBvSx7NJElKAJ7gu1ILFV0ySlxttynZUAsLRSgjF2ALcd1E/
         wpzg==
X-Gm-Message-State: AOJu0YwP5X7Wt5zkzG57Umx+qz8GNy6vfBURQvBGPIIgj4dABEekyULO
	rJqdffc1JM4wapychLRA6wJj3uh3nqgC0tFtqHbGUks/1+q1wI2kkew4
X-Gm-Gg: ASbGncvhGxM36UJZVGpz8b/eAEgC/MyBX65EqOkJxkUjLybvon4ZU7Dw57qZbeyEAKb
	NC0eZ4piKWk3eVQaoQxOZ6lZRSMGmU7qK5vzUIsHofcOXhGOsijLH/X8qMKnKrjPkzSCXz3mfBR
	rPkt45PQCaQzAzQVlY9gVyL0wsQgT9UqZY9luHhu+7rI0rdBvBKnzDUG2R7RsOfSKw+z0AYfu8h
	/zYetxUmYVzIb3LH36qfVdjPYxS0zbyfhgH3IY2IBZp/dFvTW08eHoajgZ1lY2XLTqw3iK/JBPt
	8esW9yCu8xTFwWugerNmq9qmlK+a1UbUa1iSecOgmvMGV5xJL8CkJnXb/wpoPqYl9+GVKW5sn3t
	H40gLjJEWDgdDXB+rifPL6TIwwNZHuA==
X-Google-Smtp-Source: AGHT+IFyh5z0gobnLm/KpoXF/yLMz6zpbIMLgH2QL+jJz8BQ5AGAKMf6LOQg3DiRPW6SdyzhANF8Pw==
X-Received: by 2002:a50:d60c:0:b0:60c:52aa:d685 with SMTP id 4fb4d7f45d1cf-6149b5a2d58mr1661133a12.28.1753269289256;
        Wed, 23 Jul 2025 04:14:49 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c903fd6esm8418765a12.45.2025.07.23.04.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 04:14:48 -0700 (PDT)
Message-ID: <7dfa0377-538f-464b-b4e4-4c9daa1fb85a@gmail.com>
Date: Wed, 23 Jul 2025 14:14:47 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf
 path'
To: Ping-Ke Shih <pkshih@realtek.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
 <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
 <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
 <b29df36b838049a088d8298220078134@realtek.com>
 <5CA196F3-90B4-479F-9A19-E9C71C8726D4@gmail.com>
 <34d9c169c92540caa294095d2172b4fc@realtek.com>
 <18989932-3578-4E45-BA8B-6C2C76FDE7FE@gmail.com>
 <ed867462c8d945b28b2e913d1cd0c3d5@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <ed867462c8d945b28b2e913d1cd0c3d5@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/07/2025 12:07, Ping-Ke Shih wrote:
> Piotr Oniszczuk <piotr.oniszczuk@gmail.com> wrote:
>>> Wiadomość napisana przez Ping-Ke Shih <pkshih@realtek.com> w dniu 23 lip 2025, o godz. 10:19:
>>>
>>> working state:
>>>   rtw88: rtw_chip_parameter_setup:1859 hal->chip_version=0x493d30ea
>>> non-working state:
>>>   rtw88: rtw_chip_parameter_setup:1859 hal->chip_version=0x303030ea
>>>
>>> I'd try to read more times to see if it can become correct...
>>> Also, I force to use correct value at the last iteration to see if it
>>> can work even incorrect value of register 0xF0.
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
>>> index fa0ed39cb199..137418d1108d 100644
>>> --- a/drivers/net/wireless/realtek/rtw88/main.c
>>> +++ b/drivers/net/wireless/realtek/rtw88/main.c
>>> @@ -1858,9 +1861,14 @@ static int rtw_chip_parameter_setup(struct rtw_dev *rtwdev)
>>>                return -EINVAL;
>>>        }
>>>
>>> -       hal->chip_version = rtw_read32(rtwdev, REG_SYS_CFG1);
>>> +       for (int i = 0; i < 20; i++) {
>>> +       hal->chip_version = i == 19 ? 0x493d30ea : rtw_read32(rtwdev, REG_SYS_CFG1);
>>>        hal->cut_version = BIT_GET_CHIP_VER(hal->chip_version);
>>>        hal->mp_chip = (hal->chip_version & BIT_RTL_ID) ? 0 : 1;
>>> +       printk("rtw88: %s:%d hal->chip_version=0x%x\n",
>>> +               __func__, __LINE__, hal->chip_version);
>>> +       mdelay(100);
>>> +       }
>>>        if (hal->chip_version & BIT_RF_TYPE_ID) {
>>>                hal->rf_type = RF_2T2R;
>>>                hal->rf_path_num = 2;
>>>
>>>
>>
>> well - with above patch all starts to work well :-)
>> 10 boots, 10 working wifi with correct scans.
> 
> Good.
> 
>>
>> demsg from working sys: https://termbin.com/bhs4
> 
> Unfortunately, the log said:
> first read:
>   rtw88: rtw_chip_parameter_setup:1860 hal->chip_version=0x303030ea
> 2nd~19th read:
>   rtw88: rtw_chip_parameter_setup:1860 hal->chip_version=0x30303030
> 
> Not sure if I can use this pattern to make a workaround. I think the better
> way would be to use firmware report to fix this. I'll try to make a patch
> and get back to you soon.
> 
> 

Maybe there is a mistake in rtw_sdio_read32() ? It's pretty complicated.
The equivalent function in the vendor driver is reg_r32_sdio_8822c().
I think for reading REG_SYS_CFG1 in rtw_chip_parameter_setup() it needs
to do the indirect read in the snippet below:

u32
reg_r32_sdio_8822c(struct halmac_adapter *adapter, u32 offset)
{
	enum halmac_ret_status status = HALMAC_RET_SUCCESS;
	union {
		__le32 dword;
		u8 byte[4];
	} value32 = { 0x00000000 };

	if (((offset & 0xFFFF0000) == 0) &&
	    adapter->halmac_state.mac_pwr == HALMAC_MAC_POWER_OFF) {
		return r_indir_sdio_88xx(adapter, offset, HALMAC_IO_DWORD);


But the conditions for doing an indirect read in rtw_sdio_read32() are
a bit different.

You can add this message to check:

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index d26bc8a5c2e8..f8f055b6e884 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -314,6 +314,9 @@ static u32 rtw_sdio_read32(struct rtw_dev *rtwdev, u32 addr)
 	addr = rtw_sdio_to_io_address(rtwdev, addr, direct);
 	bus_claim = rtw_sdio_bus_claim_needed(rtwsdio);
 
+	if (addr == REG_SYS_CFG1)
+		printk("%s: addr %#x direct %d\n", __func__, addr, direct);
+
 	if (bus_claim)
 		sdio_claim_host(rtwsdio->sdio_func);


