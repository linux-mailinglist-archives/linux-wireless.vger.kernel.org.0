Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF4B400C96
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Sep 2021 20:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhIDScA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Sep 2021 14:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbhIDSby (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Sep 2021 14:31:54 -0400
X-Greylist: delayed 585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Sep 2021 11:30:52 PDT
Received: from smtp.dkm.cz (smtp.dkm.cz [IPv6:2a02:8301:0:11::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A57CC0617AD
        for <linux-wireless@vger.kernel.org>; Sat,  4 Sep 2021 11:30:52 -0700 (PDT)
Received: from smtp.dkm.cz (localhost [127.0.0.1])
        by smtp.dkm.cz (Postfix) with ESMTP id 712B32EC81;
        Sat,  4 Sep 2021 20:20:58 +0200 (CEST)
Received: from router.bayer.uni.cx (ip-89-103-167-90.net.upcbroadband.cz [89.103.167.90])
        by smtp.dkm.cz (Postfix) with ESMTP;
        Sat,  4 Sep 2021 20:20:58 +0200 (CEST)
Received: from album.bayer.uni.cx (album.bayer.uni.cx [IPv6:2001:470:993c:1:5246:5dff:fe8e:a186])
        by router.bayer.uni.cx (Postfix) with SMTP id 29D96A0DC3;
        Sat,  4 Sep 2021 20:20:57 +0200 (CEST)
Received: by album.bayer.uni.cx (sSMTP sendmail emulation); Sat, 04 Sep 2021 20:20:57 +0200
Date:   Sat, 4 Sep 2021 20:20:57 +0200
From:   Petr Pisar <petr.pisar@atlas.cz>
To:     linux-wireless@vger.kernel.org
Cc:     Petr Pisar <petr.pisar@atlas.cz>
Subject: ath9 stopped transmitting multicast frames in Linux 5.14.0
Message-ID: <YTO5CYiGa/OV8tLY@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qu/g+g4LZLshFBDJ"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Qu/g+g4LZLshFBDJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

after upgrading Linux from 5.13.13 to 5.14.0 on my router with this wireless
device:

03:00.0 Network controller [0280]: Qualcomm Atheros AR93xx Wireless Network Adapter [168c:0030] (rev 01)
        Subsystem: Qualcomm Atheros AR93xx Wireless Network Adapter [168c:3116]
        Flags: bus master, fast devsel, latency 0, IRQ 18
        Memory at 81200000 (64-bit, non-prefetchable) [size=128K]
        Expansion ROM at 81220000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [300] Device Serial Number 00-00-00-00-00-00-00-00
        Kernel driver in use: ath9k
        Kernel modules: ath9k

which works as a WiFi accesspoint, I noticed that WiFi clients cannot use IPv6
anymore. The problem is that the router cannot translate an IPv6 address of
the client to a MAC address. The reason is that IPv6 multicast packets used by
ICMPv6 neighbour discovery protocol do not reach the clients. In other words
the ath9k-driven device stopped transmitting multicast frames.

This can be reproduced with "ndisc6 -r 100 fe80::217:c4ff:fe4e:1552 wlan0"
command which queries (100 times) fe80::217:c4ff:fe4e:1552 address of
my client from the router. tcpdump on the ath9k device shows the queries,
but tcpdump on the client cannot see them.

The other way works correctly. I observed this with all two WiFi clients
I have (Pixel 3a phone, and a laptop with a Realtek chip). Upgrading to 5.14.1
did not help. Once I rebooted to 5.13.13, the functionality was restored.

Therefore I conclude this is regression in 5.14.0 Linux.

-- Petr

--Qu/g+g4LZLshFBDJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE4/QvzhVoMKgDWObpT9GuwzZa978FAmEzuPwACgkQT9GuwzZa
979ZohAA4HM5dZV74vOfg5ILT5kJ2M4M64bYN7u/8XcuDGrKBkK/2vfTUI9knKnH
aBvl7wRpAkNsDRPCiu65azUhEtJbZnFii7jLQz6l6R+i25g5Jlyia/ew9J4BTnx3
WWswQZCGRcE0/IIZ8Ego8xEmi2stii5+Qg/r3UkgdJbQzTFG3BsdYKlM7AXSOjom
Oa9M5QVzfraWKK3c8+f03Z+1sEqwXiho/jbpF4K+g1MuDaGSCZC6EYMyYzdgRN5C
7H/2V4YQZKYEvV4xJlUkffE+VR8LiKr7e1KqHuL9/GSZRYicyERidZ4WpPKrxbq0
Zd9nFhBU3c58QUb2njBWaUF2TbZP4AlMtUezsePjD3eHO7hpXI1uoLL+NH6/qttv
9hOu2cW0aUWyPMW/bnjGkQXONsii8CdzVkBpIMgFWFlSyJ+RXcG4En36PmOBCqsm
Ae9rMBSEWqIZqWd+O6O86J+NQy9SOTSIR8UhudzJG/wxdZhYF0HqOkjvbfNTvpfR
5njzUhKWrZgiRmmSwV1wXDyxUdSC1sBbEAF3eph6mQdnWQ7kWEXduAhojeYqpcoq
Yf16kuZjk/+vDxG6nWpGLBHqdXr5TRfVqOao/LoVOK3KETbZCXcHxK+q5/u++rfy
VRgjgrvq7wgJ2VoJwfPL2RFLTHH1KV5JikFqxXoMbtgMyEwLQEo=
=9Wg2
-----END PGP SIGNATURE-----

--Qu/g+g4LZLshFBDJ--
