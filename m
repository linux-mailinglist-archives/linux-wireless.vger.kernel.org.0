Return-Path: <linux-wireless+bounces-22455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6EDAA9519
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 16:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DC9189A932
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9BB202C34;
	Mon,  5 May 2025 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="MYrWI56O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397F54670
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454198; cv=none; b=PILgclQ49e2/C9YIlVjFQImXHPXbHj8cgdb+qo6sxxU4nqbOqh5tmCzipki7oMODIaeDicYvXJPZA9S9ouwMkYD7G8zscaCF/fBp1/1gOMG5ScSlwfVSZ9Iay6BOfchk7TKulru5o8CjVokFsP+/G+eUOOCH6FdjvtCsWU/MyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454198; c=relaxed/simple;
	bh=6HLLGoxLzq/vGvvA2UmhxQe2IyswbBZHFnFyCJdVpfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2NFWRtikKuiYk2/PNS8I0LPD5hnnUtUEyZpshy7KnOXoe9kPRzXX6lZIUK4zQ25/8VjiPdxP4Onh7Uk2I4wV9AiBeklc5Bzx9lkP4FhnxAk9sD/Xr2nBEpTnMutGAtVnqkbgKOz5m8CU2RuqdY64+0fSuPQefcU5JfqGq9wsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=MYrWI56O; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c5e39d1e0eso488946285a.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1746454192; x=1747058992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz79ULVl6WSeuhWIMZ5c/nAlTqV3fbTdIwEo2sFrZMw=;
        b=MYrWI56O0D80RDxHuFKERRxXJkVBa3aXhMwhWO6ntUzWBryPyk6JzOYGVUnRCwlDv0
         /i8uFh1IiYc9u4fDyc9ZDaz409bDA0O4dmvvpbrcv/a3pm+re24r1ftPPtZTaKpFZ3J0
         3KLQEqf22cjB10MmIEgdBFvD9PYmm0gWYw9hRo3P5PD8VbssIvZkKJjrOYZIzNYfei7E
         U7HYywooVOjQ+xMHZ0NlySJ48mNDssLeTlsHNwFEnwRKKBgd8lN05lg+TkRPzPLj6gzy
         KeaiUoTyCspzfk1BzJ7BmlfnITA+pXtPU/+Q3D8/1Pz33uI1gx+sIeWTqGD1dnvYlPv5
         kQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746454192; x=1747058992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uz79ULVl6WSeuhWIMZ5c/nAlTqV3fbTdIwEo2sFrZMw=;
        b=mimR8/n0+WoUnhaFh1wl+CrvFt3o+NDYbEMuRZNDHbp/ikzAnELwWy2wbkWy3jivN9
         sGwiT7hk7Eboo9myF0rUSxdj496axMVrXa4bC0xGixinN66QcVrj91HgJHo/RlXo1NDR
         yVbLk5yqrNEUGWSGecgvsGBymktYfsqZrOjQESNALh5HsykfViXfUmOicXAsDU8lMJ5a
         g89/RqysMPsrXM1WWZda/oh/tHhHx1LwgvMqgjMv7Cqr7HWvMdYF/pH7XF/XfvHzAHbw
         bqdize39iMi9hIDsKVQTQkfTCDFesJo1QcPR2NDFJQ0xasZF09cBhZK4IsO1aSBdb3CL
         bShA==
X-Forwarded-Encrypted: i=1; AJvYcCXY2a0n6fZGYyU99XCf7veLKJAOoWCOmru7p2ybNNJ4udLDp8ojysKI+LsUgmuSwlDHndun6rDhzGQ6bPPe+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFw72nCnX1VSb/BsZ1ZtV1c6SYo64kKbGX/ftX86Jotw8OMKjQ
	m84obGLrxOVtS5iCqKRFHkpHr9B6YbRCBSIgLeuq0lx6YF2x7E8AlxuqIlIa8ML2X9666w8iNk7
	J/ybHhM7frBmsECyrd7+Oh3yQaczb0/Vj39QU0Q==
X-Gm-Gg: ASbGncsEBuF9Kb1SkyLLmd4k0tzGGTcCeDgz61M0bTEWfCCHPTfrD8nejW98axqsAPy
	PJEqEDSDN4M+vXpisVnw7U6T8G89LxTB2luTjyEcMic88Da61h0b7MqquszGNJfNNu503Euav7i
	xM0bvjCMgSsoI2XZsbGW42879q
X-Google-Smtp-Source: AGHT+IHrE8jZU9WOI8TvFQ2VmbAYhtZfYFuSzJfw306xsDq5wOOhnRZm7SmjWgFEzbhaFIzxBarTYJuecX6dREnu3RU=
X-Received: by 2002:a05:620a:471e:b0:7c9:4df8:6b88 with SMTP id
 af79cd13be357-7cae3a8a41fmr1095476985a.7.1746454192007; Mon, 05 May 2025
 07:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
 <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com> <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
 <CAONkfw6m9O_6FZHBrPYdpv+=AxSgsbh1T7+GaS+U+bnjyVVJvQ@mail.gmail.com>
 <3da5d47b-993c-405e-841f-1d16d8715610@quicinc.com> <1d0682c0-ee5d-f2d4-199d-4ebc4e71f9ef@quicinc.com>
 <3660fcfb-be29-422b-a352-3996ad3fc41f@quicinc.com> <CAONkfw5-bfYRwHZ9iHhgJP2f8Zqyz5SZVbdL4n9EPhKU+=ONPg@mail.gmail.com>
 <CAONkfw7xjJjMAZSfHg5avEV=Bc5aJZqrRxMDvKWK4g14bLNjRQ@mail.gmail.com>
 <d4b01807-0770-439a-a77b-1e0f078687e3@quicinc.com> <07013bbc-296a-2403-a6ca-70de220495c5@quicinc.com>
 <fd6c118b-90ea-4d11-13d0-d8f49f9325e3@quicinc.com> <CAONkfw7z3QZORCMxOJAnzF0bLNmsZKfV3rOYEhStAK628dpq+g@mail.gmail.com>
 <15edfacb-4eeb-bc3f-72cd-4b7744c9da13@quicinc.com> <CAONkfw5=Ze5TrGf1ZYrgDsWhGzOrK8oj4vPGf=xL9UDuLTYx6g@mail.gmail.com>
In-Reply-To: <CAONkfw5=Ze5TrGf1ZYrgDsWhGzOrK8oj4vPGf=xL9UDuLTYx6g@mail.gmail.com>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Mon, 5 May 2025 16:09:15 +0200
X-Gm-Features: ATxdqUGJV8NQ2lIF4yHvrAvfTHzCP3oWPQNnmcvk189nLOpryKh-e5mAJGhHZkg
Message-ID: <CAONkfw4AE7H1YDKVWAjrT5_eEAcgZ065Y0CdbV6On4QtHCN_sA@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, jjohnson@kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

