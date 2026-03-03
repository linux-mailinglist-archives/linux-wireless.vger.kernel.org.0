Return-Path: <linux-wireless+bounces-32390-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM+sGoLSpmnHWgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32390-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 13:22:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D74171EF50F
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 13:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0268F3106C52
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA972D46B3;
	Tue,  3 Mar 2026 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UcQD63me"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E3B31ED7D;
	Tue,  3 Mar 2026 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538573; cv=none; b=Rmge+facdIQgewis4aQCRCeFyNQN4CCe4eowmUSd+SuEvslamW0oz7yOEuiap9M0VQxsTdL6baIqw7LsCJj9muyeA/nBdNQNob327y9s33q00QAO/+eFnYthDieDlUv1KCIVkH44ihCYVALjERtqr4yWKcDhZi0Qeq2lLkTPFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538573; c=relaxed/simple;
	bh=0WwQnL5nFk1uqbMseEGuyIPOhaKzewrALsHncVbUmGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eclxsgEwD0ky2KdcKySz0h5/AGm/vPk+leO5sPCj59mr1B8Dy4C2K3PV5MAZ15ZVTC5J32yYAFTd65aEqoVQG2mjxlN3ttHPuxwak84lL8cLUfrSmSjkcu+zFbNqe4v9h6fmvFjve5avwWCWjLpKDCgvgEXbpdSIxk/o5R0OYQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UcQD63me; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hLIQPSMZxH5XPx9wxSi/zIDIJTBwL2PHFwUC/MuVlSM=;
	t=1772538572; x=1773748172; b=UcQD63mejLZgiP8ScA331TExwuZy3/02vyxtkN7hWmdORDD
	cmOVhUkyq5rM9iHuUFwIa36xgQq+s1PxeiyFycLi4mSI5I+y8Va7GJPPJlF3YZg9wqwvKanikqYAH
	AezB9fUrV1bn1vfqwj5vgrdfxs4y1PY4V/wQnfeHPt1UqyBXN47J0i4gaXx1czHkPunfWwfzZGkNN
	VVdYIemQnINDD8YNjCIqRGAHryZN+fVmv7RwjmAsZjjZn8OaAf6Nnl0MaPsQUcgI6M0fiH/5drmOp
	1OVS0vzCXPBIEF4EWOsAanUUlHWG7gAsZ2UdE3HaZ+zWEZTzyNsfCJpGQN3Dp0vQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxOFh-000000075Cr-2ndV;
	Tue, 03 Mar 2026 12:49:25 +0100
Message-ID: <35779061f94c2a55bb58dcd619ae91c618509cf4.camel@sipsolutions.net>
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Date: Tue, 03 Mar 2026 12:49:24 +0100
In-Reply-To: <c616fc41-3bc7-4ddc-b65c-a622111d8548@candelatech.com>
References: <fa4e82ee-eb14-3930-c76c-f3bd59c5f258@candelatech.com>
	 <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com>
	 <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
	 <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net>
	 <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com>
	 <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net>
	 <c616fc41-3bc7-4ddc-b65c-a622111d8548@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: D74171EF50F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32390-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Mon, 2026-03-02 at 07:50 -0800, Ben Greear wrote:
> On 3/2/26 07:38, Johannes Berg wrote:
> > On Mon, 2026-03-02 at 07:26 -0800, Ben Greear wrote:
> > >=20
> > > >=20
> > > > Was this with lockdep? If so, it complain about anything?
> > > >=20
> > > > I'm having a hard time seeing why it would deadlock at all when wif=
i
> > > > uses  schedule_work() and therefore the system_percpu_wq, and
> > > > __lru_add_drain_all() flushes lru_add_drain_work on mm_percpu_wq, a=
nd
> > > > lru_add_and_bh_lrus_drain() doesn't really _seem_ to do anything re=
lated
> > > > to RTNL etc.?
> > > >=20
> > > > I think we need a real explanation here rather than "if I randomly
> > > > change this, it no longer appears".
> > >=20
> > > The path where iwlwifi acquires CMA holds rtnl and/or wiphy locks bef=
ore
> > > allocating CMA memory, as expected.
> > >=20
> > > And the CMA allocation path attempts to flush the work queues in
> > > at least some cases.
> > >=20
> > > If there is a work item queued that is trying to grab rtnl and/or wip=
hy lock
> > > when CMA attempts to flush, then the flush work cannot complete, so i=
t deadlocks.
> > >=20
> > > Lockdep doesn't warn about this.
> >=20
> > It really should, in cases where it can actually happen, I wrote the
> > code myself for that... Though things have changed since, and the check=
s
> > were lost at least once (and re-added), so I suppose it's possible that
> > they were lost _again_, but the flushing system is far more flexible no=
w
> > and it's not flushing the same workqueue anyway, so it shouldn't happen=
.
> >=20
> > I stand by what I said before, need to show more precisely what depends
> > on what, and I'm not going to accept a random kthread into this.
>=20
> My first email on the topic has process stack traces as well as lockdep
> locks-held printout that points to the deadlock.  I'm not sure what else =
to offer...please let me know
> what you'd like to see.

Fair. I don't know, I don't think there's anything that even shows that
there's a dependency between the two workqueues and the
"((wq_completion)events_unbound)" and "((wq_completion)events)", and
there would have to be for it to deadlock this way because of that?

But one is mm_percpu_wq and the other is system_percpu_wq.

Tejun, does the workqueue code somehow introduce a dependency between
different per-CPU workqueues that's not modelled in lockdep?

johannes

