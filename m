Return-Path: <linux-wireless+bounces-17143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F5EA03E0D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DEF3A3573
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F18D1E2031;
	Tue,  7 Jan 2025 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cgmX+h/T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C921DED74
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250191; cv=none; b=d8nh2IGVW1/42hZkyMnAkT0UjQp37a/ypbCeMeaxclO5cqMW4QUH1Oqn752lyRtrKBkJ7Y5Muk8Zj/RASlinkxB5nC1JvF33ciOzQz9S8YDdNtYiNgIGlkUMh1oOuMvUd/l7jOtMYOGfHYwFbuhkA+BTfG9CyGIvkWw+9c1XdYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250191; c=relaxed/simple;
	bh=jZApWX6jyHNYcw31kXMZqlS1LNFaLCHTbWsQKQuu+rg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gm/HrwI3PPaCsvN1p4OSfB/VgXNsA1DEB7/8gfcSCzhDdEPjx+HPikA+ZmBw+qm25piwgc0gNok1anjqkVmKM65invtZyDoknV9t/iD8JweEUqpAiTn9BDEBrAnU1W/znKX7zjiz0FmmguwdXOwZnCDcdGbTmo9zK9ejJgXsO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cgmX+h/T; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 507BgxslF3812876, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736250179; bh=jZApWX6jyHNYcw31kXMZqlS1LNFaLCHTbWsQKQuu+rg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=cgmX+h/TWMy/5QK2myk9+t5ciryMpANZUPxKjkSwuQsz1TlIA+Metq6XMAlaWcHt9
	 d73kRtec0JENbTQ6DbtYiAhoUIHF4KjRMFETZuh6apGRekkoXa67IghDPAV8hkXeR8
	 KADw0/MScTWDo6FaC+FBkIxLuX/6YcmKxBQne3YLyxRhODQo0USU/ExKTAvPIcSWsm
	 toP/UoDjrA4A+IVVZgwRRZQ5HyiYqKnr6XG+rdOEdfJyEXfYm7vKC9Jg1M25IJUOKV
	 Po7evm2RHiqxmO2lwbjZBn8XdxQeM6UHR/SYELoQVqAwAt8OUEqzpvu7oJkhQFTZko
	 KFmT46WLqmSDw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 507BgxslF3812876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jan 2025 19:42:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 7 Jan 2025 19:42:59 +0800
Received: from [127.0.1.1] (172.16.17.164) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 7 Jan
 2025 19:42:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: fix race between cancel_hw_scan and hw_scan completion
