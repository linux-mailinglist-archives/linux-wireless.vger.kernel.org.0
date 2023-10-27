Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEF37D8CEE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 03:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbjJ0B4w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 21:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345120AbjJ0B4v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 21:56:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1905AB
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 18:56:48 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39R1ufl173466053, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39R1ufl173466053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 09:56:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 27 Oct 2023 09:55:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 27 Oct
 2023 09:51:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 4/4] wifi: rtw89: extend PHY status parser to support WiFi 7 chips
Date:   Fri, 27 Oct 2023 09:50:59 +0800
Message-ID: <20231027015059.10032-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027015059.10032-1-pkshih@realtek.com>
References: <20231027015059.10032-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
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

PHY status IEs is used to have more information about received packets,
such as RSSI and EVM. For each PHY IE type, it has different predefined
PHY IE length, and the length are changed, so add them for WiFi 7 chips
accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index ac99434c0e66..554191086336 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1513,14 +1513,24 @@ static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
 static u16 rtw89_core_get_phy_status_ie_len(struct rtw89_dev *rtwdev,
 					    const struct rtw89_phy_sts_iehdr *iehdr)
 {
-	static const u8 physts_ie_len_tab[32] = {
-		16, 32, 24, 24, 8, 8, 8, 8, VAR_LEN, 8, VAR_LEN, 176, VAR_LEN,
-		VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, 16, 24, VAR_LEN,
-		VAR_LEN, VAR_LEN, 0, 24, 24, 24, 24, 32, 32, 32, 32
+	static const u8 physts_ie_len_tabs[RTW89_CHIP_GEN_NUM][32] = {
+		[RTW89_CHIP_AX] = {
+			16, 32, 24, 24, 8, 8, 8, 8, VAR_LEN, 8, VAR_LEN, 176, VAR_LEN,
+			VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, 16, 24, VAR_LEN,
+			VAR_LEN, VAR_LEN, 0, 24, 24, 24, 24, 32, 32, 32, 32
+		},
+		[RTW89_CHIP_BE] = {
+			32, 40, 24, 24, 8, 8, 8, 8, VAR_LEN, 8, VAR_LEN, 176, VAR_LEN,
+			VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, 16, 24, VAR_LEN,
+			VAR_LEN, VAR_LEN, 0, 24, 24, 24, 24, 32, 32, 32, 32
+		},
 	};
+	const u8 *physts_ie_len_tab;
 	u16 ie_len;
 	u8 ie;
 
+	physts_ie_len_tab = physts_ie_len_tabs[rtwdev->chip->chip_gen];
+
 	ie = le32_get_bits(iehdr->w0, RTW89_PHY_STS_IEHDR_TYPE);
 	if (physts_ie_len_tab[ie] != VAR_LEN)
 		ie_len = physts_ie_len_tab[ie];
@@ -1607,6 +1617,9 @@ static int rtw89_core_rx_process_phy_ppdu(struct rtw89_dev *rtwdev,
 
 	len_from_header = le32_get_bits(hdr->w0, RTW89_PHY_STS_HDR_W0_LEN) << 3;
 
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
+		len_from_header += PHY_STS_HDR_LEN;
+
 	if (len_from_header != phy_ppdu->len) {
 		rtw89_debug(rtwdev, RTW89_DBG_UNEXP, "phy ppdu len mismatch\n");
 		return -EINVAL;
-- 
2.25.1

