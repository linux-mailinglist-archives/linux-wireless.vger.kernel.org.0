Return-Path: <linux-wireless+bounces-1343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C0E820690
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Dec 2023 14:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98721F21923
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Dec 2023 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334A58BEB;
	Sat, 30 Dec 2023 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzi1Lu77"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE08BE3
	for <linux-wireless@vger.kernel.org>; Sat, 30 Dec 2023 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3367a304091so7264445f8f.3
        for <linux-wireless@vger.kernel.org>; Sat, 30 Dec 2023 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703941943; x=1704546743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkZG2PFmUVhAXh/L5KxYka8HsNQpzi7jnZ2EAhsXux0=;
        b=Vzi1Lu77RFj4AvxnYQP0xOZ71vkUBzRQgEIa4P8aFvwta8tpnh7YATIpsfm/Hpmo3n
         fWzFG/B+yvNmyNYml3MLIqY/oNXmmror49iJ93aPr0Jad76IIxUkIzF5fBd1MnVJ+SC/
         tyyOneAY6QNTRJg3hskAVhwYxlJw/XJ10PlvkxtjTXBmideoGmOai7qwxYSmIIuKS+2c
         IGfgnj2xMiKAFSNVZmQJhxwfTZNFUXDuvUwOCFA6dAFJvF6AyGRSyRuanEMWVDMWp8ml
         +Gs6BpasvDEJ0DJmb3QKs8xhKguiP/VvO5s5/umBuXUpQvCmasfDUFjRqCac1XIqXK7z
         qrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703941943; x=1704546743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkZG2PFmUVhAXh/L5KxYka8HsNQpzi7jnZ2EAhsXux0=;
        b=SxmimCjKmIiSc1AiY97x9fwyY22BiCkur3f8g0YAiyBNec/5xNOYWIn5LAkkASWFR6
         flV0UrVnZ4EwQP8TjuwnrMRfOI1hxzMrTgHdaosZXnPvcHH00aA/9ROmg8zaP2MnJxz7
         SfJx6R7DHYg0NFUUWoyALhLuUsboXZuOBUXFtC3ZU3UAO9foXb2C6sDCEKQBQrjw5vMT
         nIILiWy3wESUuA7KuWI0hS6C1ZidEC2n7CxNowoYnwAPRRUabmIZt1zgqRzSUD6tSObD
         y0eccEl0Rx2PSYYw9XkVFJpc2p5i8Pm5hftiNbRE/fb5bb6NU3WvZQ0X3LP070TsJd9E
         pEgA==
X-Gm-Message-State: AOJu0YxsWj/UN4VBcnhed44PzrJAmKpYxkZEOcKJ9l6F6Nmtax0GO8Ro
	4wz8unVHwfdmgt3tEk/zNeOMi6Mm1UA=
X-Google-Smtp-Source: AGHT+IHsIJueYbOwQKXs2M4lW+tYXh1DkAZZsW+kSew5HwAEvRgpNWsILmtVXgNitq9OjGXwg0kVRg==
X-Received: by 2002:a5d:60cd:0:b0:332:e68b:416c with SMTP id x13-20020a5d60cd000000b00332e68b416cmr4961824wrt.26.1703941942603;
        Sat, 30 Dec 2023 05:12:22 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id t12-20020adfe10c000000b00336f43fa654sm8534385wrz.22.2023.12.30.05.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 05:12:22 -0800 (PST)
Message-ID: <1408a85d-48c4-4427-a5e0-a81c3cf10385@gmail.com>
Date: Sat, 30 Dec 2023 15:12:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtlwifi: rtl_usb: Use sync register writes
To: Larry Finger <Larry.Finger@lwfinger.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f806007e-8fba-4f29-8a38-f81d04bd4fb8@gmail.com>
 <ddaf8f07-5a7b-49a4-8ec1-2a28eee2279e@lwfinger.net>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <ddaf8f07-5a7b-49a4-8ec1-2a28eee2279e@lwfinger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/12/2023 23:36, Larry Finger wrote:
> On 12/29/23 14:51, Bitterblue Smith wrote:
>> Currently rtl_usb performs register writes using the async
>> usb_submit_urb() function. This appears to work fine for the RTL8192CU,
>> but the RTL8192DU (soon to be supported by rtlwifi) has a problem:
>> it transmits everything at the 1M rate in the 2.4 GHz band. (The 5 GHZ
>> band is still untested.)
>>
>> With this patch, rtl_usb performs the register writes using the
>> synchronous usb_control_msg() function, and the RTL8192DU works
>> normally. The RTL8192CU still works.
>>
>> The vendor drivers use the async writes in only one function,
>> rtl8192du_trigger_gpio_0 / rtl8192cu_trigger_gpio_0, which probably
>> doesn't even run in real life. They use sync writes everywhere else.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>
>> Larry, do you remember why, back in 2011, you chose to implement the
>> async writes?
> 
> Bitterblue,
> 
> That was code provided by Realtek from their USB group. I think they were in China, not Taiwan. At least the PCI and USB groups were in different countries. They provided the code, and I just cleaned it up. tested it, and submitted it. If the sync function works for the cu and du chips, go for it.
> 
> Larry
> 

Ahh, okay. I guess we'll never know why they did that.

