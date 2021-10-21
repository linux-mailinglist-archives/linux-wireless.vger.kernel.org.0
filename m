Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B037C436DB4
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 00:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhJUWr3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 18:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhJUWr2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 18:47:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E60F46128E;
        Thu, 21 Oct 2021 22:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634856312;
        bh=m+qfnO/SBKNnY0uN/eCpqLaGQq20Fvm3i99u9LONZh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LiiCwuF/Qwxl+7mNxxl3EIBsU58YVY3QuF+op5wV1Cjh/dF31MbVKVFBtp/GxXJMC
         jlSzQGFAjneD1R/VP5DfNTj1lI/K10GSTeQxZxJn2BOpcmCucPqxzOKBPL64XC3Zgh
         kdrsrNE/xAmQwdiD7i3wKURM3MSU02JZQuz9WF117Sq7dNNYO4WGCq5rhEiO1+w2qD
         XXsZte8BIKCD1GyRvb26w9I+vAi6atbgbnD7ysCKtenZ+R+Wq61JtOird+5Dtq3tMm
         oG//QDfIffvAKbz7ndZoX/H0rZWPS7uvJIfmhaybEe6QDw47rGYX3MGpTmw7G5pxUq
         18D81NdV1gyCA==
Date:   Fri, 22 Oct 2021 00:45:08 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: linux-next: Tree for Oct 21
 (drivers/net/wireless/mediatek/mt76/sdio.o)
Message-ID: <YXHtdI61S54Cm0S2@lore-desk>
References: <20211021184300.30c77f51@canb.auug.org.au>
 <88795dab-d8a9-856e-a938-8da6acc944ea@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8aYSJNaYc6oB2iRG"
Content-Disposition: inline
In-Reply-To: <88795dab-d8a9-856e-a938-8da6acc944ea@infradead.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--8aYSJNaYc6oB2iRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 10/21/21 12:43 AM, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20211020:

Hi Randy,

can you please the patch below?

Regards,
Lorenzo

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/Kconfig
index ce3a06227901..71154fc2a87c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
@@ -19,6 +19,7 @@ config MT7921S
 	select MT76_SDIO
 	select MT7921_COMMON
 	depends on MAC80211
+	depends on MMC
 	help
 	  This adds support for MT7921S 802.11ax 2x2:2SS wireless devices.
=20
> >=20
>=20
> on x86_64:
>=20
> ld: drivers/net/wireless/mediatek/mt76/sdio.o: in function `mt76s_rr':
> sdio.c:(.text+0x1263): undefined reference to `sdio_claim_host'
> ld: sdio.c:(.text+0x1278): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x12c8): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x1327): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x134d): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x138c): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x140f): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x1498): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x14e5): undefined reference to `sdio_release_host'
> ld: drivers/net/wireless/mediatek/mt76/sdio.o: in function `mt76s_wr':
> sdio.c:(.text+0x1599): undefined reference to `sdio_claim_host'
> ld: sdio.c:(.text+0x15ae): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x15f9): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x1646): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x16a5): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x16cb): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x170a): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x1782): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x17e9): undefined reference to `sdio_release_host'
> ld: drivers/net/wireless/mediatek/mt76/sdio.o: in function `mt76s_hw_init=
':
> sdio.c:(.text+0x1a56): undefined reference to `sdio_claim_host'
> ld: sdio.c:(.text+0x1a5e): undefined reference to `sdio_enable_func'
> ld: sdio.c:(.text+0x1a81): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x1ae1): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x1b18): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x1b45): undefined reference to `sdio_set_block_size'
> ld: sdio.c:(.text+0x1b9e): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x1bcb): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x1bef): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x1c10): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x1c27): undefined reference to `sdio_claim_irq'
> ld: sdio.c:(.text+0x1c37): undefined reference to `sdio_release_host'
> ld: sdio.c:(.text+0x1c43): undefined reference to `sdio_disable_func'
> ld: sdio.c:(.text+0x1c4b): undefined reference to `sdio_release_host'
> ld: sdio.c:(.text+0x1c5e): undefined reference to `sdio_writel'
> ld: drivers/net/wireless/mediatek/mt76/sdio.o: in function `mt76s_deinit':
> sdio.c:(.text+0x208e): undefined reference to `sdio_claim_host'
> ld: sdio.c:(.text+0x20af): undefined reference to `sdio_release_irq'
> ld: sdio.c:(.text+0x20d0): undefined reference to `sdio_release_host'
> ld: drivers/net/wireless/mediatek/mt76/sdio.o: in function `mt76s_read_pc=
r':
> sdio.c:(.text+0x11bd): undefined reference to `sdio_readl'
> ld: drivers/net/wireless/mediatek/mt76/sdio_txrx.o: in function `__mt76s_=
xmit_queue':
> sdio_txrx.c:(.text+0xf7): undefined reference to `sdio_writesb'
> ld: drivers/net/wireless/mediatek/mt76/sdio_txrx.o: in function `mt76s_rx=
_run_queue':
> sdio_txrx.c:(.text+0xffc): undefined reference to `sdio_readsb'
> ld: drivers/net/wireless/mediatek/mt76/sdio_txrx.o: in function `mt76s_tx=
rx_worker':
> sdio_txrx.c:(.text+0x1a18): undefined reference to `sdio_claim_host'
> ld: sdio_txrx.c:(.text+0x1a4d): undefined reference to `sdio_writel'
> ld: sdio_txrx.c:(.text+0x22c7): undefined reference to `sdio_writel'
> ld: sdio_txrx.c:(.text+0x22e9): undefined reference to `sdio_release_host'
>=20
>=20
> Full randconfig file is attached.
>=20
> --=20
> ~Randy



--8aYSJNaYc6oB2iRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYXHtdAAKCRA6cBh0uS2t
rMTTAQDPwBEhZ0z/llYiW+9LAvwvcs96cD9CVHIc55ZSbProGQEAzoIBKkh1cvSX
2UhU4mRO1H8SOkskh8hyRpj4tUTCews=
=PfpR
-----END PGP SIGNATURE-----

--8aYSJNaYc6oB2iRG--
