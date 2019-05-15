Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58CDA1EB9D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 12:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfEOKDv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 06:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfEOKDu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 06:03:50 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50AFA2084A;
        Wed, 15 May 2019 10:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557914629;
        bh=VD4tegmkqkOg95dEhB30JPWx50Q5LVCLUuv7xs5wBxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhMos16Vi53zyiMTWr4CjLVak4U9NIF9mUNdCChG/iw0BAeHHh0bDWQaDzICIygMb
         hu0GXPAgeFyDt2WovO9DkthcXUDNp1XH84TiMDwWSxSiSvp3V2ZEiHeSN8mzkyycLg
         YKSIj4+DRFhPx+detxw6cjADGGpKGEVzqg0Yk+88=
Date:   Wed, 15 May 2019 12:03:44 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7603: add debugfs knob to enable/disable edcca
Message-ID: <20190515100343.GB30757@localhost.localdomain>
References: <cover.1557591530.git.lorenzo@kernel.org>
 <0691acb931e963cb6028d4687cdd61032d0aaf52.1557591530.git.lorenzo@kernel.org>
 <87r293ugia.fsf@purkki.adurom.net>
 <20190513084127.GA3127@localhost.localdomain>
 <20190513094837.GB15694@redhat.com>
 <20190515093333.GA2333@redhat.com>
 <20190515094354.GA30757@localhost.localdomain>
 <20190515095440.GB3407@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <20190515095440.GB3407@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, May 15, 2019 at 11:43:55AM +0200, Lorenzo Bianconi wrote:
> > > On Mon, May 13, 2019 at 11:48:37AM +0200, Stanislaw Gruszka wrote:
> > > > On Mon, May 13, 2019 at 10:41:28AM +0200, Lorenzo Bianconi wrote:
> > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > > > >=20
> > > > > > > Introduce a knob in mt7603 debugfs in order to enable/disable
> > > > > > > edcca processing
> > > > > > >
> > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > >=20
> > > > > > It's good to explain what edcca does and how the file is used s=
upposed
> > > > > > to be used. In other words, have a small introduction for the u=
ser.
> > > > >=20
> > > > > Hi Kalle,
> > > > >=20
> > > > > edcca is used for adjusting energy detect based on CCA thresholds.
> > > > > The code was already there so I just reported the acronym.
> > > >=20
> > > > What for it is needed ?
> > >=20
> > > Care to comment why EDCCA is needed at all ?
> > >=20
> > > Taking that debugfs file that enable it is read-only, it looks like
> > > feature that nobody needs nor tests.
> >=20
> > already fixed in v2
> > https://patchwork.kernel.org/patch/10940645/
>=20
> I'm aware of this patch and other one for mt76x02. But so far in the
> sources EDCCA is disabled for mt76x02 without possibility to enable it
> (and this permission file issue was pointed by Kalle during review, not
> by someone who want to test EDCCA). So again, what for EDCCA is needed ?

As I have already written in a previous email, ED/CCA is used to control tx=
 power
according to the CCA MIB counters (e.g do not transmit if the channel busy =
time
is higher than 90% for given amount of time in a row). I guess it is requir=
ed
by ETSI regulatory.
Regarding file permission for mt76x02 debugfs edcca node is a typo.

Lorenzo

>=20
> Stanislaw

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXNvj/AAKCRA6cBh0uS2t
rEdQAQD4YcmmbO8cooWRbgCwesXnFnjEbxYovLBY6/vBihAUUwD+IruDiQ77GWqm
L5pr8w4RYhR9dbdM937d+obSWNLktgo=
=wWbq
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
