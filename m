Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DE4744C88
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jul 2023 09:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjGBHdl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jul 2023 03:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBHdj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jul 2023 03:33:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F6A10E5
        for <linux-wireless@vger.kernel.org>; Sun,  2 Jul 2023 00:33:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6687446eaccso2688627b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 02 Jul 2023 00:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688283206; x=1690875206;
        h=mime-version:user-agent:message-id:date:cc:subject:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WUAot5XGXX6pgz0WOP/HTVhvHXZ2kOS/OsnXvqgmCig=;
        b=heumOu+nSzZvZEoHJkrK0u5tA+BLe4h/eQjNfn6KH9SMc9AN3ImcUzF4AG8WClXQF5
         aX67F2GulX8x7WG319eO1kW1ODNlLOn4iM55ydwTT6ro7TqLT33LJs2waHjB8x3caj11
         COI8gAIZNIiyvLfww5ktXd2FGfU/sRSqqreqOl5jPoBbYbnVWE1NCH8S1DOgD8+QpgoT
         8VKlJyZ8uDOnI4ZRRw17VEiN+y4q7f2zdCFcmgcGmMl8tTIllJC/A4dXiIbroydXNMIe
         a4g1e4DXoiXkcvszcIYEGCEHJ5iiuxoODdOOCt/tkIiSJc3dHPH0449zuuIm6BNzN4Qh
         cCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688283206; x=1690875206;
        h=mime-version:user-agent:message-id:date:cc:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUAot5XGXX6pgz0WOP/HTVhvHXZ2kOS/OsnXvqgmCig=;
        b=h+18+9cpmGRNOKCB+fTT1bZCeJD3uRFrMP2+h/uAuUsWrsdC/zqEeDyJ/3G0jt3u+X
         MJVKEGhOyEYbQBU1IXoHa/0mpncayCdamQfdVYcytz5gpTJHKQ5+PbhxVX3tVzjuO/hc
         AhZlXMXaBafPU4B93zqmvXc89K3yPOPnhD0uk9xtggUVq0ddUrPIBuHu+UAmE/ZYAZzD
         Jxbh8NTi84BV52JZw0qH8yN2M86c0r/jnErMgvzY90iKWpbmakWtlP52lRITIUFot9u7
         +OfgTQVdHvxO8UaYQJu/xxp9TGXEwK5AgEekHqFwbTVLJRgta1Orq0pZ5+sHJOINy4oY
         tXgQ==
X-Gm-Message-State: ABy/qLaHmd6uGcUjzRrfWPvJnfyoK+GWAq8s5D1wcfyi0Fzxss6Fxrn/
        nM/uJoQ7evERS83yIBVhdKfFCwYXyouNfg==
X-Google-Smtp-Source: APBJJlHHxKnGiSgBflHvuV5AYUfrWpOArl5JGs9KQydQ4nSEG/ZhvBDSZDu6keJDO59YccGl2iZgBg==
X-Received: by 2002:a05:6a00:14cc:b0:66f:912b:d6f with SMTP id w12-20020a056a0014cc00b0066f912b0d6fmr10634582pfu.0.1688283205732;
        Sun, 02 Jul 2023 00:33:25 -0700 (PDT)
Received: from athena (104-52-52-190.lightspeed.frsnca.sbcglobal.net. [104.52.52.190])
        by smtp.gmail.com with ESMTPSA id g12-20020a62e30c000000b0067ab572c72fsm8903202pfh.84.2023.07.02.00.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 00:33:24 -0700 (PDT)
From:   Rob Glossop <robgssp@gmail.com>
To:     Gregory Greenman <gregory.greenman@intel.com>
Subject: [iwlwifi] wifi fails on resume from suspend
CC:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Date:   Sun, 02 Jul 2023 00:33:23 -0700
Message-ID: <87r0pq7oos.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--=-=-=
Content-Type: text/plain


After a kernel update my wifi's started misbehaving after suspend.
Observed behavior is on resume it'll either fail to connect, or connect
with extremely high packet loss - pings will typically get through for
two or three seconds at a time, followed by about thirty seconds of dead
time. dmesg has a bunch of messages to the tune of

[   66.620028] iwlwifi 0000:00:14.3: Queue 5 is stuck 0 14
[   66.620050] iwlwifi 0000:00:14.3: Queue 4 is stuck 0 4
[   66.620260] iwlwifi 0000:00:14.3: Microcode SW error detected. Restarting 0x0.
[   66.620328] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   66.620329] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 6
[   66.620330] iwlwifi 0000:00:14.3: Loaded firmware version: 77.f92b5fed.0 QuZ-a0-hr-b0-77.ucode
[   66.620331] iwlwifi 0000:00:14.3: 0x00000084 | NMI_INTERRUPT_UNKNOWN
[   66.620332] iwlwifi 0000:00:14.3: 0x0000A2F0 | trm_hw_status0
[   66.620333] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   66.620334] iwlwifi 0000:00:14.3: 0x004C8FAA | branchlink2
[   66.620335] iwlwifi 0000:00:14.3: 0x004BEF5E | interruptlink1
[   66.620336] iwlwifi 0000:00:14.3: 0x004BEF5E | interruptlink2
[   66.620336] iwlwifi 0000:00:14.3: 0x0001523A | data1
[   66.620337] iwlwifi 0000:00:14.3: 0x01000000 | data2
[   66.620338] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   66.620338] iwlwifi 0000:00:14.3: 0x18810674 | beacon time
[   66.620339] iwlwifi 0000:00:14.3: 0xB2452997 | tsf low
[   66.620340] iwlwifi 0000:00:14.3: 0x00000923 | tsf hi
[   66.620341] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   66.620341] iwlwifi 0000:00:14.3: 0x00D955C0 | time gp2
[   66.620342] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   66.620343] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   66.620343] iwlwifi 0000:00:14.3: 0xF92B5FED | uCode version minor
[   66.620344] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   66.620345] iwlwifi 0000:00:14.3: 0x00C89001 | board version
[   66.620345] iwlwifi 0000:00:14.3: 0x8052FD4F | hcmd
[   66.620346] iwlwifi 0000:00:14.3: 0x20028000 | isr0
[   66.620347] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   66.620347] iwlwifi 0000:00:14.3: 0x08F00002 | isr2
[   66.620348] iwlwifi 0000:00:14.3: 0x00C3028C | isr3
[   66.620349] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   66.620349] iwlwifi 0000:00:14.3: 0x00760103 | last cmd Id
[   66.620350] iwlwifi 0000:00:14.3: 0x0001523A | wait_event
[   66.620351] iwlwifi 0000:00:14.3: 0x000000D4 | l2p_control
[   66.620351] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   66.620352] iwlwifi 0000:00:14.3: 0x00000007 | l2p_mhvalid
[   66.620353] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   66.620353] iwlwifi 0000:00:14.3: 0x00000009 | lmpm_pmg_sel
[   66.620354] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   66.620355] iwlwifi 0000:00:14.3: 0x0000D848 | flow_handler
[   66.620386] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   66.620387] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 7
[   66.620388] iwlwifi 0000:00:14.3: 0x20000066 | NMI_INTERRUPT_HOST
[   66.620388] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   66.620389] iwlwifi 0000:00:14.3: 0x8045613A | umac branchlink2
[   66.620390] iwlwifi 0000:00:14.3: 0x8047301E | umac interruptlink1
[   66.620390] iwlwifi 0000:00:14.3: 0x8047301E | umac interruptlink2
[   66.620391] iwlwifi 0000:00:14.3: 0x01000000 | umac data1
[   66.620392] iwlwifi 0000:00:14.3: 0x8047301E | umac data2
[   66.620392] iwlwifi 0000:00:14.3: 0x00000000 | umac data3
[   66.620393] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   66.620394] iwlwifi 0000:00:14.3: 0xF92B5FED | umac minor
[   66.620394] iwlwifi 0000:00:14.3: 0x00D955BE | frame pointer
[   66.620395] iwlwifi 0000:00:14.3: 0xC0886260 | stack pointer
[   66.620396] iwlwifi 0000:00:14.3: 0x0083010C | last host cmd
[   66.620396] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   66.620419] iwlwifi 0000:00:14.3: IML/ROM dump:
[   66.620420] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   66.620426] iwlwifi 0000:00:14.3: 0x0000570D | IML/ROM data1
[   66.620433] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   66.620438] iwlwifi 0000:00:14.3: Fseq Registers:
[   66.620440] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   66.620442] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   66.620444] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   66.620446] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   66.620449] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   66.620451] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   66.620453] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   66.620455] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   66.620457] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   66.620461] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   66.620465] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   66.620470] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   66.620472] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERSION
[   66.620474] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   66.620476] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   66.620478] iwlwifi 0000:00:14.3: 0x000000DC | FSEQ_CLASS_TP_VERSION
[   66.620485] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x80472b34
[   66.620487] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   66.620566] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[   66.620570] ieee80211 phy0: Hardware restart was requested

repeated every ten seconds or so. I bisected the bug down to
597568e8df04, which turns out to be a change to the rtsx driver's power
management. On my system that's the SD card reader driver. After
blacklisting the relevant modules (rtsx_pci and rtsx_pci_sdmmc), the
wifi actually fails from boot, with the above error showing up
immediately.

Without rtsx blacklisted the bug's present from that commit up through
master. With the reader blacklisted the bug's present on every kernel I
tested, back to 5.4.

On newer kernels, plugging in an SD card also causes wifi to drop. On
5.15 wifi survives the SD card's presence.

My suspicion of what's going on is that the wifi card's power management
isn't being handled correctly, but that's being masked somehow by the sd
card driver. When the sd driver's power management code changed, or when
the driver's blacklisted, the wifi card's left without that and fails.

The hardware here's a Dell XPS 15 9500, with a "Killer AX1650" card -
the driver reports it as

[    3.086156] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX203, REV=0x354

To repro: boot, suspend, resume and try and connect to wifi. Or
blacklist rsx_pci and rtsx_pci_sdmmc, no suspend required.

Thanks for any help, and let me know if you need any more info.

--

Rob


--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=dmesg-master-suspend
Content-Transfer-Encoding: quoted-printable
Content-Description: dmesg-master

