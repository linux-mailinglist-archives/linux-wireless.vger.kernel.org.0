Return-Path: <linux-wireless+bounces-8195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3248D1A60
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 13:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD881F21DB7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6EF16C84A;
	Tue, 28 May 2024 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="fH8Cu6EK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29864C97;
	Tue, 28 May 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897395; cv=none; b=fW/QYOeIbYT0i6qh/w3wqwjIp+CGqz4a5TOzqVEQ9Fj+MOqgIq26lJNoT/GDM2DFf2r71Ui4mdfbaDZJAvrMIOseYrIwb0e0Otnm/pSuxq1X2fc3O7byQWdSvJGe0vVtMpQmpoapYT5zETiV1RCA4r+Ir71aHr1QJ89p4M1xoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897395; c=relaxed/simple;
	bh=UbHA4CGC9ZX2PL/UxdNGxTyoSsIGvsZ5ktFbrf/2IqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npDyKn5T3GrqLSfK1H58Z8WcnLRyEa8LWunFSu0BTgAxvrRZTqv76M0FZfbWptRSOxOzikBW2mu6prmsDFyX8cQlAmRASYxsxwnopkI0mtw6rYIy1jIPlE5qJnArBvb/4CU1LLQGhrMMj0IxK1M1FWmrQM35JBWDuPg5FdRNmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=fH8Cu6EK; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1716897378; x=1717502178; i=christian@heusel.eu;
	bh=jaaDVDg2tVE1xvsLU9DlvFmpC0i4AJizKFOk8iRTSeA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fH8Cu6EK4yq0CmEDB9A2dmEuDv/vsohprCSu7xepxeyC/nnyybmeEhFj6Y9CRkOo
	 kEotnRhYm1ETc+rZIzyUYVrR+MjWmDTnUWZ5DHXo0CfWYksIcrVaX2yaOxvLJ9Mdh
	 wIfLVTtRYbbwYIctrCPXDkonrebYSryYB/CUnFf4RqqbIugtXkU5P1e1gjARSLvES
	 0g2kBG0CE50flfUSUFUHoVu7ELsGCjQk3VvYNmscHH3DDEGTLGjGMLcI7L1JCIxQH
	 cyJOjcD1ASqaRgwz4ezt8riXfAgzlouu3AQImFH0eksyF8fIgTWKqwVRSf26F3Dlc
	 p4PL4UAcgZJgsozHPQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mzhax-1sOeuN3QET-00vjjU; Tue, 28
 May 2024 13:50:47 +0200
Date: Tue, 28 May 2024 13:50:44 +0200
From: Christian Heusel <christian@heusel.eu>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, Savyasaachi Vanga <savyasaachiv@gmail.com>
Subject: Re: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
Message-ID: <5t546ruzo67typmnoxa4rvr5tyupxw5zurp4s6sjn2bn7jcbms@iotqagf5iuhh>
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
 <b3d8a378-346d-4dd8-9af8-1529a4484184@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ccxtag5vfjlljsoq"
Content-Disposition: inline
In-Reply-To: <b3d8a378-346d-4dd8-9af8-1529a4484184@leemhuis.info>
X-Provags-ID: V03:K1:ojnyicP4iqGXyV/vEZmDJ0R13jn6erASwUdObEozI0xo9gweYXp
 qn3gPdLbQlQjhlmNWPBvL2owKZL4Y7RcLpzC2CC5GT1jdJu2hFpDbuw4CnYGfsVTN2EEGy/
 CU7eykCVxhpWUAQSr9TNqDXzOpOfSSMZbdQ276+eez0TOH7PVY3NEL+CZFByn42dWV7np8I
 QUAQTH2nW4bBn2pd4jHWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yvCzaa+UH1g=;o43Lf85Kn2UGOl+RIAS4yDKKm3c
 Q+oMmLqVEPs1qaDYW8xm33i8HvvT0UqQ5KO+AZiZk8uoBTcu+n/WOohxidVW8IToY/QFT7x7O
 N4tOAiwdqil6r/mYsrXdLmUsH7yCEzHt5NJ5oNbg6AtHIeKPQXAuCSZIEBxJXAKnrd2KaWns+
 hC6isZJwxrHHm6W+zsf0qCeRsrPuSbhU7qA2zA05Pb+5ucu946wMI1WOAC+gGtGsfeEyi7IuS
 XbZqwBVffUF3FzaU47XvlZ4jdbWD8meTI82AwwU6hiCPKHszwvrCh0P7sdbhcb7jQxjNOhLGb
 jFZq6Nb7eo9vR66XJOrzSGLLKYbE9DBYxt9sUaIk5hB9yT6THaqzuaJAgy0HeQTdShmuoOyW7
 V6oN4KtjqJdmH62Q8Tlv5bX7sMCGSaR00whNW472bzMpptrtkHLIBjSYNOgka+34SD1F7DFeo
 bUSIgB+AVw+BF9bRfCtkq3n5zXnQ1+ysn20uOeqFL2f/pPvJxwn7GC/JBuHMe+DTyBG1TxOK8
 3Cg5/YS0EXBYsXvzTa4U2o59BQb/Urr7kAa0OeQ0IuayDHr5UlRxZh/ZmfX+IgaIRHecgquBp
 WHHNmXGdzbmSMepkYML+o5OGNZ+oozLjIsmVALGpvVjHRQ1GqneqJPoTrUuytaRscMCWFn8QE
 BCghtGvy84gwbk3ID2b8ZBB1xVF3iCogt+eU8QJoGq4I+Yq2lA89V6pMnbDd7ysUhbQ+k23dE
 tk2LJ9XgTAZLZeC6nqJW9Cp2QX+Ul5aSaJnh7j9g9SP0UM2wadaPew=


--ccxtag5vfjlljsoq
Content-Type: multipart/mixed; boundary="xsk57s3fkcfezwct"
Content-Disposition: inline


--xsk57s3fkcfezwct
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/05/28 07:22AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 28.05.24 00:01, Christian Heusel wrote:
> >=20
> > Savyasaachi reports that scanning for other stations in monitor mode
> > does not work anymore with his RTL8821CE wireless network card for linux
> > kernels after 6.8.9.
>=20
> Thx for the report. A few remarks:
>=20
> Please be more specific in cases like this, as "kernels after 6.8.9" can
> mean "6.8.10+", "6.10-rc", or "6.9.y" (apparently it is the latter).
> Yes, this is nitpicking, which is why I normally would not have said
> anything -- but because you frequently report bugs it's likely in
> everybody's interest to bring this up.
>=20

Thanks for the remarks! I'll try to improve on giving more specific
information for these things in the future!

>
> In a case like this it would also be good if the reporter could give
> latest mainline a try, as (1) a fix might already be in there and (2)
> some developers do not care at all about bugs in stable kernels (and
> they are free to do so!). See
> https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-k=
ernel-bug-reports-are-ignored/
> for details.
>=20

The mainline kernel (6.10rc1) does not work aswell as per Savyasaachi's
tests. I have attached the journal from that run to this email.

