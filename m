Return-Path: <linux-wireless+bounces-36314-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P7sNMXqAmpKygEAu9opvQ
	(envelope-from <linux-wireless+bounces-36314-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 10:54:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B7251D150
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 10:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 676FD3001314
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C9039C623;
	Tue, 12 May 2026 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="fnAHUDDb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD739A06F
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576063; cv=none; b=gF6pGNujVNlb/GV8O8N0i2XKMF0AjvgRA75WZJxTwsA7Q+eHFPedTtnkRYgHslXdSOfkDkCqnxxZ4DC59Sqn9nhRW0jKdw7yY76NBLtVuHtpoPI0xcJKUfvYdH8Fm1LpgtaOqCWRiHtrvnGF4xwOWjU4tQQwlEeJF8pyoQDNb+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576063; c=relaxed/simple;
	bh=SsfLpbhZImgwN6CkAYtcMbgUHWERyMGmhq4hPuuYk7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgBChCD0RlaEnoZJvmWChJCxDcD4E/HO2SFX77Dp6Q7MyG3Dxiwj9z+lmdc6LUSkVLDkWEsw4Z47rcVDGLQBskJN4q0RJSdHnOO9v+Oy73gKxOUMc3Dhh9tkGCDnRpDhSDIG4XPLQpYg1KKO5Rbed/8FMwkxDteiYQKrdE4JIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=fnAHUDDb; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4gF9PX0WD9z89D9;
	Tue, 12 May 2026 10:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778576048;
	bh=SsfLpbhZImgwN6CkAYtcMbgUHWERyMGmhq4hPuuYk7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fnAHUDDbY4ydh2DuZcpTb/LkKJi0WNfGBXX+oe7A+pJ4YgpgcgDcTvVzV8mUWTFuj
	 r294gYhQjYJKtdZkcrjCj7MIsVm60JKsqSiO+OnbipUqc94AqyBiIyd7ZXv9eKlVIx
	 MAjuYG92ED7rtRKtzGLFQlmWthX9bJ99024S9VBWartT7kyB3utulBtF92nKAvfy1I
	 McuRVhb5G5yTPQp0c/YONNvSocaxW2HvqvmaSU/hBFBmOzpE75SiQnewYrGS/cW18B
	 L0WLpEXaD7HC7BelVy+nF3MQlrHF3kLWYdSx4U5KAO42MXdwss8fiw2y6CKroA0PrM
	 x9SOzN80wkfBg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4gF9PW6wgKz4y7f;
	Tue, 12 May 2026 10:54:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gF9PW00Fyz8tbR;
	Tue, 12 May 2026 10:54:06 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 2892F6183E;
	Tue, 12 May 2026 10:54:06 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <02c073d8-d2c9-4faa-be51-9ba38247b24e@leemhuis.info>
Date: Tue, 12 May 2026 10:54:05 +0200
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
 <1cf071e9-5d3c-4d55-ac75-49eb4c461422@leemhuis.info>
 <29a93dc3d9d24b3a809310694ffc5d34@realtek.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <29a93dc3d9d24b3a809310694ffc5d34@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177857604647.3064895.3471843442888703462@mxe9fb.netcup.net>
X-NC-CID: x+9Qo54u3HJNq64amWrXPVssz3jQaNLp5++GZNFx98bYHiHSkas=
X-Rspamd-Queue-Id: 72B7251D150
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36314-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leemhuis.info:email,leemhuis.info:mid,leemhuis.info:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[leemhuis.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,proton.me,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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

On 5/12/26 10:32, Ping-Ke Shih wrote:
> Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>> On 5/12/26 02:44, Ping-Ke Shih wrote:
>>> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>> On 5/6/26 09:57, Ping-Ke Shih wrote:
>>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>
>>>>>> Some devices malfunction when connected to a network with 40 MHz channel
>>>>>> width, because they don't support that.
>>>>>>
>>>>>> RTL8188FU, RTL8192FU, and RTL8710BU (RTL8188GU) have a way to signal
>>>>>> this (and some other capabilities) to the driver. Get this information
>>>>>> from the hardware and advertise 40 MHz support only when the hardware
>>>>>> can handle it. We assume the other chips can always handle it.
>>>>>>
>>>>>> RTL8710BU needs a different way to retrieve this information, which will
>>>>>> be implemented some other time.
>>>>>>
>>>>>> Fixes: dbf9b7bb0edf ("wifi: rtl8xxxu: Enable 40 MHz width by default")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221394
>>>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>>>> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
>>>>
>>>> Thx for fixing this!
>>>>
>>>>> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
>>>>> ef771eabc79d wifi: rtl8xxxu: Detect the maximum supported channel width
>>>>> https://github.com/pkshih/rtw.git
>>>>
>>>> rtw-next sounds like it aims for the next merge window; and it seems the
>>>> fix hasn't even hit -next yet. This is slightly unfortunate, as this
>>>> afaics is a fix for a recent regression -- so it ideally should head
>>>> towards mainline by now[1], as Linus' the rule of thumb is to "generally
>>>> fix regressions "within a week", preferably before the next rc"[1].
>>>>
>>>> Or am I missing something? That might very well be the case, so do not
>>>> hesitate to tell me!
>>>
>>> As this patch applied to public rtw tree, and people who encountered the
>>> problem in bugzilla can work again. To prevent breaking the public tree,
>>> I'd keep it as was.
>> I'm not sure I understand this correctly.
>>
>> Do you mean something like "the fix is now in the rtw-next tree, so I
>> can't mainline it now, as this would break the rtw-next"? But why?
> Yes. (I meant rtw-next tree)
> 
>> You
>> can cherry-pick or directly apply the fix to a pending branch (or even
>> ask Linus to merge it directly from the list, but that is likely not
>> worth it here) and git will normally later notice this and fully
>> automatically handle everything when the fix comes in again during the
>> next merge window.
> 
> I know git can handle that, but is it an acceptable practice for single one
> commit to appear twice?

Depends on whom you ask. I'd say: It's kinda normal. It's best avoided
if there is no need, but if there is a need (like here) it's fine. And
some subsystems it even happens regularly iirc.

> As the reporter has fixed his problem, can we keep this commit as it was?

Well, it boils down to: we don't know how many others are affected that
are unable to bisect and/or report the problem. So usually it's best to
fix things like this for everyone.

Ciao, Thorsten

