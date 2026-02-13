Return-Path: <linux-wireless+bounces-31793-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id U7UOGTS4jmmFEAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31793-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:35:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6AD13306E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 482A230160CA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 05:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49B02E645;
	Fri, 13 Feb 2026 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Itqr4O5F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA8242D70
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 05:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770960945; cv=none; b=QWMDtfpBcI8J7hTpcQTQyGnUhsb6I4iQzEQpa4O/WiBwtktwe9n+6pDgBiYRer4dMix/r8E97Ok/HpIZHhLY7hwaRtUwye2RsGjQ7mA9ZugFVFhEz1h0flyl0OpEbPB/j+1WKoWTedvW/uUgNt22Kqm+FSdDuG+javVKP0mHi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770960945; c=relaxed/simple;
	bh=1YvvyZaQkKEh5AqEGjnsAYFk2ROew8GgisKF1jKonC8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G/bz7VJz+SzDuz+bF7zulGNyF2AMdJRDcinsKKeKeMUuaPktTETEd7vIv8YUNeDzAL4Kq4Y44IaN4d9snAXPys5VdFGbHZUHD9Suj1EnOdW8hPdcnvEWraWvdvf/pwJD6u+Utmo4Vi+IThSaT/6T6L6o6fGgbG6tZlCdhw8+msM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Itqr4O5F; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D5Zd2321362639, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770960939; bh=cCoh7Bn8YS/TTsjsEd4rC7sQYwvnIcrhQflE8wQjffw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Itqr4O5FJn/QUfQMedO2hcNLr1PzEcuLSk7pT7eeG43nN5ewE728/25ShcG63WEjk
	 TTWl6HGg+l1c7t0Q/3PHQLfMvOKQnpZOdi76PxlYF/+ezVLeKUuU50zjEI6jgSaRNp
	 HDvKKQYEwQIeMN1uPcPqhhPpIjv5m4D5xCG90J7gnHHeoowhcunVWlL73YQO2pKMaW
	 DX1aTdWRTrg0UOMgcM2ImiTs7sIvQKXoaZgzQ+1k+iNgzWdIrRkBWbc3OXesHIDLnY
	 NMePC8u1lLie+9mFKx211LpC0/5eIAdafKponOQOgOe8h1/YLQ5zquNR//neunIG9C
	 Qffag5oAskBTQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D5Zd2321362639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 13:35:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 13:35:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 13:35:39 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 13:35:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next] wifi: rtw88: coex: Solve LE-HID lag & update coex version to 26020420
Date: Fri, 13 Feb 2026 13:34:45 +0800
Message-ID: <20260213053445.19384-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31793-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,realtek.com:email];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AF6AD13306E
X-Rspamd-Action: no action

From: Ching-Te Ku <ku920601@realtek.com>

When Wi-Fi enters power save, the register value can not be read
correctly. If mechanism take the wrong information to make decision,
it will run with wrong parameters. It leads Bluetooth low-energy
HID lag. Add logic to isolate the wrong register state.

BTCOEX Version: 26020420-2020
Desired_BT_Coex_Ver: 0x20
Desired_WL_FW_Ver: 9.9.X

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c     | 44 ++++++++++++-------
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  5 +++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  5 +++
 drivers/net/wireless/realtek/rtw88/rtw8821a.c |  7 ++-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  7 ++-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  5 +++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  5 ++-
 8 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index b4dc6ff2c175..ee4007fe6c18 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -485,6 +485,13 @@ static void rtw_coex_monitor_bt_ctr(struct rtw_dev *rtwdev)
 		"[BTCoex], Hi-Pri Rx/Tx: %d/%d, Lo-Pri Rx/Tx: %d/%d\n",
 		coex_stat->hi_pri_rx, coex_stat->hi_pri_tx,
 		coex_stat->lo_pri_rx, coex_stat->lo_pri_tx);
