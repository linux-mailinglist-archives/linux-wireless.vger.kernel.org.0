Return-Path: <linux-wireless+bounces-1388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1209F821B8B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 13:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99F11F21FC5
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 12:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00697FBE7;
	Tue,  2 Jan 2024 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIl1RFz3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67133FBE2
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d87df95ddso15646555e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jan 2024 04:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704198130; x=1704802930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cdRUBGHkeAvM9Vhl1A+sKeCfwzy0kRsUFwxlcO6H+j8=;
        b=NIl1RFz3E+PK9tptttlga5JHFOeB8YDyBrxi3qYU1oQscBwBWjd0DF0ybEqOK9p1AY
         hfHIJK1u5J0C6eYW6OSfo7oAQtw5R4DnELoI2Ne0FoOpYvoscKxlLF5v9DCzqK8cD3jX
         d18/snEFXL8ZdxkthkJ9kBtA7Swm5uC528InGRvEQlKQx/8RAIdNBVyBVX/uNEk1oRwP
         93LAVteXKbIATdKHtOsa9g0YLqtW6Dx2/0MOrZVkv5WI/4eICaTV3Q1c3T9+zsldVj7w
         35o0m+ZSqg1WwmX3qPv5tVq21xJUdiYdbuE3z3/J0Sq4oEohUB4bLGDNgEse/qBNgZL8
         PPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704198130; x=1704802930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdRUBGHkeAvM9Vhl1A+sKeCfwzy0kRsUFwxlcO6H+j8=;
        b=IDA6zxx6sLEy22x0nY1Ale5ElfxFCmN+x2Cf5kJKwPuWXyJJTLlMsffozk+vXRAHXQ
         NvE6L4ihrd/rOI0YoomlJK0s6jT4NSifsnAGL/1p9UIyF9oaUb5J8RVh6x9P/xpuND7n
         OLd6vARihbRTIY6VsdobNBv7aDVRcvofiDYPVYf34/cnC3RibJC/mj3p/YBdWWvPHH31
         gerx501z2plq7kJrSJh3g7IupyXEgnWusKW9BOtjnKMuk+0FvDun0EHaM0WEhfxH/Q9d
         VQYqqqOkCSi/jGMrSiOGBD1HI3rZTox6EQFr4/hvKBAdfJMiCklJUJTOKfv5+T6N66gk
         f2SA==
X-Gm-Message-State: AOJu0Yx7uEdd1N5p0/Ac57DUmATsmkkiEv/Iz9xdD26UIezD+AGrI7mH
	I2LKU0xIA9Il4GkZHtcFSk8=
X-Google-Smtp-Source: AGHT+IFmlYpWG2YFhujUQ3wbQpoLRpHe2RPl87SY7UnyrJiEZfCVGz9oj/lnnd+5tfhYHZH5s24hKA==
X-Received: by 2002:a05:600c:3f8b:b0:40d:88ef:dc07 with SMTP id fs11-20020a05600c3f8b00b0040d88efdc07mr735404wmb.81.1704198130303;
        Tue, 02 Jan 2024 04:22:10 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b0040d53588d94sm33506561wmq.46.2024.01.02.04.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:22:09 -0800 (PST)
Message-ID: <c0d4a3e8-3130-48a6-88d6-75156c4147d9@gmail.com>
Date: Tue, 2 Jan 2024 14:22:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: Fix off by one initial RTS rate
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
References: <be0427a7-f85f-449e-a6c8-b1c8371c39b0@gmail.com>
 <f8aaaf712d6940d48a05ae3d33aa25be@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <f8aaaf712d6940d48a05ae3d33aa25be@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/01/2024 02:45, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Monday, January 1, 2024 6:19 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH] wifi: rtl8xxxu: Fix off by one initial RTS rate
>>
>> rtl8xxxu_set_basic_rates() sets the wrong initial RTS rate. It sets the
>> next higher rate than the one it should set, e.g. 36M instead of 24M.
>>
>> The while loop is supposed to find the index of the most significant
>> bit which is 1.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 180907319e8c..b9f3382bd67c 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -4839,7 +4839,7 @@ static void rtl8xxxu_set_basic_rates(struct rtl8xxxu_priv *priv, u32 rate_cfg)
>>
>>         dev_dbg(&priv->udev->dev, "%s: rates %08x\n", __func__, rate_cfg);
>>
>> -       while (rate_cfg) {
>> +       while (rate_cfg > 1) {
>>                 rate_cfg = (rate_cfg >> 1);
>>                 rate_idx++;
>>         }
> 
> How about using __fls()? 
> 
> if (rate_cfg)
> 	rate_idx = __fls(rate_cfg);
> 
Yes, that's nicer.

