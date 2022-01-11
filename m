Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB748ADCA
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 13:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbiAKMpL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 07:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbiAKMpK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 07:45:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B5C06173F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 04:45:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79EB66156D
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 12:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9EFC36AE3;
        Tue, 11 Jan 2022 12:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641905108;
        bh=tvwB0W922eYxtQ4dJ1Cesr/VbD76jsProClXDuujtUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cX8/IZzPxmIm5PYHLkLab7uHRHEVR4C9tyjCJtNIeKRK7mSzE2j71QXvUCRIkTaou
         h9/6AfTgOJiCuxmSBWDHghIEitnKwt5m9wLIi7a4uDJiwx0iNLGfYrCEtiYTWwSy6E
         kDEWKIVCF0n/1twbHJZWdqLHpAhfKdbssqyxxzJKzyYRDaPk/C99DqcE+0ARzZLm4u
         ZX84DGFAFKlpJnIF5fr05Gl0PifYpK4Rekuq2BBsbhoaHckZKn3FKvrB/osd5Yuejg
         6tRt/JLyRyANnAtpSnUh0xgwno9D94Fnh1uNWDyVF0MHwpYZuQllN7+CJH5xoEwqLh
         9p4+WBrfRpwcQ==
Date:   Tue, 11 Jan 2022 13:45:04 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        deren.wu@mediatek.com
Subject: Re: [PATCH] mt76: mt7921: toggle runtime-pm adding a monitor vif
Message-ID: <Yd170LnF5Y2D8by5@lore-desk>
References: <f6ad709b1a64152b5955e71b7eef9f9c4c7f127e.1641893305.git.lorenzo@kernel.org>
 <8554350.NRS6bbiA14@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wo3Vtq2WfLghd2zt"
Content-Disposition: inline
In-Reply-To: <8554350.NRS6bbiA14@ripper>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--wo3Vtq2WfLghd2zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tuesday, 11 January 2022 10:34:17 CET Lorenzo Bianconi wrote:
> > Toggle runtime-pm and deep-sleep configuration adding/removing
> > a montior vif in order to forward all tx/rx frames to mac80211.
>=20
> Tested-by: Sven Eckelmann <sven@narfation.org>
>=20

ack, thx for testing.

> So monitor interface now works out of the box for me. Only receiving of=
=20
> beacons (and maybe more?) is not possible with=20
>=20
>     mt7921e 0000:05:00.0: ASIC revision: 79610010
>     mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build Time: 20211222=
190839a
>     mt7921e 0000:05:00.0: WM Firmware Version: ____010000, Build Time: 20=
211222190917

adding monitor vif we disable beacon filter, so I guess we should receive t=
hem.
@Sean, Deren: any hint about it? does the fw support this configuration?
I checked MT_WF_RFCR(0) register, and it is 0x2 adding a monitor vif.

Regards,
Lorenzo

>=20
> Thanks,
> 	Sven



--wo3Vtq2WfLghd2zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYd170AAKCRA6cBh0uS2t
rFTEAQDphVKFN3wB924SaG7CVqlaFa7DBHnyYU9WpvLxG26SogEA6CAcB9kSp6ZD
Db16eXCjIAycu0/OS2hJz/FQOgoIXwk=
=WVhw
-----END PGP SIGNATURE-----

--wo3Vtq2WfLghd2zt--
