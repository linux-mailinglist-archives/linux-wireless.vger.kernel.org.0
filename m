Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479FB69C5F7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 08:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjBTH3B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 02:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBTH3A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 02:29:00 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A882CA14
        for <linux-wireless@vger.kernel.org>; Sun, 19 Feb 2023 23:28:57 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31K72mBZ2025240, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31K72mBZ2025240
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Feb 2023 15:02:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 20 Feb 2023 15:02:52 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Feb
 2023 15:02:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: 8852b: add channel encoding for hw_scan
Date:   Mon, 20 Feb 2023 15:02:00 +0800
Message-ID: <20230220070202.29868-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230220070202.29868-1-pkshih@realtek.com>
References: <20230220070202.29868-1-pkshih@realtek.com>
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

To obtain correct packet frequency for hw_scan, 52b needs to decode
the channel index obtained from hardware. Change the driver related
set channel part as well to make driver/firmware compatible.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index ee8dba7e0074a..499ae0389c715 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1422,6 +1422,7 @@ static void rtw8852b_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89
 {
 	bool cck_en = chan->channel <= 14;
 	u8 pri_ch_idx = chan->pri_ch_idx;
+	u8 band = chan->band_type, chan_idx;
 
 	if (cck_en)
 		rtw8852b_ctrl_sco_cck(rtwdev,  chan->primary_channel);
@@ -1444,8 +1445,8 @@ static void rtw8852b_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89
 				       B_BT_DYN_DC_EST_EN_MSK, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN, 0x0);
 	}
-	rtw89_phy_write32_mask(rtwdev, R_MAC_PIN_SEL, B_CH_IDX_SEG0,
-			       chan->primary_channel);
+	chan_idx = rtw89_encode_chan_idx(rtwdev, chan->primary_channel, band);
+	rtw89_phy_write32_mask(rtwdev, R_MAC_PIN_SEL, B_CH_IDX_SEG0, chan_idx);
 	rtw8852b_5m_mask(rtwdev, chan, phy_idx);
 	rtw8852b_bb_set_pop(rtwdev);
 	rtw8852b_bb_reset_all(rtwdev, phy_idx);
@@ -2299,13 +2300,14 @@ static void rtw8852b_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
 					 struct ieee80211_rx_status *status)
 {
 	u16 chan = phy_ppdu->chan_idx;
-	u8 band;
+	enum nl80211_band band;
+	u8 ch;
 
 	if (chan == 0)
 		return;
 
-	band = chan <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
-	status->freq = ieee80211_channel_to_frequency(chan, band);
+	rtw89_decode_chan_idx(rtwdev, chan, &ch, &band);
+	status->freq = ieee80211_channel_to_frequency(ch, band);
 	status->band = band;
 }
 
-- 
2.25.1

