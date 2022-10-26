Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC48960E50A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Oct 2022 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiJZP4t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiJZP4r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 11:56:47 -0400
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B4D9C205
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 08:56:45 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MyD2M3t6VzMqFwq;
        Wed, 26 Oct 2022 17:56:43 +0200 (CEST)
Received: from [127.0.0.1] (unknown [10.92.206.117])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MyD2M2BTXzMpqC1;
        Wed, 26 Oct 2022 17:56:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fls.name; s=20200831;
        t=1666799803; bh=Hbt9BB8CXWTx6W6YRbrQT2O6fP1CCNQ0oGtYEtdaoFY=;
        h=Date:Subject:From:Reply-To:To:References:In-Reply-To:From;
        b=4eZSHGXh3+U4vQqxlDMGrFLrcOcbOziwaTEPFiIwsUo6kyzsn0oTOA79SQxAHeBnv
         1Li8iKCJBHBCZyu2gnYwt9l4HIQ1XGgCJelxfEaDM4W3WxusBHvKCXqMEOh5q9q2fX
         jnqFUUROpPf86XZgwYr9sXK0X6YE/mdXLp9x8Qto=
Message-ID: <4077a7705bb86501a9cbbce86fe1ea8c@mail.infomaniak.com>
Date:   Wed, 26 Oct 2022 17:56:43 +0200
Subject: Re: iwlwifi: intel ax210: module fail load firmware: Failed to start
 RT ucode: -110
From:   Florian Schmidt <florian@fls.name>
Reply-To: Florian Schmidt <florian@fls.name>
To:     Greenman Gregory <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6Ims3TkszbnZXSTFNNCt4UHBERXQ5cnc9PSIsInZhbHVlIjoiQnpYRGxiZ0VCejRpK0UzOWRMd0ltUT09IiwibWFjIjoiMWIwMTQ5MTA3YjY3NWUzM2NjYTFkNWU0ZGI3Yjc4MWMyMDRjYmJkODYwMDMwNWRhMWY2YWE3MDhkNDM1MzNmNiIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6IjBlV1pDWk0xNnRJaENvZ1lYakFMWmc9PSIsInZhbHVlIjoialBmRHdxc3U3UUMrMEpQMXR0OFFuUT09IiwibWFjIjoiOWY2YTg3YjkyMDM1MTMwODI3ZDUyOTZjYWVlMTg4NjAzNmM2OTA2ZmI3MmM5ZGMwZTZkMDgxZTljZjQ4NzYxYSIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.388)
References: <91cad7f52fe275bf567cf5aa7aa6f7c0@mail.infomaniak.com>
 <28dfa897c38286b1cf9ae30631fb7438@mail.infomaniak.com>
 <59fe5bdc361fed71103ee159cdb5ab64@mail.infomaniak.com>
 <f351b0a31b536e7a29d63937a242d5de7e2552ca.camel@intel.com>
In-Reply-To: <f351b0a31b536e7a29d63937a242d5de7e2552ca.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Gregory,

