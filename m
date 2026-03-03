Return-Path: <linux-wireless+bounces-32421-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FJRIilKp2n2gQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32421-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 21:52:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2271F6FE4
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 21:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9A7B3064E9C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 20:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2463736605F;
	Tue,  3 Mar 2026 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCGoGU5Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BCA351C39;
	Tue,  3 Mar 2026 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571150; cv=none; b=X7iGUxgNSJm6OKkDIHKOmUPag2UAheaaXDOQDKSZOxNftgkRGd5imLTfKEbvJ1tL14LC9a6Dw/gYKYRMakCFwY2fZl21mJ3Samv+2IOgP/aHkjIJcTOl9/cp0yiDcBZ1TuCuXyYX/iGy3umkeORFIKvX55OncPy7OU2WPqNtsqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571150; c=relaxed/simple;
	bh=Xeo5EivCSK8i5ewFGXEJ1ysYZsQ7yZF4ov0qH2Wp40A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDsxmtP+vJ0qR+iOVVPy4CKZyDLim889druUosMUTsRWFO1hQslmIXwqX6GPtaBf0JOsYLIx4ZbimBgiDteQQkLYpBw4qpzmBiAbbzyqz0mUOBDnzWoM1OaP96XJGwIa6litXYQcTaSkH+HvqGvb9nZXHbjZ5Web+22lfIiKKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCGoGU5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF02C116C6;
	Tue,  3 Mar 2026 20:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772571149;
	bh=Xeo5EivCSK8i5ewFGXEJ1ysYZsQ7yZF4ov0qH2Wp40A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCGoGU5Y39HeDTKSZIz/fjegDB4ezi/z5WfVFuIsI15kReBnn/1bImL6tNTrZugWy
	 zEIdljZz3VdMgP5z4YNVpKFnKfu/fNcryiqk9WOl6obxZrnZ1sB1Ei0rg81L/yr8R8
	 YNagly2k+91n9w27EUNbivoU8RTsUry5AStbx5KGb5Gqq8ox+7PYNCn/gPJHDVITeE
	 No9E0TTCBHKiNp/RsPqi0WPCGAwxx9+hvnJCPPYfJJO2zvKYbs0zwdH+bXUCT1oxnH
	 /rUMFRrQVnhAkj9X0iY7HoBFvVCdMKJ+mZt7IB3XP/HOMZ15Qqt5Wdl0PwZE0G8f8x
	 a3pWuJ8Me+Kng==
Date: Tue, 3 Mar 2026 10:52:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ben Greear <greearb@candelatech.com>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
Message-ID: <aadKDCKGHk1Ua-7_@slm.duckdns.org>
References: <fa4e82ee-eb14-3930-c76c-f3bd59c5f258@candelatech.com>
 <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com>
 <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
 <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net>
 <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com>
 <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net>
 <c616fc41-3bc7-4ddc-b65c-a622111d8548@candelatech.com>
 <35779061f94c2a55bb58dcd619ae91c618509cf4.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35779061f94c2a55bb58dcd619ae91c618509cf4.camel@sipsolutions.net>
X-Rspamd-Queue-Id: DB2271F6FE4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32421-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

On Tue, Mar 03, 2026 at 12:49:24PM +0100, Johannes Berg wrote:
> Fair. I don't know, I don't think there's anything that even shows that
> there's a dependency between the two workqueues and the
> "((wq_completion)events_unbound)" and "((wq_completion)events)", and
> there would have to be for it to deadlock this way because of that?
> 
> But one is mm_percpu_wq and the other is system_percpu_wq.
> 
> Tejun, does the workqueue code somehow introduce a dependency between
> different per-CPU workqueues that's not modelled in lockdep?

Hopefully not. Kinda late to the party. Why isn't mm_percpu_wq making
forward progress? That should in all circumstances. What's the work item and
kworker doing?

Thanks.

-- 
tejun

