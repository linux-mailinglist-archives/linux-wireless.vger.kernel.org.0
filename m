Return-Path: <linux-wireless+bounces-16925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FC59FEBF5
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 01:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF69161F5C
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 00:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D85E195;
	Tue, 31 Dec 2024 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="m2zDKgIc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DBA33F3
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735606138; cv=none; b=kTQomg3qqVyjENZKTKkrsDJW5aCwLn5J49H+N2mdFOFiUsbGkCBdYPJD4tpxlXsNEy6Lf35wl7uKDnNwBxxjfuxzMvnpO22piYfjpDMN6aa0SqYmW1pee3by7j3RRSHma4jCmBoihSg2bu/94QHxm8+0MVaIOiyGuO2ZV2rk8DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735606138; c=relaxed/simple;
	bh=yudp7zMINiT9T/WHtHXR/O/9TovwcC4BmMcsCPsIIDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okVnhqZ3ZecLaURGhFT+w31w3Lu+BeBxiCUspMIIa7yKG2jeOnkHrLsGkFK1DO9eGc9GKN1U/JGQ0TI7IyBtmC3eZ1kkFI6/D/Z4NdxPkT7dhkji8cw0RJgwAdaxGV7uqNQTcvGY+N4R9iaTjI66CO/oIghYtRUcR1kdeGhHTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=m2zDKgIc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BV0mq3sB791445, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735606132; bh=yudp7zMINiT9T/WHtHXR/O/9TovwcC4BmMcsCPsIIDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=m2zDKgIcBcGWVDCBWtBj/1/jHol5XocbNitsyOHQC34Z5sipO0w0rIaJyXBIcxlSd
	 OxVl4+Zj8qBEmK2nRouEjtOvdI1tvduzUhxYm0bpVzR7ZCv1Z0TqN5aMe5gikHyoJY
	 HgJ+v4sJgnFnoVykEKA4JwW6R0TvhDJJ2zABYrYasZ2TJZQOMsZXv+7XgB29axBD3r
	 STOtedalJSKXb7Rc3HnCZD4SkapivxDDFQv9RnMCOP8aId9Ywq9cPXV/x6EoRhMkqk
	 aG9kZSSQJRMMIpycTX8teP+1zOWF9n2VRWS01HSsGw7WtowSNbHLE+AevT582cyvG5
	 7hTHNChll1oIA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BV0mq3sB791445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 08:48:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 31 Dec 2024 08:48:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 31 Dec
 2024 08:48:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 1/3] wifi: rtw89: fix proceeding MCC with wrong scanning state after sequence changes
Date: Tue, 31 Dec 2024 08:48:08 +0800
Message-ID: <20241231004811.8646-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241231004811.8646-1-pkshih@realtek.com>
References: <20241231004811.8646-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

When starting/proceeding MCC, it will abort an ongoing hw scan process.
In the proceeding cases, it unexpectedly tries to abort a non-exist hw
scan process. Then, a trace shown at the bottom will happen. This problem
is caused by a previous commit which changed some call sequence inside
rtw89_hw_scan_complete() to fix some coex problems. These changes lead
to our scanning flag was not cleared when proceeding MCC. To keep the
fixes on coex, and resolve the problem here, re-consider the related
call sequence.

The known sequence requirements are listed below.

* the old sequence:
	A. notify coex
	B. clear scanning flag
	C. proceed chanctx
		C-1. set channel
		C-2. proceed MCC
(the problem: A needs to be after C-1)

* the current sequence:
	C. proceed chanctx
		C-1. set channel
		C-2. proceed MCC
	A. notify coex
	B. clear scanning flag
(the problem: C-2 needs to be after B)

So, now let hw scan caller pass a callback to proceed chanctx if needed.
Then, the new sequence will be like the below.
	C-1. set channel
	A. notify coex
	B. clear scanning flag
	C-2. proceed MCC

The following is the kernel log for the problem in current sequence.

rtw89_8852be 0000:04:00.0: rtw89_hw_scan_offload failed ret -110
------------[ cut here ]------------
[...]
CPU: 2 PID: 3991 Comm: kworker/u16:0 Tainted: G           OE      6.6.17 #3
Hardware name: LENOVO 2356AD1/2356AD1, BIOS G7ETB3WW (2.73 ) 11/28/2018
Workqueue: events_unbound wiphy_work_cancel [cfg80211]
RIP: 0010:ieee80211_sched_scan_stopped+0xaea/0xd80 [mac80211]
Code: 9c 24 d0 11 00 00 49 39 dd 0f 85 46 ff ff ff 4c 89 e7 e8 09 2d
RSP: 0018:ffffb27783643d48 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8a2280964bc0 RSI: 0000000000000000 RDI: ffff8a23df580900
RBP: ffffb27783643d88 R08: 0000000000000001 R09: 0000000000000400
R10: 0000000000000000 R11: 0000000000008268 R12: ffff8a23df580900
R13: ffff8a23df581b00 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8a258e680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f26a0654000 CR3: 000000002ea2e002 CR4: 00000000001706e0
Call Trace:
 <TASK>
 ? show_regs+0x68/0x70
 ? ieee80211_sched_scan_stopped+0xaea/0xd80 [mac80211]
 ? __warn+0x8f/0x150
 ? ieee80211_sched_scan_stopped+0xaea/0xd80 [mac80211]
 ? report_bug+0x1f5/0x200
 ? handle_bug+0x46/0x80
 ? exc_invalid_op+0x19/0x70
 ? asm_exc_invalid_op+0x1b/0x20
 ? ieee80211_sched_scan_stopped+0xaea/0xd80 [mac80211]
 ieee80211_scan_work+0x14a/0x650 [mac80211]
 ? __queue_work+0x10f/0x410
 wiphy_work_cancel+0x2fb/0x310 [cfg80211]
 process_scheduled_works+0x9d/0x390
 ? __pfx_worker_thread+0x10/0x10
 worker_thread+0x15b/0x2d0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x108/0x140
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
---[ end trace 0000000000000000 ]---

