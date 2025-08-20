Return-Path: <linux-wireless+bounces-26478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BB8B2DEEF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 16:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7906E5C1362
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66ED26FDBB;
	Wed, 20 Aug 2025 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Ww1eVBRq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5526A08C;
	Wed, 20 Aug 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699305; cv=none; b=XSMa24wanumft7R3MAXWV94CMsZsfJUruuiwlURIOorh+Bm4ck88rJyvV3GJSzDmF/Gr0FeM5pfItWqP4JwqNEDTovxO2KOW9UybwUQWts6B4/RUhUUCGKAZLWJfWyObItMJP3x2/malppHYFpjf6Xasg708CGYF5l+PEwDh/nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699305; c=relaxed/simple;
	bh=fcI+JfmbgazG0oyqr4vweApC/K8v8S2/HW2JZ5hXRzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uw79+qURWBcevWx1oRqozE4O41CeIigN5EtCCPJLkbucZx8Oi7jmIEhPgBdY51h7lAcOeYryfQt/RaOcqaqu+Z0gYEREgC/7K5AaTnJDu7tFMBnHu3gSEGQUgeoGLLHeKRd5xRZ/fYJOp4YQJxuN1ptS3bIKCfAHZofpNOwKUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Ww1eVBRq; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 613F84028389;
	Wed, 20 Aug 2025 14:14:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 613F84028389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1755699297;
	bh=wbDVHY/uG91W3ht0vZ0TgeD7aGjlU9KbGb6El0uCnDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ww1eVBRqAwLgd6RAOcTDxSB3ndfDykgKZOhpou8GxgKSVaBwK78SelmqPBFSE3nrz
	 4Q7GqdPLMQSE02xaEyrP5hS9gIxPsNS1pa8qDo+i9M35ek8ZCZI48dIEPaTMXgEtLQ
	 mez2/oOpC5RO62aiMCHwm9J6N3FFtFNEiN4HKkM8=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next 2/2] wifi: rtw89: avoid circular locking dependency in ser_state_run()
Date: Wed, 20 Aug 2025 17:13:46 +0300
Message-ID: <20250820141441.106156-3-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820141441.106156-1-pchelkin@ispras.ru>
References: <20250820141441.106156-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdep gives a splat [1] when ser_hdl_work item is executed. It is
scheduled at mac80211 workqueue via ieee80211_queue_work() and takes a
wiphy lock inside.  However, this workqueue can be flushed when e.g.
closing the interface and wiphy lock is already taken in that case.

Choosing wiphy_work_queue() for SER is likely not suitable.  Back on to
global workqueue.

