Return-Path: <linux-wireless+bounces-3377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440384F074
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 07:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF5A1F29197
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB947657AE;
	Fri,  9 Feb 2024 06:53:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6C1657B6
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707461639; cv=none; b=Xq6q8W3dA/qKvYmxGq1L5sMcChCCptqO69RaUEh+r6nrX5z9KZrlkfsvTXEY0sERHleM0/Xpk35dbAgeZw85dYsebYK0ryczRype9I/7SkZ3dmoAab7tkgVn/MFA/9XwL+WklwZdZPCx2TVB8fc3/FMIfnqg/A/7RLppL70cx+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707461639; c=relaxed/simple;
	bh=AFs5qxPazLMn6htU5mDFbEcdJdrcMTLlqL/Z6oq5EAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKA38oAkPX4x+R2bDS2af6CZ1FxIiQ2caA8YeXB5PHjyzK5wEfjJowvxTWI9ltxXSUJ3JD5Agvbl47yz9nbDEGv/BilC5/Kj8Q0KeYaEWteoP0/Urrg9025rx7xdLaevBVB7M2vJMaTKaTB6fLGCVOvo/zmUtMVsw0poPcbvtIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4196rqvbF548419, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4196rqvbF548419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 14:53:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 9 Feb 2024 14:53:53 +0800
Received: from [127.0.1.1] (172.16.16.210) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Feb
 2024 14:53:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 08/11] wifi: rtw89: 8922a: correct register definition and merge IO for ctrl_nbtg_bt_tx()
Date: Fri, 9 Feb 2024 14:52:26 +0800
Message-ID: <20240209065229.34515-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209065229.34515-1-pkshih@realtek.com>
References: <20240209065229.34515-1-pkshih@realtek.com>
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

ctrl_nbtg_bt_tx is used to control AGC settings under non-shared path
condition, which is affected by BT TX. To speed up IO, merge continual
bit mask into one IO. Also, correct a register definition.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  6 +++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 30 +++++--------------
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 31bdc7616749..26aa2d9bd526 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8077,14 +8077,16 @@
 #define R_S1_ADDCK 0x3E00
 #define B_S1_ADDCK_I GENMASK(9, 0)
 #define B_S1_ADDCK_Q GENMASK(19, 10)
-#define R_OP1DB_A 0x406B
+#define R_OP1DB_A 0x40B0
 #define B_OP1DB_A GENMASK(31, 24)
 #define R_OP1DB1_A 0x40BC
+#define B_TIA10_A GENMASK(15, 0)
 #define B_TIA1_A GENMASK(15, 8)
 #define B_TIA0_A GENMASK(7, 0)
 #define R_BKOFF_A 0x40E0
 #define B_BKOFF_IBADC_A GENMASK(23, 18)
 #define R_BACKOFF_A 0x40E4
+#define B_LNA_IBADC_A GENMASK(29, 18)
 #define B_BACKOFF_LNA_A GENMASK(29, 24)
 #define B_BACKOFF_IBADC_A GENMASK(23, 18)
 #define R_RXBY_WBADC_A 0x40F4
@@ -8140,11 +8142,13 @@
 #define R_LNA_OP 0x44B0
 #define B_LNA6 GENMASK(31, 24)
 #define R_LNA_TIA 0x44BC
+#define B_TIA10_B GENMASK(15, 0)
 #define B_TIA1_B GENMASK(15, 8)
 #define B_TIA0_B GENMASK(7, 0)
 #define R_BKOFF_B 0x44E0
 #define B_BKOFF_IBADC_B GENMASK(23, 18)
 #define R_BACKOFF_B 0x44E4
+#define B_LNA_IBADC_B GENMASK(29, 18)
 #define B_BACKOFF_LNA_B GENMASK(29, 24)
 #define B_BACKOFF_IBADC_B GENMASK(23, 18)
 #define R_RXBY_WBADC_B 0x44F4
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 02ec4d27011f..f7b81daa0b03 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1526,11 +1526,8 @@ static void rtw8922a_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 				      0x0, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_A, B_BT_TRK_OFF_A, 0x0, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_OP1DB_A, B_OP1DB_A, 0x80, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_OP1DB1_A, B_TIA0_A, 0x80, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_OP1DB1_A, B_TIA1_A, 0x80, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_A, B_BACKOFF_IBADC_A,
-				      0x34, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_A, B_BACKOFF_LNA_A, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_OP1DB1_A, B_TIA10_A, 0x8080, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_A, B_LNA_IBADC_A, 0x34, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_BKOFF_A, B_BKOFF_IBADC_A, 0x34, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_FORCE_FIR_B, B_FORCE_FIR_B, 0x3, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RXBY_WBADC_B, B_RXBY_WBADC_B,
@@ -1539,11 +1536,8 @@ static void rtw8922a_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 				      0x0, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_B, B_BT_TRK_OFF_B, 0x0, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_LNA_OP, B_LNA6, 0x80, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA0_B, 0x80, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA1_B, 0x80, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_B, B_BACKOFF_IBADC_B,
-				      0x34, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_B, B_BACKOFF_LNA_B, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA10_B, 0x8080, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_B, B_LNA_IBADC_B, 0x34, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_BKOFF_B, B_BKOFF_IBADC_B, 0x34, phy_idx);
 	} else {
 		rtw89_phy_write32_idx(rtwdev, R_FORCE_FIR_A, B_FORCE_FIR_A, 0x0, phy_idx);
@@ -1553,12 +1547,8 @@ static void rtw8922a_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 				      0x1, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_A, B_BT_TRK_OFF_A, 0x1, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_OP1DB_A, B_OP1DB_A, 0x1a, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_OP1DB1_A, B_TIA0_A, 0x2a, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_OP1DB1_A, B_TIA1_A, 0x2a, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_A, B_BACKOFF_IBADC_A,
-				      0x26, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_A, B_BACKOFF_LNA_A,
-				      0x1e, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_OP1DB1_A, B_TIA10_A, 0x2a2a, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_A, B_LNA_IBADC_A, 0x7a6, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_BKOFF_A, B_BKOFF_IBADC_A, 0x26, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_FORCE_FIR_B, B_FORCE_FIR_B, 0x0, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RXBY_WBADC_B, B_RXBY_WBADC_B,
@@ -1567,12 +1557,8 @@ static void rtw8922a_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 				      0x1, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_B, B_BT_TRK_OFF_B, 0x1, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_LNA_OP, B_LNA6, 0x20, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA0_B, 0x30, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA1_B, 0x2a, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_B, B_BACKOFF_IBADC_B,
-				      0x26, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_B, B_BACKOFF_LNA_B,
-				      0x1e, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA10_B, 0x2a30, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_B, B_LNA_IBADC_B, 0x7a6, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_BKOFF_B, B_BKOFF_IBADC_B, 0x26, phy_idx);
 	}
 }
-- 
2.25.1


