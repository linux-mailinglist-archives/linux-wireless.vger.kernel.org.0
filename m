Return-Path: <linux-wireless+bounces-39133-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WxNGINA6V2oJHwEAu9opvQ
	(envelope-from <linux-wireless+bounces-39133-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 09:46:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A475B914
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 09:46:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Y2/XD/XO";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39133-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39133-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E3CE30069B6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88B43C4169;
	Wed, 15 Jul 2026 07:46:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075C3093B2
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 07:46:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101577; cv=none; b=e4YJj3Ea+xFNOyh/erjfsLFlqLCeSYHqwBXt7ccG16Bk9d8WTfSTDUAwLPqMV890STL+y/SJle7RdfxHn2H+p3LDNDRzMENxGGShX35mglxtyRA6HH56AQg7+/TKoeQUHNrIZQVSQIqlRvTaPWO72FQGmmR+dqM8fOVR9kcLOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101577; c=relaxed/simple;
	bh=dAUBRsQ5MD7RLscPK2z9O/5sRwy48+HV+3RcdI9gSII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p69jUEcsiBk6tx+IxF9/30DVxzLdXAVePDc2LdFk/WSDZUS/aG4x01An+Jpu6hl/ZjQdXDby7iNQzQwOT64f8lcm5ygaUFB/c17mVnY9ZQ7H7ihQM8PFmw/HzdQvHAsSUqXnY1tHk9uulmGW25EKiMNAtl1QqDi63p4QqFyl3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2/XD/XO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B3F1F000E9;
	Wed, 15 Jul 2026 07:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784101576;
	bh=0LP7Al6rRiZBE1h+Cea0iWGHs8CXC0LyVHJxEu9jR3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y2/XD/XOX5eKeWY1GlQ1ajpPHkVXxIb9qN8e904DmQF333rz8PgtOHNSpJSTY1Cix
	 alrG2EVN5wCvxrBxUTo8+yl8DbExDTfuVxbKndPkyKvCCso0ogYzAeqEqI13btR+fH
	 FW1QrM0T9xUAC3ZYsNjiFuGNuJwvDrUxzmfL4Yy25t7NbbkLVx7uWlnadFDLItSEcN
	 jOLEPZc2WNULDwN3zJj5DKbhX5w3JEBs7EqktwSxcvyiJ06OpkmBip5jqi3HnlaT2Z
	 FkjGbEluVmzjm6uEiU2c2+904jgu9xiH9muhvl+Q6utmOjHsyrqtnAPmHR2DtWccVH
	 rEVmCXsu+URcQ==
Date: Wed, 15 Jul 2026 09:46:14 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Bo.Jiao@mediatek.com, angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
	matthias.bgg@gmail.com, nbd@nbd.name, rex.lu@mediatek.com,
	ryder.lee@mediatek.com, sean.wang@mediatek.com,
	shayne.chen@mediatek.com, sujuan.chen@mediatek.com
Subject: Re: [PATCH mt76 v5 16/16] wifi: mt76: mt7996: Add SW path for HW-RRO
 v3.1
Message-ID: <alc6xTe4uPIJHQy8@lore-desk>
References: <20250909-mt7996-rro-rework-v5-16-7d66f6eb7795@kernel.org>
 <20260715070001.1503928-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yv6XrpQKV6uL3VLP"
Content-Disposition: inline
In-Reply-To: <20260715070001.1503928-1-amadeus@jmu.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:amadeus@jmu.edu.cn,m:Bo.Jiao@mediatek.com,m:angelogioacchino.delregno@collabora.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:matthias.bgg@gmail.com,m:nbd@nbd.name,m:rex.lu@mediatek.com,m:ryder.lee@mediatek.com,m:sean.wang@mediatek.com,m:shayne.chen@mediatek.com,m:sujuan.chen@mediatek.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39133-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[mediatek.com,collabora.com,lists.infradead.org,vger.kernel.org,gmail.com,nbd.name];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D6A475B914

--Yv6XrpQKV6uL3VLP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,

Hi Chukun,

>=20
> > +	if (dev->mt76.hwrro_mode =3D=3D MT76_HWRRO_V3_1) {
> > +		/* rxdmad_c */
> > +		mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].flags =3D MT_WED_RRO_Q_RXDMAD_C;
>=20
> This introduces the RRO_Q_RXDMAD_C flag for the MT7992 chipset.
> However, the mt76_wed_dma_setup function lacks handling for
> MT76_WED_RRO_Q_RXDMAD_C, causing it to return -EINVAL:
>=20
> [   20.049167] mt7996e 0000:01:00.0: attaching wed device 0 version 3
> [   20.114412] platform 15010000.wed: MTK WED WO Firmware Version: ..
> [   20.123728] platform 15010000.wed: MTK WED WO Chip ID 00 Region 2
> [   20.965401] mt7996e 0000:01:00.0: probe with driver mt7996e failed wit=
h error -22
>=20
> Can you fix this?

IIRC WED is not supported for HW RRO3.1 at the moment, it is not just a mat=
ter of
fixing mt76_wed_dma_setup().

Regards,
Lorenzo

>=20
> Thanks,
> Chukun

--Yv6XrpQKV6uL3VLP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCalc6xQAKCRA6cBh0uS2t
rC90AQDqX1Zbse6nv0qogKELf1Vmvsehu3y+Et4oi05aX+ax1gEApd5Ck5/LaW1y
ger643vFlirl8/9c4Ntal6wPZEuVGAc=
=WbzV
-----END PGP SIGNATURE-----

--Yv6XrpQKV6uL3VLP--

