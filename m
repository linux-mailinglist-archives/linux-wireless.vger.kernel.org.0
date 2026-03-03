Return-Path: <linux-wireless+bounces-32426-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ84D71Yp2lsgwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32426-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 22:55:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD21F7CD2
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 22:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78E633080133
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 21:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925CC33688B;
	Tue,  3 Mar 2026 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfH8lLbD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70171336884;
	Tue,  3 Mar 2026 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574882; cv=none; b=ZC9Q4FmU0ow6sKOypfItWQORvv4PB9SlNgX93qxJ47+E55mzfuSa7Bz5h7V81g+/ZHTtjJsFvP+ZAyBFliTTivXFKW/TQmIFYEUf1U3mnyu0jaIrHEEfC4f8gxAfUCo+1+OVk0aAM9ow3pAlGh+43hlauwoNi6Op34I+ox1mUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574882; c=relaxed/simple;
	bh=VvOOzNE9BueqqRI/K17eO29FNoYNhF1HowEkUUOpvgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWR9SkoNxzMxtQhJH1LmUYHUhu1xBdSKi9E4fGITFOB0f1V4zLm5mKnXar9APuqHtjrTYI846emW9HOndnbkCgMa9SON9xPLuTcFWoocIc+f4TdRvuGnUsGD5sB/ScvTedi+LBLjVlv1gNQmsFRIf0fSUXwhm0LCkTKuYWjTqYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfH8lLbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3405AC19425;
	Tue,  3 Mar 2026 21:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574882;
	bh=VvOOzNE9BueqqRI/K17eO29FNoYNhF1HowEkUUOpvgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfH8lLbD1Qlc/I69ExYqvE48A1/rFZBINF8w4o4XIG6p6iRD6dIr+7VDpOAC+3HIc
	 S0YKGBNBalL7PjWcjWR5ZDIUWuyEUbRk7nAySAiW1QymhuU052IRRoE9SczrI41vCW
	 +5WIoUT/3n+8UVg8xK7o1TfKTT5PE7NZXC6KMET5zx1Ohv+a9kHuYsNK/iiJk0C8zb
	 Bv+9vmpjODPgsPvIq6BQg44CMRQmeVjjxk4WtVSv/EdlAzAUonykX+K8VLuOHpyLcz
	 06U4gtFKKK5ySUFHnwl9SNkUTGeLdIyhC5oh+P5cXequMv1rkd+HxGO7P7XHmfmdSA
	 pJWSS9oxs3Fpw==
Date: Tue, 3 Mar 2026 11:54:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
Message-ID: <aadYoaA_JYduCx_S@slm.duckdns.org>
References: <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com>
 <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
 <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net>
 <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com>
 <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net>
 <c616fc41-3bc7-4ddc-b65c-a622111d8548@candelatech.com>
 <35779061f94c2a55bb58dcd619ae91c618509cf4.camel@sipsolutions.net>
 <aadKDCKGHk1Ua-7_@slm.duckdns.org>
 <3303d57a4ea6776dbc66ca72441023f76e6f1234.camel@sipsolutions.net>
 <35a7ebcf-862f-0b3a-a245-c32196a58692@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35a7ebcf-862f-0b3a-a245-c32196a58692@candelatech.com>
X-Rspamd-Queue-Id: 93FD21F7CD2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32426-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

On Tue, Mar 03, 2026 at 01:40:54PM -0800, Ben Greear wrote:
> If I use a kthread to do the blocking reg_todo work, then the problem
> goes away, so it somehow does appear that the work flush logic down in swap.c
> is somehow being blocked by the reg_todo work item, not just the swap.c
> logic somehow blocking against itself.
> 
> My kthread hack left the reg_todo work item logic in place, but instead of
> the work item doing any blocking work, it instead just wakes the kthread
> I added and has that kthread do the work under mutex.
> 
> The second regulatory related work item in net/wireless/ causes the same
> lockup, though it was harder to reproduce.  Putting that work in the kthread
> also seems to have fixed it.
> 
> I could only ever reproduce this with KASAN (and lockdep and other debugging options
> enabled), my guess is that this is because then the system runs slower and/or there
> is more memory pressure.
> 
> I should still be able to reproduce this if I switch to upstream kernel, so
> if there is any debugging code you'd like me to execute, I will attempt to
> do so.

I think the main thing is findin out what state the work item is in. Is it
pending, running, or finished? You can enable wq tracepoints to figure that
out or if you can take a crashdump when it's stalled, nowadays it's really
easy to tell the state w/ something like claude code and drgn. Just tell
claude to use drgn to look at the crashdump and ask it to locate the work
item and what it's doing. It works surprisingly well.

Thanks.

-- 
tejun

