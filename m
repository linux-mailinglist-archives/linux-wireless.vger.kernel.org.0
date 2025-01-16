Return-Path: <linux-wireless+bounces-17591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2195A136B3
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 10:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC753A6FBE
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11D51D90AE;
	Thu, 16 Jan 2025 09:35:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5D1D86D6
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020123; cv=none; b=rU4UScqtNFPNVz7qS3Tzg3McEkH2g7YSgWtkc6YYpCKMkGjQIx+uHsqNlWtuXVZiwzWf1HZKUgQxlXIWZRQc+eKzyvxFXfFTaecDtO5zCa681+zR1lBacDvsOQusj/zLexWOy4H/mBRZyG/lmVrXViCb6127l84HsrFHwlEKv2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020123; c=relaxed/simple;
	bh=hMbX15oWoVS2tElQGRcsCeNcEPwQIA0VM4qELoladQs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d3x3e44Pcxn0GnOfBQxvIliVQsTVpkeuUpRSSefza/b2KuMxMHdZFYk/QKaEgBnJQcYnruNywif5U4PuEJjPn3fjSc65xDdBQ7RC9/HhF6tE7ijdXE9c/7iuxnwwqJidUPjdm43Nw5fXV8Jd8s/dyw7QP5VF2poU63II9GvWwvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3cde3591dbfso5692635ab.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 01:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737020121; x=1737624921;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lom7AH32L0Mgs9aUPNzFepeonekVl8G5+OoAuPJlwRE=;
        b=V5pu6FclBFh1jfJjxF5OPbKSx7hVrvI7gAhxQRiXl4ddFcFCG1PTpEiM43qWWf1gR0
         NPh63LXhNjlnfVo2W5KpxQ3cdunuB396bxplo+IfMaRLvg8yHacW5xuqdel7W9X0yGGl
         K6y2gyO4mcKj2ICaf1i7LG20rdASTmVi6OebUBKCKRpfYJTgDP9eOFRzfOXbW+KdCAxI
         mwNbRi9fHPBsjKnvUXWCQZbG/Pz5qh6sqrKnMlsCGGOwuNykvrP5IYSXxauwa8O2O64u
         +u+WHheWCFSTyPkQTRnjR69M6BSli+8fcdxEQllGwYGaiwz4Jyq8Aw/NSgJrDeOjrRJN
         Yq+A==
X-Forwarded-Encrypted: i=1; AJvYcCW7d70t9wsM+8kfQySDXX0n/DC/+04SWGXXvkbHpcAi9oLV70VJ9pD7WuVxF1yucMP7qGafOuG2IFKAlmu0Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HoDufJJQszZmetROmMg0O4MC6nOkypwc3piIEKqpGsjKOnaj
	xP8HlreYpy5rCPGu1JhxpYHSI9x+F8o+ypTy7BR2jH4vViYylCMeQOvtwvWjwIS53XqXDcct5Bi
	zsv/tiXWJJ7ot2EbV9OlBQJnktu4ZWPI+bPHrqi6u040oDsBVq1zvdfg=
X-Google-Smtp-Source: AGHT+IEqx756E/5dFyjefWS47ErqHCTijzSpHRd2YibhzHOcMuqd3B9lXZw4TLFiQarLe4UVNFGxHGqnOudNcf9ZqGMYp3a/u6uz
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190c:b0:3ce:7b33:8c3b with SMTP id
 e9e14a558f8ab-3ce849de894mr57987995ab.5.1737020121230; Thu, 16 Jan 2025
 01:35:21 -0800 (PST)
Date: Thu, 16 Jan 2025 01:35:21 -0800
In-Reply-To: <673b71bc.050a0220.87769.004d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6788d2d9.050a0220.20d369.0028.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in sta_info_insert_rcu (4)
From: syzbot <syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    619f0b6fad52 Merge tag 'seccomp-v6.13-rc8' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c7cfc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1cb4a1f148c0861
dashboard link: https://syzkaller.appspot.com/bug?extid=8b512026a7ec10dcbdd9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e6c7c4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c7cfc4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-619f0b6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8f14bca15c5e/vmlinux-619f0b6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/42522ef81b09/bzImage-619f0b6f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1139 at net/mac80211/sta_info.c:737 sta_info_insert_check net/mac80211/sta_info.c:737 [inline]
WARNING: CPU: 1 PID: 1139 at net/mac80211/sta_info.c:737 sta_info_insert_rcu+0x24a/0x1b70 net/mac80211/sta_info.c:942
Modules linked in:
CPU: 1 UID: 0 PID: 1139 Comm: kworker/u32:7 Not tainted 6.13.0-rc7-syzkaller-00043-g619f0b6fad52 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:sta_info_insert_check net/mac80211/sta_info.c:737 [inline]
RIP: 0010:sta_info_insert_rcu+0x24a/0x1b70 net/mac80211/sta_info.c:942
Code: 0f b7 83 ae 20 00 00 31 ff 44 31 e0 0f b7 c0 09 d0 89 c6 89 44 24 08 e8 e4 49 fd f6 8b 44 24 08 85 c0 75 7f e8 d7 4e fd f6 90 <0f> 0b 90 c7 44 24 14 ea ff ff ff e8 c6 4e fd f6 48 8b 34 24 4c 89
RSP: 0018:ffffc900064b7ab0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888030c1cd80 RCX: ffffffff8a9cd65b
RDX: ffff8880277dc880 RSI: ffffffff8a9cd5c9 RDI: 0000000000000001
RBP: ffffffff905f7cb4 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000005 R12: 000000000000ffff
R13: ffff888031e30048 R14: 00000000ffffffff R15: ffff888030338e40
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f35d7d620e0 CR3: 000000002e2c6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_ocb_finish_sta net/mac80211/ocb.c:102 [inline]
 ieee80211_ocb_work+0x30c/0x650 net/mac80211/ocb.c:136
 ieee80211_iface_work+0x8ad/0xf00 net/mac80211/iface.c:1697
 cfg80211_wiphy_work+0x3de/0x560 net/wireless/core.c:440
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

