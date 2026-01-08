Return-Path: <linux-wireless+bounces-30549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE195D03C56
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D611304A320
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE8D497B16;
	Thu,  8 Jan 2026 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WfFBCoki"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD3483806
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873832; cv=none; b=dxAUdI/wtc0Jx9il55Fnu12tRzxYdLhSgO5w1mzRj4a0qnUi9aeTjipcIw3RmvfSBlT4rsxwz6+wEqt4eCL5qxCb4WEOGipiIsb2fmxLAhHRiPYtwqgrJ19MphNJe0+Gr8dQ/QAsRXRB6ot+G3H0n0qnN9R434tEOBaMOOWHcts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873832; c=relaxed/simple;
	bh=zkEnhhDU0+hqw41yHJhdIYgUVrbqahtY7JRb+YpyLC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYxrt6nXSHUCDGsEVV+M17PLls1UOlwvy8n7q+fmaMWoOOGY08Q4fW1WoKwC9Z+AOjol7BUX3jKv17oOPDpt3cPJayMQQwwVBJBSE3rotlMnRhY/0GOnr0QmBFM17BfNArnpcDqWip2NKyeZDhyyAmcNjixnceDKBfnnyWvUnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WfFBCoki; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C3kPA2970629, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873826; bh=/BeyiwHr6zAuCKQUPftuAPH0ZkiThuZTt6DQuY6stD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WfFBCoki5jt8p+oq06KqHNw+Ks5cOV7TayHz/oHAsE6olLszqi/2y51qM5wclIbWB
	 Wtp+yE+LbFWifaUYwqE6TnZJSk+Z/ePd8L8ljYGgaQzerjczcYzCqHKrW6GcYo5imt
	 HhaAvoZyrTYUqA6a6YIhvi6dkPittKt8/bZg9HuNa7PO1qGlOs0z1boEYaUHaI6Y6P
	 B0bXm5WZe4a40hNRaWm0QEiPVDjy09bytfxVC3gPb8RAIT6ekSUe4PMYvcC9eSoCB9
	 5rmfKEFxshf4Xd+34daAnqyTgAgTVtXAfKHU/7QwVRR3Hojw5ynGPnncVuitwOqMb4
	 IUj7efvbhk4PA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C3kPA2970629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:03:46 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:46 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:46 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:03:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 05/13] wifi: rtw89: mac: add dle_mem and ple_{min,max}_qt quota for RTL8922D
Date: Thu, 8 Jan 2026 20:03:12 +0800
Message-ID: <20260108120320.2217402-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108120320.2217402-1-pkshih@realtek.com>
References: <20260108120320.2217402-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The quota of DLE and PLE depends on hardware design and consideration of
performance and application. Define them accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 20 ++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac.c  | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 15 +++++++++++++++
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 84b6549d411c..054abb1ea05a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4002,13 +4002,14 @@ struct rtw89_dle_size {
 	u16 pge_size;
 	u16 lnk_pge_num;
 	u16 unlnk_pge_num;
-	/* for WiFi 7 chips below */
+	/* for WiFi 7 chips below (suffix v1) */
 	u32 srt_ofst;
 };
 
 struct rtw89_wde_quota {
 	u16 hif;
 	u16 wcpu;
+	/* unused dcpu isn't listed */
 	u16 pkt_in;
 	u16 cpu_io;
 };
