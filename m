Return-Path: <linux-wireless+bounces-24546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFE9AE9DE9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E4A4A557C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 12:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F23B2E1733;
	Thu, 26 Jun 2025 12:57:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E902E11C0
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942652; cv=none; b=CX3ijgzoW1wn6ptR6h6FBh0d2xTbifbkCRBR2e6DGsJ/uo2bzA2A0q3D1OcNfu2zniZ9zaLIqh0BLd17tKGgThIppGLA9NkNh/xshVgutg3mTjqNBOrw7OkuoO+/tYFVGpQEz+L/b7Dlxu1zkGcuv7qbv2dkPVDd03iA4ibgaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942652; c=relaxed/simple;
	bh=rPXf71MDkv1KkvzkugTsNBkpv9MI4q54otRR8aGtKxg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uAlZqbgF/d0qjjan6xuGj2lHfvFROrD20YK21+MMvWuxt/R4meC6oHIKhTMcYngr2m+egIhjsyjNlOV4VtLx1MtKoGV5xeaTp563Wrx/0EOh/BByUI/lf3T9wcCe1tbDFMWKeQ3seEqPMTsK+qhZ/a2JsMpLY2Zi0iWgyL1IF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddd5311fd3so8413745ab.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 05:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750942649; x=1751547449;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwN0ldL1U178GSOcHtpYmNajlC0ep0MCuxdwVuLJqik=;
        b=uJLsWztK8Y72Xe1DI23couku0C8Mklicjnf5jKbPJCXgVBd1fjf57FSqjOKJszO4xI
         7MGnR9/Nrd3bthGDLy0AvCP3xZ+YEq3vbZkT/0VNHV/nWrpccmDzuJjTsMyJX/Bs1+Ik
         ZcBBwhAM6gcYlwcGH7qadNKjdqIiwty/hS/6bdcJL3N24YeEuXlQOnB0Og/7GTcEzDcy
         zouhnX4oEC/tQEM7FdgcQ60hT+xhrDhZ8TihFHx9u6B3lvwFvYvPF3xSaj1g2w7OM9pL
         DsOSnjRUfzLgktNKmp3dnqX3KG7IVmEDvWV0WEXenVrENJknwe3dlWvfSYAfMXrZG/3q
         iRtg==
X-Forwarded-Encrypted: i=1; AJvYcCW5x3qAVk6bRNAt/e3tzqVHw3v0AARE5pYjyLYIlP0xXe0b2dffPlUnDct4ZtXAdL21gyRXBQbrstYUdXZYfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+XtjhcH/CdUlVpqKdBz2UitOSn3fT/U5YivdSC3nFw/qRZvLF
	Q5kn9dtL1WZ9qEu0HWCrzWxhJGaIXsqpTcI+lUe5kctM+Nki0UZADvEKEMrmDERdB0NuuqcLj4N
	Gz1ypupGROGJEkfy7DnzM+6awls2f9CTLB5CN/ENcf63K/DDwYnkufEx0Log=
X-Google-Smtp-Source: AGHT+IHXEk1bZFIRP52lSlkallAfbwT7GM52DnNGb6AhRhB7qmX+IWQhTW+84vSo3Ni9jUrSIxOP37ua4ZcX8RmsveKxub85M+GI
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f08:b0:3df:2a58:381a with SMTP id
 e9e14a558f8ab-3df32871b05mr91740935ab.3.1750942649532; Thu, 26 Jun 2025
 05:57:29 -0700 (PDT)
Date: Thu, 26 Jun 2025 05:57:29 -0700
In-Reply-To: <685ce019.a00a0220.2e5631.0206.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685d43b9.050a0220.2303ee.01db.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in _ieee80211_sta_cur_vht_bw
From: syzbot <syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ecb259c4f70d Add linux-next specific files for 20250626
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=130db182580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e847490ba2a1e14
dashboard link: https://syzkaller.appspot.com/bug?extid=ededba317ddeca8b3f08
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102fcf0c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b67dd4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5c1b08ab7d3a/disk-ecb259c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f8489f3be9c8/vmlinux-ecb259c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/150ce938c7c2/bzImage-ecb259c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: ./include/net/mac80211.h:7769 at ieee80211_chan_width_to_rx_bw include/net/mac80211.h:7769 [inline], CPU#0: syz-executor109/5836
WARNING: ./include/net/mac80211.h:7769 at _ieee80211_sta_cur_vht_bw+0x524/0x6e0 net/mac80211/vht.c:549, CPU#0: syz-executor109/5836
Modules linked in:
CPU: 0 UID: 0 PID: 5836 Comm: syz-executor109 Not tainted 6.16.0-rc3-next-20250626-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:ieee80211_chan_width_to_rx_bw include/net/mac80211.h:7769 [inline]
RIP: 0010:_ieee80211_sta_cur_vht_bw+0x524/0x6e0 net/mac80211/vht.c:549
Code: 00 00 00 eb 49 41 83 fd 05 74 30 41 83 fd 0d 75 13 e8 70 f9 d5 f6 b8 04 00 00 00 eb 31 e8 64 f9 d5 f6 eb 28 e8 5d f9 d5 f6 90 <0f> 0b 90 eb 1d e8 52 f9 d5 f6 b8 02 00 00 00 eb 13 e8 46 f9 d5 f6
RSP: 0018:ffffc90003fcef48 EFLAGS: 00010293
RAX: ffffffff8aea1323 RBX: ffff888073fd8000 RCX: ffff888032595a00
RDX: 0000000000000000 RSI: ffffffff8f9a5660 RDI: 0000000000000007
RBP: 0000000000000000 R08: ffff888032595a00 R09: 0000000000000007
R10: 000000000000000d R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000007 R14: ffff888073fd8180 R15: 1ffff1100e7fb030
FS:  0000555588b13380(0000) GS:ffff8881259e6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dba778f798 CR3: 0000000076a32000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_sta_cur_vht_bw net/mac80211/ieee80211_i.h:2230 [inline]
 __ieee80211_vht_handle_opmode+0x3c0/0x850 net/mac80211/vht.c:701
 sta_link_apply_parameters+0xb75/0xf60 net/mac80211/cfg.c:1987
 sta_apply_parameters+0x944/0x15b0 net/mac80211/cfg.c:2111
 ieee80211_add_station+0x424/0x6a0 net/mac80211/cfg.c:2194
 rdev_add_station+0x108/0x290 net/wireless/rdev-ops.h:201
 nl80211_new_station+0x1755/0x1b70 net/wireless/nl80211.c:8358
 genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f22ab1537d9
Code: 48 83 c4 28 c3 e8 e7 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffa34ff748 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fffa34ff918 RCX: 00007f22ab1537d9
RDX: 0000000000000000 RSI: 0000200000001080 RDI: 0000000000000006
RBP: 00007f22ab1c6610 R08: 0000000000000000 R09: 00007fffa34ff918
R10: 0000000000000012 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffa34ff908 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

