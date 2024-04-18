Return-Path: <linux-wireless+bounces-6521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA738A98D3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 13:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B051C2235D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D557556464;
	Thu, 18 Apr 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDH3rbrE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279D15DBBB
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440433; cv=none; b=KL9PE39LERfQxxoUNJoqbE6i4H8iRUxAEvJyvltR8dX3qR8IAUClxyCdZw9rSggotIUwm7EbqBShcN6z5A4Qr8ULb/iE9nvE9YwfUNDYK+AZVrRcb2yR5wwdmMcYwG6mfnU0rgzhTXKdSOCBzUgtzSbyDQimX9JQ8TIWTRcnQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440433; c=relaxed/simple;
	bh=ROmcPjJ64JKmd/JiseOznZ/D2FgLxVbBoHraxuM9k20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFKCp777Tu7RJPEz9b3q71x6r6MHPxkwXAASFG3Kz2pyqIMrzaH4GAQ/KIgWEV8jcjfpy6COnNkMxoN6p9FYvQyv3PdR4hHuvd8gL3NKRyJrwoAEXZDwPYFeveZPQugB/E3F/OxGYKbzr+zv+cTcoSpxpcY4JeMn72YoeSGh/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDH3rbrE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-418dc00a31dso6187775e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 04:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713440429; x=1714045229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3o4aCuiqoMv6rrLNjd0F4tqPAFzg6fCnLe+owd2v9w=;
        b=BDH3rbrEzZRmVgHgQMTaNceSGrqUwHZGusZ+Wrih7CiqS7aCiA0ShxnPTbll1M+f18
         /TFlRoJIv5IfcRHJYJDrqgkei8Os0VwYe31AE+HnJKN/KWEjqgcCdz/SwDGXt0VcC7IE
         qVCUkfdAWuLV1icX7Y4Kn49UDu4cWL80aouCGMk/567jU2zKSDwWr3sHVPwXr+qQ4tv2
         rjLeVd/FVz/v6ckiTe7UT1EId2vfCjqC29mR7SToWEAKqZP+AS7PF2rGN7WaTv+BHyLl
         ZEHSJZg+z1FdUOYVd5WVBq4VuFWjKMqiNDQD/wBJ3rhzJiH1SFVBlY/bViOPN8D4E+bD
         4H3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713440429; x=1714045229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3o4aCuiqoMv6rrLNjd0F4tqPAFzg6fCnLe+owd2v9w=;
        b=GVh4qZMAZI6rn6n2WqTM8/rAuQkyJTMcGwPj6aDqiYnA5BDKtpb/DEjrRk+JuFt95r
         WLtOcmfxsDsIo40eI0+hBuAlF0g3giyHzrxI9tnYC+ACLVu+rV+3M/04qwQvA8eLJBfC
         ofgZoNLY1vcliyARUSF6tqKacXc+Sai/jFDl7IT80OArBr4lBMtdNtDVtIEnjSXCIe4e
         lAG9YbWSRmqlVVmv1RO/37ABsbguFgVr0SDQRh3BJcS12uZlodCfvE6WnqdX0nGSHznS
         QYJOsjeysqMGipTSlEbHgdEzYCDhRdZD2x+jTkqHtp9RyMJWmWSM8myvlXsk0UtiAivm
         g6CA==
X-Forwarded-Encrypted: i=1; AJvYcCWtmf1OZSynsKW5yuSMChvq/z2DSe5sS0LWSAtujjF19kZQKRv6LN9lpgv/Nm35WU/V3dPWQEibgNQ+GPZgQHabavZTeihqOx/3h/OODsY=
X-Gm-Message-State: AOJu0YxeqZwRRiODyh+gDpJJrscw0tdQE3GKLHolhlnxx19Vbrbyfw5E
	t+TG+1N7jbM7fo+lAGTn82+PGJreRtj1l7kskyo5/aSFCoWASBBg4Dv9hAZK
X-Google-Smtp-Source: AGHT+IFrgw8hcPeU4Vl4cAa9Q4qi2xZ/lhdhLT7vEB8tjxrC88jo1EGKUB/1FL9YpNAsxSc+8NnKbw==
X-Received: by 2002:a05:600c:46cc:b0:418:b9fa:43e9 with SMTP id q12-20020a05600c46cc00b00418b9fa43e9mr1955093wmo.29.1713440429343;
        Thu, 18 Apr 2024 04:40:29 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b00417ee886977sm6286860wmq.4.2024.04.18.04.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 04:40:29 -0700 (PDT)
Message-ID: <b171c9f5-e2a3-4256-9cac-6793df52ffc6@gmail.com>
Date: Thu, 18 Apr 2024 14:40:27 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
 <bc799ce8-f73d-475e-9858-5b2c9fee0fe3@gmail.com>
 <3bab3540ac644c879624ac200730fbee@realtek.com>
 <c7015899-da29-4357-9bab-6d1f68e43420@gmail.com>
 <36d691bf126d41fbbec3278918cd0498@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <36d691bf126d41fbbec3278918cd0498@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 03:42, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> On 17/04/2024 07:04, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>
>>
>> [...]
>>
>>>> +static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
>>>> +{
>>>> +       struct rtl_priv *rtlpriv = rtl_priv(hw);
>>>> +       struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
>>>> +       struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
>>>> +       int params[] = {RTL8190_EEPROM_ID, EEPROM_VID, EEPROM_DID,
>>>> +                       EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR_MAC0_92D,
>>>> +                       EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
>>>> +                       COUNTRY_CODE_WORLD_WIDE_13};
>>>> +       int i;
>>>> +       u16 usvalue;
>>>> +       u8 *hwinfo;
>>>> +
>>>> +       hwinfo = kzalloc(HWSET_MAX_SIZE, GFP_KERNEL);
>>>> +       if (!hwinfo)
>>>> +               return;
>>>> +
>>>> +       if (rtl_get_hwinfo(hw, rtlpriv, HWSET_MAX_SIZE, hwinfo, params))
>>>> +               goto exit;
>>>> +
>>>> +       _rtl92de_efuse_update_chip_version(hw);
>>>> +       _rtl92de_read_macphymode_and_bandtype(hw, hwinfo);
>>>> +
>>>> +       /* Read Permanent MAC address for 2nd interface */
>>>> +       if (rtlhal->interfaceindex != 0) {
>>>> +               for (i = 0; i < 6; i += 2) {
>>>> +                       usvalue = *(u16 *)&hwinfo[EEPROM_MAC_ADDR_MAC1_92D + i];
>>>> +                       *((u16 *)(&rtlefuse->dev_addr[i])) = usvalue;
>>>
>>> Copying u16 looks weird. I guess it would like to swap bytes (endian problem).
>>> At least it should be '__le16' or '__be16' because hwinfo[] is from efuse.
>>>
>>
>> It is weird. rtl_get_hwinfo() in efuse.c does the same thing.
>>
>> I don't think this code is swapping the bytes. What reason can
>> it have to swap them anyway?
>>
>> Maybe it's a (questionable) optimisation, only three copies
>> instead of six.
>>
> 
> If that just want to copy address, we can use ether_addr_copy() instead.
> I was afraid the order of efuse is different from dev_addr[], but look again.
> The byte order seems the same, right?
> 

Yes, the order is the same.