[    0.000000] microcode: updated early: 0xc8 -> 0xf6, date =3D 2022-12-27
[    0.000000] Linux version 6.4.0 (nixbld@localhost) (gcc (GCC) 11.3.0, GN=
U ld (GNU Binutils) 2.39) #1-NixOS SMP PREEMPT_DYNAMIC Tue Jan  1 00:00:00 =
UTC 1980
[    0.000000] Command line: initrd=3D\efi\nixos\49gmkhf74zbaj23c7cqz43w0c5=
dwddgl-initrd-linux-6.4.0-initrd.efi init=3D/nix/store/9q5yllrjcbas13g2cb4w=
jcmwdapdg890-nixos-system-athena-22.11.20230701.dirty/init i915.enable_psr=
=3D0 resume_offset=3D78102528 loglevel=3D4
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ae8efff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ae8f000-0x000000003ae8ffff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000003ae90000-0x000000003ae90fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000003ae91000-0x000000004c825fff] usable
[    0.000000] BIOS-e820: [mem 0x000000004c826000-0x000000004f8b4fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000004f8b5000-0x000000004ff24fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000004ff25000-0x000000004fffefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000004ffff000-0x000000004fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000050000000-0x00000000607fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000089b7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x4c569018-0x4c578057] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x4c569018-0x4c578057] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000003ae8ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000003ae8f000-0x000000003ae8ff=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000003ae90000-0x000000003ae90f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000003ae91000-0x000000004c5690=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000004c569018-0x000000004c5780=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000004c578058-0x000000004c825f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000004c826000-0x000000004f8b4f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000004f8b5000-0x000000004ff24f=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000004ff25000-0x000000004fffef=
ff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000004ffff000-0x000000004fffff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000050000000-0x00000000607fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000089b7fff=
ff] usable
[    0.000000] efi: EFI v2.7 by Dell
[    0.000000] efi: SMBIOS=3D0x4d263000 TPMFinalLog=3D0x4ff1d000 ACPI=3D0x4=
fffe000 ACPI 2.0=3D0x4fffe014 ESRT=3D0x4d121698 MEMATTR=3D0x49db4018 PROP=
=3D0x39c6f130 RNG=3D0x4ff8af18 INITRD=3D0x4c580a98 TPMEventLog=3D0x4c579018=
=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem117: MMIO range=3D[0xe0000000-0xefffffff] (25=
6MB) from e820 map
[    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
[    0.000000] efi: Remove mem118: MMIO range=3D[0xff000000-0xffffffff] (16=
MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.2 present.
[    0.000000] DMI: Dell Inc. XPS 15 9500/0RHXRG, BIOS 1.5.3 11/20/2020
[    0.000000] tsc: Detected 2600.000 MHz processor
[    0.000000] tsc: Detected 2599.992 MHz TSC
[    0.000827] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000829] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000833] last_pfn =3D 0x89b800 max_arch_pfn =3D 0x400000000
[    0.000836] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built fr=
om 10 variable MTRRs
[    0.000837] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
=20=20
[    0.001133] last_pfn =3D 0x50000 max_arch_pfn =3D 0x400000000
[    0.009965] esrt: Reserving ESRT space from 0x000000004d121698 to 0x0000=
00004d121720.
[    0.009972] Using GB pages for direct mapping
[    0.010296] Secure boot disabled
[    0.010297] RAMDISK: [mem 0x37609000-0x38703fff]
[    0.010299] ACPI: Early table checksum verification disabled
[    0.010301] ACPI: RSDP 0x000000004FFFE014 000024 (v02 DELL  )
[    0.010303] ACPI: XSDT 0x000000004FF93188 0000F4 (v01 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010306] ACPI: FACP 0x000000004FFF0000 000114 (v06 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010309] ACPI: DSDT 0x000000004FFA3000 049DC8 (v02 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010311] ACPI: FACS 0x000000004FEA5000 000040
[    0.010312] ACPI: SSDT 0x000000004FFFA000 00203C (v02 CpuRef CpuSsdt  00=
003000 INTL 20160527)
[    0.010314] ACPI: SSDT 0x000000004FFF3000 0063E5 (v02 INTEL  DptfTabl 00=
001000 INTL 20160527)
[    0.010316] ACPI: SSDT 0x000000004FFF1000 00134A (v02 SaSsdt SaSsdt   00=
003000 INTL 20160527)
[    0.010318] ACPI: HPET 0x000000004FFEF000 000038 (v01 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010319] ACPI: APIC 0x000000004FFEE000 000164 (v03 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010321] ACPI: MCFG 0x000000004FFED000 00003C (v01 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010323] ACPI: SSDT 0x000000004FFA1000 001749 (v02 DELL   DellRtd3 00=
001000 INTL 20160527)
[    0.010325] ACPI: SSDT 0x000000004FFA0000 000CB0 (v02 DELL   xh_Dell_ 00=
000000 INTL 20160527)
[    0.010326] ACPI: NHLT 0x000000004FF9F000 00002D (v00 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010328] ACPI: SSDT 0x000000004FF9E000 000C78 (v02 DELL   UsbCTabl 00=
001000 INTL 20160527)
[    0.010330] ACPI: LPIT 0x000000004FF9D000 000094 (v01 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010331] ACPI: WSMT 0x000000004FF9C000 000028 (v01 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010333] ACPI: SSDT 0x000000004FF9B000 000B75 (v02 DELL   PtidDevc 00=
001000 INTL 20160527)
[    0.010335] ACPI: DBGP 0x000000004FF9A000 000034 (v01 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010337] ACPI: DBG2 0x000000004FF99000 000054 (v00 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010338] ACPI: SSDT 0x000000004FF98000 00060E (v02 DELL   Tpm2Tabl 00=
001000 INTL 20160527)
[    0.010340] ACPI: TPM2 0x000000004FF97000 000034 (v04 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010344] ACPI: SLIC 0x000000004FF96000 000176 (v03 DELL   CBX3     06=
222004 MSFT 00010013)
[    0.010346] ACPI: BOOT 0x000000004FF95000 000028 (v01 DELL   CBX3     20=
170001 INTL 20160422)
[    0.010347] ACPI: MSDM 0x000000004FF94000 000055 (v03 DELL   CBX3     06=
222004 AMI  00010013)
[    0.010349] ACPI: DMAR 0x000000004FFFD000 0000A8 (v01 INTEL  Dell Inc 00=
000002      01000013)
[    0.010351] ACPI: SSDT 0x000000004FF8E000 0041A0 (v01 DELL   NvdTable 00=
001000 INTL 20160527)
[    0.010352] ACPI: SSDT 0x000000004FF8D000 000156 (v02 Dell   ADebTabl 00=
001000 INTL 20160527)
[    0.010354] ACPI: BGRT 0x000000004FF8C000 000038 (v01 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010356] ACPI: FPDT 0x000000004FF8B000 000034 (v01 DELL   Dell Inc 20=
170001 INTL 20160422)
[    0.010357] ACPI: Reserving FACP table memory at [mem 0x4fff0000-0x4fff0=
113]
[    0.010358] ACPI: Reserving DSDT table memory at [mem 0x4ffa3000-0x4ffec=
dc7]
[    0.010359] ACPI: Reserving FACS table memory at [mem 0x4fea5000-0x4fea5=
03f]
[    0.010359] ACPI: Reserving SSDT table memory at [mem 0x4fffa000-0x4fffc=
03b]
[    0.010360] ACPI: Reserving SSDT table memory at [mem 0x4fff3000-0x4fff9=
3e4]
[    0.010360] ACPI: Reserving SSDT table memory at [mem 0x4fff1000-0x4fff2=
349]
[    0.010361] ACPI: Reserving HPET table memory at [mem 0x4ffef000-0x4ffef=
037]
[    0.010361] ACPI: Reserving APIC table memory at [mem 0x4ffee000-0x4ffee=
163]
[    0.010362] ACPI: Reserving MCFG table memory at [mem 0x4ffed000-0x4ffed=
03b]
[    0.010362] ACPI: Reserving SSDT table memory at [mem 0x4ffa1000-0x4ffa2=
748]
[    0.010363] ACPI: Reserving SSDT table memory at [mem 0x4ffa0000-0x4ffa0=
caf]
[    0.010363] ACPI: Reserving NHLT table memory at [mem 0x4ff9f000-0x4ff9f=
02c]
[    0.010364] ACPI: Reserving SSDT table memory at [mem 0x4ff9e000-0x4ff9e=
c77]
[    0.010364] ACPI: Reserving LPIT table memory at [mem 0x4ff9d000-0x4ff9d=
093]
[    0.010365] ACPI: Reserving WSMT table memory at [mem 0x4ff9c000-0x4ff9c=
027]
[    0.010365] ACPI: Reserving SSDT table memory at [mem 0x4ff9b000-0x4ff9b=
b74]
[    0.010366] ACPI: Reserving DBGP table memory at [mem 0x4ff9a000-0x4ff9a=
033]
[    0.010366] ACPI: Reserving DBG2 table memory at [mem 0x4ff99000-0x4ff99=
053]
[    0.010367] ACPI: Reserving SSDT table memory at [mem 0x4ff98000-0x4ff98=
60d]
[    0.010367] ACPI: Reserving TPM2 table memory at [mem 0x4ff97000-0x4ff97=
033]
[    0.010368] ACPI: Reserving SLIC table memory at [mem 0x4ff96000-0x4ff96=
175]
[    0.010368] ACPI: Reserving BOOT table memory at [mem 0x4ff95000-0x4ff95=
027]
[    0.010369] ACPI: Reserving MSDM table memory at [mem 0x4ff94000-0x4ff94=
054]
[    0.010369] ACPI: Reserving DMAR table memory at [mem 0x4fffd000-0x4fffd=
0a7]
[    0.010370] ACPI: Reserving SSDT table memory at [mem 0x4ff8e000-0x4ff92=
19f]
[    0.010370] ACPI: Reserving SSDT table memory at [mem 0x4ff8d000-0x4ff8d=
155]
[    0.010371] ACPI: Reserving BGRT table memory at [mem 0x4ff8c000-0x4ff8c=
037]
[    0.010371] ACPI: Reserving FPDT table memory at [mem 0x4ff8b000-0x4ff8b=
033]
[    0.010568] No NUMA configuration found
[    0.010569] Faking a node at [mem 0x0000000000000000-0x000000089b7fffff]
[    0.010571] NODE_DATA(0) allocated [mem 0x89b7fb000-0x89b7fffff]
[    0.010600] Zone ranges:
[    0.010600]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.010601]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.010602]   Normal   [mem 0x0000000100000000-0x000000089b7fffff]
[    0.010603]   Device   empty
[    0.010604] Movable zone start for each node
[    0.010604] Early memory node ranges
[    0.010604]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.010605]   node   0: [mem 0x0000000000100000-0x000000003ae8efff]
[    0.010606]   node   0: [mem 0x000000003ae91000-0x000000004c825fff]
[    0.010606]   node   0: [mem 0x000000004ffff000-0x000000004fffffff]
[    0.010607]   node   0: [mem 0x0000000100000000-0x000000089b7fffff]
[    0.010610] Initmem setup node 0 [mem 0x0000000000001000-0x000000089b7ff=
fff]
[    0.010612] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.010624] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.011694] On node 0, zone DMA32: 2 pages in unavailable ranges
[    0.011790] On node 0, zone DMA32: 14297 pages in unavailable ranges
[    0.043262] On node 0, zone Normal: 18432 pages in unavailable ranges
[    0.043284] Reserving Intel graphics memory at [mem 0x5c800000-0x607ffff=
f]
[    0.043815] ACPI: PM-Timer IO Port: 0x1808
[    0.043819] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.043820] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.043821] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.043821] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.043821] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.043822] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.043822] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.043823] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.043823] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.043824] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.043824] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.043824] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.043825] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.043825] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.043826] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.043826] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.043827] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.043827] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.043828] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.043828] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.043866] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.043868] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.043869] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.043872] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.043872] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.043877] e820: update [mem 0x49555000-0x495d1fff] usable =3D=3D> rese=
rved
[    0.043883] TSC deadline timer available
[    0.043883] smpboot: Allowing 12 CPUs, 0 hotplug CPUs
[    0.043893] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.043894] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000fffff]
[    0.043895] PM: hibernation: Registered nosave memory: [mem 0x3ae8f000-0=
x3ae8ffff]
[    0.043896] PM: hibernation: Registered nosave memory: [mem 0x3ae90000-0=
x3ae90fff]
[    0.043897] PM: hibernation: Registered nosave memory: [mem 0x49555000-0=
x495d1fff]
[    0.043898] PM: hibernation: Registered nosave memory: [mem 0x4c569000-0=
x4c569fff]
[    0.043899] PM: hibernation: Registered nosave memory: [mem 0x4c578000-0=
x4c578fff]
[    0.043900] PM: hibernation: Registered nosave memory: [mem 0x4c826000-0=
x4f8b4fff]
[    0.043900] PM: hibernation: Registered nosave memory: [mem 0x4f8b5000-0=
x4ff24fff]
[    0.043901] PM: hibernation: Registered nosave memory: [mem 0x4ff25000-0=
x4fffefff]
[    0.043902] PM: hibernation: Registered nosave memory: [mem 0x50000000-0=
x607fffff]
[    0.043902] PM: hibernation: Registered nosave memory: [mem 0x60800000-0=
xffffffff]
[    0.043903] [mem 0x60800000-0xffffffff] available for PCI devices
[    0.043904] Booting paravirtualized kernel on bare hardware
[    0.043905] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.046670] setup_percpu: NR_CPUS:384 nr_cpumask_bits:12 nr_cpu_ids:12 n=
r_node_ids:1
[    0.047086] percpu: Embedded 57 pages/cpu s196264 r8192 d29016 u262144
[    0.047090] pcpu-alloc: s196264 r8192 d29016 u262144 alloc=3D1*2097152
[    0.047092] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- -=
- -- --=20
[    0.047108] Kernel command line: initrd=3D\efi\nixos\49gmkhf74zbaj23c7cq=
z43w0c5dwddgl-initrd-linux-6.4.0-initrd.efi init=3D/nix/store/9q5yllrjcbas1=
3g2cb4wjcmwdapdg890-nixos-system-athena-22.11.20230701.dirty/init i915.enab=
le_psr=3D0 resume_offset=3D78102528 loglevel=3D4
[    0.049192] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes, linear)
[    0.050221] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes, linear)
[    0.050312] Fallback order for Node 0: 0=20
[    0.050314] Built 1 zonelists, mobility grouping on.  Total pages: 81605=
48
[    0.050316] Policy zone: Normal
[    0.050316] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.050320] software IO TLB: area num 16.
[    0.097970] Memory: 32378580K/33160972K available (14336K kernel code, 2=
244K rwdata, 4524K rodata, 2808K init, 3400K bss, 782132K reserved, 0K cma-=
reserved)
[    0.098047] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D12, =
Nodes=3D1
[    0.098061] ftrace: allocating 36800 entries in 144 pages
[    0.102462] ftrace: allocated 144 pages with 2 groups
[    0.102841] Dynamic Preempt: voluntary
[    0.102863] rcu: Preemptible hierarchical RCU implementation.
[    0.102864] rcu: 	RCU event tracing is enabled.
[    0.102864] rcu: 	RCU restricting CPUs from NR_CPUS=3D384 to nr_cpu_ids=
=3D12.
[    0.102865] 	Trampoline variant of Tasks RCU enabled.
[    0.102865] 	Rude variant of Tasks RCU enabled.
[    0.102865] 	Tracing variant of Tasks RCU enabled.
[    0.102866] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    0.102866] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D12
[    0.104543] NR_IRQS: 24832, nr_irqs: 2152, preallocated irqs: 16
[    0.104821] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.105021] Console: colour dummy device 80x25
[    0.105023] printk: console [tty0] enabled
[    0.105046] ACPI: Core revision 20230331
[    0.105261] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.105262] APIC: Switch to symmetric I/O mode setup
[    0.105263] DMAR: Host address width 39
[    0.105264] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.105267] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660=
462 ecap 19e2ff0505e
[    0.105269] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.105271] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.105272] DMAR: RMRR base: 0x0000004f421000 end: 0x0000004f440fff
[    0.105273] DMAR: RMRR base: 0x0000005c000000 end: 0x000000607fffff
[    0.105274] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.105275] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.105276] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.106882] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.106883] x2apic enabled
[    0.106899] Switched APIC routing to cluster x2apic.
[    0.111429] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x257a34a6eea, max_idle_ns: 440795264358 ns
[    0.111434] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5199.98 BogoMIPS (lpj=3D2599992)
[    0.111452] CPU0: Thermal monitoring enabled (TM1)
[    0.111479] process: using mwait in idle threads
[    0.111481] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.111482] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.111490] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.111491] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.111491] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.111492] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT
[    0.111492] RETBleed: Mitigation: Enhanced IBRS
[    0.111493] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.111494] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.111497] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.111498] SRBDS: Mitigation: Microcode
[    0.111501] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.111502] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.111503] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.111503] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.111503] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.111504] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.111505] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.111506] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.111506] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.111507] x86/fpu: xstate_offset[9]:  960, xstate_sizes[9]:    8
[    0.111507] x86/fpu: Enabled xstate features 0x21f, context size is 968 =
bytes, using 'compacted' format.
[    0.112432] Freeing SMP alternatives memory: 32K
[    0.112432] pid_max: default: 32768 minimum: 301
[    0.112432] LSM: initializing lsm=3Dcapability,landlock,yama,selinux,bpf=
,integrity
[    0.112432] landlock: Up and running.
[    0.112432] Yama: becoming mindful.
[    0.112432] SELinux:  Initializing.
[    0.112432] LSM support for eBPF active
[    0.112432] Mount-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
[    0.112432] Mountpoint-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
[    0.112432] smpboot: CPU0: Intel(R) Core(TM) i7-10750H CPU @ 2.60GHz (fa=
mily: 0x6, model: 0xa5, stepping: 0x2)
[    0.112432] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1.
[    0.112432] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1.
[    0.112432] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb=
_adjust=3D1.
[    0.112432] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.112432] ... version:                4
[    0.112432] ... bit width:              48
[    0.112432] ... generic registers:      4
[    0.112432] ... value mask:             0000ffffffffffff
[    0.112432] ... max period:             00007fffffffffff
[    0.112432] ... fixed-purpose events:   3
[    0.112432] ... event mask:             000000070000000f
[    0.112432] signal: max sigframe size: 3632
[    0.112432] Estimated ratio of average max frequency by base frequency (=
times 1024): 1811
[    0.112432] rcu: Hierarchical SRCU implementation.
[    0.112432] rcu: 	Max phase no-delay instances is 400.
[    0.112432] smp: Bringing up secondary CPUs ...
[    0.112432] smpboot: x86: Booting SMP configuration:
[    0.112432] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  =
#9 #10 #11
[    0.115275] MMIO Stale Data CPU bug present and SMT on, data leak possib=
le. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processo=
r_mmio_stale_data.html for more details.
[    0.115456] smp: Brought up 1 node, 12 CPUs
[    0.115456] smpboot: Max logical packages: 1
[    0.115456] smpboot: Total of 12 processors activated (62399.80 BogoMIPS)
[    0.117238] devtmpfs: initialized
[    0.117238] x86/mm: Memory block size: 128MB
[    0.119060] ACPI: PM: Registering ACPI NVS region [mem 0x3ae8f000-0x3ae8=
ffff] (4096 bytes)
[    0.119060] ACPI: PM: Registering ACPI NVS region [mem 0x4f8b5000-0x4ff2=
4fff] (6750208 bytes)
[    0.119060] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.119060] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)
[    0.119060] pinctrl core: initialized pinctrl subsystem
[    0.119060] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.119060] audit: initializing netlink subsys (disabled)
[    0.119060] audit: type=3D2000 audit(1688277005.007:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.119060] thermal_sys: Registered thermal governor 'bang_bang'
[    0.119060] thermal_sys: Registered thermal governor 'step_wise'
[    0.119060] thermal_sys: Registered thermal governor 'user_space'
[    0.119060] cpuidle: using governor menu
[    0.119463] Simple Boot Flag at 0x47 set to 0x80
[    0.119501] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.119553] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.119556] PCI: not using MMCONFIG
[    0.119557] PCI: Using configuration type 1 for base access
[    0.119747] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.119748] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.119748] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.119748] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.119748] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.119748] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.119748] ACPI: Added _OSI(Module Device)
[    0.119748] ACPI: Added _OSI(Processor Device)
[    0.119748] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.119748] ACPI: Added _OSI(Processor Aggregator Device)
[    0.150740] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.215706] ACPI: Dynamic OEM Table Load:
[    0.215728] ACPI: SSDT 0xFFFF9C0FC1580900 0000FC (v02 PmRef  Cpu0Psd  00=
003000 INTL 20160527)
[    0.217231] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    0.218313] ACPI: Dynamic OEM Table Load:
[    0.218321] ACPI: SSDT 0xFFFF9C0FC156D000 000502 (v02 PmRef  Cpu0Cst  00=
003001 INTL 20160527)
[    0.219399] ACPI: Dynamic OEM Table Load:
[    0.219406] ACPI: SSDT 0xFFFF9C0FC156F800 000581 (v02 PmRef  Cpu0Ist  00=
003000 INTL 20160527)
[    0.220554] ACPI: Dynamic OEM Table Load:
[    0.220560] ACPI: SSDT 0xFFFF9C0FC15C0C00 00016C (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20160527)
[    0.221547] ACPI: Dynamic OEM Table Load:
[    0.221555] ACPI: SSDT 0xFFFF9C0FC1558000 000BEA (v02 PmRef  HwpLvt   00=
003000 INTL 20160527)
[    0.222778] ACPI: Dynamic OEM Table Load:
[    0.222786] ACPI: SSDT 0xFFFF9C0FC156C800 000778 (v02 PmRef  ApIst    00=
003000 INTL 20160527)
[    0.223938] ACPI: Dynamic OEM Table Load:
[    0.223944] ACPI: SSDT 0xFFFF9C0FC1563800 0003D7 (v02 PmRef  ApHwp    00=
003000 INTL 20160527)
[    0.225062] ACPI: Dynamic OEM Table Load:
[    0.225068] ACPI: SSDT 0xFFFF9C0FC155C000 000D22 (v02 PmRef  ApPsd    00=
003000 INTL 20160527)
[    0.226522] ACPI: Dynamic OEM Table Load:
[    0.226528] ACPI: SSDT 0xFFFF9C0FC1563400 0003CA (v02 PmRef  ApCst    00=
003000 INTL 20160527)
[    0.230852] ACPI: EC: EC started
[    0.230853] ACPI: EC: interrupt blocked
[    0.232995] ACPI: EC: EC_CMD/EC_SC=3D0x934, EC_DATA=3D0x930
[    0.232998] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC used to handle tran=
sactions
[    0.232999] ACPI: Interpreter enabled
[    0.233036] ACPI: PM: (supports S0 S3 S4 S5)
[    0.233037] ACPI: Using IOAPIC for interrupt routing
[    0.233065] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.234161] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved as ACP=
I motherboard resource
[    0.234170] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.234171] PCI: Using E820 reservations for host bridge windows
[    0.234744] ACPI: Enabled 9 GPEs in block 00 to 7F
[    0.235895] ACPI: \_SB_.PCI0.PEG0.PG00: New power resource
[    0.240747] ACPI: \_SB_.PCI0.XDCI.USBC: New power resource
[    0.242376] ACPI: \_SB_.PCI0.RP01.PXP_: New power resource
[    0.246209] ACPI: \_SB_.PCI0.SAT0.VOL0.V0PR: New power resource
[    0.246301] ACPI: \_SB_.PCI0.SAT0.VOL1.V1PR: New power resource
[    0.246387] ACPI: \_SB_.PCI0.SAT0.VOL2.V2PR: New power resource
[    0.248472] ACPI: \_SB_.PCI0.CNVW.WRST: New power resource
[    0.254407] ACPI: \PIN_: New power resource
[    0.254642] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.254647] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    0.256662] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability LTR]
[    0.258277] PCI host bridge to bus 0000:00
[    0.258279] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.258280] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.258281] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000ffff=
f window]
[    0.258282] pci_bus 0000:00: root bus resource [mem 0x60800000-0xdffffff=
f window]
[    0.258283] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7ffff=
fffff window]
[    0.258284] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7ffff=
f window]
[    0.258285] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.258345] pci 0000:00:00.0: [8086:9b54] type 00 class 0x060000
[    0.258396] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
[    0.258425] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.258668] pci 0000:00:02.0: [8086:9bc4] type 00 class 0x030000
[    0.258674] pci 0000:00:02.0: reg 0x10: [mem 0x604a000000-0x604affffff 6=
4bit]
[    0.258678] pci 0000:00:02.0: reg 0x18: [mem 0x4000000000-0x400fffffff 6=
4bit pref]
[    0.258680] pci 0000:00:02.0: reg 0x20: [io  0x4000-0x403f]
[    0.258691] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.258694] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.258786] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    0.258792] pci 0000:00:04.0: reg 0x10: [mem 0x604b110000-0x604b117fff 6=
4bit]
[    0.258955] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.258960] pci 0000:00:08.0: reg 0x10: [mem 0x604b12b000-0x604b12bfff 6=
4bit]
[    0.259058] pci 0000:00:12.0: [8086:06f9] type 00 class 0x118000
[    0.259070] pci 0000:00:12.0: reg 0x10: [mem 0x604b12a000-0x604b12afff 6=
4bit]
[    0.259198] pci 0000:00:13.0: [8086:06fc] type 00 class 0x070000
[    0.259213] pci 0000:00:13.0: reg 0x10: [mem 0x604b122000-0x604b123fff 6=
4bit]
[    0.259266] pci 0000:00:13.0: PME# supported from D0 D3hot
[    0.259526] pci 0000:00:14.0: [8086:06ed] type 00 class 0x0c0330
[    0.259538] pci 0000:00:14.0: reg 0x10: [mem 0x604b100000-0x604b10ffff 6=
4bit]
[    0.259587] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.259799] pci 0000:00:14.2: [8086:06ef] type 00 class 0x050000
[    0.259813] pci 0000:00:14.2: reg 0x10: [mem 0x604b120000-0x604b121fff 6=
4bit]
[    0.259822] pci 0000:00:14.2: reg 0x18: [mem 0x604b129000-0x604b129fff 6=
4bit]
[    0.260021] pci 0000:00:14.3: [8086:06f0] type 00 class 0x028000
[    0.260036] pci 0000:00:14.3: reg 0x10: [mem 0x604b11c000-0x604b11ffff 6=
4bit]
[    0.260192] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.260419] pci 0000:00:15.0: [8086:06e8] type 00 class 0x0c8000
[    0.260481] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.260823] pci 0000:00:15.1: [8086:06e9] type 00 class 0x0c8000
[    0.260873] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.261132] pci 0000:00:16.0: [8086:06e0] type 00 class 0x078000
[    0.261150] pci 0000:00:16.0: reg 0x10: [mem 0x604b126000-0x604b126fff 6=
4bit]
[    0.261215] pci 0000:00:16.0: PME# supported from D3hot
[    0.261539] pci 0000:00:1c.0: [8086:06b8] type 01 class 0x060400
[    0.261608] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.262001] pci 0000:00:1c.6: [8086:06be] type 01 class 0x060400
[    0.262069] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.262442] pci 0000:00:1d.0: [8086:06b0] type 01 class 0x060400
[    0.262519] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.263000] pci 0000:00:1e.0: [8086:06a8] type 00 class 0x078000
[    0.263050] pci 0000:00:1e.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.263330] pci 0000:00:1f.0: [8086:068e] type 00 class 0x060100
[    0.263573] pci 0000:00:1f.3: [8086:06c8] type 00 class 0x040380
[    0.263603] pci 0000:00:1f.3: reg 0x10: [mem 0x604b118000-0x604b11bfff 6=
4bit]
[    0.263639] pci 0000:00:1f.3: reg 0x20: [mem 0x604b000000-0x604b0fffff 6=
4bit]
[    0.263712] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.264110] pci 0000:00:1f.4: [8086:06a3] type 00 class 0x0c0500
[    0.264130] pci 0000:00:1f.4: reg 0x10: [mem 0x604b124000-0x604b1240ff 6=
4bit]
[    0.264152] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.264302] pci 0000:00:1f.5: [8086:06a4] type 00 class 0x0c8000
[    0.264315] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    0.264436] pci 0000:01:00.0: [10de:1f95] type 00 class 0x030200
[    0.264454] pci 0000:01:00.0: reg 0x10: [mem 0xb3000000-0xb3ffffff]
[    0.264468] pci 0000:01:00.0: reg 0x14: [mem 0x70000000-0x7fffffff 64bit=
 pref]
