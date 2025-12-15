Return-Path: <linux-wireless+bounces-29764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E3CC01BB
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 23:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04F8330146D7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 22:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E82E296BC8;
	Mon, 15 Dec 2025 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5jKaRgz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506AD1DF75B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765836827; cv=none; b=jbOd9fkYD1gfLpE1iJjINxRptfZWaBADXoNtpCzLrsAjPp6nl2OCxXyOMZnx+IjlY6M9y3PPfZjmFWV6bI46C886KOX1YLdkaWRncl2C4rj+l16p2tXL+qFxijxVggmPKxeTZY2/jpC7FZ+SlxoZzXAuAO8SEAAgnR1Gd01auDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765836827; c=relaxed/simple;
	bh=0Djm8NjC+ubYIfeAWg/fHPAfvXVmzXG8CvELaFZAbN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fukE9moEBdg497AAY7F5N2XI756QKlZIZuHTJyvf1/h/Gf7/UbSKDpPy+xLAyjQfAm1dSjl+3PL6XvxWsGvBnGqyxyJ/LzZloTBAvUnb5OnAfsGtCQijG7Syy+gHejVbDjbN71eOF1vM7TEe6nz24uONSF3hzaGCNJSYYyHISbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5jKaRgz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42f9ece6387so1585850f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 14:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765836824; x=1766441624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1IaqMNWoWcdDhPo0Z5ubq5iO01on4lG6PTtY39j1dA=;
        b=R5jKaRgzsKWu/GUXOmvCQq+9qofubeoe4oAO/f270P8uqfdUdjZBYuYCpMkPCYQG3J
         EnIZ6gIq7J6EK/ant6gFAdR/BOVd9YZd8gwXJuQlODlJBNi8ZoEl2siF3lWHkcgeqXyF
         4AnY1c0pBc39sEGGH/v4lzB/TW6FZ+Exp8sEJTmO7kj19wh7+fY6CNeWLksNNXdBcW5F
         1brrhj5hxpanKwvFt4Ym4c+NxVNPLvqZB796YP//R5POYPSNZiUJ1b6RfulnnUeil+Px
         Q6cwNIRbEZ7xFfD1HPoWbqT5YEa+CIlgVHeXT5bxK86yIHCciHnXArZB0V6cmtlm45lh
         J1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765836824; x=1766441624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1IaqMNWoWcdDhPo0Z5ubq5iO01on4lG6PTtY39j1dA=;
        b=oM7XkLxW1fkSvHvg/JCQkSC5dQQxZG8O+1F8OZvqhQdDowOgpps2xA4W00JD3xMsB9
         GHJ+gBXy8teYwBJg7QAFPFGiKKrqYGXCwpduTYzIzvRusSDiy+ugHsbfiFrKT455/0+H
         qCy9hvYVAAbTUc7le7koamjrH9AhVp0gyoawmc3K+HncB9IVsotsy63StGaT8RBEuFuG
         A43ldUJ7kTLvA3i/T22D5CAxmYnTxm4p/8PycV9I0Hdz1mqqY/3+RiORKfAWx+3+lCr+
         LvTSDaTJJbypHT5NnaVfAbNWmJF3w7UUphSUW0uJkIbzli5dUOz/BlI48vEskuJJdgFs
         Z/Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWyLurH/eJKM3IQ5sAaq/D0I3gGaV51K50Mz47rtsTtsrf1Tfoncywj1WnUGH7AJ3LJmh5PSWeNCgsYP3mB8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5nsoQVpqwy9PHxvl3JF5jiRPkkBsYpfMlvuLpuhRacXAIWys+
	h5MDEiNw61ApycIw76QaelSbF/ENYC2zc2S4JGqh6WUkssDPzfMupZ5C
X-Gm-Gg: AY/fxX7+Fj7Svn+W87RmvSNWh/d45vZLtXlL61kiVvDg2kRvSs2cdgqM7dZYHFfqNpo
	2XUbIjEIhu9aCH6v5sNGB/7u9hZauIWvxtjIj4Xk3akoZharwHAU14pmR3XW9RTqILSY2gvWVPo
	rsZbXSog02wW21dS2UMDeALf26h3G4j6kmH+9Wti7+i3u1avCxt20LDU9tQqxO3OaYc62YrC2oe
	FyDBSaWtgpSOOkF72/amkWHkzFoTfHy7KfyvyrxEk0homjsQ6qcwb0T1BlPNvBPM0tv4YYWqxON
	XbF7KfeFK2oylVsnL+KQq8jrh8tbVtN1FPhPzUISipHGiIbC8KTchyLcFx6N6wwPjmTLoTPljpl
	9rJ2/563s+l91EM75KNZtxHnjovgNGARaHzLk4gijFyM9run1hn9HOuXiKvV/ZrvJtbn1KKFAHk
	yLJ7kB12aQ5QFb1rq9rCN1
