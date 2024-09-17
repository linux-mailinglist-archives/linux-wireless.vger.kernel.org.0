Return-Path: <linux-wireless+bounces-12921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F34497B224
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 17:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC97B2C296
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6309717C233;
	Tue, 17 Sep 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ZuRJYk7n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8936183CB7
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586827; cv=none; b=N1uS7NwytkbcnTpdPYxKjKG7uRB7JqEue/ubP/kKOeB16o5sPLRqeB5xryRUL+no3r/viy2GtsM5bSTV0ONRi0nBAKJ7ECz0WD/UTU3xv6d9XW8pOiJWs7QvdlnrynIKz7tWo7gtCp8qEH8AkEVzkJ1/vSovr/8GU55xpkW/5T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586827; c=relaxed/simple;
	bh=kqCiNwF7fh1fXnAOdiB+Ejs046uzkWy4f5THcKiUW2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGU6paISv7SfesMjKblcTY5BWBN92xVMrT1ekW3RqRJlmnC2z72aX15EXYhaCEXRwbfY1H5AEadpC0cvuUHu9P+Tkwi3yrG9psnFg0pP6kGmCsqRkKen/IN5vPCcipemvakCA3YH5IY2kSoJMwd+6vefP/VJcKwX/36KDuk6Pd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ZuRJYk7n; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9CA14780094;
	Tue, 17 Sep 2024 15:26:54 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.39.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 373FF13C2B0;
	Tue, 17 Sep 2024 08:26:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 373FF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1726586814;
	bh=kqCiNwF7fh1fXnAOdiB+Ejs046uzkWy4f5THcKiUW2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZuRJYk7nEeijnrZrVwrXIrNVez+EF+Nj75PzhTcWqepeU8yD5lEG1JBOJ/ELW5lDF
	 7QoyK1VL3rHtuOkyKm2uJ1PSHtqIvMwn7ZRF0um/u3jOhbkLyX2Y/Kwnqe+Lrno+Rh
	 xSrfdXciNhADXj5xo9rnsHYy3kRt91MiqRWEYcGU=
Message-ID: <19eb0b33-fff2-493f-a7be-c9e890d0da83@candelatech.com>
Date: Tue, 17 Sep 2024 08:26:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/6] wifi: mac80211: notify driver about per-radio monitor
 enabled state
To: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
References: <8b11fddca38ea82b48ebe93a898582e698069f14.camel@sipsolutions.net>
 <47BF11DD-ECD1-4314-AD1B-B58A99724DFB@nbd.name>
 <8a0cb794de71bab324bdc1bb68ba58488ab925b3.camel@sipsolutions.net>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <8a0cb794de71bab324bdc1bb68ba58488ab925b3.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1726586817-FG5Jjza1zWaF
X-MDID-O:
 us5;ut7;1726586817;FG5Jjza1zWaF;<greearb@candelatech.com>;20e01846ddffb15f370631a0b8aff2f7

On 9/17/24 01:13, Johannes Berg wrote:
> On Fri, 2024-08-23 at 13:26 +0200, Felix Fietkau wrote:
>>
>>> On 23. Aug 2024, at 12:16, Johannes Berg <johannes@sipsolutions.net> wrote:
>>>
>>> ﻿On Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
>>>> This allows monitoring on one or more radios while minimizing performance
>>>> impact on the others.
>>>
>>> But why are you doing it this way? You could already solve this entirely
>>> with the driver by setting WANT_MONITOR_VIF and dealing with that, I'd
>>> think? At least after this series.
>>>
>>> I generally don't like hw->conf, it just hasn't really matched reality
>>> for years with all kinds of new concurrency capabilities. At the very
>>> least you'd have to write more text here to convince me that we want to
>>> add something to it ... :)
>>
>> I really don’t see how WANT_MONITOR_VIF helps. It seems completely unrelated to me, since it only creates a single driver visible vif, if there are no non-monitor vifs on the phy.
> 
> Well, it's true that it only creates one towards the driver, but that
> one vif can also only be bound to a single channel context, and
> therefore a single radio.
> 
> If we actually want(ed) to support monitoring on different radios
> simultaneously we'd have to change mac80211 quite a bit, and probably
> introduce multiple virtual monitor interfaces. Internally, we _always_
> have it now, to be able to bind a channel context, so we'd actually need
> multiple - one for each possible parallel channel.

I definitely want to be able to sniff on the individual underlying channels,
and not have the traffic from the different underlying radios mixed (unless
specifically requesting that feature somehow).

 From user-space perspective, having multiple monitor vifs seems the way
to do this, as that is how it works now.

Thanks,
Ben

> So that's why I think having WANT_MONITOR_VIF helps - you can assume
> today that only one chanctx can be used for monitoring, and once you
> have the monitor vif in hand, you know which one it is. Therefore you
> know which radio it is, and can adjust your offloads/etc. accordingly.
> 
>> I want to be able to control, which radios I want to capture on, regardless of which vifs are already active on the same phy.
> 
> Sure.
> 
>> A global monitor enable/disable status means that I can’t prevent monitor-incompatible offloads from being disabled on radios that I’m not monitoring on.
>>
> 
> Yeah I'd just say don't use that state, but the presence of the monitor
> vif, and you can figure out which radio it's present on.
> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


