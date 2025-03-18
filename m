Return-Path: <linux-wireless+bounces-20507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0274DA67C2D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 19:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B398A7A207C
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 18:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A940A212B11;
	Tue, 18 Mar 2025 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muHGHagv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315871DE2C8
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323277; cv=none; b=Goni+cbmEp3Der3rGHNAG0ouOfS3So6tuLTpRmjvepJnG+rEtdWJdkn/LZkCwoVRsnzNwtXlFcLByutjJeG99mVBBHMOsPdFBBXUObRoJOCWQbHzOSBncctXicWeEw0Ja3ozR2jwwwnj80iNt9WyOyEUDwAlEd8/S0DQ0jpFNnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323277; c=relaxed/simple;
	bh=MCiWUBNG0LS44N+1aVtdAmtf5lX5Fxy4162+YLBF7yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TlPLsErxkvRHsBqdsbjMGf5Smyr/9aJxAYd2WLIwN6tmlTgepV4cE7PSCZ8KcXhqErupPBVheF46y7lKlNORMMR+IsI6e1a1QExJI8cMIJBPpAmJI/3gRPwW7Oj6YLeziutXNimV0sWXN1I+ozVmgV22dzqeM1ohre+TYS/V0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muHGHagv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so8049625a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742323270; x=1742928070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VwincxnJ3JCCWGEJCUcohisAL44nSAAi7V3FP9/xyHk=;
        b=muHGHagvgAACsh08DBU8oXwo5nqIlAjk/cHjdKN+AJ92VykhwniBP3k+w5lMFUAaAl
         elVh2yPdDFE/knH/2GJVWEDjAJt47kX85qWyCEYNyB/2vN2YF5yBWUHyowVARxyPZsnQ
         1aa2yJL4bK50PbslWkYfq//RZQZvCOfnODZEOr5esP+oFqt2FEUNJMtN6Cpy5Oiq3hHx
         exgrcYSFsJuIXC8ErETh2rmxum/8XEYvAlTK2qLEBkm8Wf1YkYt8voDLMTCwCGPk1lTR
         3qNEa4u9qlAKg5ohelcC6GphrL4x4+niHt8GVlXbv74/WMvqK8aJivaB2eZB2dfdbgQB
         UzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742323270; x=1742928070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwincxnJ3JCCWGEJCUcohisAL44nSAAi7V3FP9/xyHk=;
        b=mEEtcnZeFV3x+MSeyU/jBI9U77LzdZt1CcJlhEP8oAm1pjq+3EvMTCzU0CyEwiEOi1
         6vESD0UfSq0L7a6uxjreHcp2He/X86Mx95Fkd1CEy3+QmLIEefInqeo/7YejqjJ+3FI8
         wLL8ONcxzMhYcYKTGNXF30Okf97kKgKmHQKpqHuq6tlP91NfWZ9gGuzZ/w3qX026zotD
         VM/SIcv4AhldORtVvbntEBduteLSLJ6zmqROiDBWryqnSAfHEPmIQG3r+I33z3UQC7hf
         Z9hQdz6K8D+nAj9Vp8q36IyLGTthoEO3J+7pvDTjcGs6a1bHxBYv83F5AjlgrpFxdjKs
         nbVA==
X-Forwarded-Encrypted: i=1; AJvYcCUU3mc2UFXQVyUqPd8IdvCkn/aDNg6AzwYN7kOhKHdsSkz+c6t2Eg95zL2nsea/1pMrKDxp39dxJG7SFmRwPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYZNcGgAp8kqv7m+NKJmOBWRGKo+RSH6L8HW0l5ZnrQe6xuEO
	RvP0nUGzBEj9XezQi5NR2J0JhbaFsZeiQsSNgc7SxIIbYajv/bqq
