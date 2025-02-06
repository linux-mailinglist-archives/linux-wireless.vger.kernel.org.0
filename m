Return-Path: <linux-wireless+bounces-18597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D86A2AC52
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 16:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67F41888370
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 15:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7151EDA0E;
	Thu,  6 Feb 2025 15:20:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA423642A
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855228; cv=none; b=PIcsEfPURXGxTFHRIFG9srN6v8KX9kRea/rPxFxkCmk7MBLd7gYtiQ1RyK0By9zmItgDanvITLwA05MwFxXwEMzZplgh5XO55dF/QC8lj2W/AKqGfXBCo32412HsrMdab3e1mXg+Yf1aAjbuC8PHeAH/Bh1iBCWY6R4TTeAF2MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855228; c=relaxed/simple;
	bh=eDOqP7+BXpHVhicCo7wyvj5oRo7WDsDZLNCNVn5vrec=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tz2Z1q5UDEmvbl/TNouX4rpQ79gk1OE7Ne1Y0w7UdCb4ObPwIFzzD18Gb+43+X1wdDydK/1FCP3GVrYT6JDJW3J2n1VlE88bsctmxSSJqCZGFbFSqBi+6T3QRTL8jZlAeg7pR+yyMr+KfzJQP4f9OkHlHPN1ZamOZOiNro9IwxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-854a68299c0so200333539f.2
        for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2025 07:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738855226; x=1739460026;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFl5kinqp9gWgJ6tj81uzJp2ykUIOW0B39E6YsNbxHk=;
        b=PUZYP8EZbMbACxXIltb+XUqyEprbSh85Y+7wuKSXoS0jBV2sICxYOADH03qDey8wL+
         zprCXEyWpLGjlMQ9WJRCcEdLEfyNFzP8Bzka9Z4lpyiuz9juf3KBRE2E8E0CavqERWmD
         APKuaZ1AFEZkoY7Lmi1IDWASu4rGDoexQyFMwowSrEwkoGP9nS7AmdG7X1Vnj10TQIfD
         1rTpXA5CymYAmzdhXk2KkbSKRV5oAK1/V5anHB06iymNnNSms55Ao5fvLLNESDGOCPur
         GT25WRiVQn6IEBMTbuRXToNb5kTvLRIkI1LcaklnNAFEp6PeTs9HuRElDvTEzYvcQ5cc
         tbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTNG0gt/+6E3mHQDwp9Mx5cmGgDUkYI+xNcDCX1VKJ0QNpEa/W5Nva1/0kK+qCr/3urGcLqTBD9r/KsZN0bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6bpcprnzTN7v8bNhwp0uN6EN2Ka7nSHrKTH0tCKUvjRwUct0
	PCji/v0xB3ykgEpN5UAliSh/jxpaDOoz2GIcTfwcstc0G6vpLpm2NZmhUQOfBfXo6JboKJFeBKo
	lOVrqVaqhRwlxOK8oGLy7VU0B67gYkjbGmOa3vmtEr1f/UnWyca598jU=
X-Google-Smtp-Source: AGHT+IG1TBbxPcDH0VtNoKmuHiOCibLk8WhoSRtt5DH6Mk+ghMjbBCAoPEk9GNVTz8/IEEyMT7PZRg5b+JXlMEO3Ym1EcZx5C0JJ
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:471b:b0:3d1:98e:4916 with SMTP id
 e9e14a558f8ab-3d1098e4c9dmr2346685ab.9.1738855226087; Thu, 06 Feb 2025
 07:20:26 -0800 (PST)
Date: Thu, 06 Feb 2025 07:20:26 -0800
In-Reply-To: <671906e2.050a0220.1e4b4d.008d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a4d33a.050a0220.6230e.0002.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING: ODEBUG bug in ieee80211_led_exit (2)
From: syzbot <syzbot+e84ecca6d1fa09a9b3d9@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9682c35ff6ec usb: typec: thunderbolt: Remove IS_ERR check ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=130e6df8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed7570f7f6046a71
dashboard link: https://syzkaller.appspot.com/bug?extid=e84ecca6d1fa09a9b3d9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170e6df8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155c5318580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3c194e311f90/disk-9682c35f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/daad45c8e7c8/vmlinux-9682c35f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8a4e74467d7e/bzImage-9682c35f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e84ecca6d1fa09a9b3d9@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888114d18330 object type: timer_list hint: tpt_trig_timer+0x0/0x300 net/mac80211/led.c:145
WARNING: CPU: 0 PID: 705 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Modules linked in:

CPU: 0 UID: 0 PID: 705 Comm: kworker/0:2 Not tainted 6.14.0-rc1-syzkaller-g9682c35ff6ec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd 40 d0 47 87 41 56 4c 89 e6 48 c7 c7 c0 c4 47 87 e8 af f6 c0 fe 90 <0f> 0b 90 90 58 83 05 96 71 d8 07 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc9000198f488 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff813f4d09
RDX: ffff88810b3d8000 RSI: ffffffff813f4d16 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000008 R12: ffffffff8747cb60
R13: ffffffff872acb00 R14: ffffffff86f6b4e0 R15: ffffc9000198f598
FS:  0000000000000000(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffebc06edcc CR3: 0000000008ca2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x4b7/0x600 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2284 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x2e1/0x480 mm/slub.c:4757
 ieee80211_led_exit+0x162/0x1c0 net/mac80211/led.c:210
 ieee80211_unregister_hw+0x27e/0x3a0 net/mac80211/main.c:1706
 rt2x00lib_remove_hw drivers/net/wireless/ralink/rt2x00/rt2x00dev.c:1085 [inline]
 rt2x00lib_remove_dev+0x528/0x640 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c:1550
 rt2x00usb_disconnect+0x71/0x240 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c:872
 usb_unbind_interface+0x1e2/0x960 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x396/0x9f0 drivers/base/core.c:3854
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2305
 hub_port_connect drivers/usb/core/hub.c:5363 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5663 [inline]
 port_event drivers/usb/core/hub.c:5823 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5905
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

