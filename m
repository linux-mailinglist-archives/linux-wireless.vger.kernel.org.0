Return-Path: <linux-wireless+bounces-38342-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id toskG0OFQ2rtZwoAu9opvQ
	(envelope-from <linux-wireless+bounces-38342-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 10:58:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ABA6E1DA5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 10:58:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WPbeFeAJ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38342-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38342-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 404B63005D14
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D26363086;
	Tue, 30 Jun 2026 08:57:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88B35E1CD
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 08:57:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809853; cv=none; b=iIPVlgLIlgm1WmCAeg/v/oK5CDEImXlEPxYAMJCAl5/TY5UxOhSoW+r0Rfg/DtMN/AtAb8glgAot6TuqHWT5yPpqxNUyhfJZXKDSwDAyx+W4RB+DUNb4IEHoNj1b6duN4nTXrz2/ypYVRBmR8ARbrHl6NK7VSaJ/fVfs4fHKRAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809853; c=relaxed/simple;
	bh=QP7MnhyjHkwixD4wvWw7LYA+f2T1M6gYemhsfMVDB2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XAIRdSHCXI2SRpWf6h5SFpbs2as5W4/4GvhCQufxkg+lxBlLW3fNT14mPxTRH+WcyB1kRGXXf75f28NfJ4oYhEcbdPS/ymLv8enVoNeRoPwfRnCVlHAOVGm6TMcyve9yznpugX2wEGAk7+WZfovx/+NvJaJ1Aa36P5WW4ZSGtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPbeFeAJ; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37e4098e920so1750900a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782809851; x=1783414651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmeW29lE/reveI9D6VuZEeqyMevxHQzSv9Cd8XVySCQ=;
        b=WPbeFeAJucnv41zBgI8GTwU4Fr3JJ/YOu0iNVm/riDI8x5W8hOBM7b8LhXIWET5DbD
         xzlayXJcx0M5/Ea5e7ouMtwciAPplQA+mK1g8VACXgKHz9uPEJbyghv4xakaXeNjEfbU
         8OirWBDWN1q5jopFFTGMIxhCwg08JMvZJrfRjSdiGQG6kjVgvjlw82SGtLxsAYWNjcjG
         dReRK4r10iwQq7G8bYUwR3DDj0oQyve7okKyFzWYX2/vDYHnZqv/lxTRLcYpGVqvlqVq
         /IE4la/4Fe9v5QTjMcEW2EzNN+i8pdvwu/omBoc/zsddMQ3uO1ojmaThlA9xZbJdHKDO
         Ohtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782809851; x=1783414651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmeW29lE/reveI9D6VuZEeqyMevxHQzSv9Cd8XVySCQ=;
        b=O21/x5iKao6lcVHAcbmgua0IyugZsuXgALCBo1v9CG3ZwWd0jhuqlOda0uxT4vAivD
         oH8mA+znHUhtCI1tPOUPXW+A1h1tH+oyKqPuUqlZjQ4sefJY93iDtnT0FUR0roMSbSN3
         f+zL2G7jR4jNgbGyd5VGMvp7wweqJmBrrmssiJfHwlLnJuRgJBZPAMG9JAtyWWPRJ4XC
         KkNe6IExwMpTQ5kHQdTbn3oGFqTMqiQmSNjn2o/Px+Uq6NT5xu08TnSdojQysF7w5ScK
         LJLXbj22gvxLMNW516BWzlEMoxpCXR5wOXh4vhbAZebMTePbceA5WFOfSft0J/2XzVUk
         z0Ng==
X-Gm-Message-State: AOJu0YzzryKAv8ZWeHFobjarNhQMHXrwlF2wC5FlFa+Wr/xkh9mjWqQF
	qDIpm/dbOlprdOp5HgmA8fvWYN92BMLxIXxGxJFd1VMId1W2giKg7URev11wyg==
X-Gm-Gg: AfdE7ckHQ+w93SmFKWp2S21nt+HLoIKAmEjCUYDcPLV3YhNgZj1SHzNz5a4+Iap481W
	dhuPC8rmpyMd47Zj8GMR1VeHJLzXGRBzJIABD5TSXHu3UaRuJUw7wwaz5yJZbFwOBA/x+GBfHRM
	WBQ0sL914rgN2vl7hC3ZrosILqKSOk2ehv+W+U2QCuF8U0rtQ0u4hDOLDkGm8OoGF10S7h2N3ts
	k53vppN6xP4jY9/3QYiv8AhuCpR1hEeuEOu8xW7EmCNDnpCrrDqCdS7ClsGUFG5tM4rPwW0q9dc
	HC7HXCvr7zLFqSpzVFkY3CKClM8J/SQTOY33N4FeSBba+TPWKeb7IyBx2ZqiQEzZYgweOOlvvzm
	kZ8JAA7JiJeqqomUs7z4OfoZoL4VGAGdgbd9xpL83qUeo3ZvuV8gGLIc22G49/DbhqAfiXcnKGF
	QLZawaWNCF3p+0yEuk7LI6LuHTGPjj/A==
X-Received: by 2002:a17:90b:1847:b0:37f:d9dc:557 with SMTP id 98e67ed59e1d1-380527a8ac3mr2025393a91.16.1782809850910;
        Tue, 30 Jun 2026 01:57:30 -0700 (PDT)
Received: from gmail.com (vps-8b58878c.vps.ovh.us. [2604:2dc0:202:300::a96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38053408f51sm1271502a91.10.2026.06.30.01.57.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 01:57:30 -0700 (PDT)
From: Yue Sun <samsun1006219@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG REPORT] wifi: mac80211: userspace can trigger WARN_ON in ieee80211_add_nan_func()
Date: Tue, 30 Jun 2026 16:57:15 +0800
Message-ID: <20260630085719.3313-1-samsun1006219@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38342-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[samsun1006219@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samsun1006219@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5ABA6E1DA5

Hello,

I can reproduce a kernel warning in ieee80211_add_nan_func() on current
upstream master. The reproducer uses mac80211_hwsim to create a NAN-capable
radio, starts a NAN interface, and then sends NL80211_CMD_ADD_NAN_FUNCTION.

Summary
-------

The hwsim radio created with HWSIM_ATTR_SUPPORT_NAN_DEVICE advertises
WIPHY_NAN_FLAGS_USERSPACE_DE:

  drivers/net/wireless/virtual/mac80211_hwsim_main.c:
    hw->wiphy->nan_capa.flags = WIPHY_NAN_FLAGS_CONFIGURABLE_SYNC |
                                WIPHY_NAN_FLAGS_USERSPACE_DE;

nl80211_nan_add_func() validates the NAN function and calls
rdev_add_nan_func() without rejecting devices that have
WIPHY_NAN_FLAGS_USERSPACE_DE set.

mac80211 then reaches this invariant check:

  net/mac80211/cfg.c:
    if (WARN_ON(wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE))
            return -EOPNOTSUPP;

So an ordinary nl80211 request against such a wiphy can trigger a kernel
WARNING. Systems with panic_on_warn=1 would panic.

Likely fix direction
--------------------

Reject NL80211_CMD_ADD_NAN_FUNCTION (and likely DEL_NAN_FUNCTION) in nl80211
when wiphy->nan_capa.flags has WIPHY_NAN_FLAGS_USERSPACE_DE set, or otherwise
turn the mac80211 WARN_ON into a non-warning error return if this path is
expected to be reachable from userspace input.

Tested kernel:
- tree: /home/sy/linux
- branch: master
- HEAD: dc59e4fea9d83f03bad6bddf3fa2e52491777482
- uname in guest: 7.2.0-rc1-dirty #15 PREEMPT(full)
- bzImage: /home/sy/linux/arch/x86/boot/bzImage mtime=2026-06-29T12:23:31+00:00
- vmlinux: /home/sy/linux/vmlinux mtime=2026-06-29T12:22:03+00:00

Reproducer stdout
-----------------

candidate=round3i_hwsim_nan_wdev_no_panic_on_warn
panic_on_warn_disabled=1
nl80211_family=38
create_hwsim_nan_radio=2
wiphy_dump=0 count=4
create_nan_iface(wiphy=3)=0 name=klrnan9303
created_ifindex=0
create_nan_iface(wiphy=2)=-95 name=klrnan9303
create_nan_iface(wiphy=1)=-95 name=klrnan9303
create_nan_iface(wiphy=0)=-95 name=klrnan9303
post_nan_create_iface_dump=0 count=4
nan_iface ifindex=0 wdev=0x300000002 iftype=12
start_nan(ifindex=0 wdev=0x300000002 iftype=12)=0
add_nan_function_256_empty_tx_filters(ifindex=0 wdev=0x300000002 iftype=12)=-95

Crash log
---------

[   55.935664] ------------[ cut here ]------------
[   55.936899] wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE
[   55.936917] WARNING: net/mac80211/cfg.c:501 at ieee80211_add_nan_func+0x755/0x8f0, CPU#1: poc/9303
[   55.940025] Modules linked in:
[   55.941407] CPU: 1 UID: 0 PID: 9303 Comm: poc Not tainted 7.2.0-rc1-dirty #15 PREEMPT(full) 
[   55.943097] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   55.944742] RIP: 0010:ieee80211_add_nan_func+0x755/0x8f0
[   55.945943] Code: c6 e8 0f 3e c6 f6 84 db 0f 85 91 fc ff ff e8 32 44 c6 f6 48 8d 3d 0b 2b ef 05 67 48 0f b9 3a e9 7b fc ff ff e8 1c 44 c6 f6 90 <0f> 0b 90 41 bc a1 ff ff ff e9 2e fd ff ff e8 08 44 c6 f6 90 0f 0b
[   55.949426] RSP: 0018:ffffc90000627358 EFLAGS: 00010293
[   55.951038] RAX: 0000000000000000 RBX: ffff8880489f0010 RCX: ffffffff8afaaeac
[   55.952473] RDX: ffff888023033b80 RSI: ffffffff8afab504 RDI: 0000000000000005
[   55.953912] RBP: ffff8880271bbb00 R08: 0000000000000000 R09: ffffed100913e15a
[   55.955373] R10: 0000000000000002 R11: ffffffff81000130 R12: 0000000000000002
[   55.956808] R13: 0000000000000001 R14: ffff888037cf0740 R15: ffff8880489f1e10
[   55.958248] FS:  00000000092123c0(0000) GS:ffff8880d683e000(0000) knlGS:0000000000000000
[   55.959860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.961120] CR2: 00007ff4e81986f4 CR3: 000000004a924000 CR4: 00000000000006f0
[   55.962563] Call Trace:
[   55.963177]  <TASK>
[   55.963726]  ? genlmsg_put+0x265/0x2e0
[   55.964608]  nl80211_nan_add_func+0x10a3/0x1990
[   55.965630]  ? __mutex_lock+0x27a/0x1d80
[   55.966457]  ? __pfx_nl80211_nan_add_func+0x10/0x10
[   55.967442]  ? __rtnl_unlock+0x68/0xf0
[   55.968242]  ? netdev_run_todo+0x9e1/0x14f0
[   55.969112]  ? __pfx___mutex_lock+0x10/0x10
[   55.969979]  ? mutex_is_locked+0x17/0x60
[   55.970888]  ? nl80211_pre_doit+0x120/0xa70
[   55.971778]  genl_family_rcv_msg_doit+0x1ff/0x2f0
[   55.972740]  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[   55.973802]  ? bpf_lsm_capable+0x9/0x10
[   55.974613]  ? security_capable+0x210/0x250
[   55.975494]  genl_rcv_msg+0x532/0x7e0
[   55.976274]  ? __pfx_genl_rcv_msg+0x10/0x10
[   55.977147]  ? __pfx_nl80211_pre_doit+0x10/0x10
[   55.978024]  ? __pfx_nl80211_nan_add_func+0x10/0x10
[   55.978877]  ? __pfx_nl80211_post_doit+0x10/0x10
[   55.979700]  ? __lock_acquire+0x476/0x2420
[   55.980482]  netlink_rcv_skb+0x147/0x430
[   55.981216]  ? __pfx_genl_rcv_msg+0x10/0x10
[   55.981962]  ? __pfx_netlink_rcv_skb+0x10/0x10
[   55.982762]  ? netlink_deliver_tap+0x1ae/0xd10
[   55.983557]  genl_rcv+0x28/0x40
[   55.984168]  netlink_unicast+0x58d/0x850
[   55.984893]  ? __pfx_netlink_unicast+0x10/0x10
[   55.985698]  netlink_sendmsg+0x88d/0xd90
[   55.986425]  ? __pfx_netlink_sendmsg+0x10/0x10
[   55.987224]  ? __pfx_netlink_sendmsg+0x10/0x10
[   55.988018]  ____sys_sendmsg+0xa27/0xb90
[   55.988758]  ? __pfx_____sys_sendmsg+0x10/0x10
[   55.989555]  ? __pfx_copy_msghdr_from_user+0x10/0x10
[   55.990335]  ___sys_sendmsg+0x11c/0x1b0
[   55.991041]  ? __pfx____sys_sendmsg+0x10/0x10
[   55.991720]  ? selinux_file_permission+0x127/0x660
[   55.992473]  ? bpf_lsm_file_permission+0x9/0x10
[   55.993181]  ? security_file_permission+0x75/0x230
[   55.993921]  ? rw_verify_area+0xcf/0x6e0
[   55.994559]  ? vfs_write+0x169/0x1150
[   55.995167]  ? __pfx_anon_pipe_write+0x10/0x10
[   55.995859]  ? __pfx_vfs_write+0x10/0x10
[   55.996505]  __sys_sendmsg+0x142/0x1f0
[   55.997115]  ? __pfx___sys_sendmsg+0x10/0x10
[   55.997796]  do_syscall_64+0x11f/0x860
[   55.998410]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   55.999178] RIP: 0033:0x45a037
[   55.999693] Code: ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[   56.002154] RSP: 002b:00007ffcef8a8468 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   56.003176] RAX: ffffffffffffffda RBX: 00007ffcef8acca8 RCX: 000000000045a037
[   56.004138] RDX: 0000000000000000 RSI: 00007ffcef8a84a0 RDI: 0000000000000003
[   56.005118] RBP: 00007ffcef8a84e0 R08: 0000000000000000 R09: 0000000000000000
[   56.006087] R10: 000000000000000a R11: 0000000000000246 R12: 0000000000000001
[   56.007050] R13: 00007ffcef8acc98 R14: 00000000004cc7d0 R15: 0000000000000001
[   56.008023]  </TASK>
[   56.008404] irq event stamp: 21493
[   56.008924] hardirqs last  enabled at (21501): [<ffffffff819e796e>] __up_console_sem+0xae/0xc0
[   56.010081] hardirqs last disabled at (21508): [<ffffffff819e7953>] __up_console_sem+0x93/0xc0
[   56.011259] softirqs last  enabled at (21458): [<ffffffff817ed4f2>] __irq_exit_rcu+0x172/0x220
[   56.012406] softirqs last disabled at (21439): [<ffffffff817ed4f2>] __irq_exit_rcu+0x172/0x220
[   56.013560] ---[ end trace 0000000000000000 ]---

