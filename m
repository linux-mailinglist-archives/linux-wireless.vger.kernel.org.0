Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71FD7980D9
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 05:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbjIHDNF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 23:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjIHDND (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 23:13:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0B61BD9
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 20:12:57 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3883CmUP21359316, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3883CmUP21359316
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 11:12:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 8 Sep 2023 11:12:49 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 8 Sep 2023
 11:12:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/8] wifi: rtw89: 52c: rfk: refine MCC channel info notification
Date:   Fri, 8 Sep 2023 11:11:38 +0800
Message-ID: <20230908031145.20931-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908031145.20931-1-pkshih@realtek.com>
References: <20230908031145.20931-1-pkshih@realtek.com>
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

RF calibration will notify FW to backup the calibration result after it
is done on a channel. For MCC (multi-channel concurrency) flow, when we
at RTW89_ENTITY_MODE_MCC_PREPARE mode, RF calibration should execute on
second channel of MCC, i.e. RTW89_SUB_ENTITY_1, and then, notify FW to
backup the result for the second one.

Originally, the RF calibration flow only fit single channel case. We are
planning to support MCC on RTL8852C, so we refine its RF calibration flow
to fit MCC case.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c       |  7 +--
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 51 +++++++++++++++----
 2 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index dc951cf95576..0f6ac26870b5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3220,11 +3220,11 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 
 int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
 	struct rtw89_fw_h2c_rf_get_mccch *mccch;
 	struct sk_buff *skb;
 	int ret;
+	u8 idx;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, sizeof(*mccch));
 	if (!skb) {
@@ -3234,12 +3234,13 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 	skb_put(skb, sizeof(*mccch));
 	mccch = (struct rtw89_fw_h2c_rf_get_mccch *)skb->data;
 
+	idx = rfk_mcc->table_idx;
 	mccch->ch_0 = cpu_to_le32(rfk_mcc->ch[0]);
 	mccch->ch_1 = cpu_to_le32(rfk_mcc->ch[1]);
 	mccch->band_0 = cpu_to_le32(rfk_mcc->band[0]);
 	mccch->band_1 = cpu_to_le32(rfk_mcc->band[1]);
-	mccch->current_channel = cpu_to_le32(chan->channel);
-	mccch->current_band_type = cpu_to_le32(chan->band_type);
+	mccch->current_channel = cpu_to_le32(rfk_mcc->ch[idx]);
+	mccch->current_band_type = cpu_to_le32(rfk_mcc->band[idx]);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_NOTIFY,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 7636368c8659..badd829ecfaa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
 
+#include "chan.h"
 #include "coex.h"
 #include "debug.h"
 #include "phy.h"
@@ -4068,21 +4069,53 @@ void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
 
 void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
-	u8 idx = rfk_mcc->table_idx;
-	int i;
+	DECLARE_BITMAP(map, RTW89_IQK_CHS_NR) = {};
+	const struct rtw89_chan *chan;
+	enum rtw89_entity_mode mode;
+	u8 chan_idx;
+	u8 idx;
+	u8 i;
 
-	for (i = 0; i < RTW89_IQK_CHS_NR; i++) {
-		if (rfk_mcc->ch[idx] == 0)
-			break;
-		if (++idx >= RTW89_IQK_CHS_NR)
-			idx = 0;
+	mode = rtw89_get_entity_mode(rtwdev);
+	switch (mode) {
+	case RTW89_ENTITY_MODE_MCC_PREPARE:
+		chan_idx = RTW89_SUB_ENTITY_1;
+		break;
+	default:
+		chan_idx = RTW89_SUB_ENTITY_0;
+		break;
+	}
+
+	for (i = 0; i <= chan_idx; i++) {
+		chan = rtw89_chan_get(rtwdev, i);
+
+		for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
+			if (rfk_mcc->ch[idx] == chan->channel &&
+			    rfk_mcc->band[idx] == chan->band_type) {
+				if (i != chan_idx) {
+					set_bit(idx, map);
+					break;
+				}
+
+				goto bottom;
+			}
+		}
+	}
+
+	idx = find_first_zero_bit(map, RTW89_IQK_CHS_NR);
+	if (idx == RTW89_IQK_CHS_NR) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "%s: no empty rfk table; force replace the first\n",
+			    __func__);
+		idx = 0;
 	}
 
-	rfk_mcc->table_idx = idx;
 	rfk_mcc->ch[idx] = chan->channel;
 	rfk_mcc->band[idx] = chan->band_type;
+
+bottom:
+	rfk_mcc->table_idx = idx;
 }
 
 void rtw8852c_rck(struct rtw89_dev *rtwdev)
-- 
2.25.1

