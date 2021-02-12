Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5231A0FD
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 15:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBLO5j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 09:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBLO5g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 09:57:36 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1A2C061574
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 06:56:56 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id n14so9575475iog.3
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 06:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vE6CcEMAfkSZ71OU4rtwxnEpyHTwtfTYK+kk2WOeqoE=;
        b=viEx77gtNORhxr5khoBMvnnOX7GpDvnHSS6ToFqdSEsv5B4nmFlRwkehZJ+xTjSRn2
         k0YEsshqNqs+kn5egMJKU7pRwsVxq3m+HzDbfls4QdKQwelycETHXU88vIZzATWtBVDd
         M1L3V3AUt1Jw8luARLzqaOTMSh/+qesG9RX1TaVEXMLZ0sZVdRmNGXrK3Gf7pss5vvoC
         do28xA3aD66uCmqvMI4mvE+XNJ3C2WgXiY6w7Csspqd0rQdgn1nU/7NUIOA4lYz/5GHc
         ljIuu6kK2JhDDkc/4xirunmDadQR0o6DgBOQRReg6+oyvMG0pVG6aXZNDvwSeKKRY8AC
         Ch+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vE6CcEMAfkSZ71OU4rtwxnEpyHTwtfTYK+kk2WOeqoE=;
        b=jT7ar4Cy4pxrUrNmoefOkNT0wCEHUMgFd/Cf5nEvebVTLFzCrU+ojyDNEC+rOBXXvQ
         ELpunWLpsF4pQqM3bP4muTzah6pGA+2Kz8cdayXleFImHN8+WdjTCAGaSmhU4tMUmJzS
         shJnVdww/KqH4X6E4dk4hHwcKSHkjPD3iZVZvuSUu7KDLr1h75Xn2Cuzl1UWxHnrc4mT
         dD+lDlwiUBiBoCXAbDhJexGEsDxs0/75UgVhw15Usob+9eaucSxiIbvaNlK7WHKKb2xP
         Yc7L461ApgCQ3l3o1saf3whWyfqTgFHPZuHw5UDzAuM7hUQGiwXAXs2jvzebqmRVcztK
         X1Pg==
X-Gm-Message-State: AOAM530rguEu3ZMhmmRpFlx2FIcF2isX0dVsSMt9sIfingPXJALqbald
        7aHioB34dBhzgskvZtRGXOz34L56gGveh4cnWhLm1IwV9gw=
X-Google-Smtp-Source: ABdhPJzpr+XoIKilUnyPdlcSETKSCUuiahk57PuLN5DE/1T9p7d2MiRtp7Dr+XdhXPB1ExlyXk+oUrcHNgLqmC+daSM=
X-Received: by 2002:a05:6638:2694:: with SMTP id o20mr3036089jat.132.1613141815670;
 Fri, 12 Feb 2021 06:56:55 -0800 (PST)
MIME-Version: 1.0
References: <badb5b55-2cfe-8514-b69c-38a4592f07a5@kernel.org>
 <582d5521f31a49e3518d15811ca7d5a79837a70e.camel@coelho.fi>
 <8c19a363-6701-750a-bd63-8b7a1db27a1d@kernel.org> <27a36edb-3b9b-de53-1b44-848579810a43@kernel.org>
 <CA+icZUVDw50xWbD1_zL59xqq6ExtEh6Mbrc7oSfbCQZOtHOGpw@mail.gmail.com> <2a3ca2d8-ac2d-9900-70a7-fa6884b5edb9@kernel.org>
