Return-Path: <linux-wireless+bounces-15865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D243D9E2BC0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 20:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789E3B26662
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D191F4707;
	Tue,  3 Dec 2024 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qacafe.com header.i=@qacafe.com header.b="mHcWrIu8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9FF1EE019
	for <linux-wireless@vger.kernel.org>; Tue,  3 Dec 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243987; cv=none; b=g+bahrH3cZqqVIdcmYmW+AY4IglOksMnw7WKy56Q8/Y8IQEwBZyoTOlWODubkZfWYGJ3e64EFCqVfafn4PpSeQt8REt6T9pDATjjP9kcWO+zy8421oj4yIwGvVKnPzdcaL6q6e4C+YUJwA/tCxCG0Ot/Q7kOHTxomEOA8/lRJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243987; c=relaxed/simple;
	bh=sNk7ALGJx1lmO+KM6GYaA9qhVTLJBwi5zJwlCD4uBYk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Y+75tQ6fFqFTi+yuUkREyehJO5THZz5Jma9jWsDGC7uiFGjOhoGevD1Prr32c9kR2kqDDhs3h8lppmZ3gpao+Dd9zlVkCc0bevJ143qUnk1TlScKUocsZvE5kdMejmB3m/7PjsXkLXQ1kRjzCeLAv8sNSnrzgqNlgn/CXsq1B68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=qacafe.com; spf=pass smtp.mailfrom=qacafe.com; dkim=pass (1024-bit key) header.d=qacafe.com header.i=@qacafe.com header.b=mHcWrIu8; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=qacafe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qacafe.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-84183532291so228823839f.2
        for <linux-wireless@vger.kernel.org>; Tue, 03 Dec 2024 08:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qacafe.com; s=google; t=1733243984; x=1733848784; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+YObIQmmbZsc5Mi4mBVccfM+nsPCB05Xo3E3eqTWKzs=;
        b=mHcWrIu8T/MUnFM8HCtsnN3fthru9i6NiYdUwlu1zA9nuSR44Udq13V93e8ZawF40R
         Fysr1cp3fYqtV3xcOxh9RYOADlLvn7v6PppM7iAIoYnq0AoW9C/jPqZk3RZHhK6MOzZz
         lbXmPI4UFggvEKYEGO0eyygDNZE6OGAOtnIMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243984; x=1733848784;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YObIQmmbZsc5Mi4mBVccfM+nsPCB05Xo3E3eqTWKzs=;
        b=PalhnAAvXphBerDArU1PC4wexNgWX8I+cEd9DKuAguqYd3VBQVyZuxiIh4CHHNo0Qd
         G0rx/fXrizj0mW9MFvsRkOqbyeF5VYDZPocOJbpzk6WQZ5SA9KukCVqgZTeiOgZOuvg7
         DLZ907o4Q4ZwWRRayv8UnnpgENIf4TiXJrEzIAqnyBU1Gv1Ql00CvaB2Ybd1TbdNQqov
         YEKqVVN3xq+HDw0ZYqndXH1J5DAYS9mV7exZKRRPzdlFvCFsDhAAd3+r8U7U9iAIVXU/
         SG28mC4OUJZ6VWohVGz0BxO5GvVarnDOA93vjhCe6/OcP6uc/ReeR4FSM9GKILMONs9Y
         otyQ==
X-Gm-Message-State: AOJu0YxlQPIXxP5vdd+mG/kEQOr01AM3M2v53RM9GC4mTWxpH4zAchRk
	FFiE8TKIhnl9BSArqc4gtkvQ6tPDTbCHnvk28vpe0ULXw3kXnj6dPYZEq/Rj21vBKRZ2TvrKaBX
	Q1KsK01FzKmN18dv/SYGQw4i8aaIUAONDGbBxVm7LnXH5KL/2ozE=
X-Gm-Gg: ASbGncsm7vKUB3TluntWEYumPK1V8M+nXsliYZXvSyRrCynsCkISzcFeAIiv3b3OAGX
	rzstYlB0gfViq4qnn9aZVfCxA9QofkslRL02O6c1n62/ZL3tzFRsX+YAXsQES2YtRpA==
X-Google-Smtp-Source: AGHT+IGuVNIjrosWXLgrBMZgl8otjT1pzj/nKJKcN/StQm3HtIkC0d5yY/D5Uyh6ovGjK5wx4nfZSceUI2s93bVsEUY=
X-Received: by 2002:a05:6602:6422:b0:82c:e4e1:2e99 with SMTP id
 ca18e2360f4ac-8445b5cc0e6mr393927639f.11.1733243983774; Tue, 03 Dec 2024
 08:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Carlin <tc@qacafe.com>
Date: Tue, 3 Dec 2024 11:39:08 -0500
Message-ID: <CAEEa6Ls6Tr7npuMNN1Tr07qo3hXMe4NwCDvamyFojZtJ2ZLXWg@mail.gmail.com>
Subject: MT7916 (mt7915e module) System Crash
To: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

