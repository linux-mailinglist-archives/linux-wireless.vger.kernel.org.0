Return-Path: <linux-wireless+bounces-36118-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGtyGZ/9/Wl2lgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36118-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 17:13:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7FE4F86F0
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 17:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 650083098A45
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5630E3FCB0F;
	Fri,  8 May 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqgdNCrL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E373FCB07;
	Fri,  8 May 2026 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252737; cv=none; b=bv8HJcTybJo2vJ5ncoR5UHn3mAMosFcMZ7pJugdpA+xGjdvsEE2ItyGvaf6+3DpgZSkrnmi2dAYuS7dAEsawpvthZ4dJkzdGURRKDlJL5Q5UsmFNjOuN6D++QZqRYhSQaRXz8YsRzCyRHZp3ZbCwILw9kUHOZYdH0EK5bU/IcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252737; c=relaxed/simple;
	bh=OOQd0UMMFkRrNcFfS9FsyDJqwFkrX5CUEdPtG78I3bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9mom331FUfUVinr1JJyx+9uASk/RvqS2KOdrOEu1RSubpoK2PmpI7DLIgBGHt+p5L+ECgTJjQH3PaHdTkzMSVGliUgHdYNCBLSPgNVDWnaf38rHhcZQNgKs+Qm9AyyhiHifxPwROLBWNcitHY09LQC8/fJZsnj/2kFZSzR1900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqgdNCrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F930C2BCB0;
	Fri,  8 May 2026 15:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778252736;
	bh=OOQd0UMMFkRrNcFfS9FsyDJqwFkrX5CUEdPtG78I3bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqgdNCrLdSouZfJ+cBochVg4l+EW0ZgYzTKTnY+8lfJwURJnvrQoDR8dHkAg1w6KY
	 AyN3Hf65eqfBRv8gYPmM+gf4ozqEjaUYro9FAepWWvAz64TouBzwx9KhCg4RFdGeRN
	 hYOLow1zMj2TpvMiIdWvfbxw0bRFvg9o5yu4of1acn9hFZJ/TlFM9i2KoLVdNmMrGZ
	 usVMoCcXMdt4NxHl//jzljbEF/G9cgYk+r4st0G8HfgLwv1UBW2EHS2yNu8bcvvook
	 rOhy9fKW2BU7RfhhfyVTJ2xmF7+s81zo0NSKJVwOgUO3TZpnXQMjp9bgD5LcReWfXf
	 +dJ2T/gaMu8jA==
Date: Fri, 8 May 2026 16:05:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Bartosz Golaszewski <brgl@kernel.org>,
	=?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Felipe Balbi <balbi@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>, linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Christian Lamparter <chunkeey@gmail.com>
Subject: Re: [PATCH 1/3] [v5 net-next] dt-bindings: net: add
 st,stlc4560/p54spi binding
Message-ID: <20260508-matchless-easily-80421ce426fe@spud>
References: <20260507212451.3333185-1-arnd@kernel.org>
 <20260507212451.3333185-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="726aSvgIIJD5Swc6"
Content-Disposition: inline
In-Reply-To: <20260507212451.3333185-2-arnd@kernel.org>
X-Rspamd-Queue-Id: 0C7FE4F86F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36118-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,iki.fi,kemnade.info,kernel.org,baylibre.com,davemloft.net,gmail.com,google.com,sipsolutions.net,redhat.com,atomide.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,arndb.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--726aSvgIIJD5Swc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 11:24:49PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The SPI version of Prism54 was sold under a couple of different
> names and supported by the Linux p54spi driver, but there was
> never a DT binding for it.
>=20
> Document the four known names of this device and the properties
> that are sufficient for its use on the Nokia N8x0 tablet.
>=20
> As I don't have this hardware or documentation for it, this is
> purely based on existing usage in the driver.
>=20
> Link: https://lore.kernel.org/all/e8dc9acb-6f85-e0a9-a145-d101ca6da201@gm=
ail.com/
> Acked-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--726aSvgIIJD5Swc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaf37uQAKCRB4tDGHoIJi
0oiDAP9VBMZj2YyfB3P9bwsTD4wv5yB5Cq6x3NFuws40Zkv4XgD/WBo5/f2CnmON
jgQaqwIoJVKNq6INibHJqFWUwarKLQ4=
=ikRz
-----END PGP SIGNATURE-----

--726aSvgIIJD5Swc6--

