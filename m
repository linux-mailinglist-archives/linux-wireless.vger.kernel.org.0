Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254FFBC3F8
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394866AbfIXISu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 04:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388712AbfIXISt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 04:18:49 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE86D20872;
        Tue, 24 Sep 2019 08:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569313129;
        bh=0XVxQhhK4v/cdMHqzxxL+I21ekgc2Gj21xcbDve7IWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aK1/ATGzKhIttCYCDSS/mcEpdxKHzA/bl1Y/nd/m6aq142LTqX0XebeSlJZOIHmBU
         mRNjfDCET02wSiXO0w5Tbk5Y6idGaLgfk/XjA3uTecaPulO7o88F60wgT60GX++qEr
         azBv85ZeV3UK/kGf8kcM42QanMv6VRitYO4tgEbg=
Date:   Tue, 24 Sep 2019 10:18:43 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: Re: [PATCH] mt76: mt7615: fix mt7615 firmware path definitions
Message-ID: <20190924081843.GA14501@localhost.localdomain>
References: <9e132c0949139155a4fb3375e4c83218159efce7.1569159209.git.lorenzo@kernel.org>
 <87wodzirv8.fsf@tynnyri.adurom.net>
 <20190923142916.GA3385@localhost.localdomain>
 <87lfue5kth.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <87lfue5kth.fsf@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 24, Kalle Valo wrote:
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >> > mt7615 patch/n9/cr4 firmwares are available in mediatek folder in
> >> > linux-firmware repository. Fix path definitions.
> >> > Moreover remove useless firmware name pointers and use definitions
> >> > directly
> >> >
> >> > Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-base=
d chipsets")
> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>=20
> >> This sounds pretty serious, I guess distros don't work out of box
> >> because of this? So I would like to queue this to v5.4.
> >
> > I have always worked on mt7615 driver using OpenWrt. Yesterday I instal=
led
> > another distro (Ubuntu) and I figured out the fw paths were wrong. So y=
es,
> > distros don't work out of box now.
>=20
> Thanks, I'll add this to the commit log and queue for v5.4. Shouldn't I
> also cc stable? The first release was v5.2-rc1.

Yes, I think so

>=20
> In the future I would prefer to have this bug info in the commit log
> right from the beginning, it helps a lot with patch priorisation and
> reduces email :)

Sure, will do. Sorry for not being clear from the beginning.

Regards,
Lorenzo

>=20
> --=20
> Kalle Valo

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXYnRYQAKCRA6cBh0uS2t
rGgiAPsFRZpjLkDSrdX23LQEmndVlvLR1TiPYqYOXV+Quic+hQD/S2vQN59CcpMH
Vlht5w5KE5P15NpStEIVn6mmbCkkMQI=
=f9i6
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
