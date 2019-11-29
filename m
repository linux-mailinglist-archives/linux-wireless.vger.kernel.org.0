Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B910D600
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 14:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfK2NLf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 08:11:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfK2NLf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 08:11:35 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E40E216F4;
        Fri, 29 Nov 2019 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575033094;
        bh=jrCIprHUTTV/YQQ0X2znnwgtr+4EleukDculIVQIpY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mS2M1BkHw9O6qEJm2bOoU2xPY29iD24meoOuPEhhWlO4Ha5BibzRNtrXY0PzsDSpR
         PnjyCOyU1TS6faBGiWiklrwuUxLkx9ExVNVKSVJ75HlpX/xXTtd27QlT+WLWR2kT5u
         4OJJ1QS2Y+nWd+gyyBgLFIhbRTCCQvKpBI0cgS4Y=
Date:   Fri, 29 Nov 2019 15:11:25 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: Re: [PATCH 1/3] mt76: usb: use max packet length for m76u_copy
Message-ID: <20191129131125.GF32696@localhost.localdomain>
References: <1575030748-2218-1-git-send-email-sgruszka@redhat.com>
 <1575030748-2218-2-git-send-email-sgruszka@redhat.com>
 <20191129124744.GE32696@localhost.localdomain>
 <20191129130630.GA2497@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Content-Disposition: inline
In-Reply-To: <20191129130630.GA2497@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Nov 29, 2019 at 02:47:44PM +0200, Lorenzo Bianconi wrote:
> > > +	usb->data_len =3D usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1);
> > > +	if (usb->data_len < 32)
> > > +		usb->data_len =3D 32;
> >=20
> > Hi Stanislaw,
> >=20
> > 	usb->data_len =3D max_t(u16, 32,
> > 			      usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1));
> >=20
>=20
> Why this is better ?

More readable for my point of view

>=20
> > Moreover are you sure using ctrl endpoint 0 is fine for all devices?
>=20
> usb_sndctrlpipe(udev, 0) is used in __mt76u_vendor_request() for all=20
> out requests i.e. on all cases were usb->data is used.

ops, right :) Thx for for pointing this out.

Regards,
Lorenzo

>=20
> Stanislaw=20
>=20

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXeEY+gAKCRA6cBh0uS2t
rBgsAP9r/zVUzE7kuaXvSCHfrbrkKRRz0waUGAz4w6RnyNv83gD9FIwG4H+t0ycI
Euef/np4w/ZzEOtkDHxG2uSOlrlg6wc=
=8Dkr
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--
