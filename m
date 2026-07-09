Return-Path: <linux-wireless+bounces-38833-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sT5qA17NT2pBogIAu9opvQ
	(envelope-from <linux-wireless+bounces-38833-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 18:33:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E667337FF
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 18:33:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38833-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38833-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66FF4302770F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8609438657E;
	Thu,  9 Jul 2026 16:33:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953B12E7657
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 16:33:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614811; cv=none; b=PeCkbLZXAWwsJdYI6T0SxDcwDpTgKn18AohFLUGxNiLd2J9QEtC6vSSArUbqpUhndISY7UkEnyQsR0iYBeFEQTRGFlBMemuAEbQsS0BCH4YjLq0/1Wtc/IF0u7Msfd5DM3J8OTYobhw43QAmCkMwfdM5FivFbOWEM8gvks5zDAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614811; c=relaxed/simple;
	bh=6UNNG7WBDt6OxUMGVA+8H51/6/bpImnZialtBK8q4hs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LjJRUQtvL73OTIEq2UHxN56Wq1Q2iI1W3HQ2a9h94rh9sh/BU0RcW1A/b8bZ7/QTIJ2M/p+7c6NHCBXjjHy9rMaqY5IsDrhlDkEektQHd9wfiLYUAuzQ/bhkU3MhTO5w0+ZQoYNMjwWUb1az5iyf8MgbdxaBwcwkAVJeAwMJnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6a372a5be46so114655eaf.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 09:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783614808; x=1784219608;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ygi+3cwlsJDrAZNNyjJz8DGlwNv1izQK5kISJercTSQ=;
        b=rhNDwRx+VtkIx3WwCEsIQsTUSGjhX5H3ovRXetvsA1NiWYy2YXzvCboZuNfehGN4DW
         7m4bmQrV6vsiyL0Le4xD92X7AllUWvE+kRFz2aF5ou4yHiyEP7+rhng+ULOQ+m8dydbb
         1KunvLubyqsRS9hyeboi9RqTpzxLzcCSlJOBUSyq6azbo6P0ZdYX8rhQzn+2ynO4v768
         pi8OXcS+32IgdSqjcZ7oitNiMxbomk9214C7Alvwg1l87aSLEeikOpdsK+vGEJ5VhHGK
         X2/pCBf6ztTZdY7HlRb4Nxe6HzRS/9AY2kcfmyUF9YR4DRhT4SYyd+tdYA0MAhZ6uWJi
         ljSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9f5MAG2pfAWgVmFf0o0BiXXKanSmdCrBgqOB1HHOhW6brlYtEQFwUjfzQkJhHGn8HYXD/1tP6Fj30JASnBmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwlMMlchVWAU5vg9iDCMDFHgKnf3xc2Q7KwRn9LHJ+SvtxkqCX
	ofbiAuDBb9ht8L/7CLgzkQZaKxAD4shYp5xHpMabfdTGex60toWjRydIA47LEisrASE06VbTgOB
	2+8CJSQ6cH7i64RhAcM3tTZBFAmci/s2q8YG8By1rbvRT6xPSgRl10xkPNCk=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1693:b0:6a3:10fc:766d with SMTP id
 006d021491bc7-6a36da71c03mr5771854eaf.47.1783614808551; Thu, 09 Jul 2026
 09:33:28 -0700 (PDT)
Date: Thu, 09 Jul 2026 09:33:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4fcd58.a1ad617e.25832.000e.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-out-of-bounds Read in
 ieee80211_ie_split_ric (3)
From: syzbot <syzbot+cc867e537e4bd36f69bb@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ecdef466b08b9772];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38833-lists,linux-wireless=lfdr.de,cc867e537e4bd36f69bb];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email,storage.googleapis.com:url];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-wireless];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66E667337FF

Hello,

syzbot found the following issue on:

HEAD commit:    a52d6c7160f7 selftests/arm64: fix spelling errors in comme..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17ddd739580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecdef466b08b9772
dashboard link: https://syzkaller.appspot.com/bug?extid=cc867e537e4bd36f69bb
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13940432580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156e7d89580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af2ea186884f/disk-a52d6c71.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cef93b18732f/vmlinux-a52d6c71.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9f9b8922f14/Image-a52d6c71.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc867e537e4bd36f69bb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in skip_ie net/wireless/util.c:2068 [inline]
BUG: KASAN: slab-out-of-bounds in ieee80211_ie_split_ric+0x4a8/0x508 net/wireless/util.c:-1
Read of size 1 at addr ffff0000c2aac9c1 by task syz.0.18/4930