[    0.264482] pci 0000:01:00.0: reg 0x1c: [mem 0x80000000-0x81ffffff 64bit=
 pref]
[    0.264490] pci 0000:01:00.0: reg 0x24: [io  0x3000-0x307f]
[    0.264498] pci 0000:01:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    0.264574] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.264612] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 126.016 Gb/s with =
8.0 GT/s PCIe x16 link)
[    0.264752] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.264754] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    0.264755] pci 0000:00:01.0:   bridge window [mem 0xb3000000-0xb3ffffff]
[    0.264757] pci 0000:00:01.0:   bridge window [mem 0x70000000-0x81ffffff=
 64bit pref]
[    0.264816] pci 0000:02:00.0: [8086:15ea] type 01 class 0x060400
[    0.264862] pci 0000:02:00.0: enabling Extended Tags
[    0.264953] pci 0000:02:00.0: supports D1 D2
[    0.264953] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.265130] pci 0000:00:1c.0: PCI bridge to [bus 02-6b]
[    0.265134] pci 0000:00:1c.0:   bridge window [mem 0x84000000-0xb20fffff]
[    0.265137] pci 0000:00:1c.0:   bridge window [mem 0x6000000000-0x6049ff=
ffff 64bit pref]
[    0.265202] pci 0000:03:00.0: [8086:15ea] type 01 class 0x060400
[    0.265251] pci 0000:03:00.0: enabling Extended Tags
[    0.265342] pci 0000:03:00.0: supports D1 D2
[    0.265342] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.265504] pci 0000:03:01.0: [8086:15ea] type 01 class 0x060400
[    0.265552] pci 0000:03:01.0: enabling Extended Tags
[    0.265645] pci 0000:03:01.0: supports D1 D2
[    0.265646] pci 0000:03:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.265803] pci 0000:03:02.0: [8086:15ea] type 01 class 0x060400
[    0.265851] pci 0000:03:02.0: enabling Extended Tags
[    0.265939] pci 0000:03:02.0: supports D1 D2
[    0.265940] pci 0000:03:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.266099] pci 0000:03:04.0: [8086:15ea] type 01 class 0x060400
[    0.266146] pci 0000:03:04.0: enabling Extended Tags
[    0.266239] pci 0000:03:04.0: supports D1 D2
[    0.266240] pci 0000:03:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.266393] pci 0000:02:00.0: PCI bridge to [bus 03-6b]
[    0.266400] pci 0000:02:00.0:   bridge window [mem 0x84000000-0xb1ffffff]
[    0.266405] pci 0000:02:00.0:   bridge window [mem 0x6000000000-0x6049ff=
ffff 64bit pref]
[    0.266466] pci 0000:04:00.0: [8086:15eb] type 00 class 0x088000
[    0.266481] pci 0000:04:00.0: reg 0x10: [mem 0xb1f00000-0xb1f3ffff]
[    0.266489] pci 0000:04:00.0: reg 0x14: [mem 0xb1f40000-0xb1f40fff]
[    0.266531] pci 0000:04:00.0: enabling Extended Tags
[    0.266628] pci 0000:04:00.0: supports D1 D2
[    0.266629] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.266802] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.266809] pci 0000:03:00.0:   bridge window [mem 0xb1f00000-0xb1ffffff]
[    0.266850] pci 0000:03:01.0: PCI bridge to [bus 05-37]
[    0.266857] pci 0000:03:01.0:   bridge window [mem 0x9b000000-0xb1efffff]
[    0.266862] pci 0000:03:01.0:   bridge window [mem 0x6025000000-0x6049ff=
ffff 64bit pref]
[    0.266930] pci 0000:38:00.0: [8086:15ec] type 00 class 0x0c0330
[    0.266950] pci 0000:38:00.0: reg 0x10: [mem 0x9af00000-0x9af0ffff]
[    0.267020] pci 0000:38:00.0: enabling Extended Tags
[    0.267132] pci 0000:38:00.0: supports D1 D2
[    0.267132] pci 0000:38:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.267207] pci 0000:38:00.0: 8.000 Gb/s available PCIe bandwidth, limit=
ed by 2.5 GT/s PCIe x4 link at 0000:03:02.0 (capable of 31.504 Gb/s with 8.=
0 GT/s PCIe x4 link)
[    0.267341] pci 0000:03:02.0: PCI bridge to [bus 38]
[    0.267348] pci 0000:03:02.0:   bridge window [mem 0x9af00000-0x9affffff]
[    0.267389] pci 0000:03:04.0: PCI bridge to [bus 39-6b]
[    0.267397] pci 0000:03:04.0:   bridge window [mem 0x84000000-0x9aefffff]
[    0.267402] pci 0000:03:04.0:   bridge window [mem 0x6000000000-0x6024ff=
ffff 64bit pref]
[    0.267477] pci 0000:6c:00.0: [10ec:5260] type 00 class 0xff0000
[    0.267490] pci 0000:6c:00.0: reg 0x10: [mem 0xb4100000-0xb4100fff]
[    0.267596] pci 0000:6c:00.0: supports D1 D2
[    0.267597] pci 0000:6c:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.267749] pci 0000:00:1c.6: PCI bridge to [bus 6c]
[    0.267752] pci 0000:00:1c.6:   bridge window [mem 0xb4100000-0xb41fffff]
[    0.267842] pci 0000:6d:00.0: [1c5c:1639] type 00 class 0x010802
[    0.267860] pci 0000:6d:00.0: reg 0x10: [mem 0xb4000000-0xb4003fff 64bit]
[    0.267868] pci 0000:6d:00.0: reg 0x18: [mem 0xb4005000-0xb4005fff]
[    0.267875] pci 0000:6d:00.0: reg 0x1c: [mem 0xb4004000-0xb4004fff]
[    0.268114] pci 0000:00:1d.0: PCI bridge to [bus 6d]
[    0.268118] pci 0000:00:1d.0:   bridge window [mem 0xb4000000-0xb40fffff]
[    0.275804] Low-power S0 idle used by default for system suspend
[    0.279107] ACPI: EC: interrupt unblocked
[    0.279108] ACPI: EC: event unblocked
[    0.279113] ACPI: EC: EC_CMD/EC_SC=3D0x934, EC_DATA=3D0x930
[    0.279114] ACPI: EC: GPE=3D0x6e
[    0.279115] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC initialization comp=
lete
[    0.279116] ACPI: \_SB_.PCI0.LPCB.ECDV: EC: Used to handle transactions =
and events
[    0.279166] iommu: Default domain type: Translated=20
[    0.279167] iommu: DMA domain TLB invalidation policy: lazy mode=20
[    0.279437] efivars: Registered efivars operations
[    0.279524] NetLabel: Initializing
[    0.279525] NetLabel:  domain hash size =3D 128
[    0.279526] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.279533] NetLabel:  unlabeled traffic allowed by default
[    0.279534] PCI: Using ACPI for IRQ routing
[    0.308953] PCI: pci_cache_line_size set to 64 bytes
[    0.309263] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.309264] e820: reserve RAM buffer [mem 0x3ae8f000-0x3bffffff]
[    0.309265] e820: reserve RAM buffer [mem 0x49555000-0x4bffffff]
[    0.309266] e820: reserve RAM buffer [mem 0x4c569018-0x4fffffff]
[    0.309267] e820: reserve RAM buffer [mem 0x4c826000-0x4fffffff]
[    0.309267] e820: reserve RAM buffer [mem 0x89b800000-0x89bffffff]
[    0.309451] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.309451] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.309451] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.309451] vgaarb: loaded
[    0.310432] clocksource: Switched to clocksource tsc-early
[    0.310441] VFS: Disk quotas dquot_6.6.0
[    0.310441] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.310441] pnp: PnP ACPI init
[    0.310441] system 00:00: [mem 0x40000000-0x403fffff] could not be reser=
ved
[    0.310747] system 00:01: [io  0x1800-0x18fe] has been reserved
[    0.310750] system 00:01: [mem 0xfd000000-0xfd69ffff] has been reserved
[    0.310752] system 00:01: [mem 0xfd6c0000-0xfd6cffff] has been reserved
[    0.310753] system 00:01: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.310754] system 00:01: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.310755] system 00:01: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.310756] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    0.310945] system 00:02: [io  0x2000-0x20fe] has been reserved
[    0.311033] system 00:03: [io  0x0680-0x069f] has been reserved
[    0.311034] system 00:03: [io  0x164e-0x164f] has been reserved
[    0.311104] system 00:05: [io  0x1854-0x1857] has been reserved
[    0.311907] system 00:08: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.311909] system 00:08: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.311910] system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.311911] system 00:08: [mem 0xe0000000-0xefffffff] has been reserved
[    0.311912] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.311913] system 00:08: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.311914] system 00:08: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.311915] system 00:08: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.312144] system 00:09: [mem 0xfe038000-0xfe038fff] has been reserved
[    0.314563] pnp: PnP ACPI: found 10 devices
[    0.320042] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.320075] NET: Registered PF_INET protocol family
[    0.320177] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.321927] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6=
, 262144 bytes, linear)
[    0.321944] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.321952] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)
[    0.322095] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.322288] TCP: Hash tables configured (established 262144 bind 65536)
[    0.322367] MPTCP token hash table entries: 32768 (order: 7, 786432 byte=
s, linear)
[    0.322402] UDP hash table entries: 16384 (order: 7, 524288 bytes, linea=
r)
[    0.322440] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
[    0.322501] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.322505] NET: Registered PF_XDP protocol family
[    0.322507] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffff=
ff pref]: no compatible bridge window
[    0.322511] pci 0000:03:01.0: bridge window [io  0x1000-0x0fff] to [bus =
05-37] add_size 1000
[    0.322513] pci 0000:03:04.0: bridge window [io  0x1000-0x0fff] to [bus =
39-6b] add_size 1000
[    0.322514] pci 0000:02:00.0: bridge window [io  0x1000-0x0fff] to [bus =
03-6b] add_size 2000
[    0.322515] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus =
02-6b] add_size 3000
[    0.322521] pci 0000:00:15.0: BAR 0: assigned [mem 0x4010000000-0x401000=
0fff 64bit]
[    0.322564] pci 0000:00:15.1: BAR 0: assigned [mem 0x4010001000-0x401000=
1fff 64bit]
[    0.322608] pci 0000:00:1c.0: BAR 13: assigned [io  0x5000-0x7fff]
[    0.322610] pci 0000:00:1e.0: BAR 0: assigned [mem 0x4010002000-0x401000=
2fff 64bit]
[    0.322655] pci 0000:01:00.0: BAR 6: no space for [mem size 0x00080000 p=
ref]
[    0.322657] pci 0000:01:00.0: BAR 6: failed to assign [mem size 0x000800=
00 pref]
[    0.322658] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.322661] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    0.322662] pci 0000:00:01.0:   bridge window [mem 0xb3000000-0xb3ffffff]
[    0.322664] pci 0000:00:01.0:   bridge window [mem 0x70000000-0x81ffffff=
 64bit pref]
[    0.322667] pci 0000:02:00.0: BAR 13: assigned [io  0x5000-0x6fff]
[    0.322668] pci 0000:03:01.0: BAR 13: assigned [io  0x5000-0x5fff]
[    0.322669] pci 0000:03:04.0: BAR 13: assigned [io  0x6000-0x6fff]
[    0.322670] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.322677] pci 0000:03:00.0:   bridge window [mem 0xb1f00000-0xb1ffffff]
[    0.322684] pci 0000:03:01.0: PCI bridge to [bus 05-37]
[    0.322686] pci 0000:03:01.0:   bridge window [io  0x5000-0x5fff]
[    0.322690] pci 0000:03:01.0:   bridge window [mem 0x9b000000-0xb1efffff]
[    0.322693] pci 0000:03:01.0:   bridge window [mem 0x6025000000-0x6049ff=
ffff 64bit pref]
[    0.322698] pci 0000:03:02.0: PCI bridge to [bus 38]
[    0.322702] pci 0000:03:02.0:   bridge window [mem 0x9af00000-0x9affffff]
[    0.322709] pci 0000:03:04.0: PCI bridge to [bus 39-6b]
[    0.322711] pci 0000:03:04.0:   bridge window [io  0x6000-0x6fff]
[    0.322714] pci 0000:03:04.0:   bridge window [mem 0x84000000-0x9aefffff]
[    0.322717] pci 0000:03:04.0:   bridge window [mem 0x6000000000-0x6024ff=
ffff 64bit pref]
[    0.322722] pci 0000:02:00.0: PCI bridge to [bus 03-6b]
[    0.322724] pci 0000:02:00.0:   bridge window [io  0x5000-0x6fff]
[    0.322727] pci 0000:02:00.0:   bridge window [mem 0x84000000-0xb1ffffff]
[    0.322730] pci 0000:02:00.0:   bridge window [mem 0x6000000000-0x6049ff=
ffff 64bit pref]
[    0.322735] pci 0000:00:1c.0: PCI bridge to [bus 02-6b]
[    0.322736] pci 0000:00:1c.0:   bridge window [io  0x5000-0x7fff]
[    0.322739] pci 0000:00:1c.0:   bridge window [mem 0x84000000-0xb20fffff]
[    0.322741] pci 0000:00:1c.0:   bridge window [mem 0x6000000000-0x6049ff=
ffff 64bit pref]
[    0.322744] pci 0000:00:1c.6: PCI bridge to [bus 6c]
[    0.322746] pci 0000:00:1c.6:   bridge window [mem 0xb4100000-0xb41fffff]
[    0.322751] pci 0000:00:1d.0: PCI bridge to [bus 6d]
[    0.322753] pci 0000:00:1d.0:   bridge window [mem 0xb4000000-0xb40fffff]
[    0.322760] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.322761] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.322762] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff windo=
w]
[    0.322763] pci_bus 0000:00: resource 7 [mem 0x60800000-0xdfffffff windo=
w]
[    0.322764] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff w=
indow]
[    0.322764] pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff windo=
w]
[    0.322765] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[    0.322766] pci_bus 0000:01: resource 1 [mem 0xb3000000-0xb3ffffff]
[    0.322767] pci_bus 0000:01: resource 2 [mem 0x70000000-0x81ffffff 64bit=
 pref]
