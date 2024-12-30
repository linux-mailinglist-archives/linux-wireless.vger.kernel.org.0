Return-Path: <linux-wireless+bounces-16900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA2E9FE399
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 09:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC48D3A04C5
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C11A0730;
	Mon, 30 Dec 2024 08:07:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D79E1A0718
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735546044; cv=none; b=FJXYHBN79JhzDK/pJnI5xROyoIfHxvdtd70b8naNavvPTxS9q/+0wfLAV9U1ymo5Hk13+SzwWLTsvDDCDoGLOF8icg+gAdmQwmbfwICYuc+wXoiPsZc2KlxXjbDP2u3Ul8guIXw9lgPsK9AuWavXJsxlZa4X/EqP0g3sKg6TN8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735546044; c=relaxed/simple;
	bh=OIM1Y4NWbpcMyvZVBjutclcMuYNLDE1DrkEVY49eH2Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sWvcQSpPl9pgQ+r1MvSGSNlUibw/ypkKmolEv2CoZkgt9f4q4DQg1YLyChay2rZSlu0wEmw/TyfAI7yNxvu1xsJ2kxTeLPVZQfzNGT6ujt0imIyp83t14eJnZBMeKXFxrsTESzlIpt7EkpfGwXcHLcaATZWT9+uO0OVDBCk+Rb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9d303a5ccso181398595ab.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 00:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735546042; x=1736150842;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUynRFj7VEaV10r6/OF/rVuvmpEf0FuTJOYT9ttzejI=;
        b=VsVgIyFYKWiHjzAsliY3dqEin48gG6BuoRh37QtK0e9yeLLkn8qu7b/sG18j6nniFp
         xNBErsm5WFstzs/zI5vdie7nAo/XmpTTuvYbvTecP9GxoOYhLTAzzpF4WAntDDSxiPXO
         C1+j1uPvhD+L1PdTBkER+LhSElHKkBe4ZoPNTKr82BnCXFupgOM4xUbbFqDLLlORdwcf
         l03K2rhO9SA0//oTf/D/5UzRQlLkg0gl5iz5ksWn4XY3whuhEbNt3ny9opqAOkPGXNDj
         SpGNmyqNWXbZCOTjTx/ggFRMRCIskoz5rCioAYPGy3bNWRRCFM2TfDAw2lEsxZ/FLut6
         g+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX5hG7KlXGGzVK4GxQ+i2WCpfdbsQ3P2MwIFoI9lD2XtzEX/GlFqFkR0tnQdof7MO6K2Yhn13w4qWPy4b08Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyds9FPQIBXY+0agqv8WNdQLfVTVaiOSupNrp/lnBdnEG2BY07i
	DtHfzF8JG+MGtTWk/IgkqMvvBIzJlpZkHx8cG+MER/dDaWqSDSuDenYDeIoUi3ifsjZ8GYu76zi
	hZ6FZ5D9rs9hm7kBLD2WC0ZjkysUMmHkyr1sZS/d2QwnYzduwF5onVH0=
X-Google-Smtp-Source: AGHT+IHcas72jpuAKR45Az0d9LXedHbJuJbMmRnepkwBxyRbY3YVOKrSHZNR0PnX0Cs2Di1qnyJJSNij0pxxa8x+QDPY5ZbRNgDE
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:3a7:bc2a:2522 with SMTP id
 e9e14a558f8ab-3c2d277f709mr274937865ab.7.1735546042375; Mon, 30 Dec 2024
 00:07:22 -0800 (PST)
Date: Mon, 30 Dec 2024 00:07:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677254ba.050a0220.2f3838.04ba.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_set_active_links
From: syzbot <syzbot+0c5d8e65f23569a8ffec@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172402c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c078001e66e4a17e
dashboard link: https://syzkaller.appspot.com/bug?extid=0c5d8e65f23569a8ffec
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17aa690f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155ce2f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1d66e09941d/disk-9b2ffa61.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8aa24ea0a81d/vmlinux-9b2ffa61.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d9c0b1e880a/bzImage-9b2ffa61.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c5d8e65f23569a8ffec@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 52 at net/mac80211/link.c:504 ieee80211_set_active_links+0x7ba/0x9c0 net/mac80211/link.c:504
Modules linked in:
CPU: 0 UID: 0 PID: 52 Comm: kworker/u8:3 Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_set_active_links+0x7ba/0x9c0 net/mac80211/link.c:504
Code: 94 c4 31 ff 44 89 e6 e8 f4 b5 04 f7 45 84 e4 0f 84 81 fc ff ff e8 06 b4 04 f7 e8 21 46 77 f6 e9 72 fc ff ff e8 f7 b3 04 f7 90 <0f> 0b 90 b8 ea ff ff ff e9 74 fa ff ff e8 e4 b3 04 f7 e8 bf 7f ea
RSP: 0018:ffffc90000bd7b78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880276ce9d0 RCX: ffffffff8a949444
RDX: ffff8880206b9e00 RSI: ffffffff8a949b59 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: ffffffff901d16d4
R13: 0000000000000001 R14: ffff8880277f8e40 R15: ffff8880276cd720
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005556f9227000 CR3: 00000000757fe000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_if_parse_active_links+0xa4/0x110 net/mac80211/debugfs_netdev.c:733
 wiphy_locked_debugfs_write_work+0xe3/0x1c0 net/wireless/debugfs.c:215
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

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

