Return-Path: <linux-wireless+bounces-28115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C655BF3A8D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 23:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DEE18C4C96
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 21:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1339D33375E;
	Mon, 20 Oct 2025 21:07:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20F33373E
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994451; cv=none; b=bVYdcOE04fSW9HyoWfBv8CXe0uXiBt228uW0h+VNo537hHg5bd5Mafuw1zJJVsDe/70BEaRpKVeHDhM7HZFCDKw5VWGZ2j32RoI2WtLzmgIpfpx1qflRJAr12Z1U7XDJI6jWtnfNdFmG/r/d/vd8BAQd1p0SVB0wv5LshnoSz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994451; c=relaxed/simple;
	bh=+edOF3wQZR0xUdhdOH2cokGxCXFpzafo+xsd1IEDA4M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A1RtKNTyu3xWGL3+UFDlgGBYcY2EgYE/jezjBNRU3wwhg4qG7ZiPqb7MSd/pJnR2SI85a3CW9JMcCZUTZ7ZQzFRnKBTQ/8tJW1JstT/06m6HYeOqqg76mbVwOhj5XRuSjp5OwnntSySw8KYjz6JB8CFqxzukS9dKIiCJG0/GjUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-430d003e87eso122399495ab.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 14:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994447; x=1761599247;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2uSfryshhqKkYzlSGfWI1sm7gHyIclZwLi4RwyNKL0=;
        b=bwqjsFMzD1uO/FrGK9k5PdrOaGBENQ7CWTW4wDWvoWOB6Sx/wXimYkufVZjnNazDgT
         MV0zp0EoAolkcIxrHqu9c3fq7D0LL0eC6GLqSQfsweG4/QasevZp+Wtwmsc+Pt2ZZvSE
         x0czqOIsHDUpUqsmJ/SRGFanh+zfc7h6JfB29ENVNQz/AB/YKaxv6TOPxo8G2bzHVPJb
         lVFEwdCQpvrmImpM7eU2ykliI366zM0KP6z5z8iAy7Nzlv4fshw0vWsuMa5SimsSNuR0
         mvCa8K1z0KSrkHvu/34ovRpju3ODLJTx1A/YGbRc7zu8HUv2qLVaL+nR87Ez34lT+ccW
         maLg==
X-Forwarded-Encrypted: i=1; AJvYcCVpKmbRayKCgjyDVTIc8BFS7HBbPGyegQqqzdR9nnZV3sKikkEnnkTvXEGpTnLWdcE1SDVDhs+XwfIl0qeCrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgC7kXxMTfYexhw257+qUgmoes98mymvnMow5d3FFxTQmAZfRD
	bwTXWzD1x7S6JUOubJCBWMyuUI3U45Ek22bu4IWhM+QHOWJRxP/6AZjZXo64HiEFtWk1DXPPsWe
	Ay/ShTz22ncrisx4m/v1o7/HSxNpXirHu0aUOvCbgpVln9ow/2M8CQIXXmrE=
X-Google-Smtp-Source: AGHT+IHh2h7Y2t70fZwKx9fRj8FB1KNlnr1jFGorloaS0RZfP7ZyxNBHS8ZSZXvyUBfSYm5fpwYccIeU019XMCiS+DB8enk53Oi4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4510:b0:430:c77c:cc35 with SMTP id
 e9e14a558f8ab-430c77ccd47mr201197075ab.29.1760994447649; Mon, 20 Oct 2025
 14:07:27 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:07:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f6a48f.050a0220.91a22.0453.GAE@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98ac9cc4b445 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16be6734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=878ddc3962f792e9af59
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111e7dcd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1223a492580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f8ad8459a8da/disk-98ac9cc4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/28720fa307c1/vmlinux-98ac9cc4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4f310acec99/bzImage-98ac9cc4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com

mac80211_hwsim hwsim5 wlan1: entered allmulticast mode
=====================================================
BUG: KMSAN: uninit-value in cfg80211_classify8021d+0x99d/0x12b0 net/wireless/util.c:1027
 cfg80211_classify8021d+0x99d/0x12b0 net/wireless/util.c:1027
 ieee80211_select_queue+0x37a/0x9e0 net/mac80211/wme.c:180
 __ieee80211_subif_start_xmit+0x60f/0x1d90 net/mac80211/tx.c:4304
 ieee80211_subif_start_xmit+0xa8/0x6d0 net/mac80211/tx.c:4538
 __netdev_start_xmit include/linux/netdevice.h:5248 [inline]
 netdev_start_xmit include/linux/netdevice.h:5257 [inline]
 xmit_one net/core/dev.c:3845 [inline]
 dev_hard_start_xmit+0x22f/0xa30 net/core/dev.c:3861
 __dev_queue_xmit+0x3c51/0x5e60 net/core/dev.c:4763
 dev_queue_xmit include/linux/netdevice.h:3365 [inline]
 packet_xmit+0x8f/0x710 net/packet/af_packet.c:275
 packet_snd net/packet/af_packet.c:3076 [inline]
 packet_sendmsg+0x9173/0xa2a0 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:742
 __sys_sendto+0x593/0x720 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2247
 x64_sys_call+0x3924/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4962 [inline]
 slab_alloc_node mm/slub.c:5265 [inline]
 kmem_cache_alloc_node_noprof+0x989/0x16b0 mm/slub.c:5317
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xc5/0xa60 net/core/skbuff.c:6671
 sock_alloc_send_pskb+0xacc/0xc60 net/core/sock.c:2965
 packet_alloc_skb net/packet/af_packet.c:2926 [inline]
 packet_snd net/packet/af_packet.c:3019 [inline]
 packet_sendmsg+0x743d/0xa2a0 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:742
 __sys_sendto+0x593/0x720 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2247
 x64_sys_call+0x3924/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 6051 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


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

