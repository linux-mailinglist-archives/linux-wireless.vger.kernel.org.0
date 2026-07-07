Return-Path: <linux-wireless+bounces-38766-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f7IWNXgjTWrHvgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38766-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 18:04:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F17171DA28
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 18:04:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=candelatech.com header.s=default header.b="o1/NP6Pl";
	dmarc=pass (policy=none) header.from=candelatech.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38766-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38766-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64C72300AC85
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDF44314B2;
	Tue,  7 Jul 2026 16:04:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E942643E
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 16:04:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440242; cv=none; b=ikydry9EVoUgyPG/PYVpIY5Qor3eXyqn4T7VjF6ypw2Xl3ecYUVBgjAYd77Ja36RQyQ/xr3gdhLYfuMuvOYuexh9ewPCfFnshJLjJjihXaEGuphweSEDiWk5bXG3KA0U7f71EXxSGyd49pGx+Pe0vv9IXEFiD5jVJ0zJcYytyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440242; c=relaxed/simple;
	bh=XgqxS2XoxoIYcK1OA4cx5tmcQAwt5VbpXjPrpsqCZt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fn8pYBOjOsVXjhCcwX2tIwBRhsWZWuzoMUjGxYT4769Pp2nSvb9CmYHExAKaqTxrx3dYajAdZTIhEJKCMC7zEWlIltDo6n8McNqqzp0pQDKoark0aB8J4lK8rognI3C8VGKsrjT2kHEmfP1S/FlqYdhw/Ef75PeqFiQxpw2Fmmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=o1/NP6Pl; arc=none smtp.client-ip=148.163.129.49
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 69AF9700077;
	Tue,  7 Jul 2026 16:03:58 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 07CC813C2B3;
	Tue,  7 Jul 2026 09:03:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 07CC813C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1783440236;
	bh=XgqxS2XoxoIYcK1OA4cx5tmcQAwt5VbpXjPrpsqCZt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o1/NP6Plw9pVPANRMK1uNVJrmn1V/BTlbhzjC0S5zuwfDzTH3qY7s3mQZte6BA712
	 cad6mNLYGjjST/LVzSDFTTkjZWEEAAgigT6BaEthd1KdqeD4Ugf6s5K6fw2E8zKO9G
	 HSTXKo1K7KXZpUbYUdlator4VVBfWzHK54fpvU8k=
Message-ID: <bac3152c-deb7-594e-0c8c-247acba5b7f2@candelatech.com>
Date: Tue, 7 Jul 2026 09:03:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: cfg80211: reinit wiphy work entries on runaway
 drain
Content-Language: en-US
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, baijiaju1990@gmail.com
References: <20260707134925.106972-1-zzzccc427@gmail.com>
 <d39f212a-5161-4d00-bc38-bcdc5fee2658@candelatech.com>
 <CAFRLqsXHZ75ktX0gb3HbJHyPLHa_iFr=qA8Z-G0Lz1ZEfLQKjQ@mail.gmail.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <CAFRLqsXHZ75ktX0gb3HbJHyPLHa_iFr=qA8Z-G0Lz1ZEfLQKjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1783440239-TvETyUA6uHw4
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1783440239;TvETyUA6uHw4;<greearb@candelatech.com>;42964693c53d782159cd6d1d1559cb6f
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38766-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zzzccc427@gmail.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[candelatech.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:mid,candelatech.com:from_mime,candelatech.com:url,candelatech.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F17171DA28

On 7/7/26 08:47, Cen Zhang wrote:
> Hi Ben,
> 
> Thanks for your review and comments.
> 
>> Even this likely leaves the system in a bad state since requested work
>> items would be skipped.  Probably should also increase runaway_limit quite
>> a bit as well (that has worked OK for me), maybe remove it entirely.
> 
> Fair. Hitting the guard still means pending work gets skipped; this patch only
> avoids leaving those work entries with stale list links after the
> existing drop path.
> 
> I was hesitant to remove the guard in the same change, because the
> flush-all paths run under the wiphy mutex, and a work item that keeps
> requeueing itself could otherwise keep flush, suspend, or unregister
> stuck there. Raising the limit sounds less risky, but I would want a
> concrete reason for the new value rather than picking one arbitrarily..

Yeah, you have a good point.  I'm not sure of a proper solution.  I set my limit to 200
and was no longer able to reproduce warning splats.

Your patch may certainly be an improvement.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



