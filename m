Return-Path: <linux-wireless+bounces-34878-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NkWJ7mu4GkRkwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34878-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 11:41:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD86640C83B
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 11:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA87530F278F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC1D33D503;
	Thu, 16 Apr 2026 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E0J5Y2Aa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A0382F32
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776332079; cv=none; b=uihmCQr2zQ7SpxvMmxJhy78cehZe17MJa8PZtVzCI5o4is7UqRr9BgAGzPBa6MxF3qk7LkB/A3DuRvoKt0gm2voVoX5RShnFOMjDSuS7oydBpjvXW0QgA0lT65Eq2PwgAV0GcygcXCG42TuntA1t8QD6qqo2SxX0TPn/eEWxxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776332079; c=relaxed/simple;
	bh=tWmas1cm6B5QN1jq8ekbiSzKgEB5Kt9NC51/8xvjC3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=s88+JyRLjJTip3/91g9aT0ZtSDTT1LjamBYn0b6vw6Hk4pX7NIHG+HFW0gobt8RfTW+ev+3+JqhVzPu45EM2dom5rNTZG7vWKV6Hlw+5PX5kXtnUgkLSx9u0rpP4THyXimIp6nULtRm2+fTRWhyV13wl6yuwceP1xyN7R5uDbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E0J5Y2Aa; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260416093428euoutp021b67d478df453aaa5e9ea1591d7d261e~mzJrtzIny2534725347euoutp02M
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 09:34:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260416093428euoutp021b67d478df453aaa5e9ea1591d7d261e~mzJrtzIny2534725347euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776332068;
	bh=23FazvtiCIPv2qrEXvDfkLiYN3Ax9w9NKvlIby1PYlo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=E0J5Y2Aa+QRx2NIYqv4jOcOQ69f7AtBW0WLnk+N2syJsJsU6QJQOKZNgplXE2D5YI
	 Bt5Q40ZI2cYu53JOIKOUvQQrUpzzeLrqKIjLx+F6rHL4a4P2ks8XUrQovyOf/69wvN
	 FoJVfkYciuwdhjXF43oUT0kgndh98WKfJoTMKBtM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260416093428eucas1p2fde898f84c1e15dd94d1ecb52707c72b~mzJrbkITF1661516615eucas1p2c;
	Thu, 16 Apr 2026 09:34:28 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260416093428eusmtip1af3f197c1f60f0a9d44c4640aeca3c7b~mzJrJ2eQc0938209382eusmtip1P;
	Thu, 16 Apr 2026 09:34:28 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Arend van Spriel
	<arend.vanspriel@broadcom.com>
Subject: [PATCH] wifi: brcmfmac: Fix potential use-after-free issue when
 stopping watchdog task
Date: Thu, 16 Apr 2026 11:33:39 +0200
Message-Id: <20260416093339.2066829-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260416093428eucas1p2fde898f84c1e15dd94d1ecb52707c72b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260416093428eucas1p2fde898f84c1e15dd94d1ecb52707c72b
X-EPHeader: CA
X-CMS-RootMailID: 20260416093428eucas1p2fde898f84c1e15dd94d1ecb52707c72b
References: <CGME20260416093428eucas1p2fde898f84c1e15dd94d1ecb52707c72b@eucas1p2.samsung.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34878-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD86640C83B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Watchdog task might end between send_sig() and kthread_stop() calls, what
results in the use-after-free issue. Fix this by increasing watchdog task
reference count before calling send_sig() and dropping it by switching to
kthread_stop_put().

Fixes: 373c83a801f1 ("brcmfmac: stop watchdog before detach and free everything")
Fixes: a9ffda88be74 ("brcm80211: fmac: abstract bus_stop interface function pointer")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This fixes the following, rarely observed issue when no firmware binary
is available:

brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfmac4330-sdio.txt failed with error -2
------------[ cut here ]------------
------------[ cut here ]------------
WARNING: kernel/fork.c:781 at __put_task_struct+0x13c/0x140, CPU#0: kworker/0:1/10
Modules linked in: brcmfmac hci_uart btbcm btintel bluetooth sha256 cfg80211 s5p_csis s5p_fimc s5p_mfc exynos4_is_common v4l2_fwnode v4l2_async ecdh_generic ecc s5p_jpeg videobuf2_dma_contig v4l2_mem2mem videobuf2_memops videobuf2_v4l2 videobuf2_common videodev brcmutil mc
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 7.0.0-rc6-next-20260402 #12549 PREEMPT 
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events request_firmware_work_func
Call trace: 
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x68/0x88
 dump_stack_lvl from __warn+0x94/0x204
 __warn from warn_slowpath_fmt+0x1b0/0x1bc
 warn_slowpath_fmt from __put_task_struct+0x13c/0x140
 __put_task_struct from rcu_core+0x330/0x1220
 rcu_core from handle_softirqs+0x130/0x5b0
 handle_softirqs from __irq_exit_rcu+0x144/0x1f0
 __irq_exit_rcu from irq_exit+0x8/0x28
 irq_exit from call_with_stack+0x18/0x20
 call_with_stack from __irq_svc+0x9c/0xd0
