Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540693A3C3A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jun 2021 08:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFKGuQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Jun 2021 02:50:16 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:34906 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhFKGuP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Jun 2021 02:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1623394094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yC7DYQZ6KnzuPIK3qEDW/n0fnsnwbGps1v7M2TXyDLc=;
        b=swXHPndtlXdYhyBAr+hOfZAzG8OrLusjps7b/RFJn8T83q5Yl0tdc2mYWD58QFVVKfruqu
        kkJxg9fXZds2ObFjlGyzhXRiGyatoKFqUTSY3BGRyPuWxt7SLGMVSNRFTXlrbZ3/ByWeD6
        fCp2ENfsvRRb7tYQXLrQ7agSfmiUVs0=
From:   Sven Eckelmann <sven@narfation.org>
To:     "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Cc:     Maurice Smulders <Maurice.Smulders@windtalker.com>,
        linux-wireless@vger.kernel.org
Subject: Re: MediaTek MT7612u and IBSS mode
Date:   Fri, 11 Jun 2021 08:48:10 +0200
Message-ID: <4182303.XkkeXVZP1n@ripper>
In-Reply-To: <4E744A61-BBA0-404E-B435-23C26ACF031B@windtalker.com>
References: <4E744A61-BBA0-404E-B435-23C26ACF031B@windtalker.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3186444.dtHR1CuC4E"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3186444.dtHR1CuC4E
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Maurice Smulders <Maurice.Smulders@windtalker.com>, linux-wireless@vger.kernel.org
Subject: Re: MediaTek MT7612u and IBSS mode
Date: Fri, 11 Jun 2021 08:48:10 +0200
Message-ID: <4182303.XkkeXVZP1n@ripper>
In-Reply-To: <4E744A61-BBA0-404E-B435-23C26ACF031B@windtalker.com>
References: <4E744A61-BBA0-404E-B435-23C26ACF031B@windtalker.com>

On Friday, 11 June 2021 03:55:29 CEST Maurice Smulders wrote:
> Platform: Raspberry Pi 4B / CM4 with CentOS 8 stream 64 bit - 5.10.42 kernel
> 
> Trying to use this Mediatek USB device and I notice a - quite nasty - problem using IBSS mode. On startup of the IBSS network, there is a chance the Pi goes into a tizzy 	https://github.com/openwrt/mt76/issues/543 - when it's the first (and only) node.
> I was able to dupe it consistently in my home - fairly static network - but not anymore in a lab environment. I cannot easily go back home - it's ~3000km from where I am at temporarily.
> 
> Does anyone have experience with these MediaTek devices and B.A.T.M.A.N. on lower performance nodes like a Raspberry Pi...

It doesn't seem to me like this is batman-adv or batmand related. So I would 
most likely better to ask on linux-wireless@vger.kernel.org too

And is IBSS mode really required or would meshpoint with mesh_fwding set 0 
also work?

    iw phy0 interface add mesh0 type mp
    ip link set up dev mesh0
    iw dev mesh0 mesh join 11s-bat freq 2412 HT20 mcast-rate 18 beacon-interval 1000

    iw dev mesh0 set mesh_param mesh_fwding 0
    # please make sure that it is actually 0 with: iw dev mesh0 get mesh_param mesh_fwding

    ip link set master bat0 dev mesh0

> I have ascertained that NONE of the USB Realtek dongles work, as the kernel driver is missing IBSS support at this time...
> 
> I'm against an urgent deadline, and trying to understand what I can do to make this work

Kind regards,
	Sven
--nextPart3186444.dtHR1CuC4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmDDByoACgkQXYcKB8Em
e0ZEvRAArrEZQKItYRDBcWQkhHGIYMrm9SDMPNU942EUUeR20vTjFQAfxFo2mrNL
0umJZ04+tK6DyifCWdobfsXq9pjKOXierYpET/4GVFEaD9T6RjzgoycKVom4Lh8/
8cg+k3TdU6I0MtQAeMKhRDWZNrzA/Y6iqi45uGUGJmBPiB9Q7gQSgO6X1YeSTpuR
s81X8AGL/8aWcpvMvmYGa2Ond9wDqA3pQLGtilQgKvOfMtG8X8jNu0eRqumLqeU8
Ga3SHO7DfLVcU0USmJRx2YVPrPgDM6qjcOM7NcWVP19tIWv1VayEu/9ZufjI1ezr
IjQ0JZSuPB0rCjec6YWRXLktNVPWz5GAElDDg72U0c7dlnR7fhymR1J66BV5LPl+
Kwg487eXgrASPgXchxSEoPdxXifget0pyXpx/UcNXEpOfcsUpSXeTZxJ4T3ZJ+t6
kXyr3/3cJgnuQ8qa8ELwKIiTYbHNIEubI4Oxmd9ACxbxqoH0G+htEgexuOMqfO6b
G21P2J8S4sJumja8A3xjkZD4rFzQHHgBQ3YQqa2DLatEdWfnycIysLS7LouiBsEk
iO45SQupbEaRU861l8+Zfh2yVilgjbBSnr1AeR3nCCA0alj++nFeDhbTw97HgiUP
zL4Y+jkwLTHK2PFyjJI9BBPL9Dp9JAkiKTYe+PKqdRt+iMeAQU4=
=PMMc
-----END PGP SIGNATURE-----

--nextPart3186444.dtHR1CuC4E--



