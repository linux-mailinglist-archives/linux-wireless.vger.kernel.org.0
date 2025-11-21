Return-Path: <linux-wireless+bounces-29235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9E5C78B67
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 12:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7870B4ED349
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB0134AB1E;
	Fri, 21 Nov 2025 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWUCVY8g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E17347BB6
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723510; cv=none; b=hQ6O1+K64IPO9XzGqb4p/Zc8cUSRSWLr5Q+afFOQDG2bG5o8N//m153gxZDk6PckUVGY78YZ5mMwojLfBUfa2f7yM7/vga5uakI/jS/qSOQKG2O1PLSQue6os0iC8kqBxP68MYKpYwjFGDUCorO7lnn8JcyJlOwnyg1RgvMjlB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723510; c=relaxed/simple;
	bh=Ljv+l5FYnzZjIfhVc8Ue2DVdlx4E1BWSiiozVB6s8zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5q/0Gnxqjul2yv5QjB/VBrCL9UtrPqaP+/iV++M8+Lk7JDwDIwiPiRtobcTXu0uTqyX9ys+p2sIDq+G2eKOhVUa9XzdD40KOTsds0m51slYjnkfB9gdLw/2papGukwHJWt4RYhAT2/stAK1VUvJWVMMdrBN6/Un3x28qLFPbyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWUCVY8g; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2984dfae0acso29416785ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 03:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723499; x=1764328299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=010VnkfiXcP7+jgFIu0UO+d2q87QOFhhEcySdNPszYc=;
        b=XWUCVY8gftL58n2KEWwOwBOcUAVElw49R72molz9M/6g+3KJmAesZK+WQ7fGuVjZt0
         2mIMjGkF9upuwYoHCcsU1cTiIA8u+IvccObrzla8IDUaqdSLBTpUC87AqJErdPDJQtXT
         feFC+bVuCYUQi32Zp02h95Rk3QaLRUu4bdQ7tZVwBHrCcfXbKddz0eOajM7EBgBvCI9Z
         V8l/fT8bOr+Lx3JhJOWDGRCDOJQk/LhDQlLiAwQ1ryd0zoj8FtoMACmeBLZFM5CObp3e
         kqnBk+sCjvJmdgJO0rDJ9WvJ74Ao2Yq+Rdm+9VBfVneE3QZPszRDRp4MHY5BUWKZcItA
         Aw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723499; x=1764328299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=010VnkfiXcP7+jgFIu0UO+d2q87QOFhhEcySdNPszYc=;
        b=FXKyjhbXEYDtg0LKsXXGxH7DJKEurjRzT4+oWTBRT+KG9FyMaIPG9CiMAVQ4Gib8/W
         /PYgqlXQkmteoQwdjHHZ5F1+w1VpfMLB3fHq9NzbqdJ6/Trnq5wVDcd4t7a34/Yp+gKn
         FAj/N1/VMOif7T1dg1W6kU72nN5n5SX8VS3rUB/0nIln2rf1peVfg3b/xJ8gM8WDPJM2
         eHa249Kaxe23yNH2bd0EPRGP2b0egeZ2aMlBtO95yW2/cDbvSMZxSi15VpjM5QiH69HV
         L/WW/8SxoUZJo6jvQ9G2RG12cJDckGBZ0ulEhoohnP9GVRJk3E43Q2WK2h4p0BSOunDY
         dikA==
X-Forwarded-Encrypted: i=1; AJvYcCUz3Sk0f4e03Dz0KRHgo93GTdt2ygZ5YMKnCGUCuvlMauQzJKVj0RyrcAUfvCHKC2vMAAbcKXlIJO+SHkJIGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSOrC9U/BxyJPT4hcDlO7a2X/+mqUjBU16z/HlZUGsV6mpIMyv
	T4M1OTVush8kkEchve75ZaBKX7exKUO5xsZPTSFkyjJyLzfdhuWDlrGC
X-Gm-Gg: ASbGnctu8MZrLJuI5lsuGwLrzOJxxHxSA+ogKzv+5PlxdsoriyxhlWovANhac8zv6Qs
	bbLDSC9s7Ugn/8rrFNqWAh1P2SKSLfSJTW8jprvBPLF8CWH6l/Oe9Feo6+1EFgVYfsc5cQcxXlP
	9LKo+jMdxxmhMw/97rm+CZB8kkuiYSc7mLJzjqLHPW3v+r3brNv8PMoHwlBPwHU50+/zMPpxcWD
	uJPXpIu6ysugBNYiSqTql5jedsFA5A8/TFbgeu2H5R7qB+jO+M2airdofgB5GCdImVvqgGwv25o
	mXJi2Vg2ed6epxEFW+fwfAN/iGWwEbGoK2vlFJfG/x+5OyrxnTcW6aYXrQAP2Tqf+kzcfV0dFfP
	/fl5mGt6sC/X7T2+KetjUZW3T2rXanxgoQvxBfmA2wU/PoLBbpOx5tEBszozXAIYGiTg4SH6eaj
	TWZ+0dDR+n2OcRKhzbiShlnZIg7zvzVJPhEL6FUI1RDA==
X-Google-Smtp-Source: AGHT+IEdFK3uj4zDo8jj5JndAZ1O+CQKv7P2KWNfrRl57B3KL4Tt+cot7sWc0uCylQm2Jq8jZR2R8Q==
X-Received: by 2002:a17:903:1670:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-29b6bea27f7mr24971015ad.18.1763723498277;
        Fri, 21 Nov 2025 03:11:38 -0800 (PST)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29b5b106094sm55137215ad.10.2025.11.21.03.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:11:37 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: gustavo@embeddedor.com
Cc: Jes.Sorensen@gmail.com,
	gustavoars@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	zenmchen@gmail.com
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid -Wflex-array-member-not-at-end warnings
Date: Fri, 21 Nov 2025 19:11:31 +0800
Message-ID: <20251121111132.4435-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
References: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Gustavo A. R. Silva <gustavo@embeddedor.com> 於 2025年11月21日 週五 下午6:20寫道：
>
> Hi,
>
> On 11/21/25 19:06, Zenm Chen wrote:
> > Dear maintainers,
> >
> > With this patch applied, my system always freezes right after the rtl8xxxu
> > driver is loaded. is it normal?
>
> I don't think so... It probably means that struct urb urb; cannot really be
> moved to the end of struct rtl8xxxu_rx_urb or struct rtl8xxxu_tx_urb?
>
> It'd be great if you could share a log.
>

Hi,

Nothing helpful found from the kernel log. Maybe Realtek drivers maintainer
Ping-Ke could take a look what is wrong next Monday.

