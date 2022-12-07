Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C443D645CB1
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 15:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLGOfW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 09:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiLGOfM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 09:35:12 -0500
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 06:35:01 PST
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EEA60369
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 06:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Eov9yMg5vnGx30TB6qkIL9b8Z7I1iUBVN2gDoOFOPiU=; b=AgtPs+Wm0e+CLyozKzjrb3MJ+q
        CVWZ6eRfiqFktAbjMTiDSaxqWWPM1pugM57gTUD5yfUg41ugUxxvAgCQtNpKYQL2HXTn8tlUGjvem
        W7t1Ot8TocpXq0aiUDsin7sR3OljTdvtxIK7aMfqwWMeujBcZ04NXygworE3aT+URy/r0HfjWfh8G
        1x3c2/Iuyva+71LW57ODRtlhcHO9fBKSBhRHgEr9NThDxutH1y2y8J2HL/AfbHS1WLRM2bnVB3nXE
        y7ktq4cNKPq4MiUdV2OwuNf49RPT45V9a3HSY15s/8BMy3F+NaVNDQbWAMRxqa9xMntY2/bsSeSt6
        p4zRKwbw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1p2vM5-00E00a-Cc; Wed, 07 Dec 2022 14:25:02 +0000
Date:   Wed, 7 Dec 2022 15:24:58 +0100
From:   Cyril Brulebois <kibi@debian.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, debian-kernel@lists.debian.org,
        debian-boot@lists.debian.org
Subject: Re: failed to insert STA entry for the AP (error -2)
Message-ID: <20221207142458.mlulpx6jts3yt72b@mraw.org>
Organization: Debian
References: <20221130122807.GA31720@lst.de>
 <87o7so4nr2.fsf@kernel.org>
 <20221130125236.GA865@lst.de>
 <87k03c4mdb.fsf@kernel.org>
 <20221130133016.GC3055@lst.de>
 <87sfhx3ap6.fsf@kernel.org>
 <20221203155227.GA13254@lst.de>
 <87cz8v2xb2.fsf@kernel.org>
 <20221207134025.GA21691@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pcmiubcz63uhxe3f"
Content-Disposition: inline
In-Reply-To: <20221207134025.GA21691@lst.de>
X-Debian-User: kibi
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--pcmiubcz63uhxe3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Christoph,

Christoph Hellwig <hch@lst.de> (2022-12-07):
> It turns out that while d-i comes with the ath11k and ath11k_pci
> drivers, but misses the qrtr, qrtr-mki and michael_mic modules that
> are needed for the driver to actually work and not just load.

Reminds me of: https://bugs.debian.org/761902 which meant my wireless
adapter was happy with WEP but not WPA.

> Yes.  I'm not quite sure how the packages for d-i select which modules
> to include where, but given that other wifi hardware seems to work in
> the installer they must have figured this out somehow.

What modules end up in what udebs is decided in src:linux, under
debian/installer/modules.

Commit fixing the bug mentioned above:
  https://salsa.debian.org/kernel-team/linux/-/commit/782d644da7ab74e04bfeb=
d30b66c264654028da3


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--pcmiubcz63uhxe3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmOQojcACgkQ/5FK8MKz
VSDkFA/6A/nAxvhQJb+QA8y2Q+wT8r3MSJcucTOf/kp52oMgjjwM4wQsgjEvUFVG
nb5oM9rlvBgm6X5oRL8+Mb5DHyNMb2roh8HK4EXn1Xy3WcPOyRKP1sTPSLx1qe9C
0h5BBZgfFayBfiU4s2eFQSArJQPRYFm8E5stZY+pwJevgaJ0jC8mOOZ2MMnau34S
5PWvR/Z86tZ+z114LcdLthi+tGPSCOHxsitmACLFMQZ5WsxZKR3WDJoZMKhu9E1M
XNhyZJ/y5IYwa5/fEgj2RzYO4ExPUVYplefMQEeHrp+xcBB9nCfyb59BJbQ1t1+S
+9Iir7K7OMMGlBA0EDCMqvUgHgQswVSvCHHEsz5lEefme54pWebDoZQ4hysYJxhq
zcQK6/1oX8phSu8sY/ZeXU5slCUMZQJjgVd5rS0gKenbE0OEYAhJAqAFBpwJ/ZzY
Xn9c8Dii9XJqlWO9c8km8bhvjn9Y7PMSo7aUsp2Uq9XHh7gV/rPQri+sIB7q6Nro
Pahee/O4wX8NEEZk16UTQS0rvqVf1ZNOKi1PrvxkDwCrtxwTq3rbhZ9z/yJhl3DS
yiZo8GWo/0Us6k+pSFPZ12O8Id2pQojm6+UKBW3EsUVEwq2v9U6O21BUngdnRIY+
sfaXRYr2c7VqeWTBVXDcW+GOKgXKAbErJA/e3HUjVwEmJQC7j+Y=
=TgTW
-----END PGP SIGNATURE-----

--pcmiubcz63uhxe3f--
