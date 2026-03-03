Return-Path: <linux-wireless+bounces-32379-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pZmDIat6pml8QQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32379-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 07:07:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A986A1E9653
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 07:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64C0E3029A71
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 06:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA68358365;
	Tue,  3 Mar 2026 06:07:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1930F819
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518053; cv=none; b=j96R9xQQpbEqnKe3Wbp3OwUiZ1D4Qo5eoK25drYMSn7Oi7MndVTPnctgBrG5R0OdCTDhg3LFv4jJKiQAhCtsZE+IafrC41HsVcyo2oUIOzYcKIrXl/ByvVyRE0P+O9b46TBEV/tWt8QApf34WaHKyd2liY0ebtL6LUcMA869C3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518053; c=relaxed/simple;
	bh=vvrILT+iq8oS4mB6nITgoC6Lmr1isJ71LVd3pdQSF6E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ktd7gqwTaJXLMz1PkCvSYPefbhNmNot7YR4gNA4EuAk6i3+VkMC+y2p71J8DoaFsSy3CpwwGha+N+dn7ffpSJVIpc3Lk1JHQPilJxuo9EdGeUn5/tFLit7cSYKKEjngBHD2vrug4qUAhkmyzkqP8GOv99nxop7SYhIifBpYLGFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679dc77d151so90342960eaf.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 22:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518051; x=1773122851;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXYLFdJyo3qj8tElYEFbgHcNzB4ixy6p8N0OWxG4X4A=;
        b=Ky8x+JssjhfPsrKNrhFIaSdpmLVYN09SUqVrkkMGiRNmgyveHQtfoL9nq2fD3iS0r6
         G/yFo41AEKs2Fgeyli9fUU4hMO4Sej/NvrzAlUmb0g84lrMcxxtzBPxy0bNZ6vxRHruF
         Js2SgrhBSp5vRHg+r7uQ8y7yA6oUTysJiSw3I53f0ZFGLJd/HxvFhxHW/DAJp0+xWBAI
         2UoCZEgXEY6VEGHdEgWus0kjzdl9fkXn36ZZb5mYPxYTuJSUi/YvaOWYj14Aq2jiAlqk
         dXx3scu4Za+Xvjc2ChIu7UjhcILa+P3dbYq5N9UlwDL5wtm1olySWlxeDoT/Xleh1I2T
         Y75Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHsWM+xUOEd7B2WNA4EO2o94cVrW0xs/lXw8drFC3tljCc5DxAG6vTGIrw1xYvGTBc3EiJAI+92TrwtF3jew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZWIKvPrkEzB+3qgfQHWmbW+9Pj4OPJFBxnriyjITwxTKY1Et
	zIkyPOYGwE4Rep8tA+nPwVCESBHUp7d4tW8GiPzN9NtcW3BJMK7QpXIDV53wJFFJXJLvLqScFT1
	p0NFbNesc0J4xlo2U8WgUn1BwIqE7C63/J1vZ/FUwMzsK5hV6rtOANaLLhDk=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:208a:b0:679:97d5:dd25 with SMTP id
 006d021491bc7-679faf4e60bmr8716001eaf.56.1772518051182; Mon, 02 Mar 2026
 22:07:31 -0800 (PST)
Date: Mon, 02 Mar 2026 22:07:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a67aa3.a70a0220.b118c.000a.GAE@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in nl80211_send_pmsr_capa
From: syzbot <syzbot+c686c6b197d10ff3a749@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A986A1E9653
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=10f867da86e38691];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32379-lists,linux-wireless=lfdr.de,c686c6b197d10ff3a749];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.931];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,storage.googleapis.com:url,syzkaller.appspot.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email,googlegroups.com:email]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    eb71ab2bf722 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b7d0ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10f867da86e38691
dashboard link: https://syzkaller.appspot.com/bug?extid=c686c6b197d10ff3a749
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fcbe8b5437ef/disk-eb71ab2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/245a6565a05b/vmlinux-eb71ab2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a83b065baa80/bzImage-eb71ab2b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c686c6b197d10ff3a749@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nl80211_send_pmsr_ftm_capa net/wireless/nl80211.c:2302 [inline]
BUG: KMSAN: uninit-value in nl80211_send_pmsr_capa+0x6fe/0x1b50 net/wireless/nl80211.c:2404
 nl80211_send_pmsr_ftm_capa net/wireless/nl80211.c:2302 [inline]
 nl80211_send_pmsr_capa+0x6fe/0x1b50 net/wireless/nl80211.c:2404
 nl80211_send_wiphy+0x1464/0x96d0 net/wireless/nl80211.c:3302
 nl80211_dump_wiphy+0x5b6/0xc80 net/wireless/nl80211.c:3447
 genl_dumpit+0x14e/0x2a0 net/netlink/genetlink.c:1026
 netlink_dump+0xbaa/0x1800 net/netlink/af_netlink.c:2325
 netlink_recvmsg+0xc8a/0xfe0 net/netlink/af_netlink.c:1976
 sock_recvmsg_nosec+0x23e/0x2e0 net/socket.c:1078
 ____sys_recvmsg+0x4e5/0x620 net/socket.c:2810
 ___sys_recvmsg+0x20b/0x850 net/socket.c:2854
 do_recvmmsg+0x40e/0xdf0 net/socket.c:2949
 __sys_recvmmsg net/socket.c:3023 [inline]
 __do_sys_recvmmsg net/socket.c:3046 [inline]
 __se_sys_recvmmsg net/socket.c:3039 [inline]
 __x64_sys_recvmmsg+0x383/0x500 net/socket.c:3039
 x64_sys_call+0x96d/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 mac80211_hwsim_new_radio+0x60b8/0x7e20 drivers/net/wireless/virtual/mac80211_hwsim.c:5837
 hwsim_new_radio_nl+0x1839/0x3160 drivers/net/wireless/virtual/mac80211_hwsim.c:6504
 genl_family_rcv_msg_doit+0x338/0x3f0 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0xac5/0xc00 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x54d/0x680 net/netlink/af_netlink.c:2550
 genl_rcv+0x41/0x60 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x10b2/0x1250 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xfe7/0x1080 net/socket.c:2592
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2681
 x64_sys_call+0x1e20/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4522 [inline]
 slab_alloc_node mm/slub.c:4844 [inline]
 __kmalloc_cache_noprof+0x35e/0x1260 mm/slub.c:5353
 kmalloc_noprof include/linux/slab.h:950 [inline]
 hwsim_new_radio_nl+0x1705/0x3160 drivers/net/wireless/virtual/mac80211_hwsim.c:6492
 genl_family_rcv_msg_doit+0x338/0x3f0 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0xac5/0xc00 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x54d/0x680 net/netlink/af_netlink.c:2550
 genl_rcv+0x41/0x60 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x10b2/0x1250 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xfe7/0x1080 net/socket.c:2592
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2681
 x64_sys_call+0x1e20/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 15981 Comm: syz.5.4560 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
=====================================================


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