+
+	if (coex_stat->wl_under_lps || coex_stat->wl_under_ips ||
+	    (coex_stat->hi_pri_rx > 60000 && coex_stat->hi_pri_tx == 60000 &&
+	     coex_stat->lo_pri_rx > 60000 && coex_stat->lo_pri_tx == 60000))
+		coex_stat->bt_ctr_ok = false;
+	else
+		coex_stat->bt_ctr_ok = true;
 }
 
 static void rtw_coex_monitor_bt_enable(struct rtw_dev *rtwdev)
@@ -1959,14 +1966,18 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	bool is_bt_ctr_hi = false, is_toggle_table = false;
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
-	bool bt_multi_link_remain = false, is_toggle_table = false;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
+	if (coex_stat->bt_ctr_ok &&
+	    coex_stat->lo_pri_rx + coex_stat->lo_pri_tx > 360)
+		is_bt_ctr_hi = true;
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		if (coex_stat->bt_ble_exist) {
@@ -1980,28 +1991,31 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 			}
 		} else {
 			/* Legacy HID  */
-			if (coex_stat->bt_profile_num == 1 &&
-			    (coex_stat->bt_multi_link ||
-			    (coex_stat->lo_pri_rx +
-			     coex_stat->lo_pri_tx > 360) ||
-			     coex_stat->bt_slave ||
-			     bt_multi_link_remain)) {
-				slot_type = TDMA_4SLOT;
-				table_case = 12;
-				tdma_case = 20;
-			} else if (coex_stat->bt_a2dp_active) {
+			if (coex_stat->bt_a2dp_active) {
 				table_case = 9;
 				tdma_case = 18;
+			} else if (coex_stat->bt_profile_num == 1 &&
+				   (coex_stat->bt_multi_link &&
+				    (is_bt_ctr_hi || coex_stat->bt_slave ||
+				     coex_stat->bt_multi_link_remain))) {
+				if (coex_stat->wl_gl_busy &&
+				    (coex_stat->wl_rx_rate <= 3 ||
+				     coex_stat->wl_rts_rx_rate <= 3))
+					table_case = 13;
+				else
+					table_case = 12;
+
+				tdma_case = 26;
 			} else if (coex_stat->bt_418_hid_exist &&
 				   coex_stat->wl_gl_busy) {
 				is_toggle_table = true;
 				slot_type = TDMA_4SLOT;
-				table_case = 9;
-				tdma_case = 24;
+				table_case = 32;
+				tdma_case = 27;
 			} else if (coex_stat->bt_ble_hid_exist &&
 				   coex_stat->wl_gl_busy) {
-				table_case = 32;
-				tdma_case = 9;
+				table_case = 36;
+				tdma_case = 0;
 			} else {
 				table_case = 9;
 				tdma_case = 9;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 1ab70214ce36..1179231a672d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1475,6 +1475,7 @@ struct rtw_coex_stat {
 	bool bt_game_hid_exist;
 	bool bt_hid_handle_cnt;
 	bool bt_mailbox_reply;
+	bool bt_ctr_ok;
 
 	bool wl_under_lps;
 	bool wl_under_ips;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 821c28d9cb5d..b5e7ae7ebd95 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -1794,6 +1794,11 @@ static const struct coex_table_para table_sant_8703b[] = {
 	{0x66556aaa, 0x6a5a6aaa}, /* case-30 */
 	{0xffffffff, 0x5aaa5aaa},
 	{0x56555555, 0x5a5a5aaa},
+	{0xdaffdaff, 0xdaffdaff},
+	{0xddffddff, 0xddffddff},
+	{0xe5555555, 0xe5555555}, /* case-35 */
+	{0xea5a5a5a, 0xea5a5a5a},
+	{0xea6a6a6a, 0xea6a6a6a},
 };
 
 /* Shared-Antenna TDMA */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 8715e0435f17..a2b3e7a2ad99 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1459,6 +1459,11 @@ static const struct coex_table_para table_sant_8723d[] = {
 	{0x66556aaa, 0x6a5a6aaa}, /* case-30 */
 	{0xffffffff, 0x5aaa5aaa},
 	{0x56555555, 0x5a5a5aaa},
+	{0xdaffdaff, 0xdaffdaff},
+	{0xddffddff, 0xddffddff},
+	{0xe5555555, 0xe5555555}, /* case-35 */
+	{0xea5a5a5a, 0xea5a5a5a},
+	{0xea6a6a6a, 0xea6a6a6a},
 };
 
 /* Non-Shared-Antenna Coex Table */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
index 414b77eef07c..cab85203b828 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
@@ -998,7 +998,12 @@ static const struct coex_table_para table_sant_8821a[] = {
 	{0x66556655, 0x66556655},
 	{0x66556aaa, 0x6a5a6aaa}, /* case-30 */
 	{0xffffffff, 0x5aaa5aaa},
-	{0x56555555, 0x5a5a5aaa}
+	{0x56555555, 0x5a5a5aaa},
+	{0xdaffdaff, 0xdaffdaff},
+	{0xddffddff, 0xddffddff},
+	{0xe5555555, 0xe5555555}, /* case-35 */
+	{0xea5a5a5a, 0xea5a5a5a},
+	{0xea6a6a6a, 0xea6a6a6a},
 };
 
 /* Non-Shared-Antenna Coex Table */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 2078b067562e..246046da4f13 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1727,7 +1727,12 @@ static const struct coex_table_para table_sant_8821c[] = {
 	{0x66556655, 0x66556655},
 	{0x66556aaa, 0x6a5a6aaa}, /* case-30 */
 	{0xffffffff, 0x5aaa5aaa},
-	{0x56555555, 0x5a5a5aaa}
+	{0x56555555, 0x5a5a5aaa},
+	{0xdaffdaff, 0xdaffdaff},
+	{0xddffddff, 0xddffddff},
+	{0xe5555555, 0xe5555555}, /* case-35 */
+	{0xea5a5a5a, 0xea5a5a5a},
+	{0xea6a6a6a, 0xea6a6a6a},
 };
 
 /* Non-Shared-Antenna Coex Table */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 4d88cc2f4148..e9e8a7f3f382 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2217,6 +2217,11 @@ static const struct coex_table_para table_sant_8822b[] = {
 	{0x66556aaa, 0x6a5a6aaa}, /* case-30 */
 	{0xffffffff, 0x5aaa5aaa},
 	{0x56555555, 0x5a5a5aaa},
+	{0xdaffdaff, 0xdaffdaff},
+	{0xddffddff, 0xddffddff},
+	{0xe5555555, 0xe5555555}, /* case-35 */
+	{0xea5a5a5a, 0xea5a5a5a},
+	{0xea6a6a6a, 0xea6a6a6a},
 };
 
 /* Non-Shared-Antenna Coex Table */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 28c121cf1e68..244c8026479c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5035,6 +5035,9 @@ static const struct coex_table_para table_sant_8822c[] = {
 	{0x56555555, 0x5a5a5aaa},
 	{0xdaffdaff, 0xdaffdaff},
 	{0xddffddff, 0xddffddff},
+	{0xe5555555, 0xe5555555}, /* case-35 */
+	{0xea5a5a5a, 0xea5a5a5a},
+	{0xea6a6a6a, 0xea6a6a6a},
 };
 
 /* Non-Shared-Antenna Coex Table */
@@ -5401,7 +5404,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.max_sched_scan_ssids = 4,
 #endif
 	.max_scan_ie_len = (RTW_PROBE_PG_CNT - 1) * TX_PAGE_SIZE,
-	.coex_para_ver = 0x22020720,
+	.coex_para_ver = 0x26020420,
 	.bt_desired_ver = 0x20,
 	.scbd_support = true,
 	.new_scbd10_def = true,

base-commit: 333225e1e9ead7b06e5363389403bdac72ba3046
-- 
2.25.1


