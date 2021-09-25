Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FACB418028
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Sep 2021 09:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhIYHJA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Sep 2021 03:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhIYHJA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Sep 2021 03:09:00 -0400
Received: from smtp.dkm.cz (smtp.dkm.cz [IPv6:2a02:8301:0:11::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52664C061570
        for <linux-wireless@vger.kernel.org>; Sat, 25 Sep 2021 00:07:25 -0700 (PDT)
Received: from smtp.dkm.cz (localhost [127.0.0.1])
        by smtp.dkm.cz (Postfix) with ESMTP id AA66E28946;
        Sat, 25 Sep 2021 09:07:20 +0200 (CEST)
Received: from router.bayer.uni.cx (ip-89-103-167-90.net.upcbroadband.cz [89.103.167.90])
        by smtp.dkm.cz (Postfix) with ESMTP;
        Sat, 25 Sep 2021 09:07:20 +0200 (CEST)
Received: from album.bayer.uni.cx (album.bayer.uni.cx [IPv6:2001:470:993c:1:5246:5dff:fe8e:a186])
        by router.bayer.uni.cx (Postfix) with SMTP id 7E14FA0078;
        Sat, 25 Sep 2021 09:07:19 +0200 (CEST)
Received: by album.bayer.uni.cx (sSMTP sendmail emulation); Sat, 25 Sep 2021 09:07:19 +0200
Date:   Sat, 25 Sep 2021 09:07:19 +0200
From:   Petr Pisar <petr.pisar@atlas.cz>
To:     linux-wireless@vger.kernel.org
Cc:     petr.pisar@atlas.cz
Subject: Re: ath9 stopped transmitting multicast frames in Linux 5.14.0
Message-ID: <YU7Kp2KvbDj/fWgY@album.bayer.uni.cx>
References: <YTO5CYiGa/OV8tLY@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h4tHzvk8Eaa1+FDM"
Content-Disposition: inline
In-Reply-To: <YTO5CYiGa/OV8tLY@album.bayer.uni.cx>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--h4tHzvk8Eaa1+FDM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

V=C2=A0Sat, Sep 04, 2021 at 08:20:57PM +0200,=C2=A0Petr Pisar napsal(a):
> Hello,
>=20
> after upgrading Linux from 5.13.13 to 5.14.0 on my router with this wirel=
ess
> device:
>=20
> 03:00.0 Network controller [0280]: Qualcomm Atheros AR93xx Wireless Netwo=
rk Adapter [168c:0030] (rev 01)
>         Subsystem: Qualcomm Atheros AR93xx Wireless Network Adapter [168c=
:3116]
>         Flags: bus master, fast devsel, latency 0, IRQ 18
>         Memory at 81200000 (64-bit, non-prefetchable) [size=3D128K]
>         Expansion ROM at 81220000 [disabled] [size=3D64K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=3D1/4 Maskable+ 64bit+
>         Capabilities: [70] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Virtual Channel
>         Capabilities: [300] Device Serial Number 00-00-00-00-00-00-00-00
>         Kernel driver in use: ath9k
>         Kernel modules: ath9k
>=20
> which works as a WiFi accesspoint, I noticed that WiFi clients cannot use=
 IPv6
> anymore. The problem is that the router cannot translate an IPv6 address =
of
> the client to a MAC address. The reason is that IPv6 multicast packets us=
ed by
> ICMPv6 neighbour discovery protocol do not reach the clients. In other wo=
rds
> the ath9k-driven device stopped transmitting multicast frames.
>
The same observation was reported here by Felix Fietkau in "[PATCH] Revert
"mac80211: do not use low data rates for data frames with no ack flag""
<https://marc.info/?l=3Dlinux-wireless&m=3D163091738109000&w=3D2> with a pr=
oposal to
revert the offending d333322361e7a099dc74df2498d3fa5fde5c4fa7 commit.

-- Petr

--h4tHzvk8Eaa1+FDM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE4/QvzhVoMKgDWObpT9GuwzZa978FAmFOyqEACgkQT9GuwzZa
97+HgQ//a3R2xc8ag4sorzucZT7Q8KzM/o+vF83dy988dKlJMwr/yZqtdXWRV/DL
AA2iaYt4uKC6v5FmF6JxFFGzVcU4O34peq08QyZbpfh8M42cRpfpkz5Corr+1wtM
YXaBpPncPM1d/haxX1aLNcc0rjOp65Ez4t6RGdCUBX5R1YCRWsHPOxR1Kcg31uUA
2FHzStQTissByK1FqBBVvtcaQYQCjNfhKkPCOE4OdCUN47qQvPOzayT/9HmlYSmv
AjY5mCAcMhnC/F3fKPxCDFkeycuh7aPcTdec85Yrsa7qU4ZXb6V5Cip7tIVySoZ0
d/GV36pRO64RQvNYJdo4mxa1ihEPasBpmTDVk8JXaBWDzm/HAvFpfNBaGsWBmjiI
61rG2Jak5uLy0gy8ZH0NWvE6KllP2ad3OT28kyMkHKCTNSkmYbRiQnHrZ+UXbirs
+TMYtc+JnQAVFWOG7yZYsmD70vTpGm2MBQCbVKJibuQMVwtFij529XxAJJ1qq0V7
bb7eo8GXsSkh3FKc+u2U912Drdxn/mZ7tkyFf3YaeGdW+h0vq9lsuFANADNkD/sW
oUsZTuSZHTr3WBNtke30YpMwBaV4wtmrFgLfn6Xf8t+3K7WlddYj84NVyqlpm+tx
tuPsINiiozhpLUNFPVtQLUKYSY8wg3VqwbjgPFSmU/Wqa27c4oM=
=K5II
-----END PGP SIGNATURE-----

--h4tHzvk8Eaa1+FDM--