[    0.322768] pci_bus 0000:02: resource 0 [io  0x5000-0x7fff]
[    0.322768] pci_bus 0000:02: resource 1 [mem 0x84000000-0xb20fffff]
[    0.322769] pci_bus 0000:02: resource 2 [mem 0x6000000000-0x6049ffffff 6=
4bit pref]
[    0.322770] pci_bus 0000:03: resource 0 [io  0x5000-0x6fff]
[    0.322771] pci_bus 0000:03: resource 1 [mem 0x84000000-0xb1ffffff]
[    0.322771] pci_bus 0000:03: resource 2 [mem 0x6000000000-0x6049ffffff 6=
4bit pref]
[    0.322772] pci_bus 0000:04: resource 1 [mem 0xb1f00000-0xb1ffffff]
[    0.322773] pci_bus 0000:05: resource 0 [io  0x5000-0x5fff]
[    0.322774] pci_bus 0000:05: resource 1 [mem 0x9b000000-0xb1efffff]
[    0.322775] pci_bus 0000:05: resource 2 [mem 0x6025000000-0x6049ffffff 6=
4bit pref]
[    0.322776] pci_bus 0000:38: resource 1 [mem 0x9af00000-0x9affffff]
[    0.322776] pci_bus 0000:39: resource 0 [io  0x6000-0x6fff]
[    0.322777] pci_bus 0000:39: resource 1 [mem 0x84000000-0x9aefffff]
[    0.322778] pci_bus 0000:39: resource 2 [mem 0x6000000000-0x6024ffffff 6=
4bit pref]
[    0.322779] pci_bus 0000:6c: resource 1 [mem 0xb4100000-0xb41fffff]
[    0.322780] pci_bus 0000:6d: resource 1 [mem 0xb4000000-0xb40fffff]
[    0.323476] PCI: CLS 0 bytes, default 64
[    0.323492] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.323493] software IO TLB: mapped [mem 0x0000000045555000-0x0000000049=
555000] (64MB)
[    0.323511] Unpacking initramfs...
[    0.323524] sgx: EPC section 0x50200000-0x55ffffff
[    0.323958] Initialise system trusted keyrings
[    0.323976] workingset: timestamp_bits=3D40 max_order=3D23 bucket_order=
=3D0
[    0.323984] zbud: loaded
[    0.324147] Key type asymmetric registered
[    0.324148] Asymmetric key parser 'x509' registered
[    0.324154] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    0.324174] io scheduler mq-deadline registered
[    0.324175] io scheduler kyber registered
[    0.324343] pcieport 0000:00:01.0: PME: Signaling with IRQ 122
[    0.324414] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[    0.324428] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    0.324624] pcieport 0000:00:1c.6: PME: Signaling with IRQ 124
[    0.324770] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    0.325171] pcieport 0000:03:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    0.325511] pcieport 0000:03:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    0.325762] Monitor-Mwait will be used to enter C-1 state
[    0.325768] Monitor-Mwait will be used to enter C-2 state
[    0.325773] Monitor-Mwait will be used to enter C-3 state
[    0.325776] ACPI: \_SB_.PR00: Found 3 idle states
[    0.340800] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.341131] hpet_acpi_add: no address or irqs in _CRS
[    0.342364] intel_pstate: Intel P-state driver initializing
[    0.342934] intel_pstate: HWP enabled
[    0.342947] efifb: probing for efifb
[    0.342958] efifb: Ignoring BGRT: unexpected or invalid BMP data
[    0.342959] efifb: framebuffer at 0x4000000000, using 36000k, total 3600=
0k
[    0.342960] efifb: mode is 3840x2400x32, linelength=3D15360, pages=3D1
[    0.342961] efifb: scrolling: redraw
[    0.342961] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.342987] fbcon: Deferring console take-over
[    0.342988] fb0: EFI VGA frame buffer device
[    0.343057] drop_monitor: Initializing network drop monitor service
[    0.343106] NET: Registered PF_INET6 protocol family
[    0.360230] Freeing initrd memory: 17388K
[    0.361004] Segment Routing with IPv6
[    0.361032] In-situ OAM (IOAM) with IPv6
[    0.361897] microcode: Microcode Update Driver: v2.2.
[    0.361901] IPI shorthand broadcast: enabled
[    0.362516] sched_clock: Marking stable (356000966, 6444129)->(381388304=
, -18943209)
[    0.362670] registered taskstats version 1
[    0.362708] Loading compiled-in X.509 certificates
[    0.363726] Key type .fscrypt registered
[    0.363727] Key type fscrypt-provisioning registered
[    0.363945] clk: Disabling unused clocks
[    0.364606] Freeing unused kernel image (initmem) memory: 2808K
[    0.372567] Write protecting the kernel read-only data: 20480k
[    0.373102] Freeing unused kernel image (rodata/data gap) memory: 1620K
[    0.373107] Run /init as init process
[    0.373107]   with arguments:
[    0.373108]     /init
[    0.373108]   with environment:
[    0.373109]     HOME=3D/
[    0.373109]     TERM=3Dlinux
[    0.374822] fbcon: Taking over console
[    0.374869] Console: switching to colour frame buffer device 480x150
[    0.393915] stage-1-init: [Sun Jul  2 05:50:05 UTC 2023] loading module =
dm_mod...
[    0.400028] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@redhat.com
[    0.400701] stage-1-init: [Sun Jul  2 05:50:05 UTC 2023] running udev...
[    0.407120] stage-1-init: [Sun Jul  2 05:50:05 UTC 2023] Starting versio=
n 251.16
[    0.452344] rtc_cmos 00:04: RTC can wake from S4
[    0.453441] rtc_cmos 00:04: registered as rtc0
[    0.453476] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram
[    0.453868] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0=
x60,0x64 irq 1,12
[    0.454247] i8042: Warning: Keylock active
[    0.456699] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.456712] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.469302] ACPI: bus type USB registered
[    0.469329] usbcore: registered new interface driver usbfs
[    0.469335] usbcore: registered new interface driver hub
[    0.469343] usbcore: registered new device driver usb
[    0.472318] nvme 0000:6d:00.0: platform quirk: setting simple suspend
[    0.472370] nvme nvme0: pci function 0000:6d:00.0
[    0.472657] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[    0.579708] nvme nvme0: missing or invalid SUBNQN field.
[    0.723639] nvme nvme0: 12/0/0 default/read/poll queues
[    0.728939]  nvme0n1: p1 p2 p3 p4 p5 p6 p7
[    0.731201] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.731211] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    0.732277] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[    0.732503] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.732505] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    0.732506] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.732544] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.04
[    0.732545] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.732546] usb usb1: Product: xHCI Host Controller
[    0.732547] usb usb1: Manufacturer: Linux 6.4.0 xhci-hcd
[    0.732547] usb usb1: SerialNumber: 0000:00:14.0
[    0.732671] hub 1-0:1.0: USB hub found
[    0.732685] hub 1-0:1.0: 16 ports detected
[    0.733635] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.04
[    0.733637] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.733638] usb usb2: Product: xHCI Host Controller
[    0.733639] usb usb2: Manufacturer: Linux 6.4.0 xhci-hcd
[    0.733639] usb usb2: SerialNumber: 0000:00:14.0
[    0.733690] hub 2-0:1.0: USB hub found
[    0.733702] hub 2-0:1.0: 10 ports detected
[    0.733884] usb: port power management may be unreliable
[    0.734375] xhci_hcd 0000:38:00.0: xHCI Host Controller
[    0.734377] xhci_hcd 0000:38:00.0: new USB bus registered, assigned bus =
number 3
[    0.735548] xhci_hcd 0000:38:00.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000200009810
[    0.735764] xhci_hcd 0000:38:00.0: xHCI Host Controller
[    0.735765] xhci_hcd 0000:38:00.0: new USB bus registered, assigned bus =
number 4
[    0.735766] xhci_hcd 0000:38:00.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.735806] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.04
[    0.735808] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.735809] usb usb3: Product: xHCI Host Controller
[    0.735809] usb usb3: Manufacturer: Linux 6.4.0 xhci-hcd
[    0.735810] usb usb3: SerialNumber: 0000:38:00.0
[    0.735895] hub 3-0:1.0: USB hub found
[    0.735906] hub 3-0:1.0: 2 ports detected
[    0.736110] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.04
[    0.736112] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.736112] usb usb4: Product: xHCI Host Controller
[    0.736113] usb usb4: Manufacturer: Linux 6.4.0 xhci-hcd
[    0.736114] usb usb4: SerialNumber: 0000:38:00.0
[    0.736164] hub 4-0:1.0: USB hub found
[    0.736174] hub 4-0:1.0: 2 ports detected
[    0.855342] stage-1-init: [Sun Jul  2 05:50:05 UTC 2023] starting device=
 mapper and LVM...
[    0.886979] stage-1-init: [Sun Jul  2 05:50:05 UTC 2023] failed to resum=
e...
[    0.895733] stage-1-init: [Sun Jul  2 05:50:05 UTC 2023] checking /dev/d=
isk/by-uuid/65836401-c468-4091-8879-de0c759aab27...
[    0.896228] stage-1-init: [Sun Jul  2 05:50:05 UTC 2023] fsck (busybox 1=
.35.0)
[    0.896794] stage-1-init: [Sun Jul  2 05:50:05 UTC 2023] [fsck.ext4 (1) =
-- /mnt-root/] fsck.ext4 -a /dev/disk/by-uuid/65836401-c468-4091-8879-de0c7=
59aab27
[    0.899359] stage-1-init: [Sun Jul  2 05:50:05 UTC 2023] /dev/disk/by-uu=
id/65836401-c468-4091-8879-de0c759aab27: clean, 6148338/32006144 files, 107=
133408/128000000 blocks
[    0.900352] stage-1-init: [Sun Jul  2 05:50:05 UTC 2023] mounting /dev/d=
isk/by-uuid/65836401-c468-4091-8879-de0c759aab27 on /...
[    0.950214] EXT4-fs (nvme0n1p7): mounted filesystem 65836401-c468-4091-8=
879-de0c759aab27 r/w with ordered data mode. Quota mode: none.
[    0.976501] usb 1-10: new full-speed USB device number 2 using xhci_hcd
[    1.059199] EXT4-fs (nvme0n1p7): re-mounted 65836401-c468-4091-8879-de0c=
759aab27 r/w. Quota mode: none.
[    1.059350] booting system configuration /nix/store/9q5yllrjcbas13g2cb4w=
jcmwdapdg890-nixos-system-athena-22.11.20230701.dirty
[    1.075278] stage-2-init: running activation script...
[    1.105414] usb 1-10: New USB device found, idVendor=3D27c6, idProduct=
=3D533c, bcdDevice=3D 1.00
[    1.105417] usb 1-10: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D0
[    1.105418] usb 1-10: Product: FingerPrint
[    1.105419] usb 1-10: Manufacturer: Goodix
[    1.181097] stage-2-init: setting up /etc...
[    1.216749] stage-2-init: removing obsolete symlink =E2=80=98/etc/egl/eg=
l_external_platform.d=E2=80=99...
[    1.217938] stage-2-init: removing obsolete symlink =E2=80=98/etc/blueto=
oth/network.conf=E2=80=99...
[    1.218026] stage-2-init: removing obsolete symlink =E2=80=98/etc/blueto=
oth/input.conf=E2=80=99...
[    1.219485] usb 1-11: new high-speed USB device number 3 using xhci_hcd
[    1.225553] stage-2-init: removing obsolete symlink =E2=80=98/etc/nvidia=
/nvidia-application-profiles-rc=E2=80=99...
[    1.240063] stage-2-init: removing obsolete symlink =E2=80=98/etc/system=
d/network/40-vboxnet0.link=E2=80=99...
[    1.359452] tsc: Refined TSC clocksource calibration: 2591.999 MHz
[    1.359480] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x255=
cb5c6a11, max_idle_ns: 440795249002 ns
[    1.359541] clocksource: Switched to clocksource tsc
[    1.360193] usb 1-11: New USB device found, idVendor=3D0c45, idProduct=
=3D6d14, bcdDevice=3D92.67
[    1.360195] usb 1-11: New USB device strings: Mfr=3D2, Product=3D1, Seri=
alNumber=3D0
[    1.360196] usb 1-11: Product: Integrated_Webcam_HD
[    1.360197] usb 1-11: Manufacturer: Sonix Technology Co., Ltd.
[    1.428080] systemd[1]: Inserted module 'autofs4'
[    1.475607] usb 1-14: new full-speed USB device number 4 using xhci_hcd
[    1.499893] systemd[1]: systemd 251.16 running in system mode (+PAM +AUD=
IT -SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +B=
LKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK=
 +PCRE2 -PWQUALITY -P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF=
_FRAMEWORK -XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    1.499896] systemd[1]: Detected architecture x86-64.
[    1.537068] systemd[1]: bpf-lsm: Failed to load BPF object: No such proc=
ess
[    1.550840] block nvme0n1: the capability attribute has been deprecated.
[    1.603264] usb 1-14: New USB device found, idVendor=3D8087, idProduct=
=3D0026, bcdDevice=3D 0.02
[    1.603266] usb 1-14: New USB device strings: Mfr=3D0, Product=3D0, Seri=
alNumber=3D0
[    1.665662] systemd[1]: /etc/systemd/system/cups.socket:6: ListenStream=
=3D references a path below legacy directory /var/run/, updating /var/run/c=
ups/cups.sock =E2=86=92 /run/cups/cups.sock; please update the unit file ac=
cordingly.
[    1.669870] systemd[1]: plymouth-quit.service: Service has no ExecStart=
=3D, ExecStop=3D, or SuccessAction=3D. Refusing.
[    1.671220] systemd[1]: Queued start job for default target Graphical In=
terface.
[    1.682209] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[    1.682649] systemd[1]: Created slice Slice /system/getty.
[    1.682895] systemd[1]: Created slice Slice /system/modprobe.
[    1.683129] systemd[1]: Created slice Slice /system/systemd-fsck.
[    1.683361] systemd[1]: Created slice User and Session Slice.
[    1.683422] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    1.683476] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    1.683526] systemd[1]: Reached target Local Encrypted Volumes.
[    1.683561] systemd[1]: Reached target Containers.
[    1.683598] systemd[1]: Reached target Path Units.
[    1.683631] systemd[1]: Reached target Slice Units.
[    1.685898] systemd[1]: Listening on RPCbind Server Activation Socket.
[    1.685947] systemd[1]: Reached target RPC Port Mapper.
[    1.686691] systemd[1]: Listening on Process Core Dump Socket.
[    1.686805] systemd[1]: Listening on Journal Audit Socket.
[    1.686889] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.686979] systemd[1]: Listening on Journal Socket.
[    1.687058] systemd[1]: Listening on Userspace Out-Of-Memory (OOM) Kille=
r Socket.
[    1.687469] systemd[1]: Listening on udev Control Socket.
[    1.687606] systemd[1]: Listening on udev Kernel Socket.
[    1.688155] systemd[1]: Mounting Huge Pages File System...
[    1.688776] systemd[1]: Mounting POSIX Message Queue File System...
[    1.689302] systemd[1]: Mounting NFSD configuration filesystem...
[    1.689963] systemd[1]: Mounting Kernel Debug File System...
[    1.690047] systemd[1]: Kernel Module supporting RPCSEC_GSS was skipped =
because of a failed condition check (ConditionPathExists=3D/etc/krb5.keytab=
).
[    1.690817] systemd[1]: Starting Create List of Static Device Nodes...
[    1.691401] systemd[1]: Starting Initialisation of swap device /swapfile=
...
[    1.692063] systemd[1]: Starting Load Kernel Module configfs...
[    1.692705] systemd[1]: Starting Load Kernel Module drm...
[    1.693336] systemd[1]: Starting Load Kernel Module fuse...
[    1.693903] systemd[1]: Starting mount-pstore.service...
[    1.693999] systemd[1]: File System Check on Root Device was skipped bec=
ause of a failed condition check (ConditionPathIsReadWrite=3D!/).
[    1.694818] systemd[1]: Starting Journal Service...
[    1.695853] systemd[1]: Starting Load Kernel Modules...
[    1.696784] systemd[1]: Starting Remount Root and Kernel File Systems...
[    1.697686] systemd[1]: Starting Coldplug All udev Devices...
[    1.699417] systemd[1]: Mounted Huge Pages File System.
[    1.699549] systemd[1]: Mounted POSIX Message Queue File System.
[    1.699661] systemd[1]: Mounted Kernel Debug File System.
[    1.699866] systemd[1]: Finished Create List of Static Device Nodes.
[    1.700165] systemd[1]: mkswap-swapfile.service: Deactivated successfull=
y.
[    1.700281] systemd[1]: Finished Initialisation of swap device /swapfile.
[    1.700540] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    1.700681] systemd[1]: Finished Load Kernel Module configfs.
[    1.700731] fuse: init (API version 7.38)
[    1.701529] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    1.701654] systemd[1]: Finished Load Kernel Module fuse.
[    1.702682] systemd[1]: Mounting FUSE Control File System...
[    1.703241] EXT4-fs (nvme0n1p7): re-mounted 65836401-c468-4091-8879-de0c=
759aab27 r/w. Quota mode: none.
[    1.703738] systemd[1]: Mounting Kernel Configuration File System...
[    1.704716] systemd[1]: Starting Create Static Device Nodes in /dev...
[    1.706099] systemd[1]: Finished Remount Root and Kernel File Systems.
[    1.706276] systemd[1]: Mounted FUSE Control File System.
[    1.706387] systemd[1]: Mounted Kernel Configuration File System.
[    1.707309] systemd[1]: Activating swap /swapfile...
[    1.708232] systemd[1]: Starting Load/Save Random Seed...
[    1.712180] systemd[1]: Finished Create Static Device Nodes in /dev.
[    1.712286] audit: type=3D1130 audit(1688277006.599:2): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-tmpf=
iles-setup-dev comm=3D"systemd" exe=3D"/nix/store/13vzx8g3ldkga0hl21706a9pi=
w95dzng-systemd-251.16/lib/systemd/systemd" hostname=3D? addr=3D? terminal=
=3D? res=3Dsuccess'
[    1.712355] systemd[1]: Reached target Preparation for Local File System=
s.
[    1.713159] Adding 33554428k swap on /swapfile.  Priority:-2 extents:382=
 across:511803392k SSFS
