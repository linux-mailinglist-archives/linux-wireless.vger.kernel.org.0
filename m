Return-Path: <linux-wireless+bounces-29379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 397FDC8DD9D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 11:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C9494E5B0B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED332AADC;
	Thu, 27 Nov 2025 10:55:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519DB329E55
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764240929; cv=none; b=uEtrYEQ20Y+BMg6x0LWcGXF4UxDdhldcCzyrWyKh59vApq1U/mFX5n8DouYsFqwpKtVTozcQqFSMW3U3yygjJ0IyqlLaFkcLJUHuxrNFJtoxGoggFSU0CGfmXTOTHmFp5nXs34qSJSXJwONQ+PVQsimXCXwkeZ16a6Mo2hOkSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764240929; c=relaxed/simple;
	bh=F6Q0w7C86PUsJ01iPUmoE2PdDCOmTthnRvUUfckMMEo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GIIF8M2+Xi0/e/xyFBT8eME/hyoSLSVfAj/VU+9d5ZTwBulL9rZAd47Jk4uPtMLlOHMgSXikVS1nMqb3lzooXtMQTLaHHwek/NeGwuqFqKRAqmrnqtxYoAIDXmo9zyf/9ZuV3O17+Av/DwzBIx/V8MCqczJLrhiiDTdE/vo9Fbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-9489c73d908so43558639f.2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 02:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764240926; x=1764845726;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDIhq/FuDE9UFMDa6n2SoeVFELouWXOLgjXJDPEteI0=;
        b=cFHNYYvGF7TIBZ0MBntS3XABxVpL1v1Jgs81rIYt/HLKIvLo1gofRj2mY/u5S7AcQn
         u2gT4EyrkZxlRAtXT64pfavsxwFhylKx6n8a2z3H8RG+hxbGKyVkmlCewRGxZecSzyrY
         EhDxHLGPXZv9qWrSJpt7D5eLLl4qhW9nW4pZ0KY27PNHxp6IFtivy3UpJ4j8wnzmiWuf
         dA+4y1zL9XCM5Vm5j11L5A2GBLuX33V7t3WByP+Q5ZeEc0kHQQYMhygjQm1t6SBYmYog
         Jves5GOPhYDoJlVpfiZTiVwBpYnmSm+kxE8h8VC+uDo7Q31pqR9hIShOs1SMV0SbkUtF
         1NGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+ijAboQTPMwG+XklUo5q5T070o70Lb1nSNs3+2eN/ifhSSgXl/w9d2j/3X+F+4KkHg7RKILQ2iHB34LI0jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YybZqg8/sq81Zs7MdoS9OZpAYcwazJhTbGktvlhzGKeT3I5gyIM
	Tcjei/8/iL7463VEYDmXyTD5GObap7fnAkKOMnhV1tVZcLhru0l/wg4xW6uqkP7uScccAWg/Tmd
	J12LB49R/bPUWnE1dkx1rt2wV+j/7NyuhnICchS/OJEZjJHW0ShYfGwGpQtU=
X-Google-Smtp-Source: AGHT+IHmz+DiewTIBYaot8YJxr/JEi9dTgI6U3gX3hcFdYxA6bWYEJ9IZP3O+itociUoTsdPuBSByO49eKT25G6NYQJYtcJeCsNg
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a49:b0:434:a78e:f6f0 with SMTP id
 e9e14a558f8ab-435dd07483cmr86341575ab.14.1764240926493; Thu, 27 Nov 2025
 02:55:26 -0800 (PST)
Date: Thu, 27 Nov 2025 02:55:26 -0800
In-Reply-To: <689229ec.050a0220.7f033.002a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69282e1e.a70a0220.d98e3.00fa.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in drv_unassign_vif_chanctx (3)
From: syzbot <syzbot+6506f7abde798179ecc4@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4941a17751c9 Merge tag 'trace-ringbuffer-v6.18-rc7' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12503e12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6824ec1757ea1310
dashboard link: https://syzkaller.appspot.com/bug?extid=6506f7abde798179ecc4
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168cee12580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15536f42580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4941a177.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df31d5f8fbe6/vmlinux-4941a177.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5039c51e9d30/bzImage-4941a177.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6506f7abde798179ecc4@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): (slave wlan1): Releasing backup interface
bond0 (unregistering): Released all slaves
------------[ cut here ]------------
wlan1: Failed check-sdata-in-driver check, flags: 0x0
WARNING: CPU: 0 PID: 13 at net/mac80211/driver-ops.c:366 drv_unassign_vif_chanctx+0x247/0x850 net/mac80211/driver-ops.c:366
Modules linked in:
CPU: 0 UID: 0 PID: 13 Comm: kworker/u32:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:drv_unassign_vif_chanctx+0x247/0x850 net/mac80211/driver-ops.c:366
Code: 74 24 10 48 81 c6 20 01 00 00 48 89 74 24 10 e8 af ec ee f6 8b 54 24 04 48 8b 74 24 10 48 c7 c7 40 b6 e2 8c e8 fa 1f ad f6 90 <0f> 0b 90 90 e8 90 ec ee f6 4c 89 f2 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc900001075a8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880501e8d80 RCX: ffffffff817b1cd8
RDX: ffff88801da88000 RSI: ffffffff817b1ce5 RDI: 0000000000000001
RBP: ffff888052578e80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8880501eaad8
R13: 0000000000000000 R14: ffff8880501e97b8 R15: ffff8880501eaa80
FS:  0000000000000000(0000) GS:ffff8880d6a05000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd732ef6fe8 CR3: 000000000e182000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ieee80211_assign_link_chanctx+0x3f1/0xf00 net/mac80211/chan.c:905
 __ieee80211_link_release_channel+0x273/0x4b0 net/mac80211/chan.c:1879
 ieee80211_link_release_channel+0x128/0x200 net/mac80211/chan.c:2154
 unregister_netdevice_many_notify+0x1402/0x25c0 net/core/dev.c:12305
 unregister_netdevice_many net/core/dev.c:12347 [inline]
 unregister_netdevice_queue+0x305/0x3f0 net/core/dev.c:12161
 unregister_netdevice include/linux/netdevice.h:3389 [inline]
 _cfg80211_unregister_wdev+0x64b/0x830 net/wireless/core.c:1284
 ieee80211_remove_interfaces+0x34e/0x740 net/mac80211/iface.c:2394
 ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1681
 mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim.c:5915 [inline]
 hwsim_exit_net+0x788/0x1590 drivers/net/wireless/virtual/mac80211_hwsim.c:6806
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x2ee/0xab0 net/core/net_namespace.c:252
 cleanup_net+0x41b/0x8b0 net/core/net_namespace.c:695
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

