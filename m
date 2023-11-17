Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD1C7EEB28
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 03:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjKQCle (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 21:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjKQCld (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 21:41:33 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A66D4D
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 18:41:29 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AH2fMpwD2818711, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AH2fMpwD2818711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 10:41:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Nov 2023 10:41:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 17 Nov
 2023 10:41:22 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: mac: use mac_gen pointer to access about efuse
Date:   Fri, 17 Nov 2023 10:40:25 +0800
Message-ID: <20231117024029.113845-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117024029.113845-1-pkshih@realtek.com>
References: <20231117024029.113845-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use function pointers to abstract efuse access, and introduce an new
function to convert efuse power state that is needed by WiFi 7 chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  |  5 +++--
 drivers/net/wireless/realtek/rtw89/efuse.c |  9 +++++++--
 drivers/net/wireless/realtek/rtw89/efuse.h |  5 +++--
 drivers/net/wireless/realtek/rtw89/mac.c   | 16 +++++++++++++---
 drivers/net/wireless/realtek/rtw89/mac.h   |  3 +++
 5 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index b18f54b16f9a..74bf29643823 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4216,17 +4216,18 @@ static void rtw89_core_setup_rfe_parms(struct rtw89_dev *rtwdev)
 
 static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	int ret;
 
 	ret = rtw89_mac_partial_init(rtwdev, false);
 	if (ret)
 		return ret;
 
-	ret = rtw89_parse_efuse_map(rtwdev);
+	ret = mac->parse_efuse_map(rtwdev);
 	if (ret)
 		return ret;
 
-	ret = rtw89_parse_phycap_map(rtwdev);
+	ret = mac->parse_phycap_map(rtwdev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wireless/realtek/rtw89/efuse.c
index 2aaf4d013e46..b2e8c6cc12d9 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -114,6 +114,11 @@ static int rtw89_dump_physical_efuse_map_ddv(struct rtw89_dev *rtwdev, u8 *map,
 	return 0;
 }
 
+int rtw89_cnv_efuse_state_ax(struct rtw89_dev *rtwdev, bool idle)
+{
+	return 0;
+}
+
 static int rtw89_dump_physical_efuse_map_dav(struct rtw89_dev *rtwdev, u8 *map,
 					     u32 dump_addr, u32 dump_size)
 {
@@ -231,7 +236,7 @@ static int rtw89_dump_logical_efuse_map(struct rtw89_dev *rtwdev, u8 *phy_map,
 	return 0;
 }
 
-int rtw89_parse_efuse_map(struct rtw89_dev *rtwdev)
+int rtw89_parse_efuse_map_ax(struct rtw89_dev *rtwdev)
 {
 	u32 phy_size = rtwdev->chip->physical_efuse_size;
 	u32 log_size = rtwdev->chip->logical_efuse_size;
@@ -300,7 +305,7 @@ int rtw89_parse_efuse_map(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
-int rtw89_parse_phycap_map(struct rtw89_dev *rtwdev)
+int rtw89_parse_phycap_map_ax(struct rtw89_dev *rtwdev)
 {
 	u32 phycap_addr = rtwdev->chip->phycap_addr;
 	u32 phycap_size = rtwdev->chip->phycap_size;
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.h b/drivers/net/wireless/realtek/rtw89/efuse.h
index 79071aff28de..24173b3dc085 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.h
+++ b/drivers/net/wireless/realtek/rtw89/efuse.h
@@ -7,8 +7,9 @@
 
 #include "core.h"
 
-int rtw89_parse_efuse_map(struct rtw89_dev *rtwdev);
-int rtw89_parse_phycap_map(struct rtw89_dev *rtwdev);
+int rtw89_parse_efuse_map_ax(struct rtw89_dev *rtwdev);
+int rtw89_parse_phycap_map_ax(struct rtw89_dev *rtwdev);
+int rtw89_cnv_efuse_state_ax(struct rtw89_dev *rtwdev, bool idle);
 int rtw89_read_efuse_ver(struct rtw89_dev *rtwdev, u8 *efv);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 0c5768f41d55..9ec307051611 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5,6 +5,7 @@
 #include "cam.h"
 #include "chan.h"
 #include "debug.h"
+#include "efuse.h"
 #include "fw.h"
 #include "mac.h"
 #include "pci.h"
@@ -2626,20 +2627,26 @@ static int cmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 static int rtw89_mac_read_phycap(struct rtw89_dev *rtwdev,
 				 struct rtw89_mac_c2h_info *c2h_info)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_mac_h2c_info h2c_info = {0};
 	u32 ret;
 
+	mac->cnv_efuse_state(rtwdev, false);
+
 	h2c_info.id = RTW89_FWCMD_H2CREG_FUNC_GET_FEATURE;
 	h2c_info.content_len = 0;
 
 	ret = rtw89_fw_msg_reg(rtwdev, &h2c_info, c2h_info);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (c2h_info->id != RTW89_FWCMD_C2HREG_FUNC_PHY_CAP)
-		return -EINVAL;
+		ret = -EINVAL;
 
-	return 0;
+out:
+	mac->cnv_efuse_state(rtwdev, true);
+
+	return ret;
 }
 
 int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
@@ -5775,6 +5782,9 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
 	.fwdl_get_status = rtw89_fw_get_rdy_ax,
 	.fwdl_check_path_ready = rtw89_fwdl_check_path_ready_ax,
+	.parse_efuse_map = rtw89_parse_efuse_map_ax,
+	.parse_phycap_map = rtw89_parse_phycap_map_ax,
+	.cnv_efuse_state = rtw89_cnv_efuse_state_ax,
 
 	.get_txpwr_cr = rtw89_mac_get_txpwr_cr_ax,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index cd2e9b850c72..f47a42387a6a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -873,6 +873,9 @@ struct rtw89_mac_gen_def {
 				bool dlfw, bool include_bb);
 	u8 (*fwdl_get_status)(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type);
 	int (*fwdl_check_path_ready)(struct rtw89_dev *rtwdev, bool h2c_or_fwdl);
+	int (*parse_efuse_map)(struct rtw89_dev *rtwdev);
+	int (*parse_phycap_map)(struct rtw89_dev *rtwdev);
+	int (*cnv_efuse_state)(struct rtw89_dev *rtwdev, bool idle);
 
 	bool (*get_txpwr_cr)(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx,
-- 
2.25.1

