Return-Path: <linux-wireless+bounces-37289-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEPZHrV8HmrnjgkAu9opvQ
	(envelope-from <linux-wireless+bounces-37289-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 08:48:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1645629261
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 08:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4961300D317
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 06:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29433A05C2;
	Tue,  2 Jun 2026 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMrt8VQ8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC927F19F;
	Tue,  2 Jun 2026 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382612; cv=none; b=RB/UaFSBjj8u+/7sRApW6e3Nu6ClLLhnf32pFovSr9WhSv3Hn4jnmvYkSOdhMU6a8gKPM96c9TVBh0tof5iIQeLwqx1Z9a4YRz+vQAFn6nJrqfH/YkTykzG95OxFrz+ly5KivmvsRiqKr+dL6uEcL5UiUjg/F/jJlaNIgY2aMX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382612; c=relaxed/simple;
	bh=oVz6SYKqYy1ykUS1fwQECnfl6EKiONJTsloqPqT0xyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIWNiausAE7Jqpzs1Kjeo/s7q8GQYcKCE8b8gui6qFeNrwd/jYZqbN+Fq8tNC1GusEJigUH2WgHWoKilhVg1xctaZno4C9upORZmn/9aPo2fdndNNRbtvfY3hrdsQIrnBUfr88G7mrV0wzJ3e03EuIlG0NjDLp8ppGrBada6Zlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMrt8VQ8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D7F1F00893;
	Tue,  2 Jun 2026 06:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780382611;
	bh=oVz6SYKqYy1ykUS1fwQECnfl6EKiONJTsloqPqT0xyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HMrt8VQ8uviRax8hfIijft+UtVgXap1KfnuLZUk9hKw3gmtJtZrF+2F0P9L2zwv6B
	 OYVkXHe5ymymdtUGoHD8xqvbGWUxJc1bOI2lCCXUDxKLiejmYCSzKI0APvGYSdlZFv
	 Gbj8qld+TsJLHaPOFGx3DCjpiIQKTEHVGWfqTgnLfquLyY27gmmakOp3nepTSoELKp
	 ieziZVdbzoSz6bS3HS+dvaaJtnHGWxVjP1KuVUXiEvu7zmmL961jRIMW7GvKczDLnx
	 gzUFgY6oQ7aHFoPKCFs7zDfZo967XXwqX6FJBwkBxaKAwLNlY8Y+LrEwPR1dhXw0E+
	 UZQpNVNw7uMpQ==
Date: Tue, 2 Jun 2026 08:43:27 +0200
From: "lorenzo@kernel.org" <lorenzo@kernel.org>
To: Roy Luo <roychl666@gmail.com>
Cc: Ryder Lee <Ryder.Lee@mediatek.com>,
	Shayne Chen =?utf-8?B?KOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"nbd@nbd.name" <nbd@nbd.name>, Roy-CH Luo <Roy-CH.Luo@mediatek.com>,
	Chui-hao Chiu =?utf-8?B?KOmCseWegua1qSk=?= <Chui-hao.Chiu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Sean Wang <Sean.Wang@mediatek.com>,
	Bo Jiao =?utf-8?B?KOeEpuazoik=?= <Bo.Jiao@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Message-ID: <ah57j_SwdVZTc0GR@lore-rh-laptop>
References: <20260531-mt76_tx_status_skb_add-overwrite-fix-v2-1-b73c4b4a9798@kernel.org>
 <ee0e584cb2ad1b536d327eb89342d1646fa96570.camel@mediatek.com>
 <ahwla_obwnwr2cZo@lore-desk>
 <44c54ed4da0d294c567b3b0ad750f082a6f1be9f.camel@mediatek.com>
 <ahwzwHDF7fT9t7hP@lore-desk>
 <7f02be7c4f919413718a0218b3792d4b0a222ca3.camel@mediatek.com>
 <ah0fGek5y8Nha0kd@lore-rh-laptop>
 <CAHoxoj+N3AtJgFD8vGP+uDpj6anKMgPBtZGejLDgAz0ZyisSHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vyatZ5JMfhikfHCS"
Content-Disposition: inline
In-Reply-To: <CAHoxoj+N3AtJgFD8vGP+uDpj6anKMgPBtZGejLDgAz0ZyisSHg@mail.gmail.com>
X-Spamd-Result: default: False [-1.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37289-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[mediatek.com,nbd.name,collabora.com,vger.kernel.org,lists.infradead.org,gmail.com];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F1645629261
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--vyatZ5JMfhikfHCS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 01, Roy Luo wrote:
> > > I mean the link_id is only corresponds to one specific flags bit of
> > > mac80211_tx_control_flags. But there are other bits that aren't
> > > handled. Wouldn't u32 flags make it more cleaner?
> >
> > Yes, I got your point, but my concern is if we need to sync link_id bet=
ween
> > mt7996_tx_prepare_skb() and mt7996_mac_write_txwi(). If so, I guess it =
is
> > much better to pass link_id explicitly to mt7996_mac_write_txwi() since=
 it
> > does not just depended on mac80211_tx_control_flags and I think we shou=
ld
> > not duplicate the logic in mt7996_mac_write_txwi(). Got my point?
> > If in the future (not required now) we need to pass mac80211_tx_control=
_flags
> > to mt7996_mac_write_txwi(), we will do it easily.
> >
> > Regards,
> > Lorenzo
> >
> > >
> > > Ryder
> > >
> > >
>=20
> Lorenzo,

Hi Roy,

>=20
> I got your point and IIUC the problem being addressed in this patch is th=
at
> the link id assignment has unnecessary duplicated logic across different
> places. However, the commit tile "fix reading zeroed info->control.flags"
> seems a bit misleading to me - this patch does not fully address the prob=
lem
> where the info->control.flags is cleared by memset in tx path when its
> value might still be referenced, the field is still zeroed after
> mt76_tx_status_skb_add() and whoever reads it afterward would get
> incorrect value. With this patch, we avoid using the incorrect value for
> link id, but the root cause remains.

This patch is actually fixing both of the issues since now do not have any
leftover access to info->control.flags after running mt76_tx_status_skb_add=
()
in the mt7996 tx path and it is not required (according to the current mt79=
96
codebase) to pass the flags cached value to mt7996_mac_write_txwi(). Howeve=
r,
if in the future this will be necessary, I am completely fine with that.

Regards,
Lorenzo

>=20
> The issue that Ryder tries to address in
> https://lore.kernel.org/all/5ecac6a9b7d29526e8438dea105b58f5487c93aa.1778=
521232.git.ryder.lee@mediatek.com/
> concerns the overlapping use of info->control and info->status in tx path,
> and it remains valid even with this link id fix applied. We have to be
> cautious when dealing with info->control in mt7996 tx path until the issue
> is fully resolved.
>=20
> Regards,
> Roy

--vyatZ5JMfhikfHCS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCah57jAAKCRA6cBh0uS2t
rAmFAQDk/bGX6PjAX+FifRA1xIjx6t2hREKHPBDgAfNVJn2rXAEA+RKD4cI97xcJ
rWdhiY7wIkB+7003MrfHC78YlcbvXgM=
=CO5r
-----END PGP SIGNATURE-----

--vyatZ5JMfhikfHCS--