CPU: 0 UID: 0 PID: 4930 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/02/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xb0/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0x8c/0xc4 mm/kasan/report.c:595
 __asan_report_load1_noabort+0x20/0x2c mm/kasan/report_generic.c:378
 skip_ie net/wireless/util.c:2068 [inline]
 ieee80211_ie_split_ric+0x4a8/0x508 net/wireless/util.c:-1
 ieee80211_ie_split include/net/cfg80211.h:10226 [inline]
 cfg80211_sme_get_conn_ies net/wireless/sme.c:529 [inline]
 cfg80211_sme_connect net/wireless/sme.c:586 [inline]
 cfg80211_connect+0xca8/0x1be4 net/wireless/sme.c:1528
 cfg80211_mgd_wext_connect+0x3ac/0x508 net/wireless/wext-sme.c:57
 cfg80211_mgd_wext_siwessid+0x2c4/0x40c net/wireless/wext-sme.c:184
 cfg80211_wext_siwessid+0xc4/0x13c net/wireless/wext-compat.c:1415
 ioctl_standard_iw_point+0x678/0xb04 net/wireless/wext-core.c:864
 ioctl_standard_call+0xb4/0x178 net/wireless/wext-core.c:1049
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0x104/0x36c net/wireless/wext-core.c:1013
 wext_handle_ioctl+0x154/0x288 net/wireless/wext-core.c:1074
 sock_ioctl+0x154/0x7ec net/socket.c:1353
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __arm64_sys_ioctl+0x14c/0x1c4 fs/ioctl.c:583
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594

Allocated by task 4930:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:78
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:570
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5362 [inline]
 __kmalloc_node_track_caller_noprof+0x434/0x6d4 mm/slub.c:5497
 kmemdup_noprof+0x44/0x8c mm/util.c:138
 kmemdup_noprof include/linux/fortify-string.h:715 [inline]
 cfg80211_wext_siwgenie+0x170/0x28c net/wireless/wext-sme.c:322
 ioctl_standard_iw_point+0x678/0xb04 net/wireless/wext-core.c:864
 ioctl_standard_call+0xb4/0x178 net/wireless/wext-core.c:1049
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0x104/0x36c net/wireless/wext-core.c:1013
 wext_handle_ioctl+0x154/0x288 net/wireless/wext-core.c:1074
 sock_ioctl+0x154/0x7ec net/socket.c:1353
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __arm64_sys_ioctl+0x14c/0x1c4 fs/ioctl.c:583
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594

