Return-Path: <linux-wireless+bounces-4983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CD88812C5
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 14:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC491C2375F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 13:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EF53FE23;
	Wed, 20 Mar 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmLdVIHA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8FA41E22
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943049; cv=none; b=PxLI5f8Xr117C1IsKcODqPfSulckTCWRgyWHdVJJdkyLZaDwIGfTaUG5o/UQr+mp81lcarW1dppe+LRd7cgfzmus5qz0fWd2lz2bJjeu2EfrdoulxFSTieWOW2lcMuFUDOCGEnMkuNYndmDxEEijZDdIILAkQUK0WUzZh6Cq7S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943049; c=relaxed/simple;
	bh=tRlOXiUPcbMHmHQRt4vOHv23EMhlJgdhMEGla/RP8SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdmXVTLb9sw6+0U8BzxYaIwZq9KvdKearlNpFU2IqJKW5epJnf4tOR2u8taTsL5YED34FOXThbsqpLaQLrscu0fzYLmsJkvVcIvKjhB7tkyYQpSUGfdKIK4OyjVYBkzSvQKit1Vf31fWcnjmmlrNBmdJTT8TsfIsjnjsuBQBU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmLdVIHA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33eee0258abso1976498f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710943046; x=1711547846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uzp7FbKcxGdwWygJepSs9tC/4GqEzGimBjWqb7j8sbY=;
        b=VmLdVIHATc3M2U1q6dkKSdIgJg+wYy/Texe4pKKUtct/qBgHBUsn1vENXvpzEXGy9K
         8RsGd/YHMInyVMEC7OM8YNj/hFhLR3Gdhbzqdr1TMaO9vj+vBoAFsNvJYzOc8+JxdfQc
         kIyo1tUeDZF7Dv1YotScDp+DlReABFnau9Jm7HmB7PcpcDxVtY+ZxHzi0RK62h2nMgoo
         1m5HfCXG3hyqBVfOcg/+IG1P611lbuHt8JgOGZM4PXFHyp8OGIIDP47U4xrA2tjOSZ1n
         eM9w40mtwKQAjTreDp1cHPQuvKLNzxHUL2BqQSnZ3GM+tXh9xikiz9UNRShlBTDVn+4C
         fpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710943046; x=1711547846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzp7FbKcxGdwWygJepSs9tC/4GqEzGimBjWqb7j8sbY=;
        b=bvg/15AtemEJk8dC9jjJV9wziKE0Ji9jmNuFlMsqubwTdVntFOVzg1TTh/KCz1gPd/
         SzSCG+30gYkZqeW6obMBY5givHYeR3PL7EAWGgirRi8GwdLej+6cC0/aM8k0dxyFA1km
         9wxvc1TU4IXznzDH4KG3Om1z6o4J9NFSq1FQuET64dxMaIUsd4rL6SYgvjEsW4qtzNZ7
         R6PGHhRRHoU4qjIXC7vagBlnhFBcE1jIWOJT2ubntTJYOV8ifhBmJCo4s/Q0Wl945rcB
         x+2SCNa8Y1zQonGeNAlQfgSOHRl0fF4MwhPY1q2Q0W97r23GzY3JLXNolTJhCaqbJE1d
         aSww==
X-Forwarded-Encrypted: i=1; AJvYcCUwVs5V+lpkEbjop73w1TP/HSE+B6u0wn82x59Gco9d7YxX1Wz9H5t+ANLPnI1PncTgiklML1FPJveNSqa7yL9ieKOrnmFQrUOe+81AwmI=
X-Gm-Message-State: AOJu0Ywrn6cb6die47loN86QdwoVWBBBmkjSAHjEepc6CYQyp8XFKxqQ
	bLwSNWj8/YKjtIg95YNHOGFIZcUq3dAH38c8ucaCool0zU9Fzhdr
