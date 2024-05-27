Return-Path: <linux-wireless+bounces-8148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A925A8D0FFB
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 00:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D1C1F223A5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 22:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4001757D;
	Mon, 27 May 2024 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="KQFZQLD/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF81754B;
	Mon, 27 May 2024 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716847311; cv=none; b=fDwGKRRw/xpvrqQe/7/GcYmJkUTVgwq9SwXPgCrri9qmiHI3Bli798YmYg/1pNACQ6KOOBVhwDMq7RzJsAFXU5Td5vsXmW5wDST+MuHyDBXhI+3p4v+pdbJnt17VO9tWvRYT6nwRyMYppiX9KBV5r6JfvI5Afcc8KZFi6bz3kkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716847311; c=relaxed/simple;
	bh=2H/80+wzQ2XOwb3eOdXEuO4YMb0KcSoHPNh9+VZOE6o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BXDYO/pOAj4vTg57jGtk7ouQ+u6A0A5szeWMvhJV6wvOdlM/9MioteKIeyuf62Fdc+nfifUlPclSKzZYMydifcN7YYih87A4DE87Zn52DeTyjjxjCVbEC/1Ifj7xg4OcjgIEEaDYIdAdrnl8v/G+YXZPRq3W0AUXMfVmCIA2Flc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=KQFZQLD/; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1716847279; x=1717452079; i=christian@heusel.eu;
	bh=B735z6EUj4cLVMYVFMbcIDCkO26bivXo3HNH1SLBoBw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KQFZQLD/QipAKy7pjTo+jrmWFFcITzDkIUwqsJqdoNZM8/46dVzUrOhN6T6hM7mz
	 57SeTK5BKUFCFImBow5z3BZ5cPDviFHCoNzz7Z2OhEceSCPn5bhdxfdpsR0eGNbxG
	 iG4IttQQjGZEgV888TST3msQUqdx6E+muMQ2GkaiLRaQXcdRyTiL6ooKFqB1uZVVz
	 DEYBtGfDJ/AYTu5RVsrrtYBMRwcIgzPFsXokypQT/ZGts6n6zHkwE1ADpohnQzz6f
	 HVDO0jmIihpEjkH6k4LbG++pYRMW8R/sFKKy/5HpaDe9XLaMKM8hh8TQ2ZZvadKVs
	 sI/woaT67yvBvOHsSw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MOQyE-1rrSnR0zUc-00PtSF; Tue, 28
 May 2024 00:01:19 +0200
Date: Tue, 28 May 2024 00:01:17 +0200
From: Christian Heusel <christian@heusel.eu>
To: Johannes Berg <johannes.berg@intel.com>, regressions@lists.linux.dev
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	Savyasaachi Vanga <savyasaachiv@gmail.com>
Subject: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor mode
Message-ID: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uvegfu5o6t7aays6"
Content-Disposition: inline
X-Provags-ID: V03:K1:zAacSps9IZIb1diA12HIj6vhuwSQOCgs0CYguzedl6gpp9DlDCa
 QUY2dTiCJLVdSKUrRToWRgy4vGvjDyAXmfwn5JQ+YssphO8APi5nP86qz6a97TdCYv6mmLY
 dEPIkIgQK1RMxHOCKXZ5aRClDqO7gIav9Pro2wvjQwMMZ5B8eyN88SQp84sfaWo5VnOEPSw
 6n9Sg6hZ6ENmafQochzUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DKRKQCZKyXU=;WI/pH1NftFrvV2PEGzyv9HVNtOE
 9Am3n90T3fFm3Y4pgtvBPVZ/GxKIY5+9naw1h5uzdxvYLEPQ3OMWczjyppN4y8U/bsRI+YBun
 RWqfCEJnnOyJ6YF4V8PdSykf263Z0DX3a08Lg2eR1cyS5jiLKvuE92aX59XN/dhYNxgJlkCSy
 Loy5iAs+mE7b5eF3JRE+sNfKf5SdDVMzHjsSnKa+VJ6HW9QpOAe7YNj9Xjb3g8BGQ0bpBPudG
 57iFvwIQQdlCGKipD290PNXioof3oAkGlss5/s3p50zDrk63z4KLkQl3OYQbPupVG/FLXEY2d
 s3DUpkh/LwVVS4oYU9ErGnEbG95/5oDGUwAzaEQRHh8dovXC+2MVgdnEAFM0nRQpAd11VOcbm
 Ey3uj29gh8LTOE7Aiq7GmmfTvjHfa4H/8oJcc1/DkkI1Qh58/36TKG2GVWGDl62rjUK2uiIu8
 bvjz4JnfBdmq9I5tuagTMLs2EaMKkGWPVbWa5YZQ8KAVaIyfAg4cjcEGo7QLMoqu5UIiJn8kf
 w79ZTc9gX8AlgRVkDn3pO33iQHYx0ZFbUE9RnIbMBzgka4vBx+9IbLzNU3uqIelJhEVW2nQ6z
 P7+HC5MMSMEepOkHSyoYvXScH43YKep4+gDCcfYY9fxH7eEPo4HG9+B2R9mwzNlHeYpO/xY4f
 ueD2FBDIhbjd28NucgwayNy4PytiVq1/Bvj5Lo6z7v6WWQQyFoHV5xZPb7vmpbEAtt0rGOMkI
 StQf4S9UWYsGIQ85AND3Jzjc3uRV2W1A2jv9Zke27WVNASzqJ8eJTk=


--uvegfu5o6t7aays6
Content-Type: multipart/mixed; boundary="3gxhxmfzxhyezdgf"
Content-Disposition: inline


--3gxhxmfzxhyezdgf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Johannes,

Savyasaachi reports that scanning for other stations in monitor mode
does not work anymore with his RTL8821CE wireless network card for linux
kernels after 6.8.9.

His workflow was putting the adapter in monitor mode by running
"airmon-ng start wlan0" and then capture the surrounding stations with
"airodump-ng wlan0".

We have bisected the issue together in the issue in the Arch Linux
bugtracker[0] down to the following commit:

    0a44dfc070749 ("wifi: mac80211: simplify non-chanctx drivers")

Savyasaachi (in CC) offered to be available for questions and further
debugging in this thread and some general debugging outputs are
attached/below.

Reported-by: Savyasaachi Vanga <savyasaachiv@gmail.com>
Bisected-by: Christian Heusel <christian@heusel.eu>

Cheers,
Chris

[0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/54

---

#regzbot link: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/54
#regzbot introduced: 0a44dfc070749
#regzbot title: wifi: RTL8821CE does not work in monitor mode

---

lsusb:

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 002: ID 0bda:c829 Realtek Semiconductor Corp. Bluetooth Radio
Bus 003 Device 003: ID 0c45:6739 Microdia Integrated_Webcam_FHD
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub

lspci:

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
00:01.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus
00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 51)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 7
01:00.0 Non-Volatile memory controller: Micron Technology Inc 2210 NVMe SSD [Cobain] (rev 03)
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
03:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8821CE 802.11ac PCIe Wireless Network Adapter
04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Barcelo (rev c2)
04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon High Definition Audio Controller
04:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
04:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB 3.1
04:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB 3.1
04:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
04:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h HD Audio Controller
05:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 81)
05:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 81)

