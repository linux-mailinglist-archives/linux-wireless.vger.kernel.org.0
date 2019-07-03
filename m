Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F21A5EF0D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2019 00:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfGCWMw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 18:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfGCWMw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 18:12:52 -0400
Received: from localhost.localdomain (unknown [151.66.63.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B7421882;
        Wed,  3 Jul 2019 22:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562191971;
        bh=jOhMRqOIHYJg6DnqTL/BS8YqEtF6uN3bh6EZ/jvzN04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chFraUg0cn5ngIfqTaiMqnJB47ccyZsWP5NC5un7gUW4T8yJKtOruWCiEXCdbVnCW
         6NHD4cqpWlMfYoMjClwnWzaVwSW9BYuqbCPHEgxUzq1zmtDazwNNO5pSRhQxbpzQ3c
         hOmHctSCA/JmQVz4kk1W9/7+6Vc7G0M8XqHvyuAc=
Date:   Thu, 4 Jul 2019 00:12:45 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCH 0/3] mt76: usb: alignment and endianes improvements
Message-ID: <20190703221245.GA23584@localhost.localdomain>
References: <1562079961-15527-1-git-send-email-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <1562079961-15527-1-git-send-email-sgruszka@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fix endian bug and do some minor optimizations in mt76u_{copy,rr,wr} .
>=20
> I do not mark cc stable endian fix as noboby reported this issue,
> i.e. use the driver on big endian machine, but make it a separate patch,
> so it can be backported if needed.
>=20

Tested-by: Lorenzo Bianconi <lorenzo@kernel.org>

> This is on top of:
> [PATCH] mt76: round up length on mt76_wr_copy=20
>=20
> Stanislaw Gruszka (3):
>   mt76: usb: fix endian in mt76u_copy
>   mt76: usb: remove unneeded {put,get}_unaligned
>   mt76: usb: use full intermediate buffer in mt76u_copy
>=20
>  drivers/net/wireless/mediatek/mt76/mt76.h |  5 ++++-
>  drivers/net/wireless/mediatek/mt76/usb.c  | 27 ++++++++++++++++---------=
--
>  2 files changed, 20 insertions(+), 12 deletions(-)
>=20
> --=20
> 1.9.3
>=20

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXR0oWQAKCRA6cBh0uS2t
rKr8AP9RG/++BIUhnw0z231EsPOBjgNSVj2nL75m+I5auDtoVAD+PPYGezyiOu0h
0lBIV84V9M0o7nvzoATVYZu7rlBvoA4=
=gUcB
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
