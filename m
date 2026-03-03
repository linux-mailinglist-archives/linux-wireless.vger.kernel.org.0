Return-Path: <linux-wireless+bounces-32383-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F9KJCSQpmnxRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32383-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 08:39:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1171EA401
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 08:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 019DF30459D6
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 07:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A55352FBA;
	Tue,  3 Mar 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDUEzGlH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D729309EFC
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523420; cv=none; b=OupHxK54WvlG9Ow8UgRssoprt2buaeidbhyrwsCyGadPAZPzHLC8JubgcvAdKngJHDggzoxgVz7Avfodx7xrj2Xc/yCEs8+mAtycmm0iZlP5YXgUMSsQZObuLPHBdKrsSWxsEfPQHCXK8OH0Mt8Cqb0LKbR9iVHSqwFTItB4laE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523420; c=relaxed/simple;
	bh=op77g5UoTjhxqzll2mmBdL5X9byfPcnF1cIIGUcim0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp9mFuukAWzt9xNAt+H6fsyXgnorDaOUQBeyv3STn8D/IRxLiB1weP3FTtNLW0gow211f19VBzdalu+YsZjTxi6Lmg9p8fSyMbrhXdrpUWrMkBeh2UlNqmH52hiZIHTPu3QuccWzbEiXvUB3frcCDpTcC3vCy2YkSIgZtx1oZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDUEzGlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92F4C116C6;
	Tue,  3 Mar 2026 07:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772523420;
	bh=op77g5UoTjhxqzll2mmBdL5X9byfPcnF1cIIGUcim0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDUEzGlHZ5t0GLu7tcbj4M/1q+uFQhoRNX5zFqfDC0Fs9FWCLq09dJyK0YXULz1fk
	 HBO957xKeXu62F+tFXRnY/XdoyZpQn/4TR9rUyZXVCuWKFxVmHqVr97GsptjigGvDg
	 UjMOOLL81ksYSXdFT7MpTQgLhOvkhWXKq4j6f4IU6xy4rdqMFvYXuxjakS7X7LS7xM
	 o2t1KeYT0aGMxE016lVVshPasyOvxPP2bbgsR+GbBk5dIZB4tVGCCEvRAIzHhSyyq+
	 2rmFts+i3htUV2PqQXzdD6h0RPCpW9rAXAaaKdcxS509UjSDDKlaKgXhvILCp0KUar
	 /UTAaMS0cAlaA==
Date: Tue, 3 Mar 2026 08:36:57 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	Money Wang <Money.Wang@mediatek.com>,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mac80211: fix missing ieee80211_eml_params member
 initialization
Message-ID: <aaaPmbR0pVZLMX0t@lore-desk>
References: <20260303054725.471548-1-MeiChia.Chiu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VWJ8q/hmLoxOX88V"
Content-Disposition: inline
In-Reply-To: <20260303054725.471548-1-MeiChia.Chiu@mediatek.com>
X-Rspamd-Queue-Id: 0C1171EA401
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-32383-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--VWJ8q/hmLoxOX88V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The missing initialization causes driver to misinterpret the EML control =
bitmap,
> resulting in incorrect link bitmap handling.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: 0d95280a2d54e ("wifi: mac80211: Add eMLSR/eMLMR action frame parsi=
ng support")
> Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
> ---
>  net/mac80211/eht.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
> index 75096b2195d2..078e1e23d8d1 100644
> --- a/net/mac80211/eht.c
> +++ b/net/mac80211/eht.c
> @@ -154,6 +154,7 @@ void ieee80211_rx_eml_op_mode_notif(struct ieee80211_=
sub_if_data *sdata,
>  	u8 *ptr =3D mgmt->u.action.u.eml_omn.variable;
>  	struct ieee80211_eml_params eml_params =3D {
>  		.link_id =3D status->link_id,
> +		.control =3D control,
>  	};
>  	struct sta_info *sta;
>  	int opt_len =3D 0;
> --=20
> 2.45.2
>=20

--VWJ8q/hmLoxOX88V
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaaaPmQAKCRA6cBh0uS2t
rCTPAP0d8cwb5AdhkgMXSv9FAHdkExv2kH1NdvMDGeDFtMqpWQEA+DrDwiA4PpUl
CibOoC5VLbMzSPQ+HBVF2/qeQPM9bg8=
=c9Ib
-----END PGP SIGNATURE-----

--VWJ8q/hmLoxOX88V--

