Return-Path: <linux-wireless+bounces-34093-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKMqCHm+xmnoNwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34093-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 18:29:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 710793485B6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 18:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CDA6308E946
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1540B396571;
	Fri, 27 Mar 2026 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="MaQ8vsqE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA738F92B
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774632198; cv=none; b=nuMTaQ4xeB/C8Xzh/QUrhKUoGvMqcCLH3NqbmJXztypvCKg9eNUkXgYJlC6g5zBhbNZsxQ/pLYtfCizwSB18vbXXplVUya18/0M5zSUPXrAMMxNijz/apxDAZ4vZ+LqCqb48p0T7mgHYePwRo5axU1lAVkWWxzBV5qg623f1PCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774632198; c=relaxed/simple;
	bh=7ceDAktFs/4aYNC0Ka33d7TEBjpL0Izv3hmxiwL8Hlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mPAKHDLqT7RhxAgyxiCpSuRx9bsfKh3/R1ctON9WEsL0TQBCS8mCFCGjZwQoJANYzAfm0vELkYRNRXnsNNamKutEXpMSaDa0m9paDd264VQbPYgJlTSfkfu55OCSmx74hEhFkJwjt+DJJboepPIgUEmeUP6CbdRjVF2WWYPWHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=MaQ8vsqE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48538c5956bso22966825e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1774632194; x=1775236994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PVL5y5vL+SIKcEqHvATh78BLcKW0g0Z/1pX9XnBadE=;
        b=MaQ8vsqETLU3Jw3M8Zl8mtVWIt50kdqzlfRWcv2s8RD0K8W0Gp484YVCEarKr14B2O
         Wu29c/P0zdcu0sLmZxnlZ04WWy9vc64LmUAf0uaOygr/ZnUAaUoI81lZXKeytPcyYVV6
         6pS1CXan4zVlmg3ws6w84HsObH+RjRipQDJngTN9ai+VTEMOx4ff3lCNdzoIGR0zxWof
         Imzuvb4djpLPgLnYkbaTRcuTzeQrjt6LpTKm2GiXtQE74OW5LTGhib60egaNMlJabiBO
         XZ15z9SoR/iIcKfVVfLf2uLmNDbJPUKnTc5UiheiH3Lg36i+a/EbjPNF2rw/86j7591L
         bO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774632194; x=1775236994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PVL5y5vL+SIKcEqHvATh78BLcKW0g0Z/1pX9XnBadE=;
        b=R/g6soD7V953j4cBAyxJ6LGY2cbbsQijpXVDZt9aBSjeT6JvwEqY75NB19R/Rzluyx
         8z/G3HBXteVvv/8O5aAOkPMb+MwaLTrFQacXBHsIBwfF9tV/5UZ+NS/4+bSOX31rJtkS
         vouPte+xYPpMYj1cqCAiGNdiJ8Ve8Gw2UjkSc4OfRdbtoKM+oYLMUD8u7Jtm2uq1iJ2r
         TiUpTf2AdA8xbgcV8vqNyWqUPwdq0h28IXtfvYPRk1EIGxUYtO4ccyVR1gVgXslnXK71
         Bw1+EeJGPpODYaMIWHsUHp0ZMpocuhheT6FQQQyAK7PsDneku+eQ9iKyrBw9XMu+5eel
         3vJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjvVj2qX5mw1VaGKijX8QmM8LfWDXEzDY2Y/VS1vmpV+5RA65ET/5+QwfyaoxRb0wQbtO82HNcAceEDfOHnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRbfYLt2an5NZlTH9pGsL1X0u0erXTJLSGyfHBrFrtDpeFQkb
	0o06EErjU4VEzhhG2V6KHukbwrx5yRcdHSelK9cZSXe5tbxou0tZoc6nu9vRVzIsslA/o9wHPoO
	edk/p
