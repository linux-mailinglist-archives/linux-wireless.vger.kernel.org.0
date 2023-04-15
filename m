Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9D46E2EE2
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Apr 2023 05:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDODuX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 23:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDODuU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 23:50:20 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405B459C5
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 20:50:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33F3ngpL7021908, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33F3ngpL7021908
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 15 Apr 2023 11:49:42 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 15 Apr 2023 11:49:38 +0800
Received: from localhost (172.16.20.53) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 15 Apr
 2023 11:49:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/6] wifi: rtw89: use struct instead of macros to set H2C command of hardware scan
Date:   Sat, 15 Apr 2023 11:48:57 +0800
Message-ID: <20230415034900.15679-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230415034900.15679-1-pkshih@realtek.com>
References: <20230415034900.15679-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.53]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

Remove macros that set H2C data. Instead, use struct and
le32_encode_bits() with mask definition to make it clean.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c |  45 ++++++----
 drivers/net/wireless/realtek/rtw89/fw.h | 114 ++++++------------------
 2 files changed, 51 insertions(+), 108 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8a8d166ef04fb..fd82ac8ce75e3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2540,44 +2540,51 @@ int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int len,
 	return ret;
 }
 
-#define H2C_LEN_SCAN_OFFLOAD 28
 int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 			      struct rtw89_scan_option *option,
 			      struct rtw89_vif *rtwvif)
 {
 	struct rtw89_chan *op = &rtwdev->scan_info.op_chan;
+	struct rtw89_h2c_scanofld *h2c;
+	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
-	u8 *cmd;
 	int ret;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_SCAN_OFFLOAD);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c scan offload\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_LEN_SCAN_OFFLOAD);
-	cmd = skb->data;
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_scanofld *)skb->data;
+
+	h2c->w0 = le32_encode_bits(rtwvif->mac_id, RTW89_H2C_SCANOFLD_W0_MACID) |
+		  le32_encode_bits(rtwvif->port, RTW89_H2C_SCANOFLD_W0_PORT_ID) |
+		  le32_encode_bits(RTW89_PHY_0, RTW89_H2C_SCANOFLD_W0_BAND) |
+		  le32_encode_bits(option->enable, RTW89_H2C_SCANOFLD_W0_OPERATION);
+
+	h2c->w1 = le32_encode_bits(true, RTW89_H2C_SCANOFLD_W1_NOTIFY_END) |
+		  le32_encode_bits(option->target_ch_mode,
+				   RTW89_H2C_SCANOFLD_W1_TARGET_CH_MODE) |
+		  le32_encode_bits(RTW89_SCAN_IMMEDIATE,
+				   RTW89_H2C_SCANOFLD_W1_START_MODE) |
+		  le32_encode_bits(RTW89_SCAN_ONCE, RTW89_H2C_SCANOFLD_W1_SCAN_TYPE);
 
-	RTW89_SET_FWCMD_SCANOFLD_MACID(cmd, rtwvif->mac_id);
-	RTW89_SET_FWCMD_SCANOFLD_PORT_ID(cmd, rtwvif->port);
-	RTW89_SET_FWCMD_SCANOFLD_BAND(cmd, RTW89_PHY_0);
-	RTW89_SET_FWCMD_SCANOFLD_OPERATION(cmd, option->enable);
-	RTW89_SET_FWCMD_SCANOFLD_NOTIFY_END(cmd, true);
-	RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_MODE(cmd, option->target_ch_mode);
-	RTW89_SET_FWCMD_SCANOFLD_START_MODE(cmd, RTW89_SCAN_IMMEDIATE);
-	RTW89_SET_FWCMD_SCANOFLD_SCAN_TYPE(cmd, RTW89_SCAN_ONCE);
 	if (option->target_ch_mode) {
-		RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_BW(cmd, op->band_width);
-		RTW89_SET_FWCMD_SCANOFLD_TARGET_PRI_CH(cmd,
-						       op->primary_channel);
-		RTW89_SET_FWCMD_SCANOFLD_TARGET_CENTRAL_CH(cmd, op->channel);
-		RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_BAND(cmd, op->band_type);
+		h2c->w1 |= le32_encode_bits(op->band_width,
+					    RTW89_H2C_SCANOFLD_W1_TARGET_CH_BW) |
+			   le32_encode_bits(op->primary_channel,
+					    RTW89_H2C_SCANOFLD_W1_TARGET_PRI_CH) |
+			   le32_encode_bits(op->channel,
+					    RTW89_H2C_SCANOFLD_W1_TARGET_CENTRAL_CH);
+		h2c->w0 |= le32_encode_bits(op->band_type,
+					    RTW89_H2C_SCANOFLD_W0_TARGET_CH_BAND);
 	}
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
 			      H2C_FUNC_SCANOFLD, 1, 1,
