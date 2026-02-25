Return-Path: <linux-wireless+bounces-32187-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPpOGPFwn2kccAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32187-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 23:00:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B494B19E124
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 23:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 256D33006B59
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 22:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC71191F92;
	Wed, 25 Feb 2026 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="G/oh1tZM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD531960B
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056814; cv=none; b=ZTe4Q0YTKIKmzu3pH5Dk2k8XcBriviFqvLZy/GdX1mnyhTgd4aBOx6fcBtsaAoRv0tItFYMs/8coIqgsYkAbBe3l8ZDUE6P3tF458S55ZvUTuGiO0QWroBWAOLhjg7+/wUyFWOmsiI86StSSbp9yqYHfM+ASaDTXxr8aeYI63y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056814; c=relaxed/simple;
	bh=WXYczlrT5law2u0ORRrflCf6oFCF/puLyVRx2hMUf+I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AsCF4Sq8CBMRJ6hFpp4J9JGMFQtlOC6FIT+oc99/9Lt+OdXHTmlfa0nbCu3JYKoYi+cRwI1J8nlzCXHeku4jdqe7rY4anjDKWVq/Nc7BnZEogLER26N2P7oPgA6g5BoRR/HdSxa8+erP5aQnv7iOueGja7PcAHNOPAXSnF2vTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G/oh1tZM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UUwvMEF5RKkEkjy5JJXqDmJLBCg/c/dw2hxP52spfck=;
	t=1772056813; x=1773266413; b=G/oh1tZMNQqluCJx8W4bdLSo6R0uZefA1OhHcekSZrWZKuQ
	9dKkV2nNMeZYsc94ayf6G9o/awfF4hlWoYgz9XrkjNqRRaWjNmPKxGycsyiBwMJwPgXv9iRvin27a
	mP+dsXwAWOdBixzl/h8lCkXoULHFv+yF7pAX8mMERz6NJLnZfRunbuocZznCcD7hG7W+OhnkBMeQG
	eALtg9Aj4fsWuwfJsvwCo5Kn/4tYRCfRYpU0wtI0uFV6ANTtEISGgsYBwd5WOVFuKge4XOBWxXVI5
	oy4RyEFdiO58I5DKQDWaH1FTpiyqWqIdkl6slNbstRmNAfGl4tEUlZUh2wO46nlg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vvMvS-00000001ejh-180R;
	Wed, 25 Feb 2026 23:00:10 +0100
Message-ID: <2bd17f45603a295e6ff69de666c41ee7dc2dadd4.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: move action code from per-type frame structs
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Date: Wed, 25 Feb 2026 23:00:09 +0100
In-Reply-To: <a9caee5b-1698-49ae-bf07-77b417e6ff4d@oss.qualcomm.com>
References: 
	<20260225175252.03c5c338a7b2.I9a24328e3ffcaae179466a935f1c3345029f9961@changeid>
	 <4957d35e090d54f098d27f937da70770bc001397.camel@sipsolutions.net>
	 <a9caee5b-1698-49ae-bf07-77b417e6ff4d@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32187-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B494B19E124
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 13:18 -0800, Jeff Johnson wrote:
> On 2/25/2026 9:08 AM, Johannes Berg wrote:
> >=20
> > And a couple of other notes:
> >=20
> > >  				struct{
> > > -					u8 action_code;
> > > +					u8 no_fixed_fields[0];
> > >  					u8 variable[];
> > >  				} __packed chan_switch;
> >=20
> > This thing in a couple of places isn't ideal, but I think it doesn't
> > outweigh the benefits of this structural approach.
>=20
> My fear is that "helpful" members of the community will refer to the
> following, believing this is an old style variable array definition:
>=20
> https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-lengt=
h-and-one-element-arrays

Yeah ... We'll have helpful AIs to tell the "helpful" people off, right?
Right? ;-)

> So I personally feel that a /* no fixed fields */ comment would provide t=
he
> same benefit without bringing unwanted noise (unless the code just doesn'=
t
> build without the member being present).

Ah, but that's exactly the thing, it isn't valid to have structs
completely without members (there's one case without "u8 variable[];"),
nor structs with only a variable member. So indeed it doesn't build
without it.

So ... yeah, not ideal, but I think the structural benefit outweighs the
disadvantage here.

Unless folks disagree with that and think that the action_code really
_should_ be part of the per-action-frame sub-struct? Personally, I think
the code looks better this way, and it has always slightly bothered me,
but I could be convinced otherwise :)

johannes

