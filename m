Return-Path: <linux-wireless+bounces-36321-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLE4No0QA2qX0AEAu9opvQ
	(envelope-from <linux-wireless+bounces-36321-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 13:35:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3612F51F6C2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 13:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D19413079147
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E833EF673;
	Tue, 12 May 2026 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="izC/dNUA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F33C3C00
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585449; cv=none; b=ngTOEAyPha2bkDMm9VmbzAnVOFjuUKHuQEkycGdkxVrpVbHzP25Lg8T57aho+3sHpb+WVZwHqXIgVgiQw75APS0EXhcB3bE+0wOdlYbQAEfYQDyCPA50AsjjvlaoEkU8OZS1r/zIAJW1i51y+bAvtwBufWMHX6pTaPN5ZfXa1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585449; c=relaxed/simple;
	bh=HtglGrCwkqjrWXXrzziX1/ariNbTdqIlOZLeVmCI7Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZJSLT5RBpfMX8tWrNSsyAigZmKV/8kgWy8dUwf7C+EgcTXORGwRWao/wjDZUhYi/URwLTkFl74lj4HJz3D09rGdxpMEKtsPjnFsVeNh1yqv+1NlmVXnPb6dM3Uam1dZseNTbdzr/sxKGtic9ImQIiupWVasf3eNTBQk7PoPANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=izC/dNUA; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gFDt700lnz8B6w;
	Tue, 12 May 2026 13:30:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778585439;
	bh=HtglGrCwkqjrWXXrzziX1/ariNbTdqIlOZLeVmCI7Pg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=izC/dNUAhWPeAwVJ6WiUj8ZFBhA3NE07CNMH/jxNX6Z8QZF7aK2pmNgDQAGvRSlGq
	 U/Ik+aVk2B8bJznFihO7elRJXZarKRoBqVAfu/OnN6tbgBX6TRhMC0DiE0gUYkEuVG
	 SdFNn7+S8+7HViS6bNe9gXz60YicsJR2wlMeP1Fc/v/f4olrgv2Cm5ZwVtL65mSuC2
	 9MmVNEo5QSHrcQUlhr8kOqFCZDpQ31nGNm53PnAN/6+fOp3Sa211hh93dheLPrS9zT
	 CCkUZIXANHXW3vnACmfcpSPSMITguLyVQgkgrlH65puzIK90/RMU8J7ejJXbkjyJKQ
	 2Fk5WDcz7UJ+A==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gFDt66Q04z8B6p;
	Tue, 12 May 2026 13:30:38 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gFDt6130Vz8sh8;
	Tue, 12 May 2026 13:30:38 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 7C633617A5;
	Tue, 12 May 2026 13:30:37 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ac56117b-0c16-4d98-95f7-8415ccabdc6d@leemhuis.info>
Date: Tue, 12 May 2026 13:30:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2] wifi: rtl8xxxu: Detect the maximum supported
 channel width
To: Johannes Berg <johannes@sipsolutions.net>,
 Ping-Ke Shih <pkshih@realtek.com>
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
 <02c073d8-d2c9-4faa-be51-9ba38247b24e@leemhuis.info>
 <522d09d5fad2fdebc89419a7e75b89ff14de162a.camel@sipsolutions.net>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <522d09d5fad2fdebc89419a7e75b89ff14de162a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177858543781.3310061.8800170906185187943@mxe9fb.netcup.net>
X-NC-CID: Z45TeTFUU3Y+NC07r4Asj4VSzFwrNRqL+8SE5Rqwpru6aizQmMM=
X-Rspamd-Queue-Id: 3612F51F6C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36321-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,proton.me,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/12/26 11:36, Johannes Berg wrote:
> On Tue, 2026-05-12 at 10:54 +0200, Thorsten Leemhuis wrote:
>>>> You
>>>> can cherry-pick or directly apply the fix to a pending branch (or even
>>>> ask Linus to merge it directly from the list, but that is likely not
>>>> worth it here) and git will normally later notice this and fully
>>>> automatically handle everything when the fix comes in again during the
>>>> next merge window.
>>>
>>> I know git can handle that, but is it an acceptable practice for single one
>>> commit to appear twice?
>>
>> Depends on whom you ask. I'd say: It's kinda normal. It's best avoided
>> if there is no need, but if there is a need (like here) it's fine. And
>> some subsystems it even happens regularly iirc.
> > FWIW, it's generally frowned upon and actually uncommon enough that
> linux-next actively warns about it [1] (or at least used to?), so I
> wouldn't really say your description here is all that accurate.
>
> [1] https://lore.kernel.org/lkml/?q=%22duplicate+patch+in+the%22
> 
> What does happen fairly frequently is the same immutable commit getting
> merged through different branches, but that's a single commit, not the
> same change being committed twice.

Well, that made me look up my "regularly iirc" claim. Now I remember
where I got that from: the cherry-picking (which results in a second
commit-id) the DRM subsystem regularly did:
https://lwn.net/Articles/1005222/

That's was early 2025, so the workflows there might have changed in
between due to the criticism. But from a quick 'git log --grep "(cherry
picked from commit"' in mainline it doesn't look like it did. Here is
one example of a commit that made it into 7.0 that sits with a different
commit-id in -next a second time:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=grep&q=Avoid+memory+allocations+in+xe_device_declare_wedged
b08ceb44386680 ("drm/xe: Avoid memory allocations in
xe_device_declare_wedged()") [next-20260330]
56b7432b7e8e6a ("drm/xe: Avoid memory allocations in
xe_device_declare_wedged()") [v7.0-rc7]

Here are a few from the current cycle:

0d831487b5be0a ("drm/amdgpu: nuke amdgpu_userq_fence_slab v2")
[next-20260506]
4e02e0afa95f69 ("drm/amdgpu: nuke amdgpu_userq_fence_slab v2") [v7.1-rc3]
1fc6c8ab45dbee ("drm/amdgpu/userq: fix access to stale wptr mapping")
[next-20260506]
6da7b1242da445 ("drm/amdgpu/userq: fix access to stale wptr mapping")
[v7.1-rc3]
d12d05c4bc4c15 ("drm/amdkfd: Check if there are kfd porcesses using adev
by kfd_processes_count") [next-20260506]
81665e35f143d9 ("drm/amdkfd: Check if there are kfd porcesses using adev
by kfd_processes_count") [v7.1-rc3]
d9af8263b82b6e ("drm/amdgpu: zero-initialize GART table on allocation")
[next-20260506]
e6c2e6c2e1fa06 ("drm/amdgpu: zero-initialize GART table on allocation")
[v7.1-rc3]

I found a few dozen more. But this is not my area of expertise, so
please correct me if I'm missing something.

In the end I don't care about all that. I just think it would be good to
get this regression fixed in mainline this cycle. And I suspect Linus
wants that, too. For example due to previous discussions like this:
https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/

Ciao, Thorsten