This the full log :

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.6.86 (balsam@Ubuntu24x64)
(aarch64-openwrt-linux-musl-gcc (OpenWrt GCC 13.3.0 r28597-0425664679)
13.3.0, GNU ld (GNU Binutils) 2.42) #0 SMP Sun Apr 13 16:38:32 2025
[    0.000000] Machine model: LS1088A
[    0.000000] earlycon: uart8250 at MMIO 0x00000000021c0600 (options '')
[    0.000000] printk: bootconsole [uart8250] enabled
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000080000000-0x00000000fbdfffff]
[    0.000000] NUMA: NODE_DATA [mem 0xfb9f4980-0xfb9f6fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000fbdfffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000fbdfffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000fbdfffff]
[    0.000000] On node 0, zone DMA: 16896 pages in unavailable ranges
[    0.000000] cma: Reserved 512 MiB at 0x00000000d9800000 on node -1
[    0.000000] percpu: Embedded 20 pages/cpu s42600 r8192 d31128 u81920
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: root=/dev/mmcblk0p2 rw rootwait
earlycon=uart8250,mmio,0x21c0600 console=ttyS1,115200
[    0.000000] Dentry cache hash table entries: 262144 (order: 9,
2097152 bytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 499464
[    0.000000] Policy zone: DMA
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: SWIOTLB bounce buffer size adjusted to 1MB
[    0.000000] software IO TLB: area num 8.
[    0.000000] software IO TLB: mapped [mem
0x00000000d9400000-0x00000000d9600000] (2MB)
[    0.000000] Memory: 1444056K/2029568K available (12672K kernel
code, 1192K rwdata, 3476K rodata, 640K init, 352K bss, 61224K
reserved, 524288K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 10 jiffies.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000006100000
[    0.000000] ITS [mem 0x06020000-0x0603ffff]
[    0.000000] ITS@0x0000000006020000: allocated 65536 Devices
@80080000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x0000000080070000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table
@0x0000000080100000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 25.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x5c40939b5, max_idle_ns: 440795202646 ns
[    0.000000] sched_clock: 56 bits at 25MHz, resolution 40ns, wraps
every 4398046511100ns
[    0.008222] Console: colour dummy device 80x25
[    0.013887] Calibrating delay loop (skipped), value calculated
using timer frequency.. 50.00 BogoMIPS (lpj=250000)
[    0.024348] pid_max: default: 32768 minimum: 301
[    0.032161] Mount-cache hash table entries: 4096 (order: 3, 32768
bytes, linear)
[    0.039640] Mountpoint-cache hash table entries: 4096 (order: 3,
32768 bytes, linear)
[    0.049617] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.056260] RCU Tasks Trace: Setting shift to 3 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.065705] rcu: Hierarchical SRCU implementation.
[    0.070543] rcu: Max phase no-delay instances is 1000.
[    0.075958] Platform MSI: gic-its@6020000 domain created
[    0.081384] PCI/MSI: /interrupt-controller@6000000/gic-its@6020000
domain created
[    0.088987] fsl-mc MSI: gic-its@6020000 domain created
[    0.094477] smp: Bringing up secondary CPUs ...
[    0.099329] Detected VIPT I-cache on CPU1
[    0.099362] GICv3: CPU1: found redistributor 1 region 0:0x0000000006120000
[    0.099375] GICv3: CPU1: using allocated LPI pending table
@0x0000000080110000
[    0.099402] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.099723] Detected VIPT I-cache on CPU2
[    0.099748] GICv3: CPU2: found redistributor 2 region 0:0x0000000006140000
[    0.099760] GICv3: CPU2: using allocated LPI pending table
@0x0000000080120000
[    0.099779] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.100047] Detected VIPT I-cache on CPU3
[    0.100072] GICv3: CPU3: found redistributor 3 region 0:0x0000000006160000
[    0.100084] GICv3: CPU3: using allocated LPI pending table
@0x0000000080130000
[    0.100103] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.100429] Detected VIPT I-cache on CPU4
[    0.100477] GICv3: CPU4: found redistributor 100 region 0:0x0000000006180000
[    0.100490] GICv3: CPU4: using allocated LPI pending table
@0x0000000080140000
[    0.100521] CPU4: Booted secondary processor 0x0000000100 [0x410fd034]
[    0.100845] Detected VIPT I-cache on CPU5
[    0.100874] GICv3: CPU5: found redistributor 101 region 0:0x00000000061a0000
[    0.100886] GICv3: CPU5: using allocated LPI pending table
@0x0000000080150000
[    0.100906] CPU5: Booted secondary processor 0x0000000101 [0x410fd034]
[    0.101209] Detected VIPT I-cache on CPU6
[    0.101240] GICv3: CPU6: found redistributor 102 region 0:0x00000000061c0000
[    0.101252] GICv3: CPU6: using allocated LPI pending table
@0x0000000080160000
[    0.101272] CPU6: Booted secondary processor 0x0000000102 [0x410fd034]
[    0.101576] Detected VIPT I-cache on CPU7
[    0.101609] GICv3: CPU7: found redistributor 103 region 0:0x00000000061e0000
[    0.101621] GICv3: CPU7: using allocated LPI pending table
@0x0000000080170000
[    0.101640] CPU7: Booted secondary processor 0x0000000103 [0x410fd034]
[    0.101695] smp: Brought up 1 node, 8 CPUs
[    0.280508] SMP: Total of 8 processors activated.
[    0.285253] CPU features: detected: 32-bit EL0 Support
[    0.290437] CPU features: detected: CRC32 instructions
[    0.295676] CPU features: emulated: Privileged Access Never (PAN)
using TTBR0_EL1 switching
[    0.304109] CPU: All CPU(s) started at EL2
[    0.308243] alternatives: applying system-wide alternatives
[    0.318772] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.328716] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.347164] Machine: LS1088A
[    0.353525] SoC family: QorIQ LS1088A
[    0.357216] SoC ID: svr:0x87030110, Revision: 1.0
[    0.363533] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.370269] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.377497] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[    0.385436] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for
atomic allocations
[    0.393836] thermal_sys: Registered thermal governor 'step_wise'
[    0.393863] cpuidle: using governor menu
[    0.403975] ASID allocator initialised with 65536 entries
[    0.409866] Serial: AMBA PL011 UART driver
[    0.420132] fsl_mc_bus 80c000000.fsl-mc: MC firmware version: 10.39.0
[    0.434567] Modules: 28144 pages in range for non-PLT usage
[    0.434571] Modules: 519664 pages in range for PLT usage
[    0.440774] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.452993] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.459320] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.466177] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.472502] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.479356] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.485681] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.492534] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.499940] cryptd: max_cpu_qlen set to 1000
[    0.506149] raid6: skipped pq benchmark and selected neonx8
[    0.511773] raid6: using neon recovery algorithm
[    0.516797] iommu: Default domain type: Passthrough
[    0.521972] SCSI subsystem initialized
[    0.526206] imx-i2c 2000000.i2c: pinctrl unavailable, bus recovery
not supported
[    0.534437] pca953x 0-0020: supply vcc not found, using dummy regulator
[    0.541181] pca953x 0-0020: using no AI
[    0.585880] i2c i2c-0: IMX I2C adapter registered
[    0.590840] imx-i2c 2030000.i2c: pinctrl unavailable, bus recovery
not supported
[    0.598375] i2c i2c-1: IMX I2C adapter registered
[    0.603193] pps_core: LinuxPPS API ver. 1 registered
[    0.608201] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.617437] PTP clock support registered
[    0.622363] clocksource: Switched to clocksource arch_sys_counter
[    0.629898] VFS: Disk quotas dquot_6.6.0
[    0.634029] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.644553] NET: Registered PF_INET protocol family
[    0.649592] IP idents hash table entries: 32768 (order: 6, 262144
bytes, linear)
[    0.658953] tcp_listen_portaddr_hash hash table entries: 1024
(order: 2, 16384 bytes, linear)
[    0.667584] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
[    0.675414] TCP established hash table entries: 16384 (order: 5,
131072 bytes, linear)
[    0.683502] TCP bind hash table entries: 16384 (order: 7, 524288
bytes, linear)
[    0.691225] TCP: Hash tables configured (established 16384 bind 16384)
[    0.698151] MPTCP token hash table entries: 2048 (order: 3, 49152
bytes, linear)
[    0.705738] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.712540] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.719947] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.725695] PCI: CLS 0 bytes, default 64
[    0.731486] workingset: timestamp_bits=44 max_order=19 bucket_order=0
[    0.742678] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.749077] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME)
(CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    0.760288] fuse: init (API version 7.39)
[    0.764803] SGI XFS with ACLs, security attributes, realtime, no
debug enabled
[    0.775740] xor: measuring software checksum speed
[    0.781690]    8regs           :  2937 MB/sec
[    0.787209]    32regs          :  2943 MB/sec
[    0.792797]    arm64_neon      :  2746 MB/sec
[    0.797191] xor: using function: 32regs (2943 MB/sec)
[    0.802341] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 248)
[    0.810830] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.818418] dw-pcie 3400000.pcie: error -ENXIO: IRQ index 1 not found
[    0.824968] dw-pcie 3500000.pcie: error -ENXIO: IRQ index 1 not found
[    0.831502] dw-pcie 3600000.pcie: error -ENXIO: IRQ index 1 not found
[    0.838145] layerscape-pcie 3400000.pcie: host bridge
/soc/pcie@3400000 ranges:
[    0.845560] layerscape-pcie 3400000.pcie:       IO
0x2000010000..0x200001ffff -> 0x0000000000
[    0.854183] layerscape-pcie 3400000.pcie:      MEM
0x2040000000..0x207fffffff -> 0x0040000000
[    0.863192] layerscape-pcie 3400000.pcie: iATU: unroll F, 256 ob,
24 ib, align 4K, limit 4G
[    0.971840] layerscape-pcie 3400000.pcie: PCIe Gen.3 x1 link up
[    0.977987] layerscape-pcie 3400000.pcie: PCI host bridge to bus 0000:00
[    0.984760] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.990299] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.996542] pci_bus 0000:00: root bus resource [mem
0x2040000000-0x207fffffff] (bus address [0x40000000-0x7fffffff])
[    1.007199] pci 0000:00:00.0: [1957:80c1] type 01 class 0x060400
[    1.013274] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff]
[    1.019604] pci 0000:00:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
[    1.025938] pci 0000:00:00.0: reg 0x38: [mem 0x2048000000-0x2048ffffff pref]
[    1.033093] pci 0000:00:00.0: supports D1 D2
[    1.037400] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
[    1.044633] pci 0000:01:00.0: [17cb:1104] type 00 class 0x028000
[    1.050781] pci 0000:01:00.0: reg 0x10: [mem 0x2049000000-0x20491fffff 64bit]
[    1.058461] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    1.064960] pci 0000:01:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:00:00.0 (capable of 15.752
Gb/s with 8.0 GT/s PCIe x2 link)
[    1.080401] pci 0000:00:00.0: BAR 1: assigned [mem 0x2040000000-0x2043ffffff]
[    1.087616] pci 0000:00:00.0: BAR 0: assigned [mem 0x2044000000-0x2044ffffff]
[    1.094827] pci 0000:00:00.0: BAR 6: assigned [mem
0x2045000000-0x2045ffffff pref]
[    1.102477] pci 0000:00:00.0: BAR 14: assigned [mem
0x2046000000-0x20461fffff]
[    1.109772] pci 0000:01:00.0: BAR 0: assigned [mem
0x2046000000-0x20461fffff 64bit]
[    1.117546] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.122824] pci 0000:00:00.0:   bridge window [mem 0x2046000000-0x20461fffff]
[    1.130287] layerscape-pcie 3500000.pcie: host bridge
/soc/pcie@3500000 ranges:
[    1.137693] layerscape-pcie 3500000.pcie:       IO
0x2800010000..0x280001ffff -> 0x0000000000
[    1.146319] layerscape-pcie 3500000.pcie:      MEM
0x2840000000..0x287fffffff -> 0x0040000000
[    1.154965] layerscape-pcie 3500000.pcie: iATU: unroll F, 8 ob, 6
ib, align 4K, limit 4G
[    2.163247] layerscape-pcie 3500000.pcie: Phy link never came up
[    2.169382] layerscape-pcie 3500000.pcie: PCI host bridge to bus 0001:00
[    2.176159] pci_bus 0001:00: root bus resource [bus 00-ff]
[    2.181697] pci_bus 0001:00: root bus resource [io
0x10000-0x1ffff] (bus address [0x0000-0xffff])
[    2.190750] pci_bus 0001:00: root bus resource [mem
0x2840000000-0x287fffffff] (bus address [0x40000000-0x7fffffff])
[    2.201399] pci 0001:00:00.0: [1957:80c1] type 01 class 0x060400
[    2.207480] pci 0001:00:00.0: reg 0x38: [mem 0x2840000000-0x28400007ff pref]
[    2.214633] pci 0001:00:00.0: supports D1 D2
[    2.218941] pci 0001:00:00.0: PME# supported from D0 D1 D2 D3hot
[    2.226150] pci 0001:00:00.0: BAR 6: assigned [mem
0x2840000000-0x28400007ff pref]
[    2.233803] pci 0001:00:00.0: PCI bridge to [bus 01-ff]
[    2.239290] layerscape-pcie 3600000.pcie: host bridge
/soc/pcie@3600000 ranges:
[    2.246696] layerscape-pcie 3600000.pcie:       IO
0x3000010000..0x300001ffff -> 0x0000000000
[    2.255317] layerscape-pcie 3600000.pcie:      MEM
0x3040000000..0x307fffffff -> 0x0040000000
[    2.263963] layerscape-pcie 3600000.pcie: iATU: unroll F, 8 ob, 6
ib, align 4K, limit 4G
[    3.272239] layerscape-pcie 3600000.pcie: Phy link never came up
[    3.278397] layerscape-pcie 3600000.pcie: PCI host bridge to bus 0002:00
[    3.285171] pci_bus 0002:00: root bus resource [bus 00-ff]
[    3.290709] pci_bus 0002:00: root bus resource [io
0x20000-0x2ffff] (bus address [0x0000-0xffff])
[    3.299764] pci_bus 0002:00: root bus resource [mem
0x3040000000-0x307fffffff] (bus address [0x40000000-0x7fffffff])
[    3.310415] pci 0002:00:00.0: [1957:80c1] type 01 class 0x060400
[    3.316496] pci 0002:00:00.0: reg 0x38: [mem 0x3040000000-0x30400007ff pref]
[    3.323647] pci 0002:00:00.0: supports D1 D2
[    3.327954] pci 0002:00:00.0: PME# supported from D0 D1 D2 D3hot
[    3.335160] pci 0002:00:00.0: BAR 6: assigned [mem
0x3040000000-0x30400007ff pref]
[    3.342813] pci 0002:00:00.0: PCI bridge to [bus 01-ff]
[    3.348610] switchtec: loaded.
[    3.352606] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    3.360253] 21c0500.serial: ttyS0 at MMIO 0x21c0500 (irq = 18,
base_baud = 18750000) is a 16550A
[    3.369579] 21c0600.serial: ttyS1 at MMIO 0x21c0600 (irq = 18,
base_baud = 18750000) is a 16550A
[    3.378478] printk: console [ttyS1] enabled
[    3.378478] printk: console [ttyS1] enabled
[    3.386882] printk: bootconsole [uart8250] disabled
[    3.386882] printk: bootconsole [uart8250] disabled
[    3.397168] 21d0500.serial: ttyS2 at MMIO 0x21d0500 (irq = 19,
base_baud = 18750000) is a 16550A
[    3.406435] 21d0600.serial: ttyS3 at MMIO 0x21d0600 (irq = 19,
base_baud = 18750000) is a 16550A
[    3.418130] arm-smmu 5000000.iommu: probing hardware configuration...
[    3.424585] arm-smmu 5000000.iommu: SMMUv2 with:
[    3.429202] arm-smmu 5000000.iommu: stage 1 translation
[    3.434520] arm-smmu 5000000.iommu: stage 2 translation
[    3.439831] arm-smmu 5000000.iommu: nested translation
[    3.445062] arm-smmu 5000000.iommu: coherent table walk
[    3.450373] arm-smmu 5000000.iommu: (IDR0.CTTW overridden by FW
configuration)
[    3.457690] arm-smmu 5000000.iommu: stream matching with 128 register groups
[    3.464836] arm-smmu 5000000.iommu: 64 context banks (0 stage-2 only)
[    3.471368] arm-smmu 5000000.iommu: Supported page sizes: 0x61311000
[    3.477816] arm-smmu 5000000.iommu: Stage-1: 48-bit VA -> 48-bit IPA
[    3.484265] arm-smmu 5000000.iommu: Stage-2: 48-bit IPA -> 48-bit PA
[    3.491098] arm-smmu 5000000.iommu: preserved 0 boot mappings
[    3.497004] arm-smmu 5000000.iommu: Failed to disable prefetcher
for errata workarounds, check SACR.CACHE_LOCK
[    3.513091] brd: module loaded
[    3.518998] loop: module loaded
[    3.522289] at24 0-0050: supply vcc not found, using dummy regulator
[    3.529548] at24 0-0050: 256 byte 24c02 EEPROM, writable, 1 bytes/write
[    3.536249] at24 0-0057: supply vcc not found, using dummy regulator
[    3.543453] at24 0-0057: 32768 byte 24c256 EEPROM, writable, 1 bytes/write
[    3.550397] at24 0-0054: supply vcc not found, using dummy regulator
[    3.557490] at24 0-0054: 128 byte 24c01 EEPROM, writable, 1 bytes/write
[    3.564188] at24 0-005c: supply vcc not found, using dummy regulator
[    3.571289] at24 0-005c: 16 byte 24cs01 EEPROM, read-only
[    3.576811] at24 0-0055: supply vcc not found, using dummy regulator
[    3.583932] at24 0-0055: 128 byte 24c01 EEPROM, writable, 1 bytes/write
[    3.590613] at24 0-005d: supply vcc not found, using dummy regulator
[    3.597730] at24 0-005d: 16 byte 24cs01 EEPROM, read-only
[    3.603194] at24 0-0052: supply vcc not found, using dummy regulator
[    3.634251] at24 0-005a: supply vcc not found, using dummy regulator
[    3.667214] spi-nor spi0.0: mx25u51245g (65536 Kbytes)
[    3.672432] 7 fixed-partitions partitions found on MTD device 20c0000.spi-0
[    3.679399] Creating 7 MTD partitions on "20c0000.spi-0":
[    3.684818] 0x000000000000-0x000000100000 : "rcwpbi"
[    3.690138] 0x000000100000-0x000000400000 : "uboot"
[    3.695349] 0x000000400000-0x000000420000 : "env"
[    3.700343] 0x000000420000-0x000000440000 : "envbackup"
[    3.705876] 0x000000500000-0x000000800000 : "mcfw"
[    3.710964] 0x000000800000-0x000000900000 : "dpaadpc"
[    3.716353] 0x000000900000-0x000000a00000 : "dpaadpl"
[    3.723762] spi-nor spi0.1: mx25u51245g (65536 Kbytes)
[    3.746485] VFIO - User Level meta-driver version: 0.3
[    3.751821] mousedev: PS/2 mouse device common for all mice
[    3.758160] ftm-alarm 2800000.ftm0: registered as rtc0
[    3.763318] ftm-alarm 2800000.ftm0: setting system clock to
1970-01-01T00:00:03 UTC (3)
[    3.771481] i2c_dev: i2c /dev entries driver
[    3.777475] lm75 0-0048: supply vs not found, using dummy regulator
[    3.784546] hwmon hwmon2: temp1_input not attached to any thermal zone
[    3.791077] lm75 0-0048: hwmon2: sensor 'tmp1075'
[    3.795875] lm75 0-0049: supply vs not found, using dummy regulator
[    3.802866] hwmon hwmon3: temp1_input not attached to any thermal zone
[    3.809397] lm75 0-0049: hwmon3: sensor 'tmp1075'
[    3.814983] sp805-wdt c000000.wdt: registration successful
[    3.820601] sp805-wdt c010000.wdt: registration successful
[    3.826240] sp805-wdt c020000.wdt: registration successful
[    3.831835] sp805-wdt c030000.wdt: registration successful
[    3.837464] sp805-wdt c100000.wdt: registration successful
[    3.843078] sp805-wdt c110000.wdt: registration successful
[    3.848692] sp805-wdt c120000.wdt: registration successful
[    3.854326] sp805-wdt c130000.wdt: registration successful
[    3.860971] qoriq-cpufreq qoriq-cpufreq: Freescale QorIQ CPU
frequency scaling driver
[    3.869143] sdhci: Secure Digital Host Controller Interface driver
[    3.875351] sdhci: Copyright(c) Pierre Ossman
[    3.879705] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.891397] NET: Registered PF_INET6 protocol family
[    3.897078] Segment Routing with IPv6
[    3.900762] In-situ OAM (IOAM) with IPv6
[    3.904736] NET: Registered PF_PACKET protocol family
[    3.909888] 8021q: 802.1Q VLAN Support v1.8
[    3.911345] mmc0: SDHCI controller on 2140000.esdhc [2140000.esdhc]
using ADMA 64-bit
[    3.929195] Btrfs loaded, zoned=no, fsverity=no
[    3.964276] pcieport 0000:00:00.0: Adding to iommu group 1
[    3.969939] pcieport 0000:00:00.0: PME: Signaling with IRQ 355
[    3.975974] pcieport 0000:00:00.0: AER: enabled with IRQ 355
[    3.981934] pcieport 0001:00:00.0: Adding to iommu group 2
[    3.987568] pcieport 0001:00:00.0: PME: Signaling with IRQ 356
[    3.993712] pcieport 0001:00:00.0: AER: enabled with IRQ 356
[    3.999723] pcieport 0002:00:00.0: Adding to iommu group 3
[    4.005495] pcieport 0002:00:00.0: PME: Signaling with IRQ 357
[    4.011510] pcieport 0002:00:00.0: AER: enabled with IRQ 357
[    4.013522] mmc0: new HS200 MMC card at address 0001
[    4.022550] clk: Disabling unused clocks
[    4.022678] mmcblk0: mmc0:0001 DG4008 3.41 GiB
[    4.031462]  mmcblk0: p1 p2
[    4.034738] mmcblk0boot0: mmc0:0001 DG4008 4.00 MiB
[    4.040116] mmcblk0boot1: mmc0:0001 DG4008 4.00 MiB
[    4.045302] mmcblk0rpmb: mmc0:0001 DG4008 4.00 MiB, chardev (242:0)
[    4.054435] VFS: Mounted root (squashfs filesystem) readonly on device 179:2.
[    4.061759] Freeing unused kernel memory: 640K
[    4.066283] Run /sbin/init as init process
[    4.114179] init: Console is alive
[    4.117687] init: - watchdog -
[    4.364452] kmodloader: loading kernel modules from /etc/modules-boot.d/*
[    4.390309] usbcore: registered new interface driver usbfs
[    4.395855] usbcore: registered new interface driver hub
[    4.401221] usbcore: registered new device driver usb
[    4.418875] ahci-qoriq 3200000.sata: supply ahci not found, using
dummy regulator
[    4.426514] ahci-qoriq 3200000.sata: supply phy not found, using
dummy regulator
[    4.433958] ahci-qoriq 3200000.sata: supply target not found, using
dummy regulator
[    4.441768] ahci-qoriq 3200000.sata: AHCI 0001.0301 32 slots 1
ports 6 Gbps 0x1 impl platform mode
[    4.450753] ahci-qoriq 3200000.sata: flags: 64bit ncq sntf pm clo
only pmp fbs pio slum part ccc sds apst
[    4.462092] scsi host0: ahci-qoriq
[    4.465832] ata1: SATA max UDMA/133 mmio [mem
0x03200000-0x0320ffff] port 0x100 irq 358
[    4.804072] ata1: SATA link down (SStatus 0 SControl 300)
[    4.821497] dwc3 3110000.usb3: Configuration mismatch. dr_mode forced to host
[    4.833335] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    4.838865] xhci-hcd xhci-hcd.1.auto: new USB bus registered,
assigned bus number 1
[    4.846661] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220f66d hci
version 0x100 quirks 0x0000008002000010
[    4.856108] xhci-hcd xhci-hcd.1.auto: irq 359, io mem 0x03100000
[    4.862225] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    4.867721] xhci-hcd xhci-hcd.1.auto: new USB bus registered,
assigned bus number 2
[    4.875393] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    4.882585] hub 1-0:1.0: USB hub found
[    4.886372] hub 1-0:1.0: 1 port detected
[    4.890602] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    4.900236] hub 2-0:1.0: USB hub found
[    4.904079] hub 2-0:1.0: 1 port detected
[    4.908548] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[    4.914067] xhci-hcd xhci-hcd.2.auto: new USB bus registered,
assigned bus number 3
[    4.921821] xhci-hcd xhci-hcd.2.auto: hcc params 0x0220f66d hci
version 0x100 quirks 0x0000008002000010
[    4.931266] xhci-hcd xhci-hcd.2.auto: irq 360, io mem 0x03110000
[    4.937380] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[    4.942877] xhci-hcd xhci-hcd.2.auto: new USB bus registered,
assigned bus number 4
[    4.950541] xhci-hcd xhci-hcd.2.auto: Host supports USB 3.0 SuperSpeed
[    4.957806] hub 3-0:1.0: USB hub found
[    4.961622] hub 3-0:1.0: 1 port detected
[    4.966129] usb usb4: We don't know the algorithms for LPM for this
host, disabling LPM.
[    4.975595] hub 4-0:1.0: USB hub found
[    4.979369] hub 4-0:1.0: 1 port detected
[    4.986177] usbcore: registered new interface driver usb-storage
[    4.993156] usbcore: registered new interface driver uas
[    4.998583] kmodloader: done loading kernel modules from
/etc/modules-boot.d/*
[    5.011629] init: - preinit -
[    5.172427] usb 1-1: new full-speed USB device number 2 using xhci-hcd
[    5.522132] hub 1-1:1.0: USB hub found
[    5.526028] hub 1-1:1.0: 4 ports detected
[    5.862348] usb 1-1.3: new full-speed USB device number 3 using xhci-hcd
[    8.502352] random: crng init done
Cannot parse config file '/etc/fw_env.config': No such file or directory
Failed to find NVMEM device
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
[   12.680206] mount_root: loading kmods from internal overlay
[   12.702111] kmodloader: loading kernel modules from //etc/modules-boot.d/*
[   12.711573] kmodloader: done loading kernel modules from
//etc/modules-boot.d/*
[   12.948401] block: attempting to load /tmp/overlay/upper/etc/config/fstab
[   12.955298] block: unable to load configuration (fstab: Entry not found)
[   12.962042] block: attempting to load /tmp/overlay/etc/config/fstab
[   12.968439] block: unable to load configuration (fstab: Entry not found)
[   12.975249] block: attempting to load /etc/config/fstab
[   12.982250] block: unable to load configuration (fstab: Entry not found)
[   12.989100] block: no usable configuration
[   12.993388] block: attempting to load /etc/config/fstab
[   12.998670] block: unable to load configuration (fstab: Entry not found)
[   13.005674] block: no usable configuration
[   13.010415] loop0: detected capacity change from 0 to 1964032
[   13.072398] loop0: detected capacity change from 1964032 to 1848960
[   13.231491] F2FS-fs (loop0): Mounted with checkpoint version = 11ebb934
[   13.238778] mount_root: loading kmods from internal overlay
[   13.276732] kmodloader: loading kernel modules from
/tmp/overlay/upper/etc/modules-boot.d/*
[   13.285279] kmodloader: done loading kernel modules from
/tmp/overlay/upper/etc/modules-boot.d/*
[   13.479047] block: attempting to load /tmp/overlay/upper/etc/config/fstab
[   13.486483] block: extroot: not configured
[   13.490787] block: attempting to load /etc/config/fstab
[   13.496084] block: unable to load configuration (fstab: Entry not found)
[   13.502839] block: no usable configuration
[   13.508167] mount_root: switching to f2fs overlay
[   13.515852] overlayfs: null uuid detected in lower fs '/', falling
back to xino=off,index=off,nfs_export=off.
[   13.534385] urandom-seed: Seeding with /etc/urandom.seed
[   13.556565] procd: - early -
[   13.559645] procd: - watchdog -
Failed to connect to ubus
[   14.104552] procd: - watchdog -
[   14.108020] procd: - ubus -
[   14.464339] procd: - init -
Please press Enter to activate this console.
[   14.780942] kmodloader: loading kernel modules from /etc/modules.d/*
[   14.947639] urngd: v1.0.2 started.
[   14.986252] NET: Registered PF_ALG protocol family
[   14.996186] zram: Added device: zram0
[   15.006968] cryptodev: loading out-of-tree module taints kernel.
[   15.013690] cryptodev: driver 1.13 loaded.
[   15.030677] hid: raw HID events driver (C) Jiri Kosina
[   15.041452] ntfs3: Enabled Linux POSIX ACLs support
[   15.058608] usbcore: registered new interface driver cdc_acm
[   15.064356] cdc_acm: USB Abstract Control Model driver for USB
modems and ISDN adapters
[   15.073042] Loading modules backported from Linux version
v6.12.6-0-ge9d65b48ce1a
[   15.080529] Backport generated by backports.git v6.1.110-1-35-g410656ef04d2
[   15.090962] hwmon hwmon6: temp1_input not attached to any thermal zone
[   15.114561] NET: Registered PF_QIPCRTR protocol family
[   15.126791] usbcore: registered new interface driver ums-alauda
[   15.133322] usbcore: registered new interface driver ums-cypress
[   15.140005] usbcore: registered new interface driver ums-datafab
[   15.146641] usbcore: registered new interface driver ums-freecom
[   15.153306] usbcore: registered new interface driver ums-isd200
[   15.159905] usbcore: registered new interface driver ums-jumpshot
[   15.166631] usbcore: registered new interface driver ums-karma
[   15.173304] usbcore: registered new interface driver ums-sddr09
[   15.179907] usbcore: registered new interface driver ums-sddr55
[   15.186585] usbcore: registered new interface driver ums-usbat
[   15.194209] usbcore: registered new interface driver usbhid
[   15.199782] usbhid: USB HID core driver
[   15.209047] usbcore: registered new interface driver usbserial_generic
[   15.215627] usbserial: USB Serial support registered for generic
[   15.222272] usbcore: registered new interface driver cdc_eem
[   15.228714] usbcore: registered new interface driver cdc_ether
[   15.235034] usbcore: registered new interface driver cdc_subset
[   15.251902] usbcore: registered new interface driver ch341
[   15.257471] usbserial: USB Serial support registered for ch341-uart
[   15.264747] usbcore: registered new interface driver ch348
[   15.270288] usbserial: USB Serial support registered for ch348
[   15.277751] usbcore: registered new interface driver ftdi_sio
[   15.283548] usbserial: USB Serial support registered for FTDI USB
Serial Device
[   15.290960] ftdi_sio 1-1.3:1.0: FTDI USB Serial Device converter detected
[   15.297835] usb 1-1.3: Detected FT-X
[   15.302017] usb 1-1.3: FTDI USB Serial Device converter now
attached to ttyUSB0
[   15.360863] usbcore: registered new interface driver rndis_host
[   15.381056] ath11k_pci 0000:01:00.0: Adding to iommu group 1
[   15.386952] ath11k_pci 0000:01:00.0: BAR 0: assigned [mem
0x2046000000-0x20461fffff 64bit]
[   15.395924] ath11k_pci 0000:01:00.0: MSI vectors: 16
[   15.400914] ath11k_pci 0000:01:00.0: qcn9074 hw1.0
[   15.405711] ath11k_pci 0000:01:00.0: FW memory mode: 2
[   15.603445] mhi mhi0: Requested to power ON
[   15.607667] mhi mhi0: Power on setup success
[   15.761571] mhi mhi0: Wait for device to enter SBL or Mission mode
[   15.812946] kmodloader: done loading kernel modules from /etc/modules.d/*
[   15.829003] ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0x0
board_id 0xff soc_id 0xffffffff
[   15.837832] ath11k_pci 0000:01:00.0: fw_version 0x290b8862
fw_build_timestamp 2024-09-23 10:51 fw_build_id
[   16.795763] zram0: detected capacity change from 0 to 1048576
[   16.815733] Adding 524284k swap on /dev/zram0.  Priority:100
extents:1 across:524284k SSDsc
[   17.585228] ath11k_pci 0000:01:00.0: htt event 48 not handled
[   22.232053] ath11k_pci 0000:01:00.0 phy0-ap0: entered allmulticast mode
[   22.238825] ath11k_pci 0000:01:00.0 phy0-ap0: entered promiscuous mode
[   22.247742] ath11k_pci 0000:01:00.0 phy0-ap0: left allmulticast mode
[   22.254126] ath11k_pci 0000:01:00.0 phy0-ap0: left promiscuous mode
[   22.686293] ath11k_pci 0000:01:00.0 phy0-ap0: entered allmulticast mode
[   22.693100] ath11k_pci 0000:01:00.0 phy0-ap0: entered promiscuous mode
[   30.707271] ath11k_pci 0000:01:00.0 phy0-ap0: left allmulticast mode
[   30.713689] ath11k_pci 0000:01:00.0 phy0-ap0: left promiscuous mode
[   35.762281] ath11k_pci 0000:01:00.0 phy0-ap0: entered allmulticast mode
[   35.769106] ath11k_pci 0000:01:00.0 phy0-ap0: entered promiscuous mode

BusyBox v1.36.1 (2025-04-13 16:38:32 UTC) built-in shell (ash)
Enter 'help' for a list of built-in commands.

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 OpenWrt 24.10.1, r28597-0425664679
 -----------------------------------------------------

root@OpenWrt-WAP:~#
root@OpenWrt-WAP:~# dmesg | grep ath

[   15.381056] ath11k_pci 0000:01:00.0: Adding to iommu group 1
[   15.386765] ath11k_pci 0000:01:00.0: assign IRQ: got 0
[   15.386952] ath11k_pci 0000:01:00.0: BAR 0: assigned [mem
0x2046000000-0x20461fffff 64bit]
[   15.395319] ath11k_pci 0000:01:00.0: boot pci_mem 0x000000004105ef01
[   15.395327] ath11k_pci 0000:01:00.0: boot pci probe 17cb:1104 17cb:1104
[   15.395924] ath11k_pci 0000:01:00.0: MSI vectors: 16
[   15.400907] ath11k_pci 0000:01:00.0: pci msi base data is 0
[   15.400914] ath11k_pci 0000:01:00.0: qcn9074 hw1.0
[   15.405711] ath11k_pci 0000:01:00.0: FW memory mode: 2
[   15.412307] ath11k_pci 0000:01:00.0: boot failed to load firmware-2.bin: -2
[   15.412326] ath11k_pci 0000:01:00.0: boot using fw api 1
[   15.412351] ath11k_pci 0000:01:00.0: pci msi assignment MHI
num_vectors 3 user_base_data 0 base_vector 0
[   15.412360] ath11k_pci 0000:01:00.0: pci num_vectors 3 base_vector 0
[   15.414427] ath11k_pci 0000:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   15.414575] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   15.414605] ath11k_pci 0000:01:00.0: pci irq 369 group 0
[   15.414653] ath11k_pci 0000:01:00.0: pci irq 370 group 1
[   15.414701] ath11k_pci 0000:01:00.0: pci irq 371 group 2
[   15.414748] ath11k_pci 0000:01:00.0: pci irq 372 group 3
[   15.414795] ath11k_pci 0000:01:00.0: pci irq 373 group 4
[   15.414843] ath11k_pci 0000:01:00.0: pci irq 374 group 5
[   15.414896] ath11k_pci 0000:01:00.0: pci irq 375 group 6
[   15.414944] ath11k_pci 0000:01:00.0: pci irq 376 group 7
[   15.415006] ath11k_pci 0000:01:00.0: pci after request_irq msi_ep_base_data 0
[   15.515100] ath11k_pci 0000:01:00.0: pci ltssm 0x111
[   15.515118] ath11k_pci 0000:01:00.0: pci pcie_hot_rst 0x11
[   15.520162] ath11k_pci 0000:01:00.0: pci pcie_q6_cookie_addr 0x0
[   15.520176] ath11k_pci 0000:01:00.0: pci wlaon_warm_sw_entry 0x0
[   15.540191] ath11k_pci 0000:01:00.0: pci wlaon_warm_sw_entry 0x0
[   15.540206] ath11k_pci 0000:01:00.0: pci soc reset cause 0
[   15.560216] ath11k_pci 0000:01:00.0: pci mhistatus 0xff04
[   15.570232] ath11k_pci 0000:01:00.0: pci link_ctl 0x0000 L0s 0 L1 0
[   15.761784] ath11k_pci 0000:01:00.0: boot notify status reason
MHI_CB_EE_SBL_MODE
[   15.810048] ath11k_pci 0000:01:00.0: boot notify status reason
MHI_CB_EE_MISSION_MODE
[   15.829003] ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0x0
board_id 0xff soc_id 0xffffffff
[   15.837832] ath11k_pci 0000:01:00.0: fw_version 0x290b8862
fw_build_timestamp 2024-09-23 10:51 fw_build_id
[   15.847603] ath11k_pci 0000:01:00.0: boot using board name
'bus=pci,qmi-chip-id=0,qmi-board-id=255'
[   15.873000] ath11k_pci 0000:01:00.0: boot firmware request
ath11k/QCN9074/hw1.0/board-2.bin size 786836
[   15.873031] ath11k_pci 0000:01:00.0: boot board name
[   15.873046] ath11k_pci 0000:01:00.0: 00000000: 62 75 73 3d 70 63 69
2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[   15.873058] ath11k_pci 0000:01:00.0: 00000010: 2d 69 64 3d 30 2c 71
6d 69 2d 62 6f 61 72 64 2d  -id=0,qmi-board-
[   15.873070] ath11k_pci 0000:01:00.0: 00000020: 69 64 3d 31 36 30
                            id=160
[   15.873080] ath11k_pci 0000:01:00.0: boot board name
[   15.873092] ath11k_pci 0000:01:00.0: 00000000: 62 75 73 3d 70 63 69
2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[   15.873104] ath11k_pci 0000:01:00.0: 00000010: 2d 69 64 3d 30 2c 71
6d 69 2d 62 6f 61 72 64 2d  -id=0,qmi-board-
[   15.873116] ath11k_pci 0000:01:00.0: 00000020: 69 64 3d 31 36 31
                            id=161
[   15.873126] ath11k_pci 0000:01:00.0: boot board name
[   15.873137] ath11k_pci 0000:01:00.0: 00000000: 62 75 73 3d 70 63 69
2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[   15.873149] ath11k_pci 0000:01:00.0: 00000010: 2d 69 64 3d 30 2c 71
6d 69 2d 62 6f 61 72 64 2d  -id=0,qmi-board-
[   15.873160] ath11k_pci 0000:01:00.0: 00000020: 69 64 3d 31 36 32
                            id=162
[   15.873170] ath11k_pci 0000:01:00.0: boot board name
[   15.873182] ath11k_pci 0000:01:00.0: 00000000: 62 75 73 3d 70 63 69
2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[   15.873194] ath11k_pci 0000:01:00.0: 00000010: 2d 69 64 3d 30 2c 71
6d 69 2d 62 6f 61 72 64 2d  -id=0,qmi-board-
[   15.873205] ath11k_pci 0000:01:00.0: 00000020: 69 64 3d 32 35 35
                            id=255
[   15.873215] ath11k_pci 0000:01:00.0: boot found match board data
for name 'bus=pci,qmi-chip-id=0,qmi-board-id=255'
[   15.873227] ath11k_pci 0000:01:00.0: boot found board data for
'bus=pci,qmi-chip-id=0,qmi-board-id=255'
[   15.873239] ath11k_pci 0000:01:00.0: boot using board api 2
[   17.241466] ath11k_pci 0000:01:00.0: boot firmware request
ath11k/QCN9074/hw1.0/m3.bin size 340108
[   17.264811] ath11k_pci 0000:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   17.264839] ath11k_pci 0000:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   17.264851] ath11k_pci 0000:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   17.264863] ath11k_pci 0000:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   17.264874] ath11k_pci 0000:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   17.264883] ath11k_pci 0000:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   17.264899] ath11k_pci 0000:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   17.264911] ath11k_pci 0000:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   17.266709] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.266722] ath11k_pci 0000:01:00.0: pci ring not part of an
ext_group; ring_type: 11,ring_num 0
[   17.268976] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.268994] ath11k_pci 0000:01:00.0: pci ring not part of an
ext_group; ring_type: 12,ring_num 0
[   17.269007] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.269014] ath11k_pci 0000:01:00.0: pci ring not part of an
ext_group; ring_type: 6,ring_num 0
[   17.269024] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.269031] ath11k_pci 0000:01:00.0: pci ring not part of an
ext_group; ring_type: 7,ring_num 0
[   17.269903] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.269915] ath11k_pci 0000:01:00.0: pci ring not part of an
ext_group; ring_type: 5,ring_num 0
[   17.270968] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.271495] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.271504] ath11k_pci 0000:01:00.0: pci ring not part of an
ext_group; ring_type: 5,ring_num 1
[   17.273053] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.274196] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.274205] ath11k_pci 0000:01:00.0: pci ring not part of an
ext_group; ring_type: 5,ring_num 2
[   17.275229] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.275397] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.275404] ath11k_pci 0000:01:00.0: pci ring not part of an
ext_group; ring_type: 2,ring_num 0
[   17.275572] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.276238] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.276937] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.276946] ath11k_pci 0000:01:00.0: pci ring not part of an
ext_group; ring_type: 3,ring_num 0
[   17.277173] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.277462] ath11k_pci 0000:01:00.0: boot htc service 'Control' ul
pipe 0 dl pipe 1 eid 0 ready
[   17.277470] ath11k_pci 0000:01:00.0: boot htc service 'Control' eid
0 tx flow control disabled
[   17.278587] ath11k_pci 0000:01:00.0: boot htc service HTT Data does
not allocate target credits
[   17.278701] ath11k_pci 0000:01:00.0: boot htc service 'HTT Data' ul
pipe 4 dl pipe 1 eid 1 ready
[   17.278708] ath11k_pci 0000:01:00.0: boot htc service 'HTT Data'
eid 1 tx flow control disabled
[   17.278762] ath11k_pci 0000:01:00.0: boot htc service 'WMI' ul pipe
3 dl pipe 2 eid 2 ready
[   17.278770] ath11k_pci 0000:01:00.0: boot htc service 'WMI' eid 2
tx flow control disabled
[   17.280107] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.281401] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.282052] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.283009] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.585228] ath11k_pci 0000:01:00.0: htt event 48 not handled
[   17.591124] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.591847] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.592178] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.592382] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.592391] ath11k_pci 0000:01:00.0: pci ring not part of an
ext_group; ring_type: 16,ring_num 0
[   17.592652] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.592925] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.592942] ath11k_pci 0000:01:00.0: pci ring not part of an
ext_group; ring_type: 19,ring_num 0
[   17.617200] ath11k_pci 0000:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.617220] ath11k_pci 0000:01:00.0: pci ring not part of an
ext_group; ring_type: 20,ring_num 0
[   17.619111] ath11k_pci 0000:01:00.0: pci ext irq 372
[   17.619602] ath11k_pci 0000:01:00.0: pci ext irq 372
[   22.232053] ath11k_pci 0000:01:00.0 phy0-ap0: entered allmulticast mode
[   22.238825] ath11k_pci 0000:01:00.0 phy0-ap0: entered promiscuous mode
[   22.247742] ath11k_pci 0000:01:00.0 phy0-ap0: left allmulticast mode
[   22.254126] ath11k_pci 0000:01:00.0 phy0-ap0: left promiscuous mode
[   22.686293] ath11k_pci 0000:01:00.0 phy0-ap0: entered allmulticast mode
[   22.693100] ath11k_pci 0000:01:00.0 phy0-ap0: entered promiscuous mode
[   30.707271] ath11k_pci 0000:01:00.0 phy0-ap0: left allmulticast mode
[   30.713689] ath11k_pci 0000:01:00.0 phy0-ap0: left promiscuous mode
[   35.762281] ath11k_pci 0000:01:00.0 phy0-ap0: entered allmulticast mode
[   35.769106] ath11k_pci 0000:01:00.0 phy0-ap0: entered promiscuous mode

root@OpenWrt-WAP:~# iw dev
phy#0
Interface phy0-ap0
ifindex 15
wdev 0x2
addr 04:f0:21:bd:d7:ab
ssid OpenWrt-WAP
type AP
channel 36 (5180 MHz), width: 160 MHz, center1: 5250 MHz
txpower 23.00 dBm
multicast TXQ:
qsz-byt qsz-pkt flows drops marks overlmt hashcol tx-bytes tx-packets
0 0 30 0 0 0 0 4375 30

root@OpenWrt-WAP:~# iwinfo
phy0-ap0  ESSID: "OpenWrt-WAP"
          Access Point: 04:F0:21:BD:D7:AB
          Mode: Master  Channel: 36 (5.180 GHz)  HT Mode: HE160
          Center Channel 1: 50 2: unknown
          Tx-Power: 23 dBm  Link Quality: unknown/70
          Signal: unknown  Noise: -113 dBm
          Bit Rate: unknown
          Encryption: none
          Type: nl80211  HW Mode(s): 802.11ac/ax/n
          Hardware: 17CB:1104 17CB:1104 [Qualcomm Atheros QCN6024/9024/9074]
          TX power offset: none
          Frequency offset: none
          Supports VAPs: yes  PHY name: phy0

root@OpenWrt-WAP:~# reboot
root@OpenWrt-WAP:~#

[   55.840281] ath11k_pci 0000:01:00.0 phy0-ap0: left allmulticast mode
[   55.846686] ath11k_pci 0000:01:00.0 phy0-ap0: left promiscuous mode
[   62.123928] Internal error: synchronous external abort:
0000000096000210 [#1] SMP
[   62.131431] Modules linked in: ... ath11k_pci(O) ath11k(O) ...
[   62.302873] CPU: 0 PID: 9134 Comm: procd Tainted: G           O
  6.6.86 #0
[   62.310187] Hardware name: LS1088A
[   62.317410] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   62.324374] pc : ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
[   62.330567] lr : ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
[   62.336511] sp : ffff80008cf3bb60
[   62.339821] x29: ffff80008cf3bb60 x28: ffff000006ce1900 x27: ffff0000008d3138
[   62.346965] x26: ffff800080f20128 x25: ffff8000811b0028 x24: 0000000000000000
[   62.354107] x23: 0000000000000001 x22: ffff0000072bade8 x21: ffff800079b41be4
[   62.361248] x20: ffff0000072b0000 x19: ffff800083c80500 x18: 0000000000000000
[   62.368390] x17: 0000000000000000 x16: 0000000000000000 x15: 0026d1bd2208a368
[   62.375532] x14: ffff000003697c1c x13: ffff800081113d10 x12: 0000000000000169
[   62.382674] x11: ffff800080d63a68 x10: 1fffe000006d2d01 x9 : 0000000000000000
[   62.389816] x8 : ffff000003696800 x7 : ffff7ffffa8d4000 x6 : 0000000000095346
[   62.396958] x5 : ffff7ffffa8d4000 x4 : 000000000007ffff x3 : 0000000000000000
[   62.404101] x2 : 000000000000003f x1 : ffff0000072bad58 x0 : ffff800083c00000
[   62.411243] Call trace:
[   62.413684]  ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
[   62.419524]  ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
[   62.425114]  ath11k_pcic_read32+0x30/0xb4 [ath11k]
[   62.429921]  ath11k_pci_get_msi_irq+0x528/0x1900 [ath11k_pci]
[   62.435673]  ath11k_pci_get_msi_irq+0x1460/0x1900 [ath11k_pci]
[   62.441512]  ath11k_pci_get_msi_irq+0x1750/0x1900 [ath11k_pci]
[   62.447350]  pci_device_shutdown+0x34/0x44
[   62.451449]  device_shutdown+0x160/0x268
[   62.455373]  kernel_restart+0x40/0xc0
[   62.459039]  __do_sys_reboot+0x104/0x23c
[   62.462963]  __arm64_sys_reboot+0x24/0x30
[   62.466974]  do_el0_svc+0x6c/0x100
[   62.470377]  el0_svc+0x28/0x9c
[   62.473432]  el0t_64_sync_handler+0x120/0x12c
[   62.477789]  el0t_64_sync+0x178/0x17c
[   62.481454] Code: f94e0a80 92404a73 91420273 8b130013 (b9400273)
[   62.487547] ---[ end trace 0000000000000000 ]---
[   62.492162] Kernel panic - not syncing: synchronous external abort:
Fatal exception in interrupt
[   62.500959] Kernel Offset: disabled
[   62.504442] CPU features: 0x0,00000000,00020000,1000400b
[   62.509753] Memory Limit: none
[   62.512803] Rebooting in 3 seconds..

