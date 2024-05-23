Return-Path: <linux-wireless+bounces-7989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142B38CCD41
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 09:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA262827AC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDE513CF8F;
	Thu, 23 May 2024 07:46:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3539FD6
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450395; cv=none; b=PytOa+OOS7aSSDQaN1ueKml+/sKmbPBT+UPsMD46zIMvDrIw61hmlzztvpFMhCHGWYptbwfk1Ld/99Vp7px4hEmjsGMcgIz6aSVncWk9dYH+qeZCbF0853fEvzPCwfsO9g61xeKa8OC7S8cvWViPmkeyG6RTEHDRyY7b6gim8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450395; c=relaxed/simple;
	bh=X1IUARsKujsDFRnxlLdxfmtcj0gfHJSfI3M9uf952PM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kfhqapFzRMsodSQntwcAkDYM4lwd+xMYV52WWSsD7hXUNQBz6ytOfXcFOY5haHVUVEwXixjgIYabsoDYwj3UiM0AU5Yv1g240rX58MiC9lw2tGfHaWmu3XB+SheXl53S6vDjpYCHs/AL+kEH3Y/AIpwxh5JevK1mFoUdNhcNn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e1bcad7693so142713739f.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 00:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716450393; x=1717055193;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/JSb/i2gD6c9fSgYzXiWuZto76mKs4deQ4sFdwc39TU=;
        b=kSZUVhtatnZF5ks0Ujjs15He1ffDU2SrD4zGszxcdnN8g6vFMxZ3pKlgBU0EqL7ba2
         1Azg1SfTi89xNOKaBOPTHeWzGMq4yROkYTqVFXtjwwZOdHrF0UxlNoYogcE4ov0FLR6g
         XxxypA6DvPjqmTI6BhbWpQGYJwcMKtLgemEIy5k2/t4vg2B6fkRfTLcsID3peHhgLZAG
         9UorAQl1aNlPYXoRPsMzMFd6F8EQLVWJ4xwOly+a6z0+xGyZhKzWdLvhkbouIoc7fcZM
         8/8FtnXifeI3T//SDOqnAMV0zEbyRIbcPJxebqs6siaWyIilFVVRrYJ4m11ZtbJ5dPox
         z/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCW24hfEgQqB62CUDCUPmlKjycC0Z1Iya5KmpN56flQRdQ7miQxbSeKZZ+Vt8TbEMfi7yn8qW7QKX0zzJPnxCYShuI1XjYYLP+czr+J+jXs=
X-Gm-Message-State: AOJu0Yw6EWbjdCPde6f9KJ/nJTkN+XYBfe9eeIn3q5BYlbjjYdmsLvv6
	3mzE6kfdPMPBmrxcXy9ojl3CIRXeQzORb7QZKrSvxxm++P+K7hwsHiiHEuxe1JqMK8cBPRnnxbB
	fIhHSWndjqBlSi+OomxXJEKFPx4YDvy7JwOELOhJbPg1Wm02aBSiyJbo=
X-Google-Smtp-Source: AGHT+IFKjr2T2mLKa9hndWc16xzs0P6jYcnPNbb75LC9YUPqzntLRpMQdJ7igxZRkhSbZPGtkMXVaXtQEujlW1OZnVGcLaVHpj5y
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8619:b0:488:59cc:eb4c with SMTP id
 8926c6da1cb9f-4afe3b46381mr281202173.3.1716450393710; Thu, 23 May 2024
 00:46:33 -0700 (PDT)
Date: Thu, 23 May 2024 00:46:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdef8706191a3f7b@google.com>
Subject: [syzbot] [wireless?] WARNING in __rate_control_send_low (2)
From: syzbot <syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4b377b4868ef kprobe/ftrace: fix build error due to bad fun..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12f96934980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=8dd98a9e98ee28dc484a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f4c61bc9252/disk-4b377b48.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/841f1b24d3a1/vmlinux-4b377b48.xz
kernel image: https://storage.googleapis.com/syzbot-assets/017b655dca3d/bzImage-4b377b48.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com

------------[ cut here ]------------
no supported rates for sta (null) (0xffffffff, band 0) in rate_mask 0x0 with flags 0x0
WARNING: CPU: 0 PID: 8812 at net/mac80211/rate.c:385 __rate_control_send_low+0x659/0x890 net/mac80211/rate.c:380
Modules linked in:
CPU: 0 PID: 8812 Comm: kworker/u8:20 Not tainted 6.9.0-syzkaller-08544-g4b377b4868ef #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:__rate_control_send_low+0x659/0x890 net/mac80211/rate.c:380
Code: 8b 14 24 0f 85 de 01 00 00 8b 0a 48 c7 c7 80 69 e1 8c 48 8b 74 24 10 44 89 f2 44 8b 44 24 1c 44 8b 4c 24 0c e8 08 9b 5e f6 90 <0f> 0b 90 90 e9 71 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c db
RSP: 0018:ffffc90005d074a0 EFLAGS: 00010246
RAX: d769b2aeaeba2800 RBX: 000000000000000c RCX: ffff88802e348000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88807ec45168 R08: ffffffff81585642 R09: fffffbfff1c3995c
R10: dffffc0000000000 R11: fffffbfff1c3995c R12: 0000000000000800
R13: 000000000000000c R14: 00000000ffffffff R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f61c4d3cd58 CR3: 000000004aca6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rate_control_send_low+0x1a8/0x770 net/mac80211/rate.c:405
 rate_control_get_rate+0x20e/0x5e0 net/mac80211/rate.c:921
 ieee80211_tx_h_rate_ctrl+0xc88/0x1a10 net/mac80211/tx.c:763
 invoke_tx_handlers_late+0xb3/0x18e0 net/mac80211/tx.c:1848
 ieee80211_tx+0x2e3/0x470 net/mac80211/tx.c:1969
 __ieee80211_tx_skb_tid_band+0x4e2/0x620 net/mac80211/tx.c:6103
 ieee80211_tx_skb_tid_band net/mac80211/ieee80211_i.h:2266 [inline]
 ieee80211_handle_roc_started+0x267/0x440 net/mac80211/offchannel.c:248
 _ieee80211_start_next_roc+0x7a1/0xb00 net/mac80211/offchannel.c:381
 cfg80211_wiphy_work+0x221/0x260 net/wireless/core.c:437
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
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

