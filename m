Return-Path: <linux-wireless+bounces-17104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D68A0226E
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 11:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FAB161E5E
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF11D8E07;
	Mon,  6 Jan 2025 10:03:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B761B87FF
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157809; cv=none; b=FJrBbyFHVuCs8i0N9R5mRrO5XltDlG6LR7qUgHe+xw+vl/K66TNsQ3zWWTJSyKf/y80YFpO1fAzj34S9M55Lmr+1+az7485KJyh0y0cEjPqqYWo1nabhrMBlhO8vf5fn2qxbWAqsvLz4ZvpGkX0ILaxX6xXnDI0cTAfrU91AVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157809; c=relaxed/simple;
	bh=5rZA87sgaSizDUAhMWe2cGkjlGEgg0xeoXJfyWjS474=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FX6Z3mmf503LzrKiguRhAyfqgGKxAgqRhOj9j2BVqi5/5NNSzpgVSwaCPLf/41W2HYM2i43faafUNtDKl+44eLJGWK4ku0MSVZa2b99u+vghYoazUolhlfpo9hOd6p+jiucSS873S5iY9CmidOrKmAomE5NW12cQ4cWnEXs236U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a9d195e6e5so128421205ab.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2025 02:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157806; x=1736762606;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwgJxPTUKSF4qMLpX2DkfpWAh4DxTz/ZHzgWcnT+2Tk=;
        b=xQWRhOeGVo6kVT2d+H4ZHerofRIhTz85WC9YHkXCiR1oMCLkm0AO37S/lmEXjGWJLi
         Ny2u9nGHAxdJ+rPMNoB+IIrojUDH9ZuUKYE9WrxB8UAS7ilqaw+ORstv+8LURd9We0Od
         5Fa5dLcHBxE0ESRBsadtEC3mfjCKkKMeMJ0+o5pcCfgRz9MXJLN1ubF3U7/GWcp87tMM
         AQ0IibXdcATyqgNSyxtOEcOXv8pr1PmkKLLy0tfa4xXgo9E4OfGXq08idAs6BL4X43vy
         S5RmMhgn973h4Y/vppoVwMa1QVOTVv3AYEWoCXO9ntuzUxT451Goga+Ct2753KMibym5
         g7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXYUyNHEcvZn6ryqsieMoz4741gfRmU24KwJUqJMNpnqoZwlcw9+iAkfmIlqyqweEQSL4YoLFApM2c3BnNgig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRTWoVpDs7kpJnojSzVm8oL8vLIGEtZmlR+e243Y4I2CQX+K5
	dZW5QUN3bmyO76isAYUZL9DyFQ6edl/P3TeA1fIbCS9Go5eswxVdUjPpWyYreV/31qry1kaQP/d
	KDtOL6gx5AR+QGTCNm+anB/m9p1vlb7SVrbhhIHssz4l/Pr7Nlluc9ks=
X-Google-Smtp-Source: AGHT+IHxGXPVKZrj2VpZjzaFaHlqwrxC7rrNNtc3hFkYAwGi2M46OrDfHFQpRKaDcq/NdmKszv4Z4T1+hmU0zc33iSOsG5WNS11o
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194c:b0:3a7:7811:1101 with SMTP id
 e9e14a558f8ab-3c2d53403b3mr548640155ab.20.1736157805822; Mon, 06 Jan 2025
 02:03:25 -0800 (PST)
Date: Mon, 06 Jan 2025 02:03:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677baa6d.050a0220.a40f5.0009.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING: ODEBUG bug in __mod_timer (2)
From: syzbot <syzbot+50abac586029cf8758e0@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a2d6df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
dashboard link: https://syzkaller.appspot.com/bug?extid=50abac586029cf8758e0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d24eb225cff7/disk-ccb98cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dd81532f8240/vmlinux-ccb98cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18b08e4bbf40/bzImage-ccb98cce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50abac586029cf8758e0@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object: ffff888068a59b28 object type: timer_list hint: ieee80211_ibss_timer+0x0/0x90
WARNING: CPU: 0 PID: 7396 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Modules linked in:
CPU: 0 UID: 0 PID: 7396 Comm: kworker/u8:11 Not tainted 6.13.0-rc5-syzkaller-00004-gccb98ccef0e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd e0 81 b1 8b 41 56 4c 89 e6 48 c7 c7 60 76 b1 8b e8 5f 4d bc fc 90 <0f> 0b 90 90 58 83 05 c6 4f 7f 0b 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0000:ffffc900045ef7c8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000005 RCX: ffffffff815a1789
RDX: ffff88807ea2da00 RSI: ffffffff815a1796 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8bb17d40
R13: ffffffff8b4f81a0 R14: ffffffff8a928850 R15: ffffc900045ef888
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f19769f4d58 CR3: 0000000032a52000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_assert_init+0x1ee/0x2f0 lib/debugobjects.c:1020
 debug_timer_assert_init kernel/time/timer.c:845 [inline]
 debug_assert_init kernel/time/timer.c:890 [inline]
 __mod_timer+0xae/0xdc0 kernel/time/timer.c:1071
 ieee80211_sta_merge_ibss net/mac80211/ibss.c:1272 [inline]
 ieee80211_ibss_work+0x481/0x14c0 net/mac80211/ibss.c:1672
 ieee80211_iface_work+0xd01/0xf00 net/mac80211/iface.c:1689
 cfg80211_wiphy_work+0x3de/0x560 net/wireless/core.c:440
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

