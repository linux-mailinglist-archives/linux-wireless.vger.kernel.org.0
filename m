Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5097664B4
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 09:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjG1HDp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 03:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjG1HDn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 03:03:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6D062118
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 00:03:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36S73MVl8031409, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36S73MVl8031409
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 28 Jul 2023 15:03:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 28 Jul 2023 15:03:35 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 28 Jul
 2023 15:03:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 09/10] wifi: rtw89: add to display hardware rates v1 histogram in debugfs
Date:   Fri, 28 Jul 2023 15:02:51 +0800
Message-ID: <20230728070252.66525-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728070252.66525-1-pkshih@realtek.com>
References: <20230728070252.66525-1-pkshih@realtek.com>
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

The upcoming WiFi 7 chips support EHT rates, and hardware rate codes are
changed too, so modify to adapt the changes. (EHT counters are still zeros
in below example)

RX count:
   Legacy: [0, 0, 0, 0]
     OFDM: [0, 0, 0, 0, 0, 0, 0, 0]
     HT 0: [0, 0, 0, 0, 0, 0, 0, 0]
     HT 1: [0, 0, 0, 0, 0, 0, 0, 0]
  VHT 1SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0][0, 0]
  VHT 2SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0][0, 0]
   HE 1SS: [0, 0, 42, 0, 43, 90, 75, 0, 26, 20, 260, 7]
   HE 2SS: [0, 96, 232, 84, 125, 184, 52, 0, 0, 0, 0, 0]
  EHT 1SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0][0, 0]
  EHT 2SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  |  1 +
 drivers/net/wireless/realtek/rtw89/debug.c | 35 +++++++++++++++-------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 24c1097467885..f3f7abddd3c0b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -584,6 +584,7 @@ enum rtw89_hw_rate {
 	RTW89_HW_RATE_V1_EHT_NSS4_MCS13	= 0x46D,
 
 	RTW89_HW_RATE_NR,
+	RTW89_HW_RATE_INVAL,
 
 	RTW89_HW_RATE_MASK_MOD = GENMASK(8, 7),
 	RTW89_HW_RATE_MASK_VAL = GENMASK(6, 0),
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index ce5a9ac081457..f67af8aa2358f 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3325,20 +3325,26 @@ rtw89_debug_append_rx_rate(struct seq_file *m, struct rtw89_pkt_stat *pkt_stat,
 			   pkt_stat->rx_rate_cnt[first_rate + i]);
 }
 
+#define FIRST_RATE_SAME(rate) {RTW89_HW_RATE_ ## rate, RTW89_HW_RATE_ ## rate}
+#define FIRST_RATE_ENUM(rate) {RTW89_HW_RATE_ ## rate, RTW89_HW_RATE_V1_ ## rate}
+#define FIRST_RATE_GEV1(rate) {RTW89_HW_RATE_INVAL, RTW89_HW_RATE_V1_ ## rate}
+
 static const struct rtw89_rx_rate_cnt_info {
-	enum rtw89_hw_rate first_rate;
+	enum rtw89_hw_rate first_rate[RTW89_CHIP_GEN_NUM];
 	int len;
 	int ext;
 	const char *rate_mode;
 } rtw89_rx_rate_cnt_infos[] = {
-	{RTW89_HW_RATE_CCK1, 4, 0, "Legacy:"},
-	{RTW89_HW_RATE_OFDM6, 8, 0, "OFDM:"},
-	{RTW89_HW_RATE_MCS0, 8, 0, "HT 0:"},
-	{RTW89_HW_RATE_MCS8, 8, 0, "HT 1:"},
-	{RTW89_HW_RATE_VHT_NSS1_MCS0, 10, 2, "VHT 1SS:"},
-	{RTW89_HW_RATE_VHT_NSS2_MCS0, 10, 2, "VHT 2SS:"},
-	{RTW89_HW_RATE_HE_NSS1_MCS0, 12, 0, "HE 1SS:"},
-	{RTW89_HW_RATE_HE_NSS2_MCS0, 12, 0, "HE 2ss:"},
+	{FIRST_RATE_SAME(CCK1), 4, 0, "Legacy:"},
+	{FIRST_RATE_SAME(OFDM6), 8, 0, "OFDM:"},
+	{FIRST_RATE_ENUM(MCS0), 8, 0, "HT 0:"},
+	{FIRST_RATE_ENUM(MCS8), 8, 0, "HT 1:"},
+	{FIRST_RATE_ENUM(VHT_NSS1_MCS0), 10, 2, "VHT 1SS:"},
+	{FIRST_RATE_ENUM(VHT_NSS2_MCS0), 10, 2, "VHT 2SS:"},
+	{FIRST_RATE_ENUM(HE_NSS1_MCS0), 12, 0, "HE 1SS:"},
+	{FIRST_RATE_ENUM(HE_NSS2_MCS0), 12, 0, "HE 2SS:"},
+	{FIRST_RATE_GEV1(EHT_NSS1_MCS0), 14, 2, "EHT 1SS:"},
+	{FIRST_RATE_GEV1(EHT_NSS2_MCS0), 14, 0, "EHT 2SS:"},
 };
 
 static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
@@ -3347,7 +3353,9 @@ static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_traffic_stats *stats = &rtwdev->stats;
 	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.last_pkt_stat;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_rx_rate_cnt_info *info;
+	enum rtw89_hw_rate first_rate;
 	int i;
 
 	seq_printf(m, "TP TX: %u [%u] Mbps (lv: %d), RX: %u [%u] Mbps (lv: %d)\n",
@@ -3359,15 +3367,20 @@ static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
 		   stats->rx_avg_len);
 
 	seq_puts(m, "RX count:\n");
+
 	for (i = 0; i < ARRAY_SIZE(rtw89_rx_rate_cnt_infos); i++) {
 		info = &rtw89_rx_rate_cnt_infos[i];
+		first_rate = info->first_rate[chip->chip_gen];
+		if (first_rate >= RTW89_HW_RATE_NR)
+			continue;
+
 		seq_printf(m, "%10s [", info->rate_mode);
 		rtw89_debug_append_rx_rate(m, pkt_stat,
-					   info->first_rate, info->len);
+					   first_rate, info->len);
 		if (info->ext) {
 			seq_puts(m, "][");
 			rtw89_debug_append_rx_rate(m, pkt_stat,
-						   info->first_rate + info->len, info->ext);
+						   first_rate + info->len, info->ext);
 		}
 		seq_puts(m, "]\n");
 	}
-- 
2.25.1

