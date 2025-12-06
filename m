Return-Path: <linux-wireless+bounces-29563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE3BCAAEA0
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Dec 2025 22:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74A3C31ACCD7
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 21:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3D62DBF40;
	Sat,  6 Dec 2025 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKfllvQ6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8102D94B0
	for <linux-wireless@vger.kernel.org>; Sat,  6 Dec 2025 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765058027; cv=none; b=PJz/kJsxZ3tlsOWAj8SS98uxZm9Uk0BlqPNCAH6xTP7ckdRPRw16k5VcPnNwCgPBa8+vRetayiODD9ec6QuLEZG0Z53ONKrgtClSjG0GckRs1pPeRgvYGrSwTM2SGTCVEXxsjY6k3a6PQmlEzIcQlQx0BlZm4m4WCfpuTNIR0to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765058027; c=relaxed/simple;
	bh=43TX5frqeFMefjQIw3xSaro6MZidnaNM32Znkp2b9JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7Baio+5ivhU+tuzWOKoOsxzNhfO4qjlsKjbIYOfTcc/ddxEUjiHNMNSTanhjpXHtjVoJXYSReeDCtjw0CbqBXMQQW/Q6rN0j5M2fND7vf2VtR+M4mQ00i8xMSDqp6F8At63CLeZ+VQ29IBHH4n8UZAvqv9V7k320ZYlVJ8kIEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKfllvQ6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2e77f519so2184688f8f.2
        for <linux-wireless@vger.kernel.org>; Sat, 06 Dec 2025 13:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765058023; x=1765662823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlSc46iEGMKsSwCu/roR86i2e0LFt7xxWxcFqpVt+ug=;
        b=dKfllvQ6rOsLe51Hfikl9pIM1Q+bSFybpOGnLLagzzPx53FHNboQgbOxW9KMnHb2a3
         lnbD2riOnlpritWbi5JfuRBYzG3AEUm1Pu2ce6EEw8fb5dlioeIzryOuo4HYg88SrZ6O
         umrzPfewH8aIpD7zZtsSqahwxfjbmY5825VwfP+UejxrI7Pgh6xtYfEORLhnjJ9iV2Vl
         24g4mK5QFoJK4cK8j0xCS9mRnKSsYCf/UEawBWcyzdyHxflYMJg2fIGQjZJZWUWd/dqr
         f/PqNfOAIYQqVyGVyOWxTyVHadDVY77KOs8V8969POhZ67rMQl5CrQ4XHjT0VDSqyeEf
         BGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765058023; x=1765662823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlSc46iEGMKsSwCu/roR86i2e0LFt7xxWxcFqpVt+ug=;
        b=cJ+hrls7Z2zj92hOjq1SFSL9VsO4WU1bZMKmb49MdmC8JCyT4v5ldEosnW1IP4nvtJ
         O0r+amYNKKqKak0tcmQHOj6mL+Ens4jAgHX1FFqX+v/bjXdNxdSNfBfJTEAUJSSAwCIK
         NUDGjNs+UJ7USTmzY0oDRBJjcR04ELz1pKPNBo10uOvTawLLOw1uG1NyN/Gg29+dHKLV
         paEp3iE/7W2QRCBwXe2tt2SY/ncf321aQYujNT2398hvhCkfSSDck2U7jxPNkXm24M63
         meKCHve9YdoEBNf1VIN8KCC22cY1meoQOPP5W+W1MtBJk52vgPyTg7/K3qiqrhlSsESo
         l0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5/e6EicOkl55UU4QL432Dnqo7Oz3fbRQYcxPRwyBVurhJG/SsWrqVXWM1BxT11GXRn6YHrqoScpIIa3egTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDTyRO0H6HiKlDaOm81hbs4NrUl/SnEXKURofaxO2Mu9m2fBSx
	bcdWP4XyQPkj4cIKHpjY1kq9uns/Imzbq7MXLGeU3KGtp03WL+MAKij1
