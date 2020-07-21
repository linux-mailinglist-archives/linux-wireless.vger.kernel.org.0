Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA43227EB7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jul 2020 13:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgGULYl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jul 2020 07:24:41 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:21643 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbgGULYl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jul 2020 07:24:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595330679; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=E6L59/Ozc1QteuCwKkA3fDY1+jBQ6ETDFtphXkifNJc=; b=Nc5semkOnf0Uap5hxmN/fVUScvFutm5pBnUupc2IWdjBqk2cOCPjxKAJl2nOs2eoD7nsr4Wo
 4APWK2Mc/MXMjU3RkLpYTG61lBcUH+R9P9Xj+Lr15mB1IKwHLVQYLaZJL90U2TlgUVEBGZdz
 P46slsTNSNT1DypVeXckIqopCWA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f16d076eef925b694f11581 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Jul 2020 11:24:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 664D8C433CA; Tue, 21 Jul 2020 11:24:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from Pillair (unknown [183.83.71.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 221BEC433C6;
        Tue, 21 Jul 2020 11:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 221BEC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Peter Oh'" <peter.oh@eero.com>,
        "'Kalle Valo'" <kvalo@codeaurora.org>
Cc:     "'Brian Norris'" <briannorris@chromium.org>,
        "'Doug Anderson'" <dianders@chromium.org>,
        "'linux-wireless'" <linux-wireless@vger.kernel.org>,
        "'ath10k'" <ath10k@lists.infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org> <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com> <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com> <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com> <871rlcx8uv.fsf@codeaurora.org> <CALhWmc1PbTKhrkaPn9yfpx3gZHAMuR-bPY=4_o4wQHv_H5D9dA@mail.gmail.com> <CALhWmc3i9Z+KiG1cJNvpSWNsiFhOa5jBw=XfcFz_gKwi_5QibA@mail.gmail.com> <CALhWmc1B0+SONV6_AF+nUzgxZdekPD3sZuhrsmwVQx1Q-cgT_g@mail.gmail.com> <CALhWmc0qF5stKRcikjwbeFmE-32hNCDazgQdqTMidUyt7u-T1Q@mail.gmail.com> <CALhWmc0JtQZE5CfLPb1WnwhE9wCYsjE-53kYWbwtFCs1k7FrCQ@mail.gmail.com> <CALhWmc11OefTh6Ov5GqP-yHMVTUO4r9CxqkdHT1F3yzor72v7g@mail.gmail.com>
In-Reply-To: <CALhWmc11OefTh6Ov5GqP-yHMVTUO4r9CxqkdHT1F3yzor72v7g@mail.gmail.com>
Subject: RE: [PATCH] ath10k: Add interrupt summary based CE processing
Date:   Tue, 21 Jul 2020 16:54:30 +0530
Message-ID: <000201d65f51$83d2ac60$8b780520$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGA15dfEFvBa4XggNphJju/sylmMAM3+LYgASJJg3EBYf6DCAFrMZ6MAfh/wC4Dd031iAI67U4pAS1+lKUCgVu2AQJBeMaOqRbffQA=
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Peter Oh <peter.oh@eero.com>
> Sent: Tuesday, July 21, 2020 7:03 AM
> To: Kalle Valo <kvalo@codeaurora.org>
> Cc: Brian Norris <briannorris@chromium.org>; Doug Anderson
> <dianders@chromium.org>; linux-wireless <linux-
> wireless@vger.kernel.org>; Rakesh Pillai <pillair@codeaurora.org>; =
ath10k
> <ath10k@lists.infradead.org>; LKML <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
>=20
> I'll take my word back.
> It's not this patch problem, but by others.
> I have 2 extra patches before the 3 patches so my system looks like
>=20
> backports from ath.git 5.6-rc1 + linux kernel 4.4 (similar to OpenWrt)
> On top of the working system, I cherry-picked these 5.
>=20
> #1.
> ath10k: Avoid override CE5 configuration for QCA99X0 chipsets
> ath.git commit 521fc37be3d879561ca5ab42d64719cf94116af0
> #2.
> ath10k: Fix NULL pointer dereference in AHB device probe
> wireless-drivers.git commit 1cfd3426ef989b83fa6176490a38777057e57f6c
> #3.
> ath10k: Add interrupt summary based CE processing
> https://patchwork.kernel.org/patch/11628299/

Hi Peter,
This patch is applicable only for snoc target WCN3990, since there is a =
check for per_ce_irq.
For PCI targets, per_ce_irq is false, and hence follows a different =
path.

Thanks,
Rakesh Pillai.



> #4.
> ath10k: Keep track of which interrupts fired, don't poll them
> https://patchwork.kernel.org/patch/11654631/
> #5.
> ath10k: Get rid of "per_ce_irq" hw param
> https://patchwork.kernel.org/patch/11654633/
>=20
> The error "[  14.226184] ath10k_ahb a000000.wifi: failed to receive
> initialized event from target: 80000000" is because of #1 and #2,
> since this happens even after I reverted #3~#5.
> Once I reverted all except #1 I got another crash.
>=20
> [   11.179595] !#%&PageFault P<__ath10k_ce_rx_post_buf+0x14/0x98
> [ath10k_core]> L<0x4bc00> F<005> [0000000c]
> [   11.179643] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000c
> [   11.439207] [<7f15a69c>] (__ath10k_ce_rx_post_buf [ath10k_core])
> from [<7f15a874>] (ath10k_ce_rx_post_buf+0x3c/0x50 [ath10k_core])
> [   11.447204] [<7f15a874>] (ath10k_ce_rx_post_buf [ath10k_core]) from
> [<7f2889a4>] (ath10k_pci_diag_read_mem+0x104/0x2a8 [ath10k_pci])
> [   11.458706] [<7f2889a4>] (ath10k_pci_diag_read_mem [ath10k_pci])
> from [<7f288b68>] (ath10k_pci_diag_read32+0x1c/0x2c [ath10k_pci])
> [   11.470767] [<7f288b68>] (ath10k_pci_diag_read32 [ath10k_pci]) from
> [<7f28abe8>] (ath10k_pci_init_config+0x2c/0x290 [ath10k_pci])
> [   11.482314] [<7f28abe8>] (ath10k_pci_init_config [ath10k_pci]) from
> [<7f28d160>] (ath10k_ahb_hif_power_up+0x7c/0xe8 [ath10k_pci])
> [   11.494153] [<7f28d160>] (ath10k_ahb_hif_power_up [ath10k_pci])
> from [<7f135348>] (ath10k_core_register_work+0x84/0x8f8 [ath10k_core])
> [   11.505766] [<7f135348>] (ath10k_core_register_work [ath10k_core])
> from [<8023b614>] (process_one_work+0x1c0/0x2f8)
> [   11.517594] [<8023b614>] (process_one_work) from [<8023c650>]
> (worker_thread+0x280/0x3c0)
> [   11.527919] [<8023c650>] (worker_thread) from [<802408f8>]
> (kthread+0xd8/0xe8)
> [   11.536247] [<802408f8>] (kthread) from [<80209ce8>]
> (ret_from_fork+0x14/0x2c)
>=20
> When I revert #1 eventually, my system is back to working.
> So I'm blaming the #1 and #2 could have potential bugs or require
> ath.git branch up-to-date.
>=20
> On Mon, Jul 20, 2020 at 5:58 PM Peter Oh <peter.oh@eero.com> wrote:
> >
> > My previous email wasn't sent out.
> >
> > At first I gave these 3 patches.
> > ath10k: Add interrupt summary based CE processing
> >     https://patchwork.kernel.org/patch/11628299/
> > ath10k: Keep track of which interrupts fired, don't poll them
> >     https://patchwork.kernel.org/patch/11654631/
> > ath10k: Get rid of "per_ce_irq" hw param
> >     https://patchwork.kernel.org/patch/11654633/
> > and saw the crash happen and then reverted the top 2 and used the =
very
> > first one, but it is still happening.
> >
> > On Mon, Jul 20, 2020 at 5:56 PM Peter Oh <peter.oh@eero.com> wrote:
> > >
> > > Since IPQ4019 doesn't support per CE based interrupt summary, I =
doubt
> > > if this change is correct.
> > > +       ath10k_ce_engine_int_status_clear(ar, ctrl_addr,
> > > +                                         wm_regs->cc_mask | =
wm_regs->wm_mask);
> > >
> > >
> > > On Mon, Jul 20, 2020 at 5:53 PM Peter Oh <peter.oh@eero.com> =
wrote:
> > > >
> > > > At first I gave these 3 patches.
> > > > ath10k: Add interrupt summary based CE processing
> > > >     https://patchwork.kernel.org/patch/11628299/
> > > > ath10k: Keep track of which interrupts fired, don't poll them
> > > >     https://patchwork.kernel.org/patch/11654631/
> > > > ath10k: Get rid of "per_ce_irq" hw param
> > > >     https://patchwork.kernel.org/patch/11654633/
> > > > and saw the crash happen and then reverted the top 2 and used =
the
> very first one, but it is still happening.
> > > >
> > > >
> > > >
> > > > On Mon, Jul 20, 2020 at 5:43 PM Peter Oh <peter.oh@eero.com>
> wrote:
> > > >>
> > > >> I've run 3 units and one of them happens the problem always =
while
> the
> > > >> other 2 are barely happening.
> > > >>
> > > >> On Mon, Jul 20, 2020 at 5:33 PM Peter Oh <peter.oh@eero.com>
> wrote:
> > > >> >
> > > >> > I'm getting this panic on IPQ4019 system after cherry-picked =
this
> > > >> > single patch on top of working system.
> > > >> >
> > > >> > [   14.226184] ath10k_ahb a000000.wifi: failed to receive =
initialized
> > > >> > event from target: 80000000
> > > >> > [   14.326406] !#%&PageFault P<find_dr+0x28/0x64>
> > > >> > L<devres_remove+0x38/0x70> F<005> [00000008]
> > > >> > [   14.326447] Unable to handle kernel NULL pointer =
dereference at
> > > >> > virtual address 00000008
> > > >> > [   14.333569] pgd =3D 80cac000
> > > >> > [   14.341892] [00000008] *pgd=3D00000000
> > > >> > [   14.347804] !#%&Abort P<find_dr+0x28/0x64>
> > > >> > L<devres_remove+0x38/0x70> F<005> FILE<PageFault>
> > > >> > [   14.348067] Internal error: PageFault: 5 [#1] PREEMPT SMP =
ARM
> > > >> > [   14.356568] Modules linked in: ath10k_pci(+) ecm =
shortcut_fe_drv
> > > >> > shortcut_fe ath10k_core ath mac80211 cfg80211 compat
> > > >> > [   14.372537] CPU: 3 PID: 301 Comm: systemd-modules Not =
tainted
> > > >> > 4.4.60-yocto-standard-eero #1
> > > >> > [   14.372805] Hardware name: Qualcomm (Flattened Device =
Tree)
> > > >> > [   14.380961] task: 9b492300 ti: 9d3f0000 task.ti: 9d3f0000
> > > >> > [   14.386516] PC is at find_dr+0x28/0x64
> > > >> > [   14.392069] LR is at devres_remove+0x38/0x70
> > > >> > [   14.395720] pc : [<804aa498>]    lr : [<804aa564>]    psr: =
00010193
> > > >> > [   14.395720] sp : 9d3f7cc8  ip : 00000000  fp : 7f18b380
> > > >> > [   14.400155] r10: 9d995610  r9 : 9b73db64  r8 : 9b740b00
> > > >> > [   14.411343] r7 : 80430990  r6 : 8043097c  r5 : 9b73da10  =
r4 : 00000000
> > > >> > [   14.416554] r3 : 9b740b00  r2 : 8043097c  r1 : 80430990  =
r0 : 9b73da10
> > > >> > [   14.423153] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  =
ISA ARM
> > > >> > Segment user
> > > >> > [   14.429663] Control: 10c5387d  Table: 80cac06a  DAC: =
00000055
> > > >> > [   14.436865] Process systemd-modules (pid: 301, stack limit =
=3D
> 0x9d3f0210)
> > > >> > [   14.442683] Stack: (0x9d3f7cc8 to 0x9d3f8000)
> > > >> > [   14.449455] 7cc0:                   9b73da10 a0010113 =
80430990
> > > >> > 8043097c 9b740b00 9b73db60
> > > >> > [   14.453716] 7ce0: 9d995610 804aa564 9b740b00 9dbd1f20 =
9d995600
> > > >> > 9d995600 ffffff92 00000000
> > > >> > [   14.461876] 7d00: 9d995610 804aac4c 9b740b00 80430a94 =
9dbd5f20
> > > >> > 7f28c584 9dbd5f20 7f28cf28
> > > >> > [   14.470035] 7d20: 7f28f3b2 9dbd1f20 00000001 9cae5960 =
9d9a16e0
> > > >> > 00000000 00000000 00000000
> > > >> > [   14.478196] 7d40: 8162d420 7f28c9d4 9d995610 7f28fb94 =
8162d42c
> > > >> > 815a59e0 8162d420 00000003
> > > >> > [   14.486355] 7d60: 9d3f7f54 804a96cc 9d995610 00000000 =
7f28fb94
> > > >> > 804a7df8 7f28fb94 9d995610
> > > >> > [   14.494516] 7d80: 9d995610 7f28fb94 9d995644 815d8400 =
00000000
> > > >> > 0000001c 9cae60c8 804a7f9c
> > > >> > [   14.502675] 7da0: 00000000 7f28fb94 804a7f50 804a62c0 =
9d81fc5c
> > > >> > 9d9f6634 7f28fb94 9b739a00
> > > >> > [   14.510834] 7dc0: 815a5908 804a7344 7f28f3b2 7f28f3b3 =
7f28fb94
> > > >> > 7f293000 00000000 815b6d48
> > > >> > [   14.518995] 7de0: 815b6d48 804a87a4 9cae61c0 7f293000 =
00000000
> > > >> > 7f28d2e8 9cae61c0 7f29300c
> > > >> > [   14.527153] 7e00: 9cae61c0 80213468 0018bce1 00000001 =
8040003f
> > > >> > 802b19d0 9e34ea98 00000000
> > > >> > [   14.535315] 7e20: 9e34eaa8 9e34ea98 8040003e 9e34e8a0
> 9e34e8a0
> > > >> > 9bae8100 9d3f0000 9d801e40
> > > >> > [   14.543474] 7e40: 00004eb1 9e34e8a0 9bae8080 9d3f0000 =
81621200
> > > >> > 7f28fc00 00000001 81599848
> > > >> > [   14.551632] 7e60: 7f28fc00 00000001 9cae6180 7f28fc48 =
00000001
> > > >> > 80287704 7f28fc00 9e34e8a0
> > > >> > [   14.559793] 7e80: 7f28fc00 00000001 9cae60c0 80289298 =
7f28fc0c
> > > >> > 00007fff 7f28fc00 80286a58
> > > >> > [   14.567952] 7ea0: 00000000 815998c4 a13e1138 7f293100 =
a13dba30
> > > >> > 8088bd0c 7f28fdc4 76cea5cc
> > > >> > [   14.576112] 7ec0: 9d3f7f54 802861d4 00000000 00000000 =
00000000
> > > >> > 00000000 00000000 00000000
> > > >> > [   14.584269] 7ee0: 6e72656b 00006c65 00000000 00000000 =
00000000
> > > >> > 00000000 00000000 00000000
> > > >> > [   14.592430] 7f00: 00000000 00000000 00000000 00000000 =
00000000
> > > >> > 00000000 00000000 81599848
> > > >> > [   14.600590] 7f20: 00000000 00000000 76cea5cc 00000008 =
0000017b
> > > >> > 80209de4 9d3f0000 00000000
> > > >> > [   14.608751] 7f40: 00000000 80289594 9d3f0000 00000000 =
7e85fbbc
> > > >> > a13d4000 0000d1b0 a13e0b48
> > > >> > [   14.616911] 7f60: a13e09ac a13dd590 00007e08 00008ca8 =
00000000
> > > >> > 00000000 00000000 0000313c
> > > >> > [   14.625070] 7f80: 00000026 00000027 0000001d 00000000 =
00000016
> > > >> > 00000000 00000000 00000000
> > > >> > [   14.633230] 7fa0: 5654ca48 80209c40 00000000 00000000 =
00000008
> > > >> > 76cea5cc 00000000 00000000
> > > >> > [   14.641390] 7fc0: 00000000 00000000 5654ca48 0000017b =
00000000
> > > >> > 00000001 76ea754f 00000000
> > > >> > [   14.649549] 7fe0: 7e85fbc0 7e85fbb0 76ce281c 76c6b830 =
600f0010
> > > >> > 00000008 00000000 00000000
> > > >> > [   14.657717] [<804aa498>] (find_dr) from [<804aa564>]
> > > >> > (devres_remove+0x38/0x70)
> > > >> > [   14.665868] [<804aa564>] (devres_remove) from [<804aac4c>]
> > > >> > (devres_destroy+0x8/0x24)
> > > >> > [   14.672989] [<804aac4c>] (devres_destroy) from =
[<80430a94>]
> > > >> > (devm_iounmap+0x18/0x44)
> > > >> > [   14.680927] [<80430a94>] (devm_iounmap) from [<7f28c584>]
> > > >> > (ath10k_ahb_resource_deinit+0x20/0x74 [ath10k_pci])
> > > >> > [   14.688671] [<7f28c584>] (ath10k_ahb_resource_deinit
> [ath10k_pci])
> > > >> > from [<7f28cf28>] (ath10k_ahb_probe+0x554/0x6f4 [ath10k_pci])
> > > >> > [   14.698454] [<7f28cf28>] (ath10k_ahb_probe [ath10k_pci]) =
from
> > > >> > [<804a96cc>] (platform_drv_probe+0x50/0x9c)
> > > >> > [   14.710061] [<804a96cc>] (platform_drv_probe) from =
[<804a7df8>]
> > > >> > (driver_probe_device+0x2ac/0x404)
> > > >> > [   14.719520] [<804a7df8>] (driver_probe_device) from
> [<804a7f9c>]
> > > >> > (__driver_attach+0x4c/0x8c)
> > > >> > [   14.728374] [<804a7f9c>] (__driver_attach) from =
[<804a62c0>]
> > > >> > (bus_for_each_dev+0x7c/0x8c)
> > > >> > [   14.736880] [<804a62c0>] (bus_for_each_dev) from =
[<804a7344>]
> > > >> > (bus_add_driver+0x1b4/0x234)
> > > >> > [   14.744952] [<804a7344>] (bus_add_driver) from =
[<804a87a4>]
> > > >> > (driver_register+0xa0/0xe0)
> > > >> > [   14.753136] [<804a87a4>] (driver_register) from =
[<7f28d2e8>]
> > > >> > (ath10k_ahb_init+0x10/0x38 [ath10k_pci])
> > > >> > [   14.761061] [<7f28d2e8>] (ath10k_ahb_init [ath10k_pci]) =
from
> > > >> > [<7f29300c>] (__init_backport+0xc/0x100 [ath10k_pci])
> > > >> > [   14.770418] [<7f29300c>] (__init_backport [ath10k_pci]) =
from
> > > >> > [<80213468>] (do_one_initcall+0x1c4/0x20c)
> > > >> > [   14.780633] [<80213468>] (do_one_initcall) from =
[<80287704>]
> > > >> > (do_init_module+0x54/0x1ac)
> > > >> > [   14.789916] [<80287704>] (do_init_module) from =
[<80289298>]
> > > >> > (load_module+0x19e0/0x1b04)
> > > >> > [   14.798249] [<80289298>] (load_module) from [<80289594>]
> > > >> > (SyS_finit_module+0x8c/0x9c)
> > > >> > [   14.805975] [<80289594>] (SyS_finit_module) from =
[<80209c40>]
> > > >> > (ret_fast_syscall+0x0/0x34)
> > > >> > [   14.813959] Code: e1a08003 e1540009 03a04000 0a00000c
> (e5943008)
> > > >> > [   14.822108] ---[ end trace f4da008c1c165fb3 ]---
> > > >> > [   14.830623] Kernel panic - not syncing: Fatal exception
> > > >> > [   14.832876] CPU1: stopping
> > > >> > [   14.837820] CPU: 1 PID: 343 Comm: rngd Tainted: G      D
> > > >> > 4.4.60-yocto-standard-eero #1
> > > >> > [   14.840601] Hardware name: Qualcomm (Flattened Device =
Tree)
> > > >> > [   14.849210] [<8021ed7c>] (unwind_backtrace) from =
[<8021b730>]
> > > >> > (show_stack+0x10/0x14)
> > > >> > [   14.854672] [<8021b730>] (show_stack) from [<8041b8dc>]
> > > >> > (dump_stack+0x7c/0x98)
> > > >> > [   14.862658] [<8041b8dc>] (dump_stack) from [<8021dfc8>]
> > > >> > (handle_IPI+0xdc/0x164)
> > > >> > [   14.869688] [<8021dfc8>] (handle_IPI) from [<802093e8>]
> > > >> > (gic_handle_irq+0x80/0x8c)
> > > >> > [   14.876893] [<802093e8>] (gic_handle_irq) from =
[<8020a844>]
> > > >> > (__irq_usr+0x44/0x60)
> > > >> > [   14.884524] Exception stack(0x9beaffb0 to 0x9beafff8)
> > > >> > [   14.892076] ffa0:                                     =
0c27987c
> > > >> > 40016b9f 0c27987d 0000001f
> > > >> > [   14.897118] ffc0: 00000001 763fedbc 565a344c 54b3de80 =
54b3e50c
> > > >> > 00000001 7e817c00 763fed0c
> > > >> > [   14.905277] ffe0: fffffffe 763fecc0 00000018 76ec3e18 =
30010010
> ffffffff
> > > >> > [   14.913430] CPU2: stopping
> > > >> > [   14.919849] CPU: 2 PID: 344 Comm: rngd Tainted: G      D
> > > >> > 4.4.60-yocto-standard-eero #1
> > > >> > [   14.922631] Hardware name: Qualcomm (Flattened Device =
Tree)
> > > >> > [   14.931236] [<8021ed7c>] (unwind_backtrace) from =
[<8021b730>]
> > > >> > (show_stack+0x10/0x14)
> > > >> > [   14.936703] [<8021b730>] (show_stack) from [<8041b8dc>]
> > > >> > (dump_stack+0x7c/0x98)
> > > >> > [   14.944688] [<8041b8dc>] (dump_stack) from [<8021dfc8>]
> > > >> > (handle_IPI+0xdc/0x164)
> > > >> > [   14.951719] [<8021dfc8>] (handle_IPI) from [<802093e8>]
> > > >> > (gic_handle_irq+0x80/0x8c)
> > > >> > [   14.958924] [<802093e8>] (gic_handle_irq) from =
[<8020a844>]
> > > >> > (__irq_usr+0x44/0x60)
> > > >> > [   14.966554] Exception stack(0x9beb7fb0 to 0x9beb7ff8)
> > > >> > [   14.974107] 7fa0:                                     =
fffffff7
> > > >> > 00000017 a6000000 0000014a
> > > >> > [   14.979150] 7fc0: 00000002 759fedbc 565a3470 54b3de80 =
54b3e50c
> > > >> > 00000001 7e817c00 759fed0c
> > > >> > [   14.987307] 7fe0: 00000009 759fecc0 00000018 76ec3cdc =
80010010
> ffffffff
> > > >> > [   14.995461] CPU0: stopping
> > > >> > [   15.001882] CPU: 0 PID: 341 Comm: rngd Tainted: G      D
> > > >> > 4.4.60-yocto-standard-eero #1
> > > >> > [   15.004663] Hardware name: Qualcomm (Flattened Device =
Tree)
> > > >> > [   15.013267] [<8021ed7c>] (unwind_backtrace) from =
[<8021b730>]
> > > >> > (show_stack+0x10/0x14)
> > > >> > [   15.018734] [<8021b730>] (show_stack) from [<8041b8dc>]
> > > >> > (dump_stack+0x7c/0x98)
> > > >> > [   15.026719] [<8041b8dc>] (dump_stack) from [<8021dfc8>]
> > > >> > (handle_IPI+0xdc/0x164)
> > > >> > [   15.033752] [<8021dfc8>] (handle_IPI) from [<802093e8>]
> > > >> > (gic_handle_irq+0x80/0x8c)
> > > >> > [   15.040955] [<802093e8>] (gic_handle_irq) from =
[<8020a844>]
> > > >> > (__irq_usr+0x44/0x60)
> > > >> > [   15.048585] Exception stack(0x9be87fb0 to 0x9be87ff8)
> > > >> > [   15.056139] 7fa0:                                     =
00000000
> > > >> > 00000000 a7e3391d 6a11d866
> > > >> > [   15.061181] 7fc0: 00000000 76d15dbc 565a3428 54b3de80 =
54b3e50c
> > > >> > 00000001 7e817c00 76d15d0c
> > > >> > [   15.069339] 7fe0: ffffffeb 76d15cc0 00000018 76ec3d60 =
80010010
> ffffffff
> > > >> > [   15.091080] Rebooting in 5 seconds..
> > > >> >
> > > >> >
> > > >> > On Wed, Jul 15, 2020 at 11:39 PM Kalle Valo
> <kvalo@codeaurora.org> wrote:
> > > >> > >
> > > >> > > Brian Norris <briannorris@chromium.org> writes:
> > > >> > >
> > > >> > > > On Fri, Jun 26, 2020 at 2:49 PM Doug Anderson
> <dianders@chromium.org> wrote:
> > > >> > > >> I should also note that, while I'm not terribly familiar =
with Kalle's
> > > >> > > >> workflow, I would have expected to see him in the "To:" =
list.
> I've
> > > >> > > >> added him, but it's possible he'll need you to repost =
the patch
> with
> > > >> > > >> him in the "To:" list.
> > > >> > > >
> > > >> > > >
> =
https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches#who_to_address
> > > >> > > >
> =
https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatche=
s
> > > >> > > >
> > > >> > > > Patchwork is his patch queue, so I don't think you need =
to
> address him directly.
> > > >> > >
> > > >> > > Yup, I take all patches from patchwork so no need to Cc me.
> > > >> > >
> > > >> > > --
> > > >> > >
> =
https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches

