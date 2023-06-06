Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F14D72454F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbjFFOJG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbjFFOJB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 10:09:01 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D61DE42
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 07:08:59 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:552a:0:640:dccd:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 0CEC86012B;
        Tue,  6 Jun 2023 17:08:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id c8UeC5oWna60-4N1jqPPL;
        Tue, 06 Jun 2023 17:08:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686060537;
        bh=6t+GUGyscvW2vOZjK1K6DFMQ45e6UF06dGneCwT4+6I=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Rcxbj6PzyoPk9HWfSfwVXP7Pv3eZAJWV+HN2gpg0eHES88HIHnM7YHHC95JO+oH5B
         g0kDWeRZjpC6t+zYVvZTe4twMoVsdrDp2oAzvZXqjdAd0TtoYT5vXsbWs9gjK985bz
         WLUE1XpR6Uu7kxUEIkS59+MCnBdiNuECVCyoJnGY=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: rtw89: cleanup rtw89_iqk_info and related code
Date:   Tue,  6 Jun 2023 17:08:06 +0300
Message-Id: <20230606140806.606352-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606140806.606352-1-dmantipov@yandex.ru>
References: <20230606083354.375287-1-dmantipov@yandex.ru>
 <20230606140806.606352-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop useless '_iqk_track()' and 'rtw8852a_iqk_track()' (they
just change 'thermal_rek_en' field which is set but unused
and so removed as well) functions, set but unused 'kcount'
field of 'struct rtw89_iqk_info', convert 'thermal' to local
variables where appropriate (it doesn't need to have longer
storage duration because it is actually used for debugging
purposes only), fix typos.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  3 --
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 -
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c | 34 +------------------
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.h |  1 -
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c |  8 +----
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |  9 ++---
 6 files changed, 4 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index bea2e7210b70..5e703d617e26 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3540,7 +3540,6 @@ struct rtw89_iqk_info {
 	u8 iqk_band[RTW89_IQK_PATH_NR];
 	u8 iqk_ch[RTW89_IQK_PATH_NR];
 	u8 iqk_bw[RTW89_IQK_PATH_NR];
-	u8 kcount;
 	u8 iqk_times;
 	u8 version;
 	u32 nb_txcfir[RTW89_IQK_PATH_NR];
@@ -3555,8 +3554,6 @@ struct rtw89_iqk_info {
 	bool iqk_xym_en;
 	bool iqk_sram_en;
 	bool iqk_cfir_en;
-	u8 thermal[RTW89_IQK_PATH_NR];
-	bool thermal_rek_en;
 	u32 syn1to2;
 	u8 iqk_mcc_ch[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
 	u8 iqk_table_idx[RTW89_IQK_PATH_NR];
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index d7930efd89b7..e798f395b32d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1332,7 +1332,6 @@ static void rtw8852a_rfk_scan(struct rtw89_dev *rtwdev, bool start)
 static void rtw8852a_rfk_track(struct rtw89_dev *rtwdev)
 {
 	rtw8852a_dpk_track(rtwdev);
-	rtw8852a_iqk_track(rtwdev);
 	rtw8852a_tssi_track(rtwdev);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index cd6c39b7f802..afb7eba3dc44 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -1284,11 +1284,8 @@ static void _iqk_info_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	u32 tmp = 0x0;
 	bool flag = 0x0;
 
-	iqk_info->thermal[path] =
-		ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
-	iqk_info->thermal_rek_en = false;
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_thermal = %d\n", path,
-		    iqk_info->thermal[path]);
+		    (u8)ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]));
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_LOK_COR_fail= %d\n", path,
 		    iqk_info->lok_cor_fail[0][path]);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_LOK_FIN_fail= %d\n", path,
@@ -1536,28 +1533,6 @@ static void _iqk_dbcc(struct rtw89_dev *rtwdev, u8 path)
 	_iqk_afebb_restore(rtwdev, phy_idx, path);
 }
 
