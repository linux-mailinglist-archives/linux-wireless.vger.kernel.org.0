Return-Path: <linux-wireless+bounces-8339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A393C8D5A12
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 07:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78011C22224
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 05:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75E47BB19;
	Fri, 31 May 2024 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="vcWgK1qH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E69C7C082;
	Fri, 31 May 2024 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135092; cv=none; b=l4qUVEqyfrirDrlKh7blQg3xK+hx52HzlaB2TPW/ntxYMf03/4r3og7OHPy/4INQs/uIpODXTlwR6ah5P/laGtfxMH3+Nhq8uUGKfgiCjoS4d2L3nflCzj1zPMrXEImXp+yQ9shgnuA3jVwoCslg6SLU65hVoHSc02cHNsumuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135092; c=relaxed/simple;
	bh=S9hU1h5dTbeOG44Fotcg31KZXSTZ6NX4uuM7MQ8+ac8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eA9iQRkW59+z04Am1nT+Ly5IDhkOK9HFPug8MnMre9C0z9t6r9O0FbNzeWfc4i+ChJBayFXv6c10nh29RmHERlrFa2GUy4f7IRj4RPzTqTjdRm0ra48mfO5liFsLO/l/ueFGNjZs/KUg8ZGE/9d9fI8CaDVBEmCtrOYNEzsx4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=vcWgK1qH; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=wZQpO6nF9YmmuEdpYgQY+jOsHRmogML3JDOiCshrVUQ=; t=1717135090;
	x=1717567090; b=vcWgK1qHGRBw2puqtN9pcnWb61214k1z7BZKzcprYRm0Y0bFH/0owAWDZ11Hc
	ISjUonbYdfqiMYH+2ODnswLRxcEySV48PaZ71AqtEv+hxCgqOT/BlLzuj2g4efjNvWm/f0hRMLicf
	cnBLLen+RtdOSdAOMP9DrdYsZNTI9WkTJ5LPxgJkI8iQHdkmR5UUqbm1h60/0jU/wdNTBErybEDqo
	h5cPXUfAwth8ccfr9FwMA54lZLn63yhTijbTaNa9XsrSLejSruvAUR6gFistxA0AUXtaW08riYDJu
	jbGYpdGcMInKjaWv/NNi8ZhrMBNR5RMcdPIY7HR7VRqgYfQHvw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sCvHE-0006Em-0i; Fri, 31 May 2024 07:58:08 +0200
Message-ID: <809d2332-625e-4a46-a77e-ca2e49b0d651@leemhuis.info>
Date: Fri, 31 May 2024 07:58:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Savyasaachi Vanga <savyasaachiv@gmail.com>,
 Christian Heusel <christian@heusel.eu>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>, regressions@lists.linux.dev
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
 <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717135090;603c1533;
X-HE-SMSGID: 1sCvHE-0006Em-0i

On 28.05.24 10:21, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 28.05.24 00:01, Christian Heusel wrote:
>>
>> Savyasaachi reports that scanning for other stations in monitor mode
>> does not work anymore with his RTL8821CE wireless network card for linux
>> kernels after 6.8.9.
>> [...]

Hmm, the wifi developers did not reply to the inquiry quoted below. :-/
Guess I'll have to take a closer look a the linked bugzilla report then.

Anyway: Christian, Savyasaachi, I noticed a submission of a patch
referencing the culprit with a Fixes: tag; it talks about package loss,
but it still made me wonder if that might be related somehow:
https://lore.kernel.org/all/1fabb8e4-adf3-47ae-8462-8aea963bc2a5@gmail.com/

Ciao, Thorsten

> So back to the real problem:
> 
> @wifi developers: Is there some bigger problem in 6.9.y related to
> monitoring mode that is affecting a lot of drivers/users?
> 
> I'm asking because I noticed another report that sounded related. To
> quote: https://bugzilla.kernel.org/show_bug.cgi?id=218884
> 
> """
>>  Michael 2024-05-24 17:04:51 UTC
>>
>> Some features are broken since kernel 6.9.1 when running monitor mode.
>>
>> First bug:
>> Switching a channel via "NL80211_ATTR_WIPHY_FREQ" does not switch the channel/frequency.
>>
>> That is not a device driver problem, because all device drivers (Mediatek, Ralink, Realtek, ...) are affected.
>>
>> To reproduce:
>> set monitor mode (by iw)
>> change channel (by iw)
>> check if channel has been changed (by iw)
>> record traffic and check radiotap header (Channel frequency)
>>
>> More information is here:
>> https://github.com/ZerBea/hcxdumptool/discussions/454
>> https://github.com/morrownr/8821au-20210708/issues/133#issuecomment-2125425552
>> confirmed by other users:
>> https://github.com/morrownr/8821au-20210708/issues/133#issuecomment-2125392151
>>
>>
>> Second bug:
>> frame injection is broken
>>
>> To reproduce:
>> Try to send a 80211 frame via raw socket (PF_PACKET). It is not transmitted over the air
>> https://github.com/ZerBea/hcxdumptool/discussions/454
>>
>>
>> In monitor mode, none of the WiFI tools (iw, Wireshark, airodump-ng, aireplay-ng, hcxdumptool, hcxlabtool is able to switshc the channel or to transmit 80211 frames since kernel 6.9
>>
>> [tag] [reply] [−]
>> Private
>> Comment 1 Michael 2024-05-26 09:00:58 UTC
>>
>> BTW:
>> Testing monitor mode mode these days is no easy task, because most of the device drivers are not working as expected:
>> https://bugzilla.kernel.org/show_bug.cgi?id=218528
>> https://bugzilla.kernel.org/show_bug.cgi?id=217465
>> https://bugzilla.kernel.org/show_bug.cgi?id=218528
>> https://github.com/openwrt/mt76/issues/839
>>
>> And now, since kernel 6.9.1, the mac stack is broken, too.
>>
> """
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> 