--3gxhxmfzxhyezdgf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="6.9.1-zen1-2-zen_dmesg.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.9.1-zen1-2-zen (linux-zen@archlinux) (gcc (G=
CC) 14.1.1 20240522, GNU ld (GNU Binutils) 2.42.0) #1 ZEN SMP PREEMPT_DYNAM=
IC Wed, 22 May 2024 13:47:12 +0000
[    0.000000] Command line: initrd=3D\amd-ucode.img initrd=3D\initramfs-li=
nux-zen.img root=3DUUID=3D306acb61-a48c-46f5-a81d-f74851a36849 rootflags=3D=
subvol=3D@root rw quiet resume=3DUUID=3D8407db45-f134-4fae-a376-48d0f4987f51
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000099fffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009a00000-0x0000000009dfffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f0efff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000009f0f000-0x00000000ab798fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ab799000-0x00000000ac998fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ac999000-0x00000000c9baefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c9baf000-0x00000000cbf7efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000cbf7f000-0x00000000cdf7efff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000cdf7f000-0x00000000cdffefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000cdfff000-0x00000000cdffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ce000000-0x00000000cfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fde00000-0x00000000fdefffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe0fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec01fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec20000-0x00000000fec20fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed81fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000fff1ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000040e2fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000040e300000-0x000000042fffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0xa9011018-0xa901e857] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000bff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000099fff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009a00000-0x0000000009dfff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000009e00000-0x0000000009efff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009f00000-0x0000000009f0ef=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000009f0f000-0x00000000a90110=
17] usable
[    0.000000] reserve setup_data: [mem 0x00000000a9011018-0x00000000a901e8=
57] usable
[    0.000000] reserve setup_data: [mem 0x00000000a901e858-0x00000000ab798f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000ab799000-0x00000000ac998f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ac999000-0x00000000c9baef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000c9baf000-0x00000000cbf7ef=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000cbf7f000-0x00000000cdf7ef=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000cdf7f000-0x00000000cdffef=
ff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000cdfff000-0x00000000cdffff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000ce000000-0x00000000cfffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fde00000-0x00000000fdefff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe0fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec01f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec20000-0x00000000fec20f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed81f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000fff1ff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000040e2fff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000040e300000-0x000000042fffff=
ff] reserved
[    0.000000] efi: EFI v2.7 by Dell Inc.
[    0.000000] efi: ACPI=3D0xcdffe000 ACPI 2.0=3D0xcdffe014 TPMFinalLog=3D0=
xcdf37000 SMBIOS=3D0xca68a000 SMBIOS 3.0=3D0xca688000 MEMATTR=3D0xb6890018 =
ESRT=3D0xb9474d18 RNG=3D0xcdfaff18 INITRD=3D0xac9adb18 TPMEventLog=3D0xac9a=
6018=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem56: MMIO range=3D[0xf8000000-0xfbffffff] (64M=
B) from e820 map
[    0.000000] e820: remove [mem 0xf8000000-0xfbffffff] reserved
[    0.000000] efi: Remove mem57: MMIO range=3D[0xfde00000-0xfdefffff] (1MB=
) from e820 map
[    0.000000] e820: remove [mem 0xfde00000-0xfdefffff] reserved
[    0.000000] efi: Remove mem58: MMIO range=3D[0xfe000000-0xfe0fffff] (1MB=
) from e820 map
[    0.000000] e820: remove [mem 0xfe000000-0xfe0fffff] reserved
[    0.000000] efi: Not removing mem59: MMIO range=3D[0xfec00000-0xfec01fff=
] (8KB) from e820 map
[    0.000000] efi: Not removing mem60: MMIO range=3D[0xfec10000-0xfec10fff=
] (4KB) from e820 map
[    0.000000] efi: Not removing mem61: MMIO range=3D[0xfec20000-0xfec20fff=
] (4KB) from e820 map
[    0.000000] efi: Not removing mem62: MMIO range=3D[0xfed80000-0xfed81fff=
] (8KB) from e820 map
[    0.000000] efi: Not removing mem63: MMIO range=3D[0xfee00000-0xfee00fff=
] (4KB) from e820 map
[    0.000000] efi: Remove mem64: MMIO range=3D[0xff000000-0xfff1ffff] (15M=
B) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xfff1ffff] reserved
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: Dell Inc. Vostro 3425/0R5M49, BIOS 1.16.0 01/09/2024
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2295.539 MHz processor
[    0.000351] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000353] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000359] last_pfn =3D 0x40e300 max_arch_pfn =3D 0x400000000
[    0.000366] MTRR map: 8 entries (4 fixed + 4 variable; max 21), built fr=
om 9 variable MTRRs
[    0.000368] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000570] last_pfn =3D 0xce000 max_arch_pfn =3D 0x400000000
[    0.004285] esrt: Reserving ESRT space from 0x00000000b9474d18 to 0x0000=
0000b9474d78.
[    0.004292] e820: update [mem 0xb9474000-0xb9474fff] usable =3D=3D> rese=
rved
[    0.004306] Using GB pages for direct mapping
[    0.005051] Secure boot disabled
[    0.005052] RAMDISK: [mem 0xa2e47000-0xa4faefff]
[    0.005191] ACPI: Early table checksum verification disabled
[    0.005194] ACPI: RSDP 0x00000000CDFFE014 000024 (v02 DELL  )
[    0.005196] ACPI: XSDT 0x00000000CDFC7188 00014C (v01 DELL   CL09     00=
000002      01000013)
[    0.005201] ACPI: FACP 0x00000000CDFE8000 00010C (v05 DELL   CL09     00=
000002 ASL  00040000)
[    0.005205] ACPI: DSDT 0x00000000CDFD9000 00A3F9 (v01 DELL   CL09     00=
000002 ASL  00040000)
[    0.005207] ACPI: FACS 0x00000000CDECD000 000040
[    0.005208] ACPI: UEFI 0x00000000CDF7E000 000236 (v01 DELL   CL09     00=
000001 ASL  00040000)
[    0.005210] ACPI: SSDT 0x00000000CDFFC000 000106 (v02 DELL   CL09     00=
003000 ACPI 00040000)
[    0.005212] ACPI: SSDT 0x00000000CDFFB000 00076F (v02 DELL   CL09     00=
003000 ACPI 00040000)
[    0.005213] ACPI: SSDT 0x00000000CDFFA000 000033 (v02 DELL   CL09     00=
003000 ACPI 00040000)
[    0.005215] ACPI: SSDT 0x00000000CDFF2000 0072B0 (v02 DELL   CL09     00=
000002 ACPI 00040000)
[    0.005217] ACPI: SSDT 0x00000000CDFEE000 003A21 (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005219] ACPI: SSDT 0x00000000CDFED000 00077B (v02 DELL   CL09     00=
001000 ACPI 00040000)
[    0.005220] ACPI: TPM2 0x00000000CDFEC000 00004C (v04 DELL   CL09     00=
000002 ASL  00040000)
[    0.005222] ACPI: MSDM 0x00000000CDFEB000 000055 (v03 DELL   CL09     00=
000001 ASL  00040000)
[    0.005224] ACPI: ASF! 0x00000000CDFEA000 0000A5 (v32 DELL   CL09     00=
000002 ASL  00040000)
[    0.005226] ACPI: BOOT 0x00000000CDFE9000 000028 (v01 DELL   CL09     00=
000002 ASL  00040000)
[    0.005227] ACPI: HPET 0x00000000CDFE7000 000038 (v01 DELL   CL09     00=
000002 ASL  00040000)
[    0.005229] ACPI: APIC 0x00000000CDFE6000 000138 (v03 DELL   CL09     00=
000002 ASL  00040000)
[    0.005231] ACPI: MCFG 0x00000000CDFE5000 00003C (v01 DELL   CL09     00=
000002 ASL  00040000)
[    0.005233] ACPI: SLIC 0x00000000CDFE4000 000176 (v01 DELL   CL09     00=
000002 ASL  00040000)
[    0.005234] ACPI: SSDT 0x00000000CDFD8000 000080 (v01 DELL   CL09     00=
000002 ACPI 00040000)
[    0.005236] ACPI: WSMT 0x00000000CDFD7000 000028 (v01 DELL   CL09     00=
000001 ASL  00040000)
[    0.005238] ACPI: VFCT 0x00000000CDFC9000 00D884 (v01 DELL   CL09     00=
000001 ASL  00040000)
[    0.005240] ACPI: SSDT 0x00000000CDFC8000 0000F8 (v01 DELL   CL09     00=
001000 ACPI 00040000)
[    0.005241] ACPI: SSDT 0x00000000CDFC3000 003E88 (v02 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005243] ACPI: CRAT 0x00000000CDFFD000 000B68 (v01 DELL   CL09     00=
000001 ASL  00040000)
[    0.005245] ACPI: CDIT 0x00000000CDFC2000 000029 (v01 DELL   CL09     00=
000001 ASL  00040000)
[    0.005246] ACPI: SSDT 0x00000000CDFC1000 000139 (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005248] ACPI: SSDT 0x00000000CDFC0000 000D53 (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005250] ACPI: SSDT 0x00000000CDFBE000 0010C5 (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005252] ACPI: SSDT 0x00000000CDFBD000 00028D (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005253] ACPI: SSDT 0x00000000CDFB9000 00362F (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005255] ACPI: FPDT 0x00000000CDFB8000 000044 (v01 DELL   CL09     00=
000002 ASL  00040000)
[    0.005257] ACPI: BGRT 0x00000000CDFB7000 000038 (v01 DELL   CL09     00=
000001 ASL  00040000)
[    0.005259] ACPI: IVRS 0x00000000CDFB6000 0001A4 (v02 DELL   CL09     00=
000001 ASL  00040000)
[    0.005260] ACPI: SSDT 0x00000000CDFB5000 000042 (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005262] ACPI: SSDT 0x00000000CDFB4000 00020A (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005264] ACPI: SSDT 0x00000000CDFB3000 0006DA (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005265] ACPI: SSDT 0x00000000CDFB2000 000319 (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005267] ACPI: SSDT 0x00000000CDFB1000 00007D (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005269] ACPI: SSDT 0x00000000CDFB0000 0004DB (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.005270] ACPI: Reserving FACP table memory at [mem 0xcdfe8000-0xcdfe8=
10b]
[    0.005271] ACPI: Reserving DSDT table memory at [mem 0xcdfd9000-0xcdfe3=
3f8]
[    0.005272] ACPI: Reserving FACS table memory at [mem 0xcdecd000-0xcdecd=
03f]
[    0.005273] ACPI: Reserving UEFI table memory at [mem 0xcdf7e000-0xcdf7e=
235]
[    0.005273] ACPI: Reserving SSDT table memory at [mem 0xcdffc000-0xcdffc=
105]
[    0.005274] ACPI: Reserving SSDT table memory at [mem 0xcdffb000-0xcdffb=
76e]
[    0.005274] ACPI: Reserving SSDT table memory at [mem 0xcdffa000-0xcdffa=
032]
[    0.005275] ACPI: Reserving SSDT table memory at [mem 0xcdff2000-0xcdff9=
2af]
[    0.005276] ACPI: Reserving SSDT table memory at [mem 0xcdfee000-0xcdff1=
a20]
[    0.005276] ACPI: Reserving SSDT table memory at [mem 0xcdfed000-0xcdfed=
77a]
[    0.005277] ACPI: Reserving TPM2 table memory at [mem 0xcdfec000-0xcdfec=
04b]
[    0.005277] ACPI: Reserving MSDM table memory at [mem 0xcdfeb000-0xcdfeb=
054]
[    0.005278] ACPI: Reserving ASF! table memory at [mem 0xcdfea000-0xcdfea=
0a4]
[    0.005279] ACPI: Reserving BOOT table memory at [mem 0xcdfe9000-0xcdfe9=
027]
[    0.005279] ACPI: Reserving HPET table memory at [mem 0xcdfe7000-0xcdfe7=
037]
[    0.005280] ACPI: Reserving APIC table memory at [mem 0xcdfe6000-0xcdfe6=
137]
[    0.005280] ACPI: Reserving MCFG table memory at [mem 0xcdfe5000-0xcdfe5=
03b]
[    0.005281] ACPI: Reserving SLIC table memory at [mem 0xcdfe4000-0xcdfe4=
175]
[    0.005282] ACPI: Reserving SSDT table memory at [mem 0xcdfd8000-0xcdfd8=
07f]
[    0.005282] ACPI: Reserving WSMT table memory at [mem 0xcdfd7000-0xcdfd7=
027]
[    0.005283] ACPI: Reserving VFCT table memory at [mem 0xcdfc9000-0xcdfd6=
883]
[    0.005283] ACPI: Reserving SSDT table memory at [mem 0xcdfc8000-0xcdfc8=
0f7]
[    0.005284] ACPI: Reserving SSDT table memory at [mem 0xcdfc3000-0xcdfc6=
e87]
[    0.005284] ACPI: Reserving CRAT table memory at [mem 0xcdffd000-0xcdffd=
b67]
[    0.005285] ACPI: Reserving CDIT table memory at [mem 0xcdfc2000-0xcdfc2=
028]
[    0.005286] ACPI: Reserving SSDT table memory at [mem 0xcdfc1000-0xcdfc1=
138]
[    0.005286] ACPI: Reserving SSDT table memory at [mem 0xcdfc0000-0xcdfc0=
d52]
[    0.005287] ACPI: Reserving SSDT table memory at [mem 0xcdfbe000-0xcdfbf=
0c4]
[    0.005288] ACPI: Reserving SSDT table memory at [mem 0xcdfbd000-0xcdfbd=
28c]
[    0.005288] ACPI: Reserving SSDT table memory at [mem 0xcdfb9000-0xcdfbc=
62e]
[    0.005289] ACPI: Reserving FPDT table memory at [mem 0xcdfb8000-0xcdfb8=
043]
[    0.005289] ACPI: Reserving BGRT table memory at [mem 0xcdfb7000-0xcdfb7=
037]
[    0.005290] ACPI: Reserving IVRS table memory at [mem 0xcdfb6000-0xcdfb6=
1a3]
[    0.005291] ACPI: Reserving SSDT table memory at [mem 0xcdfb5000-0xcdfb5=
041]
[    0.005291] ACPI: Reserving SSDT table memory at [mem 0xcdfb4000-0xcdfb4=
209]
[    0.005292] ACPI: Reserving SSDT table memory at [mem 0xcdfb3000-0xcdfb3=
6d9]
[    0.005292] ACPI: Reserving SSDT table memory at [mem 0xcdfb2000-0xcdfb2=
318]
[    0.005293] ACPI: Reserving SSDT table memory at [mem 0xcdfb1000-0xcdfb1=
07c]
[    0.005294] ACPI: Reserving SSDT table memory at [mem 0xcdfb0000-0xcdfb0=
4da]
[    0.005348] No NUMA configuration found
[    0.005350] Faking a node at [mem 0x0000000000000000-0x000000040e2fffff]
[    0.005352] NODE_DATA(0) allocated [mem 0x40e2fb000-0x40e2fffff]
[    0.005376] Zone ranges:
[    0.005377]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005378]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005379]   Normal   [mem 0x0000000100000000-0x000000040e2fffff]
[    0.005380]   Device   empty
[    0.005381] Movable zone start for each node
[    0.005381] Early memory node ranges
[    0.005381]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.005382]   node   0: [mem 0x0000000000100000-0x00000000099fffff]
[    0.005383]   node   0: [mem 0x0000000009e00000-0x0000000009efffff]
[    0.005384]   node   0: [mem 0x0000000009f0f000-0x00000000ab798fff]
[    0.005385]   node   0: [mem 0x00000000ac999000-0x00000000c9baefff]
[    0.005385]   node   0: [mem 0x00000000cdfff000-0x00000000cdffffff]
[    0.005386]   node   0: [mem 0x0000000100000000-0x000000040e2fffff]
[    0.005388] Initmem setup node 0 [mem 0x0000000000001000-0x000000040e2ff=
fff]
[    0.005391] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.005412] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.005598] On node 0, zone DMA32: 1024 pages in unavailable ranges
[    0.009687] On node 0, zone DMA32: 15 pages in unavailable ranges
[    0.010528] On node 0, zone DMA32: 4608 pages in unavailable ranges
[    0.010699] On node 0, zone DMA32: 17488 pages in unavailable ranges
[    0.032104] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.032178] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.032587] ACPI: PM-Timer IO Port: 0x408
[    0.032593] CPU topo: Ignoring hot-pluggable APIC ID 0 in present packag=
e.
[    0.032596] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.032598] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.032598] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.032599] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.032599] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.032600] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.032600] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.032601] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.032602] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.032602] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.032603] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.032603] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.032604] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.032604] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.032605] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.032605] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.032618] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0=
-23
[    0.032623] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 2=
4-55
[    0.032625] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.032626] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.032629] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.032630] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.032640] e820: update [mem 0xb68c0000-0xb6917fff] usable =3D=3D> rese=
rved
[    0.032655] CPU topo: Max. logical packages:   1
[    0.032656] CPU topo: Max. logical dies:       1
[    0.032656] CPU topo: Max. dies per package:   1
[    0.032660] CPU topo: Max. threads per core:   2
[    0.032660] CPU topo: Num. cores per package:     6
[    0.032661] CPU topo: Num. threads per package:  12
[    0.032661] CPU topo: Allowing 12 present CPUs plus 0 hotplug CPUs
[    0.032662] CPU topo: Rejected CPUs 4
[    0.032683] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.032685] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000bffff]
[    0.032686] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0=
x000fffff]
[    0.032687] PM: hibernation: Registered nosave memory: [mem 0x09a00000-0=
x09dfffff]
[    0.032688] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0=
x09f0efff]
[    0.032689] PM: hibernation: Registered nosave memory: [mem 0xa9011000-0=
xa9011fff]
[    0.032691] PM: hibernation: Registered nosave memory: [mem 0xa901e000-0=
xa901efff]
[    0.032692] PM: hibernation: Registered nosave memory: [mem 0xab799000-0=
xac998fff]
[    0.032693] PM: hibernation: Registered nosave memory: [mem 0xb68c0000-0=
xb6917fff]
[    0.032695] PM: hibernation: Registered nosave memory: [mem 0xb9474000-0=
xb9474fff]
[    0.032696] PM: hibernation: Registered nosave memory: [mem 0xc9baf000-0=
xcbf7efff]
[    0.032697] PM: hibernation: Registered nosave memory: [mem 0xcbf7f000-0=
xcdf7efff]
[    0.032697] PM: hibernation: Registered nosave memory: [mem 0xcdf7f000-0=
xcdffefff]
[    0.032698] PM: hibernation: Registered nosave memory: [mem 0xce000000-0=
xcfffffff]
[    0.032699] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0=
xfebfffff]
[    0.032699] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec01fff]
[    0.032700] PM: hibernation: Registered nosave memory: [mem 0xfec02000-0=
xfec0ffff]
[    0.032700] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0=
xfec10fff]
[    0.032701] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0=
xfec1ffff]
[    0.032701] PM: hibernation: Registered nosave memory: [mem 0xfec20000-0=
xfec20fff]
[    0.032702] PM: hibernation: Registered nosave memory: [mem 0xfec21000-0=
xfed7ffff]
[    0.032702] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0=
xfed81fff]
[    0.032703] PM: hibernation: Registered nosave memory: [mem 0xfed82000-0=
xfedfffff]
[    0.032703] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.032704] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.032705] [mem 0xd0000000-0xfebfffff] available for PCI devices
[    0.032706] Booting paravirtualized kernel on bare hardware
[    0.032709] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.037370] setup_percpu: NR_CPUS:320 nr_cpumask_bits:12 nr_cpu_ids:12 n=
r_node_ids:1
[    0.038035] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.038041] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=3D1*2097152
[    0.038042] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07=20
[    0.038046] pcpu-alloc: [0] 08 09 10 11=20
[    0.038065] Kernel command line: initrd=3D\amd-ucode.img initrd=3D\initr=
amfs-linux-zen.img root=3DUUID=3D306acb61-a48c-46f5-a81d-f74851a36849 rootf=
lags=3Dsubvol=3D@root rw quiet resume=3DUUID=3D8407db45-f134-4fae-a376-48d0=
f4987f51
[    0.039532] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.040254] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.040325] Fallback order for Node 0: 0=20
[    0.040329] Built 1 zonelists, mobility grouping on.  Total pages: 39613=
42
[    0.040330] Policy zone: Normal
[    0.040553] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.040597] software IO TLB: area num 16.
[    0.080639] Memory: 15564992K/16097532K available (20480K kernel code, 2=
183K rwdata, 13120K rodata, 3528K init, 3348K bss, 532280K reserved, 0K cma=
-reserved)
[    0.080798] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D12, =
Nodes=3D1
[    0.080838] ftrace: allocating 47492 entries in 186 pages
[    0.089902] ftrace: allocated 186 pages with 5 groups
[    0.089974] Dynamic Preempt: full
[    0.090021] rcu: Preemptible hierarchical RCU implementation.
[    0.090022] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D12.
[    0.090023] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.090024] 	Trampoline variant of Tasks RCU enabled.
[    0.090024] 	Rude variant of Tasks RCU enabled.
[    0.090024] 	Tracing variant of Tasks RCU enabled.
[    0.090025] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    0.090026] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D12
[    0.090032] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1.
[    0.090034] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1.
[    0.090036] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb=
_adjust=3D1.
[    0.093129] NR_IRQS: 20736, nr_irqs: 1064, preallocated irqs: 16
[    0.093317] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.093422] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.093450] Console: colour dummy device 80x25
[    0.093452] printk: legacy console [tty0] enabled
[    0.093490] ACPI: Core revision 20230628
[    0.093697] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.093714] APIC: Switch to symmetric I/O mode setup
[    0.094678] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:160
[    0.094680] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:160
[    0.094681] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:160
[    0.094681] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:160
[    0.094682] AMD-Vi: Using global IVHD EFR:0x206d73ef22254ade, EFR2:0x0
[    0.094989] APIC: Switched APIC routing to: physical flat
[    0.095737] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.100721] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2116bf37ec8, max_idle_ns: 440795308354 ns
[    0.100726] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4591.07 BogoMIPS (lpj=3D2295539)
[    0.100742] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.100776] LVT offset 1 assigned for vector 0xf9
[    0.100886] LVT offset 2 assigned for vector 0xf4
[    0.100912] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.100913] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.100915] process: using mwait in idle threads
[    0.100917] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.100919] Spectre V2 : Mitigation: Retpolines
[    0.100920] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.100920] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.100921] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    0.100922] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.100923] Spectre V2 : User space: Mitigation: STIBP always-on protect=
ion
[    0.100924] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.100926] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.100930] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.100931] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.100932] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.100932] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.100933] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User =
registers'
[    0.100934] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.100935] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.100936] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.100937] x86/fpu: Enabled xstate features 0xa07, context size is 856 =
bytes, using 'compacted' format.
[    0.120639] Freeing SMP alternatives memory: 52K
[    0.120641] pid_max: default: 32768 minimum: 301
[    0.124768] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.124796] landlock: Up and running.
[    0.124798] Yama: becoming mindful.
[    0.124803] LSM support for eBPF active
[    0.124839] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.124853] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.228790] smpboot: CPU0: AMD Ryzen 5 5625U with Radeon Graphics (famil=
y: 0x19, model: 0x50, stepping: 0x0)
[    0.229011] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.229017] ... version:                0
[    0.229018] ... bit width:              48
[    0.229019] ... generic registers:      6
[    0.229020] ... value mask:             0000ffffffffffff
[    0.229021] ... max period:             00007fffffffffff
[    0.229022] ... fixed-purpose events:   0
[    0.229023] ... event mask:             000000000000003f
[    0.229119] signal: max sigframe size: 3376
[    0.229156] rcu: Hierarchical SRCU implementation.
[    0.229158] rcu: 	Max phase no-delay instances is 400.
[    0.232071] MCE: In-kernel MCE decoding enabled.
[    0.232128] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.232234] smp: Bringing up secondary CPUs ...
[    0.232339] smpboot: x86: Booting SMP configuration:
[    0.232340] .... node  #0, CPUs:        #2  #4  #6  #8 #10  #1  #3  #5  =
#7  #9 #11
[    0.239827] Spectre V2 : Update user space SMT mitigation: STIBP always-=
on
[    0.244758] smp: Brought up 1 node, 12 CPUs
[    0.244758] smpboot: Total of 12 processors activated (55092.93 BogoMIPS)
[    0.247051] devtmpfs: initialized
[    0.247051] x86/mm: Memory block size: 128MB
[    0.248873] ACPI: PM: Registering ACPI NVS region [mem 0x09f00000-0x09f0=
efff] (61440 bytes)
[    0.248873] ACPI: PM: Registering ACPI NVS region [mem 0xcbf7f000-0xcdf7=
efff] (33554432 bytes)
[    0.249254] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.249269] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)
[    0.249334] pinctrl core: initialized pinctrl subsystem
[    0.249449] PM: RTC time: 15:32:21, date: 2024-05-27
[    0.249948] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.250178] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.250268] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.250360] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.250370] audit: initializing netlink subsys (disabled)
[    0.250378] audit: type=3D2000 audit(1716823941.155:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.250378] thermal_sys: Registered thermal governor 'fair_share'
[    0.250378] thermal_sys: Registered thermal governor 'bang_bang'
[    0.250378] thermal_sys: Registered thermal governor 'step_wise'
[    0.250378] thermal_sys: Registered thermal governor 'user_space'
[    0.250378] thermal_sys: Registered thermal governor 'power_allocator'
[    0.250378] cpuidle: using governor ladder
[    0.250378] cpuidle: using governor menu
[    0.250378] Simple Boot Flag at 0x44 set to 0x80
[    0.250378] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.250752] PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for =
domain 0000 [bus 00-3f]
[    0.250757] PCI: not using ECAM ([mem 0xf8000000-0xfbffffff] not reserve=
d)
[    0.250759] PCI: Using configuration type 1 for base access
[    0.250760] PCI: Using configuration type 1 for extended access
[    0.250903] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.251734] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.251735] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.251737] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.251738] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.251935] Demotion targets for Node 0: null
[    0.252167] ACPI: Added _OSI(Module Device)
[    0.252169] ACPI: Added _OSI(Processor Device)
[    0.252171] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.252173] ACPI: Added _OSI(Processor Aggregator Device)
[    0.277528] ACPI: 21 ACPI AML tables successfully acquired and loaded
[    0.280522] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.283218] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.283881] ACPI: EC: EC started
[    0.283882] ACPI: EC: interrupt blocked
[    0.284159] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.284161] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle tran=
sactions
[    0.284163] ACPI: Interpreter enabled
[    0.284178] ACPI: PM: (supports S0 S4 S5)
[    0.284179] ACPI: Using IOAPIC for interrupt routing
[    0.285490] PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for =
domain 0000 [bus 00-3f]
[    0.289019] PCI: [Firmware Info]: ECAM [mem 0xf8000000-0xfbffffff] not r=
eserved in ACPI motherboard resources
[    0.289021] PCI: ECAM [mem 0xf8000000-0xfbffffff] is EfiMemoryMappedIO; =
assuming valid
[    0.289022] PCI: ECAM [mem 0xf8000000-0xfbffffff] reserved to work aroun=
d lack of ACPI motherboard _CRS
[    0.289030] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.289031] PCI: Ignoring E820 reservations for host bridge windows
[    0.291421] ACPI: \_SB_.PCI0.GPP1.P0NV: New power resource
[    0.291796] ACPI: \_SB_.PCI0.GPP3.WLAN.WRST: New power resource
[    0.292085] ACPI: \_SB_.PCI0.GPP6.P0NV: New power resource
[    0.292819] ACPI: \_SB_.PCI0.GP17.XHC0.P0U0: New power resource
[    0.292949] ACPI: \_SB_.PCI0.GP17.XHC0.P3U0: New power resource
[    0.294265] ACPI: \_SB_.PCI0.GP17.XHC1.P0U1: New power resource
[    0.294396] ACPI: \_SB_.PCI0.GP17.XHC1.P3U1: New power resource
[    0.347365] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.347371] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.347499] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplu=
g LTR DPC]
[    0.347730] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER =
PCIeCapability]
[    0.347742] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf8000000-0xfbf=
fffff] for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.348284] PCI host bridge to bus 0000:00
[    0.348286] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.348288] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.348289] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.348291] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000cfff=
f window]
[    0.348293] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000efff=
f window]
[    0.348294] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xf7fffff=
f window]
[    0.348296] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfeaffff=
f window]
[    0.348297] pci_bus 0000:00: root bus resource [mem 0xfed45000-0xfed811f=
f window]
[    0.348298] pci_bus 0000:00: root bus resource [mem 0xfed81900-0xfed81ff=
f window]
[    0.348300] pci_bus 0000:00: root bus resource [mem 0xfedc0000-0xfedc0ff=
f window]
[    0.348301] pci_bus 0000:00: root bus resource [mem 0xfedc6000-0xfedc6ff=
f window]
[    0.348302] pci_bus 0000:00: root bus resource [mem 0x450200000-0xfcffff=
ffff window]
[    0.348304] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.348320] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.348403] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600 convent=
ional PCI endpoint
[    0.348484] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.348572] pci 0000:00:01.2: [1022:1634] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.348588] pci 0000:00:01.2: PCI bridge to [bus 01]
[    0.348593] pci 0000:00:01.2:   bridge window [mem 0xd0700000-0xd07fffff]
[    0.348639] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.348747] pci 0000:00:01.3: [1022:1634] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.348763] pci 0000:00:01.3: PCI bridge to [bus 02]
[    0.348766] pci 0000:00:01.3:   bridge window [io  0x3000-0x3fff]
[    0.348769] pci 0000:00:01.3:   bridge window [mem 0xd0600000-0xd06fffff]
[    0.348811] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
[    0.348906] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.348988] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.349004] pci 0000:00:02.1: PCI bridge to [bus 03]
[    0.349007] pci 0000:00:02.1:   bridge window [io  0x2000-0x2fff]
[    0.349010] pci 0000:00:02.1:   bridge window [mem 0xd0500000-0xd05fffff]
[    0.349054] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.349161] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.349246] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.349261] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.349265] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.349267] pci 0000:00:08.1:   bridge window [mem 0xd0100000-0xd04fffff]
[    0.349273] pci 0000:00:08.1:   bridge window [mem 0xfce0000000-0xfcf01f=
ffff 64bit pref]
[    0.349279] pci 0000:00:08.1: enabling Extended Tags
[    0.349314] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.349451] pci 0000:00:08.2: [1022:1635] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.349466] pci 0000:00:08.2: PCI bridge to [bus 05]
[    0.349471] pci 0000:00:08.2:   bridge window [mem 0xd0000000-0xd00fffff]
[    0.349481] pci 0000:00:08.2: enabling Extended Tags
[    0.349516] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.349640] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.349773] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.349925] pci 0000:00:18.0: [1022:166a] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.349987] pci 0000:00:18.1: [1022:166b] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.350048] pci 0000:00:18.2: [1022:166c] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.350109] pci 0000:00:18.3: [1022:166d] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.350173] pci 0000:00:18.4: [1022:166e] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.350236] pci 0000:00:18.5: [1022:166f] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.350297] pci 0000:00:18.6: [1022:1670] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.350358] pci 0000:00:18.7: [1022:1671] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.350749] pci 0000:01:00.0: [1344:5404] type 00 class 0x010802 PCIe En=
dpoint
[    0.350770] pci 0000:01:00.0: BAR 0 [mem 0xd0700000-0xd0703fff 64bit]
[    0.351085] pci 0000:00:01.2: PCI bridge to [bus 01]
[    0.351145] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.351162] pci 0000:02:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.351185] pci 0000:02:00.0: BAR 2 [mem 0xd0604000-0xd0604fff 64bit]
[    0.351199] pci 0000:02:00.0: BAR 4 [mem 0xd0600000-0xd0603fff 64bit]
[    0.351294] pci 0000:02:00.0: supports D1 D2
[    0.351295] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.351466] pci 0000:00:01.3: PCI bridge to [bus 02]
[    0.351747] pci 0000:03:00.0: [10ec:c821] type 00 class 0x028000 PCIe En=
dpoint
[    0.351765] pci 0000:03:00.0: BAR 0 [io  0x2000-0x20ff]
[    0.351787] pci 0000:03:00.0: BAR 2 [mem 0xd0500000-0xd050ffff 64bit]
[    0.351984] pci 0000:03:00.0: supports D1 D2
[    0.351986] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.352638] pci 0000:00:02.1: PCI bridge to [bus 03]
[    0.352755] pci 0000:04:00.0: [1002:15e7] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.352766] pci 0000:04:00.0: BAR 0 [mem 0xfce0000000-0xfcefffffff 64bit=
 pref]
