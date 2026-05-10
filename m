Return-Path: <linux-wireless+bounces-36178-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGU8IG7yAGo9OwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36178-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 23:02:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD91A506642
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 23:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C9C03019807
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 21:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1AA309EFF;
	Sun, 10 May 2026 21:02:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB402D949B
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446955; cv=none; b=nTwZ7xQ7uesvCrZ7JN6mjzc5bsy4xOb2VNE5QESrlyNyyRx+B+L3TX0yr6TZ0jJyWejuJ3rKFO7TzZIzCjOTVLl4r5sHSyob1ci+IlDV0Is6ASKDFK6AhUfWO9M78LniwdO6BcP6/O88p/xxlsk67bKT5ikUERogGvX0/PXSagk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446955; c=relaxed/simple;
	bh=qiMiUP4GWNA2w9vRiyBT9N3XWrpmuvhai0+xrt4hld8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sodPIRYnX+4s0Rj2h1KxKeatM3Vj4Qm8FC3xVS0/UCLPQWmdMueWw63xxPywVMjo55oK5eRLQFwuu1/qBUGtoUriQYbdQg73TwoKK5tKCAmbyNsu47rmVHUjPvlR13uQDThYRhhXwSBQygSUlcDjf5lMyTIJvjYWLTlMQeMPcG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7e1f3a293aeso8320176a34.2
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 14:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778446952; x=1779051752;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQFzIGJ6E8REtW8EJbiqWNpybEWzfPqgcYj9hEdNyVo=;
        b=ULBnmx77ejN9pjRYw5kvgZt/Q0WmEHQTSGEe/onv2UOFCBbEQVu0eJDqUhVQZMwrpc
         gxVIyJosxnOVhzlm2/xy0sm6UHvbRcU6n76b0mekeZDuLnL0917EGEt2PVJHD86DjP6G
         dIbHCDIw+hWeK0K5j0F0kP4uqc2yq+sIrQzuUq4i1A4fhfdGyLS/3azSCnhEZQuXAHaD
         ZBRo/VYGt3mayc/BThqffDkl//P/HJcxL0eCufLeGGiJFtWIjvETpTaGnQ7lbyZPUY87
         y1Wn72BzYAEvSuK3a7B+0u7twjHGa7i4eN0w7jOqe6yAOca68rU66+UG+cbjYwN/PypV
         YSSg==
X-Forwarded-Encrypted: i=1; AFNElJ/fplR0Wu0thUlYYjNAkI30yyxFiT8JN2b6rLgCJcHSC0GOWyL5VKrNfJ0yk7t9LKyBcH1IwSJVxxMxDTz9tw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5FIZSqWo/50V1rdj2KPVw7ku3KnUSoHJuFWrNcONxqMSENOhi
	O8ypD4+AemtXAXrmxJFrVrR5SCdx6iQoo9jY1UQxWl9515axUEsbevfchsqZF+YDuxettKlHGei
	8UcwuYxTZtAloIx+JGSsKnlCcfORyHmVfW1eZShzoX2mxFAGhnZBCHhpNcfc=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2905:b0:696:924d:2956 with SMTP id
 006d021491bc7-69998cc6047mr12641138eaf.14.1778446952588; Sun, 10 May 2026
 14:02:32 -0700 (PDT)
Date: Sun, 10 May 2026 14:02:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a00f268.170a0220.1c0296.021c.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in mac80211_hwsim_tx (2)
From: syzbot <syzbot+435fdb053cf98bfa5778@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DD91A506642
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36178-lists,linux-wireless=lfdr.de,435fdb053cf98bfa5778];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,goo.gl:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    adc1e5c6203c Merge tag 'efi-fixes-for-v7.1-1' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1369cd06580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24
dashboard link: https://syzkaller.appspot.com/bug?extid=435fdb053cf98bfa5778
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e1ec8b63537e/disk-adc1e5c6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2030fc4d0035/vmlinux-adc1e5c6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a50679f39f63/bzImage-adc1e5c6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+435fdb053cf98bfa5778@syzkaller.appspotmail.com

