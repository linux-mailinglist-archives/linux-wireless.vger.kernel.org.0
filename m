Return-Path: <linux-wireless+bounces-25172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1278DAFFB49
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 09:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E516C3B1DC7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 07:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA5023B626;
	Thu, 10 Jul 2025 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fia7RcU+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CIqBhEG7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C322FDEC
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133634; cv=none; b=sYoWg9rL/OztNqdaN+qZLAxZREhE/ZjTI8AY8jhMkrK6yxzCdBQzu5UlItyf3NJ8ouTKN3zHoHA0Ko0w0NsLSTSsLtroZl2wlTBRsOwr4VD9oYR6RXHJhX1tV3M0KIG8RFWjNBWUziqqvKbD2zqBwE0656XF1pI8KMBHbkUSC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133634; c=relaxed/simple;
	bh=Cs9Vet9+y4pqCPaTE/ZAhUEpraQsCm8ezCWbyjMHK0I=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=URPZo92mN3ia6tnjEshb/8SPQ5rfMnH8PNjWvgek+MXvO68PsMiWAKWdS6AUiHmpkEmossVuq9RgVoUNQvgzYSxrwRz2RrhM1C0xfhcuPNLNiWHk00TVQ1UUG9LUClPHDXD44P5oBZ8n/8RPmfjM7R5mAfSsfkgsYkrUoaKFv94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fia7RcU+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CIqBhEG7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <a9de62a0-28f1-4981-84df-253489da74ed@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752133630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AwZEBbpsxzYdzVGw0G60IakcpnD+tCviU1RQXfM0gaM=;
	b=Fia7RcU+8QOALD6F34u4sB8q6Ml4oaVBTRuDo6xYWUGLyZeW3fkKFHlALO3A/7AQb/hwWF
	UIswL2RdZzl2IzreuOB7+MROPU9zu+qynAMsmYxMWl5B4usftCjRoQ1QbFcBtYLBnV7kyZ
	ZFlN3U1TceMVn4CCnna4slZk6KxBV8rbAzCrf4tb5qm4SXFHRsONPC9DnRzxGUZaLMQH1j
	K9sSscbJsHMXpk/g0YKRNMW3yhhsY4J7dFkSBbuBOUQXYPjisHUfN4n/O9tuytCLkNiaEa
	beTphd+4/kjXQXzMAQP8XRt7Fy3wm+MbEZm5zmwYaQDRIgq9JIQHKyN6a+Z/gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752133630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AwZEBbpsxzYdzVGw0G60IakcpnD+tCviU1RQXfM0gaM=;
	b=CIqBhEG7BGJgEStYkOXX30tnQSbJIUOpR1wxtAl4mCirgfM4FnJM/je2Vuwk9aIKvVqBuP
	Wg4p8erSaOBWt8Bg==
Date: Thu, 10 Jul 2025 09:47:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>
From: Martin Kaistra <martin.kaistra@linutronix.de>
Subject: WARNING check-sdata-in-driver in ieee80211_link_info_change_notify
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

when trying to use monitor mode with either rtl8xxxu or rtlwifi driver I get a 
"Failed check-sdata-in-driver check" warning in 
ieee80211_link_info_change_notify(). Aside from the warning, monitor mode seems 
to work fine. This might also affect other drivers, I just don't have the 
hardware to test.

