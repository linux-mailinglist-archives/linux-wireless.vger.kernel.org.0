Return-Path: <linux-wireless+bounces-27142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D5DB4A254
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 08:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CDE1890012
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 06:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9A0303A3D;
	Tue,  9 Sep 2025 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GhxE7zhS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D03019B1;
	Tue,  9 Sep 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399640; cv=none; b=qP0TFj+1gcOa1yk7PHNs0J47W9Kge/XLHjObz16YJ9c4Vd901N+qnLACUlO2ArbW0w4XpBYa69JH6mZRoffz4UULrqeK20HTJopkJOd8z6DE9SFkgFjj59RUt38+zOccouDXYQtBDDgok+2zJgmZBUIP0fd0q9qsrlyjf/fY3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399640; c=relaxed/simple;
	bh=Ogqp4XpuBL7zJJTDs42HXfHEo3R5sIvtQqrPOh+C3Os=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BaTxhIke5Ntv4LwZfYXiDPWtCU0rNwjjiR/ER5kSHv8LWfwxklLWxdAEhk9zi/xkI4kS/h+T/cVM0OcONh+P6CqKkowyQCxBzfYNP3zSgLniqTDWERdkzkUbQm4G7e3SUCTrqWu3rZoI93PFaQJg5C+MBI0lLHJDKqq1mGHNHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GhxE7zhS; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0i
	bI9vEsP3MNEc9wHQ+cBn0xW5pSKNT6VjhUISVbHXA=; b=GhxE7zhS5WGBgpfF/t
	Ip6eSVueZdpc5689jRbQ/JkWIdRHAzG7pweO4rijIyJVeFuJXRxt5c3JCdMNHF+A
	eBDZKdoo9vfMk/TolmpXpEoVFXbLr6bnlLp5kFkHhljI82xS9hRecPLkiAmBGnNm
	WAYRln6qdb5dRjpwnZBz6eyQA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCHKMY4yr9ohNkqHw--.60047S2;
	Tue, 09 Sep 2025 14:33:29 +0800 (CST)
From: James Guan <guan_yufei@163.com>
To: johannes@sipsolutions.net
Cc: kuba@kernel.org,
	kuniyu@google.com,
	shaw.leon@gmail.com,
	kees@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Guan <guan_yufei@163.com>
Subject: [PATCH] wifi: cfg80211: Fix page fault in __cfg80211_connect_result()
Date: Tue,  9 Sep 2025 14:32:13 +0800
Message-Id: <20250909063213.1055024-1-guan_yufei@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHKMY4yr9ohNkqHw--.60047S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFW3uFWUCr1xCF1ftr18Zrb_yoW7Xw4Dpr
	yxtFZ8Gr4kJryUXr1UAF4UJr17ZanrAF1UXryIvr1rZa4UWw1DJryUGFW7Jry5Jr1DX3Wx
	Jr1kJw48t348GaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEgAwsUUUUU=
X-CM-SenderInfo: xjxd0s51xivxi6rwjhhfrp/1tbiJxzDS2i-wRhhzgABsT

When I attempted to connect to a virt_wifi device using iw on 6.17-rc5,
a page fault occurred in __cfg80211_connect_result(), preventing successful
connection.

The page fault is triggered because virt_wifi_connect_complete() sets
requested_bss to NULL when no BSSID is specified.

This patch fixes the bug by adding a check for a NULL connected_addr
before calling ether_addr_copy() in __cfg80211_connect_result().

Reproduction:
	root@host:~# modprobe virt_wifi
	root@host:~# ip tuntap add tap0 mode tap
	root@host:~# ip link set tap0 up
	root@host:~# ip link add link tap0 name wlan0 type virt_wifi
	root@host:~# iw dev wlan0 scan
	root@host:~# iw dev wlan0 connect "VirtWifi"

Kernel panic occurred after running the connect command.
Below is panic messages from kernel:

