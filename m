Return-Path: <linux-wireless+bounces-8167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B78D1626
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 10:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2534282018
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A19973441;
	Tue, 28 May 2024 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="lA/9sAlR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C471DA22;
	Tue, 28 May 2024 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884473; cv=none; b=CX7FdvODHw18KiKNiM5BcrxmeE7sLNdDnKnCAfM4skXQxe0JV/wtx27Bhy7yrfHnEZ33PzM/qOooQUHEdkk+UQFdQNo5/u9zcTVp13msj0ATU71+s+TrmIrqv49lhCS+ppbogGoMDIRcQDDcV1184BVul91iP/fA/g0ZX52EODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884473; c=relaxed/simple;
	bh=Iie6j6GHWhlLxfJ6VsQC39NyU0UrznXxjzkwnIv1Krs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwQnPSo7ytyL4feV43hfQt0++8YhENs2IeC9Fy/EPhLclGq6UWcyR2D5Iix3QlgGi0wxzoblSON9IN5+D3ZTAZ0+/jxWGttHn+1l1LIblgjsKILlAGvtQYC5zpt2+/kuJvqD8w5aTjlfp6UDW7uFVtNgAJPctxVVgigx+Wm+Abk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=lA/9sAlR; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Ast9z8epAyjbn/LztXgoRrxHexr964mFVCYjeYD0PFQ=;
	t=1716884470; x=1717316470; b=lA/9sAlRJJNSPqL3VLp056Bk/h5yM8xFRpj5l01BQCPz0xj
	NDudT5CwR4bPpJG4AuE5474ztwXZ8Lo4YDYJGQ7rs2uWVKzm824UXiFgJt32bE2CEQGPybPPb78vG
	UBCEgvMDpv4smvT3XzdFTr42ojJmSBGSw6Kiv/oCFv0Fc0v8gAmVQ3YoPh11bStDftbHqibv8N3KO
	ak4M99+zjojNlebmTiwHrdguchBswSM3Iuf5xjTcq1N8rAStIGjEj5bm1QN3H+5Z/IXS4rOcFEtS3
	SvNslxV7m9z9+98jXdBMTWu/HqjvcR0FCqgufH3RQtgHoEdbtWT6som8jgAJ0ulA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sBs4x-0005Pr-1M; Tue, 28 May 2024 10:21:07 +0200
Message-ID: <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
Date: Tue, 28 May 2024 10:21:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
To: Johannes Berg <johannes.berg@intel.com>, regressions@lists.linux.dev
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 Savyasaachi Vanga <savyasaachiv@gmail.com>,
 Christian Heusel <christian@heusel.eu>
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716884471;72153b97;
X-HE-SMSGID: 1sBs4x-0005Pr-1M

On 28.05.24 00:01, Christian Heusel wrote:
> 
> Savyasaachi reports that scanning for other stations in monitor mode
> does not work anymore with his RTL8821CE wireless network card for linux
> kernels after 6.8.9.
> [...]

So back to the real problem:

@wifi developers: Is there some bigger problem in 6.9.y related to
monitoring mode that is affecting a lot of drivers/users?

I'm asking because I noticed another report that sounded related. To
quote: https://bugzilla.kernel.org/show_bug.cgi?id=218884

"""
>  Michael 2024-05-24 17:04:51 UTC
> 
> Some features are broken since kernel 6.9.1 when running monitor mode.
> 
> First bug:
> Switching a channel via "NL80211_ATTR_WIPHY_FREQ" does not switch the channel/frequency.
> 
> That is not a device driver problem, because all device drivers (Mediatek, Ralink, Realtek, ...) are affected.
> 
> To reproduce:
> set monitor mode (by iw)
> change channel (by iw)
> check if channel has been changed (by iw)
> record traffic and check radiotap header (Channel frequency)
> 
> More information is here:
> https://github.com/ZerBea/hcxdumptool/discussions/454
> https://github.com/morrownr/8821au-20210708/issues/133#issuecomment-2125425552
> confirmed by other users:
> https://github.com/morrownr/8821au-20210708/issues/133#issuecomment-2125392151
> 
> 
> Second bug:
> frame injection is broken
> 
> To reproduce:
> Try to send a 80211 frame via raw socket (PF_PACKET). It is not transmitted over the air
> https://github.com/ZerBea/hcxdumptool/discussions/454
> 
> 
> In monitor mode, none of the WiFI tools (iw, Wireshark, airodump-ng, aireplay-ng, hcxdumptool, hcxlabtool is able to switshc the channel or to transmit 80211 frames since kernel 6.9
> 
> [tag] [reply] [−]
> Private
> Comment 1 Michael 2024-05-26 09:00:58 UTC
> 
> BTW:
> Testing monitor mode mode these days is no easy task, because most of the device drivers are not working as expected:
> https://bugzilla.kernel.org/show_bug.cgi?id=218528
> https://bugzilla.kernel.org/show_bug.cgi?id=217465
> https://bugzilla.kernel.org/show_bug.cgi?id=218528
> https://github.com/openwrt/mt76/issues/839
> 
> And now, since kernel 6.9.1, the mac stack is broken, too.
> 
"""

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