I bisected and found that the warning started with c4382d5ca1af ("wifi: 
mac80211: update the right link for tx power").

I can make the warning go away when I add WANT_MONITOR_VIF to the driver, but 
the real fix should probably go in mac80211.

[   48.529085] ------------[ cut here ]------------
[   48.530216] phy0-monitor: Failed check-sdata-in-driver check, flags: 0x0
[   48.531154] WARNING: CPU: 0 PID: 260 at net/mac80211/main.c:413 
ieee80211_link_info_change_notify0
[   48.532423] Modules linked in: rtl8xxxu
[   48.532949] CPU: 0 UID: 0 PID: 260 Comm: ip Not tainted 
6.14.0-rc6-g1794d7ab34d2 #67
[   48.533957] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
1.16.2-debian-1.16.2-1 044
[   48.535245] RIP: 0010:ieee80211_link_info_change_notify+0xa1/0xe0
[   48.536240] Code: b3 58 06 00 00 4c 89 04 24 48 c7 c7 38 13 80 82 c6 05 e7 37 
ba 00 01 48 8d 88 2b
[   48.541667] RSP: 0018:ffffc900002bb5e8 EFLAGS: 00010282
[   48.542772] RAX: 0000000000000000 RBX: ffff88800486a000 RCX: 0000000000000000
[   48.543700] RDX: ffff88807dc28f20 RSI: ffff88807dc1c940 RDI: ffff88807dc1c940
[   48.544666] RBP: ffff88800486adc0 R08: 0000000000009ffb R09: 00000000ffffdfff
[   48.545626] R10: 00000000ffffdfff R11: ffffffff82a59b80 R12: ffff8880077cc8e0
[   48.546594] R13: ffff88800486adc0 R14: ffff888005ba8c00 R15: 0000000000000000
[   48.547584] FS:  00007f5e551961c0(0000) GS:ffff88807dc00000(0000) 
knlGS:0000000000000000
[   48.548699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.549519] CR2: 00007f5e552acc30 CR3: 0000000005b9e000 CR4: 00000000000006f0
[   48.550513] Call Trace:
[   48.550884]  <TASK>
[   48.551210]  ? __warn+0x89/0x130
[   48.551664]  ? ieee80211_link_info_change_notify+0xa1/0xe0
[   48.552447]  ? report_bug+0x164/0x190
[   48.552979]  ? handle_bug+0x53/0x90
[   48.553472]  ? exc_invalid_op+0x17/0x70
[   48.554031]  ? asm_exc_invalid_op+0x1a/0x20
[   48.554603]  ? ieee80211_link_info_change_notify+0xa1/0xe0
[   48.555376]  ? ieee80211_link_info_change_notify+0xa1/0xe0
[   48.556136]  ieee80211_assign_link_chanctx+0x180/0x330
[   48.556849]  _ieee80211_link_use_channel+0x353/0x3a0
[   48.557540]  ? snprintf+0x4d/0x70
[   48.558009]  ? ieee80211_link_init+0x148/0x1d0
[   48.558558]  ieee80211_add_virtual_monitor+0x14a/0x260
[   48.559094]  ieee80211_do_open+0x6ee/0x750
[   48.559576]  ieee80211_open+0x6b/0x90
[   48.560231]  __dev_open+0x101/0x210
[   48.560586]  __dev_change_flags+0x1b1/0x220
[   48.561023]  netif_change_flags+0x26/0x70
[   48.561427]  do_setlink.constprop.0+0x357/0x1250
[   48.561921]  ? avc_has_perm_noaudit+0x6b/0xf0
[   48.562597]  ? cred_has_capability.isra.0+0x75/0x110
[   48.563491]  rtnl_newlink+0x835/0xc10
[   48.564200]  ? cred_has_capability.isra.0+0x75/0x110
[   48.564700]  ? __rtnl_unlock+0x37/0x70
[   48.565089]  ? __pfx_rtnl_newlink+0x10/0x10
[   48.565512]  rtnetlink_rcv_msg+0x356/0x3f0
[   48.565937]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   48.566425]  netlink_rcv_skb+0x5b/0x110
[   48.566818]  netlink_unicast+0x245/0x390
[   48.567225]  netlink_sendmsg+0x1f7/0x440
[   48.567624]  ____sys_sendmsg+0x2e4/0x310
[   48.568035]  ? copy_msghdr_from_user+0x6d/0xa0
[   48.568494]  ___sys_sendmsg+0x86/0xd0
[   48.568863]  ? fsnotify_grab_connector+0x42/0x80
[   48.569332]  ? fsnotify_destroy_marks+0x2a/0x1a0
[   48.569804]  ? __call_rcu_common.constprop.0+0x8b/0x260
[   48.570354]  __sys_sendmsg+0x6a/0xc0
[   48.570729]  do_syscall_64+0x4b/0x110
[   48.571117]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   48.571613] RIP: 0033:0x7f5e552bdf43
[   48.571989] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 
00 00 90 64 8b 04 28
[   48.573838] RSP: 002b:00007fffcec71dc8 EFLAGS: 00000246 ORIG_RAX: 
000000000000002e
[   48.574601] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5e552bdf43
[   48.575313] RDX: 0000000000000000 RSI: 00007fffcec71e30 RDI: 0000000000000003
[   48.576543] RBP: 00000000686388b9 R08: 0000000000000001 R09: 00007f5e5538fbe0
[   48.577810] R10: 0000000000000076 R11: 0000000000000246 R12: 0000000000000001
[   48.579140] R13: 00007fffcec71f00 R14: 0000000000000000 R15: 0000563fc755e020
[   48.579928]  </TASK>
[   48.580176] ---[ end trace 0000000000000000 ]---


