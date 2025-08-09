Return-Path: <linux-wireless+bounces-26232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C34B1F40B
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Aug 2025 12:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D726A566CE5
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Aug 2025 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27953248F75;
	Sat,  9 Aug 2025 10:09:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824622258E
	for <linux-wireless@vger.kernel.org>; Sat,  9 Aug 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754734169; cv=none; b=VXm4unvFCv7lOMDbVmThQi4Ykc6gJQ6mp9NJRFIUgOFJ+z4mndCc9yxXx5CSqXgfFp6njqMjP2Su4+9agaGCAq6wY6E9AnBMoZdRRNExWkr8jDrDGVLVVxS+e3vGF2kzepEQyd/OKyGWhRVlwz1E5LQzxlO7t9DimX6Gb+8m0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754734169; c=relaxed/simple;
	bh=UfVDSP4tIy+sLTTalushrExNwVMUpip9xKfPEYvuhfo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RbAWk8XT3XexsLcXoQTX8vM5wSOTXWdoEmhpzkf1soJRb6f86FJwr5il0gsHGW+IkVTDqlOAfJ3KPl2yJ3HmG0NaLjuqsTUkMd2D4UBrzhnOvyqO7H90N0NdNIbIZa4ZHLGg5TJwjy0BtxlzwNjZ83ypyD6ng/8dpcVGZrfkbLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e53c0bfa8bso8487515ab.2
        for <linux-wireless@vger.kernel.org>; Sat, 09 Aug 2025 03:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754734166; x=1755338966;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t51EWKdiMX8nQRomsdgyFHzvsopLtn3pV7NsndEVukY=;
        b=V3E4fYjQbZvWJabJvDcc+NaUlKaZUd9D0Jnbu87vjUO6SQDnBIU5TztAtxyyNT/v+p
         uz+3nzrK3kSaBLzJbzQ4VYcQAWl+Z1NBI0yID3kmYxE7VsDLwQrZAt72c6eUPCYj94oq
         L/diAwNSASjmU22qDYrnhA/fqmpQkepCduftL5f/bQk/vDS0J/Qs6MrMKhF9eEvI18C0
         7tPG9s7rauQ/r/dC5lItnlWw0Oly0oPbyLF28AwqdfUcy4rD9koWycJAulY16ZXiRbNF
         5LQrBg+BxN7JMLsbF3cBEzeieaIdXXdLbHQEsRh/QsevCLv0aIdH1vy5X8FtXSnQPr5D
         BdGg==
X-Forwarded-Encrypted: i=1; AJvYcCVFOEcXK6pr5XV0RpZRRSl25SueKcPCpOxC3h/m/oWUruv+K11rMfw31uX9wA47oL3GPg7QkDPTBbA/l8NTdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yydy0gD91a33JqCEMtDaQtQw3ue97KqYytl4pHj0byUdJOL9tO7
	61RJMCNKxTuX8viHeOiY8Kgn5yLFU9UtK/J8KN6JJl2XCw6lKiE3eY852iATmHFnH4rt4bAaqQ/
	a0zU/Y3gFnCV0Thorq73nh5/U8mwrC1gFZkA/Td18fc7LSeRyYz8SutlXbuA=
X-Google-Smtp-Source: AGHT+IGjJNcZOEDHQQseb3CPm4CzDqqSikXlC+huCp9wdB3KnMfVdDqcLNqnUzd1KP0JNZFs++TQ2wlXBLHuOr+oV/byGlYd5fmJ
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:3e3:d7e9:f305 with SMTP id
 e9e14a558f8ab-3e5331e7a5amr123556025ab.21.1754734166615; Sat, 09 Aug 2025
 03:09:26 -0700 (PDT)
Date: Sat, 09 Aug 2025 03:09:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68971e56.a70a0220.7865.0031.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_free_keys (2)
From: syzbot <syzbot+de3ee5362db09487ea37@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d2eedaa3909b Merge tag 'rtc-6.17' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178886a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75e522434dc68cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=de3ee5362db09487ea37
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/73ccac85e612/disk-d2eedaa3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/33b13def715b/vmlinux-d2eedaa3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/930b192c99ba/bzImage-d2eedaa3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de3ee5362db09487ea37@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 12058 at net/mac80211/key.c:1163 ieee80211_free_keys+0x536/0x650 net/mac80211/key.c:1162
Modules linked in:
CPU: 0 UID: 0 PID: 12058 Comm: kworker/u8:17 Not tainted 6.16.0-syzkaller-11489-gd2eedaa3909b #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:ieee80211_free_keys+0x536/0x650 net/mac80211/key.c:1162
Code: 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 f9 3c c7 f6 90 0f 0b 90 e9 46 fc ff ff e8 eb 3c c7 f6 90 <0f> 0b 90 4c 8b 24 24 e9 7c fe ff ff e8 d9 3c c7 f6 e9 2f fe ff ff
RSP: 0000:ffffc90004aff040 EFLAGS: 00010293
RAX: ffffffff8af86d55 RBX: dffffc0000000000 RCX: ffff88802bd2da00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffc90004aff0f0 R08: ffffc90004afede7 R09: 1ffff9200095fdbc
R10: dffffc0000000000 R11: fffff5200095fdbd R12: 0000000000000002
R13: ffff8880534569d0 R14: 1ffff1100a68ad3a R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125c28000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcb75946040 CR3: 000000007e27c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_do_stop+0xf47/0x1fb0 net/mac80211/iface.c:584
 ieee80211_stop+0x1b1/0x240 net/mac80211/iface.c:814
 __dev_close_many+0x361/0x6f0 net/core/dev.c:1755
 netif_close_many+0x225/0x410 net/core/dev.c:1780
 netif_close+0x158/0x210 net/core/dev.c:1797
 dev_close+0x10a/0x220 net/core/dev_api.c:220
 cfg80211_shutdown_all_interfaces+0xd4/0x220 net/wireless/core.c:277
 ieee80211_remove_interfaces+0x109/0x6e0 net/mac80211/iface.c:2364
 ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1664
 mac80211_hwsim_del_radio+0x275/0x460 drivers/net/wireless/virtual/mac80211_hwsim.c:5674
 hwsim_exit_net+0x584/0x640 drivers/net/wireless/virtual/mac80211_hwsim.c:6554
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x497/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

