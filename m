Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6039564002F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 07:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiLBGQl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 01:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiLBGQj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 01:16:39 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82479DC853
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 22:16:38 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B26FjU92006317, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B26FjU92006317
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Dec 2022 14:15:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 2 Dec 2022 14:16:31 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 2 Dec 2022
 14:16:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: add mac TSF sync function
Date:   Fri, 2 Dec 2022 14:15:24 +0800
Message-ID: <20221202061527.505668-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221202061527.505668-1-pkshih@realtek.com>
References: <20221202061527.505668-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/02/2022 06:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzIgpFekyCAwMToyMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

If the interface is in AP/P2P GO mode, we adjust the TSF with random
offset to avoid TBTT of different vifs to overlap and collide.
For every new interface added, we adjust the value and resync for all
interfaces.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 44 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h |  2 ++
 drivers/net/wireless/realtek/rtw89/reg.h | 17 +++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d80050c2e9b30..a80690d0bf485 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3913,6 +3913,49 @@ static void rtw89_mac_port_cfg_tbtt_shift(struct rtw89_dev *rtwdev,
 				B_AX_TBTT_SHIFT_OFST_MASK, val);
 }
 
+static void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif,
+				    struct rtw89_vif *rtwvif_src, u8 offset,
+				    int *n_offset)
+{
+	u32 val, reg;
+
+	if (rtwvif->net_type != RTW89_NET_TYPE_AP_MODE || rtwvif == rtwvif_src)
+		return;
+
+	/* adjust offset randomly to avoid beacon conflict */
+	offset = offset - offset / 4 + get_random_u32() % (offset / 2);
+	val = RTW89_PORT_OFFSET_MS_TO_32US((*n_offset)++, offset);
+	reg = rtw89_mac_reg_by_idx(R_AX_PORT0_TSF_SYNC + rtwvif->port * 4,
+				   rtwvif->mac_idx);
+
+	rtw89_write32_mask(rtwdev, reg, B_AX_SYNC_PORT_SRC, rtwvif_src->port);
+	rtw89_write32_mask(rtwdev, reg, B_AX_SYNC_PORT_OFFSET_VAL, val);
+	rtw89_write32_set(rtwdev, reg, B_AX_SYNC_NOW);
+}
+
+static void rtw89_mac_port_tsf_resync_all(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_vif *src = NULL, *tmp;
+	u8 offset = 100, vif_aps = 0;
+	int n_offset = 1;
+
+	rtw89_for_each_rtwvif(rtwdev, tmp) {
+		if (!src || tmp->net_type == RTW89_NET_TYPE_INFRA)
+			src = tmp;
+		if (tmp->net_type == RTW89_NET_TYPE_AP_MODE)
+			vif_aps++;
+	}
+
+	if (vif_aps == 0)
+		return;
+
+	offset /= (vif_aps + 1);
+
+	rtw89_for_each_rtwvif(rtwdev, tmp)
+		rtw89_mac_port_tsf_sync(rtwdev, tmp, src, offset, &n_offset);
+}
+
 int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	int ret;
@@ -3991,6 +4034,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif);
+	rtw89_mac_port_tsf_resync_all(rtwdev);
 	fsleep(BCN_ERLY_SET_DLY);
 	rtw89_mac_port_cfg_bcn_early(rtwdev, rtwvif);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index adb0c86a98d3e..766ca6934d33a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -168,6 +168,8 @@ enum rtw89_mac_ax_l0_to_l1_event {
 	MAC_AX_L0_TO_L1_EVENT_MAX = 15,
 };
 
+#define RTW89_PORT_OFFSET_MS_TO_32US(n, shift_ms) ((n) * (shift_ms) * 1000 / 32)
+
 enum rtw89_mac_dbg_port_sel {
 	/* CMAC 0 related */
 	RTW89_DBG_PORT_SEL_PTCL_C0 = 0,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index f2634062f377d..5324e645728bb 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -2048,6 +2048,23 @@
 #define B_AX_PTCL_TOP_ERR_IND BIT(1)
 #define B_AX_SCHEDULE_TOP_ERR_IND BIT(0)
 
+#define R_AX_PORT0_TSF_SYNC 0xC2A0
+#define R_AX_PORT0_TSF_SYNC_C1 0xE2A0
+#define R_AX_PORT1_TSF_SYNC 0xC2A4
+#define R_AX_PORT1_TSF_SYNC_C1 0xE2A4
+#define R_AX_PORT2_TSF_SYNC 0xC2A8
+#define R_AX_PORT2_TSF_SYNC_C1 0xE2A8
+#define R_AX_PORT3_TSF_SYNC 0xC2AC
+#define R_AX_PORT3_TSF_SYNC_C1 0xE2AC
+#define R_AX_PORT4_TSF_SYNC 0xC2B0
+#define R_AX_PORT4_TSF_SYNC_C1 0xE2B0
+#define B_AX_SYNC_NOW BIT(30)
+#define B_AX_SYNC_ONCE BIT(29)
+#define B_AX_SYNC_AUTO BIT(28)
+#define B_AX_SYNC_PORT_SRC GENMASK(26, 24)
+#define B_AX_SYNC_PORT_OFFSET_SIGN BIT(18)
+#define B_AX_SYNC_PORT_OFFSET_VAL GENMASK(17, 0)
+
 #define R_AX_MACID_SLEEP_0 0xC2C0
 #define R_AX_MACID_SLEEP_0_C1 0xE2C0
 #define B_AX_MACID31_0_SLEEP_SH 0
-- 
2.25.1