[    1.713454] systemd[1]: Set up automount mnt-heracles.automount.
[    1.713582] systemd[1]: Set up automount Debug Symbols File System.
[    1.713998] audit: type=3D1334 audit(1688277006.601:3): prog-id=3D78 op=
=3DLOAD
[    1.714029] audit: type=3D1334 audit(1688277006.601:4): prog-id=3D79 op=
=3DLOAD
[    1.714558] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[    1.714666] systemd[1]: Activated swap /swapfile.
[    1.715613] systemd[1]: Finished Load/Save Random Seed.
[    1.715688] audit: type=3D1130 audit(1688277006.603:5): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-rand=
om-seed comm=3D"systemd" exe=3D"/nix/store/13vzx8g3ldkga0hl21706a9piw95dzng=
-systemd-251.16/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[    1.715786] systemd[1]: Reached target Swaps.
[    1.725766] RPC: Registered named UNIX socket transport module.
[    1.725768] RPC: Registered udp transport module.
[    1.725768] RPC: Registered tcp transport module.
[    1.725769] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.727606] ACPI: bus type drm_connector registered
[    1.728113] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    1.728258] systemd[1]: Finished Load Kernel Module drm.
[    1.728336] audit: type=3D1130 audit(1688277006.615:6): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dmodprobe@drm=
 comm=3D"systemd" exe=3D"/nix/store/13vzx8g3ldkga0hl21706a9piw95dzng-system=
d-251.16/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
[    1.728343] audit: type=3D1131 audit(1688277006.615:7): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dmodprobe@drm=
 comm=3D"systemd" exe=3D"/nix/store/13vzx8g3ldkga0hl21706a9piw95dzng-system=
d-251.16/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
[    1.735613] systemd[1]: Started Journal Service.
[    1.735720] audit: type=3D1130 audit(1688277006.623:8): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-jour=
nald comm=3D"systemd" exe=3D"/nix/store/13vzx8g3ldkga0hl21706a9piw95dzng-sy=
stemd-251.16/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
[    1.736190] audit: type=3D1334 audit(1688277006.623:9): prog-id=3D80 op=
=3DLOAD
[    1.736231] audit: type=3D1334 audit(1688277006.623:10): prog-id=3D81 op=
=3DLOAD
[    1.740588] systemd-journald[627]: Received client request to flush runt=
ime journal.
[    1.741305] systemd-journald[627]: File /var/log/journal/db70a9ba05a34ea=
885e2a138a113f18d/system.journal corrupted or uncleanly shut down, renaming=
 and replacing.
[    1.789712] ACPI: AC: AC Adapter [AC] (on-line)
[    1.790068] input: Intel HID events as /devices/platform/INT33D5:00/inpu=
t/input2
[    1.790142] intel-hid INT33D5:00: platform supports 5 button array
[    1.790174] input: Intel HID 5 button array as /devices/platform/INT33D5=
:00/input/input3
[    1.791034] intel_pmc_core INT33A1:00:  initialized
[    1.791268] Consider using thermal netlink events interface
[    1.798346] wmi_bus wmi_bus-PNP0C14:03: WQBC data block query control me=
thod not found
[    1.819119] tun: Universal TUN/TAP device driver, 1.6
[    1.819277] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input4
[    1.823466] hid: raw HID events driver (C) Jiri Kosina
[    1.823989] intel_pch_thermal 0000:00:12.0: enabling device (0000 -> 000=
2)
[    1.824637] ACPI: button: Lid Switch [LID0]
[    1.825268] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input5
[    1.826867] ACPI: button: Power Button [PBTN]
[    1.827198] serial 0000:00:13.0: enabling device (0000 -> 0002)
[    1.827391] loop: module loaded
[    1.829118] Linux agpgart interface v0.103
[    1.833555] rtsx_pci 0000:6c:00.0: enabling device (0000 -> 0002)
[    1.857772] ACPI: battery: Slot [BAT0] (battery present)
[    1.862832] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    1.865455] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    1.865578] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    1.865627] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    1.879540] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    1.883990] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    1.896555] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[    1.900404] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    1.904134] pstore: Registered efi_pstore as persistent store backend
[    1.908232] i2c i2c-0: 2/2 memory slots populated (from DMI)
[    1.908654] i2c i2c-0: Successfully instantiated SPD at 0x50
[    1.913458] intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)
[    1.921276] tpm_tis STM0125:00: 2.0 TPM (device-id 0x0, rev-id 78)
[    1.929274] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    1.947587] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    1.950803] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.955178] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    1.985632] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360=
 ms ovfl timer
[    1.985635] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    1.985636] RAPL PMU: hw unit of domain package 2^-14 Joules
[    1.985638] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    1.985638] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    1.985639] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    1.989692] intel_rapl_common: Found RAPL domain package
[    1.989695] intel_rapl_common: Found RAPL domain dram
[    1.990654] cryptd: max_cpu_qlen set to 1000
[    1.995729] Intel(R) Wireless WiFi driver for Linux
[    1.996894] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    2.006120] AVX2 version of gcm_enc/dec engaged.
[    2.006161] AES CTR mode by8 optimization enabled
[    2.011311] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 0x20000=
302 wfpm id 0x80000000
[    2.011330] iwlwifi 0000:00:14.3: PCI dev 06f0/1651, rev=3D0x351, rfid=
=3D0x10a100
[    2.016748] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subc=
lass/prog-if info 0x040380
[    2.016764] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[    2.019706] input: Dell WMI hotkeys as /devices/platform/PNP0C14:03/wmi_=
bus/wmi_bus-PNP0C14:03/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input7
[    2.038722] intel_rapl_common: Found RAPL domain package
[    2.038725] intel_rapl_common: Found RAPL domain core
[    2.038726] intel_rapl_common: Found RAPL domain uncore
[    2.038727] intel_rapl_common: Found RAPL domain dram
[    2.038728] intel_rapl_common: Found RAPL domain psys
[    2.039224] intel_tcc_cooling: Programmable TCC Offset detected
[    2.047190] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D6=
, TCOBASE=3D0x0400)
[    2.047580] iTCO_wdt iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=
=3D0)
[    2.047976] ee1004 0-0050: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[    2.060903] dw-apb-uart.2: ttyS0 at MMIO 0x4010002000 (irq =3D 20, base_=
baud =3D 7500000) is a 16550A
[    2.070355] iwlwifi 0000:00:14.3: api flags index 2 larger than supporte=
d by driver
[    2.070372] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.=
3.35.37
[    2.070710] iwlwifi 0000:00:14.3: loaded firmware version 77.f92b5fed.0 =
QuZ-a0-hr-b0-77.ucode op_mode iwlmvm
[    2.429524] ACPI Warning: \_SB.PCI0.PEG0.PEGP._DSM: Argument #4 type mis=
match - Found [Buffer], ACPI requires [Package] (20230331/nsarguments-61)
[    2.429610] pci 0000:01:00.0: optimus capabilities: enabled, status dyna=
mic power, hda bios codec supported
[    2.429613] VGA switcheroo: detected Optimus DSM method \_SB_.PCI0.PEG0.=
PEGP handle
[    2.429614] nouveau: detected PR support, will not use DSM
[    2.429635] nouveau 0000:01:00.0: enabling device (0000 -> 0003)
[    2.430008] Console: switching to colour dummy device 80x25
[    2.430085] nouveau 0000:01:00.0: NVIDIA TU117 (167000a1)
[    2.440247] psmouse serio1: elantech: assuming hardware version 4 (with =
firmware version 0x0f5002)
[    2.441077] psmouse serio1: elantech: elantech_send_cmd query 0x02 faile=
d.
[    2.441084] psmouse serio1: elantech: failed to query capabilities.
[    2.447133] i2c_hid_acpi i2c-ELAN29E4:00: i2c_hid_get_input: IRQ trigger=
ed but there's no data
[    2.607616] nouveau 0000:01:00.0: bios: version 90.17.42.00.3a
[    2.622047] nouveau 0000:01:00.0: pmu: firmware unavailable
[    2.629112] nouveau 0000:01:00.0: fb: 4096 MiB GDDR6
[    2.635784] Setting dangerous option enable_psr - tainting kernel
[    2.636218] input: DELL097D:00 04F3:311C Mouse as /devices/pci0000:00/00=
00:00:15.1/i2c_designware.1/i2c-2/i2c-DELL097D:00/0018:04F3:311C.0001/input=
/input8
[    2.636285] input: DELL097D:00 04F3:311C Touchpad as /devices/pci0000:00=
/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DELL097D:00/0018:04F3:311C.0001/in=
put/input9
[    2.636341] hid-generic 0018:04F3:311C.0001: input,hidraw0: I2C HID v1.0=
0 Mouse [DELL097D:00 04F3:311C] on i2c-DELL097D:00
[    2.636700] input: ELAN29E4:00 04F3:29E4 Touchscreen as /devices/pci0000=
:00/0000:00:15.0/i2c_designware.0/i2c-1/i2c-ELAN29E4:00/0018:04F3:29E4.0002=
/input/input11
[    2.636747] input: ELAN29E4:00 04F3:29E4 as /devices/pci0000:00/0000:00:=
15.0/i2c_designware.0/i2c-1/i2c-ELAN29E4:00/0018:04F3:29E4.0002/input/input=
12
[    2.636790] input: ELAN29E4:00 04F3:29E4 as /devices/pci0000:00/0000:00:=
15.0/i2c_designware.0/i2c-1/i2c-ELAN29E4:00/0018:04F3:29E4.0002/input/input=
13
[    2.636856] hid-generic 0018:04F3:29E4.0002: input,hidraw1: I2C HID v1.0=
0 Device [ELAN29E4:00 04F3:29E4] on i2c-ELAN29E4:00
[    2.637221] ish-hid {33AECD58-B679-4E54-9BD9-A04D34F0C226}: [hid-ish]: e=
num_devices_done OK, num_hid_devices=3D1
[    2.638081] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.639709] hid-generic 001F:8087:0AC2.0003: hidraw2: SENSOR HUB HID v2.=
00 Device [hid-ishtp 8087:0AC2] on=20
[    2.654461] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    2.655178] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: =
bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[    2.657140] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/=
kbl_dmc_ver1_04.bin (v1.4)
[    2.676003] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX203, REV=
=3D0x351
[    2.676047] thermal thermal_zone13: failed to read out thermal zone (-61)
[    2.680679] input: DELL097D:00 04F3:311C Mouse as /devices/pci0000:00/00=
00:00:15.1/i2c_designware.1/i2c-2/i2c-DELL097D:00/0018:04F3:311C.0001/input=
/input15
[    2.685652] nouveau 0000:01:00.0: DRM: VRAM: 4096 MiB
[    2.685654] nouveau 0000:01:00.0: DRM: GART: 536870912 MiB
[    2.685656] nouveau 0000:01:00.0: DRM: BIT table 'A' not found
[    2.685656] nouveau 0000:01:00.0: DRM: BIT table 'L' not found
[    2.685657] nouveau 0000:01:00.0: DRM: Pointer to TMDS table not found
[    2.685658] nouveau 0000:01:00.0: DRM: DCB version 4.1
[    2.686330] nouveau 0000:01:00.0: DRM: MM: using COPY for buffer copies
[    2.686493] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on=
 minor 0
[    2.686522] nouveau 0000:01:00.0: [drm] No compatible format found
[    2.686524] nouveau 0000:01:00.0: [drm] Cannot find any crtc or sizes
[    2.686525] nouveau 0000:01:00.0: DRM: Disabling PCI power management to=
 avoid bug
[    2.693526] input: DELL097D:00 04F3:311C Touchpad as /devices/pci0000:00=
/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DELL097D:00/0018:04F3:311C.0001/in=
put/input16
[    2.693568] hid-multitouch 0018:04F3:311C.0001: input,hidraw0: I2C HID v=
1.00 Mouse [DELL097D:00 04F3:311C] on i2c-DELL097D:00
[    2.698532] mousedev: PS/2 mouse device common for all mice
[    2.701004] input: ELAN29E4:00 04F3:29E4 as /devices/pci0000:00/0000:00:=
15.0/i2c_designware.0/i2c-1/i2c-ELAN29E4:00/0018:04F3:29E4.0002/input/input=
18
[    2.701073] input: ELAN29E4:00 04F3:29E4 UNKNOWN as /devices/pci0000:00/=
0000:00:15.0/i2c_designware.0/i2c-1/i2c-ELAN29E4:00/0018:04F3:29E4.0002/inp=
ut/input19
[    2.701281] input: ELAN29E4:00 04F3:29E4 UNKNOWN as /devices/pci0000:00/=
0000:00:15.0/i2c_designware.0/i2c-1/i2c-ELAN29E4:00/0018:04F3:29E4.0002/inp=
ut/input20
[    2.701486] hid-multitouch 0018:04F3:29E4.0002: input,hidraw1: I2C HID v=
1.00 Device [ELAN29E4:00 04F3:29E4] on i2c-ELAN29E4:00
[    2.795739] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
[    2.822526] input: PS/2 Logitech Wheel Mouse as /devices/platform/i8042/=
serio1/input/input6
[    2.861552] iwlwifi 0000:00:14.3: base HW address: dc:41:a9:9f:26:cb
[    2.876972] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[    2.952889] mc: Linux media interface: v0.10
[    2.968373] videodev: Linux video capture interface: v2.00
[    2.978281] usb 1-11: Found UVC 1.00 device Integrated_Webcam_HD (0c45:6=
d14)
[    2.989716] usb 1-11: Found UVC 1.00 device Integrated_Webcam_HD (0c45:6=
d14)
[    2.992439] Bluetooth: Core ver 2.22
[    2.992466] NET: Registered PF_BLUETOOTH protocol family
[    2.992467] Bluetooth: HCI device and connection manager initialized
[    2.992507] Bluetooth: HCI socket layer initialized
[    2.992509] Bluetooth: L2CAP socket layer initialized
[    2.992513] Bluetooth: SCO socket layer initialized
[    2.998034] usbcore: registered new interface driver uvcvideo
[    3.001365] usbcore: registered new interface driver btusb
[    3.046789] Bluetooth: hci0: Found device firmware: intel/ibt-19-0-4.sfi
[    3.046878] Bluetooth: hci0: Boot Address: 0x24800
[    3.046879] Bluetooth: hci0: Firmware Version: 106-39.22
[    3.048194] usb 1-14: USB disconnect, device number 4
[    3.048346] Bluetooth: hci0: FW download error recovery failed (-19)
[    3.048370] Bluetooth: hci0: sending frame failed (-19)
[    3.048376] Bluetooth: hci0: Reading supported features failed (-19)
[    3.048380] Bluetooth: hci0: Error reading debug features
[    3.049074] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    3.049079] Bluetooth: BNEP socket layer initialized
[    3.439451] usb 1-14: new full-speed USB device number 5 using xhci_hcd
[    3.453352] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for=
 information.
