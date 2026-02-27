Return-Path: <linux-wireless+bounces-32236-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBhsN8D2oGk8oQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32236-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 02:43:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 883181B1976
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 02:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11FBD3052620
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 01:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FD82882BB;
	Fri, 27 Feb 2026 01:43:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C62566F5
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156604; cv=none; b=H04N43fcmzy40FtT6iLK8LHhasTIoUoRSGDYM2JVHvYHj0lHYSuh90hG62tlTyrxCBD3OX6ViR0gK0fDCPeMbIbrZmsD/zmD/1QUh1vmJxolBikzIQTWTaTSRLoblpBP/IYMClczghvDl82itdyd5rsFTML6z26bSp25dyzxIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156604; c=relaxed/simple;
	bh=VWFtlgXmcL9/fmReO0c8ZlT3Ha+3uO+QpINtRuqmwiE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uXmuBZ83RQjsS5MZt6Sr3evDSKl61x4cXfws5e1qt9mpxNCHPblPjLLgxLb577WAzBpLtTcW7yduli2hSMJriwb57uI9bakCVwLX3JjHxdwQvxy006SzNe9MxJcCPiooA6kfOX5g2e/dLzY7KTYMRYb/rBUNQTBg85gx9+o880g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679c5ed0942so23327830eaf.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 17:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772156602; x=1772761402;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+fVH48wga1eGVIKc9mH7KKYUjMOFbW8GCD23h+C4Vk=;
        b=NkIPKSjoPMUauevrh41P4SSud/xoEjZ04c5/oTdTR90tPyg9RfRaDIzo1ppu4E78/Y
         B5E5kATykERgFILC5qmggng60nheYYsPtgdtFHAy9QzrXTefO9rZBVn583x0fB2NK/SH
         EHEb6daThkWr9vgbDt2ocEfHpawqfWCRPCttt8dgV8dFBBV6rCYRwpHJWx/+z41lka8g
         9uLAaq9go7tgjdfGGvNztRcWuAO08Ro1EgEhrzC/i/hHj3dVEk33jExxCg3pRjDGbqhs
         815VE8OfK7n4QBDGujeuW2s+JI+WaIRpNT7Omsc1EOExhm2wNdd+htAy+2f9scWFnCvd
         cRBw==
X-Forwarded-Encrypted: i=1; AJvYcCWntiqHehpPZdN4Izd27VE31Df1HFt9O6SZtp0ZmqIONEIxuGD5ISXdhJnsADhas01CA+87dAB4CWDqc3zRkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2gEkvHUEYzMGun6x3Ijn0PRuYvJSXz1slN/CIs4kZIhaT6Ri
	HAyQpJFnIOGOgaW2un5Shl58Ko9uo81PW4+k4anxmgMaDSoDT+YMz64pBM6X9wHNeMkNEZcnm0T
	SmEl3Bqp0ygWYgauHkPQNqmtiqwpfIDHCjtWX20e4h20ZD1+9j+xj08kJib0=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2299:b0:674:62e7:190f with SMTP id
 006d021491bc7-679fadf3c5bmr853461eaf.17.1772156602218; Thu, 26 Feb 2026
 17:43:22 -0800 (PST)
Date: Thu, 26 Feb 2026 17:43:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a0f6ba.050a0220.305b49.0074.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_set_disassoc (2)
From: syzbot <syzbot+4b737df95e84787fec21@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2208a171312e89b7];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32236-lists,linux-wireless=lfdr.de,4b737df95e84787fec21];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 883181B1976
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    189f164e573e Convert remaining multi-line kmalloc_obj/flex..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1750855a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2208a171312e89b7
dashboard link: https://syzkaller.appspot.com/bug?extid=4b737df95e84787fec21
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-189f164e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/669b52dbab53/vmlinux-189f164e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51b76feb584c/bzImage-189f164e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b737df95e84787fec21@syzkaller.appspotmail.com

mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium
mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium
mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium
wlan1: deauthenticating from 08:02:11:00:00:00 by local choice (Reason: 3=DEAUTH_LEAVING)
------------[ cut here ]------------
!ap_sta
WARNING: net/mac80211/mlme.c:4137 at ieee80211_set_disassoc+0x3c8/0x1a90 net/mac80211/mlme.c:4137, CPU#0: syz.0.0/5315
Modules linked in:
CPU: 0 UID: 0 PID: 5315 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:ieee80211_set_disassoc+0x3c8/0x1a90 net/mac80211/mlme.c:4137
Code: c4 8c f6 45 85 ff 0f 84 c9 11 00 00 e8 81 c0 8c f6 eb 2b e8 7a c0 8c f6 48 83 7c 24 48 00 0f 85 38 fe ff ff e8 69 c0 8c f6 90 <0f> 0b 90 e9 aa 10 00 00 e8 5b c0 8c f6 eb 05 e8 54 c0 8c f6 48 8d
RSP: 0018:ffffc9000dd4efa0 EFLAGS: 00010287
RAX: ffffffff8b38dab7 RBX: ffff888038b28dc0 RCX: 0000000000100000
RDX: ffffc9000ec12000 RSI: 000000000001762f RDI: 0000000000017630
RBP: ffffc9000dd4f0b0 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000dd4f1e0 R11: fffff52001ba9e3f R12: ffff888038b297f0
R13: dffffc0000000000 R14: 1ffff92001ba9e04 R15: ffffc9000dd4f1e0
FS:  00007f5691c2d6c0(0000) GS:ffff88808ca5b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc7ffad0c8 CR3: 0000000035dd8000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ieee80211_mgd_deauth+0x9fa/0xe60 net/mac80211/mlme.c:10198
 rdev_deauth net/wireless/rdev-ops.h:509 [inline]
 cfg80211_mlme_deauth+0x51b/0x8f0 net/wireless/mlme.c:536
 cfg80211_sme_disconnect net/wireless/sme.c:666 [inline]
 cfg80211_disconnect+0x3b2/0x7c0 net/wireless/sme.c:1559
 cfg80211_netdev_notifier_call+0x1ba/0x1470 net/wireless/core.c:1599
 notifier_call_chain+0x1be/0x400 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
 call_netdevice_notifiers net/core/dev.c:2301 [inline]
 __dev_close_many+0x119/0x6d0 net/core/dev.c:1746
 netif_close_many+0x225/0x420 net/core/dev.c:1800
 netif_close+0x160/0x220 net/core/dev.c:1817
 dev_close+0x10a/0x220 net/core/dev_api.c:220
 cfg80211_shutdown_all_interfaces+0xc4/0x200 net/wireless/core.c:282
 cfg80211_rfkill_set_block+0x2d/0x50 net/wireless/core.c:312
 rfkill_set_block+0x1d2/0x440 net/rfkill/core.c:346
 rfkill_fop_write+0x461/0x5a0 net/rfkill/core.c:1301
 vfs_write+0x29a/0xb90 fs/read_write.c:686
 ksys_write+0x150/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5690d9c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5691c2d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5691015fa0 RCX: 00007f5690d9c629
RDX: 0000000000000008 RSI: 0000200000000080 RDI: 0000000000000006
RBP: 00007f5690e32b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5691016038 R14: 00007f5691015fa0 R15: 00007fff6e9cd5a8
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

