Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578355B91E
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 12:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfGAKf1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 06:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfGAKf0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 06:35:26 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10802133D;
        Mon,  1 Jul 2019 10:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561977325;
        bh=V0LT2bsF6NCPapQiJPdfvX5x9+VQzHzTina2qNBBtvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kd6kxeWbo7bWTGtE/KWVuLHMHhSlUX1ZoID+s7xevGIGmTLGmpPh1y3CL4y5e1CIK
         uTvttF4xQC6on2EaLsB+1l3nGY94aNUzGaduQo03BvcpvNShOojN4hne7g3FObr/+4
         eM8y/Mfq+J3amwB4bKm/Lks09jwKmtOhShxICxEY=
Date:   Mon, 1 Jul 2019 12:35:20 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: linux-next: Fixes tag needs some work in the
 wireless-drivers-next tree
Message-ID: <20190701103520.GB5110@localhost.localdomain>
References: <20190701074437.6455d067@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <20190701074437.6455d067@canb.auug.org.au>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi all,
>=20
> In commit
>=20
>   d923cf6bc38a ("mt76: mt7615: fix sparse warnings: warning: cast from re=
stricted __le16")
>=20
> Fixes tag
>=20
>   Fixes: 3ca0a6f6e9df ("mt7615: mcu: use standard signature for mt7615_mc=
u_msg_send")
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Did you mean
>=20
> Fixes: 516c3e380533 ("mt7615: mcu: use standard signature for mt7615_mcu_=
msg_send")
>=20
> In commit
>=20
>   eda96044de27 ("mt76: mt7615: fix sparse warnings: incorrect type in ass=
ignment (different base types)")
>=20
> Fixes tag
>=20
>   Fixes: 7339fbc0caa5 ("mt7615: mcu: do not use function pointers wheneve=
r possible")
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Did you mean
>=20
> Fixes: 1ca8089a55ee ("mt7615: mcu: do not use function pointers whenever =
possible")
>=20
> In commit
>=20
>   1a09d9e0e5f0 ("mt76: mt7615: fix incorrect settings in mesh mode")
>=20
> Fixes tag
>=20
>   Fixes: f072c7ba2150 ("mt76: mt7615: enable support for mesh")
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Did you mean
>=20
> Fixes: f4ec7fdf7f83 ("mt76: mt7615: enable support for mesh")

Hi Stephen,

I used the hashes from my local git tree that are different from upstream o=
nes,
sorry for the inconvenience. I will pay more attention next time.

Regards,
Lorenzo

>=20
> --=20
> Cheers,
> Stephen Rothwell



--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXRnh5QAKCRA6cBh0uS2t
rITmAQD9Ee/x3lqKcg1MbMdEffphH2TFisORObcLKQITWW451wD/VvouzaOGhBOW
8LsBL+OGGVwXQIinFxx0xNIA4LQVvwM=
=H4R7
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
