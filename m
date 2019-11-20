Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4621038F7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 12:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfKTLme (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 06:42:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbfKTLme (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 06:42:34 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDF3F21906;
        Wed, 20 Nov 2019 11:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574250153;
        bh=GY0MZx2LrAzonJ3zzCRRnSJO+67emHCkJEh6MeR1ylw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7+nWj9DjNdJ1AxRV/7XGSX2vDYdSZ250UelK0KaXoo09hXs3b9BAJOwKibWin/gg
         BeQQNdCRe/NVBMDBFeenoc2Apc7nN9dRzxkZMZXuY8gGelS2FpyyDJ3dhobaySpPxu
         vwwMtUXNo7Fc/D2wa5de1LG5C6fiQry/of/VGlk0=
Date:   Wed, 20 Nov 2019 13:42:26 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: Re: [PATCH 2/3] mt76: move coverage_class and slottime in mt76_dev
Message-ID: <20191120114226.GB21993@localhost.localdomain>
References: <cover.1573828743.git.lorenzo@kernel.org>
 <b9f6f1ff8428ba9b76244ff99b22d9949b6fabf7.1573828743.git.lorenzo@kernel.org>
 <90b792b4-98d0-accc-057d-9f1bb9cfbbb5@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <90b792b4-98d0-accc-057d-9f1bb9cfbbb5@nbd.name>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2019-11-15 16:05, Lorenzo Bianconi wrote:
> > Move coverage_class and slottime fields from driver specific data
> > structure to mt76_dev since they are used by all drivers
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Please drop this patch. I've moved a few other fields back from struct
> mt76_dev to driver specific structs, because they were in the way of
> DBDC related rework, and this one would fit the category too.
>=20
> As a general policy, I think we should only move fields to struct
> mt76_dev if they are actually used by core code as well.

ack, let's drop this patch. In the future we will need to integrate the tim=
eing
code in DBDC one since mt7615 has related regs for band0 and band1. Maybe w=
e need
to move them in mt76_phy?

Regards,
Lorenzo

>=20
> - Felix

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXdUmngAKCRA6cBh0uS2t
rEZ9AP9nwPws6q/4tpFMEGH+jknnDNWXljLTlgQDPFpKL3c+ZAD+I7yail41q+vy
KxqjozWmCNWKDYs6YYzC0lnxgS+MbAI=
=HiLt
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
