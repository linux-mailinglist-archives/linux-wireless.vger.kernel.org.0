Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8828421C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 23:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgJEV30 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 17:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJEV30 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 17:29:26 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4385C0613CE
        for <linux-wireless@vger.kernel.org>; Mon,  5 Oct 2020 14:29:24 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u17so4081899oie.3
        for <linux-wireless@vger.kernel.org>; Mon, 05 Oct 2020 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EiPX97/3Y9oFwQXyFEEPo7YOqLpiHiA+HZ7lNuRzSVk=;
        b=VQ8n9+w/1vozhLDKJLC8tjDjPEl2EPeBHpSKk0kx8gxepN579SCVLvVBljHc20YZ26
         ol1Mdo5PFh50BUO5eihWr4sdvkLz+lPCAriSXVOWlf+HizGcbEP/BI/Jt5W2FCnOlDQi
         dcA5yctGc9J0dJudLkhmHNe6rp5FGlTS/LeuCUHfqMd/NJLwBkB5gPFYgiZtgWnxUuYH
         9sVddPxW/qaeFXS4QhHPr9ImYFXS/NZ5aE9KC89RTAm0yp9RrzsYOpDbr3Dl8mVK2tlf
         O1riH4uDEcCcPXJk8GfKDCCWlSk90AXRbVaL9r/CFFL9j+46lVSCgHqbdw6IqtlyLE/a
         ao6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EiPX97/3Y9oFwQXyFEEPo7YOqLpiHiA+HZ7lNuRzSVk=;
        b=D9xwfJWXVdpUS9BiamIXovXPRfcWlPczrvQ3vR4nSAzP0m8R0Q7Gof2uGdLvIGPgkK
         YjDvAYzSl9NbplXQTd//Ut8QLxlcvq8GsyLDCtbS8KxnKrdu7TABD3i5ylxCmmKDSaB5
         6Pw5MZSrlN/ClrKzVKZT9P9GlLKkpv4Qu9TiM97ow+Yqktend1A0hT54PXUu9kEkkWzk
         FKsQwwXOo8bW3NmkUaxrAgndbLLEwf6knmrZF7gK0uxv1eBr3IVx6xdWFsu78FYS+8U6
         pu1QmWNB30BQ9wogGJCFL76kOcWnLc3MZknAtf1WtXP5uv+hV1TIh7yWSzdRWAGBxysN
         drAA==
X-Gm-Message-State: AOAM532LzDc6HOU9A5NAnv0QvBqbQXZD4HC8tSuoqPNBA9dqKc3eCk9+
        gFfWERtFV6lob5gVX6FRiHxR7ip8oqrAsrzTJh+lv8g7cnZzzA==
X-Google-Smtp-Source: ABdhPJwuyp+r+C58ZgVyCWWuQHviVOLRNuyWzau3vVbh8Cy5pJ97nW4c2wPxnWfCarIeOEzN2XYNRKHyvwJ9jgGI1Hs=
X-Received: by 2002:aca:1205:: with SMTP id 5mr872974ois.23.1601933364227;
 Mon, 05 Oct 2020 14:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <CANBg+yz2az1o9u7RDD6jwXCs=08u7izbmUOnkKJc2tnOQQCdog@mail.gmail.com>
 <97d78a81-b4fb-be83-5cb9-fa69575758c9@lwfinger.net>
In-Reply-To: <97d78a81-b4fb-be83-5cb9-fa69575758c9@lwfinger.net>
From:   Cristian Llanos <cristian.llanos@gmail.com>
Date:   Mon, 5 Oct 2020 18:28:46 -0300
Message-ID: <CANBg+yyyFhH7YA-RkU_pZQNn8hkcep=mWz_D+Y1m8w4ckzJtsg@mail.gmail.com>
Subject: Re: Error in driver for RTL8821CE
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry thanks a lot for your response, and you were right about the git
pull, the code worked just fine.

