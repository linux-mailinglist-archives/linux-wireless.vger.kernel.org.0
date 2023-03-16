Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9546BC7CF
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Mar 2023 08:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCPHya (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Mar 2023 03:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCPHy2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Mar 2023 03:54:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FFDB1B04
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 00:54:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t15so642342wrz.7
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 00:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg.ch; s=google; t=1678953259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgZuAdhRwcKz6lm+w1PEG+RN/oJu+2kHqNZHdxvfxhk=;
        b=lfanzcUFpqUTmtUL9MBxhBcpwC+jL/Jbe2hECAciZsjjS699726M1dvf1jUB61XJwm
         tiLbjo5Q04KjuoXAD75c//W405d2Bn6Kgw0VP/RwNCOhjb6agw6Ctyz1IL3frFTaSrHG
         OkfA5L/O2dUsY6CLqzMVC9eTZHho8t6RPpaES5tvIcAQkGcbboRl0Ah1AlY6wScZgAGd
         /i7qZMpe0RdGaxUmZ9831RRuuBicYYqOFarLtGBKeavMr1+mh1bnEztIN/CNpWKiv70H
         TGZWSd88r8mGYRjZzzcsU+42hJz1Dnhmz6ypwGDWTZSfCkr18d+uuc2HGXyx7w+db7Kx
         TjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678953259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgZuAdhRwcKz6lm+w1PEG+RN/oJu+2kHqNZHdxvfxhk=;
        b=HFa3ZC//7ElvSz3ouRU1jN9756Z5X1/kgJjAp2HLXp2EM8DQtU6fi1n9ilwRxCY4gy
         Gkk6kbye+VPgF0k4yLj97OMLD7J53BpoLSkpmP+NI2Fav5NxkL3X/UqXzn76Qpsj4yOC
         42OG9nXKX3lMJ/a2goyhWeqc7XiC4OZuno3+i6I1CVusTZ/kNw7SYyRqr1zuyyMTx8UF
         XTiYRCFn7Tur4EZN3W2wb6dtKtLxC4NpiP7B2uXIy3+f5XFWG9cOtYuE3rxrPCnrkFhY
         nQq8WK0/Swz8fqqAL7UGpKX1l7JRQ+//ZmiEgbdbh0xoq0acvpKYRdfHjyXwmbzzMI8x
         UOJQ==
X-Gm-Message-State: AO0yUKW2JgsAuOmjLHDG/DQ2/c/dnj1FaWcqtOm//kTCjsIpfLdNMIVV
        kyLqgdBlR4AiNCKSeVEyNBMO3wyAZMOab2AR7d3MNw==
X-Google-Smtp-Source: AK7set8wwadA1bCSJbLs3bytVvewTs8MALNhX8yUQHHlS/pPSMtb7mtFrWdm2oNrj7ldtr6X/bUbjSYLO8pLduwIGdU=
X-Received: by 2002:adf:ff85:0:b0:2c7:1b1b:4f92 with SMTP id
 j5-20020adfff85000000b002c71b1b4f92mr1160672wrr.0.1678953259520; Thu, 16 Mar
 2023 00:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <CANnVG6=a3etRagG+RaSEH-b4_nfzxpEKffQtuMWrttrbgjunZQ@mail.gmail.com>
 <186e23b5668.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6kjWj02eEFv_OeLiRtjrJ6yn4EsELz_BtrzFHH15GNMLw@mail.gmail.com>
 <186e26dc0a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6n-eqKUQnX_6wncmjG1kyVfhxqs2L82xYQpDmGq89eVAQ@mail.gmail.com>
 <186e4673718.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6kaGj1SVCqf2y3=Xj_N2G9j+-VhLDN4_WY_ywDswNkO3g@mail.gmail.com>
 <89262772-7358-77e8-8913-c459819d544a@broadcom.com> <a459b9adc5eb7b67a432bd947d47d1df08718762.camel@sipsolutions.net>
 <f430c376-5992-d394-ce55-5994c793c7c7@broadcom.com> <CANnVG6neOX+Bgc3zWA8k=hwrifmXb=xBN95aMUEyJ=orz3+Wkg@mail.gmail.com>
 <186e9109ae8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <186e9109ae8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Thu, 16 Mar 2023 08:54:03 +0100
Message-ID: <CANnVG6kvP78+WADH+Z4Yk4k9m-rjwRw0qMprHNsngNaj-jpqJQ@mail.gmail.com>
Subject: Re: wifi breakage due to commit "wifi: brcmfmac: add support for
 vendor-specific firmware api"
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hmm, I=E2=80=99m not sure either.

My guess would be that the module loading happens only when actually
initializing the device,
not when merely loading the kernel module? At least I don=E2=80=99t see any
module-related errors in dmesg:

[    5.603264] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    5.612966] brcmfmac mmc1:0001:1: Direct firmware load for
brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.bin failed with
error -2
[    5.704359] Bluetooth: Core ver 2.22
[    5.708263] NET: Registered PF_BLUETOOTH protocol family
[    5.715884] Bluetooth: HCI device and connection manager initialized
[    5.722720] Bluetooth: HCI socket layer initialized
[    5.728316] Bluetooth: L2CAP socket layer initialized
[    5.733655] Bluetooth: SCO socket layer initialized
[    5.851351] Bluetooth: HCI UART driver ver 2.3
[    5.856653] Bluetooth: HCI UART protocol H4 registered
[    5.862449] Bluetooth: HCI UART protocol Broadcom registered
[    5.863571] hci_uart_bcm serial0-0: supply vbat not found, using
dummy regulator
[    5.878107] hci_uart_bcm serial0-0: supply vddio not found, using
dummy regulator
[    5.888944] brcmfmac_wcc: brcmf_wcc_attach: executing
[    5.912344] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Mar  2 2020 23:30:41 version 7.45.202 (r724630 CY) FWID
01-72f6ece2
[    6.006077] uart-pl011 3f201000.serial: no DMA platform data
[    6.246580] Bluetooth: hci0: BCM: chip id 107
[    6.251455] Bluetooth: hci0: BCM: features 0x2f
[    6.257631] Bluetooth: hci0: BCM4345C0
[    6.261481] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
[    6.267670] Bluetooth: hci0: BCM: firmware Patch file not found, tried:
[    6.274395] Bluetooth: hci0: BCM:
'brcm/BCM4345C0.raspberrypi,3-model-b-plus.hcd'
[    6.282062] Bluetooth: hci0: BCM: 'brcm/BCM4345C0.hcd'
[    6.287369] Bluetooth: hci0: BCM: 'brcm/BCM.raspberrypi,3-model-b-plus.h=
cd'
[    6.294496] Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
[    7.903878] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    9.926759] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready


