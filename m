Return-Path: <linux-wireless+bounces-32929-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDQUG3N1sGnJjQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32929-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 20:48:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B877A257206
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 20:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B91E3041BE8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 19:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA17359714;
	Tue, 10 Mar 2026 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQIKf2zO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3373563F4;
	Tue, 10 Mar 2026 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172080; cv=none; b=Krus4txCXRq4H41hBJ+0QNJrHeeyMtfkJ/eA0P+vJzQ9pqc6x6J3B+YfYFf98DIrPteMrzW12+9IPP90XmDXLLFpjjepzGjo3uKN72BmxlpvvMihMsVcD0zNMVDty/ZQ9fXVXK/+lIvbUjuJr7m+mldMXOzNYVliWVHzVmeb5o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172080; c=relaxed/simple;
	bh=6T6jaUZt2ffF7BsGgmsx15Xkc6EQsgSDxh0SiVnLI4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bcv9DNq2I6VtkCynKtw0stUGPOb5PqxYfh+49w8hPE6mC9mC9npowBPImkaRA0DqR2p1U7bkgR9zJnlj3NqdosS+BMGMynA2sijUXJgu8CL2JkFhnVRCm5wnrHU0cPzwp73BBKCN85ZSgXgJjRexuc8ucCJCs94qVfqQjo5Tut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQIKf2zO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216FCC19423;
	Tue, 10 Mar 2026 19:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773172080;
	bh=6T6jaUZt2ffF7BsGgmsx15Xkc6EQsgSDxh0SiVnLI4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQIKf2zO+VQwtji2K+41IbalY0n57Ers3wp0AU86A+g3QoHyrNMQyrnucruLgj/IO
	 oXW0ytWiIDHxkMctz9TsogDqYivDm8dDt7ZTvmLRj4IZ/ajVB3ahHlIRHBTcI9jN7c
	 uJ+RP3xVlfXB1l3EEQq/2SX89dOe+G4+ocZHByrGaSkp3L2Wd3nyuTKIn8CDWHSVlD
	 fpuXQwjD/IlUDwBBuJA27VEON3ACdhjkM9ojRdE99Lm2bFYcYoyjcPeUbn2W2gXT3O
	 M6VPkGlXgod9v1uabYJjXm+JOrVsEg2qpm7Fjfy0d5VjtHjOdasfBazJmEWJXpivii
	 Rixwf4N1h/+Sg==
Date: Tue, 10 Mar 2026 09:47:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Miriam Rachel <miriam.rachel.korenblit@intel.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
Message-ID: <abB1b098e83bLT5v@slm.duckdns.org>
References: <35779061f94c2a55bb58dcd619ae91c618509cf4.camel@sipsolutions.net>
 <aadKDCKGHk1Ua-7_@slm.duckdns.org>
 <3303d57a4ea6776dbc66ca72441023f76e6f1234.camel@sipsolutions.net>
 <35a7ebcf-862f-0b3a-a245-c32196a58692@candelatech.com>
 <aadYoaA_JYduCx_S@slm.duckdns.org>
 <de003dc3-3e37-f238-4250-2df16eeb77d6@candelatech.com>
 <68c1ca1381d1871fff72b211890a64eb@kernel.org>
 <bba74cab-7305-a052-7e1c-7a7736ba4531@candelatech.com>
 <5b9b93df8774810a43fceb359906604b@kernel.org>
 <729164a1-9dd4-c9a4-f092-d93d775257e0@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729164a1-9dd4-c9a4-f092-d93d775257e0@candelatech.com>
X-Rspamd-Queue-Id: B877A257206
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
	TAGGED_FROM(0.00)[bounces-32929-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

On Tue, Mar 10, 2026 at 12:18:49PM -0700, Ben Greear wrote:
...
> But could this work-item (re)initialization also explain work-queue system going
> weird?  Just using kthreads, which 'fixes' the problem for me,
> really shouldn't make a difference to the code below, so probably
> it is not related?

Oh, re-initing can deifnitely corrupt things. Workqueue shares work list
across all work items sharing the pool, so the blast radius can be bigger.
ie. It'd be *possible* for kthread_worker to get lucky.

Thanks.

-- 
tejun