------------[ cut here ]------------
sp->magic != HWSIM_STA_MAGIC
WARNING: drivers/net/wireless/virtual/mac80211_hwsim.c:265 at hwsim_check_sta_magic drivers/net/wireless/virtual/mac80211_hwsim.c:265 [inline], CPU#1: syz.3.8603/32057
WARNING: drivers/net/wireless/virtual/mac80211_hwsim.c:265 at hwsim_check_sta_magic drivers/net/wireless/virtual/mac80211_hwsim.c:262 [inline], CPU#1: syz.3.8603/32057
WARNING: drivers/net/wireless/virtual/mac80211_hwsim.c:265 at mac80211_hwsim_tx+0x2085/0x2b10 drivers/net/wireless/virtual/mac80211_hwsim.c:2213, CPU#1: syz.3.8603/32057
Modules linked in:
CPU: 1 UID: 0 PID: 32057 Comm: syz.3.8603 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:hwsim_check_sta_magic drivers/net/wireless/virtual/mac80211_hwsim.c:265 [inline]
RIP: 0010:hwsim_check_sta_magic drivers/net/wireless/virtual/mac80211_hwsim.c:262 [inline]
RIP: 0010:mac80211_hwsim_tx+0x2085/0x2b10 drivers/net/wireless/virtual/mac80211_hwsim.c:2213
Code: 44 24 20 e8 fd a6 dc fa 48 8d 3d a6 50 b8 09 48 8b 54 24 20 8b 74 24 30 89 d9 67 48 0f b9 3a e9 f7 ec ff ff e8 dc a6 dc fa 90 <0f> 0b 90 e9 a0 e3 ff ff e8 ce a6 dc fa 48 8d bb f1 07 00 00 48 b8
RSP: 0018:ffffc900040eeea0 EFLAGS: 00010283
RAX: 000000000000075e RBX: ffff888083a0eb78 RCX: ffffc90011de4000
RDX: 0000000000080000 RSI: ffffffff872bec44 RDI: ffff8880663e0000
RBP: 0000000000000000 R08: 0000000000000005 R09: 000000006d537749
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888067c460c0
R13: ffff888074694780 R14: ffff8880401231c0 R15: ffff888074694780
FS:  00007f439aedf6c0(0000) GS:ffff888124475000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000003540 CR3: 000000003994c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 drv_tx net/mac80211/driver-ops.h:38 [inline]
 ieee80211_tx_frags+0x5c9/0xa70 net/mac80211/tx.c:1746
 __ieee80211_tx+0x145/0x5b0 net/mac80211/tx.c:1801
 ieee80211_tx+0x336/0x460 net/mac80211/tx.c:1984
 ieee80211_xmit+0x30f/0x3e0 net/mac80211/tx.c:2076
 __ieee80211_tx_skb_tid_band+0x2c2/0x720 net/mac80211/tx.c:6369
 ieee80211_tx_skb_tid+0x1c1/0x550 net/mac80211/tx.c:6399
 ieee80211_mgmt_tx+0x1326/0x2590 net/mac80211/offchannel.c:1029
 rdev_mgmt_tx net/wireless/rdev-ops.h:767 [inline]
 cfg80211_mlme_mgmt_tx+0x803/0x1600 net/wireless/mlme.c:961
 nl80211_tx_mgmt+0x9f9/0xf30 net/wireless/nl80211.c:14358
 genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
 __sys_sendmsg+0x170/0x220 net/socket.c:2784
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4399f9cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f439aedf028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f439a216090 RCX: 00007f4399f9cdd9
RDX: 0000000028004800 RSI: 0000200000003740 RDI: 0000000000000003
RBP: 00007f439a032d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f439a216128 R14: 00007f439a216090 R15: 00007ffff74f7008
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

