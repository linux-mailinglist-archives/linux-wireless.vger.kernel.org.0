Return-Path: <linux-wireless+bounces-14414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB749ACC2F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A19CB215BE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEFA1BD01E;
	Wed, 23 Oct 2024 14:23:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225B1B85C5
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693413; cv=none; b=nODdgctkCEex80dnn4tzlFtnmhP3C8yaZz2zfNTbwz+ekgMZWIg2TcZq/3Jrm5U3zrBmejUYZx9FG9YisPehuJeBNB4vew+Z3JYBsrBJESwlCpLxILmakTpxP5B5tzeNsn3/i+GLO8ulCru1mmnDH8LdbGE231i5qyuVgCAcfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693413; c=relaxed/simple;
	bh=3r6YoYvZ30f6qSghDf2DxgmurOn2Xt3nPopUNujTEog=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eKwXi70VD7FF4f8DOzIj7TxQcW+Yn9Q1sVjtz5D4DZyw3xxjDgzJ/gn4EYukTOGtrFiVsArAIV/oubeFEGf0AT8uHblI3TnhYjbJfLZ0nG5So95pecUMH89ZIslwdN/JmwMLwm0yMUyPzmfoQv51BmTUWLYPMWj3qZH47/yDfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so41819995ab.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729693411; x=1730298211;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXgVuYbLPnoBu31aImaW1frkkoB/BLDKXzwgKQxsWZg=;
        b=ZmgYwAETv1SNZ5m9ko22H/hMJfOxOVZRdNuFiJusx53DYtBxx4PX8qqmG7cTOOlF+0
         H0AbhkyOQXgogENjBPWF4IDxaN5EsJOagp9QAH6pVvUlEIdCr8QTBN2U3/EBkY2t9bcr
         Sw0cUp4C3+5d51Z2ETpyUsjLaKz/w0eoJxf/q0HslzCETwDVM3cz96jxBMX8qu7cFcF2
         x1Eouq5/L5mUfhNtDbVGoaIsdgvQQL6AleHPtVkE6hFLWreebQzpsc7/Dc8sJOFpdpPh
         0amO/wnb9x2uAs2lHgYbmZ0X0AfHyue/UiSojsu1FMdW79nu2BjWoadyifOGsj7LCx0f
         DewA==
X-Forwarded-Encrypted: i=1; AJvYcCVEztWEsoaAFihxq2S9puk5/b1uSN9ONuNAfp92hTnEFHE2r3Y4ammQmxd1OsWMW86YqttglNKfYHDjqX1WnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywex2BJWLJNdpSueZBGbh2Cs2humniO62LoV0jV5C0kGc1tAQK4
	Yoows3Wf7OYe3MomORWywUV1fd5tHC9hSzItClnuLKSmVvda3GnuchbmTPdwN4JkLE+Vjh12dFL
	h0Vcprj9WRPtJGA6WwqFlSmgbZaW/gvrYKcoLVmt1mqj7WX8rse5ynMI=
X-Google-Smtp-Source: AGHT+IGwEjTStvpcETt83wrxx5aGKbXY6HKNveezndoZtS1B0nzQkOb8HT7Xtw7qBIXS30eWur6ICH8SKG0PJf1h/mAaj5gMfBEa
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ef:b0:3a3:9801:b668 with SMTP id
 e9e14a558f8ab-3a4d5977eb6mr33022115ab.15.1729693410890; Wed, 23 Oct 2024
 07:23:30 -0700 (PDT)
Date: Wed, 23 Oct 2024 07:23:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671906e2.050a0220.1e4b4d.008d.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING: ODEBUG bug in ieee80211_led_exit (2)
From: syzbot <syzbot+e84ecca6d1fa09a9b3d9@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c6d9e43954bf Merge 6.12-rc4 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17196640580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a2bb21f91d75c65
dashboard link: https://syzkaller.appspot.com/bug?extid=e84ecca6d1fa09a9b3d9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bf4a453ec2f/disk-c6d9e439.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e4a2db2a5d95/vmlinux-c6d9e439.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8eb8e481b288/bzImage-c6d9e439.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e84ecca6d1fa09a9b3d9@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888113c7a630 object type: timer_list hint: tpt_trig_timer+0x0/0x300 net/mac80211/led.c:145
WARNING: CPU: 0 PID: 13007 at lib/debugobjects.c:514 debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 UID: 0 PID: 13007 Comm: kworker/0:1 Not tainted 6.12.0-rc4-syzkaller-00052-gc6d9e43954bf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd c0 fd 46 87 41 56 4c 89 e6 48 c7 c7 20 f1 46 87 e8 0e c1 c3 fe 90 <0f> 0b 90 90 58 83 05 fd 6f ff 07 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc900020cf4e8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffc9000fb91000
RDX: 0000000000100000 RSI: ffffffff811aaff6 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8746f7c0
R13: ffffffff872a8ee0 R14: ffffffff86ca22f0 R15: ffffc900020cf5f8
FS:  0000000000000000(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0bdc23b01e CR3: 0000000116760000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
 debug_check_no_obj_freed+0x4b8/0x600 lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2273 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x294/0x480 mm/slub.c:4727
 ieee80211_led_exit+0x162/0x1c0 net/mac80211/led.c:210
 ieee80211_unregister_hw+0x27e/0x3a0 net/mac80211/main.c:1694
 rt2x00lib_remove_hw drivers/net/wireless/ralink/rt2x00/rt2x00dev.c:1085 [inline]
 rt2x00lib_remove_dev+0x528/0x640 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c:1550
 rt2x00usb_disconnect+0x71/0x240 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c:874
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3864
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

