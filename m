Return-Path: <linux-wireless+bounces-12895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC74E97A7D0
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 21:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9401F23ED3
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 19:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5EC6A33A;
	Mon, 16 Sep 2024 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNfCj0Cg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17BB1BDC8;
	Mon, 16 Sep 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726515199; cv=none; b=eNENq58uk62HDXBtTMSBZmNH6yG5iqkoe3KreS3dwGHfHRPy25qN0dNvPI5qdKSCPuw2zZUQjLkHNWvQYMOkifuUMEsuWYCxbitwETkA1jxUjnY+n8SaWoscn7hgp0pVGA8D8VYWTDXETZAtl0LLbWt/RUhCA3r1XCOn+ZR+Ho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726515199; c=relaxed/simple;
	bh=4HhMzxJSxDV0HyIZDLemcqMV3spteuSwgerTwMNVG2o=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=l4PpIbBq2JYzBM33rSY2r6mdEP1g/EuUmlG+FaER75ipOYo0eUljzUjnlNQ7BNBsgtyT1BiN98Ge/P1gywscwTPRaWsBxIhWaUcYrqQTxTV77wawlHNP+ZTuN4O15+OLWIu4Mv7TMlm5qNZGgIB6J/sVxIHHj3t7S6Ahp1Be8Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNfCj0Cg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so40253195e9.0;
        Mon, 16 Sep 2024 12:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726515193; x=1727119993; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UDLRgk/3jXaHHQ2ZXBT9H12Kzqo8iOAp1vwUYj+nBQ=;
        b=BNfCj0CgAzsivmdoaq43ieCfsc6IlbVIgi6fERySljXt8ZdC+evVhz2TSGgEvFGWz7
         VF0XWmlCtPRn8ocfQ+OiBWns3lHOwkIT4zmIxjXq7+xq5ep2yFsOk4Ro5DizYtHAPYiS
         ZwKGilR6VkPIgRssqi/E9y1PnFCRVo+Jb5XmC0S1wcZTTHvTaf2Fs7+x7diOiZTQM8Rk
         inAUih7A1P2FjtStMydHLKFdUG+Faykg2Hg2BlF0N0phpQgtJImNTLnkIIOHK3qooV3g
         Z0j/o2V6uPmiOJCPJOqR6UeFNNcyu7wBED7Rn1lyWF2nF6shSeInbw6HCQ/QeKY+CqxL
         fN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726515193; x=1727119993;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6UDLRgk/3jXaHHQ2ZXBT9H12Kzqo8iOAp1vwUYj+nBQ=;
        b=P517Wz4tGkZV7fcWLLZ5yJQGIIfzkZ3PGdR8JGpEoFb4VPZWNkSth86ABfIlPEZ/b6
         unaf33+OrRuaf/shP04Um2VKdiKXLGR2d13Zx3cH2HUcRFlq2Zhl6kxy0NR1Kttw5Gc3
         5QFBDBdS8B4/Xh4fG/ImbZ45dsf/KICbfyqX5ik3h0CYTgBb7z/Kq7U4p95ypi//SSTX
         MU8vQEtMqTEtvI/PAzLoGMNBMDmVyonqDu5JW+mpRdu3jUyjktvJoPdGqVImOOaI4Go5
         yF/ToPQ7Odr3+Z3kCxS2fWCaflev5zf37mNNWEucqYIwrh0HYZQMfkbrzRviEord8Hwb
         IAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTB+W5KlwYuiDChou8mx+6LXdFR0IBoRqFi2Qw8KCfhA8ydHdjUGYzxpQn9RAtsenvouD1siPNOutTo7tMX1w=@vger.kernel.org, AJvYcCVcB50SEhlIAjz/ItrJeTVTVBYfupAp9YDzqKj4UwaqrWJfA74KPS/Jue8ZdVa34G1kRWEvZ+AeeJf7Nwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5uZAdLlytagj9kP1KLli8Yyfg1aoZg+5CoPOL3LQH55beKTu9
	PzWMTvAQkKlU+21uGQZ+qeu1FPa87cNDVjNSsXd7dpv8NvgSTuDa
X-Google-Smtp-Source: AGHT+IFdnkoPDxZwq4yCMOc5Aoq4xfEErnIgzmvofZQ+o6eFlUVxv3VGkouUJ3C2/ph4zNLaQ4qMHA==
X-Received: by 2002:a05:600c:3b15:b0:42c:bb41:a079 with SMTP id 5b1f17b1804b1-42cdb531bd4mr125587955e9.1.1726515192081;
        Mon, 16 Sep 2024 12:33:12 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73d8f78sm7816834f8f.22.2024.09.16.12.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 12:33:11 -0700 (PDT)
Message-ID: <144fbf79-950c-4cd1-bc68-4e00b47b03e9@gmail.com>
Date: Mon, 16 Sep 2024 22:33:08 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, tr, en-GB
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Deren Wu
 <deren.wu@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Kalle Valo <kvalo@kernel.org>,
 Ma Ke <make24@iscas.ac.cn>
Subject: BUG and WARNINGs from mt7921s on next-20240916
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I ran into some bug messages while testing linux-next on a MT8186
Magneton Chromebook (mt8186-corsola-magneton-sku393218). It boots 
to the OS, but at least Wi-Fi and Bluetooth are unavailable.

