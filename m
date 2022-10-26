Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27D660E6A4
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Oct 2022 19:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiJZRhb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 13:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiJZRh3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 13:37:29 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3A336870
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 10:37:26 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MyGGX4lgszMqFt4;
        Wed, 26 Oct 2022 19:37:24 +0200 (CEST)
Received: from [127.0.0.1] (unknown [10.92.209.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MyGGX2XmgzxL;
        Wed, 26 Oct 2022 19:37:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fls.name; s=20200831;
        t=1666805844; bh=NBO15QEKnGxMsn4nRbL72WCvOJlop5myta5GZDCyP4I=;
        h=Date:Subject:From:Reply-To:To:References:In-Reply-To:From;
        b=TWfmIaK/b6sehVQ96sDhiUiSe3pAymljiqnQjhuKOa3uh7GAOyf5YI+VWcgaX8Nbi
         BXmhuSmXLOF2vPdeBB9NRLaXHsxCRLcKBCBrns8hqU67d/9POciiMN2rBr4ZejQ5G2
         syhLcJOgbj6yX75v39E0hJJDk0TukGietmkarSU8=
Message-ID: <79d2434a0160d0c9b677b8144459beca@mail.infomaniak.com>
Date:   Wed, 26 Oct 2022 19:37:24 +0200
Subject: Re: iwlwifi: intel ax210: module fail load firmware: Failed to start
 RT ucode: -110
From:   Florian Schmidt <florian@fls.name>
Reply-To: Florian Schmidt <florian@fls.name>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Greenman Gregory <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6IkhKNEZFUStJWUp1NzhJOUVyU0dNaVE9PSIsInZhbHVlIjoiME1KbGtXWUY5ZllrcWNvZnJJdXY3QT09IiwibWFjIjoiZTM5ZjdmMGY3MDAxNWJjODNjOTNiNWYyYmMwMmFkN2FjZWM4MmZhYTc1NDYyOTBkODllOTI1YTY1ZmI5Yjk5MSIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6Im9rdWFRL1lFUWY0azNvWWFOSStiUXc9PSIsInZhbHVlIjoiajBtYkJWNmdBU3ZhaUl2MEN0c1hwZz09IiwibWFjIjoiMWQ3MjFkNWI3M2Q2NzM5NTRlMzQ4ZWYwMTliNDhlMWZlNDlkYjEyZGNkYmVmZTViMzUxNGY4ZDk0NDQ1NTQzNiIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.388)
References: <91cad7f52fe275bf567cf5aa7aa6f7c0@mail.infomaniak.com>
 <28dfa897c38286b1cf9ae30631fb7438@mail.infomaniak.com>
 <59fe5bdc361fed71103ee159cdb5ab64@mail.infomaniak.com>
 <f351b0a31b536e7a29d63937a242d5de7e2552ca.camel@intel.com>
 <4077a7705bb86501a9cbbce86fe1ea8c@mail.infomaniak.com>
 <cba07be4-1afc-649f-a172-19f76d726232@gmail.com>
In-Reply-To: <cba07be4-1afc-649f-a172-19f76d726232@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022-10-26T18:04:33.000+01:00, Florian Fainelli <f.fainelli@gmail.com> w=
rote:

>  On 10/26/2022 8:56 AM, Florian Schmidt wrote:
>=20
> >    Hi Gregory,
> > =20
> >  Thank you for having a look at this. The .pnvm file was present in my =
test as shown by my original message:
> >=20
> > >    md5sum /lib/firmware/*
> > >  787381c60d907f81a3ddadc5c990a82b ./iwlwifi-ty-a0-gf-a0-71.ucode
> > >  d93cbdcc4bb5be69aac128e2fe291359 ./iwlwifi-ty-a0-gf-a0.pnvm
> > >  33d13d236512466e71c81257209a356f ./regulatory.db
> >  =20
> >  I just ran the test again, ensuring I have the .pnvm you mention and t=
he result is indeed the same.
> > =20
> >  Any other ideas to solve this are welcome.
> =20
> The driver indicated it wanted to load iwlwifi-ty-a0-gf-a0-72.ucode,=20
> which you do seem to have based upon the listing above?
> --=20
> Florian

Hi Florian,

Indeed, my first log seems to load -72.ucode when my dump show a -71 file, =
that's strange. I must have mismatched some test, sorry for the confusion. =
During my tests, I've actually tried with many different firmwares (I think=
 I've done all the compatible firmware I could find), tested both with and =
without the pnvm file and many kernel versions, it always seems to fail. Th=
e suspicious thing to me is that during my tests, I've confirmed several ti=
mes that the same sets of wifi card, kernel and firmware work well on my in=
tel desktop.

Below are the logs from my latest test today with firmware -71 and the .pnv=
m from git.

I'd be happy to help debug more, but I have zero visibility on the firmware=
 so those register dumps just mean nothing to me. Let me know how I can ass=
ist with this.

Florian
-------

root@BV1-27109:/lib/firmware# md5sum /lib/firmware/*
787381c60d907f81a3ddadc5c990a82b  /lib/firmware/iwlwifi-ty-a0-gf-a0-71.ucod=
e
d93cbdcc4bb5be69aac128e2fe291359  /lib/firmware/iwlwifi-ty-a0-gf-a0.pnvm
33d13d236512466e71c81257209a356f  /lib/firmware/regulatory.db

Linux BV1-27109 6.0.1-xilinx #1 SMP PREEMPT Wed Oct 12 09:15:44 UTC 2022 ar=
mv7l GNU/Linux

pci 0000:01:00.0: [8086:2725] type 00 class 0x028000
pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:00.0: BAR 8: assigned [mem 0x80000000-0x800fffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0x80000000-0x80003fff 64bit]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0x80000000-0x800fffff]
Intel(R) Wireless WiFi driver for Linux
pci 0000:00:00.0: enabling device (0140 -> 0142)
iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-72.ucode=
 failed with error -2
iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.36
iwlwifi 0000:01:00.0: loaded firmware version 71.058653f6.0 ty-a0-gf-a0-71.=
ucode  op_mode iwlmvm
iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=3D0x420
thermal thermal_zone0: failed to read out thermal zone (-61)
iwlwifi 0000:01:00.0: loaded PNVM version a982b33e
iwlwifi 0000:01:00.0: Timeout waiting for PNVM load!
iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired (delay=3D0=
ms).
iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-a0-71=
.ucode
iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0
iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:01:00.0: 0x004DAEA2 | branchlink2
iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink1
iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink2
iwlwifi 0000:01:00.0: 0x004D9C78 | data1
iwlwifi 0000:01:00.0: 0x01000000 | data2
iwlwifi 0000:01:00.0: 0x00000000 | data3
iwlwifi 0000:01:00.0: 0x00000000 | beacon time
iwlwifi 0000:01:00.0: 0x00052ADD | tsf low
iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
iwlwifi 0000:01:00.0: 0x00000000 | time gp1
iwlwifi 0000:01:00.0: 0x00066975 | time gp2
iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
iwlwifi 0000:01:00.0: 0x00000420 | hw version
iwlwifi 0000:01:00.0: 0x00489002 | board version
iwlwifi 0000:01:00.0: 0x8004FC12 | hcmd
iwlwifi 0000:01:00.0: 0x00020000 | isr0
iwlwifi 0000:01:00.0: 0x00000000 | isr1
iwlwifi 0000:01:00.0: 0x48F00002 | isr2
iwlwifi 0000:01:00.0: 0x00C0000C | isr3
iwlwifi 0000:01:00.0: 0x00000000 | isr4
iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
iwlwifi 0000:01:00.0: 0x004D9C78 | wait_event
iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:01:00.0: 0x00000000 | timestamp
iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink1
iwlwifi 0000:01:00.0: 0x804792D6 | umac interruptlink2
iwlwifi 0000:01:00.0: 0x01000000 | umac data1
iwlwifi 0000:01:00.0: 0x804792D6 | umac data2
iwlwifi 0000:01:00.0: 0x00000000 | umac data3
iwlwifi 0000:01:00.0: 0x00000047 | umac major
iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
iwlwifi 0000:01:00.0: 0x00066ABB | frame pointer
iwlwifi 0000:01:00.0: 0xC0886244 | stack pointer
iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
iwlwifi 0000:01:00.0: IML/ROM dump:
iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
iwlwifi 0000:01:00.0: 0x000080F1 | IML/ROM data1
iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
iwlwifi 0000:01:00.0: Fseq Registers:
iwlwifi 0000:01:00.0: 0x20000000 | FSEQ_ERROR_CODE
iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRR=
OR
iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
iwlwifi 0000:01:00.0: retry init count 0
iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=3D0x420
thermal thermal_zone0: failed to read out thermal zone (-61)
iwlwifi 0000:01:00.0: Timeout waiting for PNVM load!
iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired (delay=3D0=
ms).
iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-a0-71=
.ucode
iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0
iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:01:00.0: 0x004DAEA2 | branchlink2
iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink1
iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink2
iwlwifi 0000:01:00.0: 0x004D9C78 | data1
iwlwifi 0000:01:00.0: 0x01000000 | data2
iwlwifi 0000:01:00.0: 0x00000000 | data3
iwlwifi 0000:01:00.0: 0x00000000 | beacon time
iwlwifi 0000:01:00.0: 0x00053473 | tsf low
iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
iwlwifi 0000:01:00.0: 0x00000000 | time gp1
iwlwifi 0000:01:00.0: 0x0006722F | time gp2
iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
iwlwifi 0000:01:00.0: 0x00000420 | hw version
iwlwifi 0000:01:00.0: 0x18489002 | board version
iwlwifi 0000:01:00.0: 0x8004FC12 | hcmd
iwlwifi 0000:01:00.0: 0x00020000 | isr0
iwlwifi 0000:01:00.0: 0x00000000 | isr1
iwlwifi 0000:01:00.0: 0x48F00002 | isr2
iwlwifi 0000:01:00.0: 0x00C0000C | isr3
iwlwifi 0000:01:00.0: 0x00000000 | isr4
iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
iwlwifi 0000:01:00.0: 0x004D9C78 | wait_event
iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:01:00.0: 0x00000000 | timestamp
iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink1
iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink2
iwlwifi 0000:01:00.0: 0x01000000 | umac data1
iwlwifi 0000:01:00.0: 0x8047E792 | umac data2
iwlwifi 0000:01:00.0: 0x00000000 | umac data3
iwlwifi 0000:01:00.0: 0x00000047 | umac major
iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
iwlwifi 0000:01:00.0: 0x00067375 | frame pointer
iwlwifi 0000:01:00.0: 0xC088625C | stack pointer
iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
iwlwifi 0000:01:00.0: IML/ROM dump:
iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
iwlwifi 0000:01:00.0: 0x000080EF | IML/ROM data1
iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
iwlwifi 0000:01:00.0: Fseq Registers:
iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRR=
OR
iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
iwlwifi 0000:01:00.0: retry init count 1
iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=3D0x420
thermal thermal_zone0: failed to read out thermal zone (-61)
iwlwifi 0000:01:00.0: Timeout waiting for PNVM load!
iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired (delay=3D0=
ms).
iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-a0-71=
.ucode
iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0
iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:01:00.0: 0x004DAEA2 | branchlink2
iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink1
iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink2
iwlwifi 0000:01:00.0: 0x004D9C78 | data1
iwlwifi 0000:01:00.0: 0x01000000 | data2
iwlwifi 0000:01:00.0: 0x00000000 | data3
iwlwifi 0000:01:00.0: 0x00000000 | beacon time
iwlwifi 0000:01:00.0: 0x00050982 | tsf low
iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
iwlwifi 0000:01:00.0: 0x00000000 | time gp1
iwlwifi 0000:01:00.0: 0x00064743 | time gp2
iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
iwlwifi 0000:01:00.0: 0x00000420 | hw version
iwlwifi 0000:01:00.0: 0x18489002 | board version
iwlwifi 0000:01:00.0: 0x8004FC12 | hcmd
iwlwifi 0000:01:00.0: 0x00020000 | isr0
iwlwifi 0000:01:00.0: 0x00000000 | isr1
iwlwifi 0000:01:00.0: 0x48F00002 | isr2
iwlwifi 0000:01:00.0: 0x00C0000C | isr3
iwlwifi 0000:01:00.0: 0x00000000 | isr4
iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
iwlwifi 0000:01:00.0: 0x004D9C78 | wait_event
iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:01:00.0: 0x00000000 | timestamp
iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink1
iwlwifi 0000:01:00.0: 0x804792E6 | umac interruptlink2
iwlwifi 0000:01:00.0: 0x01000000 | umac data1
iwlwifi 0000:01:00.0: 0x804792E6 | umac data2
iwlwifi 0000:01:00.0: 0x00000000 | umac data3
iwlwifi 0000:01:00.0: 0x00000047 | umac major
iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
iwlwifi 0000:01:00.0: 0x0006488D | frame pointer
iwlwifi 0000:01:00.0: 0xC0886244 | stack pointer
iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
iwlwifi 0000:01:00.0: IML/ROM dump:
iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
iwlwifi 0000:01:00.0: 0x000080F3 | IML/ROM data1
iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
iwlwifi 0000:01:00.0: Fseq Registers:
iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRR=
OR
iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
iwlwifi 0000:01:00.0: retry init count 2
