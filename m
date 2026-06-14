Return-Path: <linux-wireless+bounces-37786-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M55/AmB0LmrUwAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37786-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 11:29:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8A5680C18
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 11:29:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mv+DF5rO;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37786-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37786-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E5EF3008D0C
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 09:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2F223DCE;
	Sun, 14 Jun 2026 09:28:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D3146588
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 09:28:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429327; cv=none; b=aOcZHISF9qLn97xCgUMdwvITrOvDneGp504q93nfRP/hkzoCm7AsYWKaF0tdk/Kjf28NBKWELtwP5bcwTTsfSfiH5Bq6BkpjTSGjevpDT6Ypv3WE9/pCyEAP3lnKCO90lZJ5Vwsg9cQnjQvbuE4XCFVd5RTcnZYjeOu3muRocpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429327; c=relaxed/simple;
	bh=aKOs6kXiI+DWulUOrgUEgTmjg2oSrrf/0LluwkPgv7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jqp0P7grKrkaetaJLz99/StHklRJ4nwZ8QjJuEgJFMhocHcaST0t89OX7C0Ezf2CCNu+uqRxEPOLmlzGwUfQItAZOGo8tHIxhFg2AxJO/kgfvzm7z6kCyY2yt6Q8bpQg67gVsUWKzWX4D9IGoKVJYh2/bz1qHNrUioQA5+Xrv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv+DF5rO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944C81F000E9;
	Sun, 14 Jun 2026 09:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781429326;
	bh=qqHEqZNJNsjZK9I6sk+rqbOvQVikyDhgsbDLwNY1Oz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mv+DF5rOTEgmQYVWkV9d43nvbJDKv1wPLcVCUhiFkcxOuZf1hTlXa+7sNy9fpB2+O
	 cpMinbgi+Pqt6mNbG7V0VD125vFvScUK0ok1Tu4RKF5UyR/cEglwbl8odJ2COaaiJR
	 onrFuuFXN4hfawkVFiyvrbXv+LdosY1MMPldpVjvWYY9wYMqoAghkMlwtHeeeQJhVh
	 zlR+W4nyBy5ZsphzvROBvoxbXpgRCqoGP1MuI7H5PXvl81KIosT4ztF2ebNZ1g4KKj
	 GOGFKTBjCjEYlL5Z4nOVuwOD7xVtWFaPgrfLc1JOufYjqGceMBCjYJicg0MZy5Ktqz
	 fMM6KURRPoW3A==
Date: Sun, 14 Jun 2026 11:28:43 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 1/5] wifi: mt76: usb: size RX page-pool pages from queue
 buffer
Message-ID: <ai50S1JgkAdVJfST@lore-desk>
References: <20260613224655.2405686-1-sean.wang@kernel.org>
 <20260613224655.2405686-2-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bg1KybBuqNpXKicp"
Content-Disposition: inline
In-Reply-To: <20260613224655.2405686-2-sean.wang@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sean.wang@kernel.org,m:nbd@nbd.name,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37786-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mediatek.com:email,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A8A5680C18


--bg1KybBuqNpXKicp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Use the RX queue buffer size to select the page-pool allocation order.
> This lets USB devices use larger RX buffers without silently allocating
> undersized order-0 pages.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mac80211.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/=
wireless/mediatek/mt76/mac80211.c
> index 13c4e8abe281..6ff1eada6d09 100644
> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> @@ -628,6 +628,9 @@ int mt76_create_page_pool(struct mt76_dev *dev, struc=
t mt76_queue *q)
>  	if (!is_qrx && !mt76_queue_is_wed_tx_free(q))
>  		return 0;
> =20
> +	if (q->buf_size > PAGE_SIZE)
> +		pp_params.order =3D get_order(q->buf_size);

I guess you are interested just in usb devices here, right? Moreover, are y=
ou
interested just in MT_RXQ_MAIN queue?

Regards,
Lorenzo

> +
>  	switch (idx) {
>  	case MT_RXQ_MAIN:
>  	case MT_RXQ_BAND1:
> --=20
> 2.43.0
>=20

--bg1KybBuqNpXKicp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCai50SwAKCRA6cBh0uS2t
rFjmAQDs02PyFHYQXUrmHijoXehLFvuHRG+XsNI5x6nK+MRBzwEAnEd1hrSzNXIx
BjhBi2O6GmTUPAOU6BfaEib1AFDnngE=
=s+16
-----END PGP SIGNATURE-----

--bg1KybBuqNpXKicp--

