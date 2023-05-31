Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178DA7176AB
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 08:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjEaGI2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 02:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjEaGIK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 02:08:10 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0133BE66
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 23:07:48 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34V67RjA4025674, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34V67RjA4025674
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 31 May 2023 14:07:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 31 May 2023 14:07:40 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 31 May
 2023 14:07:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: debug: txpwr table access only valid page according to chip
Date:   Wed, 31 May 2023 14:07:11 +0800
Message-ID: <20230531060713.57203-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531060713.57203-1-pkshih@realtek.com>
References: <20230531060713.57203-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

We now support RTL8851B which has only single RF path. For chip with
single RF path, TX power page is valid only in single path section.
So, we refine debugfs txpwr table to access TX power page according
to RF path number of runtime chip. It can prevent us from reading
beyond valid sections.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 13 ++++++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h   |  6 ++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 39f6b7f5f6563..1db2d59d33ff7 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -376,6 +376,7 @@ struct txpwr_map {
 	u8 size;
 	u32 addr_from;
 	u32 addr_to;
+	u32 addr_to_1ss;
 };
 
 #define __GEN_TXPWR_ENT2(_t, _e0, _e1) \
@@ -413,6 +414,7 @@ static const struct txpwr_map __txpwr_map_byr = {
 	.size = ARRAY_SIZE(__txpwr_ent_byr),
 	.addr_from = R_AX_PWR_BY_RATE,
 	.addr_to = R_AX_PWR_BY_RATE_MAX,
+	.addr_to_1ss = R_AX_PWR_BY_RATE_1SS_MAX,
 };
 
 static const struct txpwr_ent __txpwr_ent_lmt[] = {
@@ -468,6 +470,7 @@ static const struct txpwr_map __txpwr_map_lmt = {
 	.size = ARRAY_SIZE(__txpwr_ent_lmt),
 	.addr_from = R_AX_PWR_LMT,
 	.addr_to = R_AX_PWR_LMT_MAX,
+	.addr_to_1ss = R_AX_PWR_LMT_1SS_MAX,
 };
 
 static const struct txpwr_ent __txpwr_ent_lmt_ru[] = {
@@ -495,6 +498,7 @@ static const struct txpwr_map __txpwr_map_lmt_ru = {
 	.size = ARRAY_SIZE(__txpwr_ent_lmt_ru),
 	.addr_from = R_AX_PWR_RU_LMT,
 	.addr_to = R_AX_PWR_RU_LMT_MAX,
+	.addr_to_1ss = R_AX_PWR_RU_LMT_1SS_MAX,
 };
 
 static u8 __print_txpwr_ent(struct seq_file *m, const struct txpwr_ent *ent,
@@ -527,6 +531,8 @@ static int __print_txpwr_map(struct seq_file *m, struct rtw89_dev *rtwdev,
 			     const struct txpwr_map *map)
 {
 	u8 fct = rtwdev->chip->txpwr_factor_mac;
+	u8 path_num = rtwdev->chip->rf_path_num;
+	u32 max_valid_addr;
 	u32 val, addr;
 	s8 *buf, tmp;
 	u8 cur, i;
@@ -536,7 +542,12 @@ static int __print_txpwr_map(struct seq_file *m, struct rtw89_dev *rtwdev,
 	if (!buf)
 		return -ENOMEM;
 
-	for (addr = map->addr_from; addr <= map->addr_to; addr += 4) {
+	if (path_num == 1)
+		max_valid_addr = map->addr_to_1ss;
+	else
+		max_valid_addr = map->addr_to;
+
+	for (addr = map->addr_from; addr <= max_valid_addr; addr += 4) {
 		ret = rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, addr, &val);
 		if (ret)
 			val = MASKDWORD;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 7c2807345f60d..b6ffa923133d4 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3342,16 +3342,22 @@
 #define B_AX_PWR_UL_TB_2T_MASK GENMASK(4, 0)
 #define B_AX_PWR_UL_TB_2T_V1_MASK GENMASK(7, 0)
 #define R_AX_PWR_BY_RATE_TABLE0 0xD2C0
+#define R_AX_PWR_BY_RATE_TABLE6 0xD2D8
 #define R_AX_PWR_BY_RATE_TABLE10 0xD2E8
 #define R_AX_PWR_BY_RATE R_AX_PWR_BY_RATE_TABLE0
+#define R_AX_PWR_BY_RATE_1SS_MAX R_AX_PWR_BY_RATE_TABLE6
 #define R_AX_PWR_BY_RATE_MAX R_AX_PWR_BY_RATE_TABLE10
 #define R_AX_PWR_LMT_TABLE0 0xD2EC
+#define R_AX_PWR_LMT_TABLE9 0xD310
 #define R_AX_PWR_LMT_TABLE19 0xD338
 #define R_AX_PWR_LMT R_AX_PWR_LMT_TABLE0
+#define R_AX_PWR_LMT_1SS_MAX R_AX_PWR_LMT_TABLE9
 #define R_AX_PWR_LMT_MAX R_AX_PWR_LMT_TABLE19
 #define R_AX_PWR_RU_LMT_TABLE0 0xD33C
+#define R_AX_PWR_RU_LMT_TABLE5 0xD350
 #define R_AX_PWR_RU_LMT_TABLE11 0xD368
 #define R_AX_PWR_RU_LMT R_AX_PWR_RU_LMT_TABLE0
+#define R_AX_PWR_RU_LMT_1SS_MAX R_AX_PWR_RU_LMT_TABLE5
 #define R_AX_PWR_RU_LMT_MAX R_AX_PWR_RU_LMT_TABLE11
 #define R_AX_PWR_MACID_LMT_TABLE0 0xD36C
 #define R_AX_PWR_MACID_LMT_TABLE127 0xD568
-- 
2.25.1

