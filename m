Return-Path: <linux-wireless+bounces-10088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BABB92AD26
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 02:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B0A282691
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 00:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54CB4A15;
	Tue,  9 Jul 2024 00:36:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF6197
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720485383; cv=none; b=KUGSrKLcnmwtQQ1K/J+flrcinUWwYbxChcbR0Kj0mF9ihIfr5qusYCXFhLb02VuoAl7e/y0OGKXnTVVi1zGlsssv33HwrkB/6W4CwduCZoKpZhIKLPnLA0LI8x4Xsx520u7IgZZZe1c6jNkjKZVwua21EfWdJzoR6UtQBaMVewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720485383; c=relaxed/simple;
	bh=8otHiJbE/VSdOupQC/73La9rg+QB5+G8BfHl1T3pUxg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K6FoGKR70tsRbP2pjjM7c2a0OmaTNaX+gERYl41hoQrYCNgKs/5q/Ci7bfpdS7Pw9+/fuRAdoGonwuCNSFVMPIb6tDo0JpKFV8cWtU4LWk1oVuaKnAAlhk+TqUGoevZJpGVsHJAouYmsBP5gT+nlrw85RBQ4aj1tUXlqxfwQrBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3835285561fso51321755ab.2
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jul 2024 17:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720485381; x=1721090181;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQ38Bd0kst9MLbWT6jyPb0KQ10UtFUksZmt6kSW4+Lc=;
        b=XwGPFjeZgD6z+RrEKtDf+dePI3JgrUgr9XTO4kc4fnM+aSu3ygB4AXIGkOECQ35+9Y
         F0NvunjdPhrYw48KterQYg9kxb7AlrXlXzGgBWfVfrFSlKfPKaSWyd4TJ480Nlua8TJN
         35mgftCNsRrWlRZ1lp8GYG7nt67f22MYslwqw3kMT3xtCV9KCf+4QY0BFo8Z06E9OguK
         ikwblj+c8ZolVmh4tjfyyLRJfTrXnwA73v3HnwwPMeRgxdLNkwX6iV1jRakF4hrM99qI
         oBdqxg9FGMqDLRqA026J7f4fg2MIfBlyskowAmYbXNMHh3IW5xobd8yNzQ2y9ePYXPOx
         KhCw==
X-Forwarded-Encrypted: i=1; AJvYcCX+z0e5RaTvpMcKcBd3PCMP/djk/N4nRCZhkql0anopmrmAnURGlWrBQawdzN8tdSvYzT4atM0lsL6BXHLI4aK8ohBe/1JO2EkDhumga0A=
X-Gm-Message-State: AOJu0YyXefSfWiZF1ElOZAcqf/MVYI07M7G7gBLEORtVf5AzW33CcYl4
	xp2SZtxIssj4A0Z/e2FYkMTZB5H94fopIUeuIPDbwARPKthKj1YQjW4wwZw7wyp8aQ8mfjDLxHT
	PZHGkYOwOLgP28btP3Vpgqzq5rDWgjYHMIamsajFoG8/91VvlkCUJr2M=
X-Google-Smtp-Source: AGHT+IF3SCdXTva0hGfrZCvmsu/5C2j5yWo0gBbzwdfD++/P47knw+V10pjexYLsUjE8W9HmOuw485812n30qHjjvBMYpeQhicIh
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d347:0:b0:381:7075:6911 with SMTP id
 e9e14a558f8ab-38a56e0e95dmr147685ab.1.1720485381618; Mon, 08 Jul 2024
 17:36:21 -0700 (PDT)
Date: Mon, 08 Jul 2024 17:36:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000346a6061cc5b897@google.com>
Subject: [syzbot] [wireless?] WARNING in __cfg80211_bss_update (2)
From: syzbot <syzbot+1a797e1c81be78a2ace7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d270dd21bee0 Merge tag 'pci-v6.10-fixes-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123cc8a5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=864caee5f78cab51
dashboard link: https://syzkaller.appspot.com/bug?extid=1a797e1c81be78a2ace7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/987e45087f46/disk-d270dd21.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/072b7b491dd1/vmlinux-d270dd21.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0ddb6b56277/bzImage-d270dd21.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a797e1c81be78a2ace7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 19045 at net/wireless/scan.c:1714 cfg80211_combine_bsses net/wireless/scan.c:1714 [inline]
WARNING: CPU: 1 PID: 19045 at net/wireless/scan.c:1714 __cfg80211_bss_update+0x114a/0x20c0 net/wireless/scan.c:1954
Modules linked in:
CPU: 1 PID: 19045 Comm: kworker/u8:9 Not tainted 6.10.0-rc6-syzkaller-00210-gd270dd21bee0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:cfg80211_combine_bsses net/wireless/scan.c:1714 [inline]
RIP: 0010:__cfg80211_bss_update+0x114a/0x20c0 net/wireless/scan.c:1954
Code: e1 07 fe c1 38 c1 0f 8c 49 fb ff ff 48 8b 7c 24 68 e8 aa fb 26 f7 e9 3a fb ff ff e8 e0 46 c1 f6 90 0f 0b 90 e9 c0 fb ff ff 90 <0f> 0b 90 48 89 ef e8 9b 99 e1 f9 84 c0 0f 84 9f 00 00 00 e8 be 46
RSP: 0018:ffffc9000315ee98 EFLAGS: 00010206
RAX: ffff88806d6fec10 RBX: ffff88802b936488 RCX: dffffc0000000000
RDX: ffff88805e953c00 RSI: 0000000000000000 RDI: 0000000000000006
RBP: ffff88802b936410 R08: ffffffff8ad4de30 R09: 00000010fffff448
R10: 0000505050505050 R11: 0003000000000000 R12: ffff88802b936400
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88805ca01800
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f00aee80836 CR3: 0000000021fd0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 cfg80211_inform_single_bss_data+0xfd6/0x2360 net/wireless/scan.c:2289
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3117
 cfg80211_inform_bss_frame_data+0x3bc/0x720 net/wireless/scan.c:3207
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1099 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1578 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1962/0x2d70 net/mac80211/ibss.c:1605
 ieee80211_iface_process_skb net/mac80211/iface.c:1603 [inline]
 ieee80211_iface_work+0x8a3/0xf10 net/mac80211/iface.c:1657
 cfg80211_wiphy_work+0x221/0x260 net/wireless/core.c:437
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
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

