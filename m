Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426F4283FD6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 21:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgJETqy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 15:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgJETqy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 15:46:54 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5EFC0613CE
        for <linux-wireless@vger.kernel.org>; Mon,  5 Oct 2020 12:46:53 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u17so3750175oie.3
        for <linux-wireless@vger.kernel.org>; Mon, 05 Oct 2020 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=M8CV5lrgF8LttTFc2ZXs1qHQNa0y3QtjVvRCMxtStpY=;
        b=kqp34i3gSbDQrPniKEFimOQUeJbgunncxL8gH3NWWz2ErNRWT0/GM3/I4/4sXxY2oi
         Hs+3avOIcAeZAt+y32WK3Jjc9g9RmKhjL+z0LjloV9gaw4LQapbdroKF5/ZXuaMjfuYW
         b2NsBUmd3uR7NBYSQWLFa0FR2vll6wX2wXtTz3iG8ygtvuPp5xdZFkd5HBqi6Y9SkP0u
         rFFei81d4dScTfMRa9y8Ufz8ZKSz2/rRvJWQCZgXW0vDrvA4FH0jmyXlR/SxDNpqVmD2
         1064PL+97DgxziaBe0sxCWfY7OXi4SZmM8hBnSV4C6IMYfRWb344TgtYs5jrjd/jGZXl
         P5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=M8CV5lrgF8LttTFc2ZXs1qHQNa0y3QtjVvRCMxtStpY=;
        b=MKQ3Lt7rpLOhbQEetxaSu5GSGYOrwoRitHzEVV24BCOdun8/8VspXZV/weRYNL0Ne2
         pdLdhtukfbUnQf8TE1y9BAenueBkW/Xf+kwMnZcUkPlTfo7MuH14rJDScZ4ruByCmw6Q
         y8oeBZ2lbF7O+w5R9X4AgOtNWRS5okbSbKhsJOiReEgSzvwQw4cmoMSvc+eosdodE9yV
         3RfZVPGqdne5T9pZwCxI7VyvcWxFmDdQzDeHOXkuyGf3U808wVwJb/HkhA4PFGTu9E8L
         Xxh290KdIyrrSUimio69KoH1BY3TSu1RJDPzOvTf43/LcOmN6BoVKJhEB8H9NQuKpch0
         0bkg==
X-Gm-Message-State: AOAM530wCqzYOn6qH/JIzMjuEyut0fB6M9+VYn2oChOfNxCShC1omIe8
        g4/8AUD+uxh/apx8qqmseo7IJiwhTzxPuQU+kvf1AGVbPG4=
X-Google-Smtp-Source: ABdhPJz4kl0D/LzP+mjSpgAFBQmLZq/NYnXvFtIyeUTpniCHmCdjkK1iNTO6nz5JrgCgKSfhV3L2lByUbwnnFEEGsh4=
X-Received: by 2002:a05:6808:555:: with SMTP id i21mr577564oig.55.1601927212863;
 Mon, 05 Oct 2020 12:46:52 -0700 (PDT)
MIME-Version: 1.0
From:   Cristian Llanos <cristian.llanos@gmail.com>
Date:   Mon, 5 Oct 2020 16:46:14 -0300
Message-ID: <CANBg+yz2az1o9u7RDD6jwXCs=08u7izbmUOnkKJc2tnOQQCdog@mail.gmail.com>
Subject: Error in driver for RTL8821CE
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, my name is Cristian, I'm writing from Chile

I'm trying to install the driver for my RTL8821CE card. I'm following
the instructions from the repo https://github.com/lwfinger/rtw88 (I
took the email from there) but when I try to run the "make" command, I
get the following error:

/home/cristian/Downloads/realtek_drivers/rtw88/main.c: In function
=E2=80=98rtw_core_init=E2=80=99:
/home/cristian/Downloads/realtek_drivers/rtw88/main.c:1623:2: error:
implicit declaration of function =E2=80=98tasklet_setup=E2=80=99
[-Werror=3Dimplicit-function-declaration]
 1623 |  tasklet_setup(&rtwdev->tx_tasklet, rtw_tx_tasklet);


this is the output from "sudo lshw -C network" and the full log of the erro=
r.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw88$
sudo lshw -C network
  *-network
       description: Ethernet interface
       product: RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
       vendor: Realtek Semiconductor Co., Ltd.
       physical id: 0
       bus info: pci@0000:01:00.0
       logical name: enp1s0
       version: 15
       serial: 84:2a:fd:5a:7f:6e
       capacity: 1Gbit/s
       width: 64 bits
       clock: 33MHz
       capabilities: pm msi pciexpress msix bus_master cap_list
ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd
autonegotiation
       configuration: autonegotiation=3Don broadcast=3Dyes driver=3Dr8169
