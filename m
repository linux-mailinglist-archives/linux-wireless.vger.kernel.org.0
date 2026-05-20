Return-Path: <linux-wireless+bounces-36688-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMhwFs9+DWqGyQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36688-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:28:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B284158AC8E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD6CB317B2AF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 08:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F0C3B27DE;
	Wed, 20 May 2026 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xHMuVhFV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D411E3B27D5;
	Wed, 20 May 2026 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267520; cv=none; b=Gv86gNLz8rnz/OyWbcsflXNeRboBOeni7orzhKvGXPu7eLnyXWp5qZAY+lnysSQBqg4d3/DcPdwYL2sfTFA2QkkX9h/z599nsr4ah+HQ7RL1YSN1WrsvIaUwtTxTio67bAbWJgLEw3G3PRKqAuCw8ZLnA2bCYampLeqkblUewXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267520; c=relaxed/simple;
	bh=C7c7KpWnigi7II5FEvk/eOPvVHrwTYsrna6FOHAYA+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VgJlUybTFn7LMCuxUR/EsLGg3Y84nhVWr4H1vrz554lKnpLaoP+aZ2+0xailORiklaIkChRSchaCQFPgYFacGdFwxvWOiPOT4zzRopZPV1sjM/KucsO8q332FSf95uWaMcj4J+9BnWLb7ZiHTfCsqVZtVFVvWKGaolwewLHnMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xHMuVhFV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0kNSpQkTH2BddyvatsQSQRab4uR59/gfZ0Rx4WHQy+g=;
	t=1779267517; x=1780477117; b=xHMuVhFVFChkeBpNanpV4asMtDBKUXBYXL97KgGx42psIh+
	IJPqmk2oSw6hbCFaUMaDqzOTVlOjbB0LBJOdI5NRGBVua1syRNjVWi2nDMHCfFA3yJh239LPsfpqI
	TxEO85jH5aHbxpZ1MeZu1zjhLCkUUPqd1xXGXcGuDVFL1/qABExIocitRpqx37+qMUw9u3unD3l47
	PKtv1I6i7v6C9iE/F/35KecMUCLmxGhOvR+MnYuGU1+U5BQ5IdF7lTMd72mhdHlAFNYSsQ4sgY2KE
	56bmjt+ht5WKawIMVWhcrh9t6pFsbwtqBWKL7c6FRU3zgZL9MnIQqZE4UR+Btfsw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPcl4-0000000A19z-4AXW;
	Wed, 20 May 2026 10:58:31 +0200
Message-ID: <739ba20fa3c88e92bf034d80383015b8bc78ebfe.camel@sipsolutions.net>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?=D3scar?= Alfonso =?ISO-8859-1?Q?D=EDaz?=
	 <oscar.alfonso.diaz@gmail.com>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>, 
	linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, Lorenzo
 Bianconi	 <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 	fjhhz1997@gmail.com, Brite
 <brite.airgeddon@gmail.com>
Date: Wed, 20 May 2026 10:58:29 +0200
In-Reply-To: <CA+bbHrV3fFHWevyDGPtAS=2M2mc+LxP6=xA-5fXaiTKTD=R31g@mail.gmail.com> (sfid-20260520_100244_085590_6B2EF659)
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
	 <20260519235713.49109-1-lucid_duck@justthetip.ca>
	 <20260519235713.49109-2-lucid_duck@justthetip.ca>
	 <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com>
	 <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
	 <CA+bbHrV3fFHWevyDGPtAS=2M2mc+LxP6=xA-5fXaiTKTD=R31g@mail.gmail.com>
	 (sfid-20260520_100244_085590_6B2EF659)
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36688-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[justthetip.ca,vger.kernel.org,nbd.name,kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: B284158AC8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-05-20 at 10:02 +0200, =C3=93scar Alfonso D=C3=ADaz wrote:
> I tested it on 6.18.12
>=20
> Let me know if you need me to test it again or whatever. I remember
> during my testing with the Brite's different patches that is not the
> same testing it on 6.18.x than 6.19 . Some stuff changed and the patch
> needed to be different. I've added Brite to the thread, he can add
> more useful data for you.

I guess I don't really care about 6.18.x or 6.19.x, only about 7.1-rcX
at this point. We'll want to explicitly _not_ backport this fix to older
kernel versions since it caused driver crashes.

> Regarding the approach of fixing the bug on the driver side... I've
> emailed and contacted by IRC to Lorenzo explaining the problem... but
> I got no response. So if we feel yet like this is something that needs
> to be fixed from the "driver side"... how to say it softly... we are
> f***ed up :) . Maybe the "hack" way dealing with the vif null var is
> not bad idea after all as it seems the only way to move forward.

I feel I've tried to say this before, but maybe it helps if I summarise:

There's one feature and one (possible) bug here.

The feature is:
 - monitor mode injection works for chanctx drivers.

The bug is:
 - monitor mode injection with the feature patch crashes at least some
   mt76 devices, which you reported, which I consider to be a bug in the
   driver that needs to be fixed there.

To me, the trade-off is crystal clear - as long as the bug exists, I'm
not going to apply this or a similar patch to enable the feature.

I'm also not going to apply a patch like proposed before that hacks it
by redirecting the vif pointer to a (more or less random) other vif,
that's a lazy hack that happens to fix the problem in your _specific_
use case, but will almost certainly still expose the crash in other use
cases.

I do think there's a chance that between 6.18/6.19 and 7.1-rcX the bug
in the driver has already been fixed, that's why I keep asking about
versions etc. But I also think there's a chance you're just testing
different subdrivers of mt76 with different devices, so I'm also asking
you to compare the specific devices.

I'm happy to apply this patch if the people who previously reported it
to crash (i.e. mostly you, not sure about others) are saying that
against a more recent kernel it no longer causes the test to crash
(rather than just not work, which is clearly better than crashing.)

You could always just claim you've tested this patch without the crash
and I'll apply it, but then if someone still finds a crash I'm just
going to have to revert it, and we'd be back to square one.

I hope this explains what I'm thinking and going to do (and not do),
make of it what you will.

johannes