X-Gm-Gg: ASbGncudp8x6Jql6gXYk8e/OysjtnTDdFzOkTD5kihmAhk24ow3fao2LZF3m5Uw8dzz
	5faQBbszSTLFKJwpH76/vvLV2R7ClUVC22hlAMaZm193OSsagK+NCmw3a95yvaNMgdzsNPwBlIl
	BDYjaME2bugAsi5g9FgDFQb3nFO7O0oqvlaheM8Wou+UHaVbR/iA5z7v1P2Amll+224ePSdSDHq
	eRlQmhToSIekv6cKjaSJ+f04W+gcpGdiWk2a6L5fvLRrX9vU1rAuj2CXhkj+rI51vTNbJKQC7VZ
	KzX+TGj15ElGe79H5n257YRbSG9r4RZs4YItsI9EJAxalb/yYRz1jynv/r6NEf4msb+jQcQaF7U
	/NLIWKLtmBYZIxgqClOtsD64rz/bephHAxt8QUq00yoxzc5FqI/sev7G0cz56VGfrKFcm9y0Suw
	htPNpX4seUNQnf+/shYlth
X-Google-Smtp-Source: AGHT+IHbCGiQk3fsXEj22BoPr+p1X+aNsAMv3ycLRRhbH+uIBzuybMZ3eZdnq4HZjmb9nLBzlNXi4g==
X-Received: by 2002:a5d:64e3:0:b0:42b:39ee:286f with SMTP id ffacd0b85a97d-42f89f53e46mr3097057f8f.48.1765058022382;
        Sat, 06 Dec 2025 13:53:42 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbff352sm16634775f8f.17.2025.12.06.13.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 13:53:42 -0800 (PST)
Message-ID: <44c9c325-14a8-4391-adce-4bbe8c68b446@gmail.com>
Date: Sat, 6 Dec 2025 23:53:38 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
To: Ping-Ke Shih <pkshih@realtek.com>, Zenm Chen <zenmchen@gmail.com>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>
Cc: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 linux-usb@vger.kernel.org
References: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
 <20251121111132.4435-1-zenmchen@gmail.com>
 <475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
 <c0d187d6fead4e5387db2a14129be96c@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <c0d187d6fead4e5387db2a14129be96c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/11/2025 05:26, Ping-Ke Shih wrote:
> Hi Bitterblue,
> 
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 21/11/2025 13:11, Zenm Chen wrote:
>>> Gustavo A. R. Silva <gustavo@embeddedor.com> 於 2025年11月21日 週五 下午6:20寫道：
>>>>
>>>> Hi,
>>>>
>>>> On 11/21/25 19:06, Zenm Chen wrote:
>>>>> Dear maintainers,
>>>>>
>>>>> With this patch applied, my system always freezes right after the rtl8xxxu
>>>>> driver is loaded. is it normal?
>>>>
>>>> I don't think so... It probably means that struct urb urb; cannot really be
>>>> moved to the end of struct rtl8xxxu_rx_urb or struct rtl8xxxu_tx_urb?
>>>>
>>>> It'd be great if you could share a log.
>>>>
>>>
>>> Hi,
>>>
>>> Nothing helpful found from the kernel log. Maybe Realtek drivers maintainer
>>> Ping-Ke could take a look what is wrong next Monday.
>>>
>> [...]
>>
>> I got something. In my case everything seemed fine until I unplugged the
>> wifi adapter. And then the system still worked for a few minutes before
>> it froze.
>>
> 
> Zenm and I tested below changes which can also reproduce the symptom, so
> I wonder driver might assume urb is the first member of struct, but 
> unfortunately I can't find that. Could you also help to review if something
> I missed? Thanks.
> 

Sorry, I didn't find anything either. Maybe someone from linux-usb
has an idea? The errors I got are here:

https://lore.kernel.org/linux-wireless/475b4336-eed0-4fae-848f-aae26f109606@gmail.com/

> 
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1942,15 +1942,19 @@ struct rtl8xxxu_vif {
>  };
> 
>  struct rtl8xxxu_rx_urb {
> +       u8 pad[128];
>         struct urb urb;
>         struct ieee80211_hw *hw;
>         struct list_head list;
> };
> 
>  struct rtl8xxxu_tx_urb {
> +       u8 pad[128];
>         struct urb urb;
>         struct ieee80211_hw *hw;
>         struct list_head list;
> };
> 
>  struct rtl8xxxu_fileops {
> 
> 


