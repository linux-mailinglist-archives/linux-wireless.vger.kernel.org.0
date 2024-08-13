Return-Path: <linux-wireless+bounces-11352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2B6950725
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 16:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749C41C243BC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 14:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952719D074;
	Tue, 13 Aug 2024 14:03:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F619CCED
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557809; cv=none; b=TNulBzYLaAXXvT0lBPC/NfyrVQgpaTnFUAkEQZcFrKYycgqZgLAYLVHjjm/GzvVAA7A12ZxjMFqLCF6Yk2Dp35rwYk2YduKR9ZUDshA73o9hMMzYdVOuXwum0lSIpshOW+umUfPij5sYb7hhb/L+zaOT/x3S8PjARvTenbiREIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557809; c=relaxed/simple;
	bh=jXJdyGdz5F/bXB1OgmxS76BVgK2IRGBQeONSx/vTaGU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F0TasqvcQ5cTNSdAxbO9t1frelcXGdoO4LF78GUoz3ErlI9Mbyjpn7bj/fhLGJeOXj/vK462SmE/tkdlRvCzUId3LZeTZo/kRbRUOj6eLocqJXLyqsSChuaXR19owVy6WChyv+k177Ezr9ZJ1V0JtcxkdsCJpsNqI7hqIgmi35A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b64fd27c8so58958835ab.0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 07:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723557807; x=1724162607;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaLPu4URZsu69rGRW7v009pJWzPnMWEQOBvp+anP4Ds=;
        b=Imz3PYlUDK9dUqFiOE6ivRxhM/DOT/9OsEdvcVvq8s68iZAH2WQe8JvipRoUg0o4Yv
         SypE51k0/yJU8rXU3D7191XbLGuqOQYSBzqdH/hAztMCY0QRCQyVMgWd9vM/MRuDGB0g
         YJFViquSPxZNFacMjsavARaDmBaTYSb17qQtNkTS6Aacig8i9O22q1VJQ0OPjfmIIpKa
         n06e2O8XRvuw2MK/AK82NvXoeMLjkkPKaWOnsSe/3LT/wnzRRB0HjWeIM17Bz2NGpMqo
         Uc6qxp3eVayEweH5GHA33IYE7kLEf/7MSzobXHoDJ34fslGkXOpo4Ua8qBrXq52VuAXY
         Qedg==
X-Forwarded-Encrypted: i=1; AJvYcCUjyHXX0fJbPoTqxwbniPicgt35nNGRtoxctWbo+EjBHYjvSueORGV1eB4idxSYZxd7/McMEG0YJQwsuPnv9ZlZx7Hp5gliwLgUbWV0oVc=
X-Gm-Message-State: AOJu0Yz2bQwDSfUGZIUk96wvGnH8RVOC3Up7Fa0ciFOddpNbznsnYcMO
	kP6qMW1Hr4BqLt+nB29juvPhCQIc7qfdYO2Z86BZCridw45/Qp9dcB8jc+3eJ2UUuntvJbEidUK
	DmdaYIXVnr47Mm03x2r2x+hJHqSBMl3V8r2VaGarqyEOeOssHkSyIZcA=
X-Google-Smtp-Source: AGHT+IFVSE/EmYdOFPDeZMHQzAPi3VPCmZtivc3OK6hQKFLNgOc8DSQRbVLJmJjLwm571DIfTz0VQrdlV6irBQrN/xUIUp0JVMk+
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ca:b0:395:fa9a:318e with SMTP id
 e9e14a558f8ab-39c476a3c9cmr2507215ab.0.1723557807372; Tue, 13 Aug 2024
 07:03:27 -0700 (PDT)
Date: Tue, 13 Aug 2024 07:03:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbcd0f061f911231@google.com>
Subject: [syzbot] [wireless?] WARNING in cfg80211_scan_done
From: syzbot <syzbot+189dcafc06865d38178d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c912bf709078 Merge remote-tracking branches 'origin/arm64-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12fa78ed980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35545feca25ede03
dashboard link: https://syzkaller.appspot.com/bug?extid=189dcafc06865d38178d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/caeac6485006/disk-c912bf70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/501c87f28da9/vmlinux-c912bf70.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6812e99b7182/Image-c912bf70.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+189dcafc06865d38178d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 709 at net/wireless/scan.c:1148 cfg80211_scan_done+0x2ec/0x51c net/wireless/scan.c:1147
Modules linked in:
CPU: 1 PID: 709 Comm: kworker/u8:8 Not tainted 6.10.0-rc7-syzkaller-gc912bf709078 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events_unbound cfg80211_wiphy_work
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : cfg80211_scan_done+0x2ec/0x51c net/wireless/scan.c:1147
lr : cfg80211_scan_done+0x2ec/0x51c net/wireless/scan.c:1147
sp : ffff8000999f7780
x29: ffff8000999f7810 x28: 1ffff0001333eef4 x27: dfff800000000000
x26: ffff0000cc7601b8 x25: ffff0000d9271060 x24: ffff0000cc760700
x23: 0000000000000000 x22: ffff0000d9271078 x21: ffff0000d9271070
x20: 1fffe0001b24e20c x19: ffff0000d9271000 x18: 1fffe000367a85de
x17: ffff80008f2dd000 x16: ffff80008054bde8 x15: ffff70001333eef8
x14: 1ffff0001333eef8 x13: 0000000000000006 x12: ffffffffffffffff
x11: ffff70001333eef8 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c712bc80 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff8000999f77c6 x4 : ffff0000d927107e x3 : ffff80008a7b1e94
x2 : 0000000000000006 x1 : ffff80008b8023e0 x0 : 0000000000000001
Call trace:
 cfg80211_scan_done+0x2ec/0x51c net/wireless/scan.c:1147
 __ieee80211_scan_completed+0x4e0/0xb30 net/mac80211/scan.c:486
 ieee80211_scan_work+0x1b0/0x19ac net/mac80211/scan.c:1162
 cfg80211_wiphy_work+0x1fc/0x240 net/wireless/core.c:437
 process_one_work+0x79c/0x15b8 kernel/workqueue.c:3248
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x938/0xecc kernel/workqueue.c:3409
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 2371456
hardirqs last  enabled at (2371455): [<ffff800082f99ab0>] __free_object+0x1a8/0x83c lib/debugobjects.c:354
hardirqs last disabled at (2371456): [<ffff80008b13d724>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (2371426): [<ffff80008ae7d078>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (2371426): [<ffff80008ae7d078>] batadv_nc_purge_paths+0x2f4/0x378 net/batman-adv/network-coding.c:471
softirqs last disabled at (2371424): [<ffff80008ae7ce54>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (2371424): [<ffff80008ae7ce54>] batadv_nc_purge_paths+0xd0/0x378 net/batman-adv/network-coding.c:442
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

