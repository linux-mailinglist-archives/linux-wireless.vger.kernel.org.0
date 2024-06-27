Return-Path: <linux-wireless+bounces-9625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7F7919BAA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 02:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FA0285623
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 00:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645DBDDA0;
	Thu, 27 Jun 2024 00:16:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F6C8F3
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719447386; cv=none; b=uC+uBOwaF+EkPMluTfzpVJ1qew9HAXk4D4hrZg3f0as/fmXYZyDma++7BffAbbVxaI8JpQZhudvHnSsl6XOZicP85mWakA1eNTc0v9DY4xrrFp4hV8OIs1BmXZYpApu+unOKvvJmrBDCVGy8U7TjOXV6Jy75Vpn37xTYqsKUBM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719447386; c=relaxed/simple;
	bh=KisWr8ZwKIQIzsC+EMQgpl93fx5+oECFeinQOr9EJQk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kD6UHtMiKHcVAjnOBMkpelsHKQCZPxcQo6ewAznMPH/J7QsdoKTTqerqVLipKP2aAabq+fdenWD4iaGbI9fcdjDoecI+xYkop4fvaMMj8H2UHCLM2QVos5wheiXXEm0Iw9fAM6l0cvUbcl0bnlyTK5xhb/fY2NSiRh+Bhef4tEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7f38c10cab9so940354539f.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 17:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719447384; x=1720052184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiNPNmggVhWdOgNLeeJXmGjC1mkaLJHTFJoVbDoIc10=;
        b=suxWKmutkJ8ICDG+Gk2cW8mh5aD9gZsrtJKdPYqX2CWjoA7lZVh/5n2WNOwVmzjhfi
         nL1SejtLc4Oh33RjCbG7RhYNx2hEtnaP1GyLu8Ey7d9uf0/PyKo9mV6FttkBUvwKUfAJ
         KeOWSlnXMnEpQ3tphQ8UncP5gkl3vQrNgXIvrzQykb4MTShDg+VQ9p7BE77U2qJVrJM0
         tgg+agMJchtRTibiHykqtP0ldx7og/H5zq5ifXqni+HV5Yr0sEF7ghHvH4GRIonKWx/x
         D4Mw+eqBU1pShdP8QHM9nnpZYsTra9AYw3IKpADaap/u0VO5TTMgRYayunhynbNdL2Ve
         A4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCW85wAyC648IcSMKwsd1jUXalKxClJ90kYt3RoWUKLpZKeI5dFDY3+AM3+4y8OgahN9vHa2wYrx7qxRxZa/Omp5hForEoTYj7f99xcjWxg=
X-Gm-Message-State: AOJu0YymS/WdqbQ9vpqyU4xUW7If0tfthoQKmdlR0s17lA/C23eC4yOk
	wCmjqpOhs9Dpf16U168EIyLk8tYedG9Pan8o99FrQn+M+/X7WPa8XX8plXnfzpBMBUwv35m0/yM
	w4FKbTxofA9eDqxgivD+xWcC+Xz9Qd+Va8JvPrdqnw6sbBwKD0Mzv6Z0=
X-Google-Smtp-Source: AGHT+IGNfEJk58H383ef6xFapUn2KfgFo+WSKveaahxas52XdtRcUm/V76BKMRS9AXEeMvOJIr+Rfjs3kyWWMPVqXqHQJ6IHAUSs
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1503:b0:7eb:d640:263 with SMTP id
 ca18e2360f4ac-7f3a4f758bfmr20961139f.3.1719447384080; Wed, 26 Jun 2024
 17:16:24 -0700 (PDT)
Date: Wed, 26 Jun 2024 17:16:24 -0700
In-Reply-To: <00000000000024894706196d697f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089dc24061bd40a25@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in __cfg80211_connect_result (2)
From: syzbot <syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a6a6a9809411 net: Drop explicit initialization of struct i..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1324ea82980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=d6eb9cee2885ec06f5e3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a8b81a980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d426c1980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5fb6ec98e2e9/disk-a6a6a980.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f39f26a93081/vmlinux-a6a6a980.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5997cea80d62/bzImage-a6a6a980.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 35 at net/wireless/sme.c:846 __cfg80211_connect_result+0x19ea/0x21d0 net/wireless/sme.c:846
Modules linked in:
CPU: 0 PID: 35 Comm: kworker/u8:2 Not tainted 6.10.0-rc4-syzkaller-00937-ga6a6a9809411 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: cfg80211 cfg80211_event_work
RIP: 0010:__cfg80211_connect_result+0x19ea/0x21d0 net/wireless/sme.c:846
Code: a4 00 89 c3 31 ff 89 c6 e8 43 4f b2 f6 85 db 74 29 e8 0a 7b 98 f6 84 c0 74 27 e8 f1 4a b2 f6 e9 84 00 00 00 e8 e7 4a b2 f6 90 <0f> 0b 90 4c 89 ff 4c 89 f6 e8 68 23 00 00 eb 91 e8 d1 4a b2 f6 eb
RSP: 0018:ffffc90000ab79e0 EFLAGS: 00010293
RAX: ffffffff8ae3da39 RBX: 0000000000000000 RCX: ffff88801aefbc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000ab7b00 R08: ffffffff8ae3d609 R09: 1ffffffff25f6cbd
R10: dffffc0000000000 R11: fffffbfff25f6cbe R12: ffff88802ac63098
R13: dffffc0000000000 R14: ffff88802ac63018 R15: ffff888022eeb000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200029c0 CR3: 0000000078998000 CR4: 00000000003506f0
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
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