Warning: Permanently added '[127.0.0.1]:18122' (ED25519) to the list of known hosts.

PoC: poc.c
----------

#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/genetlink.h>
#include <linux/netlink.h>
#include <linux/nl80211.h>
#include <net/if.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/time.h>
#include <unistd.h>

#ifndef NLA_TYPE_MASK
#define NLA_TYPE_MASK 0x3fff
#endif
#ifndef NLA_HDRLEN
#define NLA_HDRLEN ((int) NLA_ALIGN(sizeof(struct nlattr)))
#endif
#ifndef GENL_HDRLEN
#define GENL_HDRLEN NLMSG_ALIGN(sizeof(struct genlmsghdr))
#endif

#define BUF_SZ 16384
#define MAX_WIPHYS 32
#define MAX_IFS 64

#define HWSIM_CMD_NEW_RADIO 4
#define HWSIM_ATTR_CHANNELS 9
#define HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE 16
#define HWSIM_ATTR_RADIO_NAME 17
#define HWSIM_ATTR_SUPPORT_NAN_DEVICE 30

struct msg {
	char buf[BUF_SZ];
	size_t len;
};

struct if_info {
	int ifindex;
	int iftype;
	uint64_t wdev;
};

struct dump_state {
	int vals[MAX_WIPHYS];
	int count;
};

