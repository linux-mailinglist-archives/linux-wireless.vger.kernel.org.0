Return-Path: <linux-wireless+bounces-35176-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EWmIWeL52lY9wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35176-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:36:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C805243C208
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9903031AF1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 14:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FF33D88ED;
	Tue, 21 Apr 2026 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="oBVIiZfB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51693D8116
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781708; cv=none; b=f6vFws7OdwLipphxXoUhuRAmrOZwdxeV3qJQOPzDK74q915XoQOsZBjSO7L45EoFBOXbMLgSB09nmDwHKMX8XjCz/rESffI4aU+kZ8glNz7BLpVxvbUi89tk2bocBxyGXOhBnKHZSgdyR2zUyPvc5EVduK1rS4cYJjDMNzEUzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781708; c=relaxed/simple;
	bh=8Al3yrm/3hSvEPA958SWnVaUgmCGPZw8rcFuTzB+JYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISLuH0OjxPQMeBGjIgQuK6plrGlo4CGQKuziEjL2svPUJezArUy4DIEnknYt33s4/8ZFZghYGMPtncH1S4cfDVFU+gcFdZgGsAtuxyJZY76rq5vmytKewi1jyz3t5sdoVhNwy2Cg0L7ceZoPJdI/vdKHvAZkCvIQc062m7maFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=oBVIiZfB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d64313c39so3403749f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776781705; x=1777386505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Al3yrm/3hSvEPA958SWnVaUgmCGPZw8rcFuTzB+JYE=;
        b=oBVIiZfBEcXZc5iULO3eapa8JPyWTctIIEypve1SXZdvi3j3pV7EpNbYAZg/H2dmW2
         sYFC4FfjX3WXGmbiyTRvSnLjwPGNV7O9irYpHsWeWY6cOAurQ59fhNWOjz05zKMCmmj4
         r8FBkOTWsxSajQTpa4COqK9VnAFdzWmGelwlXm5mBWC38gwAeqV6BHVUp1rcniR5Gcub
         ArEhKTZFywzIU30Kto5c4IZOKNVkt6TS9kFKjBPVu7IYPwWJ4rN7kSka4ioiMcL58Bdm
         tR/GOu30faYoHkD0U8vsjiLu6Tm1jQ1t1YOCIjXs8we09C/QUM571zEFe+J6s4WpWkKh
         QSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781705; x=1777386505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Al3yrm/3hSvEPA958SWnVaUgmCGPZw8rcFuTzB+JYE=;
        b=SRoyR8RVsx2quT6+MR5l8+os5cS+MaVXIUqWO5QkgI5AHfLMxmT6PrBTzr4U02CqQ7
         pXdnG2FpkJu4uWTsUSQ90ClaAeU3UArbT3AwmCf5Ov2nZ5stzrlsJ+CO8tTNiSgU40pi
         Mlc/Fn7FQYSJSBUD/d7lsSS2j4PsxMi0PllUIXh8yTOk8jvLtbhj/LPXANobHtbCf5Hy
         LVd198/kSEG1gMa8m6DxP9qN/lcgjDWgvjLye7yos8oLIavnuhCrCNNdLaoReQyNk+Lj
         1cxnId8VimisamTfej6tVNLUIH5YHBqYas2/ZmfunChJ41oAZ1yLNIINi33Z/YBqvXMO
         FBKw==
X-Forwarded-Encrypted: i=1; AFNElJ/Z5HQflbWdvk7xn4f5x0KfVDG2AJZ+1vk6H2YDU0BqhqWOcn48oKW8Hv/It2zc0UEvCC/VaURVsptMRKxk2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhacDdKTsAFaQ2HF1RxkXtI7IdjDpz7lPwRPt6TntY7JlWemSC
	MsPxGY8Rfrm1Khz+Oy4wK8rFTMqt/dswAj7Yg/+/NxT9RJQEZqUe2ZuJaiLEojez6Mc=
X-Gm-Gg: AeBDiesISMblOJ5ylG6wETgjgSxx3mwDpfmjbz22nfxsDIG1MDFyEmy0SMQtCfNHO9S
	AWw1Z8aPyy/S1OvyDRnaxIS0aKggpo2N53oyEnm/PMBUyPyaLqgIrD5b1rVC+JY6eEu2h6J3ZWz
	MFuuiykoB7bcqJfSCTu60H9EaPovxeR3b26k7YKZtKPjg3Ww2nU4gFLZn6fq/2w5f/CsvInfLte
	gehW2chPdTiuBofo2alBJ6zY7Kncsq9MOVL41KtOsE/27KM9jQSLxCtAbQOLeKD8I7+0E3RvoCv
	oSOGCiTCKvddk7fwcUNCafajPrGk/ijHQ0wtwFULZAFPl4awRF9RG0aR9V9cb8xlis2jvyAH6GI
	g3lVlBjrJ9cVeNkF6q+Z6+CGc3nvdR6CtlZTFgsCLIneE0cppXxLQN6OskFIHCk4hIhbCZMxxXj
	+rAWGOTaK35rzeL/gp/1QhN2CqQBwglnSTFTIDI2+iUqk3XnEj5uDKWzpDMN3Hkz4RBOBwy7Nuu
	z1ezfwYKHK+mxs24kermeBhSQ==