[    0.352774] pci 0000:04:00.0: BAR 2 [mem 0xfcf0000000-0xfcf01fffff 64bit=
 pref]
[    0.352780] pci 0000:04:00.0: BAR 4 [io  0x1000-0x10ff]
[    0.352786] pci 0000:04:00.0: BAR 5 [mem 0xd0400000-0xd047ffff]
[    0.352794] pci 0000:04:00.0: enabling Extended Tags
[    0.352850] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.352889] pci 0000:04:00.0: 126.016 Gb/s available PCIe bandwidth, lim=
ited by 8.0 GT/s PCIe x16 link at 0000:00:08.1 (capable of 252.048 Gb/s wit=
h 16.0 GT/s PCIe x16 link)
[    0.352982] pci 0000:04:00.1: [1002:1637] type 00 class 0x040300 PCIe Le=
gacy Endpoint
[    0.352990] pci 0000:04:00.1: BAR 0 [mem 0xd04c8000-0xd04cbfff]
[    0.353012] pci 0000:04:00.1: enabling Extended Tags
[    0.353045] pci 0000:04:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.353126] pci 0000:04:00.2: [1022:15df] type 00 class 0x108000 PCIe En=
dpoint
[    0.353140] pci 0000:04:00.2: BAR 2 [mem 0xd0300000-0xd03fffff]
[    0.353150] pci 0000:04:00.2: BAR 5 [mem 0xd04cc000-0xd04cdfff]
[    0.353157] pci 0000:04:00.2: enabling Extended Tags
[    0.353267] pci 0000:04:00.3: [1022:1639] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.353279] pci 0000:04:00.3: BAR 0 [mem 0xd0100000-0xd01fffff 64bit]
[    0.353303] pci 0000:04:00.3: enabling Extended Tags
[    0.353337] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
[    0.353426] pci 0000:04:00.4: [1022:1639] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.353438] pci 0000:04:00.4: BAR 0 [mem 0xd0200000-0xd02fffff 64bit]
[    0.353462] pci 0000:04:00.4: enabling Extended Tags
[    0.353496] pci 0000:04:00.4: PME# supported from D0 D3hot D3cold
[    0.353586] pci 0000:04:00.5: [1022:15e2] type 00 class 0x048000 PCIe En=
dpoint
[    0.353594] pci 0000:04:00.5: BAR 0 [mem 0xd0480000-0xd04bffff]
[    0.353615] pci 0000:04:00.5: enabling Extended Tags
[    0.353647] pci 0000:04:00.5: PME# supported from D0 D3hot D3cold
[    0.353729] pci 0000:04:00.6: [1022:15e3] type 00 class 0x040300 PCIe En=
dpoint
[    0.353737] pci 0000:04:00.6: BAR 0 [mem 0xd04c0000-0xd04c7fff]
[    0.353759] pci 0000:04:00.6: enabling Extended Tags
[    0.353791] pci 0000:04:00.6: PME# supported from D0 D3hot D3cold
[    0.353905] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.353959] pci 0000:05:00.0: [1022:7901] type 00 class 0x010601 PCIe En=
dpoint
[    0.353987] pci 0000:05:00.0: BAR 5 [mem 0xd0001000-0xd00017ff]
[    0.353996] pci 0000:05:00.0: enabling Extended Tags
[    0.354071] pci 0000:05:00.0: 126.016 Gb/s available PCIe bandwidth, lim=
ited by 8.0 GT/s PCIe x16 link at 0000:00:08.2 (capable of 252.048 Gb/s wit=
h 16.0 GT/s PCIe x16 link)
[    0.354147] pci 0000:05:00.1: [1022:7901] type 00 class 0x010601 PCIe En=
dpoint
[    0.354176] pci 0000:05:00.1: BAR 5 [mem 0xd0000000-0xd00007ff]
[    0.354185] pci 0000:05:00.1: enabling Extended Tags
[    0.354307] pci 0000:00:08.2: PCI bridge to [bus 05]
[    0.400343] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.400346] ACPI: PCI: Interrupt link LNKA disabled
[    0.400499] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.400501] ACPI: PCI: Interrupt link LNKB disabled
[    0.400618] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.400620] ACPI: PCI: Interrupt link LNKC disabled
[    0.400718] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.400719] ACPI: PCI: Interrupt link LNKD disabled
[    0.400807] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.400808] ACPI: PCI: Interrupt link LNKE disabled
[    0.400876] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.400877] ACPI: PCI: Interrupt link LNKF disabled
[    0.400945] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.400946] ACPI: PCI: Interrupt link LNKG disabled
[    0.401014] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.401015] ACPI: PCI: Interrupt link LNKH disabled
[    0.402243] Low-power S0 idle used by default for system suspend
[    0.402374] ACPI: EC: interrupt unblocked
[    0.402375] ACPI: EC: event unblocked
[    0.402724] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.402724] ACPI: EC: GPE=3D0x3
[    0.402724] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization comp=
lete
[    0.402724] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions =
and events
[    0.402734] iommu: Default domain type: Translated
[    0.402734] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.402872] SCSI subsystem initialized
[    0.402879] libata version 3.00 loaded.
[    0.402879] ACPI: bus type USB registered
[    0.402879] usbcore: registered new interface driver usbfs
[    0.402879] usbcore: registered new interface driver hub
[    0.402879] usbcore: registered new device driver usb
[    0.450291] EDAC MC: Ver: 3.0.0
[    0.451728] efivars: Registered efivars operations
[    0.451924] NetLabel: Initializing
[    0.451925] NetLabel:  domain hash size =3D 128
[    0.451926] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.451944] NetLabel:  unlabeled traffic allowed by default
[    0.451949] mctp: management component transport protocol core
[    0.451950] NET: Registered PF_MCTP protocol family
[    0.451956] PCI: Using ACPI for IRQ routing
[    0.453771] PCI: pci_cache_line_size set to 64 bytes
[    0.454315] resource: Expanded resource Reserved due to conflict with PC=
I Bus 0000:00
[    0.454317] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.454318] e820: reserve RAM buffer [mem 0x09a00000-0x0bffffff]
[    0.454320] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
[    0.454321] e820: reserve RAM buffer [mem 0xa9011018-0xabffffff]
[    0.454322] e820: reserve RAM buffer [mem 0xab799000-0xabffffff]
[    0.454323] e820: reserve RAM buffer [mem 0xb68c0000-0xb7ffffff]
[    0.454324] e820: reserve RAM buffer [mem 0xb9474000-0xbbffffff]
[    0.454325] e820: reserve RAM buffer [mem 0xc9baf000-0xcbffffff]
[    0.454326] e820: reserve RAM buffer [mem 0xce000000-0xcfffffff]
[    0.454327] e820: reserve RAM buffer [mem 0x40e300000-0x40fffffff]
[    0.454748] pci 0000:04:00.0: vgaarb: setting as boot VGA device
[    0.454748] pci 0000:04:00.0: vgaarb: bridge control possible
[    0.454748] pci 0000:04:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.454748] vgaarb: loaded
[    0.454781] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.454785] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.456796] clocksource: Switched to clocksource tsc-early
[    0.457596] VFS: Disk quotas dquot_6.6.0
[    0.457609] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.457684] pnp: PnP ACPI init
[    0.457904] system 00:00: [mem 0xfec00000-0xfec01fff] could not be reser=
ved
[    0.457908] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.457910] system 00:00: [mem 0xfde00000-0xfdefffff] has been reserved
[    0.458292] system 00:04: [io  0x0400-0x04cf] has been reserved
[    0.458295] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.458296] system 00:04: [io  0x04d6] has been reserved
[    0.458298] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.458300] system 00:04: [io  0x0c14] has been reserved
[    0.458302] system 00:04: [io  0x0c50-0x0c52] has been reserved
[    0.458303] system 00:04: [io  0x0c6c] has been reserved
[    0.458305] system 00:04: [io  0x0c6f] has been reserved
[    0.458306] system 00:04: [io  0x0cd0-0x0cdb] has been reserved
[    0.458308] system 00:04: [io  0xfd60-0xfd6f] has been reserved
[    0.458384] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.504329] pnp: PnP ACPI: found 6 devices
[    0.510152] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.510252] NET: Registered PF_INET protocol family
[    0.510387] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.521670] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.521688] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.521734] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.521945] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.522036] TCP: Hash tables configured (established 131072 bind 65536)
[    0.522110] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    0.522142] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.522177] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    0.522223] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.522229] NET: Registered PF_XDP protocol family
[    0.522238] pci 0000:00:01.2: PCI bridge to [bus 01]
[    0.522243] pci 0000:00:01.2:   bridge window [mem 0xd0700000-0xd07fffff]
[    0.522249] pci 0000:00:01.3: PCI bridge to [bus 02]
[    0.522251] pci 0000:00:01.3:   bridge window [io  0x3000-0x3fff]
[    0.522254] pci 0000:00:01.3:   bridge window [mem 0xd0600000-0xd06fffff]
[    0.522259] pci 0000:00:02.1: PCI bridge to [bus 03]
[    0.522260] pci 0000:00:02.1:   bridge window [io  0x2000-0x2fff]
[    0.522263] pci 0000:00:02.1:   bridge window [mem 0xd0500000-0xd05fffff]
[    0.522269] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.522270] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.522273] pci 0000:00:08.1:   bridge window [mem 0xd0100000-0xd04fffff]
[    0.522276] pci 0000:00:08.1:   bridge window [mem 0xfce0000000-0xfcf01f=
ffff 64bit pref]
[    0.522280] pci 0000:00:08.2: PCI bridge to [bus 05]
[    0.522282] pci 0000:00:08.2:   bridge window [mem 0xd0000000-0xd00fffff]
[    0.522288] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.522290] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.522291] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.522293] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000cffff windo=
w]
[    0.522294] pci_bus 0000:00: resource 8 [mem 0x000d0000-0x000effff windo=
w]
[    0.522296] pci_bus 0000:00: resource 9 [mem 0xd0000000-0xf7ffffff windo=
w]
[    0.522297] pci_bus 0000:00: resource 10 [mem 0xfc000000-0xfeafffff wind=
ow]
[    0.522298] pci_bus 0000:00: resource 11 [mem 0xfed45000-0xfed811ff wind=
ow]
[    0.522300] pci_bus 0000:00: resource 12 [mem 0xfed81900-0xfed81fff wind=
ow]
[    0.522301] pci_bus 0000:00: resource 13 [mem 0xfedc0000-0xfedc0fff wind=
ow]
[    0.522303] pci_bus 0000:00: resource 14 [mem 0xfedc6000-0xfedc6fff wind=
ow]
[    0.522304] pci_bus 0000:00: resource 15 [mem 0x450200000-0xfcffffffff w=
indow]
[    0.522306] pci_bus 0000:01: resource 1 [mem 0xd0700000-0xd07fffff]
[    0.522307] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.522309] pci_bus 0000:02: resource 1 [mem 0xd0600000-0xd06fffff]
[    0.522310] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    0.522312] pci_bus 0000:03: resource 1 [mem 0xd0500000-0xd05fffff]
[    0.522313] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
[    0.522315] pci_bus 0000:04: resource 1 [mem 0xd0100000-0xd04fffff]
[    0.522316] pci_bus 0000:04: resource 2 [mem 0xfce0000000-0xfcf01fffff 6=
4bit pref]
[    0.522317] pci_bus 0000:05: resource 1 [mem 0xd0000000-0xd00fffff]
[    0.522939] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
[    0.522969] pci 0000:04:00.3: extending delay after power-on from D3hot =
to 20 msec
[    0.524261] pci 0000:04:00.4: extending delay after power-on from D3hot =
to 20 msec
[    0.535459] pci 0000:04:00.4: quirk_usb_early_handoff+0x0/0x7a0 took 109=
32 usecs
[    0.535470] PCI: CLS 64 bytes, default 64
[    0.535480] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters support=
ed
[    0.535516] Trying to unpack rootfs image as initramfs...
[    0.535537] pci 0000:00:01.0: Adding to iommu group 0
[    0.535554] pci 0000:00:01.2: Adding to iommu group 1
[    0.535571] pci 0000:00:01.3: Adding to iommu group 2
[    0.535593] pci 0000:00:02.0: Adding to iommu group 3
[    0.535609] pci 0000:00:02.1: Adding to iommu group 4
[    0.535633] pci 0000:00:08.0: Adding to iommu group 5
[    0.535649] pci 0000:00:08.1: Adding to iommu group 6
[    0.535664] pci 0000:00:08.2: Adding to iommu group 7
[    0.535692] pci 0000:00:14.0: Adding to iommu group 8
[    0.535706] pci 0000:00:14.3: Adding to iommu group 8
[    0.535773] pci 0000:00:18.0: Adding to iommu group 9
[    0.535788] pci 0000:00:18.1: Adding to iommu group 9
[    0.535802] pci 0000:00:18.2: Adding to iommu group 9
[    0.535816] pci 0000:00:18.3: Adding to iommu group 9
[    0.535831] pci 0000:00:18.4: Adding to iommu group 9
[    0.535846] pci 0000:00:18.5: Adding to iommu group 9
[    0.535862] pci 0000:00:18.6: Adding to iommu group 9
[    0.535877] pci 0000:00:18.7: Adding to iommu group 9
[    0.535893] pci 0000:01:00.0: Adding to iommu group 10
[    0.535909] pci 0000:02:00.0: Adding to iommu group 11
[    0.535925] pci 0000:03:00.0: Adding to iommu group 12
[    0.535948] pci 0000:04:00.0: Adding to iommu group 13
[    0.535965] pci 0000:04:00.1: Adding to iommu group 14
[    0.535983] pci 0000:04:00.2: Adding to iommu group 15
[    0.536001] pci 0000:04:00.3: Adding to iommu group 16
[    0.536019] pci 0000:04:00.4: Adding to iommu group 17
[    0.536036] pci 0000:04:00.5: Adding to iommu group 18
[    0.536054] pci 0000:04:00.6: Adding to iommu group 19
[    0.536071] pci 0000:05:00.0: Adding to iommu group 20
[    0.536087] pci 0000:05:00.1: Adding to iommu group 21
[    0.537940] AMD-Vi: Extended features (0x206d73ef22254ade, 0x0): PPR X2A=
PIC NX GT IA GA PC GA_vAPIC
[    0.537949] AMD-Vi: Interrupt remapping enabled
[    0.537950] AMD-Vi: X2APIC enabled
[    0.560302] AMD-Vi: Virtual APIC enabled
[    0.560311] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.560313] software IO TLB: mapped [mem 0x00000000c4f92000-0x00000000c8=
f92000] (64MB)
[    0.560386] LVT offset 0 assigned for vector 0x400
[    0.562048] perf: AMD IBS detected (0x000003ff)
[    0.562054] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/b=
ank).
[    0.564756] Initialise system trusted keyrings
[    0.564766] Key type blacklist registered
[    0.564800] workingset: timestamp_bits=3D41 max_order=3D22 bucket_order=
=3D0
[    0.564807] zbud: loaded
[    0.564914] fuse: init (API version 7.40)
[    0.565009] integrity: Platform Keyring initialized
[    0.565012] integrity: Machine keyring initialized
[    0.572615] Key type asymmetric registered
[    0.572616] Asymmetric key parser 'x509' registered
[    0.572639] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.572679] io scheduler mq-deadline registered
[    0.572681] io scheduler kyber registered
[    0.572688] io scheduler bfq registered
[    0.574057] pcieport 0000:00:01.2: PME: Signaling with IRQ 37
[    0.574174] pcieport 0000:00:01.3: PME: Signaling with IRQ 38
[    0.574274] pcieport 0000:00:02.1: PME: Signaling with IRQ 39
[    0.574376] pcieport 0000:00:08.1: PME: Signaling with IRQ 40
[    0.574578] pcieport 0000:00:08.2: PME: Signaling with IRQ 41
[    0.574678] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.576369] ACPI: AC: AC Adapter [ACAD] (on-line)
[    0.576426] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input0
[    0.576454] ACPI: button: Power Button [PWRB]
[    0.576505] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input1
[    0.576522] ACPI: button: Lid Switch [LID]
[    0.576623] Estimated ratio of average max frequency by base frequency (=
times 1024): 1488
[    0.576643] Monitor-Mwait will be used to enter C-1 state
[    0.576650] ACPI: \_SB_.PLTF.C000: Found 3 idle states
[    0.576785] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[    0.576898] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[    0.577057] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[    0.577218] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[    0.577360] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[    0.577523] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[    0.577687] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[    0.577843] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[    0.577999] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[    0.578118] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[    0.578263] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[    0.578677] thermal LNXTHERM:00: registered as thermal_zone0
[    0.578680] ACPI: thermal: Thermal Zone [TZ01] (70 C)
[    0.578901] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.579568] Freeing initrd memory: 34208K
[    0.580821] Non-volatile memory driver v1.3
[    0.580823] Linux agpgart interface v0.103
[    0.583490] tpm_tis NTC0702:00: 2.0 TPM (device-id 0xFC, rev-id 1)
[    0.598558] tpm tpm0: tpm_read_log_acpi: Failed to map ACPI memory
[    0.602598] ahci 0000:05:00.0: version 3.0
[    0.602796] ahci 0000:05:00.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    0.602799] ahci 0000:05:00.0: 1/1 ports implemented (port mask 0x1)
[    0.602801] ahci 0000:05:00.0: flags: 64bit ncq sntf ilck pm led clo onl=
y pmp fbs pio slum part=20
[    0.602961] scsi host0: ahci
[    0.603008] ata1: SATA max UDMA/133 abar m2048@0xd0001000 port 0xd000110=
0 irq 43 lpm-pol 4
[    0.603147] ahci 0000:05:00.1: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    0.603150] ahci 0000:05:00.1: 1/1 ports implemented (port mask 0x1)
[    0.603151] ahci 0000:05:00.1: flags: 64bit ncq sntf ilck pm led clo onl=
y pmp fbs pio slum part=20
[    0.603285] scsi host1: ahci
[    0.603323] ata2: SATA max UDMA/133 abar m2048@0xd0000000 port 0xd000010=
0 irq 45 lpm-pol 4
[    0.603371] ACPI: bus type drm_connector registered
[    0.603735] usbcore: registered new interface driver usbserial_generic
[    0.603740] usbserial: USB Serial support registered for generic
[    0.603795] rtc_cmos 00:01: RTC can wake from S4
[    0.604009] rtc_cmos 00:01: registered as rtc0
[    0.604036] rtc_cmos 00:01: setting system clock to 2024-05-27T15:32:21 =
UTC (1716823941)
[    0.604062] rtc_cmos 00:01: alarms up to one month, 114 bytes nvram
[    0.605062] ledtrig-cpu: registered to indicate activity on CPUs
[    0.605423] [drm] Initialized simpledrm 1.0.0 20200625 for simple-frameb=
uffer.0 on minor 0
[    0.606399] fbcon: Deferring console take-over
[    0.606401] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.606441] hid: raw HID events driver (C) Jiri Kosina
[    0.606519] drop_monitor: Initializing network drop monitor service
[    0.606618] NET: Registered PF_INET6 protocol family
[    0.612134] Segment Routing with IPv6
[    0.612136] RPL Segment Routing with IPv6
[    0.612146] In-situ OAM (IOAM) with IPv6
[    0.612180] NET: Registered PF_PACKET protocol family
[    0.613024] microcode: Current revision: 0x0a50000f
[    0.613221] resctrl: L3 allocation detected
[    0.613222] resctrl: MB allocation detected
[    0.613223] resctrl: L3 monitoring detected
[    0.613240] IPI shorthand broadcast: enabled
[    0.615270] sched_clock: Marking stable (613554930, 1380244)->(633426762=
, -18491588)
[    0.615372] Timer migration: 2 hierarchy levels; 8 children per group; 2=
 crossnode level