struct if_dump_state {
	struct if_info ifs[MAX_IFS];
	int count;
};

static int seqno = 100;

static void disable_panic_on_warn(void)
{
	int fd = open("/proc/sys/kernel/panic_on_warn", O_WRONLY | O_CLOEXEC);

	if (fd < 0) {
		printf("panic_on_warn_open=%d\n", -errno);
		return;
	}
	if (write(fd, "0\n", 2) != 2)
		printf("panic_on_warn_write=%d\n", -errno);
	else
		printf("panic_on_warn_disabled=1\n");
	close(fd);
}

static int nla_ok(const struct nlattr *nla, int rem)
{
	return rem >= (int)sizeof(*nla) &&
	       nla->nla_len >= sizeof(*nla) &&
	       nla->nla_len <= rem;
}

static int nla_type(const struct nlattr *nla)
{
	return nla->nla_type & NLA_TYPE_MASK;
}

static void *nla_data(const struct nlattr *nla)
{
	return (char *)nla + NLA_HDRLEN;
}

static int nla_payload(const struct nlattr *nla)
{
	return nla->nla_len - NLA_HDRLEN;
}

static void parse_attrs(struct nlattr **tb, int max, void *data, int len)
{
	struct nlattr *nla = data;
	memset(tb, 0, sizeof(*tb) * (max + 1));
	while (nla_ok(nla, len)) {
		int type = nla_type(nla);
		if (type <= max)
			tb[type] = nla;
		len -= NLA_ALIGN(nla->nla_len);
		nla = (struct nlattr *)((char *)nla + NLA_ALIGN(nla->nla_len));
	}
}

