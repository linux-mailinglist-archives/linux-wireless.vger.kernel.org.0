Return-Path: <linux-wireless+bounces-31694-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANQKMFgKi2kdPQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31694-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 11:37:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E661119B08
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 11:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 990F43029796
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 10:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32503161BA;
	Tue, 10 Feb 2026 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HlEjUadh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433C3164A5
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719822; cv=none; b=lGPM7TYy/GEZWk/iCGDcpTH+gWxPhdWD3RhZQgEQnOekaUqYX/cs36Rsf9pdEpsiHifTMAULCA6Js9DxHICyqgFeel8wsoGlu5lRvvIq7cgyckTkTEt8i1ja73preWLQY3Ds5vhykyISRuuLCzVKOvAvtlxUYRvevs8ITaDin7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719822; c=relaxed/simple;
	bh=Z569VX5YG9V9oFahZBC7V+JFR/SNNFlMxFGYmabmESk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dsjFcH+MmbYyMjkjry6rifUqZuglC2Ljanj3zsXZKI1q9/DbBrpIV2vHqb+0kXrq53XJvLk0ecrYX8YOK/nfxo9Q3LyGhmoa9tlhAiWrGlgm4TZ9u5npCQt1FkJNSQoe3TL0XM27bleqDlAXsBvcS4gCAEGqVIbBd9JQyW1YL6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HlEjUadh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fvgbixcGr8lvU9U9HHw5iujr/BBUDPy/zYQyK5+xPoU=;
	t=1770719821; x=1771929421; b=HlEjUadhMpokHhxtT7hSwpPdvgomNh6QvAJWWpxWhefxVXL
	LN3ZsEqQs/nQa1Q/3NNkUYNSZFYjwhPjYjqcSrhWyNcK3+MU8retH9r4uKsAW+TRh/qN37ChsNdCt
	Rx09fsWaT2AeUS49Ts9J1p+2Hmlmo9Qvu8T+hyZA4QaJ+eEtXZSYjFuxr6xVZzmcBWwUT8RxT6Jz8
	4+fl1X7zwnvFAINsgBvTRJ9WGo3QvDQF2ysW9JJAo24ddWZSj2h/jcFWFj/EuqTuZf/hlBCnKqdmO
	zCNWyoh9LON0XOYwyOi4nxU002m6kF3KZCzfWzsz8d+OtJhBzCYkVwOx9HrUX/Rg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vpl74-00000003zUB-0RYM;
	Tue, 10 Feb 2026 11:36:58 +0100
Message-ID: <6c320ef1b8dc27cb70ec88ccbfb8add6b4d212cd.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 3/3] wifi: mac80211_hwsim: add
 incumbent signal interference detection support
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <amith.a@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Aditya Kumar Singh
	 <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 11:36:57 +0100
In-Reply-To: <307b4098-8154-4d83-993d-88efe38426df@oss.qualcomm.com>
References: <20260205112146.3997044-1-amith.a@oss.qualcomm.com>
	 <20260205112146.3997044-4-amith.a@oss.qualcomm.com>
	 <858522d4e40ec73197bda6a9753b2eac8c07d145.camel@sipsolutions.net>
	 <307b4098-8154-4d83-993d-88efe38426df@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31694-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 3E661119B08
X-Rspamd-Action: no action

On Tue, 2026-02-10 at 16:06 +0530, Amith A wrote:
>=20
> > > +static int hwsim_write_simulate_incumbent_signal(void *dat, u64 val)
> > > +{
> > > +	struct mac80211_hwsim_data *data =3D dat;
> > > +	struct ieee80211_chanctx_conf *chanctx_conf =3D NULL;
> > > +
> > > +	ieee80211_iter_chan_contexts_atomic(data->hw,
> > > +					    hwsim_6ghz_chanctx_iter,
> > > +					    &chanctx_conf);
> > > +
> > > +	if (!chanctx_conf)
> > > +		return -EINVAL;
> > Wouldn't it make more sense require userspace to write also the
> > frequency, rather than randomly picking the first 6 GHz chandef?
> Agree. I=E2=80=99m currently using DEFINE_DEBUGFS_ATTRIBUTE, which only s=
upports
> a single u64 write. To accept both frequency and bitmap, is it okay if
> define a custom fops with a .write that parses two arguments?

Ah, right, 'u64 val'.

I guess you have no choice but to define a new operation, sure :-)

johannes

