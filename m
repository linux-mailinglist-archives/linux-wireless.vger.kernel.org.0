Return-Path: <linux-wireless+bounces-32423-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IhmHbZOp2nKggAAu9opvQ
	(envelope-from <linux-wireless+bounces-32423-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 22:12:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C17451F73C3
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 22:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8FCF306D8A3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5D386450;
	Tue,  3 Mar 2026 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="H/VJE0Jl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2498347531;
	Tue,  3 Mar 2026 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572339; cv=none; b=f6r4CjglLtWKVJOy4JYUAvvA1d+1VDw59Q+D3IRlAArknb4OVWHvoKYoDBKh+si06TqgElg0iPH5nJ4GZXxfhvvWH+gPHWQ9kOBuu6p27QRtAENoOf2hwllBaaAbOT5NmUrvWdyE7CRXWxPRbYJ4wCoXGSisNMZklUUtUXUS/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572339; c=relaxed/simple;
	bh=gZetZJNjR70T/LFjqoXtayWjEQgG9hfstgIaETdeEKA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GVaUzASkMO56OeHFEBO4ORRXDDarI5LAfrqfuEcLjfO/HlTdKcMc1mtqOKIm37wzbxyThM91k39X59spQi/ZlhqLtRYk8Qy2wSlrZW9va35xtLSPIpdfvd0x/nJ+N6bxCVsxzh43uOsqs3yH5ISGNbL9bFnu0i2ukdJ14n+8Jus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=H/VJE0Jl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gZetZJNjR70T/LFjqoXtayWjEQgG9hfstgIaETdeEKA=;
	t=1772572338; x=1773781938; b=H/VJE0JliLw2EDZe2ip9cZFmISiPygr1rsur4M9yJT/9Tsq
	n6drnklx45ap7WJ7DUDy+1fcPaudpFFiTHSxRDFTuq8P/jpODOVCZYRatZ+w/k2efuxMwh8sR3Axu
	U1fozS6cMkcAl0ykRo9gu2UNr0fjgso5sIB4VmVV9WKcFi+/WBKYMjvJ0iiZc7xMM+0sXTw4TbIl4
	fWj+X4WY2syGvHf+neFzypg9A9mOsTR5Mrov6P8PRiQLz/2lSI8XRjq1Uh+pHizRYn9p8nBd72ZeY
	rGJvLc1kzuXp8WEdBYfU2xr0Cd54V/cnVx3rNJ6cZ9vwazNOsk6ZH3H9Ej/pSXPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxX2K-00000007KsF-3UfN;
	Tue, 03 Mar 2026 22:12:13 +0100
Message-ID: <3303d57a4ea6776dbc66ca72441023f76e6f1234.camel@sipsolutions.net>
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
From: Johannes Berg <johannes@sipsolutions.net>
To: Tejun Heo <tj@kernel.org>
Cc: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>, "Korenblit, Miriam Rachel"
	 <miriam.rachel.korenblit@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 03 Mar 2026 22:12:12 +0100
In-Reply-To: <aadKDCKGHk1Ua-7_@slm.duckdns.org>
References: <fa4e82ee-eb14-3930-c76c-f3bd59c5f258@candelatech.com>
	 <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com>
	 <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
	 <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net>
	 <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com>
	 <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net>
	 <c616fc41-3bc7-4ddc-b65c-a622111d8548@candelatech.com>
	 <35779061f94c2a55bb58dcd619ae91c618509cf4.camel@sipsolutions.net>
	 <aadKDCKGHk1Ua-7_@slm.duckdns.org>
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
X-Rspamd-Queue-Id: C17451F73C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32423-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 10:52 -1000, Tejun Heo wrote:
> Hello,
>=20
> On Tue, Mar 03, 2026 at 12:49:24PM +0100, Johannes Berg wrote:
> > Fair. I don't know, I don't think there's anything that even shows that
> > there's a dependency between the two workqueues and the
> > "((wq_completion)events_unbound)" and "((wq_completion)events)", and
> > there would have to be for it to deadlock this way because of that?
> >=20
> > But one is mm_percpu_wq and the other is system_percpu_wq.
> >=20
> > Tejun, does the workqueue code somehow introduce a dependency between
> > different per-CPU workqueues that's not modelled in lockdep?
>=20
> Hopefully not. Kinda late to the party. Why isn't mm_percpu_wq making
> forward progress? That should in all circumstances. What's the work item =
and
> kworker doing?

Oh and in addition: the worker that's kicked off by
__lru_add_drain_all() doesn't really seem to do anything long-running?
It's lru_add_drain_per_cpu(), which is lru_add_and_bh_lrus_drain(),
which would appear to be entirely non-sleepable code (holding either
local locks or having irqs disabled.) It also doesn't show up in the
log, apparently, hence my question about strange dependencies.

johannes

