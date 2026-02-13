Return-Path: <linux-wireless+bounces-31815-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPtFCH38jmmOGwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31815-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 11:27:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD513512B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 11:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C5F230166FE
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3AC35294F;
	Fri, 13 Feb 2026 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QwCl8W+K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43799350D40
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978425; cv=none; b=SZ3mEH1mDS3w2NYyIHxskc8HO6zewtz/1Kf88/jZIODmSRMzWWAA91fvfE5FtuKWgfXgfxLrZOYLssMt3lGGYPG/boNL02B7cD/MsH+Ww9JgrsxkYg1dHwdcF8BuI/w8hgcIn98b1IVuYixJ/rXhRwyyUbKlI5IeVQj6lYAKsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978425; c=relaxed/simple;
	bh=nuU36DoW3X5FKwPFJ/6M1EXAal9JqKxkKEY++HTWa2o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A/qb1A8GLJoP/orW+C/h5BDJ3K8ETLfMZZJKQooXcLJOQ7RXAcbk2OBz2adANnvGYkkNN6Zu5qc1bbQIvn7aFk4Dczp5cXM5yX1LAwLriWuz6C2/ZG+19ZKVV7LNT7h0PCr2RJqstamKiXYL2jSoPZ3Q2g4S2XHQ7iUCZKwYVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QwCl8W+K; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DS2h1Kddm9w8T7RZLXnccTq+/EyFxF7WwBUsGnMZxOc=;
	t=1770978423; x=1772188023; b=QwCl8W+KXrtvZH5/ef3MlZjNc1uMUL712ZtkFhJtjc1WL6q
	XWovEaAegu1JiAKanXJT0nyKNL6bDbUq1jsAvd1KbSGBG0QTNkrnlFZIo9Z6/9JoV2kZIyQ8wT98C
	COtLjeDgCH0xp18OrySKW+Ylh4n9z0hglK1kAYWRiAa5Qopd219nqIjjRjrWRAVmWZ458UG0OecKU
	zydKZmV2RUalgWdMb+uLFl6nsEu3KNW/S10xF14g+nevhgocxTpRTVaYpkypZ5cQNV+UkOke4/dNK
	45H+oo/DtdvXXPVmyxJ68g8utiybnmAx1A86u1W4lz+HnkwSfGlHspWOl3v3JTjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vqqO2-00000007NB7-0SRV;
	Fri, 13 Feb 2026 11:26:58 +0100
Message-ID: <9576fdbc0b9b62caba88e05716d7c7028512130d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 2/3] wifi: cfg80211: add initial UHR
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Harshitha Prem <harshitha.prem@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>, 
	vasanthakumar.thiagarajan@oss.qualcomm.com, Lorenzo Bianconi
 <lorenzo@kernel.org>, 	ath12k@lists.infradead.org, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>,  Ping-Ke Shih <pkshih@realtek.com>
Date: Fri, 13 Feb 2026 11:26:57 +0100
In-Reply-To: <be9ab3c7f05b0f56f19aee0ffc7c2f96138b9a05.camel@sipsolutions.net>
References: <20260130154259.265130-5-johannes@sipsolutions.net>
		 <20260130164259.54cc12fbb307.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
		 <f96125eeda23451c19067359eb9d10b4047bcdd3.camel@sipsolutions.net>
		 <5d54feea-d0cd-4bd7-b0d2-02e42f0fe5e1@oss.qualcomm.com>
	 <be9ab3c7f05b0f56f19aee0ffc7c2f96138b9a05.camel@sipsolutions.net>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-31815-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+]
X-Rspamd-Queue-Id: 7BAD513512B
X-Rspamd-Action: no action

On Fri, 2026-02-13 at 11:11 +0100, Johannes Berg wrote:
> Hi Harshita,
>=20
> > > Should we add a separate netlink attribute for the UHR operation, whi=
ch
> > > hostapd would fill with the _full_ data like it appears in associatio=
n
> > > response etc.?
> > >=20
> > > That way, hostapd doesn't need to build a separate data/attribute
> > > structure but can just use hostapd_eid_uhr_operation(..., false) for =
it.
> > >=20
> > > An alternative would be to add more attributes for everything, but it=
's
> > > probably more complicated on both sides?
>=20
> > Thank you for the suggestions.
> >=20
> > We feel that using separate nested attributes for each feature is the b=
etter approach, as this allows us to reuse the attributes for the Enhanced =
BSS Parameter Critical Update procedure, where similar information is carri=
ed in the UHR parameters update element.
>=20
> Heh, I'll admit I'm surprised - I'm usually the one advocating for
> finer-grained attributes, and here I didn't ;-)

Wait, so I wrote a lot and forgot to circle back to this question ...

Basically I think that it's not going to be useful to split it up. I
have no objections to it, but it complicates the code (especially in
hostapd) quite a bit, because it's going to be either

 1) include each thing (NPCA, DBE, ...) in its own attribute, so that
    e.g. NPCA would be 4 or 6 bytes per spec format, but then we need
    separate validation for each in nl80211

 2) we really break it all down to each individual value, so e.g. NPCA
    would have separate attributes for minimum duration threshold,
    switch and switch back delay, initial QSRC and a MOPLEN flag; this
    is a bit easier to capture in a policy, but a LOT of parameters
    overall.

The thing - and why I wrote so much - is that we basically only need a
single current, and in the case of updates additionally a single post-
update, UHR operation.

So unless we're going to completely design away from beacon templates
and create an API where including the UHR Parameters Update element is
fully the firmware's (or driver's) responsibility across all the
different frame types, then the split isn't really needed. And even if
we _do_ design it completely that way, giving the post-update UHR
operation and comparing to the pre-update one isn't a huge stretch for a
design that just required fully rebuilding all the frames (parsing all
the way into fragmented elements and putting them back together in a
completely new way, including re-fragmenting elements and subelements
etc. which all sounds very messy to me.)

johannes