[    0.615456] registered taskstats version 1
[    0.615759] Loading compiled-in X.509 certificates
[    0.617363] Loaded X.509 cert 'Build time autogenerated kernel key: e250=
1fda821355ebf9ae420748f066d890852235'
[    0.621828] zswap: loaded using pool zstd/zsmalloc
[    0.622108] Key type .fscrypt registered
[    0.622110] Key type fscrypt-provisioning registered
[    0.623819] integrity: Loading X.509 certificate: UEFI:db
[    0.623846] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.623848] integrity: Loading X.509 certificate: UEFI:db
[    0.623862] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.623863] integrity: Loading X.509 certificate: UEFI:db
[    0.624301] ACPI: battery: Slot [BAT1] (battery present)
[    0.626511] integrity: Loaded X.509 cert 'CompalA31CSMB: 1e3b690555de0b9=
542b280303282c6d6'
[    0.629864] PM:   Magic number: 8:93:539
[    0.629879] tty ttyS19: hash matches
[    0.629882] port serial8250:0.18: hash matches
[    0.633152] RAS: Correctable Errors collector initialized.
[    0.910789] ata2: SATA link down (SStatus 0 SControl 300)
[    0.910892] ata1: SATA link down (SStatus 0 SControl 300)
[    0.911814] clk: Disabling unused clocks
[    0.911816] PM: genpd: Disabling unused power domains
[    0.912702] Freeing unused decrypted memory: 2028K
[    0.913093] Freeing unused kernel image (initmem) memory: 3528K
[    0.913095] Write protecting the kernel read-only data: 34816k
[    0.913398] Freeing unused kernel image (rodata/data gap) memory: 1216K
[    0.958379] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.958383] rodata_test: all tests were successful
[    0.958388] Run /init as init process
[    0.958389]   with arguments:
[    0.958390]     /init
[    0.958392]   with environment:
[    0.958392]     HOME=3D/
[    0.958393]     TERM=3Dlinux
[    1.077119] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQBC data block =
query control method not found
[    1.081525] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:PS2M] at 0=
x60,0x64 irq 1,12
[    1.082911] xhci_hcd 0000:04:00.3: xHCI Host Controller
[    1.082921] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus =
number 1
[    1.083035] xhci_hcd 0000:04:00.3: hcc params 0x0268ffe5 hci version 0x1=
10 quirks 0x0000020000000410
[    1.083346] xhci_hcd 0000:04:00.3: xHCI Host Controller
[    1.083350] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus =
number 2
[    1.083353] xhci_hcd 0000:04:00.3: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.083399] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.09
[    1.083401] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.083403] usb usb1: Product: xHCI Host Controller
[    1.083405] usb usb1: Manufacturer: Linux 6.9.1-zen1-2-zen xhci-hcd
[    1.083406] usb usb1: SerialNumber: 0000:04:00.3
[    1.083553] hub 1-0:1.0: USB hub found
[    1.083565] hub 1-0:1.0: 4 ports detected
[    1.085163] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    1.085194] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.09
[    1.085198] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.085201] usb usb2: Product: xHCI Host Controller
[    1.085203] usb usb2: Manufacturer: Linux 6.9.1-zen1-2-zen xhci-hcd
[    1.085205] usb usb2: SerialNumber: 0000:04:00.3
[    1.085326] hub 2-0:1.0: USB hub found
[    1.085334] hub 2-0:1.0: 2 ports detected
[    1.086206] usb: port power management may be unreliable
[    1.086389] xhci_hcd 0000:04:00.4: xHCI Host Controller
[    1.086396] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus =
number 3
[    1.086498] xhci_hcd 0000:04:00.4: hcc params 0x0268ffe5 hci version 0x1=
10 quirks 0x0000020000000410
[    1.086831] xhci_hcd 0000:04:00.4: xHCI Host Controller
[    1.086836] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus =
number 4
[    1.086840] xhci_hcd 0000:04:00.4: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.086887] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.09
[    1.086890] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.086893] usb usb3: Product: xHCI Host Controller
[    1.086895] usb usb3: Manufacturer: Linux 6.9.1-zen1-2-zen xhci-hcd
[    1.086897] usb usb3: SerialNumber: 0000:04:00.4
[    1.087024] hub 3-0:1.0: USB hub found
[    1.087033] hub 3-0:1.0: 4 ports detected
[    1.088270] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    1.088304] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.09
[    1.088307] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.088309] usb usb4: Product: xHCI Host Controller
[    1.088311] usb usb4: Manufacturer: Linux 6.9.1-zen1-2-zen xhci-hcd
[    1.088313] usb usb4: SerialNumber: 0000:04:00.4
[    1.088430] hub 4-0:1.0: USB hub found
[    1.088438] hub 4-0:1.0: 2 ports detected
[    1.090200] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.090255] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.095905] nvme 0000:01:00.0: platform quirk: setting simple suspend
[    1.095972] nvme nvme0: pci function 0000:01:00.0
[    1.118049] nvme nvme0: 12/0/0 default/read/poll queues
[    1.125057]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11
[    1.137843] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input2
[    1.152935] raid6: skipped pq benchmark and selected avx2x4
[    1.152938] raid6: using avx2x2 recovery algorithm
[    1.154946] xor: automatically using best checksumming function   avx   =
   =20
