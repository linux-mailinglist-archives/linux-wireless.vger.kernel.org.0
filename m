Return-Path: <linux-wireless+bounces-18574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E956CA2A0AA
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 07:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD07F3A77F7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 06:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B22422332E;
	Thu,  6 Feb 2025 06:05:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3332248B9
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821920; cv=none; b=kCdpegESmCuzqOlKD+0g+HDsI7U1wsQWAts7pscziccx3e6vSrV0Gdvg8comTsgDyroiX0BButwBSriFb0px3e/TfdCltao6Rz5tZ6OFp8cZp6x/Lt+MDu281iQekQADa1zDl8PZ0zX/Hd0y/u0XLyWdGyF8wAPhzO+5Fsc2UNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821920; c=relaxed/simple;
	bh=tiaOYm5pYA+aGstwxdQX/EYDi0r3XD/mgYm932MZdqk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c5qmQivPO/7MMQ0pINV3yHR8KMQLp6PujpTsnuoUnya3mXrIdehWgV+1Uor7yZMj/nzXMnjYBFTLq7n2z37MMaDv5wMw9RFSH9CyA84tBudiNtZD+ZOF/MPWNlMRAvEKqBw9bThUwLaEIQEo2YkQ9fxf/yMk/bhOtMx9uM7K/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-845dee0425cso47805539f.0
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 22:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821917; x=1739426717;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TO+9rzBupMNMiq/QelljNSbWiGr9BXU5LdVRKfddWs=;
        b=V/xF5IYSHA37+C1gx/KEjr2A6bIYTDEfp7uDQ9e1ZWYj04erx738kzrkasVQBo9Hzz
         lCihzqwhDoHQLS8/eNc/Alcy8z6c7MW7X316BBCPIe8Tglp22sNeEOPFzhxzvftmZljL
         70z53UaM1SwXvW2CrMHZjY3yFzN6FfMg1xodfCJqbG53jGDLUncWqLBy05Mcn1KJV8bS
         jdARvppOdWdkB2JLih6WASH3NcNShoO0HlsBSVynoCLh8AraBK7jGg4ZBDupB9QiZGpq
         FcBC2qJ11wL7eIkmgDgDIu9NagGnefvcUFPRvyDe1e+hE9PiRzGMI6JkgMG3S0Exvshi
         HH7A==
X-Forwarded-Encrypted: i=1; AJvYcCWw7+cG3hjmtv94LhkCNCoMfXxAryeQP7E7e6IJ7NAKlGCvtEwch4iFfRouybjWmDkEwmnZlx4xpczvXaIyWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6X/xgDDzSn2TZzpdGnWIkjNs2fei3e51eWk/yYuCZdpH1xpxs
	bIgc69LJGkCT71zkVVUQp7MNLKoFRxoOu9xHOpTPOAlUonFNaw7n0LeL3FxXNXH3P3jwzuicEbz
	3lEBXijv4CKvyyvOKMcv/VuPwN8xaT1lPs3j1xC474Ixh4SfscECx4lg=
X-Google-Smtp-Source: AGHT+IHXrAJssA2VQ4xK5u6Qf66UNd7a1rvB1Rp/Mk4i5onARVBr6UVxz4Lben11D22LMBOjbh+MKIxvR+//hl7rNmYXxUf2EQrq
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138c:b0:3d0:4b0d:b226 with SMTP id
 e9e14a558f8ab-3d04f917cd9mr53494645ab.21.1738821917351; Wed, 05 Feb 2025
 22:05:17 -0800 (PST)
Date: Wed, 05 Feb 2025 22:05:17 -0800
In-Reply-To: <678d7183.050a0220.303755.005f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a4511d.050a0220.19061f.05f7.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_tdls_build_mgmt_packet_data
From: syzbot <syzbot+e55106f8389651870be0@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    92514ef226f5 Merge tag 'for-6.14-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137124a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1909f2f0d8e641ce
dashboard link: https://syzkaller.appspot.com/bug?extid=e55106f8389651870be0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167aadf8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117aadf8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-92514ef2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4d8b91f8769/vmlinux-92514ef2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c24ec4365966/bzImage-92514ef2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e55106f8389651870be0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5309 at net/mac80211/tdls.c:611 ieee80211_tdls_add_setup_cfm_ies net/mac80211/tdls.c:611 [inline]
WARNING: CPU: 0 PID: 5309 at net/mac80211/tdls.c:611 ieee80211_tdls_add_ies net/mac80211/tdls.c:762 [inline]
WARNING: CPU: 0 PID: 5309 at net/mac80211/tdls.c:611 ieee80211_tdls_build_mgmt_packet_data+0x329c/0x4080 net/mac80211/tdls.c:984
Modules linked in:
CPU: 0 UID: 0 PID: 5309 Comm: syz-executor211 Not tainted 6.14.0-rc1-syzkaller-00034-g92514ef226f5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ieee80211_tdls_add_setup_cfm_ies net/mac80211/tdls.c:611 [inline]
RIP: 0010:ieee80211_tdls_add_ies net/mac80211/tdls.c:762 [inline]
RIP: 0010:ieee80211_tdls_build_mgmt_packet_data+0x329c/0x4080 net/mac80211/tdls.c:984
Code: f5 ff ff e8 06 49 3d f6 90 0f 0b 90 4c 8b 7c 24 10 e9 7e fe ff ff e8 f3 48 3d f6 90 0f 0b 90 e9 70 fe ff ff e8 e5 48 3d f6 90 <0f> 0b 90 e9 62 fe ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c c7
RSP: 0018:ffffc9000d2270c0 EFLAGS: 00010293
RAX: ffffffff8b82153b RBX: ffff888042af8d80 RCX: ffff888000ee8000
RDX: 0000000000000000 RSI: ffffffff8c0ab8e0 RDI: ffffffff8c608a00
RBP: ffffc9000d227260 R08: ffffffff901b5177 R09: 1ffffffff2036a2e
R10: dffffc0000000000 R11: fffffbfff2036a2f R12: dffffc0000000000
R13: 0000000000000017 R14: 0000000000000000 R15: ffff888041d91640
FS:  0000555566989380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000021c0 CR3: 000000004515a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_tdls_prep_mgmt_packet+0x3b6/0x860 net/mac80211/tdls.c:1058
 ieee80211_tdls_mgmt+0x8cf/0x10a0 net/mac80211/tdls.c:1299
 rdev_tdls_mgmt net/wireless/rdev-ops.h:927 [inline]
 nl80211_tdls_mgmt+0x4d8/0x770 net/wireless/nl80211.c:12537
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:713 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:728
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2568
 ___sys_sendmsg net/socket.c:2622 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2654
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1284b95c69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcdf2a63b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1284b95c69
RDX: 0000000000000000 RSI: 0000200000000000 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

