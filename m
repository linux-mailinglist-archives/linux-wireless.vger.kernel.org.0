Return-Path: <linux-wireless+bounces-32350-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGWWDN+vpWkiEgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32350-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 16:42:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A71DC0DB
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 16:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6268E300A748
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC387411626;
	Mon,  2 Mar 2026 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iIedb1yE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43652387597
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465928; cv=none; b=PRT/R5zYXGpaaQboI2vFYKfOj8wBSy7pFJPPx7HyA4K8ZDpwe4z+IIRbCBjMkjJcvxf8o8CJ6Lhj4+v4OX68lha1V7TCC/G29U+uMBj60Nd1sJ+pHSDQKFeuMVRL3DHKV0pJZVqC5Bzo4OP9GDfZaYYPuoxzZFflopDHER+c1Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465928; c=relaxed/simple;
	bh=qe4NnwKZN0XLD0rq/BNMxoRYM1d09Q+UEPEo5cE8pl8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eKSEYrcBKqPlPr12xjLqdDsIOrATc3EJzKK+MUPuM4SYq3hnnUpgUhAcljRnLonctAOGI6MW9L2VCIPeSNT6uRR8ktajzZLRkz9yTtZRYA2gLiDzaeSLssHxA5vuerGbCYB757KJJWRlQywp6XN80Aw/CYVxqxlw+Y4Xii+I+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iIedb1yE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lkos/UwEVF+f0nD+l8Noi+Rcb16prIOjHEXIGFnI3Kw=;
	t=1772465927; x=1773675527; b=iIedb1yEaFDF+d/9/njmyE3Aj1GwjR2SKwzd+NCGaShhobv
	es09q7wDM077BQwvdVeQnZ7WGVXz0oyu6UJbLR8ePKIdisLhgzvX38AlMGTi53PAdjZRS3d5zaWTZ
	2SBkwM7+E39QFT6Qc6dPKlUxGMK4wV8tvVkcpE9ZDUQ15N9HT1zZRMU6iR9psSGoR5PYMjpPoA/t1
	wpCAuSV6nEyJPNxHc1C5LxuQKC0M38pT8AGKMYiYevoo75i24fky5ftlisGLQfgSNNrv0z05B94+w
	a9RUJMvsKtrtyOHqISqBXnnvkSi263OyVswBUM8GXapfa/NGG/1yPDfFf3BH6/rQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vx5M3-00000006DCo-0pRn;
	Mon, 02 Mar 2026 16:38:43 +0100
Message-ID: <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net>
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>
Date: Mon, 02 Mar 2026 16:38:42 +0100
In-Reply-To: <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com>
References: <fa4e82ee-eb14-3930-c76c-f3bd59c5f258@candelatech.com>
	 <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com>
	 <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
	 <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net>
	 <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com>
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
X-Rspamd-Queue-Id: 882A71DC0DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32350-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Mon, 2026-03-02 at 07:26 -0800, Ben Greear wrote:
>=20
> >=20
> > Was this with lockdep? If so, it complain about anything?
> >=20
> > I'm having a hard time seeing why it would deadlock at all when wifi
> > uses  schedule_work() and therefore the system_percpu_wq, and
> > __lru_add_drain_all() flushes lru_add_drain_work on mm_percpu_wq, and
> > lru_add_and_bh_lrus_drain() doesn't really _seem_ to do anything relate=
d
> > to RTNL etc.?
> >=20
> > I think we need a real explanation here rather than "if I randomly
> > change this, it no longer appears".
>=20
> The path where iwlwifi acquires CMA holds rtnl and/or wiphy locks before
> allocating CMA memory, as expected.
>=20
> And the CMA allocation path attempts to flush the work queues in
> at least some cases.
>=20
> If there is a work item queued that is trying to grab rtnl and/or wiphy l=
ock
> when CMA attempts to flush, then the flush work cannot complete, so it de=
adlocks.
>=20
> Lockdep doesn't warn about this.

It really should, in cases where it can actually happen, I wrote the
code myself for that... Though things have changed since, and the checks
were lost at least once (and re-added), so I suppose it's possible that
they were lost _again_, but the flushing system is far more flexible now
and it's not flushing the same workqueue anyway, so it shouldn't happen.

I stand by what I said before, need to show more precisely what depends
on what, and I'm not going to accept a random kthread into this.

johannes

