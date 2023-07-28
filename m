Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBBD7664B8
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 09:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjG1HEH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 03:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjG1HEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 03:04:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ECD71FFF
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 00:04:04 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36S73ikeE031479, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36S73ikeE031479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 28 Jul 2023 15:03:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 28 Jul 2023 15:03:28 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 28 Jul
 2023 15:03:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 04/10] wifi: rtw89: use struct to set RA H2C command
Date:   Fri, 28 Jul 2023 15:02:46 +0800
Message-ID: <20230728070252.66525-5-pkshih@realtek.com>
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

RA (rate adaptive) H2C command is used to tell firmware which rates can
be used for specified MAC ID. Basically, this commit doesn't change result.
Only change to set two 32-bit instead of continual 8-byte rate masks one
by one. Originally, we only set 5-byte masks, because existing WiFi 6
2SS chips only need 5-byte masks. Setting two 32-bit masks will be more
efficient and also can support coming WiFi 7 2SS chips containing more
rates.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c |  79 +++++-----
 drivers/net/wireless/realtek/rtw89/fw.h | 187 +++++-------------------
 2 files changed, 73 insertions(+), 193 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9637f5e48d842..c2dc5c98c73dc 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1903,61 +1903,60 @@ int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	return ret;
 }
 
-#define H2C_RA_LEN 16
 int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi)
 {
 	struct sk_buff *skb;
-	u8 *cmd;
+	struct rtw89_h2c_ra *h2c;
+	u32 len = sizeof(*h2c);
 	int ret;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_RA_LEN);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c join\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_RA_LEN);
-	cmd = skb->data;
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_ra *)skb->data;
 	rtw89_debug(rtwdev, RTW89_DBG_RA,
 		    "ra cmd msk: %llx ", ra->ra_mask);
 
