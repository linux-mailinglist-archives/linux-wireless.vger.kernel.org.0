Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FE94E3AFE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 09:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiCVIpz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 04:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiCVIpq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 04:45:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E16A46672
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 01:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647938656;
        bh=KduPsgHSPcsY6DsigrItyrFr5SoMEorA69++6IEZPeo=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=gZWtgHwJmNEdk+2bYPLgayxtws4sypaQv4SIXC3Ni0bX3gIP7vbGoMhEPl/sInkjB
         6JEwt2nVOTt/hq+E03lO0HZOrylu0pFvneAn0GN/jpa2bjvyat4+qdB1AFoj2qK+59
         ztAr+6IqmCYoYahk2FkwXYgWYZcejYiTsc8s0qiQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [194.94.225.5] ([194.94.225.5]) by web-mail.gmx.net
 (3c-app-gmx-bap19.server.lan [172.19.172.89]) (via HTTP); Tue, 22 Mar 2022
 09:44:15 +0100
MIME-Version: 1.0
Message-ID: <trinity-ddca7a32-b0cd-440d-9018-f1da4af9be6a-1647938655236@3c-app-gmx-bap19>
From:   Stefan K <Shadow_7@gmx.net>
To:     linux-wireless@vger.kernel.org
Subject: Aw: RE: rtw89: unstable connection
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Mar 2022 09:44:15 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <c9ff4269e3864ee4bd437a40678a9e5f@realtek.com>
References: <2127068.tFZMq15b3B@t460-skr>
 <c9ff4269e3864ee4bd437a40678a9e5f@realtek.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:sa2S8OJbuxkNkHeOBn8XFY9kXT5enTMHLBSrVsOCMf46Ay5uAQcO0yPEWU+LZ3DZ7vrNv
 YY0uMM1beS2v4IlYRJ0c+C6+C0MI0R6GIcaTZl0raZ5taXHLVQNqplQSyYXL08E8rSdWEQBVsidH
 iiXXTAVBjSpNf6CV31VILjkgKJ6OLguMyDSXzzhzU1i3jVMV4SXLsasr2/aj1YhMTBhPicwmkVeZ
 5LuuIFCDyXdTGCiyzBI26wEyLr+s5d1OKoAgWsLiFwIoO2MOdz8nMw+NFCpH+dCDqFT5lgV9ETjm
 tg=
X-UI-Out-Filterresults: notjunk:1;V03:K0:I5cC7ypAZm8=:wOXE9qXohDaKIW5L2+vVv/
 ecasehgDY/OcHuYyMxGV9oyqherx7pvb0Zn9bszWJaQVdGqAzeuoLb68xhMKp3dTCfhoZNML4
 kq57B2IB9JOiuNfQBxBb5xecEhOtTi3P/YGGLevCrszsarxwOTLVi+d00zviEbcKyy/da1yJ1
 3DJTQGEdeg92YcPBwbnKi+nm7jXJF/tqnTbEAe5Wr149q7g7fKeIYQ/2rjDDtIVbFx86IZ/qY
 utMtWOS3nOc4wgNn+q+4vfgjAr9afVsy+rV4LWz+cgBqkX5qdCpPA5WNJoP/bNKi6Q9NkPoHo
 T0xHgKfIcIAHOr21S2BowQpdWnDSk3nLiiWFEeue8kqv7HaIBagjFwMyw0wLHdCAIF6eMoPE7
 fBUBXReZQTDY/Q5taUERMaWi5rpgLAar4xcFyfLMZUqB2w8wEpV+UX5y0R3ap3ZTV7cD/h890
 JRG226XasJD0wAiW/2ZS/AJtsGwT11WadTA2VHuSuSmk1j6XCzqupRE/L46aAV4syws4I8082
 2XX00zEdckmHC+H7SafYRMpIx8lLodLxbuvj/q1X52G
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I ran version 0=2E9=2E12=2E2, now I using 0=2E13=2E36=2E0

And it works fine and looks stable so far=2E

But from time to time I got the following messages (don't know what it mea=
n):
[  412=2E036347] rtw89_8852ae 0000:03:00=2E0: mac c2h class 1 func 2 not s=
upport
[  412=2E036353] rtw89_8852ae 0000:03:00=2E0: mac c2h class 1 func 2 not s=
upport
[  442=2E051581] rtw89_8852ae 0000:03:00=2E0: mac c2h class 1 func 2 not s=
upport
[  442=2E051591] rtw89_8852ae 0000:03:00=2E0: mac c2h class 1 func 2 not s=
upport

But thanks for you help!
best regards=20
Stefan



> Gesendet: Dienstag, 22=2E M=C3=A4rz 2022 um 08:17 Uhr
> Von: "Pkshih" <pkshih@realtek=2Ecom>
> An: "Stefan K" <shadow_7@gmx=2Enet>, "linux-wireless@vger=2Ekernel=2Eorg=
" <linux-wireless@vger=2Ekernel=2Eorg>
> Betreff: RE: rtw89: unstable connection
>
> Hi=20
>=20
> > -----Original Message-----
> > From: Stefan K <shadow_7@gmx=2Enet>
> > Sent: Monday, March 21, 2022 7:52 PM
> > To: linux-wireless@vger=2Ekernel=2Eorg
> > Subject: rtw89: unstable connection
> >=20
> > Hello,
> >=20
> > I got an new Laptop (Lenovo T14 Gen2 AMD) and it has RTL8852AE chip, i=
t can connect to WiFi, but its very
> > slow and unstable:
> > --- 8=2E8=2E8=2E8 ping statistics ---
> > 100 packets transmitted, 60 received, 60% packet loss, time 99514ms
> > rtt min/avg/max/mdev =3D 578=2E297/4515=2E244/10612=2E149/2763=2E037 m=
s, pipe 11
> >=20
> > I'm running on Debian bullseye with backport Kernel Linux 5=2E16=2E0-0=
=2Ebpo=2E3-amd64
> >=20
> > I reported this on github (https://github=2Ecom/lwfinger/rtw89/issues/=
133) and I added the following (as
> > recommended):
> > cat /etc/modprobe=2Ed/50-rtw89=2Econf
> > options rtw89_pci disable_aspm_l1=3Dy disable_aspm_l1ss=3Dy
> >=20
>=20
> In additional to above options, please also add below option:
>=20
>    options rtw89_core disable_ps_mode=3Dy
>=20
> Then, do cold reboot, or shutdown/power-on would be good=2E
>=20
> > [ 1532=2E499712] rtw89_pci 0000:03:00=2E0:  [FWBB][WARN][CMW] No speci=
fic sta connect
> > [ 1532=2E600273] rtw89_pci 0000:03:00=2E0:  [FWBB][WARN][CMW] No speci=
fic sta connect
> > [ 1532=2E700650] rtw89_pci 0000:03:00=2E0:  [FWBB][WARN][CMW] No speci=
fic sta connect
>=20
> This log shows that you use old firmware, please copy the latest firmwar=
e
> to /lib/firmware/rtw89/=2E After applying the firmware, kernel log will =
show
>=20
> rtw89_8852ae 0000:03:00=2E0: Firmware version 0=2E13=2E36=2E0, cmd versi=
on 0, type 1
> rtw89_8852ae 0000:03:00=2E0: Firmware version 0=2E13=2E36=2E0, cmd versi=
on 0, type 3
>=20
> --
> Ping-Ke
>=20
>