X-Gm-Gg: ASbGncuIJm29El/LIQI9+z+KjMScKc/2jfZlRYDyU51eKukHSQbLj7jU52wBd/UpFAM
	+Z5h0+ZMHKt3UK3+IbjLfMMSwFetUlbqnu9idXYG00/PBiqJZEQQUIaaCzWTtlWNQk2uC6cm8u9
	k393UAXL/KjCkrVzubsUoQjvgJAxE0f7h7kio0wWiTkHqApG4oLGDdw8DAXVFNqF9RseQJvfLXH
	yvzwwIPWRiDnKIn1pZNcZMwZ6w1EKjd9cl4oYnqtP+MY/68rKD6fwzMslGlihJMvfR9mQv8+czI
	SsVurruNo9Hs3/y79sq2fWP2OkAd/vjCrhMdZ9fiSwMlWeC6J8OAqg==
X-Google-Smtp-Source: AGHT+IHqq1mTRidFLNQEb7HpW0eLawGramZ1KpOhAKucq53YmrDkCsZ18b1pjovT71bTsZBzwbPMCA==
X-Received: by 2002:a05:6402:42c6:b0:5e5:36b3:e822 with SMTP id 4fb4d7f45d1cf-5e8a080e28dmr17638660a12.24.1742323270044;
        Tue, 18 Mar 2025 11:41:10 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816b2a683sm7981788a12.81.2025.03.18.11.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 11:41:09 -0700 (PDT)
Message-ID: <aa278922-5fac-4f47-acc2-25cc2c133365@gmail.com>
Date: Tue, 18 Mar 2025 20:41:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
 <289795d5-49ae-4789-8f14-b2d016843a53@gmail.com>
 <b972a60bb0b04b5f817047027970d896@realtek.com>
 <0ac48cfe-dc7a-442f-b893-41416cd3017d@gmail.com>
 <095328518444426887e039202fa8c609@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <095328518444426887e039202fa8c609@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2025 04:06, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 17/03/2025 05:01, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>
>>>> Tell the chip the maximum AMPDU size supported by the AP. This greatly
>>>> improves the TX speed of RTL8814AU in the 2.4 GHz band. Before: ~90
>>>> Mbps. After: ~300 Mbps.
>>>>
>>>> Add this configuration for all the chips, even if it only has an effect
>>>> on RTL8814AU in my tests. Surely they all need this.
>>>
>>> The hardware default value of REG_AMPDU_MAX_LENGTH is 0xffff (unlimited)
>>> for most chips. It seems like RTL8812A/RTL8821A are also exceptions, so
>>> at power on function they do
>>>     rtw_write32(rtwdev, REG_AMPDU_MAX_LENGTH, 0xffffffff);
>>>
>>> I feel RTL8814A has similar setting, so maybe you can just add similar
>>> stuff.
>>>
>>> By the way, the AMPDU is controlled by TX descriptor basically:
>>>       pkt_info->ampdu_factor = ampdu_factor;
>>>       pkt_info->ampdu_density = ampdu_density;
>>>       pkt_info->ampdu_en = ampdu_en;
>>>
>>> Since you didn't change this part at all, I still feel setting
>>> REG_AMPDU_MAX_LENGTH to 0xffffffff can fix low throughput problem.
>>>
>>
>> I tried 0xffffffff just now and it doesn't work. It's the same with
>> both of my routers. They advertise a maximum AMPDU size of 64 K.
>> I can't just set it to 0xffff either, because then the upload speed
>> in the 5 GHz band suffers a lot. The dual band router advertises a
>> maximum AMPDU size of 256 K in the 5 GHz band so it gets a value of
>> 0x3ffff.
> 
> Not sure if 0xffffffff is a special value. Since this is a limit of
> AMPDU length, you can set a constant large value such as 0x3ffff you 
> have tested. Is there special case it can't handle?
> 
> 

0x3ffff is not good for the 2.4 GHz band. The upload is only ~90 Mbps
with both of the routers I tested. Same with 0x1ffff. Only 0xffff
works well for them.

0xffff is too little for the 5 GHz band. The upload speed is ~200 Mbps
less than with 0x3ffff.

I guess if you really don't want this patch I can hardcode 0xffff and
0x3ffff in rtw8814a_switch_band(). I just don't know if all access
points will be happy with that.

