Return-Path: <linux-wireless+bounces-24243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE1ADE994
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 13:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58393ABA3F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 11:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE42882B7;
	Wed, 18 Jun 2025 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk8bDS2K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8127E7EF
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750244730; cv=none; b=eNZXxjPraoAGqd7Jamn4656UCd69JR9KG/tquBrsLml6v9ng5rq7bnmgRDwq7xXVkkhYchCfhbwjNfYLDcCdh2ukQbRMQKXi0O/5gGY0OFXWLjczNF3xgWGi3ydUa3NDnzr9UGgC9bc1PalHsj+1GPD8RJYB9TNR360/nIp1sxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750244730; c=relaxed/simple;
	bh=+MwgSIcBXv6XIcu4qJs6pD/68P+5f4OvuOQ/jbTT8UY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=LZWf4zrGs45J5iAVXfuLRftikAdEFKkwvSfqMhTBKhKUjNhe8nSygEHNVdlEYyV6uW5nCILhKiX/r0ihbbHXqFmxhzdnCa1ZxdeScSMkC2CRYbrVmBoKEg9YGNzfaQQs5KnFhKcKDJqHQ9RQ3aZkXqJVgPKo+5lRTd/xk28BFAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nk8bDS2K; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a36748920cso8038082f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750244727; x=1750849527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhvFcQKb5HUpTBpctYFKID1CkMZixVHk1QW2CHQ5Pb4=;
        b=Nk8bDS2KHAn0bQ9GvGvFOW7SX7sRDpqOb9e43wcql/tp5g1eUbUqVE+wj3gXOUQ8x6
         6nPbuEZcZ5uqtgS9GIgt7lnmueCBfSQH8BzUKtkoGHPpBTfkNT8XM1Sw2QR8/jelI/xr
         HLYWhhdpM8qmdWQm9tnynSt+9AoOqeU5SG620EOqkAJyiqa1CERPKIAZjoMxumZJVUwq
         XT0X5IMZCZtHx30jvFvbkcnh6U4cPAWB0sVlC4qUPZjv/y54RErts0ZNy7YtGKxoI0T4
         65JJAbS0Z2OSxh9hJ0xyjL9ZKOzOxm1yULxhgpF6qOyl4bjus5FoaNsqwmFJtZWE5N9b
         PH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750244727; x=1750849527;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhvFcQKb5HUpTBpctYFKID1CkMZixVHk1QW2CHQ5Pb4=;
        b=idYNTE98n/UedJSA9TMyO1hYkCunB7wI4ILe8Hho2N1zxFvGMBgyWxXzu2l6ulhBjo
         uC02bDNHtNjoOG7uDXoIACwsUR+G6FiIA23N63JEGBanFIAEJ2q+5806ua59I52KL4rt
         vEbOOvIRLZj8fGebEzeWYwZjGZWnpGFSFZN1cap+Q1K52zI3b/Q3/8OzaWa44J+oMy0C
         hGGzHsLOKFxMcrx1HIg73VYjwq8XAyxR+dY4zF11UmRRucME8vqNgh7syUpc1cGu0T97
         38PTiwFuwpNCmaxFouYSfSUdtdxOfGkSrlioJ2dbAOFxs22o81fI9cZDQqOUWpPOv8l4
         Lohw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8kIQbxrTl5k6Btw0CdQORAAcSvZ8OsvvoGyLpiVYJwWL2JuislW1nbVz7CWqVqbI+gDw1rn+yKnZ6qmjAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIbfOGLBz5WvWYOB62j3Iwct1VARBpnix3I7Y95wxwIXyACKOS
	XeSJmrdn4WKzdgTJ1e6U5WRKHl3cQo/94oNxhMLfW8FImb5wjJ2OtZE9Gltsng==
