Return-Path: <linux-wireless+bounces-37785-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GE1/CBp0LmqwwAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37785-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 11:27:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6DE680BFE
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 11:27:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hwkZQqtd;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37785-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37785-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DCCA3021716
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 09:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E629039BFFE;
	Sun, 14 Jun 2026 09:26:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45154399002
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 09:26:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429205; cv=none; b=qnDm973YtV54byeVlP9oNnm4v+U1V92F/omRnVKnxDUNriGY3uXETMD/DHyK4sv9TGjU5OQR8RHXbH+R9cOHikc/UyrbtPKtqqTd7qB1doQ3DBMofTpFDi9IXX0XWu51fNIx0++yInyZ/mmks0B7XF64NTuxkR1PMa33sl8rCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429205; c=relaxed/simple;
	bh=QaHNkFaO6qDI8YI9nfO1dkSr5JBEWy86S3LrGnzyUrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjazQJ16gQ9BvtV64JdgPoKN5/Jv0+7jy37A4SVL1ajPvpxsoRRzpHHta1lAEe71H2syKUyNuJ9poHvXfnCSovAAkaLyOjUEHLXM/AHLzJDkpnRaxEJ5eo2zHjsuGD3Bup+gXP2f+y1rEJnAnrZHZ5a/Lh3oxJ17aSAPU37uipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwkZQqtd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105241F000E9;
	Sun, 14 Jun 2026 09:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781429202;
	bh=QqTMTiQg1sf52LbnFTly3RfFBwAHjqFaOZSFE8C6iQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hwkZQqtd4opBAdy2o1ZHR9ZMbv03X9dvQK+31NZdxMF1MlXWQjho9sAMeAz4tW9v1
	 0xN6owDCIGOz9k3HNDB8me/Yar9ahFhQ5dgMV1trfDcwLW7fvvIyg/qIuXVj3+vMv/
	 Ax0NU0Es/6pyVCzfOGOUQA+PZ+TsNmWOlXmnBrFkxyQNVY/JY0CmbwdvUPTglR5b5s
	 +iT98q643glfs/MfDRgC4DIRUaeZwDg2L5Y2E+Z1osXhLGjhS4Q8i+W0NAN8MOIzUm
	 VuSnLLFy/AXJI/7AIBz5BRylSxtO4+j7AajcNQ1rHr+fD/ip4BAz5gZrFg5S58eobq
	 6owLNsCuHDBwQ==
Date: Sun, 14 Jun 2026 11:26:39 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/5] wifi: mt76: add USB RX aggregation support
Message-ID: <ai5zzwOcBrrtvjNk@lore-desk>
References: <20260613224655.2405686-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pyRDaUZ8du7f0YkO"
Content-Disposition: inline
In-Reply-To: <20260613224655.2405686-1-sean.wang@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37785-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:sean.wang@kernel.org,m:nbd@nbd.name,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A6DE680BFE


--pyRDaUZ8du7f0YkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This series adds optional USB RX aggregation support to mt76 and enables
> it on mt7927u.
>=20
> RX aggregation allows multiple RX frames to be received from one USB URB,
> reducing USB completion overhead and improving RX efficiency for
> high-throughput RX traffic and monitor capture.

Hi Sean,

MT76 usb already supports Scatter-Gather (SG) for RX urbs in order to recei=
ve
multiple buffers in the same urb. Since this approach has a better memory
footprint, can we reuse this approach?
Moreover, can you please provide some performance comparison? (e.g. through=
put
and memory usage).

Regards,
Lorenzo

>=20
> The common USB support remains opt-in, so existing USB drivers keep the
> current behavior unless they explicitly enable RX aggregation. The same
> settings work for both mt7927u and mt7925u, but this series enables the
> feature only on mt7927u for now.
>=20
> This series does the following:
>=20
> - size RX page-pool pages from the queue buffer size
> - support out-of-order RX URB completion
> - add optional USB RX aggregation parsing
> - add debugfs stats to verify aggregation behavior
> - enable USB RX aggregation on mt7927u
>=20
> The series is based on wireless-next commit:
>=20
> 21352612198c ("b43: add RF power offset for N-PHY r8 + radio 2057 r8")
>=20
> It also cherry-picks the following patch from patchwork as a dependency:
>=20
> wifi: mt76: mt76u: use a threaded NAPI for the RX path
> Link: https://lore.kernel.org/all/20260609105301.196302-1-phial@phiality.=
com/
>=20
> Sean Wang (5):
>   wifi: mt76: usb: size RX page-pool pages from queue buffer
>   wifi: mt76: usb: support out-of-order RX URB completion
>   wifi: mt76: usb: add optional RX aggregation support
>   wifi: mt76: usb: add debugfs aggregation stats
>   wifi: mt76: mt7927u: enable USB RX aggregation
>=20
>  drivers/net/wireless/mediatek/mt76/debugfs.c  |  35 +++
>  drivers/net/wireless/mediatek/mt76/mac80211.c |   3 +
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  38 ++-
>  .../net/wireless/mediatek/mt76/mt7925/usb.c   |  18 +-
>  .../net/wireless/mediatek/mt76/mt792x_usb.c   |  23 +-
>  drivers/net/wireless/mediatek/mt76/usb.c      | 251 ++++++++++++++++--
>  6 files changed, 335 insertions(+), 33 deletions(-)
>=20
> --=20
> 2.43.0
>=20

--pyRDaUZ8du7f0YkO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCai5zzwAKCRA6cBh0uS2t
rCL5AQD36+ZV63ZKM6pJRZP22/1sqTURbayd1hEhI0lMVKf43gD/SF0dbi/igXqj
DfJcZqHMDeVDEevEJBwuDnj4/GwA9gc=
=kFQp
-----END PGP SIGNATURE-----

--pyRDaUZ8du7f0YkO--

