Return-Path: <linux-wireless+bounces-23517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E635BAC9CC6
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 22:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6974A7A5802
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 20:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF9A149E13;
	Sat, 31 May 2025 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ1ODVUy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F472608
	for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748724881; cv=none; b=GgspWHsO4qjm6xY6U8kmaHWsTfrCQvz16/+UwkmZhXTA91HuZ+3ePs0Xebf4fGNsm6zOaxYNaqjB5oPR/+GxceT1Z4vBsrvmKnYCy9+o7Mtjc+ayZg1xNDibygRsvkJPz/3abfJzwYpL/liLqRFxmUVwf/2kF+8v4Sa+Qxqutb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748724881; c=relaxed/simple;
	bh=gXjGjaXoZOqrI62Za2c66stq6J3/L8nZIcslCxMeACo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=DechP40un+6e1WBzn2Yu27ch399HdGZ3R4jvFy07PNN+P8jXJqtupAWJF2DXUhh5Bz/v80McP33W1NpHq4vm+zdgul/HIPdnfa9mTZ7GUbwzf4ymJhiZbZ/Pf+GKcjf3z92AN9GYNvS8tolSu6UochDfY/P8osPTLfnLbZwPbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQ1ODVUy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so18204435e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748724878; x=1749329678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qABlCXY0Qx5KaYWBtlxo6+huQyQlhkPe7qLg+AMwqBA=;
        b=HQ1ODVUy7Wn+43/HtIPBB+LXK6mT16NbGGIyYNwiCxgRnQcFW4ANIrNlYZm/pIQnSf
         nGyQh0zE3WATsgHjuUxOZB4j7WL66MEbTgy5uKeEoVQmQ9vXT7UlspDfrX79F2gkiNMq
         JILCutqd3IBj47qfFlC+OUQQgaX86XNmaPP+xLZJsA48NUDTZSbaF5gqVfHKxJKAKQZF
         ED069KDJYQ8owqW/vVynxSFf88Yd1rbqi0nS0Y50KRm405+lLpwBG+EmEroZH7oDhnzj
         WKnlS764RsFBp93xQSNtn3LcUs05CppPqurMHIwWq4AbL6J+wHGBv0UsYK3u4BYIR2PR
         zpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748724878; x=1749329678;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qABlCXY0Qx5KaYWBtlxo6+huQyQlhkPe7qLg+AMwqBA=;
        b=tOagf/Td1CUIPkP2AiIivZ4Owr1NENi+BeVkLJZFTLq9DOtZdK43PZJgS0pSU7vL4n
         XZ1nYHdxGmEmk6NTGE1FjQWr8LLb38lXXpNYlki9Iukulz2wIxPVB1xT/mSnu4a2Oa7K
         ecGTtehz/ZxXZaYOJv08+6gFvTGrQeVnC6zPs3YehH2x1o4v1BOAfjxWKFI8YRZpqG3R
         yXcQGApac1bPZ2betp/tUCrHGWojlHRw2mRH0WRstTC3jmkCKFafqhA7fV5UVck5Os2i
         l4rFnu1Ub6tKipziHq//XUDNXt/wLOPGXb85oVKa3bjIfzw+V/EbkGIFvv/lo8GFLYVL
         Jg3w==
X-Forwarded-Encrypted: i=1; AJvYcCUeiipyjvAhOtgbylv+o4nyRC40QQpVYCaWEeDwz7uWf+m7EN3KKrJ0hD1s+eWJRL5O8/9/Y2ziMZh25Fmtyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjuhdqtQJrSUIyxlboglOAMTRUzjh1y2KyM5HXhp40eq7KzKI3
	aThQcUYgDCddBtgfJ1k7MfDAUErABZNthINxVMLgoUUxJQ3Yu0ceWn1XmwdmjA==
X-Gm-Gg: ASbGnctk7vIsZSgdvqBpO0Ikb1j2fAbJjo20Li0sRSta0Hv1uNyh82seFUI+PnOFXt7
	ASVxVilsb1SjzV53ASK0+XfkfdFP6uznhRVx2hRrDvQj3csUYeHvXDg5biNJQD6TviKvQvu2cKG
	RXojOkol4IzsolOfuTkq52yqw+QV1PYOTdRiIPgRV5Z3h5CXwb/ZUoH/izGkKJ0lFq98LroLE8O
	k/CCXprWi5lkFYQIIAml8TOy2HrU/HaqUczYhm8uuZj5jPY2+y6dOszGWbRFKj/VTk7d7Hj0PGP
	zW3lm4+hbBYdIFggMniJoWwKCtLIlMGl8vIJzUTp4LLZkQJg9Ibd0NG095k=
