Return-Path: <linux-wireless+bounces-37761-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CFOJDCoELWpzZAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37761-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 09:18:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1C567DF75
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 09:18:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G+WLGU8i;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37761-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37761-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF7553010DA1
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 07:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267CE2EDD40;
	Sat, 13 Jun 2026 07:17:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4431D6BB
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 07:17:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781335078; cv=none; b=klqVU/CHEwdfmAq1+KCWNE0rQ5o3Po5gPY+Kau+GqwUUROHwiMlW8uTnMO/Cl+2CxXo1GtuQpAEJMesArQImpE6kLj6Mji5LfzvsFSKj848idN82I+4OLvg2iqDATFEUQ50btoix5cpn7H+lF4o+w9rtbQuoO0GNzvQ7skZeLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781335078; c=relaxed/simple;
	bh=HsSW3RgP2gP2ZNrAvi9O+p9gE0C6XM56yw+ewyFUXMI=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=tqPXP1oNSUY4xeAumi6+4aNgPYSZ/548VQLg/bUNeOt2f1iZN7bkPhJNtdN7TXRGIYUPU4BEHR9mwi3OKMYdFnzAQ9DcNWrmxi0yDKP3KHMvD9R6uoAaHQ0a4Qj5aktglLGb1gt8wWUlCnNj8NjJS5MUvVR16mwm2RVGXqsrnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+WLGU8i; arc=none smtp.client-ip=74.125.82.170
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3074adb8fcaso935923eec.0
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781335070; x=1781939870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:to:reply-to
         :content-language:references:subject:from:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jFtK7d7136wHBNUFNh0i2NEwHU3R+NU8Fo5by9gTZ5I=;
        b=G+WLGU8iWF8pentEKQdTKo16rfJ9Qx1fujMKFT+1T2azlkApS0uw5t4pIc5ojrQhRe
         NpPe6fIonObpSsgLwtbikqvFbgpWNbMv91XF1Y3EtWPHZj3Ha/LECk0WgwlQbui51RW/
         gZ9++fw48Gat7TcmOn9AAQhr5LHwv18JIcExRt3oi7VehiWZvajKKOdfQS8p/yt1BRc9
         UD8Jx/4w+09VUYfQn4cIRypEfF817heuUGOaAWXWkTPTWx3+nnU66jBr9wtVLal/LDgO
         qqiHqtWHGn/TycoprtxwVVAjEONflrvPDyJ6Be9KmXa6215BmJYGX2vd3uNcczDbFFGv
         g+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781335070; x=1781939870;
        h=content-transfer-encoding:in-reply-to:cc:to:reply-to
         :content-language:references:subject:from:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFtK7d7136wHBNUFNh0i2NEwHU3R+NU8Fo5by9gTZ5I=;
        b=PJhVVpEnIVfnmijnlV/vM6+Chjv19fj9j/C4MKEe8M/9d7vfNTt6sPaNOXaDNe4OYT
         JcK75axJwB1LN8UcuY6QBFNMVZ1CuYfhdj4qmhHMysdQRVcyi5ZyuTGtyU/hzM29m/hl
         ENn/nbmWxC1fCi1IOwuSNkKFwZgE+vnDZ3JYo8FpodNnlggjSNf43wNz48zanP19YMEl
         zJEA8+alMISDAnV111kVnPvGvgqvUJ/MSUF/z8ELQBsPYcN0hDM+XtmsgHlNANjZgyZy
         gQyXNzCzSasoAlYsh1TJKPEWxqJj4x7y8j0w8lOR++7qBRqKxgGKFV4iMIqT8/LrEEN3
         gc9g==
X-Forwarded-Encrypted: i=1; AFNElJ/FR/Z+4VyuOCpw+HUbDXpn8h0h95FRajqjbD6qi+tCeqwmpOyOXvCqklF4fZpS5RiiXyvqqfqeTgW8a30+9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLepys+6IDSLI6QjgCXbcnSEPcpzAUwztdgKTbw+pHuZV6t5wi
	RjFA7tDphETZNkAtsAe7+X4jq1i3kJ5CVX1n2fw84ekjebgjHg5duZcX4+V1YSqX7m0=
X-Gm-Gg: Acq92OFWJbq1mZ1R4eLXZG40LTltABHMpFgF5+TlXFdzNv9CJ45H60k60pO7rLuNH+9
	TVfjDUEyvw9JZZvdxByxt/z23RES9mNhk0g90J+N9VQM2H7JcG0N+j5G9apShlSiPl63fJ9xkI9
	Zmi5U3h5+FPFuAU0Q6FpWUDbq7okoXGVc4x/ac1LcKEwBgOBCX5Hq02VafR50v9OV38NFuxd/iW
	YtRb3BUwe4wnGQkMwmHYYKjyh0PEx82tYHhYG5bAYjSOwBhsLC1e5xbnM4k0RJzaDVlMBS+7lvq
	HE3hS8NqfvBE6jKiW3hPlfBfUWvvr2D6+nWt1fDaIzGTzzlPL4dJkbCb2x1K6F9nUao8ibSPIQ2
	cj5tT5Gr4yVc9gumMQzn3r7o0NF8PhhMDsKN+cwg+sD7aZLxafXaWRaPcb5Hva9Vv1tF89nvLWj
	zDFi4137m+k32m9B9a0UjzDBsX10Q1yZ6Zp273qrZaCRF3J2Q03s9tB+dF+YopmRiqsAUjvvcRy
	bUgxdCxm8B2O+9B0A==
X-Received: by 2002:a05:7300:320f:b0:304:5644:f97a with SMTP id 5a478bee46e88-3082009bf0fmr3533745eec.21.1781335069312;
        Sat, 13 Jun 2026 00:17:49 -0700 (PDT)
Received: from ?IPV6:2806:269:481:219f:2864:9007:e863:5642? ([2806:269:481:219f:2864:9007:e863:5642])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ddaf69asm7052173eec.0.2026.06.13.00.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 00:17:48 -0700 (PDT)
Message-ID: <2f82fb71-9ecd-4370-9468-92bc987f72c9@gmail.com>
Date: Sat, 13 Jun 2026 00:17:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Angel Parra <jesusnavarrojr188@gmail.com>
Subject: [RESEND] Ongoing instability and connection loops with MT7922
 (mt7921e driver)
References: <abe71e0f-bd5d-4800-aa82-8ad3fcfdd663@gmail.com>
Content-Language: en-US
Reply-To: Angel Parra <jesusnavarrojr188@gmail.com>
To: morrownr@gmail.com
Cc: Sean.Wang@mediatek.com, =?UTF-8?Q?Jes=C3=BAs_Navarro_Parra?=
 <jesusnavarrojr188@gmail.com>,
 Linux Wireless Mailing List <linux-wireless@vger.kernel.org>,
 lorenzo@kernel.org, nbd@nbd.name, Bitterblue Smith
 <rtl8821cerfe2@gmail.com>,
 "rtl8821cerfe2@gmail.com >> Bitterblue Smith" <rtl8821cerfe2@gmail.com>,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com
