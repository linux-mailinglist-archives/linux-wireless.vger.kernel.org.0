Return-Path: <linux-wireless+bounces-2247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2E0832837
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 11:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FD91F21ADE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3A4D582;
	Fri, 19 Jan 2024 10:51:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA694CB50;
	Fri, 19 Jan 2024 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661497; cv=none; b=OHS5LYU32lhPn1NrC5t57TcJWWpRMprIXezvrrSrEDELSlPPsDXJDq3fhME3Lhx84/4n/srnCs+RyFiz2DFZdJVlzbt+wo+HTcLYJJNgtGgdKdIjvfOR+pUcOMtSvKD/2MI5HjINHLTZds0ykSBbCO/IXm5Mh0mjAaI2u/4PvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661497; c=relaxed/simple;
	bh=4A6eeS7kx7TfcCJmouZOZARrlVZqniTcsFUoVz0mpQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O9hhJCHtfPHSOTpq/eX58MvI45byMZRIAqoJL7Cqp32K3ZR4iai0iPTM4Jww6Eu8hMKIeo1pcOAILJyjWVzj1fuqxE5Sa4d4K5E9o/u31SQO5u4rBO1UyMqifiZ0CQ1QFdSNEqGu1TbPvCAdLg7rjPGAf5g/qiuE+wKEb1gDIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rQmTF-0002lL-Lp; Fri, 19 Jan 2024 11:51:33 +0100
Message-ID: <a2ccb118-6e80-47f2-af51-c4490c0d7dc1@leemhuis.info>
Date: Fri, 19 Jan 2024 11:51:33 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7 broke wifi "AP is in CSA process, reject auth"
Content-Language: en-US, de-DE
To: linux-wireless@vger.kernel.org, regressions@lists.linux.dev
References: <CAJvGw+DQhBk_mHXeu6RTOds5iramMW2FbMB01VbKRA4YbHHDTA@mail.gmail.com>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAJvGw+DQhBk_mHXeu6RTOds5iramMW2FbMB01VbKRA4YbHHDTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705661495;1d96f1f6;
X-HE-SMSGID: 1rQmTF-0002lL-Lp

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 15.01.24 15:39, coldolt wrote:
> I'm on Arch linux, updated the kernel from 6.6.10 -> 6.7.
> 
> Now it doesn't connect to my 5GHz wifi, to 2.4GHz it still connects.
> Also the earlier kernel version still works. Output from "sudo dmesg |
> grep -i wlp2s0":
> 
>> [    6.049600] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
>> [  131.095861] wlp2s0: AP is in CSA process, reject auth
>> [  132.143170] wlp2s0: AP is in CSA process, reject auth
>> [  133.599906] wlp2s0: AP is in CSA process, reject auth
>> [  135.549325] wlp2s0: AP is in CSA process, reject auth
>> [  145.510438] wlp2s0: AP is in CSA process, reject auth
> 
> I notice that the commit c09c4f31998bac, which was added to kernel
> 6.7, introduced rejecting a connection with that error message "AP is
> in CSA process, reject auth".

#regzbot ^introduced c09c4f31998bac
#regzbot title wifi: cfg80211: can't connect to my 5GHz wifi anymore
#regzbot monitor:
https://lore.kernel.org/all/20240118111941.549593-4-johannes@sipsolutions.net/
#regzbot fix: wifi: cfg80211: detect stuck ECSA element in probe resp
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