-			      H2C_LEN_SCAN_OFFLOAD);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 5f73b86f54d93..27cf56d855909 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2772,96 +2772,32 @@ static inline void RTW89_SET_FWCMD_CHINFO_POWER_IDX(void *cmd, u32 val)
 	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 16), val, GENMASK(15, 0));
 }
 
-static inline void RTW89_SET_FWCMD_SCANOFLD_MACID(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_NORM_CY(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(15, 8));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_PORT_ID(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(18, 16));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_BAND(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, BIT(19));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_OPERATION(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(21, 20));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_BAND(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(23, 22));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_NOTIFY_END(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(0));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_MODE(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(1));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_START_MODE(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(2));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_SCAN_TYPE(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(4, 3));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_BW(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(7, 5));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_TARGET_PRI_CH(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(15, 8));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_TARGET_CENTRAL_CH(void *cmd,
-							      u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(23, 16));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_PROBE_REQ_PKT_ID(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(31, 24));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_NORM_PD(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 8), val, GENMASK(15, 0));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_SLOW_PD(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 8), val, GENMASK(23, 16));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_TSF_HIGH(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 12), val, GENMASK(31, 0));
-}
+struct rtw89_h2c_scanofld {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 tsf_high;
+	__le32 tsf_low;
+	__le32 w5;
+	__le32 w6;
+} __packed;
 
-static inline void RTW89_SET_FWCMD_SCANOFLD_TSF_SLOW(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 16), val, GENMASK(31, 0));
-}
+#define RTW89_H2C_SCANOFLD_W0_MACID GENMASK(7, 0)
+#define RTW89_H2C_SCANOFLD_W0_NORM_CY GENMASK(15, 8)
+#define RTW89_H2C_SCANOFLD_W0_PORT_ID GENMASK(18, 16)
+#define RTW89_H2C_SCANOFLD_W0_BAND BIT(19)
+#define RTW89_H2C_SCANOFLD_W0_OPERATION GENMASK(21, 20)
+#define RTW89_H2C_SCANOFLD_W0_TARGET_CH_BAND GENMASK(23, 22)
+#define RTW89_H2C_SCANOFLD_W1_NOTIFY_END BIT(0)
+#define RTW89_H2C_SCANOFLD_W1_TARGET_CH_MODE BIT(1)
+#define RTW89_H2C_SCANOFLD_W1_START_MODE BIT(2)
+#define RTW89_H2C_SCANOFLD_W1_SCAN_TYPE GENMASK(4, 3)
+#define RTW89_H2C_SCANOFLD_W1_TARGET_CH_BW GENMASK(7, 5)
+#define RTW89_H2C_SCANOFLD_W1_TARGET_PRI_CH GENMASK(15, 8)
+#define RTW89_H2C_SCANOFLD_W1_TARGET_CENTRAL_CH GENMASK(23, 16)
+#define RTW89_H2C_SCANOFLD_W1_PROBE_REQ_PKT_ID GENMASK(31, 24)
+#define RTW89_H2C_SCANOFLD_W2_NORM_PD GENMASK(15, 0)
+#define RTW89_H2C_SCANOFLD_W2_SLOW_PD GENMASK(23, 16)
 
 static inline void RTW89_SET_FWCMD_P2P_MACID(void *cmd, u32 val)
 {
-- 
2.25.1

