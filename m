Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8A1656A70
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Dec 2022 13:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiL0MFy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Dec 2022 07:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiL0MFb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Dec 2022 07:05:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB7FE65
        for <linux-wireless@vger.kernel.org>; Tue, 27 Dec 2022 04:05:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAA34B80F91
        for <linux-wireless@vger.kernel.org>; Tue, 27 Dec 2022 12:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F1CC433EF;
        Tue, 27 Dec 2022 12:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142719;
        bh=5LHiqeLynL77VsE/GoSVlk7YcpIs55fn3gYhMzF8/9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tShXwjDlXzuiHSG5GMl5oy/BOf09ZXBWzQ3K0pCOkkeqRySFYRC/FKJ8P4uyEUGB/
         8gWvGCrUR+VCejM0qsXH0HHJwcoDTpjWtdpJyMKdfWYS7ye16Nj0gGk92fX3NI/iKn
         LeHoxGxT8yiq4HiLXWkGhn/FWljh77BF4T5K7dO+0k82OTDrN1x4aDhuCEPhIWPgoU
         92sLtZlcZfikd4IZr0GmQx7uIlSrRE0/V1n63+6oYei0g3enBOaaWM3y1GIttb3kYw
         2bHoU0Z+vpgN/Ff1KJU07kS541swKsslxEuupqEArKD8zNps0Hx5S//uPkTM1769EG
         PL2z/ktZKpm2A==
Date:   Tue, 27 Dec 2022 13:05:19 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Nick Morrow <morrownr@gmail.com>
Cc:     nbd@nbd.name, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        Sean Wang <sean.wang@mediatek.com>, deren.wu@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [bug report} wifi: mt76: mt7612u/mt7610u - 6.1.x hard locking
 systems
Message-ID: <Y6rffzYy5hgIQKSE@localhost.localdomain>
References: <CAFktD2fRnSbNgWRRoGbQzG5_Mw7=zFJKTVBHS_3D+mNUYcv9hQ@mail.gmail.com>
 <Y6Y3wzSxbTG2aLAo@localhost.localdomain>
 <CAFktD2fbpUv9X5MY1jozyXoxvNXW=4OfaJ3B1KcZtdrBfiG4NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2DAAM0Odn3zEz+I6"
Content-Disposition: inline
In-Reply-To: <CAFktD2fbpUv9X5MY1jozyXoxvNXW=4OfaJ3B1KcZtdrBfiG4NA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--2DAAM0Odn3zEz+I6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > Starting with kernel 6.1 rc1, mt7612u and mt7610u are hard locking
> > > systems when connection is established. From a report this morning:
> > >
> > > "So I'm using a MT7610U based adapter and updated to 6.1.1 in Arch
> > > Linux and it's a complete lockup a few seconds after connecting as
> > > other people have said, I'll use the LTS kernel (5.15) in the
> > > meanwhile but this is probably going to get a lot of people that use
> > > distros with newer kernels."
> > >
> > > Background: Problem first discovered with kernel 6.1 rc1. Bug report
> > > was seen on linux-wireless around the rc5 timeframe. This is an
> > > additional bug report.
> > >
> > > I don't think additional info is needed as I have tested on several
> > > distros with various RC's of 6.1 and the problem is 100% reproducible
> > > and unavoidable. This is a show stopper bug and will result in
> > > widespread reports as distros upgrade to kernel 6.1.
> > >
> > > Regards,
> >
> > Hi Nick,
> >
> > Can you please try the patch below?
> > https://patchwork.kernel.org/project/linux-wireless/patch/2022121708562=
4.52077-1-nbd@nbd.name/
> >
> > Regards,
> > Lorenzo
>=20
> Lorenzo,
>=20
> Today, I downloaded kernel 6.1.1, applied the above patch and
> compiled. Once installed, I tested with an Alfa ACM mt7612u based
> adapter. I no longer see the problem. No system lockups at all. iperf3
> is showing a consistent performance of around 387 Mb/s. dmesg is
> clean. The patch appears to have fixed the issue. I can also test with
> a mt7610u based adapter if you think it is necessary but since that
> patch was not to mt76, I decided testing only with the mt7612u adapter
> was probably good enough. Let me know if there is anything else I can
> do.

no, it is not necessary to test with mt7610u as well. Thanks for testing.

Regards,
Lorenzo

>=20
> Nick
> https://github.com/morrownr/USB-WiFi

--2DAAM0Odn3zEz+I6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY6rffAAKCRA6cBh0uS2t
rFQAAQDBUAU1+aRZXjlYsdB6GSdP6HJXq0VFg3SPTslkxGXWRAEA94QDG/4x4Tcb
JrynkYJyY3e7yC1naBRyx+pVM5ndbgw=
=Um+x
-----END PGP SIGNATURE-----

--2DAAM0Odn3zEz+I6--