In-Reply-To: <abe71e0f-bd5d-4800-aa82-8ad3fcfdd663@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37761-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:morrownr@gmail.com,m:Sean.Wang@mediatek.com,m:jesusnavarrojr188@gmail.com,m:linux-wireless@vger.kernel.org,m:lorenzo@kernel.org,m:nbd@nbd.name,m:rtl8821cerfe2@gmail.com,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,vger.kernel.org,kernel.org,nbd.name];
	FORGED_SENDER(0.00)[jesusnavarrojr188@gmail.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jesusnavarrojr188@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[jesusnavarrojr188@gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF1C567DF75


Hello, Bitterblue!

Details:

Laptop model: Asus Zenbook Pro 17
WiFi card PCI id: 02:00.0 Network controller [0280]: MEDIATEK Corp. 
MT7922 802.11ax PCI Express Wireless Network Adapter [14c3
:0616]
Distro: Arch Linux (just Arch Linux, it's rolling release)


I added the disable_aspm and tried for a while, but when a wall was 
again between the modem and the laptop, it still abruptly disconnected 
and still took a long long time on "Configuring interfaces" just to fail 
right away.

dmesg output now that it has disconnected abruptly even with disable_aspm:

[    0.000000] Linux version 7.0.12-zen1-1-zen (linux-zen@archlinux) 
(gcc (GCC) 16.1.1 20260430, GNU ld (GNU Binutils) 2.46.0) #1 ZEN SMP 
PREEMPT_DYNAMIC Wed, 10 Jun 2026 08:57:50 +0000
[    0.000000] Command line: quiet loglevel=2 udev.log_priority=3 
rd.udev.log_level=2 bgrt_disable=1 splash modeset=1 preempt=voluntary 
amd_iommu=on iommu=pt pcie_aspm.policy=performance 
sysrq_always_enabled=1 
rd.luks.name=c04e1ef4-24dc-46ac-b697-4c3acab6d213=malasdecisiones 
rd.luks.options=timeout=0,discard 
rootflags=x-systemd.device-timeout=0,subvol=/@,compress=zstd:8 
rootfstype=btrfs root=UUID=22b6302a-51c8-4c7b-b0f0-40b7baa5421c
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff]  
System RAM
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff]  
device reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfefff]  
System RAM
[    0.000000] BIOS-e820: [mem 0x0000000009bff000-0x0000000009ffffff]  
device reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff]  
System RAM
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a227fff]  
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a228000-0x00000000905b4fff]  
System RAM
[    0.000000] BIOS-e820: [mem 0x00000000905b5000-0x0000000093104fff]  
device reserved
[    0.000000] BIOS-e820: [mem 0x0000000093105000-0x0000000093189fff]  
ACPI data
[    0.000000] BIOS-e820: [mem 0x000000009318a000-0x0000000098202fff]  
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000098203000-0x00000000995fdfff]  
device reserved
[    0.000000] BIOS-e820: [mem 0x00000000995fe000-0x00000000995fefff]  
System RAM
[    0.000000] BIOS-e820: [mem 0x00000000995ff000-0x00000000995fffff]  
device reserved
[    0.000000] BIOS-e820: [mem 0x0000000099600000-0x000000009affcfff]  
System RAM
[    0.000000] BIOS-e820: [mem 0x000000009affd000-0x000000009bffffff]  
device reserved
[    0.000000] BIOS-e820: [gap 0x000000009c000000-0x000000009cdfffff]
[    0.000000] BIOS-e820: [mem 0x000000009ce00000-0x000000009fffffff]  
device reserved
[    0.000000] BIOS-e820: [gap 0x00000000a0000000-0x00000000dfffffff]
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff]  
device reserved
[    0.000000] BIOS-e820: [gap 0x00000000f0000000-0x00000000fcffffff]
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff]  
device reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000043e2fffff]  
System RAM
[    0.000000] BIOS-e820: [gap 0x000000043e300000-0x000000043f33ffff]
[    0.000000] BIOS-e820: [mem 0x000000043f340000-0x00000004801fffff]  
device reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.8 by American Megatrends
[    0.000000] efi: ACPI=0x93189000 ACPI 2.0=0x93189014 
TPMFinalLog=0x981b6000 SMBIOS=0x99376000 SMBIOS 3.0=0x99375000 
MEMATTR=0x87f74018 ESRT=0x87f77f18 INITRD=0x87f52f98 RNG=0x9311e018 
TPMEventLog=0x93119018
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem64: MMIO range=[0xe0000000-0xefffffff] 
(256MB) from e820 map
[    0.000000] e820: remove [mem 0xe0000000-0xefffffff] device reserved
[    0.000000] efi: Remove mem65: MMIO range=[0xfd000000-0xfedfffff] 
(30MB) from e820 map
[    0.000000] e820: remove [mem 0xfd000000-0xfedfffff] device reserved
[    0.000000] efi: Not removing mem66: MMIO 
range=[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem67: MMIO range=[0xfee01000-0xffffffff] 
(17MB) from e820 map
[    0.000000] e820: remove [mem 0xfee01000-0xffffffff] device reserved
[    0.000000] efi: Remove mem69: MMIO range=[0x460000000-0x4801fffff] 
(514MB) from e820 map
[    0.000000] e820: remove [mem 0x460000000-0x4801fffff] device reserved
[    0.000000] SMBIOS 3.4.0 present.
[    0.000000] DMI: ASUSTeK COMPUTER INC. Zenbook 
UM6702RC_RM6702RC_BM6702RC UM6702RC_UM6702RC/UM6702RC, BIOS UM6702RC.320 
02/21/2023
[    0.000000] DMI: Memory slots populated: 4/4
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3293.479 MHz processor
[    0.000135] e820: update [mem 0x00000000-0x00000fff] System RAM ==> 
device reserved
[    0.000136] e820: remove [mem 0x000a0000-0x000fffff] System RAM
[    0.000140] last_pfn = 0x43e300 max_arch_pfn = 0x400000000
[    0.000146] MTRR map: 6 entries (3 fixed + 3 variable; max 20), built 
from 9 variable MTRRs
[    0.000147] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB WP  UC- WT
[    0.000472] last_pfn = 0x9affd max_arch_pfn = 0x400000000
[    0.003159] esrt: Reserving ESRT space from 0x0000000087f77f18 to 
0x0000000087f77f50.
[    0.003164] e820: update [mem 0x87f77000-0x87f77fff] System RAM ==> 
device reserved
[    0.003175] Using GB pages for direct mapping
[    0.003303] Secure boot enabled
[    0.003303] RAMDISK: [mem 0x65774000-0x759d0fff]
[    0.003510] ACPI: Early table checksum verification disabled
[    0.003513] ACPI: RSDP 0x0000000093189014 000024 (v02 _ASUS_)
[    0.003516] ACPI: XSDT 0x0000000093188728 00014C (v01 _ASUS_ Notebook 
01072009 AMI  01000013)
[    0.003519] ACPI: FACP 0x000000009317B000 000114 (v06 _ASUS_ Notebook 
01072009 AMI  00010013)
[    0.003523] ACPI: DSDT 0x000000009316B000 00FDC5 (v02 _ASUS_ Notebook 
01072009 INTL 20200717)
[    0.003524] ACPI: FACS 0x00000000981B4000 000040
[    0.003526] ACPI: MSDM 0x0000000093187000 000055 (v03 _ASUS_ Notebook 
01072009 ASUS 00000001)
[    0.003527] ACPI: SSDT 0x0000000093186000 000573 (v01 AMD ACDC    
  00000001 INTL 20200717)
[    0.003528] ACPI: SSDT 0x0000000093185000 0001CC (v01 AMD STD3    
  00000001 INTL 20200717)
[    0.003530] ACPI: SSDT 0x000000009317D000 007F5B (v02 AMD AmdTable 
00000002 MSFT 02000002)
[    0.003531] ACPI: IVRS 0x000000009317C000 0001A4 (v02 AMD AmdTable 
00000001 AMD  00000001)
[    0.003532] ACPI: FIDT 0x000000009316A000 00009C (v01 _ASUS_ Notebook 
01072009 AMI  00010013)
[    0.003534] ACPI: ECDT 0x0000000093169000 0000C1 (v01 _ASUS_ Notebook 
01072009 AMI. 00000005)
[    0.003535] ACPI: MCFG 0x0000000093168000 00003C (v01 _ASUS_ Notebook 
01072009 MSFT 00010013)
[    0.003536] ACPI: FPDT 0x0000000093167000 000044 (v01 _ASUS_ A M I    
01072009 AMI  01000013)
[    0.003538] ACPI: VFCT 0x000000009315C000 00AE84 (v01 _ASUS_ Notebook 
00000001 AMD  31504F47)
[    0.003539] ACPI: BGRT 0x000000009315B000 000038 (v01 _ASUS_ Notebook 
01072009 AMI  00010013)
[    0.003540] ACPI: TPM2 0x000000009315A000 00004C (v04 _ASUS_ Notebook 
00000001 AMI  00000000)
[    0.003541] ACPI: SSDT 0x0000000093154000 005354 (v02 AMD AmdTable 
00000001 AMD  00000001)
[    0.003543] ACPI: CRAT 0x0000000093153000 000EE8 (v01 AMD AmdTable 
00000001 AMD  00000001)
[    0.003544] ACPI: CDIT 0x0000000093152000 000029 (v01 AMD AmdTable 
00000001 AMD  00000001)
[    0.003545] ACPI: SSDT 0x0000000093150000 001598 (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003547] ACPI: SSDT 0x000000009314E000 00156D (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003548] ACPI: SSDT 0x000000009314D000 000024 (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003549] ACPI: SSDT 0x0000000093149000 003CE8 (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003550] ACPI: SSDT 0x0000000093148000 00081C (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003552] ACPI: SSDT 0x0000000093147000 0000D3 (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003553] ACPI: SSDT 0x000000009313F000 007EB4 (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003554] ACPI: WSMT 0x000000009313E000 000028 (v01 _ASUS_ Notebook 
01072009 AMI  00010013)
[    0.003555] ACPI: APIC 0x000000009313D000 0000E8 (v03 _ASUS_ Notebook 
01072009 AMI  00010013)
[    0.003557] ACPI: SSDT 0x000000009313B000 001F2A (v01 AMD AOD      
00000001 INTL 20200717)
[    0.003558] ACPI: SSDT 0x000000009313A000 0007CF (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003559] ACPI: SSDT 0x0000000093138000 00109D (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003561] ACPI: SSDT 0x000000009312E000 009471 (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003562] ACPI: SSDT 0x0000000093128000 00501A (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003563] ACPI: SSDT 0x0000000093127000 0009CD (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003565] ACPI: SSDT 0x0000000093126000 00008D (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003566] ACPI: SSDT 0x0000000093124000 001126 (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003567] ACPI: SSDT 0x0000000093123000 0009C6 (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003568] ACPI: SSDT 0x0000000093122000 000C0C (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003570] ACPI: SSDT 0x0000000093121000 0006D2 (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003571] ACPI: SSDT 0x000000009311F000 001638 (v01 AMD AmdTable 
00000001 INTL 20200717)
[    0.003572] ACPI: Reserving FACP table memory at [mem 
0x9317b000-0x9317b113]
[    0.003573] ACPI: Reserving DSDT table memory at [mem 
0x9316b000-0x9317adc4]
[    0.003573] ACPI: Reserving FACS table memory at [mem 
0x981b4000-0x981b403f]
[    0.003574] ACPI: Reserving MSDM table memory at [mem 
0x93187000-0x93187054]
[    0.003574] ACPI: Reserving SSDT table memory at [mem 
0x93186000-0x93186572]
[    0.003575] ACPI: Reserving SSDT table memory at [mem 
0x93185000-0x931851cb]
[    0.003575] ACPI: Reserving SSDT table memory at [mem 
0x9317d000-0x93184f5a]
[    0.003575] ACPI: Reserving IVRS table memory at [mem 
0x9317c000-0x9317c1a3]
[    0.003576] ACPI: Reserving FIDT table memory at [mem 
0x9316a000-0x9316a09b]
[    0.003576] ACPI: Reserving ECDT table memory at [mem 
0x93169000-0x931690c0]
[    0.003576] ACPI: Reserving MCFG table memory at [mem 
0x93168000-0x9316803b]
[    0.003577] ACPI: Reserving FPDT table memory at [mem 
0x93167000-0x93167043]
[    0.003577] ACPI: Reserving VFCT table memory at [mem 
0x9315c000-0x93166e83]
[    0.003577] ACPI: Reserving BGRT table memory at [mem 
0x9315b000-0x9315b037]
[    0.003578] ACPI: Reserving TPM2 table memory at [mem 
0x9315a000-0x9315a04b]
[    0.003578] ACPI: Reserving SSDT table memory at [mem 
0x93154000-0x93159353]
[    0.003579] ACPI: Reserving CRAT table memory at [mem 
0x93153000-0x93153ee7]
[    0.003579] ACPI: Reserving CDIT table memory at [mem 
0x93152000-0x93152028]
[    0.003579] ACPI: Reserving SSDT table memory at [mem 
0x93150000-0x93151597]
[    0.003580] ACPI: Reserving SSDT table memory at [mem 
0x9314e000-0x9314f56c]
[    0.003580] ACPI: Reserving SSDT table memory at [mem 
0x9314d000-0x9314d023]
[    0.003580] ACPI: Reserving SSDT table memory at [mem 
0x93149000-0x9314cce7]
[    0.003581] ACPI: Reserving SSDT table memory at [mem 
0x93148000-0x9314881b]
[    0.003581] ACPI: Reserving SSDT table memory at [mem 
0x93147000-0x931470d2]
[    0.003581] ACPI: Reserving SSDT table memory at [mem 
0x9313f000-0x93146eb3]
[    0.003582] ACPI: Reserving WSMT table memory at [mem 
0x9313e000-0x9313e027]
[    0.003582] ACPI: Reserving APIC table memory at [mem 
0x9313d000-0x9313d0e7]
[    0.003583] ACPI: Reserving SSDT table memory at [mem 
0x9313b000-0x9313cf29]
[    0.003583] ACPI: Reserving SSDT table memory at [mem 
0x9313a000-0x9313a7ce]
[    0.003583] ACPI: Reserving SSDT table memory at [mem 
0x93138000-0x9313909c]
[    0.003584] ACPI: Reserving SSDT table memory at [mem 
0x9312e000-0x93137470]
[    0.003584] ACPI: Reserving SSDT table memory at [mem 
0x93128000-0x9312d019]
[    0.003584] ACPI: Reserving SSDT table memory at [mem 
0x93127000-0x931279cc]
[    0.003585] ACPI: Reserving SSDT table memory at [mem 
0x93126000-0x9312608c]
[    0.003585] ACPI: Reserving SSDT table memory at [mem 
0x93124000-0x93125125]
[    0.003586] ACPI: Reserving SSDT table memory at [mem 
0x93123000-0x931239c5]
[    0.003586] ACPI: Reserving SSDT table memory at [mem 
0x93122000-0x93122c0b]
[    0.003586] ACPI: Reserving SSDT table memory at [mem 
0x93121000-0x931216d1]
[    0.003587] ACPI: Reserving SSDT table memory at [mem 
0x9311f000-0x93120637]
[    0.003650] No NUMA configuration found
[    0.003650] Faking a node at [mem 0x0000000000000000-0x000000043e2fffff]
[    0.003654] NODE_DATA(0) allocated [mem 0x43e2d5280-0x43e2fffff]
[    0.003968] ACPI: PM-Timer IO Port: 0x808
[    0.003973] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.003985] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, 
GSI 0-23
[    0.003990] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, 
GSI 24-55
[    0.003991] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.003993] ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 1 low edge)
[    0.003993] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.003996] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.003998] CPU topo: Max. logical packages:   1
[    0.003999] CPU topo: Max. logical nodes:      1
[    0.003999] CPU topo: Num. nodes per package:  1
[    0.004000] CPU topo: Max. logical dies:       1
[    0.004001] CPU topo: Max. dies per package:   1
[    0.004003] CPU topo: Max. threads per core:   2
[    0.004003] CPU topo: Num. cores per package:     8
[    0.004004] CPU topo: Num. threads per package:  16
[    0.004004] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    0.004014] PM: hibernation: Registered nosave memory: [mem 
0x00000000-0x00000fff]
[    0.004015] PM: hibernation: Registered nosave memory: [mem 
0x000a0000-0x000fffff]
[    0.004016] PM: hibernation: Registered nosave memory: [mem 
0x09bff000-0x09ffffff]
[    0.004016] PM: hibernation: Registered nosave memory: [mem 
0x0a200000-0x0a227fff]
[    0.004017] PM: hibernation: Registered nosave memory: [mem 
0x87f77000-0x87f77fff]
[    0.004018] PM: hibernation: Registered nosave memory: [mem 
0x905b5000-0x995fdfff]
[    0.004018] PM: hibernation: Registered nosave memory: [mem 
0x995ff000-0x995fffff]
[    0.004019] PM: hibernation: Registered nosave memory: [mem 
0x9affd000-0xffffffff]
[    0.004020] [gap 0xa0000000-0xfedfffff] available for PCI devices
[    0.004021] Booting paravirtualized kernel on bare hardware
[    0.004023] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.008502] Zone ranges:
[    0.008503]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.008504]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.008504]   Normal   [mem 0x0000000100000000-0x000000043e2fffff]
[    0.008505]   Device   empty
[    0.008505] Movable zone start for each node
[    0.008506] Early memory node ranges
[    0.008506]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.008507]   node   0: [mem 0x0000000000100000-0x0000000009bfefff]
[    0.008508]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.008508]   node   0: [mem 0x000000000a228000-0x00000000905b4fff]
[    0.008509]   node   0: [mem 0x00000000995fe000-0x00000000995fefff]
[    0.008509]   node   0: [mem 0x0000000099600000-0x000000009affcfff]
[    0.008509]   node   0: [mem 0x0000000100000000-0x000000043e2fffff]
[    0.008511] Initmem setup node 0 [mem 
0x0000000000001000-0x000000043e2fffff]
[    0.008515] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.008529] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.008654] On node 0, zone DMA32: 1025 pages in unavailable ranges
[    0.011106] On node 0, zone DMA32: 40 pages in unavailable ranges
[    0.011307] On node 0, zone DMA32: 36937 pages in unavailable ranges
[    0.011341] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.027863] On node 0, zone Normal: 20483 pages in unavailable ranges
[    0.027904] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.027913] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 
nr_cpu_ids:16 nr_node_ids:1
[    0.028312] percpu: Embedded 63 pages/cpu s221184 r8192 d28672 u262144
[    0.028316] pcpu-alloc: s221184 r8192 d28672 u262144 alloc=1*2097152
[    0.028318] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 
12 13 14 15
[    0.028331] Kernel command line: quiet loglevel=2 udev.log_priority=3 
rd.udev.log_level=2 bgrt_disable=1 splash modeset=1 preempt=voluntary 
amd_iommu=on iommu=pt pcie_aspm.policy=performance 
sysrq_always_enabled=1 
rd.luks.name=c04e1ef4-24dc-46ac-b697-4c3acab6d213=malasdecisiones 
rd.luks.options=timeout=0,discard 
rootflags=x-systemd.device-timeout=0,subvol=/@,compress=zstd:8 
rootfstype=btrfs root=UUID=22b6302a-51c8-4c7b-b0f0-40b7baa5421c
[    0.028401] Dynamic Preempt: unsupported mode: voluntary
[    0.028411] AMD-Vi: Unknown option - 'on'
[    0.028428] sysrq: sysrq always enabled.
[    0.028452] Unknown kernel command line parameters "splash modeset=1 
preempt=voluntary", will be passed to user space.
[    0.028648] printk: log buffer data + meta data: 131072 + 557056 = 
688128 bytes
[    0.029841] Dentry cache hash table entries: 2097152 (order: 12, 
16777216 bytes, linear)
[    0.030474] Inode-cache hash table entries: 1048576 (order: 11, 
8388608 bytes, linear)
[    0.030584] software IO TLB: area num 16.
[    0.039771] Fallback order for Node 0: 0
[    0.039778] Built 1 zonelists, mobility grouping on.  Total pages: 
3997225
[    0.039779] Policy zone: Normal
[    0.039961] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.060187] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.070642] ftrace: allocating 55199 entries in 216 pages
[    0.070643] ftrace: allocated 216 pages with 4 groups
[    0.070719] Dynamic Preempt: full
[    0.070772] rcu: Preemptible hierarchical RCU implementation.
[    0.070773] rcu:     RCU restricting CPUs from NR_CPUS=8192 to 
nr_cpu_ids=16.
[    0.070774] rcu:     RCU priority boosting: priority 1 delay 500 ms.
[    0.070775]     Trampoline variant of Tasks RCU enabled.
[    0.070776]     Rude variant of Tasks RCU enabled.
[    0.070776]     Tracing variant of Tasks RCU enabled.
[    0.070777] rcu: RCU calculated value of scheduler-enlistment delay 
is 100 jiffies.
[    0.070777] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.070786] RCU Tasks: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
[    0.070789] RCU Tasks Rude: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
[    0.073965] NR_IRQS: 524544, nr_irqs: 1096, preallocated irqs: 16
[    0.074168] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[    0.074402] kfence: initialized - using 2097152 bytes for 255 objects 
at 0x(____ptrval____)-0x(____ptrval____)
[    0.074436] Console: colour dummy device 80x25
[    0.074437] printk: legacy console [tty0] enabled
[    0.074476] ACPI: Core revision 20251212
[    0.074653] APIC: Switch to symmetric I/O mode setup
[    0.075034] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:0xa0
[    0.075036] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:0xa0
[    0.075036] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:0xa0
[    0.075037] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:0xa0
[    0.075038] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
[    0.075378] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.076121] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.080660] clocksource: tsc-early: mask: 0xffffffffffffffff 
max_cycles: 0x2f793c6e6dd, max_idle_ns: 440795344023 ns
[    0.080665] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 6586.95 BogoMIPS (lpj=3293479)
[    0.080691] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.080715] LVT offset 1 assigned for vector 0xf9
[    0.080717] LVT offset 2 assigned for vector 0xf4
[    0.080863] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.080864] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.080866] process: using mwait in idle threads
[    0.080869] mitigations: Enabled attack vectors: user_kernel, 
user_user, guest_host, guest_guest, SMT mitigations: auto
[    0.080872] Speculative Store Bypass: Mitigation: Speculative Store 
Bypass disabled via prctl
[    0.080873] Speculative Return Stack Overflow: IBPB-extending 
microcode not applied!
[    0.080874] Speculative Return Stack Overflow: WARNING: See 
https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for 
mitigation options.
[    0.080874] Transient Scheduler Attacks: Vulnerable: No microcode
[    0.080875] Spectre V2 : Mitigation: Retpolines
[    0.080876] Spectre V2 : User space: Mitigation: STIBP always-on 
protection
[    0.080877] Speculative Return Stack Overflow: Vulnerable: Safe RET, 
no microcode
[    0.080878] VMSCAPE: Mitigation: IBPB before exit to userspace
[    0.080879] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[    0.080879] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on 
context switch and VMEXIT
[    0.080880] Spectre V2 : Enabling Restricted Speculation for firmware 
calls
[    0.080881] Spectre V2 : mitigation: Enabling conditional Indirect 
Branch Prediction Barrier
[    0.080882] active return thunk: srso_alias_return_thunk
[    0.080892] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating 
point registers'
[    0.080893] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.080893] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.080894] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys 
User registers'
[    0.080895] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow 
User registers'
[    0.080895] x86/fpu: Supporting XSAVE feature 0x1000: 'Control-flow 
Kernel registers (KVM only)'
[    0.080897] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]: 256
[    0.080898] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:   8
[    0.080898] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.080899] x86/fpu: xstate_offset[12]:  856, xstate_sizes[12]:   24
[    0.080899] x86/fpu: Enabled xstate features 0x1a07, context size is 
880 bytes, using 'compacted' format.
[    0.106289] Freeing SMP alternatives memory: 72K
[    0.106293] pid_max: default: 32768 minimum: 301
[    0.106429] landlock: Up and running.
[    0.106431] Yama: becoming mindful.
[    0.106654] LSM support for eBPF active
[    0.106708] Mount-cache hash table entries: 32768 (order: 6, 262144 
bytes, linear)
[    0.106727] Mountpoint-cache hash table entries: 32768 (order: 6, 
262144 bytes, linear)
[    0.106807] VFS: Finished mounting rootfs on nullfs
[    0.209736] smpboot: CPU0: AMD Ryzen 9 6900HX with Radeon Graphics 
(family: 0x19, model: 0x44, stepping: 0x1)
[    0.209957] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.209963] ... version:                   0
[    0.209964] ... bit width:                 48
[    0.209965] ... generic counters:          6
[    0.209966] ... generic bitmap:            000000000000003f
[    0.209967] ... fixed-purpose counters:    0
[    0.209968] ... fixed-purpose bitmap:      0000000000000000
[    0.209969] ... value mask:                0000ffffffffffff
[    0.209970] ... max period:                00007fffffffffff
[    0.209971] ... global_ctrl mask:          000000000000003f
[    0.210072] signal: max sigframe size: 3376
[    0.210431] rcu: Hierarchical SRCU implementation.
[    0.210433] rcu:     Max phase no-delay instances is 400.
[    0.210501] Timer migration: 2 hierarchy levels; 8 children per 
group; 2 crossnode level
[    0.217055] MCE: In-kernel MCE decoding enabled.
[    0.217094] NMI watchdog: Enabled. Permanently consumes one hw-PMU 
counter.
[    0.217213] smp: Bringing up secondary CPUs ...
[    0.217298] smpboot: x86: Booting SMP configuration:
[    0.217300] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  
#1  #3  #5  #7  #9 #11 #13 #15
[    0.228814] Spectre V2 : Update user space SMT mitigation: STIBP 
always-on
[    0.236680] smp: Brought up 1 node, 16 CPUs
[    0.236682] smpboot: Total of 16 processors activated (105391.32 
BogoMIPS)
[    0.240340] Memory: 15127052K/15988900K available (25071K kernel 
code, 3061K rwdata, 16560K rodata, 4968K init, 4984K bss, 839052K 
reserved, 0K cma-reserved)
[    0.243677] devtmpfs: initialized
[    0.244175] x86/mm: Memory block size: 128MB
[    0.247439] ACPI: PM: Registering ACPI NVS region [mem 
0x0a200000-0x0a227fff] (163840 bytes)
[    0.247439] ACPI: PM: Registering ACPI NVS region [mem 
0x9318a000-0x98202fff] (84381696 bytes)
[    0.248759] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.248759] posixtimers hash table entries: 8192 (order: 5, 131072 
bytes, linear)
[    0.248759] futex hash table entries: 4096 (262144 bytes on 1 NUMA 
nodes, total 256 KiB, linear).
[    0.248910] PM: RTC time: 05:33:05, date: 2026-06-13
[    0.249230] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.249694] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic 
allocations
[    0.249806] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for 
atomic allocations
[    0.249915] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for 
atomic allocations
[    0.249921] audit: initializing netlink subsys (disabled)
[    0.249927] audit: type=2000 audit(1781328785.174:1): 
state=initialized audit_enabled=0 res=1
[    0.249927] thermal_sys: Registered thermal governor 'fair_share'
[    0.249927] thermal_sys: Registered thermal governor 'bang_bang'
[    0.249927] thermal_sys: Registered thermal governor 'step_wise'
[    0.249927] thermal_sys: Registered thermal governor 'user_space'
[    0.249927] thermal_sys: Registered thermal governor 'power_allocator'
[    0.249927] cpuidle: using governor ladder
[    0.249927] cpuidle: using governor menu
[    0.255730] efi: Freeing EFI boot services memory: 158684K
[    0.255733] ACPI FADT declares the system doesn't support PCIe ASPM, 
so disable it
[    0.255735] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.255839] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) 
for domain 0000 [bus 00-ff]
[    0.255854] PCI: Using configuration type 1 for base access
[    0.256014] kprobes: kprobe jump-optimization is enabled. All kprobes 
are optimized if possible.
[    0.256014] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.256014] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.256014] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.256014] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.257827] raid6: skipped pq benchmark and selected avx2x4
[    0.257829] raid6: using avx2x2 recovery algorithm
[    0.257915] ACPI: Added _OSI(Module Device)
[    0.257916] ACPI: Added _OSI(Processor Device)
[    0.257918] ACPI: Added _OSI(Processor Aggregator Device)
[    0.294263] ACPI: 24 ACPI AML tables successfully acquired and loaded
[    0.296061] ACPI: EC: EC started
[    0.296062] ACPI: EC: interrupt blocked
[    0.296776] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.296777] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.297931] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.314962] ACPI: \_SB_: platform _OSC: OS support mask [006e7eff]
[    0.315096] ACPI: \_SB_: platform _OSC: OS control mask [006e7e7f]
[    0.315761] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ 
XDomain+
[    0.315763] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ 
XDomain+
[    0.316486] ACPI: Interpreter enabled
[    0.316501] ACPI: PM: (supports S0 S4 S5)
[    0.316503] ACPI: Using IOAPIC for interrupt routing
[    0.318226] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug
[    0.318228] PCI: Ignoring E820 reservations for host bridge windows
[    0.318778] ACPI: Enabled 2 GPEs in block 00 to 1F
[    0.320088] ACPI: \_SB_.PCI0.GPP1.P0NV: New power resource
[    0.321040] ACPI: \_SB_.PCI0.GPP0.M237: New power resource
[    0.322791] ACPI: \_SB_.PCI0.GPP8.P0NV: New power resource
[    0.325350] ACPI: \_SB_.PCI0.GP11.PWRS: New power resource
[    0.325713] ACPI: \_SB_.PCI0.GP11: Overriding _PRW sleep state (S4) 
by S0 from power resources
[    0.327105] ACPI: \_SB_.PCI0.GP11.SWUS.PWRS: New power resource
[    0.328830] ACPI: \_SB_.PCI0.GP12.PWRS: New power resource
[    0.329183] ACPI: \_SB_.PCI0.GP12: Overriding _PRW sleep state (S4) 
by S0 from power resources
[    0.330560] ACPI: \_SB_.PCI0.GP12.SWUS.PWRS: New power resource
[    0.330900] ACPI: \_SB_.PCI0.GP17.PWRS: New power resource
[    0.331230] ACPI: \_SB_.PCI0.GP17.VGA_.PWRS: New power resource
[    0.331625] ACPI: \_SB_.PCI0.GP17.HDAU.PWRS: New power resource
[    0.331961] ACPI: \_SB_.PCI0.GP17.ACP_.PWRS: New power resource
[    0.332491] ACPI: \_SB_.PCI0.GP17.AZAL.PWRS: New power resource
[    0.333206] ACPI: \_SB_.PCI0.GP17.XHC0.PWRS: New power resource
[    0.333993] ACPI: \_SB_.PCI0.GP17.XHC0.RHUB.PRT4.BTPR: New power resource
[    0.334581] ACPI: \_SB_.PCI0.GP17.XHC1.PWRS: New power resource
[    0.335570] ACPI: \_SB_.PCI0.GP18.SATA.P0S0: New power resource
[    0.335602] ACPI: \_SB_.PCI0.GP18.SATA.P3S0: New power resource
[    0.336206] ACPI: \_SB_.PCI0.GP19.XHC2.PWRS: New power resource
[    0.337342] ACPI: \_SB_.PCI0.GP19.XHC3.PWRS: New power resource
[    0.338555] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
[    0.339783] ACPI: \_SB_.PCI0.GP19.NHI0.PWRS: New power resource
[    0.340383] ACPI: \_SB_.PCI0.GP19.NHI0: Overriding _PRW sleep state 
(S4) by S0 from power resources
[    0.341084] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
[    0.341649] ACPI: \_SB_.PCI0.GP19.NHI1: Overriding _PRW sleep state 
(S4) by S0 from power resources
[    0.349696] ACPI: \_SB_.PRWL: New power resource
[    0.351110] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.351116] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI EDR HPX-Type3]
[    0.351326] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug 
SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.351328] acpi PNP0A08:00: FADT indicates ASPM is unsupported, 
using BIOS configuration
[    0.351924] PCI host bridge to bus 0000:00
[    0.351928] pci_bus 0000:00: root bus resource [io 0x0000-0x03af window]
[    0.351930] pci_bus 0000:00: root bus resource [io 0x03e0-0x0cf7 window]
[    0.351931] pci_bus 0000:00: root bus resource [io 0x03b0-0x03df window]
[    0.351933] pci_bus 0000:00: root bus resource [io 0x0d00-0xefff window]
[    0.351934] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000dffff window]
[    0.351936] pci_bus 0000:00: root bus resource [mem 
0xa0000000-0xdfffffff window]
[    0.351937] pci_bus 0000:00: root bus resource [mem 
0x460000000-0x7fffffffff window]
[    0.351939] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.351954] pci 0000:00:00.0: [1022:14b5] type 00 class 0x060000 
conventional PCI endpoint
[    0.352084] pci 0000:00:00.2: [1022:14b6] type 00 class 0x080600 
conventional PCI endpoint
[    0.352194] pci 0000:00:01.0: [1022:14b7] type 00 class 0x060000 
conventional PCI endpoint
[    0.352267] pci 0000:00:01.1: [1022:14b8] type 01 class 0x060400 PCIe 
Root Port
[    0.352282] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.352286] pci 0000:00:01.1:   bridge window [io 0xe000-0xefff]
[    0.352289] pci 0000:00:01.1:   bridge window [mem 0xdc000000-0xdd0fffff]
[    0.352296] pci 0000:00:01.1:   bridge window [mem 
0x7e00000000-0x7f01ffffff 64bit pref]
[    0.352351] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.352509] pci 0000:00:02.0: [1022:14b7] type 00 class 0x060000 
conventional PCI endpoint
[    0.352594] pci 0000:00:02.2: [1022:14ba] type 01 class 0x060400 PCIe 
Root Port
[    0.352614] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.352622] pci 0000:00:02.2:   bridge window [mem 0xdda00000-0xddbfffff]
[    0.352705] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.352902] pci 0000:00:02.3: [1022:14ba] type 01 class 0x060400 PCIe 
Root Port
[    0.352922] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.352929] pci 0000:00:02.3:   bridge window [mem 0xddd00000-0xdddfffff]
[    0.353010] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.353196] pci 0000:00:02.4: [1022:14ba] type 01 class 0x060400 PCIe 
Root Port
[    0.353216] pci 0000:00:02.4: PCI bridge to [bus 04]
[    0.353223] pci 0000:00:02.4:   bridge window [mem 0xddc00000-0xddcfffff]
[    0.353303] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
[    0.353481] pci 0000:00:03.0: [1022:14b7] type 00 class 0x060000 
conventional PCI endpoint
[    0.353556] pci 0000:00:03.1: [1022:14cd] type 01 class 0x060400 PCIe 
Root Port
[    0.353578] pci 0000:00:03.1: PCI bridge to [bus 05-34]
[    0.353584] pci 0000:00:03.1:   bridge window [io 0xb000-0xcfff]
[    0.353587] pci 0000:00:03.1:   bridge window [mem 0xc4000000-0xdbffffff]
[    0.353596] pci 0000:00:03.1:   bridge window [mem 
0x7f40000000-0x7f67ffffff 64bit pref]
[    0.353607] pci 0000:00:03.1: enabling Extended Tags
[    0.353922] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.355435] pci 0000:00:04.0: [1022:14b7] type 00 class 0x060000 
conventional PCI endpoint
[    0.355515] pci 0000:00:04.1: [1022:14cd] type 01 class 0x060400 PCIe 
Root Port
[    0.355537] pci 0000:00:04.1: PCI bridge to [bus 35-64]
[    0.355543] pci 0000:00:04.1:   bridge window [io 0x9000-0xafff]
[    0.355547] pci 0000:00:04.1:   bridge window [mem 0xac000000-0xc3ffffff]
[    0.355556] pci 0000:00:04.1:   bridge window [mem 
0x7f10000000-0x7f37ffffff 64bit pref]
[    0.355567] pci 0000:00:04.1: enabling Extended Tags
[    0.355882] pci 0000:00:04.1: PME# supported from D0 D3hot D3cold
[    0.357383] pci 0000:00:08.0: [1022:14b7] type 00 class 0x060000 
conventional PCI endpoint
[    0.357457] pci 0000:00:08.1: [1022:14b9] type 01 class 0x060400 PCIe 
Root Port
[    0.357472] pci 0000:00:08.1: PCI bridge to [bus 65]
[    0.357476] pci 0000:00:08.1:   bridge window [io 0xd000-0xdfff]
[    0.357479] pci 0000:00:08.1:   bridge window [mem 0xdd600000-0xdd9fffff]
[    0.357485] pci 0000:00:08.1:   bridge window [mem 
0x7f70000000-0x7f801fffff 64bit pref]
[    0.357491] pci 0000:00:08.1: enabling Extended Tags
[    0.357531] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.357864] pci 0000:00:08.3: [1022:14b9] type 01 class 0x060400 PCIe 
Root Port
[    0.357879] pci 0000:00:08.3: PCI bridge to [bus 66]
[    0.357884] pci 0000:00:08.3:   bridge window [mem 0xdd200000-0xdd5fffff]
[    0.357895] pci 0000:00:08.3: enabling Extended Tags
[    0.357938] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.358298] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 
conventional PCI endpoint
[    0.358432] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 
conventional PCI endpoint
[    0.358570] pci 0000:00:18.0: [1022:1679] type 00 class 0x060000 
conventional PCI endpoint
[    0.358619] pci 0000:00:18.1: [1022:167a] type 00 class 0x060000 
conventional PCI endpoint
[    0.358659] pci 0000:00:18.2: [1022:167b] type 00 class 0x060000 
conventional PCI endpoint
[    0.358710] pci 0000:00:18.3: [1022:167c] type 00 class 0x060000 
conventional PCI endpoint
[    0.358752] pci 0000:00:18.4: [1022:167d] type 00 class 0x060000 
conventional PCI endpoint
[    0.358792] pci 0000:00:18.5: [1022:167e] type 00 class 0x060000 
conventional PCI endpoint
[    0.358832] pci 0000:00:18.6: [1022:167f] type 00 class 0x060000 
conventional PCI endpoint
[    0.358876] pci 0000:00:18.7: [1022:1680] type 00 class 0x060000 
conventional PCI endpoint
[    0.358999] pci 0000:01:00.0: [10de:25a2] type 00 class 0x030200 PCIe 
Legacy Endpoint
[    0.359023] pci 0000:01:00.0: BAR 0 [mem 0xdc000000-0xdcffffff]
[    0.359026] pci 0000:01:00.0: BAR 1 [mem 0x7e00000000-0x7effffffff 
64bit pref]
[    0.359029] pci 0000:01:00.0: BAR 3 [mem 0x7f00000000-0x7f01ffffff 
64bit pref]
[    0.359031] pci 0000:01:00.0: BAR 5 [io  0xe000-0xe07f]
[    0.359033] pci 0000:01:00.0: ROM [mem 0xdd000000-0xdd07ffff pref]
[    0.359086] pci 0000:01:00.0: PME# supported from D0 D3hot
[    0.359181] pci 0000:01:00.0: 126.024 Gb/s available PCIe bandwidth, 
limited by 16.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048 
Gb/s with 16.0 GT/s PCIe x16 link)
[    0.360623] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.360907] pci 0000:02:00.0: [14c3:0616] type 00 class 0x028000 PCIe 
Endpoint
[    0.360956] pci 0000:02:00.0: BAR 0 [mem 0xdda00000-0xddafffff 64bit 
pref]
[    0.360960] pci 0000:02:00.0: BAR 2 [mem 0xddb00000-0xddb07fff 64bit]
[    0.361041] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.361264] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.361401] pci 0000:03:00.0: [17a0:9755] type 00 class 0x080501 PCIe 
Endpoint
[    0.361470] pci 0000:03:00.0: BAR 0 [mem 0xddd00000-0xddd00fff]
[    0.361599] pci 0000:03:00.0: supports D1 D2
[    0.361601] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.361961] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.362275] pci 0000:04:00.0: [144d:a80a] type 00 class 0x010802 PCIe 
Endpoint
[    0.362312] pci 0000:04:00.0: BAR 0 [mem 0xddc00000-0xddc03fff 64bit]
[    0.362807] pci 0000:00:02.4: PCI bridge to [bus 04]
[    0.362875] pci 0000:00:03.1: PCI bridge to [bus 05-34]
[    0.362942] pci 0000:00:04.1: PCI bridge to [bus 35-64]
[    0.363049] pci 0000:65:00.0: [1002:1681] type 00 class 0x030000 PCIe 
Legacy Endpoint
[    0.363075] pci 0000:65:00.0: BAR 0 [mem 0x7f70000000-0x7f7fffffff 
64bit pref]
[    0.363077] pci 0000:65:00.0: BAR 2 [mem 0x7f80000000-0x7f801fffff 
64bit pref]
[    0.363080] pci 0000:65:00.0: BAR 4 [io  0xd000-0xd0ff]
[    0.363082] pci 0000:65:00.0: BAR 5 [mem 0xdd900000-0xdd97ffff]
[    0.363087] pci 0000:65:00.0: enabling Extended Tags
[    0.363146] pci 0000:65:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.363493] pci 0000:65:00.1: [1002:1640] type 00 class 0x040300 PCIe 
Legacy Endpoint
[    0.363517] pci 0000:65:00.1: BAR 0 [mem 0xdd9c8000-0xdd9cbfff]
[    0.363526] pci 0000:65:00.1: enabling Extended Tags
[    0.363564] pci 0000:65:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.363861] pci 0000:65:00.2: [1022:1649] type 00 class 0x108000 PCIe 
Endpoint
[    0.363943] pci 0000:65:00.2: BAR 2 [mem 0xdd800000-0xdd8fffff]
[    0.363947] pci 0000:65:00.2: BAR 5 [mem 0xdd9cc000-0xdd9cdfff]
[    0.363952] pci 0000:65:00.2: enabling Extended Tags
[    0.364103] pci 0000:65:00.3: [1022:161d] type 00 class 0x0c0330 PCIe 
Endpoint
[    0.364128] pci 0000:65:00.3: BAR 0 [mem 0xdd700000-0xdd7fffff 64bit]
[    0.364136] pci 0000:65:00.3: enabling Extended Tags
[    0.364176] pci 0000:65:00.3: PME# supported from D0 D3hot D3cold
[    0.364485] pci 0000:65:00.4: [1022:161e] type 00 class 0x0c0330 PCIe 
Endpoint
[    0.364511] pci 0000:65:00.4: BAR 0 [mem 0xdd600000-0xdd6fffff 64bit]
[    0.364519] pci 0000:65:00.4: enabling Extended Tags
[    0.364559] pci 0000:65:00.4: PME# supported from D0 D3hot D3cold
[    0.364871] pci 0000:65:00.5: [1022:15e2] type 00 class 0x048000 PCIe 
Endpoint
[    0.364895] pci 0000:65:00.5: BAR 0 [mem 0xdd980000-0xdd9bffff]
[    0.364904] pci 0000:65:00.5: enabling Extended Tags
[    0.364942] pci 0000:65:00.5: PME# supported from D0 D3hot D3cold
[    0.365643] pci 0000:65:00.6: [1022:15e3] type 00 class 0x040300 PCIe 
Endpoint
[    0.365669] pci 0000:65:00.6: BAR 0 [mem 0xdd9c0000-0xdd9c7fff]
[    0.365678] pci 0000:65:00.6: enabling Extended Tags
[    0.365716] pci 0000:65:00.6: PME# supported from D0 D3hot D3cold
[    0.366016] pci 0000:00:08.1: PCI bridge to [bus 65]
[    0.366107] pci 0000:66:00.0: [1022:161f] type 00 class 0x0c0330 PCIe 
Endpoint
[    0.366136] pci 0000:66:00.0: BAR 0 [mem 0xdd400000-0xdd4fffff 64bit]
[    0.366145] pci 0000:66:00.0: enabling Extended Tags
[    0.366194] pci 0000:66:00.0: PME# supported from D0 D3hot D3cold
[    0.366527] pci 0000:66:00.3: [1022:15d6] type 00 class 0x0c0330 PCIe 
Endpoint
[    0.366553] pci 0000:66:00.3: BAR 0 [mem 0xdd300000-0xdd3fffff 64bit]
[    0.366561] pci 0000:66:00.3: enabling Extended Tags
[    0.366601] pci 0000:66:00.3: PME# supported from D0 D3hot D3cold
[    0.366919] pci 0000:66:00.4: [1022:15d7] type 00 class 0x0c0330 PCIe 
Endpoint
[    0.366945] pci 0000:66:00.4: BAR 0 [mem 0xdd200000-0xdd2fffff 64bit]
[    0.366954] pci 0000:66:00.4: enabling Extended Tags
[    0.366994] pci 0000:66:00.4: PME# supported from D0 D3hot D3cold
[    0.367304] pci 0000:66:00.5: [1022:162e] type 00 class 0x0c0340 PCIe 
Endpoint
[    0.367335] pci 0000:66:00.5: BAR 0 [mem 0xdd580000-0xdd5fffff 64bit]
[    0.367343] pci 0000:66:00.5: enabling Extended Tags
[    0.367383] pci 0000:66:00.5: PME# supported from D0 D3hot D3cold
[    0.367687] pci 0000:66:00.6: [1022:162f] type 00 class 0x0c0340 PCIe 
Endpoint
[    0.367718] pci 0000:66:00.6: BAR 0 [mem 0xdd500000-0xdd57ffff 64bit]
[    0.367726] pci 0000:66:00.6: enabling Extended Tags
[    0.367767] pci 0000:66:00.6: PME# supported from D0 D3hot D3cold
[    0.368078] pci 0000:00:08.3: PCI bridge to [bus 66]
[    0.380029] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.380095] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.380152] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.380220] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.380283] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.380335] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.380388] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.380440] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.382241] Low-power S0 idle used by default for system suspend
[    0.382591] ACPI: EC: interrupt unblocked
[    0.382593] ACPI: EC: event unblocked
[    0.382601] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.382602] ACPI: EC: GPE=0x2
[    0.382604] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot ECDT EC initialization 
complete
[    0.382606] ACPI: \_SB_.PCI0.SBRG.EC0_: EC: Used to handle 
transactions and events
[    0.382676] iommu: Default domain type: Passthrough (set via kernel 
command line)
[    0.382807] SCSI subsystem initialized
[    0.382814] libata version 3.00 loaded.
[    0.382814] ACPI: bus type USB registered
[    0.382814] usbcore: registered new interface driver usbfs
[    0.382814] usbcore: registered new interface driver hub
[    0.382814] usbcore: registered new device driver usb
[    0.406924] EDAC MC: Ver: 3.0.0
[    0.407250] efivars: Registered efivars operations
[    0.407250] NetLabel: Initializing
[    0.407250] NetLabel:  domain hash size = 128
[    0.407250] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.407250] NetLabel:  unlabeled traffic allowed by default
[    0.407250] mctp: management component transport protocol core
[    0.407250] NET: Registered PF_MCTP protocol family
[    0.407250] PCI: Using ACPI for IRQ routing
[    0.416356] PCI: pci_cache_line_size set to 64 bytes
[    0.416645] e820: register RAM buffer resource [mem 
0x09bff000-0x0bffffff]
[    0.416647] e820: register RAM buffer resource [mem 
0x0a200000-0x0bffffff]
[    0.416648] e820: register RAM buffer resource [mem 
0x87f77000-0x87ffffff]
[    0.416649] e820: register RAM buffer resource [mem 
0x905b5000-0x93ffffff]
[    0.416651] e820: register RAM buffer resource [mem 
0x995ff000-0x9bffffff]
[    0.416652] e820: register RAM buffer resource [mem 
0x9affd000-0x9bffffff]
[    0.416653] e820: register RAM buffer resource [mem 
0x43e300000-0x43fffffff]
[    0.416707] pci 0000:65:00.0: vgaarb: setting as boot VGA device
[    0.416707] pci 0000:65:00.0: vgaarb: bridge control possible
[    0.416707] pci 0000:65:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
[    0.416707] vgaarb: loaded
[    0.416855] clocksource: Switched to clocksource tsc-early
[    0.417017] VFS: Disk quotas dquot_6.6.0
[    0.417030] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    0.417038] acpi PNP0C01:00: Reserved [mem 0xe0000000-0xefffffff]
[    0.417038] acpi PNP0C02:00: Could not reserve [mem 
0xfd000000-0xfdffffff]
[    0.417240] acpi PNP0C02:01: Skipped [io  0x0010-0x001f]
[    0.417242] acpi PNP0C02:01: Skipped [io  0x0022-0x003f]
[    0.417243] acpi PNP0C02:01: Skipped [io  0x0063]
[    0.417245] acpi PNP0C02:01: Skipped [io  0x0065]
[    0.417246] acpi PNP0C02:01: Skipped [io  0x0067-0x006f]
[    0.417247] acpi PNP0C02:01: Skipped [io  0x0072-0x007f]
[    0.417248] acpi PNP0C02:01: Skipped [io  0x0080]
[    0.417250] acpi PNP0C02:01: Skipped [io  0x0084-0x0086]
[    0.417251] acpi PNP0C02:01: Skipped [io  0x0088]
[    0.417252] acpi PNP0C02:01: Skipped [io  0x008c-0x008e]
[    0.417253] acpi PNP0C02:01: Skipped [io  0x0090-0x009f]
[    0.417255] acpi PNP0C02:01: Skipped [io  0x00a2-0x00bf]
[    0.417256] acpi PNP0C02:01: Skipped [io  0x00b1]
[    0.417257] acpi PNP0C02:01: Skipped [io  0x00e0-0x00ef]
[    0.417258] acpi PNP0C02:01: Reserved [io  0x04d0-0x04d1]
[    0.417260] acpi PNP0C02:01: Reserved [io  0x040b]
[    0.417261] acpi PNP0C02:01: Reserved [io  0x04d6]
[    0.417263] acpi PNP0C02:01: Reserved [io  0x0c00-0x0c01]
[    0.417264] acpi PNP0C02:01: Reserved [io  0x0c14]
[    0.417265] acpi PNP0C02:01: Reserved [io  0x0c50-0x0c51]
[    0.417267] acpi PNP0C02:01: Reserved [io  0x0c52]
[    0.417268] acpi PNP0C02:01: Reserved [io  0x0c6c]
[    0.417269] acpi PNP0C02:01: Reserved [io  0x0c6f]
[    0.417271] acpi PNP0C02:01: Reserved [io  0x0cd0-0x0cd1]
[    0.417272] acpi PNP0C02:01: Reserved [io  0x0cd2-0x0cd3]
[    0.417273] acpi PNP0C02:01: Reserved [io  0x0cd4-0x0cd5]
[    0.417275] acpi PNP0C02:01: Reserved [io  0x0cd6-0x0cd7]
[    0.417276] acpi PNP0C02:01: Reserved [io  0x0cd8-0x0cdf]
[    0.417278] acpi PNP0C02:01: Reserved [io  0x0800-0x089f]
[    0.417279] acpi PNP0C02:01: Reserved [io  0x0b00-0x0b0f]
[    0.417280] acpi PNP0C02:01: Reserved [io  0x0b20-0x0b3f]
[    0.417282] acpi PNP0C02:01: Reserved [io  0x0900-0x090f]
[    0.417283] acpi PNP0C02:01: Reserved [io  0x0910-0x091f]
[    0.417285] acpi PNP0C02:01: Could not reserve [mem 
0xfec00000-0xfec00fff]
[    0.417286] acpi PNP0C02:01: Could not reserve [mem 
0xfec01000-0xfec01fff]
[    0.417288] acpi PNP0C02:01: Reserved [mem 0xfedc0000-0xfedc0fff]
[    0.417290] acpi PNP0C02:01: Reserved [mem 0xfee00000-0xfee00fff]
[    0.417291] acpi PNP0C02:01: Could not reserve [mem 
0xfed80000-0xfed8ffff]
[    0.417293] acpi PNP0C02:01: Reserved [mem 0xfec10000-0xfec10fff]
[    0.417295] acpi PNP0C02:01: Reserved [mem 0xff000000-0xffffffff]
[    0.417330] pnp: PnP ACPI init
[    0.423246] pnp: PnP ACPI: found 2 devices
[    0.429284] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
0xffffff, max_idle_ns: 2085701024 ns
[    0.429420] NET: Registered PF_INET protocol family
[    0.429672] IP idents hash table entries: 262144 (order: 9, 2097152 
bytes, linear)
[    0.442531] tcp_listen_portaddr_hash hash table entries: 8192 (order: 
5, 131072 bytes, linear)
[    0.442552] Table-perturb hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[    0.442620] TCP established hash table entries: 131072 (order: 8, 
1048576 bytes, linear)
[    0.442811] TCP bind hash table entries: 65536 (order: 9, 2097152 
bytes, linear)
[    0.442892] TCP: Hash tables configured (established 131072 bind 65536)
[    0.442986] MPTCP token hash table entries: 16384 (order: 7, 393216 
bytes, linear)
[    0.443037] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.443095] UDP-Lite hash table entries: 8192 (order: 7, 524288 
bytes, linear)
[    0.443163] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.443170] NET: Registered PF_XDP protocol family
[    0.443186] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.443195] pci 0000:00:01.1:   bridge window [io 0xe000-0xefff]
[    0.443199] pci 0000:00:01.1:   bridge window [mem 0xdc000000-0xdd0fffff]
[    0.443202] pci 0000:00:01.1:   bridge window [mem 
0x7e00000000-0x7f01ffffff 64bit pref]
[    0.443206] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.443210] pci 0000:00:02.2:   bridge window [mem 0xdda00000-0xddbfffff]
[    0.443217] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.443220] pci 0000:00:02.3:   bridge window [mem 0xddd00000-0xdddfffff]
[    0.443227] pci 0000:00:02.4: PCI bridge to [bus 04]
[    0.443230] pci 0000:00:02.4:   bridge window [mem 0xddc00000-0xddcfffff]
[    0.443237] pci 0000:00:03.1: PCI bridge to [bus 05-34]
[    0.443239] pci 0000:00:03.1:   bridge window [io 0xb000-0xcfff]
[    0.443243] pci 0000:00:03.1:   bridge window [mem 0xc4000000-0xdbffffff]
[    0.443247] pci 0000:00:03.1:   bridge window [mem 
0x7f40000000-0x7f67ffffff 64bit pref]
[    0.443252] pci 0000:00:04.1: PCI bridge to [bus 35-64]
[    0.443254] pci 0000:00:04.1:   bridge window [io 0x9000-0xafff]
[    0.443258] pci 0000:00:04.1:   bridge window [mem 0xac000000-0xc3ffffff]
[    0.443261] pci 0000:00:04.1:   bridge window [mem 
0x7f10000000-0x7f37ffffff 64bit pref]
[    0.443268] pci 0000:00:08.1: PCI bridge to [bus 65]
[    0.443270] pci 0000:00:08.1:   bridge window [io 0xd000-0xdfff]
[    0.443275] pci 0000:00:08.1:   bridge window [mem 0xdd600000-0xdd9fffff]
[    0.443278] pci 0000:00:08.1:   bridge window [mem 
0x7f70000000-0x7f801fffff 64bit pref]
[    0.443282] pci 0000:00:08.3: PCI bridge to [bus 66]
[    0.443285] pci 0000:00:08.3:   bridge window [mem 0xdd200000-0xdd5fffff]
[    0.443290] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.443292] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.443294] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.443295] pci_bus 0000:00: resource 7 [io  0x0d00-0xefff window]
[    0.443296] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff 
window]
[    0.443298] pci_bus 0000:00: resource 9 [mem 0xa0000000-0xdfffffff 
window]
[    0.443300] pci_bus 0000:00: resource 10 [mem 
0x460000000-0x7fffffffff window]
[    0.443301] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.443303] pci_bus 0000:01: resource 1 [mem 0xdc000000-0xdd0fffff]
[    0.443304] pci_bus 0000:01: resource 2 [mem 
0x7e00000000-0x7f01ffffff 64bit pref]
[    0.443306] pci_bus 0000:02: resource 1 [mem 0xdda00000-0xddbfffff]
[    0.443307] pci_bus 0000:03: resource 1 [mem 0xddd00000-0xdddfffff]
[    0.443309] pci_bus 0000:04: resource 1 [mem 0xddc00000-0xddcfffff]
[    0.443310] pci_bus 0000:05: resource 0 [io  0xb000-0xcfff]
[    0.443312] pci_bus 0000:05: resource 1 [mem 0xc4000000-0xdbffffff]
[    0.443313] pci_bus 0000:05: resource 2 [mem 
0x7f40000000-0x7f67ffffff 64bit pref]
[    0.443315] pci_bus 0000:35: resource 0 [io  0x9000-0xafff]
[    0.443316] pci_bus 0000:35: resource 1 [mem 0xac000000-0xc3ffffff]
[    0.443318] pci_bus 0000:35: resource 2 [mem 
0x7f10000000-0x7f37ffffff 64bit pref]
[    0.443319] pci_bus 0000:65: resource 0 [io  0xd000-0xdfff]
[    0.443320] pci_bus 0000:65: resource 1 [mem 0xdd600000-0xdd9fffff]
[    0.443322] pci_bus 0000:65: resource 2 [mem 
0x7f70000000-0x7f801fffff 64bit pref]
[    0.443323] pci_bus 0000:66: resource 1 [mem 0xdd200000-0xdd5fffff]
[    0.443460] pci 0000:00:02.3: mask Replay Timer Timeout Correctable 
Errors due to 0000:03:00.0 hardware defect
[    0.443724] pci 0000:65:00.1: D0 power state depends on 0000:65:00.0
[    0.443780] pci 0000:00:08.1: can't derive routing for PCI INT A
[    0.443782] pci 0000:00:08.1: PCI INT A: not connected
[    0.443997] pci 0000:00:08.3: can't derive routing for PCI INT A
[    0.443999] pci 0000:00:08.3: PCI INT A: not connected
[    0.444240] PCI: CLS 64 bytes, default 64
[    0.444267] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters 
supported
[    0.444323] Trying to unpack rootfs image as initramfs...
[    0.444369] pci 0000:00:01.0: Adding to iommu group 0
[    0.444388] pci 0000:00:01.1: Adding to iommu group 1
[    0.444437] pci 0000:00:02.0: Adding to iommu group 2
[    0.444456] pci 0000:00:02.2: Adding to iommu group 3
[    0.444476] pci 0000:00:02.3: Adding to iommu group 4
[    0.444494] pci 0000:00:02.4: Adding to iommu group 5
[    0.444524] pci 0000:00:03.0: Adding to iommu group 6
[    0.444541] pci 0000:00:03.1: Adding to iommu group 6
[    0.444571] pci 0000:00:04.0: Adding to iommu group 7
[    0.444593] pci 0000:00:04.1: Adding to iommu group 7
[    0.444633] pci 0000:00:08.0: Adding to iommu group 8
[    0.444650] pci 0000:00:08.1: Adding to iommu group 9
[    0.444668] pci 0000:00:08.3: Adding to iommu group 10
[    0.444699] pci 0000:00:14.0: Adding to iommu group 11
[    0.444713] pci 0000:00:14.3: Adding to iommu group 11
[    0.444777] pci 0000:00:18.0: Adding to iommu group 12
[    0.444791] pci 0000:00:18.1: Adding to iommu group 12
[    0.444805] pci 0000:00:18.2: Adding to iommu group 12
[    0.444819] pci 0000:00:18.3: Adding to iommu group 12
[    0.444834] pci 0000:00:18.4: Adding to iommu group 12
[    0.444848] pci 0000:00:18.5: Adding to iommu group 12
[    0.444863] pci 0000:00:18.6: Adding to iommu group 12
[    0.444877] pci 0000:00:18.7: Adding to iommu group 12
[    0.444898] pci 0000:01:00.0: Adding to iommu group 13
[    0.444916] pci 0000:02:00.0: Adding to iommu group 14
[    0.444933] pci 0000:03:00.0: Adding to iommu group 15
[    0.444950] pci 0000:04:00.0: Adding to iommu group 16
[    0.444987] pci 0000:65:00.0: Adding to iommu group 17
[    0.445012] pci 0000:65:00.1: Adding to iommu group 18
[    0.445030] pci 0000:65:00.2: Adding to iommu group 19
[    0.445048] pci 0000:65:00.3: Adding to iommu group 20
[    0.445067] pci 0000:65:00.4: Adding to iommu group 21
[    0.445085] pci 0000:65:00.5: Adding to iommu group 22
[    0.445105] pci 0000:65:00.6: Adding to iommu group 23
[    0.445124] pci 0000:66:00.0: Adding to iommu group 24
[    0.445142] pci 0000:66:00.3: Adding to iommu group 25
[    0.445161] pci 0000:66:00.4: Adding to iommu group 26
[    0.445179] pci 0000:66:00.5: Adding to iommu group 27
[    0.445198] pci 0000:66:00.6: Adding to iommu group 28
[    0.445612] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR 
NX GT [5] IA GA PC GA_vAPIC
[    0.445621] AMD-Vi: Interrupt remapping enabled
[    0.445733] AMD-Vi: Virtual APIC enabled
[    0.445745] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.445747] software IO TLB: mapped [mem 
0x0000000083f54000-0x0000000087f54000] (64MB)
[    0.445874] LVT offset 0 assigned for vector 0x400
[    0.445981] perf: AMD IBS detected (0x000003fd)
[    0.445987] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 
counters/bank).
[    0.447944] Initialise system trusted keyrings
[    0.447955] Key type blacklist registered
[    0.447997] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[    0.448378] fuse: init (API version 7.45)
[    0.448458] integrity: Platform Keyring initialized
[    0.448461] integrity: Machine keyring initialized
[    0.454929] xor: automatically using best checksumming function   avx
[    0.454932] Key type asymmetric registered
[    0.454933] Asymmetric key parser 'x509' registered
[    0.454954] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 245)
[    0.455008] io scheduler mq-deadline registered
[    0.455009] io scheduler kyber registered
[    0.455021] io scheduler bfq registered
[    0.456577] ledtrig-cpu: registered to indicate activity on CPUs
[    0.456710] pcieport 0000:00:01.1: PME: Signaling with IRQ 32
[    0.456770] pcieport 0000:00:01.1: AER: enabled with IRQ 32
[    0.456791] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- PwrCtrl- 
MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- 
LLActRep+
[    0.456997] pcieport 0000:00:02.2: PME: Signaling with IRQ 33
[    0.457051] pcieport 0000:00:02.2: AER: enabled with IRQ 33
[    0.457204] pcieport 0000:00:02.3: PME: Signaling with IRQ 34
[    0.457268] pcieport 0000:00:02.3: AER: enabled with IRQ 34
[    0.457437] pcieport 0000:00:02.4: PME: Signaling with IRQ 35
[    0.457497] pcieport 0000:00:02.4: AER: enabled with IRQ 35
[    0.457663] pcieport 0000:00:03.1: PME: Signaling with IRQ 36
[    0.457725] pcieport 0000:00:03.1: AER: enabled with IRQ 36
[    0.457744] pcieport 0000:00:03.1: pciehp: Slot #0 AttnBtn- PwrCtrl- 
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- 
LLActRep+
[    0.458216] pcieport 0000:00:04.1: PME: Signaling with IRQ 37
[    0.458273] pcieport 0000:00:04.1: AER: enabled with IRQ 37
[    0.458291] pcieport 0000:00:04.1: pciehp: Slot #0 AttnBtn- PwrCtrl- 
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- 
LLActRep+
[    0.458718] pcieport 0000:00:08.1: PME: Signaling with IRQ 38
[    0.458856] pcieport 0000:00:08.3: PME: Signaling with IRQ 39
[    0.458907] pcieport 0000:00:08.3: AER: enabled with IRQ 39
[    0.461267] ACPI: AC: AC Adapter [AC0] (off-line)
[    0.461334] input: Lid Switch as 
/devices/pci0000:00/0000:00:14.3/PNP0C09:00/PNP0C0D:00/input/input0
[    0.461361] ACPI: button: Lid Switch [LID]
[    0.461401] input: Power Button as 
/devices/platform/PNP0C0C:00/input/input1
[    0.461422] ACPI: button: Power Button [PWRB]
[    0.461460] Monitor-Mwait will be used to enter C-1 state
[    0.464363] Estimated ratio of average max frequency by base 
frequency (times 1024): 1277
[    0.465758] acpi LNXTHERM:00: registered as thermal_zone0
[    0.465760] ACPI: thermal: Thermal Zone [THRM] (74 C)
[    0.466013] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.478421] hpet_acpi_add: no address or irqs in _CRS
[    0.478499] Non-volatile memory driver v1.3
[    0.478501] Linux agpgart interface v0.103
[    0.481991] ACPI: battery: Slot [BAT0] (battery present)
[    0.483555] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
[    0.663691] Freeing initrd memory: 264564K
[    1.300671] ACPI: bus type drm_connector registered
[    1.301275] xhci_hcd 0000:65:00.3: xHCI Host Controller
[    1.301286] xhci_hcd 0000:65:00.3: new USB bus registered, assigned 
bus number 1
[    1.301827] xhci_hcd 0000:65:00.3: hcc params 0x0120ffc5 hci version 
0x120 quirks 0x0000000200000010
[    1.302301] xhci_hcd 0000:65:00.3: xHCI Host Controller
[    1.302304] xhci_hcd 0000:65:00.3: new USB bus registered, assigned 
bus number 2
[    1.302306] xhci_hcd 0000:65:00.3: Host supports USB 3.1 Enhanced 
SuperSpeed
[    1.302344] usb usb1: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 7.00
[    1.302347] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    1.302349] usb usb1: Product: xHCI Host Controller
[    1.302350] usb usb1: Manufacturer: Linux 7.0.12-zen1-1-zen xhci-hcd
[    1.302351] usb usb1: SerialNumber: 0000:65:00.3
[    1.302450] hub 1-0:1.0: USB hub found
[    1.302481] hub 1-0:1.0: 4 ports detected
[    1.303040] usb usb2: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    1.303058] usb usb2: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 7.00
[    1.303060] usb usb2: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    1.303061] usb usb2: Product: xHCI Host Controller
[    1.303063] usb usb2: Manufacturer: Linux 7.0.12-zen1-1-zen xhci-hcd
[    1.303064] usb usb2: SerialNumber: 0000:65:00.3
[    1.303146] hub 2-0:1.0: USB hub found
[    1.303165] hub 2-0:1.0: 2 ports detected
[    1.303599] xhci_hcd 0000:65:00.4: xHCI Host Controller
[    1.303604] xhci_hcd 0000:65:00.4: new USB bus registered, assigned 
bus number 3
[    1.303972] xhci_hcd 0000:65:00.4: hcc params 0x0120ffc5 hci version 
0x120 quirks 0x0000000200000010
[    1.304200] xhci_hcd 0000:65:00.4: xHCI Host Controller
[    1.304203] xhci_hcd 0000:65:00.4: new USB bus registered, assigned 
bus number 4
[    1.304205] xhci_hcd 0000:65:00.4: Host supports USB 3.1 Enhanced 
SuperSpeed
[    1.304234] usb usb3: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 7.00
[    1.304236] usb usb3: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    1.304237] usb usb3: Product: xHCI Host Controller
[    1.304238] usb usb3: Manufacturer: Linux 7.0.12-zen1-1-zen xhci-hcd
[    1.304240] usb usb3: SerialNumber: 0000:65:00.4
[    1.304322] hub 3-0:1.0: USB hub found
[    1.304342] hub 3-0:1.0: 3 ports detected
[    1.304785] usb usb4: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    1.304802] usb usb4: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 7.00
[    1.304804] usb usb4: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    1.304806] usb usb4: Product: xHCI Host Controller
[    1.304807] usb usb4: Manufacturer: Linux 7.0.12-zen1-1-zen xhci-hcd
[    1.304808] usb usb4: SerialNumber: 0000:65:00.4
[    1.304883] hub 4-0:1.0: USB hub found
[    1.304904] hub 4-0:1.0: 2 ports detected
[    1.305342] xhci_hcd 0000:66:00.0: xHCI Host Controller
[    1.305346] xhci_hcd 0000:66:00.0: new USB bus registered, assigned 
bus number 5
[    1.306607] xhci_hcd 0000:66:00.0: USB3 root hub has no ports
[    1.306624] xhci_hcd 0000:66:00.0: hcc params 0x0110ffc5 hci version 
0x120 quirks 0x0000000200000010
[    1.306768] usb usb5: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 7.00
[    1.306770] usb usb5: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    1.306771] usb usb5: Product: xHCI Host Controller
[    1.306773] usb usb5: Manufacturer: Linux 7.0.12-zen1-1-zen xhci-hcd
[    1.306774] usb usb5: SerialNumber: 0000:66:00.0
[    1.306852] hub 5-0:1.0: USB hub found
[    1.306867] hub 5-0:1.0: 1 port detected
[    1.307273] xhci_hcd 0000:66:00.3: xHCI Host Controller
[    1.307277] xhci_hcd 0000:66:00.3: new USB bus registered, assigned 
bus number 6
[    1.307634] xhci_hcd 0000:66:00.3: hcc params 0x0110ffc5 hci version 
0x120 quirks 0x0000000200000010
[    1.308025] xhci_hcd 0000:66:00.3: xHCI Host Controller
[    1.308028] xhci_hcd 0000:66:00.3: new USB bus registered, assigned 
bus number 7
[    1.308030] xhci_hcd 0000:66:00.3: Host supports USB 3.1 Enhanced 
SuperSpeed
[    1.308059] usb usb6: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 7.00
[    1.308060] usb usb6: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    1.308062] usb usb6: Product: xHCI Host Controller
[    1.308063] usb usb6: Manufacturer: Linux 7.0.12-zen1-1-zen xhci-hcd
[    1.308064] usb usb6: SerialNumber: 0000:66:00.3
[    1.308145] hub 6-0:1.0: USB hub found
[    1.308164] hub 6-0:1.0: 1 port detected
[    1.308355] usb usb7: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    1.308372] usb usb7: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 7.00
[    1.308374] usb usb7: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    1.308376] usb usb7: Product: xHCI Host Controller
[    1.308377] usb usb7: Manufacturer: Linux 7.0.12-zen1-1-zen xhci-hcd
[    1.308378] usb usb7: SerialNumber: 0000:66:00.3
[    1.308451] hub 7-0:1.0: USB hub found
[    1.308475] hub 7-0:1.0: 1 port detected
[    1.309060] xhci_hcd 0000:66:00.4: xHCI Host Controller
[    1.309064] xhci_hcd 0000:66:00.4: new USB bus registered, assigned 
bus number 8
[    1.309422] xhci_hcd 0000:66:00.4: hcc params 0x0110ffc5 hci version 
0x120 quirks 0x0000000200000010
[    1.309800] xhci_hcd 0000:66:00.4: xHCI Host Controller
[    1.309803] xhci_hcd 0000:66:00.4: new USB bus registered, assigned 
bus number 9
[    1.309805] xhci_hcd 0000:66:00.4: Host supports USB 3.1 Enhanced 
SuperSpeed
[    1.309833] usb usb8: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 7.00
[    1.309835] usb usb8: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    1.309836] usb usb8: Product: xHCI Host Controller
[    1.309837] usb usb8: Manufacturer: Linux 7.0.12-zen1-1-zen xhci-hcd
[    1.309839] usb usb8: SerialNumber: 0000:66:00.4
[    1.309915] hub 8-0:1.0: USB hub found
[    1.309934] hub 8-0:1.0: 1 port detected
[    1.310123] usb usb9: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    1.310141] usb usb9: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 7.00
[    1.310142] usb usb9: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    1.310144] usb usb9: Product: xHCI Host Controller
[    1.310145] usb usb9: Manufacturer: Linux 7.0.12-zen1-1-zen xhci-hcd
[    1.310146] usb usb9: SerialNumber: 0000:66:00.4
[    1.310222] hub 9-0:1.0: USB hub found
[    1.310241] hub 9-0:1.0: 1 port detected
[    1.310796] usbcore: registered new interface driver usbserial_generic
[    1.310802] usbserial: USB Serial support registered for generic
[    1.310821] i8042: PNP: PS/2 Controller [PNP030b:PS2K] at 0x60,0x64 irq 1
[    1.310823] i8042: PNP: PS/2 appears to have AUX port disabled, if 
this is incorrect please boot with i8042.nopnp
[    1.313920] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.314862] rtc_cmos 00:00: RTC can wake from S4
[    1.315328] rtc_cmos 00:00: registered as rtc0
[    1.315386] rtc_cmos 00:00: setting system clock to 
2026-06-13T05:33:06 UTC (1781328786)
[    1.315417] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
[    1.315828] input: AT Translated Set 2 keyboard as 
/devices/platform/i8042/serio0/input/input2
[    1.317762] simple-framebuffer simple-framebuffer.0: [drm] Registered 
1 planes with drm panic
[    1.317776] [drm] Initialized simpledrm 1.0.0 for 
simple-framebuffer.0 on minor 0
[    1.319240] fbcon: Deferring console take-over
[    1.319246] simple-framebuffer simple-framebuffer.0: [drm] fb0: 
simpledrmdrmfb frame buffer device
[    1.319306] hid: raw HID events driver (C) Jiri Kosina
[    1.319344] usbcore: registered new interface driver usbhid
[    1.319346] usbhid: USB HID core driver
[    1.319431] rust_binder: Loaded Rust Binder.
[    1.319468] drop_monitor: Initializing network drop monitor service
[    1.319630] NET: Registered PF_INET6 protocol family
[    1.320117] Segment Routing with IPv6
[    1.320119] RPL Segment Routing with IPv6
[    1.320128] In-situ OAM (IOAM) with IPv6
[    1.320154] NET: Registered PF_PACKET protocol family
[    1.323755] x86/amd: Previous system reset reason [0x00080800]: 
software wrote 0x6 to reset control register 0xCF9
[    1.323776] microcode: Current revision: 0x0a404102
[    1.324836] resctrl: L3 allocation detected
[    1.324845] resctrl: MB allocation detected
[    1.324849] resctrl: L3 monitoring detected
[    1.324891] IPI shorthand broadcast: enabled
[    1.328954] sched_clock: Marking stable (1327011670, 
1466198)->(1343876431, -15398563)
[    1.329510] registered taskstats version 1
[    1.333533] Loading compiled-in X.509 certificates
[    1.340817] Loaded X.509 cert 'Build time autogenerated kernel key: 
ee4f39bfebe9f5791001ed40b512a031d1a39a4f'
[    1.345383] zswap: loaded using pool zstd
[    1.345504] Demotion targets for Node 0: null
[    1.345708] Key type .fscrypt registered
[    1.345710] Key type fscrypt-provisioning registered
[    1.346179] Btrfs loaded, zoned=yes, fsverity=yes
[    1.346223] Key type big_key registered
[    1.346472] integrity: Loading X.509 certificate: UEFI:db
[    1.352267] integrity: Loaded X.509 cert 'Database Key: 
0619922b4752eb0c1a036e927a9b5963'
[    1.352274] integrity: Loading X.509 certificate: UEFI:db
[    1.352319] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI 
CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.352323] integrity: Loading X.509 certificate: UEFI:db
[    1.352356] integrity: Loaded X.509 cert 'Microsoft Windows 
Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.352360] integrity: Loading X.509 certificate: UEFI:db
[    1.352389] integrity: Loaded X.509 cert 'Microsoft Option ROM UEFI 
CA 2023: 514fbf937fa46fb57bf07af8bed84b3b864b1711'
[    1.352393] integrity: Loading X.509 certificate: UEFI:db
[    1.352416] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 
81aa6b3244c935bce0d6628af39827421e32497d'
[    1.352418] integrity: Loading X.509 certificate: UEFI:db
[    1.352431] integrity: Loaded X.509 cert 'Microsoft Corporation: 
Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    1.353106] PM:   Magic number: 14:533:567
[    1.353192] acpi LNXPOWER:0c: hash matches
[    1.353357] RAS: Correctable Errors collector initialized.
[    1.355616] clk: Disabling unused clocks
[    1.355623] PM: genpd: Disabling unused power domains
[    1.356943] Freeing unused decrypted memory: 2028K
[    1.357817] Freeing unused kernel image (initmem) memory: 4968K
[    1.357843] Write protecting the kernel read-only data: 45056k
[    1.358615] Freeing unused kernel image (text/rodata gap) memory: 1552K
[    1.359356] Freeing unused kernel image (rodata/data gap) memory: 1872K
[    1.421453] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.421459] rodata_test: all tests were successful
[    1.421472] Run /init as init process
[    1.421475]   with arguments:
[    1.421477]     /init
[    1.421479]     splash
[    1.421480]   with environment:
[    1.421482]     HOME=/
[    1.421484]     TERM=linux
[    1.421485]     modeset=1
[    1.421487]     preempt=voluntary
[    1.443289] systemd[1]: Successfully made /usr/ read-only.
[    1.451538] tsc: Refined TSC clocksource calibration: 3293.812 MHz
[    1.451565] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x2f7a76a4ebd, max_idle_ns: 440795230158 ns
[    1.451634] clocksource: Switched to clocksource tsc
[    1.539747] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    1.547741] usb 5-1: new high-speed USB device number 2 using xhci_hcd
[    1.675072] usb 5-1: New USB device found, idVendor=0408, 
idProduct=30e1, bcdDevice= 0.02
[    1.675088] usb 5-1: New USB device strings: Mfr=3, Product=1, 
SerialNumber=2
[    1.675095] usb 5-1: Product: USB2.0 HD UVC WebCam
[    1.675100] usb 5-1: Manufacturer: Quanta
[    1.675105] usb 5-1: SerialNumber: 0x0001
[    1.698659] usb 1-3: New USB device found, idVendor=04f3, 
idProduct=0c6e, bcdDevice= 9.00
[    1.698676] usb 1-3: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[    1.698683] usb 1-3: Product: ELAN:Fingerprint
[    1.698689] usb 1-3: Manufacturer: ELAN
[    1.777732] systemd[1]: systemd 260.2-2-arch running in system mode 
(+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT 
+GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 +KMOD 
+LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY 
+P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF 
+XKBCOMMON +UTMP +LIBARCHIVE)
[    1.777754] systemd[1]: Detected architecture x86-64.
[    1.777762] systemd[1]: Running in initrd.
[    1.778510] systemd[1]: Received untrusted credentials: 
nvpcr-anchor.60831444225341dc9bf4534be89fb4fa, 
nvpcr-anchor.8696d28fd91d491bb9a81447af16cbe9, 
nvpcr-anchor.e0d25e725f974937888f257745cb77de
[    1.778520] systemd[1]: Acquired 0 regular credentials, 3 untrusted 
credentials.
[    1.778710] systemd[1]: Initializing machine ID from random generator.
[    1.812536] usb 1-4: new high-speed USB device number 3 using xhci_hcd
[    1.820289] systemd[1]: Queued start job for default target Initrd 
Default Target.
[    1.830570] systemd[1]: Created slice Slice /system/systemd-cryptsetup.
[    1.830625] systemd[1]: Expecting device 
/dev/disk/by-uuid/22b6302a-51c8-4c7b-b0f0-40b7baa5421c...
[    1.830636] systemd[1]: Expecting device 
/dev/disk/by-uuid/c04e1ef4-24dc-46ac-b697-4c3acab6d213...
[    1.830656] systemd[1]: Reached target Slice Units.
[    1.830667] systemd[1]: Reached target Swaps.
[    1.830676] systemd[1]: Reached target Timer Units.
[    1.830760] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.830832] systemd[1]: Listening on Journal Sockets.
[    1.830901] systemd[1]: Listening on udev Control Socket.
[    1.830941] systemd[1]: Listening on udev Kernel Socket.
[    1.830952] systemd[1]: Reached target Socket Units.
[    1.831840] systemd[1]: Starting Create List of Static Device Nodes...
[    1.833687] systemd[1]: Starting Journal Service...
[    1.834527] systemd[1]: Starting Load Kernel Modules...
[    1.835728] systemd[1]: Starting TPM PCR Barrier (initrd)...
[    1.836390] systemd[1]: Starting Create Static Device Nodes in /dev...
[    1.836981] systemd[1]: Starting Coldplug All udev Devices...
[    1.837708] systemd[1]: Starting Virtual Console Setup...
[    1.839388] systemd[1]: Finished Create List of Static Device Nodes.
[    1.846191] systemd[1]: Finished Create Static Device Nodes in /dev.
[    1.846547] systemd[1]: Reached target Preparation for Local File 
Systems.
[    1.846579] systemd[1]: Reached target Local File Systems.
[    1.848129] systemd[1]: Starting Rule-based Manager for Device Events 
and Files...
[    1.850225] systemd[1]: Finished Virtual Console Setup.
[    1.853133] systemd-journald[195]: Collecting audit messages is disabled.
[    1.854848] ACPI: video: Video Device [VGA] (multi-head: yes rom: no  
post: no)
[    1.855685] input: Video Bus as 
/devices/pci0000:00/0000:00:08.1/acpi.video_bus.0/input/input3
[    1.881189] systemd[1]: Started Rule-based Manager for Device Events 
and Files.
[    1.884554] systemd[1]: Finished TPM PCR Barrier (initrd).
[    1.931729] systemd[1]: Started Journal Service.
[    1.938944] usb 1-4: New USB device found, idVendor=0489, 
idProduct=e0e2, bcdDevice= 1.00
[    1.938959] usb 1-4: New USB device strings: Mfr=5, Product=6, 
SerialNumber=7
[    1.938963] usb 1-4: Product: Wireless_Device
[    1.938967] usb 1-4: Manufacturer: MediaTek Inc.
[    1.938970] usb 1-4: SerialNumber: 000000000
[    1.939970] nvidia: loading out-of-tree module taints kernel.
[    1.939982] nvidia: module verification failed: signature and/or 
required key missing - tainting kernel
[    2.108330] nvidia-nvlink: Nvlink Core is being initialized, major 
device number 237