[    3.453354] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason=
@zx2c4.com>. All Rights Reserved.
[    3.463987] NET: Registered PF_PACKET protocol family
[    3.566785] usb 1-14: New USB device found, idVendor=3D8087, idProduct=
=3D0026, bcdDevice=3D 0.02
[    3.566788] usb 1-14: New USB device strings: Mfr=3D0, Product=3D0, Seri=
alNumber=3D0
[    3.569602] Bluetooth: hci0: Bootloader revision 0.4 build 0 week 30 2018
[    3.570653] Bluetooth: hci0: Device revision is 2
[    3.570655] Bluetooth: hci0: Secure boot is enabled
[    3.570656] Bluetooth: hci0: OTP lock is enabled
[    3.570657] Bluetooth: hci0: API lock is enabled
[    3.570658] Bluetooth: hci0: Debug lock is disabled
[    3.570659] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    3.601958] Bluetooth: hci0: Found device firmware: intel/ibt-19-0-4.sfi
[    3.602032] Bluetooth: hci0: Boot Address: 0x24800
[    3.602033] Bluetooth: hci0: Firmware Version: 106-39.22
[    3.849491] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on mi=
nor 1
[    3.852314] ACPI: video: Video Device [PEGP] (multi-head: no  rom: yes  =
post: no)
[    3.852339] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/device:00/LNXVIDEO:00/input/input22
[    3.857191] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  =
post: no)
[    3.859485] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:01/input/input23
[    3.859646] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_aud=
io_component_bind_ops [i915])
[    3.859977] vga_switcheroo: enabled
[    3.866495] fbcon: i915drmfb (fb0) is primary device
[    3.882046] Console: switching to colour frame buffer device 480x150
[    3.903423] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    3.953894] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC289: li=
ne_outs=3D2 (0x14/0x17/0x0/0x0/0x0) type:speaker
[    3.953899] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    3.953901] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    3.953902] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    3.953904] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    3.953905] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=3D0x19
[    3.953906] snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=3D0x1b
[    3.953907] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x12
[    3.975128] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=3D1=
394 'systemd'
[    4.626055] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/00=
00:00:1f.3/sound/card0/input24
[    4.626107] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input25
[    4.626146] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input26
[    4.626195] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input27
[    5.241806] Bluetooth: hci0: Waiting for firmware download to complete
[    5.242595] Bluetooth: hci0: Firmware loaded in 1602181 usecs
[    5.242638] Bluetooth: hci0: Waiting for device to boot
[    5.256595] Bluetooth: hci0: Device booted in 13657 usecs
[    5.256905] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-0-=
4.ddc
[    5.259628] Bluetooth: hci0: Applying Intel DDC parameters completed
[    5.260604] Bluetooth: hci0: Firmware revision 0.4 build 106 week 39 2022
[    5.325787] Bluetooth: MGMT ver 1.22
[    5.328049] NET: Registered PF_ALG protocol family
[    5.780722] rfkill: input handler disabled
[    6.108642] Bluetooth: RFCOMM TTY layer initialized
[    6.108649] Bluetooth: RFCOMM socket layer initialized
[    6.108654] Bluetooth: RFCOMM ver 1.11
[    6.822663] wlp0s20f3: authenticate with 76:ac:b9:3d:23:e1
[    6.826416] wlp0s20f3: send auth to 76:ac:b9:3d:23:e1 (try 1/3)
[    6.890918] wlp0s20f3: authenticate with 76:ac:b9:3d:23:e1
[    6.890921] wlp0s20f3: send auth to 76:ac:b9:3d:23:e1 (try 1/3)
[    6.892020] wlp0s20f3: authenticated
[    6.892450] wlp0s20f3: associate with 76:ac:b9:3d:23:e1 (try 1/3)
[    6.897115] wlp0s20f3: RX AssocResp from 76:ac:b9:3d:23:e1 (capab=3D0x11=
11 status=3D0 aid=3D7)
[    6.904360] wlp0s20f3: associated
[    7.084489] NET: Registered PF_QIPCRTR protocol family
[    7.146057] ucsi_acpi USBC000:00: unknown error 0
[    7.146061] ucsi_acpi USBC000:00: UCSI_GET_PDOS failed (-5)
[    7.152563] NFSD: Using nfsdcld client tracking operations.
[    7.152583] NFSD: no clients to reclaim, skipping NFSv4 grace period (ne=
t f0000000)
[    9.477110] systemd-journald[627]: File /var/log/journal/db70a9ba05a34ea=
885e2a138a113f18d/user-1000.journal corrupted or uncleanly shut down, renam=
ing and replacing.
[    9.774752] rfkill: input handler enabled
[   11.790489] Bluetooth: hci0: command 0x0408 tx timeout
[   11.790492] Bluetooth: hci0: Opcode 0x c24 failed: -110
[   14.324482] warning: `.kded5-wrapped' uses wireless extensions which wil=
l stop working for Wi-Fi 7 hardware; use nl80211
[   45.452940] wlp0s20f3: deauthenticating from 76:ac:b9:3d:23:e1 by local =
choice (Reason: 3=3DDEAUTH_LEAVING)
[   46.251772] PM: suspend entry (s2idle)
[   46.262603] Filesystems sync: 0.010 seconds
[   46.305168] Freezing user space processes
[   46.306577] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[   46.306580] OOM killer disabled.
[   46.306581] Freezing remaining freezable tasks
[   46.307549] Freezing remaining freezable tasks completed (elapsed 0.000 =
seconds)
[   46.307552] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[   46.974166] ACPI: EC: interrupt blocked
[   46.982179] intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [59C]
[   50.843626] ACPI: EC: interrupt unblocked
[   52.614284] nvme nvme0: 12/0/0 default/read/poll queues
[   52.650861] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: =
bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[   52.651344] OOM killer enabled.
[   52.651345] Restarting tasks ... done.
[   52.654313] random: crng reseeded on system resumption
[   52.753957] PM: suspend exit
[   53.410473] psmouse serio1: elantech: assuming hardware version 4 (with =
firmware version 0x0f5002)
[   53.410911] psmouse serio1: elantech: elantech_send_cmd query 0x02 faile=
d.
[   53.410914] psmouse serio1: elantech: failed to query capabilities.
[   53.787920] input: PS/2 Logitech Wheel Mouse as /devices/platform/i8042/=
serio1/input/input29
[   56.481997] wlp0s20f3: authenticate with 76:ac:b9:3d:23:e1
[   56.485263] wlp0s20f3: send auth to 76:ac:b9:3d:23:e1 (try 1/3)
[   56.541053] wlp0s20f3: authenticate with 76:ac:b9:3d:23:e1
[   56.541057] wlp0s20f3: send auth to 76:ac:b9:3d:23:e1 (try 1/3)
[   56.542196] wlp0s20f3: authenticated
[   56.542928] wlp0s20f3: associate with 76:ac:b9:3d:23:e1 (try 1/3)
[   56.546049] wlp0s20f3: RX AssocResp from 76:ac:b9:3d:23:e1 (capab=3D0x11=
11 status=3D0 aid=3D6)
[   56.558703] wlp0s20f3: associated
[   66.620028] iwlwifi 0000:00:14.3: Queue 5 is stuck 0 14
[   66.620050] iwlwifi 0000:00:14.3: Queue 4 is stuck 0 4
[   66.620260] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   66.620328] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   66.620329] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 6
[   66.620330] iwlwifi 0000:00:14.3: Loaded firmware version: 77.f92b5fed.0=
 QuZ-a0-hr-b0-77.ucode
[   66.620331] iwlwifi 0000:00:14.3: 0x00000084 | NMI_INTERRUPT_UNKNOWN=20=
=20=20=20=20=20=20
[   66.620332] iwlwifi 0000:00:14.3: 0x0000A2F0 | trm_hw_status0
[   66.620333] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   66.620334] iwlwifi 0000:00:14.3: 0x004C8FAA | branchlink2
[   66.620335] iwlwifi 0000:00:14.3: 0x004BEF5E | interruptlink1
[   66.620336] iwlwifi 0000:00:14.3: 0x004BEF5E | interruptlink2
[   66.620336] iwlwifi 0000:00:14.3: 0x0001523A | data1
[   66.620337] iwlwifi 0000:00:14.3: 0x01000000 | data2
[   66.620338] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   66.620338] iwlwifi 0000:00:14.3: 0x18810674 | beacon time
[   66.620339] iwlwifi 0000:00:14.3: 0xB2452997 | tsf low
[   66.620340] iwlwifi 0000:00:14.3: 0x00000923 | tsf hi
[   66.620341] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   66.620341] iwlwifi 0000:00:14.3: 0x00D955C0 | time gp2
[   66.620342] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   66.620343] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   66.620343] iwlwifi 0000:00:14.3: 0xF92B5FED | uCode version minor
[   66.620344] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   66.620345] iwlwifi 0000:00:14.3: 0x00C89001 | board version
[   66.620345] iwlwifi 0000:00:14.3: 0x8052FD4F | hcmd
[   66.620346] iwlwifi 0000:00:14.3: 0x20028000 | isr0
[   66.620347] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   66.620347] iwlwifi 0000:00:14.3: 0x08F00002 | isr2
[   66.620348] iwlwifi 0000:00:14.3: 0x00C3028C | isr3
[   66.620349] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   66.620349] iwlwifi 0000:00:14.3: 0x00760103 | last cmd Id
[   66.620350] iwlwifi 0000:00:14.3: 0x0001523A | wait_event
[   66.620351] iwlwifi 0000:00:14.3: 0x000000D4 | l2p_control
[   66.620351] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   66.620352] iwlwifi 0000:00:14.3: 0x00000007 | l2p_mhvalid
[   66.620353] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   66.620353] iwlwifi 0000:00:14.3: 0x00000009 | lmpm_pmg_sel
[   66.620354] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   66.620355] iwlwifi 0000:00:14.3: 0x0000D848 | flow_handler
[   66.620386] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   66.620387] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 7
[   66.620388] iwlwifi 0000:00:14.3: 0x20000066 | NMI_INTERRUPT_HOST
[   66.620388] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   66.620389] iwlwifi 0000:00:14.3: 0x8045613A | umac branchlink2
[   66.620390] iwlwifi 0000:00:14.3: 0x8047301E | umac interruptlink1
[   66.620390] iwlwifi 0000:00:14.3: 0x8047301E | umac interruptlink2
[   66.620391] iwlwifi 0000:00:14.3: 0x01000000 | umac data1
[   66.620392] iwlwifi 0000:00:14.3: 0x8047301E | umac data2
[   66.620392] iwlwifi 0000:00:14.3: 0x00000000 | umac data3
[   66.620393] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   66.620394] iwlwifi 0000:00:14.3: 0xF92B5FED | umac minor
[   66.620394] iwlwifi 0000:00:14.3: 0x00D955BE | frame pointer
[   66.620395] iwlwifi 0000:00:14.3: 0xC0886260 | stack pointer
[   66.620396] iwlwifi 0000:00:14.3: 0x0083010C | last host cmd
[   66.620396] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   66.620419] iwlwifi 0000:00:14.3: IML/ROM dump:
[   66.620420] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   66.620426] iwlwifi 0000:00:14.3: 0x0000570D | IML/ROM data1
[   66.620433] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   66.620438] iwlwifi 0000:00:14.3: Fseq Registers:
[   66.620440] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   66.620442] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   66.620444] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   66.620446] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   66.620449] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   66.620451] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   66.620453] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   66.620455] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   66.620457] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   66.620461] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   66.620465] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   66.620470] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   66.620472] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   66.620474] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   66.620476] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   66.620478] iwlwifi 0000:00:14.3: 0x000000DC | FSEQ_CLASS_TP_VERSION
[   66.620485] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x80472b34
[   66.620487] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   66.620566] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   66.620570] ieee80211 phy0: Hardware restart was requested
[   77.372081] iwlwifi 0000:00:14.3: Queue 2 is stuck 0 8
[   77.372264] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   77.372371] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   77.372372] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 6
[   77.372374] iwlwifi 0000:00:14.3: Loaded firmware version: 77.f92b5fed.0=
 QuZ-a0-hr-b0-77.ucode
[   77.372375] iwlwifi 0000:00:14.3: 0x00000084 | NMI_INTERRUPT_UNKNOWN=20=
=20=20=20=20=20=20
[   77.372376] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   77.372377] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   77.372378] iwlwifi 0000:00:14.3: 0x004C8FAA | branchlink2
[   77.372379] iwlwifi 0000:00:14.3: 0x004BEF5E | interruptlink1
[   77.372380] iwlwifi 0000:00:14.3: 0x004BEF5E | interruptlink2
[   77.372380] iwlwifi 0000:00:14.3: 0x0001523A | data1
[   77.372381] iwlwifi 0000:00:14.3: 0x01000000 | data2
[   77.372382] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   77.372383] iwlwifi 0000:00:14.3: 0x18C10641 | beacon time
[   77.372384] iwlwifi 0000:00:14.3: 0xB2E939CB | tsf low
[   77.372384] iwlwifi 0000:00:14.3: 0x00000923 | tsf hi
[   77.372385] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   77.372386] iwlwifi 0000:00:14.3: 0x009EDE4D | time gp2
[   77.372386] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   77.372387] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   77.372388] iwlwifi 0000:00:14.3: 0xF92B5FED | uCode version minor
[   77.372389] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   77.372389] iwlwifi 0000:00:14.3: 0x00C89001 | board version
[   77.372390] iwlwifi 0000:00:14.3: 0x8027FD4F | hcmd
[   77.372391] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   77.372392] iwlwifi 0000:00:14.3: 0x01000000 | isr1
[   77.372392] iwlwifi 0000:00:14.3: 0x08F00002 | isr2
[   77.372393] iwlwifi 0000:00:14.3: 0x00C3029C | isr3
[   77.372394] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   77.372394] iwlwifi 0000:00:14.3: 0x0502001C | last cmd Id
[   77.372395] iwlwifi 0000:00:14.3: 0x0001523A | wait_event
[   77.372396] iwlwifi 0000:00:14.3: 0x00000080 | l2p_control
[   77.372397] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   77.372397] iwlwifi 0000:00:14.3: 0x0000003F | l2p_mhvalid
[   77.372398] iwlwifi 0000:00:14.3: 0x000000CE | l2p_addr_match
[   77.372399] iwlwifi 0000:00:14.3: 0x00000009 | lmpm_pmg_sel
[   77.372400] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   77.372400] iwlwifi 0000:00:14.3: 0x0000F090 | flow_handler
[   77.372431] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   77.372432] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 7
[   77.372433] iwlwifi 0000:00:14.3: 0x20000066 | NMI_INTERRUPT_HOST
[   77.372434] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   77.372435] iwlwifi 0000:00:14.3: 0x8045613A | umac branchlink2
[   77.372435] iwlwifi 0000:00:14.3: 0x8047301E | umac interruptlink1
[   77.372436] iwlwifi 0000:00:14.3: 0x8047301E | umac interruptlink2
[   77.372437] iwlwifi 0000:00:14.3: 0x01000000 | umac data1
[   77.372438] iwlwifi 0000:00:14.3: 0x8047301E | umac data2
[   77.372438] iwlwifi 0000:00:14.3: 0x00000000 | umac data3
[   77.372439] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   77.372440] iwlwifi 0000:00:14.3: 0xF92B5FED | umac minor
[   77.372440] iwlwifi 0000:00:14.3: 0x009EDE4C | frame pointer
[   77.372441] iwlwifi 0000:00:14.3: 0xC0886260 | stack pointer
[   77.372442] iwlwifi 0000:00:14.3: 0x0062010C | last host cmd
[   77.372442] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   77.372465] iwlwifi 0000:00:14.3: IML/ROM dump:
[   77.372466] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   77.372472] iwlwifi 0000:00:14.3: 0x0000576A | IML/ROM data1
[   77.372479] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   77.372484] iwlwifi 0000:00:14.3: Fseq Registers:
[   77.372486] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   77.372488] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   77.372491] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   77.372493] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   77.372495] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   77.372497] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   77.372499] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   77.372501] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   77.372504] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   77.372508] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   77.372512] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   77.372516] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   77.372519] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   77.372521] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   77.372523] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   77.372525] iwlwifi 0000:00:14.3: 0x000000DC | FSEQ_CLASS_TP_VERSION
[   77.372532] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x80472b34
[   77.372534] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   77.372613] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   77.372617] ieee80211 phy0: Hardware restart was requested
[   88.636011] iwlwifi 0000:00:14.3: Queue 2 is stuck 0 4
[   88.636211] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[   88.636278] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   88.636279] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 6
[   88.636280] iwlwifi 0000:00:14.3: Loaded firmware version: 77.f92b5fed.0=
 QuZ-a0-hr-b0-77.ucode
[   88.636281] iwlwifi 0000:00:14.3: 0x00000084 | NMI_INTERRUPT_UNKNOWN=20=
=20=20=20=20=20=20
[   88.636283] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   88.636283] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   88.636284] iwlwifi 0000:00:14.3: 0x004C8FAA | branchlink2
[   88.636285] iwlwifi 0000:00:14.3: 0x004BEF5E | interruptlink1
[   88.636286] iwlwifi 0000:00:14.3: 0x004BEF5E | interruptlink2
[   88.636286] iwlwifi 0000:00:14.3: 0x0001523A | data1
[   88.636287] iwlwifi 0000:00:14.3: 0x01000000 | data2
[   88.636288] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   88.636289] iwlwifi 0000:00:14.3: 0x1A010693 | beacon time
[   88.636289] iwlwifi 0000:00:14.3: 0xB3951976 | tsf low
[   88.636290] iwlwifi 0000:00:14.3: 0x00000923 | tsf hi
[   88.636291] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   88.636292] iwlwifi 0000:00:14.3: 0x00A6B6C1 | time gp2
[   88.636292] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   88.636293] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[   88.636294] iwlwifi 0000:00:14.3: 0xF92B5FED | uCode version minor
[   88.636294] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   88.636295] iwlwifi 0000:00:14.3: 0x00C89001 | board version
[   88.636296] iwlwifi 0000:00:14.3: 0x809EFD4F | hcmd
[   88.636297] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   88.636297] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   88.636298] iwlwifi 0000:00:14.3: 0x08F80002 | isr2
[   88.636299] iwlwifi 0000:00:14.3: 0x00C3008C | isr3
[   88.636299] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   88.636300] iwlwifi 0000:00:14.3: 0x0503001C | last cmd Id
[   88.636301] iwlwifi 0000:00:14.3: 0x0001523A | wait_event
[   88.636301] iwlwifi 0000:00:14.3: 0x000000D4 | l2p_control
[   88.636302] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   88.636303] iwlwifi 0000:00:14.3: 0x00000007 | l2p_mhvalid
[   88.636303] iwlwifi 0000:00:14.3: 0x00000081 | l2p_addr_match
[   88.636304] iwlwifi 0000:00:14.3: 0x00000009 | lmpm_pmg_sel
[   88.636305] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   88.636305] iwlwifi 0000:00:14.3: 0x0000B858 | flow_handler
[   88.636337] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   88.636337] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 7
[   88.636338] iwlwifi 0000:00:14.3: 0x20000066 | NMI_INTERRUPT_HOST
[   88.636339] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   88.636340] iwlwifi 0000:00:14.3: 0x8045613A | umac branchlink2
[   88.636340] iwlwifi 0000:00:14.3: 0x8047301E | umac interruptlink1
[   88.636341] iwlwifi 0000:00:14.3: 0x8047301E | umac interruptlink2
[   88.636342] iwlwifi 0000:00:14.3: 0x01000000 | umac data1
[   88.636343] iwlwifi 0000:00:14.3: 0x8047301E | umac data2
[   88.636343] iwlwifi 0000:00:14.3: 0x00000000 | umac data3
[   88.636344] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[   88.636345] iwlwifi 0000:00:14.3: 0xF92B5FED | umac minor
[   88.636345] iwlwifi 0000:00:14.3: 0x00A6B6BF | frame pointer
[   88.636346] iwlwifi 0000:00:14.3: 0xC0886260 | stack pointer
[   88.636347] iwlwifi 0000:00:14.3: 0x0066010C | last host cmd
[   88.636347] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   88.636369] iwlwifi 0000:00:14.3: IML/ROM dump:
[   88.636370] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   88.636377] iwlwifi 0000:00:14.3: 0x00005792 | IML/ROM data1
[   88.636383] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   88.636388] iwlwifi 0000:00:14.3: Fseq Registers:
[   88.636390] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   88.636393] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   88.636395] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   88.636397] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   88.636399] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   88.636401] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   88.636403] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   88.636406] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[   88.636408] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   88.636412] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[   88.636416] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   88.636421] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   88.636423] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   88.636425] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[   88.636427] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[   88.636429] iwlwifi 0000:00:14.3: 0x000000DC | FSEQ_CLASS_TP_VERSION
[   88.636436] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x80472b34
[   88.636438] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[   88.636517] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   88.636520] ieee80211 phy0: Hardware restart was requested
[  100.924025] iwlwifi 0000:00:14.3: Queue 3 is stuck 0 1
[  100.924170] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[  100.924237] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[  100.924238] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 6
[  100.924240] iwlwifi 0000:00:14.3: Loaded firmware version: 77.f92b5fed.0=
 QuZ-a0-hr-b0-77.ucode
[  100.924241] iwlwifi 0000:00:14.3: 0x00000084 | NMI_INTERRUPT_UNKNOWN=20=
=20=20=20=20=20=20
[  100.924242] iwlwifi 0000:00:14.3: 0x0000A2F0 | trm_hw_status0
[  100.924243] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[  100.924244] iwlwifi 0000:00:14.3: 0x004C8FAA | branchlink2
[  100.924244] iwlwifi 0000:00:14.3: 0x004BEF5E | interruptlink1
[  100.924245] iwlwifi 0000:00:14.3: 0x004BEF5E | interruptlink2
[  100.924246] iwlwifi 0000:00:14.3: 0x0001523A | data1
[  100.924247] iwlwifi 0000:00:14.3: 0x01000000 | data2
[  100.924248] iwlwifi 0000:00:14.3: 0x00000000 | data3
[  100.924248] iwlwifi 0000:00:14.3: 0x1C810694 | beacon time
[  100.924249] iwlwifi 0000:00:14.3: 0xB4509979 | tsf low
[  100.924250] iwlwifi 0000:00:14.3: 0x00000923 | tsf hi
[  100.924250] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[  100.924251] iwlwifi 0000:00:14.3: 0x00B65492 | time gp2
[  100.924252] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[  100.924253] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[  100.924253] iwlwifi 0000:00:14.3: 0xF92B5FED | uCode version minor
[  100.924254] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[  100.924255] iwlwifi 0000:00:14.3: 0x00C89001 | board version
[  100.924256] iwlwifi 0000:00:14.3: 0x8068FD4F | hcmd
[  100.924256] iwlwifi 0000:00:14.3: 0x20020000 | isr0
[  100.924257] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[  100.924257] iwlwifi 0000:00:14.3: 0x08F00002 | isr2
[  100.924258] iwlwifi 0000:00:14.3: 0x00C30208 | isr3
[  100.924259] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[  100.924259] iwlwifi 0000:00:14.3: 0x0504001C | last cmd Id
[  100.924260] iwlwifi 0000:00:14.3: 0x0001523A | wait_event
[  100.924261] iwlwifi 0000:00:14.3: 0x00000094 | l2p_control
[  100.924262] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[  100.924262] iwlwifi 0000:00:14.3: 0x0000000F | l2p_mhvalid
[  100.924263] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[  100.924264] iwlwifi 0000:00:14.3: 0x00000009 | lmpm_pmg_sel
[  100.924264] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[  100.924265] iwlwifi 0000:00:14.3: 0x0000D08C | flow_handler
[  100.924296] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[  100.924297] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 7
[  100.924298] iwlwifi 0000:00:14.3: 0x20000066 | NMI_INTERRUPT_HOST
[  100.924299] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[  100.924299] iwlwifi 0000:00:14.3: 0x8045613A | umac branchlink2
[  100.924300] iwlwifi 0000:00:14.3: 0x8047301E | umac interruptlink1
[  100.924301] iwlwifi 0000:00:14.3: 0x8047301E | umac interruptlink2
[  100.924301] iwlwifi 0000:00:14.3: 0x01000000 | umac data1
[  100.924302] iwlwifi 0000:00:14.3: 0x8047301E | umac data2
[  100.924303] iwlwifi 0000:00:14.3: 0x00000000 | umac data3
[  100.924303] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[  100.924304] iwlwifi 0000:00:14.3: 0xF92B5FED | umac minor
[  100.924305] iwlwifi 0000:00:14.3: 0x00B65491 | frame pointer
[  100.924305] iwlwifi 0000:00:14.3: 0xC0886260 | stack pointer
[  100.924306] iwlwifi 0000:00:14.3: 0x0068010C | last host cmd
[  100.924307] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[  100.924329] iwlwifi 0000:00:14.3: IML/ROM dump:
[  100.924330] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[  100.924337] iwlwifi 0000:00:14.3: 0x0000570D | IML/ROM data1
[  100.924344] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[  100.924348] iwlwifi 0000:00:14.3: Fseq Registers:
[  100.924350] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[  100.924353] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[  100.924355] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[  100.924357] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[  100.924359] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[  100.924361] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[  100.924363] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[  100.924365] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[  100.924368] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[  100.924372] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[  100.924376] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[  100.924380] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[  100.924383] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[  100.924385] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[  100.924387] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[  100.924389] iwlwifi 0000:00:14.3: 0x000000DC | FSEQ_CLASS_TP_VERSION
[  100.924396] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x80472b34
[  100.924398] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[  100.924477] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[  100.924480] ieee80211 phy0: Hardware restart was requested
[  102.015402] wlp0s20f3: deauthenticating from 76:ac:b9:3d:23:e1 by local =
choice (Reason: 3=3DDEAUTH_LEAVING)
[  105.117655] wlp0s20f3: authenticate with 76:ac:b9:3d:23:e1
[  105.125739] wlp0s20f3: send auth to 76:ac:b9:3d:23:e1 (try 1/3)
[  105.189360] wlp0s20f3: authenticate with 76:ac:b9:3d:23:e1
[  105.189364] wlp0s20f3: send auth to 76:ac:b9:3d:23:e1 (try 1/3)
[  105.190481] wlp0s20f3: authenticated
[  105.191928] wlp0s20f3: associate with 76:ac:b9:3d:23:e1 (try 1/3)
[  105.194055] wlp0s20f3: RX AssocResp from 76:ac:b9:3d:23:e1 (capab=3D0x11=
11 status=3D0 aid=3D2)
[  105.208281] wlp0s20f3: associated
[  115.772016] iwlwifi 0000:00:14.3: Queue 5 is stuck 0 4
[  115.772092] iwlwifi 0000:00:14.3: Queue 4 is stuck 0 16
[  115.772266] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g 0x0.
[  115.772334] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[  115.772335] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 6
[  115.772336] iwlwifi 0000:00:14.3: Loaded firmware version: 77.f92b5fed.0=
 QuZ-a0-hr-b0-77.ucode
[  115.772337] iwlwifi 0000:00:14.3: 0x00000084 | NMI_INTERRUPT_UNKNOWN=20=
=20=20=20=20=20=20
[  115.772338] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[  115.772339] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[  115.772340] iwlwifi 0000:00:14.3: 0x004C8FAA | branchlink2
[  115.772341] iwlwifi 0000:00:14.3: 0x004BEF5E | interruptlink1
[  115.772342] iwlwifi 0000:00:14.3: 0x004BEF5E | interruptlink2
[  115.772342] iwlwifi 0000:00:14.3: 0x0001523A | data1
[  115.772343] iwlwifi 0000:00:14.3: 0x01000000 | data2
[  115.772344] iwlwifi 0000:00:14.3: 0x00000000 | data3
[  115.772345] iwlwifi 0000:00:14.3: 0x19C1066D | beacon time
[  115.772345] iwlwifi 0000:00:14.3: 0xB533299B | tsf low
[  115.772346] iwlwifi 0000:00:14.3: 0x00000923 | tsf hi
[  115.772347] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[  115.772348] iwlwifi 0000:00:14.3: 0x00DD6E04 | time gp2
[  115.772348] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[  115.772349] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[  115.772350] iwlwifi 0000:00:14.3: 0xF92B5FED | uCode version minor
[  115.772350] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[  115.772351] iwlwifi 0000:00:14.3: 0x00C89001 | board version
[  115.772352] iwlwifi 0000:00:14.3: 0x8050FD4F | hcmd
[  115.772353] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[  115.772353] iwlwifi 0000:00:14.3: 0x01000000 | isr1
[  115.772354] iwlwifi 0000:00:14.3: 0x08F00002 | isr2
[  115.772355] iwlwifi 0000:00:14.3: 0x00C3028C | isr3
[  115.772355] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[  115.772356] iwlwifi 0000:00:14.3: 0x0204001C | last cmd Id
[  115.772357] iwlwifi 0000:00:14.3: 0x0001523A | wait_event
[  115.772357] iwlwifi 0000:00:14.3: 0x00000080 | l2p_control
[  115.772358] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[  115.772359] iwlwifi 0000:00:14.3: 0x0000003F | l2p_mhvalid
[  115.772359] iwlwifi 0000:00:14.3: 0x000000CE | l2p_addr_match
[  115.772360] iwlwifi 0000:00:14.3: 0x00000009 | lmpm_pmg_sel
[  115.772361] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[  115.772361] iwlwifi 0000:00:14.3: 0x00006040 | flow_handler
[  115.772393] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[  115.772393] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 7
[  115.772394] iwlwifi 0000:00:14.3: 0x20000066 | NMI_INTERRUPT_HOST
[  115.772395] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[  115.772396] iwlwifi 0000:00:14.3: 0x8045613A | umac branchlink2
[  115.772397] iwlwifi 0000:00:14.3: 0x8047301E | umac interruptlink1
[  115.772397] iwlwifi 0000:00:14.3: 0x8047301E | umac interruptlink2
[  115.772398] iwlwifi 0000:00:14.3: 0x01000000 | umac data1
[  115.772399] iwlwifi 0000:00:14.3: 0x8047301E | umac data2
[  115.772399] iwlwifi 0000:00:14.3: 0x00000000 | umac data3
[  115.772400] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[  115.772401] iwlwifi 0000:00:14.3: 0xF92B5FED | umac minor
[  115.772401] iwlwifi 0000:00:14.3: 0x00DD6E02 | frame pointer
[  115.772402] iwlwifi 0000:00:14.3: 0xC0886260 | stack pointer
[  115.772403] iwlwifi 0000:00:14.3: 0x00E1010C | last host cmd
[  115.772403] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[  115.772426] iwlwifi 0000:00:14.3: IML/ROM dump:
[  115.772426] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[  115.772433] iwlwifi 0000:00:14.3: 0x000057A1 | IML/ROM data1
[  115.772440] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[  115.772444] iwlwifi 0000:00:14.3: Fseq Registers:
[  115.772446] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[  115.772449] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[  115.772451] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[  115.772453] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[  115.772455] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[  115.772457] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[  115.772459] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[  115.772461] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[  115.772464] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[  115.772468] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[  115.772472] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[  115.772476] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[  115.772479] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[  115.772481] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERSION
[  115.772483] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSION
[  115.772485] iwlwifi 0000:00:14.3: 0x000000DC | FSEQ_CLASS_TP_VERSION
[  115.772492] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0x80472b34
[  115.772494] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd0
[  115.772573] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[  115.772576] ieee80211 phy0: Hardware restart was requested

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=myconfig
Content-Description: .config

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 6.4.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (GCC) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=124
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_WERROR=y
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=18
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_MISC=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="error"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
CONFIG_CACHESTAT_SYSCALL=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_VSMP is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_PERF_EVENTS_AMD_UNCORE=y
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
# CONFIG_ADDRESS_MASKING is not set
CONFIG_HOTPLUG_CPU=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_NFIT is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_HOTPLUG_CORE_SYNC=y
CONFIG_HOTPLUG_CORE_SYNC_DEAD=y
CONFIG_HOTPLUG_CORE_SYNC_FULL=y
CONFIG_HOTPLUG_SPLIT_STARTUP=y
CONFIG_HOTPLUG_PARALLEL=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_DEV_BSG_COMMON=y
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_CGROUP_IOPRIO=y
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SWAP=y
# CONFIG_ZSWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=y
# CONFIG_NET_KEY is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
# CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_TUNNEL=y
# CONFIG_INET_DIAG is not set
CONFIG_TCP_CONG_ADVANCED=y
# CONFIG_TCP_CONG_BIC is not set
CONFIG_TCP_CONG_CUBIC=y
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_TCP_CONG_HSTCP is not set
# CONFIG_TCP_CONG_HYBLA is not set
# CONFIG_TCP_CONG_VEGAS is not set
# CONFIG_TCP_CONG_NV is not set
# CONFIG_TCP_CONG_SCALABLE is not set
# CONFIG_TCP_CONG_LP is not set
# CONFIG_TCP_CONG_VENO is not set
# CONFIG_TCP_CONG_YEAH is not set
# CONFIG_TCP_CONG_ILLINOIS is not set
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_ESPINTCP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NF_CONNTRACK_SECMARK=y
# CONFIG_NF_CONNTRACK_PROCFS is not set
# CONFIG_NF_CONNTRACK_LABELS is not set
CONFIG_NF_CONNTRACK_FTP=y
CONFIG_NF_CONNTRACK_IRC=y
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
CONFIG_NF_CONNTRACK_SIP=y
CONFIG_NF_CT_NETLINK=y
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=y
CONFIG_NF_NAT_FTP=y
CONFIG_NF_NAT_IRC=y
CONFIG_NF_NAT_SIP=y
CONFIG_NF_NAT_MASQUERADE=y
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_NAT=m
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=y
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
CONFIG_NETFILTER_XT_MATCH_POLICY=y
CONFIG_NETFILTER_XT_MATCH_STATE=y
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TPROXY_IPV4 is not set
# CONFIG_NF_DUP_IPV4 is not set
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_MANGLE=y
# CONFIG_IP_NF_RAW is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TPROXY_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_REJECT=y
CONFIG_IP6_NF_MANGLE=y
# CONFIG_IP6_NF_RAW is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=y
# CONFIG_NF_CONNTRACK_BRIDGE is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_HFSC is not set
# CONFIG_NET_SCH_PRIO is not set
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
# CONFIG_NET_SCH_SFB is not set
# CONFIG_NET_SCH_SFQ is not set
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_NETEM is not set
# CONFIG_NET_SCH_DRR is not set
# CONFIG_NET_SCH_MQPRIO is not set
# CONFIG_NET_SCH_SKBPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
# CONFIG_NET_SCH_CODEL is not set
# CONFIG_NET_SCH_FQ_CODEL is not set
# CONFIG_NET_SCH_CAKE is not set
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
# CONFIG_NET_SCH_INGRESS is not set
# CONFIG_NET_SCH_PLUG is not set
# CONFIG_NET_SCH_ETS is not set
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
# CONFIG_NET_CLS_ROUTE4 is not set
# CONFIG_NET_CLS_FW is not set
# CONFIG_NET_CLS_U32 is not set
# CONFIG_NET_CLS_FLOW is not set
CONFIG_NET_CLS_CGROUP=y
# CONFIG_NET_CLS_BPF is not set
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
# CONFIG_NET_EMATCH_CMP is not set
# CONFIG_NET_EMATCH_NBYTE is not set
# CONFIG_NET_EMATCH_U32 is not set
# CONFIG_NET_EMATCH_META is not set
# CONFIG_NET_EMATCH_TEXT is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
# CONFIG_NET_ACT_POLICE is not set
# CONFIG_NET_ACT_GACT is not set
# CONFIG_NET_ACT_MIRRED is not set
# CONFIG_NET_ACT_SAMPLE is not set
# CONFIG_NET_ACT_IPT is not set
# CONFIG_NET_ACT_NAT is not set
# CONFIG_NET_ACT_PEDIT is not set
# CONFIG_NET_ACT_SIMP is not set
# CONFIG_NET_ACT_SKBEDIT is not set
# CONFIG_NET_ACT_CSUM is not set
# CONFIG_NET_ACT_MPLS is not set
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=y
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=y
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
# CONFIG_HOTPLUG_PCI_PCIE is not set
# CONFIG_PCIEAER is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
# CONFIG_VMD is not set

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=y
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
CONFIG_PATA_AMD=y
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=y
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
CONFIG_PATA_SCH=y
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PCMCIA is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID10 is not set
# CONFIG_MD_RAID456 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
# CONFIG_DM_UNSTRIPED is not set
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_THIN_PROVISIONING is not set
# CONFIG_DM_CACHE is not set
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
# CONFIG_DM_ERA is not set
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=y
# CONFIG_DM_LOG_USERSPACE is not set
# CONFIG_DM_RAID is not set
CONFIG_DM_ZERO=y
# CONFIG_DM_MULTIPATH is not set
# CONFIG_DM_DELAY is not set
# CONFIG_DM_DUST is not set
# CONFIG_DM_INIT is not set
# CONFIG_DM_UEVENT is not set
# CONFIG_DM_FLAKEY is not set
# CONFIG_DM_VERITY is not set
# CONFIG_DM_SWITCH is not set
# CONFIG_DM_LOG_WRITES is not set
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_AUDIT is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=y
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_PDS_CORE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
# CONFIG_TULIP is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_ULI526X is not set
# CONFIG_PCMCIA_XIRCOM is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
CONFIG_SKY2=y
# CONFIG_SKY2_DEBUG is not set
# CONFIG_OCTEON_EP is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=y
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_T1S_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_CBTX_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
# CONFIG_AIRO_CS is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
# CONFIG_MT7921U is not set
# CONFIG_MT7996E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=y
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_PCMCIA_WL3501 is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_QWIIC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
# CONFIG_JOYSTICK_SENSEHAT is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP5 is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
# CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_ILITEK is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS is not set
# CONFIG_TOUCHSCREEN_IMAGIS is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
# CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# end of Serial drivers

CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_N_HDLC is not set
# CONFIG_IPWIRELESS is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

# CONFIG_PINCTRL is not set
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX127 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_CORE is not set
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS6594_I2C is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=y
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_QXL is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# end of Console display driver support
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
# CONFIG_SND_HDA_INPUT_BEEP is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
# CONFIG_SND_HDA_CODEC_REALTEK is not set
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
# CONFIG_SND_HDA_CODEC_HDMI is not set
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
# CONFIG_SND_HDA_CODEC_CS8409 is not set
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
# CONFIG_SND_HDA_CODEC_CA0110 is not set
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
# CONFIG_SND_HDA_CODEC_SI3054 is not set
# CONFIG_SND_HDA_GENERIC is not set
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# CONFIG_SND_HDA_CTL_DEV_ID is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_PCMCIA=y
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_PDAUDIOCF is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set
# CONFIG_SND_VIRTIO is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_FT260 is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_DJ is not set
# CONFIG_HID_LOGITECH_HIDPP is not set
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
CONFIG_HID_SONY=y
# CONFIG_SONY_FF is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
# CONFIG_HID_TOPRE is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

CONFIG_I2C_HID=y
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_BD2606MVV is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=y
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
# CONFIG_HUAWEI_WMI is not set
# CONFIG_MXM_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACER_WMI is not set
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
CONFIG_EEEPC_LAPTOP=y
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_LENOVO_YMC is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_PMC_CORE is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_MSI_WMI is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_LG_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
# CONFIG_COMMON_CLK is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
# CONFIG_AMD_IOMMU_V2 is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
# CONFIG_IOMMUFD is not set
# CONFIG_IRQ_REMAP is not set
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
# CONFIG_CONFIGFS_FS is not set
CONFIG_EFIVAR_FS=m
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_SMB_SERVER is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
# CONFIG_9P_FS_POSIX_ACL is not set
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
# CONFIG_SECURITY_PATH is not set
# CONFIG_INTEL_TXT is not set
CONFIG_LSM_MMAP_MIN_ADDR=65536
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARIA is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
# CONFIG_CRYPTO_ESSIV is not set
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
# CONFIG_CRYPTO_BLAKE2B is not set
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_SHA1 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_VMAC is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_XXHASH is not set
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRCT10DIF is not set
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
# CONFIG_CRC64_ROCKSOFT is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
# CONFIG_CRC8 is not set
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_FLAGS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_AS_HAS_NON_CONST_LEB128=y
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_WQ_CPU_INTENSIVE_REPORT is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_LATENCYTOP is not set
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_USER_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FUNCTION_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--=-=-=
Content-Type: text/plain
Content-Disposition: inline; filename=lspci
Content-Description: lspci output

00:00.0 Host bridge: Intel Corporation 10th Gen Core Processor Host Bridge/DRAM Registers (rev 02)
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=10 <?>
	Kernel driver in use: skl_uncore

00:01.0 PCI bridge: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) (rev 02) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 122
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 3000-3fff [size=4K] [16-bit]
	Memory behind bridge: b3000000-b3ffffff [size=16M] [32-bit]
	Prefetchable memory behind bridge: 70000000-81ffffff [size=288M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: Dell Device 097d
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00238  Data: 0000
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 8GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <256ns, L1 <8us
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8
			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt+
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 75W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Via WAKE#, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=02 ComponentID=01 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed19000
	Capabilities: [d94 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: pcieport

00:02.0 VGA compatible controller: Intel Corporation CometLake-H GT2 [UHD Graphics] (rev 05) (prog-if 00 [VGA controller])
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 178
	Region 0: Memory at 604a000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at 4000000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 4000 [size=64]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
	Capabilities: [40] Vendor Specific Information: Len=0c <?>
	Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ FLReset+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
	Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Process Address Space ID (PASID)
		PASIDCap: Exec- Priv-, Max PASID Width: 14
		PASIDCtl: Enable- Exec- Priv-
	Capabilities: [200 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable-, Smallest Translation Unit: 00
	Capabilities: [300 v1] Page Request Interface (PRI)
		PRICtl: Enable- Reset-
		PRISta: RF- UPRGI- Stopped+
		Page Request Capacity: 00008000, Page Request Allocation: 00000000
	Kernel driver in use: i915
	Kernel modules: i915

00:04.0 Signal processing controller: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem (rev 02)
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at 604b110000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: proc_thermal
	Kernel modules: processor_thermal_device_pci_legacy

00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model
	Subsystem: Dell Device 097d
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at 604b12b000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-

00:12.0 Signal processing controller: Intel Corporation Comet Lake PCH Thermal Controller
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at 604b12a000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Kernel driver in use: intel_pch_thermal
	Kernel modules: intel_pch_thermal

00:13.0 Serial controller: Intel Corporation Device 06fc (prog-if 00 [8250])
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at 604b122000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: intel_ish_ipc
	Kernel modules: 8250_pci, intel_ish_ipc

00:14.0 USB controller: Intel Corporation Comet Lake USB 3.1 xHCI Host Controller (prog-if 30 [XHCI])
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 144
	Region 0: Memory at 604b100000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee00518  Data: 0000
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:14.2 RAM memory: Intel Corporation Comet Lake PCH Shared SRAM
	Subsystem: Dell Device 097d
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at 604b120000 (64-bit, non-prefetchable) [disabled] [size=8K]
	Region 2: Memory at 604b129000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:14.3 Network controller: Intel Corporation Comet Lake PCH CNVi WiFi
	Subsystem: Rivet Networks Wi-Fi 6 AX1650s 160MHz (201D2W) [Killer]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at 604b11c000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE- FLReset+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
	Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [100 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [164 v1] Vendor Specific Information: ID=0010 Rev=0 Len=014 <?>
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

00:15.0 Serial bus controller: Intel Corporation Comet Lake PCH Serial IO I2C Controller #0
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at 4010000000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:15.1 Serial bus controller: Intel Corporation Comet Lake PCH Serial IO I2C Controller #1
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at 4010001000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:16.0 Communication controller: Intel Corporation Comet Lake HECI Controller
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 162
	Region 0: Memory at 604b126000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00758  Data: 0000
	Capabilities: [a4] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: mei_me
	Kernel modules: mei_me

00:1c.0 PCI bridge: Intel Corporation Device 06b8 (rev f0) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 123
	Bus: primary=00, secondary=02, subordinate=6b, sec-latency=0
	I/O behind bridge: 5000-7fff [size=12K] [16-bit]
	Memory behind bridge: 84000000-b20fffff [size=737M] [32-bit]
	Prefetchable memory behind bridge: 6000000000-6049ffffff [size=1184M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x4, ASPM not supported
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 25W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00258  Data: 0000
	Capabilities: [90] Subsystem: Dell Device 097d
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn- NFERptEn- FERptEn-
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [150 v1] Precision Time Measurement
		PTMCap: Requester:- Responder:+ Root:+
		PTMClockGranularity: 4ns
		PTMControl: Enabled:- RootSelected:-
		PTMEffectiveGranularity: Unknown
	Capabilities: [220 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [250 v1] Downstream Port Containment
		DpcCap:	INT Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
		DpcCtl:	Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- DL_ActiveErr-
		DpcSta:	Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO ErrPtr:1f
		Source:	0000
	Kernel driver in use: pcieport

00:1c.6 PCI bridge: Intel Corporation Device 06be (rev f0) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 124
	Bus: primary=00, secondary=6c, subordinate=6c, sec-latency=0
	I/O behind bridge: f000-0fff [disabled] [16-bit]
	Memory behind bridge: b4100000-b41fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #7, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #6, PowerLimit 10W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00278  Data: 0000
	Capabilities: [90] Subsystem: Dell Device 097d
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn- NFERptEn- FERptEn-
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [150 v1] Precision Time Measurement
		PTMCap: Requester:- Responder:+ Root:+
		PTMClockGranularity: 4ns
		PTMControl: Enabled:- RootSelected:-
		PTMEffectiveGranularity: Unknown
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=60us LTR1.2_Threshold=98304ns
		L1SubCtl2: T_PwrOn=60us
	Capabilities: [220 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [250 v1] Downstream Port Containment
		DpcCap:	INT Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
		DpcCtl:	Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- DL_ActiveErr-
		DpcSta:	Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO ErrPtr:1f
		Source:	0000
	Kernel driver in use: pcieport

00:1d.0 PCI bridge: Intel Corporation Comet Lake PCI Express Root Port #9 (rev f0) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 125
	Bus: primary=00, secondary=6d, subordinate=6d, sec-latency=0
	I/O behind bridge: f000-0fff [disabled] [16-bit]
	Memory behind bridge: b4000000-b40fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #9, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #8, PowerLimit 25W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00298  Data: 0000
	Capabilities: [90] Subsystem: Dell Device 097d
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn- NFERptEn- FERptEn-
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [150 v1] Precision Time Measurement
		PTMCap: Requester:- Responder:+ Root:+
		PTMClockGranularity: 4ns
		PTMControl: Enabled:- RootSelected:-
		PTMEffectiveGranularity: Unknown
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=40us LTR1.2_Threshold=65536ns
		L1SubCtl2: T_PwrOn=50us
	Capabilities: [220 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [250 v1] Downstream Port Containment
		DpcCap:	INT Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
		DpcCtl:	Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- DL_ActiveErr-
		DpcSta:	Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO ErrPtr:1f
		Source:	0000
	Kernel driver in use: pcieport

00:1e.0 Communication controller: Intel Corporation Comet Lake PCH Serial IO UART Host Controller #0
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at 4010002000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1f.0 ISA bridge: Intel Corporation Device 068e
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:1f.3 Audio device: Intel Corporation Comet Lake PCH cAVS (prog-if 80)
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	Interrupt: pin A routed to IRQ 181
	Region 0: Memory at 604b118000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at 604b000000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Vendor Specific Information: Len=14 <?>
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee009b8  Data: 0000
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel, snd_soc_skl, snd_sof_pci_intel_cnl

00:1f.4 SMBus: Intel Corporation Comet Lake PCH SMBus Controller
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at 604b124000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at efa0 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

00:1f.5 Serial bus controller: Intel Corporation Comet Lake PCH SPI Controller
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at fe010000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: intel-spi
	Kernel modules: intel_spi_pci

01:00.0 3D controller: NVIDIA Corporation TU117M [GeForce GTX 1650 Ti Mobile] (rev a1)
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 163
	Region 0: Memory at b3000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at 70000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at 80000000 (64-bit, prefetchable) [size=32M]
	Region 5: I/O ports at 3000 [size=128]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00798  Data: 0000
	Capabilities: [78] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <512ns, L1 <16us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x8 (downgraded)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [250 v1] Latency Tolerance Reporting
		Max snoop latency: 34326183936ns
		Max no snoop latency: 34326183936ns
	Capabilities: [258 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=255us PortTPowerOnTime=10us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=0us LTR1.2_Threshold=0ns
		L1SubCtl2: T_PwrOn=10us
	Capabilities: [128 v1] Power Budgeting <?>
	Capabilities: [420 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
	Capabilities: [900 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [bb0 v1] Physical Resizable BAR
		BAR 0: current size: 16MB, supported: 16MB
		BAR 1: current size: 256MB, supported: 64MB 128MB 256MB
		BAR 3: current size: 32MB, supported: 32MB
	Kernel driver in use: nvidia
	Kernel modules: nvidiafb, nouveau, nvidia_drm, nvidia

02:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 097d
	Physical Slot: 0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Bus: primary=02, secondary=03, subordinate=6b, sec-latency=0
	I/O behind bridge: 5000-6fff [size=8K] [16-bit]
	Memory behind bridge: 84000000-b1ffffff [size=736M] [32-bit]
	Prefetchable memory behind bridge: 6000000000-6049ffffff [size=1184M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [ac] Subsystem: Dell Device 097d
	Capabilities: [c0] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 25W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <2us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled,
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [50] Capability ID 0x15 [0000]
	Capabilities: [100 v1] Device Serial Number af-b8-b5-78-6f-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
	Capabilities: [700 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [800 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [a00 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=0us PortTPowerOnTime=10us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=0us LTR1.2_Threshold=81920ns
		L1SubCtl2: T_PwrOn=10us
	Capabilities: [b00 v1] Precision Time Measurement
		PTMCap: Requester:- Responder:- Root:-
		PTMClockGranularity: Unimplemented
		PTMControl: Enabled:- RootSelected:-
		PTMEffectiveGranularity: Unknown
	Kernel driver in use: pcieport

03:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 126
	Bus: primary=03, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
	Memory behind bridge: b1f00000-b1ffffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee002b8  Data: 0000
	Capabilities: [ac] Subsystem: Dell Device 097d
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [50] Capability ID 0x15 [0000]
	Capabilities: [100 v1] Device Serial Number af-b8-b5-78-6f-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=1 RefClk=100ns PATEntryBits=1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=1 ArbSelect=Fixed TC/VC=00
			Status:	NegoPending+ InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
	Capabilities: [700 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [900 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir- CmpltRedir- UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport

03:01.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 127
	Bus: primary=03, secondary=05, subordinate=37, sec-latency=0
	I/O behind bridge: 5000-5fff [size=4K] [16-bit]
	Memory behind bridge: 9b000000-b1efffff [size=367M] [32-bit]
	Prefetchable memory behind bridge: 6025000000-6049ffffff [size=592M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee002f8  Data: 0000
	Capabilities: [ac] Subsystem: Dell Device 097d
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #1, PowerLimit 0W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [50] Capability ID 0x15 [0000]
	Capabilities: [100 v1] Device Serial Number af-b8-b5-78-6f-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending+ InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
	Capabilities: [700 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [900 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir- CmpltRedir- UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport

03:02.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 128
	Bus: primary=03, secondary=38, subordinate=38, sec-latency=0
	I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
	Memory behind bridge: 9af00000-9affffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00318  Data: 0000
	Capabilities: [ac] Subsystem: Dell Device 097d
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [50] Capability ID 0x15 [0000]
	Capabilities: [100 v1] Device Serial Number af-b8-b5-78-6f-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
	Capabilities: [700 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [900 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir- CmpltRedir- UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport

03:04.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 129
	Bus: primary=03, secondary=39, subordinate=6b, sec-latency=0
	I/O behind bridge: 6000-6fff [size=4K] [16-bit]
	Memory behind bridge: 84000000-9aefffff [size=367M] [32-bit]
	Prefetchable memory behind bridge: 6000000000-6024ffffff [size=592M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00338  Data: 0000
	Capabilities: [ac] Subsystem: Dell Device 097d
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #4, PowerLimit 0W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [50] Capability ID 0x15 [0000]
	Capabilities: [100 v1] Device Serial Number af-b8-b5-78-6f-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending+ InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
	Capabilities: [700 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [900 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir- CmpltRedir- UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport

04:00.0 System peripheral: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018] (rev 06)
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at b1f00000 (32-bit, non-prefetchable) [size=256K]
	Region 1: Memory at b1f40000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI-X: Enable+ Count=16 Masked-
		Vector table: BAR=1 offset=00000000
		PBA: BAR=1 offset=00000fa0
	Capabilities: [100 v1] Device Serial Number af-b8-b5-78-6f-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Kernel driver in use: thunderbolt
	Kernel modules: thunderbolt

38:00.0 USB controller: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018] (rev 06) (prog-if 30 [XHCI])
	Subsystem: Dell Device 097d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 145
	Region 0: Memory at 9af00000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee00538  Data: 0000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Device Serial Number af-b8-b5-78-6f-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
	Capabilities: [700 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [800 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

6c:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5260 PCI Express Card Reader (rev 01)
	Subsystem: Dell Device 097d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 130
	Region 0: Memory at b4100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00358  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [148 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
	Capabilities: [158 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [168 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [170 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=60us PortTPowerOnTime=60us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=0us LTR1.2_Threshold=98304ns
		L1SubCtl2: T_PwrOn=60us
	Kernel driver in use: rtsx_pci
	Kernel modules: rtsx_pci

6d:00.0 Non-Volatile memory controller: SK hynix Device 1639 (prog-if 02 [NVM Express])
	Subsystem: SK hynix Device 1639
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	NUMA node: 0
	Region 0: Memory at b4000000 (64-bit, non-prefetchable) [size=16K]
	Region 2: Memory at b4005000 (32-bit, non-prefetchable) [size=4K]
	Region 3: Memory at b4004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable- Count=1/16 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		AERCap:	First Error Pointer: 14, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 04000001 0000000f 6d010000 00000000
	Capabilities: [150 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [160 v1] Power Budgeting <?>
	Capabilities: [1b8 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [300 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [400 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [900 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=24us PortTPowerOnTime=50us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=0us LTR1.2_Threshold=65536ns
		L1SubCtl2: T_PwrOn=50us
	Kernel driver in use: nvme
	Kernel modules: nvme


--=-=-=--
