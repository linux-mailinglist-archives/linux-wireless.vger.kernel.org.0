Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093F478F872
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 08:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348355AbjIAGQY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 02:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbjIAGQX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 02:16:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA88810D3
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 23:16:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3816FgZrA004704, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3816FgZrA004704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Sep 2023 14:15:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 1 Sep 2023 14:16:08 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 1 Sep 2023
 14:16:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/8] wifi: rtw89: fw: generalize download firmware flow by mac_gen pointers
Date:   Fri, 1 Sep 2023 14:15:01 +0800
Message-ID: <20230901061507.34312-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230901061507.34312-1-pkshih@realtek.com>
References: <20230901061507.34312-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to reuse the flow to download firmware, define some mac_gen::ops
to implement them for WiFi 6 and 7 chips individually. This doesn't change
logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 21 +++++++++------------
 drivers/net/wireless/realtek/rtw89/mac.c | 17 +++++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac.h |  9 +++++----
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7c2fa732db18..459597c28bc9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -47,19 +47,13 @@ struct sk_buff *rtw89_fw_h2c_alloc_skb_no_hdr(struct rtw89_dev *rtwdev, u32 len)
 	return rtw89_fw_h2c_alloc_skb(rtwdev, len, false);
 }
 
-static u8 _fw_get_rdy(struct rtw89_dev *rtwdev)
-{
-	u8 val = rtw89_read8(rtwdev, R_AX_WCPU_FW_CTRL);
-
-	return FIELD_GET(B_AX_WCPU_FWDL_STS_MASK, val);
-}
-
 int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u8 val;
 	int ret;
 
-	ret = read_poll_timeout_atomic(_fw_get_rdy, val,
+	ret = read_poll_timeout_atomic(mac->fwdl_get_status, val,
 				       val == RTW89_FWDL_WCPU_FW_INIT_RDY,
 				       1, FWDL_WAIT_CNT, false, rtwdev);
 	if (ret) {
@@ -77,6 +71,7 @@ int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev)
 			return -EINVAL;
 
 		default:
+			rtw89_err(rtwdev, "fw unexpected status %d\n", val);
 			return -EBUSY;
 		}
 	}
@@ -767,6 +762,7 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 l
 
 static int rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 len)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	int ret;
 
 	ret = __rtw89_fw_download_hdr(rtwdev, fw, len);
@@ -775,7 +771,7 @@ static int rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 len
 		return ret;
 	}
 
-	ret = rtw89_fwdl_check_path_ready_ax(rtwdev, false);
+	ret = mac->fwdl_check_path_ready(rtwdev, false);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]FWDL path ready\n");
 		return ret;
@@ -885,13 +881,14 @@ static void rtw89_fw_dl_fail_dump(struct rtw89_dev *rtwdev)
 
 int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 	struct rtw89_fw_suit *fw_suit = rtw89_fw_suit_get(rtwdev, type);
 	struct rtw89_fw_bin_info info;
 	int ret;
 
-	rtw89_mac_disable_cpu(rtwdev);
-	ret = rtw89_mac_enable_cpu(rtwdev, 0, true);
+	mac->disable_cpu(rtwdev);
+	ret = mac->fwdl_enable_wcpu(rtwdev, 0, true);
 	if (ret)
 		return ret;
 
@@ -901,7 +898,7 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 		goto fwdl_err;
 	}
 
-	ret = rtw89_fwdl_check_path_ready_ax(rtwdev, true);
+	ret = mac->fwdl_check_path_ready(rtwdev, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]H2C path ready\n");
 		goto fwdl_err;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 013114fd9d19..fe8dbb2fe8e1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3452,7 +3452,7 @@ static void rtw89_disable_fw_watchdog(struct rtw89_dev *rtwdev)
 	rtw89_mac_mem_write(rtwdev, R_AX_WDT_STATUS, val32, RTW89_MAC_MEM_CPU_LOCAL);
 }
 
-void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev)
+static void rtw89_mac_disable_cpu_ax(struct rtw89_dev *rtwdev)
 {
 	clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
 
@@ -3467,7 +3467,7 @@ void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev)
 	rtw89_write32_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
 }
 
-int rtw89_mac_enable_cpu(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
+static int rtw89_mac_enable_cpu_ax(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
 {
 	u32 val;
 	int ret;
@@ -5684,6 +5684,14 @@ int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+static u8 rtw89_fw_get_rdy_ax(struct rtw89_dev *rtwdev)
+{
+	u8 val = rtw89_read8(rtwdev, R_AX_WCPU_FW_CTRL);
+
+	return FIELD_GET(B_AX_WCPU_FWDL_STS_MASK, val);
+}
+
+static
 int rtw89_fwdl_check_path_ready_ax(struct rtw89_dev *rtwdev,
 				   bool h2c_or_fwdl)
 {
@@ -5701,5 +5709,10 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.indir_access_addr = R_AX_INDIR_ACCESS_ENTRY,
 	.mem_base_addrs = rtw89_mac_mem_base_addrs_ax,
 	.rx_fltr = R_AX_RX_FLTR_OPT,
+
+	.disable_cpu = rtw89_mac_disable_cpu_ax,
+	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
+	.fwdl_get_status = rtw89_fw_get_rdy_ax,
+	.fwdl_check_path_ready = rtw89_fwdl_check_path_ready_ax,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index a9a571df3a77..ecf143a671c6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -858,6 +858,11 @@ struct rtw89_mac_gen_def {
 	u32 indir_access_addr;
 	const u32 *mem_base_addrs;
 	u32 rx_fltr;
+
+	void (*disable_cpu)(struct rtw89_dev *rtwdev);
+	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw);
+	u8 (*fwdl_get_status)(struct rtw89_dev *rtwdev);
+	int (*fwdl_check_path_ready)(struct rtw89_dev *rtwdev, bool h2c_or_fwdl);
 };
 
 extern const struct rtw89_mac_gen_def rtw89_mac_gen_ax;
@@ -975,8 +980,6 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct ieee80211_vif *vif);
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
-void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev);
-int rtw89_mac_enable_cpu(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw);
 int rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev);
 int rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev);
 
@@ -1207,7 +1210,5 @@ int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow);
 int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 					enum rtw89_mac_idx band);
 void rtw89_mac_hw_mgnt_sec(struct rtw89_dev *rtwdev, bool wow);
-int rtw89_fwdl_check_path_ready_ax(struct rtw89_dev *rtwdev,
-				   bool h2c_or_fwdl);
 
 #endif
-- 
2.25.1

