Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA557664B2
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjG1HDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 03:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjG1HDh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 03:03:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16B4619AF
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 00:03:35 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36S73HKy8031384, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36S73HKy8031384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 28 Jul 2023 15:03:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 28 Jul 2023 15:03:29 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 28 Jul
 2023 15:03:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 05/10] wifi: rtw89: add H2C RA command V1 to support WiFi 7 chips
Date:   Fri, 28 Jul 2023 15:02:47 +0800
Message-ID: <20230728070252.66525-6-pkshih@realtek.com>
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

H2C RA V1 command adds two words to support WiFi 7 chips, which can
possibly support up to 4SS rates. Because current chips have only 2SS
rates, leave the fields blank for now. The main changes are to set
extended bits of EHT mode and bandwidth -- add a bit for EHT mode; add a
bit to enumerate 320MHz channel bandwidth.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  5 +++--
 drivers/net/wireless/realtek/rtw89/fw.c   | 18 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h   | 11 +++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 81643a9b4e85f..43e02a28e4cd4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2700,9 +2700,10 @@ struct rtw89_ra_info {
 	 * Bit2 : HT
 	 * Bit3 : VHT
 	 * Bit4 : HE
+	 * Bit5 : EHT
 	 */
-	u8 mode_ctrl:5;
-	u8 bw_cap:2;
+	u8 mode_ctrl:6;
+	u8 bw_cap:3; /* enum rtw89_bandwidth */
 	u8 macid;
 	u8 dcm_cap:1;
 	u8 er_cap:1;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c2dc5c98c73dc..b27734036fb6d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1905,11 +1905,19 @@ int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi)
 {
-	struct sk_buff *skb;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_h2c_ra_v1 *h2c_v1;
 	struct rtw89_h2c_ra *h2c;
 	u32 len = sizeof(*h2c);
+	bool format_v1 = false;
+	struct sk_buff *skb;
 	int ret;
 
+	if (chip->chip_gen == RTW89_CHIP_BE) {
+		len = sizeof(*h2c_v1);
+		format_v1 = true;
+	}
+
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c join\n");
@@ -1939,6 +1947,14 @@ int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi
 	h2c->w3 = le32_encode_bits(ra->fix_giltf_en, RTW89_H2C_RA_W3_FIX_GILTF_EN) |
 		  le32_encode_bits(ra->fix_giltf, RTW89_H2C_RA_W3_FIX_GILTF);
 
+	if (!format_v1)
+		goto csi;
+
+	h2c_v1 = (struct rtw89_h2c_ra_v1 *)h2c;
+	h2c_v1->w4 = le32_encode_bits(ra->mode_ctrl, RTW89_H2C_RA_V1_W4_MODE_EHT) |
+		     le32_encode_bits(ra->bw_cap, RTW89_H2C_RA_V1_W4_BW_EHT);
+
+csi:
 	if (!csi)
 		goto done;
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 5e7f528c71e7c..831dbe6023935 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -327,6 +327,17 @@ struct rtw89_h2c_ra {
 #define RTW89_H2C_RA_W3_FIXED_CSI_GI_LTF GENMASK(28, 26)
 #define RTW89_H2C_RA_W3_FIXED_CSI_BW GENMASK(31, 29)
 
+struct rtw89_h2c_ra_v1 {
+	struct rtw89_h2c_ra v0;
+	__le32 w4;
+	__le32 w5;
+} __packed;
+
+#define RTW89_H2C_RA_V1_W4_MODE_EHT GENMASK(6, 0)
+#define RTW89_H2C_RA_V1_W4_BW_EHT GENMASK(10, 8)
+#define RTW89_H2C_RA_V1_W4_RAMASK_UHL16 GENMASK(31, 16)
+#define RTW89_H2C_RA_V1_W5_RAMASK_UHH16 GENMASK(15, 0)
+
 static inline void RTW89_SET_FWCMD_SEC_IDX(void *cmd, u32 val)
 {
 	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(7, 0));
-- 
2.25.1

