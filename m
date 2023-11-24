Return-Path: <linux-wireless+bounces-29-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073E27F6CC1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02A42814F1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684749461;
	Fri, 24 Nov 2023 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7C8D6E
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 23:18:15 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AO7I9wO43551155, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AO7I9wO43551155
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 15:18:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 24 Nov 2023 15:18:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 24 Nov
 2023 15:18:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/8] wifi: rtw89: refine element naming used by queue empty check
Date: Fri, 24 Nov 2023 15:16:59 +0800
Message-ID: <20231124071703.132549-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124071703.132549-1-pkshih@realtek.com>
References: <20231124071703.132549-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In queue empty check, one group contains 32 queues. And, the two elements,
wde_qempty_acq_num and wde_qempty_mgq_sel, are number of group and select
of group. To avoid confusing them with queue number and queue selection,
we refine their naming.

(don't change logic at all)

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 4 ++--
 drivers/net/wireless/realtek/rtw89/mac.c      | 8 ++++----
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 2 ++
 7 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4fcad17dd9b7..0f6077a01b73 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3676,8 +3676,8 @@ struct rtw89_chip_info {
 	u32 rsvd_ple_ofst;
 	const struct rtw89_hfc_param_ini *hfc_param_ini;
 	const struct rtw89_dle_mem *dle_mem;
-	u8 wde_qempty_acq_num;
-	u8 wde_qempty_mgq_sel;
+	u8 wde_qempty_acq_grpnum;
+	u8 wde_qempty_mgq_grpsel;
 	u32 rf_base_addr[2];
 	u8 support_chanctx_num;
 	u8 support_bands;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index bdd9c152951f..b5e32b830a17 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1621,13 +1621,13 @@ int rtw89_mac_get_dle_rsvd_qt_cfg(struct rtw89_dev *rtwdev,
 static bool mac_is_txq_empty(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mac_dle_dfi_qempty qempty;
-	u32 qnum, qtmp, val32, msk32;
+	u32 grpnum, qtmp, val32, msk32;
 	int i, j, ret;
 
-	qnum = rtwdev->chip->wde_qempty_acq_num;
+	grpnum = rtwdev->chip->wde_qempty_acq_grpnum;
 	qempty.dle_type = DLE_CTRL_TYPE_WDE;
 
-	for (i = 0; i < qnum; i++) {
+	for (i = 0; i < grpnum; i++) {
 		qempty.grpsel = i;
 		ret = dle_dfi_qempty(rtwdev, &qempty);
 		if (ret) {
@@ -1643,7 +1643,7 @@ static bool mac_is_txq_empty(struct rtw89_dev *rtwdev)
 		}
 	}
 
-	qempty.grpsel = rtwdev->chip->wde_qempty_mgq_sel;
+	qempty.grpsel = rtwdev->chip->wde_qempty_mgq_grpsel;
 	ret = dle_dfi_qempty(rtwdev, &qempty);
 	if (ret) {
 		rtw89_warn(rtwdev, "dle dfi mgq empty %d\n", ret);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index dd15b904cd2f..734960a47ecf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2360,8 +2360,8 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= rtw8851b_hfc_param_ini_pcie,
 	.dle_mem		= rtw8851b_dle_mem_pcie,
-	.wde_qempty_acq_num     = 4,
-	.wde_qempty_mgq_sel     = 4,
+	.wde_qempty_acq_grpnum	= 4,
+	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 2bddd0acb195..247f717792cd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2095,8 +2095,8 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852a_hfc_param_ini_pcie,
 	.dle_mem		= rtw8852a_dle_mem_pcie,
-	.wde_qempty_acq_num	= 16,
-	.wde_qempty_mgq_sel	= 16,
+	.wde_qempty_acq_grpnum	= 16,
+	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xc000, 0xd000},
 	.pwr_on_seq		= pwr_on_seq_8852a,
 	.pwr_off_seq		= pwr_off_seq_8852a,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index a576e4f47880..f1eb7183a87b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2529,8 +2529,8 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= rtw8852b_hfc_param_ini_pcie,
 	.dle_mem		= rtw8852b_dle_mem_pcie,
-	.wde_qempty_acq_num	= 4,
-	.wde_qempty_mgq_sel	= 4,
+	.wde_qempty_acq_grpnum	= 4,
+	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ea152a4613f2..1a0a24805610 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2865,8 +2865,8 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852c_hfc_param_ini_pcie,
 	.dle_mem		= rtw8852c_dle_mem_pcie,
-	.wde_qempty_acq_num     = 16,
-	.wde_qempty_mgq_sel     = 16,
+	.wde_qempty_acq_grpnum	= 16,
+	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xe000, 0xf000},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index b75d555d0cc3..a82c17fb1281 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -342,6 +342,8 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.rsvd_ple_ofst		= 0x8f800,
 	.hfc_param_ini		= rtw8922a_hfc_param_ini_pcie,
 	.dle_mem		= rtw8922a_dle_mem_pcie,
+	.wde_qempty_acq_grpnum	= 4,
+	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
-- 
2.25.1


