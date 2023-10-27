Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE3E7D8CEC
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 03:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjJ0B4s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 21:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345109AbjJ0B4r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 21:56:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D632AB
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 18:56:44 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39R1ubl173466053, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39R1ubl173466053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 09:56:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 27 Oct 2023 09:55:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 27 Oct
 2023 09:51:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/4] wifi: rtw89: configure PPDU max user by chip
Date:   Fri, 27 Oct 2023 09:50:57 +0800
Message-ID: <20231027015059.10032-3-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Different chip can support different max user in one PPDU report.
So, we now configure it in chip info.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 6 ++++--
 drivers/net/wireless/realtek/rtw89/core.h     | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 6 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4bfb4188de72..6a70c035b22e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1407,6 +1407,7 @@ static int rtw89_core_rx_process_mac_ppdu(struct rtw89_dev *rtwdev,
 					  struct sk_buff *skb,
 					  struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_rxinfo *rxinfo = (const struct rtw89_rxinfo *)skb->data;
 	bool rx_cnt_valid = false;
 	u8 plcp_size = 0;
@@ -1416,8 +1417,9 @@ static int rtw89_core_rx_process_mac_ppdu(struct rtw89_dev *rtwdev,
 	rx_cnt_valid = le32_get_bits(rxinfo->w0, RTW89_RXINFO_W0_RX_CNT_VLD);
 	plcp_size = le32_get_bits(rxinfo->w1, RTW89_RXINFO_W1_PLCP_LEN) << 3;
 	usr_num = le32_get_bits(rxinfo->w0, RTW89_RXINFO_W0_USR_NUM);
-	if (usr_num > RTW89_PPDU_MAX_USR) {
-		rtw89_warn(rtwdev, "Invalid user number in mac info\n");
+	if (usr_num > chip->ppdu_max_usr) {
+		rtw89_warn(rtwdev, "Invalid user number (%d) in mac info\n",
+			   usr_num);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 91e4d4e79eea..2eb29ea9ff7b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2815,7 +2815,6 @@ struct rtw89_ra_info {
 	u8 csi_bw:3;
 };
 
-#define RTW89_PPDU_MAX_USR 4
 #define RTW89_PPDU_MAC_INFO_USR_SIZE 4
 #define RTW89_PPDU_MAC_INFO_SIZE 8
 #define RTW89_PPDU_MAC_RX_CNT_SIZE 96
@@ -3644,6 +3643,7 @@ struct rtw89_chip_info {
 	u8 bacam_num;
 	u8 bacam_dynamic_num;
 	enum rtw89_bacam_ver bacam_ver;
+	u8 ppdu_max_usr;
 
 	u8 sec_ctrl_efuse_size;
 	u32 physical_efuse_size;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 50522ff85003..ffc464b2ac10 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2393,6 +2393,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.bacam_num		= 2,
 	.bacam_dynamic_num	= 4,
 	.bacam_ver		= RTW89_BACAM_V0,
+	.ppdu_max_usr		= 4,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 2048,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 0c36e6180e25..0d6f87b900d5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2129,6 +2129,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.bacam_num		= 2,
 	.bacam_dynamic_num	= 4,
 	.bacam_ver		= RTW89_BACAM_V0,
+	.ppdu_max_usr		= 4,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 1536,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 9d4e6f08218d..62c2feab569c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2563,6 +2563,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.bacam_num		= 2,
 	.bacam_dynamic_num	= 4,
 	.bacam_ver		= RTW89_BACAM_V0,
+	.ppdu_max_usr		= 4,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 2048,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 3b7d8ab39bab..7bb5d359a06a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2877,6 +2877,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.bacam_num		= 8,
 	.bacam_dynamic_num	= 8,
 	.bacam_ver		= RTW89_BACAM_V0_EXT,
+	.ppdu_max_usr		= 8,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 2048,
-- 
2.25.1

