Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C038148AC0B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 11:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiAKK67 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 05:58:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59062 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349489AbiAKK6i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 05:58:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E21E6615C9
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 10:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE44C36AE3;
        Tue, 11 Jan 2022 10:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641898717;
        bh=7A2HmM/Ser53J1c4qOSiBQ1vG++Nn3K+WnGPh4pjdcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3hbOcaesOCvzyj73w6+c4w0O7Z/Q7FFRi5ji1kLw49lcuqJcyJmIquXqY9n+gwEG
         znMDSAKG2OloncSBMqHB8jf2rA8NLtxbSaS8SxK47X5LCoGXM5gbUY3s2ek10jRClp
         fsld4NpZKQNKtTXsNpwvR/U2lGeZC7wSHwmeXz8aumU7OOEyjmURi54RX9jV2ASBhN
         P+2ZIPlBvtnfIPZHza1GsbyzHm5uDEdTVOddZof6SHFBQkOhVZYKo5HDmxmt6RTvER
         YEhnZ6jegdCxSdWYDGbKsMcv511GKwFMFCeq1Iw4zgKAPlZw0WRiVJPd7QRqWabTxX
         nXyHdPYJh+3jg==
Date:   Tue, 11 Jan 2022 11:58:33 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        deren.wu@mediatek.com
Subject: Re: [PATCH 1/2] mt76: mt7921: fix a leftover race in runtime-pm
Message-ID: <Yd1i2dzT7l/gLUb/@lore-desk>
References: <cover.1640897147.git.lorenzo@kernel.org>
 <65e65daddbcec420392befa3b4f9a6aaaea21315.1640897147.git.lorenzo@kernel.org>
 <87zgo2k1b2.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ShYKOc29s3nnGLt4"
Content-Disposition: inline
In-Reply-To: <87zgo2k1b2.fsf@tynnyri.adurom.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ShYKOc29s3nnGLt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Fix a possible race in mt7921_pm_power_save_work() if rx/tx napi
> > schedules ps_work and we are currently accessing device register
> > on a different cpu.
> >
> > Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/=
net/wireless/mediatek/mt76/mt7921/mac.c
> > index defef3496246..0744f6e42ba3 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> > @@ -1553,6 +1553,14 @@ void mt7921_pm_power_save_work(struct work_struc=
t *work)
> >  	    dev->fw_assert)
> >  		goto out;
> > =20
> > +	if (mutex_is_locked(&dev->mt76.mutex))
> > +		/* if mt76 mutex is held we should not put the device
> > +		 * to sleep since we are currently accessing device
> > +		 * register map. We need to wait for the next power_save
> > +		 * trigger.
> > +		 */
> > +		goto out;
>=20
> This looks fishy to me. What protects the case when ps_work is run first
> and at the same time another cpu starts accessing the registers?
>=20
> Do note that I didn't check the code, so I might be missing something.

before accessing chip registers, we run mt7921_mutex_acquire() so we grab m=
t76
mutex and run mt76_connac_pm_wake(). In mt76_connac_pm_wake() we cancel
ps_work, so it is not possible to access regs while mt7921_pm_power_save_wo=
rk() is
running. The only leftover case is the other way around, i.e. if we
schedule mt7921_pm_power_save_work while we are already reading/writing chip
regs. This is only possible when mt7921_pm_power_save_work is scheduled by
rx_napi and this patch is fixing the latter case. Agree?

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--ShYKOc29s3nnGLt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYd1i2QAKCRA6cBh0uS2t
rJBYAQDx1cEByJO4CirfWzK/IjMAJ1l4DzG0E8PM35o/umH65QEAyPYdHZgLrSnK
l5xDcLbN2LVG8UI68zcNh6bXrJ4jTgU=
=i4dQ
-----END PGP SIGNATURE-----

--ShYKOc29s3nnGLt4--
