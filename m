Return-Path: <linux-wireless+bounces-33839-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF0rKnXOw2nuuAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33839-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 13:00:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A48D4324608
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 13:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CCE430E6414
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BDA3D4135;
	Wed, 25 Mar 2026 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="kuwyZkam"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFB93D4103
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438900; cv=none; b=CggKlsLUPPH4Cid6gg+d8nK7Sq/IjZMBaULWmtELejA1VDOEulZ/ssPaMDA16qSM154J2aiU+Kdq+PNJawYhjzDhLe1eXSQkunOsuK5BY5Yjd3UKeIMSoR8m+oBBP9cPgB5wxO9rBowmFCpJ45kN6g3CXZDSa4kaUsoCLSKrHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438900; c=relaxed/simple;
	bh=toXV95iXYj/xT+IYbMFvmEoZ5wP0rlmXNWuzJnK3cb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyg3gy7zqIcEUmhBN0oNbcEPl8Td6nVlHIzbQarvXZkyVghcYJYxTeyMra5dZb2uYK8m4se7+3cFxNibaw/LBghn41apWyiX214hrNliDRLH/F3IIzHpGDpK2sWKXOrfPVpDC0qQm23RlOFgEYyMtECYWHbqO6aM8rkbYgv7yYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=kuwyZkam; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iWvpiAP7LUICieC7sDhMfOr4PVzAKQIntU+om6/essg=; b=kuwyZkameaoVg1wH8Y+hWpSZS9
	8JRlzU+7jEfsUQ6f+Y62yp55QTHUqH4fpaBRz8JiuLbNy8j2Th5y+Z5dd2E15KAWzobkFnGFH93mg
	I9ZJ3YO6YpGn8HThUDvprNQzRCIToPiBhWEAy3xfGtS358pPDkMf3OK/mAw0j9cBVciI=;
Received: from p5b015666.dip0.t-ipconnect.de ([91.1.86.102] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1w5McD-00Bzdw-0j;
	Wed, 25 Mar 2026 12:41:37 +0100
Message-ID: <9b4e633e-133e-4ec2-959f-1fb25e706ede@nbd.name>
Date: Wed, 25 Mar 2026 12:41:36 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: mac80211: factor out part of
 ieee80211_calc_expected_tx_airtime
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>,
 linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
References: <20260323101954.874299-1-nbd@nbd.name>
 <900aa78e-b0ca-43de-adae-4053bde4d328@freebox.fr>
 <0f56f76d-7820-4392-88f7-78f24b9ff421@nbd.name>
 <0bbe540f-6a48-4d70-b6ca-4498f715963b@freebox.fr>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <0bbe540f-6a48-4d70-b6ca-4498f715963b@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33839-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[nbd.name:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A48D4324608
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25.03.26 12:21, Pablo MARTIN-GOMEZ wrote:
> On 25/03/2026 04:58, Felix Fietkau wrote:
>> On 23.03.26 17:00, Pablo MARTIN-GOMEZ wrote:
>>> Hello,
>>>
> [...]
>>> I know this patch is just a refactoring, but I think this moved code is
>>> bugged. If (and it's a big if) I understood correctly the chain of
>>> macros and the comments, `ieee80211_get_rate_duration` return the
>>> `duration` in 1024 µs of an average packet (which would imply
>>> 1f38b8c564b8 is wrong) and the (PHY) `overhead` in µs for a (average)
>>> packet. So I believe the code should be:
>>> ```c
>>>     duration = ieee80211_get_rate_duration(hw, &stat, &overhead);
>>>     duration *= 1024;  /* now duration is in µs */
>>>     /* the agg_shift calculation has to be fixed */
>>>     duration += (overhead >> agg_shift);  /* for one packet, we
>>> "assign" a
>>> fraction of the overhead */
>>>     duration *= len/AVG_PKT_SIZE;  /* we multiply by the number of
>>> packets */
>>>     duration /= 1024;  /* we go back to a duration in 1024 µs*/
>>>
>>>     return duration;
>>> ```
>> 
>> The overhead (preamble, signal field, etc.) is a fixed per-frame PHY
>> cost that doesn't depend on how many data bytes are in the frame. In the
>> aggregated case, agg_shift amortizes that fixed cost across the
>> estimated number of subframes in the aggregate. So the correct order is:
>> scale the data duration to the actual packet size, then add the
>> amortized overhead once.
> My bad, I didn't understand that `len` was the byte size of a MPDU.
> 
> So I was wrong on where I put the overhead, but (a priori) not on the
> rest of the calculation *if* my understanding of the units is correct.
> If 1f38b8c564b8 is correct and so `duration` is in ns and `overhead` is
> in µs, then your code is correct, but the commit message is wrong
> because `ieee80211_rate_expected_tx_airtime` is returning a value in ns.
> 
> My snippet fixed if `duration` is in 1024 µs:
> ```c
>       duration = ieee80211_get_rate_duration(hw, &stat, &overhead);  /*
> duration of an average MPDU in 1024 µs */
>       duration *= 1024;  /* duration in µs */
>       duration /= AVG_PKT_SIZE;  /* duration in µs for a byte */
>       duration *= len;  /* duration in µs for the actual MPDU */
>       duration += (overhead >> agg_shift);  /* duration in µs for an
> approximate PPDU aka airtime */
>       duration /= 1024;  /* airtime duration in 1024 µs*/
> 
>       return duration;
> ```
> [`ieee80211_calc_expected_tx_airtime` has to be fixed too]
> 
> The current patch:
> ```c
> 	duration·=·ieee80211_get_rate_duration(hw,·&stat,·&overhead);  /*
> duration of an average MPDU in ns */
> 	duration·*=·len;
> 	duration·/=·AVG_PKT_SIZE;  /* duration in ns for the actual MPDU */
> 	duration·+=·(overhead·*·1024·>>·agg_shift);  /* adding the overhead in
> µs to a duration in ns to get PPDU duration: overhead [µs] == overhead *
> 1024 [ns] */
> 	return·duration;  /* airtime duration in ns */
> ```

The formatting of your snippets is really weird. Are you using some kind 
of LLM?

There is definitely an issue in the commit message, which I will fix in 
v2. It says the unit is 1024 us, when in fact it should say that the 
unit is 1/1024 us (approximately ns). Maybe that's what got you 
confused. Either way, your 'fixed' snippet seems wrong to me and the 
code should be fine as-is.

- Felix