> And sorry, there is something else: from the dmesg it looks a lot like
> this report is from a patched vendor kernel that among others seems to
> enable features like "forced interrupt request threading"
> (https://github.com/zen-kernel/zen-kernel/wiki/Detailed-Feature-List).
> Such changes even if small and done carefully can lead to bugs like this
> (yes, that particular feature I mentioned can be enabled through a
> kernel parameter as well, but some developers would consider this to be
> an unsupported configuration). The absolut minimum you should have done
> is to mention that; but normally you never want to use such kernels for
> reporting bugs upstream, as the problem might not be present in the
> upstream code.

Yes that one is my bad, this was just a journal I had still lying around
as it was part of the initial stages of the bugreport. The bisection was
of course done on the mainline tree without any additional patchsets
involved and as I said above the journal from the mainline boot is now
attached.

Cheers,
chris

--xsk57s3fkcfezwct
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-6.10.0-rc1-1-mainline"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.10.0-rc1-1-mainline (linux-mainline@archlinu=
x) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU Binutils) 2.42.0) #1 SMP PREEMPT=
_DYNAMIC Mon, 27 May 2024 00:55:18 +0000
[    0.000000] Command line: initrd=3D\amd-ucode.img initrd=3D\initramfs-li=
nux-mainline.img root=3DUUID=3D306acb61-a48c-46f5-a81d-f74851a36849 rootfla=
gs=3Dsubvol=3D@root rw resume=3DUUID=3D8407db45-f134-4fae-a376-48d0f4987f51
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
ESRT=3D0xb9474d18 RNG=3D0xcdfaff18 INITRD=3D0xac9adf98 TPMEventLog=3D0xac9a=
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
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2295.711 MHz processor
[    0.000352] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000354] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000361] last_pfn =3D 0x40e300 max_arch_pfn =3D 0x400000000
[    0.000368] MTRR map: 8 entries (4 fixed + 4 variable; max 21), built fr=
om 9 variable MTRRs
[    0.000369] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000578] last_pfn =3D 0xce000 max_arch_pfn =3D 0x400000000
[    0.004298] esrt: Reserving ESRT space from 0x00000000b9474d18 to 0x0000=
0000b9474d78.
[    0.004304] e820: update [mem 0xb9474000-0xb9474fff] usable =3D=3D> rese=
rved
[    0.004318] Using GB pages for direct mapping
[    0.004722] Secure boot disabled
[    0.004723] RAMDISK: [mem 0xa2ec7000-0xa4faefff]
[    0.004869] ACPI: Early table checksum verification disabled
[    0.004872] ACPI: RSDP 0x00000000CDFFE014 000024 (v02 DELL  )
[    0.004876] ACPI: XSDT 0x00000000CDFC7188 00014C (v01 DELL   CL09     00=
000002      01000013)
[    0.004881] ACPI: FACP 0x00000000CDFE8000 00010C (v05 DELL   CL09     00=
000002 ASL  00040000)
[    0.004885] ACPI: DSDT 0x00000000CDFD9000 00A3F9 (v01 DELL   CL09     00=
000002 ASL  00040000)
[    0.004887] ACPI: FACS 0x00000000CDECD000 000040
[    0.004888] ACPI: UEFI 0x00000000CDF7E000 000236 (v01 DELL   CL09     00=
000001 ASL  00040000)
[    0.004890] ACPI: SSDT 0x00000000CDFFC000 000106 (v02 DELL   CL09     00=
003000 ACPI 00040000)
[    0.004892] ACPI: SSDT 0x00000000CDFFB000 00076F (v02 DELL   CL09     00=
003000 ACPI 00040000)
[    0.004894] ACPI: SSDT 0x00000000CDFFA000 000033 (v02 DELL   CL09     00=
003000 ACPI 00040000)
[    0.004896] ACPI: SSDT 0x00000000CDFF2000 0072B0 (v02 DELL   CL09     00=
000002 ACPI 00040000)
[    0.004898] ACPI: SSDT 0x00000000CDFEE000 003A21 (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004900] ACPI: SSDT 0x00000000CDFED000 00077B (v02 DELL   CL09     00=
001000 ACPI 00040000)
[    0.004901] ACPI: TPM2 0x00000000CDFEC000 00004C (v04 DELL   CL09     00=
000002 ASL  00040000)
[    0.004903] ACPI: MSDM 0x00000000CDFEB000 000055 (v03 DELL   CL09     00=
000001 ASL  00040000)
[    0.004905] ACPI: ASF! 0x00000000CDFEA000 0000A5 (v32 DELL   CL09     00=
000002 ASL  00040000)
[    0.004907] ACPI: BOOT 0x00000000CDFE9000 000028 (v01 DELL   CL09     00=
000002 ASL  00040000)
[    0.004909] ACPI: HPET 0x00000000CDFE7000 000038 (v01 DELL   CL09     00=
000002 ASL  00040000)
[    0.004911] ACPI: APIC 0x00000000CDFE6000 000138 (v03 DELL   CL09     00=
000002 ASL  00040000)
[    0.004912] ACPI: MCFG 0x00000000CDFE5000 00003C (v01 DELL   CL09     00=
000002 ASL  00040000)
[    0.004914] ACPI: SLIC 0x00000000CDFE4000 000176 (v01 DELL   CL09     00=
000002 ASL  00040000)
[    0.004916] ACPI: SSDT 0x00000000CDFD8000 000080 (v01 DELL   CL09     00=
000002 ACPI 00040000)
[    0.004918] ACPI: WSMT 0x00000000CDFD7000 000028 (v01 DELL   CL09     00=
000001 ASL  00040000)
[    0.004920] ACPI: VFCT 0x00000000CDFC9000 00D884 (v01 DELL   CL09     00=
000001 ASL  00040000)
[    0.004922] ACPI: SSDT 0x00000000CDFC8000 0000F8 (v01 DELL   CL09     00=
001000 ACPI 00040000)
[    0.004923] ACPI: SSDT 0x00000000CDFC3000 003E88 (v02 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004925] ACPI: CRAT 0x00000000CDFFD000 000B68 (v01 DELL   CL09     00=
000001 ASL  00040000)
[    0.004927] ACPI: CDIT 0x00000000CDFC2000 000029 (v01 DELL   CL09     00=
000001 ASL  00040000)
[    0.004929] ACPI: SSDT 0x00000000CDFC1000 000139 (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004931] ACPI: SSDT 0x00000000CDFC0000 000D53 (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004933] ACPI: SSDT 0x00000000CDFBE000 0010C5 (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004934] ACPI: SSDT 0x00000000CDFBD000 00028D (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004936] ACPI: SSDT 0x00000000CDFB9000 00362F (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004938] ACPI: FPDT 0x00000000CDFB8000 000044 (v01 DELL   CL09     00=
000002 ASL  00040000)
[    0.004940] ACPI: BGRT 0x00000000CDFB7000 000038 (v01 DELL   CL09     00=
000001 ASL  00040000)
[    0.004942] ACPI: IVRS 0x00000000CDFB6000 0001A4 (v02 DELL   CL09     00=
000001 ASL  00040000)
[    0.004943] ACPI: SSDT 0x00000000CDFB5000 000042 (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004945] ACPI: SSDT 0x00000000CDFB4000 00020A (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004947] ACPI: SSDT 0x00000000CDFB3000 0006DA (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004949] ACPI: SSDT 0x00000000CDFB2000 000319 (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004951] ACPI: SSDT 0x00000000CDFB1000 00007D (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004953] ACPI: SSDT 0x00000000CDFB0000 0004DB (v01 DELL   CL09     00=
000001 ACPI 00040000)
[    0.004954] ACPI: Reserving FACP table memory at [mem 0xcdfe8000-0xcdfe8=
10b]
[    0.004955] ACPI: Reserving DSDT table memory at [mem 0xcdfd9000-0xcdfe3=
3f8]
[    0.004956] ACPI: Reserving FACS table memory at [mem 0xcdecd000-0xcdecd=
03f]
[    0.004956] ACPI: Reserving UEFI table memory at [mem 0xcdf7e000-0xcdf7e=
235]
[    0.004957] ACPI: Reserving SSDT table memory at [mem 0xcdffc000-0xcdffc=
105]
[    0.004958] ACPI: Reserving SSDT table memory at [mem 0xcdffb000-0xcdffb=
76e]
[    0.004958] ACPI: Reserving SSDT table memory at [mem 0xcdffa000-0xcdffa=
032]
[    0.004959] ACPI: Reserving SSDT table memory at [mem 0xcdff2000-0xcdff9=
2af]
[    0.004959] ACPI: Reserving SSDT table memory at [mem 0xcdfee000-0xcdff1=
a20]
[    0.004960] ACPI: Reserving SSDT table memory at [mem 0xcdfed000-0xcdfed=
77a]
[    0.004961] ACPI: Reserving TPM2 table memory at [mem 0xcdfec000-0xcdfec=
04b]
[    0.004961] ACPI: Reserving MSDM table memory at [mem 0xcdfeb000-0xcdfeb=
054]
[    0.004962] ACPI: Reserving ASF! table memory at [mem 0xcdfea000-0xcdfea=
0a4]
[    0.004962] ACPI: Reserving BOOT table memory at [mem 0xcdfe9000-0xcdfe9=
027]
[    0.004963] ACPI: Reserving HPET table memory at [mem 0xcdfe7000-0xcdfe7=
037]
[    0.004964] ACPI: Reserving APIC table memory at [mem 0xcdfe6000-0xcdfe6=
137]
[    0.004964] ACPI: Reserving MCFG table memory at [mem 0xcdfe5000-0xcdfe5=
03b]
[    0.004965] ACPI: Reserving SLIC table memory at [mem 0xcdfe4000-0xcdfe4=
175]
[    0.004966] ACPI: Reserving SSDT table memory at [mem 0xcdfd8000-0xcdfd8=
07f]
[    0.004966] ACPI: Reserving WSMT table memory at [mem 0xcdfd7000-0xcdfd7=
027]
[    0.004967] ACPI: Reserving VFCT table memory at [mem 0xcdfc9000-0xcdfd6=
883]
[    0.004967] ACPI: Reserving SSDT table memory at [mem 0xcdfc8000-0xcdfc8=
0f7]
[    0.004968] ACPI: Reserving SSDT table memory at [mem 0xcdfc3000-0xcdfc6=
e87]
[    0.004969] ACPI: Reserving CRAT table memory at [mem 0xcdffd000-0xcdffd=
b67]
[    0.004969] ACPI: Reserving CDIT table memory at [mem 0xcdfc2000-0xcdfc2=
028]
[    0.004970] ACPI: Reserving SSDT table memory at [mem 0xcdfc1000-0xcdfc1=
138]
[    0.004970] ACPI: Reserving SSDT table memory at [mem 0xcdfc0000-0xcdfc0=
d52]
[    0.004971] ACPI: Reserving SSDT table memory at [mem 0xcdfbe000-0xcdfbf=
0c4]
[    0.004972] ACPI: Reserving SSDT table memory at [mem 0xcdfbd000-0xcdfbd=
28c]
[    0.004972] ACPI: Reserving SSDT table memory at [mem 0xcdfb9000-0xcdfbc=
62e]
[    0.004973] ACPI: Reserving FPDT table memory at [mem 0xcdfb8000-0xcdfb8=
043]
[    0.004974] ACPI: Reserving BGRT table memory at [mem 0xcdfb7000-0xcdfb7=
037]
[    0.004974] ACPI: Reserving IVRS table memory at [mem 0xcdfb6000-0xcdfb6=
1a3]
[    0.004975] ACPI: Reserving SSDT table memory at [mem 0xcdfb5000-0xcdfb5=
041]
[    0.004975] ACPI: Reserving SSDT table memory at [mem 0xcdfb4000-0xcdfb4=
209]
[    0.004976] ACPI: Reserving SSDT table memory at [mem 0xcdfb3000-0xcdfb3=
6d9]
[    0.004977] ACPI: Reserving SSDT table memory at [mem 0xcdfb2000-0xcdfb2=
318]
[    0.004977] ACPI: Reserving SSDT table memory at [mem 0xcdfb1000-0xcdfb1=
07c]
[    0.004978] ACPI: Reserving SSDT table memory at [mem 0xcdfb0000-0xcdfb0=
4da]
[    0.005033] No NUMA configuration found
[    0.005034] Faking a node at [mem 0x0000000000000000-0x000000040e2fffff]
[    0.005037] NODE_DATA(0) allocated [mem 0x40e2fb000-0x40e2fffff]
[    0.005063] Zone ranges:
[    0.005063]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005065]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005066]   Normal   [mem 0x0000000100000000-0x000000040e2fffff]
[    0.005067]   Device   empty
[    0.005067] Movable zone start for each node
[    0.005068] Early memory node ranges
[    0.005068]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.005069]   node   0: [mem 0x0000000000100000-0x00000000099fffff]
[    0.005070]   node   0: [mem 0x0000000009e00000-0x0000000009efffff]
[    0.005071]   node   0: [mem 0x0000000009f0f000-0x00000000ab798fff]
[    0.005072]   node   0: [mem 0x00000000ac999000-0x00000000c9baefff]
[    0.005072]   node   0: [mem 0x00000000cdfff000-0x00000000cdffffff]
[    0.005073]   node   0: [mem 0x0000000100000000-0x000000040e2fffff]
[    0.005075] Initmem setup node 0 [mem 0x0000000000001000-0x000000040e2ff=
fff]
[    0.005079] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.005100] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.005287] On node 0, zone DMA32: 1024 pages in unavailable ranges
[    0.009377] On node 0, zone DMA32: 15 pages in unavailable ranges
[    0.010223] On node 0, zone DMA32: 4608 pages in unavailable ranges
[    0.010382] On node 0, zone DMA32: 17488 pages in unavailable ranges
[    0.031783] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.031856] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.032264] ACPI: PM-Timer IO Port: 0x408
[    0.032271] CPU topo: Ignoring hot-pluggable APIC ID 0 in present packag=
e.
[    0.032273] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.032275] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.032275] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.032276] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.032276] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.032277] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.032278] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.032278] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.032279] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.032279] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.032280] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.032280] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.032281] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.032281] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.032282] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.032283] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.032295] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0=
-23
[    0.032300] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 2=
4-55
[    0.032302] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.032304] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.032307] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.032308] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.032316] e820: update [mem 0xb68c0000-0xb6917fff] usable =3D=3D> rese=
rved
[    0.032332] CPU topo: Max. logical packages:   1
[    0.032333] CPU topo: Max. logical dies:       1
[    0.032333] CPU topo: Max. dies per package:   1
[    0.032337] CPU topo: Max. threads per core:   2
[    0.032338] CPU topo: Num. cores per package:     6
[    0.032338] CPU topo: Num. threads per package:  12
[    0.032339] CPU topo: Allowing 12 present CPUs plus 0 hotplug CPUs
[    0.032339] CPU topo: Rejected CPUs 4
[    0.032361] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.032363] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000bffff]
[    0.032364] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0=
x000fffff]
[    0.032365] PM: hibernation: Registered nosave memory: [mem 0x09a00000-0=
x09dfffff]
[    0.032366] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0=
x09f0efff]
[    0.032368] PM: hibernation: Registered nosave memory: [mem 0xa9011000-0=
xa9011fff]
[    0.032369] PM: hibernation: Registered nosave memory: [mem 0xa901e000-0=
xa901efff]
[    0.032371] PM: hibernation: Registered nosave memory: [mem 0xab799000-0=
xac998fff]
[    0.032372] PM: hibernation: Registered nosave memory: [mem 0xb68c0000-0=
xb6917fff]
[    0.032373] PM: hibernation: Registered nosave memory: [mem 0xb9474000-0=
xb9474fff]
[    0.032375] PM: hibernation: Registered nosave memory: [mem 0xc9baf000-0=
xcbf7efff]
[    0.032375] PM: hibernation: Registered nosave memory: [mem 0xcbf7f000-0=
xcdf7efff]
[    0.032376] PM: hibernation: Registered nosave memory: [mem 0xcdf7f000-0=
xcdffefff]
[    0.032377] PM: hibernation: Registered nosave memory: [mem 0xce000000-0=
xcfffffff]
[    0.032378] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0=
xfebfffff]
[    0.032378] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec01fff]
[    0.032379] PM: hibernation: Registered nosave memory: [mem 0xfec02000-0=
xfec0ffff]
[    0.032379] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0=
xfec10fff]
[    0.032380] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0=
xfec1ffff]
[    0.032381] PM: hibernation: Registered nosave memory: [mem 0xfec20000-0=
xfec20fff]
[    0.032381] PM: hibernation: Registered nosave memory: [mem 0xfec21000-0=
xfed7ffff]
[    0.032382] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0=
xfed81fff]
[    0.032382] PM: hibernation: Registered nosave memory: [mem 0xfed82000-0=
xfedfffff]
[    0.032383] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.032383] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.032385] [mem 0xd0000000-0xfebfffff] available for PCI devices
[    0.032386] Booting paravirtualized kernel on bare hardware
[    0.032389] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.036688] setup_percpu: NR_CPUS:320 nr_cpumask_bits:12 nr_cpu_ids:12 n=
r_node_ids:1
[    0.037355] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.037361] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=3D1*2097152
[    0.037363] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07=20
[    0.037367] pcpu-alloc: [0] 08 09 10 11=20
[    0.037384] Kernel command line: initrd=3D\amd-ucode.img initrd=3D\initr=
amfs-linux-mainline.img root=3DUUID=3D306acb61-a48c-46f5-a81d-f74851a36849 =
rootflags=3Dsubvol=3D@root rw resume=3DUUID=3D8407db45-f134-4fae-a376-48d0f=
4987f51
[    0.038846] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.039569] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.039645] Fallback order for Node 0: 0=20
[    0.039648] Built 1 zonelists, mobility grouping on.  Total pages: 40243=
83
[    0.039649] Policy zone: Normal
[    0.039867] mem auto-init: stack:all(zero), heap alloc:on, heap free:off=
, mlocked free:off
[    0.039913] software IO TLB: area num 16.
[    0.079967] Memory: 15567560K/16097532K available (18432K kernel code, 2=
174K rwdata, 13304K rodata, 3408K init, 3656K bss, 529712K reserved, 0K cma=
-reserved)
[    0.080131] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D12, =
Nodes=3D1
[    0.080175] ftrace: allocating 49561 entries in 194 pages
[    0.089624] ftrace: allocated 194 pages with 3 groups
[    0.089693] Dynamic Preempt: full
[    0.089742] rcu: Preemptible hierarchical RCU implementation.
[    0.089743] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D12.
[    0.089744] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.089745] 	Trampoline variant of Tasks RCU enabled.
[    0.089745] 	Rude variant of Tasks RCU enabled.
[    0.089746] 	Tracing variant of Tasks RCU enabled.
[    0.089746] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.089747] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D12
[    0.089755] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1.
[    0.089757] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1.
[    0.089759] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb=
_adjust=3D1.
[    0.092933] NR_IRQS: 20736, nr_irqs: 1064, preallocated irqs: 16
[    0.093124] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.093230] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.093256] Console: colour dummy device 80x25
[    0.093258] printk: legacy console [tty0] enabled
[    0.093300] ACPI: Core revision 20240322
[    0.093506] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.093523] APIC: Switch to symmetric I/O mode setup
[    0.094485] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:160
[    0.094487] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:160
[    0.094488] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:160
[    0.094489] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:160
[    0.094490] AMD-Vi: Using global IVHD EFR:0x206d73ef22254ade, EFR2:0x0
[    0.094783] APIC: Switched APIC routing to: physical flat
[    0.095525] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.110196] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2117617bc06, max_idle_ns: 440795287603 ns
[    0.110201] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4593.73 BogoMIPS (lpj=3D7652370)
[    0.110216] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.110251] LVT offset 1 assigned for vector 0xf9
[    0.110361] LVT offset 2 assigned for vector 0xf4
[    0.110387] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.110388] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.110391] process: using mwait in idle threads
[    0.110392] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.110394] Spectre V2 : Mitigation: Retpolines
[    0.110395] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.110396] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.110397] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    0.110398] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.110399] Spectre V2 : User space: Mitigation: STIBP always-on protect=
ion
[    0.110400] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.110401] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.110406] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.110407] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.110408] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.110408] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.110409] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User =
registers'
[    0.110410] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.110411] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.110411] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.110412] x86/fpu: Enabled xstate features 0xa07, context size is 856 =
bytes, using 'compacted' format.
[    0.133791] Freeing SMP alternatives memory: 40K
[    0.133794] pid_max: default: 32768 minimum: 301
[    0.136911] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.136941] landlock: Up and running.
[    0.136943] Yama: becoming mindful.
[    0.136948] LSM support for eBPF active
[    0.136984] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.136998] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.249015] smpboot: CPU0: AMD Ryzen 5 5625U with Radeon Graphics (famil=
y: 0x19, model: 0x50, stepping: 0x0)
[    0.249252] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.249259] ... version:                0
[    0.249260] ... bit width:              48
[    0.249261] ... generic registers:      6
[    0.249262] ... value mask:             0000ffffffffffff
[    0.249263] ... max period:             00007fffffffffff
[    0.249264] ... fixed-purpose events:   0
[    0.249265] ... event mask:             000000000000003f
[    0.249365] signal: max sigframe size: 3376
[    0.249399] rcu: Hierarchical SRCU implementation.
[    0.249401] rcu: 	Max phase no-delay instances is 1000.
[    0.250198] MCE: In-kernel MCE decoding enabled.
[    0.250198] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.250198] smp: Bringing up secondary CPUs ...
[    0.250198] smpboot: x86: Booting SMP configuration:
[    0.250198] .... node  #0, CPUs:        #2  #4  #6  #8 #10  #1  #3  #5  =
#7  #9 #11
[    0.263639] Spectre V2 : Update user space SMT mitigation: STIBP always-=
on
[    0.273569] smp: Brought up 1 node, 12 CPUs
[    0.273569] smpboot: Total of 12 processors activated (55119.77 BogoMIPS)
[    0.274661] devtmpfs: initialized
[    0.274661] x86/mm: Memory block size: 128MB
[    0.277922] ACPI: PM: Registering ACPI NVS region [mem 0x09f00000-0x09f0=
efff] (61440 bytes)
[    0.277922] ACPI: PM: Registering ACPI NVS region [mem 0xcbf7f000-0xcdf7=
efff] (33554432 bytes)
[    0.277922] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.277922] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)
[    0.277922] pinctrl core: initialized pinctrl subsystem
[    0.277922] PM: RTC time: 11:09:31, date: 2024-05-28
[    0.278027] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.278257] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.278355] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.278448] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.278455] audit: initializing netlink subsys (disabled)
[    0.280206] audit: type=3D2000 audit(1716894571.186:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.280308] thermal_sys: Registered thermal governor 'fair_share'
[    0.280310] thermal_sys: Registered thermal governor 'bang_bang'
[    0.280311] thermal_sys: Registered thermal governor 'step_wise'
[    0.280312] thermal_sys: Registered thermal governor 'user_space'
[    0.280313] thermal_sys: Registered thermal governor 'power_allocator'
[    0.280320] cpuidle: using governor ladder
[    0.280320] cpuidle: using governor menu
[    0.280320] Simple Boot Flag at 0x44 set to 0x80
[    0.280320] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.280361] PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for =
domain 0000 [bus 00-3f]
[    0.280374] PCI: Using configuration type 1 for base access
[    0.280482] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.286524] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.286524] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.286524] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.286524] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.286524] Demotion targets for Node 0: null
[    0.286986] ACPI: Added _OSI(Module Device)
[    0.286988] ACPI: Added _OSI(Processor Device)
[    0.286990] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.286991] ACPI: Added _OSI(Processor Aggregator Device)
[    0.306165] ACPI: 21 ACPI AML tables successfully acquired and loaded
[    0.311943] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.313783] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.314729] ACPI: EC: EC started
[    0.314730] ACPI: EC: interrupt blocked
[    0.316022] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.316025] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle tran=
sactions
[    0.316026] ACPI: Interpreter enabled
[    0.316041] ACPI: PM: (supports S0 S4 S5)
[    0.316042] ACPI: Using IOAPIC for interrupt routing
[    0.317603] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.317605] PCI: Ignoring E820 reservations for host bridge windows
[    0.320051] ACPI: \_SB_.PCI0.GPP1.P0NV: New power resource
[    0.320436] ACPI: \_SB_.PCI0.GPP3.WLAN.WRST: New power resource
[    0.320742] ACPI: \_SB_.PCI0.GPP6.P0NV: New power resource
[    0.321492] ACPI: \_SB_.PCI0.GP17.XHC0.P0U0: New power resource
[    0.321624] ACPI: \_SB_.PCI0.GP17.XHC0.P3U0: New power resource
[    0.322960] ACPI: \_SB_.PCI0.GP17.XHC1.P0U1: New power resource
[    0.323090] ACPI: \_SB_.PCI0.GP17.XHC1.P3U1: New power resource
[    0.383822] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.383828] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.383955] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplu=
g LTR DPC]
[    0.384184] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER =
PCIeCapability]
[    0.384195] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf8000000-0xfbf=
fffff] for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.384726] PCI host bridge to bus 0000:00
[    0.384729] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.384731] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.384733] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.384735] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000cfff=
f window]
[    0.384737] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000efff=
f window]
[    0.384738] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xf7fffff=
f window]
[    0.384740] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfeaffff=
f window]
[    0.384742] pci_bus 0000:00: root bus resource [mem 0xfed45000-0xfed811f=
f window]
[    0.384743] pci_bus 0000:00: root bus resource [mem 0xfed81900-0xfed81ff=
f window]
[    0.384745] pci_bus 0000:00: root bus resource [mem 0xfedc0000-0xfedc0ff=
f window]
[    0.384746] pci_bus 0000:00: root bus resource [mem 0xfedc6000-0xfedc6ff=
f window]
[    0.384748] pci_bus 0000:00: root bus resource [mem 0x450200000-0xfcffff=
ffff window]
[    0.384749] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.384764] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.384849] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600 convent=
ional PCI endpoint
[    0.384930] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.385020] pci 0000:00:01.2: [1022:1634] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.385035] pci 0000:00:01.2: PCI bridge to [bus 01]
[    0.385041] pci 0000:00:01.2:   bridge window [mem 0xd0700000-0xd07fffff]
[    0.385087] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.385195] pci 0000:00:01.3: [1022:1634] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.385210] pci 0000:00:01.3: PCI bridge to [bus 02]
[    0.385214] pci 0000:00:01.3:   bridge window [io  0x3000-0x3fff]
[    0.385217] pci 0000:00:01.3:   bridge window [mem 0xd0600000-0xd06fffff]
[    0.385259] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
[    0.385354] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.385438] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.385454] pci 0000:00:02.1: PCI bridge to [bus 03]
[    0.385458] pci 0000:00:02.1:   bridge window [io  0x2000-0x2fff]
[    0.385460] pci 0000:00:02.1:   bridge window [mem 0xd0500000-0xd05fffff]
[    0.385505] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.385616] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.385699] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.385714] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.385718] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.385720] pci 0000:00:08.1:   bridge window [mem 0xd0100000-0xd04fffff]
[    0.385726] pci 0000:00:08.1:   bridge window [mem 0xfce0000000-0xfcf01f=
ffff 64bit pref]
[    0.385732] pci 0000:00:08.1: enabling Extended Tags
[    0.385767] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.385902] pci 0000:00:08.2: [1022:1635] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.385917] pci 0000:00:08.2: PCI bridge to [bus 05]
[    0.385922] pci 0000:00:08.2:   bridge window [mem 0xd0000000-0xd00fffff]
[    0.385932] pci 0000:00:08.2: enabling Extended Tags
[    0.385967] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.386090] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.386220] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.386371] pci 0000:00:18.0: [1022:166a] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.386435] pci 0000:00:18.1: [1022:166b] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.386499] pci 0000:00:18.2: [1022:166c] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.386564] pci 0000:00:18.3: [1022:166d] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.386627] pci 0000:00:18.4: [1022:166e] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.386691] pci 0000:00:18.5: [1022:166f] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.386755] pci 0000:00:18.6: [1022:1670] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.386817] pci 0000:00:18.7: [1022:1671] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.387230] pci 0000:01:00.0: [1344:5404] type 00 class 0x010802 PCIe En=
dpoint
[    0.387251] pci 0000:01:00.0: BAR 0 [mem 0xd0700000-0xd0703fff 64bit]
[    0.387568] pci 0000:00:01.2: PCI bridge to [bus 01]
[    0.387628] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.387646] pci 0000:02:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.387669] pci 0000:02:00.0: BAR 2 [mem 0xd0604000-0xd0604fff 64bit]
[    0.387683] pci 0000:02:00.0: BAR 4 [mem 0xd0600000-0xd0603fff 64bit]
[    0.387778] pci 0000:02:00.0: supports D1 D2
[    0.387779] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.387952] pci 0000:00:01.3: PCI bridge to [bus 02]
[    0.388228] pci 0000:03:00.0: [10ec:c821] type 00 class 0x028000 PCIe En=
dpoint
[    0.388245] pci 0000:03:00.0: BAR 0 [io  0x2000-0x20ff]
[    0.388267] pci 0000:03:00.0: BAR 2 [mem 0xd0500000-0xd050ffff 64bit]
[    0.388465] pci 0000:03:00.0: supports D1 D2
[    0.388466] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.389204] pci 0000:00:02.1: PCI bridge to [bus 03]
[    0.389300] pci 0000:04:00.0: [1002:15e7] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.389312] pci 0000:04:00.0: BAR 0 [mem 0xfce0000000-0xfcefffffff 64bit=
 pref]
