Return-Path: <linux-wireless+bounces-31213-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMN9F1qHeGk/qwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31213-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 10:37:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65691D35
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 10:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D15B3020EAF
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A11B2E1F02;
	Tue, 27 Jan 2026 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBesd8su"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E32E1EE0
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506646; cv=none; b=Agi/mvOPvyZF/155sVpRxEs2PQFEX0sz9TcmlJYeSC48MQvOp94q7QdtKdD32pON5dnCny4snw1lZ1oXKfSupvV6UMDxbAUd4WAP8mJuwprJBa2cm9DKqjGJ8E6eZzz1hIw3y1S3L8ttb4V86lTihcnrrWClTluXmgPNxmnnvII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506646; c=relaxed/simple;
	bh=kW6QRj1KHFAisJA+DUtpLIHXA+CHWOk19fvX1z86acc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bis2+EelWbtln5KWc2nTTxpT5m2USMWE9St0xHR/ttl2HuQKNYJr5AGvWjMkRK9hbb4PQzHm7kBCVtdQRv4hMYc5hlKL7aTOkF5t2Ut8mSt0PSwLdPTPmw1HUSxMrq+6lQfgyZGYmlp2qErTEfjAwliJGV1rrhrIV6Vafof9yU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBesd8su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23707C16AAE;
	Tue, 27 Jan 2026 09:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769506645;
	bh=kW6QRj1KHFAisJA+DUtpLIHXA+CHWOk19fvX1z86acc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBesd8suneqE+ep6Zoo3I2+szbwRdxAk4WqwcxQkPkgMbp5jjSbSk2ViOlcOKpBf6
	 YJbJTsRlq2tFyCFaZNpNwj4AZwaYFShutMjSLNGy/5cubxB/hDF2XDKHA/VbbcAYlM
	 EyF8uQSegvrjHjqZbosTR3TNc5ozp02n2KkYKCAPkUvdThL5ljW2xSBF/T+tEnAVod
	 S9AT8dTaT7I/u1NtNYxO3nO9WKSHanC+2ckfWNS/oNZQ6Za7dvs+Ayz55Z+uNJbh6y
	 VgELspYxfOhH35nDjZr/y9+Gm0jJbm4lwxfaCyPApA+aR8w2xKTI+V0jk+s0VLxhWb
	 XdWApszp5PH3w==
Date: Tue, 27 Jan 2026 10:37:22 +0100
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
Subject: Re: [PATCH wireless-next v2 1/2] wifi: mac80211: Add eMLSR/eMLMR
 action frame parsing support
Message-ID: <aXiHUlHmrKz8JgXS@lore-desk>
References: <20260125-mac80211-emlsr-v2-0-466329d61c88@kernel.org>
 <20260125-mac80211-emlsr-v2-1-466329d61c88@kernel.org>
 <01e62344994a34daae0666b3873aa98e72fb5850.camel@sipsolutions.net>
 <aXftjdCtqnQk69ys@lore-desk>
 <b592a6c9a8f59f112b2221b9a46568769b1e9dcd.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tGRs4KgtXgG4/Ty3"
Content-Disposition: inline
In-Reply-To: <b592a6c9a8f59f112b2221b9a46568769b1e9dcd.camel@sipsolutions.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-31213-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC65691D35
X-Rspamd-Action: no action


--tGRs4KgtXgG4/Ty3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 2026-01-26 at 23:41 +0100, Lorenzo Bianconi wrote:
> >=20
> > > Per spec I'm also not sure what the MCS map should be when it's not
> > > included in the frame?
> >=20
> > IIUC the mcs map value are supposed to be in Operation mode notificatio=
n frame
> > just for eMLMR. I think the driver should check if the bit is set in
> > ieee80211_eml_params control field to verify if mcs_map_bw values are v=
alid.
>=20
> Yeah you're right, the MCS Map is always present if EMLMR Mode is set to
> 1. I thought it was also optional and then what values should you use?
>=20
> Can't mac80211 validate the values?

I guess we can validate eMLMR Supported MCS and NSS Set subfiled according =
to
the table 9-417t available in P802.11be standard.

>=20
> > Reading the standard, it is not clear to me if mcs map values are suppo=
sed to be
> > added in the Notification frame sent by the AP. What do you think?
>=20
> Hmm. I thought no, but then the language says it's present when the
> EMLMR Mode is set to 1, so ... it would have to be? Strange, because
> it's not really defined (well) in this direction.
>=20
> OK, I guess the memcpy was right after all:
>=20
>    An AP affiliated with the AP MLD that receives an EML Operating Mode
>    Notification frame from a non-AP STA affiliated with the non-AP MLD
>    should send an EML Operating Mode Notification frame to confirm the
>    mode switch at the AP MLD to the non-AP STA with EML Control field
>    set to the same value as EML Control field in the received EML
>    Operating Mode Notification frame from the non-AP STA before the
>    transition timeout expires.
>=20
> But I think better restrict memcpy() then to just the EML Control field
> and build the action header etc. directly.

I guess we can just memcpy() control field + link_bitmap (if present) +
eMLMR Supported MCS and NSS Set subfiled (if present). Agree?

Regards,
Lorenzo

>=20
> johannes

--tGRs4KgtXgG4/Ty3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaXiHUgAKCRA6cBh0uS2t
rPFrAP9U5RInNCg8lzoLRgQI/9uuSh9XghVNRgnh/e9FWA2hgQEAxUM+Se7rKHSk
yA0+GV3G+INjnnXvmkBzfwRINc9uJAE=
=iYd0
-----END PGP SIGNATURE-----

--tGRs4KgtXgG4/Ty3--

