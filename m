Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75947C249
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 16:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbhLUPKz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 10:10:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50488 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbhLUPKy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 10:10:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59FA761638
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 15:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C415C36AE8;
        Tue, 21 Dec 2021 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640099453;
        bh=mQw0U2pIEF6pkJ8dtV2bWUpTP8D955s0WVx1lO+OXdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i9Xh9VV7OBM4hTLkQBk7ob9aSZm1G8d6DuYUPQUsd7GtYIxxsq/K4e/z4Rmq+ujNg
         TTuR+deBTz4Jda2h6cQZxnMN7MKfaJpdezliirqmwmcxlZfnxjUqPMDqfv1HBcKCG+
         o3k0dpm63BzJTbR4gbpAIqea+uvD2yFMk0+96+/UkXbh/JWSQeh4YWajpSXybd4zoD
         vU0QBCBOrCDVL/cMMvowZ2n4kpYuoL7llCzIEcppnAg5InxkkRrKfPpbzcENI31Wl6
         OfUxbFvmpDr9YnMHgL/1fSyBfIK2OInq3j9k+EEZ2OYGP64+QM4idUQd/fT+KWqTW6
         lQ1iRZ6B6Vzsw==
Date:   Tue, 21 Dec 2021 16:10:49 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, deren.wu@mediatek.com,
        sean.wang@mediatek.com, sven@narfation.org
Subject: Re: [PATCH wireless-drivers] mt76: mt7921: fix a possible race
 enabling/disabling runtime-pm
Message-ID: <YcHueZZ01sMuG0Cz@lore-desk>
References: <0f3e075a2033dc05f09dab4059e5be8cbdccc239.1640094847.git.lorenzo@kernel.org>
 <878rwe6loy.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VnL6r0eOIvJw5UI0"
Content-Disposition: inline
In-Reply-To: <878rwe6loy.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--VnL6r0eOIvJw5UI0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Fix a possible race enabling/disabling runtime-pm between
> > mt7921_pm_set() and mt7921_poll_rx() since mt7921_pm_wake_work()
> > always schedules rx-napi callback and it will trigger
> > mt7921_pm_power_save_work routine putting chip to in low-power state
> > during mt7921_pm_set processing.
> >
> > Suggested-by: Deren Wu <deren.wu@mediatek.com>
> > Tested-by: Deren Wu <deren.wu@mediatek.com>
> > Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> We are in -rc6 already, so I would prefer to take this to
> wireless-drivers-next instead. Is that ok?

I think wireless-drivers-next is fine since the bug is not so critical.

Regards,
Lorenzo

>=20
> Felix, ack?
>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--VnL6r0eOIvJw5UI0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYcHueQAKCRA6cBh0uS2t
rErJAPwPFijAghlCo6CikMY2WOMja9Z+JBLbYqPw41YgUhy3cwEA1uR3n/fvVtyL
F17Y7eNolVj3CGy4Cq+d0wpLyuZk7gY=
=zYZa
-----END PGP SIGNATURE-----

--VnL6r0eOIvJw5UI0--
