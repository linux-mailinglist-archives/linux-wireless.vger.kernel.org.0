Return-Path: <linux-wireless+bounces-23392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 113E7AC3728
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 23:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E034172DD0
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 21:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B3D14A09C;
	Sun, 25 May 2025 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiO7zajc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3253FD4
	for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748210294; cv=none; b=hKbpq2YUPP4Qgaccgwh1yKIKHedJOl1l8ml5NVL4Fgs4ndYVHBTUYOcKQpwuI6go9SyUx/eN0jhJ8zv0Zdylbpy/nGwgsPoQEjWcmTEBNLwkD0oQI9Ul9cqGuuG/0s65Ev+fkpXCqMhpmqVijEYrhv/mqgUE3typkbBjng6yyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748210294; c=relaxed/simple;
	bh=B1tsvTIOtTJUGeiwMao2KrbRgM5OwQ25uGEjzjigmSI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=DtfdrJxsuYLwlyYKrbBsu15NkDahstwztBGPUga4EB0kJiIeHKCGNIlaTOD4alzMa6U/yImp1MPA4bWW3aRPQH9/mFk9kgko8YVwOt4EUTSfPRaSHErCBxAZMT5dGZ48vB9y5mbtWGlQYg51WtclzAUIH7rLHNTq2HeO0LynaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiO7zajc; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d54bso2639965a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748210290; x=1748815090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZk+nx6xO4AjExkootdJG0P93JuJ121NzgFCaEV0XTU=;
        b=iiO7zajcT51eSAPRbygUavEOjChVL+eCl+AsJDpl/KYwScJtsDsp2iGiIpvu7/ZvH/
         TvnVemu10qKaQc+zq17aaFIqN2C22xbxSfnvP1vjzKB+XmWAGkjKtVWTF0m7e/z1r+N/
         a/dsy3Ei93YNFXZSmqsA8kO5iPGlFaDEimjYhJbjpNBr4axaijA1Elu6uPYmJZ8hYI2Y
         rlxQ12ysC9bSLRQ3baOG6XPEZomGhC87ErY3f3nDqmrwLn1zWT1hNS04vZp7Xc5aOzW3
         vTsPJby3fDYvKLgjDC8CNUi7qI1KA6zpYYTI3fwsEa/moK/JeudEnrz55BKqCV2Ek+JP
         dDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748210290; x=1748815090;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZk+nx6xO4AjExkootdJG0P93JuJ121NzgFCaEV0XTU=;
        b=KDgf38gXUitjuXQkmmCWKqgXLSWTOsY6TTGTMQ9QnMyjbDPsNQbJGUsm5qROOLMKpu
         /I/d2mSeMVgbc0L7pp/310XsLpMTGW4TpRnWXQJmLv2GJduNIIOH/kkwdNyerjAOD5m8
         DJmlRcLI7Dle+C96w/jh9XjTFuxephT3y9pSl1CiUjYEGIMMQUy4oTeI05ugDUJE1jPh
         mV66R0z0oo4Iop+NybH9gq/pEuhk4z2NsLCqcv2le86bPhvnDPpz+Jvj1Q6TRhzPjcVR
         h8k7LHxG7BDRK+X6n+N8LNjrtsjC1BTdVHfx/JHMoC5ojAReRLlWN4jB6ewTlKYugGTd
         WeZA==
X-Forwarded-Encrypted: i=1; AJvYcCWjveMyBRzor/DUs+zR6jL+cJMihTLKilLxFf7l4TUr3tGzNBVePEKJ7nTeKf1QRUcC+3XJTmYE6WQZPX4bpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJsiFHQn+N8l/KZnJK8ou5V6MF8xt5+JNxBKoMXmBdM7o3CGEn
	UOKqDRYbPtT/VdSK/O3W25bW6LORJOCICCGk59ncnFXDCV4UqCM+/WJw
X-Gm-Gg: ASbGncu59sB9RhypDD6nfeMRDVxJ9hQApcfaK0wsL0wA1+XHawmTk4ktRbz2vhz6YcB
	TpwDBiEVviGqs8zi8Vi7hJZvufzgXJAIEwC7Kv5pkK7BlJjdbn1OArko/LGOV79jt4TPDx+4+eb
	OHjoapzDpQTckRH20y+30JXbOrAm2a61nlTPrrbWTXCKo8TfzjqjAbwzHxHpLpKlmlnFeZZtCvG
	5yfPemBSM+UzIczlg4aEbHkFigRvSDt1qm8uYyw6i9Nf7VADXDVep3bPYBWNavLxkGNnTacpXo6
	K3f7ESRxFw1dW1bdEx9NFzwqv+g3qBbN3RF+c6dphrme6pratFbY4Jc1gPo=
X-Google-Smtp-Source: AGHT+IEhWEY/4WKhivTkENoQ9hoWfcicBsk3LlN9Q54gd4C3IocwOe3bZE/cf4GxtXjWNQpUr2U72w==
X-Received: by 2002:a05:6402:84f:b0:5fc:aa51:4d9b with SMTP id 4fb4d7f45d1cf-602da5fa67cmr6103971a12.27.1748210290358;
        Sun, 25 May 2025 14:58:10 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-601f1c598c2sm10720802a12.78.2025.05.25.14.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 14:58:10 -0700 (PDT)
Message-ID: <1fb57f92-0532-46f0-8140-c9e191aee0f8@gmail.com>
Date: Mon, 26 May 2025 00:58:09 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v1 08/13] wifi: rtw89: Hide some errors when the
 device is unplugged
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <6038bad5-4a4e-4f99-8292-e37a6d11961c@gmail.com>
 <61a8d41163d4402992e679becb7d18fa@realtek.com>
Content-Language: en-US
In-Reply-To: <61a8d41163d4402992e679becb7d18fa@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/05/2025 06:43, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> A few unnecessary error messages are printed when the device is
>> unplugged. "read swsi busy" in particular can appear ~1000 times when
>> RTL8851BU is unplugged.
>>
>> Add a new flag RTW89_FLAG_UNPLUGGED and print some error messages only
>> when this flag is not set. The new USB driver will set the flag when
>> the device is unplugged.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
>> index 1a03355b340f..99f01fff90fe 100644
>> --- a/drivers/net/wireless/realtek/rtw89/mac.c
>> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
>> @@ -88,7 +88,7 @@ int rtw89_mac_write_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 val)
>>
>>         ret = read_poll_timeout(rtw89_read8, lte_ctrl, (lte_ctrl & BIT(5)) != 0,
>>                                 50, 50000, false, rtwdev, R_AX_LTE_CTRL + 3);
> 
> For this case, timeout time is large enough for USB. But I'm surprising that
> you don't need to adjust timeout time of read_poll_timeout() for USB devices, 
> since USB is much slower than PCIE.
> 

I don't know, it seems fine.

> If sometime you need, I suggest this pattern (number is artificial): 
> 
> u64 rtw89_hci_timeout(rtwdev, to)
> {
>     if (USB 2)
>         return max(to, 200); // I assume USB 2 is slower and 200 is enough for two times IO.
>     else if (USB 3)
>         return max(to, 100); // I assume USB 3 is faster than USB 2
> 
>     return to;
> }
> 
> u64 to;
> 
> to = rtw89_hci_timeout(rtwdev, 30);
> 
> - read_poll_timeout(..., 1, 30, ...);
> + read_poll_timeout(..., 1, to, ...);
> 
> 


