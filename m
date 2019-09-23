Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96067BB6B7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437717AbfIWO3W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 10:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407439AbfIWO3W (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 10:29:22 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E8420867;
        Mon, 23 Sep 2019 14:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569248961;
        bh=CVgrGX5/EIQqPm/oJqwDX4dwqNY8w7AqKjPDia/J4mA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iBnIOuNDO9P2rMy2OsWwqDEx2X9WpI1YbjWeMmOSi/4Bj51Zomssojf5X7R3u8lsZ
         7O0HtU6uQGzGMFqNkKDydjY8fU1Gh2lviippiWMYQc6bqlqPKeZ9FPv1Tnpzxr9OrE
         x0B2DduwZ82ADJb3qWktmPvGjSZFIJIZSjEedLKc=
Date:   Mon, 23 Sep 2019 16:29:16 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: Re: [PATCH] mt76: mt7615: fix mt7615 firmware path definitions
Message-ID: <20190923142916.GA3385@localhost.localdomain>
References: <9e132c0949139155a4fb3375e4c83218159efce7.1569159209.git.lorenzo@kernel.org>
 <87wodzirv8.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <87wodzirv8.fsf@tynnyri.adurom.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > mt7615 patch/n9/cr4 firmwares are available in mediatek folder in
> > linux-firmware repository. Fix path definitions.
> > Moreover remove useless firmware name pointers and use definitions
> > directly
> >
> > Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based c=
hipsets")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> This sounds pretty serious, I guess distros don't work out of box
> because of this? So I would like to queue this to v5.4.

Hi Kalle,

I have always worked on mt7615 driver using OpenWrt. Yesterday I installed
another distro (Ubuntu) and I figured out the fw paths were wrong. So yes,
distros don't work out of box now.

Regards,
Lorenzo

>=20
> --=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXYjWugAKCRA6cBh0uS2t
rGU6AQCmcJ4XyKq3Ul/pQlBXJNRgsIR/+L0/F0e3HVReYvUNSwEAjVC7bctS4z7V
zRhRsoQg+zXv+6Tz4oeDGAtTPIIywwE=
=OMQE
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