Exception stack(0xe0891c20 to 0xe0891c68)
...
 __irq_svc from console_flush_one_record+0x394/0x570
 console_flush_one_record from console_unlock+0x78/0x148
 console_unlock from vprintk_emit+0x224/0x390
 vprintk_emit from vprintk_default+0x20/0x28
 vprintk_default from _printk+0x2c/0x5c
 _printk from warn_slowpath_fmt+0xe8/0x1bc
 warn_slowpath_fmt from kthread_stop+0x2bc/0x364
 kthread_stop from brcmf_sdio_remove+0x2c/0x194 [brcmfmac]
 brcmf_sdio_remove [brcmfmac] from brcmf_sdiod_remove+0x20/0xb8 [brcmfmac]
 brcmf_sdiod_remove [brcmfmac] from brcmf_ops_sdio_remove+0x34/0x5c [brcmfmac]
 brcmf_ops_sdio_remove [brcmfmac] from sdio_bus_remove+0x30/0x10c
 sdio_bus_remove from device_release_driver_internal+0x190/0x204
 device_release_driver_internal from brcmf_sdio_firmware_callback+0x50/0x944 [brcmfmac]
 brcmf_sdio_firmware_callback [brcmfmac] from brcmf_fw_request_done+0x154/0x17c [brcmfmac]
 brcmf_fw_request_done [brcmfmac] from request_firmware_work_func+0x50/0x98
 request_firmware_work_func from process_one_work+0x260/0x7dc
 process_one_work from worker_thread+0x1ac/0x3b0
 worker_thread from kthread+0x128/0x168
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xe0891fb0 to 0xe0891ff8)
...
irq event stamp: 18820
hardirqs last  enabled at (18826): [<c01c7d8c>] vprintk_emit+0x364/0x390
hardirqs last disabled at (18831): [<c01c7d48>] vprintk_emit+0x320/0x390
softirqs last  enabled at (18598): [<c0add65c>] __alloc_skb+0x168/0x1c0
softirqs last disabled at (18629): [<c013e038>] __irq_exit_rcu+0x144/0x1f0
---[ end trace 0000000000000000 ]---
WARNING: lib/refcount.c:25 at kthread_stop+0x2bc/0x364, CPU#0: kworker/0:1/10
refcount_t: addition on 0; use-after-free.
Modules linked in: brcmfmac hci_uart btbcm btintel bluetooth sha256 cfg80211 s5p_csis s5p_fimc s5p_mfc exynos4_is_common v4l2_fwnode v4l2_async ecdh_generic ecc s5p_jpeg videobuf2_dma_contig v4l2_mem2mem videobuf2_memops videobuf2_v4l2 videobuf2_common videodev brcmutil mc
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G        W           7.0.0-rc6-next-20260402 #12549 PREEMPT 
Tainted: [W]=WARN
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events request_firmware_work_func
Call trace: 
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x68/0x88
 dump_stack_lvl from __warn+0x94/0x204
 __warn from warn_slowpath_fmt+0x124/0x1bc
 warn_slowpath_fmt from kthread_stop+0x2bc/0x364
 kthread_stop from brcmf_sdio_remove+0x2c/0x194 [brcmfmac]
 brcmf_sdio_remove [brcmfmac] from brcmf_sdiod_remove+0x20/0xb8 [brcmfmac]
 brcmf_sdiod_remove [brcmfmac] from brcmf_ops_sdio_remove+0x34/0x5c [brcmfmac]
 brcmf_ops_sdio_remove [brcmfmac] from sdio_bus_remove+0x30/0x10c
 sdio_bus_remove from device_release_driver_internal+0x190/0x204
 device_release_driver_internal from brcmf_sdio_firmware_callback+0x50/0x944 [brcmfmac]
 brcmf_sdio_firmware_callback [brcmfmac] from brcmf_fw_request_done+0x154/0x17c [brcmfmac]
 brcmf_fw_request_done [brcmfmac] from request_firmware_work_func+0x50/0x98
 request_firmware_work_func from process_one_work+0x260/0x7dc
 process_one_work from worker_thread+0x1ac/0x3b0
 worker_thread from kthread+0x128/0x168
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xe0891fb0 to 0xe0891ff8)
...
irq event stamp: 19327
hardirqs last  enabled at (19435): [<c01c3810>] __up_console_sem+0x50/0x60
hardirqs last disabled at (19460): [<c01c37fc>] __up_console_sem+0x3c/0x60
softirqs last  enabled at (19458): [<c013dc0c>] handle_softirqs+0x330/0x5b0
softirqs last disabled at (19443): [<c013e038>] __irq_exit_rcu+0x144/0x1f0
---[ end trace 0000000000000000 ]---

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index d34db69c25a7..e6de88a6a852 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -2477,8 +2477,9 @@ static void brcmf_sdio_bus_stop(struct device *dev)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	if (bus->watchdog_tsk) {
+		get_task_struct(bus->watchdog_tsk);
 		send_sig(SIGTERM, bus->watchdog_tsk, 1);
-		kthread_stop(bus->watchdog_tsk);
+		kthread_stop_put(bus->watchdog_tsk);
 		bus->watchdog_tsk = NULL;
 	}
 
@@ -4568,8 +4569,9 @@ void brcmf_sdio_remove(struct brcmf_sdio *bus)
 	if (bus) {
 		/* Stop watchdog task */
 		if (bus->watchdog_tsk) {
+			get_task_struct(bus->watchdog_tsk);
 			send_sig(SIGTERM, bus->watchdog_tsk, 1);
-			kthread_stop(bus->watchdog_tsk);
+			kthread_stop_put(bus->watchdog_tsk);
 			bus->watchdog_tsk = NULL;
 		}
 
-- 
2.34.1


