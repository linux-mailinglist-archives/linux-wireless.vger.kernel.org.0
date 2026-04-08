Return-Path: <linux-wireless+bounces-34522-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAgpEjkh1mklBQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34522-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 11:34:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B421D3B9EC5
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 11:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75B1C3012CD7
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 09:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEEA35F607;
	Wed,  8 Apr 2026 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCfmrL2j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0E7224B04;
	Wed,  8 Apr 2026 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640885; cv=none; b=IO7OVEhzgn70//73/EpERJz+S+QslJcC236ZCCL17XJDNVKa9RRS/tKcCS1usjbNOv2AUNCxGzan/HpdlTn2e2mEb2iYPN5dx99pjs3ROuiWsrv2T4dPUO1d/f8UpOoR2Ad8w2zaQH6pVV6tBfvYVmzot3QGsDIMtm8wp7k6jFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640885; c=relaxed/simple;
	bh=xB2G7g50HPojzs91gVhYtm9ibj6OxWB3a3yj4DtnA9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2IBMspRnHCmD/6eu7EYk9nA7A93PqWCloPIvE2/Z08YkSKeJqiZqxB52s73Gc+ijPK5N+TNEiamLJGJjb2FvLK2EYT+l4XHT7wqrc/K8oSc6cUM8Vt1lzpXLbyTVZldS6CscRADY/OWzf8d4bkfYAsTVBPV6NYs9AEKuBCvLg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCfmrL2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99ADC19421;
	Wed,  8 Apr 2026 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775640885;
	bh=xB2G7g50HPojzs91gVhYtm9ibj6OxWB3a3yj4DtnA9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCfmrL2jaBS2Zir8M+930wpHrwSiWb69VCPUF2OaZOMPzdm7HQyBDiWU3WZrLKPEJ
	 8K1yB42YQjodE3UsdJeA+PvQI5EuaQcKHp8n9ptkJlp0KAYEqTP0meK39CFNWnZnR5
	 QhepcmDlPZxOmYgPD24obbjbip6ihfpIe+HAhYP4SCm0FAX3ppt0y1Mg6KCePy4SWI
	 25VtanpprO9taPO1sVdnhpRQiE3QdeHgkoNT9OoX8D/sg19ksbA15A7vp9RjeRxIgM
	 +DW9hRZZbhVPRAbQQWhcuuy+mBCQ/CP4wdY370sxnrdlQuSyGfSLczZXA5u5HXn8C/
	 jtzWF4gtNoyAg==
Date: Wed, 8 Apr 2026 11:34:42 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Zenm Chen <zenmchen@gmail.com>
Cc: nbd@nbd.name, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
	sean.wang@mediatek.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH mt76] wifi: mt76: mt76x2u: Add support for ELECOM
 WDC-867SU3S
Message-ID: <adYhMgllS55Chvpb@lore-desk>
References: <20260407154430.9184-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ECjadagwUqD3QKe7"
Content-Disposition: inline
In-Reply-To: <20260407154430.9184-1-zenmchen@gmail.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34522-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-hardware.org:url]
X-Rspamd-Queue-Id: B421D3B9EC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ECjadagwUqD3QKe7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 07, Zenm Chen wrote:
> Add the ID 056e:400a to the table to support an additional MT7612U
> adapter: ELECOM WDC-867SU3S.
>=20
> Compile tested only.
>=20
> Cc: stable@vger.kernel.org # 5.10.x

I do not think this material for stable. Anyway:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> ---
> This ID was found from [1] and adding it to the device table should be=20
> enough to make it work. Hardware probes at [2] can prove its existence.
>=20
> [1] https://bushowhige.blogspot.com/2019/08/ubuntu-1804-mediatek-usb-wi-f=
i.html
> [2] https://linux-hardware.org/?id=3Dusb:056e-400a
> ---
>  drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt76x2/usb.c
> index 01cb3b283..459c4044f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
> @@ -16,6 +16,7 @@ static const struct usb_device_id mt76x2u_device_table[=
] =3D {
>  	{ USB_DEVICE(0x0e8d, 0x7612) },	/* Aukey USBAC1200 - Alfa AWUS036ACM */
>  	{ USB_DEVICE(0x057c, 0x8503) },	/* Avm FRITZ!WLAN AC860 */
>  	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
> +	{ USB_DEVICE(0x056e, 0x400a) },	/* ELECOM WDC-867SU3S */
>  	{ USB_DEVICE(0x0e8d, 0x7632) },	/* HC-M7662BU1 */
>  	{ USB_DEVICE(0x0471, 0x2126) }, /* LiteOn WN4516R module, nonstandard U=
SB connector */
>  	{ USB_DEVICE(0x0471, 0x7600) }, /* LiteOn WN4519R module, nonstandard U=
SB connector */
> --=20
> 2.53.0
>=20

--ECjadagwUqD3QKe7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCadYhMgAKCRA6cBh0uS2t
rH4BAQDadaOqA+izjfKsqTGZE4t7netvYf9LX/dwKhfjXP+BpwEAmT0UWS1fM3wY
y/Xgc7k8ncdplQixrzhIVJD56iveDAM=
=Vfip
-----END PGP SIGNATURE-----

--ECjadagwUqD3QKe7--

