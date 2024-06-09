Return-Path: <linux-wireless+bounces-8722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F21A7901686
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 17:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF521F21368
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 15:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28F245BFD;
	Sun,  9 Jun 2024 15:46:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA641C71
	for <linux-wireless@vger.kernel.org>; Sun,  9 Jun 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717947989; cv=none; b=F94ueWB71j5TD/ZHm7l+Eq9hzk3XX+DIUUQMclF/RHQcRZw2sT+qbL3PCSYNjoNFWtxEYepzVUqukcnmOPZqJZnXD9l3mTkuXd7X4UI3znHEuqiVysaZSveDUOrYRo95LzcZXeodLNNaozi4GgOP147upTkFJ9eMNXo4KiB54O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717947989; c=relaxed/simple;
	bh=BmR7WGyngT9D2Icit299gpJRLMzYonWCQtwfVW6NHFE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WUA8/+roQ80g9VoYwkqBquUJbipHGY2cGFEceQkiN36reNSPOUopQctGs51IuwzemssQ21RX1uMNHjudOZFhfHgNSzTRFSoS4XKj+7kDp1z8R1UAR128mlvQe5BFIX87A87C2N4ZVrhpugEDcfEXHEQ5a4beTldXeg63DLUX7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e69c0762b8so479103839f.1
        for <linux-wireless@vger.kernel.org>; Sun, 09 Jun 2024 08:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717947987; x=1718552787;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGit8253DSuMkPy55Ebot61PeCnbx0vhheDOMbFFV8U=;
        b=DDD3zXxErmiBDdgMMl6XxgspK8GJKWyF0IIp+YExuz4MjDaGmk8J2e6jWIxJjh99j0
         Jc0HBYU5JHU+nHA3BsvE7/P6CWDERZGxw3wv8tdesgMO9l4OHDXVM/OdFtHw+MCBZoGb
         XXeutihh4Bl1QAYh4sMoY9fMkb50j4CSIB9DTfJcsmkVGiHlwVMn4Ke66GIBIiH14MYp
         9wUegNbBaHC5AiOm85poh4iwyN9TDWk7tVsLMfPw1ZKzZx9rC5aNazQjxlmG5tg7W327
         PxOTIw+6jGD4CuauZz34Yr+RA4E30QNYZqXIEWvfjteb6R6bDCl28ZTVQUSECiNpWkvh
         Hbag==
X-Forwarded-Encrypted: i=1; AJvYcCUhvaE6UR/vS1XGd35hw6QIoCGY6AsETQF10xcNm1fft3mrZExCJ4aWeShZQ6pY8ZnZ5Zwos5CJ7ZDh5HIINk3rwfYzlc6/lVfqU7kE+AM=
X-Gm-Message-State: AOJu0Yyl/rhoa8ONyVmuHwLFs/htj/4bgWvbfKrU7k+Phln4sq5xuoe9
	9qERGdSzSE0r80OLc/bOHs6Jdfd5yiswzkGgXswPeAfBhrEUALN+wb79di7AjFpX7nnXY8ZmHq/
	7G0G7e1jxqr6Q8L4xY8Xve0DPP5M7OaBuylHDklrU9uz5+cVVEuMKabw=
X-Google-Smtp-Source: AGHT+IEkxBf+V7HQlCwDG4kWqFebf6MZ3K2ZkCXklEgKHjKu0dwxDTezgVuEKTVJaIA3qmNbNCysmSjKr6Zxp4CktewCwjv1ZhFP
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c29:b0:375:a40f:97d1 with SMTP id
 e9e14a558f8ab-375a40f9ce4mr633875ab.4.1717947987316; Sun, 09 Jun 2024
 08:46:27 -0700 (PDT)
Date: Sun, 09 Jun 2024 08:46:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086e896061a76efd0@google.com>
Subject: [syzbot] [wireless?] UBSAN: array-index-out-of-bounds in cfg80211_wext_siwscan
From: syzbot <syzbot+161cd7b97ad2b6e21fb6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    234cb065ad82 Add linux-next specific files for 20240605
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=160c62ce980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc762e458631913
dashboard link: https://syzkaller.appspot.com/bug?extid=161cd7b97ad2b6e21fb6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0492dc0386a/disk-234cb065.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/490224339088/vmlinux-234cb065.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5843c0673606/bzImage-234cb065.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+161cd7b97ad2b6e21fb6@syzkaller.appspotmail.com

warning: `syz-executor.4' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/wireless/scan.c:3461:8
index 33 is out of range for type 'struct iw_freq[32]'
CPU: 1 PID: 7326 Comm: syz-executor.4 Tainted: G        W          6.10.0-rc2-next-20240605-syzkaller #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:91 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:117
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 cfg80211_wext_siwscan+0x56d/0x10d0 net/wireless/scan.c:3461
 ioctl_standard_iw_point+0x788/0xcb0 net/wireless/wext-core.c:867
 ioctl_standard_call+0xc7/0x290 net/wireless/wext-core.c:1052
 wext_ioctl_dispatch+0x58e/0x640 net/wireless/wext-core.c:1016
 wext_handle_ioctl+0x15f/0x270 net/wireless/wext-core.c:1077
 sock_ioctl+0x17f/0x8e0 net/socket.c:1275
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f14b5e7cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f14b6be20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f14b5fb3f80 RCX: 00007f14b5e7cee9
RDX: 0000000020000000 RSI: 0000000000008b18 RDI: 0000000000000005
RBP: 00007f14b5eda6fe R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f14b5fb3f80 R15: 00007ffc59f64db8
 </TASK>
---[ end trace ]---


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

