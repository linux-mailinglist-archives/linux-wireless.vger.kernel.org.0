Return-Path: <linux-wireless+bounces-34523-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGMgMFBF1mkFCwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34523-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 14:08:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 157303BBC68
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 14:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97878301016C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 12:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B6B3806DA;
	Wed,  8 Apr 2026 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sHFmDNRc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21133BE154
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650075; cv=none; b=Dzakq4jcHnKw+vvUaAjdypWaXQCw/LuhOctm3bGn13WbPLOwEPBu+ZDykRseJyQjo1E+dIFZSq67oacd0THqFKlBfZNfYedpvd5HkqhNnCzh/FQai2IC2S5b/QegipYXGKVCsMeeBS41/ykua9SHwtBYjQ5Ih82RuM6XWCJr7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650075; c=relaxed/simple;
	bh=VGHqSDsuyGvOMpG2LBaW9sjcgyWMpMUJMApoz2641HI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwWOL2l4or93oK3vLrdQW+73jWlIsnt5mqD8xQ1OJ1bSFIHwGuqxh/2YFjSEyGf/kmWVxHsBbwUgBRl+K31EQwDbYbV6U3wRdhu6FcSTw2c/sGda83CNX9F3QnCy6Mx2r4lRke9EhHzAWflt7llnpgEnSC407o9Ypibti87heTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sHFmDNRc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=z0i/v9+wBWPJbCNmaG2kTCrZX9/QKBj4BNK3lp/Bh3Q=;
	t=1775650074; x=1776859674; b=sHFmDNRcm/4XryTLJfiEeXh9xy5wvOFnYNzD7xb7FFMNiyS
	jnueNzo/t9OFhJBQh2X16GkOQ9OC+21t+UTMQvSc4Zgc+yODgh5uHUdRHS/hOxabnjz9hUZUgjeM0
	qUcO+zTBPi+dkPyXg1sNQdOQNLmVvTiiBt4y474FDSHOVYD7kgVZnjbi2beipBTuQF21rmtCDb1eS
	nFQWtXXBUHOxHDCw5Ht41HR78uSFw++B2HQ6DVcL5EPUAlrD2gIUSJoUfGPnlH67qlI3w4ZDvB3Pv
	gCndzM7XUyL41EQ4M1EsWhJ4+lAyk3Zhr3ltfsJ6Wy/O3l2pnIIkthkFWLJusZeQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wARhH-0000000EXeh-2nyj;
	Wed, 08 Apr 2026 14:07:51 +0200
Message-ID: <f60497d95314a9a595d0830cf47de8533674e811.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] wifi: Transition/Padding delay subfields are for
 both EMLSR and EMLMR
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 08 Apr 2026 14:07:50 +0200
In-Reply-To: <822a3036-1cc0-460f-ad04-d711606afd4c@freebox.fr> (sfid-20260407_174732_307875_EE1220BF)
References: <20260327201135.905852-1-pmartin-gomez@freebox.fr>
	 <20260327201135.905852-4-pmartin-gomez@freebox.fr>
	 <6900294c6c10fb7336e8ca6c7217e970db2cc3a1.camel@sipsolutions.net>
	 <822a3036-1cc0-460f-ad04-d711606afd4c@freebox.fr>
	 (sfid-20260407_174732_307875_EE1220BF)
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34523-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 157303BBC68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-07 at 17:47 +0200, Pablo MARTIN-GOMEZ wrote:
> On 07/04/2026 16:00, Johannes Berg wrote:
> > On Fri, 2026-03-27 at 21:11 +0100, Pablo Martin-Gomez wrote:
> > > -#define IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY	0x0070
> > > +#define IEEE80211_EML_CAP_EMLSR_EMLMR_TRANSITION_DELAY	0x0070
> > >  #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_0US		0
> > >  #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_16US		1
> > >  #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_32US		2
> >=20
> > I think this is confusing. You have the "EMLSR_EMLMR_" prefix in the
> > definition for the mask, but not in the values, but also the prefix
> > itself gets very long, not sure what to do about that. Maybe just
> > ..._EML_TRANSITION_DELAY even if it doesn't match the spec completely.
> In the standard, there is two different tables to convert the field
> value to a delay: 9-417j for EMLSR and 9-417l for EMLMR. E.g. if the
> field has the value 1, in EMLSR mode, it's a 16 =C2=B5s delay, in EMLMR m=
ode,
> it's a 32 =C2=B5s delay.

Ouch, good catch. Why do they just want to make everyone's life harder
all the time...

> As no driver implements EMLMR, I was expecting the first one to
> implement it to create the defines:
> ```
> #define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_0US	0
> #define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_32US	1
> [...]
> ```

That seems dangerous, you have to really look hard at the spec to really
notice?

> If you prefer, I can implement it +
> `ieee80211_emlmr_[trans/pad]_delay_in_us` but it will be dead code for no=
w.

Dead code in form of a bunch of defines doesn't seem so bad I guess?

But I still think the naming is confusing. Maybe we just drop the
"EMLSR_EMLMR_" from the *mask* define, and have it only for the
individual defines, as say

#define IEEE80211_EML_CAP_EML_TRANSITION_DELAY	0x0070
#define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_0US	0
#define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_16US	1
#define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_32US	2
...
#define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_32US	1
...

I think that'd also call out that in fact those are (needlessly)
different.

johannes

