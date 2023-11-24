Return-Path: <linux-wireless+bounces-28-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 604907F6CBE
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A04BB20D5D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 07:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA33C8F63;
	Fri, 24 Nov 2023 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F06D5E
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 23:18:14 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AO7I73M03551149, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AO7I73M03551149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 15:18:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Nov 2023 15:18:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 24 Nov
 2023 15:18:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/8] wifi: rtw89: add reserved size as factor of DLE used size
Date: Fri, 24 Nov 2023 15:16:58 +0800
Message-ID: <20231124071703.132549-4-pkshih@realtek.com>
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

DLE stands for Double Link Engine that is used to maintain buffer page.
To avoid linking to wrong pages, we check the used page size during
initialization and stop driver probe if the used size is unexpected.

Currently, we check the page size used by PLE (payload engine) and WDE
(WiFi descriptor engine). For coming WiFi 7 chips, additional reserved
size is added for BB as buffer to run LA mode, so add and check the
reserved size as well.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index ac14865a114a..bdd9c152951f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1672,11 +1672,21 @@ static bool mac_is_txq_empty(struct rtw89_dev *rtwdev)
 	return (val32 & msk32) == msk32;
 }
 
-static inline u32 dle_used_size(const struct rtw89_dle_size *wde,
-				const struct rtw89_dle_size *ple)
+static inline u32 dle_used_size(const struct rtw89_dle_mem *cfg)
 {
-	return wde->pge_size * (wde->lnk_pge_num + wde->unlnk_pge_num) +
+	const struct rtw89_dle_size *wde = cfg->wde_size;
+	const struct rtw89_dle_size *ple = cfg->ple_size;
+	u32 used;
+
+	used = wde->pge_size * (wde->lnk_pge_num + wde->unlnk_pge_num) +
 	       ple->pge_size * (ple->lnk_pge_num + ple->unlnk_pge_num);
+
+	if (cfg->rsvd0_size && cfg->rsvd1_size) {
+		used += cfg->rsvd0_size->size;
+		used += cfg->rsvd1_size->size;
+	}
+
+	return used;
 }
 
 static u32 dle_expected_used_size(struct rtw89_dev *rtwdev,
@@ -1898,8 +1908,7 @@ static int dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
 		ext_wde_min_qt_wcpu = ext_cfg->wde_min_qt->wcpu;
 	}
 
-	if (dle_used_size(cfg->wde_size, cfg->ple_size) !=
-	    dle_expected_used_size(rtwdev, mode)) {
+	if (dle_used_size(cfg) != dle_expected_used_size(rtwdev, mode)) {
 		rtw89_err(rtwdev, "[ERR]wd/dle mem cfg\n");
 		ret = -EINVAL;
 		goto error;
@@ -3037,8 +3046,7 @@ static int dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
 		return -EINVAL;
 	}
 
-	if (dle_used_size(cfg->wde_size, cfg->ple_size) !=
-	    dle_expected_used_size(rtwdev, mode)) {
+	if (dle_used_size(cfg) != dle_expected_used_size(rtwdev, mode)) {
 		rtw89_err(rtwdev, "[ERR]wd/dle mem cfg\n");
 		return -EINVAL;
 	}
-- 
2.25.1


