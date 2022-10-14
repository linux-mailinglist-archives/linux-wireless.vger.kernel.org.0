Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2B75FEE14
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 14:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJNMm7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJNMmx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 08:42:53 -0400
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00F71C713F
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 05:42:49 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MpmJ56lQMzMpnf8
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 14:42:45 +0200 (CEST)
Received: from [127.0.0.1] (unknown [10.92.207.204])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MpmJ55BmfzMpphh
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 14:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fls.name; s=20200831;
        t=1665751365; bh=JI3wsspRI2fhMjKLK1CQCGvZWKC3RiFpczxvIzENCUY=;
        h=Date:Subject:From:Reply-To:To:References:In-Reply-To:From;
        b=gznJxykcLk9kyxOAdrU+G2fBNIbGrVwB8K+ML5LcNlZ1jPZh2Ou99mWQmi8eDkCMM
         6Q/E4Hm2UlXBQgBzgI2jTu7it67f/WVpk5I1Sa9IcuKo9ej6lKRbilkIE5ZB2ngkjE
         etaBNpDrDfsJkdOT4p1hzkBpvZP1blRQ8iKfuYsw=
Message-ID: <59fe5bdc361fed71103ee159cdb5ab64@mail.infomaniak.com>
Date:   Fri, 14 Oct 2022 14:42:45 +0200
Subject: iwlwifi: intel ax210: module fail load firmware: Failed to start RT
 ucode: -110
From:   Florian Schmidt <florian@fls.name>
Reply-To: Florian Schmidt <florian@fls.name>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6ImU0ekJ3SVlFUG9uVGJqa0llUnVzREE9PSIsInZhbHVlIjoiWGZxQkJadk1wWkkvdE1hajRrL2t6UT09IiwibWFjIjoiNDI0NmY5ZmMxN2JiZjcyZjI5MDE5NjJlYzUyMzhhZGQ1MzUyZWQ1YzExNTAwMmYwNmU5M2YxODVjODYwNTBhOCIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6InF1RjRIbG9yNG85OGZCTlZGRGxMOHc9PSIsInZhbHVlIjoiQU94clkwcE9UaTFuQkE0V3VGQWJVdz09IiwibWFjIjoiYmFjNzBiMzhjZWIzY2QyYzNhOTQ5YTIyOTFmZTFjMjUxYzg1MGIwY2RjMDNlNzNiODBhZTMxYzg3YjdmODAyYyIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.383)
References: <91cad7f52fe275bf567cf5aa7aa6f7c0@mail.infomaniak.com>
 <28dfa897c38286b1cf9ae30631fb7438@mail.infomaniak.com>
In-Reply-To: <28dfa897c38286b1cf9ae30631fb7438@mail.infomaniak.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello, I've been trying to use an intel ax210 minipcie board on an arm32 pl=
atform. I could use an intel ax200 on the same platform without issues but =
with the ax210 it always fail.

How can I assist in debugging this issue ?

Below are some system information and the output of dmesg when loading iwlw=
ifi:

lspci -k
00:00.0 PCI bridge: Xilinx Corporation Device 7121
01:00.0 Network controller: Intel Corporation Device 2725 (rev 1a)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Dev=
ice 0024
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: iwlwifi
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: iwlwifi

md5sum /lib/firmware/*
787381c60d907f81a3ddadc5c990a82b=C2=A0 ./iwlwifi-ty-a0-gf-a0-71.ucode
d93cbdcc4bb5be69aac128e2fe291359=C2=A0 ./iwlwifi-ty-a0-gf-a0.pnvm
33d13d236512466e71c81257209a356f=C2=A0 ./regulatory.db

uname -a
Linux BV1-26804 6.0.1-xilinx #1 SMP PREEMPT Wed Oct 12 09:15:44 UTC 2022 ar=
mv7l GNU/Linux

dmesg
pci 0000:01:00.0: [8086:2725] type 00 class 0x028000
pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:00.0: BAR 8: assigned [mem 0x80000000-0x800fffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0x80000000-0x80003fff 64bit]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:=C2=A0=C2=A0 bridge window [mem 0x80000000-0x800fffff]
Intel(R) Wireless WiFi driver for Linux
pci 0000:00:00.0: enabling device (0140 -> 0142)
iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-72.ucode=
 failed with error -2
iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.36
iwlwifi 0000:01:00.0: loaded firmware version 71.058653f6.0 ty-a0-gf-a0-71.=
ucode op_mode iwlmvm
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
iwlwifi 0000:01:00.0: 0x000529AD | tsf low
iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
iwlwifi 0000:01:00.0: 0x00000000 | time gp1
iwlwifi 0000:01:00.0: 0x0006680C | time gp2
iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
iwlwifi 0000:01:00.0: 0x00000420 | hw version
iwlwifi 0000:01:00.0: 0x00C89002 | board version
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
iwlwifi 0000:01:00.0: 0x000668FF | frame pointer
iwlwifi 0000:01:00.0: 0xC088625C | stack pointer
iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
iwlwifi 0000:01:00.0: IML/ROM dump:
iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
iwlwifi 0000:01:00.0: 0x000080BD | IML/ROM data1
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
iwlwifi 0000:01:00.0: 0x00051864 | tsf low
iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
iwlwifi 0000:01:00.0: 0x00000000 | time gp1
iwlwifi 0000:01:00.0: 0x0006561F | time gp2
iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
iwlwifi 0000:01:00.0: 0x00000420 | hw version
iwlwifi 0000:01:00.0: 0x18C89002 | board version
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
iwlwifi 0000:01:00.0: 0x8046C930 | umac interruptlink2
iwlwifi 0000:01:00.0: 0x01000000 | umac data1
iwlwifi 0000:01:00.0: 0x8046C930 | umac data2
iwlwifi 0000:01:00.0: 0x00000000 | umac data3
iwlwifi 0000:01:00.0: 0x00000047 | umac major
iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
iwlwifi 0000:01:00.0: 0x00065713 | frame pointer
iwlwifi 0000:01:00.0: 0xC088623C | stack pointer
iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
iwlwifi 0000:01:00.0: IML/ROM dump:
iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
iwlwifi 0000:01:00.0: 0x000080F1 | IML/ROM data1
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
iwlwifi 0000:01:00.0: 0x00051D19 | tsf low
iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
iwlwifi 0000:01:00.0: 0x00000000 | time gp1
iwlwifi 0000:01:00.0: 0x00065AD6 | time gp2
iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
iwlwifi 0000:01:00.0: 0x00000420 | hw version
iwlwifi 0000:01:00.0: 0x18C89002 | board version
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
iwlwifi 0000:01:00.0: 0xC00818E0 | umac interruptlink2
iwlwifi 0000:01:00.0: 0x01000000 | umac data1
iwlwifi 0000:01:00.0: 0xC00818E0 | umac data2
iwlwifi 0000:01:00.0: 0x00000000 | umac data3
iwlwifi 0000:01:00.0: 0x00000047 | umac major
iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
iwlwifi 0000:01:00.0: 0x00065BCA | frame pointer
iwlwifi 0000:01:00.0: 0xC0886228 | stack pointer
iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
iwlwifi 0000:01:00.0: IML/ROM dump:
iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
iwlwifi 0000:01:00.0: 0x000080F1 | IML/ROM data1
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