X-Google-Smtp-Source: AGHT+IEvxmPid3MmUK/VACsjcZ2fOOf+B1kW3duQNGmQZJfdYxhdBu/eNuPmT+T1QoLewyH03WcwYw==
X-Received: by 2002:a05:600c:4e0b:b0:442:f4d4:53a with SMTP id 5b1f17b1804b1-450d64c322amr89088115e9.2.1748724877435;
        Sat, 31 May 2025 13:54:37 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe7415asm9263965f8f.57.2025.05.31.13.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 May 2025 13:54:36 -0700 (PDT)
Message-ID: <033a88be-9fa4-42c4-85ab-57bd6063b7e8@gmail.com>
Date: Sat, 31 May 2025 23:54:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v1 05/13] wifi: rtw89: Add hfc_param_ini_usb
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <348b0c94-2db6-4ae9-819c-6fa7f9c3ac56@gmail.com>
 <54b050dc237e46fcb96576e19451ae97@realtek.com>
 <9c3980f3-c22e-4213-bab3-15d25bdc1b59@gmail.com>
 <fc4c3f9b333a49e6bb078e7b1bd67e57@realtek.com>
Content-Language: en-US
In-Reply-To: <fc4c3f9b333a49e6bb078e7b1bd67e57@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/05/2025 04:51, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 13/05/2025 06:12, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> Add hfc_param_ini_usb to struct rtw89_chip_info. For now initialise it
>>>> only for RTL8851B.
>>>>
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>> ---
>>>
>>> [...]
>>>
>>>
>>>> +
>>>> +static const struct rtw89_hfc_param_ini rtw8851b_hfc_param_ini_usb[] = {
>>>> +       [RTW89_QTA_SCC] = {rtw8851b_hfc_chcfg_usb, &rtw8851b_hfc_pubcfg_usb,
>>>> +                          &rtw8851b_hfc_preccfg_usb, RTW89_HCIFC_STF},
>>>
>>> [RTW89_QTA_WOW] is missing. I'm not sure if current can handle this correctly.
>>> Could you try to do WoWLAN with USB? At least, it shouldn't crash.
>>>
>>
>> RTW89_QTA_WOW is missing because I didn't find an equivalent in
>> enum mac_ax_qta_mode in the vendor driver.
> 
> Yes, vendor driver doesn't have that. As I know, it does some modifications
> from original normal operation quota, such as RTW89_QTA_SCC, because we want
> constant definition in upstream driver. I will check internally and get back
> to you how it should be for USB devices. 
> 
>>
>> I enabled WOWLAN with this command:
>>
>> iw phy0 wowlan enable disconnect
>>
>> Then I put the computer to sleep (suspend to RAM). There was no crash,
>> just some error messages. The computer went to sleep and woke up without
>> any other problems. Of course it didn't stay connected to the access
>> point during sleep.
>>
>> May 23 20:19:46 ideapad2 kernel: rtw89_8851bu 1-2:1.2: qta mode unmatch!
>> May 23 20:19:47 ideapad2 kernel: rtw89_8851bu 1-2:1.2: [ERR]get_dle_mem_cfg
>> May 23 20:19:47 ideapad2 kernel: rtw89_8851bu 1-2:1.2: [ERR]patch rx qta -22
>> May 23 20:19:47 ideapad2 kernel: rtw89_8851bu 1-2:1.2: failed to config mac
>> May 23 20:19:47 ideapad2 kernel: rtw89_8851bu 1-2:1.2: wow: failed to enable trx_post
>> May 23 20:19:47 ideapad2 kernel: rtw89_8851bu 1-2:1.2: failed to enable wow
>> May 23 20:19:47 ideapad2 kernel: rtw89_8851bu 1-2:1.2: failed to suspend for wow -22
>>
>> That was without RTW89_QTA_WOW.
>>
>> Then I tried to copy RTW89_QTA_SCC in rtw8851b_hfc_param_ini_usb and
>> rtw8851b_dle_mem_usb2. With that I think it was able to upload the WOW
>> firmware and it stayed connected to the access point, but something
>> didn't let the computer go to sleep. It sat there for several minutes
>> with a black screen, the power LED on, and connected to the access
>> point (but without an IP address), until I clicked the "Disconnect"
>> button in the access point's web interface to disconnect this station.
>> That's when the computer finally went to sleep.
>>
>> So WOWLAN with RTL8851BU needs more work.
> 
> Thanks for the test. I'd ask internal experts if USB devices can support
> WoW already. But, I guess the answer is yes. Have you tested WoW with
> vendor driver? 
> 
> 

Yes, it works. I can wake up the computer with a Magic Packet.

