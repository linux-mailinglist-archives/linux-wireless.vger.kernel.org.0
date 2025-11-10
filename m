Return-Path: <linux-wireless+bounces-28816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB79EC4977E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 23:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B60B94EC4E9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A29D223DCE;
	Mon, 10 Nov 2025 22:00:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B834D382
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812033; cv=none; b=eV15txFxU7Uo3/AvFWxDTwUGmkjhSHWiHLHoQLjbS+hh4VmyzNKkxWOaP/db8kWNiR1j37QAhgfTXKh4a31MruVNE0CeWz3ah7GlA9gDAtZkVtWr9grFRVKyM/fbhXZIm1hHALL0K4udn5PjkVJsuvA+mjOY6Xrsnh8dMDZ5TfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812033; c=relaxed/simple;
	bh=5ilf5cNnuohitDR46Y8dkzBAopZhR1YtL7FpueMdWhQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AjCCF9EuYwtfe6UiNwczNtLZUmGkKIOPc4RCVZ/9TwTub7tfs66uFznUhhdNsRW4qcv7z8xMlOF9bQcieh2DmHY9t9lfWon9H4DkOwiDGheEHvEgH4daWpvUCjIxsPSlQf8gFdWc3r4j5PKM9qvzCiMq0Q0tBEyz/usS9IlZTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-9489c73d908so199271639f.2
        for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 14:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762812031; x=1763416831;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ad7jqqUSpHLSBaI5VXp+X0Xj58YZn6vBrxghlB0xHXk=;
        b=Fx3f+4JM+z2/1I5Q8tPiGeI3cIosnbMu2SlfVvds/cUlFhaVb0qjW8DSoDeCXLPat6
         iVGqM5+V7M2lR96PBq1ptIfScC5nmpodcYpnQusYCbxwlJRewggcLUdt37bSSEYj9yCJ
         0gYR+aS2VEhUccmE+zht9LnUMeLV0IX12R/XFnq8+7O3ACGxrSiXHk+hynxLcO0olso/
         zmW+Qy76YKeI9wajGMGatfeA+MN1t4qha3/4R+IzUODnUsz9ID0XEtVvEaQLbwH8UzGu
         N+lDWZs40vQvDp0HdBqODQjQeZ0pYEI5YqeNU6uRZOrkYUOFPxNn8qzKKs+HNpuDh03B
         kSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlBC5G9YgW5cjFM1s4ev+4EGblxG+Kx/Q/UWeTJgazJcmF24dY8KfihkBDUvEDPJrZt/gpaALye7XgndrGUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjcC5SMk7rzKSQ5Qhnm6yIFe17OqqyLWlBE4xvYfQgCVAQnWs5
	Mrxzia9+oLYete5dMAKUQqEEDa/ffjbhH6yKiP7TwQSR49p4yWN7SFcdBXtjd/TTV1LFkK1dR7Q
	9C0aCWwuR9P0LJVMROt8n3LWwSSY8UI3g3q0N2ad55T/OTzNuEBJ7zY7Dd4k=
X-Google-Smtp-Source: AGHT+IEPRm99bTmbdnpgLqT88YQjdbSg0DKp1PfqCj7hzlOEjIkSPPgRALpDdQ+cvh9i9ZyRQvzWBL3IGaTZtaUZwziphBg4fMkO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc3:b0:431:d7da:ee29 with SMTP id
 e9e14a558f8ab-43367e79e87mr111463385ab.28.1762812030970; Mon, 10 Nov 2025
 14:00:30 -0800 (PST)
Date: Mon, 10 Nov 2025 14:00:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6912607e.a70a0220.22f260.010f.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in _ieee80211_change_chanctx (2)
From: syzbot <syzbot+e785ad5c3cc8ca31eeac@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dcb6fa37fd7b Linux 6.18-rc3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14e07812580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b659f0cab27b22
dashboard link: https://syzkaller.appspot.com/bug?extid=e785ad5c3cc8ca31eeac
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae6bec0d0398/disk-dcb6fa37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dcc732da66c3/vmlinux-dcb6fa37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/301d1bbdecc2/Image-dcb6fa37.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e785ad5c3cc8ca31eeac@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 17489 at net/mac80211/chan.c:544 _ieee80211_change_chanctx+0x25c/0x10f4 net/mac80211/chan.c:544
Modules linked in:
CPU: 0 UID: 0 PID: 17489 Comm: syz.1.3194 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : _ieee80211_change_chanctx+0x25c/0x10f4 net/mac80211/chan.c:544
lr : _ieee80211_change_chanctx+0x25c/0x10f4 net/mac80211/chan.c:544
sp : ffff8000991c67c0
x29: ffff8000991c68e0 x28: 0000000000000006 x27: dfff800000000000
x26: 0000000000000006 x25: ffff0000f6909800 x24: ffff8000991c69c0
x23: ffff0000f69098b0 x22: ffff0000d52b3398 x21: 0000000000000000
x20: ffff0000f6909800 x19: ffff0000d52b0e80 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008052a444 x15: 0000000000000005
x14: 0000000000000002 x13: 000000000000000d x12: 0000000000ff0100
x11: 0000000000080000 x10: 0000000000003423 x9 : ffff8000a5ddb000
x8 : 0000000000003424 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff8000991c6a10 x4 : 0000000000000000 x3 : ffff8000991c69c0
x2 : ffff0000f6909800 x1 : ffff800092ae0f10 x0 : 0000000000000006
Call trace:
 _ieee80211_change_chanctx+0x25c/0x10f4 net/mac80211/chan.c:544 (P)
 ieee80211_change_chanctx net/mac80211/chan.c:590 [inline]
 ieee80211_recalc_chanctx_chantype+0xcec/0xdf4 net/mac80211/chan.c:865
 ieee80211_vif_use_reserved_switch+0x1470/0x22b0 net/mac80211/chan.c:1763
 ieee80211_link_use_reserved_context+0x2e8/0x4ec net/mac80211/chan.c:2017
 __ieee80211_csa_finalize net/mac80211/cfg.c:4114 [inline]
 ieee80211_csa_finalize+0x464/0xf08 net/mac80211/cfg.c:4145
 __ieee80211_channel_switch net/mac80211/cfg.c:4424 [inline]
 ieee80211_channel_switch+0x834/0xa40 net/mac80211/cfg.c:4439
 rdev_channel_switch+0x124/0x300 net/wireless/rdev-ops.h:1116
 nl80211_channel_switch+0x8d8/0xb18 net/wireless/nl80211.c:11476
 genl_family_rcv_msg_doit+0x1d8/0x2bc net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x450/0x624 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x220/0x3fc net/netlink/af_netlink.c:2552
 genl_rcv+0x38/0x50 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x694/0x8c4 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x648/0x930 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x490/0x7b8 net/socket.c:2630
 ___sys_sendmsg+0x204/0x278 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __arm64_sys_sendmsg+0x184/0x238 net/socket.c:2719
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:746
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 772
hardirqs last  enabled at (771): [<ffff800080c84b38>] kasan_quarantine_put+0x1a0/0x1c8 mm/kasan/quarantine.c:234
hardirqs last disabled at (772): [<ffff80008adecb80>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (732): [<ffff8000803d8488>] softirq_handle_end kernel/softirq.c:468 [inline]
softirqs last  enabled at (732): [<ffff8000803d8488>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:650
softirqs last disabled at (693): [<ffff800080022024>] __do_softirq+0x14/0x20 kernel/softirq.c:656
---[ end trace 0000000000000000 ]---


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