[1]:

 WARNING: possible circular locking dependency detected
 6.17.0-rc2 #17 Not tainted
 ------------------------------------------------------
 kworker/u32:1/61 is trying to acquire lock:
 ffff88811bc00768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ser_state_run+0x5e/0x180 [rtw89_core]

 but task is already holding lock:
 ffffc9000048fd30 ((work_completion)(&ser->ser_hdl_work)){+.+.}-{0:0}, at: process_one_work+0x7b5/0x1450

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #2 ((work_completion)(&ser->ser_hdl_work)){+.+.}-{0:0}:
        process_one_work+0x7c6/0x1450
        worker_thread+0x49e/0xd00
        kthread+0x313/0x640
        ret_from_fork+0x221/0x300
        ret_from_fork_asm+0x1a/0x30

 -> #1 ((wq_completion)phy0){+.+.}-{0:0}:
        touch_wq_lockdep_map+0x8e/0x180
        __flush_workqueue+0x129/0x10d0
        ieee80211_stop_device+0xa8/0x110
        ieee80211_do_stop+0x14ce/0x2880
        ieee80211_stop+0x13a/0x2c0
        __dev_close_many+0x18f/0x510
        __dev_change_flags+0x25f/0x670
        netif_change_flags+0x7b/0x160
        do_setlink.isra.0+0x1640/0x35d0
        rtnl_newlink+0xd8c/0x1d30
        rtnetlink_rcv_msg+0x700/0xb80
        netlink_rcv_skb+0x11d/0x350
        netlink_unicast+0x49a/0x7a0
        netlink_sendmsg+0x759/0xc20
        ____sys_sendmsg+0x812/0xa00
        ___sys_sendmsg+0xf7/0x180
        __sys_sendmsg+0x11f/0x1b0
        do_syscall_64+0xbb/0x360
        entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> #0 (&rdev->wiphy.mtx){+.+.}-{4:4}:
        __lock_acquire+0x124c/0x1d20
        lock_acquire+0x154/0x2e0
        __mutex_lock+0x17b/0x12f0
        ser_state_run+0x5e/0x180 [rtw89_core]
        rtw89_ser_hdl_work+0x119/0x220 [rtw89_core]
        process_one_work+0x82d/0x1450
        worker_thread+0x49e/0xd00
        kthread+0x313/0x640
        ret_from_fork+0x221/0x300
        ret_from_fork_asm+0x1a/0x30

 other info that might help us debug this:

 Chain exists of:
   &rdev->wiphy.mtx --> (wq_completion)phy0 --> (work_completion)(&ser->ser_hdl_work)

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&ser->ser_hdl_work));
                                lock((wq_completion)phy0);
                                lock((work_completion)(&ser->ser_hdl_work));
   lock(&rdev->wiphy.mtx);

  *** DEADLOCK ***

 2 locks held by kworker/u32:1/61:
  #0: ffff888103835148 ((wq_completion)phy0){+.+.}-{0:0}, at: process_one_work+0xefa/0x1450
  #1: ffffc9000048fd30 ((work_completion)(&ser->ser_hdl_work)){+.+.}-{0:0}, at: process_one_work+0x7b5/0x1450

 stack backtrace:
 CPU: 0 UID: 0 PID: 61 Comm: kworker/u32:1 Not tainted 6.17.0-rc2 #17 PREEMPT(voluntary)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS edk2-20250523-14.fc42 05/23/2025
 Workqueue: phy0 rtw89_ser_hdl_work [rtw89_core]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5d/0x80
  print_circular_bug.cold+0x178/0x1be
  check_noncircular+0x14c/0x170
  __lock_acquire+0x124c/0x1d20
  lock_acquire+0x154/0x2e0
  __mutex_lock+0x17b/0x12f0
  ser_state_run+0x5e/0x180 [rtw89_core]
  rtw89_ser_hdl_work+0x119/0x220 [rtw89_core]
  process_one_work+0x82d/0x1450
  worker_thread+0x49e/0xd00
  kthread+0x313/0x640
  ret_from_fork+0x221/0x300
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Found by Linux Verification Center (linuxtesting.org).

Fixes: ebfc9199df05 ("wifi: rtw89: add wiphy_lock() to work that isn't held wiphy_lock() yet")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

The whole log is attached below.  The issue itself which triggers SER
activity is quite reliably reproduced on my side when VM is booted with
passthrough rtw89_8852be (vfio-pci) and debugger enabled.  The card then
recovers and works without visible failures.