With a new installation of Rocky 9.5 using a 6.11.7 kernel we have
observed a system crash related to the unloading/loading of the
mt7915e kernel module, using the MT7916 hardware.

Included below is the output of a kernel warning during unload.
The system crashes during module load, and so no log output
is available.  I=E2=80=99ve also included version information.

Usually at most 3-5 cycles of unload/load are needed to generate
a crash. (e.g. `modprobe -r mt7915e && modprobe mt7915e`).

Would anyone be able to debug this with me?  I would be happy
to provide more debugging or logging information as needed.

Thank you,
Tim Carlin
QA Cafe

Dec  3 11:06:14 localhost kernel: mt7915e 0000:51:00.0: HW/SW Version:
0x8a108a10, Build Time: 20230202144915a
Dec  3 11:06:14 localhost kernel: mt7915e 0000:51:00.0: WM Firmware
Version: ____000000, Build Time: 20230202145005
Dec  3 11:06:14 localhost kernel: mt7915e 0000:51:00.0: WA Firmware
Version: DEV_000000, Build Time: 20230202143332

Dec  3 11:09:45 localhost kernel: ------------[ cut here ]------------
Dec  3 11:09:45 localhost kernel: WARNING: CPU: 16 PID: 2952 at
net/core/page_pool.c:1057 page_pool_disable_direct_recycling+0x33/0x40
Dec  3 11:09:45 localhost kernel: Modules linked in: snd_seq_dummy(E)
snd_hrtimer(E) snd_seq(E) snd_seq_device(E) snd_timer(E) snd(E)
soundcore(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E)
nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E)
nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E)
nf_defrag_ipv6(E) nf_defrag_ipv4(E) ip_set(E) nf_tables(E)
nfnetlink(E) qrtr(E) vfat(E) fat(E) intel_rapl_msr(E)
intel_rapl_common(E) intel_uncore_frequency(E)
intel_uncore_frequency_common(E) i10nm_edac(E) skx_edac_common(E)
nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E)
coretemp(E) iwlmvm(E) kvm_intel(E) mt7915e(E-) mt76_connac_lib(E)
mt76(E) kvm(E) mac80211(E) iwlwifi(E) rapl(E) libarc4(E)
intel_cstate(E) cfg80211(E) iTCO_wdt(E) intel_pmc_bxt(E)
iTCO_vendor_support(E) isst_if_mbox_pci(E) isst_if_mmio(E)
ipmi_ssif(E) intel_uncore(E) dax_hmem(E) pcspkr(E) isst_if_common(E)
i2c_i801(E) rfkill(E) i2c_mux(E) ftdi_sio(E) intel_th_gth(E) mei_me(E)
i2c_smbus(E) mei(E) intel_pch_thermal(E) intel_th_pci(E)
Dec  3 11:09:45 localhost kernel: intel_vsec(E) ioatdma(E) intel_th(E)
ipmi_si(E) acpi_power_meter(E) acpi_ipmi(E) ipmi_devintf(E) joydev(E)
ipmi_msghandler(E) acpi_pad(E) xfs(E) libcrc32c(E) rndis_host(E)
cdc_ether(E) usbnet(E) mii(E) sd_mod(E) sg(E) ast(E)
drm_shmem_helper(E) drm_kms_helper(E) crct10dif_pclmul(E) ahci(E)
crc32_pclmul(E) crc32c_intel(E) polyval_clmulni(E) libahci(E)
polyval_generic(E) nvme(E) drm(E) libata(E) igb(E) i40e(E)
ghash_clmulni_intel(E) nvme_core(E) libie(E) dca(E) i2c_algo_bit(E)
fuse(E)
Dec  3 11:09:45 localhost kernel: CPU: 16 UID: 0 PID: 2952 Comm:
modprobe Kdump: loaded Tainted: G        W   E
6.11.7-1.el9.elrepo.x86_64 #1
Dec  3 11:09:45 localhost kernel: Tainted: [W]=3DWARN, [E]=3DUNSIGNED_MODUL=
E
Dec  3 11:09:45 localhost kernel: Hardware name: Supermicro Super
Server/X12SPL-F, BIOS 1.9 01/03/2024
Dec  3 11:09:45 localhost kernel: RIP:
0010:page_pool_disable_direct_recycling+0x33/0x40
Dec  3 11:09:45 localhost kernel: Code: c7 47 30 ff ff ff ff 48 85 c0
74 19 48 8b 50 10 83 e2 01 74 15 8b 40 34 83 f8 ff 75 11 48 c7 47 18
00 00 00 00 c3 cc cc cc cc <0f> 0b eb e7 0f 0b eb eb 0f 1f 44 00 00 90
90 90 90 90 90 90 90 90
Dec  3 11:09:45 localhost kernel: RSP: 0018:ff5df22286b17d78 EFLAGS: 000102=
46
Dec  3 11:09:45 localhost kernel: RAX: ff375ee85b302f90 RBX:
ff375ee850031800 RCX: 0000000000000000
Dec  3 11:09:45 localhost kernel: RDX: 0000000000000000 RSI:
ffffffff937e54ce RDI: ff375ee850031800
Dec  3 11:09:45 localhost kernel: RBP: ff375ee85b302020 R08:
0000000000000000 R09: ff5df22286b17d57
Dec  3 11:09:45 localhost kernel: R10: 0000000000000000 R11:
0000000000000187 R12: ff375ee85b303120
Dec  3 11:09:45 localhost kernel: R13: ff375ee85b304dd0 R14:
ff375ee85b3026b8 R15: ffffffffc09d99b8
Dec  3 11:09:45 localhost kernel: FS:  00007f5bc1182740(0000)
GS:ff375ef73fc00000(0000) knlGS:0000000000000000
Dec  3 11:09:45 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Dec  3 11:09:45 localhost kernel: CR2: 0000563961080000 CR3:
000000011eafe006 CR4: 0000000000771ef0
Dec  3 11:09:45 localhost kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Dec  3 11:09:45 localhost kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Dec  3 11:09:45 localhost kernel: PKRU: 55555554
Dec  3 11:09:45 localhost kernel: Call Trace:
Dec  3 11:09:45 localhost kernel: <TASK>
Dec  3 11:09:45 localhost kernel: ? __warn+0x7f/0x120
Dec  3 11:09:45 localhost kernel: ? page_pool_disable_direct_recycling+0x33=
/0x40
Dec  3 11:09:45 localhost kernel: ? report_bug+0x1c3/0x1d0
Dec  3 11:09:45 localhost kernel: ? handle_bug+0x5b/0xa0
Dec  3 11:09:45 localhost kernel: ? exc_invalid_op+0x14/0x70
Dec  3 11:09:45 localhost kernel: ? asm_exc_invalid_op+0x16/0x20
Dec  3 11:09:45 localhost kernel: ? page_pool_disable_direct_recycling+0x33=
/0x40
Dec  3 11:09:45 localhost kernel: page_pool_destroy+0x41/0x150
Dec  3 11:09:45 localhost kernel: mt76_dma_cleanup+0x119/0x220 [mt76]
Dec  3 11:09:45 localhost kernel: mt7915_stop_hardware+0x1e/0x40 [mt7915e]
Dec  3 11:09:45 localhost kernel: mt7915_unregister_device+0xb6/0xd0 [mt791=
5e]
Dec  3 11:09:45 localhost kernel: pci_device_remove+0x3b/0xb0
Dec  3 11:09:45 localhost kernel: device_release_driver_internal+0x193/0x20=
0
Dec  3 11:09:45 localhost kernel: driver_detach+0x44/0x90
Dec  3 11:09:45 localhost kernel: bus_remove_driver+0x69/0xf0
Dec  3 11:09:45 localhost kernel: pci_unregister_driver+0x2a/0xb0
Dec  3 11:09:45 localhost kernel: mt7915_exit+0xc/0xce0 [mt7915e]
Dec  3 11:09:45 localhost kernel: __do_sys_delete_module.constprop.0+0x176/=
0x310
Dec  3 11:09:45 localhost kernel: ? syscall_trace_enter+0xfb/0x190
Dec  3 11:09:45 localhost kernel: do_syscall_64+0x60/0x180
Dec  3 11:09:45 localhost kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec  3 11:09:45 localhost kernel: RIP: 0033:0x7f5bc090ef2b
Dec  3 11:09:45 localhost kernel: Code: 73 01 c3 48 8b 0d ed 9e 0e 00
f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bd 9e
0e 00 f7 d8 64 89 01 48
Dec  3 11:09:45 localhost kernel: RSP: 002b:00007ffda08a7e88 EFLAGS:
00000206 ORIG_RAX: 00000000000000b0
Dec  3 11:09:45 localhost kernel: RAX: ffffffffffffffda RBX:
00005644bab1cd90 RCX: 00007f5bc090ef2b
Dec  3 11:09:45 localhost kernel: RDX: 0000000000000000 RSI:
0000000000000800 RDI: 00005644bab1cdf8
Dec  3 11:09:45 localhost kernel: RBP: 00005644bab1cd90 R08:
0000000000000000 R09: 0000000000000000
Dec  3 11:09:45 localhost kernel: R10: 00007f5bc099eac0 R11:
0000000000000206 R12: 00005644bab1cdf8
Dec  3 11:09:45 localhost kernel: R13: 0000000000000000 R14:
00005644bab1cdf8 R15: 00007ffda08aa1b8
Dec  3 11:09:45 localhost kernel: </TASK>
Dec  3 11:09:45 localhost kernel: ---[ end trace 0000000000000000 ]---