[    1.242124] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    1.312621] usb 1-4: new low-speed USB device number 2 using xhci_hcd
[    1.320627] usb 3-1: new full-speed USB device number 2 using xhci_hcd
[    1.458868] usb 1-4: New USB device found, idVendor=3D046d, idProduct=3D=
c040, bcdDevice=3D24.30
[    1.458874] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.458876] usb 1-4: Product: USB-PS/2 Optical Mouse
[    1.458878] usb 1-4: Manufacturer: Logitech
[    1.469435] usb 3-1: New USB device found, idVendor=3D0bda, idProduct=3D=
c829, bcdDevice=3D 1.10
[    1.469448] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    1.469454] usb 3-1: Product: Bluetooth Radio=20
[    1.469459] usb 3-1: Manufacturer: Realtek=20
[    1.469462] usb 3-1: SerialNumber: 00e04c000001
[    1.486650] usbcore: registered new interface driver usbhid
[    1.486656] usbhid: USB HID core driver
[    1.489616] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:0=
0/0000:00:08.1/0000:04:00.3/usb1/1-4/1-4:1.0/0003:046D:C040.0001/input/inpu=
t4
[    1.489679] hid-generic 0003:046D:C040.0001: input,hidraw0: USB HID v1.1=
0 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:04:00.3-4/input0
[    1.578821] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  p=
ost: no)
[    1.579076] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/device:0f/LNXVIDEO:00/input/input5
[    1.594402] usb 3-4: new high-speed USB device number 3 using xhci_hcd
[    1.598399] tsc: Refined TSC clocksource calibration: 2295.687 MHz
[    1.598406] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x211=
74ac26ec, max_idle_ns: 440795209452 ns
[    1.598432] clocksource: Switched to clocksource tsc
[    1.732698] usb 3-4: New USB device found, idVendor=3D0c45, idProduct=3D=
6739, bcdDevice=3D14.11
[    1.732704] usb 3-4: New USB device strings: Mfr=3D2, Product=3D1, Seria=
lNumber=3D0
[    1.732707] usb 3-4: Product: Integrated_Webcam_FHD
[    1.732708] usb 3-4: Manufacturer: CN07W56Y8LG0027EC677A00
[    2.983658] [drm] amdgpu kernel modesetting enabled.
[    2.987495] amdgpu: Virtual CRAT table created for CPU
[    2.987507] amdgpu: Topology: Add CPU node
[    2.987607] amdgpu 0000:04:00.0: enabling device (0006 -> 0007)
[    2.987653] [drm] initializing kernel modesetting (RENOIR 0x1002:0x15E7 =
0x1028:0x0B7D 0xC2).
[    2.992073] [drm] register mmio base: 0xD0400000
[    2.992074] [drm] register mmio size: 524288
[    2.995118] [drm] add ip block number 0 <soc15_common>
[    2.995120] [drm] add ip block number 1 <gmc_v9_0>
[    2.995121] [drm] add ip block number 2 <vega10_ih>
[    2.995122] [drm] add ip block number 3 <psp>
[    2.995124] [drm] add ip block number 4 <smu>
[    2.995125] [drm] add ip block number 5 <dm>
[    2.995126] [drm] add ip block number 6 <gfx_v9_0>
[    2.995127] [drm] add ip block number 7 <sdma_v4_0>
[    2.995129] [drm] add ip block number 8 <vcn_v2_0>
[    2.995130] [drm] add ip block number 9 <jpeg_v2_0>
[    2.995144] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from VFCT
[    2.995146] amdgpu: ATOM BIOS: 113-BARCELO-002
[    2.996892] [drm] VCN decode is enabled in VM mode
[    2.996893] [drm] VCN encode is enabled in VM mode
[    2.997831] [drm] JPEG decode is enabled in VM mode
[    3.020962] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
[    3.020967] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re enabled
[    3.020971] amdgpu 0000:04:00.0: amdgpu: MODE2 reset
[    3.022164] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[    3.022169] amdgpu 0000:04:00.0: amdgpu: VRAM: 512M 0x000000F400000000 -=
 0x000000F41FFFFFFF (512M used)