In-Reply-To: <2a3ca2d8-ac2d-9900-70a7-fa6884b5edb9@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 12 Feb 2021 15:56:44 +0100
Message-ID: <CA+icZUVc3zLUMg=skV9mW9=R3hOwigjGVMBRqHhm83JTqrXghg@mail.gmail.com>
Subject: Re: Today's linux-next iwlwifi broken
To:     Heiner Kallweit <hkall@kernel.org>
Cc:     Josh Boyer <jwboyer@kernel.org>, Luca Coelho <luca@coelho.fi>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Feb 12, 2021 at 3:46 PM Heiner Kallweit <hkall@kernel.org> wrote:
>
> On 12.02.2021 15:38, Sedat Dilek wrote:
> > On Fri, Feb 12, 2021 at 3:15 PM Heiner Kallweit <hkall@kernel.org> wrot=
e:
> >>
> >> On 12.02.2021 13:21, Heiner Kallweit wrote:
> >>> On 11.02.2021 21:23, Luca Coelho wrote:
> >>>> On Thu, 2021-02-11 at 17:10 +0100, Heiner Kallweit wrote:
> >>>>> Today's linux-next has a bunch of issues, at least with my AX210 (0=
024) card.
> >>>>>
> >>>>> First I got a GPF in iwl_request_firmware(), cfg->fw_name_pre was i=
nvalid.
> >>>>> After some digging into it I found that 6f60fb03c8e7 ("iwlwifi: mov=
e SnJ
> >>>>> and So rules to the new tables") removed the entries for some cards=
.
> >>>>> Obviously 5febcdef3090 and 9b15596c5006 weren't synced with some pa=
rallel
> >>>>> development.
> >>>>> After adding the entry for 0024 I now get the following lockdep war=
ning.
> >>>>> Isn't there any regression testing with lockdep enabled?
> >>>>> Also warning "api flags index 2 larger than supported by driver" is=
 still
> >>>>> there, IIRC we talked about this weeks ago.
> >>>>>
> >>>>>
> >>>>> [    4.561774] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
> >>>>> [    4.630849] iwlwifi 0000:01:00.0: Direct firmware load for iwlwi=
fi-ty-a0-gf-a0-61.ucode failed with error -2
> >>>>> [    4.639817] iwlwifi 0000:01:00.0: api flags index 2 larger than =
supported by driver
> >>>>> [    4.640062] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Vers=
ion: 93.8.73.28
> >>>>> [    4.642138] iwlwifi 0000:01:00.0: loaded firmware version 60.84d=
9abea.0 ty-a0-gf-a0-60.ucode op_mode iwlmvm
> >>>>> [    4.760541] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX21=
0 160MHz, REV=3D0x420
> >>>>> [    4.942350] irq/131-iwlwifi/2094 just changed the state of lock:
> >>>>> [    4.942358] ffffa3fc07f080b0 (&rxq->lock){+.-.}-{2:2}, at: iwl_p=
cie_rx_handle+0x7c/0x8b0 [iwlwifi]
> >>>>> [    4.942504] 1 lock held by irq/131-iwlwifi/2094:
> >>>>> [    4.942511]  #0: ffffa3fc0855c170 (sync_cmd_lockdep_map){+.+.}-{=
0:0}, at: iwl_pcie_irq_rx_msix_handler+0x47/0x100 [iwlwifi]
> >>>>> [    4.943219]    _iwl_pcie_rx_init+0x208/0x6e0 [iwlwifi]
> >>>>> [    4.943242]    iwl_pcie_gen2_rx_init+0x20/0x30 [iwlwifi]
> >>>>> [    4.943264]    iwl_trans_pcie_gen2_start_fw+0x1e3/0x350 [iwlwifi=
]
> >>>>> [    4.943289]    iwl_mvm_load_ucode_wait_alive+0xfc/0x440 [iwlmvm]
> >>>>> [    4.943329]    iwl_run_unified_mvm_ucode+0xa5/0x250 [iwlmvm]
> >>>>> [    4.943360]    iwl_run_init_mvm_ucode+0x292/0x370 [iwlmvm]
> >>>>> [    4.943391]    iwl_op_mode_mvm_start+0x7f4/0xb60 [iwlmvm]
> >>>>> [    4.943424]    _iwl_op_mode_start.isra.0+0x42/0x80 [iwlwifi]
> >>>>> [    4.943446]    iwl_opmode_register+0x70/0xe0 [iwlwifi]
> >>>>> [    4.943467]    iwl_mvm_init+0x35/0x1000 [iwlmvm]
> >>>>> [    4.943588]                     _iwl_pcie_rx_init+0x140/0x6e0 [i=
wlwifi]
> >>>>> [    4.943612]                     iwl_pcie_gen2_rx_init+0x20/0x30 =
[iwlwifi]
> >>>>> [    4.943635]                     iwl_trans_pcie_gen2_start_fw+0x1=
e3/0x350 [iwlwifi]
> >>>>> [    4.943662]                     iwl_mvm_load_ucode_wait_alive+0x=
fc/0x440 [iwlmvm]
> >>>>> [    4.943695]                     iwl_run_unified_mvm_ucode+0xa5/0=
x250 [iwlmvm]
> >>>>> [    4.943728]                     iwl_run_init_mvm_ucode+0x292/0x3=
70 [iwlmvm]
> >>>>> [    4.943760]                     iwl_op_mode_mvm_start+0x7f4/0xb6=
0 [iwlmvm]
> >>>>> [    4.943793]                     _iwl_op_mode_start.isra.0+0x42/0=
x80 [iwlwifi]
> >>>>> [    4.943816]                     iwl_opmode_register+0x70/0xe0 [i=
wlwifi]
> >>>>> [    4.943838]                     iwl_mvm_init+0x35/0x1000 [iwlmvm=
]
> >>>>> [    4.943954]                     iwl_pcie_rx_handle+0x7c/0x8b0 [i=
wlwifi]
> >>>>> [    4.943978]                     iwl_pcie_napi_poll_msix+0x2a/0x9=
0 [iwlwifi]
> >>>>> [    4.944063]                     iwl_pcie_irq_rx_msix_handler+0xb=
c/0x100 [iwlwifi]
> >>>>> [    4.944147]                    _iwl_pcie_rx_init+0x140/0x6e0 [iw=
lwifi]
> >>>>> [    4.944170]                    iwl_pcie_gen2_rx_init+0x20/0x30 [=
iwlwifi]
> >>>>> [    4.944194]                    iwl_trans_pcie_gen2_start_fw+0x1e=
3/0x350 [iwlwifi]
> >>>>> [    4.944220]                    iwl_mvm_load_ucode_wait_alive+0xf=
c/0x440 [iwlmvm]
> >>>>> [    4.944255]                    iwl_run_unified_mvm_ucode+0xa5/0x=
250 [iwlmvm]
> >>>>> [    4.944287]                    iwl_run_init_mvm_ucode+0x292/0x37=
0 [iwlmvm]
> >>>>> [    4.944319]                    iwl_op_mode_mvm_start+0x7f4/0xb60=
 [iwlmvm]