On Thu, 16 Mar 2023 at 07:17, Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On March 15, 2023 8:53:50 PM Michael Stapelberg
> <michael+lkml@stapelberg.ch> wrote:
>
> > Hey Arend
> >
> > Thanks for looking into it.
> >
> > Your suspicion was spot on: we don=E2=80=99t have /sbin/modprobe (we do=
n=E2=80=99t
> > even have /sbin!)
> >
> > I addressed this issue by loading the brcmfmac-wcc module where we
> > also load the others:
> > https://github.com/gokrazy/wifi/commit/f611656338b68faa5f42bc2c8bbf1e02=
31a74a50
> >
> > I=E2=80=99m not entirely sure why I concluded in my earlier testing tha=
t
> > loading the module doesn=E2=80=99t help.
> > Perhaps the issue was that I was manually loading the module after the
> > wifi program
> > tried to use the interface already and had it fail its firmware load =
=E2=80=94
> > in either case,
> > loading brcmfmac-wcc from the wifi program seems to work fine.
>
> I was going to say it seems racy, but I am not sure why that works at all=
.
> In brcmf_fwvid_request_module it says:
>
>     ret =3D request_module("brcmfmac-%s", fwvid_list[fwvid].name);
>         if (ret)
>             goto fail;
>
> and the missing modprobe would always cause request_module() to fail (see
> [1]) hence the device probe would fail. What am I missing here?
>
> Regards,
> Arend
>
> [1] https://elixir.bootlin.com/linux/latest/source/kernel/kmod.c#L138
>
> >
> > I also realize that the error message gives a number of pointers once
> > you know how to interpret it:
> >
> > + brcmfmac: brcmf_fwvid_request_module: mod=3Dwcc: failed -2
> >
> > I now understand this was trying to tell me that
> > request_module("brcmfmac-wcc") failed
> > with error code -2 (ENOENT), which means that the kernel=E2=80=99s
> > request_module() function
> > could not find CONFIG_MODPROBE_PATH.
> >
> > For comparison, when the user space tool exists but fails, including
> > when it can=E2=80=99t find
> > the requested module (ENOENT), it always returns exit code 1:
> > https://salsa.debian.org/md/kmod/-/blob/7d761268ebb68245daf47167e418823=
c68c3eb98/tools/modprobe.c#L1025
> >
> > I think it would be nice if the Linux kernel could print a more
> > descriptive error message in this case.
> > I=E2=80=99m not sure what the kernel conventions are: should the caller=
 of
> > request_module() produce a good error message?
> > Ideally, the message would translate -2 into ENOENT, and mention the
> > name =E2=80=9Cbrcmfmac-wcc=E2=80=9D.
> >
> > Or maybe we could have a kconfig option to indicate there is no
> > CONFIG_MODPROBE_PATH,
> > and instead make any request_module() call fail loudly with a
> > descriptive error in dmesg?
> >
> > Thanks for considering
> > Best regards
> > Michael
> >
> > On Wed, 15 Mar 2023 at 11:11, Arend van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On 3/15/2023 10:57 AM, Johannes Berg wrote:
> >>> On Wed, 2023-03-15 at 10:12 +0100, Arend van Spriel wrote:
> >>>>
> >>>> I think it works pretty similar to firmware loading. These days firm=
ware
> >>>> loading does not rely on a user-space helper and I assumed the same =
is
> >>>> true for module loading. Will look into it.
> >>>
> >>> As far as I know you still need the modprobe helper in
> >>>
> >>> /proc/sys/kernel/modprobe
> >>
> >> Hi Michael,
> >>
> >> With hint from Johannes I found this Kconfig option:
> >>
> >> config MODPROBE_PATH
> >> string "Path to modprobe binary"
> >> default "/sbin/modprobe"
> >> help
> >> When kernel code requests a module, it does so by calling
> >> the "modprobe" userspace utility. This option allows you to
> >> set the path where that binary is found. This can be changed
> >> at runtime via the sysctl file
> >> /proc/sys/kernel/modprobe. Setting this to the empty string
> >> removes the kernel's ability to request modules (but
> >> userspace can still load modules explicitly).
> >>
> >> Now checking the .config that you sent it says:
> >>
> >> CONFIG_MODPROBE_PATH=3D"/sbin/modprobe"
> >>
> >> So my suspicion is that modprobe is not at that given location?
> >>
> >> Regards,
> >> Arend
>
>
>
