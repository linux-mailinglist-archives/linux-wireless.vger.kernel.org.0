Return-Path: <linux-wireless+bounces-15156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C98FA9C3165
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Nov 2024 09:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57E7B21036
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Nov 2024 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849DF1527B1;
	Sun, 10 Nov 2024 08:44:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80EE14A624
	for <linux-wireless@vger.kernel.org>; Sun, 10 Nov 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731228259; cv=none; b=RG0cdhUvq7AdsfJJKLKD7n+ydyorQvXuTcs0WP0LPdLFBFRjb1bkyeTVCAww9Nmo3K6XDQISKBUZ89ChIHiNKW733g6s0NaRBYGjlzPy28Xke2JGD9nSaxQcEoxRE0ZTql7qx6gk9D3CTWo/jf3V9C/uSBkLUVDT3jmYjKfmw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731228259; c=relaxed/simple;
	bh=N6fjnQ3SVjcaUzADUhmQzaxQkP7EPDBqq6OJR0PXTh4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EelPCFap+ocNKFmX4CdcymtW4JtdymwrL8iyFslTU0fYj94VZHbRixBEm4trOhz/QH621rj8/SF4iJx1Ofb1atDobFB4L2yPlkCQuhMYealvxZg2EBUAnmX0mifn181EBGn88Xlokc7QaFWNPbZpsulSoNcIB6Yf1osJ2W01e0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b7974696so44257625ab.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 Nov 2024 00:44:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731228257; x=1731833057;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=znOIIlnNrOZ23GxgUlO5RXsc39UsdkSI5Y+xlIMB35Y=;
        b=Ye/Zp7lHDo7SyyoTmL7ymFcADfHmgaG55XcFHYRgAphFjFmv38uZLGgBfJOfeenBHX
         T16au8zftiNa97QO8ShBRJ/U+vsmrUa5LV0gwa8TH1qPnDQI+WKHTv5fgeFoQzY9phah
         UMzHAoSik2vwQPigkc4Ej81SK6Q3Wp0M4JyR2UdzUtu20ZQ29qK58GPktVdJy+Jcj0Yw
         tedm+mUCuDpW00B/1XkN5kimW1oP96CI3xj+mB4fcdzA1h6KNiIzYqk7oQ8eY4pxFR8X
         NWrTeqwkDndqzlS3Q4HbL1FSB1Vlu8KkPcA821u9yhjx/xAVycTdUA8wmG/3T8MXeoU0
         QB4A==
X-Forwarded-Encrypted: i=1; AJvYcCWf64bMkb9L9VO4FTwibt+TR9WRYHSlqdyNDJsP/VUa+wDkIe/aOSO6J3DycGMTrtn/HF7/pcJNT0+ZFARaiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YycUDF5oMFVHGBurWqF4fIV8iWjRqek1XZ5v7a3Uus/55Eqtusx
	Zim3yFs22Vugvmn8hPbDT8IF22T0CdNeKsgx3LzdO7weRmAsixYrXYMJ6ZEJ9TCr+MSXyEHz2eR
	Xz0hSFVKXPfKFMv36JgZvaw94Xhci5dT8VFCcfD2Hh/jkzfxn/Hj/OZI=
X-Google-Smtp-Source: AGHT+IHy8lOTiYW1dJ+FhT3xtg2IJ7H1+Y2fyo4KO/dcG0+G7kCUR4jIMPTQjvCzUhggTMelaN5PLOTxeze85zG9HrIgdVI+QUmU
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c6:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a6f1a3742bmr84154435ab.16.1731228257009; Sun, 10 Nov 2024
 00:44:17 -0800 (PST)
Date: Sun, 10 Nov 2024 00:44:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67307260.050a0220.320e73.0321.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in mac80211_hwsim_config_mac_nl
From: syzbot <syzbot+9ea265d998de25ac6a46@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ccb35037c48a Merge branch 'net-lan969x-add-vcap-functional..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1492cf40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9d1c42858837b59
dashboard link: https://syzkaller.appspot.com/bug?extid=9ea265d998de25ac6a46
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4c339ec95c42/disk-ccb35037.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/328f6f24277e/vmlinux-ccb35037.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0473d4109fcb/bzImage-ccb35037.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ea265d998de25ac6a46@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 16303 at drivers/net/wireless/virtual/mac80211_hwsim.c:1445 mac80211_hwsim_config_mac_nl+0x2b2/0x370 drivers/net/wireless/virtual/mac80211_hwsim.c:1445
Modules linked in:
CPU: 0 UID: 0 PID: 16303 Comm: syz.6.3042 Not tainted 6.12.0-rc5-syzkaller-01164-gccb35037c48a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:mac80211_hwsim_config_mac_nl+0x2b2/0x370 drivers/net/wireless/virtual/mac80211_hwsim.c:1445
Code: 48 8b 3c 24 4c 89 fe 44 89 ea 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 eb f8 ff ff e8 46 b3 8d fa eb 05 e8 3f b3 8d fa 90 <0f> 0b 90 e9 10 fe ff ff 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 90 fd
RSP: 0018:ffffc9000b0476b0 EFLAGS: 00010293
RAX: ffffffff870726e1 RBX: 0000000000000000 RCX: ffff888072945a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff870724ed R09: 1ffffffff203a5d5
R10: dffffc0000000000 R11: ffffffff87069560 R12: ffff8880635dae32
R13: 0000000000000000 R14: 0000000000000001 R15: ffff8880554630a0
FS:  00007f08d2bff6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020003a80 CR3: 000000007c7cc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mac80211_hwsim_add_interface+0x9a/0x320 drivers/net/wireless/virtual/mac80211_hwsim.c:2136
 drv_add_interface+0x2f8/0x8e0 net/mac80211/driver-ops.c:73
 ieee80211_do_open+0x73d/0x2430 net/mac80211/iface.c:1373
 ieee80211_open+0x192/0x200 net/mac80211/iface.c:458
 __dev_open+0x2d3/0x450 net/core/dev.c:1476
 __dev_change_flags+0x1e2/0x6f0 net/core/dev.c:8904
 dev_change_flags+0x8b/0x1a0 net/core/dev.c:8976
 devinet_ioctl+0xcce/0x1ac0 net/ipv4/devinet.c:1209
 inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0x158/0x460 net/socket.c:1227
 sock_ioctl+0x626/0x8e0 net/socket.c:1346
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f08d317e31b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007f08d2bfde60 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f08d2bfdf80 RCX: 00007f08d317e31b
RDX: 00007f08d2bfdee0 RSI: 0000000000008914 RDI: 000000000000000b
RBP: 000000000000000b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000024
R13: 0000000000000048 R14: 00007f08d2bfdfa0 R15: 00007f08d2bfdee0
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

