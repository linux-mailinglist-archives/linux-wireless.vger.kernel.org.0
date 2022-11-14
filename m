Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A616281F3
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Nov 2022 15:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiKNOHQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 09:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiKNOHK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 09:07:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F9D2B277
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 06:07:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15D4DB80EBB
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 14:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640A2C433D6;
        Mon, 14 Nov 2022 14:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668434826;
        bh=gzP/liO4RJ471LAuAoem22dSFdFH7q8+7B4M+VM6JHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLvpYP0ddEqyK1rtp6aGPzF9EmSkXUIQ4Qe/eQDL6YVqPnUaFY1Nw+pNh2jtVgwpz
         ySZAHBydtet8nZA6xrfRBck8HvDybv5fYI/VK7A+g3JROzXCS3CeCUAUMEs1GHB5SW
         SEA6wbdhmlFkKS6+LxWYbqtri2hZj3FU+hQWMybeSSp6Sbkza+IUiMBIr90Ne/731a
         1AfaORDg55Y7c5jC5YhHLtc0l98DCWX48nZlrJqcXF+vzwgDy7YX66jreikVoA8nSj
         fdp6KNUTrChyvN3f3w1sdVMDoXbjwdbusmmlbAyxIk3mAOlX0Cr5k7P+1SOV8po5IW
         UtrdffTBcHv4g==
Date:   Mon, 14 Nov 2022 15:07:03 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ray Jantz <ray.jantz@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [BUG REPORT] mt76: LED not working on ASUS AC51 USB (mt7610U)
Message-ID: <Y3JLhx3jfCF8zL3a@lore-desk>
References: <ba072331-b7db-edc3-de77-4496d402f497@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2VUFC7saVm+CVx5e"
Content-Disposition: inline
In-Reply-To: <ba072331-b7db-edc3-de77-4496d402f497@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--2VUFC7saVm+CVx5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,
> Below is a bug I submitted on Suse bugzilla - they said I should it submit
> it to linux-wireless.
>=20
> LED not working on ASUS AC51 wireless USB adapter (MT7610U chipset) using
> Mediatek driver
>=20
> The activity LED on my ASUS AC51 wireless USB adapter does not flash when=
 there is link activity. Everything else works - the adapter connects to wi=
reless networks, but the LED never flashes.  The LED works fine in Windows =
10.
>=20
> Reproducible: Always
>=20
> Steps to Reproduce:
> 1. Plug ASUS AC51 adapter into a USB port.
> 2. No need to install a driver (driver is in-kernel)
> 3.(Optional) reboot
> 4. Connect to wireless network.
> 5. Open a browser and bring up a web page.
> Actual Results:
> The activity LED on the AC51 never flashes even though there is network a=
ctivity.
>=20
> Expected Results:
> The activity LED on the AC51 should flash when there is network activity.
>=20
> The OS is Opensuse Tumbleweed 6.0.5-1-default.
>=20
> The info from lsusb is:
>=20
> ASUSTek Computer, Inc. AC51 802.11a/b/g/n/ac Wireless Adapter [Mediatek M=
T7610U]
>=20
> Bus 001 Device 003: ID 0b05:17d1 ASUSTek Computer, Inc. AC51 802.11a/b/g/=
n/ac Wireless Adapter [Mediatek MT7610U]
>=20
> I have checked the kernel config file and  CONFIG_MT76_LEDS=3Dy is set.
>=20

In the current codebase mt76_leds is only supported for mmio devices since
afaik mac80211 requires the driver led callbacks to be atomic while usb
configuration path can't run in atomic context.
I will work on a solution to overcome this problem.

Regards,
Lorenzo

--2VUFC7saVm+CVx5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY3JLhgAKCRA6cBh0uS2t
rJL0AQDOelTL6S/EFAOL8GtotfMk4a39/mn304PtWZ18XrqqWAEA+WQGr9woxpgg
OAsn1IvBYkWpZ6eCkkGFBitydhkcuQ0=
=AG0G
-----END PGP SIGNATURE-----

--2VUFC7saVm+CVx5e--
