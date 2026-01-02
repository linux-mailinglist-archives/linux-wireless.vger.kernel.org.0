Return-Path: <linux-wireless+bounces-30279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B32DCEE2A8
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 11:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5710300091D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E682DA76B;
	Fri,  2 Jan 2026 10:28:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D372DA749;
	Fri,  2 Jan 2026 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767349728; cv=none; b=FT5fTYqW8tsWUtd65mz94qBE02ioKF0OGzn1vjDKZoaESfZJ1lnHMR2ppPwWtK9nbXCgwrhNIoHm6nbFmL2B2ViKEdXw4ZsFu1rl1YS/ePuremvHdPcjGLFEFSrMtJjbH70RkTRgv5aQpplUDZ+qPhA2jL1P6mDMd35NarktNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767349728; c=relaxed/simple;
	bh=V/sqwXHm2sJeqHpSG4R8qtwl8OvnE0heO4RGb+KaupI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6Af2JFwzHBWWShY67zmoFQdU0BMzj40ZHJ9aMdc+X2BhDzmNIOcl+gSK67XhmCL2VVQ02iJO+JJc5kiGGLeOw48gsmDscKa+DxUIoiHWCIZ+cuVAyldmpY9Fvr4cq8CwgrwrzT7U4JndQW9y2kR5TNkYWMOP5v1/jz4f56Xnz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 602ASPBK050190;
	Fri, 2 Jan 2026 19:28:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 602ASPDU050187
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 2 Jan 2026 19:28:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <27b1ec67-cb85-4673-b6f2-00003c705b8f@I-love.SAKURA.ne.jp>
Date: Fri, 2 Jan 2026 19:28:25 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [wireless?] WARNING in rfkill_unregister
To: Johannes Berg <johannes@sipsolutions.net>,
        syzbot <syzbot+16210d09509730207241@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: Krzysztof Kozlowski <krzk@kernel.org>
References: <6955cbd5.050a0220.a1b6.032d.GAE@google.com>
 <e062f6a0a7583ca99ab0449481119634f8b02a3d.camel@sipsolutions.net>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <e062f6a0a7583ca99ab0449481119634f8b02a3d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp

On 2026/01/01 21:07, Johannes Berg wrote:
> If this email doesn't wake anyone up, I'll do that on the next syzbot
> rfkill vs. NFC report I get :)

Is the next report https://syzkaller.appspot.com/bug?extid=ef8f802abdb9a32343fc ?

Obviously deadlocked (but lockdep cannot report due to dev->mutex being marked as novalidate).

INFO: task syz.4.1326:10654 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.1326      state:D stack:27848 pid:10654 tgid:10645 ppid:5823   task_flags:0x400040 flags:0x00080002
Call Trace:
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 rfkill_unregister+0xc8/0x220 net/rfkill/core.c:1145
 nfc_unregister_device+0x96/0x300 net/nfc/core.c:1167
 virtual_ncidev_close+0x56/0x90 drivers/nfc/virtual_ncidev.c:172
 __fput+0x44c/0xa70 fs/file_table.c:468
 fput_close_sync+0x113/0x220 fs/file_table.c:573
 __do_sys_close fs/open.c:1573 [inline]
 __se_sys_close fs/open.c:1558 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1558
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
2 locks held by syz.4.1326/10654:
 #0: ffff888078c13100 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:895 [inline]
 #0: ffff888078c13100 (&dev->mutex){....}-{4:4}, at: nfc_unregister_device+0x63/0x300 net/nfc/core.c:1165
 #1: ffffffff8f5fd668 (rfkill_global_mutex){+.+.}-{4:4}, at: rfkill_unregister+0xc8/0x220 net/rfkill/core.c:1145

INFO: task syz.3.1329:10652 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.1329      state:D stack:26824 pid:10652 tgid:10651 ppid:5820   task_flags:0x400140 flags:0x00080002
Call Trace:
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 device_lock include/linux/device.h:895 [inline]
 nfc_dev_down+0x3b/0x290 net/nfc/core.c:143
 nfc_rfkill_set_block+0x2d/0x100 net/nfc/core.c:179
 rfkill_set_block+0x1d2/0x440 net/rfkill/core.c:346
 rfkill_fop_write+0x44b/0x570 net/rfkill/core.c:1301
 vfs_write+0x27e/0xb30 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
2 locks held by syz.3.1329/10652:
 #0: ffffffff8f5fd668 (rfkill_global_mutex){+.+.}-{4:4}, at: rfkill_fop_write+0x191/0x570 net/rfkill/core.c:1293
 #1: ffff888078c13100 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:895 [inline]
 #1: ffff888078c13100 (&dev->mutex){....}-{4:4}, at: nfc_dev_down+0x3b/0x290 net/nfc/core.c:143