firmware=3Drtl8168h-2_0.0.2 02/26/15 latency=3D0 link=3Dno multicast=3Dyes
port=3DMII
       resources: irq:19 ioport:4000(size=3D256)
memory:80504000-80504fff memory:80500000-80503fff
  *-network UNCLAIMED
       description: Network controller
       product: RTL8821CE 802.11ac PCIe Wireless Network Adapter
       vendor: Realtek Semiconductor Co., Ltd.
       physical id: 0
       bus info: pci@0000:02:00.0
       version: 00
       width: 64 bits
       clock: 33MHz
       capabilities: pm msi pciexpress cap_list
       configuration: latency=3D0
       resources: ioport:3000(size=3D256) memory:80400000-8040ffff
cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw88$

cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw88$ =
ls
bf.c             debug.o         mac80211.o    phy.c
rtw8723de.h       rtw8821c_table.c  rtw8822ce.c          sec.c
bf.h             dkms.conf       mac.c         phy.h
rtw8723d_fw.bin   rtw8821c_table.h  rtw8822ce.h          sec.h
bitfield.h       efuse.c         mac.h         ps.c         rtw8723d.h
       rtw8822b.c        rtw8822c_fw.bin      sign-file
certificate.p12  efuse.h         main.c        ps.h
rtw8723d_table.c  rtw8822be.c       rtw8822c.h           tx.c
certificate.pem  fw.c            main.h        README.md
rtw8723d_table.h  rtw8822be.h       rtw8822c_table.c     tx.h
coex.c           fw.h            main.o        regd.c       rtw8821c.c
       rtw8822b_fw.bin   rtw8822c_table.h     util.c
coex.h           hci.h           Makefile      regd.h
rtw8821ce.c       rtw8822b.h        rtw8822c_wow_fw.bin  util.h
compiler.h       kernel_key.pem  openssl.conf  reg.h
rtw8821ce.h       rtw8822b_table.c  rx.c                 util.o
debug.c          key.pem         pci.c         rtw8723d.c
rtw8821c_fw.bin   rtw8822b_table.h  rx.h                 wow.c
debug.h          mac80211.c      pci.h         rtw8723de.c  rtw8821c.h
       rtw8822c.c        sch_generic.h        wow.h

cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw88$ =
make
make -C /lib/modules/5.4.0-42-generic/build
M=3D/home/cristian/Downloads/realtek_drivers/rtw88 modules
make1: Entering directory '/usr/src/linux-headers-5.4.0-42-generic'
  CC M  /home/cristian/Downloads/realtek_drivers/rtw88/main.o
/home/cristian/Downloads/realtek_drivers/rtw88/main.c: In function
rtw_core_init:
/home/cristian/Downloads/realtek_drivers/rtw88/main.c:1623:2: error:
implicit declaration of function tasklet_setup
-Werror=3Dimplicit-function-declaration
 1623   tasklet_setup(&rtwdev->tx_tasklet, rtw_tx_tasklet);

cc1: some warnings being treated as errors
make2: *** scripts/Makefile.build:275:
/home/cristian/Downloads/realtek_drivers/rtw88/main.o Error 1
make1: *** Makefile:1731: /home/cristian/Downloads/realtek_drivers/rtw88 Er=
ror 2
make1: Leaving directory '/usr/src/linux-headers-5.4.0-42-generic'
make: *** Makefile:79: all Error 2

cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw88$
sudo make install
sudo password for cristian:
make -C /lib/modules/5.4.0-42-generic/build
M=3D/home/cristian/Downloads/realtek_drivers/rtw88 modules
make1: Entering directory '/usr/src/linux-headers-5.4.0-42-generic'
  CC M  /home/cristian/Downloads/realtek_drivers/rtw88/main.o
/home/cristian/Downloads/realtek_drivers/rtw88/main.c: In function
rtw_core_init:
/home/cristian/Downloads/realtek_drivers/rtw88/main.c:1623:2: error:
implicit declaration of function tasklet_setup
-Werror=3Dimplicit-function-declaration
 1623 |  tasklet_setup(&rtwdev->tx_tasklet, rtw_tx_tasklet);

cc1: some warnings being treated as errors
make2: *** scripts/Makefile.build:275:
/home/cristian/Downloads/realtek_drivers/rtw88/main.o Error 1
make1: *** Makefile:1731: /home/cristian/Downloads/realtek_drivers/rtw88 Er=
ror 2
make1: Leaving directory '/usr/src/linux-headers-5.4.0-42-generic'
make: *** Makefile:79: all Error 2

cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw88$


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks, and greetings from Chile!



--
Cristian Llanos Montenegro
+56 9 9618 8576
