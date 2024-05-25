Return-Path: <linux-wireless+bounces-8062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A038CEEC6
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 13:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13C81C2092D
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28A3B297;
	Sat, 25 May 2024 11:48:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084237147
	for <linux-wireless@vger.kernel.org>; Sat, 25 May 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716637704; cv=none; b=BJ1qHm5Pe1lxv4ouPOkJqFDdRdlubkxQjLU+1VJgxG3ho8hMww0Uc9U6Xvj1PSw1Bm9MOhPPrlAcC9JNg+xJI73LJzNE1PsDhLUoJR6Sgakr6XVrc5UM3XJeGX1/hIpoeXtHwFzzFRquToo6uU3ddzOc0Wvghoxy99+f8jLqGmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716637704; c=relaxed/simple;
	bh=0qbYg6aOqdNGPthjuPeNfOsUkCVqJnS1vSrM7z/Xv4I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Am2Js5mCM5BWZHqyD0i9EG8F8tX91bpGeiVP1vSmV0tigKw2jypE1IkfbGGVW/oJ3mJ3OyUVvKa1hxvmx/BP1fY8uGdIvZgxMzOx/Nbgm2YTze5+IuUiFijwNEYHCB097LqDcWQ0W/olWusCXd6Ac67/bkENcuMpX7yElAy0/Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36da593c0faso39365645ab.0
        for <linux-wireless@vger.kernel.org>; Sat, 25 May 2024 04:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716637702; x=1717242502;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ktky9nzPSQla9DzbbACpPeWbHWXchC8XncDgsXpz46k=;
        b=ilQpTcz0NQTzHtrhxKaGoGdSbjeCfx9MVjRIhGV4VPyOU++4H06ai8P135e6TUr4Oh
         jY9JDhm0uZcFfnEUM8E8i8NTJ2048O3ZyaNDyNIVOWrxVJ6jhVsbnzNlXMzJQf1R9gW6
         zmCZdXpGtOWo6iUH8OCZJXjoGDSkuFBMVLuJGsXfep1Ku9l65mQmVK5QjxnhCaLcv2U3
         51NjVQfRcDmUnLt5xAZC/LCTyeDUMwcXLh/hp57MTSVMvV59H2jGzR2YiLxhc5Uy7r1q
         jIjuAN0Geaf9DOUvlnt7cD5tYjXT9HISE7DFJWlOV8Xfo4su7AxSdXz3RimMy32lrjk7
         SGDw==
X-Forwarded-Encrypted: i=1; AJvYcCUPxN9bwycR7cDcjEYekbBS37pLHeHgR3MYJn0Pz7SLrEcjRhxM0xwKtTnDFQM2js4BFJnW+bCb/Q8SiUkfrmLQJPcMhnSOgvZEYW5aAkg=
X-Gm-Message-State: AOJu0YwtuvZHGzKXMSWd/E4XNT41KwuEvZloUqGabdnnQFzfTAWtvNlb
	zjtQ0/c40yR4lvb/+spmtDln1f7TpUmrL6BsUDx72UGlUvLx61fvwSskIAifnH3HmX2flVMxP8r
	ypjQDZ7YipXi3vL5hpAX9sfb3sD0pkEGrTWPCQDf0Qw+oJKVDYEp/uTY=
X-Google-Smtp-Source: AGHT+IGe8h11cGjjZ/CIXvDVFFpXTvnx6rQVT5A5q3eStHc8rVFExwNMB7uUTqrJn4pa+s0Y7nGEwLfY3g11+x4u1p2Qpo0nx90g
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c566:0:b0:36c:5228:462 with SMTP id
 e9e14a558f8ab-3737b31cb5fmr3359085ab.3.1716637702796; Sat, 25 May 2024
 04:48:22 -0700 (PDT)
Date: Sat, 25 May 2024 04:48:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007bc4a8061945dc37@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in regdb_fw_cb
From: syzbot <syzbot+9d8f809bfaab2e794297@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f6a15f095a6 Merge tag 'cocci-for-6.10' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12363a34980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be91306a8917025
dashboard link: https://syzkaller.appspot.com/bug?extid=9d8f809bfaab2e794297
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/02867060d65d/disk-8f6a15f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4bb75fbf6fb1/vmlinux-8f6a15f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd38cadddf33/bzImage-8f6a15f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d8f809bfaab2e794297@syzkaller.appspotmail.com

INFO: task kworker/0:2:927 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:23760 pid:927   tgid:927   ppid:2      flags:0x00004000
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x4a00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 regdb_fw_cb+0x82/0x1c0 net/wireless/reg.c:1017
 request_firmware_work_func+0x1a4/0x280 drivers/base/firmware_loader/main.c:1167
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:5:5157 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

