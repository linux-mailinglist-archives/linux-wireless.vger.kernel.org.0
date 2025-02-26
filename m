Return-Path: <linux-wireless+bounces-19492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04C5A4672B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 17:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BA61882D3F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5250B2904;
	Wed, 26 Feb 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="r2a44Nfm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D442A8F
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588553; cv=none; b=eHU2dDxH+p/Wswq7efCnFZQf5NAAwjAwIJQnJ+AqP1Yt3iXnaHi63gb4FlCoKn1FEjxkSHrm5Gtqi47+D0I5oTm1QN/tGEMYgQ/ablMBnKUEVAgGwX1rW6hElHslO1WA5LyPgVSu9JhKNsIKpL0sKc45LXbI18SMlVeZQJ8+UI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588553; c=relaxed/simple;
	bh=3e7dVIn1p/TbysnevVyDajXRE3ZYVCJcx3x05dMdMRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IJe+7Xx+u7E+HIfRecx3+SkYS/Y1yu66/8nkUu0/7iN/3LvRoKzUXTie78Ldjprs/S4sMrvtyM6R2lOUeXPTNEa1vQaRrbODLFCGPek7eGG68P50yIUOiDFU0DYDlXM0GaGNiXvS+flPKaE6q8euanTd45oW62W5iyCq3UjNbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=r2a44Nfm; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
Message-ID: <8fa3ffd9-ebaa-4db1-8d1d-ed0cb6802872@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1740588160;
	bh=3e7dVIn1p/TbysnevVyDajXRE3ZYVCJcx3x05dMdMRE=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=r2a44NfmlA6fZXxF4jwyehpD76nZzbl/BwgNFj7uwEr3MVJf3+lNsVfdjqgHwLOMN
	 py4dI1aIpZfZOe1dRovIMk7YsQdQEqxyJphlVpuKAdteTeaplTSaIuqxBFv6M8+9yE
	 TUo262gKvA8xOAUbEuj0MWO+Nh48/8NQdmDzLd1o=
Date: Wed, 26 Feb 2025 17:42:40 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Convert mac80211 to TXQs only
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20250220104426.82011-1-Alexander@wetzel-home.de>
 <1fa2f33a67ee1c6e537095888df44c7adeae64d2.camel@sipsolutions.net>
Content-Language: en-US, de-DE
From: Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <1fa2f33a67ee1c6e537095888df44c7adeae64d2.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.25 16:37, Johannes Berg wrote:
> On Thu, 2025-02-20 at 11:44 +0100, Alexander Wetzel wrote:
>> This series switches all TX handling in mac80211 over to TXQs.
>>
> 
> I really wanted to apply this, but looks like it's nowhere near ready.
> 
> There were a number of compiler and sparse warnings, which I mostly
> fixed, but also testing with hostap/hwsim tests blows up completely,
> e.g.:
> 
> ========================================================
> WARNING: possible irq lock inversion dependency detected
> 6.13.0-rc7-01678-g0d8fd15558f7 #110 Not tainted
> --------------------------------------------------------
> mac80211-phy0/114 just changed the state of lock:
> 000000006c784f08 (_xmit_ETHER#2){+.-.}-{3:3}, at: __dev_queue_xmit+0xb0c/0xc83
> but this lock took another, SOFTIRQ-unsafe lock in the past:
>   (&local->active_txq_lock[i]){+.+.}-{3:3}
> 
> 
> and interrupts could create inverse lock ordering between them.
> 
> 
> other info that might help us debug this:
>   Possible interrupt unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&local->active_txq_lock[i]);
>                                 local_irq_disable();
>                                 lock(_xmit_ETHER#2);
>                                 lock(&local->active_txq_lock[i]);
>    <Interrupt>
>      lock(_xmit_ETHER#2);
> 
>   *** DEADLOCK ***
> 
> which actually seems to happen as a deadlock, since my tests are no
> longer making progress at some point.

I checked the hostapd tests with the series, it was working for me...
But besides the kernel the rest on my testvm is roughly two years old, 
including hostapd. AND my attempt to try the patches on my openwrt 
router on the weekend also deadlocked after some minutes. I suspected a 
porting issue so far, but with that I better start looking elsewhere.

I'll try to reproduce that. Are there some instructions somewhere to get 
a comparable testsetup to the one you are using?


Alexander