[    8.085405] rtw89_8852be 0000:00:05.0: loaded firmware rtw89/rtw8852b_fw-1.bin
[    8.319767] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[    8.391400] rtw89_8852be 0000:00:05.0: Firmware version 0.29.128.0 (418a672d), cmd version 0, type 5
[    8.392051] rtw89_8852be 0000:00:05.0: Firmware version 0.29.128.0 (418a672d), cmd version 0, type 3
[    8.554083] systemd-tmpfile (252) used greatest stack depth: 24152 bytes left
[    8.834526] rtw89_8852be 0000:00:05.0: chip rfe_type is 1
[    8.920602] rtw89_8852be 0000:00:05.0: rfkill hardware state changed to enable
[    8.943191] rtw89_8852be 0000:00:05.0 wlp0s5: renamed from wlan0
...
[   50.425636] rtw89_8852be 0000:00:05.0: FW status = 0x1e001500
[   50.426438] rtw89_8852be 0000:00:05.0: FW BADADDR = 0x40000000
[   50.427084] rtw89_8852be 0000:00:05.0: FW EPC/RA = 0xb898fc27
[   50.427746] rtw89_8852be 0000:00:05.0: FW MISC = 0xb898cd8b
[   50.428664] rtw89_8852be 0000:00:05.0: R_AX_HALT_C2H = 0x10002020
[   50.429642] rtw89_8852be 0000:00:05.0: R_AX_SER_DBG_INFO = 0xf00000b2
[   50.430506] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a7451
[   50.431947] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a7451
[   50.432903] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a7451
[   50.433730] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a744d
[   50.434511] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a744d
[   50.435319] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a7451
[   50.436074] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a744d
[   50.436774] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a744b
[   50.437537] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a7449
[   50.438388] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a744b
[   50.439409] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a7451
[   50.440222] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a744d
[   50.440945] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a744f
[   50.441567] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a7449
[   50.442312] rtw89_8852be 0000:00:05.0: [ERR]fw PC = 0xb89a7453
[   50.442974] rtw89_8852be 0000:00:05.0: --->
               err=0x5000
[   50.443712] rtw89_8852be 0000:00:05.0: R_AX_SER_DBG_INFO =0xf00000b2
[   50.444460] rtw89_8852be 0000:00:05.0: R_AX_SER_DBG_INFO =0xf00000b2
[   50.445306] rtw89_8852be 0000:00:05.0: DBG Counter 1 (R_AX_DRV_FW_HSK_4)=0xdeadbeef
[   50.446235] rtw89_8852be 0000:00:05.0: DBG Counter 2 (R_AX_DRV_FW_HSK_5)=0xdeadbeef
[   50.447035] rtw89_8852be 0000:00:05.0: R_AX_DMAC_ERR_ISR=0x00000000
[   50.447746] rtw89_8852be 0000:00:05.0: R_AX_DMAC_ERR_IMR=0xffffffff
[   50.448504] rtw89_8852be 0000:00:05.0: R_AX_CMAC_ERR_ISR [0]=0x00000000
[   50.449434] rtw89_8852be 0000:00:05.0: R_AX_CMAC_FUNC_EN [0]=0xf000003f
[   50.450266] rtw89_8852be 0000:00:05.0: R_AX_CK_EN [0]=0xffffffff
[   50.451150] rtw89_8852be 0000:00:05.0: R_AX_CMAC_ERR_IMR [0]=0xffffffff
[   50.452232] rtw89_8852be 0000:00:05.0: [CMAC] : CMAC1 not enabled
[   50.453025] rtw89_8852be 0000:00:05.0: R_AX_RPQ_RXBD_IDX =0x00250025
[   50.453737] rtw89_8852be 0000:00:05.0: R_AX_DBG_ERR_FLAG=0x10000000
[   50.454552] rtw89_8852be 0000:00:05.0: R_AX_LBC_WATCHDOG=0x00000081
[   50.455365] rtw89_8852be 0000:00:05.0: <---
[   50.455926] rtw89_8852be 0000:00:05.0: SER catches error: 0x5000

[   50.457154] ======================================================
[   50.458143] WARNING: possible circular locking dependency detected
[   50.458981] 6.17.0-rc2 #17 Not tainted
[   50.459746] ------------------------------------------------------
[   50.460561] kworker/u32:1/61 is trying to acquire lock:
[   50.461305] ffff88811bc00768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ser_state_run+0x5e/0x180 [rtw89_core]
[   50.462629] 
               but task is already holding lock:
[   50.463449] ffffc9000048fd30 ((work_completion)(&ser->ser_hdl_work)){+.+.}-{0:0}, at: process_one_work+0x7b5/0x1450
[   50.464934] 
               which lock already depends on the new lock.

[   50.466034] 
               the existing dependency chain (in reverse order) is:
[   50.467040] 
               -> #2 ((work_completion)(&ser->ser_hdl_work)){+.+.}-{0:0}:
[   50.468133]        process_one_work+0x7c6/0x1450
[   50.468797]        worker_thread+0x49e/0xd00
[   50.469381]        kthread+0x313/0x640
[   50.469938]        ret_from_fork+0x221/0x300
[   50.470523]        ret_from_fork_asm+0x1a/0x30
[   50.471179] 
               -> #1 ((wq_completion)phy0){+.+.}-{0:0}:
[   50.472038]        touch_wq_lockdep_map+0x8e/0x180
[   50.472524]        __flush_workqueue+0x129/0x10d0
[   50.473112]        ieee80211_stop_device+0xa8/0x110
[   50.473680]        ieee80211_do_stop+0x14ce/0x2880
[   50.474411]        ieee80211_stop+0x13a/0x2c0
[   50.474905]        __dev_close_many+0x18f/0x510
[   50.475362]        __dev_change_flags+0x25f/0x670
[   50.475950]        netif_change_flags+0x7b/0x160
[   50.476461]        do_setlink.isra.0+0x1640/0x35d0
[   50.477007]        rtnl_newlink+0xd8c/0x1d30
[   50.477453]        rtnetlink_rcv_msg+0x700/0xb80
[   50.478073]        netlink_rcv_skb+0x11d/0x350
[   50.478558]        netlink_unicast+0x49a/0x7a0
[   50.479064]        netlink_sendmsg+0x759/0xc20
[   50.479511]        ____sys_sendmsg+0x812/0xa00
[   50.479992]        ___sys_sendmsg+0xf7/0x180
[   50.480423]        __sys_sendmsg+0x11f/0x1b0
[   50.480933]        do_syscall_64+0xbb/0x360
[   50.481356]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   50.481959] 
               -> #0 (&rdev->wiphy.mtx){+.+.}-{4:4}:
[   50.482578]        __lock_acquire+0x124c/0x1d20
[   50.483072]        lock_acquire+0x154/0x2e0
[   50.483490]        __mutex_lock+0x17b/0x12f0
[   50.483963]        ser_state_run+0x5e/0x180 [rtw89_core]
[   50.484518]        rtw89_ser_hdl_work+0x119/0x220 [rtw89_core]
[   50.485149]        process_one_work+0x82d/0x1450
[   50.485620]        worker_thread+0x49e/0xd00
[   50.486092]        kthread+0x313/0x640
[   50.486484]        ret_from_fork+0x221/0x300
[   50.486958]        ret_from_fork_asm+0x1a/0x30
[   50.487419] 
               other info that might help us debug this:

[   50.488290] Chain exists of:
                 &rdev->wiphy.mtx --> (wq_completion)phy0 --> (work_completion)(&ser->ser_hdl_work)

[   50.489752]  Possible unsafe locking scenario:

[   50.490351]        CPU0                    CPU1
[   50.490866]        ----                    ----
[   50.491320]   lock((work_completion)(&ser->ser_hdl_work));
[   50.491951]                                lock((wq_completion)phy0);
[   50.492622]                                lock((work_completion)(&ser->ser_hdl_work));
[   50.493459]   lock(&rdev->wiphy.mtx);
[   50.493884] 
                *** DEADLOCK ***

[   50.494467] 2 locks held by kworker/u32:1/61:
[   50.494969]  #0: ffff888103835148 ((wq_completion)phy0){+.+.}-{0:0}, at: process_one_work+0xefa/0x1450
[   50.495919]  #1: ffffc9000048fd30 ((work_completion)(&ser->ser_hdl_work)){+.+.}-{0:0}, at: process_one_work+0x7b5/0x1450
[   50.497017] 
               stack backtrace:
[   50.497459] CPU: 0 UID: 0 PID: 61 Comm: kworker/u32:1 Not tainted 6.17.0-rc2 #17 PREEMPT(voluntary) 
[   50.497465] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS edk2-20250523-14.fc42 05/23/2025
[   50.497470] Workqueue: phy0 rtw89_ser_hdl_work [rtw89_core]
[   50.497503] Call Trace:
[   50.497506]  <TASK>
[   50.497509]  dump_stack_lvl+0x5d/0x80
[   50.497517]  print_circular_bug.cold+0x178/0x1be
[   50.497525]  check_noncircular+0x14c/0x170
[   50.497535]  __lock_acquire+0x124c/0x1d20
[   50.497543]  ? ret_from_fork_asm+0x1a/0x30
[   50.497550]  lock_acquire+0x154/0x2e0
[   50.497555]  ? ser_state_run+0x5e/0x180 [rtw89_core]
[   50.497586]  ? ser_state_run+0x5e/0x180 [rtw89_core]
[   50.497610]  __mutex_lock+0x17b/0x12f0
[   50.497616]  ? ser_state_run+0x5e/0x180 [rtw89_core]
[   50.497643]  ? srso_alias_return_thunk+0x5/0xfbef5
[   50.497648]  ? __lock_acquire+0xcc3/0x1d20
[   50.497654]  ? __pfx___mutex_lock+0x10/0x10
[   50.497662]  ? srso_alias_return_thunk+0x5/0xfbef5
[   50.497676]  ? do_raw_spin_lock+0x128/0x260
[   50.497680]  ? find_held_lock+0x2b/0x80
[   50.497688]  ? ser_state_run+0x5e/0x180 [rtw89_core]
[   50.497713]  ser_state_run+0x5e/0x180 [rtw89_core]
[   50.497740]  rtw89_ser_hdl_work+0x119/0x220 [rtw89_core]
[   50.497768]  process_one_work+0x82d/0x1450
[   50.497779]  ? __pfx_process_one_work+0x10/0x10
[   50.497784]  ? srso_alias_return_thunk+0x5/0xfbef5
[   50.497791]  ? srso_alias_return_thunk+0x5/0xfbef5
[   50.497795]  ? assign_work+0x167/0x240
[   50.497799]  ? srso_alias_return_thunk+0x5/0xfbef5
[   50.497805]  worker_thread+0x49e/0xd00
[   50.497816]  ? __pfx_worker_thread+0x10/0x10
[   50.497820]  kthread+0x313/0x640
[   50.497827]  ? __pfx_kthread+0x10/0x10
[   50.497830]  ? ret_from_fork+0x18/0x300
[   50.497836]  ? srso_alias_return_thunk+0x5/0xfbef5
[   50.497840]  ? lock_release+0xc6/0x2c0
[   50.497845]  ? __pfx_kthread+0x10/0x10
[   50.497851]  ret_from_fork+0x221/0x300
[   50.497855]  ? __pfx_kthread+0x10/0x10
[   50.497860]  ret_from_fork_asm+0x1a/0x30
[   50.497871]  </TASK>
[   50.565573] rtw89_8852be 0000:00:05.0: firmware failed to ack for leaving ps mode
[   50.876040] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 57471994482 wd_nsec: 502738831
[   53.429036] rtw89_8852be 0000:00:05.0: c2h reg timeout
[   53.480222] rtw89_8852be 0000:00:05.0: rtw89: failed to leave lps state
[   53.483649] rtw89_8852be 0000:00:05.0: FW backtrace invalid key: 0x66383938
[   53.699956] ieee80211 phy0: Hardware restart was requested


 drivers/net/wireless/realtek/rtw89/ser.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index bb39fdbcba0d..6c0a13a854f6 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -205,7 +205,6 @@ static void rtw89_ser_hdl_work(struct work_struct *work)
 
 static int ser_send_msg(struct rtw89_ser *ser, u8 event)
 {
-	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
 	struct ser_msg *msg = NULL;
 
 	if (test_bit(RTW89_SER_DRV_STOP_RUN, ser->flags))
@@ -221,7 +220,7 @@ static int ser_send_msg(struct rtw89_ser *ser, u8 event)
 	list_add(&msg->list, &ser->msg_q);
 	spin_unlock_irq(&ser->msg_q_lock);
 
-	ieee80211_queue_work(rtwdev->hw, &ser->ser_hdl_work);
+	schedule_work(&ser->ser_hdl_work);
 	return 0;
 }
 
-- 
2.50.1


