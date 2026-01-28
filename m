Return-Path: <linux-wireless+bounces-31274-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CGcLX8HemlE1gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31274-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 13:56:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42756A1AAD
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 13:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB5A3300CFE2
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 12:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8C534FF59;
	Wed, 28 Jan 2026 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szJg0Tu7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D2350A37
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604985; cv=none; b=m8czA7v/gUh2hioNyMo0p14zaIrmFB2JRsIux6p8104Ko7HRPn7YSMQpjnVK1ib9EazBbJrgFXUGclXbIDoCoDfU3MmnbJSxvljR8wrbCVL/+zNSh0YEj3mlVQhvZNgSxj75OMjX274gpbSlVsgxf/qcTwmHRBP7FvIQmo3xt/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604985; c=relaxed/simple;
	bh=H4wMz2eOAnUA22tTDE7YiBFrw9e46OADbwnLFMXxEO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnmR+mjfKVe8zd48JCfCQ+qFu4E6kvWyF3X71OfmEBAw1s7Awa1EcCBE4fPtzPBbfbKxdShSLn1c++Tas80/xNtGHhyjLa7anBuNPWYSIO77P3oufZm+S/7sY2w6ai3Rjv1VQ/CE2jCs21KCc9UE6XOnqAEOITTPVxTWNSKaH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szJg0Tu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052DAC4CEF1;
	Wed, 28 Jan 2026 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769604985;
	bh=H4wMz2eOAnUA22tTDE7YiBFrw9e46OADbwnLFMXxEO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szJg0Tu7aEAsIXuqZmjwT9iKyObWKOLeGtNRMZwoMxX0ZMLKle53P58TIhFIIKyRA
	 GhB3MV/D77gqyJDuPA0ls0gquLgQQbUFydd8gmEz6Q6wFR1GoFBl6yLeAkC0heiOII
	 yDms8tBugAcp/68u/zb6emvWYZfcCc0jHOlGd7fWe49PTAvbMDOBa2w0CXFJA+YXaN
	 960sh9sOPxpOxgfkvcIa032R7+iParcfgq2hnME75CBOJSY1TuN6A8jLZY55OL8BDz
	 YORkI6YiCSaDHooIsX23qX8IAAOgMxdPj52MYKAsyzJkB2a/Ye9iAJjTRZJCeBVT2n
	 KCKhtMQ+MyqcA==
Date: Wed, 28 Jan 2026 13:56:22 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH wireless-next v3] wifi: mac80211: Add eMLSR/eMLMR action
 frame parsing support
Message-ID: <aXoHdmjLKB-g54ie@lore-desk>
References: <20260128-mac80211-emlsr-v3-1-473b0c1d9cc4@kernel.org>
 <69d939aae0abecfdd011219e00076542c6e1abb1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Zs3XZ6GtgRi+Qdz"
Content-Disposition: inline
In-Reply-To: <69d939aae0abecfdd011219e00076542c6e1abb1.camel@sipsolutions.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-31274-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,collabora.com,vger.kernel.org,nbd.name,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42756A1AAD
X-Rspamd-Action: no action


--1Zs3XZ6GtgRi+Qdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I probably missed this the last time already:
>=20
> > +	if ((control & IEEE80211_EML_CTRL_EMLSR_MODE) ||
> > +	    (control & IEEE80211_EML_CTRL_EMLMR_MODE)) {
> > +		eml_params.link_bitmap =3D get_unaligned_le16(ptr);
> > +		if (eml_params.link_bitmap &&
>=20
> Surely 0 is an invalid bitmap? To disable it, you send a frame without
> IEEE80211_EML_CTRL_EMLSR_MODE or IEEE80211_EML_CTRL_EMLMR_MODE set, so I
> don't see how an empty bitmap would be valid?

ack, right. When we disable EMLSR IEEE80211_EML_CTRL_EMLSR_MODE so link_bit=
map
is not present. I will fix it in v4.

>=20
> > +		    !(eml_params.link_bitmap & sdata->vif.active_links))
>=20
> That's the wrong check, I think? It only checks that you have any
> overlap, but we need all bits to be valid, i.e. only
>=20
> 		(link_bitmap & active_links) =3D=3D link_bitmap
>=20
> is valid, no?

ack, I will fix it in v4.

>=20
> > +			return;
> > +	}
> > +
> > +	if (drv_set_eml_op_mode(sdata, &sta->sta, &eml_params))
> > +		return;
> > +
> > +	ieee80211_send_eml_op_mode_notif(sdata, mgmt, opt_len);
>=20
> IMHO it would make more sense to pass "ptr, opt_len" rather than "mgmt,
> opt_len", since that's just what gets copied and then the callee doesn't
> need to dig it out.

But I guess we need mgmt pointer to set even other fields (e.g. dst-addr,
dialog_token, ecc.).

Regards,
Lorenzo

>=20
> johannes

--1Zs3XZ6GtgRi+Qdz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaXoHdgAKCRA6cBh0uS2t
rIx9AQDvMwmRdK2HHZaNcr3E02VyLsA7SNysCnhg80MPCO/FTAD7BFs1g3oXdEyR
83lkQ9fbka8Lcr0RoF34SyfP3qzyoQk=
=gLbO
-----END PGP SIGNATURE-----

--1Zs3XZ6GtgRi+Qdz--