[    0.389320] pci 0000:04:00.0: BAR 2 [mem 0xfcf0000000-0xfcf01fffff 64bit=
 pref]
[    0.389326] pci 0000:04:00.0: BAR 4 [io  0x1000-0x10ff]
[    0.389331] pci 0000:04:00.0: BAR 5 [mem 0xd0400000-0xd047ffff]
[    0.389340] pci 0000:04:00.0: enabling Extended Tags
[    0.389395] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.389434] pci 0000:04:00.0: 126.016 Gb/s available PCIe bandwidth, lim=
ited by 8.0 GT/s PCIe x16 link at 0000:00:08.1 (capable of 252.048 Gb/s wit=
h 16.0 GT/s PCIe x16 link)
[    0.389530] pci 0000:04:00.1: [1002:1637] type 00 class 0x040300 PCIe Le=
gacy Endpoint
[    0.389538] pci 0000:04:00.1: BAR 0 [mem 0xd04c8000-0xd04cbfff]
[    0.389560] pci 0000:04:00.1: enabling Extended Tags
[    0.389593] pci 0000:04:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.389679] pci 0000:04:00.2: [1022:15df] type 00 class 0x108000 PCIe En=
dpoint
[    0.389693] pci 0000:04:00.2: BAR 2 [mem 0xd0300000-0xd03fffff]
[    0.389703] pci 0000:04:00.2: BAR 5 [mem 0xd04cc000-0xd04cdfff]
[    0.389711] pci 0000:04:00.2: enabling Extended Tags
[    0.389826] pci 0000:04:00.3: [1022:1639] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.389837] pci 0000:04:00.3: BAR 0 [mem 0xd0100000-0xd01fffff 64bit]
[    0.389862] pci 0000:04:00.3: enabling Extended Tags
[    0.389896] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
[    0.389988] pci 0000:04:00.4: [1022:1639] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.390000] pci 0000:04:00.4: BAR 0 [mem 0xd0200000-0xd02fffff 64bit]
[    0.390024] pci 0000:04:00.4: enabling Extended Tags
[    0.390059] pci 0000:04:00.4: PME# supported from D0 D3hot D3cold
[    0.390155] pci 0000:04:00.5: [1022:15e2] type 00 class 0x048000 PCIe En=
dpoint
[    0.390163] pci 0000:04:00.5: BAR 0 [mem 0xd0480000-0xd04bffff]
[    0.390185] pci 0000:04:00.5: enabling Extended Tags
[    0.390220] pci 0000:04:00.5: PME# supported from D0 D3hot D3cold
[    0.390305] pci 0000:04:00.6: [1022:15e3] type 00 class 0x040300 PCIe En=
dpoint
[    0.390314] pci 0000:04:00.6: BAR 0 [mem 0xd04c0000-0xd04c7fff]
[    0.390335] pci 0000:04:00.6: enabling Extended Tags
[    0.390368] pci 0000:04:00.6: PME# supported from D0 D3hot D3cold
[    0.390486] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.390540] pci 0000:05:00.0: [1022:7901] type 00 class 0x010601 PCIe En=
dpoint
[    0.390569] pci 0000:05:00.0: BAR 5 [mem 0xd0001000-0xd00017ff]
[    0.390578] pci 0000:05:00.0: enabling Extended Tags
[    0.390652] pci 0000:05:00.0: 126.016 Gb/s available PCIe bandwidth, lim=
ited by 8.0 GT/s PCIe x16 link at 0000:00:08.2 (capable of 252.048 Gb/s wit=
h 16.0 GT/s PCIe x16 link)
[    0.390735] pci 0000:05:00.1: [1022:7901] type 00 class 0x010601 PCIe En=
dpoint
[    0.390764] pci 0000:05:00.1: BAR 5 [mem 0xd0000000-0xd00007ff]
[    0.390773] pci 0000:05:00.1: enabling Extended Tags
[    0.390900] pci 0000:00:08.2: PCI bridge to [bus 05]
[    0.444587] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.444593] ACPI: PCI: Interrupt link LNKA disabled
[    0.444784] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.444785] ACPI: PCI: Interrupt link LNKB disabled
[    0.444859] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.444860] ACPI: PCI: Interrupt link LNKC disabled
[    0.444952] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.444953] ACPI: PCI: Interrupt link LNKD disabled
[    0.445038] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.445039] ACPI: PCI: Interrupt link LNKE disabled
[    0.445107] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.445108] ACPI: PCI: Interrupt link LNKF disabled
[    0.445176] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.445177] ACPI: PCI: Interrupt link LNKG disabled
[    0.445246] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.445247] ACPI: PCI: Interrupt link LNKH disabled
[    0.446498] Low-power S0 idle used by default for system suspend
[    0.446630] ACPI: EC: interrupt unblocked
[    0.446632] ACPI: EC: event unblocked
[    0.446869] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.446869] ACPI: EC: GPE=3D0x3
[    0.446869] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization comp=
lete
[    0.446869] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions =
and events
[    0.446879] iommu: Default domain type: Translated
[    0.446879] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.447013] SCSI subsystem initialized
[    0.447013] libata version 3.00 loaded.
[    0.447013] ACPI: bus type USB registered
[    0.447013] usbcore: registered new interface driver usbfs
[    0.447013] usbcore: registered new interface driver hub
[    0.447013] usbcore: registered new device driver usb
[    0.503415] EDAC MC: Ver: 3.0.0
[    0.504296] efivars: Registered efivars operations
[    0.504296] NetLabel: Initializing
[    0.504296] NetLabel:  domain hash size =3D 128
[    0.504296] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.504296] NetLabel:  unlabeled traffic allowed by default
[    0.504296] mctp: management component transport protocol core
[    0.504296] NET: Registered PF_MCTP protocol family
[    0.504296] PCI: Using ACPI for IRQ routing
[    0.507417] PCI: pci_cache_line_size set to 64 bytes
[    0.507962] resource: Expanded resource Reserved due to conflict with PC=
I Bus 0000:00
[    0.507965] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.507967] e820: reserve RAM buffer [mem 0x09a00000-0x0bffffff]
[    0.507968] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
[    0.507970] e820: reserve RAM buffer [mem 0xa9011018-0xabffffff]
[    0.507971] e820: reserve RAM buffer [mem 0xab799000-0xabffffff]
[    0.507972] e820: reserve RAM buffer [mem 0xb68c0000-0xb7ffffff]
[    0.507973] e820: reserve RAM buffer [mem 0xb9474000-0xbbffffff]
[    0.507975] e820: reserve RAM buffer [mem 0xc9baf000-0xcbffffff]
[    0.507976] e820: reserve RAM buffer [mem 0xce000000-0xcfffffff]
[    0.507977] e820: reserve RAM buffer [mem 0x40e300000-0x40fffffff]
[    0.508031] pci 0000:04:00.0: vgaarb: setting as boot VGA device
[    0.508031] pci 0000:04:00.0: vgaarb: bridge control possible
[    0.508031] pci 0000:04:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.508031] vgaarb: loaded
[    0.508031] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.508031] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.510256] clocksource: Switched to clocksource tsc-early
[    0.511155] VFS: Disk quotas dquot_6.6.0
[    0.511165] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.511247] pnp: PnP ACPI init
[    0.511477] system 00:00: [mem 0xfec00000-0xfec01fff] could not be reser=
ved
[    0.511482] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.511484] system 00:00: [mem 0xfde00000-0xfdefffff] has been reserved
[    0.511875] system 00:04: [io  0x0400-0x04cf] has been reserved
[    0.511878] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.511880] system 00:04: [io  0x04d6] has been reserved
[    0.511881] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.511883] system 00:04: [io  0x0c14] has been reserved
[    0.511885] system 00:04: [io  0x0c50-0x0c52] has been reserved
[    0.511886] system 00:04: [io  0x0c6c] has been reserved
[    0.511888] system 00:04: [io  0x0c6f] has been reserved
[    0.511889] system 00:04: [io  0x0cd0-0x0cdb] has been reserved
[    0.511891] system 00:04: [io  0xfd60-0xfd6f] has been reserved
[    0.511968] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.565486] pnp: PnP ACPI: found 6 devices
[    0.571388] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.571544] NET: Registered PF_INET protocol family
[    0.571737] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.583894] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.583913] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.583955] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.584143] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.584234] TCP: Hash tables configured (established 131072 bind 65536)
[    0.584313] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    0.584346] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.584379] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    0.584426] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.584432] NET: Registered PF_XDP protocol family
[    0.584441] pci 0000:00:01.2: PCI bridge to [bus 01]
[    0.584447] pci 0000:00:01.2:   bridge window [mem 0xd0700000-0xd07fffff]
[    0.584453] pci 0000:00:01.3: PCI bridge to [bus 02]
[    0.584455] pci 0000:00:01.3:   bridge window [io  0x3000-0x3fff]
[    0.584458] pci 0000:00:01.3:   bridge window [mem 0xd0600000-0xd06fffff]
[    0.584463] pci 0000:00:02.1: PCI bridge to [bus 03]
[    0.584465] pci 0000:00:02.1:   bridge window [io  0x2000-0x2fff]
[    0.584468] pci 0000:00:02.1:   bridge window [mem 0xd0500000-0xd05fffff]
[    0.584474] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.584476] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.584479] pci 0000:00:08.1:   bridge window [mem 0xd0100000-0xd04fffff]
[    0.584482] pci 0000:00:08.1:   bridge window [mem 0xfce0000000-0xfcf01f=
ffff 64bit pref]
[    0.584486] pci 0000:00:08.2: PCI bridge to [bus 05]
[    0.584489] pci 0000:00:08.2:   bridge window [mem 0xd0000000-0xd00fffff]
[    0.584495] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.584497] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.584498] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.584500] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000cffff windo=
w]
[    0.584501] pci_bus 0000:00: resource 8 [mem 0x000d0000-0x000effff windo=
w]
[    0.584503] pci_bus 0000:00: resource 9 [mem 0xd0000000-0xf7ffffff windo=
w]
[    0.584505] pci_bus 0000:00: resource 10 [mem 0xfc000000-0xfeafffff wind=
ow]
[    0.584506] pci_bus 0000:00: resource 11 [mem 0xfed45000-0xfed811ff wind=
ow]
[    0.584508] pci_bus 0000:00: resource 12 [mem 0xfed81900-0xfed81fff wind=
ow]
[    0.584509] pci_bus 0000:00: resource 13 [mem 0xfedc0000-0xfedc0fff wind=
ow]
[    0.584511] pci_bus 0000:00: resource 14 [mem 0xfedc6000-0xfedc6fff wind=
ow]
[    0.584513] pci_bus 0000:00: resource 15 [mem 0x450200000-0xfcffffffff w=
indow]
[    0.584514] pci_bus 0000:01: resource 1 [mem 0xd0700000-0xd07fffff]
[    0.584516] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.584518] pci_bus 0000:02: resource 1 [mem 0xd0600000-0xd06fffff]
[    0.584520] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    0.584521] pci_bus 0000:03: resource 1 [mem 0xd0500000-0xd05fffff]
[    0.584523] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
[    0.584524] pci_bus 0000:04: resource 1 [mem 0xd0100000-0xd04fffff]
[    0.584526] pci_bus 0000:04: resource 2 [mem 0xfce0000000-0xfcf01fffff 6=
4bit pref]
[    0.584528] pci_bus 0000:05: resource 1 [mem 0xd0000000-0xd00fffff]
[    0.585148] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
[    0.585156] pci 0000:04:00.3: extending delay after power-on from D3hot =
to 20 msec
[    0.586445] pci 0000:04:00.4: extending delay after power-on from D3hot =
to 20 msec
[    0.597670] pci 0000:04:00.4: quirk_usb_early_handoff+0x0/0x730 took 109=
59 usecs
[    0.597683] PCI: CLS 64 bytes, default 64
[    0.597702] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters support=
ed
[    0.597735] Trying to unpack rootfs image as initramfs...
[    0.597767] pci 0000:00:01.0: Adding to iommu group 0
[    0.597783] pci 0000:00:01.2: Adding to iommu group 1
[    0.597799] pci 0000:00:01.3: Adding to iommu group 2
[    0.597819] pci 0000:00:02.0: Adding to iommu group 3
[    0.597833] pci 0000:00:02.1: Adding to iommu group 4
[    0.597854] pci 0000:00:08.0: Adding to iommu group 5
[    0.597869] pci 0000:00:08.1: Adding to iommu group 6
[    0.597883] pci 0000:00:08.2: Adding to iommu group 7
[    0.597909] pci 0000:00:14.0: Adding to iommu group 8
[    0.597922] pci 0000:00:14.3: Adding to iommu group 8
[    0.597984] pci 0000:00:18.0: Adding to iommu group 9
[    0.597998] pci 0000:00:18.1: Adding to iommu group 9
[    0.598011] pci 0000:00:18.2: Adding to iommu group 9
[    0.598025] pci 0000:00:18.3: Adding to iommu group 9
[    0.598039] pci 0000:00:18.4: Adding to iommu group 9
[    0.598052] pci 0000:00:18.5: Adding to iommu group 9
[    0.598067] pci 0000:00:18.6: Adding to iommu group 9
[    0.598081] pci 0000:00:18.7: Adding to iommu group 9
[    0.598095] pci 0000:01:00.0: Adding to iommu group 10
[    0.598110] pci 0000:02:00.0: Adding to iommu group 11
[    0.598126] pci 0000:03:00.0: Adding to iommu group 12
[    0.598149] pci 0000:04:00.0: Adding to iommu group 13
[    0.598165] pci 0000:04:00.1: Adding to iommu group 14
[    0.598181] pci 0000:04:00.2: Adding to iommu group 15
[    0.598197] pci 0000:04:00.3: Adding to iommu group 16
[    0.598212] pci 0000:04:00.4: Adding to iommu group 17
[    0.598228] pci 0000:04:00.5: Adding to iommu group 18
[    0.598244] pci 0000:04:00.6: Adding to iommu group 19
[    0.598260] pci 0000:05:00.0: Adding to iommu group 20
[    0.598275] pci 0000:05:00.1: Adding to iommu group 21
[    0.600309] AMD-Vi: Extended features (0x206d73ef22254ade, 0x0): PPR X2A=
PIC NX GT IA GA PC GA_vAPIC
[    0.600319] AMD-Vi: Interrupt remapping enabled
[    0.600320] AMD-Vi: X2APIC enabled
[    0.604552] AMD-Vi: Virtual APIC enabled
[    0.604561] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.604563] software IO TLB: mapped [mem 0x00000000c4f92000-0x00000000c8=
f92000] (64MB)
[    0.604631] LVT offset 0 assigned for vector 0x400
[    0.605249] perf: AMD IBS detected (0x000003ff)
[    0.605254] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/b=
ank).
[    0.610301] Initialise system trusted keyrings
[    0.610312] Key type blacklist registered
[    0.610343] workingset: timestamp_bits=3D41 max_order=3D22 bucket_order=
=3D0
[    0.610353] zbud: loaded
[    0.610517] integrity: Platform Keyring initialized
[    0.610520] integrity: Machine keyring initialized
[    0.619931] Key type asymmetric registered
[    0.619934] Asymmetric key parser 'x509' registered
[    0.619963] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.620000] io scheduler mq-deadline registered
[    0.620001] io scheduler kyber registered
[    0.620009] io scheduler bfq registered
[    0.621410] pcieport 0000:00:01.2: PME: Signaling with IRQ 37
[    0.621532] pcieport 0000:00:01.3: PME: Signaling with IRQ 38
[    0.621636] pcieport 0000:00:02.1: PME: Signaling with IRQ 39
[    0.621744] pcieport 0000:00:08.1: PME: Signaling with IRQ 40
[    0.621959] pcieport 0000:00:08.2: PME: Signaling with IRQ 41
[    0.622060] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.624203] ACPI: AC: AC Adapter [ACAD] (on-line)
[    0.624251] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input0
[    0.624275] ACPI: button: Power Button [PWRB]
[    0.624312] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input1
[    0.624330] ACPI: button: Lid Switch [LID]
[    0.624409] Estimated ratio of average max frequency by base frequency (=
times 1024): 1488
[    0.624428] Monitor-Mwait will be used to enter C-1 state
[    0.624434] ACPI: \_SB_.PLTF.C000: Found 3 idle states
[    0.624554] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[    0.624665] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[    0.624772] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[    0.624901] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[    0.625079] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[    0.625243] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[    0.625399] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[    0.625552] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[    0.625713] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[    0.625870] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[    0.626024] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[    0.626484] thermal LNXTHERM:00: registered as thermal_zone0
[    0.626487] ACPI: thermal: Thermal Zone [TZ01] (74 C)
[    0.626686] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.629200] Non-volatile memory driver v1.3
[    0.629203] Linux agpgart interface v0.103
[    0.635385] tpm_tis NTC0702:00: 2.0 TPM (device-id 0xFC, rev-id 1)
[    0.644025] Freeing initrd memory: 33696K
[    0.680349] ACPI: battery: Slot [BAT1] (battery present)
[    0.762186] tpm tpm0: tpm_read_log_acpi: Failed to map ACPI memory
[    0.832611] ACPI: bus type drm_connector registered
[    0.834022] ahci 0000:05:00.0: version 3.0
[    0.834193] ahci 0000:05:00.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    0.834196] ahci 0000:05:00.0: 1/1 ports implemented (port mask 0x1)
[    0.834198] ahci 0000:05:00.0: flags: 64bit ncq sntf ilck pm led clo onl=
y pmp fbs pio slum part=20
[    0.834461] scsi host0: ahci
[    0.834517] ata1: SATA max UDMA/133 abar m2048@0xd0001000 port 0xd000110=
0 irq 43 lpm-pol 4
[    0.834664] ahci 0000:05:00.1: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    0.834667] ahci 0000:05:00.1: 1/1 ports implemented (port mask 0x1)
[    0.834669] ahci 0000:05:00.1: flags: 64bit ncq sntf ilck pm led clo onl=
y pmp fbs pio slum part=20
[    0.834870] scsi host1: ahci
[    0.834912] ata2: SATA max UDMA/133 abar m2048@0xd0000000 port 0xd000010=
0 irq 45 lpm-pol 4
[    0.834989] usbcore: registered new interface driver usbserial_generic
[    0.834996] usbserial: USB Serial support registered for generic
[    0.835058] rtc_cmos 00:01: RTC can wake from S4
[    0.835289] rtc_cmos 00:01: registered as rtc0
[    0.835377] rtc_cmos 00:01: setting system clock to 2024-05-28T11:09:31 =
UTC (1716894571)
[    0.835435] rtc_cmos 00:01: alarms up to one month, 114 bytes nvram
[    0.840790] ledtrig-cpu: registered to indicate activity on CPUs
[    0.841246] [drm] Initialized simpledrm 1.0.0 20200625 for simple-frameb=
uffer.0 on minor 0
[    0.841795] fbcon: Deferring console take-over
[    0.841798] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.841932] hid: raw HID events driver (C) Jiri Kosina
[    0.841998] drop_monitor: Initializing network drop monitor service
[    0.842110] NET: Registered PF_INET6 protocol family
[    0.846887] Segment Routing with IPv6
[    0.846890] RPL Segment Routing with IPv6
[    0.846905] In-situ OAM (IOAM) with IPv6
[    0.846938] NET: Registered PF_PACKET protocol family
[    0.847778] microcode: Current revision: 0x0a50000f
[    0.847978] resctrl: L3 allocation detected
[    0.847979] resctrl: MB allocation detected
[    0.847980] resctrl: L3 monitoring detected
[    0.847998] IPI shorthand broadcast: enabled
[    0.850377] sched_clock: Marking stable (847922661, 381435)->(854881278,=
 -6577182)
