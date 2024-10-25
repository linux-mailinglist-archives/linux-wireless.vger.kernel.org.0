Return-Path: <linux-wireless+bounces-14526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A854F9B03FF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 15:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387441F23D5D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C065252F76;
	Fri, 25 Oct 2024 13:27:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CABA212175
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862855; cv=none; b=Opv5ngAmO9+3vZ9AEEVxoCmo8cVBS7GYU+gTl6ozNVyXwEUVHhdVutEfdj6rML0RqzHvf0r736SWkRWzZ2lIFAz1RvvPOBvJP9G7nQrzr6HAHWwE0Y1nlMpy3SgHnUzCeNd75azL7zf9m5OA91aidWMXXLjMTvyYY3NZjBXQh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862855; c=relaxed/simple;
	bh=oUV8wQiwOT/Q5ELHbMxxJrivvMlAW06NvgN72SyZUwI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=opKBeiZs7Zg04foWgEHuuSFYPPoXZCGWwbOcCv/OEAkI1gNit0ofCLVn+X8b5lNdQUqaXl0ign5jAuqv9jCD5nZchoxfnr9z+xMsE+dO0Z5+NqIU/4pC4IYVbvowch8X8z7yfMg9lvHhwureSRlZu6N/USU6tpS5Eh8Us73KHKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b7b13910so17763285ab.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 06:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862853; x=1730467653;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDeAzHo2o+cjRMDUBSDU3PUYawCjPuEVtUK2fecNhEY=;
        b=tqvLqUDFX7xSjRg0juW75r5gHs3BQ3wkCUb/jqqth74w7NcrS6lX61DZsPUdIXNTiB
         qK0bX8EUkBjpEeG8LzKDw/7WLP1Mx9hnIZqF04ChvtoPkOK7XZld2hUfffo9tz68wJrq
         6oX2uNu0Nupdgu/v4+inIGEkbCII/NTptmVxavCT040zRxiXjpwxCfQbN19sbGQB94Ts
         Y2Cqj3Wfefn35V+Jci9sxWPhHnN9RSX09/ZKPs0V8TV+DgIKVx/6HxiPBowV2vnRePfs
         kmdIPkHgWjVt7RvpNFO6hVt0ZjwE2pt0cDiaa1YFZzc2TectgwYA7Bex75C0O8urfIHj
         HTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMhWFW2NB4A2SvSZ+ywH08ujLJ/oQnej8bQRHBV7ADS531YygzQjlG4MKcL9cppwL5h83heskue1OIfIBg9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrscLw7L3qboN29S5NTdgStCxhlumZ9BJKe88e0WTcskp8As2
	2OXwU7t0HQgyya6uBMpWAV8Jml6SUMWHMp0l8O5XlmeK445j+ffHQkRwebp6Lb/qcmxC47PiAJM
	uoTiMV0cDrS0BmWVM7LZHE1+i9yUcvDo0AoreGqellWlcuftpeJaaMnc=
X-Google-Smtp-Source: AGHT+IH9vsZfI7/60PrcQK2GN7L69YH2Yjh6F4BS7JS1U9SOJl9n0gQLnfC0dxFsBnl8UYekkDqnBft2l68Dkhs1CUMbX/4YomaO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4b:b0:3a0:979d:843 with SMTP id
 e9e14a558f8ab-3a4de79db8cmr63910235ab.9.1729862852818; Fri, 25 Oct 2024
 06:27:32 -0700 (PDT)
Date: Fri, 25 Oct 2024 06:27:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b9cc4.050a0220.2e773.0004.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING: ODEBUG bug in _cfg80211_unregister_wdev
From: syzbot <syzbot+66941b4fb1cdd6585c62@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    42f7652d3eb5 Linux 6.12-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c3e430580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=66941b4fb1cdd6585c62
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ed847da7e5cc/disk-42f7652d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/66c7a2b66b5b/vmlinux-42f7652d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9878229c04ae/bzImage-42f7652d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+66941b4fb1cdd6585c62@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: ffff888061cc0600 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 4423 at lib/debugobjects.c:517 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 UID: 0 PID: 4423 Comm: kworker/u8:7 Not tainted 6.12.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: netns cleanup_net
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
Code: e8 9b 5e 3b fd 4c 8b 0b 48 c7 c7 a0 0b 61 8c 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 1b 93 92 fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 a4 e2 59 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc9000cd37578 EFLAGS: 00010286
RAX: 29d90125cddd4800 RBX: ffffffff8c0be6e0 RCX: ffff888032333c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8c610d20 R08: ffffffff8155e402 R09: fffffbfff1cf9fe0
R10: dffffc0000000000 R11: fffffbfff1cf9fe0 R12: 0000000000000001
R13: ffffffff8c610c38 R14: dffffc0000000000 R15: ffff888061cc0600
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555c3b808 CR3: 00000000652c6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_activate+0x357/0x510 lib/debugobjects.c:732
 debug_rcu_head_queue kernel/rcu/rcu.h:224 [inline]
 kvfree_call_rcu+0x99/0x790 kernel/rcu/tree.c:3801
 _cfg80211_unregister_wdev+0x347/0x560 net/wireless/core.c:1238
 ieee80211_remove_interfaces+0x4db/0x700 net/mac80211/iface.c:2300
 ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1669
 mac80211_hwsim_del_radio+0x2c4/0x4c0 drivers/net/wireless/virtual/mac80211_hwsim.c:5625
 hwsim_exit_net+0x5c1/0x670 drivers/net/wireless/virtual/mac80211_hwsim.c:6505
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:626
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

