Return-Path: <linux-wireless+bounces-32432-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGcVAeKip2m4iwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32432-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 04:11:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B681FA3B4
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 04:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FED6301FC92
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 03:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98243364E91;
	Wed,  4 Mar 2026 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="KKKbWGno"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF418EB0
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 03:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772593885; cv=none; b=Hj8A9/Uhs6D6gZCROtEW44o/P4no7IsHkSWc8CbaxL99pcvdr4XMFuqhJeC3/t4Kb1ICUcyvj8ZSqPoSmp51iJWO8pqaxpqRV2xyhbbh3X7v7Ef8IAuY9xUMJaRuJgdhVDvmx7CoQ/erz/MzXfkJdBTp92Kx+BExVOfAO7/Zm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772593885; c=relaxed/simple;
	bh=k5bO1k7+7DcfEketxrhE/s6m6h//szOl5ybqxwShOlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3PzONO0f/a1AtCL46bVc9uw5rGVbZVlqOMTNK6/kPZjGSz2QcZzaDFZWsvMfjKFzUEDiOpMJPTurhM3DBahOwetf/fmmAT1uCQi2PmI0HkgAY1nuTBch//5czaByady6UKz6HnaT7og6ytfwn1I3mT5wvbFePHdEiKndPidjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=KKKbWGno; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1772593880;
	bh=VqTvxPWzCZleF/cQGDr+4cElbXvFJHr3M2AYce9c8sU=;
	h=From:Subject:Date:Message-ID;
	b=KKKbWGnoqIlOiGIhrLNILalg+M2Xy0tdxEMu91316L9+ORlze79ZbRvksgDAMSMaR
	 t1QroExkuK6mKtNIQjYEvEET059O0yIvxEBRwVgkhjvRFTNgsyWDZ8+jJ6znrSqEcu
	 MblAvoydBMkIw+oh/5OWkLz11pE+xgYlD1L5Jgzw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.32) with ESMTP
	id 69A7A23B000068A2; Wed, 4 Mar 2026 11:08:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7553394456883
X-SMAIL-UIID: 9ACF65E9A8934540A480B37432775D4D-20260304-110846-1
From: Hillf Danton <hdanton@sina.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ben Greear <greearb@candelatech.com>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	linux-mm@kvack.org,
	Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is active.
Date: Wed,  4 Mar 2026 11:08:34 +0800
Message-ID: <20260304030835.610-1-hdanton@sina.com>
In-Reply-To: <35779061f94c2a55bb58dcd619ae91c618509cf4.camel@sipsolutions.net>
References: <fa4e82ee-eb14-3930-c76c-f3bd59c5f258@candelatech.com> <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com> <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com> <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net> <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com> <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net> <c616fc41-3bc7-4ddc-b65c-a622111d8548@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 75B681FA3B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32432-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hdanton@sina.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sina.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[sina.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026 12:49:24 +0100 Johannes Berg wrote:
>On Mon, 2026-03-02 at 07:50 -0800, Ben Greear wrote:
>> On 3/2/26 07:38, Johannes Berg wrote:
>> > On Mon, 2026-03-02 at 07:26 -0800, Ben Greear wrote:
>> > > > 
>> > > > Was this with lockdep? If so, it complain about anything?
>> > > > 
>> > > > I'm having a hard time seeing why it would deadlock at all when wifi
>> > > > uses  schedule_work() and therefore the system_percpu_wq, and
>> > > > __lru_add_drain_all() flushes lru_add_drain_work on mm_percpu_wq, and
>> > > > lru_add_and_bh_lrus_drain() doesn't really _seem_ to do anything related
>> > > > to RTNL etc.?
>> > > > 
>> > > > I think we need a real explanation here rather than "if I randomly
>> > > > change this, it no longer appears".
>> > > 
>> > > The path where iwlwifi acquires CMA holds rtnl and/or wiphy locks before
>> > > allocating CMA memory, as expected.
>> > > 
>> > > And the CMA allocation path attempts to flush the work queues in
>> > > at least some cases.
>> > > 
>> > > If there is a work item queued that is trying to grab rtnl and/or wiphy lock
>> > > when CMA attempts to flush, then the flush work cannot complete, so it deadlocks.
>> > > 
>> > > Lockdep doesn't warn about this.
>> > 
>> > It really should, in cases where it can actually happen, I wrote the
>> > code myself for that... Though things have changed since, and the checks
>> > were lost at least once (and re-added), so I suppose it's possible that
>> > they were lost _again_, but the flushing system is far more flexible now
>> > and it's not flushing the same workqueue anyway, so it shouldn't happen.
>> > 
>> > I stand by what I said before, need to show more precisely what depends
>> > on what, and I'm not going to accept a random kthread into this.
>> 
>> My first email on the topic has process stack traces as well as lockdep
>> locks-held printout that points to the deadlock.  I'm not sure what else to offer...please let me know
>> what you'd like to see.
>
> Fair. I don't know, I don't think there's anything that even shows that
> there's a dependency between the two workqueues and the
> "((wq_completion)events_unbound)" and "((wq_completion)events)", and
> there would have to be for it to deadlock this way because of that?
>
Given the locks held [1],

	kworker/1:0/39480	kworker/u32:11/34989
	rtnl_mutex
				&rdev->wiphy.mtx
				__lru_add_drain_all
				  flush_work(&per_cpu(lru_add_drain_work, cpu))
	&rdev->wiphy.mtx

__if__ there is one work item queued __before__ one of the flush targets on
workqueue and it acquires the rtnl mutex, then no deadlock can rise,
because worker-xyz gets off CPU due to failing to take the rtnl lock then
worker-xyz+1 dequeus the flush target and completes it due to nothing
with rtnl. Same applies to the wiphy lock.

BTW any chance for queuing work that acquires rtnl lock on mm_percpu_wq?

[1] Subject: 6.18.13 iwlwifi deadlock allocating cma while work-item is active.
https://lore.kernel.org/linux-wireless/fa4e82ee-eb14-3930-c76c-f3bd59c5f258@candelatech.com/