-static void _iqk_track(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_iqk_info *iqk = &rtwdev->iqk;
-	u8 path = 0x0;
-	u8 cur_ther;
-
-	if (iqk->iqk_band[0] == RTW89_BAND_2G)
-		return;
-	if (iqk->iqk_bw[0] < RTW89_CHANNEL_WIDTH_80)
-		return;
-
-	/* only check path 0 */
-	for (path = 0; path < 1; path++) {
-		cur_ther = ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
-
-		if (abs(cur_ther - iqk->thermal[path]) > RTW8852A_IQK_THR_REK)
-			iqk->thermal_rek_en = true;
-		else
-			iqk->thermal_rek_en = false;
-	}
-}
-
 static void _rck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 {
 	u32 rf_reg5, rck_val = 0;
@@ -1616,7 +1591,6 @@ static void _iqk_init(struct rtw89_dev *rtwdev)
 	iqk_info->iqk_sram_en = false;
 	iqk_info->iqk_cfir_en = false;
 	iqk_info->iqk_xym_en = false;
-	iqk_info->thermal_rek_en = false;
 	iqk_info->iqk_times = 0x0;
 
 	for (ch = 0; ch < RTW89_IQK_CHS_NR; ch++) {
@@ -1645,7 +1619,6 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]==========IQK start!!!!!==========\n");
 	iqk_info->iqk_times++;
-	iqk_info->kcount = 0;
 	iqk_info->version = RTW8852A_IQK_VER;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]Test Ver 0x%x\n", iqk_info->version);
@@ -3655,11 +3628,6 @@ void rtw8852a_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_STOP);
 }
 
-void rtw8852a_iqk_track(struct rtw89_dev *rtwdev)
-{
-	_iqk_track(rtwdev);
-}
-
 void rtw8852a_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 		     bool is_afe)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h
index ea36553a76b7..fa058ccc8616 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h
@@ -10,7 +10,6 @@
 void rtw8852a_rck(struct rtw89_dev *rtwdev);
 void rtw8852a_dack(struct rtw89_dev *rtwdev);
 void rtw8852a_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
-void rtw8852a_iqk_track(struct rtw89_dev *rtwdev);
 void rtw8852a_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 		     bool is_afe);
 void rtw8852a_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 722ae34b09c1..fa018e1f499b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -1317,10 +1317,6 @@ static void _iqk_info_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	u32 tmp;
 	bool flag;
 
-	iqk_info->thermal[path] =
-		ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
-	iqk_info->thermal_rek_en = false;
-
 	flag = iqk_info->lok_cor_fail[0][path];
 	rtw89_phy_write32_mask(rtwdev, R_IQKINF, B_IQKINF_FCOR << (path * 4), flag);
 	flag = iqk_info->lok_fin_fail[0][path];
@@ -1568,7 +1564,6 @@ static void _iqk_init(struct rtw89_dev *rtwdev)
 	iqk_info->iqk_sram_en = false;
 	iqk_info->iqk_cfir_en = false;
 	iqk_info->iqk_xym_en = false;
-	iqk_info->thermal_rek_en = false;
 	iqk_info->iqk_times = 0x0;
 
 	for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
@@ -1622,9 +1617,8 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
-		    "[IQK]==========IQK strat!!!!!==========\n");
+		    "[IQK]==========IQK start!!!!!==========\n");
 	iqk_info->iqk_times++;
-	iqk_info->kcount = 0;
 	iqk_info->version = RTW8852B_IQK_VER;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]Test Ver 0x%x\n", iqk_info->version);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 2c0bc3a4ab3b..d8c8688faee4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -1261,11 +1261,8 @@ static void _iqk_info_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	u32 tmp;
 	bool flag;
 
-	iqk_info->thermal[path] =
-		ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
-	iqk_info->thermal_rek_en = false;
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_thermal = %d\n", path,
-		    iqk_info->thermal[path]);
+		    (u8)ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]));
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_LOK_COR_fail= %d\n", path,
 		    iqk_info->lok_cor_fail[0][path]);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_LOK_FIN_fail= %d\n", path,
@@ -1502,7 +1499,6 @@ static void _iqk_init(struct rtw89_dev *rtwdev)
 	iqk_info->iqk_sram_en = false;
 	iqk_info->iqk_cfir_en = false;
 	iqk_info->iqk_xym_en = false;
-	iqk_info->thermal_rek_en = false;
 	iqk_info->iqk_times = 0x0;
 
 	for (ch = 0; ch < RTW89_IQK_CHS_NR; ch++) {
@@ -1529,9 +1525,8 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
-		    "[IQK]==========IQK strat!!!!!==========\n");
+		    "[IQK]==========IQK start!!!!!==========\n");
 	iqk_info->iqk_times++;
-	iqk_info->kcount = 0;
 	iqk_info->version = RTW8852C_IQK_VER;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]Test Ver 0x%x\n", iqk_info->version);
-- 
2.40.1