[    0.850486] Timer migration: 2 hierarchy levels; 8 children per group; 2=
 crossnode level
[    0.850578] registered taskstats version 1
[    0.852663] Loading compiled-in X.509 certificates
[    0.854809] Loaded X.509 cert 'Build time autogenerated kernel key: a96b=
4f2d99ff730752feff69a97d01cbfd1e50bf'
[    0.859541] zswap: loaded using pool zstd/zsmalloc
[    0.859585] Demotion targets for Node 0: null
[    0.859904] Key type .fscrypt registered
[    0.859905] Key type fscrypt-provisioning registered
[    0.861570] integrity: Loading X.509 certificate: UEFI:db
[    0.861601] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.861603] integrity: Loading X.509 certificate: UEFI:db
[    0.861621] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.861622] integrity: Loading X.509 certificate: UEFI:db
[    0.864439] integrity: Loaded X.509 cert 'CompalA31CSMB: 1e3b690555de0b9=
542b280303282c6d6'
[    0.867732] PM:   Magic number: 8:879:176
[    0.867782] acpi device:39: hash matches
[    0.867791] acpi device:0c: hash matches
[    0.872211] RAS: Correctable Errors collector initialized.
[    1.148021] ata1: SATA link down (SStatus 0 SControl 300)
[    1.148688] ata2: SATA link down (SStatus 0 SControl 300)
[    1.150255] clk: Disabling unused clocks
[    1.150259] PM: genpd: Disabling unused power domains
[    1.151375] Freeing unused decrypted memory: 2028K
[    1.151695] Freeing unused kernel image (initmem) memory: 3408K
[    1.151703] Write protecting the kernel read-only data: 32768k
[    1.152021] Freeing unused kernel image (rodata/data gap) memory: 1032K
[    1.195254] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.195260] rodata_test: all tests were successful
[    1.195265] Run /init as init process
[    1.195266]   with arguments:
[    1.195268]     /init
[    1.195269]   with environment:
[    1.195270]     HOME=3D/
[    1.195272]     TERM=3Dlinux
[    1.219622] fbcon: Taking over console
[    1.223251] Console: switching to colour frame buffer device 240x67
[    1.319440] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQBC data block =
query control method not found
[    1.324011] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:PS2M] at 0=
x60,0x64 irq 1,12
[    1.336063] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.336151] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.336275] xhci_hcd 0000:04:00.3: xHCI Host Controller
[    1.336282] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus =
number 1
[    1.336385] xhci_hcd 0000:04:00.3: hcc params 0x0268ffe5 hci version 0x1=
10 quirks 0x0000020000000010
[    1.336676] xhci_hcd 0000:04:00.3: xHCI Host Controller
[    1.336679] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus =
number 2
[    1.336682] xhci_hcd 0000:04:00.3: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.336727] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.10
[    1.336730] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.336732] usb usb1: Product: xHCI Host Controller
[    1.336733] usb usb1: Manufacturer: Linux 6.10.0-rc1-1-mainline xhci-hcd
[    1.336735] usb usb1: SerialNumber: 0000:04:00.3
[    1.336925] hub 1-0:1.0: USB hub found
[    1.336945] hub 1-0:1.0: 4 ports detected
[    1.338212] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    1.338263] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.10
[    1.338266] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.338267] usb usb2: Product: xHCI Host Controller
[    1.338269] usb usb2: Manufacturer: Linux 6.10.0-rc1-1-mainline xhci-hcd
[    1.338270] usb usb2: SerialNumber: 0000:04:00.3
[    1.338375] hub 2-0:1.0: USB hub found
[    1.338393] hub 2-0:1.0: 2 ports detected
[    1.339107] usb: port power management may be unreliable
[    1.339307] xhci_hcd 0000:04:00.4: xHCI Host Controller
[    1.339315] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus =
number 3
[    1.339421] xhci_hcd 0000:04:00.4: hcc params 0x0268ffe5 hci version 0x1=
10 quirks 0x0000020000000010
[    1.339763] xhci_hcd 0000:04:00.4: xHCI Host Controller
[    1.339769] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus =
number 4
[    1.339772] xhci_hcd 0000:04:00.4: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.339812] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.10
[    1.339815] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.339817] usb usb3: Product: xHCI Host Controller
[    1.339818] usb usb3: Manufacturer: Linux 6.10.0-rc1-1-mainline xhci-hcd
[    1.339820] usb usb3: SerialNumber: 0000:04:00.4
[    1.339937] hub 3-0:1.0: USB hub found
[    1.339950] hub 3-0:1.0: 4 ports detected
[    1.341098] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    1.341124] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.10
[    1.341126] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.341128] usb usb4: Product: xHCI Host Controller
[    1.341130] usb usb4: Manufacturer: Linux 6.10.0-rc1-1-mainline xhci-hcd
[    1.341131] usb usb4: SerialNumber: 0000:04:00.4
[    1.341242] hub 4-0:1.0: USB hub found
[    1.341257] hub 4-0:1.0: 2 ports detected
[    1.343658] nvme 0000:01:00.0: platform quirk: setting simple suspend
[    1.343743] nvme nvme0: pci function 0000:01:00.0
[    1.352890] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input2
[    1.364268] nvme nvme0: 12/0/0 default/read/poll queues
[    1.370314]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11
[    1.398545] raid6: skipped pq benchmark and selected avx2x4
[    1.398549] raid6: using avx2x2 recovery algorithm
[    1.401063] xor: automatically using best checksumming function   avx   =
   =20
