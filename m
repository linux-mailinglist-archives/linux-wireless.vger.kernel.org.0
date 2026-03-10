Return-Path: <linux-wireless+bounces-32930-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEJvAqt1sGnJjQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32930-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 20:48:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05790257233
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 20:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3287C3014A08
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 19:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4262D3220;
	Tue, 10 Mar 2026 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5Wn9Npb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB872C11D9;
	Tue, 10 Mar 2026 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172131; cv=none; b=aroeLhXyHrYIzcb/MSGHUUvVMJefJJYaObYwTXZTyJVcGrtQ2WAisxsvOBjQAuux9RE+SpdYAz3LzbzEc+LUUfPVkZq8dBGMkg82Kc5afb9FYZ44lie4V7bWQnvaRTv3brf71tpIzXXuxhHTetBKdlCPspykEVZBm5oyWJKrb4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172131; c=relaxed/simple;
	bh=8RDQfE2xP1BWgVgje31aWjZMSOyhfmFEXWA2AkWRkvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYCslHrozcdgMv67cwUk5MIh3qQNKT7A9WmOymC7eq7m2Rj2+16mLYF0TASo9YSzD9uNpWTzIioJJUUs27Nz6CIoXtr5djKuu43Ml4I7zGidStS+rpTwyFyN2vNkhOGs+3R70MRrZYHZfP2GN5yqoQy1dh0X9R4aTvTEGscF+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5Wn9Npb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71781C19423;
	Tue, 10 Mar 2026 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773172131;
	bh=8RDQfE2xP1BWgVgje31aWjZMSOyhfmFEXWA2AkWRkvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5Wn9Npb6xtJVj5PVvDE2FjOPMVFmtv4Vy3sXQJK5oNzQiA2ouG7R5fG9SL9DMrAp
	 PoqTKHzKkywF0Xwocplj3jIsERUmRwrdrydepr/3LMPmYkRJKhNHq12jkfTzkEzTBY
	 sFijpy7ArNS7UKJFrdhZMjqdRnIYMLmh3Y/t23ko1SUWu5uTDkrXiscuYrXfJYT2Yw
	 rHNUGcWQcF99+X8AxkhOSPAb/bCV7EBaGnnVNQi2ilxIkkvbBrYnumiYnY5XNmJbub
	 08TzHLTX+6olTVPLxJtwXYbI93zCHxCFuTlW3koXJDDWo0QxgxefjQ0Pn3/uqViOti
	 l2tK8oGni0qHw==
Date: Tue, 10 Mar 2026 09:48:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Miriam Rachel <miriam.rachel.korenblit@intel.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
Message-ID: <abB1oq9c97RD_g0C@slm.duckdns.org>
References: <aadKDCKGHk1Ua-7_@slm.duckdns.org>
 <3303d57a4ea6776dbc66ca72441023f76e6f1234.camel@sipsolutions.net>
 <35a7ebcf-862f-0b3a-a245-c32196a58692@candelatech.com>
 <aadYoaA_JYduCx_S@slm.duckdns.org>
 <de003dc3-3e37-f238-4250-2df16eeb77d6@candelatech.com>
 <68c1ca1381d1871fff72b211890a64eb@kernel.org>
 <bba74cab-7305-a052-7e1c-7a7736ba4531@candelatech.com>
 <5b9b93df8774810a43fceb359906604b@kernel.org>
 <729164a1-9dd4-c9a4-f092-d93d775257e0@candelatech.com>
 <abB1b098e83bLT5v@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abB1b098e83bLT5v@slm.duckdns.org>
X-Rspamd-Queue-Id: 05790257233
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32930-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 09:47:59AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Mar 10, 2026 at 12:18:49PM -0700, Ben Greear wrote:
> ...
> > But could this work-item (re)initialization also explain work-queue system going
> > weird?  Just using kthreads, which 'fixes' the problem for me,
> > really shouldn't make a difference to the code below, so probably
> > it is not related?
> 
> Oh, re-initing can deifnitely corrupt things. Workqueue shares work list
> across all work items sharing the pool, so the blast radius can be bigger.
> ie. It'd be *possible* for kthread_worker to get lucky.

BTW, if you enable CONFIG_DEBUG_OBJECTS_WORK, re-init should trigger a dump.

Thanks.

-- 
tejun

