Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0EA48AC16
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 12:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiAKLCq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 06:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiAKLCq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 06:02:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43491C06173F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 03:02:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5576615C3
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 11:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B638DC36AE9;
        Tue, 11 Jan 2022 11:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641898965;
        bh=bpDyuPCSeMVqJyeugkA7wQopRLRWRBPLU2LF5wLNe8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0JjGXgMGBwLwKbWaaEtu9QTD3QigaJQOdps+TZWdEkW6WFieqW4J9e3+UIsFrfBM
         NI0K5G08992uKy502/kb+TgYY/J/u6q2/2A4egeEpzevxrbua5DbAgH97Ptfna71Bp
         vW+U52aTuLF9fov697XcyMNLSPnMW6MeZZWGosBxy/Ss5Lh+cqpGEI9MENKvL85t+N
         3uJ5wb4T3bE7b9jN87/l9EzZhGfQ2agOrY8F0FxXOKIrU+xSOB8Sws0iPVz8zrBcqN
         Tru4X9WDWzOMzyJRQga9IPQsy9dTiB7juVdSH28g2sPUF0252y455I9/vUDKe1KrLz
         zwZg8zIrQaM9Q==
Date:   Tue, 11 Jan 2022 12:02:41 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com, nbd@nbd.name,
        jf@simonwunderlich.de, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Deren Wu <deren.wu@mediatek.com>
Subject: Re: mt76: MT7921K monitor mode not working
Message-ID: <Yd1j0UFVkDC50x8D@lore-desk>
References: <YapTmM3EztojTS9F@lore-desk--annotate>
 <12706913.cppxkphV4n@ripper>
 <YbusBazb4GAC6YQl@lore-desk>
 <34944167.qDeGz8lmHr@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jWgpeJokEZ4CKhaP"
Content-Disposition: inline
In-Reply-To: <34944167.qDeGz8lmHr@ripper>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--jWgpeJokEZ4CKhaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,
>=20
> On Thursday, 16 December 2021 22:13:41 CET Lorenzo Bianconi wrote:
> > can you please try the patch below to see if it fixes the crash/hang in=
 monitor
> > mode?
>=20
> I have tested it now. But it seems like it was already applied. Otherwise=
 I=20
> would have provided my Tested-by.
>=20
> The only problem I have with the monitor mode is the missing beacons (and=
=20
> maybe more frames which I haven't yet identified).
>=20
> Kind regards,
> 	Sven

Hi Sven,

can you please test my latest patch?
https://patchwork.kernel.org/project/linux-wireless/patch/f6ad709b1a64152b5=
955e71b7eef9f9c4c7f127e.1641893305.git.lorenzo@kernel.org/
This patch will automatically set/clear runtime-pm/deep-sleep adding/removi=
ng a
monitor vif.

Regards,
Lorenzo

--jWgpeJokEZ4CKhaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYd1j0QAKCRA6cBh0uS2t
rM6kAP9hz6s1QHJtutAXCkq6/VTbZpOGXDHIodyEESZicFRlIAD/WkjRu83dUNWg
A2ZzAcHLlxpJGttwvqBE9SDQHoyfQw0=
=Cn3t
-----END PGP SIGNATURE-----

--jWgpeJokEZ4CKhaP--
