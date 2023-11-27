Return-Path: <linux-wireless+bounces-125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C1B7FAAC6
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 21:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5596BB20E57
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BDB3FB39;
	Mon, 27 Nov 2023 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E935ADC
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 12:00:34 -0800 (PST)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-6cbb3512511so7532067b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 12:00:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701115234; x=1701720034;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0azJOGAh/8a7Fh8R1J/n4CdyDJCzGiGb4P2qXnwNlWM=;
        b=RYfEn9Go1W0Pb5PwVccUqJk+6cQPjqAjW/LoaBxY62ge3haQR3sB9/LyJYOVVwVchl
         N5qGq7cmxRwl0DjoxCj7Jf0oiPQ+O9IVyFc2U8gVjmqPh7T6KEzSrZrfT9Gk97AA6Y1H
         OsD8A+B6ka7X+iNUxbFe1Fir1rqPyt61tRu+aqxlgCcneMWpXEWoSXZQwk/NwIckX2AC
         /VmZxtd3jY3xIhjk+jTr5hK6FKRfb0XAfNaGr1rDhbkvIo59jUVo99aAbDcVx0FEn/ro
         TFaUWphe4YdbKQyWWvJW/nfhk8y+f42jpYbk7Qhexlt3FtrTFUihU0cvLZfPDKfCSmEw
         S23Q==
X-Gm-Message-State: AOJu0YycxKfQLXajzlVf069z9IVzSh5I4ANJh1ilCChDLHzwYFew4X9Q
	PnaXWWTYotxxwRoq3qqc+tZevRESrhfxYAPyXfpdR1UHDK1T
X-Google-Smtp-Source: AGHT+IHNoJt0YUyhpCusf9hCXy75ow1nLdqPVsVbiF8vBXGxrNh9GsR41ZAU7pS+gaeWhE5A0RY6Qkn8qo1uo+OU2GBJsW8A1gSL
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3911:b0:6c3:9efc:6833 with SMTP id
 fh17-20020a056a00391100b006c39efc6833mr3281206pfb.2.1701115234323; Mon, 27
 Nov 2023 12:00:34 -0800 (PST)
Date: Mon, 27 Nov 2023 12:00:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000439664060b27c19b@google.com>
Subject: [syzbot] [wireless?] WARNING in __cfg80211_bss_update
From: syzbot <syzbot+9c67d243461f9800f17b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b6de136b5f0 Merge tag 'loongarch-fixes-6.7-1' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118a257ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2a9d08825f82ef3
dashboard link: https://syzkaller.appspot.com/bug?extid=9c67d243461f9800f17b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25ab52a5f324/disk-9b6de136.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/324f600af6eb/vmlinux-9b6de136.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7f3148d7c5fb/bzImage-9b6de136.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c67d243461f9800f17b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1522 at net/wireless/scan.c:1692 cfg80211_combine_bsses net/wireless/scan.c:1692 [inline]
WARNING: CPU: 1 PID: 1522 at net/wireless/scan.c:1692 __cfg80211_bss_update+0x1cbc/0x24b0 net/wireless/scan.c:1877
Modules linked in:
CPU: 1 PID: 1522 Comm: kworker/u4:5 Not tainted 6.7.0-rc2-syzkaller-00029-g9b6de136b5f0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:cfg80211_combine_bsses net/wireless/scan.c:1692 [inline]
RIP: 0010:__cfg80211_bss_update+0x1cbc/0x24b0 net/wireless/scan.c:1877
Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 d5 02 00 00 48 b8 22 01 00 00 00 00 ad de 49 89 44 24 18 e9 02 f3 ff ff e8 05 21 b1 f7 90 <0f> 0b 90 e9 34 f0 ff ff e8 f7 20 b1 f7 48 8d 7b 98 e8 4e 73 ff ff
RSP: 0018:ffffc90005307568 EFLAGS: 00010283
RAX: 0000000000000ddf RBX: 0000000000000003 RCX: ffffc900146de000
RDX: 0000000000040000 RSI: ffffffff89d6692b RDI: 0000000000000000
RBP: ffff88807781e068 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88801ea9e800
R13: ffff88807781e000 R14: dffffc0000000000 R15: 0000000000000005
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31723000 CR3: 000000002993c000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 cfg80211_inform_single_bss_frame_data+0x768/0xf30 net/wireless/scan.c:2905
 cfg80211_inform_bss_frame_data+0xbf/0x290 net/wireless/scan.c:2936
 ieee80211_bss_info_update+0x300/0x8f0 net/mac80211/scan.c:205
 ieee80211_rx_bss_info net/mac80211/ibss.c:1098 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1577 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1973/0x3120 net/mac80211/ibss.c:1604
 ieee80211_iface_process_skb net/mac80211/iface.c:1589 [inline]
 ieee80211_iface_work+0xa67/0xda0 net/mac80211/iface.c:1643
 cfg80211_wiphy_work+0x24e/0x330 net/wireless/core.c:435
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
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