X-Gm-Gg: ATEYQzzrFG6RzwnBin9DNfJUI8RLyAwr04Cqf39eh0RAof2ffcCXILTOBqrfsv34042
	AG2f1I28g1b5A2WQZfkjXHzzyS7B4W/bKmg0WQbrDvJI4psiEiyU0ZEYR8QL3xydR0zbsXXhVHk
	84i0QYFxiWNqWqa6Mw/Tnt/ss1vgA6iReGRqEtasoZhui/rAUmVJ8iV2/h2bQlwWj4qwwhg85ct
	FpN9AK2cAanTAEUngEtrm1BOISRFTRIdTPkf/1d5gPe97UmgGQPd2FGnOnAnI/P8H97qGGaV8b9
	z6Po/3PhHIpRicz7FDcVEyLULJVrBuiC/YXea+AAWI/uEyUw7j39crZWNX4b+vBBdyzK+gaM9cu
	F/M1XZv7kQs7mTk0Pccl4oD1K9/ZLs1hDduCJPHr67+Ut+wy6ACKpAjqvnlIWfH5cPlCCO9TRio
	oUBuSxAxgHoBOKLXISdDym2XkZf+mW8HJt4InUW4mWQ/0hlGn851PQOmOmMOlwUL63sQxjoaJds
	6Q6A4JJuY4=
X-Received: by 2002:a05:600c:6487:b0:486:fe83:861c with SMTP id 5b1f17b1804b1-487290d098dmr45336805e9.7.1774632193537;
        Fri, 27 Mar 2026 10:23:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:71:7cc0:9f51:a89f:3777:bbea? ([2a01:e0a:71:7cc0:9f51:a89f:3777:bbea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872718e474sm20645765e9.31.2026.03.27.10.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 10:23:13 -0700 (PDT)
Message-ID: <34e028b0-c598-4d60-81aa-26a109b44d6d@freebox.fr>
Date: Fri, 27 Mar 2026 18:23:12 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/19] wifi: mac80211: clean up STA NSS handling
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20260327093659.711584-21-johannes@sipsolutions.net>
 <20260327103659.5296c2f3a949.I97fb93ccc1b366110ab23de58fcd73676cdd85d6@changeid>
 <79228bab-aa6c-4fda-97c9-768b158dfa3a@freebox.fr>
 <8aa10ce1ed9da7409ade68d376a61f5e14c70219.camel@sipsolutions.net>
 <ff90035f97d3ae180171172ad6624fcc7c6c9d8a.camel@sipsolutions.net>
Content-Language: en-US
From: Pablo MG <pmartin-gomez@freebox.fr>
In-Reply-To: <ff90035f97d3ae180171172ad6624fcc7c6c9d8a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34093-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[freebox.fr];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 710793485B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 27/03/2026 à 16:08, Johannes Berg a écrit :
> On Fri, 2026-03-27 at 15:50 +0100, Johannes Berg wrote:
>> On Fri, 2026-03-27 at 13:24 +0100, Pablo MG wrote:
>>> If we are doing some cleanup, let's go full on it.
> 
>> No? You're sounding a lot like an LLM that really likes to comment on
>> code that's only moved...
> 
> OK, that was a cheap shot, sorry.
No hard feelings, this wouldn't be a Linux ML if there was some harsh 
and somewhat deserved comments from time to time.

> 
> We can debate the merits of doing some cleanup on the code separately,
> but "let's go full" doesn't really ever make sense, even if a patch is
> already doing some specific cleanup in some area, it's always better to
> do other/unrelated cleanups separately.
The phrasing was very LLMy of me, and my proposed changes definitely 
warranted its own commit, I could have done better.

> 
> So please don't suggest that code that's only (explicitly!) being moved
> get cleanups "along the way", doing that would be actively harmful to
> understanding the changes being made. The key point in this patch isn't
> even that the code moves, it's that the callers move around. Maybe I
> shouldn't even move the code at the same time.
Not to poke the bear again, but the commit message does say 'While doing 
this, fix [...]', so if we can add a fix to it, why not plug in a 
refactor too /s

> 
> Of course, if there are cleanups related to actual modifications, sure,
> that's good to review.
> 
> Also, of course you're more than welcome to suggest cleanups to the code
> as patches yourself, but you could do that _better_ by reading the
> _code_ rather than by looking at the changes someone else is doing is
> doing to it. And less chances of conflicting along the way.
I'll do that. It's true that I have a bit of a T-Rex vision regarding 
code, if it's not changing, I don't know it exists.
> 
> The part that the review LLMs do all the time is suggest that context or
> code being moved is also changed, and that's really not how "small,
> individual commits" work. Even the Sashiko folks are actually trying to
> get it to do _less_ of that, nobody is saying this is a good thing.
> 
> johannes

Pablo MG

