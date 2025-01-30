Return-Path: <linux-wireless+bounces-18233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062EDA23690
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 22:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0F218813D1
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A4C1B87D9;
	Thu, 30 Jan 2025 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwMNEqnp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DED1AF0C8
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271781; cv=none; b=Q+ES5hnServcHl3p50jMddQMiLAbIX3Y5kEnOfn3zTNm/9IzWd5mObWEmP4z6AvDtvtU/8ZrFKv3kxl+4d1O/po9vx4eO3scx+aQ/Zh4SQ+dx3D3k9/Qdvge7HOh9/zGX3EskorSFkyVGXg2KUn6a8zEERX0NaKBZkUVqg/z7ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271781; c=relaxed/simple;
	bh=wfrqbY2yqdWuXJH46lkjgSAY+ZEYsUkC4h0aKDyx2xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VkmSjWT3nJa6SydBazZpYT+JkJJrpwUYc6N0ctqIumwsFYwvHk0Gxj5XAYxlCF93cpwcLahAcvDH9x+6KbJX7xiphU8HlJS/QtqbfvpqKW5T5EZYV3nbbNu0+yXBkmLnjCuluWX0jizOx2o/GWmakM/J6aZ55dV0TPR0w0blskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwMNEqnp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4362f61757fso13314975e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 13:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738271778; x=1738876578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/9FEaM22FKnFTH28lPqMVkRSRkhTnuTHOqDAzZsxP5o=;
        b=KwMNEqnpSEOhiBXQDiOuk6zNllSW/i7dz+uWm3SS8Fkrbc8roRU8jB8cx7QG9QA0eg
         kUErZ58F205JBXfPU2guAaJPeg8PsW0gGdSQ9kAuWrAE1bRGK7rGRt775afhmZwtjjR+
         SHFuvzWQCREHVBsTwi+Aabd5vhnzvmtyLJATvuTMos4wl8sbXpnEMgpdRnIkKRVYlafg
         CBAYxMd+TM4rTNmCkMVLprbHqc4VJucr7dXOFAcTs1RZbBFeTGzpPA0gZFTzevtGrPp/
         18ybDXybLBuoHJoaMeWTMBPy72nu5m+sp3uC/oKkBcnL0J7CNaiyENNGtgh4UcEwc33+
         7Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738271778; x=1738876578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9FEaM22FKnFTH28lPqMVkRSRkhTnuTHOqDAzZsxP5o=;
        b=IO5bPcZPiXo8jX6kipp6s2vvqoYTfeSA0SE3HLaVkIM0HafhjTnT77BsUC0knPIcqL
         Twh88AawMYDRoFEEUYz+goXsWjCEML0YNJv6BC9tsH89TiEZ/BEFOH1pEvLoEUQrfdE0
         xMu6KRofmkG0pxADfBgxEcWygYmlKwlmCTD/S9K7lQsthogGI5hLGh3U1O+dFJmCORS+
         eNTfReH8VT+UQGmnX0A6ZXD5wako7fnRPX/PbZePfR1vbZmYDxFtPsgGZCDsU3MDCAfm
         9rt0b7Iz75X8gLmYXqtO/PMyvOEuP7sAZaVmQwX5o5Jx6gTqcZCE5YrCpeC9l0EhEBSL
         Yoaw==
X-Forwarded-Encrypted: i=1; AJvYcCWaiLw2SP7ev1m7dFjj03wH0A4begE7yJbYohSFsuoj7Ep+2v45WBJpsKi54WXRq4XskgGHOiCR9a7jXp+rEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yjbDULD9aTVaAeySaKXnPwxrHNHdAL188bIDkU8ruqrSuHWV
	x2XAW6a1Iyud8YCXXgYwHaFWttgND1cMJvxhWfOqLd8e46C1DMF9sAmSAw==
X-Gm-Gg: ASbGncsS/ACaBsdOByQup1Jh7PrRE5mgSlJGnzjHgz3BgfG/WvrXANmGEhGGe5p/jvD
	69v/B8hqcUNxdeTR9qU3t14nsjctz8BkuwQ4f9BSKpaoB/bVI7rMCTrI9R/wLhXGd3Ey538U2YE
	xXx9Mx5rruEaS6Bxe1bfq79XmIbB8RJJA7PxbljqLVhTTn2WEEc2sGhLmt1MGRWS3SJAy5ZdX9z
	2kArfFFtiZbIlWxEAWKVl3VlFbAhQYfB0mNB3esPjXnWd11MwYqPCSVibPS+DIPAQ0eI/dn4xKy
	HdILVZTmR6RkkDKeME+6f585
X-Google-Smtp-Source: AGHT+IElgqROe1O+KmPoG/dsdM7aPIaKUA/KOmVLZy7iBFbSvaiS6AaxcjVBmdfftvOIR75Khqp72Q==
X-Received: by 2002:a05:600c:4fd3:b0:434:fe62:28c1 with SMTP id 5b1f17b1804b1-438dc3cbfd9mr75532795e9.18.1738271777946;
        Thu, 30 Jan 2025 13:16:17 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc12f28sm69990585e9.7.2025.01.30.13.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 13:16:17 -0800 (PST)