Date: Tue, 7 Jan 2025 19:42:54 +0800
Message-ID: <20250107114254.6769-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The rtwdev->scanning flag isn't protected by mutex originally, so
cancel_hw_scan can pass the condition, but suddenly hw_scan completion
unset the flag and calls ieee80211_scan_completed() that will free
local->hw_scan_req. Then, cancel_hw_scan raises null-ptr-deref and
use-after-free. Fix it by moving the check condition to where
protected by mutex.

 KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
 CPU: 2 PID: 6922 Comm: kworker/2:2 Tainted: G           OE
 Hardware name: LENOVO 2356AD1/2356AD1, BIOS G7ETB6WW (2.76 ) 09/10/2019
 Workqueue: events cfg80211_conn_work [cfg80211]
 RIP: 0010:rtw89_fw_h2c_scan_offload_be+0xc33/0x13c3 [rtw89_core]
 Code: 00 45 89 6c 24 1c 0f 85 23 01 00 00 48 8b 85 20 ff ff ff 48 8d
 RSP: 0018:ffff88811fd9f068 EFLAGS: 00010206
 RAX: dffffc0000000000 RBX: ffff88811fd9f258 RCX: 0000000000000001
 RDX: 0000000000000011 RSI: 0000000000000001 RDI: 0000000000000089
 RBP: ffff88811fd9f170 R08: 0000000000000000 R09: 0000000000000000
 R10: ffff88811fd9f108 R11: 0000000000000000 R12: ffff88810e47f960
 R13: 0000000000000000 R14: 000000000000ffff R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff8881d6f00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007531dfca55b0 CR3: 00000001be296004 CR4: 00000000001706e0
 Call Trace:
  <TASK>
  ? show_regs+0x61/0x73
  ? __die_body+0x20/0x73
  ? die_addr+0x4f/0x7b
  ? exc_general_protection+0x191/0x1db
  ? asm_exc_general_protection+0x27/0x30
  ? rtw89_fw_h2c_scan_offload_be+0xc33/0x13c3 [rtw89_core]
  ? rtw89_fw_h2c_scan_offload_be+0x458/0x13c3 [rtw89_core]
  ? __pfx_rtw89_fw_h2c_scan_offload_be+0x10/0x10 [rtw89_core]
  ? do_raw_spin_lock+0x75/0xdb
  ? __pfx_do_raw_spin_lock+0x10/0x10
  rtw89_hw_scan_offload+0xb5e/0xbf7 [rtw89_core]
  ? _raw_spin_unlock+0xe/0x24
  ? __mutex_lock.constprop.0+0x40c/0x471
  ? __pfx_rtw89_hw_scan_offload+0x10/0x10 [rtw89_core]
  ? __mutex_lock_slowpath+0x13/0x1f
  ? mutex_lock+0xa2/0xdc
  ? __pfx_mutex_lock+0x10/0x10
  rtw89_hw_scan_abort+0x58/0xb7 [rtw89_core]
  rtw89_ops_cancel_hw_scan+0x120/0x13b [rtw89_core]
  ieee80211_scan_cancel+0x468/0x4d0 [mac80211]
  ieee80211_prep_connection+0x858/0x899 [mac80211]
  ieee80211_mgd_auth+0xbea/0xdde [mac80211]
  ? __pfx_ieee80211_mgd_auth+0x10/0x10 [mac80211]
  ? cfg80211_find_elem+0x15/0x29 [cfg80211]
  ? is_bss+0x1b7/0x1d7 [cfg80211]
  ieee80211_auth+0x18/0x27 [mac80211]
  cfg80211_mlme_auth+0x3bb/0x3e7 [cfg80211]
  cfg80211_conn_do_work+0x410/0xb81 [cfg80211]
  ? __pfx_cfg80211_conn_do_work+0x10/0x10 [cfg80211]
  ? __kasan_check_read+0x11/0x1f
  ? psi_group_change+0x8bc/0x944
  ? __kasan_check_write+0x14/0x22
  ? mutex_lock+0x8e/0xdc
  ? __pfx_mutex_lock+0x10/0x10
  ? __pfx___radix_tree_lookup+0x10/0x10
  cfg80211_conn_work+0x245/0x34d [cfg80211]
  ? __pfx_cfg80211_conn_work+0x10/0x10 [cfg80211]
  ? update_cfs_rq_load_avg+0x3bc/0x3d7
  ? sched_clock_noinstr+0x9/0x1a
  ? sched_clock+0x10/0x24
  ? sched_clock_cpu+0x7e/0x42e
  ? newidle_balance+0x796/0x937
  ? __pfx_sched_clock_cpu+0x10/0x10
  ? __pfx_newidle_balance+0x10/0x10
  ? __kasan_check_read+0x11/0x1f
  ? psi_group_change+0x8bc/0x944
  ? _raw_spin_unlock+0xe/0x24
  ? raw_spin_rq_unlock+0x47/0x54
  ? raw_spin_rq_unlock_irq+0x9/0x1f
  ? finish_task_switch.isra.0+0x347/0x586
  ? __schedule+0x27bf/0x2892
  ? mutex_unlock+0x80/0xd0
  ? do_raw_spin_lock+0x75/0xdb
  ? __pfx___schedule+0x10/0x10
  process_scheduled_works+0x58c/0x821
  worker_thread+0x4c7/0x586
  ? __kasan_check_read+0x11/0x1f
  kthread+0x285/0x294
  ? __pfx_worker_thread+0x10/0x10
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x29/0x6f
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
  </TASK>

Fixes: 895907779752 ("rtw89: 8852a: add ieee80211_ops::hw_scan")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 5eac0b524060..5f79dd4afbbd 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1285,11 +1285,11 @@ static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return;
 
-	if (!rtwdev->scanning)
-		return;
-
 	mutex_lock(&rtwdev->mutex);
 
+	if (!rtwdev->scanning)
+		goto out;
+
 	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
 	if (unlikely(!rtwvif_link)) {
 		rtw89_err(rtwdev, "cancel hw scan: find no link on HW-0\n");
-- 
2.25.1


