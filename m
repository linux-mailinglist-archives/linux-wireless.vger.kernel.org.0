Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2098A3186AD
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 10:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBKJDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 04:03:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhBKJCJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 04:02:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4034361493;
        Thu, 11 Feb 2021 09:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613034088;
        bh=MI4GYWPIWY+Zo+3Vcbn2NZOTHyDJviJuOQCLUENsNaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhMmg385YljefngT4REeoAxmYkaqRvrvK979A0MYtA6H2V0oPPoKbk/8GGo5H+6Do
         Wd9f1eb8l00beJviYdTJwrVlWtesAQ/lrzNqDR7QHffNAPJvGuDLb35x57AzoSneX3
         Lt23Le2gDgaknHctGE5+fkxF9X6Lg5+4ZkiRebme2vJl/M++l1OP+og5m1nDpa/bg/
         jQ/pecH81iUWfxgwdHK82RRkIaM83ITJUIhhFDigaKgIU5W8JfyQacK/qmoPL7gyUI
         is+fz4PDdb7Uaw09ChU7glUn7LkzjEkEUPBGo27RPhXctCFvnBEcQ6oGWDHYMn3KGa
         yp44jzee9U3Qw==
Date:   Thu, 11 Feb 2021 10:01:23 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     shayne.chen@mediatek.com, linux-wireless@vger.kernel.org
Subject: Re: [bug report] mt76: mt7915: add support for continuous tx in
 testmode
Message-ID: <YCTyY2GProMYGluQ@lore-desk>
References: <YCO+SaK0nJvCG5J5@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1BCbwhKgNRkdwKLM"
Content-Disposition: inline
In-Reply-To: <YCO+SaK0nJvCG5J5@mwanda>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--1BCbwhKgNRkdwKLM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Shayne Chen,

Hi Dan,

right. I will post a fix soon.

Regards,
Lorenzo

>=20
> The patch 3f0caa3cbf94: "mt76: mt7915: add support for continuous tx
> in testmode" from Jan 5, 2021, leads to the following static checker
> warning:
>=20
> 	drivers/net/wireless/mediatek/mt76/mt7915/testmode.c:597 mt7915_tm_set_t=
x_cont()
> 	error: uninitialized symbol 'mode'.
>=20
> drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
>    583                  break;
>    584          case MT76_TM_TX_MODE_HE_EXT_SU:
>    585                  mode =3D MT_PHY_TYPE_HE_EXT_SU;
>    586                  break;
>    587          case MT76_TM_TX_MODE_HE_TB:
>    588                  mode =3D MT_PHY_TYPE_HE_TB;
>    589                  break;
>    590          case MT76_TM_TX_MODE_HE_MU:
>    591                  mode =3D MT_PHY_TYPE_HE_MU;
>    592                  break;
>    593          default:
>=20
> "mode" is uninitialized on the default path.
>=20
>    594                  break;
>    595          }
>    596 =20
>    597          rateval =3D  mode << 6 | rate_idx;
>                            ^^^^^^^^^
>=20
>    598          tx_cont->rateval =3D cpu_to_le16(rateval);
>    599 =20
>    600  out:
>    601          if (!en) {
>    602                  int ret;
>    603 =20
>=20
> regards,
> dan carpenter

--1BCbwhKgNRkdwKLM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYCTyYQAKCRA6cBh0uS2t
rCcxAQCt+xkfnkzgvyjjua9lInDh8GXtlPwbMHlCDzWZi1CsywEA8+FAisPEXzO/
xJjYgFB+3TiEfV4a/QYKU9NJHeT+8AU=
=kHpH
-----END PGP SIGNATURE-----

--1BCbwhKgNRkdwKLM--
