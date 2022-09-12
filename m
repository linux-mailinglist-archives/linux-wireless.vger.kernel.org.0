Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCABC5B54EA
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 09:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiILHBI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 03:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiILHBG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 03:01:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60DF8248DF
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 00:01:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28C70VCZ0026851, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28C70VCZ0026851
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 12 Sep 2022 15:00:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 12 Sep 2022 15:00:51 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 12 Sep
 2022 15:00:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: support for setting HE GI and LTF
Date:   Mon, 12 Sep 2022 15:00:13 +0800
Message-ID: <20220912070014.10018-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912070014.10018-1-pkshih@realtek.com>
References: <20220912070014.10018-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/12/2022 06:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTIgpFekyCAwMjozNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

Support setting HE GI and LTF values to the kernel via nl80211.
We currently only support some GI and LTF values settings.

The command example is:
  iw wlan0 set bitrates he-gi-2.4 0.8 he-ltf-2.4 2

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  4 ++-
 drivers/net/wireless/realtek/rtw89/fw.c   |  2 ++
 drivers/net/wireless/realtek/rtw89/fw.h   | 10 ++++++
 drivers/net/wireless/realtek/rtw89/phy.c  | 39 +++++++++++++++++++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b5fa61eb24f06..5b19fee020f67 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2055,7 +2055,9 @@ struct rtw89_ra_info {
 	u8 ra_csi_rate_en:1;
 	u8 fixed_csi_rate_en:1;
 	u8 cr_tbl_sel:1;
-	u8 rsvd2:5;
+	u8 fix_giltf_en:1;
+	u8 fix_giltf:3;
+	u8 rsvd2:1;
 	u8 csi_mcs_ss_idx;
 	u8 csi_mode:2;
 	u8 csi_gi_ltf:3;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8e4d0e18fa715..93c2e74e062cc 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1419,6 +1419,8 @@ int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi
 	RTW89_SET_FWCMD_RA_MASK_2(cmd, FIELD_GET(MASKBYTE2, ra->ra_mask));
 	RTW89_SET_FWCMD_RA_MASK_3(cmd, FIELD_GET(MASKBYTE3, ra->ra_mask));
 	RTW89_SET_FWCMD_RA_MASK_4(cmd, FIELD_GET(MASKBYTE4, ra->ra_mask));
+	RTW89_SET_FWCMD_RA_FIX_GILTF_EN(cmd, ra->fix_giltf_en);
+	RTW89_SET_FWCMD_RA_FIX_GILTF(cmd, ra->fix_giltf);
 
 	if (csi) {
 		RTW89_SET_FWCMD_RA_BFEE_CSI_CTL(cmd, 1);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index edd43f00994c4..366557270ea17 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -346,6 +346,16 @@ static inline void RTW89_SET_FWCMD_RA_CR_TBL_SEL(void *cmd, u32 val)
 	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, BIT(10));
 }
 
+static inline void RTW89_SET_FWCMD_RA_FIX_GILTF_EN(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, BIT(11));
+}
+
+static inline void RTW89_SET_FWCMD_RA_FIX_GILTF(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(14, 12));
+}
+
 static inline void RTW89_SET_FWCMD_RA_FIXED_CSI_MCS_SS_IDX(void *cmd, u32 val)
 {
 	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(23, 16));
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a2ebef0051b83..dfb19df97c305 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -193,6 +193,40 @@ static const u64
 rtw89_ra_mask_he_rates[4] = {RA_MASK_HE_1SS_RATES, RA_MASK_HE_2SS_RATES,
 			     RA_MASK_HE_3SS_RATES, RA_MASK_HE_4SS_RATES};
 
+static void rtw89_phy_ra_gi_ltf(struct rtw89_dev *rtwdev,
+				struct rtw89_sta *rtwsta,
+				bool *fix_giltf_en, u8 *fix_giltf)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct cfg80211_bitrate_mask *mask = &rtwsta->mask;
+	u8 band = chan->band_type;
+	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
+	u8 he_gi = mask->control[nl_band].he_gi;
+	u8 he_ltf = mask->control[nl_band].he_ltf;
+
+	if (!rtwsta->use_cfg_mask)
+		return;
+
+	if (he_ltf == 2 && he_gi == 2) {
+		*fix_giltf = RTW89_GILTF_LGI_4XHE32;
+	} else if (he_ltf == 2 && he_gi == 0) {
+		*fix_giltf = RTW89_GILTF_SGI_4XHE08;
+	} else if (he_ltf == 1 && he_gi == 1) {
+		*fix_giltf = RTW89_GILTF_2XHE16;
+	} else if (he_ltf == 1 && he_gi == 0) {
+		*fix_giltf = RTW89_GILTF_2XHE08;
+	} else if (he_ltf == 0 && he_gi == 1) {
+		*fix_giltf = RTW89_GILTF_1XHE16;
+	} else if (he_ltf == 0 && he_gi == 0) {
+		*fix_giltf = RTW89_GILTF_1XHE08;
+	} else {
+		*fix_giltf_en = false;
+		return;
+	}
+
+	*fix_giltf_en = true;
+}
+
 static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 				    struct ieee80211_sta *sta, bool csi)
 {
@@ -210,8 +244,10 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	u8 bw_mode = 0;
 	u8 stbc_en = 0;
 	u8 ldpc_en = 0;
+	u8 fix_giltf = 0;
 	u8 i;
 	bool sgi = false;
+	bool fix_giltf_en = false;
 
 	memset(ra, 0, sizeof(*ra));
 	/* Set the ra mask from sta's capability */
@@ -226,6 +262,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[1] &
 		    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD)
 			ldpc_en = 1;
+		rtw89_phy_ra_gi_ltf(rtwdev, rtwsta, &fix_giltf_en, &fix_giltf);
 	} else if (sta->deflink.vht_cap.vht_supported) {
 		u16 mcs_map = le16_to_cpu(sta->deflink.vht_cap.vht_mcs.rx_mcs_map);
 
@@ -335,6 +372,8 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	ra->ss_num = min(sta->deflink.rx_nss, rtwdev->hal.tx_nss) - 1;
 	ra->en_sgi = sgi;
 	ra->ra_mask = ra_mask;
+	ra->fix_giltf_en = fix_giltf_en;
+	ra->fix_giltf = fix_giltf;
 
 	if (!csi)
 		return;
-- 
2.25.1