-	RTW89_SET_FWCMD_RA_MODE(cmd, ra->mode_ctrl);
-	RTW89_SET_FWCMD_RA_BW_CAP(cmd, ra->bw_cap);
-	RTW89_SET_FWCMD_RA_MACID(cmd, ra->macid);
-	RTW89_SET_FWCMD_RA_DCM(cmd, ra->dcm_cap);
-	RTW89_SET_FWCMD_RA_ER(cmd, ra->er_cap);
-	RTW89_SET_FWCMD_RA_INIT_RATE_LV(cmd, ra->init_rate_lv);
-	RTW89_SET_FWCMD_RA_UPD_ALL(cmd, ra->upd_all);
-	RTW89_SET_FWCMD_RA_SGI(cmd, ra->en_sgi);
-	RTW89_SET_FWCMD_RA_LDPC(cmd, ra->ldpc_cap);
-	RTW89_SET_FWCMD_RA_STBC(cmd, ra->stbc_cap);
-	RTW89_SET_FWCMD_RA_SS_NUM(cmd, ra->ss_num);
-	RTW89_SET_FWCMD_RA_GILTF(cmd, ra->giltf);
-	RTW89_SET_FWCMD_RA_UPD_BW_NSS_MASK(cmd, ra->upd_bw_nss_mask);
-	RTW89_SET_FWCMD_RA_UPD_MASK(cmd, ra->upd_mask);
-	RTW89_SET_FWCMD_RA_MASK_0(cmd, FIELD_GET(MASKBYTE0, ra->ra_mask));
-	RTW89_SET_FWCMD_RA_MASK_1(cmd, FIELD_GET(MASKBYTE1, ra->ra_mask));
-	RTW89_SET_FWCMD_RA_MASK_2(cmd, FIELD_GET(MASKBYTE2, ra->ra_mask));
-	RTW89_SET_FWCMD_RA_MASK_3(cmd, FIELD_GET(MASKBYTE3, ra->ra_mask));
-	RTW89_SET_FWCMD_RA_MASK_4(cmd, FIELD_GET(MASKBYTE4, ra->ra_mask));
-	RTW89_SET_FWCMD_RA_FIX_GILTF_EN(cmd, ra->fix_giltf_en);
-	RTW89_SET_FWCMD_RA_FIX_GILTF(cmd, ra->fix_giltf);
-
-	if (csi) {
-		RTW89_SET_FWCMD_RA_BFEE_CSI_CTL(cmd, 1);
-		RTW89_SET_FWCMD_RA_BAND_NUM(cmd, ra->band_num);
-		RTW89_SET_FWCMD_RA_CR_TBL_SEL(cmd, ra->cr_tbl_sel);
-		RTW89_SET_FWCMD_RA_FIXED_CSI_RATE_EN(cmd, ra->fixed_csi_rate_en);
-		RTW89_SET_FWCMD_RA_RA_CSI_RATE_EN(cmd, ra->ra_csi_rate_en);
-		RTW89_SET_FWCMD_RA_FIXED_CSI_MCS_SS_IDX(cmd, ra->csi_mcs_ss_idx);
-		RTW89_SET_FWCMD_RA_FIXED_CSI_MODE(cmd, ra->csi_mode);
-		RTW89_SET_FWCMD_RA_FIXED_CSI_GI_LTF(cmd, ra->csi_gi_ltf);
-		RTW89_SET_FWCMD_RA_FIXED_CSI_BW(cmd, ra->csi_bw);
-	}
-
+	h2c->w0 = le32_encode_bits(ra->mode_ctrl, RTW89_H2C_RA_W0_MODE) |
+		  le32_encode_bits(ra->bw_cap, RTW89_H2C_RA_W0_BW_CAP) |
+		  le32_encode_bits(ra->macid, RTW89_H2C_RA_W0_MACID) |
+		  le32_encode_bits(ra->dcm_cap, RTW89_H2C_RA_W0_DCM) |
+		  le32_encode_bits(ra->er_cap, RTW89_H2C_RA_W0_ER) |
+		  le32_encode_bits(ra->init_rate_lv, RTW89_H2C_RA_W0_INIT_RATE_LV) |
+		  le32_encode_bits(ra->upd_all, RTW89_H2C_RA_W0_UPD_ALL) |
+		  le32_encode_bits(ra->en_sgi, RTW89_H2C_RA_W0_SGI) |
+		  le32_encode_bits(ra->ldpc_cap, RTW89_H2C_RA_W0_LDPC) |
+		  le32_encode_bits(ra->stbc_cap, RTW89_H2C_RA_W0_STBC) |
+		  le32_encode_bits(ra->ss_num, RTW89_H2C_RA_W0_SS_NUM) |
+		  le32_encode_bits(ra->giltf, RTW89_H2C_RA_W0_GILTF) |
+		  le32_encode_bits(ra->upd_bw_nss_mask, RTW89_H2C_RA_W0_UPD_BW_NSS_MASK) |
+		  le32_encode_bits(ra->upd_mask, RTW89_H2C_RA_W0_UPD_MASK);
+	h2c->w1 = le32_encode_bits(ra->ra_mask, RTW89_H2C_RA_W1_RAMASK_LO32);
+	h2c->w2 = le32_encode_bits(ra->ra_mask >> 32, RTW89_H2C_RA_W2_RAMASK_HI32);
+	h2c->w3 = le32_encode_bits(ra->fix_giltf_en, RTW89_H2C_RA_W3_FIX_GILTF_EN) |
+		  le32_encode_bits(ra->fix_giltf, RTW89_H2C_RA_W3_FIX_GILTF);
+
+	if (!csi)
+		goto done;
+
+	h2c->w2 |= le32_encode_bits(1, RTW89_H2C_RA_W2_BFEE_CSI_CTL);
+	h2c->w3 |= le32_encode_bits(ra->band_num, RTW89_H2C_RA_W3_BAND_NUM) |
+		   le32_encode_bits(ra->cr_tbl_sel, RTW89_H2C_RA_W3_CR_TBL_SEL) |
+		   le32_encode_bits(ra->fixed_csi_rate_en, RTW89_H2C_RA_W3_FIXED_CSI_RATE_EN) |
+		   le32_encode_bits(ra->ra_csi_rate_en, RTW89_H2C_RA_W3_RA_CSI_RATE_EN) |
+		   le32_encode_bits(ra->csi_mcs_ss_idx, RTW89_H2C_RA_W3_FIXED_CSI_MCS_SS_IDX) |
+		   le32_encode_bits(ra->csi_mode, RTW89_H2C_RA_W3_FIXED_CSI_MODE) |
+		   le32_encode_bits(ra->csi_gi_ltf, RTW89_H2C_RA_W3_FIXED_CSI_GI_LTF) |
+		   le32_encode_bits(ra->csi_bw, RTW89_H2C_RA_W3_FIXED_CSI_BW);
+
+done:
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RA,
 			      H2C_FUNC_OUTSRC_RA_MACIDCFG, 0, 0,
-			      H2C_RA_LEN);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 45f927dc212ef..5e7f528c71e7c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -291,160 +291,41 @@ struct rtw89_pktofld_info {
 	bool cancel;
 };
 