static void msg_init(struct msg *m, int family, int flags, int cmd)
{
	struct nlmsghdr *nlh;
	struct genlmsghdr *gh;

	memset(m, 0, sizeof(*m));
	nlh = (struct nlmsghdr *)m->buf;
	nlh->nlmsg_type = family;
	nlh->nlmsg_flags = flags;
	nlh->nlmsg_seq = seqno++;
	nlh->nlmsg_pid = 0;
	nlh->nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
	gh = (struct genlmsghdr *)NLMSG_DATA(nlh);
	gh->cmd = cmd;
	gh->version = 0;
	m->len = nlh->nlmsg_len;
}

static int add_attr(struct msg *m, int type, const void *data, int len)
{
	struct nlmsghdr *nlh = (struct nlmsghdr *)m->buf;
	struct nlattr *nla;
	size_t need = NLA_HDRLEN + len;
	size_t aligned = NLA_ALIGN(need);

	if (m->len + aligned > sizeof(m->buf))
		return -1;
	nla = (struct nlattr *)(m->buf + m->len);
	nla->nla_type = type;
	nla->nla_len = need;
	if (len > 0 && data)
		memcpy((char *)nla + NLA_HDRLEN, data, len);
	if (aligned > need)
		memset((char *)nla + need, 0, aligned - need);
	m->len += aligned;
	nlh->nlmsg_len = m->len;
	return 0;
}