[    1.487532] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    1.590631] usb 1-4: new low-speed USB device number 2 using xhci_hcd
[    1.590669] usb 3-1: new full-speed USB device number 2 using xhci_hcd
[    1.610605] tsc: Refined TSC clocksource calibration: 2295.697 MHz
[    1.610623] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x211=
75462393, max_idle_ns: 440795268065 ns
[    1.610683] clocksource: Switched to clocksource tsc
[    1.748186] usb 1-4: New USB device found, idVendor=3D046d, idProduct=3D=
c040, bcdDevice=3D24.30
[    1.748203] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.748209] usb 1-4: Product: USB-PS/2 Optical Mouse
[    1.748214] usb 1-4: Manufacturer: Logitech
[    1.749839] usb 3-1: New USB device found, idVendor=3D0bda, idProduct=3D=
c829, bcdDevice=3D 1.10
[    1.749843] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    1.749845] usb 3-1: Product: Bluetooth Radio=20
[    1.749846] usb 3-1: Manufacturer: Realtek=20
[    1.749848] usb 3-1: SerialNumber: 00e04c000001
[    1.771860] usbcore: registered new interface driver usbhid
[    1.771864] usbhid: USB HID core driver
[    1.775998] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:0=
0/0000:00:08.1/0000:04:00.3/usb1/1-4/1-4:1.0/0003:046D:C040.0001/input/inpu=
t4
[    1.776067] hid-generic 0003:046D:C040.0001: input,hidraw0: USB HID v1.1=
0 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:04:00.3-4/input0
[    1.828501] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  p=
ost: no)
[    1.828746] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/device:0f/LNXVIDEO:00/input/input5
[    1.883743] usb 3-4: new high-speed USB device number 3 using xhci_hcd
[    2.036832] usb 3-4: New USB device found, idVendor=3D0c45, idProduct=3D=
6739, bcdDevice=3D14.11
[    2.036837] usb 3-4: New USB device strings: Mfr=3D2, Product=3D1, Seria=
lNumber=3D0
[    2.036840] usb 3-4: Product: Integrated_Webcam_FHD
[    2.036842] usb 3-4: Manufacturer: CN07W56Y8LG0027EC677A00
[    3.318369] [drm] amdgpu kernel modesetting enabled.
[    3.321790] amdgpu: Virtual CRAT table created for CPU
[    3.321806] amdgpu: Topology: Add CPU node
[    3.321915] amdgpu 0000:04:00.0: enabling device (0006 -> 0007)
[    3.321968] [drm] initializing kernel modesetting (RENOIR 0x1002:0x15E7 =
0x1028:0x0B7D 0xC2).
[    3.325315] [drm] register mmio base: 0xD0400000
[    3.325318] [drm] register mmio size: 524288
[    3.328414] [drm] add ip block number 0 <soc15_common>
[    3.328417] [drm] add ip block number 1 <gmc_v9_0>
[    3.328418] [drm] add ip block number 2 <vega10_ih>
[    3.328420] [drm] add ip block number 3 <psp>
[    3.328421] [drm] add ip block number 4 <smu>
[    3.328422] [drm] add ip block number 5 <dm>
[    3.328424] [drm] add ip block number 6 <gfx_v9_0>
[    3.328425] [drm] add ip block number 7 <sdma_v4_0>
[    3.328427] [drm] add ip block number 8 <vcn_v2_0>
[    3.328428] [drm] add ip block number 9 <jpeg_v2_0>
[    3.328443] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from VFCT
[    3.328446] amdgpu: ATOM BIOS: 113-BARCELO-002
[    3.330220] [drm] VCN decode is enabled in VM mode
[    3.330222] [drm] VCN encode is enabled in VM mode
[    3.331116] [drm] JPEG decode is enabled in VM mode
[    3.344290] Console: switching to colour dummy device 80x25
[    3.398727] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
[    3.398737] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re enabled
[    3.398744] amdgpu 0000:04:00.0: amdgpu: MODE2 reset
[    3.399623] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[    3.399633] amdgpu 0000:04:00.0: amdgpu: VRAM: 512M 0x000000F400000000 -=
 0x000000F41FFFFFFF (512M used)
