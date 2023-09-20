Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E257A7497
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjITHpL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 03:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjITHo4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 03:44:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EE6CE
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 00:44:49 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38K7iaK83803008, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38K7iaK83803008
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 15:44:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 20 Sep 2023 15:44:35 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 20 Sep
 2023 15:44:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] wifi: rtw89: add subband index of primary channel to struct rtw89_chan
Date:   Wed, 20 Sep 2023 15:43:16 +0800
Message-ID: <20230920074322.42898-2-pkshih@realtek.com>
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

The subband index is a hardware value of relationship between primary
channel and bandwidth, and it is used by setting channel/bandwidth to
specify the primary channel.

Because this index is only needed when bandwidth >= 20 MHz, adjust
order of enumerator bandwidth to access offsets array easier. To prevent
misuse RTW89_CHANNEL_WIDTH_NUM as size, change it to
RTW89_CHANNEL_WIDTH_ORDINARY_NUM that will be the size of array. The
enumerator values of bandwidth (before ordinary number) will be also
used by upcoming TX power table built in firmware file, so add a comment
to remind keeping the order.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 12 +++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index fb68d7f8ec3a..85c25213bf02 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -87,6 +87,19 @@ static enum rtw89_sc_offset rtw89_get_primary_chan_idx(enum rtw89_bandwidth bw,
 	return primary_chan_idx;
 }
 
+static u8 rtw89_get_primary_sb_idx(u8 central_ch, u8 pri_ch,
+				   enum rtw89_bandwidth bw)
+{
+	static const u8 prisb_cal_ofst[RTW89_CHANNEL_WIDTH_ORDINARY_NUM] = {
+		0, 2, 6, 14, 30
+	};
+
+	if (bw >= RTW89_CHANNEL_WIDTH_ORDINARY_NUM)
+		return 0;
+
+	return (prisb_cal_ofst[bw] + pri_ch - central_ch) / 4;
+}
+
 void rtw89_chan_create(struct rtw89_chan *chan, u8 center_chan, u8 primary_chan,
 		       enum rtw89_band band, enum rtw89_bandwidth bandwidth)
 {
@@ -106,6 +119,8 @@ void rtw89_chan_create(struct rtw89_chan *chan, u8 center_chan, u8 primary_chan,
 	chan->subband_type = rtw89_get_subband_type(band, center_chan);
 	chan->pri_ch_idx = rtw89_get_primary_chan_idx(bandwidth, center_freq,
 						      primary_freq);
+	chan->pri_sb_idx = rtw89_get_primary_sb_idx(center_chan, primary_chan,
+						    bandwidth);
 }
 
 bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 08fa83995e17..cafc1e09f4d6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -841,9 +841,14 @@ enum rtw89_bandwidth {
 	RTW89_CHANNEL_WIDTH_40	= 1,
 	RTW89_CHANNEL_WIDTH_80	= 2,
 	RTW89_CHANNEL_WIDTH_160	= 3,
-	RTW89_CHANNEL_WIDTH_80_80	= 4,
-	RTW89_CHANNEL_WIDTH_5	= 5,
-	RTW89_CHANNEL_WIDTH_10	= 6,
+	RTW89_CHANNEL_WIDTH_320	= 4,
+
+	/* keep index order above */
+	RTW89_CHANNEL_WIDTH_ORDINARY_NUM = 5,
+
+	RTW89_CHANNEL_WIDTH_80_80 = 5,
+	RTW89_CHANNEL_WIDTH_5 = 6,
+	RTW89_CHANNEL_WIDTH_10 = 7,
 };
 
 enum rtw89_ps_mode {
@@ -898,6 +903,7 @@ struct rtw89_chan {
 	u32 freq;
 	enum rtw89_subband subband_type;
 	enum rtw89_sc_offset pri_ch_idx;
+	u8 pri_sb_idx;
 };
 
 struct rtw89_chan_rcd {
-- 
2.25.1

