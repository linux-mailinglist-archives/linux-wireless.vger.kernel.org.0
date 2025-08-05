Return-Path: <linux-wireless+bounces-26161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12233B1B7D5
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Aug 2025 17:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AC017BB3A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Aug 2025 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A379A289814;
	Tue,  5 Aug 2025 15:57:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0D2749D7
	for <linux-wireless@vger.kernel.org>; Tue,  5 Aug 2025 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754409454; cv=none; b=dBc43gUCn30jvVaE0n0PubVxet/AXvIFbZ/h4+8G6LBVT9iMSM43ECy/z0ODCfzBdOhNaCjNVM9BijssjVoqxTfuedr8fmcP72Y1Fy33y36s+h6ollk1hMh9vLHtVNCS1g9cVyItE4iQIBPMY0fxrhHnqO6quJIhx9K9eCuEeoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754409454; c=relaxed/simple;
	bh=g0ecg3Q81U2CFlbsKTtZuExNs/RfX1k10w5EglLEdqo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dPFV8bqZPx9NU5/UOhGWFprOlCrZPpIz0wUIlK6rkQhx6a37qoxqY7gwSPr93zkiOoNzSD+De9TkoZPVHVcSeVA/MKjj2024uWX6xf3zrKwe6VhsqGPYj/asEkbapOu3M/rEebNkOfm5GyyyqEKEiXejGTP+m4nuKWH6PCjc/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-87c2bcfd156so2522739f.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 Aug 2025 08:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754409452; x=1755014252;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8mlwvJNmo6qdqX17K3vXEq/b8z8wXKmt9sQYJcWZQQ=;
        b=auyQToBQT55vSP5UMpt8PaK8SvaqE9emKFiz5lEz6o26sjmrPHrUCmCX0Ja5PZ/M6Q
         Qw/M4fceso57hivIdFOrvqkpFWffcaG6bGrKczx10dA+IKs7qXDn2icn/+vZ34nIeC/y
         m1CKYPsd0JDrmCUYIS8RC2M0nBEVmP/rTiVPhIuhmSAkikIcosdodod+soHWejD+Zhwu
         jngxtHTpSKJ2Aev8dAECGZ4NX2wLZJ+qJD5EN6zuuALx4QQezKm+0tZ/lmh32JQKi6xw
         SDQJHZq453s6wWo5igmc/9GI7lznfVOFXa0Qjj+cG/gG6FL0ixR8TeEhlLWH8Yfq6m+i
         woag==
X-Forwarded-Encrypted: i=1; AJvYcCWelKj/GZnyj9OhZlkvgNAO4TCLU2yJfMgvbSP59ReILpmwc6tIV14TM6uzozhrsC1B3e5jtXNSf03NDXXsDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YygZ+W7Z/TVyfyJ19xB54ELf593wFef+8aNinKKk01oY48lQ2BM
	oKHypSh0K7yS5E7HAKyLkWZzwQIYkoPwAsEfsCbIavA0Tv/4F35flajZVdNzXgJCkeMZviWInN6
	OwqFi4eLnDhd0dXYnHDsD926Wl7g6zwNk0TuzPr20ngjeifABUiCZMZ1Wtlc=
X-Google-Smtp-Source: AGHT+IH7KiSosg8Up/F9+Xg6br5+pgu4hBSl8CrIFlfN5oaPEvTm+11ueLjC/XCOM5H8C/jojG9KWwPymeO0F/la2YqySOy3Ardl
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fd5:b0:881:7fe8:d4ca with SMTP id
 ca18e2360f4ac-88191b4d579mr723966639f.3.1754409452077; Tue, 05 Aug 2025
 08:57:32 -0700 (PDT)
Date: Tue, 05 Aug 2025 08:57:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689229ec.050a0220.7f033.002a.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in drv_unassign_vif_chanctx (3)
From: syzbot <syzbot+6506f7abde798179ecc4@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7e161a991ea7 Merge tag 'i2c-for-6.17-rc1-part2' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cc7aa2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1bb6a60e53533c7
dashboard link: https://syzkaller.appspot.com/bug?extid=6506f7abde798179ecc4
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c830eae67136/disk-7e161a99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cbc8fc9ead36/vmlinux-7e161a99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db1e8c2fe140/bzImage-7e161a99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6506f7abde798179ecc4@syzkaller.appspotmail.com

------------[ cut here ]------------
wlan1: Failed check-sdata-in-driver check, flags: 0x0
WARNING: CPU: 0 PID: 6119 at net/mac80211/driver-ops.c:366 drv_unassign_vif_chanctx+0x247/0x850 net/mac80211/driver-ops.c:366
Modules linked in:
CPU: 0 UID: 0 PID: 6119 Comm: kworker/u8:8 Not tainted 6.16.0-syzkaller-11699-g7e161a991ea7 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:drv_unassign_vif_chanctx+0x247/0x850 net/mac80211/driver-ops.c:366
Code: 74 24 10 48 81 c6 20 01 00 00 48 89 74 24 10 e8 ff fb bb f6 8b 54 24 04 48 8b 74 24 10 48 c7 c7 60 5b 08 8d e8 4a 9a 7a f6 90 <0f> 0b 90 90 e8 e0 fb bb f6 4c 89 f2 48 b8 00 00 00 00 00 fc ff df
RSP: 0000:ffffc9000440f5f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880758fcd80 RCX: ffffffff817a3308
RDX: ffff888026cb4880 RSI: ffffffff817a3315 RDI: 0000000000000001
RBP: ffff888076e70e40 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: fffffffffffec258 R12: ffff8880758fea28
R13: 0000000000000000 R14: ffff8880758fd728 R15: ffff8880758fe9d0
FS:  0000000000000000(0000) GS:ffff8881246c6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc9ef0dafe8 CR3: 000000002b620000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_assign_link_chanctx+0x3f1/0xf00 net/mac80211/chan.c:916
 __ieee80211_link_release_channel+0x273/0x4b0 net/mac80211/chan.c:1890
 ieee80211_link_release_channel+0x128/0x200 net/mac80211/chan.c:2165
 unregister_netdevice_many_notify+0x1419/0x24c0 net/core/dev.c:12177
 unregister_netdevice_many net/core/dev.c:12219 [inline]
 unregister_netdevice_queue+0x305/0x3f0 net/core/dev.c:12063
 unregister_netdevice include/linux/netdevice.h:3382 [inline]
 _cfg80211_unregister_wdev+0x64b/0x830 net/wireless/core.c:1275
 ieee80211_remove_interfaces+0x34e/0x740 net/mac80211/iface.c:2391
 ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1664
 mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim.c:5674 [inline]
 hwsim_exit_net+0x3ac/0x7d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6554
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x2eb/0xab0 net/core/net_namespace.c:251
 cleanup_net+0x408/0x890 net/core/net_namespace.c:682
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
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