X-Google-Smtp-Source: AGHT+IGd08ZkV6PqnQYMD2pkdpNo1zPAchN2dMU5y2VqwFiWL3JlXqtOJIPTZVTVa6IN1QBvXNd0BQ==
X-Received: by 2002:a5d:64c5:0:b0:430:fdc8:8bc9 with SMTP id ffacd0b85a97d-430fdc88e95mr5335723f8f.40.1765836823386;
        Mon, 15 Dec 2025 14:13:43 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f984a268sm11802964f8f.1.2025.12.15.14.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 14:13:42 -0800 (PST)
Message-ID: <01840faf-b330-45ff-93c0-f7f094e5e75d@gmail.com>
Date: Tue, 16 Dec 2025 00:13:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 10/12] wifi: rtw89: warn unexpected polling value
 of XTAL SI
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Gary Chang <gary.chang@realtek.com>, Damon Chen <damon.chen@realtek.com>,
 Zong-Zhe Yang <kevin_yang@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
 <20251212031303.19882-11-pkshih@realtek.com>
 <fffdce20-1cc0-4e51-babf-2a759ed37444@gmail.com>
 <37be87bfd5c64af1b0631071d09bf297@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <37be87bfd5c64af1b0631071d09bf297@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2025 03:24, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 12/12/2025 05:13, Ping-Ke Shih wrote:
>>> XTAL SI is an indirect serial interface to access registers in another
>>> hardware domain. When BT driver initializes UART interface, firmware might
>>> rarely control XTAL SI at the same time causing access racing.
>>>
>>> Current is to adjust initialization flow to avoid the racing. To make
>>> the racing visible if it still presents, add a message to address this.
>>>
>>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>>> ---
>>>  drivers/net/wireless/realtek/rtw89/mac.c    | 11 ++++++++++-
>>>  drivers/net/wireless/realtek/rtw89/mac_be.c | 11 ++++++++++-
>>>  2 files changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
>>> index cf36be167162..066c99f3e53a 100644
>>> --- a/drivers/net/wireless/realtek/rtw89/mac.c
>>> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
>>> @@ -7023,6 +7023,11 @@ int rtw89_mac_write_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8
>> m
>>>               return ret;
>>>       }
>>>
>>> +     if (u32_get_bits(val32, B_AX_WL_XTAL_SI_ADDR_MASK) != offset ||
>>> +         u32_get_bits(val32, B_AX_WL_XTAL_SI_DATA_MASK) != val)
>>> +             rtw89_warn(rtwdev, "xtal si write: offset=%x val=%x poll=%x\n",
>>> +                        offset, val, val32);
>>> +
>>
>> This message appears several times after I unplug a USB adapter:
>>
>> [  +0.834445] rtw89_8851bu 1-2:1.2: xtal si write: offset=90 val=10 poll=0
>> [  +0.000015] rtw89_8851bu 1-2:1.2: xtal si write: offset=90 val=0 poll=0
>> [  +0.000007] rtw89_8851bu 1-2:1.2: xtal si write: offset=90 val=0 poll=0
>> [  +0.000004] rtw89_8851bu 1-2:1.2: xtal si write: offset=80 val=0 poll=0
>> [  +0.000005] rtw89_8851bu 1-2:1.2: xtal si write: offset=90 val=80 poll=0
>> [  +0.000005] rtw89_8851bu 1-2:1.2: xtal si write: offset=90 val=0 poll=0
>> [  +0.000004] rtw89_8851bu 1-2:1.2: xtal si write: offset=90 val=0 poll=0
>>
> 
> I think this is because it calls this function during power-off.
> 
> With additional changes below, will it avoid warning in your side?
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index 7ffb039e7d1b..9113efe00a94 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -1483,6 +1483,11 @@ static void rtw89_mac_power_switch_boot_mode(struct rtw89_dev *rtwdev)
>         rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
>  }
> 
> +static int rtw89_mac_pwr_off_func_for_unplugged(struct rtw89_dev *rtwdev)
> +{
> +       return 0;
> +}
> +
>  static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>  {
>         const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
> @@ -1497,8 +1502,13 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>                 cfg_seq = chip->pwr_on_seq;
>                 cfg_func = chip->ops->pwr_on_func;
>         } else {
> -               cfg_seq = chip->pwr_off_seq;
> -               cfg_func = chip->ops->pwr_off_func;
> +               if (test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags)) {
> +                       cfg_seq = NULL;
> +                       cfg_func = rtw89_mac_pwr_off_func_for_unplugged;
> +               } else {
> +                       cfg_seq = chip->pwr_off_seq;
> +                       cfg_func = chip->ops->pwr_off_func;
> +               }
>         }
> 
>         if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
> 
> 
> 
> 

Yes, with this the warnings don't appear anymore.