static int add_u8(struct msg *m, int type, uint8_t val)
{
	return add_attr(m, type, &val, sizeof(val));
}

static int add_u32(struct msg *m, int type, uint32_t val)
{
	return add_attr(m, type, &val, sizeof(val));
}

static int add_u64(struct msg *m, int type, uint64_t val)
{
	return add_attr(m, type, &val, sizeof(val));
}

static int nest_start(struct msg *m, int type)
{
	struct nlmsghdr *nlh = (struct nlmsghdr *)m->buf;
	struct nlattr *nla;
	size_t off = m->len;

	if (m->len + NLA_HDRLEN > sizeof(m->buf))
		return -1;
	nla = (struct nlattr *)(m->buf + m->len);
	nla->nla_type = type | NLA_F_NESTED;
	nla->nla_len = NLA_HDRLEN;
	m->len += NLA_HDRLEN;
	nlh->nlmsg_len = m->len;
	return (int)off;
}

static void nest_end(struct msg *m, int off)
{
	struct nlmsghdr *nlh = (struct nlmsghdr *)m->buf;
	struct nlattr *nla = (struct nlattr *)(m->buf + off);

	nla->nla_len = m->len - off;
	m->len = NLA_ALIGN(m->len);
	nlh->nlmsg_len = m->len;
}

static int nl_sock(void)
{
	struct sockaddr_nl sa;
	struct timeval tv = { .tv_sec = 3, .tv_usec = 0 };
	int fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_GENERIC);
	if (fd < 0)
		return -1;
	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
	memset(&sa, 0, sizeof(sa));
	sa.nl_family = AF_NETLINK;
	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
		close(fd);
		return -1;
	}
	return fd;
}

static int send_msg(int fd, struct msg *m)
{
	struct sockaddr_nl sa;
	struct iovec iov;
	struct msghdr mh;

	memset(&sa, 0, sizeof(sa));
	sa.nl_family = AF_NETLINK;
	iov.iov_base = m->buf;
	iov.iov_len = ((struct nlmsghdr *)m->buf)->nlmsg_len;
	memset(&mh, 0, sizeof(mh));
	mh.msg_name = &sa;
	mh.msg_namelen = sizeof(sa);
	mh.msg_iov = &iov;
	mh.msg_iovlen = 1;
	return sendmsg(fd, &mh, 0);
}