The buggy address belongs to the object at ffff0000c2aac9c0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 1-byte region [ffff0000c2aac9c0, ffff0000c2aac9c1)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff0000c2aaca20 pfn:0x102aac
flags: 0x5ffc00000000200(workingset|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000200 ffff0000c0001500 ffff0000c0000348 fffffdffc30937d0
raw: ffff0000c2aaca20 0000000800800064 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000c2aac880: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff0000c2aac900: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
>ffff0000c2aac980: fa fc fc fc fa fc fc fc 01 fc fc fc fa fc fc fc
                                           ^
 ffff0000c2aaca00: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff0000c2aaca80: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
==================================================================
------------[ cut here ]------------
memcpy: detected buffer overflow: 18446744073709551615 byte write of buffer size 0
WARNING: lib/string_helpers.c:1037 at __fortify_report+0xa0/0xb8 lib/string_helpers.c:1036, CPU#0: syz.0.18/4930
Modules linked in:
CPU: 0 UID: 0 PID: 4930 Comm: syz.0.18 Tainted: G    B               syzkaller #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/02/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __fortify_report+0xa0/0xb8 lib/string_helpers.c:1036
lr : __fortify_report+0xa0/0xb8 lib/string_helpers.c:1036
sp : ffff8000986876a0
x29: ffff8000986876a0 x28: 1fffe000199c09e6 x27: 1fffe000199c09da
x26: ffff0000c2aac9c0 x25: 0000000000000001 x24: ffff0000d02ad200
x23: ffff0000cce04ed0 x22: ffff800086cbcad8 x21: 0000000000000001
x20: ffffffffffffffff x19: 0000000000000000 x18: 0000000000000000
x17: 3d3d3d3d3d3d3d3d x16: 3d3d3d3d3d3d3d3d x15: 3d3d3d3d3d3d3d3d
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000002 x9 : e75ac9114b2ee700
x8 : e75ac9114b2ee700 x7 : 0000000000000000 x6 : ffff80008048ce60
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000802f7010
x2 : 0000000100000000 x1 : ffff0000d1543a80 x0 : 0000000000000000
Call trace:
 __fortify_report+0xa0/0xb8 lib/string_helpers.c:1036 (P)
 __fortify_panic+0x10/0x14 lib/string_helpers.c:1043
 fortify_memcpy_chk include/linux/fortify-string.h:547 [inline]
 cfg80211_sme_get_conn_ies net/wireless/sme.c:533 [inline]
 cfg80211_sme_connect net/wireless/sme.c:586 [inline]
 cfg80211_connect+0x1918/0x1be4 net/wireless/sme.c:1528
 cfg80211_mgd_wext_connect+0x3ac/0x508 net/wireless/wext-sme.c:57
 cfg80211_mgd_wext_siwessid+0x2c4/0x40c net/wireless/wext-sme.c:184
 cfg80211_wext_siwessid+0xc4/0x13c net/wireless/wext-compat.c:1415
 ioctl_standard_iw_point+0x678/0xb04 net/wireless/wext-core.c:864
 ioctl_standard_call+0xb4/0x178 net/wireless/wext-core.c:1049
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0x104/0x36c net/wireless/wext-core.c:1013
 wext_handle_ioctl+0x154/0x288 net/wireless/wext-core.c:1074
 sock_ioctl+0x154/0x7ec net/socket.c:1353
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __arm64_sys_ioctl+0x14c/0x1c4 fs/ioctl.c:583
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
irq event stamp: 1077
hardirqs last  enabled at (1077): [<ffff8000868c3474>] irqentry_exit_to_kernel_mode_after_preempt include/linux/irq-entry-common.h:507 [inline]
hardirqs last  enabled at (1077): [<ffff8000868c3474>] arm64_exit_to_kernel_mode+0x80/0x94 arch/arm64/kernel/entry-common.c:62
hardirqs last disabled at (1076): [<ffff8000868bf484>] __el1_irq arch/arm64/kernel/entry-common.c:506 [inline]
hardirqs last disabled at (1076): [<ffff8000868bf484>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:522
softirqs last  enabled at (978): [<ffff800084c68eac>] local_bh_enable include/linux/bottom_half.h:33 [inline]
softirqs last  enabled at (978): [<ffff800084c68eac>] rcu_read_unlock_bh include/linux/rcupdate.h:914 [inline]
softirqs last  enabled at (978): [<ffff800084c68eac>] __dev_queue_xmit+0x14d0/0x2ba4 net/core/dev.c:4907
softirqs last disabled at (972): [<ffff800084c67bd8>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (972): [<ffff800084c67bd8>] rcu_read_lock_bh include/linux/rcupdate.h:893 [inline]
softirqs last disabled at (972): [<ffff800084c67bd8>] __dev_queue_xmit+0x1fc/0x2ba4 net/core/dev.c:4793
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
kernel BUG at lib/string_helpers.c:1044!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 4930 Comm: syz.0.18 Tainted: G    B   W           syzkaller #0 PREEMPT 
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/02/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __fortify_panic+0x10/0x14 lib/string_helpers.c:1043
lr : __fortify_panic+0x10/0x14 lib/string_helpers.c:1043
sp : ffff8000986876d0
x29: ffff8000986876d0 x28: 1fffe000199c09e6 x27: 1fffe000199c09da
x26: ffff0000c2aac9c0 x25: 0000000000000001 x24: ffff0000d02ad200
x23: ffff0000cce04ed0 x22: 0000000000000002 x21: 0000000000000000
x20: ffff0000e2cc0740 x19: ffffffffffffffff x18: 0000000000000000
x17: 3d3d3d3d3d3d3d3d x16: 3d3d3d3d3d3d3d3d x15: 3d3d3d3d3d3d3d3d
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000002 x9 : e75ac9114b2ee700
x8 : e75ac9114b2ee700 x7 : 0000000000000000 x6 : ffff80008048ce60
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000802f7010
x2 : 0000000100000000 x1 : ffff0000d1543a80 x0 : 0000000000000000
Call trace:
 __fortify_panic+0x10/0x14 lib/string_helpers.c:1043 (P)
 fortify_memcpy_chk include/linux/fortify-string.h:547 [inline]
 cfg80211_sme_get_conn_ies net/wireless/sme.c:533 [inline]
 cfg80211_sme_connect net/wireless/sme.c:586 [inline]
 cfg80211_connect+0x1918/0x1be4 net/wireless/sme.c:1528
 cfg80211_mgd_wext_connect+0x3ac/0x508 net/wireless/wext-sme.c:57
 cfg80211_mgd_wext_siwessid+0x2c4/0x40c net/wireless/wext-sme.c:184
 cfg80211_wext_siwessid+0xc4/0x13c net/wireless/wext-compat.c:1415
 ioctl_standard_iw_point+0x678/0xb04 net/wireless/wext-core.c:864
 ioctl_standard_call+0xb4/0x178 net/wireless/wext-core.c:1049
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0x104/0x36c net/wireless/wext-core.c:1013
 wext_handle_ioctl+0x154/0x288 net/wireless/wext-core.c:1074
 sock_ioctl+0x154/0x7ec net/socket.c:1353
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __arm64_sys_ioctl+0x14c/0x1c4 fs/ioctl.c:583
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
Code: d503233f a9bf7bfd 910003fd 94618cfa (d4210000) 
---[ end trace 0000000000000000 ]---


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

