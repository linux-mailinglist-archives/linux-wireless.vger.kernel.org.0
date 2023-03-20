Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E9C6C0D5A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 10:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjCTJci (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 05:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCTJce (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 05:32:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F08D1ACED
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 02:32:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32K9W51C0018087, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32K9W51C0018087
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Mar 2023 17:32:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 20 Mar 2023 17:32:19 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Mar
 2023 17:32:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: fix incorrect channel info during scan due to ppdu_sts filtering
Date:   Mon, 20 Mar 2023 17:31:12 +0800
Message-ID: <20230320093112.30466-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320093112.30466-1-pkshih@realtek.com>
References: <20230320093112.30466-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

We use ppdu_sts to obtain channel information from hardware, to ensure
that the scan results have correct channel information. However, some of
ppdu_sts that is filtered by the to_self check is also needed for the scan
results. Therefore, we modify the filter part in front of CFO count.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 208fd589ffa25..4485978357615 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1220,6 +1220,10 @@ static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev, u8 *addr,
 	phy_ppdu->chan_idx = RTW89_GET_PHY_STS_IE01_CH_IDX(addr);
 	if (phy_ppdu->rate < RTW89_HW_RATE_OFDM6)
 		return;
+
+	if (!phy_ppdu->to_self)
+		return;
+
 	/* sign conversion for S(12,2) */
 	if (rtwdev->chip->cfo_src_fd)
 		cfo = sign_extend32(RTW89_GET_PHY_STS_IE01_FD_CFO(addr), 11);
@@ -1284,9 +1288,6 @@ static int rtw89_core_rx_parse_phy_sts(struct rtw89_dev *rtwdev,
 	if (phy_ppdu->ie < RTW89_CCK_PKT)
 		return -EINVAL;
 
-	if (!phy_ppdu->to_self)
-		return 0;
-
 	pos = (u8 *)phy_ppdu->buf + PHY_STS_HDR_LEN;
 	end = (u8 *)phy_ppdu->buf + phy_ppdu->len;
 	while (pos < end) {
-- 
2.25.1