[    3.399636] amdgpu 0000:04:00.0: amdgpu: GART: 1024M 0x0000000000000000 =
- 0x000000003FFFFFFF
[    3.399643] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
[    3.399644] [drm] RAM width 128bits DDR4
[    3.399785] [drm] amdgpu: 512M of VRAM memory ready
[    3.399787] [drm] amdgpu: 7668M of GTT memory ready.
[    3.399802] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    3.399938] [drm] PCIE GART of 1024M enabled.
[    3.399940] [drm] PTB located at 0x000000F41FC00000
[    3.400338] [drm] Loading DMUB firmware via PSP: version=3D0x01010028
[    3.400737] [drm] Found VCN firmware Version ENC: 1.21 DEC: 7 VEP: 0 Rev=
ision: 3
[    3.400747] amdgpu 0000:04:00.0: amdgpu: Will use PSP to load VCN firmwa=
re
[    4.127551] amdgpu 0000:04:00.0: amdgpu: reserve 0x400000 from 0xf41f800=
000 for PSP TMR
[    4.216541] amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    4.227892] amdgpu 0000:04:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available
[    4.227895] amdgpu 0000:04:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[    4.228080] amdgpu 0000:04:00.0: amdgpu: SMU is initialized successfully!
[    4.229135] [drm] Display Core v3.2.281 initialized on DCN 2.1
[    4.229137] [drm] DP-HDMI FRL PCON supported
[    4.229690] [drm] DMUB hardware initialized: version=3D0x01010028
[    4.407996] [drm] kiq ring mec 2 pipe 1 q 0
[    4.411269] [drm] VCN decode and encode initialized successfully(under D=
PG Mode).
[    4.411289] [drm] JPEG decode initialized successfully.
[    4.412923] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    4.412935] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    4.413033] amdgpu: Virtual CRAT table created for GPU
[    4.413490] amdgpu: Topology: Add dGPU node [0x15e7:0x1002]
[    4.413492] kfd kfd: amdgpu: added device 1002:15e7
[    4.413573] amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 8,=
 active_cu_number 7
