Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70071F248
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfEOMBk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 08:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbfEOLNz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 07:13:55 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C4020862;
        Wed, 15 May 2019 11:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918834;
        bh=hF+k8arQQBJmy+6LJc2q9QQ7r70YBE9Ie0gz7BV2xz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BkwBIG3LelHE5JiqR6QSatS76wBERHK9WH79u8fiMDHeynMvWhwzwvSKEmtzZofzO
         KxABmNMVHRAAIrp3zhqLUc/qsJD73DhNBOmGmh6fSKtWnHy5kVy/PbQ3YwJM6rqau/
         7mEkw9BWe95OSBo1Wl4tqgIsHOVEPNCVlNHF7hEI=
Date:   Wed, 15 May 2019 13:13:49 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7603: add debugfs knob to enable/disable edcca
Message-ID: <20190515111348.GC30757@localhost.localdomain>
References: <cover.1557591530.git.lorenzo@kernel.org>
 <0691acb931e963cb6028d4687cdd61032d0aaf52.1557591530.git.lorenzo@kernel.org>
 <87r293ugia.fsf@purkki.adurom.net>
 <20190513084127.GA3127@localhost.localdomain>
 <20190513094837.GB15694@redhat.com>
 <20190515093333.GA2333@redhat.com>
 <20190515094354.GA30757@localhost.localdomain>
 <20190515095440.GB3407@redhat.com>
 <20190515100343.GB30757@localhost.localdomain>
 <20190515103309.GA15134@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <20190515103309.GA15134@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, May 15, 2019 at 12:03:44PM +0200, Lorenzo Bianconi wrote:
> > > On Wed, May 15, 2019 at 11:43:55AM +0200, Lorenzo Bianconi wrote:
> > > > > On Mon, May 13, 2019 at 11:48:37AM +0200, Stanislaw Gruszka wrote:
> > > > > > On Mon, May 13, 2019 at 10:41:28AM +0200, Lorenzo Bianconi wrot=
e:
> > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > > > > > >=20
> > > > > > > > > Introduce a knob in mt7603 debugfs in order to enable/dis=
able
> > > > > > > > > edcca processing
> > > > > > > > >
> > > > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > >=20
> > > > > > > > It's good to explain what edcca does and how the file is us=
ed supposed
> > > > > > > > to be used. In other words, have a small introduction for t=
he user.
> > > > > > >=20
> > > > > > > Hi Kalle,
> > > > > > >=20
> > > > > > > edcca is used for adjusting energy detect based on CCA thresh=
olds.
> > > > > > > The code was already there so I just reported the acronym.
> > > > > >=20
> > > > > > What for it is needed ?
> > > > >=20
> > > > > Care to comment why EDCCA is needed at all ?
> > > > >=20
> > > > > Taking that debugfs file that enable it is read-only, it looks li=
ke
> > > > > feature that nobody needs nor tests.
> > > >=20
> > > > already fixed in v2
> > > > https://patchwork.kernel.org/patch/10940645/
> > >=20
> > > I'm aware of this patch and other one for mt76x02. But so far in the
> > > sources EDCCA is disabled for mt76x02 without possibility to enable it
> > > (and this permission file issue was pointed by Kalle during review, n=
ot
> > > by someone who want to test EDCCA). So again, what for EDCCA is neede=
d ?
> >=20
> > As I have already written in a previous email, ED/CCA is used to contro=
l tx power
> > according to the CCA MIB counters (e.g do not transmit if the channel b=
usy time
> > is higher than 90% for given amount of time in a row). I guess it is re=
quired
> > by ETSI regulatory.
> But what is user case for that, i.e. who need this (it wasn't implemented=
 in
> mt76x2 since you added it on Dec 2018). What will happen if it will be re=
moved?
>=20
> > Regarding file permission for mt76x02 debugfs edcca node is a typo.
> Typo or not, effectively disable the feature and show nobody is
> testing it.
>=20
> The reason I'm asking is that seems EDCCA is the main reason to
> implement watchod for mt76x2, it wasn't necessary to have a watchdog
> as seems devices did not hung before EDCCA was added.

IIRC I added the first watchdog implementation to fix tx hangs that occur
under heavy load even using FCC regulatory (so when EDCCA processing is
disabled)

Regards,
Lorenzo

>=20
> Stanislaw

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXNv0aQAKCRA6cBh0uS2t
rPgLAP4w8B/CCKhKYOXh4RQKO/XtaepRDQOjvmwlJK8QodQttgD+Im2Bs4ajKzhp
dKHjOt3+RKVPFz7K0/DpxHusXcTI9QA=
=xyF2
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
