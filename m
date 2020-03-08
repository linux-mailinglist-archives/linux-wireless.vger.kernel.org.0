Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2D17D344
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 11:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgCHKoB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 06:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgCHKoB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 06:44:01 -0400
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C68420828;
        Sun,  8 Mar 2020 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583664241;
        bh=hqlA6lSMLWbnz9BF/e9pOQBqFmdVb8XeWhql/dME254=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlPxdi/GpM2Dwg56AnTEXt59lM5Mj2hczLOFe9ZZQYBEft9doubJqdrdIMFlL0nu3
         IO5VVaEq9fbRkShCtERldTuzPUg0/Fm3wQS2Jlu6B5eshJ2DB6bWupgdQiIiXVeiKQ
         UB69jukyMsGAKqT3QkUFkOsmTrjjXQTNO0er2YI4=
Date:   Sun, 8 Mar 2020 11:43:59 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: Re: [PATCH 0/4] use proper size for mt7615 sta mcu commands
Message-ID: <20200308104359.GA1579745@localhost.localdomain>
References: <cover.1583066508.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <cover.1583066508.git.lorenzo@kernel.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Use proper buffer size for mcu messages in mt7615_mcu_set_sta since
> MT7615_WTBL_UPDATE_MAX_SIZE takes into account just wtbl headers while
> the mcu message contains even sta related headers.
> Use proper buffer size for mcu messages in mt7615_mcu_set_rx_ba,
> mt7615_mcu_set_tx_ba and mt7615_mcu_set_bmc routines
>=20
> Lorenzo Bianconi (4):
>   mt76: mt7615: use proper size for mcu msg in mt7615_mcu_set_tx_ba
>   mt76: mt7615: use proper size for mcu msg in mt7615_mcu_set_rx_ba
>   mt76: mt7615: use proper size for mcu msg in mt7615_mcu_set_sta
>   mt76: mt7615: use proper size for mcu msg in mt7615_mcu_set_bmc
>=20

Please drop this series, I will post an update version soon.

Regards,
Lorenzo

>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 354 ++++++++++--------
>  .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  20 +
>  2 files changed, 213 insertions(+), 161 deletions(-)
>=20
> --=20
> 2.24.1
>=20

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXmTMagAKCRA6cBh0uS2t
rGwlAPwMKLfwDgNdE37Ticfa4bG6N1YTZpJMBJwfwuvYnT4vHAEApWxGe0vJ3qrK
AMlDOWDBC0557gaZv/vcM6gPQGr+pg4=
=aWKf
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
