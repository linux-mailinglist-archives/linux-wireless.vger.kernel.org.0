Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08BB6555FA
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Dec 2022 00:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiLWXUn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Dec 2022 18:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiLWXUk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Dec 2022 18:20:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3D121882
        for <linux-wireless@vger.kernel.org>; Fri, 23 Dec 2022 15:20:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 268ADB82195
        for <linux-wireless@vger.kernel.org>; Fri, 23 Dec 2022 23:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553E6C433D2;
        Fri, 23 Dec 2022 23:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671837636;
        bh=7DH9rWFiSpnIUtROcGFobZVIBMfhsphaC0SMZ9clWmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p06B7zGqQvM0j/itRnzCNn+nmYUjn03eTbRWs9uJirjqd4K36a+KT+fuDJvVPF0wu
         UVsfPNDOioKOr8+IxN+Xw6sKvpNvmVSF+/ppZTQsQBMgobt2ZSxZH6TmC8TOJMhHJH
         CMrWsjFCy47aP9/Y461CvNTESnLA03rcsgoxY1gOgVDdU6wmFS+9Co3+N2mF8uLcgU
         BnmOc17xnrNGRRebF7THDrmO/Oi2kqwFuPP+maP5R2IwhowD7mnWQcp2gn9LwfkKSU
         OMc5/wadnsnLuBIgY0WJxD9nZLw0qqnBMoFtiaWNaTuoyUtzzB7klaHbpypcixl/VZ
         gPhIZ3VNKex+g==
Date:   Sat, 24 Dec 2022 00:20:35 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Nick Morrow <morrownr@gmail.com>
Cc:     nbd@nbd.name, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        Sean Wang <sean.wang@mediatek.com>, deren.wu@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [bug report} wifi: mt76: mt7612u/mt7610u - 6.1.x hard locking
 systems
Message-ID: <Y6Y3wzSxbTG2aLAo@localhost.localdomain>
References: <CAFktD2fRnSbNgWRRoGbQzG5_Mw7=zFJKTVBHS_3D+mNUYcv9hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EyFLBunWBbUw4B6e"
Content-Disposition: inline
In-Reply-To: <CAFktD2fRnSbNgWRRoGbQzG5_Mw7=zFJKTVBHS_3D+mNUYcv9hQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--EyFLBunWBbUw4B6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Starting with kernel 6.1 rc1, mt7612u and mt7610u are hard locking
> systems when connection is established. From a report this morning:
>=20
> "So I'm using a MT7610U based adapter and updated to 6.1.1 in Arch
> Linux and it's a complete lockup a few seconds after connecting as
> other people have said, I'll use the LTS kernel (5.15) in the
> meanwhile but this is probably going to get a lot of people that use
> distros with newer kernels."
>=20
> Background: Problem first discovered with kernel 6.1 rc1. Bug report
> was seen on linux-wireless around the rc5 timeframe. This is an
> additional bug report.
>=20
> I don't think additional info is needed as I have tested on several
> distros with various RC's of 6.1 and the problem is 100% reproducible
> and unavoidable. This is a show stopper bug and will result in
> widespread reports as distros upgrade to kernel 6.1.
>=20
> Regards,

Hi Nick,

Can you please try the patch below?
https://patchwork.kernel.org/project/linux-wireless/patch/20221217085624.52=
077-1-nbd@nbd.name/

Regards,
Lorenzo

>=20
> Nick
> https://github.com/morrownr/USB-WiFi

--EyFLBunWBbUw4B6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY6Y3vwAKCRA6cBh0uS2t
rLwBAP9Si8qAR4w7Z8svcpPJMCP9/AUqU42Wb3LYasIg+ROAeQEA9qMNbWXbSO1s
kQ+KWOiA/9XDM5lAd+UHkzWHz51JzAs=
=3Y+6
-----END PGP SIGNATURE-----

--EyFLBunWBbUw4B6e--
