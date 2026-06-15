Return-Path: <linux-wireless+bounces-37801-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ryNVJW+lL2rNDwUAu9opvQ
	(envelope-from <linux-wireless+bounces-37801-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:10:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E82DF6840CE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:10:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KZZ8ooGl;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37801-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37801-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAE583007F46
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 07:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24CD1D8E01;
	Mon, 15 Jun 2026 07:10:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580C13AA2D
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 07:10:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507436; cv=none; b=Sj5ruj+hYiYy1gKTIgIbeTQVI8l2qad18DiDNL0SZmJHiKSVxtldCcBf/wU6btBlGwaYfLX2xY41O72b1yPmbHA6sNkutH1p8GQjQ772fbQeMmRu+PdmKBf2au7ga9uk8oJ64NBXTmhbcDDHRjATGFj4H2NayGuhk8NlldlHZVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507436; c=relaxed/simple;
	bh=zCiTkOVkPg/f8B2oTzcxg1tWzfYAXH3KXlOTbk5quOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf+0duJ7vJAJzh9Ra78ti8YhTwmaKkUUrqdyMK87fd1EizTQpxDXJ+ODzC2eEjZ3Bs8uwFx4H0V9MXNEtv12T8EPJrH2A9h2yUI68OHeOYXsaKlSiM6VyBhSjWxUlL9yhv9V/vyll06WNlxibqN5uX9MhByWiQ6tiGrl9/S6oC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZZ8ooGl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360CC1F000E9;
	Mon, 15 Jun 2026 07:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781507435;
	bh=B63Rr7BRtf10FMXqKBI22vFs9Wx6/aB3dAFnmxB7moU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KZZ8ooGlkJbDgwEsr1XL6BNAQCABBxMW84Yzff07H25+wSgrg5qu3lAlbQNbNxdKi
	 Rbvfst8tGzfV5LigDKVSaiGRcT3n+KsDBg8iDn3Nb+8oaUGQBs2gueqP+v4Rq6xdFM
	 iin3kls1iw04SvbMxYKwLZ89b1+97EjF5wA9YPP0g1ADeRkWRnFy8bnKeYRFWCzrry
	 4wQmGDy68l4X3xhRM7euLtbwsiVX19Wohmtaqx1qw6K/YPHM+656D0s+8aHWtEnbL0
	 D4Qiw3Ww7l4t49fLNgQq0iegILvE1mD7vK9qTXVzSE6NUR+Yd5P24YDYhm7PhTyVJQ
	 aANreiFZ2Xv0A==
Date: Mon, 15 Jun 2026 09:10:31 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 5/5] wifi: mt76: mt7927u: enable USB RX aggregation
Message-ID: <ai-lZ-IOh3opn8lP@lore-rh-laptop>
References: <20260613224655.2405686-1-sean.wang@kernel.org>
 <20260613224655.2405686-6-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G88a4jpSspo+4gZ9"
Content-Disposition: inline
In-Reply-To: <20260613224655.2405686-6-sean.wang@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
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
	TAGGED_FROM(0.00)[bounces-37801-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lore-rh-laptop:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E82DF6840CE


--G88a4jpSspo+4gZ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Enable USB RX aggregation on MT7927u with vendor driver parameters for
> alignment, padding and buffer size. According to the vendor driver, the
> hardware should run RX aggregation with USB SG disabled.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/usb.c |  6 +++++-
>  drivers/net/wireless/mediatek/mt76/usb.c        | 11 +++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/usb.c
> index a0bfe6f09ae4..42d13bc6ebbc 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
> @@ -5,7 +5,6 @@
>  #include <linux/module.h>
>  #include <linux/sizes.h>
>  #include <linux/usb.h>
> -
>  #include "mt7925.h"
>  #include "mcu.h"
>  #include "mac.h"
> @@ -235,6 +234,11 @@ static int mt7925u_probe(struct usb_interface *usb_i=
ntf,
>  		mdev->rev =3D (0x7927 << 16) | (mdev->rev & 0xff);
>  	}
> =20
> +	if (is_mt7927(mdev))
> +		mt76u_enable_rx_aggr(mdev, MT7927_USB_RX_AGGR_ALIGN,
> +				     MT7927_USB_RX_AGGR_PADDING,
> +				     MT7927_USB_RX_AGGR_BUF_SIZE);

This seems to me something like a NETIF_F_GRO_HW. Should the user be able to
toggle it via ethtool?

Regards,
Lorenzo

> +
>  	if (mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY)) {
>  		ret =3D mt792xu_wfsys_reset(dev);
>  		if (ret)
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wirel=
ess/mediatek/mt76/usb.c
> index 10ad2b024985..f0df510904c5 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -1300,6 +1300,17 @@ static const struct mt76_queue_ops usb_queue_ops =
=3D {
>  	.kick =3D mt76u_tx_kick,
>  };
> =20
> +void mt76u_enable_rx_aggr(struct mt76_dev *dev, int align, int padding,
> +			  int buf_size)
> +{
> +	dev->usb.sg_en =3D false;
> +	dev->usb.rx_aggr.enable =3D true;
> +	dev->usb.rx_aggr.align =3D align;
> +	dev->usb.rx_aggr.padding =3D padding;
> +	dev->usb.rx_aggr.buf_size =3D buf_size;
> +}
> +EXPORT_SYMBOL_GPL(mt76u_enable_rx_aggr);
> +
>  int __mt76u_init(struct mt76_dev *dev, struct usb_interface *intf,
>  		 struct mt76_bus_ops *ops)
>  {
> --=20
> 2.43.0
>=20

--G88a4jpSspo+4gZ9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCai+lYgAKCRA6cBh0uS2t
rGkmAQDpJFWPjvmC0UYH6mNRDhrH2NtuSnd6XC8lal6FDOuxLwD/V6Ulxi/ICKS5
tKv6G9I+PGb0M74xveAHFQu7ljHy7Q8=
=2Nz/
-----END PGP SIGNATURE-----

--G88a4jpSspo+4gZ9--