[    4.413576] amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0
[    4.413578] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 1 on hub 0
[    4.413580] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 4 on hub 0
[    4.413581] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 5 on hub 0
[    4.413583] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 6 on hub 0
[    4.413584] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 7 on hub 0
[    4.413585] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 8 on hub 0
[    4.413587] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 9 on hub 0
[    4.413588] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 10 on hub 0
[    4.413590] amdgpu 0000:04:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 11 on hub 0
[    4.413591] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 8
[    4.413592] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 =
on hub 8
[    4.413594] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4=
 on hub 8
[    4.413595] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5=
 on hub 8
[    4.413597] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6=
 on hub 8
[    4.419511] amdgpu 0000:04:00.0: amdgpu: Runtime PM not available
[    4.420151] [drm] Initialized amdgpu 3.57.0 20150101 for 0000:04:00.0 on=
 minor 1
[    4.425066] fbcon: amdgpudrmfb (fb0) is primary device
[    4.425216] [drm] DSC precompute is not needed.
[    4.445480] Console: switching to colour frame buffer device 240x67
[    4.446997] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[    4.522792] BTRFS: device fsid 306acb61-a48c-46f5-a81d-f74851a36849 devi=
d 1 transid 54916 /dev/nvme0n1p10 (259:10) scanned by mount (314)
[    4.523032] BTRFS info (device nvme0n1p10): first mount of filesystem 30=
6acb61-a48c-46f5-a81d-f74851a36849
[    4.523044] BTRFS info (device nvme0n1p10): using crc32c (crc32c-intel) =
checksum algorithm
[    4.523048] BTRFS info (device nvme0n1p10): using free-space-tree
[    4.616421] systemd[1]: systemd 255.7-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZST=
D +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    4.616428] systemd[1]: Detected architecture x86-64.
[    4.617543] systemd[1]: Hostname set to <DELL>.
[    4.913816] systemd[1]: bpf-lsm: LSM BPF program attached
[    5.038560] systemd[1]: Queued start job for default target Graphical In=
terface.
[    5.079158] systemd[1]: Created slice Slice /system/dirmngr.
[    5.079523] systemd[1]: Created slice Slice /system/getty.
[    5.079795] systemd[1]: Created slice Slice /system/gpg-agent.
[    5.080072] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    5.080343] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    5.080631] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    5.080916] systemd[1]: Created slice Slice /system/keyboxd.
[    5.081192] systemd[1]: Created slice Slice /system/modprobe.
[    5.081461] systemd[1]: Created slice Slice /system/systemd-fsck.
[    5.081690] systemd[1]: Created slice User and Session Slice.
[    5.081775] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    5.081848] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    5.082021] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    5.082073] systemd[1]: Expecting device /dev/disk/by-uuid/306acb61-a48c=
-46f5-a81d-f74851a36849...
[    5.082108] systemd[1]: Expecting device /dev/disk/by-uuid/8407db45-f134=
-4fae-a376-48d0f4987f51...
[    5.082140] systemd[1]: Expecting device /dev/disk/by-uuid/C2A6-AADD...
[    5.082175] systemd[1]: Reached target Local Encrypted Volumes.
[    5.082212] systemd[1]: Reached target Local Integrity Protected Volumes.
[    5.082259] systemd[1]: Reached target Path Units.
[    5.082291] systemd[1]: Reached target Remote File Systems.
[    5.082322] systemd[1]: Reached target Slice Units.
[    5.082364] systemd[1]: Reached target Local Verity Protected Volumes.
[    5.082445] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    5.083321] systemd[1]: Listening on Process Core Dump Socket.
[    5.083450] systemd[1]: Listening on Journal Socket (/dev/log).
[    5.083565] systemd[1]: Listening on Journal Socket.
[    5.083625] systemd[1]: TPM2 PCR Extension (Varlink) was skipped because=
 of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    5.084113] systemd[1]: Listening on udev Control Socket.
[    5.084256] systemd[1]: Listening on udev Kernel Socket.
[    5.084394] systemd[1]: Listening on User Database Manager Socket.
[    5.085684] systemd[1]: Mounting Huge Pages File System...
[    5.086234] systemd[1]: Mounting POSIX Message Queue File System...
[    5.086804] systemd[1]: Mounting Kernel Debug File System...
[    5.087512] systemd[1]: Mounting Kernel Trace File System...
[    5.088183] systemd[1]: Starting Create List of Static Device Nodes...
[    5.088825] systemd[1]: Starting Load Kernel Module configfs...
[    5.089733] systemd[1]: Starting Load Kernel Module dm_mod...
[    5.090513] systemd[1]: Starting Load Kernel Module drm...
[    5.091360] systemd[1]: Starting Load Kernel Module fuse...
[    5.092262] systemd[1]: Starting Load Kernel Module loop...
[    5.093922] systemd[1]: Starting Journal Service...
[    5.095209] systemd[1]: Starting Load Kernel Modules...
[    5.095281] systemd[1]: TPM2 PCR Machine ID Measurement was skipped beca=
use of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    5.095945] systemd[1]: Starting Remount Root and Kernel File Systems...
[    5.096024] systemd[1]: TPM2 SRK Setup (Early) was skipped because of an=
 unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    5.096752] systemd[1]: Starting Coldplug All udev Devices...
[    5.098177] systemd[1]: Mounted Huge Pages File System.
[    5.098378] systemd[1]: Mounted POSIX Message Queue File System.
[    5.098540] systemd[1]: Mounted Kernel Debug File System.
[    5.098697] systemd[1]: Mounted Kernel Trace File System.
[    5.099002] systemd[1]: Finished Create List of Static Device Nodes.
[    5.099410] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    5.099595] systemd[1]: Finished Load Kernel Module configfs.
[    5.099905] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    5.100037] systemd[1]: Finished Load Kernel Module drm.
[    5.100959] systemd[1]: Mounting Kernel Configuration File System...
[    5.101841] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    5.102221] loop: module loaded
[    5.102849] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    5.103042] systemd[1]: Finished Load Kernel Module loop.
[    5.105200] device-mapper: uevent: version 1.0.3
[    5.105293] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    5.105929] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    5.106116] systemd[1]: Finished Load Kernel Module dm_mod.
[    5.106339] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    5.107161] systemd[1]: Mounted Kernel Configuration File System.
[    5.107919] systemd-journald[372]: Collecting audit messages is disabled.
[    5.108184] fuse: init (API version 7.40)
[    5.108285] Asymmetric key parser 'pkcs8' registered
[    5.108816] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    5.108956] systemd[1]: Finished Load Kernel Module fuse.
[    5.109705] systemd[1]: Finished Load Kernel Modules.
[    5.110932] systemd[1]: Mounting FUSE Control File System...
[    5.112178] systemd[1]: Starting Apply Kernel Variables...
[    5.116317] systemd[1]: Mounted FUSE Control File System.
[    5.118150] systemd[1]: Starting User Database Manager...
[    5.121148] systemd[1]: Finished Apply Kernel Variables.
[    5.121612] BTRFS info (device nvme0n1p10 state M): use lzo compression,=
 level 0