Message-ID: <7895ccb5-d057-4925-a7dc-0bb2db76b2c4@gmail.com>
Date: Thu, 30 Jan 2025 23:16:16 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for
 RTL8814AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
 <fa9ff2b4-6e1a-45e4-90de-db6fe0d4f433@gmail.com>
 <ca7380d8560046c4a2a2badde9302691@realtek.com>
 <d05ba9e5-d5e3-4761-bd1e-f7c2b63f5a36@gmail.com>
 <53740c9ec74a4aa0a5a3c51b895eb385@realtek.com>
 <d80fe4e2-1e38-4e84-b169-8c2699d7c764@gmail.com>
 <1f04331c713141c68e6892751611d01e@realtek.com>
 <86aae394-be5d-4fca-a68c-2ee02e5ab6af@gmail.com>
 <975cf4b88f43484e8411764fd72d8313@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <975cf4b88f43484e8411764fd72d8313@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2025 11:12, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 29/01/2025 04:43, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> On 28/01/2025 07:52, Ping-Ke Shih wrote:
>>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>> On 27/01/2025 08:36, Ping-Ke Shih wrote:
>>>>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>>>> The existing code is suitable for chips with up to 2 spatial streams.
>>>>>>>> Inform the firmware about the rates it's allowed to use when
>>>>>>>> transmitting 3 spatial streams.
>>>>>>>>
>>>>>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>>>>>> ---
>>>>>>>>  drivers/net/wireless/realtek/rtw88/fw.c | 14 ++++++++++++++
>>>>>>>>  drivers/net/wireless/realtek/rtw88/fw.h |  1 +
>>>>>>>>  2 files changed, 15 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>>>> index 02389b7c6876..0ca1b139110d 100644
>>>>>>>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>>>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>>>> @@ -735,6 +735,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
>>>>>>>>  {
>>>>>>>>         u8 h2c_pkt[H2C_PKT_SIZE] = {0};
>>>>>>>>         bool disable_pt = true;
>>>>>>>> +       u32 mask_hi;
>>>>>>>>
>>>>>>>>         SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
>>>>>>>>
>>>>>>>> @@ -755,6 +756,19 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
>>>>>>>>         si->init_ra_lv = 0;
>>>>>>>>
>>>>>>>>         rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
>>>>>>>> +
>>>>>>>> +       if (rtwdev->chip->rf_tbl[RF_PATH_C]) {
>>>>>>>
>>>>>>> Using `efuse->hw_cap.nss >= 3` would be consistent with latter patch.
>>>>>>>
>>>>>>
>>>>>> I would like that, but nss is 2 when RTL8814AU is in USB 2 mode.
>>>>>> I assume this is to keep the current draw under the 500 mA limit
>>>>>> of USB 2.
>>>>>>
>>>>>> What about rtwdev->hal.rf_path_num >= 3 ? I don't remember why
>>>>>> I didn't do that.
>>>>>
>>>>> I think `rtwdev->hal.rf_path_num >= 3` is suitable to initialize/configure
>>>>> hardware registers, because no matter USB 2 or 3 mode should be the same.
>>>>>
>>>>> For this case (RA info), this is related to protocol, so I feel
>>>>> `efuse->hw_cap.nss >= 3` is suitable, but I have not seen a patch to declare
>>>>> supported NSS in register_hw(), or I missed it? Or, without RA_INFO_HI,
>>>>> it gets abnormal rate to RTL8814AU in your test?
>>>>>
>>>>
>>>> You didn't miss it, that will be in part 3. You can see the code here:
>>>>
>>>> https://github.com/lwfinger/rtw88/blob/21a3fa7ec11a0cbb3be14145f45cdca35c3d3217/rtw8814a.c#L82
>>>>
>>>
>>> I feel we should clearly define the meaning. What I thought for 8814AU are:
>>>  - hal->rf_type: hardware capability. Should be RF_3T3R no matter USB 2 or 3.
>>>  - hal->antenna_tx: the antenna for current TX. Can be 2 antenna.
>>>  - hal->antenna_rx: the antenna for current RX. Can be 2 antenna.
>>>  - efuse->hw_cap.nss: read from efuse. So this will be 3SS for USB 2/3.
>>> If you have better defnitiion, please share your ideas.
>>>
>>
>> If efuse->hw_cap.nss is always 3, how to limit the spatial streams
>> to 2 in USB 2 mode?
> 
> That's a proposal only, because I felt `efuse->hw_cap.nss` read from efuse
> should be persistent, but it is fine to define desired meaning. 
> 
> I would like to confirm if USB devices will not switch USB 2/3 mode
> after USB probe? If so, `efuse->hw_cap.nss` is also a kind of persistent.
> Then, using `efuse->hw_cap.nss` seems fine. 
> 

Oh, yes, the switching is done only in the USB probe function.