$ sudo journalctl -k -b -1
Nov 21 18:52:53 BM5220 kernel: Linux version 6.17.8-arch1-1 (linux@archlinux) (gcc (GCC) 15.2.1 20251112, GNU ld (GNU Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Fri, 14 Nov 2025 06:54:20 +0000
Nov 21 18:52:53 BM5220 kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-linux root=UUID=7e5f26b7-dfb4-4127-a8db-b4a8a512c3c0 rw loglevel=3 quiet
Nov 21 18:52:53 BM5220 kernel: BIOS-provided physical RAM map:
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x0000000000100000-0x00000000bd3dffff] usable
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000bd3e0000-0x00000000bd6c3fff] reserved
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000bd6c4000-0x00000000bd6d3fff] ACPI data
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000bd6d4000-0x00000000bda36fff] ACPI NVS
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000bda37000-0x00000000be60cfff] reserved
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000be60d000-0x00000000be60dfff] usable
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000be60e000-0x00000000be813fff] ACPI NVS
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000be814000-0x00000000bec4afff] usable
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000bec4b000-0x00000000beff3fff] reserved
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000beff4000-0x00000000beffffff] usable
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
Nov 21 18:52:53 BM5220 kernel: BIOS-e820: [mem 0x0000000100001000-0x000000022effffff] usable
Nov 21 18:52:53 BM5220 kernel: NX (Execute Disable) protection: active
Nov 21 18:52:53 BM5220 kernel: APIC: Static calls initialized
Nov 21 18:52:53 BM5220 kernel: efi: EFI v32.3.1 by American Megatrends
Nov 21 18:52:53 BM5220 kernel: efi: ACPI=0xbd6cb000 ACPI 2.0=0xbd6cb000 SMBIOS=0xf04c0 INITRD=0xab896e18 
Nov 21 18:52:53 BM5220 kernel: efi: Not removing mem164: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
Nov 21 18:52:53 BM5220 kernel: efi: Not removing mem165: MMIO range=[0xfec10000-0xfec10fff] (4KB) from e820 map
Nov 21 18:52:53 BM5220 kernel: efi: Not removing mem166: MMIO range=[0xfed00000-0xfed00fff] (4KB) from e820 map
Nov 21 18:52:53 BM5220 kernel: efi: Not removing mem167: MMIO range=[0xfed40000-0xfed44fff] (20KB) from e820 map
Nov 21 18:52:53 BM5220 kernel: efi: Not removing mem168: MMIO range=[0xfed80000-0xfed80fff] (4KB) from e820 map
Nov 21 18:52:53 BM5220 kernel: efi: Not removing mem169: MMIO range=[0xfed81000-0xfed8ffff] (60KB) from e820 map
Nov 21 18:52:53 BM5220 kernel: efi: Remove mem170: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
Nov 21 18:52:53 BM5220 kernel: e820: remove [mem 0xff000000-0xffffffff] reserved
Nov 21 18:52:53 BM5220 kernel: SMBIOS 2.7 present.
Nov 21 18:52:53 BM5220 kernel: DMI: System manufacturer System Product Name/F2A85-M, BIOS 6508 07/11/2014
Nov 21 18:52:53 BM5220 kernel: DMI: Memory slots populated: 4/4
Nov 21 18:52:53 BM5220 kernel: tsc: Fast TSC calibration using PIT
Nov 21 18:52:53 BM5220 kernel: tsc: Detected 3818.600 MHz processor
Nov 21 18:52:53 BM5220 kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Nov 21 18:52:53 BM5220 kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Nov 21 18:52:53 BM5220 kernel: last_pfn = 0x22f000 max_arch_pfn = 0x400000000
Nov 21 18:52:53 BM5220 kernel: total RAM covered: 3056M
Nov 21 18:52:53 BM5220 kernel: Found optimal setting for mtrr clean up
Nov 21 18:52:53 BM5220 kernel:  gran_size: 64K         chunk_size: 32M         num_reg: 3          lose cover RAM: 0G
Nov 21 18:52:53 BM5220 kernel: MTRR map: 8 entries (5 fixed + 3 variable; max 22), built from 9 variable MTRRs
Nov 21 18:52:53 BM5220 kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
Nov 21 18:52:53 BM5220 kernel: e820: update [mem 0xbf000000-0xffffffff] usable ==> reserved
Nov 21 18:52:53 BM5220 kernel: last_pfn = 0xbf000 max_arch_pfn = 0x400000000
Nov 21 18:52:53 BM5220 kernel: found SMP MP-table at [mem 0x000fd770-0x000fd77f]
Nov 21 18:52:53 BM5220 kernel: Using GB pages for direct mapping
Nov 21 18:52:53 BM5220 kernel: Secure boot disabled
Nov 21 18:52:53 BM5220 kernel: RAMDISK: [mem 0xa40b4000-0xa7938fff]
Nov 21 18:52:53 BM5220 kernel: ACPI: Early table checksum verification disabled
Nov 21 18:52:53 BM5220 kernel: ACPI: RSDP 0x00000000BD6CB000 000024 (v02 ALASKA)
Nov 21 18:52:53 BM5220 kernel: ACPI: XSDT 0x00000000BD6CB078 000064 (v01 ALASKA A M I    01072009 AMI  00010013)
Nov 21 18:52:53 BM5220 kernel: ACPI: FACP 0x00000000BD6D1E50 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
Nov 21 18:52:53 BM5220 kernel: ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20250404/tbfadt-611)
Nov 21 18:52:53 BM5220 kernel: ACPI: DSDT 0x00000000BD6CB170 006CDB (v02 ALASKA A M I    00000000 INTL 20051117)
Nov 21 18:52:53 BM5220 kernel: ACPI: FACS 0x00000000BDA2C080 000040
Nov 21 18:52:53 BM5220 kernel: ACPI: APIC 0x00000000BD6D1F60 000072 (v03 ALASKA A M I    01072009 AMI  00010013)
Nov 21 18:52:53 BM5220 kernel: ACPI: FPDT 0x00000000BD6D1FD8 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
Nov 21 18:52:53 BM5220 kernel: ACPI: MCFG 0x00000000BD6D2020 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
Nov 21 18:52:53 BM5220 kernel: ACPI: SSDT 0x00000000BD6D2EA0 0004B7 (v02 AMD    ANNAPURN 00000001 MSFT 04000000)
Nov 21 18:52:53 BM5220 kernel: ACPI: HPET 0x00000000BD6D20B8 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
Nov 21 18:52:53 BM5220 kernel: ACPI: IVRS 0x00000000BD6D20F0 000070 (v02 AMD    ANNAPURN 00000001 AMD  00000000)
Nov 21 18:52:53 BM5220 kernel: ACPI: SSDT 0x00000000BD6D2160 000D40 (v01 AMD    ANNAPURN 00000001 AMD  00000001)
Nov 21 18:52:53 BM5220 kernel: ACPI: Reserving FACP table memory at [mem 0xbd6d1e50-0xbd6d1f5b]
Nov 21 18:52:53 BM5220 kernel: ACPI: Reserving DSDT table memory at [mem 0xbd6cb170-0xbd6d1e4a]
Nov 21 18:52:53 BM5220 kernel: ACPI: Reserving FACS table memory at [mem 0xbda2c080-0xbda2c0bf]
Nov 21 18:52:53 BM5220 kernel: ACPI: Reserving APIC table memory at [mem 0xbd6d1f60-0xbd6d1fd1]
Nov 21 18:52:53 BM5220 kernel: ACPI: Reserving FPDT table memory at [mem 0xbd6d1fd8-0xbd6d201b]
Nov 21 18:52:53 BM5220 kernel: ACPI: Reserving MCFG table memory at [mem 0xbd6d2020-0xbd6d205b]
Nov 21 18:52:53 BM5220 kernel: ACPI: Reserving SSDT table memory at [mem 0xbd6d2ea0-0xbd6d3356]
Nov 21 18:52:53 BM5220 kernel: ACPI: Reserving HPET table memory at [mem 0xbd6d20b8-0xbd6d20ef]
Nov 21 18:52:53 BM5220 kernel: ACPI: Reserving IVRS table memory at [mem 0xbd6d20f0-0xbd6d215f]
Nov 21 18:52:53 BM5220 kernel: ACPI: Reserving SSDT table memory at [mem 0xbd6d2160-0xbd6d2e9f]
Nov 21 18:52:53 BM5220 kernel: No NUMA configuration found
Nov 21 18:52:53 BM5220 kernel: Faking a node at [mem 0x0000000000000000-0x000000022effffff]
Nov 21 18:52:53 BM5220 kernel: NODE_DATA(0) allocated [mem 0x22efd32c0-0x22effdfff]
Nov 21 18:52:53 BM5220 kernel: Zone ranges:
Nov 21 18:52:53 BM5220 kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Nov 21 18:52:53 BM5220 kernel:   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Nov 21 18:52:53 BM5220 kernel:   Normal   [mem 0x0000000100000000-0x000000022effffff]
Nov 21 18:52:53 BM5220 kernel:   Device   empty
Nov 21 18:52:53 BM5220 kernel: Movable zone start for each node
Nov 21 18:52:53 BM5220 kernel: Early memory node ranges
Nov 21 18:52:53 BM5220 kernel:   node   0: [mem 0x0000000000001000-0x000000000009ffff]
Nov 21 18:52:53 BM5220 kernel:   node   0: [mem 0x0000000000100000-0x00000000bd3dffff]
Nov 21 18:52:53 BM5220 kernel:   node   0: [mem 0x00000000be60d000-0x00000000be60dfff]
Nov 21 18:52:53 BM5220 kernel:   node   0: [mem 0x00000000be814000-0x00000000bec4afff]
Nov 21 18:52:53 BM5220 kernel:   node   0: [mem 0x00000000beff4000-0x00000000beffffff]
Nov 21 18:52:53 BM5220 kernel:   node   0: [mem 0x0000000100001000-0x000000022effffff]
Nov 21 18:52:53 BM5220 kernel: Initmem setup node 0 [mem 0x0000000000001000-0x000000022effffff]
Nov 21 18:52:53 BM5220 kernel: On node 0, zone DMA: 1 pages in unavailable ranges
Nov 21 18:52:53 BM5220 kernel: On node 0, zone DMA: 96 pages in unavailable ranges
Nov 21 18:52:53 BM5220 kernel: On node 0, zone DMA32: 4653 pages in unavailable ranges
Nov 21 18:52:53 BM5220 kernel: On node 0, zone DMA32: 518 pages in unavailable ranges
Nov 21 18:52:53 BM5220 kernel: On node 0, zone DMA32: 937 pages in unavailable ranges
Nov 21 18:52:53 BM5220 kernel: On node 0, zone Normal: 4097 pages in unavailable ranges
Nov 21 18:52:53 BM5220 kernel: On node 0, zone Normal: 4096 pages in unavailable ranges
Nov 21 18:52:53 BM5220 kernel: ACPI: PM-Timer IO Port: 0x808
Nov 21 18:52:53 BM5220 kernel: ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
Nov 21 18:52:53 BM5220 kernel: IOAPIC[0]: apic_id 5, version 33, address 0xfec00000, GSI 0-23
Nov 21 18:52:53 BM5220 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Nov 21 18:52:53 BM5220 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Nov 21 18:52:53 BM5220 kernel: ACPI: Using ACPI (MADT) for SMP configuration information
Nov 21 18:52:53 BM5220 kernel: ACPI: HPET id: 0x10228210 base: 0xfed00000
Nov 21 18:52:53 BM5220 kernel: CPU topo: Max. logical packages:   1
Nov 21 18:52:53 BM5220 kernel: CPU topo: Max. logical dies:       1
Nov 21 18:52:53 BM5220 kernel: CPU topo: Max. dies per package:   1
Nov 21 18:52:53 BM5220 kernel: CPU topo: Max. threads per core:   1
Nov 21 18:52:53 BM5220 kernel: CPU topo: Num. cores per package:     4
Nov 21 18:52:53 BM5220 kernel: CPU topo: Num. threads per package:   4
Nov 21 18:52:53 BM5220 kernel: CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
Nov 21 18:52:53 BM5220 kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
Nov 21 18:52:53 BM5220 kernel: PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
Nov 21 18:52:53 BM5220 kernel: PM: hibernation: Registered nosave memory: [mem 0xbd3e0000-0xbe60cfff]
Nov 21 18:52:53 BM5220 kernel: PM: hibernation: Registered nosave memory: [mem 0xbe60e000-0xbe813fff]
Nov 21 18:52:53 BM5220 kernel: PM: hibernation: Registered nosave memory: [mem 0xbec4b000-0xbeff3fff]
Nov 21 18:52:53 BM5220 kernel: PM: hibernation: Registered nosave memory: [mem 0xbf000000-0x100000fff]
Nov 21 18:52:53 BM5220 kernel: [mem 0xbf000000-0xfebfffff] available for PCI devices
Nov 21 18:52:53 BM5220 kernel: Booting paravirtualized kernel on bare hardware
Nov 21 18:52:53 BM5220 kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
Nov 21 18:52:53 BM5220 kernel: setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
Nov 21 18:52:53 BM5220 kernel: percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u524288
Nov 21 18:52:53 BM5220 kernel: pcpu-alloc: s217088 r8192 d28672 u524288 alloc=1*2097152
Nov 21 18:52:53 BM5220 kernel: pcpu-alloc: [0] 0 1 2 3 
Nov 21 18:52:53 BM5220 kernel: Kernel command line: BOOT_IMAGE=/boot/vmlinuz-linux root=UUID=7e5f26b7-dfb4-4127-a8db-b4a8a512c3c0 rw loglevel=3 quiet
Nov 21 18:52:53 BM5220 kernel: printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
Nov 21 18:52:53 BM5220 kernel: Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: software IO TLB: area num 4.
Nov 21 18:52:53 BM5220 kernel: Fallback order for Node 0: 0 
Nov 21 18:52:53 BM5220 kernel: Built 1 zonelists, mobility grouping on.  Total pages: 2017218
Nov 21 18:52:53 BM5220 kernel: Policy zone: Normal
Nov 21 18:52:53 BM5220 kernel: mem auto-init: stack:all(zero), heap alloc:on, heap free:off
Nov 21 18:52:53 BM5220 kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Nov 21 18:52:53 BM5220 kernel: ftrace: allocating 56535 entries in 224 pages
Nov 21 18:52:53 BM5220 kernel: ftrace: allocated 224 pages with 3 groups
Nov 21 18:52:53 BM5220 kernel: Dynamic Preempt: full
Nov 21 18:52:53 BM5220 kernel: rcu: Preemptible hierarchical RCU implementation.
Nov 21 18:52:53 BM5220 kernel: rcu:         RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
Nov 21 18:52:53 BM5220 kernel: rcu:         RCU priority boosting: priority 1 delay 500 ms.
Nov 21 18:52:53 BM5220 kernel:         Trampoline variant of Tasks RCU enabled.
Nov 21 18:52:53 BM5220 kernel:         Rude variant of Tasks RCU enabled.
Nov 21 18:52:53 BM5220 kernel:         Tracing variant of Tasks RCU enabled.
Nov 21 18:52:53 BM5220 kernel: rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
Nov 21 18:52:53 BM5220 kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
Nov 21 18:52:53 BM5220 kernel: RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
Nov 21 18:52:53 BM5220 kernel: RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
Nov 21 18:52:53 BM5220 kernel: RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
Nov 21 18:52:53 BM5220 kernel: NR_IRQS: 524544, nr_irqs: 456, preallocated irqs: 16
Nov 21 18:52:53 BM5220 kernel: rcu: srcu_init: Setting srcu_struct sizes based on contention.
Nov 21 18:52:53 BM5220 kernel: kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
Nov 21 18:52:53 BM5220 kernel: Console: colour dummy device 80x25
Nov 21 18:52:53 BM5220 kernel: printk: legacy console [tty0] enabled
Nov 21 18:52:53 BM5220 kernel: ACPI: Core revision 20250404
Nov 21 18:52:53 BM5220 kernel: clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
Nov 21 18:52:53 BM5220 kernel: APIC: Switch to symmetric I/O mode setup
Nov 21 18:52:53 BM5220 kernel: AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
Nov 21 18:52:53 BM5220 kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Nov 21 18:52:53 BM5220 kernel: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6e15f517ead, max_idle_ns: 881590696735 ns
Nov 21 18:52:53 BM5220 kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 7637.20 BogoMIPS (lpj=3818600)
Nov 21 18:52:53 BM5220 kernel: Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
Nov 21 18:52:53 BM5220 kernel: Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
Nov 21 18:52:53 BM5220 kernel: mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
Nov 21 18:52:53 BM5220 kernel: Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
Nov 21 18:52:53 BM5220 kernel: Spectre V2 : Mitigation: Retpolines
Nov 21 18:52:53 BM5220 kernel: RETBleed: Mitigation: untrained return thunk
Nov 21 18:52:53 BM5220 kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Nov 21 18:52:53 BM5220 kernel: Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT
Nov 21 18:52:53 BM5220 kernel: active return thunk: retbleed_return_thunk
Nov 21 18:52:53 BM5220 kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
Nov 21 18:52:53 BM5220 kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
Nov 21 18:52:53 BM5220 kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
Nov 21 18:52:53 BM5220 kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
Nov 21 18:52:53 BM5220 kernel: x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
Nov 21 18:52:53 BM5220 kernel: Freeing SMP alternatives memory: 56K
Nov 21 18:52:53 BM5220 kernel: pid_max: default: 32768 minimum: 301
Nov 21 18:52:53 BM5220 kernel: LSM: initializing lsm=capability,landlock,lockdown,yama,bpf
Nov 21 18:52:53 BM5220 kernel: landlock: Up and running.
Nov 21 18:52:53 BM5220 kernel: Yama: becoming mindful.
Nov 21 18:52:53 BM5220 kernel: LSM support for eBPF active
Nov 21 18:52:53 BM5220 kernel: Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: smpboot: CPU0: AMD A10-5800K APU with Radeon(tm) HD Graphics (family: 0x15, model: 0x10, stepping: 0x1)
Nov 21 18:52:53 BM5220 kernel: Performance Events: Fam15h core perfctr, AMD PMU driver.
Nov 21 18:52:53 BM5220 kernel: ... version:                0
Nov 21 18:52:53 BM5220 kernel: ... bit width:              48
Nov 21 18:52:53 BM5220 kernel: ... generic registers:      6
Nov 21 18:52:53 BM5220 kernel: ... value mask:             0000ffffffffffff
Nov 21 18:52:53 BM5220 kernel: ... max period:             00007fffffffffff
Nov 21 18:52:53 BM5220 kernel: ... fixed-purpose events:   0
Nov 21 18:52:53 BM5220 kernel: ... event mask:             000000000000003f
Nov 21 18:52:53 BM5220 kernel: signal: max sigframe size: 1776
Nov 21 18:52:53 BM5220 kernel: rcu: Hierarchical SRCU implementation.
Nov 21 18:52:53 BM5220 kernel: rcu:         Max phase no-delay instances is 400.
Nov 21 18:52:53 BM5220 kernel: Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
Nov 21 18:52:53 BM5220 kernel: MCE: In-kernel MCE decoding enabled.
Nov 21 18:52:53 BM5220 kernel: NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
Nov 21 18:52:53 BM5220 kernel: smp: Bringing up secondary CPUs ...
Nov 21 18:52:53 BM5220 kernel: smpboot: x86: Booting SMP configuration:
Nov 21 18:52:53 BM5220 kernel: .... node  #0, CPUs:      #1 #2 #3
Nov 21 18:52:53 BM5220 kernel: smp: Brought up 1 node, 4 CPUs
Nov 21 18:52:53 BM5220 kernel: smpboot: Total of 4 processors activated (30548.80 BogoMIPS)
Nov 21 18:52:53 BM5220 kernel: Memory: 7732920K/8068872K available (20065K kernel code, 2946K rwdata, 16204K rodata, 4688K init, 4880K bss, 323056K reserved, 0K cma-reserved)
Nov 21 18:52:53 BM5220 kernel: devtmpfs: initialized
Nov 21 18:52:53 BM5220 kernel: x86/mm: Memory block size: 128MB
Nov 21 18:52:53 BM5220 kernel: ACPI: PM: Registering ACPI NVS region [mem 0xbd6d4000-0xbda36fff] (3551232 bytes)
Nov 21 18:52:53 BM5220 kernel: ACPI: PM: Registering ACPI NVS region [mem 0xbe60e000-0xbe813fff] (2121728 bytes)
Nov 21 18:52:53 BM5220 kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
Nov 21 18:52:53 BM5220 kernel: posixtimers hash table entries: 2048 (order: 3, 32768 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: futex hash table entries: 1024 (65536 bytes on 1 NUMA nodes, total 64 KiB, linear).
Nov 21 18:52:53 BM5220 kernel: pinctrl core: initialized pinctrl subsystem
Nov 21 18:52:53 BM5220 kernel: PM: RTC time: 10:52:48, date: 2025-11-21
Nov 21 18:52:53 BM5220 kernel: NET: Registered PF_NETLINK/PF_ROUTE protocol family
Nov 21 18:52:53 BM5220 kernel: DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
Nov 21 18:52:53 BM5220 kernel: DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
Nov 21 18:52:53 BM5220 kernel: DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
Nov 21 18:52:53 BM5220 kernel: audit: initializing netlink subsys (disabled)
Nov 21 18:52:53 BM5220 kernel: audit: type=2000 audit(1763722368.163:1): state=initialized audit_enabled=0 res=1
Nov 21 18:52:53 BM5220 kernel: thermal_sys: Registered thermal governor 'fair_share'
Nov 21 18:52:53 BM5220 kernel: thermal_sys: Registered thermal governor 'bang_bang'
Nov 21 18:52:53 BM5220 kernel: thermal_sys: Registered thermal governor 'step_wise'
Nov 21 18:52:53 BM5220 kernel: thermal_sys: Registered thermal governor 'user_space'
Nov 21 18:52:53 BM5220 kernel: thermal_sys: Registered thermal governor 'power_allocator'
Nov 21 18:52:53 BM5220 kernel: cpuidle: using governor ladder
Nov 21 18:52:53 BM5220 kernel: cpuidle: using governor menu
Nov 21 18:52:53 BM5220 kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Nov 21 18:52:53 BM5220 kernel: PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
Nov 21 18:52:53 BM5220 kernel: PCI: not using ECAM ([mem 0xe0000000-0xefffffff] not reserved)
Nov 21 18:52:53 BM5220 kernel: PCI: Using configuration type 1 for base access
Nov 21 18:52:53 BM5220 kernel: PCI: Using configuration type 1 for extended access
Nov 21 18:52:53 BM5220 kernel: kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
Nov 21 18:52:53 BM5220 kernel: HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
Nov 21 18:52:53 BM5220 kernel: HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
Nov 21 18:52:53 BM5220 kernel: HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
Nov 21 18:52:53 BM5220 kernel: HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
Nov 21 18:52:53 BM5220 kernel: raid6: skipped pq benchmark and selected sse2x4
Nov 21 18:52:53 BM5220 kernel: raid6: using ssse3x2 recovery algorithm
Nov 21 18:52:53 BM5220 kernel: ACPI: Added _OSI(Module Device)
Nov 21 18:52:53 BM5220 kernel: ACPI: Added _OSI(Processor Device)
Nov 21 18:52:53 BM5220 kernel: ACPI: Added _OSI(Processor Aggregator Device)
Nov 21 18:52:53 BM5220 kernel: ACPI: 3 ACPI AML tables successfully acquired and loaded
Nov 21 18:52:53 BM5220 kernel: ACPI: Interpreter enabled
Nov 21 18:52:53 BM5220 kernel: ACPI: PM: (supports S0 S3 S4 S5)
Nov 21 18:52:53 BM5220 kernel: ACPI: Using IOAPIC for interrupt routing
Nov 21 18:52:53 BM5220 kernel: PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
Nov 21 18:52:53 BM5220 kernel: PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as ACPI motherboard resource
Nov 21 18:52:53 BM5220 kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Nov 21 18:52:53 BM5220 kernel: PCI: Using E820 reservations for host bridge windows
Nov 21 18:52:53 BM5220 kernel: ACPI: Enabled 8 GPEs in block 00 to 1F
Nov 21 18:52:53 BM5220 kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Nov 21 18:52:53 BM5220 kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
Nov 21 18:52:53 BM5220 kernel: acpi PNP0A03:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME LTR DPC]
Nov 21 18:52:53 BM5220 kernel: acpi PNP0A03:00: _OSC: OS now controls [AER PCIeCapability]
Nov 21 18:52:53 BM5220 kernel: PCI host bridge to bus 0000:00
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: root bus resource [mem 0xd0000000-0xffffffff window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:00.0: [1022:1410] type 00 class 0x060000 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:00.2: [1022:1419] type 00 class 0x080600 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.0: [1002:9901] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.0: BAR 0 [mem 0xd0000000-0xdfffffff pref]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.0: BAR 1 [io  0xf000-0xf0ff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.0: BAR 2 [mem 0xfeb00000-0xfeb3ffff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.0: enabling Extended Tags
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.0: supports D1 D2
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.1: [1002:9902] type 00 class 0x040300 PCIe Root Complex Integrated Endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.1: BAR 0 [mem 0xfeb40000-0xfeb43fff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.1: enabling Extended Tags
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.1: supports D1 D2
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:10.0: [1022:7812] type 00 class 0x0c0330 PCIe Root Complex Integrated Endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:10.0: BAR 0 [mem 0xfeb46000-0xfeb47fff 64bit]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:10.1: [1022:7812] type 00 class 0x0c0330 PCIe Root Complex Integrated Endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:10.1: BAR 0 [mem 0xfeb44000-0xfeb45fff 64bit]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:10.1: PME# supported from D0 D3hot D3cold
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:11.0: [1022:7801] type 00 class 0x010601 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:11.0: BAR 0 [io  0xf140-0xf147]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:11.0: BAR 1 [io  0xf130-0xf133]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:11.0: BAR 2 [io  0xf120-0xf127]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:11.0: BAR 3 [io  0xf110-0xf113]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:11.0: BAR 4 [io  0xf100-0xf10f]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:11.0: BAR 5 [mem 0xfeb4c000-0xfeb4c7ff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:12.0: [1022:7807] type 00 class 0x0c0310 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:12.0: BAR 0 [mem 0xfeb4b000-0xfeb4bfff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:12.2: [1022:7808] type 00 class 0x0c0320 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:12.2: BAR 0 [mem 0xfeb4a000-0xfeb4a0ff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:12.2: supports D1 D2
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:13.0: [1022:7807] type 00 class 0x0c0310 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:13.0: BAR 0 [mem 0xfeb49000-0xfeb49fff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:13.2: [1022:7808] type 00 class 0x0c0320 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:13.2: BAR 0 [mem 0xfeb48000-0xfeb480ff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:13.2: supports D1 D2
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.0: [1022:780b] type 00 class 0x0c0500 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.3: [1022:780e] type 00 class 0x060100 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.4: [1022:780f] type 01 class 0x060401 conventional PCI bridge
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.4: PCI bridge to [bus 01] (subtractive decode)
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:15.0: [1022:43a0] type 01 class 0x060400 PCIe Root Port
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:15.0: PCI bridge to [bus 02]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:15.0:   bridge window [io  0xe000-0xefff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:15.0:   bridge window [mem 0xfea00000-0xfeafffff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:15.0: enabling Extended Tags
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:15.0: supports D1 D2
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:18.0: [1022:1400] type 00 class 0x060000 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:18.1: [1022:1401] type 00 class 0x060000 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:18.2: [1022:1402] type 00 class 0x060000 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:18.3: [1022:1403] type 00 class 0x060000 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:18.4: [1022:1404] type 00 class 0x060000 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:18.5: [1022:1405] type 00 class 0x060000 conventional PCI endpoint
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:01: extended config space not accessible
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.4: PCI bridge to [bus 01] (subtractive decode)
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000dffff window] (subtractive decode)
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xffffffff window] (subtractive decode)
Nov 21 18:52:53 BM5220 kernel: pci 0000:02:00.0: [10ec:c852] type 00 class 0x028000 PCIe Endpoint
Nov 21 18:52:53 BM5220 kernel: pci 0000:02:00.0: BAR 0 [io  0xe000-0xe0ff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:02:00.0: BAR 2 [mem 0xfea00000-0xfeafffff 64bit]
Nov 21 18:52:53 BM5220 kernel: pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:15.0: PCI bridge to [bus 02]
Nov 21 18:52:53 BM5220 kernel: ACPI: PCI: Interrupt link LNKA configured for IRQ 0
Nov 21 18:52:53 BM5220 kernel: ACPI: PCI: Interrupt link LNKB configured for IRQ 0
Nov 21 18:52:53 BM5220 kernel: ACPI: PCI: Interrupt link LNKC configured for IRQ 0
Nov 21 18:52:53 BM5220 kernel: ACPI: PCI: Interrupt link LNKD configured for IRQ 0
Nov 21 18:52:53 BM5220 kernel: ACPI: PCI: Interrupt link LNKE configured for IRQ 0
Nov 21 18:52:53 BM5220 kernel: ACPI: PCI: Interrupt link LNKF configured for IRQ 0
Nov 21 18:52:53 BM5220 kernel: ACPI: PCI: Interrupt link LNKG configured for IRQ 0
Nov 21 18:52:53 BM5220 kernel: ACPI: PCI: Interrupt link LNKH configured for IRQ 0
Nov 21 18:52:53 BM5220 kernel: iommu: Default domain type: Translated
Nov 21 18:52:53 BM5220 kernel: iommu: DMA domain TLB invalidation policy: lazy mode
Nov 21 18:52:53 BM5220 kernel: SCSI subsystem initialized
Nov 21 18:52:53 BM5220 kernel: libata version 3.00 loaded.
Nov 21 18:52:53 BM5220 kernel: ACPI: bus type USB registered
Nov 21 18:52:53 BM5220 kernel: usbcore: registered new interface driver usbfs
Nov 21 18:52:53 BM5220 kernel: usbcore: registered new interface driver hub
Nov 21 18:52:53 BM5220 kernel: usbcore: registered new device driver usb
Nov 21 18:52:53 BM5220 kernel: EDAC MC: Ver: 3.0.0
Nov 21 18:52:53 BM5220 kernel: efivars: Registered efivars operations
Nov 21 18:52:53 BM5220 kernel: NetLabel: Initializing
Nov 21 18:52:53 BM5220 kernel: NetLabel:  domain hash size = 128
Nov 21 18:52:53 BM5220 kernel: NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
Nov 21 18:52:53 BM5220 kernel: NetLabel:  unlabeled traffic allowed by default
Nov 21 18:52:53 BM5220 kernel: mctp: management component transport protocol core
Nov 21 18:52:53 BM5220 kernel: NET: Registered PF_MCTP protocol family
Nov 21 18:52:53 BM5220 kernel: PCI: Using ACPI for IRQ routing
Nov 21 18:52:53 BM5220 kernel: PCI: pci_cache_line_size set to 64 bytes
Nov 21 18:52:53 BM5220 kernel: e820: reserve RAM buffer [mem 0xbd3e0000-0xbfffffff]
Nov 21 18:52:53 BM5220 kernel: e820: reserve RAM buffer [mem 0xbe60e000-0xbfffffff]
Nov 21 18:52:53 BM5220 kernel: e820: reserve RAM buffer [mem 0xbec4b000-0xbfffffff]
Nov 21 18:52:53 BM5220 kernel: e820: reserve RAM buffer [mem 0xbf000000-0xbfffffff]
Nov 21 18:52:53 BM5220 kernel: e820: reserve RAM buffer [mem 0x22f000000-0x22fffffff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.0: vgaarb: setting as boot VGA device
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.0: vgaarb: bridge control possible
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
Nov 21 18:52:53 BM5220 kernel: vgaarb: loaded
Nov 21 18:52:53 BM5220 kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
Nov 21 18:52:53 BM5220 kernel: hpet0: 3 comparators, 32-bit 14.318180 MHz counter
Nov 21 18:52:53 BM5220 kernel: clocksource: Switched to clocksource tsc-early
Nov 21 18:52:53 BM5220 kernel: VFS: Disk quotas dquot_6.6.0
Nov 21 18:52:53 BM5220 kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Nov 21 18:52:53 BM5220 kernel: pnp: PnP ACPI init
Nov 21 18:52:53 BM5220 kernel: system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:01: [mem 0xc0000000-0xcfffffff] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:02: [mem 0xfeb80000-0xfebfffff] could not be reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x04d0-0x04d1] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x040b] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x04d6] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0c00-0x0c01] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0c14] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0c50-0x0c51] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0c52] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0c6c] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0c6f] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0cd0-0x0cd1] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0cd2-0x0cd3] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0cd4-0x0cd5] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0cd6-0x0cd7] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0cd8-0x0cdf] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0800-0x089f] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0b20-0x0b3f] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0900-0x090f] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0x0910-0x091f] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [io  0xfe00-0xfefe] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [mem 0xfec00000-0xfec00fff] could not be reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [mem 0xfee00000-0xfee00fff] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [mem 0xfed80000-0xfed8ffff] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [mem 0xfed61000-0xfed70fff] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [mem 0xfec10000-0xfec10fff] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [mem 0xfed00000-0xfed00fff] could not be reserved
Nov 21 18:52:53 BM5220 kernel: system 00:03: [mem 0xff000000-0xffffffff] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:04: [io  0x0300-0x031f] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:04: [io  0x0290-0x029f] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:04: [io  0x0230-0x023f] has been reserved
Nov 21 18:52:53 BM5220 kernel: system 00:06: [io  0x04d0-0x04d1] has been reserved
Nov 21 18:52:53 BM5220 kernel: pnp: PnP ACPI: found 8 devices
Nov 21 18:52:53 BM5220 kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Nov 21 18:52:53 BM5220 kernel: NET: Registered PF_INET protocol family
Nov 21 18:52:53 BM5220 kernel: IP idents hash table entries: 131072 (order: 8, 1048576 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: TCP: Hash tables configured (established 65536 bind 65536)
Nov 21 18:52:53 BM5220 kernel: MPTCP token hash table entries: 8192 (order: 5, 196608 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: UDP hash table entries: 4096 (order: 6, 262144 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: UDP-Lite hash table entries: 4096 (order: 6, 262144 bytes, linear)
Nov 21 18:52:53 BM5220 kernel: NET: Registered PF_UNIX/PF_LOCAL protocol family
Nov 21 18:52:53 BM5220 kernel: NET: Registered PF_XDP protocol family
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.4: PCI bridge to [bus 01]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:15.0: PCI bridge to [bus 02]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:15.0:   bridge window [io  0xe000-0xefff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:15.0:   bridge window [mem 0xfea00000-0xfeafffff]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:00: resource 9 [mem 0xd0000000-0xffffffff window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:01: resource 4 [io  0x0000-0x03af window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:01: resource 5 [io  0x03e0-0x0cf7 window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:01: resource 6 [io  0x03b0-0x03df window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:01: resource 7 [io  0x0d00-0xffff window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:01: resource 8 [mem 0x000a0000-0x000dffff window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:01: resource 9 [mem 0xd0000000-0xffffffff window]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
Nov 21 18:52:53 BM5220 kernel: pci_bus 0000:02: resource 1 [mem 0xfea00000-0xfeafffff]
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.1: D0 power state depends on 0000:00:01.0
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x760 took 23223 usecs
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:12.2: PME# does not work under D3, disabling it
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x760 took 21333 usecs
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:13.2: PME# does not work under D3, disabling it
Nov 21 18:52:53 BM5220 kernel: PCI: CLS 64 bytes, default 64
Nov 21 18:52:53 BM5220 kernel: Trying to unpack rootfs image as initramfs...
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.0: Adding to iommu group 0
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:01.1: Adding to iommu group 0
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:10.0: Adding to iommu group 1
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:10.1: Adding to iommu group 1
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:11.0: Adding to iommu group 2
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:12.0: Adding to iommu group 3
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:12.2: Adding to iommu group 3
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:13.0: Adding to iommu group 4
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:13.2: Adding to iommu group 4
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.0: Adding to iommu group 5
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.3: Adding to iommu group 5
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:14.4: Adding to iommu group 6
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:15.0: Adding to iommu group 7
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:18.0: Adding to iommu group 8
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:18.1: Adding to iommu group 8
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:18.2: Adding to iommu group 8
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:18.3: Adding to iommu group 8
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:18.4: Adding to iommu group 8
Nov 21 18:52:53 BM5220 kernel: pci 0000:00:18.5: Adding to iommu group 8
Nov 21 18:52:53 BM5220 kernel: pci 0000:02:00.0: Adding to iommu group 7
Nov 21 18:52:53 BM5220 kernel: AMD-Vi: Extended features (0x800000853, 0x0): PreF PPR GT IA
Nov 21 18:52:53 BM5220 kernel: AMD-Vi: Interrupt remapping enabled
Nov 21 18:52:53 BM5220 kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Nov 21 18:52:53 BM5220 kernel: software IO TLB: mapped [mem 0x00000000ac32c000-0x00000000b032c000] (64MB)
Nov 21 18:52:53 BM5220 kernel: LVT offset 0 assigned for vector 0x400
Nov 21 18:52:53 BM5220 kernel: perf: AMD IBS detected (0x000000ff)
Nov 21 18:52:53 BM5220 kernel: Initialise system trusted keyrings
Nov 21 18:52:53 BM5220 kernel: Key type blacklist registered
Nov 21 18:52:53 BM5220 kernel: workingset: timestamp_bits=36 max_order=21 bucket_order=0
Nov 21 18:52:53 BM5220 kernel: fuse: init (API version 7.44)
Nov 21 18:52:53 BM5220 kernel: integrity: Platform Keyring initialized
Nov 21 18:52:53 BM5220 kernel: integrity: Machine keyring initialized
Nov 21 18:52:53 BM5220 kernel: xor: automatically using best checksumming function   avx       
Nov 21 18:52:53 BM5220 kernel: Key type asymmetric registered
Nov 21 18:52:53 BM5220 kernel: Asymmetric key parser 'x509' registered
Nov 21 18:52:53 BM5220 kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
Nov 21 18:52:53 BM5220 kernel: io scheduler mq-deadline registered
Nov 21 18:52:53 BM5220 kernel: io scheduler kyber registered
Nov 21 18:52:53 BM5220 kernel: io scheduler bfq registered
Nov 21 18:52:53 BM5220 kernel: ledtrig-cpu: registered to indicate activity on CPUs
Nov 21 18:52:53 BM5220 kernel: input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
Nov 21 18:52:53 BM5220 kernel: ACPI: button: Power Button [PWRB]
Nov 21 18:52:53 BM5220 kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
Nov 21 18:52:53 BM5220 kernel: ACPI: button: Power Button [PWRF]
Nov 21 18:52:53 BM5220 kernel: Could not retrieve perf counters (-19)
Nov 21 18:52:53 BM5220 kernel: Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
Nov 21 18:52:53 BM5220 kernel: Non-volatile memory driver v1.3
Nov 21 18:52:53 BM5220 kernel: Linux agpgart interface v0.103
Nov 21 18:52:53 BM5220 kernel: ACPI: bus type drm_connector registered
Nov 21 18:52:53 BM5220 kernel: ahci 0000:00:11.0: AHCI vers 0001.0300, 32 command slots, 6 Gbps, SATA mode
Nov 21 18:52:53 BM5220 kernel: ahci 0000:00:11.0: 8/8 ports implemented (port mask 0xff)
Nov 21 18:52:53 BM5220 kernel: ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio sxs 
Nov 21 18:52:53 BM5220 kernel: scsi host0: ahci
Nov 21 18:52:53 BM5220 kernel: scsi host1: ahci
Nov 21 18:52:53 BM5220 kernel: scsi host2: ahci
Nov 21 18:52:53 BM5220 kernel: scsi host3: ahci
Nov 21 18:52:53 BM5220 kernel: scsi host4: ahci
Nov 21 18:52:53 BM5220 kernel: scsi host5: ahci
Nov 21 18:52:53 BM5220 kernel: scsi host6: ahci
Nov 21 18:52:53 BM5220 kernel: scsi host7: ahci
Nov 21 18:52:53 BM5220 kernel: ata1: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c100 irq 26 lpm-pol 1
Nov 21 18:52:53 BM5220 kernel: ata2: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c180 irq 27 lpm-pol 1
Nov 21 18:52:53 BM5220 kernel: ata3: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c200 irq 28 lpm-pol 1
Nov 21 18:52:53 BM5220 kernel: ata4: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c280 irq 29 lpm-pol 1
Nov 21 18:52:53 BM5220 kernel: ata5: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c300 irq 30 lpm-pol 1
Nov 21 18:52:53 BM5220 kernel: ata6: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c380 irq 31 lpm-pol 1
Nov 21 18:52:53 BM5220 kernel: ata7: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c400 irq 32 lpm-pol 1
Nov 21 18:52:53 BM5220 kernel: ata8: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c480 irq 33 lpm-pol 1 ext
Nov 21 18:52:53 BM5220 kernel: QUIRK: Enable AMD PLL fix
Nov 21 18:52:53 BM5220 kernel: ohci-pci 0000:00:12.0: OHCI PCI host controller
Nov 21 18:52:53 BM5220 kernel: ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 1
Nov 21 18:52:53 BM5220 kernel: ohci-pci 0000:00:12.0: irq 18, io mem 0xfeb4b000
Nov 21 18:52:53 BM5220 kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.17
Nov 21 18:52:53 BM5220 kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Nov 21 18:52:53 BM5220 kernel: usb usb1: Product: OHCI PCI host controller
Nov 21 18:52:53 BM5220 kernel: usb usb1: Manufacturer: Linux 6.17.8-arch1-1 ohci_hcd
Nov 21 18:52:53 BM5220 kernel: usb usb1: SerialNumber: 0000:00:12.0
Nov 21 18:52:53 BM5220 kernel: hub 1-0:1.0: USB hub found
Nov 21 18:52:53 BM5220 kernel: hub 1-0:1.0: 5 ports detected
Nov 21 18:52:53 BM5220 kernel: ehci-pci 0000:00:13.2: EHCI Host Controller
Nov 21 18:52:53 BM5220 kernel: ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
Nov 21 18:52:53 BM5220 kernel: ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
Nov 21 18:52:53 BM5220 kernel: ehci-pci 0000:00:13.2: debug port 1
Nov 21 18:52:53 BM5220 kernel: ehci-pci 0000:00:13.2: irq 17, io mem 0xfeb48000
Nov 21 18:52:53 BM5220 kernel: ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
Nov 21 18:52:53 BM5220 kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
Nov 21 18:52:53 BM5220 kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Nov 21 18:52:53 BM5220 kernel: usb usb2: Product: EHCI Host Controller
Nov 21 18:52:53 BM5220 kernel: usb usb2: Manufacturer: Linux 6.17.8-arch1-1 ehci_hcd
Nov 21 18:52:53 BM5220 kernel: usb usb2: SerialNumber: 0000:00:13.2
Nov 21 18:52:53 BM5220 kernel: hub 2-0:1.0: USB hub found
Nov 21 18:52:53 BM5220 kernel: hub 2-0:1.0: 5 ports detected
Nov 21 18:52:53 BM5220 kernel: ehci-pci 0000:00:12.2: EHCI Host Controller
Nov 21 18:52:53 BM5220 kernel: ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 3
Nov 21 18:52:53 BM5220 kernel: ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
Nov 21 18:52:53 BM5220 kernel: ehci-pci 0000:00:12.2: debug port 1
Nov 21 18:52:53 BM5220 kernel: ehci-pci 0000:00:12.2: irq 17, io mem 0xfeb4a000
Nov 21 18:52:53 BM5220 kernel: ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
Nov 21 18:52:53 BM5220 kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
Nov 21 18:52:53 BM5220 kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Nov 21 18:52:53 BM5220 kernel: usb usb3: Product: EHCI Host Controller
Nov 21 18:52:53 BM5220 kernel: usb usb3: Manufacturer: Linux 6.17.8-arch1-1 ehci_hcd
Nov 21 18:52:53 BM5220 kernel: usb usb3: SerialNumber: 0000:00:12.2
Nov 21 18:52:53 BM5220 kernel: hub 3-0:1.0: USB hub found
Nov 21 18:52:53 BM5220 kernel: hub 3-0:1.0: 5 ports detected
Nov 21 18:52:53 BM5220 kernel: ata8: SATA link down (SStatus 0 SControl 300)
Nov 21 18:52:53 BM5220 kernel: ata4: SATA link down (SStatus 0 SControl 300)
Nov 21 18:52:53 BM5220 kernel: ata2: SATA link down (SStatus 0 SControl 300)
Nov 21 18:52:53 BM5220 kernel: ata7: SATA link down (SStatus 0 SControl 300)
Nov 21 18:52:53 BM5220 kernel: ata6: SATA link down (SStatus 0 SControl 300)
Nov 21 18:52:53 BM5220 kernel: ata3: SATA link down (SStatus 0 SControl 300)
Nov 21 18:52:53 BM5220 kernel: ata5: SATA link down (SStatus 0 SControl 300)
Nov 21 18:52:53 BM5220 kernel: hub 1-0:1.0: USB hub found
Nov 21 18:52:53 BM5220 kernel: hub 1-0:1.0: 5 ports detected
Nov 21 18:52:53 BM5220 kernel: ohci-pci 0000:00:13.0: OHCI PCI host controller
Nov 21 18:52:53 BM5220 kernel: ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 4
Nov 21 18:52:53 BM5220 kernel: ohci-pci 0000:00:13.0: irq 18, io mem 0xfeb49000
Nov 21 18:52:53 BM5220 kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.17
Nov 21 18:52:53 BM5220 kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Nov 21 18:52:53 BM5220 kernel: usb usb4: Product: OHCI PCI host controller
Nov 21 18:52:53 BM5220 kernel: usb usb4: Manufacturer: Linux 6.17.8-arch1-1 ohci_hcd
Nov 21 18:52:53 BM5220 kernel: usb usb4: SerialNumber: 0000:00:13.0
Nov 21 18:52:53 BM5220 kernel: hub 4-0:1.0: USB hub found
Nov 21 18:52:53 BM5220 kernel: hub 4-0:1.0: 5 ports detected
Nov 21 18:52:53 BM5220 kernel: xhci_hcd 0000:00:10.0: xHCI Host Controller
Nov 21 18:52:53 BM5220 kernel: xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 5
Nov 21 18:52:53 BM5220 kernel: xhci_hcd 0000:00:10.0: hcc params 0x014042c3 hci version 0x96 quirks 0x0000000000000208
Nov 21 18:52:53 BM5220 kernel: xhci_hcd 0000:00:10.0: xHCI Host Controller
Nov 21 18:52:53 BM5220 kernel: xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 6
Nov 21 18:52:53 BM5220 kernel: xhci_hcd 0000:00:10.0: Host supports USB 3.0 SuperSpeed
Nov 21 18:52:53 BM5220 kernel: usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
Nov 21 18:52:53 BM5220 kernel: usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Nov 21 18:52:53 BM5220 kernel: usb usb5: Product: xHCI Host Controller
Nov 21 18:52:53 BM5220 kernel: usb usb5: Manufacturer: Linux 6.17.8-arch1-1 xhci-hcd
Nov 21 18:52:53 BM5220 kernel: usb usb5: SerialNumber: 0000:00:10.0
Nov 21 18:52:53 BM5220 kernel: hub 5-0:1.0: USB hub found
Nov 21 18:52:53 BM5220 kernel: hub 5-0:1.0: 2 ports detected
Nov 21 18:52:53 BM5220 kernel: usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
Nov 21 18:52:53 BM5220 kernel: usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
Nov 21 18:52:53 BM5220 kernel: usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Nov 21 18:52:53 BM5220 kernel: usb usb6: Product: xHCI Host Controller
Nov 21 18:52:53 BM5220 kernel: usb usb6: Manufacturer: Linux 6.17.8-arch1-1 xhci-hcd
Nov 21 18:52:53 BM5220 kernel: usb usb6: SerialNumber: 0000:00:10.0
Nov 21 18:52:53 BM5220 kernel: hub 6-0:1.0: USB hub found
Nov 21 18:52:53 BM5220 kernel: hub 6-0:1.0: 2 ports detected
Nov 21 18:52:53 BM5220 kernel: xhci_hcd 0000:00:10.1: xHCI Host Controller
Nov 21 18:52:53 BM5220 kernel: xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 7
Nov 21 18:52:53 BM5220 kernel: xhci_hcd 0000:00:10.1: hcc params 0x014042c3 hci version 0x96 quirks 0x0000000000000208
Nov 21 18:52:53 BM5220 kernel: xhci_hcd 0000:00:10.1: xHCI Host Controller
Nov 21 18:52:53 BM5220 kernel: xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 8
Nov 21 18:52:53 BM5220 kernel: xhci_hcd 0000:00:10.1: Host supports USB 3.0 SuperSpeed
Nov 21 18:52:53 BM5220 kernel: usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
Nov 21 18:52:53 BM5220 kernel: usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Nov 21 18:52:53 BM5220 kernel: usb usb7: Product: xHCI Host Controller
Nov 21 18:52:53 BM5220 kernel: usb usb7: Manufacturer: Linux 6.17.8-arch1-1 xhci-hcd
Nov 21 18:52:53 BM5220 kernel: usb usb7: SerialNumber: 0000:00:10.1
Nov 21 18:52:53 BM5220 kernel: hub 7-0:1.0: USB hub found
Nov 21 18:52:53 BM5220 kernel: hub 7-0:1.0: 2 ports detected
Nov 21 18:52:53 BM5220 kernel: usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
Nov 21 18:52:53 BM5220 kernel: usb usb8: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
Nov 21 18:52:53 BM5220 kernel: usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Nov 21 18:52:53 BM5220 kernel: usb usb8: Product: xHCI Host Controller
Nov 21 18:52:53 BM5220 kernel: usb usb8: Manufacturer: Linux 6.17.8-arch1-1 xhci-hcd
Nov 21 18:52:53 BM5220 kernel: usb usb8: SerialNumber: 0000:00:10.1
Nov 21 18:52:53 BM5220 kernel: hub 8-0:1.0: USB hub found
Nov 21 18:52:53 BM5220 kernel: hub 8-0:1.0: 2 ports detected
Nov 21 18:52:53 BM5220 kernel: usbcore: registered new interface driver usbserial_generic
Nov 21 18:52:53 BM5220 kernel: usbserial: USB Serial support registered for generic
Nov 21 18:52:53 BM5220 kernel: i8042: PNP: No PS/2 controller found.
Nov 21 18:52:53 BM5220 kernel: rtc_cmos 00:05: RTC can wake from S4
Nov 21 18:52:53 BM5220 kernel: rtc_cmos 00:05: registered as rtc0
Nov 21 18:52:53 BM5220 kernel: rtc_cmos 00:05: setting system clock to 2025-11-21T10:52:49 UTC (1763722369)
Nov 21 18:52:53 BM5220 kernel: rtc_cmos 00:05: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
Nov 21 18:52:53 BM5220 kernel: amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
Nov 21 18:52:53 BM5220 kernel: simple-framebuffer simple-framebuffer.0: [drm] Registered 1 planes with drm panic
Nov 21 18:52:53 BM5220 kernel: [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
Nov 21 18:52:53 BM5220 kernel: fbcon: Deferring console take-over
Nov 21 18:52:53 BM5220 kernel: simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
Nov 21 18:52:53 BM5220 kernel: hid: raw HID events driver (C) Jiri Kosina
Nov 21 18:52:53 BM5220 kernel: usbcore: registered new interface driver usbhid
Nov 21 18:52:53 BM5220 kernel: usbhid: USB HID core driver
Nov 21 18:52:53 BM5220 kernel: drop_monitor: Initializing network drop monitor service
Nov 21 18:52:53 BM5220 kernel: NET: Registered PF_INET6 protocol family
Nov 21 18:52:53 BM5220 kernel: Segment Routing with IPv6
Nov 21 18:52:53 BM5220 kernel: RPL Segment Routing with IPv6
Nov 21 18:52:53 BM5220 kernel: In-situ OAM (IOAM) with IPv6
Nov 21 18:52:53 BM5220 kernel: NET: Registered PF_PACKET protocol family
Nov 21 18:52:53 BM5220 kernel: x86/pm: family 0x15 cpu detected, MSR saving is needed during suspending.
Nov 21 18:52:53 BM5220 kernel: microcode: Current revision: 0x06001119
Nov 21 18:52:53 BM5220 kernel: IPI shorthand broadcast: enabled
Nov 21 18:52:53 BM5220 kernel: sched_clock: Marking stable (645616167, 32595706)->(697131484, -18919611)
Nov 21 18:52:53 BM5220 kernel: registered taskstats version 1
Nov 21 18:52:53 BM5220 kernel: Loading compiled-in X.509 certificates
Nov 21 18:52:53 BM5220 kernel: Freeing initrd memory: 57876K
Nov 21 18:52:53 BM5220 kernel: Loaded X.509 cert 'Build time autogenerated kernel key: c03c1fe1402d6c6e461f97d145a2c0ada6431430'
Nov 21 18:52:53 BM5220 kernel: zswap: loaded using pool zstd/zsmalloc
Nov 21 18:52:53 BM5220 kernel: Demotion targets for Node 0: null
Nov 21 18:52:53 BM5220 kernel: Key type .fscrypt registered
Nov 21 18:52:53 BM5220 kernel: Key type fscrypt-provisioning registered
Nov 21 18:52:53 BM5220 kernel: Btrfs loaded, zoned=yes, fsverity=yes
Nov 21 18:52:53 BM5220 kernel: Key type big_key registered
Nov 21 18:52:53 BM5220 kernel: integrity: Loading X.509 certificate: UEFI:db
Nov 21 18:52:53 BM5220 kernel: integrity: Loaded X.509 cert 'ASUSTeK MotherBoard SW Key Certificate: da83b990422ebc8c441f8d8b039a65a2'
Nov 21 18:52:53 BM5220 kernel: integrity: Loading X.509 certificate: UEFI:db
Nov 21 18:52:53 BM5220 kernel: integrity: Loaded X.509 cert 'ASUSTeK Notebook SW Key Certificate: b8e581e4df77a5bb4282d5ccfc00c071'
Nov 21 18:52:53 BM5220 kernel: integrity: Loading X.509 certificate: UEFI:db
Nov 21 18:52:53 BM5220 kernel: integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
Nov 21 18:52:53 BM5220 kernel: integrity: Loading X.509 certificate: UEFI:db
Nov 21 18:52:53 BM5220 kernel: integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
Nov 21 18:52:53 BM5220 kernel: integrity: Loading X.509 certificate: UEFI:db
Nov 21 18:52:53 BM5220 kernel: integrity: Loaded X.509 cert 'Canonical Ltd. Master Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
Nov 21 18:52:53 BM5220 kernel: ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
Nov 21 18:52:53 BM5220 kernel: ata1.00: ATA-10: ADATA SU800, Q0518BS, max UDMA/133
Nov 21 18:52:53 BM5220 kernel: ata1.00: 250069680 sectors, multi 2: LBA48 NCQ (depth 32), AA
Nov 21 18:52:53 BM5220 kernel: PM:   Magic number: 1:10:882
Nov 21 18:52:53 BM5220 kernel: hub 8-0:1.0: hash matches
Nov 21 18:52:53 BM5220 kernel: ata1.00: Features: Dev-Sleep DIPM
Nov 21 18:52:53 BM5220 kernel: ata1.00: configured for UDMA/133
Nov 21 18:52:53 BM5220 kernel: RAS: Correctable Errors collector initialized.
Nov 21 18:52:53 BM5220 kernel: scsi 0:0:0:0: Direct-Access     ATA      ADATA SU800      8BS  PQ: 0 ANSI: 5
Nov 21 18:52:53 BM5220 kernel: sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
Nov 21 18:52:53 BM5220 kernel: sd 0:0:0:0: [sda] Write Protect is off
Nov 21 18:52:53 BM5220 kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Nov 21 18:52:53 BM5220 kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 21 18:52:53 BM5220 kernel: sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
Nov 21 18:52:53 BM5220 kernel: clk: Disabling unused clocks
Nov 21 18:52:53 BM5220 kernel: PM: genpd: Disabling unused power domains
Nov 21 18:52:53 BM5220 kernel:  sda: sda1 sda2 sda3 sda4
Nov 21 18:52:53 BM5220 kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Nov 21 18:52:53 BM5220 kernel: Freeing unused decrypted memory: 2028K
Nov 21 18:52:53 BM5220 kernel: Freeing unused kernel image (initmem) memory: 4688K
Nov 21 18:52:53 BM5220 kernel: Write protecting the kernel read-only data: 36864k
Nov 21 18:52:53 BM5220 kernel: Freeing unused kernel image (text/rodata gap) memory: 412K
Nov 21 18:52:53 BM5220 kernel: Freeing unused kernel image (rodata/data gap) memory: 180K
Nov 21 18:52:53 BM5220 kernel: usb 2-2: new high-speed USB device number 2 using ehci-pci
Nov 21 18:52:53 BM5220 kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
Nov 21 18:52:53 BM5220 kernel: rodata_test: all tests were successful
Nov 21 18:52:53 BM5220 kernel: Run /init as init process
Nov 21 18:52:53 BM5220 kernel:   with arguments:
Nov 21 18:52:53 BM5220 kernel:     /init
Nov 21 18:52:53 BM5220 kernel:   with environment:
Nov 21 18:52:53 BM5220 kernel:     HOME=/
Nov 21 18:52:53 BM5220 kernel:     TERM=linux
Nov 21 18:52:53 BM5220 kernel: usb 2-2: New USB device found, idVendor=7392, idProduct=7822, bcdDevice= 2.00
Nov 21 18:52:53 BM5220 kernel: usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Nov 21 18:52:53 BM5220 kernel: usb 2-2: Product: 802.11n WLAN Adapter
Nov 21 18:52:53 BM5220 kernel: usb 2-2: Manufacturer: Realtek
Nov 21 18:52:53 BM5220 kernel: usb 2-2: SerialNumber: 00e04c000001
Nov 21 18:52:53 BM5220 kernel: usb 2-3: new high-speed USB device number 3 using ehci-pci
Nov 21 18:52:53 BM5220 kernel: usb 1-5: new full-speed USB device number 2 using ohci-pci
Nov 21 18:52:53 BM5220 kernel: usb 2-3: New USB device found, idVendor=2717, idProduct=4106, bcdDevice= 0.00
Nov 21 18:52:53 BM5220 kernel: usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Nov 21 18:52:53 BM5220 kernel: usb 2-3: Product: MI WLAN Adapter
Nov 21 18:52:53 BM5220 kernel: usb 2-3: Manufacturer: MediaTek
Nov 21 18:52:53 BM5220 kernel: usb 2-3: SerialNumber: 1.0
Nov 21 18:52:53 BM5220 kernel: usb 1-5: New USB device found, idVendor=0bda, idProduct=5852, bcdDevice= 0.00
Nov 21 18:52:53 BM5220 kernel: usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Nov 21 18:52:53 BM5220 kernel: usb 1-5: Product: Bluetooth Radio
Nov 21 18:52:53 BM5220 kernel: usb 1-5: Manufacturer: Realtek
Nov 21 18:52:53 BM5220 kernel: usb 1-5: SerialNumber: 00e04c000001
Nov 21 18:52:53 BM5220 kernel: [drm] radeon kernel modesetting enabled.
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: vgaarb: deactivate vga console
Nov 21 18:52:53 BM5220 kernel: [drm] initializing kernel modesetting (ARUBA 0x1002:0x9901 0x1043:0x8526 0x00).
Nov 21 18:52:53 BM5220 kernel: ATOM BIOS: 113
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: VRAM: 256M 0x0000000000000000 - 0x000000000FFFFFFF (256M used)
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: GTT: 1024M 0x0000000010000000 - 0x000000004FFFFFFF
Nov 21 18:52:53 BM5220 kernel: [drm] Detected VRAM RAM=256M, BAR=256M
Nov 21 18:52:53 BM5220 kernel: [drm] RAM width 64bits DDR
Nov 21 18:52:53 BM5220 kernel: [drm] radeon: 256M of VRAM memory ready
Nov 21 18:52:53 BM5220 kernel: [drm] radeon: 1024M of GTT memory ready.
Nov 21 18:52:53 BM5220 kernel: [drm] Loading ARUBA Microcode
Nov 21 18:52:53 BM5220 kernel: [drm] Internal thermal controller without fan control
Nov 21 18:52:53 BM5220 kernel: [drm] radeon: dpm initialized
Nov 21 18:52:53 BM5220 kernel: [drm] Found VCE firmware/feedback version 50.0.1 / 17!
Nov 21 18:52:53 BM5220 kernel: [drm] GART: num cpu pages 262144, num gpu pages 262144
Nov 21 18:52:53 BM5220 kernel: [drm] PCIE GART of 1024M enabled (table at 0x00000000001D6000).
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: WB enabled
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: fence driver on ring 0 uses gpu addr 0x0000000010000c00
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: fence driver on ring 5 uses gpu addr 0x0000000000075a18
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: fence driver on ring 6 uses gpu addr 0x0000000010000c18
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: fence driver on ring 7 uses gpu addr 0x0000000010000c1c
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: fence driver on ring 1 uses gpu addr 0x0000000010000c04
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: fence driver on ring 2 uses gpu addr 0x0000000010000c08
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: fence driver on ring 3 uses gpu addr 0x0000000010000c0c
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: fence driver on ring 4 uses gpu addr 0x0000000010000c10
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: radeon: MSI limited to 32-bit
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: radeon: using MSI.
Nov 21 18:52:53 BM5220 kernel: [drm] radeon: irq initialized.
Nov 21 18:52:53 BM5220 kernel: [drm] ring test on 0 succeeded in 2 usecs
Nov 21 18:52:53 BM5220 kernel: [drm] ring test on 3 succeeded in 4 usecs
Nov 21 18:52:53 BM5220 kernel: [drm] ring test on 4 succeeded in 3 usecs
Nov 21 18:52:53 BM5220 kernel: [drm] ring test on 5 succeeded in 2 usecs
Nov 21 18:52:53 BM5220 kernel: usb 4-4: new low-speed USB device number 2 using ohci-pci
Nov 21 18:52:53 BM5220 kernel: [drm] UVD initialized successfully.
Nov 21 18:52:53 BM5220 kernel: tsc: Refined TSC clocksource calibration: 3818.997 MHz
Nov 21 18:52:53 BM5220 kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6e18e4af21c, max_idle_ns: 881590542384 ns
Nov 21 18:52:53 BM5220 kernel: clocksource: Switched to clocksource tsc
Nov 21 18:52:53 BM5220 kernel: [drm] ring test on 6 succeeded in 18 usecs
Nov 21 18:52:53 BM5220 kernel: [drm] ring test on 7 succeeded in 3 usecs
Nov 21 18:52:53 BM5220 kernel: [drm] VCE initialized successfully.
Nov 21 18:52:53 BM5220 kernel: [drm] ib test on ring 0 succeeded in 0 usecs
Nov 21 18:52:53 BM5220 kernel: [drm] ib test on ring 3 succeeded in 0 usecs
Nov 21 18:52:53 BM5220 kernel: [drm] ib test on ring 4 succeeded in 0 usecs
Nov 21 18:52:53 BM5220 kernel: usb 4-4: New USB device found, idVendor=046d, idProduct=c077, bcdDevice=72.00
Nov 21 18:52:53 BM5220 kernel: usb 4-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 21 18:52:53 BM5220 kernel: usb 4-4: Product: USB Optical Mouse
Nov 21 18:52:53 BM5220 kernel: usb 4-4: Manufacturer: Logitech
Nov 21 18:52:53 BM5220 kernel: input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:13.0/usb4/4-4/4-4:1.0/0003:046D:C077.0001/input/input2
Nov 21 18:52:53 BM5220 kernel: hid-generic 0003:046D:C077.0001: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:13.0-4/input0
Nov 21 18:52:53 BM5220 kernel: [drm] ib test on ring 5 succeeded
Nov 21 18:52:53 BM5220 kernel: usb 4-5: new full-speed USB device number 3 using ohci-pci
Nov 21 18:52:53 BM5220 kernel: usb 4-5: New USB device found, idVendor=05af, idProduct=1023, bcdDevice= 0.00
Nov 21 18:52:53 BM5220 kernel: usb 4-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 21 18:52:53 BM5220 kernel: usb 4-5: Product: Ghost Key Elimiantion Keyboard
Nov 21 18:52:53 BM5220 kernel: usb 4-5: Manufacturer: Sunrex/JME
Nov 21 18:52:53 BM5220 kernel: input: Sunrex/JME Ghost Key Elimiantion Keyboard as /devices/pci0000:00/0000:00:13.0/usb4/4-5/4-5:1.0/0003:05AF:1023.0002/input/input3
Nov 21 18:52:53 BM5220 kernel: hid-generic 0003:05AF:1023.0002: input,hidraw1: USB HID v1.11 Keyboard [Sunrex/JME Ghost Key Elimiantion Keyboard] on usb-0000:00:13.0-5/input0
Nov 21 18:52:53 BM5220 kernel: input: Sunrex/JME Ghost Key Elimiantion Keyboard Consumer Control as /devices/pci0000:00/0000:00:13.0/usb4/4-5/4-5:1.1/0003:05AF:1023.0003/input/input4
Nov 21 18:52:53 BM5220 kernel: input: Sunrex/JME Ghost Key Elimiantion Keyboard System Control as /devices/pci0000:00/0000:00:13.0/usb4/4-5/4-5:1.1/0003:05AF:1023.0003/input/input5
Nov 21 18:52:53 BM5220 kernel: hid-generic 0003:05AF:1023.0003: input,hidraw2: USB HID v1.11 Device [Sunrex/JME Ghost Key Elimiantion Keyboard] on usb-0000:00:13.0-5/input1
Nov 21 18:52:53 BM5220 kernel: [drm] ib test on ring 6 succeeded
Nov 21 18:52:53 BM5220 kernel: [drm] ib test on ring 7 succeeded
Nov 21 18:52:53 BM5220 kernel: [drm] Radeon Display Connectors
Nov 21 18:52:53 BM5220 kernel: [drm] Connector 0:
Nov 21 18:52:53 BM5220 kernel: [drm]   HDMI-A-1
Nov 21 18:52:53 BM5220 kernel: [drm]   HPD1
Nov 21 18:52:53 BM5220 kernel: [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 0x653c 0x653c
Nov 21 18:52:53 BM5220 kernel: [drm]   Encoders:
Nov 21 18:52:53 BM5220 kernel: [drm]     DFP1: INTERNAL_UNIPHY2
Nov 21 18:52:53 BM5220 kernel: [drm] Connector 1:
Nov 21 18:52:53 BM5220 kernel: [drm]   VGA-1
Nov 21 18:52:53 BM5220 kernel: [drm]   HPD2
Nov 21 18:52:53 BM5220 kernel: [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c
Nov 21 18:52:53 BM5220 kernel: [drm]   Encoders:
Nov 21 18:52:53 BM5220 kernel: [drm]     CRT1: INTERNAL_UNIPHY2
Nov 21 18:52:53 BM5220 kernel: [drm]     CRT1: NUTMEG
Nov 21 18:52:53 BM5220 kernel: [drm] Connector 2:
Nov 21 18:52:53 BM5220 kernel: [drm]   DVI-D-1
Nov 21 18:52:53 BM5220 kernel: [drm]   HPD3
Nov 21 18:52:53 BM5220 kernel: [drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558 0x655c 0x655c
Nov 21 18:52:53 BM5220 kernel: [drm]   Encoders:
Nov 21 18:52:53 BM5220 kernel: [drm]     DFP2: INTERNAL_UNIPHY
Nov 21 18:52:53 BM5220 kernel: [drm] Initialized radeon 2.51.0 for 0000:00:01.0 on minor 0
Nov 21 18:52:53 BM5220 kernel: [drm] fb mappable at 0xD03E9000
Nov 21 18:52:53 BM5220 kernel: [drm] vram apper at 0xD0000000
Nov 21 18:52:53 BM5220 kernel: [drm] size 8294400
Nov 21 18:52:53 BM5220 kernel: [drm] fb depth is 24
Nov 21 18:52:53 BM5220 kernel: [drm]    pitch is 7680
Nov 21 18:52:53 BM5220 kernel: fbcon: radeondrmfb (fb0) is primary device
Nov 21 18:52:53 BM5220 kernel: fbcon: Deferring console take-over
Nov 21 18:52:53 BM5220 kernel: radeon 0000:00:01.0: [drm] fb0: radeondrmfb frame buffer device
Nov 21 18:52:53 BM5220 kernel: fbcon: Taking over console
Nov 21 18:52:53 BM5220 kernel: Console: switching to colour frame buffer device 240x67
Nov 21 18:52:53 BM5220 kernel: EXT4-fs (sda3): mounted filesystem 7e5f26b7-dfb4-4127-a8db-b4a8a512c3c0 r/w with ordered data mode. Quota mode: none.
Nov 21 18:52:53 BM5220 systemd[1]: systemd 258.2-2-arch running in system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
Nov 21 18:52:53 BM5220 systemd[1]: Detected architecture x86-64.
Nov 21 18:52:53 BM5220 systemd[1]: Hostname set to <BM5220>.
Nov 21 18:52:53 BM5220 systemd[1]: bpf-restrict-fs: LSM BPF program attached
Nov 21 18:52:53 BM5220 systemd[1]: Queued start job for default target Graphical Interface.
Nov 21 18:52:53 BM5220 systemd[1]: Created slice Virtual Machine and Container Slice.
Nov 21 18:52:53 BM5220 systemd[1]: Created slice Slice /system/dirmngr.
Nov 21 18:52:53 BM5220 systemd[1]: Created slice Slice /system/getty.
Nov 21 18:52:53 BM5220 systemd[1]: Created slice Slice /system/gpg-agent.
Nov 21 18:52:53 BM5220 systemd[1]: Created slice Slice /system/gpg-agent-browser.
Nov 21 18:52:53 BM5220 systemd[1]: Created slice Slice /system/gpg-agent-extra.
Nov 21 18:52:53 BM5220 systemd[1]: Created slice Slice /system/gpg-agent-ssh.
Nov 21 18:52:53 BM5220 systemd[1]: Created slice Slice /system/keyboxd.
Nov 21 18:52:53 BM5220 systemd[1]: Created slice Slice /system/modprobe.
Nov 21 18:52:53 BM5220 systemd[1]: Created slice Slice /system/systemd-fsck.
Nov 21 18:52:53 BM5220 systemd[1]: Created slice User and Session Slice.
Nov 21 18:52:53 BM5220 systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
Nov 21 18:52:53 BM5220 systemd[1]: Started Forward Password Requests to Wall Directory Watch.
Nov 21 18:52:53 BM5220 systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
Nov 21 18:52:53 BM5220 systemd[1]: Expecting device /dev/disk/by-uuid/0088-2AD0...
Nov 21 18:52:53 BM5220 systemd[1]: Reached target Local Encrypted Volumes.
Nov 21 18:52:53 BM5220 systemd[1]: Reached target Login Prompts.
Nov 21 18:52:53 BM5220 systemd[1]: Reached target Image Downloads.
Nov 21 18:52:53 BM5220 systemd[1]: Reached target Local Integrity Protected Volumes.
Nov 21 18:52:53 BM5220 systemd[1]: Reached target Path Units.
Nov 21 18:52:53 BM5220 systemd[1]: Reached target Remote File Systems.
Nov 21 18:52:53 BM5220 systemd[1]: Reached target Slice Units.
Nov 21 18:52:53 BM5220 systemd[1]: Reached target Local Verity Protected Volumes.
Nov 21 18:52:53 BM5220 systemd[1]: Listening on Device-mapper event daemon FIFOs.
Nov 21 18:52:53 BM5220 systemd[1]: Listening on LVM2 poll daemon socket.
Nov 21 18:52:53 BM5220 systemd[1]: Listening on Query the User Interactively for a Password.
Nov 21 18:52:53 BM5220 systemd[1]: Listening on Process Core Dump Socket.
Nov 21 18:52:53 BM5220 systemd[1]: Listening on Credential Encryption/Decryption.
Nov 21 18:52:53 BM5220 systemd[1]: Listening on Factory Reset Management.
Nov 21 18:52:53 BM5220 systemd[1]: Listening on Journal Socket (/dev/log).
Nov 21 18:52:53 BM5220 systemd[1]: Listening on Journal Sockets.
Nov 21 18:52:53 BM5220 systemd[1]: TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Nov 21 18:52:53 BM5220 systemd[1]: Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Nov 21 18:52:53 BM5220 systemd[1]: Listening on udev Control Socket.
Nov 21 18:52:53 BM5220 systemd[1]: Listening on udev Kernel Socket.
Nov 21 18:52:53 BM5220 systemd[1]: Listening on udev Varlink Socket.
Nov 21 18:52:53 BM5220 systemd[1]: Mounting Huge Pages File System...
Nov 21 18:52:53 BM5220 systemd[1]: Mounting POSIX Message Queue File System...
Nov 21 18:52:53 BM5220 systemd[1]: Mounting Kernel Debug File System...
Nov 21 18:52:53 BM5220 systemd[1]: Mounting Kernel Trace File System...
Nov 21 18:52:53 BM5220 systemd[1]: Starting Create List of Static Device Nodes...
Nov 21 18:52:53 BM5220 systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
Nov 21 18:52:53 BM5220 systemd[1]: Load Kernel Module configfs was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!configfs).
Nov 21 18:52:53 BM5220 systemd[1]: Mounting Kernel Configuration File System...
Nov 21 18:52:53 BM5220 systemd[1]: Starting Load Kernel Module dm_mod...
Nov 21 18:52:53 BM5220 systemd[1]: Load Kernel Module drm was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!drm).
Nov 21 18:52:53 BM5220 systemd[1]: Load Kernel Module fuse was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!fuse).
Nov 21 18:52:53 BM5220 systemd[1]: Mounting FUSE Control File System...
Nov 21 18:52:53 BM5220 systemd[1]: Starting Load Kernel Module loop...
Nov 21 18:52:53 BM5220 systemd[1]: File System Check on Root Device was skipped because of an unmet condition check (ConditionPathIsReadWrite=!/).
Nov 21 18:52:53 BM5220 systemd[1]: Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
Nov 21 18:52:53 BM5220 systemd[1]: Starting Journal Service...
Nov 21 18:52:53 BM5220 systemd[1]: Starting Load Kernel Modules...
Nov 21 18:52:53 BM5220 systemd[1]: TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Nov 21 18:52:53 BM5220 systemd[1]: Starting Remount Root and Kernel File Systems...
Nov 21 18:52:53 BM5220 systemd[1]: Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Nov 21 18:52:53 BM5220 systemd[1]: Starting Load udev Rules from Credentials...
Nov 21 18:52:53 BM5220 systemd[1]: Starting Coldplug All udev Devices...
Nov 21 18:52:53 BM5220 kernel: loop: module loaded
Nov 21 18:52:53 BM5220 systemd[1]: Mounted Huge Pages File System.
Nov 21 18:52:53 BM5220 systemd[1]: Mounted POSIX Message Queue File System.
Nov 21 18:52:53 BM5220 systemd[1]: Mounted Kernel Debug File System.
Nov 21 18:52:53 BM5220 systemd[1]: Mounted Kernel Trace File System.
Nov 21 18:52:53 BM5220 systemd[1]: Finished Create List of Static Device Nodes.
Nov 21 18:52:53 BM5220 systemd[1]: Mounted Kernel Configuration File System.
Nov 21 18:52:53 BM5220 systemd[1]: Mounted FUSE Control File System.
Nov 21 18:52:53 BM5220 systemd[1]: modprobe@loop.service: Deactivated successfully.
Nov 21 18:52:53 BM5220 systemd[1]: Finished Load Kernel Module loop.
Nov 21 18:52:53 BM5220 systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
Nov 21 18:52:53 BM5220 kernel: device-mapper: uevent: version 1.0.3
Nov 21 18:52:53 BM5220 kernel: device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
Nov 21 18:52:53 BM5220 systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
Nov 21 18:52:53 BM5220 systemd[1]: Finished Load Kernel Module dm_mod.
Nov 21 18:52:53 BM5220 kernel: EXT4-fs (sda3): re-mounted 7e5f26b7-dfb4-4127-a8db-b4a8a512c3c0.
Nov 21 18:52:53 BM5220 systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
Nov 21 18:52:53 BM5220 systemd[1]: Finished Remount Root and Kernel File Systems.
Nov 21 18:52:53 BM5220 systemd[1]: Activating swap /swap...
Nov 21 18:52:53 BM5220 systemd[1]: Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
Nov 21 18:52:53 BM5220 systemd[1]: Starting Load/Save OS Random Seed...
Nov 21 18:52:53 BM5220 systemd[1]: TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Nov 21 18:52:53 BM5220 systemd[1]: Finished Load udev Rules from Credentials.
Nov 21 18:52:53 BM5220 systemd-journald[276]: Collecting audit messages is disabled.
Nov 21 18:52:53 BM5220 kernel: Adding 2097148k swap on /swap.  Priority:-2 extents:58 across:59916288k SS
Nov 21 18:52:53 BM5220 systemd[1]: Activated swap /swap.
Nov 21 18:52:53 BM5220 systemd[1]: Reached target Swaps.
Nov 21 18:52:53 BM5220 kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Nov 21 18:52:53 BM5220 kernel: i2c_dev: i2c /dev entries driver
Nov 21 18:52:53 BM5220 kernel: it87: Found IT8603E chip at 0x290, revision 1
Nov 21 18:52:53 BM5220 systemd[1]: Finished Load Kernel Modules.
Nov 21 18:52:53 BM5220 systemd[1]: Starting Apply Kernel Variables...
Nov 21 18:52:53 BM5220 systemd[1]: Finished Create Static Device Nodes in /dev gracefully.
Nov 21 18:52:53 BM5220 systemd[1]: Create System Users was skipped because no trigger condition checks were met.
Nov 21 18:52:53 BM5220 systemd[1]: Starting Network Time Synchronization...
Nov 21 18:52:53 BM5220 systemd[1]: Starting Create Static Device Nodes in /dev...
Nov 21 18:52:53 BM5220 systemd[1]: Finished Apply Kernel Variables.
Nov 21 18:52:53 BM5220 systemd[1]: Started Journal Service.
Nov 21 18:52:53 BM5220 kernel: random: crng init done
Nov 21 18:52:53 BM5220 systemd-journald[276]: Received client request to flush runtime journal.
Nov 21 18:52:53 BM5220 systemd-journald[276]: File /var/log/journal/5580eb3cb26647fa935f19263112b322/system.journal corrupted or uncleanly shut down, renaming and replacing.
Nov 21 18:52:53 BM5220 kernel: mousedev: PS/2 mouse device common for all mice
Nov 21 18:52:53 BM5220 kernel: acpi_cpufreq: overriding BIOS provided _PSD data
Nov 21 18:52:53 BM5220 kernel: piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
Nov 21 18:52:53 BM5220 kernel: piix4_smbus 0000:00:14.0: Using register 0x2e for SMBus port selection
Nov 21 18:52:53 BM5220 kernel: i2c i2c-7: Successfully instantiated SPD at 0x50
Nov 21 18:52:53 BM5220 kernel: i2c i2c-7: Successfully instantiated SPD at 0x51
Nov 21 18:52:53 BM5220 kernel: i2c i2c-7: Successfully instantiated SPD at 0x52
Nov 21 18:52:53 BM5220 kernel: input: PC Speaker as /devices/platform/pcspkr/input/input6
Nov 21 18:52:53 BM5220 kernel: i2c i2c-7: Successfully instantiated SPD at 0x53
Nov 21 18:52:53 BM5220 kernel: piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
Nov 21 18:52:54 BM5220 kernel: sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
Nov 21 18:52:54 BM5220 kernel: sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO address
Nov 21 18:52:54 BM5220 kernel: sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
Nov 21 18:52:54 BM5220 kernel: asus_wmi: ASUS WMI generic driver loaded
Nov 21 18:52:54 BM5220 kernel: asus_wmi: failed to register LPS0 sleep handler in asus-wmi
Nov 21 18:52:54 BM5220 kernel: asus_wmi: Initialization: 0x0
Nov 21 18:52:54 BM5220 kernel: asus_wmi: BIOS WMI version: 0.9
Nov 21 18:52:54 BM5220 kernel: asus_wmi: SFUN value: 0x0
Nov 21 18:52:54 BM5220 kernel: eeepc-wmi eeepc-wmi: Detected ASUSWMI, use DCTS
Nov 21 18:52:54 BM5220 kernel: input: Eee PC WMI hotkeys as /devices/platform/eeepc-wmi/input/input7
Nov 21 18:52:54 BM5220 kernel: at24 7-0050: supply vcc not found, using dummy regulator
Nov 21 18:52:54 BM5220 kernel: at24 7-0050: 256 byte spd EEPROM, read-only
Nov 21 18:52:54 BM5220 kernel: at24 7-0051: supply vcc not found, using dummy regulator
Nov 21 18:52:54 BM5220 kernel: at24 7-0051: 256 byte spd EEPROM, read-only
Nov 21 18:52:54 BM5220 kernel: at24 7-0052: supply vcc not found, using dummy regulator
Nov 21 18:52:54 BM5220 kernel: at24 7-0052: 256 byte spd EEPROM, read-only
Nov 21 18:52:54 BM5220 kernel: at24 7-0053: supply vcc not found, using dummy regulator
Nov 21 18:52:54 BM5220 kernel: at24 7-0053: 256 byte spd EEPROM, read-only
Nov 21 18:52:54 BM5220 kernel: snd_hda_intel 0000:00:01.1: enabling device (0000 -> 0002)
Nov 21 18:52:54 BM5220 kernel: snd_hda_intel 0000:00:01.1: Force to non-snoop mode
Nov 21 18:52:54 BM5220 kernel: kvm_amd: TSC scaling supported
Nov 21 18:52:54 BM5220 kernel: kvm_amd: Nested Virtualization enabled
Nov 21 18:52:54 BM5220 kernel: kvm_amd: Nested Paging enabled
Nov 21 18:52:54 BM5220 kernel: kvm_amd: LBR virtualization supported
Nov 21 18:52:54 BM5220 kernel: snd_hda_intel 0000:00:01.1: bound 0000:00:01.0 (ops radeon_audio_component_bind_ops [radeon])
Nov 21 18:52:54 BM5220 kernel: input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/sound/card0/input8
Nov 21 18:52:56 BM5220 systemd-journald[276]: File /var/log/journal/5580eb3cb26647fa935f19263112b322/user-1000.journal corrupted or uncleanly shut down, renaming and replacing.