[    2.116720] nvidia 0000:01:00.0: enabling device (0000 -> 0003)
[    2.163853] NVRM: loading NVIDIA UNIX Open Kernel Module for x86_64  
610.43.02  Release Build  (root@)
[    4.042185] ccp 0000:65:00.2: enabling device (0000 -> 0002)
[    4.046792] ccp 0000:65:00.2: tee enabled
[    4.047612] ccp 0000:65:00.2: psp enabled
[    4.059321] Key type psk registered
[    4.060872] sdhci: Secure Digital Host Controller Interface driver
[    4.060875] sdhci: Copyright(c) Pierre Ossman
[    4.072375] amdgpu: Virtual CRAT table created for CPU
[    4.072408] amdgpu: Topology: Add CPU node
[    4.072653] amdgpu 0000:65:00.0: enabling device (0006 -> 0007)
[    4.072737] amdgpu 0000:65:00.0: initializing kernel modesetting 
(YELLOW_CARP 0x1002:0x1681 0x1043:0x107D 0x01).
[    4.074465] amdgpu 0000:65:00.0: register mmio base: 0xDD900000
[    4.074471] amdgpu 0000:65:00.0: register mmio size: 524288
[    4.078946] amdgpu 0000:65:00.0: detected ip block number 0 
<common_v1_0_0> (nv_common)
[    4.078951] amdgpu 0000:65:00.0: detected ip block number 1 
<gmc_v10_0_0> (gmc_v10_0)
[    4.078955] amdgpu 0000:65:00.0: detected ip block number 2 
<ih_v5_0_0> (navi10_ih)
[    4.078957] amdgpu 0000:65:00.0: detected ip block number 3 
<psp_v13_0_0> (psp)
[    4.078962] amdgpu 0000:65:00.0: detected ip block number 4 
<smu_v13_0_0> (smu)
[    4.078965] amdgpu 0000:65:00.0: detected ip block number 5 
<dce_v1_0_0> (dm)
[    4.078967] amdgpu 0000:65:00.0: detected ip block number 6 
<gfx_v10_0_0> (gfx_v10_0)
[    4.078970] amdgpu 0000:65:00.0: detected ip block number 7 
<sdma_v5_2_0> (sdma_v5_2)
[    4.078973] amdgpu 0000:65:00.0: detected ip block number 8 
<vcn_v3_0_0> (vcn_v3_0)
[    4.078976] amdgpu 0000:65:00.0: detected ip block number 9 
<jpeg_v3_0_0> (jpeg_v3_0)
[    4.079009] amdgpu 0000:65:00.0: Fetched VBIOS from VFCT
[    4.079012] amdgpu 0000:65:00.0: [drm] ATOM BIOS: 113-REMBRANDT-X37
[    4.080997] sdhci-pci 0000:03:00.0: SDHCI controller found 
[17a0:9755] (rev 0)
[    4.081026] sdhci-pci 0000:03:00.0: enabling device (0000 -> 0002)
[    4.085821] nvidia-modeset: Loading NVIDIA UNIX Open Kernel Mode 
Setting Driver for x86_64  610.43.02  Release Build (root@)
[    4.105458] mmc0: SDHCI controller on PCI [0000:03:00.0] using ADMA 
64-bit
[    4.112345] nvme 0000:04:00.0: platform quirk: setting simple suspend
[    4.112615] nvme nvme0: pci function 0000:04:00.0
[    4.116275] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[    4.126326] amdgpu 0000:65:00.0: vgaarb: deactivate vga console
[    4.126341] amdgpu 0000:65:00.0: Trusted Memory Zone (TMZ) feature 
disabled as experimental (default)
[    4.126341] nvme nvme0: D3 entry latency set to 10 seconds
[    4.126426] amdgpu 0000:65:00.0: vm size is 262144 GB, 4 levels, 
block size is 9-bit, fragment size is 9-bit
[    4.126440] amdgpu 0000:65:00.0: VRAM: 512M 0x000000F400000000 - 
0x000000F41FFFFFFF (512M used)
[    4.126446] amdgpu 0000:65:00.0: GART: 1024M 0x0000000000000000 - 
0x000000003FFFFFFF
[    4.126496] amdgpu 0000:65:00.0: [drm] Detected VRAM RAM=512M, BAR=512M
[    4.126500] amdgpu 0000:65:00.0: [drm] RAM width 128bits LPDDR5
[    4.126857] amdgpu 0000:65:00.0:  512M of VRAM memory ready
[    4.126866] amdgpu 0000:65:00.0:  7609M of GTT memory ready.
[    4.126928] amdgpu 0000:65:00.0: [drm] GART: num cpu pages 262144, 
num gpu pages 262144
[    4.127653] amdgpu 0000:65:00.0: [drm] PCIE GART of 1024M enabled 
(table at 0x000000F41FC00000).
[    4.128833] amdgpu 0000:65:00.0: [drm] Loading DMUB firmware via PSP: 
version=0x0400004B
[    4.129865] amdgpu 0000:65:00.0: [drm] use_doorbell being set to: [true]
[    4.129902] amdgpu 0000:65:00.0: [VCN instance 0] Found VCN firmware 
Version ENC: 1.33 DEC: 4 VEP: 0 Revision: 15
[    4.132491] nvme nvme0: 16/0/0 default/read/poll queues
[    4.150759]  nvme0n1: p6 p7
[    4.154712] amdgpu 0000:65:00.0: reserve 0xa00000 from 0xf41e000000 
for PSP TMR
[    4.214132] device-mapper: uevent: version 1.0.3
[    4.214242] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) 
initialised: dm-devel@lists.linux.dev
[    4.329583] amdgpu 0000:65:00.0: RAS: optional ras ta ucode is not 
available
[    4.342574] amdgpu 0000:65:00.0: RAP: optional rap ta ucode is not 
available
[    4.342579] amdgpu 0000:65:00.0: SECUREDISPLAY: optional 
securedisplay ta ucode is not available
[    4.344725] amdgpu 0000:65:00.0: SMU is initialized successfully!
[    4.345862] amdgpu 0000:65:00.0: [drm] Display Core v3.2.369 
initialized on DCN 3.1.2
[    4.345869] amdgpu 0000:65:00.0: [drm] DP-HDMI FRL PCON supported
[    4.347602] amdgpu 0000:65:00.0: [drm] DMUB hardware initialized: 
version=0x0400004B
[    4.410603] amdgpu 0000:65:00.0: [drm] eDP-1: PSR support 0, DC PSR 
ver -1, sink PSR ver 0 DPCD caps 0xb su_y_granularity 0
[    4.410696] amdgpu 0000:65:00.0: [drm] HDMI-A-1: PSR support 0, DC 
PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.410769] amdgpu 0000:65:00.0: [drm] DP-1: PSR support 0, DC PSR 
ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.410819] amdgpu 0000:65:00.0: [drm] DP-2: PSR support 0, DC PSR 
ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.410904] amdgpu 0000:65:00.0: [drm] DP-3: PSR support 0, DC PSR 
ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.410958] amdgpu 0000:65:00.0: [drm] DP-4: PSR support 0, DC PSR 
ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.411020] amdgpu 0000:65:00.0: [drm] DP-5: PSR support 0, DC PSR 
ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.411098] amdgpu 0000:65:00.0: [drm] DP-6: PSR support 0, DC PSR 
ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.411751] amdgpu 0000:65:00.0: kiq ring mec 2 pipe 1 q 0
[    4.417528] kfd kfd: Allocated 3969056 bytes on gart
[    4.417549] kfd kfd: Total number of KFD nodes to be created: 1
[    4.417801] amdgpu: Virtual CRAT table created for GPU
[    4.418775] amdgpu: Topology: Add GPU node [0x1002:0x1681]
[    4.418777] kfd kfd: added device 1002:1681
[    4.418792] amdgpu 0000:65:00.0: SE 1, SH per SE 2, CU per SH 6, 
active_cu_number 12
[    4.418797] amdgpu 0000:65:00.0: ring gfx_0.0.0 uses VM inv eng 0 on 
hub 0
[    4.418799] amdgpu 0000:65:00.0: ring gfx_0.1.0 uses VM inv eng 1 on 
hub 0
[    4.418801] amdgpu 0000:65:00.0: ring comp_1.0.0 uses VM inv eng 4 on 
hub 0
[    4.418802] amdgpu 0000:65:00.0: ring comp_1.1.0 uses VM inv eng 5 on 
hub 0
[    4.418804] amdgpu 0000:65:00.0: ring comp_1.2.0 uses VM inv eng 6 on 
hub 0
[    4.418805] amdgpu 0000:65:00.0: ring comp_1.3.0 uses VM inv eng 7 on 
hub 0
[    4.418806] amdgpu 0000:65:00.0: ring comp_1.0.1 uses VM inv eng 8 on 
hub 0
[    4.418808] amdgpu 0000:65:00.0: ring comp_1.1.1 uses VM inv eng 9 on 
hub 0
[    4.418809] amdgpu 0000:65:00.0: ring comp_1.2.1 uses VM inv eng 10 
on hub 0
[    4.418810] amdgpu 0000:65:00.0: ring comp_1.3.1 uses VM inv eng 11 
on hub 0
[    4.418812] amdgpu 0000:65:00.0: ring kiq_0.2.1.0 uses VM inv eng 12 
on hub 0
[    4.418813] amdgpu 0000:65:00.0: ring sdma0 uses VM inv eng 13 on hub 0
[    4.418814] amdgpu 0000:65:00.0: ring vcn_dec_0 uses VM inv eng 0 on 
hub 8
[    4.418816] amdgpu 0000:65:00.0: ring vcn_enc_0.0 uses VM inv eng 1 
on hub 8
[    4.418817] amdgpu 0000:65:00.0: ring vcn_enc_0.1 uses VM inv eng 4 
on hub 8
[    4.418818] amdgpu 0000:65:00.0: ring jpeg_dec uses VM inv eng 5 on hub 8
[    4.420327] amdgpu 0000:65:00.0: Runtime PM not available
[    4.420781] amdgpu 0000:65:00.0: [drm] Using custom brightness curve
[    4.421809] amdgpu 0000:65:00.0: [drm] Registered 4 planes with drm panic
[    4.428537] [drm] Initialized amdgpu 3.64.0 for 0000:65:00.0 on minor 1
[    4.447029] fbcon: amdgpudrmfb (fb0) is primary device
[    4.447037] fbcon: Deferring console take-over
[    4.447043] amdgpu 0000:65:00.0: [drm] fb0: amdgpudrmfb frame buffer 
device
[    4.574644] [drm] pre_validate_dsc:1667 MST_DSC dsc precompute is not 
needed
[    5.865865] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[    5.867709] [drm] Initialized nvidia-drm 0.0.0 for 0000:01:00.0 on 
minor 2
[    5.867741] nvidia 0000:01:00.0: [drm] No compatible format found
[    5.867744] nvidia 0000:01:00.0: [drm] Cannot find any crtc or sizes
[    6.343611] Key type trusted registered
[    6.345786] Key type encrypted registered
[    6.382661] BTRFS: device label Malas Decisiones devid 1 transid 
849384 /dev/mapper/malasdecisiones (253:0) scanned by mount (360)
[    6.383038] BTRFS info (device dm-0): first mount of filesystem 
22b6302a-51c8-4c7b-b0f0-40b7baa5421c
[    6.383042] BTRFS info (device dm-0): using crc32c checksum algorithm
[    6.450069] BTRFS info (device dm-0): enabling ssd optimizations
[    6.450073] BTRFS info (device dm-0): turning on async discard
[    6.450075] BTRFS info (device dm-0): enabling free space tree
[    6.450077] BTRFS info (device dm-0): use zstd compression, level 8
[    6.596697] systemd-journald[195]: Received SIGTERM from PID 1 (systemd).
[    7.312912] systemd[1]: systemd 260.2-2-arch running in system mode 
(+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT 
+GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 +KMOD 
+LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY 
+P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF 
+XKBCOMMON +UTMP +LIBARCHIVE)
[    7.312939] systemd[1]: Detected architecture x86-64.
[    7.322226] systemd[1]: Received untrusted credentials: 
nvpcr-anchor.60831444225341dc9bf4534be89fb4fa, 
nvpcr-anchor.8696d28fd91d491bb9a81447af16cbe9, 
nvpcr-anchor.e0d25e725f974937888f257745cb77de
[    7.322237] systemd[1]: Acquired 0 regular credentials, 3 untrusted 
credentials.
[    7.322594] systemd[1]: Hostname set to <megagei>.
[    7.405495] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    7.622123] systemd[1]: initrd-switch-root.service: Deactivated 
successfully.
[    7.622260] systemd[1]: Stopped Switch Root.
[    7.622996] systemd[1]: systemd-journald.service: Scheduled restart 
job, restart counter is at 1.
[    7.623347] systemd[1]: Created slice Slice /system/dirmngr.
[    7.623654] systemd[1]: Created slice Slice /system/getty.
[    7.623964] systemd[1]: Created slice Slice /system/gpg-agent.
[    7.624240] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    7.624556] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    7.624886] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    7.625153] systemd[1]: Created slice Slice /system/keyboxd.
[    7.625423] systemd[1]: Created slice Slice /system/modprobe.
[    7.625655] systemd[1]: Created slice User and Session Slice.
[    7.625686] systemd[1]: Dispatch Password Requests to Console 
Directory Watch skipped, unmet condition check 
ConditionPathExists=!/run/plymouth/pid
[    7.625726] systemd[1]: Started Forward Password Requests to Wall 
Directory Watch.
[    7.625877] systemd[1]: Set up automount Arbitrary Executable File 
Formats File System Automount Point.
[    7.625900] systemd[1]: Expecting device /dev/disk/by-uuid/9A0A-BB8A...
[    7.625916] systemd[1]: Reached target Login Prompts.
[    7.625931] systemd[1]: Reached target Image Downloads.
[    7.625947] systemd[1]: Stopped target Switch Root.
[    7.625961] systemd[1]: Stopped target Initrd File Systems.
[    7.625973] systemd[1]: Stopped target Initrd Root File System.
[    7.625987] systemd[1]: Reached target Local Integrity Protected Volumes.
[    7.626007] systemd[1]: Reached target Path Units.
[    7.626020] systemd[1]: Reached target Remote File Systems.
[    7.626033] systemd[1]: Reached target Slice Units.
[    7.626058] systemd[1]: Reached target Local Verity Protected Volumes.
[    7.626117] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.626613] systemd[1]: Listening on Query the User Interactively for 
a Password.
[    7.628152] systemd[1]: Listening on Process Core Dump Socket.
[    7.628499] systemd[1]: Listening on Credential Encryption/Decryption.
[    7.628974] systemd[1]: Listening on Factory Reset Management.
[    7.629471] systemd[1]: Listening on Console Output Muting Service 
Socket.
[    7.630475] systemd[1]: Listening on TPM PCR Measurements.
[    7.630870] systemd[1]: Listening on Make TPM PCR Policy.
[    7.631225] systemd[1]: Listening on Disk Repartitioning Service Socket.
[    7.631288] systemd[1]: Listening on udev Control Socket.
[    7.631355] systemd[1]: Listening on udev Varlink Socket.
[    7.631429] systemd[1]: Listening on User Database Manager Socket.
[    7.632862] systemd[1]: Mounting Huge Pages File System...
[    7.633447] systemd[1]: Mounting POSIX Message Queue File System...
[    7.634033] systemd[1]: Mounting Kernel Debug File System...
[    7.634596] systemd[1]: Mounting Kernel Trace File System...
[    7.644747] systemd[1]: Starting Create List of Static Device Nodes...
[    7.644894] systemd[1]: Load Kernel Module configfs skipped, unmet 
condition check ConditionKernelModuleLoaded=!configfs
[    7.645562] systemd[1]: Mounting Kernel Configuration File System...
[    7.645598] systemd[1]: Load Kernel Module drm skipped, unmet 
condition check ConditionKernelModuleLoaded=!drm
[    7.645622] systemd[1]: Load Kernel Module fuse skipped, unmet 
condition check ConditionKernelModuleLoaded=!fuse
[    7.646210] systemd[1]: Mounting FUSE Control File System...
[    7.646297] systemd[1]: plymouth-switch-root.service: Deactivated 
successfully.
[    7.646362] systemd[1]: Stopped Plymouth switch root service.
[    7.646527] systemd[1]: systemd-cryptsetup@malasdecisiones.service: 
Deactivated successfully.
[    7.646565] systemd[1]: Stopped 
systemd-cryptsetup@malasdecisiones.service.
[    7.646793] systemd[1]: Clear Stale Hibernate Storage Info skipped, 
unmet condition check 
ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67
[    7.654211] systemd[1]: Starting Journal Service...
[    7.660273] systemd[1]: Starting Load Kernel Modules...
[    7.662433] systemd[1]: Starting TPM PCR Machine ID Measurement...
[    7.663192] systemd[1]: Starting Remount Root and Kernel File Systems...
[    7.664023] systemd[1]: Starting Early TPM SRK Setup...
[    7.664677] systemd[1]: Starting Load udev Rules from Credentials...
[    7.665499] systemd[1]: Starting Coldplug All udev Devices...
[    7.674515] systemd[1]: Mounted Huge Pages File System.
[    7.674691] systemd[1]: Mounted POSIX Message Queue File System.
[    7.674811] systemd[1]: Mounted Kernel Debug File System.
[    7.674913] systemd[1]: Mounted Kernel Trace File System.
[    7.675186] systemd[1]: Finished Create List of Static Device Nodes.
[    7.675331] systemd[1]: Mounted Kernel Configuration File System.
[    7.675436] systemd[1]: Mounted FUSE Control File System.
[    7.676518] systemd[1]: Starting Create Static Device Nodes in /dev 
gracefully...
[    7.680924] systemd[1]: Finished Load udev Rules from Credentials.
[    7.682487] systemd[1]: Finished Remount Root and Kernel File Systems.
[    7.682703] systemd-journald[445]: Collecting audit messages is disabled.
[    7.683062] systemd[1]: Rebuild Hardware Database skipped, no trigger 
condition checks were met.
[    7.684046] systemd[1]: Starting Load/Save OS Random Seed...
[    7.684335] i2c_dev: i2c /dev entries driver
[    7.686039] systemd[1]: Finished Load Kernel Modules.
[    7.687256] systemd[1]: Starting Apply Kernel Variables...
[    7.687327] systemd[1]: Started Journal Service.
[    7.722415] systemd-journald[445]: Received client request to flush 
runtime journal.
[    8.205201] ACPI: bus type thunderbolt registered
[    8.215707] acpi-tad ACPI000E:00: Missing _PRW
[    8.307285] cfg80211: Loading compiled-in X.509 certificates for 
regulatory database
[    8.307458] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    8.307611] Loaded X.509 cert 'wens: 
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    8.308005] i2c_hid_acpi i2c-ELAN9008:00: i2c_hid_get_input: IRQ 
triggered but there's no data
[    8.308315] faux_driver regulatory: Direct firmware load for 
regulatory.db failed with error -2
[    8.308320] cfg80211: failed to load regulatory.db
[    8.315227] Serial bus multi instantiate pseudo device driver 
CSC3551:00: Instantiated 2 I2C devices.
[    8.315584] input: ELAN9008:00 04F3:2F19 Touchscreen as 
/devices/platform/AMDI0010:00/i2c-0/i2c-ELAN9008:00/0018:04F3:2F19.0002/input/input6
[    8.316185] input: ASUE1210:00 04F3:31FA Mouse as 
/devices/platform/AMDI0010:03/i2c-2/i2c-ASUE1210:00/0018:04F3:31FA.0001/input/input4
[    8.334837] input: ELAN9008:00 04F3:2F19 as 
/devices/platform/AMDI0010:00/i2c-0/i2c-ELAN9008:00/0018:04F3:2F19.0002/input/input7
[    8.335642] input: ASUE1210:00 04F3:31FA Touchpad as 
/devices/platform/AMDI0010:03/i2c-2/i2c-ASUE1210:00/0018:04F3:31FA.0001/input/input5
[    8.341123] input: ELAN9008:00 04F3:2F19 as 
/devices/platform/AMDI0010:00/i2c-0/i2c-ELAN9008:00/0018:04F3:2F19.0002/input/input8
[    8.342630] hid-generic 0018:04F3:31FA.0001: input,hidraw0: I2C HID 
v1.00 Mouse [ASUE1210:00 04F3:31FA] on i2c-ASUE1210:00
[    8.342711] input: PC Speaker as /devices/platform/pcspkr/input/input10
[    8.345359] hid-generic 0018:04F3:2F19.0002: input,hidraw1: I2C HID 
v1.00 Device [ELAN9008:00 04F3:2F19] on i2c-ELAN9008:00
[    8.350796] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, 
revision 0
[    8.350801] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus 
port selection
[    8.355698] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller 
at 0xb20
[    8.362971] asus_wmi: ASUS WMI generic driver loaded
[    8.387192] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    8.388771] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO 
address
[    8.389573] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec 
(nowayout=0)
[    8.396367] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 
163840 ms ovfl timer
[    8.396372] RAPL PMU: hw unit of domain package 2^-16 Joules
[    8.396375] RAPL PMU: hw unit of domain core 2^-16 Joules
[    8.542507] asus_armoury: No matching power limits found for this system
[    8.542541] mc: Linux media interface: v0.10
[    8.567719] Bluetooth: Core ver 2.22
[    8.567748] NET: Registered PF_BLUETOOTH protocol family
[    8.567750] Bluetooth: HCI device and connection manager initialized
[    8.567760] Bluetooth: HCI socket layer initialized
[    8.567764] Bluetooth: L2CAP socket layer initialized
[    8.567770] Bluetooth: SCO socket layer initialized
[    8.579947] asus_wmi: Initialization: 0x1
[    8.580969] asus_wmi: BIOS WMI version: 9.4
[    8.581667] asus_wmi: SFUN value: 0x21
[    8.581704] asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
[    8.586572] snd_pci_acp6x 0000:65:00.5: enabling device (0000 -> 0002)
[    8.590757] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Adding DSD 
properties for 10431EE2
[    8.592219] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Using extra 
_DSD properties, bypassing _DSD in ACPI
[    8.594772] videodev: Linux video capture interface: v2.00
[    8.605449] asus-nb-wmi asus-nb-wmi: Using throttle_thermal_policy 
for platform_profile support
[    8.605579] input: ASUE1210:00 04F3:31FA Mouse as 
/devices/platform/AMDI0010:03/i2c-2/i2c-ASUE1210:00/0018:04F3:31FA.0001/input/input11
[    8.605700] input: ASUE1210:00 04F3:31FA Touchpad as 
/devices/platform/AMDI0010:03/i2c-2/i2c-ASUE1210:00/0018:04F3:31FA.0001/input/input12
[    8.605764] hid-multitouch 0018:04F3:31FA.0001: input,hidraw0: I2C 
HID v1.00 Mouse [ASUE1210:00 04F3:31FA] on i2c-ASUE1210:00
[    8.612812] input: Asus WMI hotkeys as 
/devices/platform/asus-nb-wmi/input/input13
[    8.633677] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Cirrus Logic 
CS35L41 (35a40), Revision: B2
[    8.633986] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Adding DSD 
properties for 10431EE2
[    8.634103] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Using extra 
_DSD properties, bypassing _DSD in ACPI
[    8.634108] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Reset line 
busy, assuming shared reset
[    8.651699] asus_wmi: fan_curve_get_factory_default (0x00110024) 
failed: -19
[    8.652153] asus_wmi: fan_curve_get_factory_default (0x00110025) 
failed: -19
[    8.652623] asus_wmi: fan_curve_get_factory_default (0x00110032) 
failed: -19
[    8.660773] FAT-fs (nvme0n1p6): Volume was not properly unmounted. 
Some data may be corrupt. Please run fsck.
[    8.667585] usbcore: registered new interface driver btusb
[    8.668232] mt7921e 0000:02:00.0: disabling ASPM  L1
[    8.668237] mt7921e 0000:02:00.0: can't disable ASPM; OS doesn't have 
ASPM control
[    8.677028] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 
20260224103448
[    8.680464] mt7921e 0000:02:00.0: ASIC revision: 79220010
[    8.682634] input: ELAN9008:00 04F3:2F19 as 
/devices/platform/AMDI0010:00/i2c-0/i2c-ELAN9008:00/0018:04F3:2F19.0002/input/input14
[    8.682732] input: ELAN9008:00 04F3:2F19 UNKNOWN as 
/devices/platform/AMDI0010:00/i2c-0/i2c-ELAN9008:00/0018:04F3:2F19.0002/input/input15
[    8.682908] input: ELAN9008:00 04F3:2F19 UNKNOWN as 
/devices/platform/AMDI0010:00/i2c-0/i2c-ELAN9008:00/0018:04F3:2F19.0002/input/input16
[    8.683027] hid-multitouch 0018:04F3:2F19.0002: input,hidraw1: I2C 
HID v1.00 Device [ELAN9008:00 04F3:2F19] on i2c-ELAN9008:00
[    8.684009] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Cirrus Logic 
CS35L41 (35a40), Revision: B2
[    8.687482] kvm_amd: TSC scaling supported
[    8.687486] kvm_amd: Nested Virtualization enabled
[    8.687492] kvm_amd: Nested Paging enabled
[    8.687496] kvm_amd: LBR virtualization supported
[    8.687503] kvm_amd: Virtual VMLOAD VMSAVE supported
[    8.687505] kvm_amd: Virtual GIF supported
[    8.690911] ACPI: battery: new hook: ASUS Battery Extension
[    8.691168] snd_hda_intel 0000:65:00.1: enabling device (0000 -> 0002)
[    8.691344] snd_hda_intel 0000:65:00.1: Handle vga_switcheroo audio 
client
[    8.691595] snd_hda_intel 0000:65:00.6: enabling device (0000 -> 0002)
[    8.694607] mousedev: PS/2 mouse device common for all mice
[    8.694819] uvcvideo 5-1:1.0: Found UVC 1.10 device USB2.0 HD UVC 
WebCam (0408:30e1)
[    8.706581] usbcore: registered new interface driver uvcvideo
[    8.710130] snd_hda_intel 0000:65:00.1: bound 0000:65:00.0 (ops 
amdgpu_dm_audio_component_bind_ops [amdgpu])
[    8.712747] input: HD-Audio Generic HDMI/DP,pcm=3 as 
/devices/pci0000:00/0000:00:08.1/0000:65:00.1/sound/card0/input18
[    8.712851] input: HD-Audio Generic HDMI/DP,pcm=7 as 
/devices/pci0000:00/0000:00:08.1/0000:65:00.1/sound/card0/input19
[    8.712923] input: HD-Audio Generic HDMI/DP,pcm=8 as 
/devices/pci0000:00/0000:00:08.1/0000:65:00.1/sound/card0/input20
[    8.745212] intel_rapl_common: Found RAPL domain package
[    8.745220] intel_rapl_common: Found RAPL domain core
[    8.745390] amd_atl: AMD Address Translation Library initialized
[    8.757259] snd_hda_codec_alc269 hdaudioC1D0: ALC285: picked fixup  
for codec SSID 1043:1ee2
[    8.758940] mt7921e 0000:02:00.0: HW/SW Version: 0x8a108a10, Build 
Time: 20260224103145a
[    8.760605] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: format 3 timestamp 0x6128e16b
[    8.760610] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: Fri 27 Aug 2021 14:58:19 W. 
Europe Daylight Time
[    8.908659] Adding 134217724k swap on /.swap/swapfile. Priority:-1 
extents:10626 across:910628296k SS
[    9.127462] mt7921e 0000:02:00.0: WM Firmware Version: ____000000, 
Build Time: 20260224103233
[    9.214024] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 
400a4 vendor: 0x2 v0.43.1, 2 algorithms
[    9.215144] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2-l0.bin (v1): v0.43.1
[    9.215148] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: 
C:\Users\tyang\Desktop\Product 
Setting\SmartAMP\ASUS\ASUS_Zenbook\UM6702\Tuning Release\01252022\UM6
[    9.285120] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration 
applied: R0=10056
[    9.299157] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded 
- Type: spk-prot, Gain: 17
[    9.299236] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: CS35L41 Bound - 
SSID: 10431EE2, BST: 1, VSPK: 1, CH: L, FW EN: 1, SPKID: -19
[    9.299242] snd_hda_codec_alc269 hdaudioC1D0: bound 
i2c-CSC3551:00-cs35l41-hda.0 (ops cs35l41_hda_comp_ops 
[snd_hda_scodec_cs35l41])
[    9.300434] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: format 3 timestamp 0x6128e16b
[    9.300438] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: Fri 27 Aug 2021 14:58:19 W. 
Europe Daylight Time
[    9.754100] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 
400a4 vendor: 0x2 v0.43.1, 2 algorithms
[    9.755187] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2-r0.bin (v1): v0.43.1
[    9.755190] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: 
C:\Users\tyang\Desktop\Product 
Setting\SmartAMP\ASUS\ASUS_Zenbook\UM6702\Tuning Release\01252022\UM6
[    9.824365] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration 
applied: R0=9714
[    9.838580] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded 
- Type: spk-prot, Gain: 17
[    9.838661] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: CS35L41 Bound - 
SSID: 10431EE2, BST: 1, VSPK: 1, CH: R, FW EN: 1, SPKID: -19
[    9.838668] snd_hda_codec_alc269 hdaudioC1D0: bound 
i2c-CSC3551:00-cs35l41-hda.1 (ops cs35l41_hda_comp_ops 
[snd_hda_scodec_cs35l41])
[    9.838993] snd_hda_codec_alc269 hdaudioC1D0: autoconfig for ALC285: 
line_outs=2 (0x14/0x17/0x0/0x0/0x0) type:speaker
[    9.838998] snd_hda_codec_alc269 hdaudioC1D0:    speaker_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[    9.839003] snd_hda_codec_alc269 hdaudioC1D0:    hp_outs=1 
(0x21/0x0/0x0/0x0/0x0)
[    9.839006] snd_hda_codec_alc269 hdaudioC1D0:    mono: mono_out=0x0
[    9.839009] snd_hda_codec_alc269 hdaudioC1D0:    inputs:
[    9.839012] snd_hda_codec_alc269 hdaudioC1D0:      Mic=0x12
[   10.238079] mt7921e 0000:02:00.0 wlp2s0: renamed from wlan0
[   10.486919] input: HD-Audio Generic Headphone as 
/devices/pci0000:00/0000:00:08.1/0000:65:00.6/sound/card1/input21
[   10.937801] Bluetooth: hci0: Device setup in 2217087 usecs
[   10.937812] Bluetooth: hci0: HCI Enhanced Setup Synchronous 
Connection command is advertised, but not supported.
[   10.999210] Bluetooth: hci0: AOSP extensions version v1.00
[   10.999221] Bluetooth: hci0: AOSP quality report is supported
[   12.625164] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.625168] Bluetooth: BNEP filters: protocol multicast
[   12.625174] Bluetooth: BNEP socket layer initialized
[   12.626445] Bluetooth: MGMT ver 1.23
[   12.632730] NET: Registered PF_ALG protocol family
[   15.703278] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[   16.175219] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[   16.212479] wlp2s0: authenticated
[   16.213538] wlp2s0: associate with f8:64:b8:b8:3d:7c (try 1/3)
[   16.233664] wlp2s0: RX AssocResp from f8:64:b8:b8:3d:7c (capab=0x1031 
status=0 aid=2)
[   16.265336] wlp2s0: associated
[   18.547261] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[   19.997903] Bluetooth: RFCOMM TTY layer initialized
[   19.997929] Bluetooth: RFCOMM socket layer initialized
[   19.997936] Bluetooth: RFCOMM ver 1.11
[   24.845324] BTRFS info (device dm-0 state M): use zstd compression, 
level 6
[   30.285951] wlp2s0: deauthenticating from f8:64:b8:b8:3d:7c by local 
choice (Reason: 3=DEAUTH_LEAVING)
[   30.691278] PM: suspend entry (s2idle)
[   30.712519] Filesystems sync: 0.021 seconds
[   31.417203] Freezing user space processes
[   31.418572] Freezing user space processes completed (elapsed 0.001 
seconds)
[   31.418579] OOM killer disabled.
[   31.418580] Freezing remaining freezable tasks
[   31.419518] Freezing remaining freezable tasks completed (elapsed 
0.000 seconds)
[   31.419522] printk: Suspending console(s) (use no_console_suspend to 
debug)
[   31.432789] queueing ieee80211 work while going to suspend
[   31.438505] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
[   31.901091] pcieport 0000:00:08.3: quirk: disabling D3cold for suspend
[   31.902303] ACPI: EC: interrupt blocked
[   74.340228] ACPI: EC: interrupt unblocked
[   74.403080] NVRM: RmHandleDNotifierEvent: RmHandleDNotifierEvent: 
Failed to handle ACPI D-Notifier event, status=0x11
[   74.538659] amdgpu 0000:65:00.0: [drm] PCIE GART of 1024M enabled 
(table at 0x000000F41FC00000).
[   74.538794] amdgpu 0000:65:00.0: SMU is resuming...
[   74.540645] nvme nvme0: D3 entry latency set to 10 seconds
[   74.541209] amdgpu 0000:65:00.0: SMU is resumed successfully!
[   74.541546] i2c_hid_acpi i2c-ASUE1210:00: i2c_hid_get_input: 
incomplete report (16/65280)
[   74.544492] nvme nvme0: 16/0/0 default/read/poll queues
[   74.580641] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: format 3 timestamp 0x6128e16b
[   74.580648] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: Fri 27 Aug 2021 14:58:19 W. 
Europe Daylight Time
[   74.799882] amdgpu 0000:65:00.0: ring gfx_0.0.0 uses VM inv eng 0 on 
hub 0
[   74.799891] amdgpu 0000:65:00.0: ring gfx_0.1.0 uses VM inv eng 1 on 
hub 0
[   74.799894] amdgpu 0000:65:00.0: ring comp_1.0.0 uses VM inv eng 4 on 
hub 0
[   74.799896] amdgpu 0000:65:00.0: ring comp_1.1.0 uses VM inv eng 5 on 
hub 0
[   74.799898] amdgpu 0000:65:00.0: ring comp_1.2.0 uses VM inv eng 6 on 
hub 0
[   74.799900] amdgpu 0000:65:00.0: ring comp_1.3.0 uses VM inv eng 7 on 
hub 0
[   74.799902] amdgpu 0000:65:00.0: ring comp_1.0.1 uses VM inv eng 8 on 
hub 0
[   74.799903] amdgpu 0000:65:00.0: ring comp_1.1.1 uses VM inv eng 9 on 
hub 0
[   74.799905] amdgpu 0000:65:00.0: ring comp_1.2.1 uses VM inv eng 10 
on hub 0
[   74.799908] amdgpu 0000:65:00.0: ring comp_1.3.1 uses VM inv eng 11 
on hub 0
[   74.799910] amdgpu 0000:65:00.0: ring kiq_0.2.1.0 uses VM inv eng 12 
on hub 0
[   74.799912] amdgpu 0000:65:00.0: ring sdma0 uses VM inv eng 13 on hub 0
[   74.799914] amdgpu 0000:65:00.0: ring vcn_dec_0 uses VM inv eng 0 on 
hub 8
[   74.799916] amdgpu 0000:65:00.0: ring vcn_enc_0.0 uses VM inv eng 1 
on hub 8
[   74.799919] amdgpu 0000:65:00.0: ring vcn_enc_0.1 uses VM inv eng 4 
on hub 8
[   74.799921] amdgpu 0000:65:00.0: ring jpeg_dec uses VM inv eng 5 on hub 8
[   74.841244] OOM killer enabled.
[   74.841248] Restarting tasks: Starting
[   74.842134] Restarting tasks: Done
[   74.842147] efivarfs: resyncing variable state
[   74.845970] efivarfs: finished resyncing variable state
[   74.846051] random: crng reseeded on system resumption
[   75.039379] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 
400a4 vendor: 0x2 v0.43.1, 2 algorithms
[   75.039951] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: format 3 timestamp 0x6128e16b
[   75.039963] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: Fri 27 Aug 2021 14:58:19 W. 
Europe Daylight Time
[   75.040852] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2-r0.bin (v1): v0.43.1
[   75.040876] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: 
C:\Users\tyang\Desktop\Product 
Setting\SmartAMP\ASUS\ASUS_Zenbook\UM6702\Tuning Release\01252022\UM6
[   75.560239] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 
400a4 vendor: 0x2 v0.43.1, 2 algorithms
[   75.562154] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2-l0.bin (v1): v0.43.1
[   75.562162] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: 
C:\Users\tyang\Desktop\Product 
Setting\SmartAMP\ASUS\ASUS_Zenbook\UM6702\Tuning Release\01252022\UM6
[   75.632783] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration 
applied: R0=9714
[   75.639449] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration 
applied: R0=10056
[   75.660991] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded 
- Type: spk-prot, Gain: 17
[   75.664076] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded 
- Type: spk-prot, Gain: 17
[   75.739246] PM: suspend exit
[   78.459123] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[   78.470480] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[   78.473640] wlp2s0: authenticated
[   78.474992] wlp2s0: associate with f8:64:b8:b8:3d:7c (try 1/3)
[   78.494931] wlp2s0: RX AssocResp from f8:64:b8:b8:3d:7c (capab=0x1031 
status=0 aid=2)
[   78.524946] wlp2s0: associated
[   82.333740] nvme nvme0: using unchecked data buffer
[   82.409481] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[   83.175560] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[   84.536280] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[   85.161170] warning: `kdeconnectd' uses wireless extensions which 
will stop working for Wi-Fi 7 hardware; use nl80211
[   86.427967] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[  174.183024] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[  962.391672] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 1127.147657] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 1220.598204] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 1230.231312] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 1238.358387] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 1250.340764] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 1340.828518] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 1523.913500] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 2054.152868] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 2212.014173] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 2415.390479] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 2438.408513] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 2442.535080] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 2451.502292] perf: interrupt took too long (2521 > 2500), lowering 
kernel.perf_event_max_sample_rate to 79000
[ 2453.901044] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 2530.706314] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 3289.528840] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 3290.139675] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 3290.518503] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 3613.634983] wlp2s0: deauthenticating from f8:64:b8:b8:3d:7c by local 
choice (Reason: 3=DEAUTH_LEAVING)
[ 3618.586060] PM: suspend entry (s2idle)
[ 3619.192179] Filesystems sync: 0.606 seconds
[ 3621.272527] Freezing user space processes
[ 3621.291017] Freezing user space processes completed (elapsed 0.018 
seconds)
[ 3621.291059] OOM killer disabled.
[ 3621.291073] Freezing remaining freezable tasks
[ 3621.371379] Freezing remaining freezable tasks completed (elapsed 
0.080 seconds)
[ 3621.371418] printk: Suspending console(s) (use no_console_suspend to 
debug)
[ 3621.398851] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
[ 3621.422019] queueing ieee80211 work while going to suspend
[ 3621.784351] ACPI: EC: interrupt blocked
[ 3623.563762] ACPI: EC: interrupt unblocked
[ 3623.709926] NVRM: RmHandleDNotifierEvent: RmHandleDNotifierEvent: 
Failed to handle ACPI D-Notifier event, status=0x11
[ 3623.863977] amdgpu 0000:65:00.0: [drm] PCIE GART of 1024M enabled 
(table at 0x000000F41FC00000).
[ 3623.864089] amdgpu 0000:65:00.0: SMU is resuming...
[ 3623.865994] nvme nvme0: D3 entry latency set to 10 seconds
[ 3623.868514] amdgpu 0000:65:00.0: SMU is resumed successfully!
[ 3623.879861] nvme nvme0: 16/0/0 default/read/poll queues
[ 3624.124663] amdgpu 0000:65:00.0: ring gfx_0.0.0 uses VM inv eng 0 on 
hub 0
[ 3624.124698] amdgpu 0000:65:00.0: ring gfx_0.1.0 uses VM inv eng 1 on 
hub 0
[ 3624.124717] amdgpu 0000:65:00.0: ring comp_1.0.0 uses VM inv eng 4 on 
hub 0
[ 3624.124734] amdgpu 0000:65:00.0: ring comp_1.1.0 uses VM inv eng 5 on 
hub 0
[ 3624.124752] amdgpu 0000:65:00.0: ring comp_1.2.0 uses VM inv eng 6 on 
hub 0
[ 3624.124769] amdgpu 0000:65:00.0: ring comp_1.3.0 uses VM inv eng 7 on 
hub 0
[ 3624.124787] amdgpu 0000:65:00.0: ring comp_1.0.1 uses VM inv eng 8 on 
hub 0
[ 3624.124804] amdgpu 0000:65:00.0: ring comp_1.1.1 uses VM inv eng 9 on 
hub 0
[ 3624.124821] amdgpu 0000:65:00.0: ring comp_1.2.1 uses VM inv eng 10 
on hub 0
[ 3624.124840] amdgpu 0000:65:00.0: ring comp_1.3.1 uses VM inv eng 11 
on hub 0
[ 3624.124858] amdgpu 0000:65:00.0: ring kiq_0.2.1.0 uses VM inv eng 12 
on hub 0
[ 3624.124876] amdgpu 0000:65:00.0: ring sdma0 uses VM inv eng 13 on hub 0
[ 3624.124894] amdgpu 0000:65:00.0: ring vcn_dec_0 uses VM inv eng 0 on 
hub 8
[ 3624.124912] amdgpu 0000:65:00.0: ring vcn_enc_0.0 uses VM inv eng 1 
on hub 8
[ 3624.124930] amdgpu 0000:65:00.0: ring vcn_enc_0.1 uses VM inv eng 4 
on hub 8
[ 3624.124948] amdgpu 0000:65:00.0: ring jpeg_dec uses VM inv eng 5 on hub 8
[ 3624.285137] OOM killer enabled.
[ 3624.285156] Restarting tasks: Starting
[ 3624.295705] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: format 3 timestamp 0x6128e16b
[ 3624.295758] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: Fri 27 Aug 2021 14:58:19 W. 
Europe Daylight Time
[ 3624.317302] Restarting tasks: Done
[ 3624.317351] efivarfs: resyncing variable state
[ 3624.362306] efivarfs: finished resyncing variable state
[ 3624.362504] random: crng reseeded on system resumption
[ 3624.631013] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: format 3 timestamp 0x6128e16b
[ 3624.631061] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: Fri 27 Aug 2021 14:58:19 W. 
Europe Daylight Time
[ 3624.761537] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 
400a4 vendor: 0x2 v0.43.1, 2 algorithms
[ 3624.795554] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2-r0.bin (v1): v0.43.1
[ 3624.795638] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: 
C:\Users\tyang\Desktop\Product 
Setting\SmartAMP\ASUS\ASUS_Zenbook\UM6702\Tuning Release\01252022\UM6
[ 3625.280497] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 
400a4 vendor: 0x2 v0.43.1, 2 algorithms
[ 3625.284550] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2-l0.bin (v1): v0.43.1
[ 3625.284625] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: 
C:\Users\tyang\Desktop\Product 
Setting\SmartAMP\ASUS\ASUS_Zenbook\UM6702\Tuning Release\01252022\UM6
[ 3625.355240] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration 
applied: R0=9714
[ 3625.365162] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration 
applied: R0=10056
[ 3625.392789] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded 
- Type: spk-prot, Gain: 17
[ 3625.398799] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded 
- Type: spk-prot, Gain: 17
[ 3625.702053] PM: suspend exit
[ 3629.349443] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[ 3629.552486] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[ 3629.563226] wlp2s0: authenticated
[ 3629.566138] wlp2s0: associate with f8:64:b8:b8:3d:7a (try 1/3)
[ 3629.586463] wlp2s0: RX AssocResp from f8:64:b8:b8:3d:7a (capab=0x1c31 
status=0 aid=2)
[ 3629.616565] wlp2s0: associated
[ 3630.761751] wlp2s0: Limiting TX power to 27 (27 - 0) dBm as 
advertised by f8:64:b8:b8:3d:7a
[ 3641.990188] wlp2s0: deauthenticating from f8:64:b8:b8:3d:7a by local 
choice (Reason: 3=DEAUTH_LEAVING)
[ 3644.357000] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 3647.311976] PM: suspend entry (s2idle)
[ 3648.158528] Filesystems sync: 0.846 seconds
[ 3650.043659] Freezing user space processes
[ 3650.054473] Freezing user space processes completed (elapsed 0.010 
seconds)
[ 3650.054511] OOM killer disabled.
[ 3650.054525] Freezing remaining freezable tasks
[ 3650.057507] Freezing remaining freezable tasks completed (elapsed 
0.002 seconds)
[ 3650.057549] printk: Suspending console(s) (use no_console_suspend to 
debug)
[ 3650.082196] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
[ 3650.102720] queueing ieee80211 work while going to suspend
[ 3650.508319] ACPI: EC: interrupt blocked
[ 3763.765905] NVRM: rm_power_source_change_event: 
rm_power_source_change_event: Failed to handle Power Source change 
event, status=0x11
[ 3764.075385] ACPI: EC: interrupt unblocked
[ 3764.148305] NVRM: RmHandleDNotifierEvent: RmHandleDNotifierEvent: 
Failed to handle ACPI D-Notifier event, status=0x11
[ 3764.284532] amdgpu 0000:65:00.0: [drm] PCIE GART of 1024M enabled 
(table at 0x000000F41FC00000).
[ 3764.284560] amdgpu 0000:65:00.0: SMU is resuming...
[ 3764.286504] nvme nvme0: D3 entry latency set to 10 seconds
[ 3764.288671] amdgpu 0000:65:00.0: SMU is resumed successfully!
[ 3764.289954] nvme nvme0: 16/0/0 default/read/poll queues
[ 3764.325415] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: format 3 timestamp 0x6128e16b
[ 3764.325424] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: Fri 27 Aug 2021 14:58:19 W. 
Europe Daylight Time
[ 3764.448764] amdgpu 0000:65:00.0: ring gfx_0.0.0 uses VM inv eng 0 on 
hub 0
[ 3764.448776] amdgpu 0000:65:00.0: ring gfx_0.1.0 uses VM inv eng 1 on 
hub 0
[ 3764.448781] amdgpu 0000:65:00.0: ring comp_1.0.0 uses VM inv eng 4 on 
hub 0
[ 3764.448785] amdgpu 0000:65:00.0: ring comp_1.1.0 uses VM inv eng 5 on 
hub 0
[ 3764.448789] amdgpu 0000:65:00.0: ring comp_1.2.0 uses VM inv eng 6 on 
hub 0
[ 3764.448793] amdgpu 0000:65:00.0: ring comp_1.3.0 uses VM inv eng 7 on 
hub 0
[ 3764.448796] amdgpu 0000:65:00.0: ring comp_1.0.1 uses VM inv eng 8 on 
hub 0
[ 3764.448800] amdgpu 0000:65:00.0: ring comp_1.1.1 uses VM inv eng 9 on 
hub 0
[ 3764.448804] amdgpu 0000:65:00.0: ring comp_1.2.1 uses VM inv eng 10 
on hub 0
[ 3764.448808] amdgpu 0000:65:00.0: ring comp_1.3.1 uses VM inv eng 11 
on hub 0
[ 3764.448812] amdgpu 0000:65:00.0: ring kiq_0.2.1.0 uses VM inv eng 12 
on hub 0
[ 3764.448816] amdgpu 0000:65:00.0: ring sdma0 uses VM inv eng 13 on hub 0
[ 3764.448821] amdgpu 0000:65:00.0: ring vcn_dec_0 uses VM inv eng 0 on 
hub 8
[ 3764.448825] amdgpu 0000:65:00.0: ring vcn_enc_0.0 uses VM inv eng 1 
on hub 8
[ 3764.448829] amdgpu 0000:65:00.0: ring vcn_enc_0.1 uses VM inv eng 4 
on hub 8
[ 3764.448833] amdgpu 0000:65:00.0: ring jpeg_dec uses VM inv eng 5 on hub 8
[ 3764.591579] OOM killer enabled.
[ 3764.591582] Restarting tasks: Starting
[ 3764.594642] Restarting tasks: Done
[ 3764.594653] efivarfs: resyncing variable state
[ 3764.598912] efivarfs: finished resyncing variable state
[ 3764.598997] random: crng reseeded on system resumption
[ 3764.795657] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: format 3 timestamp 0x6128e16b
[ 3764.795667] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: Fri 27 Aug 2021 14:58:19 W. 
Europe Daylight Time
[ 3764.796884] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 
400a4 vendor: 0x2 v0.43.1, 2 algorithms
[ 3764.807528] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2-r0.bin (v1): v0.43.1
[ 3764.807535] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: 
C:\Users\tyang\Desktop\Product 
Setting\SmartAMP\ASUS\ASUS_Zenbook\UM6702\Tuning Release\01252022\UM6
[ 3765.316263] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 
400a4 vendor: 0x2 v0.43.1, 2 algorithms
[ 3765.317958] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2-l0.bin (v1): v0.43.1
[ 3765.317968] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: 
C:\Users\tyang\Desktop\Product 
Setting\SmartAMP\ASUS\ASUS_Zenbook\UM6702\Tuning Release\01252022\UM6
[ 3765.391540] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration 
applied: R0=9714
[ 3765.394755] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration 
applied: R0=10056
[ 3765.418149] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded 
- Type: spk-prot, Gain: 17
[ 3765.420227] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded 
- Type: spk-prot, Gain: 17
[ 3765.466449] PM: suspend exit
[ 3768.147768] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[ 3768.160352] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[ 3768.214259] wlp2s0: authenticated
[ 3768.216045] wlp2s0: associate with f8:64:b8:b8:3d:7a (try 1/3)
[ 3768.256264] wlp2s0: RX AssocResp from f8:64:b8:b8:3d:7a (capab=0x1c31 
status=0 aid=2)
[ 3768.287263] wlp2s0: associated
[ 3768.287438] wlp2s0: Limiting TX power to 27 (27 - 0) dBm as 
advertised by f8:64:b8:b8:3d:7a
[ 3775.337080] wlp2s0: deauthenticating from f8:64:b8:b8:3d:7a by local 
choice (Reason: 3=DEAUTH_LEAVING)
[ 3780.449156] PM: suspend entry (s2idle)
[ 3780.553011] Filesystems sync: 0.103 seconds
[ 3781.146408] Freezing user space processes
[ 3781.149088] Freezing user space processes completed (elapsed 0.002 
seconds)
[ 3781.149092] OOM killer disabled.
[ 3781.149094] Freezing remaining freezable tasks
[ 3781.150096] Freezing remaining freezable tasks completed (elapsed 
0.001 seconds)
[ 3781.150100] printk: Suspending console(s) (use no_console_suspend to 
debug)
[ 3781.167024] queueing ieee80211 work while going to suspend
[ 3781.170270] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
[ 3781.317578] ACPI: EC: interrupt blocked
[ 3795.599800] ACPI: EC: interrupt unblocked
[ 3795.662222] NVRM: RmHandleDNotifierEvent: RmHandleDNotifierEvent: 
Failed to handle ACPI D-Notifier event, status=0x11
[ 3795.790165] amdgpu 0000:65:00.0: [drm] PCIE GART of 1024M enabled 
(table at 0x000000F41FC00000).
[ 3795.790221] amdgpu 0000:65:00.0: SMU is resuming...
[ 3795.791439] nvme nvme0: D3 entry latency set to 10 seconds
[ 3795.792787] amdgpu 0000:65:00.0: SMU is resumed successfully!
[ 3795.795482] nvme nvme0: 16/0/0 default/read/poll queues
[ 3795.831128] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: format 3 timestamp 0x6128e16b
[ 3795.831137] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: Fri 27 Aug 2021 14:58:19 W. 
Europe Daylight Time
[ 3795.867675] NVRM: rm_power_source_change_event: 
rm_power_source_change_event: Failed to handle Power Source change 
event, status=0x11
[ 3795.954007] amdgpu 0000:65:00.0: ring gfx_0.0.0 uses VM inv eng 0 on 
hub 0
[ 3795.954013] amdgpu 0000:65:00.0: ring gfx_0.1.0 uses VM inv eng 1 on 
hub 0
[ 3795.954016] amdgpu 0000:65:00.0: ring comp_1.0.0 uses VM inv eng 4 on 
hub 0
[ 3795.954017] amdgpu 0000:65:00.0: ring comp_1.1.0 uses VM inv eng 5 on 
hub 0
[ 3795.954019] amdgpu 0000:65:00.0: ring comp_1.2.0 uses VM inv eng 6 on 
hub 0
[ 3795.954021] amdgpu 0000:65:00.0: ring comp_1.3.0 uses VM inv eng 7 on 
hub 0
[ 3795.954023] amdgpu 0000:65:00.0: ring comp_1.0.1 uses VM inv eng 8 on 
hub 0
[ 3795.954024] amdgpu 0000:65:00.0: ring comp_1.1.1 uses VM inv eng 9 on 
hub 0
[ 3795.954026] amdgpu 0000:65:00.0: ring comp_1.2.1 uses VM inv eng 10 
on hub 0
[ 3795.954028] amdgpu 0000:65:00.0: ring comp_1.3.1 uses VM inv eng 11 
on hub 0
[ 3795.954030] amdgpu 0000:65:00.0: ring kiq_0.2.1.0 uses VM inv eng 12 
on hub 0
[ 3795.954032] amdgpu 0000:65:00.0: ring sdma0 uses VM inv eng 13 on hub 0
[ 3795.954034] amdgpu 0000:65:00.0: ring vcn_dec_0 uses VM inv eng 0 on 
hub 8
[ 3795.954036] amdgpu 0000:65:00.0: ring vcn_enc_0.0 uses VM inv eng 1 
on hub 8
[ 3795.954037] amdgpu 0000:65:00.0: ring vcn_enc_0.1 uses VM inv eng 4 
on hub 8
[ 3795.954039] amdgpu 0000:65:00.0: ring jpeg_dec uses VM inv eng 5 on hub 8
[ 3796.099794] OOM killer enabled.
[ 3796.099797] Restarting tasks: Starting
[ 3796.102899] Restarting tasks: Done
[ 3796.102910] efivarfs: resyncing variable state
[ 3796.111670] efivarfs: finished resyncing variable state
[ 3796.111759] random: crng reseeded on system resumption
[ 3796.302453] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 
400a4 vendor: 0x2 v0.43.1, 2 algorithms
[ 3796.302905] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: format 3 timestamp 0x6128e16b
[ 3796.302918] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2.wmfw: Fri 27 Aug 2021 14:58:19 W. 
Europe Daylight Time
[ 3796.306554] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2-r0.bin (v1): v0.43.1
[ 3796.306559] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: 
C:\Users\tyang\Desktop\Product 
Setting\SmartAMP\ASUS\ASUS_Zenbook\UM6702\Tuning Release\01252022\UM6
[ 3796.824301] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 
400a4 vendor: 0x2 v0.43.1, 2 algorithms
[ 3796.826507] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: 
cirrus/cs35l41-dsp1-spk-prot-10431ee2-l0.bin (v1): v0.43.1
[ 3796.826514] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: 
C:\Users\tyang\Desktop\Product 
Setting\SmartAMP\ASUS\ASUS_Zenbook\UM6702\Tuning Release\01252022\UM6
[ 3796.898786] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration 
applied: R0=9714
[ 3796.903273] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration 
applied: R0=10056
[ 3796.903745] PM: suspend exit
[ 3796.940906] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded 
- Type: spk-prot, Gain: 17
[ 3796.944952] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded 
- Type: spk-prot, Gain: 17
[ 3799.668042] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[ 3799.680497] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[ 3799.844308] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[ 3799.941861] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[ 3799.991989] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[ 3802.759169] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[ 3802.772644] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[ 3802.841719] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[ 3802.978441] wlp2s0: authenticated
[ 3802.979773] wlp2s0: associate with f8:64:b8:b8:3d:7a (try 1/3)
[ 3803.012785] wlp2s0: RX AssocResp from f8:64:b8:b8:3d:7a (capab=0x1c31 
status=0 aid=2)
[ 3803.038207] wlp2s0: associated
[ 3803.098267] wlp2s0: Limiting TX power to 27 (27 - 0) dBm as 
advertised by f8:64:b8:b8:3d:7a
[ 4035.315084] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Failed to read 
MBOX STS: -121
[ 4257.184368] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 4257.621588] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 4257.917561] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 4425.514826] hrtimer: interrupt took 11221 ns
[ 4483.231429] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 4483.659058] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 4483.930552] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 4543.074278] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 4543.513614] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 4543.823514] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 4682.939788] wlp2s0: deauthenticating from f8:64:b8:b8:3d:7a by local 
choice (Reason: 3=DEAUTH_LEAVING)
[ 4693.771867] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 4693.786941] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 4693.797661] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 2/3)
[ 4693.807879] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 3/3)
[ 4693.818216] wlp2s0: authenticated
[ 4693.818744] wlp2s0: associate with f8:64:b8:b8:3d:7c (try 1/3)
[ 4694.235077] wlp2s0: associate with f8:64:b8:b8:3d:7c (try 2/3)
[ 4694.248395] wlp2s0: associate with f8:64:b8:b8:3d:7c (try 3/3)
[ 4694.261995] wlp2s0: association with f8:64:b8:b8:3d:7c timed out
[ 4697.019768] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 4697.034869] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 4697.048605] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 2/3)
[ 4697.059023] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 3/3)
[ 4697.069404] wlp2s0: authentication with f8:64:b8:b8:3d:7c timed out
[ 4700.250491] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 4700.265632] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 4700.280574] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 2/3)
[ 4700.294335] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 3/3)
[ 4700.308832] wlp2s0: authentication with f8:64:b8:b8:3d:7c timed out
[ 4703.959290] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 4703.974357] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 4703.984871] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 2/3)
[ 4703.994936] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 3/3)
[ 4704.005161] wlp2s0: authentication with f8:64:b8:b8:3d:7c timed out
[ 4708.541696] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 4708.556260] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 4708.566661] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 2/3)
[ 4708.577492] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 3/3)
[ 4708.587774] wlp2s0: authentication with f8:64:b8:b8:3d:7c timed out
[ 4710.853749] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[ 4710.864656] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[ 4711.012016] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[ 4711.061621] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[ 4711.193968] wlp2s0: authenticated
[ 4711.194778] wlp2s0: associate with f8:64:b8:b8:3d:7a (try 1/3)
[ 4711.276212] wlp2s0: associate with f8:64:b8:b8:3d:7a (try 2/3)
[ 4711.458642] wlp2s0: RX AssocResp from f8:64:b8:b8:3d:7a (capab=0x1c31 
status=0 aid=2)
[ 4711.488619] wlp2s0: associated
[ 4711.488710] wlp2s0: Limiting TX power to 27 (27 - 0) dBm as 
advertised by f8:64:b8:b8:3d:7a
[ 4715.064487] wlp2s0: deauthenticating from f8:64:b8:b8:3d:7a by local 
choice (Reason: 3=DEAUTH_LEAVING)
[ 4717.982390] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 4717.997595] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 4718.000627] wlp2s0: authenticated
[ 4718.001752] wlp2s0: associate with f8:64:b8:b8:3d:7c (try 1/3)
[ 4718.022017] wlp2s0: RX AssocResp from f8:64:b8:b8:3d:7c (capab=0x1031 
status=0 aid=2)
[ 4718.049685] wlp2s0: associated
[ 4902.616744] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 4903.079565] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 4903.366204] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 5127.764569] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 5128.234630] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 5128.579528] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 5202.894727] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 5203.330889] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 5203.605866] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[ 5244.984061] wlp2s0: deauthenticated from f8:64:b8:b8:3d:7c (Reason: 
3=DEAUTH_LEAVING)
[ 5248.023091] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 5248.038242] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 5248.048500] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 2/3)
[ 5248.058723] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 3/3)
[ 5248.069335] wlp2s0: authentication with f8:64:b8:b8:3d:7c timed out
[ 5251.250320] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 5251.265358] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 5251.275696] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 2/3)
[ 5251.396230] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 3/3)
[ 5251.406516] wlp2s0: authentication with f8:64:b8:b8:3d:7c timed out
[ 5255.084188] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 5255.099290] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 5255.109751] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 2/3)
[ 5255.120124] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 3/3)
[ 5255.130335] wlp2s0: authentication with f8:64:b8:b8:3d:7c timed out
[ 5263.087932] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 5263.103102] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 5263.113261] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 2/3)
[ 5263.123405] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 3/3)
[ 5263.133691] wlp2s0: authentication with f8:64:b8:b8:3d:7c timed out
[ 5275.807968] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 5275.823170] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 5275.833481] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 2/3)
[ 5275.844266] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 3/3)
[ 5275.854740] wlp2s0: authentication with f8:64:b8:b8:3d:7c timed out
[ 5291.073682] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 5291.087210] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 5291.097416] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 2/3)
[ 5291.107844] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 3/3)
[ 5291.118204] wlp2s0: authentication with f8:64:b8:b8:3d:7c timed out
[ 5303.805652] wlp2s0: authenticate with f8:64:b8:b8:3d:7c (local 
address=38:d5:7a:12:c2:3b)
[ 5303.820868] wlp2s0: send auth to f8:64:b8:b8:3d:7c (try 1/3)
[ 5303.824210] wlp2s0: authenticated
[ 5303.825746] wlp2s0: associate with f8:64:b8:b8:3d:7c (try 1/3)
[ 5303.846155] wlp2s0: RX AssocResp from f8:64:b8:b8:3d:7c (capab=0x1031 
status=0 aid=2)
[ 5303.878012] wlp2s0: associated

El 08/06/26 a las 12:12, Bitterblue Smith escribió:
> On 28/05/2026 04:44, Angel Parra wrote:
>> Hello,
>> I was advised to reach out to this mailing list regarding severe wireless connection issues with my MediaTek card. I am writing to request a review of the `mt7921e` driver. While I appreciate the significant improvements made to the `mt7902` driver recently, the support for some newer chipsets currently feels almost unusable in real-world conditions.
>>
>> My hardware details are as follows:
>> ```text
>> 02:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter
>>          Subsystem: Foxconn International, Inc. Device e0cd
>>          Kernel driver in use: mt7921e
>> ```
>>
>> Below are the most consistent bugs and instabilities I have observed to the date that constantly interrupt our workflow:
>>
>> * The adapter often fails to discover nearby access points, despite multiple mobile phones confirming their active presence.
>> * Both 2.4GHz and 5GHz WLANs frequently remain undetected, even when the laptop is directly next to the router.
>> * Regardless of physical proximity to the modem, the connection process regularly hangs on "Configuring interface" (in the KDE Plasma desktop applet) for over 15 seconds. After this delay, the connection either succeeds or fails completely.
>> * When successfully connected to 2.4GHz bands, download speeds are remarkably slow and fall significantly below what my phone achieves on the same connection.
>> * The detection range is severely limited; establishing a link to a 5GHz SSID requires being in the exact same room as the access point.
>> * Introducing a single wall between the router and the laptop triggers the aforementioned 15-second "Configuring interface" hang, usually resulting in a failed connection.
>> * Upon failing to connect to an otherwise healthy access point, the system enters an infinite loop. It hangs on configuration, fails, jumps to the next saved SSID, fails again, and cycles endlessly through all saved profiles.
>> * Overall connection stability is exceptionally poor. A successful connection might persist only if the laptop remains perfectly stationary. Otherwise, the link randomly drops after a few minutes with a "Connection deactivated" state, triggering the failed connection loop.
>> * Attempting to bypass these issues by tethering to a mobile hotspot directly next to the laptop also fails. The adapter either cannot detect the hotspot at all or hangs during configuration, leaving the machine entirely offline.
>>
>> The failing connection loop in `dmesg` looks like this over a span of several minutes, clearly illustrating the continuous authentication timeouts as the adapter cycles through my saved profiles:
>>
>> ```text
>> [148485.661369] PM: suspend exit
>> [148488.781860] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [148488.795305] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [148488.843935] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [148488.996043] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [148489.044916] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> [148491.867424] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [148491.880895] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [148491.939014] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [148492.094896] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [148492.142676] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> [148495.354718] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [148495.368216] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [148495.418798] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [148495.577799] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [148495.625990] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> [148499.324558] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [148499.337991] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [148499.387641] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [148499.542987] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [148499.593575] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> [148510.294935] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [148510.308356] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [148510.360427] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [148510.406754] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [148510.566970] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> [148520.573843] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [148520.587285] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [148520.644274] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [148520.693177] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [148521.140382] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [148541.462597] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [148541.476062] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [148541.522330] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [148541.973505] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [148542.022304] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [148548.610998] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [148548.624376] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [148549.075668] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [148549.121771] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [148549.574886] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> [148552.427178] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [148552.430014] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [148552.470639] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [148552.513942] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [148552.556374] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [148565.252575] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [148565.266023] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [148565.396382] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [148565.446749] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [148565.605849] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [148579.997166] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [148580.010594] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [148580.072257] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [148580.112398] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [148580.152361] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [148592.848439] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [148592.861867] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [148592.903480] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [148592.995422] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [148593.041528] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [148607.612953] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [148607.626393] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [148607.698476] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [148607.742091] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [148607.783429] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> [148620.219579] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [148620.233011] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [148620.328013] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [148620.374159] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [148620.534020] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [148633.224869] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [148633.238306] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [148633.303939] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [148633.356603] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [148633.514978] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [148637.634640] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [148637.647620] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [148637.694360] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [148637.743291] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [148638.192244] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> [148655.509368] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [148655.522809] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [148655.572981] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [148656.021379] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [148656.070061] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [148677.626050] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [148677.639450] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [148677.704689] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [148677.753188] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [148677.914243] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> [148680.509871] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [148680.512694] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [148680.530021] wlp2s0: authenticated
>> [148680.530280] wlp2s0: associate with 84:d8:1b:9f:91:10 (try 1/3)
>> [148680.555487] wlp2s0: RX AssocResp from 84:d8:1b:9f:91:10 (capab=0x411 status=0 aid=4)
>> [148680.582777] wlp2s0: associated
>> [149142.517235] nvidia-modeset: WARNING: GPU:0: Correcting number of heads for current head configuration (0x00)
>> [149361.823195] wlp2s0: Connection to AP 84:d8:1b:9f:91:10 lost
>> [149418.133906] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [149418.145316] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [149418.194402] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [149418.242746] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [149418.692292] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [149437.001016] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [149437.012391] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [149437.095855] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [149437.142168] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [149437.593548] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [149464.557438] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [149464.568407] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [149464.730630] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [149464.777125] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [149464.932766] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [149474.631073] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [149474.644554] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [149474.690700] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [149474.849313] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [149474.895328] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [149535.532981] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [149535.546820] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [149535.678835] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [149535.725111] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [149535.880819] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [149879.705065] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [149879.718556] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [149879.794297] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [149879.843592] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [149880.017253] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [149888.633997] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [149888.647548] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [149888.805077] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [149888.856075] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [149889.015401] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [149928.562888] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [149928.576448] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [149928.619097] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [149928.661687] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [149928.737998] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [149941.444820] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [149941.458370] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [149941.615999] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [149941.662509] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [149941.711201] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [149956.605669] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [149956.619156] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [149956.673039] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [149956.721411] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [149957.172885] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [149969.882794] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
>> [149969.896301] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
>> [149969.943140] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
>> [149969.990954] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
>> [149970.442757] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
>> [149984.624558] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [149984.638187] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [149984.697458] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [149984.737544] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [149984.778744] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> [150016.560488] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [150016.573492] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [150016.614971] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [150016.673246] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [150016.721924] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> [150051.575890] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [150051.589489] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [150051.636535] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [150051.685162] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [150052.134899] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> [150064.827990] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
>> [150064.841478] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
>> [150064.966855] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
>> [150065.015378] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
>> [150065.174847] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
>> ```
>>
>> Thank you for your time and for reading through this report. I would greatly appreciate it if this could be routed to the appropriate maintainers to help address these driver issues. Have a great day wherever you are.
>>
> Hi!
>
> These details could be helpful:
>
> - Laptop model
> - Wifi card's PCI ID (from "lspci -nn")
> - Name and version of the Linux distro
> - Full output of dmesg
>
> The mt7921e module has a parameter called "disable_aspm". Have you
> tried to set this to 1? Just a random thing you can try.
>
> I'm not sure if it's necessary with the Mediatek cards, but if you
> try this parameter, do a cold boot (set the parameter using the
> bootloader or a file in /etc/modprobe.d/, shut down the laptop, then
> turn it on again).
>
> I added the maintainers of mt76 to the Cc list.