[    3.022171] amdgpu 0000:04:00.0: amdgpu: GART: 1024M 0x0000000000000000 =
- 0x000000003FFFFFFF
[    3.022177] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
[    3.022178] [drm] RAM width 128bits DDR4
[    3.022304] [drm] amdgpu: 512M of VRAM memory ready
[    3.022306] [drm] amdgpu: 7667M of GTT memory ready.
[    3.022318] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    3.022454] [drm] PCIE GART of 1024M enabled.
[    3.022456] [drm] PTB located at 0x000000F41FC00000
[    3.022918] [drm] Loading DMUB firmware via PSP: version=3D0x01010028
[    3.023326] [drm] Found VCN firmware Version ENC: 1.21 DEC: 7 VEP: 0 Rev=
ision: 3
[    3.023332] amdgpu 0000:04:00.0: amdgpu: Will use PSP to load VCN firmwa=
re
[    3.747701] amdgpu 0000:04:00.0: amdgpu: reserve 0x400000 from 0xf41f800=
000 for PSP TMR
[    3.837016] amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    3.848223] amdgpu 0000:04:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available
[    3.848226] amdgpu 0000:04:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[    3.848627] amdgpu 0000:04:00.0: amdgpu: SMU is initialized successfully!
[    3.849008] [drm] Display Core v3.2.273 initialized on DCN 2.1
[    3.849011] [drm] DP-HDMI FRL PCON supported
[    3.849570] [drm] DMUB hardware initialized: version=3D0x01010028
[    4.019735] [drm] kiq ring mec 2 pipe 1 q 0
[    4.022865] [drm] VCN decode and encode initialized successfully(under D=
PG Mode).
[    4.022884] [drm] JPEG decode initialized successfully.
[    4.046225] amdgpu: HMM registered 512MB device memory
[    4.047909] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    4.047920] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    4.048031] amdgpu: Virtual CRAT table created for GPU
[    4.048101] amdgpu: Topology: Add dGPU node [0x15e7:0x1002]
[    4.048103] kfd kfd: amdgpu: added device 1002:15e7
[    4.048112] amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 8,=
 active_cu_number 7