As a start, I tried reverting commit abbd838c579e ("Merge tag 
'mt76-for-kvalo-2024-09-06' of https://github.com/nbd168/wireless")
and it works fine after that. Didn't have time to do a full bisect, 
but will try if nobody has any immediate opinions.

There are a few traces, here's some select lines to catch your attention,
not sure how informational they are:

[   16.040525] kernel BUG at net/core/skbuff.c:2268!
[   16.040531] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[   16.040803] CPU: 3 UID: 0 PID: 526 Comm: mt76-sdio-txrx  Not tainted 6.11.0-next-20240916-deb-00002-g7b544e01c649 #1
[   16.040897] Call trace:
[   16.040899]  pskb_expand_head+0x2b0/0x3c0
[   16.040905]  mt76s_tx_run_queue+0x274/0x410 [mt76_sdio]
[   16.040909]  mt76s_txrx_worker+0xe4/0xac8 [mt76_sdio]
[   16.040914]  mt7921s_txrx_worker+0x98/0x1e0 [mt7921s]
[   16.040924]  __mt76_worker_fn+0x80/0x128 [mt76]
[   16.040934]  kthread+0xe8/0xf8
[   16.040940]  ret_from_fork+0x10/0x20

[   16.046045] note: mt76-sdio-txrx [526] exited with irqs disabled

[   16.805325] WARNING: CPU: 3 PID: 0 at kernel/context_tracking.c:128 ct_kernel_exit.isra.0+0xa0/0xa8
[   16.805630] Tainted: [D]=DIE

[   19.050110] mt7921s mmc1:0001:1: Message 00000010 (seq 1) timeout
[   19.062383] mt7921s mmc1:0001:1: Failed to get patch semaphore

[   24.171397] WARNING: CPU: 7 PID: 54 at kernel/kthread.c:76 kthread_park+0x8c/0xe0
[   24.623719] Tainted: [D]=DIE, [W]=WARN
[   24.641302] Workqueue: events mt7921_init_work [mt7921_common]
[   24.834560] Call trace:
[   24.839437]  kthread_park+0x8c/0xe0
[   24.846405]  mt7921s_init_reset+0x8c/0x248 [mt7921s]
[   24.856329]  mt7921_init_work+0xcc/0x228 [mt7921_common]
[   24.866950]  process_one_work+0x178/0x3d0
[   24.874962]  worker_thread+0x200/0x3f0
[   24.882452]  kthread+0xe8/0xf8
[   24.888550]  ret_from_fork+0x10/0x20

[   24.904974] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[   25.032335] Internal error: Oops: 0000000096000004 [#2] SMP

I'm pasting the full log below with some more data. (Though I get 
duplicate output from serial console, and had to sort -n | uniq, 
hoping it didn't mess up anything).

------ 8< ------

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd050]
[    0.000000] Linux version 6.11.0-next-20240916-deb-00002-g7b544e01c649 (alpernebbi@ALPER-PC) (aarch64-linux-gnu-gcc (Debian 14.2.0-1) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP Mon Sep 16 17:42:49 +03 2024
[    0.000000] KASLR enabled
[    0.000000] random: crng init done
[    0.000000] Machine model: Google Magneton board
[    0.000000] printk: debug: skip boot console de-registration.
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000050000000, size 16 MiB
[    0.000000] OF: reserved mem: initialized node memory@50000000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000050000000..0x000000005109ffff (17024 KiB) nomap non-reusable memory@50000000
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000060000000, size 16 MiB
[    0.000000] OF: reserved mem: initialized node memory@60000000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000060000000..0x0000000060ffffff (16384 KiB) nomap non-reusable memory@60000000
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000061000000, size 1 MiB
[    0.000000] OF: reserved mem: initialized node memory@61000000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000061000000..0x00000000610fffff (1024 KiB) nomap non-reusable memory@61000000
[    0.000000] OF: reserved mem: 0x00000000ffec5000..0x00000000fffc4fff (1024 KiB) map non-reusable ramoops
[    0.000000] earlycon: mtk8250 at MMIO32 0x0000000011002000 (options '115200n8')
[    0.000000] printk: legacy bootconsole [mtk8250] enabled
[    0.000000] NUMA: Faking a node at [mem 0x0000000040000000-0x000000013fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x13f7a8ec0-0x13f7abc7f]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x000000004fffffff]
[    0.000000]   node   0: [mem 0x0000000050000000-0x000000005109ffff]
[    0.000000]   node   0: [mem 0x00000000510a0000-0x00000000545fffff]
[    0.000000]   node   0: [mem 0x0000000054700000-0x000000005fffffff]
[    0.000000]   node   0: [mem 0x0000000060000000-0x00000000610fffff]
[    0.000000]   node   0: [mem 0x0000000061100000-0x0000000069ffffff]
[    0.000000]   node   0: [mem 0x000000006a100000-0x00000000ffdfffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000013fffffff]
[    0.000000] On node 0, zone DMA: 256 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 256 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 512 pages in unavailable ranges
[    0.000000] cma: Reserved 64 MiB at 0x00000000fbe00000 on node -1
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 34 pages/cpu s100568 r8192 d30504 u139264
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 1530923
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: cros_secure kern_guid=882c31a2-0695-4426-94bd-abb0f691866e earlycon keep_bootcon splash plymouth.ignore-serial-consoles ipv6.disable=1 root=UUID=c16826e5-0b66-4648-87db-8a2601010f0a
[    0.000000] Unknown kernel command line parameters "cros_secure splash kern_guid=882c31a2-0695-4426-94bd-abb0f691866e", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1047552
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.000000] software IO TLB: area num 8.
[    0.000000] software IO TLB: mapped [mem 0x00000000f7e00000-0x00000000fbe00000] (64MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] ftrace: allocating 49524 entries in 194 pages
[    0.000000] ftrace: allocated 194 pages with 3 groups
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.000000] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 480 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: GICD_CTRL.DS=0, SCR_EL3.FIQ=0
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000000c040000
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-0[0] { /cpus/cpu@0[0] /cpus/cpu@100[1] /cpus/cpu@200[2] /cpus/cpu@300[3] /cpus/cpu@400[4] /cpus/cpu@500[5] }
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-1[1] { /cpus/cpu@600[6] /cpus/cpu@700[7] }
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 13.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x2ff89eacb, max_idle_ns: 440795202429 ns
[    0.000000] sched_clock: 56 bits at 13MHz, resolution 76ns, wraps every 4398046511101ns
[    0.008965] Console: colour dummy device 80x25
[    0.013443] printk: legacy console [tty0] enabled
[    0.018257] Calibrating delay loop (skipped), value calculated using timer frequency.. 26.00 BogoMIPS (lpj=52000)
[    0.028601] pid_max: default: 32768 minimum: 301
[    0.033338] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,ima,evm
[    0.042220] landlock: Up and running.
[    0.045902] Yama: becoming mindful.
[    0.049564] AppArmor: AppArmor initialized
[    0.053734] TOMOYO Linux initialized
[    0.057678] LSM support for eBPF active
[    0.061659] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.069119] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.077902] psi: inconsistent task state! task=2:kthreadd cpu=0 psi_flags=4 clear=0 set=4
[    0.101305] rcu: Hierarchical SRCU implementation.
[    0.106134] rcu:     Max phase no-delay instances is 1000.
[    0.111537] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.121373] EFI services will not be available.
[    0.126188] smp: Bringing up secondary CPUs ...
[    0.142890] Detected VIPT I-cache on CPU1
[    0.142948] GICv3: CPU1: found redistributor 100 region 0:0x000000000c060000
[    0.142981] CPU1: Booted secondary processor 0x0000000100 [0x411fd050]
[    0.158933] Detected VIPT I-cache on CPU2
[    0.158971] GICv3: CPU2: found redistributor 200 region 0:0x000000000c080000
[    0.158990] CPU2: Booted secondary processor 0x0000000200 [0x411fd050]
[    0.174900] Detected VIPT I-cache on CPU3
[    0.174934] GICv3: CPU3: found redistributor 300 region 0:0x000000000c0a0000
[    0.174949] CPU3: Booted secondary processor 0x0000000300 [0x411fd050]
[    0.186930] Detected VIPT I-cache on CPU4
[    0.186965] GICv3: CPU4: found redistributor 400 region 0:0x000000000c0c0000
[    0.186980] CPU4: Booted secondary processor 0x0000000400 [0x411fd050]
[    0.202962] Detected VIPT I-cache on CPU5
[    0.202997] GICv3: CPU5: found redistributor 500 region 0:0x000000000c0e0000
[    0.203013] CPU5: Booted secondary processor 0x0000000500 [0x411fd050]
[    0.215071] CPU features: detected: Spectre-v4
[    0.215076] CPU features: detected: Spectre-BHB
[    0.215078] CPU features: detected: ARM erratum 1418040
[    0.215080] CPU features: detected: ARM erratum 1463225
[    0.215083] CPU features: detected: SSBS not fully self-synchronizing
[    0.215086] Detected PIPT I-cache on CPU6
[    0.215122] GICv3: CPU6: found redistributor 600 region 0:0x000000000c100000
[    0.215129] arch_timer: Enabling local workaround for ARM erratum 1418040
[    0.215138] CPU6: Booted secondary processor 0x0000000600 [0x413fd0b0]
[    0.227031] Detected PIPT I-cache on CPU7
[    0.227072] GICv3: CPU7: found redistributor 700 region 0:0x000000000c120000
[    0.227079] arch_timer: Enabling local workaround for ARM erratum 1418040
[    0.227089] CPU7: Booted secondary processor 0x0000000700 [0x413fd0b0]
[    0.227165] smp: Brought up 1 node, 8 CPUs
[    0.394862] SMP: Total of 8 processors activated.
[    0.399598] CPU: All CPU(s) started at EL2
[    0.403721] CPU features: detected: 32-bit EL0 Support
[    0.408894] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
[    0.417569] CPU features: detected: Common not Private translations
[    0.423880] CPU features: detected: CRC32 instructions
[    0.429053] CPU features: detected: Data cache clean to Point of Persistence
[    0.436154] CPU features: detected: RCpc load-acquire (LDAPR)
[    0.441939] CPU features: detected: LSE atomic instructions
[    0.447549] CPU features: detected: Privileged Access Never
[    0.453159] CPU features: detected: RAS Extension Support
[    0.458596] CPU features: detected: Speculative Store Bypassing Safe (SSBS)
[    0.465651] alternatives: applying system-wide alternatives
[    0.474307] CPU features: detected: Hardware dirty bit management on CPU6-7
[    0.483969] node 0 deferred pages initialised in 0ms
[    0.489026] Memory: 3885480K/4190208K available (15232K kernel code, 3446K rwdata, 6172K rodata, 2752K init, 828K bss, 233796K reserved, 65536K cma-reserved)
[    0.503982] devtmpfs: initialized
[    0.512758] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.522597] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.530137] 2G module region forced by RANDOMIZE_MODULE_REGION_FULL
[    0.536454] 0 pages in range for non-PLT usage
[    0.536456] 517120 pages in range for PLT usage
[    0.541048] pinctrl core: initialized pinctrl subsystem
[    0.551959] DMI not present or invalid.
[    0.557522] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.564171] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.571392] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.579376] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.587374] audit: initializing netlink subsys (disabled)
[    0.592918] audit: type=2000 audit(0.456:1): state=initialized audit_enabled=0 res=1
[    0.593759] thermal_sys: Registered thermal governor 'fair_share'
[    0.600728] thermal_sys: Registered thermal governor 'bang_bang'
[    0.606868] thermal_sys: Registered thermal governor 'step_wise'
[    0.612915] thermal_sys: Registered thermal governor 'user_space'
[    0.618962] thermal_sys: Registered thermal governor 'power_allocator'
[    0.625120] cpuidle: using governor ladder
[    0.635828] cpuidle: using governor menu
[    0.639853] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.646795] ASID allocator initialised with 32768 entries
[    0.652534] Serial: AMBA PL011 UART driver
[    0.669191] platform 14013000.dsi: Fixed dependency cycle(s) with /soc/i2c@11007000/anx7625@58
[    0.683157] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.690008] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.696320] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.703155] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.709465] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.716300] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.722610] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.729444] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.736952] ACPI: Interpreter disabled.
[    0.741402] iommu: Default domain type: Translated
[    0.746234] iommu: DMA domain TLB invalidation policy: strict mode
[    0.752768] pps_core: LinuxPPS API ver. 1 registered
[    0.757772] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.766979] PTP clock support registered
[    0.770935] EDAC MC: Ver: 3.0.0
[    0.774223] scmi_core: SCMI protocol bus registered
[    0.779959] NetLabel: Initializing
[    0.783386] NetLabel:  domain hash size = 128
[    0.787769] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.793494] NetLabel:  unlabeled traffic allowed by default
[    0.799193] vgaarb: loaded
[    0.802085] clocksource: Switched to clocksource arch_sys_counter
[    0.808449] VFS: Disk quotas dquot_6.6.0
[    0.812426] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.819644] AppArmor: AppArmor Filesystem Enabled
[    0.824418] pnp: PnP ACPI: disabled
[    0.831557] NET: Registered PF_INET protocol family
[    0.836577] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.845917] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.854563] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.862445] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.870701] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.878864] TCP: Hash tables configured (established 32768 bind 32768)
[    0.885579] MPTCP token hash table entries: 4096 (order: 4, 98304 bytes, linear)
[    0.893082] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.899906] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.907234] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.912951] NET: Registered PF_XDP protocol family
[    0.917781] PCI: CLS 0 bytes, default 64
[    0.921833] Trying to unpack rootfs image as initramfs...
[    0.928838] kvm [1]: nv: 554 coarse grained trap handlers
[    0.934554] kvm [1]: IPA Size Limit: 40 bits
[    0.938885] kvm [1]: GICv3: no GICV resource entry
[    0.943713] kvm [1]: disabling GICv2 emulation
[    0.948200] kvm [1]: GIC system register CPU interface enabled
[    0.954090] kvm [1]: vgic interrupt IRQ18
[    0.958142] kvm [1]: VHE mode initialized successfully
[    0.964122] Initialise system trusted keyrings
[    0.968623] Key type blacklist registered
[    0.972741] workingset: timestamp_bits=42 max_order=20 bucket_order=0
[    0.979253] zbud: loaded
[    0.981973] fuse: init (API version 7.41)
[    0.986202] integrity: Platform Keyring initialized
[    0.991123] integrity: Machine keyring initialized
[    0.995953] Key type asymmetric registered
[    1.000075] Asymmetric key parser 'x509' registered
[    5.868941] Freeing initrd memory: 22892K
[    5.886908] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    5.894458] io scheduler mq-deadline registered
[    5.906144] ledtrig-cpu: registered to indicate activity on CPUs
[    5.912257] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    5.926713] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    5.934445] Serial: AMBA driver
[    5.937939] msm_serial: driver initialized
[    5.942129] SuperH (H)SCI(F) driver initialized
[    5.948887] mousedev: PS/2 mouse device common for all mice
[    5.957484] SMCCC: SOC_ID: ID = jep106:0426:8186 Revision = 0x00000000
[    5.965218] hw perfevents: enabled with armv8_cortex_a55 PMU driver, 7 (0,8000003f) counters available
[    5.975405] hw perfevents: enabled with armv8_cortex_a76 PMU driver, 7 (0,8000003f) counters available
[    5.986187] IPv6: Loaded, but administratively disabled, reboot required to enable
[    5.993823] mip6: Mobile IPv6
[    5.996810] mip6: mip6_init: can't add xfrm type(destopt)
[    6.002257] NET: Registered PF_PACKET protocol family
[    6.007546] mpls_gso: MPLS GSO support
[    6.014053] registered taskstats version 1
[    6.018316] Loading compiled-in X.509 certificates
[    6.062196] Loaded X.509 cert 'Build time autogenerated kernel key: 8dc7145aaa7e9aab3b86e5537f1c2bfa59509cbe'
[    6.076029] Demotion targets for Node 0: null
[    6.080663] Key type .fscrypt registered
[    6.084615] Key type fscrypt-provisioning registered
[    6.144310] Key type encrypted registered
[    6.148368] AppArmor: AppArmor sha256 policy hashing enabled
[    6.154093] ima: No TPM chip found, activating TPM-bypass!
[    6.159618] ima: Allocated hash algorithm: sha256
[    6.164369] ima: No architecture policies found
[    6.168957] evm: Initialising EVM extended attributes:
[    6.174129] evm: security.selinux
[    6.177460] evm: security.SMACK64 (disabled)
[    6.181755] evm: security.SMACK64EXEC (disabled)
[    6.186401] evm: security.SMACK64TRANSMUTE (disabled)
[    6.191484] evm: security.SMACK64MMAP (disabled)
[    6.196130] evm: security.apparmor
[    6.199550] evm: security.ima
[    6.202532] evm: security.capability
[    6.206127] evm: HMAC attrs: 0x1
[    6.212930] clk: Disabling unused clocks
[    6.216900] PM: genpd: Disabling unused power domains
[    6.224857] Freeing unused kernel memory: 2752K
[    6.250486] Checked W+X mappings: passed, no W+X pages found
[    6.256198] Run /init as init process
[    6.597646] cannot find "mediatek,mt8186-fhctl"
[    6.641486] mediatek-mipi-tx 11cc0000.dsi-phy: can't get nvmem_cell_get, ignore it
[    6.655464] mtk-spi-nor 11000000.spi: spi frequency: 39000000 Hz
[    6.700074] 11002000.serial: ttyS0 at MMIO 0x11002000 (irq = 244, base_baud = 1625000) is a ST16650V2
[    6.701297] input: wifi-wakeup as /devices/platform/wifi-wakeup/input/input0
[    6.716630] printk: legacy console [ttyS0] enabled
[    6.726739] spi_master spi0: will run message pump with realtime priority
[    6.727457] mt6359-auxadc: Failed to locate of_node [id: -1]
[    6.728788] platform 14013000.dsi: Fixed dependency cycle(s) with /soc/i2c@11007000/anx7625@58
[    6.728829] i2c 0-0058: Fixed dependency cycle(s) with /soc/i2c@11007000/anx7625@58/aux-bus/panel
[    6.728842] i2c 0-0058: Fixed dependency cycle(s) with /soc/dsi@14013000
[    6.732990] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/ovl@14005000
[    6.733033] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/ovl@14006000
[    6.733056] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/rdma@14007000
[    6.733079] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/color@14009000
[    6.733111] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/ccorr@1400b000
[    6.733133] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/aal@1400c000
[    6.733155] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/gamma@1400d000
[    6.740972] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/ovl@14005000
[    6.746522] platform mt6358-regulator: Fixed dependency cycle(s) with /soc/pwrap@1000d000/pmic/regulators/vs2
[    6.754777] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/ovl@14006000
[    6.763570] platform mt6358-regulator: Fixed dependency cycle(s) with /soc/pwrap@1000d000/pmic/regulators/vdram1
[    6.770299] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/rdma@14007000
[    6.778510] platform mt6358-regulator: Fixed dependency cycle(s) with /soc/pwrap@1000d000/pmic/regulators/vs1
[    6.779281] hid: raw HID events driver (C) Jiri Kosina
[    6.780813] mt6358-keys: Failed to locate of_node [id: -1]
[    6.786870] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/color@14009000
[    6.789011] cros-ec-spi spi0.0: Chrome EC device registered
[    6.796282] pp3300_vcn33_x: Bringing 3500000uV into 3300000-3300000uV
[    6.803630] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/ccorr@1400b000
[    6.812756] pp2760_vsim2_x: Bringing 1860000uV into 2700000-2700000uV
[    6.820252] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/aal@1400c000
[    6.862956] mt6397-rtc mt6358-rtc: registered as rtc0
[    6.869440] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/gamma@1400d000
[    6.879777] mt6397-rtc mt6358-rtc: setting system clock to 2024-09-16T15:25:24 UTC (1726500324)
[    6.880155] i2c_hid_of 2-002c: supply vddl not found, using dummy regulator
[    6.888029] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/dsi@14013000
[    6.888446] input: cros_ec as /devices/platform/soc/11010000.spi/spi_master/spi0/spi0.0/11010000.spi:ec@0:keyboard-controller/input/input1
[    6.893245] input: cros_ec_buttons as /devices/platform/soc/11010000.spi/spi_master/spi0/spi0.0/11010000.spi:ec@0:keyboard-controller/input/input2
[    7.261651] mediatek-drm mediatek-drm.2.auto: Adding component match for /soc/rdma@1401f000
[    7.272416] mtk-msdc 11240000.mmc: allocated mmc-pwrseq
[    7.289318] mmc0: CQHCI version 5.10
[    7.375371] mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=52 arg=00000C00; host->error=0x00000002
[    7.394096] mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=52 arg=80000C08; host->error=0x00000002
[    7.425798] mtk-msdc 11230000.mmc: Final PAD_DS_TUNE: 0x11c14
[    7.440743] mmc0: Command Queue Engine enabled
[    7.441017] mmc1: new ultra high speed SDR104 SDIO card at address 0001
[    7.445185] mmc0: new HS400 MMC card at address 0001
[    7.463150] panel-simple-dp-aux aux-0-0058: Detected BOE NT140FHM-N45 (0x09ae)
[    7.468349] mmcblk0: mmc0:0001 DV4064 58.2 GiB
[    7.476036] mtu3 11201000.usb: supply vusb33 not found, using dummy regulator
[    7.486077]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[    7.486908] mtu3 11201000.usb: dr_mode: 3, drd: auto
[    7.493193] mmcblk0boot0: mmc0:0001 DV4064 4.00 MiB
[    7.497239] mtu3 11201000.usb: u2p_dis_msk: 0, u3p_dis_msk: 0
[    7.497416] mtu3 11201000.usb: usb3-drd: 0
[    7.502735] mmcblk0boot1: mmc0:0001 DV4064 4.00 MiB
[    7.508621] mtu3 11201000.usb: irq 266
[    7.513681] mmcblk0rpmb: mmc0:0001 DV4064 16.0 MiB, chardev (240:0)
[    7.516885] mtu3 11201000.usb: IP version 0x1006(U2 IP)
[    7.601450] mtu3 11201000.usb: max_speed: high-speed
[    7.611384] mtu3 11201000.usb: fifosz/epnum: Tx=0x2000/8, Rx=0x2000/8
[    7.624289] mtu3 11201000.usb: dma mask: 36 bits
[    7.634671] mtu3 11201000.usb: xHCI platform device register success...
[    7.648493] mtu3 11281000.usb: supply vusb33 not found, using dummy regulator
[    7.663069] mtu3 11281000.usb: dr_mode: 3, drd: auto
[    7.665375] usbcore: registered new interface driver usbfs
[    7.668033] mtu3 11281000.usb: u2p_dis_msk: 0, u3p_dis_msk: 0
[    7.668173] mtu3 11281000.usb: usb3-drd: 1
[    7.673555] usbcore: registered new interface driver hub
[    7.679313] mtu3 11281000.usb: irq 267
[    7.683395] usbcore: registered new device driver usb
[    7.688671] mtu3 11281000.usb: IP version 0x1006(U3 IP)
[    7.742379] mtu3 11281000.usb: max_speed: super-speed-plus
[    7.743003] xhci-mtk 11200000.usb: supply vusb33 not found, using dummy regulator
[    7.747860] mtu3 11281000.usb: fifosz/epnum: Tx=0x4000/8, Rx=0x4000/8
[    7.755481] xhci-mtk 11200000.usb: uwk - reg:0x420, version:2
[    7.761766] mtu3 11281000.usb: dma mask: 36 bits
[    7.767732] xhci-mtk 11200000.usb: xHCI Host Controller
[    7.773275] xhci-mtk 11280000.usb: supply vusb33 not found, using dummy regulator
[    7.777332] xhci-mtk 11200000.usb: new USB bus registered, assigned bus number 1
[    7.777393] xhci-mtk 11200000.usb: USB3 root hub has no ports
[    7.784937] xhci-mtk 11280000.usb: uwk - reg:0x424, version:2
[    7.792194] xhci-mtk 11200000.usb: hcc params 0x01400f99 hci version 0x110 quirks 0x0000000000200010
[    7.798089] xhci-mtk 11280000.usb: xHCI Host Controller
[    7.803684] xhci-mtk 11200000.usb: irq 268, io mem 0x11200000
[    7.812785] xhci-mtk 11280000.usb: new USB bus registered, assigned bus number 2
[    7.818129] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[    7.825232] xhci-mtk 11280000.usb: hcc params 0x01400f99 hci version 0x110 quirks 0x0000000000200010
[    7.831112] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.831116] usb usb1: Product: xHCI Host Controller
[    7.839384] xhci-mtk 11280000.usb: irq 269, io mem 0x11280000
[    7.848491] usb usb1: Manufacturer: Linux 6.11.0-next-20240916-deb-00002-g7b544e01c649 xhci-hcd
[    7.855748] xhci-mtk 11280000.usb: xHCI Host Controller
[    7.860563] usb usb1: SerialNumber: 11200000.usb
[    8.028253] hub 1-0:1.0: USB hub found
[    8.035778] hub 1-0:1.0: 1 port detected
[    8.043872] xhci-mtk 11280000.usb: new USB bus registered, assigned bus number 3
[    8.058701] xhci-mtk 11280000.usb: Host supports USB 3.2 Enhanced SuperSpeed
[    8.072879] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[    8.089429] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.103892] usb usb2: Product: xHCI Host Controller
[    8.113647] usb usb2: Manufacturer: Linux 6.11.0-next-20240916-deb-00002-g7b544e01c649 xhci-hcd
[    8.131056] usb usb2: SerialNumber: 11280000.usb
[    8.140632] hub 2-0:1.0: USB hub found
[    8.148147] hub 2-0:1.0: 1 port detected
[    8.156170] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
[    8.172409] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
[    8.188956] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.203409] usb usb3: Product: xHCI Host Controller
[    8.213166] usb usb3: Manufacturer: Linux 6.11.0-next-20240916-deb-00002-g7b544e01c649 xhci-hcd
[    8.230576] usb usb3: SerialNumber: 11280000.usb
[    8.240157] hub 3-0:1.0: USB hub found
[    8.247671] hub 3-0:1.0: 1 port detected
[    8.255703] mtu3 11281000.usb: xHCI platform device register success...
[    8.276133] mtk-iommu 14016000.iommu: bound 14003000.smi (ops mtk_smi_exit [mtk_smi])
[    8.291907] mtk-iommu 14016000.iommu: bound 14004000.smi (ops mtk_smi_exit [mtk_smi])
[    8.307634] mtk-iommu 14016000.iommu: bound 1b002000.smi (ops mtk_smi_exit [mtk_smi])
[    8.323361] mtk-iommu 14016000.iommu: bound 1602e000.smi (ops mtk_smi_exit [mtk_smi])
[    8.339061] mtk-iommu 14016000.iommu: bound 17010000.smi (ops mtk_smi_exit [mtk_smi])
[    8.354737] mtk-iommu 14016000.iommu: bound 14023000.smi (ops mtk_smi_exit [mtk_smi])
[    8.370451] mtk-iommu 14016000.iommu: bound 1502e000.smi (ops mtk_smi_exit [mtk_smi])
[    8.386126] mtk-iommu 14016000.iommu: bound 1582e000.smi (ops mtk_smi_exit [mtk_smi])
[    8.401797] mtk-iommu 14016000.iommu: bound 1a001000.smi (ops mtk_smi_exit [mtk_smi])
[    8.417468] mtk-iommu 14016000.iommu: bound 1a002000.smi (ops mtk_smi_exit [mtk_smi])
[    8.433139] mtk-iommu 14016000.iommu: bound 1a00f000.smi (ops mtk_smi_exit [mtk_smi])
[    8.448836] mtk-iommu 14016000.iommu: bound 1a010000.smi (ops mtk_smi_exit [mtk_smi])
[    8.448890] usb 1-1: new high-speed USB device number 2 using xhci-mtk
[    8.456752] mtk-iommu 14016000.iommu: bound 1c10f000.smi (ops mtk_smi_exit [mtk_smi])
[    8.493277] mtk-iommu 14016000.iommu: bound 1c00f000.smi (ops mtk_smi_exit [mtk_smi])
[    8.509481] mediatek-disp-ovl 14005000.ovl: Adding to iommu group 0
[    8.522904] mediatek-disp-ovl 14006000.ovl: Adding to iommu group 0
[    8.536023] mediatek-disp-rdma 14007000.rdma: Adding to iommu group 0
[    8.549490] mediatek-disp-rdma 1401f000.rdma: Adding to iommu group 0
[    8.562842] mediatek-drm mediatek-drm.2.auto: bound 14005000.ovl (ops mtk_drm_exit [mediatek_drm])
[    8.580822] usb 2-1: new high-speed USB device number 2 using xhci-mtk
[    8.582140] mediatek-drm mediatek-drm.2.auto: bound 14006000.ovl (ops mtk_drm_exit [mediatek_drm])
[    8.603451] usb 1-1: New USB device found, idVendor=30c9, idProduct=0093, bcdDevice= 0.09
[    8.611862] mediatek-drm mediatek-drm.2.auto: bound 14007000.rdma (ops mtk_drm_exit [mediatek_drm])
[    8.620000] usb 1-1: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    8.620004] usb 1-1: Product: Integrated Camera
[    8.620007] usb 1-1: Manufacturer: Lenovo
[    8.620009] usb 1-1: SerialNumber: 8SSC21J75356V1SR34D04F6
[    8.688748] mediatek-drm mediatek-drm.2.auto: bound 14009000.color (ops mtk_drm_exit [mediatek_drm])
[    8.707061] mediatek-drm mediatek-drm.2.auto: bound 1400b000.ccorr (ops mtk_drm_exit [mediatek_drm])
[    8.725355] mediatek-drm mediatek-drm.2.auto: bound 1400c000.aal (ops mtk_drm_exit [mediatek_drm])
[    8.742261] usb 2-1: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.16
[    8.743292] mediatek-drm mediatek-drm.2.auto: bound 1400d000.gamma (ops mtk_drm_exit [mediatek_drm])
[    8.751459] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    8.792208] usb 2-1: Product: USB2.1 Hub
[    8.800054] usb 2-1: Manufacturer: Generic
[    8.809431] hub 2-1:1.0: USB hub found
[    8.817941] hub 2-1:1.0: 3 ports detected
[    8.818842] mediatek-drm mediatek-drm.2.auto: bound 14013000.dsi (ops mtk_drm_exit [mediatek_drm])
[    8.843895] mediatek-drm mediatek-drm.2.auto: bound 1401f000.rdma (ops mtk_drm_exit [mediatek_drm])
[    8.862076] mediatek-drm mediatek-drm.2.auto: Not creating crtc 1 because component 10 is disabled or missing
[    8.866810] usb 3-1: new SuperSpeed USB device number 2 using xhci-mtk
[    8.872572] [drm] Initialized mediatek 1.0.0 for mediatek-drm.2.auto on minor 0
[    9.217339] Console: switching to colour frame buffer device 240x67
[    9.229914] mediatek-drm mediatek-drm.2.auto: [drm] fb0: mediatekdrmfb frame buffer device
[    9.304875] usb 3-1: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.16
[    9.321261] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    9.328846] usbcore: registered new device driver onboard-usb-dev
[    9.335540] usb 3-1: Product: USB3.2 Hub
[    9.335544] usb 3-1: Manufacturer: Generic
[    9.337112] hub 3-1:1.0: USB hub found
[    9.372670] hub 3-1:1.0: 3 ports detected
[   10.590334] usb 3-1.2: new SuperSpeed USB device number 3 using xhci-mtk
[   10.626980] usb 3-1.2: New USB device found, idVendor=04e8, idProduct=61f5, bcdDevice= 1.00
[   10.643747] usb 3-1.2: New USB device strings: Mfr=2, Product=3, SerialNumber=1
[   10.643752] usb 3-1.2: Product: Portable SSD T5
[   10.643755] usb 3-1.2: Manufacturer: Samsung
[   10.643758] usb 3-1.2: SerialNumber: 1234567E4FF2
[   10.687566] SCSI subsystem initialized
[   10.700350] usb 3-1.2: USB controller 11280000.usb does not support streams, which are required by the UAS driver.
[   10.721087] usb 3-1.2: Please try an other USB controller if you wish to use UAS.
[   10.721091] usb-storage 3-1.2:1.0: USB Mass Storage device detected
[   10.721702] scsi host0: usb-storage 3-1.2:1.0
[   10.757586] usbcore: registered new interface driver usb-storage
[   10.772605] usbcore: registered new interface driver uas
[   11.778827] scsi 0:0:0:0: Direct-Access     Samsung  Portable SSD T5  0    PQ: 0 ANSI: 6
[   11.801877] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[   11.817671] sd 0:0:0:0: [sda] Write Protect is off
[   11.827706] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   11.866684]  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10
[   11.880716] sd 0:0:0:0: [sda] Attached SCSI disk
[   12.239413] EXT4-fs (sda4): mounted filesystem c16826e5-0b66-4648-87db-8a2601010f0a ro with ordered data mode. Quota mode: none.
[   12.372682] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[   12.497038] systemd[1]: Inserted module 'autofs4'
[   12.538640] systemd[1]: systemd 256.5-1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCO)
[   12.604118] systemd[1]: Detected architecture arm64.
[   12.615377] systemd[1]: Hostname set to <DEBIAN-T5-ARM64>.
[   12.768629] systemd[1]: bpf-restrict-fs: Failed to load BPF object: No such process
[   13.158668] systemd[1]: Queued start job for default target graphical.target.
[   13.225238] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
[   13.241008] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[   13.257669] systemd[1]: Created slice system-serial\x2dgetty.slice - Slice /system/serial-getty.
[   13.276331] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[   13.294675] systemd[1]: Created slice user.slice - User and Session Slice.
[   13.308737] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[   13.330219] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[   13.355624] systemd[1]: Expecting device dev-disk-by\x2duuid-605450ef\x2d43fc\x2d41e4\x2d83d7\x2d9c204d5c1c03.device - /dev/disk/by-uuid/605450ef-43fc-41e4-83d7-9c204d5c1c03...
[   13.387323] systemd[1]: Expecting device dev-disk-by\x2duuid-92da49dd\x2d921b\x2d4e87\x2d9b65\x2d3ecbd9905707.device - /dev/disk/by-uuid/92da49dd-921b-4e87-9b65-3ecbd9905707...
[   13.419163] systemd[1]: Expecting device dev-disk-by\x2duuid-9409\x2dDA15.device - /dev/disk/by-uuid/9409-DA15...
[   13.439874] systemd[1]: Expecting device dev-ttyAMA0.device - /dev/ttyAMA0...
[   13.454255] systemd[1]: Expecting device dev-ttyS0.device - /dev/ttyS0...
[   13.468013] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[   13.485923] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
[   13.502964] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[   13.517523] systemd[1]: Reached target slices.target - Slice Units.
[   13.530251] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[   13.549165] systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
[   13.566592] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[   13.584391] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[   13.602557] systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
[   13.617375] systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   13.644924] systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   13.672180] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[   13.688660] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[   13.707450] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[   13.766877] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[   13.785218] systemd[1]: Mounting run-lock.mount - Legacy Locks Directory /run/lock...
[   13.803022] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[   13.820759] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[   13.839689] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
[   13.858991] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[   13.879740] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[   13.899336] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[   13.916671] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[   13.936398] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[   13.952172] systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
[   13.984688] systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[   14.031876] systemd[1]: Starting systemd-journald.service - Journal Service...
[   14.049441] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[   14.065554] systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   14.097177] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[   14.115997] systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   14.146783] systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
[   14.168717] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[   14.179524] systemd-journald[331]: Collecting audit messages is disabled.
[   14.195155] EXT4-fs (sda4): re-mounted c16826e5-0b66-4648-87db-8a2601010f0a r/w. Quota mode: none.
[   14.223272] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[   14.238037] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[   14.253788] systemd[1]: Mounted run-lock.mount - Legacy Locks Directory /run/lock.
[   14.269440] systemd[1]: Started systemd-journald.service - Journal Service.
[   14.374947] systemd-journald[331]: Received client request to flush runtime journal.
[   14.935868] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   15.022815] pstore: Using crash dump compression: deflate
[   15.035525] pstore: Registered ramoops as persistent store backend
[   15.047996] ramoops: using 0x100000@0xffec5000, ecc: 0
[   15.109992] mtk-wdt 10007000.watchdog: Watchdog enabled (timeout=31 sec, nowayout=0)
[   15.128526] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.146800] mtk-lvts-thermal 1100b000.thermal-sensor: fake golden temp=50
[   15.166664] mtk-scp 10500000.scp: assigned reserved memory node memory@50000000
[   15.182768] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.195654] remoteproc remoteproc0: scp is available
[   15.217946] remoteproc remoteproc0: powering up scp
[   15.228152] ACPI: battery: new extension: cros-charge-control.6.auto
[   15.231899] remoteproc remoteproc0: Booting fw image mediatek/mt8186/scp.img, size 419488
[   15.231909] mtk-scp 10500000.scp: IPI buf addr 0x0003bdb0
[   15.232218] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.290597] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.307523] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.320997] rt5682s 5-001a: Using default DAI clk names: rt5682-dai-wclk, rt5682-dai-bclk
[   15.326877] mtk-scp 10500000.scp: SCP is ready. FW version corsola_scp_v2.0.18944-70c8f752
[   15.326893] mtk-scp 10500000.scp: creating channel cros-ec-rpmsg addr 0xd
[   15.328463] sbs-battery 6-000b: sbs-battery: battery gas gauge device registered
[   15.337709] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.341465] elan_i2c 2-0015: Elan Touchpad: Module ID: 0x010a, Firmware: 0x0002, Sample: 0x0002, IAP: 0x0002
[   15.341977] input: Elan Touchpad as /devices/platform/soc/11009000.i2c/i2c-2/2-0015/input/input3
[   15.345657] remoteproc remoteproc0: remote processor scp is now up
[   15.430929] mc: Linux media interface: v0.10
[   15.452901] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.490708] videodev: Linux video capture interface: v2.00
[   15.506411] Fallback method does not support PEC.
[   15.506411] sbs-battery 6-000b: I2C adapter does not support I2C_FUNC_SMBUS_READ_BLOCK_DATA.
[   15.533600] mt6358-sound mt6358-sound: mt6358_platform_driver_probe(), dev name mt6358-sound
[   15.536533] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.565442] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.582003] tpm_tis_spi spi1.0: TPM ready IRQ confirmed on attempt 2
[   15.594865] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.598915] mt8186-audio 11210000.audio-controller: mtk_afe_combine_sub_dai(), num of dai 41
[   15.607141] tpm_tis_spi spi1.0: 2.0 TPM (device-id 0x504A, rev-id 83)
[   15.609526] mt8186-audio 11210000.audio-controller: No cache defaults, reading back from HW
[   15.620913] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.646657] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   15.681016] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.681413] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   15.704906] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   15.717988] cros-ec-led cros-ec-led.9.auto: probe with driver cros-ec-led failed with error -22
[   15.737735] cros-ec-dev cros-ec-dev.15.auto: CrOS System Control Processor MCU detected
[   15.757040] cros-ec-rpmsg 10500000.scp.cros-ec-rpmsg.13.-1: Chrome EC device registered
[   15.759051] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.761583] tpm_tis_spi spi1.0: Cr50 firmware version: Ti50/D3C1 RO_B:0.0.56/- RW_A:0.23.90/ti50_common_mp-15224.B:v0.0
[   15.772981] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
[   15.789991] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.806773] panfrost 13040000.gpu: clock rate = 249999863
[   15.851522] panfrost 13040000.gpu: EM: created perf domain
[   15.871976] mtk-ccifreq cci: failed to add devfreq device: -517
[   15.892576] panfrost 13040000.gpu: mali-g52 id 0x7402 major 0x1 minor 0x0 status 0x0
[   15.908188] panfrost 13040000.gpu: features: 00000000,00000cf7, issues: 00000000,00000400
[   15.908195] panfrost 13040000.gpu: Features: L2:0x07120206 Shader:0x00000002 Tiler:0x00000209 Mem:0x1 MMU:0x00002823 AS:0xff JS:0x7
[   15.908202] panfrost 13040000.gpu: shader_present=0x3 l2_present=0x1
[   15.922602] Adding 31457276k swap on /dev/sda6.  Priority:-2 extents:1 across:31457276k
[   15.922886] usb 1-1: Found UVC 1.50 device Integrated Camera (30c9:0093)
[   15.984927] [drm] Initialized panfrost 1.2.0 for 13040000.gpu on minor 1
[   16.000891] usbcore: registered new interface driver uvcvideo
[   16.031262] ------------[ cut here ]------------
[   16.040525] kernel BUG at net/core/skbuff.c:2268!
[   16.040531] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[   16.040537] Modules linked in: mtk_jpeg(+) mtk_adsp_common v4l2_vp9 mt7921s(+) mtk_vcodec_enc(+) mt76_sdio v4l2_h264 aes_ce_blk mtk_adsp_ipc mtk_vcodec_dbgfs mt7921_common mtk_vcodec_common mtk_jpeg_enc_hw aes_ce_cipher mt792x_lib snd_sof_xtensa_dsp crct10dif_ce mt76_connac_lib pp
[   16.040655]  snd_compress mt6577_auxadc snd_pcm_dmaengine industrialio lvts_thermal snd_pcm mtk_rpmsg mtk_svs mtk_scp_ipi mtk_adsp_mailbox rpmsg_core memconsole_coreboot mtk_wdt governor_passive snd_timer memconsole vpd_sysfs snd ramoops mtk_cci_devfreq soundcore reed_solomon sg n
[   16.040782]  clk_mt8186_apmixedsys mtk_cmdq_mailbox mtk_pmic_wrap spi_mtk_nor i2c_mt65xx clk_mt8186_imp_iic_wrap spi_mt65xx clk_mt8186_topckgen clk_mt8186_infra_ao fixed pwm_bl
[   16.040803] CPU: 3 UID: 0 PID: 526 Comm: mt76-sdio-txrx  Not tainted 6.11.0-next-20240916-deb-00002-g7b544e01c649 #1
[   16.040809] Hardware name: Google Magneton board (DT)
[   16.040811] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   16.040816] pc : pskb_expand_head+0x2b0/0x3c0
[   16.040827] lr : mt76s_tx_run_queue+0x274/0x410 [mt76_sdio]
[   16.040837] sp : ffff800082413c20
[   16.040839] x29: ffff800082413c30 x28: ffff030783514080 x27: ffff030783114f80
[   16.040846] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000200
[   16.040852] x23: 0000000000000140 x22: 0000000000000028 x21: ffff0307897b2020
[   16.040858] x20: ffff030783514080 x19: ffff030783111200 x18: 0000000000000000
[   16.040863] x17: ffff568eeefd6000 x16: ffffac78cfc10ee8 x15: 0000000000000000
[   16.040869] x14: 0000000000000000 x13: 00000000000001a0 x12: 00000000000001a0
[   16.040875] x11: 0000000000000000 x10: 0000000000000bd0 x9 : ffffac78bc9dedac
[   16.040880] x8 : ffff0307849f68b0 x7 : 0000000000000000 x6 : 0000000005d995fa
[   16.040886] x5 : 0000000000000000 x4 : ffff0307849f5c80 x3 : 0000000000000820
[   16.040891] x2 : 0000000000000200 x1 : 0000000000000002 x0 : ffff030783111200
[   16.040897] Call trace:
[   16.040899]  pskb_expand_head+0x2b0/0x3c0
[   16.040905]  mt76s_tx_run_queue+0x274/0x410 [mt76_sdio]
[   16.040909]  mt76s_txrx_worker+0xe4/0xac8 [mt76_sdio]
[   16.040914]  mt7921s_txrx_worker+0x98/0x1e0 [mt7921s]
[   16.040924]  __mt76_worker_fn+0x80/0x128 [mt76]
[   16.040934]  kthread+0xe8/0xf8
[   16.040940]  ret_from_fork+0x10/0x20
[   16.040949] Code: 52800021 97fffed9 17ffffbc d4210000 (d4210000)
[   16.040953] ---[ end trace 0000000000000000 ]---
[   16.046045] note: mt76-sdio-txrx [526] exited with irqs disabled
[   16.048248] mtk-vcodec-enc 17020000.video-encoder: Adding to iommu group 1
[   16.050772] mtk-ccifreq cci: failed to add devfreq device: -517
[   16.051568] ------------[ cut here ]------------
[   16.805325] WARNING: CPU: 3 PID: 0 at kernel/context_tracking.c:128 ct_kernel_exit.isra.0+0xa0/0xa8
[   16.805341] Modules linked in: snd_sof_mt8186(+) mtk_vcodec_dec(+) joydev(+) mtk_jpeg(+) mtk_adsp_common v4l2_vp9 mt7921s mtk_vcodec_enc(+) mt76_sdio v4l2_h264 aes_ce_blk mtk_adsp_ipc mtk_vcodec_dbgfs mt7921_common mtk_vcodec_common mtk_jpeg_enc_hw aes_ce_cipher mt792x_lib snd_soc
[   16.805462]  cros_charge_control elan_i2c snd_soc_core mtk_scp snd_compress mt6577_auxadc snd_pcm_dmaengine industrialio lvts_thermal snd_pcm mtk_rpmsg mtk_svs mtk_scp_ipi mtk_adsp_mailbox rpmsg_core memconsole_coreboot mtk_wdt governor_passive snd_timer memconsole vpd_sysfs snd r
[   16.805596]  cqhci udc_core pwm_mtk_disp usb_common clk_mt8186_apmixedsys mtk_cmdq_mailbox mtk_pmic_wrap spi_mtk_nor i2c_mt65xx clk_mt8186_imp_iic_wrap spi_mt65xx clk_mt8186_topckgen clk_mt8186_infra_ao fixed pwm_bl
[   16.805624] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Tainted: G      D            6.11.0-next-20240916-deb-00002-g7b544e01c649 #1
[   16.805630] Tainted: [D]=DIE
[   16.805632] Hardware name: Google Magneton board (DT)
[   16.805635] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   16.805640] pc : ct_kernel_exit.isra.0+0xa0/0xa8
[   16.805645] lr : ct_idle_enter+0x14/0x20
[   16.805649] sp : ffff800080133d60
[   16.805651] x29: ffff800080133d60 x28: 0000000000000000 x27: 0000000000000000
[   16.805658] x26: 0000000000000000 x25: 0000000000000000 x24: 00000003bcbf47dc
[   16.805663] x23: 0000000000000000 x22: ffff030780b1c880 x21: ffff0307bf6ee478
[   16.805669] x20: 0000000000000005 x19: ffff0307bf6eb700 x18: ffff800084ec3c98
[   16.805675] x17: ffff03078080fb00 x16: 0000000000001059 x15: 000000000000089d
[   16.805681] x14: 0000000000000002 x13: 0000000000000000 x12: 0000000000000113
[   16.805687] x11: 071c71c71c71c71c x10: 000000000000003b x9 : ffffac78cfeca660
[   16.805693] x8 : 0000000000000018 x7 : 000000000000006d x6 : 0000000005d995fa
[   16.805698] x5 : 4000000000000002 x4 : ffff568eeefd6000 x3 : ffff800080133d60
[   16.805704] x2 : ffffac78d0715700 x1 : ffffac78d0715700 x0 : 4000000000000000
[   16.805710] Call trace:
[   16.805712]  ct_kernel_exit.isra.0+0xa0/0xa8
[   16.805717]  ct_idle_enter+0x14/0x20
[   16.805722]  cpuidle_enter_state+0x1a4/0x460
[   16.805726]  cpuidle_enter+0x40/0x60
[   16.805733]  do_idle+0x1fc/0x280
[   16.805740]  cpu_startup_entry+0x40/0x50
[   16.805745]  secondary_start_kernel+0x128/0x158
[   16.805752]  __secondary_switched+0xb8/0xc0
[   16.805758] ---[ end trace 0000000000000000 ]---
[   16.836198] mtk-jpeg 17030000.jpeg-encoder: Adding to iommu group 1
[   17.529676] sof-audio-of-mt8186 10680000.adsp: DT DSP detected
[   17.529817] mtk-vcodec-dec 16000000.video-decoder: Adding to iommu group 1
[   17.530091] mtk-jpeg 17030000.jpeg-encoder: mtk-jpeg-enc device registered as /dev/video3 (81,3)
[   17.535691] sof-audio-of-mt8186 10680000.adsp: assigned reserved memory node memory@61000000
[   17.546482] mtk-ccifreq cci: failed to add devfreq device: -517
[   17.603968] sof-audio-of-mt8186 10680000.adsp: Firmware paths/files for ipc type 0:
[   17.605029] mtk-vdec-comp 16025000.video-codec: Adding to iommu group 1
[   17.611648] sof-audio-of-mt8186 10680000.adsp:  Firmware file:     mediatek/sof/sof-mt8186.ri
[   17.611653] sof-audio-of-mt8186 10680000.adsp:  Topology file:     mediatek/sof-tplg/sof-mt8186.tplg
[   17.612004] sof-audio-of-mt8186 10680000.adsp: Firmware info: version 2:0:0-475be
[   17.620780] mtk-ccifreq cci: failed to add devfreq device: -517
[   17.626828] sof-audio-of-mt8186 10680000.adsp: Firmware: ABI 3:22:1 Kernel ABI 3:23:1
[   17.626855] sof-audio-of-mt8186 10680000.adsp: unknown sof_ext_man header type 3 size 0x30
[   17.631797] sof-audio-of-mt8186 10680000.adsp: Firmware info: version 2:0:0-475be
[   17.742162] sof-audio-of-mt8186 10680000.adsp: Firmware: ABI 3:22:1 Kernel ABI 3:23:1
[   17.744509] mtk-ccifreq cci: failed to add devfreq device: -517
[   17.875626] EXT4-fs (sda2): mounted filesystem 605450ef-43fc-41e4-83d7-9c204d5c1c03 r/w with ordered data mode. Quota mode: none.
[   18.093680] audit: type=1400 audit(1726500335.708:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=590 comm="apparmor_parser"
[   18.125082] audit: type=1400 audit(1726500335.712:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=585 comm="apparmor_parser"
[   18.125091] audit: type=1400 audit(1726500335.712:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=585 comm="apparmor_parser"
[   18.125096] audit: type=1400 audit(1726500335.712:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=584 comm="apparmor_parser"
[   18.125101] audit: type=1400 audit(1726500335.712:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=588 comm="apparmor_parser"
[   18.125106] audit: type=1400 audit(1726500335.712:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=588 comm="apparmor_parser"
[   18.125111] audit: type=1400 audit(1726500335.712:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=588 comm="apparmor_parser"
[   18.306790] audit: type=1400 audit(1726500335.712:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oosplash" pid=589 comm="apparmor_parser"
[   18.306797] audit: type=1400 audit(1726500335.720:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=595 comm="apparmor_parser"
[   18.306802] audit: type=1400 audit(1726500335.724:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cups-browsed" pid=596 comm="apparmor_parser"
[   19.050110] mt7921s mmc1:0001:1: Message 00000010 (seq 1) timeout
[   19.062383] mt7921s mmc1:0001:1: Failed to get patch semaphore
[   19.252928] NET: Registered PF_QIPCRTR protocol family
[   24.162158] ------------[ cut here ]------------
[   24.171397] WARNING: CPU: 7 PID: 54 at kernel/kthread.c:76 kthread_park+0x8c/0xe0
[   24.186377] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device qrtr binfmt_misc nls_ascii nls_cp437 vfat fat mtk_vcodec_dec_hw snd_sof_mt8186 mtk_vcodec_dec joydev mtk_jpeg mtk_adsp_common v4l2_vp9 mt7921s mtk_vcodec_enc mt76_sdio v4l2_h264 aes_ce_blk mtk_adsp_ipn
[   24.186521]  cros_ec_sysfs cros_usbpd_logger led_class_multicolor cros_usbpd_notify mtd tpm_tis_core typec cros_charge_control elan_i2c snd_soc_core mtk_scp snd_compress mt6577_auxadc snd_pcm_dmaengine industrialio lvts_thermal snd_pcm mtk_rpmsg mtk_svs mtk_scp_ipi mtk_adsp_mailb3
[   24.365336]  mtk_cmdq_helper mtk_sd clk_mt8186_mfg phy_mtk_mipi_dsi_drv drm nvmem_mtk_efuse mt6358_regulator cqhci udc_core pwm_mtk_disp usb_common clk_mt8186_apmixedsys mtk_cmdq_mailbox mtk_pmic_wrap spi_mtk_nor i2c_mt65xx clk_mt8186_imp_iic_wrap spi_mt65xx clk_mt8186_topckgen cl
[   24.600571] CPU: 7 UID: 0 PID: 54 Comm: kworker/7:0 Tainted: G      D W          6.11.0-next-20240916-deb-00002-g7b544e01c649 #1
[   24.623719] Tainted: [D]=DIE, [W]=WARN
[   24.631206] Hardware name: Google Magneton board (DT)
[   24.641302] Workqueue: events mt7921_init_work [mt7921_common]
[   24.652972] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   24.666899] pc : kthread_park+0x8c/0xe0
[   24.674563] lr : mt7921s_init_reset+0x8c/0x248 [mt7921s]
[   24.685186] sp : ffff800080473ce0
[   24.691804] x29: ffff800080473ce0 x28: ffff0307803cef00 x27: ffff0307bf777c68
[   24.706080] x26: ffffac78d07f18c0 x25: ffff0307803cef80 x24: ffff0307897b20c8
[   24.720356] x23: ffff0307897be8c8 x22: ffff0307897b7768 x21: ffff800080473d00
[   24.734631] x20: ffff0307897b7820 x19: ffff0307849f5c80 x18: 0000000000000008
[   24.748908] x17: ffff568eef05e000 x16: ffffac78cf0dd428 x15: 0000000000000040
[   24.763183] x14: ffffffffffffffff x13: 0000000000000339 x12: 0000000000000001
[   24.777459] x11: ffffac78d07cee70 x10: 0000000000000bd0 x9 : ffffac78bc3cf054
[   24.791734] x8 : ffff0307808ae8b0 x7 : 0000000000000004 x6 : 0000000000000000
[   24.806009] x5 : ffff0307bf764348 x4 : ffff0307897b2080 x3 : ffff0307897b7770
[   24.820285] x2 : ffff800080473d18 x1 : 0000000000005800 x0 : 0000000000400040
[   24.834560] Call trace:
[   24.839437]  kthread_park+0x8c/0xe0
[   24.846405]  mt7921s_init_reset+0x8c/0x248 [mt7921s]
[   24.856329]  mt7921_init_work+0xcc/0x228 [mt7921_common]
[   24.866950]  process_one_work+0x178/0x3d0
[   24.874962]  worker_thread+0x200/0x3f0
[   24.882452]  kthread+0xe8/0xf8
[   24.888550]  ret_from_fork+0x10/0x20
[   24.895693] ---[ end trace 0000000000000000 ]---
[   24.904974] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[   24.922563] Mem abort info:
[   24.928143]   ESR = 0x0000000096000004
[   24.935638]   EC = 0x25: DABT (current EL), IL = 32 bits
[   24.946265]   SET = 0, FnV = 0
[   24.952365]   EA = 0, S1PTW = 0
[   24.958641]   FSC = 0x04: level 0 translation fault
[   24.968399] Data abort info:
[   24.974153]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   24.985126]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   24.995231]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   25.005858] user pgtable: 4k pages, 48-bit VAs, pgdp=00000001012eb000
[   25.018746] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[   25.032335] Internal error: Oops: 0000000096000004 [#2] SMP
[   25.043480] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device qrtr binfmt_misc nls_ascii nls_cp437 vfat fat mtk_vcodec_dec_hw snd_sof_mt8186 mtk_vcodec_dec joydev mtk_jpeg mtk_adsp_common v4l2_vp9 mt7921s mtk_vcodec_enc mt76_sdio v4l2_h264 aes_ce_blk mtk_adsp_ipn
[   25.043612]  cros_ec_sysfs cros_usbpd_logger led_class_multicolor cros_usbpd_notify mtd tpm_tis_core typec cros_charge_control elan_i2c snd_soc_core mtk_scp snd_compress mt6577_auxadc snd_pcm_dmaengine industrialio lvts_thermal snd_pcm mtk_rpmsg mtk_svs mtk_scp_ipi mtk_adsp_mailb3
[   25.222435]  mtk_cmdq_helper mtk_sd clk_mt8186_mfg phy_mtk_mipi_dsi_drv drm nvmem_mtk_efuse mt6358_regulator cqhci udc_core pwm_mtk_disp usb_common clk_mt8186_apmixedsys mtk_cmdq_mailbox mtk_pmic_wrap spi_mtk_nor i2c_mt65xx clk_mt8186_imp_iic_wrap spi_mt65xx clk_mt8186_topckgen cl
[   25.457674] CPU: 7 UID: 0 PID: 54 Comm: kworker/7:0 Tainted: G      D W          6.11.0-next-20240916-deb-00002-g7b544e01c649 #1
[   25.480825] Tainted: [D]=DIE, [W]=WARN
[   25.488312] Hardware name: Google Magneton board (DT)
[   25.498411] Workqueue: events mt7921_init_work [mt7921_common]
[   25.510083] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   25.524015] pc : kthread_park+0x2c/0xe0
[   25.531685] lr : mt7921s_init_reset+0x8c/0x248 [mt7921s]
[   25.542318] sp : ffff800080473ce0
[   25.548939] x29: ffff800080473ce0 x28: ffff0307803cef00 x27: ffff0307bf777c68
[   25.563216] x26: ffffac78d07f18c0 x25: ffff0307803cef80 x24: ffff0307897b20c8
[   25.577492] x23: ffff0307897be8c8 x22: ffff0307897b7768 x21: ffff800080473d00
[   25.591769] x20: 0000000000000000 x19: ffff0307849f5c80 x18: 0000000000000008
[   25.606044] x17: ffff568eef05e000 x16: ffffac78cf0dd428 x15: 0000000000000040
[   25.620320] x14: ffffffffffffffff x13: 0000000000000339 x12: 0000000000000001
[   25.634595] x11: ffffac78d07cee70 x10: 0000000000000bd0 x9 : ffffac78bc3cf054
[   25.648869] x8 : ffff0307808ae8b0 x7 : 0000000000000004 x6 : 0000000000000000
[   25.663145] x5 : ffff0307bf764348 x4 : ffff0307897b2080 x3 : ffff0307897b7770
[   25.677420] x2 : ffff800080473d18 x1 : 0000000000005800 x0 : 0000000000400040
[   25.691696] Call trace:
[   25.696574]  kthread_park+0x2c/0xe0
[   25.703541]  mt7921s_init_reset+0x8c/0x248 [mt7921s]
[   25.713466]  mt7921_init_work+0xcc/0x228 [mt7921_common]
[   25.724089]  process_one_work+0x178/0x3d0
[   25.732102]  worker_thread+0x200/0x3f0
[   25.739592]  kthread+0xe8/0xf8
[   25.745689]  ret_from_fork+0x10/0x20
[   25.752832] Code: b9402c00 36a80360 f9431e74 371003a0 (f9400280)
[   25.765018] ---[ end trace 0000000000000000 ]---
[   26.133052] rfkill: input handler disabled
[   27.756379] mtk-ccifreq cci: failed to add devfreq device: -517
[   27.771837] platform cci: deferred probe pending: mtk-ccifreq: devfreq_add_device: Unable to start governor for the device
[   27.794010] platform 1100bc00.svs: deferred probe pending: mtk-svs: failed to get OPP device for bank 3
[   27.812847] platform sound: deferred probe pending: mt8186_mt6366: I2S3: codec dai not found
[   32.523939]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[   37.986383] pp1840_vaux18: disabling
[   37.993715] pp2800_vaud28: disabling

Debian GNU/Linux trixie/sid DEBIAN-T5-ARM64 ttyS0

DEBIAN-T5-ARM64 login: alpernebbi
Password:
Linux DEBIAN-T5-ARM64 6.11.0-next-20240916-deb-00002-g7b544e01c649 #1 SMP Mon Sep 16 17:42:49 +03 2024 aarch64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
You have new mail.

[   76.908268] PDLOG 2024/09/16 15:25:11.783 P0 SNK Charger ??? 5025mV max 5000mV / 500mA
[   76.908268] PDLOG 2024/09/16 15:25:11.783 P0 SNK Charger ??? 5025mV max 5000mV / 500mA

$ sudo mount -t debugfs none /sys/kernel/debug
[sudo] password for alpernebbi:

alpernebbi@DEBIAN-T5-ARM64 ~
$ sudo cat /sys/kernel/debug/devices_deferred
cci     mtk-ccifreq: devfreq_add_device: Unable to start governor for the device
1100bc00.svs    mtk-svs: failed to get OPP device for bank 3
sound   mt8186_mt6366: I2S3: codec dai not found

alpernebbi@DEBIAN-T5-ARM64 ~
$ lsmod
Module                  Size  Used by
snd_seq_dummy          12288  0
snd_hrtimer            12288  1
snd_seq                81920  7 snd_seq_dummy
snd_seq_device         12288  1 snd_seq
qrtr                   36864  2
binfmt_misc            20480  1
nls_ascii              12288  1
nls_cp437              16384  1
vfat                   20480  1
fat                    73728  1 vfat
mtk_vcodec_dec_hw      16384  0
snd_sof_mt8186         24576  0
mtk_vcodec_dec        163840  1 mtk_vcodec_dec_hw
joydev                 28672  0
mtk_jpeg               32768  0
mtk_adsp_common        12288  1 snd_sof_mt8186
v4l2_vp9               20480  1 mtk_vcodec_dec
mt7921s                20480  0
mtk_vcodec_enc         61440  0
mt76_sdio              24576  1 mt7921s
v4l2_h264              16384  1 mtk_vcodec_dec
aes_ce_blk             32768  0
mtk_adsp_ipc           16384  1 snd_sof_mt8186
mtk_vcodec_dbgfs       12288  2 mtk_vcodec_enc,mtk_vcodec_dec
mt7921_common          65536  1 mt7921s
mtk_vcodec_common      20480  4 mtk_vcodec_enc,mtk_vcodec_dbgfs,mtk_vcodec_dec,mtk_vcodec_dec_hw
mtk_jpeg_enc_hw        12288  1 mtk_jpeg
aes_ce_cipher          12288  1 aes_ce_blk
mt792x_lib             45056  2 mt7921s,mt7921_common
snd_sof_xtensa_dsp     12288  1 snd_sof_mt8186
crct10dif_ce           12288  1
mt76_connac_lib        53248  3 mt792x_lib,mt7921s,mt7921_common
polyval_ce             12288  0
mtk_jpeg_dec_hw        16384  1 mtk_jpeg
mtk_vpu                20480  1 mtk_vcodec_common
uvcvideo              110592  0
polyval_generic        12288  1 polyval_ce
mt76                   94208  5 mt792x_lib,mt7921s,mt7921_common,mt76_sdio,mt76_connac_lib
ghash_ce               16384  0
videobuf2_vmalloc      16384  1 uvcvideo
videobuf2_dma_contig    20480  3 mtk_jpeg,mtk_vcodec_enc,mtk_vcodec_dec
snd_sof_of             12288  1 snd_sof_mt8186
mac80211              946176  4 mt792x_lib,mt76,mt7921_common,mt76_connac_lib
v4l2_mem2mem           28672  5 mtk_jpeg,mtk_vcodec_enc,mtk_jpeg_dec_hw,mtk_jpeg_enc_hw,mtk_vcodec_dec
uvc                    12288  1 uvcvideo
gf128mul               12288  2 polyval_generic,ghash_ce
panfrost               77824  3
snd_sof               172032  3 snd_sof_mt8186,mtk_adsp_common,snd_sof_of
mt8186_mt6366          49152  0
sha2_ce                12288  0
libarc4                12288  1 mac80211
videobuf2_memops       16384  2 videobuf2_vmalloc,videobuf2_dma_contig
cros_ec_rpmsg          16384  0
cfg80211              856064  4 mt76,mac80211,mt7921_common,mt76_connac_lib
ofpart                 16384  0
sha256_arm64           24576  1 sha2_ce
snd_soc_mt8186_afe    241664  30 mt8186_mt6366
cros_usbpd_charger     20480  0
snd_sof_utils          16384  1 snd_sof
spi_nor               106496  0
cros_ec_typec          24576  0
leds_cros_ec           12288  0
gpu_sched              49152  1 panfrost
snd_soc_dmic           12288  0
tpm_tis_spi            16384  0
videobuf2_v4l2         20480  5 mtk_jpeg,mtk_vcodec_enc,uvcvideo,mtk_vcodec_dec,v4l2_mem2mem
snd_soc_bt_sco         12288  0
sha1_ce                12288  0
snd_soc_rt1015p        16384  0
snd_soc_mt6358         61440  1 snd_soc_mt8186_afe
videodev              253952  6 mtk_jpeg,mtk_vcodec_enc,videobuf2_v4l2,uvcvideo,mtk_vcodec_dec,v4l2_mem2mem
rfkill                 28672  4 cfg80211
videobuf2_common       53248  11 mtk_jpeg,mtk_vcodec_enc,videobuf2_vmalloc,videobuf2_dma_contig,mtk_jpeg_dec_hw,videobuf2_v4l2,mtk_jpeg_enc_hw,uvcvideo,mtk_vcodec_dec,v4l2_mem2mem,videobuf2_memops
drm_shmem_helper       24576  1 panfrost
mc                     61440  6 videodev,videobuf2_v4l2,uvcvideo,videobuf2_common,mtk_vcodec_dec,v4l2_mem2mem
snd_soc_mtk_common     28672  2 snd_soc_mt8186_afe,mt8186_mt6366
snd_soc_rt5682s        81920  0
sbs_battery            20480  0
cros_ec_debugfs        12288  0
cros_ec_chardev        12288  0
cros_ec_hwmon          12288  0
cros_ec_sysfs          12288  0
cros_usbpd_logger      16384  0
led_class_multicolor    12288  1 leds_cros_ec
cros_usbpd_notify      16384  2 cros_ec_typec,cros_usbpd_charger
mtd                    69632  3 spi_nor,ofpart
tpm_tis_core           24576  1 tpm_tis_spi
typec                  61440  1 cros_ec_typec
cros_charge_control    16384  0
elan_i2c               36864  0
snd_soc_core          245760  9 snd_soc_mt8186_afe,mt8186_mt6366,snd_soc_mt6358,snd_sof,snd_soc_bt_sco,snd_soc_mtk_common,snd_soc_rt1015p,snd_soc_dmic,snd_soc_rt5682s
mtk_scp                36864  1 mtk_vcodec_common
snd_compress           24576  2 snd_sof,snd_soc_core
mt6577_auxadc          16384  0
snd_pcm_dmaengine      12288  1 snd_soc_core
industrialio           90112  1 mt6577_auxadc
lvts_thermal           24576  0
snd_pcm               122880  9 snd_soc_mt8186_afe,mt8186_mt6366,snd_sof,snd_soc_mtk_common,snd_compress,snd_soc_core,snd_sof_utils,snd_soc_rt5682s,snd_pcm_dmaengine
mtk_rpmsg              12288  1 mtk_scp
mtk_svs                49152  0
mtk_scp_ipi            12288  2 mtk_vcodec_common,mtk_scp
mtk_adsp_mailbox       12288  2
rpmsg_core             16384  2 mtk_rpmsg,cros_ec_rpmsg
memconsole_coreboot    12288  0
mtk_wdt                12288  1
governor_passive       12288  0
snd_timer              40960  3 snd_seq,snd_hrtimer,snd_pcm
memconsole             12288  1 memconsole_coreboot
vpd_sysfs              12288  0
snd                    94208  12 snd_soc_mt8186_afe,snd_seq,snd_seq_device,mt8186_mt6366,snd_soc_mt6358,snd_sof,snd_timer,snd_compress,snd_soc_core,snd_pcm
ramoops                24576  0
mtk_cci_devfreq        12288  0
soundcore              12288  1 snd
reed_solomon           16384  1 ramoops
sg                     32768  0
evdev                  20480  7
efi_pstore             12288  0
configfs               49152  1
nfnetlink              16384  1
ip_tables              24576  0
x_tables               32768  1 ip_tables
autofs4                49152  2
ext4                  786432  2
crc32c_generic         12288  4
crc16                  12288  1 ext4
mbcache                16384  1 ext4
jbd2                  135168  1 ext4
sd_mod                 61440  4
uas                    24576  0
usb_storage            73728  5 uas
scsi_mod              233472  4 sd_mod,usb_storage,uas,sg
scsi_common            12288  5 scsi_mod,sd_mod,usb_storage,uas,sg
onboard_usb_dev        16384  0
xhci_mtk_hcd           28672  0
xhci_hcd              253952  1 xhci_mtk_hcd
usbcore               278528  6 xhci_hcd,onboard_usb_dev,usb_storage,uvcvideo,xhci_mtk_hcd,uas
panel_edp              32768  0
cros_ec_keyb           16384  0
i2c_hid_of             12288  0
i2c_cros_ec_tunnel     12288  0
matrix_keymap          12288  1 cros_ec_keyb
rtc_mt6397             12288  1
cros_ec_dev            12288  0
anx7625                49152  0
i2c_hid                36864  1 i2c_hid_of
hid                   229376  1 i2c_hid
clk_mt8186_mm          12288  26
drm_dp_aux_bus         12288  2 anx7625,panel_edp
mt6397                 24576  0
cros_ec_spi            20480  0
cros_ec                16384  2 cros_ec_spi,cros_ec_rpmsg
gpio_keys              16384  0
clk_mt8186_ipe         12288  8
mediatek_drm          139264  4
clk_mt8186_mdp         12288  2
drm_display_helper    143360  3 anx7625,panel_edp,mediatek_drm
phy_mtk_tphy           28672  3
clk_mt8186_mcu         12288  0
clk_mt8186_cam         12288  9
mtk_iommu              32768  8
drm_dma_helper         16384  2 mediatek_drm
clk_mt8186_vdec        12288  5
clk_mt8186_venc        12288  5
mtk_smi                20480  0
clk_mt8186_wpe         12288  4
drm_kms_helper        139264  5 anx7625,drm_dma_helper,drm_shmem_helper,drm_display_helper,mediatek_drm
mtk_mutex              20480  1 mediatek_drm
mtk_mmsys              24576  1 mediatek_drm
clk_mt8186_img         12288  5
mtu3                  106496  0
mtk_cmdq_helper        16384  3 mtk_mmsys,mtk_mutex,mediatek_drm
mtk_sd                 49152  0
clk_mt8186_mfg         12288  2
phy_mtk_mipi_dsi_drv    20480  2
drm                   479232  15 gpu_sched,i2c_hid,anx7625,drm_kms_helper,drm_dma_helper,panel_edp,drm_shmem_helper,drm_display_helper,mediatek_drm,panfrost
nvmem_mtk_efuse        12288  0
mt6358_regulator       45056  25
cqhci                  24576  1 mtk_sd
udc_core               53248  1 mtu3
pwm_mtk_disp           12288  1
usb_common             12288  6 xhci_hcd,usbcore,uvcvideo,xhci_mtk_hcd,mtu3,udc_core
clk_mt8186_apmixedsys    12288  0
mtk_cmdq_mailbox       20480  2 mtk_cmdq_helper
mtk_pmic_wrap          36864  0
spi_mtk_nor            20480  0
i2c_mt65xx             28672  0
clk_mt8186_imp_iic_wrap    12288  5
spi_mt65xx             24576  0
clk_mt8186_topckgen    20480  47
clk_mt8186_infra_ao    20480  43
fixed                  16384  45
pwm_bl                 16384  0

alpernebbi@DEBIAN-T5-ARM64 ~
$ cat /etc/modprobe.d/mtk.conf
softdep mtk_smi pre: mtk-pmic-wrap mt6358-regulator
softdep mtk_iommu pre: mtk_smi
softdep mtk-sd pre: mt6358-regulator
softdep mtu3 pre: mt6358-regulator
softdep mediatek-drm pre: mt6358-regulator mtk_iommu

alpernebbi@DEBIAN-T5-ARM64 ~
$ sudo systemctl poweroff

[  348.928608] rfkill: input handler enabled
[  349.278237] coredump: 2541(plymouthd): over coredump resource limit, skipping core dump
[  349.294278] coredump: 2541(plymouthd): coredump has not been created, error -7
[  349.550635] detected fb_set_par error, error code: -16
[  OK  ] Stopped session-1.scope - Session 1 of User alpernebbi.
         Stopping user@1000.service - User Manager for UID 1000...
[  OK  ] Stopped user@1000.service - User Manager for UID 1000.
         Stopping systemd-user-sessions.service - Permit User Sessions...
         Stopping user-runtime-dir@1000.ser…Runtime Directory /run/user/1000...
[  OK  ] Stopped systemd-user-sessions.service - Permit User Sessions.
[  OK  ] Unmounted run-user-1000.mount - /run/user/1000.
[  OK  ] Stopped user-runtime-dir@1000.serv…r Runtime Directory /run/user/1000.
[  OK  ] Removed slice user-1000.slice - User Slice of UID 1000.
[  OK  ] Stopped target network.target - Network.
[  OK  ] Stopped target remote-fs.target - Remote File Systems.
         Stopping NetworkManager.service - Network Manager...
         Stopping networking.service - Raise network interfaces...
         Stopping systemd-logind.service - User Login Management...
         Stopping wpa_supplicant.service - WPA supplicant...
[  OK  ] Stopped NetworkManager.service - Network Manager.
[  OK  ] Stopped wpa_supplicant.service - WPA supplicant.
[  OK  ] Stopped systemd-logind.service - User Login Management.
[  OK  ] Stopped target nss-user-lookup.target - User and Group Name Lookups.
         Stopping dbus.service - D-Bus System Message Bus...
[  OK  ] Stopped dbus.service - D-Bus System Message Bus.
[  OK  ] Stopped networking.service - Raise network interfaces.
[  OK  ] Stopped target basic.target - Basic System.
[  OK  ] Stopped systemd-ask-password-plymo…quests to Plymouth Directory Watch.
[  OK  ] Stopped target paths.target - Path Units.
[  OK  ] Stopped cups.path - CUPS Scheduler.
[  OK  ] Stopped target slices.target - Slice Units.
[  OK  ] Removed slice user.slice - User and Session Slice.
[  OK  ] Stopped target sockets.target - Socket Units.
[  OK  ] Closed avahi-daemon.socket - Avahi…DNS/DNS-SD Stack Activation Socket.
[  OK  ] Closed cups.socket - CUPS Scheduler.
[  OK  ] Closed dbus.socket - D-Bus System Message Bus Socket.
[  OK  ] Closed sshd-unix-local.socket - Op…temd-ssh-generator, AF_UNIX Local).
[  OK  ] Closed systemd-hostnamed.socket - Hostname Service Socket.
[  OK  ] Stopped target sysinit.target - System Initialization.
[  OK  ] Stopped target cryptsetup.target - Local Encrypted Volumes.
[  OK  ] Stopped systemd-ask-password-wall.…d Requests to Wall Directory Watch.
[  OK  ] Stopped target integritysetup.targ… Local Integrity Protected Volumes.
[  OK  ] Stopped target veritysetup.target - Local Verity Protected Volumes.
         Stopping systemd-backlight@backlig…ness of backlight:backlight-lcd0...
         Stopping systemd-binfmt.service - Set Up Additional Binary Formats...
[  OK  ] Stopped systemd-sysctl.service - Apply Kernel Variables.
[  OK  ] Stopped systemd-modules-load.service - Load Kernel Modules.
         Stopping systemd-timesyncd.service - Network Time Synchronization...
         Stopping systemd-update-utmp.servi…ord System Boot/Shutdown in UTMP...
[  OK  ] Stopped systemd-backlight@backligh…htness of backlight:backlight-lcd0.
[  OK  ] Stopped systemd-timesyncd.service - Network Time Synchronization.
[  OK  ] Stopped systemd-binfmt.service - Set Up Additional Binary Formats.
[  OK  ] Removed slice system-systemd\x2dba… - Slice /system/systemd-backlight.
[  OK  ] Unset automount proc-sys-fs-binfmt…ormats File System Automount Point.
[  OK  ] Stopped systemd-update-utmp.servic…ecord System Boot/Shutdown in UTMP.
[  OK  ] Stopped systemd-tmpfiles-setup.ser…reate System Files and Directories.
[  OK  ] Stopped target local-fs.target - Local File Systems.
         Unmounting boot-efi.mount - /boot/efi...
         Unmounting home.mount - /home...
         Unmounting run-lock.mount - Legacy Locks Directory /run/lock...
         Unmounting tmp.mount - Temporary Directory /tmp...
[  OK  ] Unmounted run-lock.mount - Legacy Locks Directory /run/lock.
[  OK  ] Unmounted tmp.mount - Temporary Directory /tmp.
[  OK  ] Stopped target swap.target - Swaps.
         Deactivating swap dev-disk-by\x2dd…p - /dev/disk/by-diskseq/4-part6...
[  OK  ] Unmounted boot-efi.mount - /boot/efi.
[  OK  ] Stopped systemd-fsck@dev-disk-by\x…eck on /dev/disk/by-uuid/9409-DA15.
[  OK  ] Deactivated swap dev-disk-by\x2dpa…8079f9-9be3-4040-b0c6-135b958b076c.
[  OK  ] Deactivated swap dev-disk-by\x2did…able_SSD_T5_1234567E4FF2-0:0-part6.
[  OK  ] Deactivated swap dev-disk-by\x2dpa…8079f9-9be3-4040-b0c6-135b958b076c.
[  OK  ] Deactivated swap dev-disk-by\x2dpa…da49dd-921b-4e87-9b65-3ecbd9905707.
[  OK  ] Deactivated swap dev-disk-by\x2ddi…wap - /dev/disk/by-diskseq/4-part6.
[  OK  ] Deactivated swap dev-disk-by\x2did…table_SSD_T5_S46UNV0M200584Z-part6.
[  OK    351.791891] EXT4-fs (sda2): unmounting filesystem 605450ef-43fc-41e4-83d7-9c204d5c1c03.
0m] Deactivated [swap dev-disk-by\x2did…by-id/wwn-0x5002538e00000000-part6.
  351.791891] EXT4-fs (sda2): unmounting filesystem 605450ef-43fc-41e4-83d7-9c204d5c1c03.
[  OK  ] Deactivated swap dev-disk-by\x2dpa…1.0-scsi-0:0:0:0-part/by-partnum/6.
[  OK  ] Deactivated swap dev-disk-by\x2dpa…b-usb-0:1.2:1.0-scsi-0:0:0:0-part6.
[  OK  ] Deactivated swap dev-disk-by\x2dpa…-0:0:0:0-part/by-partlabel/SWAP-T5.
[  OK  ] Deactivated swap dev-disk-by\x2dpa…usbv3-0:1.2:1.0-scsi-0:0:0:0-part6.
[  OK  ] Deactivated swap dev-disk-by\x2dpa…p - /dev/disk/by-partlabel/SWAP-T5.
[  OK  ] Deactivated swap dev-sda6.swap - /dev/sda6.
[  OK  ] Unmounted home.mount - /home.
[  OK  ] Deactivated swap dev-disk-by\x2duu…da49dd-921b-4e87-9b65-3ecbd9905707.
[  OK  ] Reached target umount.target - Unmount All Filesystems.
[  OK  ] Stopped systemd-fsck@dev-disk-by\x…5450ef-43fc-41e4-83d7-9c204d5c1c03.
[  OK  ] Removed slice system-systemd\x2dfs…slice - Slice /system/systemd-fsck.
[  OK  ] Stopped target local-fs-pre.target…Preparation for Local File Systems.
[  OK  ] Stopped systemd-remount-fs.service…mount Root and Kernel File Systems.
[  OK  ] Stopped systemd-tmpfiles-setup-dev…Create Static Device Nodes in /dev.
[  OK  ] Stopped systemd-tmpfiles-setup-dev…ic Device Nodes in /dev gracefully.
[  OK  ] Reached target shutdown.target - System Shutdown.
[  OK  ] Reached target final.target - Late Shutdown Services.
[  OK  ] Finished systemd-poweroff.service - System Power Off.