Thank you for having a look at this. The .pnvm file was present in my test =
as shown by my original message:
> md5sum /lib/firmware/*
> 787381c60d907f81a3ddadc5c990a82b ./iwlwifi-ty-a0-gf-a0-71.ucode
> d93cbdcc4bb5be69aac128e2fe291359 ./iwlwifi-ty-a0-gf-a0.pnvm
> 33d13d236512466e71c81257209a356f ./regulatory.db

I just ran the test again, ensuring I have the .pnvm you mention and the re=
sult is indeed the same.

Any other ideas to solve this are welcome.

Thanks,
Florian

On 2022-10-26T16:13:16.000+02:00, Greenman Gregory <gregory.greenman@intel.=
com> wrote:

>  On Fri, 2022-10-14 at 14:42 +0200, Florian Schmidt wrote:
>=20
> >    Hello, I've been trying to use an intel ax210 minipcie board on an a=
rm32 platform. I could use an intel ax200 on the same platform without issu=
es but with the ax210 it always fail.
> > =20
> >  How can I assist in debugging this issue ?
> > =20
> >  Below are some system information and the output of dmesg when loading=
 iwlwifi:
> > =20
> >  lspci -k
> >  00:00.0 PCI bridge: Xilinx Corporation Device 7121
> >  01:00.0 Network controller: Intel Corporation Device 2725 (rev 1a)
> >          Subsystem: Intel Corporation Device 0024
> >          Kernel driver in use: iwlwifi
> >          Kernel modules: iwlwifi
> > =20
> >  md5sum /lib/firmware/*
> >  787381c60d907f81a3ddadc5c990a82b  ./iwlwifi-ty-a0-gf-a0-71.ucode
> >  d93cbdcc4bb5be69aac128e2fe291359  ./iwlwifi-ty-a0-gf-a0.pnvm
> >  33d13d236512466e71c81257209a356f  ./regulatory.db
> > =20
> >  uname -a
> >  Linux BV1-26804 6.0.1-xilinx #1 SMP PREEMPT Wed Oct 12 09:15:44 UTC 20=
22 armv7l GNU/Linux
> > =20
> >  dmesg
> >  pci 0000:01:00.0: [8086:2725] type 00 class 0x028000
> >  pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> >  pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> >  pci 0000:00:00.0: BAR 8: assigned [mem 0x80000000-0x800fffff]
> >  pci 0000:01:00.0: BAR 0: assigned [mem 0x80000000-0x80003fff 64bit]
> >  pci 0000:00:00.0: PCI bridge to [bus 01]
> >  pci 0000:00:00.0:   bridge window [mem 0x80000000-0x800fffff]
> >  Intel(R) Wireless WiFi driver for Linux
> >  pci 0000:00:00.0: enabling device (0140 -> 0142)
> >  iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
> >  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-72.=
ucode failed with error -2
> >  iwlwifi 0000:01:00.0: api flags index 2 larger than supported by drive=
r
> >  iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.36
> >  iwlwifi 0000:01:00.0: loaded firmware version 71.058653f6.0 ty-a0-gf-a=
0-71.ucode op_mode iwlmvm
> >  iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=3D0x=
420
> >  thermal thermal_zone0: failed to read out thermal zone (-61)
> >  iwlwifi 0000:01:00.0: loaded PNVM version a982b33e
> >  iwlwifi 0000:01:00.0: Timeout waiting for PNVM load!
> >  iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
> >  iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired (dela=
y=3D0ms).
> >  iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> >  iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
> >  iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-=
a0-71.ucode
> >  iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
> >  iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0
> >  iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
> >  iwlwifi 0000:01:00.0: 0x004DAEA2 | branchlink2
> >  iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink1
> >  iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink2
> >  iwlwifi 0000:01:00.0: 0x004D9C78 | data1
> >  iwlwifi 0000:01:00.0: 0x01000000 | data2
> >  iwlwifi 0000:01:00.0: 0x00000000 | data3
> >  iwlwifi 0000:01:00.0: 0x00000000 | beacon time
> >  iwlwifi 0000:01:00.0: 0x000529AD | tsf low
> >  iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> >  iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> >  iwlwifi 0000:01:00.0: 0x0006680C | time gp2
> >  iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
> >  iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
> >  iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
> >  iwlwifi 0000:01:00.0: 0x00000420 | hw version
> >  iwlwifi 0000:01:00.0: 0x00C89002 | board version
> >  iwlwifi 0000:01:00.0: 0x8004FC12 | hcmd
> >  iwlwifi 0000:01:00.0: 0x00020000 | isr0
> >  iwlwifi 0000:01:00.0: 0x00000000 | isr1
> >  iwlwifi 0000:01:00.0: 0x48F00002 | isr2
> >  iwlwifi 0000:01:00.0: 0x00C0000C | isr3
> >  iwlwifi 0000:01:00.0: 0x00000000 | isr4
> >  iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
> >  iwlwifi 0000:01:00.0: 0x004D9C78 | wait_event
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> >  iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
> >  iwlwifi 0000:01:00.0: 0x00000000 | timestamp
> >  iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
> >  iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> >  iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
> >  iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
> >  iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
> >  iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
> >  iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink1
> >  iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink2
> >  iwlwifi 0000:01:00.0: 0x01000000 | umac data1
> >  iwlwifi 0000:01:00.0: 0x8047E792 | umac data2
> >  iwlwifi 0000:01:00.0: 0x00000000 | umac data3
> >  iwlwifi 0000:01:00.0: 0x00000047 | umac major
> >  iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
> >  iwlwifi 0000:01:00.0: 0x000668FF | frame pointer
> >  iwlwifi 0000:01:00.0: 0xC088625C | stack pointer
> >  iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
> >  iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
> >  iwlwifi 0000:01:00.0: IML/ROM dump:
> >  iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
> >  iwlwifi 0000:01:00.0: 0x000080BD | IML/ROM data1
> >  iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
> >  iwlwifi 0000:01:00.0: Fseq Registers:
> >  iwlwifi 0000:01:00.0: 0x20000000 | FSEQ_ERROR_CODE
> >  iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
> >  iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
> >  iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
> >  iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
> >  iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> >  iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
> >  iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
> >  iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
> >  iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
> >  iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VT=
RIM
> >  iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG=
_MIRROR
> >  iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
> >  iwlwifi 0000:01:00.0: retry init count 0
> >  iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=3D0x=
420
> >  thermal thermal_zone0: failed to read out thermal zone (-61)
> >  iwlwifi 0000:01:00.0: Timeout waiting for PNVM load!
> >  iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
> >  iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired (dela=
y=3D0ms).
> >  iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> >  iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
> >  iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-=
a0-71.ucode
> >  iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
> >  iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0
> >  iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
> >  iwlwifi 0000:01:00.0: 0x004DAEA2 | branchlink2
> >  iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink1
> >  iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink2
> >  iwlwifi 0000:01:00.0: 0x004D9C78 | data1
> >  iwlwifi 0000:01:00.0: 0x01000000 | data2
> >  iwlwifi 0000:01:00.0: 0x00000000 | data3
> >  iwlwifi 0000:01:00.0: 0x00000000 | beacon time
> >  iwlwifi 0000:01:00.0: 0x00051864 | tsf low
> >  iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> >  iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> >  iwlwifi 0000:01:00.0: 0x0006561F | time gp2
> >  iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
> >  iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
> >  iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
> >  iwlwifi 0000:01:00.0: 0x00000420 | hw version
> >  iwlwifi 0000:01:00.0: 0x18C89002 | board version
> >  iwlwifi 0000:01:00.0: 0x8004FC12 | hcmd
> >  iwlwifi 0000:01:00.0: 0x00020000 | isr0
> >  iwlwifi 0000:01:00.0: 0x00000000 | isr1
> >  iwlwifi 0000:01:00.0: 0x48F00002 | isr2
> >  iwlwifi 0000:01:00.0: 0x00C0000C | isr3
> >  iwlwifi 0000:01:00.0: 0x00000000 | isr4
> >  iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
> >  iwlwifi 0000:01:00.0: 0x004D9C78 | wait_event
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> >  iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
> >  iwlwifi 0000:01:00.0: 0x00000000 | timestamp
> >  iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
> >  iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> >  iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
> >  iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
> >  iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
> >  iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
> >  iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink1
> >  iwlwifi 0000:01:00.0: 0x8046C930 | umac interruptlink2
> >  iwlwifi 0000:01:00.0: 0x01000000 | umac data1
> >  iwlwifi 0000:01:00.0: 0x8046C930 | umac data2
> >  iwlwifi 0000:01:00.0: 0x00000000 | umac data3
> >  iwlwifi 0000:01:00.0: 0x00000047 | umac major
> >  iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
> >  iwlwifi 0000:01:00.0: 0x00065713 | frame pointer
> >  iwlwifi 0000:01:00.0: 0xC088623C | stack pointer
> >  iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
> >  iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
> >  iwlwifi 0000:01:00.0: IML/ROM dump:
> >  iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
> >  iwlwifi 0000:01:00.0: 0x000080F1 | IML/ROM data1
> >  iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
> >  iwlwifi 0000:01:00.0: Fseq Registers:
> >  iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
> >  iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
> >  iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
> >  iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
> >  iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
> >  iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> >  iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
> >  iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
> >  iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
> >  iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
> >  iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VT=
RIM
> >  iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG=
_MIRROR
> >  iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
> >  iwlwifi 0000:01:00.0: retry init count 1
> >  iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=3D0x=
420
> >  thermal thermal_zone0: failed to read out thermal zone (-61)
> >  iwlwifi 0000:01:00.0: Timeout waiting for PNVM load!
> >  iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
> >  iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired (dela=
y=3D0ms).
> >  iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> >  iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
> >  iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-=
a0-71.ucode
> >  iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
> >  iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0
> >  iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
> >  iwlwifi 0000:01:00.0: 0x004DAEA2 | branchlink2
> >  iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink1
> >  iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink2
> >  iwlwifi 0000:01:00.0: 0x004D9C78 | data1
> >  iwlwifi 0000:01:00.0: 0x01000000 | data2
> >  iwlwifi 0000:01:00.0: 0x00000000 | data3
> >  iwlwifi 0000:01:00.0: 0x00000000 | beacon time
> >  iwlwifi 0000:01:00.0: 0x00051D19 | tsf low
> >  iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> >  iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> >  iwlwifi 0000:01:00.0: 0x00065AD6 | time gp2
> >  iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
> >  iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
> >  iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
> >  iwlwifi 0000:01:00.0: 0x00000420 | hw version
> >  iwlwifi 0000:01:00.0: 0x18C89002 | board version
> >  iwlwifi 0000:01:00.0: 0x8004FC12 | hcmd
> >  iwlwifi 0000:01:00.0: 0x00020000 | isr0
> >  iwlwifi 0000:01:00.0: 0x00000000 | isr1
> >  iwlwifi 0000:01:00.0: 0x48F00002 | isr2
> >  iwlwifi 0000:01:00.0: 0x00C0000C | isr3
> >  iwlwifi 0000:01:00.0: 0x00000000 | isr4
> >  iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
> >  iwlwifi 0000:01:00.0: 0x004D9C78 | wait_event
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> >  iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
> >  iwlwifi 0000:01:00.0: 0x00000000 | timestamp
> >  iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
> >  iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> >  iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
> >  iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
> >  iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
> >  iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
> >  iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink1
> >  iwlwifi 0000:01:00.0: 0xC00818E0 | umac interruptlink2
> >  iwlwifi 0000:01:00.0: 0x01000000 | umac data1
> >  iwlwifi 0000:01:00.0: 0xC00818E0 | umac data2
> >  iwlwifi 0000:01:00.0: 0x00000000 | umac data3
> >  iwlwifi 0000:01:00.0: 0x00000047 | umac major
> >  iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
> >  iwlwifi 0000:01:00.0: 0x00065BCA | frame pointer
> >  iwlwifi 0000:01:00.0: 0xC0886228 | stack pointer
> >  iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
> >  iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
> >  iwlwifi 0000:01:00.0: IML/ROM dump:
> >  iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
> >  iwlwifi 0000:01:00.0: 0x000080F1 | IML/ROM data1
> >  iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
> >  iwlwifi 0000:01:00.0: Fseq Registers:
> >  iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
> >  iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
> >  iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
> >  iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
> >  iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
> >  iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> >  iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
> >  iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
> >  iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
> >  iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
> >  iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VT=
RIM
> >  iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG=
_MIRROR
> >  iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
> >  iwlwifi 0000:01:00.0: retry init count 2
> =20
> The problem here (at least what I can understand from the log) is that th=
e PNVM binary is missing.
> Indeed, it's not required for ax200 device, but it's needed for ax210 dev=
ice.
> You can take iwlwifi-ty-a0-gf-a0.pnvm from=C2=A0
> http://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.gi=
t and place it along with
> the frimware file in /lib/firmware.
>=20
> HTH,
> Gregory