[    4.048115] amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0
[    4.048117] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 1 on hub 0
[    4.048119] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 4 on hub 0
[    4.048120] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 5 on hub 0
[    4.048121] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 6 on hub 0
[    4.048122] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 7 on hub 0
[    4.048124] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 8 on hub 0
[    4.048125] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 9 on hub 0
[    4.048126] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 10 on hub 0
[    4.048127] amdgpu 0000:04:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 11 on hub 0
[    4.048129] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 8
[    4.048130] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 =
on hub 8
[    4.048131] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4=
 on hub 8
[    4.048133] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5=
 on hub 8
[    4.048134] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6=
 on hub 8
[    4.053722] [drm] Initialized amdgpu 3.57.0 20150101 for 0000:04:00.0 on=
 minor 1
[    4.060520] fbcon: amdgpudrmfb (fb0) is primary device
[    4.060524] fbcon: Deferring console take-over
[    4.060527] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[    4.109492] BTRFS: device fsid 306acb61-a48c-46f5-a81d-f74851a36849 devi=
d 1 transid 54490 /dev/nvme0n1p10 (259:10) scanned by mount (312)
[    4.109741] BTRFS info (device nvme0n1p10): first mount of filesystem 30=
6acb61-a48c-46f5-a81d-f74851a36849
[    4.109751] BTRFS info (device nvme0n1p10): using crc32c (crc32c-intel) =
checksum algorithm
[    4.109755] BTRFS info (device nvme0n1p10): using free-space-tree
[    4.203630] systemd[1]: systemd 255.6-2-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZST=
D +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    4.203637] systemd[1]: Detected architecture x86-64.
[    4.204743] systemd[1]: Hostname set to <DELL>.
[    4.562524] systemd[1]: bpf-lsm: LSM BPF program attached
[    4.649369] systemd[1]: Queued start job for default target Graphical In=
terface.
[    4.663633] systemd[1]: Created slice Slice /system/dirmngr.
[    4.664066] systemd[1]: Created slice Slice /system/getty.
[    4.664302] systemd[1]: Created slice Slice /system/gpg-agent.
[    4.664548] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    4.664790] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    4.665030] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    4.665261] systemd[1]: Created slice Slice /system/keyboxd.
[    4.665549] systemd[1]: Created slice Slice /system/modprobe.
[    4.665792] systemd[1]: Created slice Slice /system/systemd-fsck.
[    4.665981] systemd[1]: Created slice User and Session Slice.
[    4.666031] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    4.666067] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    4.666195] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    4.666211] systemd[1]: Expecting device /dev/disk/by-uuid/306acb61-a48c=
-46f5-a81d-f74851a36849...
[    4.666216] systemd[1]: Expecting device /dev/disk/by-uuid/8407db45-f134=
-4fae-a376-48d0f4987f51...
[    4.666220] systemd[1]: Expecting device /dev/disk/by-uuid/C2A6-AADD...
[    4.666227] systemd[1]: Reached target Local Encrypted Volumes.
[    4.666237] systemd[1]: Reached target Local Integrity Protected Volumes.
[    4.666248] systemd[1]: Reached target Path Units.
[    4.666257] systemd[1]: Reached target Remote File Systems.
[    4.666263] systemd[1]: Reached target Slice Units.
[    4.666278] systemd[1]: Reached target Local Verity Protected Volumes.
[    4.666329] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    4.667060] systemd[1]: Listening on Process Core Dump Socket.
[    4.667377] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.667472] systemd[1]: Listening on Journal Socket.
[    4.667503] systemd[1]: TPM2 PCR Extension (Varlink) was skipped because=
 of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    4.667755] systemd[1]: Listening on udev Control Socket.
[    4.667823] systemd[1]: Listening on udev Kernel Socket.
[    4.667893] systemd[1]: Listening on User Database Manager Socket.
[    4.669201] systemd[1]: Mounting Huge Pages File System...
[    4.669691] systemd[1]: Mounting POSIX Message Queue File System...
[    4.670170] systemd[1]: Mounting Kernel Debug File System...
[    4.670686] systemd[1]: Mounting Kernel Trace File System...
[    4.671350] systemd[1]: Starting Create List of Static Device Nodes...
[    4.671914] systemd[1]: Starting Load Kernel Module configfs...
[    4.672572] systemd[1]: Starting Load Kernel Module dm_mod...
[    4.673490] systemd[1]: Starting Load Kernel Module drm...
[    4.674273] systemd[1]: Starting Load Kernel Module fuse...
[    4.674957] systemd[1]: Starting Load Kernel Module loop...
[    4.676787] systemd[1]: Starting Journal Service...
[    4.678037] systemd[1]: Starting Load Kernel Modules...
[    4.678052] systemd[1]: TPM2 PCR Machine ID Measurement was skipped beca=
use of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    4.678801] systemd[1]: Starting Remount Root and Kernel File Systems...
[    4.678846] systemd[1]: TPM2 SRK Setup (Early) was skipped because of an=
 unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    4.679563] systemd[1]: Starting Coldplug All udev Devices...
