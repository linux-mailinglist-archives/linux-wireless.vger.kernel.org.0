Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 629FD1EB26
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 11:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEOJoE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 05:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfEOJoD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 05:44:03 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200D520843;
        Wed, 15 May 2019 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557913442;
        bh=+Ksn74+ZCHUUgprO30dYuz2bot13x4fR+Koe4TgLFUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGbgtmc+F+rfDY5LqPWjmRT8h/eE2RKVbkL5/0WAeJPNIAxmG+ogR1VkX3Vix4co8
         wLb5DdcES+12N+vy7IZZkQ82lcIP7qFjTfzSbwPO/h5d4kCVIuiHsMBkz/mg591IRp
         VTWV510mzEQ3LUX9TtrduapcT2dCMGpRZWmZfcw8=
Date:   Wed, 15 May 2019 11:43:55 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7603: add debugfs knob to enable/disable edcca
Message-ID: <20190515094354.GA30757@localhost.localdomain>
References: <cover.1557591530.git.lorenzo@kernel.org>
 <0691acb931e963cb6028d4687cdd61032d0aaf52.1557591530.git.lorenzo@kernel.org>
 <87r293ugia.fsf@purkki.adurom.net>
 <20190513084127.GA3127@localhost.localdomain>
 <20190513094837.GB15694@redhat.com>
 <20190515093333.GA2333@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20190515093333.GA2333@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, May 13, 2019 at 11:48:37AM +0200, Stanislaw Gruszka wrote:
> > On Mon, May 13, 2019 at 10:41:28AM +0200, Lorenzo Bianconi wrote:
> > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > >=20
> > > > > Introduce a knob in mt7603 debugfs in order to enable/disable
> > > > > edcca processing
> > > > >
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > >=20
> > > > It's good to explain what edcca does and how the file is used suppo=
sed
> > > > to be used. In other words, have a small introduction for the user.
> > >=20
> > > Hi Kalle,
> > >=20
> > > edcca is used for adjusting energy detect based on CCA thresholds.
> > > The code was already there so I just reported the acronym.
> >=20
> > What for it is needed ?
>=20
> Care to comment why EDCCA is needed at all ?
>=20
> Taking that debugfs file that enable it is read-only, it looks like
> feature that nobody needs nor tests.

already fixed in v2
https://patchwork.kernel.org/patch/10940645/

Lorenzo

>=20
> Stanislaw=20

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXNvfVwAKCRA6cBh0uS2t
rBeBAP9N9LcAr7lH3ShqQFYjA7HgYlnOV/WcpzzTozpg6kuZdgD+MXG1FzODVmlX
haeZRIN4wV3dLXxFjPGqtZJ6Bk6v+AU=
=C+8i
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
