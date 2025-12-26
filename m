Return-Path: <linux-wireless+bounces-30132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26711CDEF88
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 21:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B01E3007948
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8E31DE89A;
	Fri, 26 Dec 2025 20:18:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8072818A93F
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766780303; cv=none; b=fEtdVK3arEjdhIYZjbU7B/NQcdDdytshZArOXO9Uf6IbPffT944uYNxY9yGqU8ACYZyVcAo6ovWtFMFncVMiHR0T62EUuJf+4hOrXfa//QPae1U7lrQ01alFmAtx9yAqRYdAo6gAYPnq2GPbPBfkHMAxqNxjJOx2tgld6epqtOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766780303; c=relaxed/simple;
	bh=h0YW76HQwllrg9YcIJwv7iPn8tk4GGanDS1RnyjZpk0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xas2mVMI0KMViwTL5KGoDOR8pbdirjVas6cXtWz6z4edKdkXphdkHW18YIq708MSQGVRqQAXDJdJz6wOBjSg1PyNSYg+Dlq5GzW2lZHezRlTGd9DnuBGhRfiCK5WNx/+UcVELtA3UwJKttL5R6yjBVFldgiLT43H5/bMMNJNiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-3f524bd05bbso11788614fac.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 12:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766780300; x=1767385100;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjRWRRVLWipGhq2BVAZRGHCxff3tGCAwhsSHVuG/gag=;
        b=O+QIhm6xPiENrnqVesuPxKUe4jxBOkDAg1YIhwy+slcYm52ASZ84sqk0xgIDBGIn6W
         TmIfOjnLRuSfjnsILF9W43FFhmpZo2GnN/bm6wtudBomiFCkzr/PZt8UspVNjCiFf1eS
         QnKYu7uMW3er1hXyHaVlNKE2ToXDMgWkOeWn1DYbwIYKO38leYy+8ASn4PjO4DqBN420
         SItPAppdGLVCvSxuh60si24XSV05SYEyPTJ25G5eyOUuJmMpbU7vnpT2/0WOcTJiFSSw
         kj3jwwgCDjl/6n8Ye6SFgI3hsCPs/TRgEuTHb68j/UcXZGzQi+JwYJ/KJ/7rj8qo1HiY
         kP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNrhPFg12i79WLQih9QcWfuu4XDl3647w24484b9XpZhtbyLpu3L5eTtON2Txsr7aGyvUWvDKq1h+m5TljSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOep3G1Bs6JwGjXzZAaBvDBC62pF9A/k32n62lsuZ3OvjwMgV
	f2HY+5et49mEcPiJEOHAf1LGZX8YGQFuz7l9ApS3ocySLCkjGsuDpTOK4aRbFoXVJ8FD4UUStYq
	5catMuJvtG+TfDq7zAH+bhHwbi65pG2/ualNJPTUY3tAXGT1m92cwUAJbqPw=
X-Google-Smtp-Source: AGHT+IFXyIeEfOBRkqcawkdPNksH+hYqvS+uVDxBWbK6xd/oWHtUFibanaD4esGRhBvjiZsH2TedZty9VVvGxv7zp85Lyduw28DH
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2288:b0:65b:34e8:baab with SMTP id
 006d021491bc7-65d0ebeb877mr9909626eaf.72.1766780300579; Fri, 26 Dec 2025
 12:18:20 -0800 (PST)
Date: Fri, 26 Dec 2025 12:18:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694eed8c.050a0220.35954c.007c.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in reg_todo (4)
From: syzbot <syzbot+8f72a490f8e8879ee7e6@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9448598b22c5 Linux 6.19-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111ad392580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=8f72a490f8e8879ee7e6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1007c3c2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d4808a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/477361b600ee/disk-9448598b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d6a6291ae36e/vmlinux-9448598b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c0e810e0acf/bzImage-9448598b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f72a490f8e8879ee7e6@syzkaller.appspotmail.com

INFO: task kworker/0:0:9 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:23672 pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events reg_todo
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x149b/0x4fd0 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 reg_todo+0x1c/0xa60 net/wireless/reg.c:3189


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

