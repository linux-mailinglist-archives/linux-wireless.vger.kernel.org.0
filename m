Return-Path: <linux-wireless+bounces-17153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE9EA04623
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 17:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468C41638F2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122F61F4719;
	Tue,  7 Jan 2025 16:25:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D21F2C25
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267132; cv=none; b=fhEoFNXR8GsMeOdVnnqs22pK2UmONxMeagaMgiib0j3czhq1t8NmAPM1JGeva27iYz1rMXfyPfea9tt5kg8Eq85tMrQaMZl4oxAUbxsriEF5sApU5GnIUZnDLKWEQHSMDWgUanEE7+zP14ErTKP+d5MfZ9+YLhFv5N4nzmMFRcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267132; c=relaxed/simple;
	bh=C1uu7KJPad0P/K6vV+2ViYpu26xuTkpumqT649zmcGU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Grj7XAa8MuYwYvtGz53SImttGGMA9WJzltXI4uF7U5pxRZu/vc2Cve8xyqUiU7DxooQBTL6AqylqGNezc2ZuXSEhrWYxYa+pWt0qV5B8EkC8xoRFza64hSU3V/htEJqsehAPb6HESwWu3Pe4KWprftwuK49w9D4OQt5TfqF77T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a9d4ea9e0cso154178075ab.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 08:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736267128; x=1736871928;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIbj1985qmxWb39sTDDBhOMH3hk1O4jew4vLD0IUd6U=;
        b=mzdkQH8LiHWzGdjhlYhh8G1KvPztDAlt/d/1sBvPtNGxaUPHInL7O/T2uJYmJIWcPo
         ++cryLy9hjlLGJsHnnANJW9R/oeQYXZUTGkUKmOrRtb4eBuFgEy0nQQefplYPLuvkBr/
         YSbI1TqhDcw8iNahgco+St+CVCMog5aIAKU3bpgwvuzGW8dPjg8ibbhIVj8IA2/09AvA
         m0UoRyWNqCtOu/ts1yAVhr9AEVmMndliN08zheHdGrGz5vSje0BEnYRzybA7atajHn1e
         fLW0hpc2VCmhiC2lbfozZOZEfc6AI1wHFS5F0uX/ymIO7/MhyiMvXLTZQbA7UjSHdPWQ
         EMTg==
X-Forwarded-Encrypted: i=1; AJvYcCUlxe1OCZ9m0R4bBNUUX73l7ZOE7l/9h4nPHFfYxbHfuBj5L7Vi64OXrga/irVzwla/2Fvwjx7eMOWPhKNEsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymQxUJtTI2S70+DVwrFEYkI8SyJNZMiSR8cMcUzlXU+kW+dZs+
	/fcL/Ukw7OOzKi+wRt/WzxP1deb9d9e7xR0v7ml0lLEBf2c1NUrc11e/4KoS0x1mNsXSnIRKIa3
	ta8i2Ds0pZkJZUq7o146U6WHCxeu5WrfL3EsUwae1nj7jmYykdNo09zw=
X-Google-Smtp-Source: AGHT+IGGRAgAv3dD0kWIJOsbXk0QUd+5GSP8V+OS6LHv9BPmtIzAh/JEC8J7NdHF6zksa2nwBD+5jjtEHG536jErPcqPwqItBTnY
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ca:b0:3a7:86ab:bebe with SMTP id
 e9e14a558f8ab-3c2d514f966mr513344955ab.16.1736267127799; Tue, 07 Jan 2025
 08:25:27 -0800 (PST)
Date: Tue, 07 Jan 2025 08:25:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677d5577.050a0220.a40f5.0022.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_request_ibss_scan
From: syzbot <syzbot+1634c5399e29d8b66789@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    63676eefb7a0 Merge tag 'sched_ext-for-6.13-rc5-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e98edf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
dashboard link: https://syzkaller.appspot.com/bug?extid=1634c5399e29d8b66789
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-63676eef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/efc20deb6462/vmlinux-63676eef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b916a2c594d7/bzImage-63676eef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1634c5399e29d8b66789@syzkaller.appspotmail.com

wlan1: No active IBSS STAs - trying to scan for other IBSS networks with same SSID (merge)
------------[ cut here ]------------
WARNING: CPU: 2 PID: 94 at net/mac80211/scan.c:1213 ieee80211_request_ibss_scan+0x7b8/0x9a0 net/mac80211/scan.c:1213
Modules linked in:
CPU: 2 UID: 0 PID: 94 Comm: kworker/u32:5 Not tainted 6.13.0-rc5-syzkaller-00161-g63676eefb7a0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_request_ibss_scan+0x7b8/0x9a0 net/mac80211/scan.c:1213
Code: e9 3b fb ff ff e8 08 ce 08 f7 be 04 00 00 00 bf 06 00 00 00 41 bd 04 00 00 00 e8 33 d0 08 f7 e9 3b fd ff ff e8 e9 cd 08 f7 90 <0f> 0b 90 bb ea ff ff ff e9 6e fc ff ff 48 c7 c7 d4 1a 1d 90 e8 ef
RSP: 0018:ffffc900010af988 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8a908130
RDX: ffff88801f83a440 RSI: ffffffff8a9081c7 RDI: 0000000000000005
RBP: ffff888064659720 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000005
R13: 0000000000000006 R14: dffffc0000000000 R15: ffff88804ff70e40
FS:  0000000000000000(0000) GS:ffff88802b600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002f61bffc CR3: 000000001e3c2000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_sta_merge_ibss net/mac80211/ibss.c:1290 [inline]
 ieee80211_ibss_work+0x83b/0x14c0 net/mac80211/ibss.c:1672
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

