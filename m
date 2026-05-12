Return-Path: <linux-wireless+bounces-36309-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPtzLk3UAmrPxwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36309-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 09:18:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC7551BAA3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 09:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 003D33020BD5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AF4263C7F;
	Tue, 12 May 2026 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Nn+WSIsG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0034A795
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570253; cv=none; b=FrFJNJyvsPp/BOyAJl/4jBoN3zjYpWWzcSF4DZbMswPRPI+YU2cEMKTTwJ4s+R7pz093eI/fAvtj5HnAvC9yoi/jzoouqVDS2BLM4hHHj8X+Z3A94mgLssX/wWV6iTziOHZMjOMOPKfHEfNeYIydJYr/ibRFE/1uhSo3UAzZqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570253; c=relaxed/simple;
	bh=PGK8gd6RLPN8TVxowId4B7hcSPJeq9KHicvlzsl8Knw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AN+PxFbI9OGyZ1gttsKwvegWkHqdoidRLzAPv1aa+ObEyDP2wycl8GlOkWWbbEetIJ4m1UcEjtUuDhvvqfmYaJwEgJ4EdjxOVeezxN1rJkfmprowqhbBv/iApd11tMD6DsKSONDszK5Q1JGV21FUecKM/dghhzGnL6ffJIusm6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Nn+WSIsG; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gF7Fn2NFtz4DjS;
	Tue, 12 May 2026 09:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778570237;
	bh=PGK8gd6RLPN8TVxowId4B7hcSPJeq9KHicvlzsl8Knw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nn+WSIsGKMUArqFjDfeL3a5xe6RMrjbsPFAzWGkjBgssAnjNfFmDD+tmucG055shE
	 G0iLf/F5cgcvqoryLTDupvCdImdTgbnJVXFhsO33SphWxInnXhclguuuNJPW3TsLxp
	 F5Xjdvw7SnZRX1tTXa8HIKbw4+R9BpU6ITtRJ8B2UfzpUwfpkt3bfLJgRz+U5a9+B8
	 bJ2jDQlafeKlDIurzIlCdbFB6BpA1lMOZYSRURw9zG3QFgmo2BxOVsw5RB/1u4EkXL
	 G55jEnuBTprwwF2zoHtMcEktxVyNCkFGwPNPSrcPTN8xBrzSPP7nF3KRTg4FH9bXtS
	 Fc1yU70L/4XDQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gF7Fn1h2yz7vt2;
	Tue, 12 May 2026 09:17:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gF7Fm1Nlcz8tgR;
	Tue, 12 May 2026 09:17:16 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 9893F6184E;
	Tue, 12 May 2026 09:17:15 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <1cf071e9-5d3c-4d55-ac75-49eb4c461422@leemhuis.info>
Date: Tue, 12 May 2026 09:17:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2] wifi: rtl8xxxu: Detect the maximum supported
 channel width
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "art1310@proton.me" <art1310@proton.me>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <c57de68e-5d57-4c26-898f-8a284bb25381@gmail.com>
 <ee88b3a2-2cc9-4370-b782-189a603a7fa1@RTKEXHMBS04.realtek.com.tw>
 <41693ffc-926c-4e67-9a48-b6e1b1d150bd@leemhuis.info>
 <f26992e669744e6f87084e017f897275@realtek.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <f26992e669744e6f87084e017f897275@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177857023592.2936282.8027880108869927067@mxe9fb.netcup.net>
X-NC-CID: cRX10LR12CGbJk05VwtesGzqXrlvOYJOYxN7G/QGIRCguOG3psQ=
X-Rspamd-Queue-Id: AFC7551BAA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36309-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,leemhuis.info:email,leemhuis.info:mid,leemhuis.info:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[leemhuis.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,proton.me,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/12/26 02:44, Ping-Ke Shih wrote:
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>> On 5/6/26 09:57, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>
>>>> Some devices malfunction when connected to a network with 40 MHz channel
>>>> width, because they don't support that.
>>>>
>>>> RTL8188FU, RTL8192FU, and RTL8710BU (RTL8188GU) have a way to signal
>>>> this (and some other capabilities) to the driver. Get this information
>>>> from the hardware and advertise 40 MHz support only when the hardware
>>>> can handle it. We assume the other chips can always handle it.
>>>>
>>>> RTL8710BU needs a different way to retrieve this information, which will
>>>> be implemented some other time.
>>>>
>>>> Fixes: dbf9b7bb0edf ("wifi: rtl8xxxu: Enable 40 MHz width by default")
>>>> Cc: stable@vger.kernel.org
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221394
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
>>
>> Thx for fixing this!
>>
>>> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
>>> ef771eabc79d wifi: rtl8xxxu: Detect the maximum supported channel width
>>> https://github.com/pkshih/rtw.git
>>
>> rtw-next sounds like it aims for the next merge window; and it seems the
>> fix hasn't even hit -next yet. This is slightly unfortunate, as this
>> afaics is a fix for a recent regression -- so it ideally should head
>> towards mainline by now[1], as Linus' the rule of thumb is to "generally
>> fix regressions "within a week", preferably before the next rc"[1].
>>
>> Or am I missing something? That might very well be the case, so do not
>> hesitate to tell me!
> 
> As this patch applied to public rtw tree, and people who encountered the
> problem in bugzilla can work again. To prevent breaking the public tree,
> I'd keep it as was.

I'm not sure I understand this correctly.

Do you mean something like "the fix is now in the rtw-next tree, so I
can't mainline it now, as this would break the rtw-next"? But why? You
can cherry-pick or directly apply the fix to a pending branch (or even
ask Linus to merge it directly from the list, but that is likely not
worth it here) and git will normally later notice this and fully
automatically handle everything when the fix comes in again during the
next merge window.

Or did I misinterpret what you meant?

Ciao, Thorsten