[  150.197544] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  150.199333] #PF: supervisor read access in kernel mode
[  150.199787] #PF: error_code(0x0000) - not-present page
[  150.200148] PGD 0 P4D 0
[  150.200339] Oops: Oops: 0000 [#1] SMP NOPTI
[  150.200641] CPU: 0 UID: 0 PID: 78 Comm: kworker/u4:5 Not tainted 6.17.0-rc5 #5 PREEMPT(voluntary)
[  150.201264] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  150.202056] Workqueue: cfg80211 cfg80211_event_work [cfg80211]
[  150.202528] RIP: 0010:__cfg80211_connect_result+0x35d/0xa40 [cfg80211]
[  150.203032] Code: 8d 14 db 49 89 84 d6 00 04 00 00 41 0f b7 44 24 68 41 83 c5 01 44 89 eb 66 85 c0 75 b6 48 85 db 74 c0 41 80 8e a4 00 00 00 01 <41> 8b 07c
[  150.204305] RSP: 0018:ffffc9000069bd10 EFLAGS: 00010202
[  150.204670] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[  150.205169] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888110e1f830
[  150.205666] RBP: ffffc9000069bd90 R08: ffffffff0000afd4 R09: 0000000000000003
[  150.206169] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8881065e4c18
[  150.206670] R13: 0000000000000001 R14: ffff888110e1f000 R15: 0000000000000000
[  150.207165] FS:  0000000000000000(0000) GS:ffff8881f7c3e000(0000) knlGS:0000000000000000
[  150.207723] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  150.208129] CR2: 0000000000000000 CR3: 000000010577d004 CR4: 0000000000372ef0
[  150.208627] Call Trace:
[  150.208811]  <TASK>
[  150.208972]  ? wakeup_preempt+0x74/0x80
[  150.209262]  cfg80211_process_wdev_events+0x13c/0x1b0 [cfg80211]
[  150.209738]  ? cfg80211_process_wdev_events+0x13c/0x1b0 [cfg80211]
[  150.210219]  cfg80211_process_rdev_events+0x2f/0x50 [cfg80211]
[  150.210766]  cfg80211_event_work+0x3a/0x60 [cfg80211]
[  150.211323]  process_scheduled_works+0xa3/0x420
[  150.211806]  worker_thread+0x12a/0x270
[  150.212170]  kthread+0x10d/0x230
[  150.212460]  ? __pfx_worker_thread+0x10/0x10
[  150.212770]  ? __pfx_kthread+0x10/0x10
[  150.213043]  ret_from_fork+0x8c/0x100
[  150.213322]  ? __pfx_kthread+0x10/0x10
[  150.213595]  ret_from_fork_asm+0x1a/0x30
[  150.213911]  </TASK>
[  150.214076] Modules linked in: virt_wifi cfg80211 intel_rapl_msr intel_rapl_common intel_uncore_frequency_common kvm_intel kvm bochs drm_client_lib drm_sh4
[  150.216925] CR2: 0000000000000000
[  150.217176] ---[ end trace 0000000000000000 ]---
[  150.217526] RIP: 0010:__cfg80211_connect_result+0x35d/0xa40 [cfg80211]
[  150.218120] Code: 8d 14 db 49 89 84 d6 00 04 00 00 41 0f b7 44 24 68 41 83 c5 01 44 89 eb 66 85 c0 75 b6 48 85 db 74 c0 41 80 8e a4 00 00 00 01 <41> 8b 07c
[  150.219483] RSP: 0018:ffffc9000069bd10 EFLAGS: 00010202
[  150.219863] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[  150.220372] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888110e1f830
[  150.220874] RBP: ffffc9000069bd90 R08: ffffffff0000afd4 R09: 0000000000000003
[  150.221379] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8881065e4c18
[  150.221899] R13: 0000000000000001 R14: ffff888110e1f000 R15: 0000000000000000
[  150.222433] FS:  0000000000000000(0000) GS:ffff8881f7c3e000(0000) knlGS:0000000000000000
[  150.223192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  150.223728] CR2: 0000000000000000 CR3: 000000010577d004 CR4: 0000000000372ef0
[  150.224373] note: kworker/u4:5[78] exited with irqs disabled

Signed-off-by: James Guan <guan_yufei@163.com>
---
 net/wireless/sme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 3a028ff287fb..6014d71d2845 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -863,7 +863,8 @@ void __cfg80211_connect_result(struct net_device *dev,
 		wdev->links[link].client.current_bss =
 			bss_from_pub(cr->links[link].bss);
 	wdev->connected = true;
-	ether_addr_copy(wdev->u.client.connected_addr, connected_addr);
+	if (connected_addr)
+		ether_addr_copy(wdev->u.client.connected_addr, connected_addr);
 	if (cr->valid_links) {
 		for_each_valid_link(cr, link)
 			memcpy(wdev->links[link].addr, cr->links[link].addr,
-- 
2.25.1