static int recv_genl(int fd, int seq, bool dump,
		     void (*cb)(struct nlmsghdr *, void *), void *arg)
{
	char rbuf[BUF_SZ];

	for (;;) {
		ssize_t n = recv(fd, rbuf, sizeof(rbuf), 0);
		struct nlmsghdr *nlh;
		int rem;

		if (n < 0)
			return -errno;
		rem = (int)n;
		for (nlh = (struct nlmsghdr *)rbuf; NLMSG_OK(nlh, rem);
		     nlh = NLMSG_NEXT(nlh, rem)) {
			if (nlh->nlmsg_seq != (unsigned)seq)
				continue;
			if (nlh->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *err = NLMSG_DATA(nlh);
				if (err->error)
					return err->error;
				return 0;
			}
			if (nlh->nlmsg_type == NLMSG_DONE)
				return 0;
			if (cb)
				cb(nlh, arg);
			if (!dump)
				return 0;
		}
	}
}

static int transact(int fd, struct msg *m, bool dump,
		    void (*cb)(struct nlmsghdr *, void *), void *arg)
{
	int seq = ((struct nlmsghdr *)m->buf)->nlmsg_seq;
	if (send_msg(fd, m) < 0)
		return -errno;
	return recv_genl(fd, seq, dump, cb, arg);
}

static void family_cb(struct nlmsghdr *nlh, void *arg)
{
	int *family = arg;
	struct genlmsghdr *gh = NLMSG_DATA(nlh);
	struct nlattr *tb[CTRL_ATTR_MAX + 1];
	int len = nlh->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);

	if (len < 0)
		return;
	parse_attrs(tb, CTRL_ATTR_MAX, (char *)gh + GENL_HDRLEN, len);
	if (tb[CTRL_ATTR_FAMILY_ID] &&
	    nla_payload(tb[CTRL_ATTR_FAMILY_ID]) >= 2)
		*family = *(uint16_t *)nla_data(tb[CTRL_ATTR_FAMILY_ID]);
}

static int resolve_family(int fd, const char *name)
{
	struct msg m;
	int family = -1;

	msg_init(&m, GENL_ID_CTRL, NLM_F_REQUEST, CTRL_CMD_GETFAMILY);
	add_attr(&m, CTRL_ATTR_FAMILY_NAME, name, strlen(name) + 1);
	if (transact(fd, &m, false, family_cb, &family) < 0)
		return -1;
	return family;
}

static int resolve_nl80211(int fd)
{
	return resolve_family(fd, "nl80211");
}

static int create_hwsim_nan_radio(int fd)
{
	struct msg m;
	int family = resolve_family(fd, "MAC80211_HWSIM");
	uint32_t channels = 1;
	char name[32];

	if (family < 0)
		return -ENOENT;

	snprintf(name, sizeof(name), "klr-nan-%d", getpid() % 10000);
	msg_init(&m, family, NLM_F_REQUEST | NLM_F_ACK, HWSIM_CMD_NEW_RADIO);
	add_u32(&m, HWSIM_ATTR_CHANNELS, channels);
	add_attr(&m, HWSIM_ATTR_RADIO_NAME, name, strlen(name) + 1);
	add_attr(&m, HWSIM_ATTR_SUPPORT_NAN_DEVICE, NULL, 0);
	add_attr(&m, HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE, NULL, 0);
	return transact(fd, &m, false, NULL, NULL);
}

static void wiphy_cb(struct nlmsghdr *nlh, void *arg)
{
	struct dump_state *st = arg;
	struct genlmsghdr *gh = NLMSG_DATA(nlh);
	struct nlattr *tb[NL80211_ATTR_MAX + 1];
	int len = nlh->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
	int wiphy, i;

	if (len < 0)
		return;
	parse_attrs(tb, NL80211_ATTR_MAX, (char *)gh + GENL_HDRLEN, len);
	if (!tb[NL80211_ATTR_WIPHY] ||
	    nla_payload(tb[NL80211_ATTR_WIPHY]) < 4)
		return;
	wiphy = *(uint32_t *)nla_data(tb[NL80211_ATTR_WIPHY]);
	for (i = 0; i < st->count; i++)
		if (st->vals[i] == wiphy)
			return;
	if (st->count < MAX_WIPHYS)
		st->vals[st->count++] = wiphy;
}

static int dump_wiphys(int fd, int family, struct dump_state *st)
{
	struct msg m;
	memset(st, 0, sizeof(*st));
	msg_init(&m, family, NLM_F_REQUEST | NLM_F_DUMP, NL80211_CMD_GET_WIPHY);
	return transact(fd, &m, true, wiphy_cb, st);
}

