Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375127A749D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 09:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjITHpS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbjITHpA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 03:45:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7ACED
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 00:44:52 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38K7idEC3803259, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38K7idEC3803259
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 15:44:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 20 Sep 2023 15:44:39 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 20 Sep
 2023 15:44:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw89: phy: refine helpers used for raw TX power
Date:   Wed, 20 Sep 2023 15:43:19 +0800
Message-ID: <20230920074322.42898-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920074322.42898-1-pkshih@realtek.com>
References: <20230920074322.42898-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, these helpers were implemented by macros. We rewrite them
by normal functions. In the new function to seek raw TX power by rate,
we access the array according to rate section and discard the original
pointer arithmetic.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c  | 77 ++++++++++++-----------
 2 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 62b0cdecb0f7..71ed4d59ef53 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -718,6 +718,7 @@ struct rtw89_txpwr_byrate {
 	s8 mcs[RTW89_NSS_NUM][RTW89_RATE_MCS_NUM];
 	s8 hedcm[RTW89_NSS_HEDCM_NUM][RTW89_RATE_HEDCM_NUM];
 	s8 offset[RTW89_RATE_OFFSET_NUM];
+	s8 trap;
 };
 
 enum rtw89_bandwidth_section_num {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d9f56c510eed..f86de8c8ce18 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1535,68 +1535,75 @@ static const u8 rtw89_rs_nss_num[] = {
 	[RTW89_RS_OFFSET] = 1,
 };
 
-static const u8 _byr_of_rs[] = {
-	[RTW89_RS_CCK] = offsetof(struct rtw89_txpwr_byrate, cck),
-	[RTW89_RS_OFDM] = offsetof(struct rtw89_txpwr_byrate, ofdm),
-	[RTW89_RS_MCS] = offsetof(struct rtw89_txpwr_byrate, mcs),
-	[RTW89_RS_HEDCM] = offsetof(struct rtw89_txpwr_byrate, hedcm),
-	[RTW89_RS_OFFSET] = offsetof(struct rtw89_txpwr_byrate, offset),
-};
-
-#define _byr_seek(rs, raw) ((s8 *)(raw) + _byr_of_rs[rs])
-#define _byr_idx(rs, nss, idx) ((nss) * rtw89_rs_idx_num[rs] + (idx))
-#define _byr_chk(rs, nss, idx) \
-	((nss) < rtw89_rs_nss_num[rs] && (idx) < rtw89_rs_idx_num[rs])
+static
+s8 *rtw89_phy_raw_byr_seek(struct rtw89_dev *rtwdev,
+			   struct rtw89_txpwr_byrate *head,
+			   const struct rtw89_rate_desc *desc)
+{
+	switch (desc->rs) {
+	case RTW89_RS_CCK:
+		return &head->cck[desc->idx];
+	case RTW89_RS_OFDM:
+		return &head->ofdm[desc->idx];
+	case RTW89_RS_MCS:
+		return &head->mcs[desc->nss][desc->idx];
+	case RTW89_RS_HEDCM:
+		return &head->hedcm[desc->nss][desc->idx];
+	case RTW89_RS_OFFSET:
+		return &head->offset[desc->idx];
+	default:
+		rtw89_warn(rtwdev, "unrecognized byr rs: %d\n", desc->rs);
+		return &head->trap;
+	}
+}
 
 void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 				 const struct rtw89_txpwr_table *tbl)
 {
 	const struct rtw89_txpwr_byrate_cfg *cfg = tbl->data;
 	const struct rtw89_txpwr_byrate_cfg *end = cfg + tbl->size;
+	struct rtw89_txpwr_byrate *byr_head;
+	struct rtw89_rate_desc desc = {};
 	s8 *byr;
 	u32 data;
-	u8 i, idx;
+	u8 i;
 
 	for (; cfg < end; cfg++) {
-		byr = _byr_seek(cfg->rs, &rtwdev->byr[cfg->band]);
+		byr_head = &rtwdev->byr[cfg->band];
+		desc.rs = cfg->rs;
+		desc.nss = cfg->nss;
 		data = cfg->data;
 
 		for (i = 0; i < cfg->len; i++, data >>= 8) {
-			idx = _byr_idx(cfg->rs, cfg->nss, (cfg->shf + i));
-			byr[idx] = (s8)(data & 0xff);
+			desc.idx = cfg->shf + i;
+			byr = rtw89_phy_raw_byr_seek(rtwdev, byr_head, &desc);
+			*byr = data & 0xff;
 		}
 	}
 }
 EXPORT_SYMBOL(rtw89_phy_load_txpwr_byrate);
 
-#define _phy_txpwr_rf_to_mac(rtwdev, txpwr_rf)				\
-({									\
-	const struct rtw89_chip_info *__c = (rtwdev)->chip;		\
-	(txpwr_rf) >> (__c->txpwr_factor_rf - __c->txpwr_factor_mac);	\
-})
+static s8 rtw89_phy_txpwr_rf_to_mac(struct rtw89_dev *rtwdev, s8 txpwr_rf)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return txpwr_rf >> (chip->txpwr_factor_rf - chip->txpwr_factor_mac);
+}
 
 static
 s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band,
 			       const struct rtw89_rate_desc *rate_desc)
 {
+	struct rtw89_txpwr_byrate *byr_head;
 	s8 *byr;
-	u8 idx;
 
 	if (rate_desc->rs == RTW89_RS_CCK)
 		band = RTW89_BAND_2G;
 
-	if (!_byr_chk(rate_desc->rs, rate_desc->nss, rate_desc->idx)) {
-		rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
-			    "[TXPWR] unknown byrate desc rs=%d nss=%d idx=%d\n",
-			    rate_desc->rs, rate_desc->nss, rate_desc->idx);
-
-		return 0;
-	}
-
-	byr = _byr_seek(rate_desc->rs, &rtwdev->byr[band]);
-	idx = _byr_idx(rate_desc->rs, rate_desc->nss, rate_desc->idx);
+	byr_head = &rtwdev->byr[band];
+	byr = rtw89_phy_raw_byr_seek(rtwdev, byr_head, rate_desc);
 
-	return _phy_txpwr_rf_to_mac(rtwdev, byr[idx]);
+	return rtw89_phy_txpwr_rf_to_mac(rtwdev, *byr);
 }
 
 static u8 rtw89_channel_6g_to_idx(struct rtw89_dev *rtwdev, u8 channel_6g)
@@ -1688,7 +1695,7 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 		return 0;
 	}
 
-	lmt = _phy_txpwr_rf_to_mac(rtwdev, lmt);
+	lmt = rtw89_phy_txpwr_rf_to_mac(rtwdev, lmt);
 	sar = rtw89_query_sar(rtwdev, freq);
 
 	return min(lmt, sar);
@@ -1945,7 +1952,7 @@ static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 		return 0;
 	}
 
-	lmt_ru = _phy_txpwr_rf_to_mac(rtwdev, lmt_ru);
+	lmt_ru = rtw89_phy_txpwr_rf_to_mac(rtwdev, lmt_ru);
 	sar = rtw89_query_sar(rtwdev, freq);
 
 	return min(lmt_ru, sar);
-- 
2.25.1