But i'm still unable to connect my laptop to the internet. I made:

$ git pull
$ make
$ sudo make install (everything ok!)
And then, reboot.

But now i go to  the Settings panel (Ubuntu 20.04.1 LTS) and i'm still
unable to connect.

Let me show you some logs:

=3D=3D=3D
$ lsmod | grep rtw
rtw_8821ce 16384 0
rtw_8821c 77824 1 rtw_8821ce
rtw_pci 24576 1 rtw_8821ce
rtw_core 167936 2 rtw_8821c,rtw_pci
mac80211 843776 2 rtw_core,rtw_pci
cfg80211 704512 2 rtw_core,mac80211


$ sudo lshw -C network
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

=3D=3D=3D


May I still need to do something else?

Thanks Larry for your time.


On Mon, Oct 5, 2020 at 5:46 PM Larry Finger <Larry.Finger@lwfinger.net> wro=
te:
>
> On 10/5/20 2:46 PM, Cristian Llanos wrote:
> > Hi, my name is Cristian, I'm writing from Chile
> >
> > I'm trying to install the driver for my RTL8821CE card. I'm following
> > the instructions from the repo https://github.com/lwfinger/rtw88 (I
> > took the email from there) but when I try to run the "make" command, I
> > get the following error:
> >
> > /home/cristian/Downloads/realtek_drivers/rtw88/main.c: In function
> > =E2=80=98rtw_core_init=E2=80=99:
> > /home/cristian/Downloads/realtek_drivers/rtw88/main.c:1623:2: error:
> > implicit declaration of function =E2=80=98tasklet_setup=E2=80=99
> > [-Werror=3Dimplicit-function-declaration]
> >   1623 |  tasklet_setup(&rtwdev->tx_tasklet, rtw_tx_tasklet);
> >
> >
> > this is the output from "sudo lshw -C network" and the full log of the =
error.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw=
88$
> > sudo lshw -C network
> >    *-network
> >         description: Ethernet interface
> >         product: RTL8111/8168/8411 PCI Express Gigabit Ethernet Control=
ler
> >         vendor: Realtek Semiconductor Co., Ltd.
> >         physical id: 0
> >         bus info: pci@0000:01:00.0
> >         logical name: enp1s0
> >         version: 15
> >         serial: 84:2a:fd:5a:7f:6e
> >         capacity: 1Gbit/s
> >         width: 64 bits
> >         clock: 33MHz
> >         capabilities: pm msi pciexpress msix bus_master cap_list
> > ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd
> > autonegotiation
> >         configuration: autonegotiation=3Don broadcast=3Dyes driver=3Dr8=
169
> > firmware=3Drtl8168h-2_0.0.2 02/26/15 latency=3D0 link=3Dno multicast=3D=
yes
> > port=3DMII
> >         resources: irq:19 ioport:4000(size=3D256)
> > memory:80504000-80504fff memory:80500000-80503fff
> >    *-network UNCLAIMED
> >         description: Network controller
> >         product: RTL8821CE 802.11ac PCIe Wireless Network Adapter
> >         vendor: Realtek Semiconductor Co., Ltd.
> >         physical id: 0
> >         bus info: pci@0000:02:00.0
> >         version: 00
> >         width: 64 bits
> >         clock: 33MHz
> >         capabilities: pm msi pciexpress cap_list
> >         configuration: latency=3D0
> >         resources: ioport:3000(size=3D256) memory:80400000-8040ffff
> > cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw=
88$
> >
> > cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw=
88$ ls
> > bf.c             debug.o         mac80211.o    phy.c
> > rtw8723de.h       rtw8821c_table.c  rtw8822ce.c          sec.c
> > bf.h             dkms.conf       mac.c         phy.h
> > rtw8723d_fw.bin   rtw8821c_table.h  rtw8822ce.h          sec.h
> > bitfield.h       efuse.c         mac.h         ps.c         rtw8723d.h
> >         rtw8822b.c        rtw8822c_fw.bin      sign-file
> > certificate.p12  efuse.h         main.c        ps.h
> > rtw8723d_table.c  rtw8822be.c       rtw8822c.h           tx.c
> > certificate.pem  fw.c            main.h        README.md
> > rtw8723d_table.h  rtw8822be.h       rtw8822c_table.c     tx.h
> > coex.c           fw.h            main.o        regd.c       rtw8821c.c
> >         rtw8822b_fw.bin   rtw8822c_table.h     util.c
> > coex.h           hci.h           Makefile      regd.h
> > rtw8821ce.c       rtw8822b.h        rtw8822c_wow_fw.bin  util.h
> > compiler.h       kernel_key.pem  openssl.conf  reg.h
> > rtw8821ce.h       rtw8822b_table.c  rx.c                 util.o
> > debug.c          key.pem         pci.c         rtw8723d.c
> > rtw8821c_fw.bin   rtw8822b_table.h  rx.h                 wow.c
> > debug.h          mac80211.c      pci.h         rtw8723de.c  rtw8821c.h
> >         rtw8822c.c        sch_generic.h        wow.h
> >
> > cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw=
88$ make
> > make -C /lib/modules/5.4.0-42-generic/build
> > M=3D/home/cristian/Downloads/realtek_drivers/rtw88 modules
> > make1: Entering directory '/usr/src/linux-headers-5.4.0-42-generic'
> >    CC M  /home/cristian/Downloads/realtek_drivers/rtw88/main.o
> > /home/cristian/Downloads/realtek_drivers/rtw88/main.c: In function
> > rtw_core_init:
> > /home/cristian/Downloads/realtek_drivers/rtw88/main.c:1623:2: error:
> > implicit declaration of function tasklet_setup
> > -Werror=3Dimplicit-function-declaration
> >   1623   tasklet_setup(&rtwdev->tx_tasklet, rtw_tx_tasklet);
> >
> > cc1: some warnings being treated as errors
> > make2: *** scripts/Makefile.build:275:
> > /home/cristian/Downloads/realtek_drivers/rtw88/main.o Error 1
> > make1: *** Makefile:1731: /home/cristian/Downloads/realtek_drivers/rtw8=
8 Error 2
> > make1: Leaving directory '/usr/src/linux-headers-5.4.0-42-generic'
> > make: *** Makefile:79: all Error 2
> >
> > cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw=
88$
> > sudo make install
> > sudo password for cristian:
> > make -C /lib/modules/5.4.0-42-generic/build
> > M=3D/home/cristian/Downloads/realtek_drivers/rtw88 modules
> > make1: Entering directory '/usr/src/linux-headers-5.4.0-42-generic'
> >    CC M  /home/cristian/Downloads/realtek_drivers/rtw88/main.o
> > /home/cristian/Downloads/realtek_drivers/rtw88/main.c: In function
> > rtw_core_init:
> > /home/cristian/Downloads/realtek_drivers/rtw88/main.c:1623:2: error:
> > implicit declaration of function tasklet_setup
> > -Werror=3Dimplicit-function-declaration
> >   1623 |  tasklet_setup(&rtwdev->tx_tasklet, rtw_tx_tasklet);
> >
> > cc1: some warnings being treated as errors
> > make2: *** scripts/Makefile.build:275:
> > /home/cristian/Downloads/realtek_drivers/rtw88/main.o Error 1
> > make1: *** Makefile:1731: /home/cristian/Downloads/realtek_drivers/rtw8=
8 Error 2
> > make1: Leaving directory '/usr/src/linux-headers-5.4.0-42-generic'
> > make: *** Makefile:79: all Error 2
> >
> > cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw=
88$
> >
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> You need to do a git pull. The missing tasklet_setup was fixed on Sep. 26=
.
>
> Larry
>


--=20
Cristian Llanos Montenegro
+56 9 9618 8576