> >>>>> [    4.944352]                    _iwl_op_mode_start.isra.0+0x42/0x=
80 [iwlwifi]
> >>>>> [    4.944375]                    iwl_opmode_register+0x70/0xe0 [iw=
lwifi]
> >>>>> [    4.944397]                    iwl_mvm_init+0x35/0x1000 [iwlmvm]
> >>>>> [    4.944493]  ... key      at: [<ffffffffc0c2e0c0>] __key.12+0x0/=
0xffffffffffff0f40 [iwlwifi]
> >>>>> [    4.944547]    iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
> >>>>> [    4.944569]    iwl_pcie_napi_poll_msix+0x2a/0x90 [iwlwifi]
> >>>>> [    4.944643]    iwl_pcie_irq_rx_msix_handler+0xbc/0x100 [iwlwifi]
> >>>>> [    4.944705] CPU: 0 PID: 2094 Comm: irq/131-iwlwifi Not tainted 5=
.11.0-rc7-next-20210211+ #1
> >>>>> [    4.944786]  ? iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
> >>>>> [    4.944825]  ? iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
> >>>>> [    4.944847]  iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
> >>>>> [    4.944878]  iwl_pcie_napi_poll_msix+0x2a/0x90 [iwlwifi]
> >>>>> [    4.944949]  ? iwl_pcie_irq_rx_msix_handler+0xab/0x100 [iwlwifi]
> >>>>> [    4.944981]  iwl_pcie_irq_rx_msix_handler+0xbc/0x100 [iwlwifi]
> >>>>
> >>>> Thanks for reporting!
> >>>>
> >>>> We made a bunch of fixes in this area and Kalle just pulled them to
> >>>> wireless-drivers-next.  I believe these changes will be in tomorrow'=
s
> >>>> linux-next.  Can you retry it then?
> >>>>
> >>> I tested today's linux-next:
> >>>
> >>> The lockdep warning is still there and occurs w/o any traffic on boot=
.
> >>> No CI machine on your side w/ lockdep enabled?
> >>>
> >>>
> >>> [    5.845931] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> [    5.845938] WARNING: possible irq lock inversion dependency detect=
ed
> >>> [    5.845946] 5.11.0-rc7-next-20210212+ #1 Not tainted
> >>> [    5.845954] ------------------------------------------------------=
--
> >>> [    5.845961] irq/131-iwlwifi/2132 just changed the state of lock:
> >>> [    5.845969] ffff8ca6c88600b0 (&rxq->lock){+.-.}-{2:2}, at: iwl_pci=
e_rx_handle+0x7c/0x8b0 [iwlwifi]
> >>> [    5.846011] but this lock took another, SOFTIRQ-unsafe lock in the=
 past:
> >>> [    5.846019]  (napi_hash_lock){+.+.}-{2:2}
> >>> [    5.846023]
> >>>
> >>>                and interrupts could create inverse lock ordering betw=
een them.
> >>>
> >>> [    5.846039]
> >>>                other info that might help us debug this:
> >>> [    5.846047]  Possible interrupt unsafe locking scenario:
> >>>
> >>> [    5.846055]        CPU0                    CPU1
> >>> [    5.846061]        ----                    ----
> >>> [    5.846066]   lock(napi_hash_lock);
> >>> [    5.846074]                                local_irq_disable();
> >>> [    5.846081]                                lock(&rxq->lock);
> >>> [    5.846090]                                lock(napi_hash_lock);
> >>> [    5.846099]   <Interrupt>
> >>> [    5.846103]     lock(&rxq->lock);
> >>> [    5.846110]
> >>>                 *** DEADLOCK ***
> >>>
> >>> "api flags index 2 larger than supported by driver" is also still the=
re
> >>>
> >>> 0024 AX210 version is now detected. When I disable the entry I don't =
get a GPF
> >>> any longer but a WARN() is triggered. Not sure why a WARN() was chose=
n because
> >>> the call trace provides no benefit here. More helpful would be a simp=
le
> >>> error message stating: "dev id foo: unknown dev sub id bar. Contact m=
aintainers."
> >>>
> >>>> --
> >>>> Cheers,
> >>>> Luca.
> >>>>
> >>> Heiner
> >>>
> >>
> >>
> >> One more comment, as I just wanted to upgrade my AX210 firmware versio=
n:
> >>
> >> Latest version in linux-firmware is 59. Seems you're at 62 already.
> >> And last but not least: The iwlwifi firmware pollutes the linux-firmwa=
re
> >> root directory. Wouldn't it be better to move all these firmware files
> >> to something like intel/iwlwifi ?
> >> Maybe for now you could leave symlinks in the root directory.
> >>
> >
> > I agree with Heiner, that's something I do/did/will not like: the
> > locations for firmware files.
> >
> > Here on Debian all firmware files are stored in "/lib/firmware"
> > directory - which should be plural "firmwares" IMHO.
> >
> > We already have a lot of directories for vendors like "intel",
> > "nvidia", "matrox", etc.
> >
> > If we move intel stuff around then please do it for intel-gfx stuff
> > like "i915" or ucodes like "intel-ucode".
> >
> > I vote to move all intel stuff into a single directory called "intel"
> > where we have sub-dirs:
> > intel > i915
> > intel > iwlwifi
> > intel > ucode (renamed from "intel-ucode")
> > intel > e100
> > ...
> >
> > But before doing any move - this should be done for all vendors.
> > See realtek, broadcom, amd (radeon-gfx), etc.
> > Means collect all firmware stuff for bluetooth, wlan, ethernet, gfx
> > etc. of a single vendor.
> >
> > If we do a cleanup then I vote to do this for all vendors?
> >
> > Dunno, who is the maintainer of linux-firmware.
> > Guess we need to change code in the Linux sources to say "load
> > firmware from </path/to/dirname>".
> > ( Should be one-liners. )
> >
> > For that request we should open a new thread.
> >
> > My =E2=82=AC0,99 (if I would be a good guy I have written =E2=82=AC1,00=
).
> >
> > - Sedat -
> >
>
> +Josh for linux-firmware

Thanks.

Some more ideas but cannot say this is more overhead than helpful:

<vendor_name>/<hw_cat_short>/<driver_name>

With hw_cat_short I mean:
"bth" short for bluetooth
"eth" short for ethernet
"wifi" for wireless-lan
"gfx" for graphics
etc.

If vendors have multiple wifi device "families" thinking of realtek for exa=
mple.

Some brainstorming...

Hey, I found one cent :-)...

- Sedat -