Fixes: f16c40acd319 ("wifi: rtw89: Fix TX fail with A2DP after scanning")
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 26 +++++++++++++--
 drivers/net/wireless/realtek/rtw89/chan.h |  9 ++++-
 drivers/net/wireless/realtek/rtw89/core.c |  2 +-
 drivers/net/wireless/realtek/rtw89/fw.c   | 40 +++++++++++++++++++----
 4 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index fb9449930c40..abc78716596d 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2530,7 +2530,25 @@ void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
 	hal->entity_pause = true;
 }
 
-void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev)
+static void rtw89_chanctx_proceed_cb(struct rtw89_dev *rtwdev,
+				     const struct rtw89_chanctx_cb_parm *parm)
+{
+	int ret;
+
+	if (!parm || !parm->cb)
+		return;
+
+	ret = parm->cb(rtwdev, parm->data);
+	if (ret)
+		rtw89_warn(rtwdev, "%s (%s): cb failed: %d\n", __func__,
+			   parm->caller ?: "unknown", ret);
+}
+
+/* pass @cb_parm if there is a @cb_parm->cb which needs to invoke right after
+ * call rtw89_set_channel() and right before proceed entity according to mode.
+ */
+void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev,
+			   const struct rtw89_chanctx_cb_parm *cb_parm)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	enum rtw89_entity_mode mode;
@@ -2538,14 +2556,18 @@ void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev)
 
 	lockdep_assert_held(&rtwdev->mutex);
 
-	if (!hal->entity_pause)
+	if (unlikely(!hal->entity_pause)) {
+		rtw89_chanctx_proceed_cb(rtwdev, cb_parm);
 		return;
+	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "chanctx proceed\n");
 
 	hal->entity_pause = false;
 	rtw89_set_channel(rtwdev);
 
+	rtw89_chanctx_proceed_cb(rtwdev, cb_parm);
+
 	mode = rtw89_get_entity_mode(rtwdev);
 	switch (mode) {
 	case RTW89_ENTITY_MODE_MCC:
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 2eb31dff2083..092a6f676894 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -38,6 +38,12 @@ enum rtw89_chanctx_pause_reasons {
 	RTW89_CHANCTX_PAUSE_REASON_ROC,
 };
 
+struct rtw89_chanctx_cb_parm {
+	int (*cb)(struct rtw89_dev *rtwdev, void *data);
+	void *data;
+	const char *caller;
+};
+
 struct rtw89_entity_weight {
 	unsigned int active_chanctxs;
 	unsigned int active_roles;
@@ -100,7 +106,8 @@ void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
 void rtw89_chanctx_track(struct rtw89_dev *rtwdev);
 void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
 			 enum rtw89_chanctx_pause_reasons rsn);
-void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev);
+void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev,
+			   const struct rtw89_chanctx_cb_parm *cb_parm);
 
 const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 					       const char *caller_message,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index f848185e2ced..bb4621d38658 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3357,7 +3357,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 	roc->state = RTW89_ROC_IDLE;
 	rtw89_config_roc_chandef(rtwdev, rtwvif_link->chanctx_idx, NULL);
-	rtw89_chanctx_proceed(rtwdev);
+	rtw89_chanctx_proceed(rtwdev, NULL);
 	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, true, false);
 	if (ret)
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 90db15685728..6c105e4b1cb3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6919,22 +6919,25 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_HW_SCAN);
 }
 
-void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev,
-			    struct rtw89_vif_link *rtwvif_link,
-			    bool aborted)
+struct rtw89_hw_scan_complete_cb_data {
+	struct rtw89_vif_link *rtwvif_link;
+	bool aborted;
+};
+
+static int rtw89_hw_scan_complete_cb(struct rtw89_dev *rtwdev, void *data)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_hw_scan_complete_cb_data *cb_data = data;
+	struct rtw89_vif_link *rtwvif_link = cb_data->rtwvif_link;
 	struct cfg80211_scan_info info = {
-		.aborted = aborted,
+		.aborted = cb_data->aborted,
 	};
 	struct rtw89_vif *rtwvif;
 	u32 reg;
 
 	if (!rtwvif_link)
-		return;
-
-	rtw89_chanctx_proceed(rtwdev);
+		return -EINVAL;
 
 	rtwvif = rtwvif_link->rtwvif;
 
@@ -6953,6 +6956,29 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev,
 	scan_info->last_chan_idx = 0;
 	scan_info->scanning_vif = NULL;
 	scan_info->abort = false;
+
+	return 0;
+}
+
+void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev,
+			    struct rtw89_vif_link *rtwvif_link,
+			    bool aborted)
+{
+	struct rtw89_hw_scan_complete_cb_data cb_data = {
+		.rtwvif_link = rtwvif_link,
+		.aborted = aborted,
+	};
+	const struct rtw89_chanctx_cb_parm cb_parm = {
+		.cb = rtw89_hw_scan_complete_cb,
+		.data = &cb_data,
+		.caller = __func__,
+	};
+
+	/* The things here needs to be done after setting channel (for coex)
+	 * and before proceeding entity mode (for MCC). So, pass a callback
+	 * of them for the right sequence rather than doing them directly.
+	 */
+	rtw89_chanctx_proceed(rtwdev, &cb_parm);
 }
 
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev,
-- 
2.25.1