@@ -4026,8 +4027,10 @@ struct rtw89_ple_quota {
 	u16 wd_rel;
 	u16 cpu_io;
 	u16 tx_rpt;
-	/* for WiFi 7 chips below */
+	/* for WiFi 7 chips below (suffix v1) */
 	u16 h2d;
+	/* for WiFi 7 chips after 8922D (suffix v2) */
+	u16 snrpt;
 };
 
 struct rtw89_rsvd_quota {
@@ -4048,6 +4051,17 @@ struct rtw89_dle_rsvd_size {
 	u32 size;
 };
 
+struct rtw89_dle_input {
+	u32 tx_ampdu_num_b0;
+	u32 tx_ampdu_num_b1;
+	u32 tx_amsdu_size; /* unit: KB */
+	u32 h2c_max_size;
+	u32 rx_amsdu_size; /* unit: KB */
+	u32 c2h_max_size;
+	u32 mpdu_info_tbl_b0;
+	u32 mpdu_info_tbl_b1;
+};
+
 struct rtw89_dle_mem {
 	enum rtw89_qta_mode mode;
 	const struct rtw89_dle_size *wde_size;
@@ -4060,6 +4074,8 @@ struct rtw89_dle_mem {
 	const struct rtw89_rsvd_quota *rsvd_qt;
 	const struct rtw89_dle_rsvd_size *rsvd0_size;
 	const struct rtw89_dle_rsvd_size *rsvd1_size;
+	/* for WiFi 7 chips after 8922D */
+	const struct rtw89_dle_input *dle_input;
 };
 
 struct rtw89_reg_def {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index be478540f742..b1f313f738b8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1717,10 +1717,12 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size7 = {RTW89_WDE_PG_64, 510, 2,},
 	/* DLFW */
 	.wde_size9 = {RTW89_WDE_PG_64, 0, 1024,},
+	.wde_size16_v1 = {RTW89_WDE_PG_64, 639, 1, 0,},
 	/* 8852C USB3.0 */
 	.wde_size17 = {RTW89_WDE_PG_64, 354, 30,},
 	/* 8852C DLFW */
 	.wde_size18 = {RTW89_WDE_PG_64, 0, 2048,},
+	.wde_size18_v1 = {RTW89_WDE_PG_64, 0, 640, 0,},
 	/* 8852C PCIE SCC */
 	.wde_size19 = {RTW89_WDE_PG_64, 3328, 0,},
 	.wde_size23 = {RTW89_WDE_PG_64, 1022, 2,},
@@ -1747,6 +1749,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_size18 = {RTW89_PLE_PG_128, 2544, 16,},
 	/* 8852C PCIE SCC */
 	.ple_size19 = {RTW89_PLE_PG_128, 1904, 16,},
+	.ple_size20_v1 = {RTW89_PLE_PG_128, 2554, 182, 40960,},
+	.ple_size22_v1 = {RTW89_PLE_PG_128, 2736, 0, 40960,},
 	/* 8852B USB2.0 SCC */
 	.ple_size32 = {RTW89_PLE_PG_128, 620, 20,},
 	/* 8852B USB3.0 SCC */
@@ -1758,6 +1762,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt0_v1 = {3302, 6, 0, 20,},
 	/* 8852A USB */
 	.wde_qt1 = {512, 196, 0, 60,},
+	.wde_qt3 = {0, 0, 0, 0,},
 	/* DLFW */
 	.wde_qt4 = {0, 0, 0, 0,},
 	/* PCIE 64 */
@@ -1770,6 +1775,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt17 = {0, 0, 0,  0,},
 	/* 8852C PCIE SCC */
 	.wde_qt18 = {3228, 60, 0, 40,},
+	.wde_qt19_v1 = {613, 6, 0, 20,},
 	.wde_qt23 = {958, 48, 0, 16,},
 	/* 8852B USB2.0/USB3.0 SCC */
 	.wde_qt25 = {152, 2, 0, 8,},
@@ -1781,6 +1787,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt4 = {264, 0, 16, 20, 26, 13, 356, 0, 32, 40, 8,},
 	/* PCIE SCC */
 	.ple_qt5 = {264, 0, 32, 20, 64, 13, 1101, 0, 64, 128, 120,},
+	.ple_qt5_v2 = {0, 0, 32, 256, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,},
 	.ple_qt9 = {0, 0, 32, 256, 0, 0, 0, 0, 0, 0, 1, 0, 0,},
 	/* DLFW */
 	.ple_qt13 = {0, 0, 16, 48, 0, 0, 0, 0, 0, 0, 0,},
@@ -1791,8 +1798,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt26 = {2654, 0, 1134, 48, 64, 13, 1478, 0, 64, 128, 120, 0,},
 	/* USB 52C USB3.0 */
 	.ple_qt42 = {1068, 0, 16, 48, 4, 13, 178, 0, 16, 1, 8, 16, 0,},
+	.ple_qt42_v2 = {91, 91, 32, 16, 19, 13, 91, 91, 44, 18, 1, 4, 0, 0,},
 	/* USB 52C USB3.0 */
 	.ple_qt43 = {3068, 0, 32, 48, 4, 13, 178, 0, 16, 1, 8, 16, 0,},
+	.ple_qt43_v2 = {645, 645, 32, 16, 2062, 2056, 2134, 2134, 2087, 2061, 1, 2047, 0, 0,},
 	/* DLFW 52C */
 	.ple_qt44 = {0, 0, 16, 256, 0, 0, 0, 0, 0, 0, 0, 0,},
 	/* DLFW 52C */
@@ -1826,8 +1835,13 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt_51b_wow = {147, 0, 16, 20, 157, 13, 133, 0, 172, 14, 24, 0,},
 	.ple_rsvd_qt0 = {2, 107, 107, 6, 6, 6, 6, 0, 0, 0,},
 	.ple_rsvd_qt1 = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+	.ple_rsvd_qt9 = {1, 44, 44, 6, 6, 6, 6, 69, 0, 0,},
 	.rsvd0_size0 = {212992, 0,},
+	.rsvd0_size6 = {40960, 0,},
 	.rsvd1_size0 = {587776, 2048,},
+	.rsvd1_size2 = {391168, 2048,},
+	.dle_input3 = {0, 0, 0, 16384, 0, 2048, 0, 0,},
+	.dle_input18 = {128, 128, 11454, 2048, 0, 2048, 24, 24,},
 };
 EXPORT_SYMBOL(rtw89_mac_size);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index b569f721a6f9..fd1e3a395891 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -932,8 +932,10 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size6;
 	const struct rtw89_dle_size wde_size7;
 	const struct rtw89_dle_size wde_size9;
+	const struct rtw89_dle_size wde_size16_v1;
 	const struct rtw89_dle_size wde_size17;
 	const struct rtw89_dle_size wde_size18;
+	const struct rtw89_dle_size wde_size18_v1;
 	const struct rtw89_dle_size wde_size19;
 	const struct rtw89_dle_size wde_size23;
 	const struct rtw89_dle_size wde_size25;
@@ -949,18 +951,22 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size ple_size17;
 	const struct rtw89_dle_size ple_size18;
 	const struct rtw89_dle_size ple_size19;
+	const struct rtw89_dle_size ple_size20_v1;
+	const struct rtw89_dle_size ple_size22_v1;
 	const struct rtw89_dle_size ple_size32;
 	const struct rtw89_dle_size ple_size33;
 	const struct rtw89_dle_size ple_size34;
 	const struct rtw89_wde_quota wde_qt0;
 	const struct rtw89_wde_quota wde_qt1;
 	const struct rtw89_wde_quota wde_qt0_v1;
+	const struct rtw89_wde_quota wde_qt3;
 	const struct rtw89_wde_quota wde_qt4;
 	const struct rtw89_wde_quota wde_qt6;
 	const struct rtw89_wde_quota wde_qt7;
 	const struct rtw89_wde_quota wde_qt16;
 	const struct rtw89_wde_quota wde_qt17;
 	const struct rtw89_wde_quota wde_qt18;
+	const struct rtw89_wde_quota wde_qt19_v1;
 	const struct rtw89_wde_quota wde_qt23;
 	const struct rtw89_wde_quota wde_qt25;
 	const struct rtw89_wde_quota wde_qt31;
@@ -968,13 +974,16 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt1;
 	const struct rtw89_ple_quota ple_qt4;
 	const struct rtw89_ple_quota ple_qt5;
+	const struct rtw89_ple_quota ple_qt5_v2;
 	const struct rtw89_ple_quota ple_qt9;
 	const struct rtw89_ple_quota ple_qt13;
 	const struct rtw89_ple_quota ple_qt18;
 	const struct rtw89_ple_quota ple_qt25;
 	const struct rtw89_ple_quota ple_qt26;
 	const struct rtw89_ple_quota ple_qt42;
+	const struct rtw89_ple_quota ple_qt42_v2;
 	const struct rtw89_ple_quota ple_qt43;
+	const struct rtw89_ple_quota ple_qt43_v2;
 	const struct rtw89_ple_quota ple_qt44;
 	const struct rtw89_ple_quota ple_qt45;
 	const struct rtw89_ple_quota ple_qt46;
@@ -994,8 +1003,14 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt_51b_wow;
 	const struct rtw89_rsvd_quota ple_rsvd_qt0;
 	const struct rtw89_rsvd_quota ple_rsvd_qt1;
+	const struct rtw89_rsvd_quota ple_rsvd_qt1_v1;
+	const struct rtw89_rsvd_quota ple_rsvd_qt9;
 	const struct rtw89_dle_rsvd_size rsvd0_size0;
+	const struct rtw89_dle_rsvd_size rsvd0_size6;
 	const struct rtw89_dle_rsvd_size rsvd1_size0;
+	const struct rtw89_dle_rsvd_size rsvd1_size2;
+	const struct rtw89_dle_input dle_input3;
+	const struct rtw89_dle_input dle_input18;
 };
 
 extern const struct rtw89_mac_size_set rtw89_mac_size;
-- 
2.25.1


