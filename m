Return-Path: <linux-wireless+bounces-4951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42465880C68
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 08:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724BC1C21FC4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 07:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B6D22313;
	Wed, 20 Mar 2024 07:52:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E923770
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921129; cv=none; b=Glc2f8Mgreoa57JRUTO089/cPk7B37RbcpPJLRbke0d/yGaw+mzKOn4Q5eyTfcZd+yqs3vxJXBTpiCajxrqCVmWI3KvS7ZS5k1Vr6o4Mbch64DPXFF8Cq0EaNLEzA3QLZlpDStEFG5xixoQRP8V7SQKrUUHge033WuQH2pLo6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921129; c=relaxed/simple;
	bh=sBBSqb2PjgpeGizeasqOVHTAH58NbR6m5Dm5UWkN5GY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kGMe/PkJhQLA7PZ2IhYhJNde60AUVZASuSG/E683muCjiJtr1FoJi2WoOBOYjrKGUZVi0MM+3OJGq9oaQHBUKAjx/QS2NLZf3j+fxD30AyXYUfvQ7vfqZPDtXXcqv5QE653Z6xWYpMo6LNHO9dKBj697RTxHXwqaKmAOjEHAvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42K7pqCV3340019, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42K7pqCV3340019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 15:51:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 15:51:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Mar
 2024 15:51:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw88: coex: Prevent doing I/O during Wi-Fi power saving
Date: Wed, 20 Mar 2024 15:50:47 +0800
Message-ID: <20240320075047.31810-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

Fix Wi-Fi 2.4Ghz throughput drop over than 40% when Bluetooh is idle.
The code flow will read registers during Wi-Fi power saving, and be
returned, which results in incorrect counters to do mechanism judgment.
Adjust the code flow. Will leave Wi-Fi power save mode first then update
counters.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 4 +++-
 drivers/net/wireless/realtek/rtw88/main.c | 5 ++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 86467d2f8888..de3332eb7a22 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -3937,7 +3937,9 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 	lte_coex = rtw_coex_read_indirect_reg(rtwdev, 0x38);
 	bt_coex = rtw_coex_read_indirect_reg(rtwdev, 0x54);
 
-	if (!coex_stat->bt_disabled && !coex_stat->bt_mailbox_reply) {
+	if (!coex_stat->wl_under_ips &&
+	    (!coex_stat->wl_under_lps || coex_stat->wl_force_lps_ctrl) &&
+	    !coex_stat->bt_disabled && !coex_stat->bt_mailbox_reply) {
 		rtw_coex_get_bt_supported_version(rtwdev,
 				&coex_stat->bt_supported_version);
 		rtw_coex_get_bt_patch_version(rtwdev, &coex_stat->patch_ver);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index ffba6b88f392..81ef4717dbf4 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -227,9 +227,6 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	else
 		clear_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
 
-	rtw_coex_wl_status_check(rtwdev);
-	rtw_coex_query_bt_hid_list(rtwdev);
-
 	if (busy_traffic != test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags))
 		rtw_coex_wl_status_change_notify(rtwdev, 0);
 
@@ -257,6 +254,8 @@ static void rtw_watch_dog_work(struct work_struct *work)
 
 	/* make sure BB/RF is working for dynamic mech */
 	rtw_leave_lps(rtwdev);
+	rtw_coex_wl_status_check(rtwdev);
+	rtw_coex_query_bt_hid_list(rtwdev);
 
 	rtw_phy_dynamic_mechanism(rtwdev);
 
-- 
2.25.1


