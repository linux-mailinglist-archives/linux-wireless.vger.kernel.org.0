Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9783322792
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 10:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhBWJNQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 04:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231696AbhBWJM7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 04:12:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BFD4601FA;
        Tue, 23 Feb 2021 09:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614071536;
        bh=DjqJjoufcjzpUfw/QLHeD87CQ3boRTZ3pvy1/b0MsKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJ0Jc4epoVOQ8K3M5oRA+ZUfR1he8niW5pIP0sj0nUuYpSgHKONp8Je6AaZZa20KX
         p/t7tr+guBLAS79EvRiFvE+GTMoVdaCdGMX9/8NPIvzhaPL1gS0OLT03fQayyrmNpQ
         VanviheTjJhB54LESIeAqAHCpULfvSoVzX5oBAlOEp/jn4ufer8nMqNheXTpFEeseu
         hZCJOaLrOj5M4Q89s0cTxy2z+vR2Obj8L6q9GeLqKToG2zYOYiJ4Vt4Q2CbREeN8U1
         PEfvCfRBezMtsccwmMZhsuOcMO9bAJ9+dBJuBPEPDSudDbcRTepmWCM8Y4HWFk/hqJ
         fqN0s9LaMbo4A==
Date:   Tue, 23 Feb 2021 10:12:11 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] mt76: mt7615: remove hdr->fw_ver check
Message-ID: <YDTG6xGgCjbinhte@lore-desk>
References: <61d40a20375f888c122ee0e186168fc2db863fc3.1614058187.git.ryder.lee@mediatek.com>
 <d0ed6b4f2dbac66ac9e31f3725bc4db5cc50f1f3.1614058187.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aZDrB28CWxLVbpCm"
Content-Disposition: inline
In-Reply-To: <d0ed6b4f2dbac66ac9e31f3725bc4db5cc50f1f3.1614058187.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--aZDrB28CWxLVbpCm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Only mt7615 uses v1 version. Also, some of released firmware doesn't
> have hdr->fw_ver.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mcu.c
> index 393ce09d3956..65c6ab14fe6f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -1449,8 +1449,7 @@ static int mt7615_load_n9(struct mt7615_dev *dev, c=
onst char *name)
>  		 sizeof(dev->mt76.hw->wiphy->fw_version),
>  		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
> =20
> -	if (!is_mt7615(&dev->mt76) &&
> -	    !strncmp(hdr->fw_ver, "2.0", sizeof(hdr->fw_ver))) {
> +	if (!is_mt7615(&dev->mt76)) {
>  		dev->fw_ver =3D MT7615_FIRMWARE_V2;
>  		dev->mcu_ops =3D &sta_update_ops;
>  	} else {

so there are some v2 fw version w/o fw_ver field, correct? Is this fw in
linux-firmware?

Regards,
Lorenzo

> --=20
> 2.18.0
>=20

--aZDrB28CWxLVbpCm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYDTG5wAKCRA6cBh0uS2t
rCRXAQCV+tBJ1+NpNuY++xxAaztdP5BxlB8GjYx6vMsm7kVxegD/VXUUKUK6RtL0
4cHkqnAcKhHrjWm4udlXVrOMM2p4VAc=
=fCnQ
-----END PGP SIGNATURE-----

--aZDrB28CWxLVbpCm--
