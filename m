Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADFE282178
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Oct 2020 06:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJCE4w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Oct 2020 00:56:52 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:63253 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJCE4v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Oct 2020 00:56:51 -0400
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id AFA9220000B1
        for <linux-wireless@vger.kernel.org>; Sat,  3 Oct 2020 04:56:47 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="nbDMEUAl"
Date:   Sat, 03 Oct 2020 04:56:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1601701004;
        bh=xeLKQq+tvnZyix1rDZWNt6pihNWvEJCGsNiZsWNlYao=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=nbDMEUAlkfuFzcfML/z08zJtKsGr+6U3lSiYFaLQH0tMRf7I7NK07yCAVJE09zB3d
         Kprtm9Osnz76hN3q/9Msd3wedEKHUgyscvFLv5WxS78jMs0MyWQloWQ7W39vXcNTPx
         j5JCsKqlGGLXSUeaJNlQCfVbNi8S4bU6enM9vLRs=
To:     "Coelho, Luciano" <luciano.coelho@intel.com>
From:   Connor Davis <connojd@protonmail.com>
Cc:     "jandryuk@gmail.com" <jandryuk@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Reply-To: Connor Davis <connojd@protonmail.com>
Subject: Re: [PATCH] iwlwifi: mvm: fix RFH_QUEUE_CONFIG_CMD bug
Message-ID: <dJMIsBuIobhyKuzlvGdL1LGpxU0d6fAJ5ygEGjHbS-Kt2qY4jsxo_RQyX7xMBtMqt-NUeKpEpYUXzEuu1GydH_AgKMtRGBoiqnahTBIM-9w=@protonmail.com>
In-Reply-To: <f3a689fbf9a958f9c853f663d245f3c2db6759a9.camel@intel.com>
References: <20200820012022.7504-1-connojd@protonmail.com> <CAKf6xpuFbFuLu864OoSHj0gV2Ba0kW-z0FkThmFw4jAV6jGxDQ@mail.gmail.com> <f3a689fbf9a958f9c853f663d245f3c2db6759a9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Friday, October 2, 2020 12:11 AM, Coelho, Luciano <luciano.coelho@intel.=
com> wrote:

> On Thu, 2020-10-01 at 09:25 -0400, Jason Andryuk wrote:
>
> > On Wed, Aug 19, 2020 at 9:28 PM Connor Davis connojd@protonmail.com wro=
te:
> >
> > > If iwl_configure_rxq is called when mvm->trans->num_rx_queues =3D=3D =
1,
> > > an RFH_QUEUE_CONFIG_CMD is sent with cmd->num_queues =3D=3D 0. This r=
esults
> > > in an error when the interface is brought up:
> > > [ 10.073760] iwlwifi 0000:3b:00.0: Applying debug destination EXTERNA=
L_DRAM
> > > [ 10.239723] iwlwifi 0000:3b:00.0: FW already configured (0) - re-con=
figuring
> > > [ 10.441592] iwlwifi 0000:3b:00.0: Microcode SW error detected. Resta=
rting 0x2000000.
> > > [ 10.442812] iwlwifi 0000:3b:00.0: Start IWL Error Log Dump:
> > > [ 10.442815] iwlwifi 0000:3b:00.0: Status: 0x00000040, count: 6
> > > [ 10.442817] iwlwifi 0000:3b:00.0: Loaded firmware version: 48.4fa004=
1f.0 cc-a0-48.ucode
> > > [ 10.442818] iwlwifi 0000:3b:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FA=
TAL
> > > [ 10.442820] iwlwifi 0000:3b:00.0: 0x000022F0 | trm_hw_status0
> > > [ 10.442821] iwlwifi 0000:3b:00.0: 0x00000000 | trm_hw_status1
> > > [ 10.442822] iwlwifi 0000:3b:00.0: 0x004F8E3C | branchlink2
> > > [ 10.442823] iwlwifi 0000:3b:00.0: 0x004E4FF4 | interruptlink1
> > > [ 10.442825] iwlwifi 0000:3b:00.0: 0x004E4FF4 | interruptlink2
> > > [ 10.442826] iwlwifi 0000:3b:00.0: 0x00016FF4 | data1
> > > [ 10.442827] iwlwifi 0000:3b:00.0: 0x00001000 | data2
> > > [ 10.442828] iwlwifi 0000:3b:00.0: 0xF0000008 | data3
> > > [ 10.442829] iwlwifi 0000:3b:00.0: 0x00000000 | beacon time
> > > [ 10.442831] iwlwifi 0000:3b:00.0: 0x00053105 | tsf low
> > > [ 10.442832] iwlwifi 0000:3b:00.0: 0x00000000 | tsf hi
> > > [ 10.442833] iwlwifi 0000:3b:00.0: 0x00000000 | time gp1
> > > [ 10.442834] iwlwifi 0000:3b:00.0: 0x00059A51 | time gp2
> > > [ 10.442835] iwlwifi 0000:3b:00.0: 0x00000001 | uCode revision type
> > > [ 10.442836] iwlwifi 0000:3b:00.0: 0x00000030 | uCode version major
> > > [ 10.442838] iwlwifi 0000:3b:00.0: 0x4FA0041F | uCode version minor
> > > [ 10.442839] iwlwifi 0000:3b:00.0: 0x00000340 | hw version
> > > [ 10.442840] iwlwifi 0000:3b:00.0: 0x18C89000 | board version
> > > [ 10.442841] iwlwifi 0000:3b:00.0: 0x801FF500 | hcmd
> > > [ 10.442842] iwlwifi 0000:3b:00.0: 0x00020000 | isr0
> > > [ 10.442843] iwlwifi 0000:3b:00.0: 0x00000000 | isr1
> > > [ 10.442845] iwlwifi 0000:3b:00.0: 0x08F00002 | isr2
> > > [ 10.442846] iwlwifi 0000:3b:00.0: 0x00C00008 | isr3
> > > [ 10.442847] iwlwifi 0000:3b:00.0: 0x00000000 | isr4
> > > [ 10.442848] iwlwifi 0000:3b:00.0: 0x000301D1 | last cmd Id
> > > [ 10.442849] iwlwifi 0000:3b:00.0: 0x00016FF4 | wait_event
> > > [ 10.442850] iwlwifi 0000:3b:00.0: 0x00000000 | l2p_control
> > > [ 10.442851] iwlwifi 0000:3b:00.0: 0x00000000 | l2p_duration
> > > [ 10.442852] iwlwifi 0000:3b:00.0: 0x00000000 | l2p_mhvalid
> > > [ 10.442853] iwlwifi 0000:3b:00.0: 0x00000000 | l2p_addr_match
> > > [ 10.442855] iwlwifi 0000:3b:00.0: 0x00000009 | lmpm_pmg_sel
> > > [ 10.442856] iwlwifi 0000:3b:00.0: 0x00000000 | timestamp
> > > [ 10.442857] iwlwifi 0000:3b:00.0: 0x00000828 | flow_handler
> > > [ 10.443452] iwlwifi 0000:3b:00.0: Start IWL Error Log Dump:
> > > [ 10.443453] iwlwifi 0000:3b:00.0: Status: 0x00000040, count: 7
> > > [ 10.443454] iwlwifi 0000:3b:00.0: 0x20000034 | NMI_INTERRUPT_WDG
> > > [ 10.443456] iwlwifi 0000:3b:00.0: 0x00000000 | umac branchlink1
> > > [ 10.443456] iwlwifi 0000:3b:00.0: 0xC008CC3C | umac branchlink2
> > > [ 10.443458] iwlwifi 0000:3b:00.0: 0x8048E6D8 | umac interruptlink1
> > > [ 10.443459] iwlwifi 0000:3b:00.0: 0x8048E6D8 | umac interruptlink2
> > > [ 10.443460] iwlwifi 0000:3b:00.0: 0x00000004 | umac data1
> > > [ 10.443461] iwlwifi 0000:3b:00.0: 0x8048E6D8 | umac data2
> > > [ 10.443462] iwlwifi 0000:3b:00.0: 0x00000000 | umac data3
> > > [ 10.443463] iwlwifi 0000:3b:00.0: 0x00000030 | umac major
> > > [ 10.443464] iwlwifi 0000:3b:00.0: 0x4FA0041F | umac minor
> > > [ 10.443465] iwlwifi 0000:3b:00.0: 0x00059A43 | frame pointer
> > > [ 10.443466] iwlwifi 0000:3b:00.0: 0xC0886A48 | stack pointer
> > > [ 10.443468] iwlwifi 0000:3b:00.0: 0x000B050D | last host cmd
> > > [ 10.443469] iwlwifi 0000:3b:00.0: 0x00000000 | isr status reg
> > > [ 10.443553] iwlwifi 0000:3b:00.0: Fseq Registers:
> > > [ 10.443605] iwlwifi 0000:3b:00.0: 0xE0000101 | FSEQ_ERROR_CODE
> > > [ 10.443657] iwlwifi 0000:3b:00.0: 0x00290011 | FSEQ_TOP_INIT_VERSION
> > > [ 10.443709] iwlwifi 0000:3b:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSI=
ON
> > > [ 10.443775] iwlwifi 0000:3b:00.0: 0x0000A503 | FSEQ_OTP_VERSION
> > > [ 10.443912] iwlwifi 0000:3b:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERS=
ION
> > > [ 10.443958] iwlwifi 0000:3b:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> > > [ 10.444011] iwlwifi 0000:3b:00.0: 0x00100530 | FSEQ_CNVI_ID
> > > [ 10.444062] iwlwifi 0000:3b:00.0: 0x00000532 | FSEQ_CNVR_ID
> > > [ 10.444113] iwlwifi 0000:3b:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
> > > [ 10.444166] iwlwifi 0000:3b:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
> > > [ 10.444220] iwlwifi 0000:3b:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_R=
EG_DIG_DCDC_VTRIM
> > > [ 10.444275] iwlwifi 0000:3b:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_R=
EG_ACTIVE_VDIG_MIRROR
> > > [ 10.445696] iwlwifi 0000:3b:00.0: Collecting data: trigger 2 fired.
> > > [ 10.445710] iwlwifi 0000:3b:00.0: FW error in SYNC CMD RFH_QUEUE_CON=
FIG_CMD
> > > [ 10.445873] iwlwifi 0000:3b:00.0: Failed to configure RX queues: -5
> > > that has been seen on several AX200/9462 devices running in a Xen HVM=
 domain
> > > with PCI passthrough [0][1]. It can also be seen natively with a Kill=
er AX1650x
> > > by coaxing the value of num_rx_queues to 1 in iwl_pcie_set_interrupt_=
capa.
> > > Fix this by returning early from iwl_configure_rxq whenever num_rx_qu=
eues is 1.
> > > [0] https://github.com/QubesOS/qubes-issues/issues/5616
> > > [1] https://lore.kernel.org/linux-wireless/3cab5072-17a2-4d9a-2077-93=
788971c6c4@invisiblethingslab.com/T/
> > > Signed-off-by: Connor Davis connojd@protonmail.com
> >
> > Tested-by: Jason Andryuk jandryuk@gmail.com
> > This should be CC Stable as well.
> > Thanks for fixing, Connor.
>
> Thanks for the patch!

No problem, it's my pleasure! Thanks for the review.

>
> Sorry for the delay in replying.
>
> We have a similar patch in our internal tree that is queued for
> upstreaming. It's probably too late to have it in v5.9, but we will
> apply it as soon as possible.
>
> --
> Cheers,
> Luca.

- Connor


