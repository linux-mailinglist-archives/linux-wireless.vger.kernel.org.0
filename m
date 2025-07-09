Return-Path: <linux-wireless+bounces-25071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE05AFDFCB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 08:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D25F37B0E0C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB9156678;
	Wed,  9 Jul 2025 06:05:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0726AABE
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752041154; cv=none; b=fh15mcwGiqXMGnIATlqXkkWJw709RpcR9wDPXLeO2+wE5g4w9c2o6hWb48GGj6z1EoeUK2TYATIVgITCRC6We2Vb6ocuzWJp2aclBDhUFsjGY+Yalz4Xdz7J60hkSJGxcnPmdpFbEV/JKk9cQAstocIeGlZXm13pQMJ7hjc04cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752041154; c=relaxed/simple;
	bh=mIG72ageji+RcV+rigjXBpCC2maRXuPAk0h+KEAiWaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4ChEnyhmwk588lICPi7vtJxCsjqdTfpncK8fykLOicZNwtLdchj9StRIUyXBNZM0GGE5LD5vtOun9BioxJXnWd8VihnR+ok2g2AdVn/bFaYol0hLW4ncTur+QQAUW1HINz9yg9Iyqj8T3+sT62wqsr+lfl+j0MI/lYt4Mdj1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7d1.dynamic.kabel-deutschland.de [95.90.247.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AC75D61E64845;
	Wed, 09 Jul 2025 08:05:42 +0200 (CEST)
Message-ID: <c0058c94-35c0-40fc-b23f-93864baa9d5c@molgen.mpg.de>
Date: Wed, 9 Jul 2025 08:05:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: make VHT opmode NSS ignore a debug
 message
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20250708105849.22448-2-johannes@sipsolutions.net>
 <00a86131-3258-4a96-b223-4be0d020a126@molgen.mpg.de>
 <abc76a87bf8b5fffcee18d64bfbd6c641c7739c2.camel@sipsolutions.net>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <abc76a87bf8b5fffcee18d64bfbd6c641c7739c2.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Dear Johannes,


Am 08.07.25 um 13:42 schrieb Johannes Berg:

>>> There's no need to always print it, it's only useful for
>>> debugging specific client issues. Make it a debug message.
>>
>> Excuse my ignorance, but I wonder if it’s a firmware bug (of the access
>> point), if this situation occurs?
>>
>> Also, I do have a problem with that Telekom Speedport 3, that sometimes
>> – despite still connected Wi-Fi – no network connection is possible, and
>> re-connecting fixes it. It happens much later to the message, so I
>> assume it’s unrelated, but no warnings would give me more confidence
>> into the Telekom router.
> 
> Either way it's a bug on the other side. It's basically saying that it
> wants to change the NSS (number of spatial streams) to a higher number
> than it ever advertised support for.
> 
> If you get it on the client side while connected to an AP then yeah,
> that seems like an AP firmware bug.
> 
> It doesn't seem that it'd be related in this case. Though I guess with
> my patch we'd stop printing the message and erroneously give you more
> confidence ;-)
> 
> It just doesn't seem useful to print the message - there's nothing you
> can do about it, it basically means we ignore it and keep transmitting
> with a lower NSS (which is fine anyway, it's subject to rate control and
> the AP cannot have any expectation on how many streams we really use),
> and so it's not actionable to the user in any way.

In some cases, people can contact the router manufacturer asking to look 
into their firmware.

>>> -			pr_warn_ratelimited("Ignoring NSS change in VHT Operating Mode Notification from %pM with invalid nss %d",
>>> -					    link_sta->pub->addr, nss);
>>> +			sdata_dbg(sdata,
>>> +				  "Ignore NSS change to invalid %d in VHT opmode notif from %pM",
>>> +				  nss, link_sta->pub->addr);
>>
>> As with my original patch, would printing the current “NSS value” be
>> useful? At least for me, who does not know how to get that value from a
>> running system.
> 
> We could, though I later realized you printed the wrong value (if
> anything, should have "link_sta->capa_nss"),

Sorry for mixing this, and thank you for spotting this.

> but it's easy to tell what that value is from the association and/or
> beacon, so it didn't really seem all that useful. Perhaps more to be
> said for simply disconnecting in this case in strict mode, or
> something, so it's noticeable to people working on this/testing it.
Maybe. I have never heard of strict mode. ;-) For the ignorant like me, 
having more details in the log message would help, as it’s not so easy 
for me to capture and interpret the beacon. ;-)

Anyway, you are the expert, so the patch looks fine.


Kind regards,

Paul