X-Received: by 2002:a05:6000:25c6:b0:43d:7a08:a5f8 with SMTP id ffacd0b85a97d-43fe3e0ae91mr28509500f8f.35.1776781704476;
        Tue, 21 Apr 2026 07:28:24 -0700 (PDT)
Received: from localhost (p200300f65f114e0838b25d7f2f2f49cd.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:38b2:5d7f:2f2f:49cd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e3a18csm42923276f8f.20.2026.04.21.07.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:28:23 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:28:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Johannes Berg <johannes@sipsolutions.net>, 
	Ulf Hansson <ulfh@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, linux-mmc@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, 
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
Message-ID: <aeeFun4zdz360GCb@monoceros>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
 <aeaMkfk_1t98e7SU@monoceros>
 <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
 <aecu1ixyHP2hQvgE@monoceros>
 <2d6e902083d693cdbb15fc62c6bf92db34fc734a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wkasyawrdb76jdw2"
Content-Disposition: inline
In-Reply-To: <2d6e902083d693cdbb15fc62c6bf92db34fc734a.camel@sipsolutions.net>
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35176-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,codasip.com,vger.kernel.org,linuxfoundation.org,sang-engineering.com,holtmann.org,collabora.com,lists.infradead.org,realtek.com,nbd.name,kernel.org,mediatek.com,chromium.org,dolcini.it,linux.intel.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,renesas];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C805243C208
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--wkasyawrdb76jdw2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
MIME-Version: 1.0

Hello Johannes,

On Tue, Apr 21, 2026 at 10:59:04AM +0200, Johannes Berg wrote:
> On Tue, 2026-04-21 at 10:12 +0200, Uwe Kleine-K=F6nig (The Capable Hub)
> wrote:
> > >=20
> > > We only received 1-3 of the 6:
> > >=20
> > > https://patchwork.kernel.org/project/bluetooth/list/?series=3D1082520
> > >=20
> > > Or is this on purpose, and we should consider the set complete?
> >=20
> > The remaining patches are for wifi. My expectation was that they go in
> > via wifi+netdev once the first patch is in their base. But of course I'm
> > open for maintainer coordination to let the series go in in less steps
> > than I expected. If that helps I can also create an immutable branch,
> > but I have no urge here, so if only the first patch goes in during the
> > next merge window, I won't have problems to keep track of the remaining
> > bits.
>=20
> It's probably better for everything all around, including the various
> automations that test patch series, if you just flip a coin, send these
> to either BT or WiFi, and then resend the others later :)

The first patch of this series adapting sdio_device_id is technically
mmc material. However to demonstrate the upside of this patch you also
have to look at at least one of bluetooth and wifi. So even if I drop
one of those there are still two subsystems involved. And then in my
subjective view it doesn't matter much if I involve two or three
subsystems. Regarding test automations I would assume that if the
bluetooth bot sees patches #1-#4 of this series it can do something
already (involving either testing the series only partially or finding
all 6 patches on lore). And then this isn't worse than just sending the
first four patches of the series and delaying wifi until later.

But I agree that's a trade-off.

Having said that, I'm happy if the first patch is merged and patches #2
to #6 are discarded by the bluetooth and wifi people. I'll come back to
them once the first patch is in a release.

> All assuming we get an ACK from whoever is responsible for patch 1 to
> merge it through some other tree :)

To make this more explicit: That would be Ulf as MMC maintainer.

Best regards
Uwe

--wkasyawrdb76jdw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnniYQACgkQj4D7WH0S
/k4HiwgApSzuIJ1URhsrlSvh9N8JDusJG3q51TwVELmNJHyiGiApzvIMI2hf1LpH
E1+5egvSwoK33C+ReJRedPagWp0Ll3IFfj2s0y3HvwrI5a76Tdf4sHvj5NHPiRIH
y9KHO4wXogmzK8jd1kjTZQfVblWyXiIkrLiylpMbymhBKeStWp7DRQSV/94dIdZe
Ig/lLo4/6IjeuI3hqDpPqnRIscxMXd5YdujPggb4cJWAEy0Xeh0UelFMr/++spDD
07BXWuy0sJyPh7Q0c6YyhUYR2JQTbfRGhdia/V1lPmvtICvopICdSWsFPvGyqVwX
F0yDYOI9syIZGhmxoclUWCaZGbh0IA==
=qXiL
-----END PGP SIGNATURE-----

--wkasyawrdb76jdw2--

