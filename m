Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E106E1E06
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 10:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDNIW4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 04:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjDNIWv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 04:22:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F7F30C4
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 01:22:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33E8MCBh8008421, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33E8MCBh8008421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 14 Apr 2023 16:22:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 14 Apr 2023 16:22:35 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 14 Apr
 2023 16:22:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: mac: use regular int as return type of DLE buffer request
Date:   Fri, 14 Apr 2023 16:22:28 +0800
Message-ID: <20230414082228.30766-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The function to request DLE (data link engine) buffer uses 'u16' as return
value that mixes error code, so change it to 'int' as regular error code.
Also, treat invalid register value (0xfff) as an error.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 13 ++++---------
 drivers/net/wireless/realtek/rtw89/mac.c   | 22 +++++++++++++---------
 drivers/net/wireless/realtek/rtw89/mac.h   |  2 +-
 drivers/net/wireless/realtek/rtw89/reg.h   |  1 +
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 0e0e1483c099b..1e5b7a9987163 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3069,18 +3069,13 @@ static int rtw89_dbg_trigger_ctrl_error(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_cpuio_ctrl ctrl_para = {0};
 	u16 pkt_id;
+	int ret;
 
 	rtw89_leave_ps_mode(rtwdev);
 
-	pkt_id = rtw89_mac_dle_buf_req(rtwdev, 0x20, true);
-	switch (pkt_id) {
-	case 0xffff:
-		return -ETIMEDOUT;
-	case 0xfff:
-		return -ENOMEM;
-	default:
-		break;
-	}
+	ret = rtw89_mac_dle_buf_req(rtwdev, 0x20, true, &pkt_id);
+	if (ret)
+		return ret;
 
 	/* intentionally, enqueue two pkt, but has only one pkt id */
 	ctrl_para.cmd_type = CPUIO_OP_CMD_ENQ_TO_HEAD;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d0e138f8b880a..86fc74388f55d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2805,7 +2805,7 @@ int rtw89_mac_resume_sch_tx_v1(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
 }
 EXPORT_SYMBOL(rtw89_mac_resume_sch_tx_v1);
 
-u16 rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd)
+int rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd, u16 *pkt_id)
 {
 	u32 val, reg;
 	int ret;
@@ -2820,9 +2820,13 @@ u16 rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd)
 	ret = read_poll_timeout(rtw89_read32, val, val & B_AX_WD_BUF_STAT_DONE,
 				1, 2000, false, rtwdev, reg);
 	if (ret)
-		return 0xffff;
+		return ret;
+
+	*pkt_id = FIELD_GET(B_AX_WD_BUF_STAT_PKTID_MASK, val);
+	if (*pkt_id == S_WD_BUF_STAT_PKTID_INVALID)
+		return -ENOENT;
 
-	return FIELD_GET(B_AX_WD_BUF_STAT_PKTID_MASK, val);
+	return 0;
 }
 
 int rtw89_mac_set_cpuio(struct rtw89_dev *rtwdev,
@@ -2899,10 +2903,10 @@ static int dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
 
 	dle_quota_cfg(rtwdev, cfg, INVALID_QT_WCPU);
 
-	pkt_id = rtw89_mac_dle_buf_req(rtwdev, 0x20, true);
-	if (pkt_id == 0xffff) {
+	ret = rtw89_mac_dle_buf_req(rtwdev, 0x20, true, &pkt_id);
+	if (ret) {
 		rtw89_err(rtwdev, "[ERR]WDE DLE buf req\n");
-		return -ENOMEM;
+		return ret;
 	}
 
 	ctrl_para.cmd_type = CPUIO_OP_CMD_ENQ_TO_HEAD;
@@ -2917,10 +2921,10 @@ static int dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
 		return -EFAULT;
 	}
 
-	pkt_id = rtw89_mac_dle_buf_req(rtwdev, 0x20, false);
-	if (pkt_id == 0xffff) {
+	ret = rtw89_mac_dle_buf_req(rtwdev, 0x20, false, &pkt_id);
+	if (ret) {
 		rtw89_err(rtwdev, "[ERR]PLE DLE buf req\n");
-		return -ENOMEM;
+		return ret;
 	}
 
 	ctrl_para.cmd_type = CPUIO_OP_CMD_ENQ_TO_HEAD;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8064d3953d7f2..f385db29b7f0d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1146,7 +1146,7 @@ enum rtw89_mac_xtal_si_offset {
 int rtw89_mac_write_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask);
 int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val);
 void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
-u16 rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd);
+int rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd, u16 *pkt_id);
 int rtw89_mac_set_cpuio(struct rtw89_dev *rtwdev,
 			struct rtw89_cpuio_ctrl *ctrl_para, bool wd);
 int rtw89_mac_typ_fltr_opt(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 37a1777a25a32..264e92e1601d5 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1586,6 +1586,7 @@
 #define R_AX_PL_BUF_STATUS 0x9824
 #define B_AX_WD_BUF_STAT_DONE BIT(31)
 #define B_AX_WD_BUF_STAT_PKTID_MASK GENMASK(11, 0)
+#define S_WD_BUF_STAT_PKTID_INVALID GENMASK(11, 0)
 
 #define R_AX_WD_CPUQ_OP_0 0x9810
 #define R_AX_PL_CPUQ_OP_0 0x9830
-- 
2.25.1

