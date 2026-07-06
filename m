Return-Path: <linux-wireless+bounces-38695-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BSqQDsfJS2ofaQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38695-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 17:29:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 322EC7129AB
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 17:29:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=wvCeS84a;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38695-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38695-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 497FF30EC7FE
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 14:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E572BEC52;
	Mon,  6 Jul 2026 14:34:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013F93806DD;
	Mon,  6 Jul 2026 14:34:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348452; cv=none; b=kHVCd3+hhyw1rYKYeddFQqhwoknVoqs0t0cSPdhuXzDqzHUO5dPzJcy2/1ejz4zsyJFcvAN3IFW7lg4FN3Z3PzZRyXwh2TZdBjIGVIBUUlqCQ4SVA+pnFWSQKULFnwma6zla0dErKFDh6FUsp+uYPP3p6e49fJVAdR8XR0doAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348452; c=relaxed/simple;
	bh=87F/0z6PhDIEqZ1Y8WA3OI3baoYr7Lbq1/GbUEM5B8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/NhwakTiwX3DolYs19677WSkeCEFNL6CVivqFuU9XC6rQnLyunBxB/YYaZ25omWVPDq6RxeUpSD+YMAZwt2eTN8art7m8YobcKUaNMaYQRGeYwAK/3OucH8Ld/eITwPy31/yx0edvI6lLfow4vISYVvQlOugnn+YmpV/dVNEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wvCeS84a; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=87F/0z6PhDIEqZ1Y8WA3OI3baoYr7Lbq1/GbUEM5B8w=;
	t=1783348451; x=1784558051; b=wvCeS84aRt+IoKQR7nFA9CvSZJ9u43QnYUW8HkDNf4rP/xh
	p3SEgtpY2U4HSJVMrx/0X3Wb6c/ALC8UB69ojTb5GeeIm3xhKKT9bvlB05NmeyhNr5Hh/Z1H5YpJe
	HmTiGUW5U8O7zqzAUXtu3hh0D6mJerM7er0Spf1rWYTgyPYdy//dzsoE42fJdefR6WLozxHTuAnNZ
	C90RrT8dgQrFinyleK2GVD2xvyCbYd9b77R+wlErnvFZqlMB+Mw4nR3jeniWLQHL0gEtVnu5+rfZr
	B9hUG0MrcUGpA1tpWE/Eqv3NpVYGMBMior8rs4SOfadyOWiVs/WcELvw3ZWMjtUg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wgkOe-0000000DU53-1WND;
	Mon, 06 Jul 2026 16:34:08 +0200
Message-ID: <a2dd36c58cb228693428c5a5abe3e14ef6376e7c.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: serialize socket owner release with
 netdev teardown
From: Johannes Berg <johannes@sipsolutions.net>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com
Date: Mon, 06 Jul 2026 16:34:07 +0200
In-Reply-To: <CAFRLqsXDDO=fzwwe5eNEkS=qUjf9=2X=NrX+LcZ+TNkMN+fF5Q@mail.gmail.com> (sfid-20260706_142458_242277_5D2336AE)
References: <20260619162500.3876325-1-zzzccc427@gmail.com>
	 <4fc7e89b3203e9bc8843c848268519d34585a038.camel@sipsolutions.net>
	 <CAFRLqsXDDO=fzwwe5eNEkS=qUjf9=2X=NrX+LcZ+TNkMN+fF5Q@mail.gmail.com>
	 (sfid-20260706_142458_242277_5D2336AE)
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zzzccc427@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38695-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 322EC7129AB

On Mon, 2026-07-06 at 20:24 +0800, Cen Zhang wrote:
> Hi Johannes,
>=20
> Thanks for your review and comments.
>=20
> > What's that supposed to mean? Of course there's ordering between those
> > two things?
>=20
> You're right, that wording was imprecise.
>=20
> I didn't mean that NETDEV_GOING_DOWN and NETDEV_UNREGISTER are unordered =
with
> respect to each other. What I meant is that the NETLINK_URELEASE notifier=
's
> schedule_work() site is not ordered against the teardown-side
> cancel_work_sync() for the same wdev.

Yeah, fair.

> I chose RTNL because netdev notifier delivery is already serialized by RT=
NL,
> so it orders the existing schedule_work() producer against the existing
> cancel_work_sync() with a small change. But if you prefer moving the canc=
el,
> I can rework v2 in that direction.
>=20
> My only concern with simply moving a final cancel into
> _cfg80211_unregister_wdev() is that this path is called with the wiphy mu=
tex
> held, while cfg80211_autodisconnect_wk() also takes the wiphy mutex. So I
> think the final drain would need to happen after the RCU readers are gone=
,
> but outside the wiphy lock and before the wdev/netdev lifetime can end.

Sounds like maybe it should just be a wiphy work so we don't have to
worry about the locking at all?

johannes

