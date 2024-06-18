Return-Path: <linux-wireless+bounces-9213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E2790D9D9
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815541C215B3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7E882D6D;
	Tue, 18 Jun 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WT46ZamZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62856B8C;
	Tue, 18 Jun 2024 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729451; cv=none; b=LzhZ1aD9AkOz4AghaUXIwXwPArr4EdC9wSj82TIyJowEUjxFEHmIhEwLlDX64llh5HV70SN11H2GChi2tJE8hKcq/wCXrxBHknpq9fesYMKflqdm+dzW3GYLmQZrhvnoIJ3eRCVt6TBm4oBzb8/unX3bN7uC91wPj8yKHQ/XMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729451; c=relaxed/simple;
	bh=WCWnF1tCWCkGAB1OhE8HbNrmsX/frO3b1N++OWubed4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aoTtqS3xHyA3I9efgpV0ic6A9gszcicGII+uI4bZzEI0VJhi99GSi+wEJ3fbG90nM+ohZf1PykZAjbQ/J8EtmqOvQeS3hK/gsq/cu3K3ufTU1a7z0jbWddZ73TbZWlbRx121dz5J5wOTSHmLdOL8BLn0hDJPs+9tPSZppDdXnu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WT46ZamZ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IGoSHZ076289;
	Tue, 18 Jun 2024 11:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718729428;
	bh=/8JyMP0dEUxv10e4ddkxCVOvkktmSLVcKrhuuo33fBA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WT46ZamZQetWXNzI8f3Kyc2+Umajw3bN23/d6pGN6gnoVwi5648LviAiR+RcE/wXi
	 nG+T2qiDEzll6MBVMmvM26Bl6mQVox8tU8EdoBBeDJXJb0+hNYEikqZ0l8aESib5oa
	 +35GDRxv5DMVmV3Vr/Bgcydfe+/0sx/Pqf5T0fi0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IGoSCc003334
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 11:50:28 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 11:50:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 11:50:27 -0500
Received: from [10.250.212.197] ([10.250.212.197])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IGoPJD007094;
	Tue, 18 Jun 2024 11:50:26 -0500
Message-ID: <a8108b2a-fae5-408c-a187-3cb4b2887366@ti.com>
Date: Tue, 18 Jun 2024 19:50:25 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2] wifi: wlcore: fix wlcore AP mode
To: Kalle Valo <kvalo@kernel.org>,
        "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: Johannes Berg <johannes.berg@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>
References: <E1sClp4-00Evu7-8v@rmk-PC.armlinux.org.uk>
 <Zm1CKAKCnuc94oIi@shell.armlinux.org.uk> <87tthrn8gf.fsf@kernel.org>
 <ZnA4QpyOdcYxg8LE@shell.armlinux.org.uk> <87a5jimx0a.fsf@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <87a5jimx0a.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/18/2024 12:16 PM, Kalle Valo wrote:
> 
> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> 
>> On Mon, Jun 17, 2024 at 01:56:48PM +0300, Kalle Valo wrote:
>>> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
>>> 
>>> > I see all my TI Wilink patches have been marked as "deferred" in the
>>> > wireless patchwork. Please could you explain what the plan is with
>>> > these patches, especially this one which fixes a serious frustrating
>>> > failing that makes AP mode on this hardware very unreliable and thus
>>> > useless.
>>> 
>>> I'm just swamped with patches, I'll try to look at these soon.
>>> 
>>> I wish that TI would take a more active role in upstream, for example
>>> reviewing and testing patches would help a lot.
>>
>> I believe the problem has been that TI have had an attitude of "we
>> only support people using 4.19.38, if you can't reproduce the problem
>> there we aren't interested". To see the versions they support:
>>
>> https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7
>>
>> basically, all are ancient.
>>
>> They also appear take the attitude that all the kernel code is ripe
>> for them to hack about with - whcih is why this fix has had to be
>> reworked so it isn't removing NL80211_FEATURE_FULL_AP_CLIENT_STATE
>> for _all_ kernel wireless drivers!
>>
>> Also, I think they also require one to use their hostapd and
>> wpa_supplicant, probably for a similar reason. I know that in some
>> of the patches they've hacked in API changes...
>>
>> Then one can see the attitude of lock-step firmware and driver
>> upgrade - you can't use 8.9.1.x.x firmware with their older driver,
>> and you can't use 8.9.0.x.x with their newer driver. That, of course,
>> is not acceptable to mainline.
>>
>> So, given all this, IMHO it's probably a good thing TI aren't trying
>> to submit their stuff upstream... that is, unless they are willing
>> to learn how to "do things correctly".
>>
>> Maybe I'm being too hard on TI's wireless division, but that seems to
>> be what has been going on.
> 
> Yeah, the all you describe above is very common in wireless vendors :/
> But vendors do learn, Realtek is a great example of that. Let's hope
> that TI does too.

I can say that the driver for the next generation of chips (CC33xx) does 
not and will not require any modifications to mac80211, cfg80211 and 
supplicant.

I will also try to aid and review patches for wl18xx.

Michael.

