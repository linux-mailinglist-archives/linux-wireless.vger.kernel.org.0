Return-Path: <linux-wireless+bounces-15294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552AF9C8606
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 10:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C30D1F21390
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F31F6662;
	Thu, 14 Nov 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="T49jF7lh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDCB1D1724;
	Thu, 14 Nov 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576294; cv=none; b=PQZ+MRRvun9ilN4rR4Dv+IKLk2WsPjUxLL/32DrXi36I9G/mmGbfSGMcrKtbkD1I7EJgoBlY8DOz5rpIVDis/tarEuS9ihPvjpqjzRNRgl08hmtqvGHiAHJ2nJ1zBSR/AbhI5Erd9Uv70AfcwHDsE7AlVM4tzDAplTseCn2y6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576294; c=relaxed/simple;
	bh=QT9nv+7ABxLfW7m7zCw7AcnI99f1A1A7+i1IdkJUoeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubj3XsWaM+Y9LLkSR7jiAVShohy4OgajA/KzXNYfyJDQh3PouCJLwAhxCin0Qzg5ghc0wdRDrgz7ASrfG6HoA2Wh314fZJr1BjN27VzTyQHNFD5vP1iZgZzCpRKVHbkQLR1iXb+ia3d+WsSrFPf3Eppp2RQPDy+u4I7D9V8J56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=T49jF7lh; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=0XM5kyRcvHvf7K0opkbIiWBMSzDYHY1fTptPz17A5EI=;
	t=1731576292; x=1732008292; b=T49jF7lhW7zDnDA5B8mDrz91t8UJtokJ2F2ZJWGHzQbRD1v
	u2oNuYROOpx3VUPQfOLZ+CpExKdm5HuLdH+KHXNMKwLrhX2jFPppMsJNyrqLc0YhpFhxH7v7N+CzU
	RFAZj7jogLYTCHvewVj0cJKeFudM0v/jhKoUXNPGPou9m1Xiyfgycj96rCwzlwD4e+cFFFPtjrn87
	1PhRGHBH71Z9+8dWNtT3WuNtgDPtush0EpwJ4n6E24/hKM8sDbPcH8W68MEcOssceBUeuPB0EpFrT
	c7srI6W/WCisJHuSxl5p3B2C6vfjAIYgWmyCqj0xWKeMytCRpitbxIPOSJ+LWY4g==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1tBW5q-0003ec-Dn; Thu, 14 Nov 2024 10:24:50 +0100
Message-ID: <5f64abc6-017f-4283-bf08-dba1aea28e9d@leemhuis.info>
Date: Thu, 14 Nov 2024 10:24:49 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] The iwl4965 driver broke somewhere between 6.10.10
 and 6.11.5 (probably 6.11rc)
To: Kalle Valo <kvalo@kernel.org>, Alf Marius <post@alfmarius.net>
Cc: Andrey Batyiev <batyiev@gmail.com>, regressions@lists.linux.dev,
 linux-wireless@vger.kernel.org
References: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com>
 <87wmhg61yp.fsf@kernel.org>
 <CAEQQxWx7PXw3O_j1FWn7G+DhUUXt3sEB0qDyA2+udRQ6r28FUA@mail.gmail.com>
 <4f689121-f2c1-45ec-bd5b-105a770af935@app.fastmail.com>
 <87ttcauv7x.fsf@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-MW
In-Reply-To: <87ttcauv7x.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1731576292;63491355;
X-HE-SMSGID: 1tBW5q-0003ec-Dn

On 14.11.24 08:32, Kalle Valo wrote:
> "Alf Marius" <post@alfmarius.net> writes:
>> [Andrey Batyiev]
>>> Hello everyone,
>>> I've only tested it on my 3945. I have no equipment to test it on 4965, sorry.
>>
>> Yes the commit message says "Tested on iwl3945 only."
>> ..which I did find a bit strange. Is it normal to deploy code to the mainline
>> that is untested? Why was this also applied to 4965?
>>
>> I'm just asking questions here, as I have no direct knownledge of C or
>> kernel driver programming. I've 20 yrs of web-dev experience though
>> and know from experience that shipping untested code is a bad idea.
>>
>> Anyway, not trying to point fingers here! Just curious to find those who
>> wrote the actual code, maybe get some info on why this was added
>> and if it is really important. If not, maybe a revert is in order
>>
>> Regarding testing, I obviously have a laptop with the 4965 card and
>> I'm more than willing to test stuff out if needed.
> 
> I sent a revert to fix this:
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=11597043d74809daf5d14256b96d6781749b3f82

Many thx for taking care of this!

> If all goes well this should be in v6.13-rc1.

Sigh. FWIW, I think that should have gone straight to mainline, as the
situation afaics is quite similar to this one where Linus clarified that
he wants such fixes even at this stage of the cycle:

https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/

Given that this is a hardware that likely is not much in use any more I
guess it's not making much noise about besides this mail.

Alf: that patch lacks a stable tag, so there is no guarantee that the
fix will be backported to 6.12.y and earlier; but it likely will due to
the Fixes tag. If it wasn't backported within 2 weeks after 6.13-rc1 is
out, please speak up.

Ciao, Thorsten

