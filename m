Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979067C626E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 03:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjJLBtm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 21:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjJLBtl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 21:49:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660D4B7
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 18:49:36 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39C1nSo95585703, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39C1nSo95585703
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 09:49:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 12 Oct 2023 09:49:28 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 12 Oct
 2023 09:49:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: mac: update RTS threshold according to chip gen
Date:   Thu, 12 Oct 2023 09:48:57 +0800
Message-ID: <20231012014902.18523-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012014902.18523-1-pkshih@realtek.com>
References: <20231012014902.18523-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

When TX size or time of packet over RTS threshold set by this register,
hardware will use RTS protection automatically. Since WiFi 6 and 7 chips
have different register address for this, separate the address according
to chip gen.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 4 +++-
 drivers/net/wireless/realtek/rtw89/mac.h    | 1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 1 +
 drivers/net/wireless/realtek/rtw89/reg.h    | 6 ++++++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f1d14e84cda7..4587bd596c32 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4840,6 +4840,7 @@ void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx)
 #define MAC_AX_LEN_TH_MAX  255
 #define MAC_AX_TIME_TH_DEF 88
 #define MAC_AX_LEN_TH_DEF  4080
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	u32 rts_threshold = hw->wiphy->rts_threshold;
 	u32 time_th, len_th;
@@ -4856,7 +4857,7 @@ void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx)
 	time_th = min_t(u32, time_th >> MAC_AX_TIME_TH_SH, MAC_AX_TIME_TH_MAX);
 	len_th = min_t(u32, len_th >> MAC_AX_LEN_TH_SH, MAC_AX_LEN_TH_MAX);
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_AGG_LEN_HT_0, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, mac->agg_len_ht, mac_idx);
 	rtw89_write16_mask(rtwdev, reg, B_AX_RTS_TXTIME_TH_MASK, time_th);
 	rtw89_write16_mask(rtwdev, reg, B_AX_RTS_LEN_TH_MASK, len_th);
 }
@@ -5751,6 +5752,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.mem_base_addrs = rtw89_mac_mem_base_addrs_ax,
 	.rx_fltr = R_AX_RX_FLTR_OPT,
 	.port_base = &rtw89_port_base_ax,
+	.agg_len_ht = R_AX_AGG_LEN_HT_0,
 
 	.disable_cpu = rtw89_mac_disable_cpu_ax,
 	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 617fd2aea776..b318027a977f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -859,6 +859,7 @@ struct rtw89_mac_gen_def {
 	const u32 *mem_base_addrs;
 	u32 rx_fltr;
 	const struct rtw89_port_reg *port_base;
+	u32 agg_len_ht;
 
 	void (*disable_cpu)(struct rtw89_dev *rtwdev);
 	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason,
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 8af71d8a659a..6c277b6b25b8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -250,6 +250,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.mem_base_addrs = rtw89_mac_mem_base_addrs_be,
 	.rx_fltr = R_BE_RX_FLTR_OPT,
 	.port_base = &rtw89_port_base_be,
+	.agg_len_ht = R_BE_AGG_LEN_HT_0,
 
 	.disable_cpu = rtw89_mac_disable_cpu_be,
 	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 95cdee52fdc8..8c148d6041d0 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3894,6 +3894,12 @@
 #define R_BE_PORT_HGQ_WINDOW_CFG 0x105A0
 #define R_BE_PORT_HGQ_WINDOW_CFG_C1 0x145A0
 
+#define R_BE_AGG_LEN_HT_0 0x10814
+#define R_BE_AGG_LEN_HT_0_C1 0x14814
+#define B_BE_AMPDU_MAX_LEN_HT_MASK GENMASK(31, 16)
+#define B_BE_RTS_TXTIME_TH_MASK GENMASK(15, 8)
+#define B_BE_RTS_LEN_TH_MASK GENMASK(7, 0)
+
 #define R_BE_MBSSID_DROP_0 0x1083C
 #define R_BE_MBSSID_DROP_0_C1 0x1483C
 #define B_BE_GI_LTF_FB_SEL BIT(30)
-- 
2.25.1

