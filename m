Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DFE381916
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhEON2d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 09:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhEON2b (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 09:28:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8822D613C5;
        Sat, 15 May 2021 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621085238;
        bh=QURrrz5COVC1de/qkQQKAKghh77NujeEw+aCUpanUnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iO+RTPhaXq79mQRT0kXi6XABMHse1HtWP3nfmmrkz8yqLaNkSdA7oAF95T2zqsKA3
         9DeZ8dPjQJmu98ktytJvhnQSrMVvnHjWoHH1o6mXn0qxM4buBiN11wlJYWKaACD/Lk
         9EBYMTfps25ZJLk4y/PN+Xn8UyLvLiKeojnf1kCKllZiPxBYiMNVnPXf2GDhfFXLQO
         pqY1LFQMIMQLZSFEqH3EGEL6rjrFQ/HcxxkpiFlnfB0UyoR3SnqvuasoOBJL61FBu4
         /4UdCebrqECbVl6FRWUzAYFyFB/K3DFDNE1ejnsSSLDOZG3NsEuQ6V9AfpTcgxBClX
         KlqBLyBp34D1g==
Date:   Sat, 15 May 2021 15:27:13 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Subject: Re: [PATCH] mt76: mt7615: do not set MT76_STATE_PM at bootstrap
Message-ID: <YJ/MMVp5lRSMpsy2@lore-desk>
References: <3ff8e1901f38a943c4ca487a93d036ed368b46e1.1619543861.git.lorenzo@kernel.org>
 <20210515064632.E5146C433F1@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+Tvjm1DBeWv6qCjF"
Content-Disposition: inline
In-Reply-To: <20210515064632.E5146C433F1@smtp.codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--+Tvjm1DBeWv6qCjF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Remove MT76_STATE_PM in mt7615_init_device() and introduce
> > __mt7663s_mcu_drv_pmctrl for fw loading in mt7663s.
> > This patch fixes a crash at bootstrap for device (e.g. mt7622) that do
> > not support runtime-pm
> >=20
> > Fixes: 129fac01ffe85 ("mt76: connac: introduce wake counter for fw_pmct=
rl synchronization")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Lorenzo, you wanted to have this to v5.13, right?
>=20

yes, right

> Fixes tag is wrong:

ops, sorry. Fixed in v2

Regards,
Lorenzo

>=20
> Git commit not found or invalid id: 129fac01ffe85
>=20
> Please provide me the correct commit id and I can fix it during commit.
>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/patch/3ff8e1901f38a94=
3c4ca487a93d036ed368b46e1.1619543861.git.lorenzo@kernel.org/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--+Tvjm1DBeWv6qCjF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYJ/MLgAKCRA6cBh0uS2t
rLx5AQCnCk5CeGJSZmE+uIRDYqX4lnBpf/sAPiClExaT5Q90xwEAsN1pgpPkmolH
fJtvY5T1W4beIK+ojRB8LiHtC+hVego=
=SYIx
-----END PGP SIGNATURE-----

--+Tvjm1DBeWv6qCjF--
