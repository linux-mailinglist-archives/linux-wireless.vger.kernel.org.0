Return-Path: <linux-wireless+bounces-8088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907BE8CFE7A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 12:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F581C21363
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42BF13BAD4;
	Mon, 27 May 2024 10:59:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B28513B783
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807568; cv=none; b=dOfvVI+QTtiQ3NfxLmyoBIpqGMxQ0rm/iEUjfp/C6+XGaRL/ToKR/i+7YLIKBzQBH3xsOv/mbtU0DdTQyoRjvnwPrQbBXWskTsNVLtBNlzP3vAsbiO0tcrzYQXEjWZjNuoVSCmlpiRiX7FGfTchkIIOIr6Lq+NTHafOJ70vs1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807568; c=relaxed/simple;
	bh=8xA4CXYk2A7mqEyXN1r6pODew65oUNGtLCSCn7pNWnE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uvBRHDhsIaz2UQXPM35S6BbCicwTQzmN2NZs6rr/SYm+zlxupXqO8AXz1WyxU/4mK9lTyfN9wyNAcHkG44Lx8yMworXjhpcGeMECwDRoEOsx0+9V/rrgzDFq4YCDVpU/3uIEk3g/XJqyaWciPwIAUniXTvGqXJIoMzgouTgXqyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-373809cc942so33345115ab.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 03:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716807566; x=1717412366;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/74GZnUOXqFTj0TYyb7t24tQQzKPVBAEjB566d/BI9E=;
        b=W/2Yj9/Fo8OA9mN5+CAqTT5U3buQQ+7VkS2nq+J9mWEY+O1QPqW/80rgx4EvAMvksv
         NCwO38z/chkQR6bXh2+u7rtl2A74RtFFjo0z4INsHHROda2+UUi1/t5iquRUIxbPCpgc
         6kB+XW2FNX0sooH05bdrdmhpzy11Svc6NfoDdvmfb0XN95ZQHO4spJF635DXHcyKAS47
         eoTbWCTk+NI9I010JzS1W5HsUTTHbAWAY77Asd01AZOgHYkzvpa2/D2+gaekXeg8Z446
         SgFUEh0Ep43VfioXRqi0ItbARunq+lXgsvE/5USEgyPeyNvK1EqL/AvcywK1gxbTiJSr
         0ojw==
X-Forwarded-Encrypted: i=1; AJvYcCVL8J0y5VZmTYyXtMAlq976p/3kbJnuUH5pKSBOkMH3NPJ8rD4u+jf7c4Ir4hltzRmFyJ9nXl1brDWLNqfWFGREOrc+5wEzIVRFHsyFlVE=
X-Gm-Message-State: AOJu0Yy4VlnDt8flx+aSGi2Potad18MWsO20bRxI73FDYQWe7aiybGHw
	ecenoKubUgz6aQlld6YoL6ojw9jEsEGQSpkP6+XiUjnsQH9i9jI+btcovVwDgq10pILER4bmaU2
	wV/OlRlhEdH9MdiPxG5zhLe8xvg+PAx1B+quckvDs5ebDu3FjDIyPYQ4=
X-Google-Smtp-Source: AGHT+IGXp/U5DhpU+gxJGdZo2E2LNiKkvtqN8FFyKIccAxeVPW6l8HTiyV4hklQ7etB5G0wZkpINgGp6+lAi7pu6L46+CeOIhzLo
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:371:30f1:96be with SMTP id
 e9e14a558f8ab-3737b1cd625mr5674175ab.0.1716807566391; Mon, 27 May 2024
 03:59:26 -0700 (PDT)
Date: Mon, 27 May 2024 03:59:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024894706196d697f@google.com>
Subject: [syzbot] [wireless?] WARNING in __cfg80211_connect_result (2)
From: syzbot <syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0b4f5add9fa5 Merge branch 'mlx5-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16d3e7dc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
dashboard link: https://syzkaller.appspot.com/bug?extid=d6eb9cee2885ec06f5e3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/012c6c28629f/disk-0b4f5add.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a95912632824/vmlinux-0b4f5add.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4bc604c85096/bzImage-0b4f5add.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 2887 at net/wireless/sme.c:846 __cfg80211_connect_result+0x19ea/0x21d0 net/wireless/sme.c:846
Modules linked in:
CPU: 1 PID: 2887 Comm: kworker/u8:13 Not tainted 6.9.0-syzkaller-12082-g0b4f5add9fa5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: cfg80211 cfg80211_event_work
RIP: 0010:__cfg80211_connect_result+0x19ea/0x21d0 net/wireless/sme.c:846
Code: a3 00 89 c3 31 ff 89 c6 e8 83 eb b3 f6 85 db 74 29 e8 5a 17 9a f6 84 c0 74 27 e8 31 e7 b3 f6 e9 84 00 00 00 e8 27 e7 b3 f6 90 <0f> 0b 90 4c 89 ff 4c 89 f6 e8 68 23 00 00 eb 91 e8 11 e7 b3 f6 eb
RSP: 0018:ffffc90009f579e0 EFLAGS: 00010293
RAX: ffffffff8ae22d59 RBX: 0000000000000000 RCX: ffff88802b8c8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90009f57b00 R08: ffffffff8ae22929 R09: 1ffffffff25f4abd
R10: dffffc0000000000 R11: fffffbfff25f4abe R12: ffff88807cb8f898
R13: dffffc0000000000 R14: ffff88807cb8f818 R15: ffff88805ff1f000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3362a000 CR3: 00000000732a4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cfg80211_process_wdev_events+0x356/0x510 net/wireless/util.c:1105
 cfg80211_process_rdev_events+0xac/0x110 net/wireless/util.c:1147
 cfg80211_event_work+0x2f/0x40 net/wireless/core.c:335
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