static void iface_cb(struct nlmsghdr *nlh, void *arg)
{
	struct if_dump_state *st = arg;
	struct genlmsghdr *gh = NLMSG_DATA(nlh);
	struct nlattr *tb[NL80211_ATTR_MAX + 1];
	int len = nlh->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
	int iftype, ifindex = 0;
	uint64_t wdev = 0;

	if (len < 0)
		return;
	parse_attrs(tb, NL80211_ATTR_MAX, (char *)gh + GENL_HDRLEN, len);
	if (!tb[NL80211_ATTR_IFTYPE] ||
	    nla_payload(tb[NL80211_ATTR_IFTYPE]) < 4)
		return;
	iftype = *(uint32_t *)nla_data(tb[NL80211_ATTR_IFTYPE]);
	if (tb[NL80211_ATTR_IFINDEX] &&
	    nla_payload(tb[NL80211_ATTR_IFINDEX]) >= 4)
		ifindex = *(uint32_t *)nla_data(tb[NL80211_ATTR_IFINDEX]);
	if (tb[NL80211_ATTR_WDEV] &&
	    nla_payload(tb[NL80211_ATTR_WDEV]) >= 8)
		wdev = *(uint64_t *)nla_data(tb[NL80211_ATTR_WDEV]);
	if (st->count >= MAX_IFS)
		return;
	st->ifs[st->count].ifindex = ifindex;
	st->ifs[st->count].iftype = iftype;
	st->ifs[st->count].wdev = wdev;
	st->count++;
}

static int dump_ifaces(int fd, int family, struct if_dump_state *st)
{
	struct msg m;
	memset(st, 0, sizeof(*st));
	msg_init(&m, family, NLM_F_REQUEST | NLM_F_DUMP, NL80211_CMD_GET_INTERFACE);
	return transact(fd, &m, true, iface_cb, st);
}

static int create_nan_iface(int fd, int family, int wiphy, char *ifname,
			    size_t ifname_len)
{
	struct msg m;
	int ret;

	snprintf(ifname, ifname_len, "klrnan%d", getpid() % 10000);
	msg_init(&m, family, NLM_F_REQUEST | NLM_F_ACK, NL80211_CMD_NEW_INTERFACE);
	add_u32(&m, NL80211_ATTR_WIPHY, wiphy);
	add_attr(&m, NL80211_ATTR_IFNAME, ifname, strlen(ifname) + 1);
	add_u32(&m, NL80211_ATTR_IFTYPE, NL80211_IFTYPE_NAN);
	ret = transact(fd, &m, false, NULL, NULL);
	return ret;
}

static int create_station_iface(int fd, int family, int wiphy, char *ifname,
				size_t ifname_len)
{
	struct msg m;
	int ret;

	snprintf(ifname, ifname_len, "klrwlan%d", getpid() % 10000);
	msg_init(&m, family, NLM_F_REQUEST | NLM_F_ACK, NL80211_CMD_NEW_INTERFACE);
	add_u32(&m, NL80211_ATTR_WIPHY, wiphy);
	add_attr(&m, NL80211_ATTR_IFNAME, ifname, strlen(ifname) + 1);
	add_u32(&m, NL80211_ATTR_IFTYPE, NL80211_IFTYPE_STATION);
	ret = transact(fd, &m, false, NULL, NULL);
	return ret;
}

static void add_wdev_selector(struct msg *m, int ifindex, uint64_t wdev)
{
	if (wdev)
		add_u64(m, NL80211_ATTR_WDEV, wdev);
	else
		add_u32(m, NL80211_ATTR_IFINDEX, ifindex);
}

static int start_nan(int fd, int family, int ifindex, uint64_t wdev)
{
	struct msg m;
	uint8_t pref = 2;

	msg_init(&m, family, NLM_F_REQUEST | NLM_F_ACK, NL80211_CMD_START_NAN);
	add_wdev_selector(&m, ifindex, wdev);
	add_u8(&m, NL80211_ATTR_NAN_MASTER_PREF, pref);
	return transact(fd, &m, false, NULL, NULL);
}

static int set_if_up(int ifindex)
{
	struct ifreq ifr;
	int s, ret;
	char name[IFNAMSIZ];

	if (!if_indextoname(ifindex, name))
		return -errno;
	s = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
	if (s < 0)
		return -errno;
	memset(&ifr, 0, sizeof(ifr));
	strncpy(ifr.ifr_name, name, sizeof(ifr.ifr_name) - 1);
	ret = ioctl(s, SIOCGIFFLAGS, &ifr);
	if (ret < 0) {
		ret = -errno;
		close(s);
		return ret;
	}
	ifr.ifr_flags |= IFF_UP;
	ret = ioctl(s, SIOCSIFFLAGS, &ifr);
	if (ret < 0)
		ret = -errno;
	else
		ret = 0;
	close(s);
	return ret;
}