[    5.122498] systemd[1]: Finished Remount Root and Kernel File Systems.
[    5.123698] systemd[1]: Rebuild Hardware Database was skipped because no=
 trigger condition checks were met.
[    5.124539] systemd[1]: Starting Load/Save OS Random Seed...
[    5.124925] systemd[1]: TPM2 SRK Setup was skipped because of an unmet c=
ondition check (ConditionSecurity=3Dmeasured-uki).
[    5.134732] systemd[1]: Finished Load/Save OS Random Seed.
[    5.139511] systemd[1]: Started User Database Manager.
[    5.148916] systemd[1]: Started Journal Service.
[    5.162454] systemd-journald[372]: Received client request to flush runt=
ime journal.
[    5.184156] systemd-journald[372]: /var/log/journal/7bfb25584b964a788001=
ba83cd062386/system.journal: Journal file uses a different sequence number =
ID, rotating.
[    5.184159] systemd-journald[372]: Rotating system journal.
[    5.572833] input: DELL Wireless hotkeys as /devices/virtual/input/input6
[    5.594543] ccp 0000:04:00.2: enabling device (0000 -> 0002)
[    5.595828] ccp 0000:04:00.2: ccp: unable to access the device: you migh=
t be running a broken BIOS.
[    5.597033] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, re=
vision 0
[    5.597039] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port=
 selection
[    5.597104] ccp 0000:04:00.2: tee enabled
[    5.597188] ccp 0000:04:00.2: psp enabled
[    5.608146] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at=
 0xb20
[    5.611406] input: PC Speaker as /devices/platform/pcspkr/input/input7
[    5.612022] ACPI: battery: new extension: Dell DDV Battery Extension
[    5.629336] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840=
 ms ovfl timer
[    5.629339] RAPL PMU: hw unit of domain package 2^-16 Joules
[    5.647143] cryptd: max_cpu_qlen set to 1000
[    5.648112] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    5.648247] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    5.648365] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    5.720595] Adding 20971516k swap on /dev/nvme0n1p11.  Priority:-2 exten=
ts:1 across:20971516k SS
[    5.751440] input: DELL0B7D:00 06CB:CE26 Mouse as /devices/platform/AMDI=
0010:03/i2c-0/i2c-DELL0B7D:00/0018:06CB:CE26.0002/input/input9
[    5.751497] input: DELL0B7D:00 06CB:CE26 Touchpad as /devices/platform/A=
MDI0010:03/i2c-0/i2c-DELL0B7D:00/0018:06CB:CE26.0002/input/input10
[    5.751560] hid-generic 0018:06CB:CE26.0002: input,hidraw1: I2C HID v1.0=
0 Mouse [DELL0B7D:00 06CB:CE26] on i2c-DELL0B7D:00
[    5.757767] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    5.757861] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO ad=
dress
[    5.757975] sp5100-tco sp5100-tco: initialized. heartbeat=3D60 sec (nowa=
yout=3D0)
[    5.761799] snd_rn_pci_acp3x 0000:04:00.5: enabling device (0000 -> 0002)
[    5.765370] AVX2 version of gcm_enc/dec engaged.
[    5.765417] AES CTR mode by8 optimization enabled
[    5.781155] input: Dell WMI hotkeys as /devices/platform/PNP0C14:01/wmi_=
bus/wmi_bus-PNP0C14:01/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input12
[    5.805429] r8169 0000:02:00.0 eth0: RTL8168h/8111h, 04:bf:1b:0e:8a:e9, =
XID 541, IRQ 85
[    5.805437] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    5.807599] r8169 0000:02:00.0 enp2s0: renamed from eth0
[    5.885047] input: DELL0B7D:00 06CB:CE26 Mouse as /devices/platform/AMDI=
0010:03/i2c-0/i2c-DELL0B7D:00/0018:06CB:CE26.0002/input/input13
[    5.885132] input: DELL0B7D:00 06CB:CE26 Touchpad as /devices/platform/A=
MDI0010:03/i2c-0/i2c-DELL0B7D:00/0018:06CB:CE26.0002/input/input14
[    5.885202] hid-multitouch 0018:06CB:CE26.0002: input,hidraw1: I2C HID v=
1.00 Mouse [DELL0B7D:00 06CB:CE26] on i2c-DELL0B7D:00
[    5.920023] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
[    5.920106] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio clie=
nt
[    5.920160] snd_hda_intel 0000:04:00.6: enabling device (0000 -> 0002)
[    5.956066] mousedev: PS/2 mouse device common for all mice
[    5.956379] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[    5.957614] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:08.1/0000:04:00.1/sound/card0/input16
[    5.960574] rtw_8821ce 0000:03:00.0: enabling device (0000 -> 0003)
[    5.962048] rtw_8821ce 0000:03:00.0: Firmware version 24.11.0, H2C versi=
on 12
[    5.969327] kvm_amd: TSC scaling supported
[    5.969330] kvm_amd: Nested Virtualization enabled
[    5.969331] kvm_amd: Nested Paging enabled
[    5.969340] kvm_amd: Virtual VMLOAD VMSAVE supported
[    5.969341] kvm_amd: Virtual GIF supported
[    5.969342] kvm_amd: LBR virtualization supported
[    5.974230] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3254: l=
ine_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    5.974235] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    5.974237] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    5.974239] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0
[    5.974241] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    5.974243] snd_hda_codec_realtek hdaudioC1D0:      Headset Mic=3D0x19
[    5.974245] snd_hda_codec_realtek hdaudioC1D0:      Headphone Mic=3D0x1b
[    6.137180] intel_rapl_common: Found RAPL domain package
[    6.137186] intel_rapl_common: Found RAPL domain core
[    6.137590] AMD Address Translation Library initialized
[    6.438962] NET: Registered PF_ALG protocol family
[    6.441907] 8021q: 802.1Q VLAN Support v1.8
[    6.487071] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
[    6.635973] input: HD-Audio Generic Headphone Mic as /devices/pci0000:00=
/0000:00:08.1/0000:04:00.6/sound/card1/input17
[    6.688012] mc: Linux media interface: v0.10
[    6.710495] r8169 0000:02:00.0 enp2s0: Link is Down
[    6.716788] Bluetooth: Core ver 2.22
[    6.716810] NET: Registered PF_BLUETOOTH protocol family
[    6.716811] Bluetooth: HCI device and connection manager initialized
[    6.716815] Bluetooth: HCI socket layer initialized
[    6.716817] Bluetooth: L2CAP socket layer initialized
[    6.716822] Bluetooth: SCO socket layer initialized
[    6.719101] videodev: Linux video capture interface: v2.00
[    6.849143] usb 3-4: Found UVC 1.00 device Integrated_Webcam_FHD (0c45:6=
739)
[    6.851974] usbcore: registered new interface driver btusb
[    6.861598] usbcore: registered new interface driver uvcvideo
[    7.057206] Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c =
lmp_ver=3D08 lmp_subver=3D8821
[    7.059187] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[    7.059216] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[    7.062671] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[    7.063326] Bluetooth: hci0: RTL: cfg_sz 10, total sz 34926
[    7.665203] Bluetooth: hci0: RTL: fw version 0x75b8f098
[    9.186571] wlan0: authenticate with d1:32:e5:a4:ca:11 (local address=3D=
da:10:ac:14:4a:c4)
[    9.210724] wlan0: send auth to d1:32:e5:a4:ca:11 (try 1/3)
[    9.213298] wlan0: authenticated
[    9.213353] wlan0: associating to AP d1:32:e5:a4:ca:11 with corrupt prob=
e response
[    9.213790] wlan0: associate with d1:32:e5:a4:ca:11 (try 1/3)
[    9.222887] wlan0: RX AssocResp from d1:32:e5:a4:ca:11 (capab=3D0x411 st=
atus=3D0 aid=3D2)
[    9.223192] wlan0: associated
[   14.268760] systemd-journald[372]: /var/log/journal/7bfb25584b964a788001=
ba83cd062386/user-1000.journal: Journal file uses a different sequence numb=
er ID, rotating.
[   20.840672] warning: `iwconfig' uses wireless extensions which will stop=
 working for Wi-Fi 7 hardware; use nl80211
[   20.933920] wlan0: deauthenticating from d1:32:e5:a4:ca:11 by local choi=
ce (Reason: 3=3DDEAUTH_LEAVING)
[   23.269105] rtw_8821ce 0000:03:00.0 wlan0: entered promiscuous mode
[   23.269111] rtw_8821ce 0000:03:00.0 wlan0: entered allmulticast mode

--xsk57s3fkcfezwct--

--ccxtag5vfjlljsoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZVxRMACgkQwEfU8yi1
JYVxQw//SkhMZqCUTuhndJV2b9CzHlmwecFYpimxdrH3c04b7qbdqdqJYS1fgwBj
7FmnMKiOhVx7js/23pK3BJ8Z0lDcXlSUI3DnukG8TwPjVmtlt4FzUy/E4Xp7JqQB
YTeDimBbp9wOrEZWrMmx3x1GUnDFlEBwXHAV5kR/HsnOaaZqjz0R5Mb0h9eZFZ6o
xiGh8O9eZ/7Dtg/wV92Iyr7e+bAhK0BQE1cvaCuq/k4U6CeoLOj+lSqfk+T+81wt
pfgXDsAepvqXKJGP4OdwwKf+Jf8ecwitagmJaMm6G3A9nA1xPLaFaynPr/IwbGMb
yI/hAVlLX7Ls2HRnEloekliGOTGBudh1yRMEVgbqVIXg3W+nw4869pJ9ROlZE6iZ
hWtR51fwbRgmdYifYRKYoV3769gDvABWfRSA3bRnYNNo4POTlX+uIWGEHYpljg/N
Y1fSFtZViqnHmywQs05Acg68HcdrvXf9ybX+Q0mkUSQ68J4xNJtvIVw8+c6z1vsx
z2dI8U+DwtS5Ll+qVsdC6OjL3wQ9fxjrgYDgLIyzezFHIFyPZp9mIw1eX7Ap6tSu
RISSAUxAaOK16rPM9mbOqUvsba5P+wJFKumMZvrEJ5W4n60V/0n33TBFJ2YrQwcU
h1fnuSkAjBzTh976zBD+RmGMzljaSruwd4tive60oyN9MHWVg2s=
=baMg
-----END PGP SIGNATURE-----

--ccxtag5vfjlljsoq--