X-Google-Smtp-Source: AGHT+IEh1yGDGOUIWYCdtwbPRbym9tG5qXGBu7DWyEq1XvGSr23lghnHSUEbbE5w/oY4BmG6xdJWng==
X-Received: by 2002:adf:ed12:0:b0:33d:b2d7:6264 with SMTP id a18-20020adfed12000000b0033db2d76264mr1920043wro.51.1710943045825;
        Wed, 20 Mar 2024 06:57:25 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id a26-20020a5d457a000000b0033e7e9c8657sm14769601wrc.45.2024.03.20.06.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 06:57:25 -0700 (PDT)
Message-ID: <75128dc9-402b-4904-8c00-15dee1537c6a@gmail.com>
Date: Wed, 20 Mar 2024 15:57:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] wifi: rtlwifi: Add new rtl8192du driver
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <5c23149c-1487-438d-bb37-69e2dd8173dc@gmail.com>
 <2280b6c991fa09e66506088441f63790d092e343.camel@realtek.com>
 <f19a1e6c-fd56-45b7-9936-a1a72d1988ad@gmail.com>
 <45b98bd53119455fa727d67640211fab@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <45b98bd53119455fa727d67640211fab@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 02:57, Ping-Ke Shih wrote:
> 
>>>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h:60:39: warning: context imbalance in
>>> 'rtl92d_bandtype_2_4G' - unexpected unlock
>>>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h:60:39: warning: context imbalance in
>>> 'rtl92d_dm_false_alarm_counter_statistics' - unexpected unlock
>>>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h:60:39: warning: context imbalance in
>>> 'rtl92d_dm_cck_packet_detection_thresh' - unexpected unlock
>>
>> These look like false positives. Every unlock is preceded by
>> a lock. I found a suggestion to annotate the functions with
>> "__acquires(...)" and "__releases(...)" to quiet these warnings,
>> but that didn't do anything. I can only fix it by copying the
>> contents of rtl92d_acquire_cckandrw_pagea_ctl() and
>> rtl92d_release_cckandrw_pagea_ctl() to the eight places where
>> they are called, and duplicating the code that needs locking:
>>
>>         if (rtlpriv->rtlhal.interfaceindex == 1 &&
>>             rtlpriv->rtlhal.interface == INTF_PCI) {
>>                 spin_lock_irqsave(&rtlpriv->locks.cck_and_rw_pagea_lock, flag);
>>                 temp_cck = rtl_get_bbreg(hw, RCCK0_TXFILTER2,
>>                                          MASKDWORD) & MASKCCK;
>>                 spin_unlock_irqrestore(&rtlpriv->locks.cck_and_rw_pagea_lock, flag);
>>         } else {
>>                 temp_cck = rtl_get_bbreg(hw, RCCK0_TXFILTER2,
>>                                          MASKDWORD) & MASKCCK;
>>         }
>>
> 
> Duplicate of main statements 'temp_cck = ....' isn't good. I prefer
> 
> bool need_lock = rtlpriv->rtlhal.interfaceindex == 1 &&
>                  rtlpriv->rtlhal.interface == INTF_PCI;
> 
> if (need_lock)
> 	spin_lock_irqsave(&rtlpriv->locks.cck_and_rw_pagea_lock, flag);
> 
> 	temp_cck = rtl_get_bbreg(hw, RCCK0_TXFILTER2, MASKDWORD) & MASKCCK;
> 
> if (need_lock)
> 	spin_unlock_irqrestore(&rtlpriv->locks.cck_and_rw_pagea_lock, flag);
> 

Even this doesn't work. I get the same warning as before.

> 
> But, I wonder why sparse doesn't complain original code (before your patchset)
> that used static inline already. Can we keep original style?
> 
I found the reason. In patch 2/12 I moved the two functions
from rtl8192de/phy.h to rtl8192d/phy_common.h. This should be
harmless. But I also deleted these lines from the end of
rtl8192de/phy.h:

void rtl92d_acquire_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
				       unsigned long *flag);
void rtl92d_release_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
				       unsigned long *flag);

They seemed pointless. If I add them to phy_common.h all the
warnings about locks go away. I will do this for v3.