X-Gm-Gg: ASbGncvYVXgR5rEHJkp0/kgMgEWgooQYmJSu3hapd9Hz5ns8Ivwzpl9anzfTtzk4tpT
	casBI/dsKFldEzpmwwtuVnBDq22Ji96wusybxdV+Q98b7PU/mhXnKQd/EkBpLXqtu7v4q2SKWvJ
	HsUSg5ackW+Ljm2PnO+m2hUK1xH05hX9bpJ/ls7pGTPCXmAmshQjUROKZPYs7nlyErBmQhyJNcy
	VHYVypRusEqRz+RKujVzUwWwEXe3oao3u2f5D46x2ISbr0odvyRNbTkAUeGHmJvoBj8YGDrqG75
	fTLEpZpBuqJcz3F7Fv05ZHzvVDrkO6mBsUtxk1Ovt6glIYqCLpmkZ6HChklX4P0wGi+YlQ==
X-Google-Smtp-Source: AGHT+IG314Z7jiTtcDX4PAsviizaUcUR9yy+30d55t6gPNZqWenkoRT73LfEiDMRw+kWs+iDKtZz5A==
X-Received: by 2002:a05:6000:4284:b0:3a4:eb7a:2cda with SMTP id ffacd0b85a97d-3a5723a2c2fmr11736827f8f.30.1750244726488;
        Wed, 18 Jun 2025 04:05:26 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a7e980sm16243191f8f.41.2025.06.18.04.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 04:05:26 -0700 (PDT)
Message-ID: <0aedd61b-3ebb-4c82-98b5-bcff944a9986@gmail.com>
Date: Wed, 18 Jun 2025 14:05:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v2 06/14] wifi: rtw89: Disable deep power saving
 for USB/SDIO
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <1e25d8b6-fb5c-4733-81ec-b9ae9bbd8f92@gmail.com>
 <f098d82e620849f791fba9bc56198f5f@realtek.com>
Content-Language: en-US
In-Reply-To: <f098d82e620849f791fba9bc56198f5f@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/06/2025 04:42, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Disable rtw89_mac_send_rpwm() for USB and SDIO because it is called in
>> atomic context and accessing hardware registers results in "scheduling
>> while atomic" errors.
>>
>> Disable rtw89_mac_power_mode_change() because it prints an error message
>> when rtw89_mac_send_rpwm() is disabled.
>>
>> Modify rtw89_ps_power_mode_change() to call
>> rtw89_ps_power_mode_change_with_hci() only for PCI because the latter
>> is probably relevant only for PCI and also because it calls
>> napi_schedule(), which results in dereferencing a null pointer with USB.
>>
>> For USB and SDIO rtw89_ps_power_mode_change() probably needs to call
>> rtw89_mac_power_mode_change() instead, in case deep power saving is ever
>> enabled for USB or SDIO.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>  - Disable deep power saving for SDIO also.
>>  - Don't disable rtw89_ps_power_mode_change() for USB/SDIO.
>>  - Disable rtw89_mac_power_mode_change() for USB/SDIO.
>>  - Call rtw89_ps_power_mode_change_with_hci() only for PCI and call
>>    rtw89_mac_power_mode_change() for USB/SDIO.
>>  - Update the commit message.
>> ---
>>  drivers/net/wireless/realtek/rtw89/mac.c | 6 ++++++
>>  drivers/net/wireless/realtek/rtw89/ps.c  | 3 ++-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
>> index 7f3c816d4704..2cebde9e9229 100644
>> --- a/drivers/net/wireless/realtek/rtw89/mac.c
>> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
>> @@ -1336,6 +1336,9 @@ static void rtw89_mac_send_rpwm(struct rtw89_dev *rtwdev,
>>  {
>>         u16 request;
>>
>> +       if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE)
>> +               return;
>> +
> 
> I think we can just return RTW89_PS_MODE_NONE in rtw89_update_ps_mode()
> for hci.type != RTW89_HCI_TYPE_PCIE.
> 

Yes, that works.

> If not, I would like to define a 'rtwdev->hci.can_deep_ps' for the purpose
> to disable deep PS temporarily. Sometime we can support it by just removing
> this flag simply. But not very prefer this way though. 
> 