static int add_nan_func_overflow(int fd, int family, int ifindex, uint64_t wdev)
{
	struct msg m;
	uint8_t service_id[NL80211_NAN_FUNC_SERVICE_ID_LEN] = {0};
	uint8_t type = NL80211_NAN_FUNC_SUBSCRIBE;
	int func, filt, i;

	msg_init(&m, family, NLM_F_REQUEST, NL80211_CMD_ADD_NAN_FUNCTION);
	add_wdev_selector(&m, ifindex, wdev);

	func = nest_start(&m, NL80211_ATTR_NAN_FUNC);
	if (func < 0)
		return -EMSGSIZE;
	add_u8(&m, NL80211_NAN_FUNC_TYPE, type);
	add_attr(&m, NL80211_NAN_FUNC_SERVICE_ID, service_id, sizeof(service_id));

	filt = nest_start(&m, NL80211_NAN_FUNC_TX_MATCH_FILTER);
	if (filt < 0)
		return -EMSGSIZE;
	for (i = 0; i < 256; i++) {
		if (add_attr(&m, i + 1, NULL, 0) < 0)
			return -EMSGSIZE;
	}
	nest_end(&m, filt);
	nest_end(&m, func);

	return transact(fd, &m, false, NULL, NULL);
}

static void try_one_if(int fd, int family, struct if_info info)
{
	int ret;

	if (info.ifindex > 0) {
		ret = set_if_up(info.ifindex);
		printf("set_if_up(ifindex=%d)=%d\n", info.ifindex, ret);
		sleep(1);
	}
	ret = start_nan(fd, family, info.ifindex, info.wdev);
	printf("start_nan(ifindex=%d wdev=0x%llx iftype=%d)=%d\n",
	       info.ifindex, (unsigned long long)info.wdev, info.iftype, ret);
	ret = add_nan_func_overflow(fd, family, info.ifindex, info.wdev);
	printf("add_nan_function_256_empty_tx_filters(ifindex=%d wdev=0x%llx iftype=%d)=%d\n",
	       info.ifindex, (unsigned long long)info.wdev, info.iftype, ret);
}

int main(void)
{
	struct dump_state wiphys;
	struct if_dump_state ifs;
	int fd, family, ret, i;

	setvbuf(stdout, NULL, _IONBF, 0);
	printf("candidate=round3i_hwsim_nan_wdev_no_panic_on_warn\n");
	disable_panic_on_warn();

	fd = nl_sock();
	if (fd < 0) {
		perror("netlink");
		return 1;
	}
	family = resolve_nl80211(fd);
	if (family < 0) {
		printf("nl80211 family not available\n");
		return 0;
	}
	printf("nl80211_family=%d\n", family);

	ret = create_hwsim_nan_radio(fd);
	printf("create_hwsim_nan_radio=%d\n", ret);
	sleep(2);

	ret = dump_wiphys(fd, family, &wiphys);
	printf("wiphy_dump=%d count=%d\n", ret, wiphys.count);
	for (i = 0; i < wiphys.count; i++) {
		char ifname[IFNAMSIZ];
		int ifindex;

		ret = create_nan_iface(fd, family, wiphys.vals[i], ifname,
				       sizeof(ifname));
		printf("create_nan_iface(wiphy=%d)=%d name=%s\n",
		       wiphys.vals[i], ret, ifname);
		if (ret < 0)
			continue;
		sleep(1);
		ifindex = if_nametoindex(ifname);
		printf("created_ifindex=%d\n", ifindex);
	}

	ret = dump_ifaces(fd, family, &ifs);
	printf("post_nan_create_iface_dump=%d count=%d\n", ret, ifs.count);
	for (i = 0; i < ifs.count; i++) {
		if (ifs.ifs[i].iftype != NL80211_IFTYPE_NAN)
			continue;
		printf("nan_iface ifindex=%d wdev=0x%llx iftype=%d\n",
		       ifs.ifs[i].ifindex, (unsigned long long)ifs.ifs[i].wdev,
		       ifs.ifs[i].iftype);
		try_one_if(fd, family, ifs.ifs[i]);
		break;
	}

	close(fd);
	return 0;
}

