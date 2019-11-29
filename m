Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F7E10D3CD
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 11:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfK2KTo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 05:19:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfK2KTo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 05:19:44 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 023AA217BA;
        Fri, 29 Nov 2019 10:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575022783;
        bh=gTeJHCIyxpAz+L0NTqEziICyOohggz4wvCHxTrCVi6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJUXx34qUMYsVIz3ICO6a/NAaPWrxCaGYGEZ9z3mtkUfrmgRmq1qrC6qoXxmg1SY8
         59fdYf9WNBEBd6q1k0Wt9yqavjPBQ97zBTqHEe/ccjnqyF6/rEUHZ43cBZzskmWXDY
         Q48q3XxURW8xcHYSF/EQdTrQmyb7LeALByPU68ao=
Date:   Fri, 29 Nov 2019 12:19:35 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Vasa Shpatrov <vasily.shpatrov@queensu.ca>
Cc:     "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Linux bug report: mt76x0 driver for USB WiFi adapter does not
 support channel > 140 on 5Ghz band
Message-ID: <20191129101935.GC32696@localhost.localdomain>
References: <YQXPR0101MB146201584E8F6325CEC4531999470@YQXPR0101MB1462.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <YQXPR0101MB146201584E8F6325CEC4531999470@YQXPR0101MB1462.CANPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

> [3.] Keywords (i.e., modules, networking, kernel):
>     networking, wifi, driver, USB
>=20
> [4.] Kernel information
> [4.1.] Kernel version (from /proc/version):
>         Linux version 4.19.66-Re4son-v8+ (root@kali-pi-dev-v8) (gcc versi=
on 8.2.0 (Debian 8.2.0-12)) #1 SMP PREEMPT Sun Aug 18 12:14:35 UTC 2019

Hi Vasa,

IIUC you are running a pretty old version of the driver. According to the r=
pi
kernel tree, mt76x0u enables radio frequencies up to 5700MHz

https://github.com/raspberrypi/linux/blob/rpi-4.19.y/drivers/net/wireless/m=
ediatek/mt76/mt76x0/init.c#L565

I guess you need to update the driver to latest stable one.

Regards,
Lorenzo

>=20
> [8.] Environment
> [8.1.] Software (add the output of the ver_linux script here)
>         Linux kali 4.19.66-Re4son-v8+ #1 SMP PREEMPT Sun Aug 18 12:14:35 =
UTC 2019 aarch64 GNU/Linux
>=20
>         GNU Make                4.2.1
>         Binutils                2.32.51.20190727
>         Util-linux              2.34
>         Mount                   2.34
>         Module-init-tools       26
>         E2fsprogs               1.45.3
>         PPP                     2.4.7
>         Linux C Library         2.29
>         Dynamic linker (ldd)    2.29
>         Linux C++ Library       6.0.27
>         Procps                  3.3.15
>         Net-tools               2.10
>         Kbd                     2.0.4
>         Console-tools           2.0.4
>         Sh-utils                8.30
>         Udev                    241
>         Wireless-tools          30
>         Modules Loaded          arc4 bcm2835_codec bcm2835_mmal_vchiq bcm=
2835_v4l2 bluetooth
>                                 brcmfmac brcmutil btbcm cfg80211 ecdh_gen=
eric evdev gpio_keys hci_uart ip_tables
>                                 ipv6 mac80211 media mt76 mt76x0 rfkill sd=
hci_iproc serdev snd snd_bcm2835
>                                 snd_pcm snd_timer uio uio_pdrv_genirq v4l=
2_common v4l2_mem2mem vc_sm_cma vchiq
>                                 videobuf2_common videobuf2_dma_contig vid=
eobuf2_memops videobuf2_v4l2 videobuf2_v
>                                 malloc videodev x_tables
>=20
> [8.2.] Processor information (from /proc/cpuinfo):
>         processor       : 0
>         BogoMIPS        : 38.40
>         Features        : fp asimd evtstrm crc32 cpuid
>         CPU implementer : 0x41
>         CPU architecture: 8
>         CPU variant     : 0x0
>         CPU part        : 0xd03
>         CPU revision    : 4
>=20
>         processor       : 1
>         BogoMIPS        : 38.40
>         Features        : fp asimd evtstrm crc32 cpuid
>         CPU implementer : 0x41
>         CPU architecture: 8
>         CPU variant     : 0x0
>         CPU part        : 0xd03
>         CPU revision    : 4
>=20
>         processor       : 2
>         BogoMIPS        : 38.40
>         Features        : fp asimd evtstrm crc32 cpuid
>         CPU implementer : 0x41
>         CPU architecture: 8
>         CPU variant     : 0x0
>         CPU part        : 0xd03
>         CPU revision    : 4
>=20
>         processor       : 3
>         BogoMIPS        : 38.40
>         Features        : fp asimd evtstrm crc32 cpuid
>         CPU implementer : 0x41
>         CPU architecture: 8
>         CPU variant     : 0x0
>         CPU part        : 0xd03
>         CPU revision    : 4
>=20
> [8.3.] Module information (from /proc/modules):
>         mt76x0 122880 0 - Live 0xffffffa3be4ab000
>         mt76 49152 1 mt76x0, Live 0xffffffa3be3bc000
>         mac80211 929792 2 mt76x0,mt76, Live 0xffffffa3be1b1000
>         cfg80211 757760 4 mt76x0,mt76,brcmfmac,mac80211, Live 0xffffffa3b=
dda1000
>         rfkill 32768 6 bluetooth,cfg80211, Live 0xffffffa3bdd69000
>=20
> [8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
>         00000000-3b3fffff : System RAM
>         00000000-00000fff : reserved
>         00080000-00a8ffff : Kernel code
>         00a90000-00d4ffff : reserved
>         00d50000-00f28fff : Kernel data
>         2eff9000-2effffff : reserved
>         39800000-399fffff : reserved
>         39b52000-3a9fffff : reserved
>         3aa70000-3ab70fff : reserved
>         3ab71000-3abd0fff : reserved
>         3abd3000-3abd6fff : reserved
>         3abd7000-3abfefff : reserved
>         3abff000-3abfffff : reserved
>         3ac00000-3b3fffff : reserved
>         3f006000-3f006fff : dwc_otg
>         3f007000-3f007eff : dma@7e007000
>         3f00a000-3f00a023 : watchdog@7e100000
>         3f00b840-3f00b87b : mailbox@7e00b840
>         3f00b880-3f00b8bf : mailbox@7e00b880
>         3f100000-3f100113 : watchdog@7e100000
>         3f101000-3f102fff : cprman@7e101000
>         3f104000-3f10400f : rng@7e104000
>         3f200000-3f2000b3 : gpio@7e200000
>         3f201000-3f2011ff : serial@7e201000
>         3f201000-3f2011ff : serial@7e201000
>         3f202000-3f2020ff : mmc@7e202000
>         3f212000-3f212007 : thermal@7e212000
>         3f215000-3f215007 : aux@7e215000
>         3f300000-3f3000ff : mmcnr@7e300000
>         3f980000-3f98ffff : dwc_otg

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXeDwsQAKCRA6cBh0uS2t
rPIRAQD6gwFlIvb8JyrVLtQk7DeRO/ivkiTlt56VJaC3FJ+XYQEApL79clu+qWWi
GKiFyyxjwXsg23tfo1leNiIMtgAYKAc=
=cYwU
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