-static inline void RTW89_SET_FWCMD_RA_IS_DIS(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(0));
-}
-
-static inline void RTW89_SET_FWCMD_RA_MODE(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(5, 1));
-}
-
-static inline void RTW89_SET_FWCMD_RA_BW_CAP(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(7, 6));
-}
-
-static inline void RTW89_SET_FWCMD_RA_MACID(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(15, 8));
-}
-
-static inline void RTW89_SET_FWCMD_RA_DCM(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(16));
-}
-
-static inline void RTW89_SET_FWCMD_RA_ER(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(17));
-}
-
-static inline void RTW89_SET_FWCMD_RA_INIT_RATE_LV(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(19, 18));
-}
-
-static inline void RTW89_SET_FWCMD_RA_UPD_ALL(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(20));
-}
-
-static inline void RTW89_SET_FWCMD_RA_SGI(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(21));
-}
-
-static inline void RTW89_SET_FWCMD_RA_LDPC(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(22));
-}
-
-static inline void RTW89_SET_FWCMD_RA_STBC(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(23));
-}
-
-static inline void RTW89_SET_FWCMD_RA_SS_NUM(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(26, 24));
-}
-
-static inline void RTW89_SET_FWCMD_RA_GILTF(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(29, 27));
-}
-
-static inline void RTW89_SET_FWCMD_RA_UPD_BW_NSS_MASK(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(30));
-}
-
-static inline void RTW89_SET_FWCMD_RA_UPD_MASK(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(31));
-}
-
-static inline void RTW89_SET_FWCMD_RA_MASK_0(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_RA_MASK_1(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(15, 8));
-}
-
-static inline void RTW89_SET_FWCMD_RA_MASK_2(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(23, 16));
-}
-
-static inline void RTW89_SET_FWCMD_RA_MASK_3(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(31, 24));
-}
-
-static inline void RTW89_SET_FWCMD_RA_MASK_4(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x02, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_RA_BFEE_CSI_CTL(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x02, val, BIT(31));
-}
-
-static inline void RTW89_SET_FWCMD_RA_BAND_NUM(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_RA_RA_CSI_RATE_EN(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, BIT(8));
-}
-
-static inline void RTW89_SET_FWCMD_RA_FIXED_CSI_RATE_EN(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, BIT(9));
-}
-
-static inline void RTW89_SET_FWCMD_RA_CR_TBL_SEL(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, BIT(10));
-}
-
-static inline void RTW89_SET_FWCMD_RA_FIX_GILTF_EN(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, BIT(11));
-}
-
-static inline void RTW89_SET_FWCMD_RA_FIX_GILTF(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(14, 12));
-}
-
-static inline void RTW89_SET_FWCMD_RA_FIXED_CSI_MCS_SS_IDX(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(23, 16));
-}
-
-static inline void RTW89_SET_FWCMD_RA_FIXED_CSI_MODE(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(25, 24));
-}
-
-static inline void RTW89_SET_FWCMD_RA_FIXED_CSI_GI_LTF(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(28, 26));
-}
+struct rtw89_h2c_ra {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+} __packed;
 
-static inline void RTW89_SET_FWCMD_RA_FIXED_CSI_BW(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(31, 29));
-}
+#define RTW89_H2C_RA_W0_IS_DIS BIT(0)
+#define RTW89_H2C_RA_W0_MODE GENMASK(5, 1)
+#define RTW89_H2C_RA_W0_BW_CAP GENMASK(7, 6)
+#define RTW89_H2C_RA_W0_MACID GENMASK(15, 8)
+#define RTW89_H2C_RA_W0_DCM BIT(16)
+#define RTW89_H2C_RA_W0_ER BIT(17)
+#define RTW89_H2C_RA_W0_INIT_RATE_LV GENMASK(19, 18)
+#define RTW89_H2C_RA_W0_UPD_ALL BIT(20)
+#define RTW89_H2C_RA_W0_SGI BIT(21)
+#define RTW89_H2C_RA_W0_LDPC BIT(22)
+#define RTW89_H2C_RA_W0_STBC BIT(23)
+#define RTW89_H2C_RA_W0_SS_NUM GENMASK(26, 24)
+#define RTW89_H2C_RA_W0_GILTF GENMASK(29, 27)
+#define RTW89_H2C_RA_W0_UPD_BW_NSS_MASK BIT(30)
+#define RTW89_H2C_RA_W0_UPD_MASK BIT(31)
+#define RTW89_H2C_RA_W1_RAMASK_LO32 GENMASK(31, 0)
+#define RTW89_H2C_RA_W2_RAMASK_HI32 GENMASK(30, 0)
+#define RTW89_H2C_RA_W2_BFEE_CSI_CTL BIT(31)
+#define RTW89_H2C_RA_W3_BAND_NUM GENMASK(7, 0)
+#define RTW89_H2C_RA_W3_RA_CSI_RATE_EN BIT(8)
+#define RTW89_H2C_RA_W3_FIXED_CSI_RATE_EN BIT(9)
+#define RTW89_H2C_RA_W3_CR_TBL_SEL BIT(10)
+#define RTW89_H2C_RA_W3_FIX_GILTF_EN BIT(11)
+#define RTW89_H2C_RA_W3_FIX_GILTF GENMASK(14, 12)
+#define RTW89_H2C_RA_W3_FIXED_CSI_MCS_SS_IDX GENMASK(23, 16)
+#define RTW89_H2C_RA_W3_FIXED_CSI_MODE GENMASK(25, 24)
+#define RTW89_H2C_RA_W3_FIXED_CSI_GI_LTF GENMASK(28, 26)
+#define RTW89_H2C_RA_W3_FIXED_CSI_BW GENMASK(31, 29)
 
 static inline void RTW89_SET_FWCMD_SEC_IDX(void *cmd, u32 val)
 {
-- 
2.25.1