[    4.680809] systemd[1]: Mounted Huge Pages File System.
[    4.680904] systemd[1]: Mounted POSIX Message Queue File System.
[    4.680984] systemd[1]: Mounted Kernel Debug File System.
[    4.681067] systemd[1]: Mounted Kernel Trace File System.
[    4.681257] systemd[1]: Finished Create List of Static Device Nodes.
[    4.681542] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    4.681668] systemd[1]: Finished Load Kernel Module configfs.
[    4.681923] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    4.682061] systemd[1]: Finished Load Kernel Module drm.
[    4.682277] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    4.682427] systemd[1]: Finished Load Kernel Module fuse.
[    4.683202] systemd[1]: Mounting FUSE Control File System...
[    4.684054] systemd[1]: Mounting Kernel Configuration File System...
[    4.684632] loop: module loaded
[    4.684887] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    4.685192] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    4.685367] systemd[1]: Finished Load Kernel Module loop.
[    4.688335] device-mapper: uevent: version 1.0.3
[    4.688446] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    4.689045] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    4.689080] Asymmetric key parser 'pkcs8' registered
[    4.689177] systemd[1]: Finished Load Kernel Module dm_mod.
[    4.722893] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    4.723146] systemd[1]: Finished Load Kernel Modules.
[    4.726607] systemd-journald[368]: Collecting audit messages is disabled.
[    4.742557] systemd[1]: Starting Apply Kernel Variables...
[    4.743083] systemd[1]: Mounted FUSE Control File System.
[    4.743217] systemd[1]: Mounted Kernel Configuration File System.
[    4.744709] systemd[1]: Starting User Database Manager...
[    4.748143] systemd[1]: Finished Apply Kernel Variables.
[    4.764178] systemd[1]: Started Journal Service.
[    4.767015] BTRFS info (device nvme0n1p10 state M): use lzo compression,=
 level 0
[    4.777710] systemd-journald[368]: Received client request to flush runt=
ime journal.
[    4.800483] systemd-journald[368]: /var/log/journal/7bfb25584b964a788001=
ba83cd062386/system.journal: Journal file uses a different sequence number =
ID, rotating.
[    4.800488] systemd-journald[368]: Rotating system journal.
[    5.036730] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, re=
vision 0
[    5.036739] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port=
 selection
[    5.036873] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at=
 0xb20
[    5.044486] ACPI: battery: new extension: Dell DDV Battery Extension
[    5.044523] input: DELL Wireless hotkeys as /devices/virtual/input/input6
[    5.048663] ccp 0000:04:00.2: enabling device (0000 -> 0002)
[    5.055629] ccp 0000:04:00.2: ccp: unable to access the device: you migh=
t be running a broken BIOS.
[    5.055722] input: PC Speaker as /devices/platform/pcspkr/input/input7
[    5.057314] ccp 0000:04:00.2: tee enabled
[    5.057401] ccp 0000:04:00.2: psp enabled
[    5.076647] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840=
 ms ovfl timer
[    5.076652] RAPL PMU: hw unit of domain package 2^-16 Joules
[    5.116241] cryptd: max_cpu_qlen set to 1000
[    5.117185] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    5.117306] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    5.117420] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    5.132462] Adding 20971516k swap on /dev/nvme0n1p11.  Priority:-2 exten=
ts:1 across:20971516k SS
[    5.167162] input: DELL0B7D:00 06CB:CE26 Mouse as /devices/platform/AMDI=
0010:03/i2c-0/i2c-DELL0B7D:00/0018:06CB:CE26.0002/input/input9
[    5.167230] input: DELL0B7D:00 06CB:CE26 Touchpad as /devices/platform/A=
MDI0010:03/i2c-0/i2c-DELL0B7D:00/0018:06CB:CE26.0002/input/input10
[    5.167297] hid-generic 0018:06CB:CE26.0002: input,hidraw1: I2C HID v1.0=
0 Mouse [DELL0B7D:00 06CB:CE26] on i2c-DELL0B7D:00
[    5.172239] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    5.172322] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO ad=
dress
[    5.181441] sp5100-tco sp5100-tco: initialized. heartbeat=3D60 sec (nowa=
yout=3D0)
[    5.194078] AVX2 version of gcm_enc/dec engaged.
[    5.194105] snd_rn_pci_acp3x 0000:04:00.5: enabling device (0000 -> 0002)
[    5.194148] AES CTR mode by8 optimization enabled
[    5.197240] input: Dell WMI hotkeys as /devices/platform/PNP0C14:01/wmi_=
bus/wmi_bus-PNP0C14:01/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input12
[    5.213085] r8169 0000:02:00.0 eth0: RTL8168h/8111h, 04:bf:1b:0e:8a:e9, =
XID 541, IRQ 85
[    5.213093] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    5.215577] r8169 0000:02:00.0 enp2s0: renamed from eth0
[    5.231751] input: DELL0B7D:00 06CB:CE26 Mouse as /devices/platform/AMDI=
0010:03/i2c-0/i2c-DELL0B7D:00/0018:06CB:CE26.0002/input/input13
[    5.231907] input: DELL0B7D:00 06CB:CE26 Touchpad as /devices/platform/A=
MDI0010:03/i2c-0/i2c-DELL0B7D:00/0018:06CB:CE26.0002/input/input14
[    5.232000] hid-multitouch 0018:06CB:CE26.0002: input,hidraw1: I2C HID v=
1.00 Mouse [DELL0B7D:00 06CB:CE26] on i2c-DELL0B7D:00
[    5.273656] mousedev: PS/2 mouse device common for all mice
[    5.295576] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
[    5.295680] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio clie=
nt
[    5.295739] snd_hda_intel 0000:04:00.6: enabling device (0000 -> 0002)
[    5.308451] rtw_8821ce 0000:03:00.0: enabling device (0000 -> 0003)
[    5.312938] rtw_8821ce 0000:03:00.0: Firmware version 24.11.0, H2C versi=
on 12
[    5.346739] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[    5.349575] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:08.1/0000:04:00.1/sound/card0/input16
[    5.356341] kvm_amd: TSC scaling supported
[    5.356346] kvm_amd: Nested Virtualization enabled
[    5.356347] kvm_amd: Nested Paging enabled
[    5.356358] kvm_amd: Virtual VMLOAD VMSAVE supported
[    5.356359] kvm_amd: Virtual GIF supported
[    5.356360] kvm_amd: LBR virtualization supported
[    5.362713] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3254: l=
ine_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    5.362718] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    5.362720] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    5.362722] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0
[    5.362724] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    5.362725] snd_hda_codec_realtek hdaudioC1D0:      Headset Mic=3D0x19
[    5.362727] snd_hda_codec_realtek hdaudioC1D0:      Headphone Mic=3D0x1b
[    5.398254] intel_rapl_common: Found RAPL domain package
[    5.398258] intel_rapl_common: Found RAPL domain core
[    5.398510] AMD Address Translation Library initialized
[    6.035202] input: HD-Audio Generic Headphone Mic as /devices/pci0000:00=
/0000:00:08.1/0000:04:00.6/sound/card1/input17
[    6.136452] mc: Linux media interface: v0.10
[    6.164904] Bluetooth: Core ver 2.22
[    6.164930] NET: Registered PF_BLUETOOTH protocol family
[    6.164932] Bluetooth: HCI device and connection manager initialized
[    6.164936] Bluetooth: HCI socket layer initialized
[    6.164938] Bluetooth: L2CAP socket layer initialized
[    6.164942] Bluetooth: SCO socket layer initialized
[    6.167405] videodev: Linux video capture interface: v2.00
[    6.279883] usb 3-4: Found UVC 1.00 device Integrated_Webcam_FHD (0c45:6=
739)
[    6.280341] usbcore: registered new interface driver btusb
[    6.292263] usbcore: registered new interface driver uvcvideo
[    6.503226] Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c =
lmp_ver=3D08 lmp_subver=3D8821
[    6.505223] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[    6.505228] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[    6.506846] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[    6.507268] Bluetooth: hci0: RTL: cfg_sz 10, total sz 34926
[    6.582473] NET: Registered PF_ALG protocol family
[    6.584231] 8021q: 802.1Q VLAN Support v1.8
[    6.625400] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
[    6.803506] r8169 0000:02:00.0 enp2s0: Link is Down
[    7.129595] Bluetooth: hci0: RTL: fw version 0x75b8f098
[    7.327538] fbcon: Taking over console
[    7.328410] [drm] DSC precompute is not needed.
[    7.358676] Console: switching to colour frame buffer device 240x67
[    9.020480] wlan0: authenticate with d1:32:e5:a4:ca:11 (local address=3D=
da:10:ac:14:4a:c4)
[    9.042680] wlan0: send auth to d1:32:e5:a4:ca:11 (try 1/3)
[    9.044922] wlan0: authenticated
[    9.044993] wlan0: associating to AP d1:32:e5:a4:ca:11 with corrupt prob=
e response
[    9.045435] wlan0: associate with d1:32:e5:a4:ca:11 (try 1/3)
[    9.051120] wlan0: RX AssocResp from d1:32:e5:a4:ca:11 (capab=3D0x411 st=
atus=3D0 aid=3D1)
[    9.051405] wlan0: associated
[   11.853329] systemd-journald[368]: /var/log/journal/7bfb25584b964a788001=
ba83cd062386/user-1000.journal: Journal file uses a different sequence numb=
er ID, rotating.
[   18.776883] warning: `iwconfig' uses wireless extensions which will stop=
 working for Wi-Fi 7 hardware; use nl80211
[   18.862187] wlan0: deauthenticating from d1:32:e5:a4:ca:11 by local choi=
ce (Reason: 3=3DDEAUTH_LEAVING)
[   21.904646] rtw_8821ce 0000:03:00.0 wlan0: entered promiscuous mode
[   21.904653] rtw_8821ce 0000:03:00.0 wlan0: entered allmulticast mode

--3gxhxmfzxhyezdgf--

--uvegfu5o6t7aays6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZVAq0ACgkQwEfU8yi1
JYXdNhAAnPTDAxJNO6UOTMVruKOQiDuRCUApizctkjMfyZ0PD76dKBEgP0Tg+Lku
4YwG87ZDwipv7k1psVHn1rUskhKlXfy7GW5DvrVOVj2T9VW04OV/8hpdDCX4qfOs
c6GbA1Avsa5S+3CJslZQUW8/wLOW70U72gS+2ZY0dRZ+T17fSOxyq2MxLQRfUEaK
pHOc4mh80TU0WY6yqOmCiuH3xbYgOGattFCdFZ69KEsgKdqKe4Pz0dzEWImvGrYT
jIsjFOnKy7ZM7rkjsOhfxCRE+tW+UA03Ih3mLlqJfOGY9Crdw86qyCjVEjAAFayw
zU6jkvHrYrRC6J9oZ7Mf7anSA2eEsY8Do6BLqkrTMNcKqtzncdUyREIQ5Io3wWOM
zhT1fpYaThTIMcVauoSn+Jvzv9FiW+BUQ+OYH3saQ0XcvQLFfkeuJNlGREGq4oR4
NkaMv4ua7y3V1CygKq4UHUuPX8Zr1pr8s9ADiqSQNZ8PbyitIPIZdhbCbr8n7h+t
rv8BSlp4P79bSMqrl3/qTri2x2dk4Zo0TTdBgf16wiKdyEA0BCE6WVmslGLnZWEK
AD6S5ryWTXpnLLs4MGtgISOGnKGVeq7r+EyhNJy/G1MNsYemfBiVvGD3PkTxeFDz
ST0PK98yKD+3ky7PirdAsa7xA7G8GR+YLSLXfok6cJNZmtYxOKA=
=SbsV
-----END PGP SIGNATURE-----

--uvegfu5o6t7aays6--

