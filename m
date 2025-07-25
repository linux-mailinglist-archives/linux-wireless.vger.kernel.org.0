Return-Path: <linux-wireless+bounces-26011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A5CB1161B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 03:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8C3AC2B31
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 01:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409F632;
	Fri, 25 Jul 2025 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAJwl59q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D020E204083
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408579; cv=none; b=H47wQuQsELAEL+8x6/RrHOuXOBXQwIkp1K/hiX0v4cLzxkAePxg4JezMjETt70e8Q5eQT6tD12pVjwm06FcBXCyDlvkKXx/yV9BaYtIILKG5k+IlrLrts5BL8LfaQp3efIWT3NyUy69uxDe34J0kk8ubJf0Na0jVnuBlmtKMt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408579; c=relaxed/simple;
	bh=BNaw79ZxGkTEeKkkRGmTHHpiAiTq8DxMhK1qbZKSlHI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WLIx1bjvyvVHjDLaj7qUfAhlCDg7MrNQ6jNMYo6HSnj8Nrp8TwPw4ph9nozQb8Ra3CVe6Hd5mFOdYzyWlvg4Mctgo6Du9tYjJYFFRecuHqDcvdOrv2k9tmZKMxsGGHaz0b2ML9CaCaiudR8OUc83tXkCwi1FNWtasTY6VorNd/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAJwl59q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753408574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HX/M0A4s/i+cg+i791MzBz3fGhd28OWvCamyNFpBGKU=;
	b=bAJwl59q+SHdiTQzACJIkmPbKjI0fyusHZrjv5dKfJACvJW460SoXwgr/XMwbssvyhgASf
	j7PheOFnIx29BCJeBYtBRX+pGJXmOQH7tZlklCE52cyQI9zJBI5Rl/gu3BStx1CCm8o/pa
	X28MktljYvdMfACZF9788Wk63P+502I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-UCoQdEOLOx24G2hO5Jwl8g-1; Thu, 24 Jul 2025 21:56:12 -0400
X-MC-Unique: UCoQdEOLOx24G2hO5Jwl8g-1
X-Mimecast-MFC-AGG-ID: UCoQdEOLOx24G2hO5Jwl8g_1753408572
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fad9167e4cso37541496d6.1
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 18:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753408571; x=1754013371;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HX/M0A4s/i+cg+i791MzBz3fGhd28OWvCamyNFpBGKU=;
        b=N982iCtELzOVW/mYNuhWTDlGSVGMM72LCK+ApdY8rwpUV/oGxL+xSupORrlRLWgv1S
         SLguIZSOEjlTqQX1o81ErX9uCuXFzMoIpnABH00g9M8Jelnte7sIpIYx9GEKw1zOzkui
         HK9WFBTk5gjPpJCzt+3XZd1j5WsNdZD631Uk2CMDqVn/oTRr1AZGt0HmcQxOJnkxSpWw
         c/PP58uc4klneIczkuMndLY2EtEQV7xrOOV7nnSJJvzzTRK6+1G+7dfWMuDg/KBjrfdi
         ykV1CZhcz6FRgtBbbsJVYpOQvIMyf7PitOgOTHLDz7EpVtOW1Rf1ojGIlqtRHaHYNlV4
         h1dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYMG4DY/zPsfTl8ENSCIB24iDtozSHo3LAr/drDkXR+rC37UahZOaxNEaECULtqt/xdSf8jyntfUo8TWk2eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIH9I6QJPPyYOZJIOVjNuXf+g3f0619btYN2/rmEMsCife8JNm
	Be/yC4fT2Jc+kG3z9o1Ow+r4BNweXZ5b10zebbWEyfJII2/vZCPAthfStDFHJDs027KCq0pN2xB
	V+IYOcAqa0Mlkf49jFg6o9ZJnv6WIinAaf915O+2lIWeaFYD7x5icLmj2kS8dL0Aop2+vC9VeyE
	5l+s4=
X-Gm-Gg: ASbGncsql0LfcyyUYfnWqe5zVtQw1VJ88yfywrZ6gFb2Ec/j64obgDnXsbBnq254cWv
	cJMIEPCR5OfoDKD+tm/RcxRflVhMKHhHVBObaytaSgD2NIoDPNqU1rrv7us1RevChi1oWnMCc0n
	+M0Kx4DkNDzeVBlJVXXJl5v/rjnRWsvMc74oUNcV3lCJfIxgmRW6IchrgaY7hvs4tgsLg3ZqQM+
	KPjYfxfeUXxSQBm5q+jeBsPOFXLvY/fk71hk6zKsdmLQ7bZFm/tOYPxRz+fyUqs6NamLuaO5GUX
	4uoPqxWiVJpOm8pdyB6vtAUeW2pMohzVbrUu717tYzzf2SsLTWdYXWMuHMsv7SLzEnh2s0xSGHt
	hTxTTtJ6rkA==
X-Received: by 2002:a05:6214:2302:b0:6fa:ce27:5975 with SMTP id 6a1803df08f44-707207129b9mr2115986d6.22.1753408570618;
        Thu, 24 Jul 2025 18:56:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF88ZMD9aIpYyRLTeemGCAYKFRBf7r+s4dduG/5AHuHLCteZ88xEkXMyHvZw6F4f3mNaOEyUg==
X-Received: by 2002:a05:6214:2302:b0:6fa:ce27:5975 with SMTP id 6a1803df08f44-707207129b9mr2115696d6.22.1753408570264;
        Thu, 24 Jul 2025 18:56:10 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70713e0ff62sm16717736d6.96.2025.07.24.18.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 18:56:09 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <51ab2b78-a409-4201-97a0-30e976571df8@redhat.com>
Date: Thu, 24 Jul 2025 21:56:07 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
To: Thomas Gleixner <tglx@linutronix.de>, Waiman Long <llong@redhat.com>,
 Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, will@kernel.org, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 John Ogness <jogness@linutronix.de>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx> <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
 <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
 <aIKEfIjYBPzlE7y7@duo.ucw.cz>
 <6c5e70a8-2db2-4fa6-8a42-35033e480293@redhat.com> <871pq5qlgj.ffs@tglx>
Content-Language: en-US
In-Reply-To: <871pq5qlgj.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/24/25 6:21 PM, Thomas Gleixner wrote:
> On Thu, Jul 24 2025 at 15:22, Waiman Long wrote:
>> On 7/24/25 3:07 PM, Pavel Machek wrote:
>>>> The lockdep warning just means that console_owner_lock is acquired both in
>>>> softirq context and in task context with interrupt enabled. That can leads
>>>> to deadlock. So the remedy is to always take console_owner_lock with
>>>> interrupt disabled, i.e. with
>>>> raw_spin_lock_irqsave/raw_spin_lock_irqrestore.
>>> So you suspect problem is in the printk code?
>> This lockdep problem is likely unrelated to the IRQ flag problem
>> reported in the original email as it shouldn't affect the IRQ flag.
> Wrong you are ... :)
>
Sorry for coming to a conclusion early without looking more deeply into 
the printk code. I do admit that printk() isn't an area that I know 
enough about.

Will look harder next time.

Thanks,
Longman


