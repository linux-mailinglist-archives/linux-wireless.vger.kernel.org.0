Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3940467AFE
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 17:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382100AbhLCQNX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 11:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382101AbhLCQMx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 11:12:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1326C061D5E
        for <linux-wireless@vger.kernel.org>; Fri,  3 Dec 2021 08:09:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6841D62C23
        for <linux-wireless@vger.kernel.org>; Fri,  3 Dec 2021 16:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFE8C53FD2;
        Fri,  3 Dec 2021 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638547764;
        bh=lnJSHKCZvGVPK48N7mQhF2MzGkmU1p9LnYQ1zzIxWjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBoEq0Y0FGulKH/ho84vA/VwDnaDfU9XpZq+YZGbx1Qsf/Upb+7sNHy1VKmmxfJBp
         Oi+nm4H4CcPBq15LRL+rrbqXSOmNvHXz9ZqTyFj/9jUhqA3a7+U6zNOdS+jVqhXP3X
         Bb1fsobTjYL3das8GfINdrlQXBx3RrFh5iY+dMCKr3fslkgsOXFz3uksGcL9r9xdir
         GiQ/Af3dQlMnhO+VD8sKM6aezWvlgpvevPqkvblJmSYNDss2Ss1Nx7Pqwwyu0GIK71
         EB2r8aF/Dv7USvt9rT/3FIz1GmN0wbz/ghIpBYPYNX1dXjjjMd4riDw0F2lw8C0ZXI
         MIvJjJy5gn3bg==
Date:   Fri, 3 Dec 2021 17:09:20 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Jan Fuchs <jf@simonwunderlich.de>, linux-wireless@vger.kernel.org,
        nbd@nbd.name, linux-mediatek <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: mt76: MT7921K monitor mode not working
Message-ID: <YapBMGjLcjuBo/vw@lore-desk>
References: <7e156597-a206-b236-e4c8-d476614de7ef@simonwunderlich.de>
 <YalFC7UlCPsCSZqE@lore-desk>
 <3467395.ZLqV6DWSsM@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dy1Ly8MqNkbwOfbI"
Content-Disposition: inline
In-Reply-To: <3467395.ZLqV6DWSsM@ripper>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--dy1Ly8MqNkbwOfbI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thursday, 2 December 2021 23:13:31 CET Lorenzo Bianconi wrote:
> > IIRC you need to disable runtime-pm and deep-sleep to proper enable mon=
itor
> > mode:
> >=20
> > echo 0 > /sys/kernel/debug/ieee80211/phy<x>/mt76/runtime-pm
> > echo 0 > /sys/kernel/debug/ieee80211/phy<x>/mt76/deep-sleep
> >=20
> > Can you please give it whirl?
>=20
> Jan gave me the card. I've set it to a rather busy channel (2.4GHz channe=
l=20
> 11), created a monitor interface, attached tcpdump and then waited what=
=20
> happens. I didn't get anything and then I've tried to set runtime-pm and =
deep-
> sleep to 0. This didn't change the behavior for me at lot. I saw two pack=
ets=20
> and then it went silent again.
>=20
> I wanted to try the same on a different card (ath11k) in the same system.=
 But
> it crashed my complete system - so I had to recreate the test setup. This=
 time,=20
> I've set runtime-pm + deep-sleep to 0 before creating mon0. After doing t=
his,=20
> it seemed to work.

interesting, adding Sean to the loop here.
It seems the fw is mainting a different state in this case.

@Sean: any pointers?

Regards,
Lorenzo

>=20
> Kind regards,
> 	Sven



--dy1Ly8MqNkbwOfbI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYapBMAAKCRA6cBh0uS2t
rJOzAQCZfdsdVFUCVzP+N/SiAYJmM9ynBn2XVI9q/NZY2ynZnAEAyGzUhlgxq2X8
hndtXsB+HrLAQTK6I+FR8neLgT6QnAw=
=zQwP
-----END PGP SIGNATURE-----

--dy1Ly8MqNkbwOfbI--
