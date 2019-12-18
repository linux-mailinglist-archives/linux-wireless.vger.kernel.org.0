Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC40112424E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 09:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfLRI6b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 03:58:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfLRI6b (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 03:58:31 -0500
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B61A218AC;
        Wed, 18 Dec 2019 08:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576659510;
        bh=fbGtJ1AbQG4GFHYBK43fqIOtWma50FMdJYnbr+aItmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x7yaOxUI0vNMMLKJX6TQxhBiiWEp986D7WG16oi5xVmRet5P5iFDn7DXLnR45s+Gi
         rn4kT2R74w/uV6Yd9pg3lFem0n4esDjyPOHj4XfzxaZ+mzwjXE1lYMXhZIqYRzhQNP
         HyvIlLIlCPJxGVjBMM4SLiJVmQk31h5vGzS2NPag=
Date:   Wed, 18 Dec 2019 09:58:25 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com
Subject: Re: [PATCH] mt76: fix compilation warning in mt76_eeprom_override()
Message-ID: <20191218085825.GB11823@localhost.localdomain>
References: <a64aaf778d3d144a46678f2833db2ec0afa3c58a.1576521036.git.lorenzo@kernel.org>
 <87bls63ujm.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <87bls63ujm.fsf@tynnyri.adurom.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Fix the following compilation warning in mt76_eeprom_override routine
> > when CONFIG_OF is not set and label 'out' is not actually used
> >
> > drivers/net/wireless/mediatek/mt76/eeprom.c: In function =E2=80=98mt76_=
eeprom_override=E2=80=99:
> > drivers/net/wireless/mediatek/mt76/eeprom.c:100:1: warning: label =E2=
=80=98out=E2=80=99 defined but not used [-Wunused-label]
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> What commit introduced this? Or is this an old issue?

Hi Kalle,

I did not added the Fixed tag since this commit is currently just on Felix'=
s tree:

commit c203e25590b472eb561e1c53898a7f7b5c734563
mt76: fix possible undetected invalid MAC address

Regards,
Lorenzo

>=20
> --=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXfnqLwAKCRA6cBh0uS2t
rD6fAP4pAofcEdyw0SW45WVdY6KUcZEzuuYS5BxXEYNpZJDtdwEAsbkZ9oYy+aaI
VI3aUWTr/cqddmaI7boNhkxq1ZlhnQc=
=HGYW
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
