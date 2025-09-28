Return-Path: <linux-wireless+bounces-27687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A3FBA7660
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Sep 2025 20:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C613B7FAD
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Sep 2025 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43B521FF3B;
	Sun, 28 Sep 2025 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfbYlWk/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DBE34BA4D
	for <linux-wireless@vger.kernel.org>; Sun, 28 Sep 2025 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759085503; cv=none; b=l1YJn9jwxii1/+TpnRAaQaufYo9Y9/f59ul7ksDj6rYebdnXpG5NMW72CfD3j4s0/LTMtDVoy4YSQQfcvrnBfXTfr99HEli2qYTxqGuq2auGSV814SvQtDTz6g9ooJ0UWmL0Jtal3QFlg8zagfcv1zMqoMydkCw0iGVubIF7pMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759085503; c=relaxed/simple;
	bh=yUF1e5HTtIM25H1wVDkuktMH1+TPM3u7uRIWQSIymag=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XDspLRTryBJQx92FMd/5tsyp7ZG9Q2kPhzn3N1cnmH1yTQFPZRyQzgouzusLVqASWXrVc1+UG72KElW0jOSlwQZ7QhyN8NnYQe0qsj3WmzXH78/Fqt1G8Ag56WHfHeqDQlDp5Pms8BJmi2sQLO0OE+9SKJDyOweo8mgfYJaLQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfbYlWk/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4dd7233b407so30353991cf.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Sep 2025 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759085496; x=1759690296; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BmU5OzSRtlmAatiIdNH8jBCMqKy6qoTlv5IBc2owMw=;
        b=AfbYlWk/19caY3IaHFJjow14dlpuDjL53/QhmAouPhnCCWwB5oM6F9OQ72LOkEQEs0
         kVBFwz9GFNhWhsMauH2hGlcR0BUmUw05pjDLHRPMlHlFdIwsJsJGwVnZOsYhSvomLYPk
         2v4GySQ+MRXs3OEa/j2aJf6VwfYhaYTbdyz9FTi0/TjdLz+dh+FC5YtBsyhkZztpNow9
         9LRS+Pyni+coFxPGem6LAlzvDcOT6/bwxrd5Q/KGtcstM/HO340cJIfi0Oncx9sSDCXq
         caM2mgkVjne/bHf/MA4zduVVq1gilLeFPOTsUsFgmBIVVIPZdapa0VY/IEm5hhPv0D7e
         mMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759085496; x=1759690296;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BmU5OzSRtlmAatiIdNH8jBCMqKy6qoTlv5IBc2owMw=;
        b=IXfl0YCR1TdJ66gl0V/f/ywS05gwbS4wRERNwmNTLCjdMvvU1EyJdNG4GlfyolxDxE
         eh9nogVUVaH9f2LeYuUANmFFInERHcSo6uo2Au98IUb2EsaFiwpkkAU79shBEFjRhnx8
         bQLQ22s9b4hsnDEMMkUKRAftPaAWSSkzQC6V6sNH14u1hYSgiQwEQ4syDqFf6ZT101Sq
         WaDhewB27nxVltYHCDM5SU7wclv0mdIxThxfXU3khBFdtQF5nQ0VD9/tF51EAt8MlOef
         GHo53PVgrWoEuMFBHVkYE2KWg23Fq9UtwSaqpd6Uu70/NqDlx/3Krv44aFOzeFRjX+FP
         C8qg==
X-Gm-Message-State: AOJu0YylLAMB/8fWi+1I3iw5VAqnrEqI9FrZBgWc1XvLPWGoCUFamaDj
	VmgAey07KaBIM5GvSWhSzYNZUN5gq+vFIT/GRpAAdEZ4VyZtp6WmKpjqQwJ0XvDXZFzFwWBJzPl
	2mUFzymdR71eVaCgHZOEpeDzwgah4BPVvB3Ln
X-Gm-Gg: ASbGncteGZgP9tE/yNHdLk005M+p8QODi1ByYDvOnUsiAMKvQvA9dNwKsY2WIZIxQU2
	NveZI90MlW+qMsRGaBsw7CA38MtDvGWfZbPfjpmPw3Jy2b1J7QZyyMtGEZMmOPFaSRG43VtD7Bo
	UKFChGn8c9GpwJjP91PMs9aV0E5jQta15uHvKO1HZoo9C2cWVM1HTbfoTIVHPOzRABG8ownTohX
	Sj0Rfjjkjd0AH9/
X-Google-Smtp-Source: AGHT+IG2RoZUz/fu2trPrX45mGuRMZvwV5NaBn2s5bsmg2fSvcOvb2evBUs6HTMs75RrihTZAeI4Tj3Pd/A/sbIFRAc=
X-Received: by 2002:a05:622a:212:b0:4cd:fe0:4f8a with SMTP id
 d75a77b69052e-4da481d5ca8mr261711521cf.23.1759085494022; Sun, 28 Sep 2025
 11:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Francesco Bergesio <francescobergesio1@gmail.com>
Date: Sun, 28 Sep 2025 20:51:22 +0200
X-Gm-Features: AS18NWCNWZQfOdBNVbhyaPmBef3lgu6pN6F1TGx_OE5pxDmfhU_-m_497-2bCmc
Message-ID: <CAFXXzTbHabF2hZKWM=RquQXB_tFq-24SPifnyL9ZA5-HL30X1A@mail.gmail.com>
Subject: [Bug Report] Intel AX1775 / AX1790 / BE20 / BE401 / BE1750 2x2 (Wi-Fi
 7) fails to resume after suspend (s2idle)
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm reporting a bug with Intel AX1775 / AX1790 / BE20 / BE401 / BE1750
2x2 (Wi-Fi 7) on Linux kernel 6.14.0-32-generic. The Wi-Fi fails to
resume after suspend to idle (s2idle), requiring a reboot to regain
connectivity.

lspci: 0000:2c:00.0 Network controller [0280]: Intel Corporation Wi-Fi
7(802.11be) AX1775*/AX1790*/BE20*/BE401/BE1750* 2x2 [8086:272b] (rev
1a)
Subsystem: Rivet Networks Device [1a56:1774]

Kernel Version:
6.14.0-32-generic #32~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC
Module: iwlwifi (built for kernel 6.14.0-32-generic, srcversion
FB9BBE8EA461C5285F8A7B9)
Loaded firmware: 96.44729d4e.0 (gl-c0-fm-c0-96.ucode)
PNVM: 97f4ce1a

Steps to Reproduce:
- Connect to a Wi-Fi network.
- Suspend the system using systemctl suspend.
- Resume the system.
- Wi-Fi does not reconnect automatically; manual reconnection fails.

Expected Behavior:
Wi-Fi should resume and reconnect automatically after suspend.
Actual Behavior:
Wi-Fi remains disconnected. iwconfig or nmcli show no wireless extension.

dmesg output around resume:

[   62.031074] PM: suspend entry (s2idle)
[   62.047712] Filesystems sync: 0.016 seconds
[   62.101156] Freezing user space processes
[   62.103095] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[   62.103098] OOM killer disabled.
[   62.103099] Freezing remaining freezable tasks
[   62.104181] Freezing remaining freezable tasks completed (elapsed
0.001 seconds)
[   62.104185] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[   62.489650] ACPI: EC: interrupt blocked
[   65.805788] ACPI: EC: interrupt unblocked
[   66.290126] pci 0000:00:08.0: Setting to D3hot
[   66.312934] spd5118 1-0050: Failed to write b =3D 0: -6
[   66.312945] spd5118 1-0050: PM: dpm_run_callback(): spd5118_resume
[spd5118] returns -6
[   66.312958] spd5118 1-0050: PM: failed to resume async: error -6
[   66.318931] i915 0000:00:02.0: [drm] GT0: GuC firmware
i915/mtl_guc_70.bin version 70.36.0
[   66.327113] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[   66.327117] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[   66.327326] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[   66.327818] i915 0000:00:02.0: [drm] GT1: GuC firmware
i915/mtl_guc_70.bin version 70.36.0
[   66.327820] i915 0000:00:02.0: [drm] GT1: HuC firmware
i915/mtl_huc_gsc.bin version 8.5.4
[   66.351731] i915 0000:00:02.0: [drm] GT1: GUC: submission enabled
[   66.351732] i915 0000:00:02.0: [drm] GT1: GUC: SLPC enabled
[   66.351796] i915 0000:00:02.0: [drm] GT1: GUC: RC enabled
[   66.818856] fbcon: Taking over console
[   66.819128] mei_gsc_proxy
0000:00:16.0-0f73db04-97ab-4125-b893-e904ad0d5464: bound 0000:00:02.0
(ops i915_gsc_proxy_component_ops [i915])
[   66.822326] Console: switching to colour frame buffer device 160x50
[   66.830412] OOM killer enabled.
[   66.830414] Restarting tasks ... done.
[   66.833495] random: crng reseeded on system resumption
[   66.942579] PM: suspend exit
[   66.993359] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[   66.993547] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   66.993693] Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   67.004869] Intel(R) Wireless WiFi driver for Linux
[   67.014032] iwlwifi 0000:2c:00.0: Detected crf-id 0x2001910, cnv-id
0x2001910 wfpm id 0x80000000
[   67.014130] iwlwifi 0000:2c:00.0: PCI dev 272b/1774, rev=3D0x472, rfid=
=3D0x112200
[   67.014132] iwlwifi 0000:2c:00.0: Detected Intel(R) Wi-Fi 7 BE202 160MHz
[   67.016943] iwlwifi 0000:2c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
Version: 0.0.4.196
[   67.017200] iwlwifi 0000:2c:00.0: loaded firmware version
96.44729d4e.0 gl-c0-fm-c0-96.ucode op_mode iwlmvm
[   67.395629] iwlwifi 0000:2c:00.0: Detected RF FM, rfid=3D0x112200
[   67.396130] iwlwifi 0000:2c:00.0: loaded PNVM version 97f4ce1a
[   67.510361] iwlwifi 0000:2c:00.0: base HW address: a0:02:a5:6b:d6:5e
[   67.592265] iwlwifi 0000:2c:00.0 wlp44s0f0: renamed from wlan0
[   68.056514] Realtek Internal NBASE-T PHY r8169-0-2d00:00: attached
PHY driver (mii_bus:phy_addr=3Dr8169-0-2d00:00, irq=3DMAC)
[   68.162853] usb 3-3: reset full-speed USB device number 2 using xhci_hcd
[   68.197718] r8169 0000:2d:00.0 enp45s0: Link is Down
[   68.612253] iwlwifi 0000:2c:00.0: Registered PHC clock:
iwlwifi-PTP, with index: 0
[   68.615741] warning: `wpa_supplicant' uses wireless extensions
which will stop working for Wi-Fi 7 hardware; use nl80211

complete dmesg output:

[    0.000000] Linux version 6.14.0-32-generic
(buildd@lcy02-amd64-047) (x86_64-linux-gnu-gcc-13 (Ubuntu
13.3.0-6ubuntu2~24.04) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42)
#32~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Sep  2 14:21:04 UTC 2
(Ubuntu 6.14.0-32.32~24.04.1-generic 6.14.11)
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-6.14.0-32-generic
root=3D/dev/mapper/vgmint-root ro quiet splash
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai
[    0.000000] x86/tme: not enabled by BIOS
[    0.000000] x86/split lock detection: #AC: crashing the kernel on
kernel split_locks and warning on user-space split_locks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000635f2fff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x00000000635f3000-0x000000006766dfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000006766e000-0x0000000067767fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x0000000067768000-0x00000000678eafff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000678eb000-0x000000006bffefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000006bfff000-0x000000006bffffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000006c000000-0x00000000787fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087fffffff] usabl=
e
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x594ca018-0x594eec57] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem
0x0000000000000000-0x000000000009efff] usable
[    0.000000] reserve setup_data: [mem
0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem
0x0000000000100000-0x00000000594ca017] usable
[    0.000000] reserve setup_data: [mem
0x00000000594ca018-0x00000000594eec57] usable
[    0.000000] reserve setup_data: [mem
0x00000000594eec58-0x00000000635f2fff] usable
[    0.000000] reserve setup_data: [mem
0x00000000635f3000-0x000000006766dfff] reserved
[    0.000000] reserve setup_data: [mem
0x000000006766e000-0x0000000067767fff] ACPI data
[    0.000000] reserve setup_data: [mem
0x0000000067768000-0x00000000678eafff] ACPI NVS
[    0.000000] reserve setup_data: [mem
0x00000000678eb000-0x000000006bffefff] reserved
[    0.000000] reserve setup_data: [mem
0x000000006bfff000-0x000000006bffffff] usable
[    0.000000] reserve setup_data: [mem
0x000000006c000000-0x00000000787fffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem
0x0000000100000000-0x000000087fffffff] usable
[    0.000000] efi: EFI v2.9 by American Megatrends
[    0.000000] efi: ACPI=3D0x67864000 ACPI 2.0=3D0x67864014
TPMFinalLog=3D0x67833000 SMBIOS=3D0x6ac1b000 SMBIOS 3.0=3D0x6ac1a000
MEMATTR=3D0x59bf9698 ESRT=3D0x59c0a418 MOKvar=3D0x6bc7d000 INITRD=3D0x59bd9=
798
RNG=3D0x676a0018 TPMEventLog=3D0x67690018
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem82: MMIO range=3D[0xc0000000-0xcfffffff]
(256MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Not removing mem83: MMIO
range=3D[0xfe000000-0xfe010fff] (68KB) from e820 map
[    0.000000] efi: Not removing mem84: MMIO
range=3D[0xfec00000-0xfec00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem85: MMIO
range=3D[0xfed00000-0xfed00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem87: MMIO
range=3D[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem88: MMIO range=3D[0xff000000-0xffffffff]
(16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.6.0 present.
[    0.000000] DMI: Micro-Star International Co., Ltd. Stealth 16 AI
Studio A1VGG/MS-15F4, BIOS E15F4IMS.10A 05/10/2024
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] secureboot: Secure boot enabled
[    0.000000] Kernel is locked down from EFI Secure Boot mode; see
man kernel_lockdown.7
[    0.000000] tsc: Detected 3100.000 MHz processor
[    0.000000] tsc: Detected 3072.000 MHz TSC
[    0.000007] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000008] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000013] last_pfn =3D 0x880000 max_arch_pfn =3D 0x400000000
[    0.000020] total RAM covered: 63295M
[    0.000079]  gran_size: 64K chunk_size: 64K num_reg: 10   lose
cover RAM: 30716M
[    0.000080]  gran_size: 64K chunk_size: 128K num_reg: 10   lose
cover RAM: 30716M
[    0.000081]  gran_size: 64K chunk_size: 256K num_reg: 10   lose
cover RAM: 30716M
[    0.000082]  gran_size: 64K chunk_size: 512K num_reg: 10   lose
cover RAM: 30716M
[    0.000082]  gran_size: 64K chunk_size: 1M num_reg: 10   lose cover
RAM: 30716M
[    0.000083]  gran_size: 64K chunk_size: 2M num_reg: 10   lose cover
RAM: 30716M
[    0.000084]  gran_size: 64K chunk_size: 4M num_reg: 10   lose cover
RAM: 30716M
[    0.000084]  gran_size: 64K chunk_size: 8M num_reg: 10   lose cover
RAM: 30716M
[    0.000085]  gran_size: 64K chunk_size: 16M num_reg: 10   lose
cover RAM: 30716M
[    0.000085]  gran_size: 64K chunk_size: 32M num_reg: 10   lose
cover RAM: 30716M
[    0.000086]  gran_size: 64K chunk_size: 64M num_reg: 10   lose
cover RAM: 30716M
[    0.000087]  gran_size: 64K chunk_size: 128M num_reg: 10   lose
cover RAM: 30718M
[    0.000087]  gran_size: 64K chunk_size: 256M num_reg: 10   lose
cover RAM: 30712M
[    0.000088]  gran_size: 64K chunk_size: 512M num_reg: 10   lose
cover RAM: 30712M
[    0.000089]  gran_size: 64K chunk_size: 1G num_reg: 10   lose cover
RAM: 30712M
[    0.000089]  gran_size: 64K chunk_size: 2G num_reg: 10   lose cover
RAM: 30712M
[    0.000090]  gran_size: 128K chunk_size: 128K num_reg: 10   lose
cover RAM: 30716M
[    0.000091]  gran_size: 128K chunk_size: 256K num_reg: 10   lose
cover RAM: 30716M
[    0.000091]  gran_size: 128K chunk_size: 512K num_reg: 10   lose
cover RAM: 30716M
[    0.000092]  gran_size: 128K chunk_size: 1M num_reg: 10   lose
cover RAM: 30716M
[    0.000092]  gran_size: 128K chunk_size: 2M num_reg: 10   lose
cover RAM: 30716M
[    0.000093]  gran_size: 128K chunk_size: 4M num_reg: 10   lose
cover RAM: 30716M
[    0.000094]  gran_size: 128K chunk_size: 8M num_reg: 10   lose
cover RAM: 30716M
[    0.000094]  gran_size: 128K chunk_size: 16M num_reg: 10   lose
cover RAM: 30716M
[    0.000095]  gran_size: 128K chunk_size: 32M num_reg: 10   lose
cover RAM: 30716M
[    0.000096]  gran_size: 128K chunk_size: 64M num_reg: 10   lose
cover RAM: 30716M
[    0.000096]  gran_size: 128K chunk_size: 128M num_reg: 10   lose
cover RAM: 30718M
[    0.000097]  gran_size: 128K chunk_size: 256M num_reg: 10   lose
cover RAM: 30712M
[    0.000097]  gran_size: 128K chunk_size: 512M num_reg: 10   lose
cover RAM: 30712M
[    0.000098]  gran_size: 128K chunk_size: 1G num_reg: 10   lose
cover RAM: 30712M
[    0.000099]  gran_size: 128K chunk_size: 2G num_reg: 10   lose
cover RAM: 30712M
[    0.000099]  gran_size: 256K chunk_size: 256K num_reg: 10   lose
cover RAM: 30716M
[    0.000100]  gran_size: 256K chunk_size: 512K num_reg: 10   lose
cover RAM: 30716M
[    0.000101]  gran_size: 256K chunk_size: 1M num_reg: 10   lose
cover RAM: 30716M
[    0.000101]  gran_size: 256K chunk_size: 2M num_reg: 10   lose
cover RAM: 30716M
[    0.000102]  gran_size: 256K chunk_size: 4M num_reg: 10   lose
cover RAM: 30716M
[    0.000102]  gran_size: 256K chunk_size: 8M num_reg: 10   lose
cover RAM: 30716M
[    0.000103]  gran_size: 256K chunk_size: 16M num_reg: 10   lose
cover RAM: 30716M
[    0.000104]  gran_size: 256K chunk_size: 32M num_reg: 10   lose
cover RAM: 30716M
[    0.000104]  gran_size: 256K chunk_size: 64M num_reg: 10   lose
cover RAM: 30716M
[    0.000105]  gran_size: 256K chunk_size: 128M num_reg: 10   lose
cover RAM: 30718M
[    0.000105]  gran_size: 256K chunk_size: 256M num_reg: 10   lose
cover RAM: 30712M
[    0.000106]  gran_size: 256K chunk_size: 512M num_reg: 10   lose
cover RAM: 30712M
[    0.000107]  gran_size: 256K chunk_size: 1G num_reg: 10   lose
cover RAM: 30712M
[    0.000107]  gran_size: 256K chunk_size: 2G num_reg: 10   lose
cover RAM: 30712M
[    0.000108]  gran_size: 512K chunk_size: 512K num_reg: 10   lose
cover RAM: 30716M
[    0.000109]  gran_size: 512K chunk_size: 1M num_reg: 10   lose
cover RAM: 30716M
[    0.000109]  gran_size: 512K chunk_size: 2M num_reg: 10   lose
cover RAM: 30716M
[    0.000110]  gran_size: 512K chunk_size: 4M num_reg: 10   lose
cover RAM: 30716M
[    0.000110]  gran_size: 512K chunk_size: 8M num_reg: 10   lose
cover RAM: 30716M
[    0.000111]  gran_size: 512K chunk_size: 16M num_reg: 10   lose
cover RAM: 30716M
[    0.000112]  gran_size: 512K chunk_size: 32M num_reg: 10   lose
cover RAM: 30716M
[    0.000112]  gran_size: 512K chunk_size: 64M num_reg: 10   lose
cover RAM: 30716M
[    0.000113]  gran_size: 512K chunk_size: 128M num_reg: 10   lose
cover RAM: 30718M
[    0.000114]  gran_size: 512K chunk_size: 256M num_reg: 10   lose
cover RAM: 30712M
[    0.000114]  gran_size: 512K chunk_size: 512M num_reg: 10   lose
cover RAM: 30712M
[    0.000115]  gran_size: 512K chunk_size: 1G num_reg: 10   lose
cover RAM: 30712M
[    0.000115]  gran_size: 512K chunk_size: 2G num_reg: 10   lose
cover RAM: 30712M
[    0.000116]  gran_size: 1M chunk_size: 1M num_reg: 10   lose cover
RAM: 30716M
[    0.000117]  gran_size: 1M chunk_size: 2M num_reg: 10   lose cover
RAM: 30716M
[    0.000117]  gran_size: 1M chunk_size: 4M num_reg: 10   lose cover
RAM: 30716M
[    0.000118]  gran_size: 1M chunk_size: 8M num_reg: 10   lose cover
RAM: 30716M
[    0.000119]  gran_size: 1M chunk_size: 16M num_reg: 10   lose cover
RAM: 30716M
[    0.000119]  gran_size: 1M chunk_size: 32M num_reg: 10   lose cover
RAM: 30716M
[    0.000120]  gran_size: 1M chunk_size: 64M num_reg: 10   lose cover
RAM: 30716M
[    0.000120]  gran_size: 1M chunk_size: 128M num_reg: 10   lose
cover RAM: 30718M
[    0.000121]  gran_size: 1M chunk_size: 256M num_reg: 10   lose
cover RAM: 30712M
[    0.000122]  gran_size: 1M chunk_size: 512M num_reg: 10   lose
cover RAM: 30712M
[    0.000122]  gran_size: 1M chunk_size: 1G num_reg: 10   lose cover
RAM: 30712M
[    0.000123]  gran_size: 1M chunk_size: 2G num_reg: 10   lose cover
RAM: 30712M
[    0.000123]  gran_size: 2M chunk_size: 2M num_reg: 10   lose cover
RAM: 30716M
[    0.000124]  gran_size: 2M chunk_size: 4M num_reg: 10   lose cover
RAM: 30716M
[    0.000125]  gran_size: 2M chunk_size: 8M num_reg: 10   lose cover
RAM: 30716M
[    0.000125]  gran_size: 2M chunk_size: 16M num_reg: 10   lose cover
RAM: 30716M
[    0.000126]  gran_size: 2M chunk_size: 32M num_reg: 10   lose cover
RAM: 30716M
[    0.000126]  gran_size: 2M chunk_size: 64M num_reg: 10   lose cover
RAM: 30716M
[    0.000127]  gran_size: 2M chunk_size: 128M num_reg: 10   lose
cover RAM: 30718M
[    0.000128]  gran_size: 2M chunk_size: 256M num_reg: 10   lose
cover RAM: 30712M
[    0.000128]  gran_size: 2M chunk_size: 512M num_reg: 10   lose
cover RAM: 30712M
[    0.000129]  gran_size: 2M chunk_size: 1G num_reg: 10   lose cover
RAM: 30712M
[    0.000130]  gran_size: 2M chunk_size: 2G num_reg: 10   lose cover
RAM: 30712M
[    0.000130]  gran_size: 4M chunk_size: 4M num_reg: 10   lose cover
RAM: 30716M
[    0.000131]  gran_size: 4M chunk_size: 8M num_reg: 10   lose cover
RAM: 30716M
[    0.000131]  gran_size: 4M chunk_size: 16M num_reg: 10   lose cover
RAM: 30716M
[    0.000132]  gran_size: 4M chunk_size: 32M num_reg: 10   lose cover
RAM: 30716M
[    0.000133]  gran_size: 4M chunk_size: 64M num_reg: 10   lose cover
RAM: 30716M
[    0.000133]  gran_size: 4M chunk_size: 128M num_reg: 10   lose
cover RAM: 30718M
[    0.000134]  gran_size: 4M chunk_size: 256M num_reg: 10   lose
cover RAM: 30712M
[    0.000134]  gran_size: 4M chunk_size: 512M num_reg: 10   lose
cover RAM: 30712M
[    0.000135]  gran_size: 4M chunk_size: 1G num_reg: 10   lose cover
RAM: 30712M
[    0.000136]  gran_size: 4M chunk_size: 2G num_reg: 10   lose cover
RAM: 30712M
[    0.000136]  gran_size: 8M chunk_size: 8M num_reg: 10   lose cover
RAM: 30716M
[    0.000137]  gran_size: 8M chunk_size: 16M num_reg: 10   lose cover
RAM: 30716M
[    0.000137]  gran_size: 8M chunk_size: 32M num_reg: 10   lose cover
RAM: 30716M
[    0.000138]  gran_size: 8M chunk_size: 64M num_reg: 10   lose cover
RAM: 30716M
[    0.000139]  gran_size: 8M chunk_size: 128M num_reg: 10   lose
cover RAM: 30718M
[    0.000139]  gran_size: 8M chunk_size: 256M num_reg: 10   lose
cover RAM: 30712M
[    0.000140]  gran_size: 8M chunk_size: 512M num_reg: 10   lose
cover RAM: 30712M
[    0.000140]  gran_size: 8M chunk_size: 1G num_reg: 10   lose cover
RAM: 30712M
[    0.000141]  gran_size: 8M chunk_size: 2G num_reg: 10   lose cover
RAM: 30712M
[    0.000142]  gran_size: 16M chunk_size: 16M num_reg: 10   lose
cover RAM: 30716M
[    0.000142]  gran_size: 16M chunk_size: 32M num_reg: 10   lose
cover RAM: 30716M
[    0.000143]  gran_size: 16M chunk_size: 64M num_reg: 10   lose
cover RAM: 30716M
[    0.000144]  gran_size: 16M chunk_size: 128M num_reg: 10   lose
cover RAM: 30718M
[    0.000144]  gran_size: 16M chunk_size: 256M num_reg: 10   lose
cover RAM: 30712M
[    0.000145]  gran_size: 16M chunk_size: 512M num_reg: 10   lose
cover RAM: 30712M
[    0.000146]  gran_size: 16M chunk_size: 1G num_reg: 10   lose cover
RAM: 30712M
[    0.000146]  gran_size: 16M chunk_size: 2G num_reg: 10   lose cover
RAM: 30712M
[    0.000147]  gran_size: 32M chunk_size: 32M num_reg: 10   lose
cover RAM: 30716M
[    0.000147]  gran_size: 32M chunk_size: 64M num_reg: 10   lose
cover RAM: 30716M
[    0.000148]  gran_size: 32M chunk_size: 128M num_reg: 10   lose
cover RAM: 30718M
[    0.000149]  gran_size: 32M chunk_size: 256M num_reg: 10   lose
cover RAM: 30712M
[    0.000149]  gran_size: 32M chunk_size: 512M num_reg: 10   lose
cover RAM: 30712M
[    0.000150]  gran_size: 32M chunk_size: 1G num_reg: 10   lose cover
RAM: 30712M
[    0.000151]  gran_size: 32M chunk_size: 2G num_reg: 10   lose cover
RAM: 30712M
[    0.000151]  gran_size: 64M chunk_size: 64M num_reg: 10   lose
cover RAM: 30716M
[    0.000152]  gran_size: 64M chunk_size: 128M num_reg: 10   lose
cover RAM: 30718M
[    0.000152]  gran_size: 64M chunk_size: 256M num_reg: 10   lose
cover RAM: 30712M
[    0.000153]  gran_size: 64M chunk_size: 512M num_reg: 10   lose
cover RAM: 30712M
[    0.000154]  gran_size: 64M chunk_size: 1G num_reg: 10   lose cover
RAM: 30712M
[    0.000154]  gran_size: 64M chunk_size: 2G num_reg: 10   lose cover
RAM: 30712M
[    0.000155]  gran_size: 128M chunk_size: 128M num_reg: 10   lose
cover RAM: 30776M
[    0.000156]  gran_size: 128M chunk_size: 256M num_reg: 10   lose
cover RAM: 30776M
[    0.000156]  gran_size: 128M chunk_size: 512M num_reg: 10   lose
cover RAM: 30768M
[    0.000157]  gran_size: 128M chunk_size: 1G num_reg: 10   lose
cover RAM: 30768M
[    0.000158]  gran_size: 128M chunk_size: 2G num_reg: 10   lose
cover RAM: 30768M
[    0.000158]  gran_size: 256M chunk_size: 256M num_reg: 10   lose
cover RAM: 30776M
[    0.000159]  gran_size: 256M chunk_size: 512M num_reg: 10   lose
cover RAM: 30768M
[    0.000159]  gran_size: 256M chunk_size: 1G num_reg: 10   lose
cover RAM: 30768M
[    0.000160]  gran_size: 256M chunk_size: 2G num_reg: 10   lose
cover RAM: 30768M
[    0.000161]  gran_size: 512M chunk_size: 512M num_reg: 10   lose
cover RAM: 31024M
[    0.000161]  gran_size: 512M chunk_size: 1G num_reg: 10   lose
cover RAM: 31024M
[    0.000162]  gran_size: 512M chunk_size: 2G num_reg: 10   lose
cover RAM: 31024M
[    0.000163]  gran_size: 1G chunk_size: 1G num_reg: 10   lose cover
RAM: 31520M
[    0.000163]  gran_size: 1G chunk_size: 2G num_reg: 10   lose cover
RAM: 31520M
[    0.000164]  gran_size: 2G chunk_size: 2G num_reg: 10   lose cover
RAM: 32512M
[    0.000164] mtrr_cleanup: can not find optimal value
[    0.000165] please specify mtrr_gran_size/mtrr_chunk_size
[    0.000166] MTRR map: 8 entries (3 fixed + 5 variable; max 23),
built from 10 variable MTRRs
[    0.000167] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000647] e820: update [mem 0x74000000-0xffffffff] usable =3D=3D> rese=
rved
[    0.000649] e820: update [mem 0x880000000-0x8800fffff] usable =3D=3D> re=
served
[    0.000651] x2apic: enabled by BIOS, switching to x2apic ops
[    0.000652] last_pfn =3D 0x6c000 max_arch_pfn =3D 0x400000000
[    0.005263] esrt: Reserving ESRT space from 0x0000000059c0a418 to
0x0000000059c0a540.
[    0.005268] e820: update [mem 0x59c0a000-0x59c0afff] usable =3D=3D> rese=
rved
[    0.005279] Using GB pages for direct mapping
[    0.005365] secureboot: Secure boot enabled
[    0.005365] RAMDISK: [mem 0x49124000-0x4deb0fff]
[    0.005703] ACPI: Early table checksum verification disabled
[    0.005706] ACPI: RSDP 0x0000000067864014 000024 (v02 MSI_NB)
[    0.005709] ACPI: XSDT 0x0000000067863728 00019C (v01 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005714] ACPI: FACP 0x000000006774D000 000114 (v06 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005717] ACPI: DSDT 0x00000000676E9000 0637D9 (v02 MSI_NB
MEGABOOK 01072009 INTL 20210930)
[    0.005719] ACPI: FACS 0x00000000678E6000 000040
[    0.005721] ACPI: SSDT 0x0000000067765000 0006AA (v02 PmRef
Cpu0Ist  00003000 INTL 20210930)
[    0.005722] ACPI: SSDT 0x0000000067764000 0005E4 (v02 PmRef
Cpu0Hwp  00003000 INTL 20210930)
[    0.005724] ACPI: SSDT 0x0000000067763000 0001AB (v02 PmRef
Cpu0Psd  00003000 INTL 20210930)
[    0.005726] ACPI: SSDT 0x0000000067762000 000394 (v02 PmRef
Cpu0Cst  00003001 INTL 20210930)
[    0.005727] ACPI: SSDT 0x0000000067760000 001BAF (v02 PmRef  ApIst
  00003000 INTL 20210930)
[    0.005729] ACPI: SSDT 0x000000006775E000 001620 (v02 PmRef  ApHwp
  00003000 INTL 20210930)
[    0.005731] ACPI: SSDT 0x000000006775C000 001349 (v02 PmRef  ApPsd
  00003000 INTL 20210930)
[    0.005732] ACPI: SSDT 0x000000006775B000 000FBB (v02 PmRef  ApCst
  00003000 INTL 20210930)
[    0.005734] ACPI: SSDT 0x0000000067757000 003BC8 (v02 CpuRef
CpuSsdt  00003000 INTL 20210930)
[    0.005736] ACPI: DTPR 0x0000000067756000 000088 (v01
  00000000      00000000)
[    0.005738] ACPI: SSDT 0x0000000067750000 005D91 (v02 DptfTb
DptfTabl 00001000 INTL 20210930)
[    0.005739] ACPI: SSDT 0x000000006774E000 001033 (v02 INTEL
PDatTabl 00001000 INTL 20210930)
[    0.005741] ACPI: FIDT 0x00000000676E8000 00009C (v01 MSI_NB
MEGABOOK 01072009 AMI  00010013)
[    0.005742] ACPI: SSDT 0x0000000067767000 00038C (v02 PmaxDv
Pmax_Dev 00000001 INTL 20210930)
[    0.005744] ACPI: SSDT 0x0000000067766000 000066 (v02 MSI_NB MsiNvs
  00003000 INTL 20210930)
[    0.005746] ACPI: SSDT 0x00000000676E5000 002494 (v02 INTEL
IgfxSsdt 00003000 INTL 20210930)
[    0.005748] ACPI: SSDT 0x00000000676DB000 009AB7 (v02 INTEL
TcssSsdt 00001000 INTL 20210930)
[    0.005749] ACPI: HPET 0x00000000676DA000 000038 (v01 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005751] ACPI: APIC 0x00000000676D9000 000358 (v05 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005752] ACPI: MCFG 0x00000000676D8000 00003C (v01 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005754] ACPI: SSDT 0x00000000676D6000 00147F (v02 MSI_NB
I2Pm_Rvp 00001000 INTL 20210930)
[    0.005755] ACPI: SSDT 0x00000000676C5000 010171 (v02 MSI_NB
MtlP_Rvp 00001000 INTL 20210930)
[    0.005757] ACPI: UEFI 0x000000006781A000 000048 (v01 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005758] ACPI: LPIT 0x00000000676C4000 0000CC (v01 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005760] ACPI: SSDT 0x00000000676C2000 000CA6 (v02 MSI_NB
PtidDevc 00001000 INTL 20210930)
[    0.005761] ACPI: SSDT 0x00000000676BC000 00587D (v02 MSI_NB
TbtTypeC 00000000 INTL 20210930)
[    0.005763] ACPI: DBGP 0x00000000676BB000 000034 (v01 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005765] ACPI: DBG2 0x00000000676BA000 000054 (v00 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005766] ACPI: SSDT 0x00000000676B8000 001191 (v02 MSI_NB
UsbCTabl 00001000 INTL 20210930)
[    0.005768] ACPI: NHLT 0x00000000676B7000 000960 (v00 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005769] ACPI: DMAR 0x00000000676B6000 000098 (v01 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005771] ACPI: FPDT 0x00000000676B5000 000044 (v01 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005772] ACPI: SSDT 0x00000000676B3000 0010AD (v02 INTEL
xh_mtlpR 00000000 INTL 20210930)
[    0.005774] ACPI: SSDT 0x00000000676B0000 00281A (v02 SocGpe SocGpe
  00003000 INTL 20210930)
[    0.005776] ACPI: SSDT 0x00000000676AD000 0028D3 (v02 SocCmn SocCmn
  00003000 INTL 20210930)
[    0.005777] ACPI: SSDT 0x00000000676AC000 00004B (v02 MSI_NB
Free_DOS 00003000 INTL 20210930)
[    0.005779] ACPI: SDEV 0x00000000676AB000 000136 (v01 MSI_NB
MEGABOOK 01072009 AMI  01000013)
[    0.005780] ACPI: BGRT 0x00000000676AA000 000038 (v01 MSI_NB
MEGABOOK 01072009 AMI  00010013)
[    0.005782] ACPI: UEFI 0x0000000067817000 00063A (v01 INTEL
RstVmdE  00000000 INTL 00000000)
[    0.005783] ACPI: UEFI 0x0000000067816000 00005C (v01 INTEL
RstVmdV  00000000 INTL 00000000)
[    0.005785] ACPI: SSDT 0x00000000676A8000 0011A0 (v02 INTEL
St00Ssdt 00001000 INTL 20210930)
[    0.005787] ACPI: SSDT 0x00000000676A4000 003238 (v02 OptRf2
Opt2Tabl 00001000 INTL 20210930)
[    0.005788] ACPI: PHAT 0x00000000676A3000 000569 (v01 MSI_NB
MEGABOOK 00000005 MSFT 0100000D)
[    0.005790] ACPI: TPM2 0x00000000676A2000 00004C (v04 MSI_NB
MEGABOOK 00000001 AMI  00000000)
[    0.005791] ACPI: WSMT 0x00000000676C3000 000028 (v01 MSI_NB
MEGABOOK 01072009 AMI  00010013)
[    0.005793] ACPI: BGRT 0x00000000676A1000 000038 (v01 MSI_NB
MEGABOOK 01072009 AMI  00010013)
[    0.005794] ACPI: Reserving FACP table memory at [mem 0x6774d000-0x6774d=
113]
[    0.005795] ACPI: Reserving DSDT table memory at [mem 0x676e9000-0x6774c=
7d8]
[    0.005796] ACPI: Reserving FACS table memory at [mem 0x678e6000-0x678e6=
03f]
[    0.005796] ACPI: Reserving SSDT table memory at [mem 0x67765000-0x67765=
6a9]
[    0.005796] ACPI: Reserving SSDT table memory at [mem 0x67764000-0x67764=
5e3]
[    0.005797] ACPI: Reserving SSDT table memory at [mem 0x67763000-0x67763=
1aa]
[    0.005797] ACPI: Reserving SSDT table memory at [mem 0x67762000-0x67762=
393]
[    0.005798] ACPI: Reserving SSDT table memory at [mem 0x67760000-0x67761=
bae]
[    0.005798] ACPI: Reserving SSDT table memory at [mem 0x6775e000-0x6775f=
61f]
[    0.005798] ACPI: Reserving SSDT table memory at [mem 0x6775c000-0x6775d=
348]
[    0.005799] ACPI: Reserving SSDT table memory at [mem 0x6775b000-0x6775b=
fba]
[    0.005799] ACPI: Reserving SSDT table memory at [mem 0x67757000-0x6775a=
bc7]
[    0.005800] ACPI: Reserving DTPR table memory at [mem 0x67756000-0x67756=
087]
[    0.005800] ACPI: Reserving SSDT table memory at [mem 0x67750000-0x67755=
d90]
[    0.005800] ACPI: Reserving SSDT table memory at [mem 0x6774e000-0x6774f=
032]
[    0.005801] ACPI: Reserving FIDT table memory at [mem 0x676e8000-0x676e8=
09b]
[    0.005801] ACPI: Reserving SSDT table memory at [mem 0x67767000-0x67767=
38b]
[    0.005802] ACPI: Reserving SSDT table memory at [mem 0x67766000-0x67766=
065]
[    0.005802] ACPI: Reserving SSDT table memory at [mem 0x676e5000-0x676e7=
493]
[    0.005803] ACPI: Reserving SSDT table memory at [mem 0x676db000-0x676e4=
ab6]
[    0.005803] ACPI: Reserving HPET table memory at [mem 0x676da000-0x676da=
037]
[    0.005803] ACPI: Reserving APIC table memory at [mem 0x676d9000-0x676d9=
357]
[    0.005804] ACPI: Reserving MCFG table memory at [mem 0x676d8000-0x676d8=
03b]
[    0.005804] ACPI: Reserving SSDT table memory at [mem 0x676d6000-0x676d7=
47e]
[    0.005805] ACPI: Reserving SSDT table memory at [mem 0x676c5000-0x676d5=
170]
[    0.005805] ACPI: Reserving UEFI table memory at [mem 0x6781a000-0x6781a=
047]
[    0.005805] ACPI: Reserving LPIT table memory at [mem 0x676c4000-0x676c4=
0cb]
[    0.005806] ACPI: Reserving SSDT table memory at [mem 0x676c2000-0x676c2=
ca5]
[    0.005806] ACPI: Reserving SSDT table memory at [mem 0x676bc000-0x676c1=
87c]
[    0.005807] ACPI: Reserving DBGP table memory at [mem 0x676bb000-0x676bb=
033]
[    0.005807] ACPI: Reserving DBG2 table memory at [mem 0x676ba000-0x676ba=
053]
[    0.005807] ACPI: Reserving SSDT table memory at [mem 0x676b8000-0x676b9=
190]
[    0.005808] ACPI: Reserving NHLT table memory at [mem 0x676b7000-0x676b7=
95f]
[    0.005808] ACPI: Reserving DMAR table memory at [mem 0x676b6000-0x676b6=
097]
[    0.005809] ACPI: Reserving FPDT table memory at [mem 0x676b5000-0x676b5=
043]
[    0.005809] ACPI: Reserving SSDT table memory at [mem 0x676b3000-0x676b4=
0ac]
[    0.005809] ACPI: Reserving SSDT table memory at [mem 0x676b0000-0x676b2=
819]
[    0.005810] ACPI: Reserving SSDT table memory at [mem 0x676ad000-0x676af=
8d2]
[    0.005810] ACPI: Reserving SSDT table memory at [mem 0x676ac000-0x676ac=
04a]
[    0.005811] ACPI: Reserving SDEV table memory at [mem 0x676ab000-0x676ab=
135]
[    0.005811] ACPI: Reserving BGRT table memory at [mem 0x676aa000-0x676aa=
037]
[    0.005811] ACPI: Reserving UEFI table memory at [mem 0x67817000-0x67817=
639]
[    0.005812] ACPI: Reserving UEFI table memory at [mem 0x67816000-0x67816=
05b]
[    0.005812] ACPI: Reserving SSDT table memory at [mem 0x676a8000-0x676a9=
19f]
[    0.005813] ACPI: Reserving SSDT table memory at [mem 0x676a4000-0x676a7=
237]
[    0.005813] ACPI: Reserving PHAT table memory at [mem 0x676a3000-0x676a3=
568]
[    0.005814] ACPI: Reserving TPM2 table memory at [mem 0x676a2000-0x676a2=
04b]
[    0.005814] ACPI: Reserving WSMT table memory at [mem 0x676c3000-0x676c3=
027]
[    0.005815] ACPI: Reserving BGRT table memory at [mem 0x676a1000-0x676a1=
037]
[    0.005861] APIC: Switched APIC routing to: cluster x2apic
[    0.006031] No NUMA configuration found
[    0.006031] Faking a node at [mem 0x0000000000000000-0x000000087fffffff]
[    0.006035] NODE_DATA(0) allocated [mem 0x87ffd3540-0x87fffdfff]
[    0.006168] Zone ranges:
[    0.006169]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.006170]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.006171]   Normal   [mem 0x0000000100000000-0x000000087fffffff]
[    0.006172]   Device   empty
[    0.006172] Movable zone start for each node
[    0.006173] Early memory node ranges
[    0.006173]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.006174]   node   0: [mem 0x0000000000100000-0x00000000635f2fff]
[    0.006175]   node   0: [mem 0x000000006bfff000-0x000000006bffffff]
[    0.006175]   node   0: [mem 0x0000000100000000-0x000000087fffffff]
[    0.006177] Initmem setup node 0 [mem 0x0000000000001000-0x000000087ffff=
fff]
[    0.006181] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.006202] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.008491] On node 0, zone DMA32: 35340 pages in unavailable ranges
[    0.050003] On node 0, zone Normal: 16384 pages in unavailable ranges
[    0.050518] ACPI: PM-Timer IO Port: 0x1808
[    0.050523] CPU topo: Boot CPU APIC ID not the first enumerated
APIC ID: 20 !=3D 10
[    0.050524] CPU topo: [Firmware Bug]: APIC enumeration order not
specification compliant
[    0.050527] ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
[    0.050570] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.050572] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.050574] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.050576] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.050577] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.050585] e820: update [mem 0x59a0e000-0x59bbefff] usable =3D=3D> rese=
rved
[    0.050593] TSC deadline timer available
[    0.050596] CPU topo: Max. logical packages:   1
[    0.050596] CPU topo: Max. logical dies:       1
[    0.050597] CPU topo: Max. dies per package:   1
[    0.050599] CPU topo: Max. threads per core:   1
[    0.050599] CPU topo: Num. cores per package:    16
[    0.050600] CPU topo: Num. threads per package:  16
[    0.050600] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    0.050611] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.050613] PM: hibernation: Registered nosave memory: [mem
0x0009f000-0x000fffff]
[    0.050614] PM: hibernation: Registered nosave memory: [mem
0x59a0e000-0x59bbefff]
[    0.050614] PM: hibernation: Registered nosave memory: [mem
0x59c0a000-0x59c0afff]
[    0.050616] PM: hibernation: Registered nosave memory: [mem
0x635f3000-0x6bffefff]
[    0.050616] PM: hibernation: Registered nosave memory: [mem
0x6c000000-0xffffffff]
[    0.050618] [mem 0x78800000-0xfdffffff] available for PCI devices
[    0.050619] Booting paravirtualized kernel on bare hardware
[    0.050621] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.050627] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16
nr_cpu_ids:16 nr_node_ids:1
[    0.051646] percpu: Embedded 88 pages/cpu s237568 r8192 d114688 u524288
[    0.051649] pcpu-alloc: s237568 r8192 d114688 u524288 alloc=3D1*2097152
[    0.051651] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
[    0.051653] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
[    0.051670] Kernel command line:
BOOT_IMAGE=3D/vmlinuz-6.14.0-32-generic root=3D/dev/mapper/vgmint-root ro
quiet splash
[    0.051717] Unknown kernel command line parameters "splash
BOOT_IMAGE=3D/vmlinuz-6.14.0-32-generic", will be passed to user space.
[    0.051726] printk: log buffer data + meta data: 262144 + 917504 =3D
1179648 bytes
[    0.054529] Dentry cache hash table entries: 4194304 (order: 13,
33554432 bytes, linear)
[    0.055941] Inode-cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.056062] Fallback order for Node 0: 0
[    0.056065] Built 1 zonelists, mobility grouping on.  Total pages: 82712=
50
[    0.056066] Policy zone: Normal
[    0.056074] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.056084] software IO TLB: area num 16.
[    0.106838] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, =
Nodes=3D1
[    0.106880] ftrace: allocating 60395 entries in 236 pages
[    0.121538] ftrace: allocated 236 pages with 5 groups
[    0.122285] Dynamic Preempt: voluntary
[    0.122349] rcu: Preemptible hierarchical RCU implementation.
[    0.122350] rcu: RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D16.
[    0.122351] Trampoline variant of Tasks RCU enabled.
[    0.122351] Rude variant of Tasks RCU enabled.
[    0.122352] Tracing variant of Tasks RCU enabled.
[    0.122352] rcu: RCU calculated value of scheduler-enlistment delay
is 100 jiffies.
[    0.122352] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D16
[    0.122362] RCU Tasks: Setting shift to 4 and lim to 1
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D16.
[    0.122364] RCU Tasks Rude: Setting shift to 4 and lim to 1
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D16.
[    0.122366] RCU Tasks Trace: Setting shift to 4 and lim to 1
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D16.
[    0.124247] NR_IRQS: 524544, nr_irqs: 2184, preallocated irqs: 16
[    0.124541] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.124720] Console: colour dummy device 80x25
[    0.124723] printk: legacy console [tty0] enabled
[    0.124767] ACPI: Core revision 20240827
[    0.125071] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.125122] APIC: Switch to symmetric I/O mode setup
[    0.125123] DMAR: Host address width 42
[    0.125124] DMAR: DRHD base: 0x000000fc800000 flags: 0x0
[    0.125133] DMAR: dmar0: reg_base_addr fc800000 ver 7:0 cap
c9de008cee690462 ecap 12ca9a00f0ef5e
[    0.125135] DMAR: DRHD base: 0x000000fc801000 flags: 0x1
[    0.125139] DMAR: dmar1: reg_base_addr fc801000 ver 7:0 cap
c9de008cee690462 ecap 12ca9a00f0efde
[    0.125140] DMAR: SATC flags: 0x1
[    0.125143] DMAR-IR: IOAPIC id 2 under DRHD base  0xfc801000 IOMMU 1
[    0.125144] DMAR-IR: HPET id 0 under DRHD base 0xfc801000
[    0.125144] DMAR-IR: Queued invalidation will be enabled to support
x2apic and Intr-remapping.
[    0.126753] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.130699] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x2c47f5688fc, max_idle_ns: 440795305069 ns
[    0.130705] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6144.00 BogoMIPS (lpj=3D3072000)
[    0.130757] CPU0: Thermal monitoring enabled (TM1)
[    0.130758] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.130924] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.130925] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.130927] process: using mwait in idle threads
[    0.130929] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.130931] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.130932] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.130933] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl
[    0.130941] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.130942] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.130943] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.130943] x86/fpu: Supporting XSAVE feature 0x200: 'Protection
Keys User registers'
[    0.130944] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow
User registers'
[    0.130944] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.130945] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.130946] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.130946] x86/fpu: Enabled xstate features 0xa07, context size is
856 bytes, using 'compacted' format.
[    0.131703] Freeing SMP alternatives memory: 48K
[    0.131703] pid_max: default: 32768 minimum: 301
[    0.131703] LSM: initializing
lsm=3Dlockdown,capability,landlock,yama,apparmor,ima,evm
[    0.131703] landlock: Up and running.
[    0.131703] Yama: becoming mindful.
[    0.131703] AppArmor: AppArmor initialized
[    0.131703] Mount-cache hash table entries: 65536 (order: 7, 524288
bytes, linear)
[    0.131703] Mountpoint-cache hash table entries: 65536 (order: 7,
524288 bytes, linear)
[    0.131703] smpboot: CPU0: Intel(R) Core(TM) Ultra 9 185H (family:
0x6, model: 0xaa, stepping: 0x4)
[    0.131703] Performance Events: XSAVE Architectural LBR, PEBS
fmt4+-baseline,  AnyThread deprecated, Meteorlake Hybrid events,
32-deep LBR, full-width counters, Intel PMU driver.
[    0.131703] core: cpu_core PMU driver:
[    0.131703] ... version:                5
[    0.131703] ... bit width:              48
[    0.131703] ... generic registers:      8
[    0.131703] ... value mask:             0000ffffffffffff
[    0.131703] ... max period:             00007fffffffffff
[    0.131703] ... fixed-purpose events:   4
[    0.131703] ... event mask:             0001000f000000ff
[    0.131703] signal: max sigframe size: 3632
[    0.131703] Estimated ratio of average max frequency by base
frequency (times 1024): 1684
[    0.131931] rcu: Hierarchical SRCU implementation.
[    0.131933] rcu: Max phase no-delay instances is 400.
[    0.131961] Timer migration: 2 hierarchy levels; 8 children per
group; 2 crossnode level
[    0.132662] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.132774] smp: Bringing up secondary CPUs ...
[    0.132845] smpboot: x86: Booting SMP configuration:
[    0.132845] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
#8  #9 #10 #11 #12 #13 #14 #15
[    0.007030] core: cpu_atom PMU driver:
[    0.007030] ... version:                5
[    0.007030] ... bit width:              48
[    0.007030] ... generic registers:      8
[    0.007030] ... value mask:             0000ffffffffffff
[    0.007030] ... max period:             00007fffffffffff
[    0.007030] ... fixed-purpose events:   3
[    0.007030] ... event mask:             00000007000000ff
[    0.139726] smp: Brought up 1 node, 16 CPUs
[    0.139732] smpboot: Total of 16 processors activated (98304.00 BogoMIPS=
)
[    0.140851] Memory: 32279108K/33085000K available (21450K kernel
code, 4570K rwdata, 15060K rodata, 5140K init, 4432K bss, 776884K
reserved, 0K cma-reserved)
[    0.141754] devtmpfs: initialized
[    0.141754] x86/mm: Memory block size: 128MB
[    0.143196] ACPI: PM: Registering ACPI NVS region [mem
0x67768000-0x678eafff] (1585152 bytes)
[    0.143196] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.143196] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)
[    0.143196] pinctrl core: initialized pinctrl subsystem
[    0.143196] PM: RTC time: 15:18:37, date: 2025-09-28
[    0.143840] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.144259] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.144603] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[    0.144941] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool
for atomic allocations
[    0.144947] audit: initializing netlink subsys (disabled)
[    0.144972] audit: type=3D2000 audit(1759072717.014:1):
state=3Dinitialized audit_enabled=3D0 res=3D1
[    0.144972] thermal_sys: Registered thermal governor 'fair_share'
[    0.144972] thermal_sys: Registered thermal governor 'bang_bang'
[    0.144972] thermal_sys: Registered thermal governor 'step_wise'
[    0.144972] thermal_sys: Registered thermal governor 'user_space'
[    0.144972] thermal_sys: Registered thermal governor 'power_allocator'
[    0.144972] cpuidle: using governor ladder
[    0.144972] cpuidle: using governor menu
[    0.144972] ACPI FADT declares the system doesn't support PCIe
ASPM, so disable it
[    0.144972] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.144972] PCI: ECAM [mem 0xc0000000-0xcdffffff] (base 0xc0000000)
for domain 0000 [bus 00-df]
[    0.144972] PCI: Using configuration type 1 for base access
[    0.144972] kprobes: kprobe jump-optimization is enabled. All
kprobes are optimized if possible.
[    0.148725] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 page=
s
[    0.148726] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.148727] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s
[    0.148728] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.149627] ACPI: Added _OSI(Module Device)
[    0.149628] ACPI: Added _OSI(Processor Device)
[    0.149629] ACPI: Added _OSI(Processor Aggregator Device)
[    0.248367] ACPI: 27 ACPI AML tables successfully acquired and loaded
[    0.259859] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomai=
n+
[    0.259862] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomai=
n+
[    0.263714] ACPI: EC: EC started
[    0.263715] ACPI: EC: interrupt blocked
[    0.270479] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.270482] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC used to handle
transactions
[    0.270483] ACPI: Interpreter enabled
[    0.270547] ACPI: PM: (supports S0 S3 S4 S5)
[    0.270548] ACPI: Using IOAPIC for interrupt routing
[    0.271920] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=3Dnocrs" and report a bug
[    0.271922] PCI: Ignoring E820 reservations for host bridge windows
[    0.272952] ACPI: Enabled 11 GPEs in block 00 to 7F
[    0.272971] ACPI: Enabled 8 GPEs in block 80 to DF
[    0.274803] ACPI: \_SB_.PC00.RP01.PXP_: New power resource
[    0.275949] ACPI: \_SB_.PC00.RP01.PXSX.WRST: New power resource
[    0.278913] ACPI: \_SB_.PC00.RP06.PXP_: New power resource
[    0.281695] ACPI: \_SB_.PC00.RP09.PXP_: New power resource
[    0.282846] ACPI: \_SB_.PC00.RP10.PXP_: New power resource
[    0.283986] ACPI: \_SB_.PC00.RP11.PXP_: New power resource
[    0.285570] ACPI: \_SB_.PC00.RP12.PXP_: New power resource
[    0.291646] ACPI: \_SB_.PC00.XHCI.RHUB.HS10.BTRT: New power resource
[    0.291698] ACPI: \_SB_.PC00.XHCI.RHUB.HS10.DBTR: New power resource
[    0.291941] ACPI: \_SB_.PC00.PAUD: New power resource
[    0.296772] ACPI: \_SB_.PC00.I2C3.PXTC: New power resource
[    0.305096] ACPI: \_SB_.PC00.TBT0: New power resource
[    0.305154] ACPI: \_SB_.PC00.TBT1: New power resource
[    0.305208] ACPI: \_SB_.PC00.D3C_: New power resource
[    0.321781] ACPI: \PIN_: New power resource
[    0.322476] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-df])
[    0.322482] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI EDR HPX-Type3]
[    0.323273] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.324803] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug
SHPCHotplug PME PCIeCapability LTR DPC]
[    0.324805] acpi PNP0A08:00: FADT indicates ASPM is unsupported,
using BIOS configuration
[    0.326514] PCI host bridge to bus 0000:00
[    0.326517] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]
[    0.326519] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    0.326520] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.326522] pci_bus 0000:00: root bus resource [mem
0x80000000-0xbfffffff window]
[    0.326523] pci_bus 0000:00: root bus resource [mem
0x4000000000-0x3ffbfffffff window]
[    0.326525] pci_bus 0000:00: root bus resource [bus 00-df]
[    0.428813] pci 0000:00:00.0: [8086:7d01] type 00 class 0x060000
conventional PCI endpoint
[    0.428981] pci 0000:00:01.0: [8086:7ecc] type 01 class 0x060400
PCIe Root Port
[    0.428999] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.429002] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    0.429004] pci 0000:00:01.0:   bridge window [mem 0x87000000-0x880fffff=
]
[    0.429010] pci 0000:00:01.0:   bridge window [mem
0x4000000000-0x4201ffffff 64bit pref]
[    0.429065] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.429096] pci 0000:00:01.0: PTM enabled (root), 4ns granularity
[    0.429890] pci 0000:00:02.0: [8086:7d55] type 00 class 0x030000
PCIe Root Complex Integrated Endpoint
[    0.429914] pci 0000:00:02.0: BAR 0 [mem 0x4a20000000-0x4a20ffffff
64bit pref]
[    0.429916] pci 0000:00:02.0: BAR 2 [mem 0x4210000000-0x421fffffff
64bit pref]
[    0.429934] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.429937] pci 0000:00:02.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.429967] pci 0000:00:02.0: PME# supported from D0 D3hot
[    0.429992] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64bit =
pref]
[    0.429994] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff
64bit pref]: contains BAR 0 for 7 VFs
[    0.430187] pci 0000:00:04.0: [8086:7d03] type 00 class 0x118000
conventional PCI endpoint
[    0.430220] pci 0000:00:04.0: BAR 0 [mem 0x4a33280000-0x4a3329ffff 64bit=
]
[    0.430543] pci 0000:00:07.0: [8086:7ec4] type 01 class 0x060400
PCIe Root Port
[    0.430564] pci 0000:00:07.0: PCI bridge to [bus 02-2b]
[    0.430573] pci 0000:00:07.0:   bridge window [mem 0x80000000-0x85ffffff=
]
[    0.430581] pci 0000:00:07.0:   bridge window [mem
0x4220000000-0x4a1fffffff 64bit pref]
[    0.430676] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.430713] pci 0000:00:07.0: PTM enabled (root), 4ns granularity
[    0.431605] pci 0000:00:08.0: [8086:7e4c] type 00 class 0x088000
conventional PCI endpoint
[    0.431635] pci 0000:00:08.0: BAR 0 [mem 0x4a332ce000-0x4a332cefff 64bit=
]
[    0.431730] pci 0000:00:0a.0: [8086:7d0d] type 00 class 0x118000
PCIe Root Complex Integrated Endpoint
[    0.431748] pci 0000:00:0a.0: BAR 0 [mem 0x4a33240000-0x4a3327ffff 64bit=
]
[    0.431754] pci 0000:00:0a.0: enabling Extended Tags
[    0.431820] pci 0000:00:0b.0: [8086:7d1d] type 00 class 0x120000
PCIe Root Complex Integrated Endpoint
[    0.431839] pci 0000:00:0b.0: BAR 0 [mem 0x4a28000000-0x4a2fffffff 64bit=
]
[    0.431842] pci 0000:00:0b.0: BAR 4 [mem 0x4a332cd000-0x4a332cdfff 64bit=
]
[    0.431967] pci 0000:00:0d.0: [8086:7ec0] type 00 class 0x0c0330
conventional PCI endpoint
[    0.431996] pci 0000:00:0d.0: BAR 0 [mem 0x4a332b0000-0x4a332bffff 64bit=
]
[    0.432028] pci 0000:00:0d.0: PME# supported from D3hot D3cold
[    0.432528] pci 0000:00:0d.2: [8086:7ec2] type 00 class 0x0c0340
conventional PCI endpoint
[    0.432555] pci 0000:00:0d.2: BAR 0 [mem 0x4a33200000-0x4a3323ffff 64bit=
]
[    0.432558] pci 0000:00:0d.2: BAR 2 [mem 0x4a332cc000-0x4a332ccfff 64bit=
]
[    0.432584] pci 0000:00:0d.2: supports D1 D2
[    0.432585] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.432753] pci 0000:00:0e.0: [8086:7d0b] type 00 class 0x010400
PCIe Root Complex Integrated Endpoint
[    0.432786] pci 0000:00:0e.0: BAR 0 [mem 0x4a30000000-0x4a31ffffff 64bit=
]
[    0.432788] pci 0000:00:0e.0: BAR 2 [mem 0x86000000-0x86ffffff]
[    0.432791] pci 0000:00:0e.0: BAR 4 [mem 0x4a32000000-0x4a32ffffff 64bit=
]
[    0.433011] pci 0000:00:14.0: [8086:7e7d] type 00 class 0x0c0330
conventional PCI endpoint
[    0.433039] pci 0000:00:14.0: BAR 0 [mem 0x4a332a0000-0x4a332affff 64bit=
]
[    0.433070] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.433576] pci 0000:00:14.2: [8086:7e7f] type 00 class 0x050000
conventional PCI endpoint
[    0.433613] pci 0000:00:14.2: BAR 0 [mem 0x4a332c4000-0x4a332c7fff 64bit=
]
[    0.433616] pci 0000:00:14.2: BAR 2 [mem 0x4a332cb000-0x4a332cbfff 64bit=
]
[    0.433754] pci 0000:00:15.0: [8086:7e78] type 00 class 0x0c8000
conventional PCI endpoint
[    0.433795] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.443973] pci 0000:00:16.0: [8086:7e70] type 00 class 0x078000
conventional PCI endpoint
[    0.444024] pci 0000:00:16.0: BAR 0 [mem 0x4a332c9000-0x4a332c9fff 64bit=
]
[    0.444075] pci 0000:00:16.0: PME# supported from D3hot
[    0.444789] pci 0000:00:1c.0: [8086:7e38] type 01 class 0x060400
PCIe Root Port
[    0.444806] pci 0000:00:1c.0: PCI bridge to [bus 2c]
[    0.444810] pci 0000:00:1c.0:   bridge window [mem 0x88400000-0x884fffff=
]
[    0.444867] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.444899] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.445725] pci 0000:00:1c.2: [8086:7e3a] type 01 class 0x060400
PCIe Root Port
[    0.445742] pci 0000:00:1c.2: PCI bridge to [bus 2d]
[    0.445745] pci 0000:00:1c.2:   bridge window [io  0x3000-0x3fff]
[    0.445747] pci 0000:00:1c.2:   bridge window [mem 0x88300000-0x883fffff=
]
[    0.445803] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.445832] pci 0000:00:1c.2: PTM enabled (root), 4ns granularity
[    0.446622] pci 0000:00:1c.4: [8086:7e3c] type 01 class 0x060400
PCIe Root Port
[    0.446638] pci 0000:00:1c.4: PCI bridge to [bus 2e]
[    0.446642] pci 0000:00:1c.4:   bridge window [mem 0x88200000-0x882fffff=
]
[    0.446697] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.446727] pci 0000:00:1c.4: PTM enabled (root), 4ns granularity
[    0.447531] pci 0000:00:1f.0: [8086:7e02] type 00 class 0x060100
conventional PCI endpoint
[    0.447934] pci 0000:00:1f.3: [8086:7e28] type 00 class 0x040100
conventional PCI endpoint
[    0.448005] pci 0000:00:1f.3: BAR 0 [mem 0x4a332c0000-0x4a332c3fff 64bit=
]
[    0.448016] pci 0000:00:1f.3: BAR 4 [mem 0x4a33000000-0x4a331fffff 64bit=
]
[    0.448086] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.448163] pci 0000:00:1f.4: [8086:7e22] type 00 class 0x0c0500
conventional PCI endpoint
[    0.448201] pci 0000:00:1f.4: BAR 0 [mem 0x4a332c8000-0x4a332c80ff 64bit=
]
[    0.448208] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.448468] pci 0000:00:1f.5: [8086:7e23] type 00 class 0x0c8000
conventional PCI endpoint
[    0.448566] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.448726] pci 0000:01:00.0: [10de:2820] type 00 class 0x030000
PCIe Legacy Endpoint
[    0.448755] pci 0000:01:00.0: BAR 0 [mem 0x87000000-0x87ffffff]
[    0.448757] pci 0000:01:00.0: BAR 1 [mem 0x4000000000-0x41ffffffff
64bit pref]
[    0.448760] pci 0000:01:00.0: BAR 3 [mem 0x4200000000-0x4201ffffff
64bit pref]
[    0.448762] pci 0000:01:00.0: BAR 5 [io  0x4000-0x407f]
[    0.448763] pci 0000:01:00.0: ROM [mem 0x88000000-0x8807ffff pref]
[    0.448821] pci 0000:01:00.0: PME# supported from D0 D3hot
[    0.449187] pci 0000:01:00.1: [10de:22bd] type 00 class 0x040300
PCIe Endpoint
[    0.449216] pci 0000:01:00.1: BAR 0 [mem 0x88080000-0x88083fff]
[    0.449328] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.449383] pci 0000:00:07.0: PCI bridge to [bus 02-2b]
[    0.449973] pci 0000:2c:00.0: [8086:272b] type 00 class 0x028000
PCIe Endpoint
[    0.450178] pci 0000:2c:00.0: BAR 0 [mem 0x88400000-0x88403fff 64bit]
[    0.450495] pci 0000:2c:00.0: PME# supported from D0 D3hot D3cold
[    0.453858] pci 0000:00:1c.0: PCI bridge to [bus 2c]
[    0.453915] pci 0000:2d:00.0: [10ec:3000] type 00 class 0x020000
PCIe Endpoint
[    0.453962] pci 0000:2d:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.453967] pci 0000:2d:00.0: BAR 2 [mem 0x88300000-0x8830ffff 64bit]
[    0.453970] pci 0000:2d:00.0: BAR 4 [mem 0x88310000-0x88313fff 64bit]
[    0.454066] pci 0000:2d:00.0: supports D1 D2
[    0.454067] pci 0000:2d:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.454299] pci 0000:00:1c.2: PCI bridge to [bus 2d]
[    0.454423] pci 0000:2e:00.0: [10ec:525a] type 00 class 0xff0000
PCIe Endpoint
[    0.454627] pci 0000:2e:00.0: BAR 1 [mem 0x88200000-0x88200fff]
[    0.454979] pci 0000:2e:00.0: supports D1 D2
[    0.454980] pci 0000:2e:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.455574] pci 0000:00:1c.4: PCI bridge to [bus 2e]
[    0.459529] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.459654] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.459777] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.459899] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.460022] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.460144] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.460265] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.460387] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.461270] ACPI: \_SB_.PEPD: Duplicate LPS0 _DSM functions (mask: 0x1)
[    0.595619] Low-power S0 idle used by default for system suspend
[    0.597525] ACPI: EC: interrupt unblocked
[    0.597526] ACPI: EC: event unblocked
[    0.597545] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.597547] ACPI: EC: GPE=3D0x6e
[    0.597548] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC initialization comp=
lete
[    0.597549] ACPI: \_SB_.PC00.LPCB.EC__: EC: Used to handle
transactions and events
[    0.597710] iommu: Default domain type: Translated
[    0.597710] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.597838] SCSI subsystem initialized
[    0.597844] libata version 3.00 loaded.
[    0.597844] ACPI: bus type USB registered
[    0.597844] usbcore: registered new interface driver usbfs
[    0.597844] usbcore: registered new interface driver hub
[    0.597844] usbcore: registered new device driver usb
[    0.597844] pps_core: LinuxPPS API ver. 1 registered
[    0.597844] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.597844] PTP clock support registered
[    0.597858] EDAC MC: Ver: 3.0.0
[    0.598760] efivars: Registered efivars operations
[    0.598978] NetLabel: Initializing
[    0.598979] NetLabel:  domain hash size =3D 128
[    0.598981] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.599007] NetLabel:  unlabeled traffic allowed by default
[    0.599024] mctp: management component transport protocol core
[    0.599024] NET: Registered PF_MCTP protocol family
[    0.599024] PCI: Using ACPI for IRQ routing
[    0.609306] PCI: pci_cache_line_size set to 64 bytes
[    0.609550] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]:
can't claim; no compatible bridge window
[    0.609730] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.609733] e820: reserve RAM buffer [mem 0x594ca018-0x5bffffff]
[    0.609734] e820: reserve RAM buffer [mem 0x59a0e000-0x5bffffff]
[    0.609735] e820: reserve RAM buffer [mem 0x59c0a000-0x5bffffff]
[    0.609736] e820: reserve RAM buffer [mem 0x635f3000-0x63ffffff]
[    0.609765] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.609765] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.609765] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.609765] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.609765] pci 0000:01:00.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
[    0.609765] vgaarb: loaded
[    0.609768] clocksource: Switched to clocksource tsc-early
[    0.610393] VFS: Disk quotas dquot_6.6.0
[    0.610403] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.610477] AppArmor: AppArmor Filesystem Enabled
[    0.610508] pnp: PnP ACPI init
[    0.610856] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.610859] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.610983] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.611814] pnp 00:04: disabling [mem 0x00000000-0x00000fff]
because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff
64bit pref]
[    0.611817] pnp 00:04: disabling [mem 0x00000000-0x00000fff]
because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff
64bit pref]
[    0.611840] system 00:04: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.611842] system 00:04: [mem 0xc0000000-0xcfffffff] has been reserved
[    0.611843] system 00:04: [mem 0xfed20000-0xfed7ffff] could not be reser=
ved
[    0.611844] system 00:04: [mem 0xfc800000-0xfc81ffff] could not be reser=
ved
[    0.611845] system 00:04: [mem 0xfed45000-0xfed8ffff] could not be reser=
ved
[    0.611847] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.612715] system 00:05: [io  0x2000-0x20fe] has been reserved
[    0.613366] pnp: PnP ACPI: found 7 devices
[    0.618898] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.618953] NET: Registered PF_INET protocol family
[    0.619191] IP idents hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.634085] tcp_listen_portaddr_hash hash table entries: 16384
(order: 6, 262144 bytes, linear)
[    0.634131] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
[    0.634229] TCP established hash table entries: 262144 (order: 9,
2097152 bytes, linear)
[    0.634556] TCP bind hash table entries: 65536 (order: 9, 2097152
bytes, linear)
[    0.634650] TCP: Hash tables configured (established 262144 bind 65536)
[    0.634816] MPTCP token hash table entries: 32768 (order: 7, 786432
bytes, linear)
[    0.634966] UDP hash table entries: 16384 (order: 8, 1048576 bytes, line=
ar)
[    0.635136] UDP-Lite hash table entries: 16384 (order: 8, 1048576
bytes, linear)
[    0.635254] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.635261] NET: Registered PF_XDP protocol family
[    0.635267] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
[    0.635280] pci 0000:00:02.0: VF BAR 0 [mem
0x4202000000-0x4208ffffff 64bit pref]: assigned
[    0.635285] pci 0000:00:07.0: bridge window [io  0x5000-0x5fff]: assigne=
d
[    0.635287] pci 0000:00:15.0: BAR 0 [mem 0x4209000000-0x4209000fff
64bit]: assigned
[    0.635301] pci 0000:00:1f.5: BAR 0 [mem 0x88100000-0x88100fff]: assigne=
d
[    0.635311] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.635314] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    0.635317] pci 0000:00:01.0:   bridge window [mem 0x87000000-0x880fffff=
]
[    0.635319] pci 0000:00:01.0:   bridge window [mem
0x4000000000-0x4201ffffff 64bit pref]
[    0.635323] pci 0000:00:07.0: PCI bridge to [bus 02-2b]
[    0.635329] pci 0000:00:07.0:   bridge window [io  0x5000-0x5fff]
[    0.635332] pci 0000:00:07.0:   bridge window [mem 0x80000000-0x85ffffff=
]
[    0.635335] pci 0000:00:07.0:   bridge window [mem
0x4220000000-0x4a1fffffff 64bit pref]
[    0.635340] pci 0000:00:1c.0: PCI bridge to [bus 2c]
[    0.635343] pci 0000:00:1c.0:   bridge window [mem 0x88400000-0x884fffff=
]
[    0.635348] pci 0000:00:1c.2: PCI bridge to [bus 2d]
[    0.635349] pci 0000:00:1c.2:   bridge window [io  0x3000-0x3fff]
[    0.635352] pci 0000:00:1c.2:   bridge window [mem 0x88300000-0x883fffff=
]
[    0.635357] pci 0000:00:1c.4: PCI bridge to [bus 2e]
[    0.635360] pci 0000:00:1c.4:   bridge window [mem 0x88200000-0x882fffff=
]
[    0.635365] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.635366] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.635367] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.635368] pci_bus 0000:00: resource 7 [mem 0x80000000-0xbfffffff windo=
w]
[    0.635369] pci_bus 0000:00: resource 8 [mem
0x4000000000-0x3ffbfffffff window]
[    0.635370] pci_bus 0000:01: resource 0 [io  0x4000-0x4fff]
[    0.635371] pci_bus 0000:01: resource 1 [mem 0x87000000-0x880fffff]
[    0.635372] pci_bus 0000:01: resource 2 [mem
0x4000000000-0x4201ffffff 64bit pref]
[    0.635374] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
[    0.635375] pci_bus 0000:02: resource 1 [mem 0x80000000-0x85ffffff]
[    0.635375] pci_bus 0000:02: resource 2 [mem
0x4220000000-0x4a1fffffff 64bit pref]
[    0.635377] pci_bus 0000:2c: resource 1 [mem 0x88400000-0x884fffff]
[    0.635378] pci_bus 0000:2d: resource 0 [io  0x3000-0x3fff]
[    0.635379] pci_bus 0000:2d: resource 1 [mem 0x88300000-0x883fffff]
[    0.635380] pci_bus 0000:2e: resource 1 [mem 0x88200000-0x882fffff]
[    0.635919] pci 0000:01:00.1: extending delay after power-on from
D3hot to 20 msec
[    0.635949] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.636140] PCI: CLS 64 bytes, default 64
[    0.636224] DMAR: No RMRR found
[    0.636225] DMAR: No ATSR found
[    0.636227] DMAR: dmar0: Using Queued invalidation
[    0.636230] DMAR: dmar1: Using Queued invalidation
[    0.636262] Trying to unpack rootfs image as initramfs...
[    0.636766] pci 0000:00:02.0: Adding to iommu group 0
[    0.636894] pci 0000:00:00.0: Adding to iommu group 1
[    0.636924] pci 0000:00:01.0: Adding to iommu group 2
[    0.636934] pci 0000:00:04.0: Adding to iommu group 3
[    0.636951] pci 0000:00:07.0: Adding to iommu group 4
[    0.636959] pci 0000:00:08.0: Adding to iommu group 5
[    0.636968] pci 0000:00:0a.0: Adding to iommu group 6
[    0.636982] pci 0000:00:0b.0: Adding to iommu group 7
[    0.636996] pci 0000:00:0d.0: Adding to iommu group 8
[    0.637004] pci 0000:00:0d.2: Adding to iommu group 8
[    0.637013] pci 0000:00:0e.0: Adding to iommu group 9
[    0.637029] pci 0000:00:14.0: Adding to iommu group 10
[    0.637042] pci 0000:00:14.2: Adding to iommu group 10
[    0.637053] pci 0000:00:15.0: Adding to iommu group 11
[    0.637065] pci 0000:00:16.0: Adding to iommu group 12
[    0.637078] pci 0000:00:1c.0: Adding to iommu group 13
[    0.637088] pci 0000:00:1c.2: Adding to iommu group 14
[    0.637098] pci 0000:00:1c.4: Adding to iommu group 15
[    0.637118] pci 0000:00:1f.0: Adding to iommu group 16
[    0.637127] pci 0000:00:1f.3: Adding to iommu group 16
[    0.637137] pci 0000:00:1f.4: Adding to iommu group 16
[    0.637146] pci 0000:00:1f.5: Adding to iommu group 16
[    0.637180] pci 0000:01:00.0: Adding to iommu group 17
[    0.637191] pci 0000:01:00.1: Adding to iommu group 17
[    0.637204] pci 0000:2c:00.0: Adding to iommu group 18
[    0.637215] pci 0000:2d:00.0: Adding to iommu group 19
[    0.637226] pci 0000:2e:00.0: Adding to iommu group 20
[    0.639585] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.639589] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.639591] software IO TLB: mapped [mem
0x0000000053649000-0x0000000057649000] (64MB)
[    0.639953] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x2c47f5688fc, max_idle_ns: 440795305069 ns
[    0.639985] clocksource: Switched to clocksource tsc
[    0.640015] platform rtc_cmos: registered platform RTC device (no
PNP device found)
[    0.649959] Initialise system trusted keyrings
[    0.649972] Key type blacklist registered
[    0.650017] workingset: timestamp_bits=3D36 max_order=3D23 bucket_order=
=3D0
[    0.650029] zbud: loaded
[    0.650264] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.650338] fuse: init (API version 7.42)
[    0.650455] integrity: Platform Keyring initialized
[    0.650459] integrity: Machine keyring initialized
[    0.658327] Key type asymmetric registered
[    0.658328] Asymmetric key parser 'x509' registered
[    0.658351] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 243)
[    0.658390] io scheduler mq-deadline registered
[    0.659350] ledtrig-cpu: registered to indicate activity on CPUs
[    0.659707] pcieport 0000:00:01.0: PME: Signaling with IRQ 122
[    0.659936] pcieport 0000:00:07.0: PME: Signaling with IRQ 123
[    0.659961] pcieport 0000:00:07.0: pciehp: Slot #12 AttnBtn-
PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+
IbPresDis- LLActRep+
[    0.660219] pcieport 0000:00:1c.0: PME: Signaling with IRQ 124
[    0.660407] pcieport 0000:00:1c.2: PME: Signaling with IRQ 125
[    0.660585] pcieport 0000:00:1c.4: PME: Signaling with IRQ 126
[    0.660674] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.661400] ACPI: AC: AC Adapter [ADP1] (on-line)
[    0.661439] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:17/PNP0C09:00/PNP0C0D:00=
/input/input0
[    0.661477] ACPI: button: Lid Switch [LID0]
[    0.661502] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.661515] ACPI: button: Sleep Button [SLPB]
[    0.661533] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
[    0.661591] ACPI: button: Power Button [PWRB]
[    0.672914] thermal LNXTHERM:00: registered as thermal_zone0
[    0.672916] ACPI: thermal: Thermal Zone [THRM] (64 C)
[    0.673156] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.674685] hpet_acpi_add: no address or irqs in _CRS
[    0.674722] Linux agpgart interface v0.103
[    0.682463] loop: module loaded
[    0.682939] ACPI: bus type drm_connector registered
[    0.683435] tun: Universal TUN/TAP device driver, 1.6
[    0.683462] PPP generic driver version 2.4.2
[    0.683589] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    0.683596] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned
bus number 1
[    0.684751] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci
version 0x120 quirks 0x0000000200009810
[    0.685025] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    0.685028] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned
bus number 2
[    0.685030] xhci_hcd 0000:00:0d.0: Host supports USB 3.2 Enhanced SuperS=
peed
[    0.685080] usb usb1: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 6.14
[    0.685082] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.685083] usb usb1: Product: xHCI Host Controller
[    0.685084] usb usb1: Manufacturer: Linux 6.14.0-32-generic xhci-hcd
[    0.685085] usb usb1: SerialNumber: 0000:00:0d.0
[    0.685174] hub 1-0:1.0: USB hub found
[    0.685201] hub 1-0:1.0: 1 port detected
[    0.685432] usb usb2: New USB device found, idVendor=3D1d6b,
idProduct=3D0003, bcdDevice=3D 6.14
[    0.685434] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.685435] usb usb2: Product: xHCI Host Controller
[    0.685436] usb usb2: Manufacturer: Linux 6.14.0-32-generic xhci-hcd
[    0.685436] usb usb2: SerialNumber: 0000:00:0d.0
[    0.685490] hub 2-0:1.0: USB hub found
[    0.685500] hub 2-0:1.0: 4 ports detected
[    0.687493] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.687498] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 3
[    0.688620] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci
version 0x120 quirks 0x0000000200009810
[    0.688867] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.688869] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 4
[    0.688870] xhci_hcd 0000:00:14.0: Host supports USB 3.2 Enhanced SuperS=
peed
[    0.688897] usb usb3: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 6.14
[    0.688898] usb usb3: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.688899] usb usb3: Product: xHCI Host Controller
[    0.688900] usb usb3: Manufacturer: Linux 6.14.0-32-generic xhci-hcd
[    0.688901] usb usb3: SerialNumber: 0000:00:14.0
[    0.688975] hub 3-0:1.0: USB hub found
[    0.688988] hub 3-0:1.0: 12 ports detected
[    0.690701] usb usb4: New USB device found, idVendor=3D1d6b,
idProduct=3D0003, bcdDevice=3D 6.14
[    0.690703] usb usb4: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.690704] usb usb4: Product: xHCI Host Controller
[    0.690705] usb usb4: Manufacturer: Linux 6.14.0-32-generic xhci-hcd
[    0.690706] usb usb4: SerialNumber: 0000:00:14.0
[    0.690771] hub 4-0:1.0: USB hub found
[    0.690779] hub 4-0:1.0: 2 ports detected
[    0.691138] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]
at 0x60,0x64 irq 1,12
[    0.693985] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.693994] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.694099] mousedev: PS/2 mouse device common for all mice
[    0.694229] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.694882] rtc_cmos rtc_cmos: registered as rtc0
[    0.695012] rtc_cmos rtc_cmos: setting system clock to
2025-09-28T15:18:38 UTC (1759072718)
[    0.695044] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram
[    0.695049] i2c_dev: i2c /dev entries driver
[    0.697202] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is
disabled. Duplicate IMA measurements will not be recorded in the IMA
log.
[    0.697219] device-mapper: uevent: version 1.0.3
[    0.697286] device-mapper: ioctl: 4.49.0-ioctl (2025-01-17)
initialised: dm-devel@lists.linux.dev
[    0.697290] intel_pstate: Intel P-state driver initializing
[    0.699967] Hybrid CPU capacity scaling enabled
[    0.700113] intel_pstate: HWP enabled
[    0.700278] simple-framebuffer simple-framebuffer.0: [drm]
Registered 1 planes with drm panic
[    0.700280] [drm] Initialized simpledrm 1.0.0 for
simple-framebuffer.0 on minor 0
[    0.701200] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input3
[    0.702928] fbcon: Deferring console take-over
[    0.702929] simple-framebuffer simple-framebuffer.0: [drm] fb0:
simpledrmdrmfb frame buffer device
[    0.703027] drop_monitor: Initializing network drop monitor service
[    0.703114] NET: Registered PF_INET6 protocol family
[    0.731878] Freeing initrd memory: 79412K
[    0.738225] Segment Routing with IPv6
[    0.738238] In-situ OAM (IOAM) with IPv6
[    0.738273] NET: Registered PF_PACKET protocol family
[    0.738405] Key type dns_resolver registered
[    0.741151] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.742412] microcode: Current revision: 0x00000024
[    0.742415] microcode: Updated early from: 0x0000001c
[    0.743849] IPI shorthand broadcast: enabled
[    0.745488] sched_clock: Marking stable (739001548,
6030986)->(768759645, -23727111)
[    0.746157] registered taskstats version 1
[    0.748918] Loading compiled-in X.509 certificates
[    0.749353] Loaded X.509 cert 'Build time autogenerated kernel key:
e068e01b81b1bfef8990f6ae8592b26d1458b381'
[    0.749683] Loaded X.509 cert 'Canonical Ltd. Live Patch Signing
2025 Kmod: d541cef61dc7e793b7eb7e899970a2eef0b5dc8c'
[    0.750007] Loaded X.509 cert 'Canonical Ltd. Live Patch Signing:
14df34d1a87cf37625abec039ef2bf521249b969'
[    0.750299] Loaded X.509 cert 'Canonical Ltd. Kernel Module
Signing: 88f752e560a1e0737e31163a466ad7b70a850c19'
[    0.750300] blacklist: Loading compiled-in revocation X.509 certificates
[    0.750311] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing:
61482aa2830d0ab2ad5af10b7250da9033ddcef0'
[    0.750318] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing
(2017): 242ade75ac4a15e50d50c84b0d45ff3eae707a03'
[    0.750325] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing
(ESM 2018): 365188c1d374d6b07c3c8f240f8ef722433d6a8b'
[    0.750331] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing
(2019): c0746fd6c5da3ae827864651ad66ae47fe24b3e8'
[    0.750337] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing
(2021 v1): a8d54bbb3825cfb94fa13c9f8a594a195c107b8d'
[    0.750343] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing
(2021 v2): 4cf046892d6fd3c9a5b03f98d845f90851dc6a8c'
[    0.750348] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing
(2021 v3): 100437bb6de6e469b581e61cd66bce3ef4ed53af'
[    0.750354] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing
(Ubuntu Core 2019): c1d57b8f6b743f23ee41f4f7ee292f06eecadfb9'
[    0.752018] Demotion targets for Node 0: null
[    0.752164] Key type .fscrypt registered
[    0.752165] Key type fscrypt-provisioning registered
[    0.752195] Key type trusted registered
[    0.758454] cryptd: max_cpu_qlen set to 1000
[    0.780217] ACPI: battery: Slot [BAT1] (battery present)
[    0.784431] AES CTR mode by8 optimization enabled
[    0.795900] Key type encrypted registered
[    0.795903] AppArmor: AppArmor sha256 policy hashing enabled
[    0.796121] integrity: Loading X.509 certificate: UEFI:db
[    0.796147] integrity: Loaded X.509 cert 'Microsoft Windows
Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.796149] integrity: Loading X.509 certificate: UEFI:db
[    0.796167] integrity: Loaded X.509 cert 'Microsoft Corporation
UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.796168] integrity: Loading X.509 certificate: UEFI:db
[    0.796184] integrity: Loaded X.509 cert 'Microsoft Corporation:
Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    0.796185] integrity: Loading X.509 certificate: UEFI:db
[    0.796200] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023:
81aa6b3244c935bce0d6628af39827421e32497d'
[    0.797501] integrity: Loading X.509 certificate: UEFI:MokListRT
(MOKvar table)
[    0.797748] integrity: Loaded X.509 cert 'Canonical Ltd. Master
Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    0.797749] integrity: Loading X.509 certificate: UEFI:MokListRT
(MOKvar table)
[    0.797927] integrity: Loaded X.509 cert 'localhost.localdomain
Secure Boot Module Signature key:
1108b3da28d32991ed110eeb901384dcdd361bba'
[    0.797933] Loading compiled-in module X.509 certificates
[    0.798451] Loaded X.509 cert 'Build time autogenerated kernel key:
e068e01b81b1bfef8990f6ae8592b26d1458b381'
[    0.798453] ima: Allocated hash algorithm: sha256
[    0.816055] audit: type=3D1807 audit(1759072718.620:2):
action=3Dmeasure func=3DKEXEC_KERNEL_CHECK res=3D1
[    0.816065] evm: Initialising EVM extended attributes:
[    0.816065] audit: type=3D1807 audit(1759072718.620:3):
action=3Dmeasure func=3DMODULE_CHECK res=3D1
[    0.816066] evm: security.selinux
[    0.816068] evm: security.SMACK64
[    0.816070] evm: security.SMACK64EXEC
[    0.816071] evm: security.SMACK64TRANSMUTE
[    0.816072] evm: security.SMACK64MMAP
[    0.816073] evm: security.apparmor
[    0.816074] evm: security.ima
[    0.816074] evm: security.capability
[    0.816075] evm: HMAC attrs: 0x1
[    0.816406] PM:   Magic number: 9:984:336
[    0.816451] tty tty57: hash matches
[    0.816534] memory memory186: hash matches
[    0.819501] RAS: Correctable Errors collector initialized.
[    0.823182] Lockdown: swapper/0: hibernation is restricted; see man
kernel_lockdown.7
[    0.823205] clk: Disabling unused clocks
[    0.823207] PM: genpd: Disabling unused power domains
[    0.828344] Freeing unused decrypted memory: 2028K
[    0.829319] Freeing unused kernel image (initmem) memory: 5140K
[    0.829331] Write protecting the kernel read-only data: 38912k
[    0.830426] Freeing unused kernel image (text/rodata gap) memory: 1076K
[    0.830788] Freeing unused kernel image (rodata/data gap) memory: 1324K
[    0.837087] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.837092] Run /init as init process
[    0.837093]   with arguments:
[    0.837094]     /init
[    0.837094]     splash
[    0.837095]   with environment:
[    0.837095]     HOME=3D/
[    0.837095]     TERM=3Dlinux
[    0.837096]     BOOT_IMAGE=3D/vmlinuz-6.14.0-32-generic
[    0.932146] usb 3-3: new full-speed USB device number 2 using xhci_hcd
[    0.964284] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WQAK data
block query control method not found
[    0.964293] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WQAL data
block query control method not found
[    0.964303] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WMAJ method
block execution control method not found
[    0.966185] hid: raw HID events driver (C) Jiri Kosina
[    0.967820] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
[    0.967830] pci_bus 10000:e0: root bus resource [bus e0-ff]
[    0.967833] pci_bus 10000:e0: root bus resource [mem 0x86000000-0x86ffff=
ff]
[    0.967836] pci_bus 10000:e0: root bus resource [mem
0x4a32002000-0x4a32ffffff 64bit]
[    0.967869] pci 10000:e0:06.0: [8086:09ab] type 00 class 0x088000
conventional PCI endpoint
[    0.968057] pci 10000:e0:06.0: Adding to iommu group 9
[    0.968137] pci 10000:e0:06.2: [8086:7ecb] type 01 class 0x060400
PCIe Root Port
[    0.968162] pci 10000:e0:06.2: PCI bridge to [bus e1]
[    0.968170] pci 10000:e0:06.2:   bridge window [io  0x0000-0x0fff]
[    0.968174] pci 10000:e0:06.2:   bridge window [mem 0x86000000-0x860ffff=
f]
[    0.968247] pci 10000:e0:06.2: PME# supported from D0 D3hot D3cold
[    0.968294] pci 10000:e0:06.2: PTM enabled (root), 4ns granularity
[    0.968442] pci 10000:e0:06.2: Adding to iommu group 9
[    0.968472] pci 10000:e0:06.2: Primary bus is hard wired to 0
[    0.968544] pci 10000:e1:00.0: [144d:a80a] type 00 class 0x010802
PCIe Endpoint
[    0.968596] pci 10000:e1:00.0: BAR 0 [mem 0x86000000-0x86003fff 64bit]
[    0.968903] pci 10000:e1:00.0: Adding to iommu group 9
[    0.968991] pci 10000:e0:06.2: PCI bridge to [bus e1]
[    0.969002] pci 10000:e0:06.2: Primary bus is hard wired to 0
[    0.974040] rtsx_pci 0000:2e:00.0: enabling device (0000 -> 0002)
[    0.980714] ACPI: bus type thunderbolt registered
[    0.982328] r8169 0000:2d:00.0: can't disable ASPM; OS doesn't have
ASPM control
[    0.986768] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    0.987106] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    0.989628] r8169 0000:2d:00.0 eth0: RTL8125B, d8:43:ae:3c:e3:a2,
XID 641, IRQ 179
[    0.989630] r8169 0000:2d:00.0 eth0: jumbo features [frames: 16362
bytes, tx checksumming: ko]
[    0.990110] r8169 0000:2d:00.0 enp45s0: renamed from eth0
[    1.058062] usb 3-3: New USB device found, idVendor=3D27c6,
idProduct=3D6094, bcdDevice=3D 1.00
[    1.058066] usb 3-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    1.058068] usb 3-3: Product: Goodix USB2.0 MISC
[    1.058069] usb 3-3: Manufacturer: Goodix Technology Co., Ltd.
[    1.058070] usb 3-3: SerialNumber: UIDF01F4ECA_XXXX_MOC_B0
[    1.090543] input: ELAN0304:00 04F3:3208 Mouse as
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-ELAN0304:00/001=
8:04F3:3208.0001/input/input6
[    1.090619] input: ELAN0304:00 04F3:3208 Touchpad as
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-ELAN0304:00/001=
8:04F3:3208.0001/input/input8
[    1.090676] hid-generic 0018:04F3:3208.0001: input,hidraw0: I2C HID
v1.00 Mouse [ELAN0304:00 04F3:3208] on i2c-ELAN0304:00
[    1.153087] input: ELAN0304:00 04F3:3208 Mouse as
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-ELAN0304:00/001=
8:04F3:3208.0001/input/input9
[    1.153280] input: ELAN0304:00 04F3:3208 Touchpad as
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-ELAN0304:00/001=
8:04F3:3208.0001/input/input11
[    1.153439] hid-multitouch 0018:04F3:3208.0001: input,hidraw0: I2C
HID v1.00 Mouse [ELAN0304:00 04F3:3208] on i2c-ELAN0304:00
[    1.154257] pci 10000:e0:06.2: bridge window [mem
0x86000000-0x860fffff]: assigned
[    1.154270] pci 10000:e0:06.2: bridge window [io  size 0x1000]:
can't assign; no space
[    1.154276] pci 10000:e0:06.2: bridge window [io  size 0x1000]:
failed to assign
[    1.154284] pci 10000:e1:00.0: BAR 0 [mem 0x86000000-0x86003fff
64bit]: assigned
[    1.154302] pci 10000:e0:06.2: PCI bridge to [bus e1]
[    1.154310] pci 10000:e0:06.2:   bridge window [mem 0x86000000-0x860ffff=
f]
[    1.154337] pci 10000:e1:00.0: BIOS can't program ASPM, let OS control i=
t
[    1.154457] pcieport 10000:e0:06.2: can't derive routing for PCI INT C
[    1.154462] pcieport 10000:e0:06.2: PCI INT C: no GSI
[    1.154685] pcieport 10000:e0:06.2: PME: Signaling with IRQ 181
[    1.154976] vmd 0000:00:0e.0: Bound to PCI domain 10000
[    1.173058] usb 3-4: new full-speed USB device number 3 using xhci_hcd
[    1.189552] nvme nvme0: pci function 10000:e1:00.0
[    1.189587] pcieport 10000:e0:06.2: can't derive routing for PCI INT A
[    1.189589] nvme 10000:e1:00.0: PCI INT A: not connected
[    1.191641] nvme nvme0: D3 entry latency set to 10 seconds
[    1.195406] nvme nvme0: 16/0/0 default/read/poll queues
[    1.198484]  nvme0n1: p1 p2 p3
[    1.295225] psmouse serio1: elantech: assuming hardware version 4
(with firmware version 0x4f5001)
[    1.298323] usb 3-4: New USB device found, idVendor=3D1038,
idProduct=3D1122, bcdDevice=3D 2.51
[    1.298335] usb 3-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.298340] usb 3-4: Product: SteelSeries KLC
[    1.298343] usb 3-4: Manufacturer: SteelSeries
[    1.306408] psmouse serio1: elantech: Synaptics capabilities query
result 0x00, 0x20, 0x14.
[    1.316984] psmouse serio1: elantech: Elan sample query result 00, 25, 8=
5
[    1.327803] psmouse serio1: elantech: Elan ic body: 0x11, current
fw version: 0x3
[    1.390116] input: ETPS/2 Elantech Touchpad as
/devices/platform/i8042/serio1/input/input5
[    1.412135] usb 3-5: new low-speed USB device number 4 using xhci_hcd
[    1.540792] usb 3-5: New USB device found, idVendor=3D093a,
idProduct=3D2521, bcdDevice=3D 1.00
[    1.540807] usb 3-5: New USB device strings: Mfr=3D0, Product=3D2, Seria=
lNumber=3D0
[    1.540811] usb 3-5: Product: USB OPTICAL MOUSE
[    1.656338] usb 3-9: new high-speed USB device number 5 using xhci_hcd
[    1.786585] usb 3-9: New USB device found, idVendor=3D5986,
idProduct=3D1193, bcdDevice=3D 3.13
[    1.786600] usb 3-9: New USB device strings: Mfr=3D3, Product=3D1, Seria=
lNumber=3D2
[    1.786605] usb 3-9: Product: FHD Camera
[    1.786609] usb 3-9: Manufacturer: Bison
[    1.786612] usb 3-9: SerialNumber: 0001
[    1.902352] usb 3-10: new full-speed USB device number 6 using xhci_hcd
[    2.027262] usb 3-10: New USB device found, idVendor=3D8087,
idProduct=3D0036, bcdDevice=3D 0.00
[    2.027277] usb 3-10: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D0
[    2.056830] hid-generic 0003:1038:1122.0002: hiddev0,hidraw1: USB
HID v1.11 Device [SteelSeries SteelSeries KLC] on
usb-0000:00:14.0-4/input0
[    2.057477] input: SteelSeries SteelSeries KLC as
/devices/pci0000:00/0000:00:14.0/usb3/3-4/3-4:1.1/0003:1038:1122.0003/input=
/input12
[    2.108871] hid-generic 0003:1038:1122.0003: input,hidraw2: USB HID
v1.11 Device [SteelSeries SteelSeries KLC] on
usb-0000:00:14.0-4/input1
[    2.111622] input: USB OPTICAL MOUSE as
/devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5:1.0/0003:093A:2521.0004/input=
/input13
[    2.112143] hid-generic 0003:093A:2521.0004: input,hidraw3: USB HID
v1.11 Mouse [USB OPTICAL MOUSE] on usb-0000:00:14.0-5/input0
[    2.112209] usbcore: registered new interface driver usbhid
[    2.112211] usbhid: USB HID core driver
[    2.242033] raid6: avx2x4   gen() 22625 MB/s
[    2.259033] raid6: avx2x2   gen() 26531 MB/s
[    2.276033] raid6: avx2x1   gen() 22848 MB/s
[    2.276034] raid6: using algorithm avx2x2 gen() 26531 MB/s
[    2.293033] raid6: .... xor() 16496 MB/s, rmw enabled
[    2.293034] raid6: using avx2x2 recovery algorithm
[    2.315847] xor: automatically using best checksumming function   avx
[    2.319540] async_tx: api initialized (async)
[   19.675793] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[   19.716574] Lockdown: resume: hibernation is restricted; see man
kernel_lockdown.7
[   19.752107] EXT4-fs (dm-1): mounted filesystem
51aa2dfe-8528-4ed9-b183-d5a6f0d9ec5e ro with ordered data mode. Quota
mode: none.
[   19.872867] systemd[1]: Inserted module 'autofs4'
[   19.892853] systemd[1]: systemd 255.4-1ubuntu8.10 running in system
mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT
-GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC
+KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE
+TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP
+SYSVINIT default-hierarchy=3Dunified)
[   19.892866] systemd[1]: Detected architecture x86-64.
[   19.893596] systemd[1]: Hostname set to <linux-Stealth-16-AI-Studio-A1VG=
G>.
[   20.032560] systemd[1]: /etc/systemd/system/teamviewerd.service:9:
PIDFile=3D references a path below legacy directory /var/run/, updating
/var/run/teamviewerd.pid =E2=86=92 /run/teamviewerd.pid; please update the
unit file accordingly.
[   20.051480] systemd[1]: /etc/systemd/system/anydesk.service:9:
PIDFile=3D references a path below legacy directory /var/run/, updating
/var/run/anydesk.pid =E2=86=92 /run/anydesk.pid; please update the unit fil=
e
accordingly.
[   20.096124] systemd[1]: Queued start job for default target graphical.ta=
rget.
[   20.123829] systemd[1]: Created slice system-modprobe.slice - Slice
/system/modprobe.
[   20.124283] systemd[1]: Created slice
system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service
Slice.
[   20.124599] systemd[1]: Created slice system-systemd\x2dfsck.slice
- Slice /system/systemd-fsck.
[   20.124900] systemd[1]: Created slice system-tor.slice - Slice /system/t=
or.
[   20.125148] systemd[1]: Created slice user.slice - User and Session Slic=
e.
[   20.125203] systemd[1]: Started systemd-ask-password-wall.path -
Forward Password Requests to Wall Directory Watch.
[   20.125387] systemd[1]: Set up automount
proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats
File System Automount Point.
[   20.125407] systemd[1]: Expecting device
dev-disk-by\x2duuid-11b77119\x2dfc98\x2d4d46\x2d864f\x2d1f6c2fa63330.device
- /dev/disk/by-uuid/11b77119-fc98-4d46-864f-1f6c2fa63330...
[   20.125417] systemd[1]: Expecting device
dev-disk-by\x2duuid-2e2f74f9\x2d8aca\x2d4379\x2daf24\x2de5f56abd555a.device
- /dev/disk/by-uuid/2e2f74f9-8aca-4379-af24-e5f56abd555a...
[   20.125424] systemd[1]: Expecting device
dev-disk-by\x2duuid-A739\x2d422D.device -
/dev/disk/by-uuid/A739-422D...
[   20.125431] systemd[1]: Expecting device
dev-mapper-vgmint\x2dswap_1.device - /dev/mapper/vgmint-swap_1...
[   20.125450] systemd[1]: Reached target integritysetup.target -
Local Integrity Protected Volumes.
[   20.125473] systemd[1]: Reached target nss-user-lookup.target -
User and Group Name Lookups.
[   20.125487] systemd[1]: Reached target remote-fs.target - Remote
File Systems.
[   20.125497] systemd[1]: Reached target slices.target - Slice Units.
[   20.125523] systemd[1]: Reached target veritysetup.target - Local
Verity Protected Volumes.
[   20.125601] systemd[1]: Listening on dm-event.socket -
Device-mapper event daemon FIFOs.
[   20.125681] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2
poll daemon socket.
[   20.126205] systemd[1]: Listening on syslog.socket - Syslog Socket.
[   20.127169] systemd[1]: Listening on systemd-coredump.socket -
Process Core Dump Socket.
[   20.127241] systemd[1]: Listening on systemd-fsckd.socket - fsck to
fsckd communication Socket.
[   20.127294] systemd[1]: Listening on systemd-initctl.socket -
initctl Compatibility Named Pipe.
[   20.127369] systemd[1]: Listening on
systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[   20.127452] systemd[1]: Listening on systemd-journald.socket -
Journal Socket.
[   20.127493] systemd[1]: systemd-pcrextend.socket - TPM2 PCR
Extension (Varlink) was skipped because of an unmet condition check
(ConditionSecurity=3Dmeasured-uki).
[   20.127594] systemd[1]: Listening on systemd-udevd-control.socket -
udev Control Socket.
[   20.127664] systemd[1]: Listening on systemd-udevd-kernel.socket -
udev Kernel Socket.
[   20.128658] systemd[1]: Mounting dev-hugepages.mount - Huge Pages
File System...
[   20.129285] systemd[1]: Mounting dev-mqueue.mount - POSIX Message
Queue File System...
[   20.129911] systemd[1]: Mounting sys-kernel-debug.mount - Kernel
Debug File System...
[   20.130573] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel
Trace File System...
[   20.132095] systemd[1]: Starting systemd-journald.service - Journal
Service...
[   20.132174] systemd[1]: Finished blk-availability.service -
Availability of block devices.
[   20.133026] systemd[1]: Starting keyboard-setup.service - Set the
console keyboard layout...
[   20.133730] systemd[1]: Starting kmod-static-nodes.service - Create
List of Static Device Nodes...
[   20.134398] systemd[1]: Starting lvm2-monitor.service - Monitoring
of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[   20.135008] systemd[1]: Starting modprobe@configfs.service - Load
Kernel Module configfs...
[   20.135586] systemd[1]: Starting modprobe@dm_mod.service - Load
Kernel Module dm_mod...
[   20.136167] systemd[1]: Starting modprobe@drm.service - Load Kernel
Module drm...
[   20.136844] systemd[1]: Starting modprobe@efi_pstore.service - Load
Kernel Module efi_pstore...
[   20.137500] systemd[1]: Starting modprobe@fuse.service - Load
Kernel Module fuse...
[   20.138076] systemd[1]: Starting modprobe@loop.service - Load
Kernel Module loop...
[   20.138171] systemd[1]: systemd-fsck-root.service - File System
Check on Root Device was skipped because of an unmet condition check
(ConditionPathExists=3D!/run/initramfs/fsck-root).
[   20.139136] systemd[1]: Starting systemd-modules-load.service -
Load Kernel Modules...
[   20.139151] systemd[1]: systemd-pcrmachine.service - TPM2 PCR
Machine ID Measurement was skipped because of an unmet condition check
(ConditionSecurity=3Dmeasured-uki).
[   20.139856] systemd[1]: Starting systemd-remount-fs.service -
Remount Root and Kernel File Systems...
[   20.139895] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK
Setup (Early) was skipped because of an unmet condition check
(ConditionSecurity=3Dmeasured-uki).
[   20.140585] systemd[1]: Starting systemd-udev-trigger.service -
Coldplug All udev Devices...
[   20.141748] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File Sy=
stem.
[   20.141834] systemd[1]: Mounted dev-mqueue.mount - POSIX Message
Queue File System.
[   20.141905] systemd[1]: Mounted sys-kernel-debug.mount - Kernel
Debug File System.
[   20.141978] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel
Trace File System.
[   20.142171] systemd[1]: Finished kmod-static-nodes.service - Create
List of Static Device Nodes.
[   20.142379] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[   20.142494] systemd[1]: Finished modprobe@configfs.service - Load
Kernel Module configfs.
[   20.142672] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[   20.142766] systemd[1]: Finished modprobe@dm_mod.service - Load
Kernel Module dm_mod.
[   20.142930] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   20.143019] systemd[1]: Finished modprobe@drm.service - Load Kernel
Module drm.
[   20.143193] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   20.143291] systemd[1]: Finished modprobe@fuse.service - Load
Kernel Module fuse.
[   20.143468] systemd[1]: modprobe@loop.service: Deactivated successfully.
[   20.143557] systemd[1]: Finished modprobe@loop.service - Load
Kernel Module loop.
[   20.143692] pstore: Using crash dump compression: deflate
[   20.144404] systemd[1]: Mounting sys-fs-fuse-connections.mount -
FUSE Control File System...
[   20.145134] systemd[1]: Mounting sys-kernel-config.mount - Kernel
Configuration File System...
[   20.145181] systemd[1]: systemd-repart.service - Repartition Root
Disk was skipped because no trigger condition checks were met.
[   20.145468] systemd-journald[597]: Collecting audit messages is disabled=
.
[   20.145982] systemd[1]: Starting
systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes
in /dev gracefully...
[   20.148786] systemd[1]: Mounted sys-fs-fuse-connections.mount -
FUSE Control File System.
[   20.149469] systemd[1]: Mounted sys-kernel-config.mount - Kernel
Configuration File System.
[   20.151470] pstore: Registered efi_pstore as persistent store backend
[   20.151827] systemd[1]: modprobe@efi_pstore.service: Deactivated
successfully.
[   20.151940] systemd[1]: Finished modprobe@efi_pstore.service - Load
Kernel Module efi_pstore.
[   20.154507] lp: driver loaded but no devices found
[   20.158814] ppdev: user-space parallel port driver
[   20.159276] systemd[1]: Finished
systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes
in /dev gracefully.
[   20.162796] systemd[1]: Finished keyboard-setup.service - Set the
console keyboard layout.
[   20.171039] EXT4-fs (dm-1): re-mounted
51aa2dfe-8528-4ed9-b183-d5a6f0d9ec5e r/w.
[   20.171856] systemd[1]: Finished systemd-remount-fs.service -
Remount Root and Kernel File Systems.
[   20.172309] systemd[1]: systemd-hwdb-update.service - Rebuild
Hardware Database was skipped because of an unmet condition check
(ConditionNeedsUpdate=3D/etc).
[   20.172347] systemd[1]: systemd-pstore.service - Platform
Persistent Storage Archival was skipped because of an unmet condition
check (ConditionDirectoryNotEmpty=3D/sys/fs/pstore).
[   20.193317] systemd[1]: Starting systemd-random-seed.service -
Load/Save OS Random Seed...
[   20.193369] systemd[1]: systemd-sysusers.service - Create System
Users was skipped because no trigger condition checks were met.
[   20.194385] systemd[1]: Starting systemd-tmpfiles-setup-dev.service
- Create Static Device Nodes in /dev...
[   20.194412] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup
was skipped because of an unmet condition check
(ConditionSecurity=3Dmeasured-uki).
[   20.194533] systemd[1]: Started systemd-journald.service - Journal Servi=
ce.
[   20.206160] systemd-journald[597]: Received client request to flush
runtime journal.
[   20.222373] systemd-journald[597]:
/var/log/journal/7f76320c963b48a8b6c1cb34741f02f9/system.journal:
Journal file uses a different sequence number ID, rotating.
[   20.222378] systemd-journald[597]: Rotating system journal.
[   20.319048] intel_vsec 0000:00:0a.0: enabling device (0000 -> 0002)
[   20.321280] input: Intel HID events as
/devices/platform/INTC1070:00/input/input14
[   20.322144] intel-hid INTC1070:00: platform supports 5 button array
[   20.324346] input: Intel HID 5 button array as
/devices/platform/INTC1070:00/input/input15
[   20.325991] input: gpio-keys as
/devices/platform/ACPI0011:00/gpio-keys.1.auto/input/input16
[   20.333045] resource: resource sanity check: requesting [mem
0x00000000fedc0000-0x00000000fedcffff], which spans more than pnp
00:04 [mem 0xfedc0000-0xfedc7fff]
[   20.333053] caller igen6_register_mci+0x5b/0x280 [igen6_edac]
mapping multiple BARs
[   20.336435] EDAC MC0: Giving out device to module igen6_edac
controller Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
[   20.337313] intel_vpu 0000:00:0b.0: enabling device (0000 -> 0002)
[   20.338385] EDAC MC1: Giving out device to module igen6_edac
controller Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
[   20.339067] EDAC igen6: v2.5.1
[   20.344514] intel_vpu 0000:00:0b.0: [drm] Firmware:
intel/vpu/vpu_37xx_v0.0.bin, version:
20230726*MTL_CLIENT_SILICON-release*2101*ci_tag_mtl_pv_vpu_rc_20230726_2101=
*648a666b8b9
[   20.344528] intel_vpu 0000:00:0b.0: [drm] Scheduler mode: OS
[   20.362113] Adding 88793084k swap on /dev/mapper/vgmint-swap_1.
Priority:-2 extents:1 across:88793084k SS
[   20.363735] mc: Linux media interface: v0.10
[   20.366144] input: MSI WMI hotkeys as /devices/virtual/input/input17
[   20.366947] pci 0000:00:08.0: Setting to D3hot
[   20.378076] pci 0000:00:14.2: enabling device (0000 -> 0002)
[   20.379166] intel_pmc_core INT33A1:00: Assuming a default substate
order for this platform
[   20.379288] intel_pmc_core INT33A1:00:  initialized
[   20.385808] Bluetooth: Core ver 2.22
[   20.391582] EXT4-fs (nvme0n1p2): mounted filesystem
11b77119-fc98-4d46-864f-1f6c2fa63330 r/w with ordered data mode. Quota
mode: none.
[   20.413709] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters,
655360 ms ovfl timer
[   20.413714] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   20.413716] RAPL PMU: hw unit of domain package 2^-14 Joules
[   20.413716] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   20.414415] videodev: Linux video capture interface: v2.00
[   20.415014] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[   20.415123] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   20.415208] Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   20.420112] NET: Registered PF_BLUETOOTH protocol family
[   20.420115] Bluetooth: HCI device and connection manager initialized
[   20.420120] Bluetooth: HCI socket layer initialized
[   20.420122] Bluetooth: L2CAP socket layer initialized
[   20.420128] Bluetooth: SCO socket layer initialized
[   20.423801] msi_ec: Firmware version is not supported: '15F4EMS1.106'
[   20.429066] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   20.429112] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   20.430516] i2c i2c-1: Successfully instantiated SPD at 0x50
[   20.438518] nvidia: loading out-of-tree module taints kernel.
[   20.443446] Intel(R) Wireless WiFi driver for Linux
[   20.443675] iwlwifi 0000:2c:00.0: enabling device (0000 -> 0002)
[   20.452484] iwlwifi 0000:2c:00.0: Detected crf-id 0x2001910, cnv-id
0x2001910 wfpm id 0x80000000
[   20.452498] iwlwifi 0000:2c:00.0: PCI dev 272b/1774, rev=3D0x472, rfid=
=3D0x112200
[   20.452499] iwlwifi 0000:2c:00.0: Detected Intel(R) Wi-Fi 7 BE202 160MHz
[   20.456022] iwlwifi 0000:2c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
Version: 0.0.4.196
[   20.456409] iwlwifi 0000:2c:00.0: loaded firmware version
96.44729d4e.0 gl-c0-fm-c0-96.ucode op_mode iwlmvm
[   20.463499] [drm] Initialized intel_vpu 1.0.0 for 0000:00:0b.0 on minor =
0
[   20.474628] nvidia-nvlink: Nvlink Core is being initialized, major
device number 509

[   20.476104] intel_rapl_msr: PL4 support detected.
[   20.476150] intel_rapl_common: Found RAPL domain package
[   20.476154] intel_rapl_common: Found RAPL domain core
[   20.476157] intel_rapl_common: Found RAPL domain psys
[   20.477213] nvidia 0000:01:00.0: enabling device (0000 -> 0003)
[   20.477357] nvidia 0000:01:00.0: vgaarb: VGA decodes changed:
olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dnone
[   20.514638] spi-nor spi0.0: supply vcc not found, using dummy regulator
[   20.518422] spd5118 1-0050: DDR5 temperature sensor: vendor
0x06:0x32 revision 1.6
[   20.525789] Creating 1 MTD partitions on "0000:00:1f.5":
[   20.525795] 0x000000000000-0x000002000000 : "BIOS"
[   20.526103] NVRM: loading NVIDIA UNIX Open Kernel Module for x86_64
 575.57.08  Release Build  (dvs-builder@U22-I3-H04-01-5)  Sat May 24
07:03:13 UTC 2025
[   20.594626] usb 3-9: Found UVC 1.10 device FHD Camera (5986:1193)
[   20.599714] usb 3-9: Found UVC 1.50 device FHD Camera (5986:1193)
[   20.601562] usbcore: registered new interface driver uvcvideo
[   20.842169] proc_thermal_pci 0000:00:04.0: enabling device (0000 -> 0002=
)
[   20.842542] intel_rapl_common: Found RAPL domain package
[   20.842833] usbcore: registered new interface driver btusb
[   20.843561] i915 0000:00:02.0: [drm] Found meteorlake (device ID
7d55) integrated display version 14.00 stepping C0
[   20.844898] i915 0000:00:02.0: [drm] VT-d active for gfx access
[   20.845060] Bluetooth: hci0: Firmware timestamp 2025.7 buildtype 1
build 76693
[   20.845072] Bluetooth: hci0: Firmware SHA1: 0x9919f053
[   20.845226] nvidia-modeset: Loading NVIDIA UNIX Open Kernel Mode
Setting Driver for x86_64  575.57.08  Release Build
(dvs-builder@U22-I3-H04-01-5)  Sat May 24 06:53:21 UTC 2025
[   20.849547] Bluetooth: hci0: DSM reset method type: 0x01
[   20.850271] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[   20.856531] Bluetooth: hci0: Found device firmware: intel/ibt-0291-0291.=
sfi
[   20.856546] Bluetooth: hci0: Boot Address: 0x100800
[   20.856547] Bluetooth: hci0: Firmware Version: 149-7.25
[   20.856548] Bluetooth: hci0: Firmware already loaded
[   20.860025] Bluetooth: hci0: Fseq status: Success (0x00)
[   20.860037] Bluetooth: hci0: Fseq executed: 00.00.04.195
[   20.860041] Bluetooth: hci0: Fseq BT Top: 00.00.04.195
[   20.871529] i915 0000:00:02.0: vgaarb: deactivate vga console
[   20.871557] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[   20.879531] snd_hda_intel 0000:00:1f.3: Digital mics found on
Skylake+ platform, using SOF driver
[   20.879609] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[   20.879781] snd_hda_intel 0000:01:00.1: Disabling MSI
[   20.879785] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio clie=
nt
[   20.885127] i915 0000:00:02.0: vgaarb: VGA decodes changed:
olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
[   20.893381] i915 0000:00:02.0: [drm] Finished loading DMC firmware
i915/mtl_dmc.bin (v2.21)
[   20.904215] input: HDA NVidia HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card0/input18
[   20.904265] input: HDA NVidia HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card0/input19
[   20.904318] input: HDA NVidia HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card0/input20
[   20.904371] input: HDA NVidia HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card0/input21
[   20.923816] i915 0000:00:02.0: [drm] GT0: GuC firmware
i915/mtl_guc_70.bin version 70.36.0
[   20.933675] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[   20.933678] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[   20.933883] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[   20.939560] mei_gsc_proxy
0000:00:16.0-0f73db04-97ab-4125-b893-e904ad0d5464: bound 0000:00:02.0
(ops i915_gsc_proxy_component_ops [i915])
[   20.939923] i915 0000:00:02.0: [drm] GT1: GuC firmware
i915/mtl_guc_70.bin version 70.36.0
[   20.939924] i915 0000:00:02.0: [drm] GT1: HuC firmware
i915/mtl_huc_gsc.bin version 8.5.4
[   20.958015] Bluetooth: hci0: Failed to read codec capabilities (-95)
[   20.962001] Bluetooth: hci0: Failed to read codec capabilities (-95)
[   20.975550] NVRM: testIfDsmSubFunctionEnabled: GPS ACPI DSM called
before _acpiDsmSupportedFuncCacheInit subfunction =3D 11.
[   20.984235] sof-audio-pci-intel-mtl 0000:00:1f.3: enabling device
(0000 -> 0002)
[   20.984438] sof-audio-pci-intel-mtl 0000:00:1f.3: DSP detected with
PCI class/subclass/prog-if 0x040100
[   21.018688] i915 0000:00:02.0: [drm] GT1: HuC: authenticated for clear m=
edia
[   21.019650] i915 0000:00:02.0: [drm] GT1: GUC: submission enabled
[   21.019653] i915 0000:00:02.0: [drm] GT1: GUC: SLPC enabled
[   21.019774] i915 0000:00:02.0: [drm] GT1: GUC: RC enabled
[   21.023161] i915 0000:00:02.0: [drm] Protected Xe Path (PXP)
protected content support initialized
[   21.140577] iwlwifi 0000:2c:00.0: Detected RF FM, rfid=3D0x112200
[   21.150268] iwlwifi 0000:2c:00.0: loaded PNVM version 97f4ce1a
[   21.161821] i915 0000:00:02.0: [drm] GT1: Loaded GSC firmware
i915/mtl_gsc_1.bin (cv1.0, r102.1.15.1926, svn 1)
[   21.182026] i915 0000:00:02.0: [drm] GT1: HuC: authenticated for
all workloads
[   21.262938] iwlwifi 0000:2c:00.0: base HW address: a0:02:a5:6b:d6:5e
[   21.356590] iwlwifi 0000:2c:00.0 wlp44s0f0: renamed from wlan0
[   22.061464] i915 0000:00:02.0: [drm] PHY A failed to request refclk
after 1us.
[   22.328898] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 1
[   22.329330] ACPI: video: Video Device [PXSX] (multi-head: no  rom:
yes  post: no)
[   22.329376] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:16/LNXVIDEO:00/input/inp=
ut22
[   22.331474] ACPI: video: Video Device [GFX0] (multi-head: yes  rom:
no  post: no)
[   22.331690] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input23
[   22.335016] fbcon: i915drmfb (fb0) is primary device
[   22.335019] fbcon: Deferring console take-over
[   22.335021] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[   22.334934] sof-audio-pci-intel-mtl 0000:00:1f.3: bound
0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[   22.341975] sof-audio-pci-intel-mtl 0000:00:1f.3: use msi interrupt mode
[   22.392079] sof-audio-pci-intel-mtl 0000:00:1f.3: hda codecs found, mask=
 5
[   22.392085] sof-audio-pci-intel-mtl 0000:00:1f.3: using HDA machine
driver skl_hda_dsp_generic now
[   22.392087] sof-audio-pci-intel-mtl 0000:00:1f.3: NHLT device BT(0)
detected, ssp_mask 0x4
[   22.392089] sof-audio-pci-intel-mtl 0000:00:1f.3: BT link detected
in NHLT tables: 0x4
[   22.392091] sof-audio-pci-intel-mtl 0000:00:1f.3: DMICs detected in
NHLT tables: 2
[   22.397384] sof-audio-pci-intel-mtl 0000:00:1f.3: Firmware
paths/files for ipc type 1:
[   22.397389] sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware file:
  intel/sof-ipc4/mtl/sof-mtl.ri
[   22.397390] sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware lib
path: intel/sof-ipc4-lib/mtl
[   22.397391] sof-audio-pci-intel-mtl 0000:00:1f.3:  Topology file:
  intel/sof-ace-tplg/sof-hda-generic-2ch.tplg
[   22.399799] sof-audio-pci-intel-mtl 0000:00:1f.3: Loaded firmware
library: ADSPFW, version: 2.13.0.1
[   22.516586] sof-audio-pci-intel-mtl 0000:00:1f.3: Booted firmware
version: 2.13.0.1
[   22.516867] NVRM: testIfDsmSubFunctionEnabled: GPS ACPI DSM called
before _acpiDsmSupportedFuncCacheInit subfunction =3D 11.
[   22.562340] [drm] Initialized nvidia-drm 0.0.0 for 0000:01:00.0 on minor=
 2
[   22.562810] nvidia 0000:01:00.0: [drm] Cannot find any crtc or sizes
[   22.564885] sof-audio-pci-intel-mtl 0000:00:1f.3: Topology: ABI
3:29:1 Kernel ABI 3:23:1
[   22.565279] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: Parent
card not yet available, widget card binding deferred
[   22.588000] snd_hda_codec_realtek ehdaudio0D0: autoconfig for
ALC274: line_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[   22.588006] snd_hda_codec_realtek ehdaudio0D0:    speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
[   22.588008] snd_hda_codec_realtek ehdaudio0D0:    hp_outs=3D1
(0x21/0x0/0x0/0x0/0x0)
[   22.588010] snd_hda_codec_realtek ehdaudio0D0:    mono: mono_out=3D0x0
[   22.588012] snd_hda_codec_realtek ehdaudio0D0:    inputs:
[   22.588013] snd_hda_codec_realtek ehdaudio0D0:      Mic=3D0x19
[   23.041849] skl_hda_dsp_generic skl_hda_dsp_generic:
hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
[   23.059877] input: sof-hda-dsp Mic as
/devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card1/input24
[   23.059976] input: sof-hda-dsp Headphone as
/devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card1/input25
[   23.060096] input: sof-hda-dsp HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card1/input26
[   23.060172] input: sof-hda-dsp HDMI/DP,pcm=3D4 as
/devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card1/input27
[   23.060243] input: sof-hda-dsp HDMI/DP,pcm=3D5 as
/devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card1/input28
[   23.204151] zfs: module license 'CDDL' taints kernel.
[   23.204158] Disabling lock debugging due to kernel taint
[   23.204194] zfs: module license taints kernel.
[   24.341527] ZFS: Loaded module v2.3.1-1ubuntu2, ZFS pool version
5000, ZFS filesystem version 5
[   24.341529] ZFS: Using ZFS with kernel 6.14.0-32-generic is
EXPERIMENTAL and SERIOUS DATA LOSS may occur!
[   24.341530] ZFS: Please report your results at:
https://github.com/openzfs/zfs/issues/new
[   24.399326] audit: type=3D1400 audit(1759072742.203:4):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"buildah" pid=3D1059 comm=3D"apparmor_parser"
[   24.399359] audit: type=3D1400 audit(1759072742.203:5):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"1password" pid=3D1053 comm=3D"apparmor_parser"
[   24.399388] audit: type=3D1400 audit(1759072742.203:6):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"element-desktop" pid=3D1069 comm=3D"apparmor_parser"
[   24.399419] audit: type=3D1400 audit(1759072742.203:7):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"devhelp" pid=3D1068 comm=3D"apparmor_parser"
[   24.399444] audit: type=3D1400 audit(1759072742.203:8):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D4D6F6E676F444220436F6D70617373 pid=3D1055 comm=3D"apparmor_parser"
[   24.399471] audit: type=3D1400 audit(1759072742.203:9):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"busybox" pid=3D1060 comm=3D"apparmor_parser"
[   24.399496] audit: type=3D1400 audit(1759072742.203:10):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"Discord" pid=3D1054 comm=3D"apparmor_parser"
[   24.399526] audit: type=3D1400 audit(1759072742.203:11):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"cam" pid=3D1062 comm=3D"apparmor_parser"
[   24.399564] audit: type=3D1400 audit(1759072742.203:12):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"crun" pid=3D1067 comm=3D"apparmor_parser"
[   24.399590] audit: type=3D1400 audit(1759072742.203:13):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"chrome" pid=3D1065 comm=3D"apparmor_parser"
[   24.665057] nvme nvme0: using unchecked data buffer
[   24.677949] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   24.677954] Bluetooth: BNEP filters: protocol multicast
[   24.677958] Bluetooth: BNEP socket layer initialized
[   24.679629] Bluetooth: MGMT ver 1.23
[   24.685008] NET: Registered PF_ALG protocol family
[   24.790314] NET: Registered PF_QIPCRTR protocol family
[   24.843003] Bluetooth: hci0: Failed to read codec capabilities (-95)
[   24.847020] Bluetooth: hci0: Failed to read codec capabilities (-95)
[   24.895229] Loading of unsigned module is rejected
[   25.130112] Realtek Internal NBASE-T PHY r8169-0-2d00:00: attached
PHY driver (mii_bus:phy_addr=3Dr8169-0-2d00:00, irq=3DMAC)
[   25.299284] r8169 0000:2d:00.0 enp45s0: Link is Down
[   25.314005] ACPI BIOS Error (bug): Could not resolve symbol
[\_TZ.ETMD], AE_NOT_FOUND (20240827/psargs-332)

[   25.314023] No Local Variables are initialized for Method [_OSC]

[   25.314025] Initialized Arguments for Method [_OSC]:  (4 arguments
defined for method invocation)
[   25.314026]   Arg0:   000000004578cba0 <Obj>           Buffer(16)
5D A8 3B B2 B7 C8 42 35
[   25.314060]   Arg1:   000000007e104d4b <Obj>           Integer
0000000000000001
[   25.314065]   Arg2:   000000005f15f5ac <Obj>           Integer
0000000000000002
[   25.314069]   Arg3:   0000000056f1bfc4 <Obj>           Buffer(8) 00
00 00 00 05 00 00 00

[   25.314081] ACPI Error: Aborting method \_SB.IETM._OSC due to
previous error (AE_NOT_FOUND) (20240827/psparse-529)
[   25.314112] Consider using thermal netlink events interface
[   25.718103] iwlwifi 0000:2c:00.0: Registered PHC clock:
iwlwifi-PTP, with index: 0
[   26.696658] Bluetooth: RFCOMM TTY layer initialized
[   26.696671] Bluetooth: RFCOMM socket layer initialized
[   26.696680] Bluetooth: RFCOMM ver 1.11
[   28.069027] rfkill: input handler disabled
[   28.201993] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   28.666496] usb 3-3: reset full-speed USB device number 2 using xhci_hcd
[   29.869155] wlp44s0f0: authenticate with 84:d8:1b:70:59:82 (local
address=3Da0:02:a5:6b:d6:5e)
[   29.869858] wlp44s0f0: send auth to 84:d8:1b:70:59:82 (try 1/3)
[   29.884943] wlp44s0f0: authenticated
[   29.886115] wlp44s0f0: associate with 84:d8:1b:70:59:82 (try 1/3)
[   29.905829] wlp44s0f0: RX AssocResp from 84:d8:1b:70:59:82
(capab=3D0x1411 status=3D0 aid=3D8)
[   29.909554] wlp44s0f0: associated
[   31.345955] kauditd_printk_skb: 120 callbacks suppressed
[   31.345958] audit: type=3D1400 audit(1759072749.149:134):
apparmor=3D"DENIED" operation=3D"open" class=3D"file"
profile=3D"/usr/sbin/cups-browsed"
name=3D"/usr/local/lib/libfreetype.so.6.20.2" pid=3D2259
comm=3D"cups-browsed" requested_mask=3D"r" denied_mask=3D"r" fsuid=3D117
ouid=3D0
[   31.504101] audit: type=3D1400 audit(1759072749.308:135):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"docker-default" pid=3D2385 comm=3D"apparmor_parser"
[   31.538602] evm: overlay not supported
[   31.820163] Initializing XFRM netlink socket
[   31.845100] bridge: filtering via arp/ip/ip6tables is no longer
available by default. Update your scripts to load br_netfilter if you
need this.
[   40.413630] usb 3-3: reset full-speed USB device number 2 using xhci_hcd
[   41.159726] systemd-journald[597]:
/var/log/journal/7f76320c963b48a8b6c1cb34741f02f9/user-1000.journal:
Journal file uses a different sequence number ID, rotating.
[   42.152282] rfkill: input handler enabled
[   59.387840] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   59.388629] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   60.611003] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   60.613392] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   60.615128] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   60.639200] wlp44s0f0: deauthenticating from 84:d8:1b:70:59:82 by
local choice (Reason: 3=3DDEAUTH_LEAVING)
[   61.630142] iwlwifi 0000:2c:00.0: Unregistering PHC clock:
iwlwifi-PTP, with index: 0
[   62.031074] PM: suspend entry (s2idle)
[   62.047712] Filesystems sync: 0.016 seconds
[   62.101156] Freezing user space processes
[   62.103095] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[   62.103098] OOM killer disabled.
[   62.103099] Freezing remaining freezable tasks
[   62.104181] Freezing remaining freezable tasks completed (elapsed
0.001 seconds)
[   62.104185] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[   62.489650] ACPI: EC: interrupt blocked
[   65.805788] ACPI: EC: interrupt unblocked
[   66.290126] pci 0000:00:08.0: Setting to D3hot
[   66.312934] spd5118 1-0050: Failed to write b =3D 0: -6
[   66.312945] spd5118 1-0050: PM: dpm_run_callback(): spd5118_resume
[spd5118] returns -6
[   66.312958] spd5118 1-0050: PM: failed to resume async: error -6
[   66.318931] i915 0000:00:02.0: [drm] GT0: GuC firmware
i915/mtl_guc_70.bin version 70.36.0
[   66.327113] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[   66.327117] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[   66.327326] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[   66.327818] i915 0000:00:02.0: [drm] GT1: GuC firmware
i915/mtl_guc_70.bin version 70.36.0
[   66.327820] i915 0000:00:02.0: [drm] GT1: HuC firmware
i915/mtl_huc_gsc.bin version 8.5.4
[   66.351731] i915 0000:00:02.0: [drm] GT1: GUC: submission enabled
[   66.351732] i915 0000:00:02.0: [drm] GT1: GUC: SLPC enabled
[   66.351796] i915 0000:00:02.0: [drm] GT1: GUC: RC enabled
[   66.818856] fbcon: Taking over console
[   66.819128] mei_gsc_proxy
0000:00:16.0-0f73db04-97ab-4125-b893-e904ad0d5464: bound 0000:00:02.0
(ops i915_gsc_proxy_component_ops [i915])
[   66.822326] Console: switching to colour frame buffer device 160x50
[   66.830412] OOM killer enabled.
[   66.830414] Restarting tasks ... done.
[   66.833495] random: crng reseeded on system resumption
[   66.942579] PM: suspend exit
[   66.993359] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[   66.993547] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   66.993693] Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   67.004869] Intel(R) Wireless WiFi driver for Linux
[   67.014032] iwlwifi 0000:2c:00.0: Detected crf-id 0x2001910, cnv-id
0x2001910 wfpm id 0x80000000
[   67.014130] iwlwifi 0000:2c:00.0: PCI dev 272b/1774, rev=3D0x472, rfid=
=3D0x112200
[   67.014132] iwlwifi 0000:2c:00.0: Detected Intel(R) Wi-Fi 7 BE202 160MHz
[   67.016943] iwlwifi 0000:2c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
Version: 0.0.4.196
[   67.017200] iwlwifi 0000:2c:00.0: loaded firmware version
96.44729d4e.0 gl-c0-fm-c0-96.ucode op_mode iwlmvm
[   67.395629] iwlwifi 0000:2c:00.0: Detected RF FM, rfid=3D0x112200
[   67.396130] iwlwifi 0000:2c:00.0: loaded PNVM version 97f4ce1a
[   67.510361] iwlwifi 0000:2c:00.0: base HW address: a0:02:a5:6b:d6:5e
[   67.592265] iwlwifi 0000:2c:00.0 wlp44s0f0: renamed from wlan0
[   68.056514] Realtek Internal NBASE-T PHY r8169-0-2d00:00: attached
PHY driver (mii_bus:phy_addr=3Dr8169-0-2d00:00, irq=3DMAC)
[   68.162853] usb 3-3: reset full-speed USB device number 2 using xhci_hcd
[   68.197718] r8169 0000:2d:00.0 enp45s0: Link is Down
[   68.612253] iwlwifi 0000:2c:00.0: Registered PHC clock:
iwlwifi-PTP, with index: 0
[   68.615741] warning: `wpa_supplicant' uses wireless extensions
which will stop working for Wi-Fi 7 hardware; use nl80211

Thank you,

Francesco Bergesio

