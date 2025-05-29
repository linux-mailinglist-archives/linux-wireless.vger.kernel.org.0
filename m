Return-Path: <linux-wireless+bounces-23495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5FBAC7DC3
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 14:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1ED7AD501
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91142248A5;
	Thu, 29 May 2025 12:33:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C62222C1
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522008; cv=none; b=mgATcIE01dwYcjKbW8DqGJPpHT6e1PMljHN3ozbC6CeS2Zd6cg5k0F4SYZhRbrIUsIqyPuppuIgGfca2ZpyVWb8hZgYVdcfiPTgftcYKDPTRX0/AHxmRO+vKz6wtqkqRlkrEq/xYf/gkpbxg7pny5lrmwsM5iwZEhD/xjSh+brY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522008; c=relaxed/simple;
	bh=kIkmKcaPV98XKhRwOTAvnQhINvi2n4gSAdVyCSaFabU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FlG4+3SzyyogQTWQKGB01radbWsvVQ/j1tkGJ8A9+xpZH2pVU2Og7PnbXMl6jrmypZMaqFCqqCIvLqYFsfOPrT8UyClYFhjM/cMOsrg70s1f9e/7kRPYAtuEyfS6bOUxd+fxa+C/+OHnaXAHLBkJB9135vuoZn/K/7E3yDY43WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b4ee2e69bso73174939f.2
        for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 05:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748522006; x=1749126806;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5bml+Lhlb/ESJB7OB397E+URQXQmoC/VYahWRyI1KaM=;
        b=pc1v3zRVBVWfAXRI5aZ75EPlE7MMPvsnmiAeGGbd3h/GfFTj1eRS6HxN457J+50b2z
         HZEiqzaDhQwmElwjvTlACYXJg7mzNsT5ZFNFSn63NGDWY/tiZfe4NWA4B8AFPalrjk48
         TrCm4Ybk4lq96wfz/iX+wJoK8j+xb5xnonZiYIWpOAZCxDIyCni92eMkpue/LdRBo0R7
         Eiga0JNf8I1tmb7CVCP2tAt6SPJ//qwRVJs+hauSNhi63mz+KLEx3xZtVpHqsC1uQp4o
         MrchEpH+VTlsNXqsc+SqZM70JHLE92lOGdnZswDVELY6oFIclpj1NGkPCZ8AUZLyxH+J
         lIAA==
X-Forwarded-Encrypted: i=1; AJvYcCUs9gYmCUJkgJozUg1Pk/gctEbNBxeQyUgGH/cOaP4kS6CKw3JyzJ8fOHNmK29c6UAmQ8ou/rjevqjVa9UakA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXwPghOmWkxqw1eI0LwZtfJyD5IGnFqymqvvKQ9pTkx/5+5q0S
	RcV5UK4QPBWt1Vs1/abCQGgPO9hH6ycX9+tM/bl4EEuW84TEtknJ24He25iXPBO0cxWXarlq9tv
	Wqz/BPOiapGGom4Q/SZQzGT7ROA834gPq95lkjCrDdfKuHI0RlUHDGKIY+ww=
X-Google-Smtp-Source: AGHT+IHxHOKcAfW53VhsEwfYQe28Edle9Xwc641YqhY2if7TdOjOHCstkntXRFjfL61vR74DgjPJZSP093ib53p+cgjjwt7thbwV
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:9f50:0:b0:86c:ee8b:c089 with SMTP id
 ca18e2360f4ac-86cee8bc1bbmr560370739f.3.1748522005946; Thu, 29 May 2025
 05:33:25 -0700 (PDT)
Date: Thu, 29 May 2025 05:33:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68385415.a70a0220.29d4a0.082e.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_tx_h_rate_ctrl
From: syzbot <syzbot+0d516b33238bd97ee864@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5cdb2c77c4c3 Merge tag 'net-6.15-rc8' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14784df4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9fd1c9848687d742
dashboard link: https://syzkaller.appspot.com/bug?extid=0d516b33238bd97ee864
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d90a868e19ee/disk-5cdb2c77.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3c5ff2a5a972/vmlinux-5cdb2c77.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6a0db04ca42/bzImage-5cdb2c77.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d516b33238bd97ee864@syzkaller.appspotmail.com

wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
------------[ cut here ]------------
wlan1: Dropped data frame as no usable bitrate found while scanning and associated. Target station: 08:02:11:00:00:00 on 5 GHz band
WARNING: CPU: 1 PID: 1111 at net/mac80211/tx.c:756 ieee80211_tx_h_rate_ctrl+0xc87/0x1780 net/mac80211/tx.c:749
Modules linked in:
CPU: 1 UID: 0 PID: 1111 Comm: kworker/u8:6 Not tainted 6.15.0-rc7-syzkaller-00082-g5cdb2c77c4c3 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_tx_h_rate_ctrl+0xc87/0x1780 net/mac80211/tx.c:749
Code: 31 f6 83 e6 07 41 0f 95 c6 31 ff e8 03 26 ea f6 43 8d 0c 76 83 c1 02 48 c7 c7 60 8b 8c 8c 48 89 de 4c 89 fa e8 3a 7e ae f6 90 <0f> 0b 90 90 41 bf 01 00 00 00 e9 eb 02 00 00 e8 95 21 ea f6 e9 6a
RSP: 0018:ffffc90003c9f460 EFLAGS: 00010246
RAX: caae12da654acc00 RBX: ffff888078a69738 RCX: ffff888026951e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc90003c9f5d0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bba984 R12: dffffc0000000000
R13: ffffc90003c9f788 R14: 0000000000000001 R15: ffff888059534d44
FS:  0000000000000000(0000) GS:ffff8881261c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557d9f3588 CR3: 0000000031484000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 invoke_tx_handlers_late+0xb6/0x1820 net/mac80211/tx.c:1850
 ieee80211_tx+0x2ac/0x420 net/mac80211/tx.c:1971
 __ieee80211_tx_skb_tid_band+0x50f/0x680 net/mac80211/tx.c:6107
 ieee80211_tx_skb_tid_band net/mac80211/ieee80211_i.h:2338 [inline]
 ieee80211_send_scan_probe_req net/mac80211/scan.c:655 [inline]
 ieee80211_scan_state_send_probe+0x59a/0xa10 net/mac80211/scan.c:683
 ieee80211_scan_work+0x5b1/0x1ce0 net/mac80211/scan.c:1143
 cfg80211_wiphy_work+0x2dc/0x460 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
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

