Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EEB7C6273
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 03:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjJLBtr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 21:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjJLBtn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 21:49:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E0098
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 18:49:41 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39C1nXo95585703, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39C1nXo95585703
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 09:49:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 12 Oct 2023 09:49:32 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 12 Oct
 2023 09:49:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: mac: set bf_assoc capabilities according to chip gen
Date:   Thu, 12 Oct 2023 09:49:01 +0800
Message-ID: <20231012014902.18523-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012014902.18523-1-pkshih@realtek.com>
References: <20231012014902.18523-1-pkshih@realtek.com>
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

When associated peer has beamformer capability, we should enable
beamformee, set CSI parameter, and configure rate to send CSI packets.
Since WiFi 7 registers are very different from WiFi 7, separate
configuration functions.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    |  29 ++--
 drivers/net/wireless/realtek/rtw89/mac.h    |  15 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c | 163 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  45 ++++++
 4 files changed, 238 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b47b3c9be2cb..b55f1844f653 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5208,7 +5208,7 @@ static void rtw89_mac_bfee_standby_timer(struct rtw89_dev *rtwdev, u8 mac_idx,
 	}
 }
 
-static void rtw89_mac_bfee_ctrl(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
+void rtw89_mac_bfee_ctrl(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 reg;
@@ -5225,7 +5225,7 @@ static void rtw89_mac_bfee_ctrl(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
 	}
 }
 
-static int rtw89_mac_init_bfee(struct rtw89_dev *rtwdev, u8 mac_idx)
+static int rtw89_mac_init_bfee_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	u32 reg;
 	u32 val32;
@@ -5267,9 +5267,9 @@ static int rtw89_mac_init_bfee(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
-static int rtw89_mac_set_csi_para_reg(struct rtw89_dev *rtwdev,
-				      struct ieee80211_vif *vif,
-				      struct ieee80211_sta *sta)
+static int rtw89_mac_set_csi_para_reg_ax(struct rtw89_dev *rtwdev,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta)
 {
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	u8 mac_idx = rtwvif->mac_idx;
@@ -5325,9 +5325,9 @@ static int rtw89_mac_set_csi_para_reg(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-static int rtw89_mac_csi_rrsc(struct rtw89_dev *rtwdev,
-			      struct ieee80211_vif *vif,
-			      struct ieee80211_sta *sta)
+static int rtw89_mac_csi_rrsc_ax(struct rtw89_dev *rtwdev,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta)
 {
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	u32 rrsc = BIT(RTW89_MAC_BF_RRSC_6M) | BIT(RTW89_MAC_BF_RRSC_24M);
@@ -5364,17 +5364,18 @@ static int rtw89_mac_csi_rrsc(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-void rtw89_mac_bf_assoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta)
+static void rtw89_mac_bf_assoc_ax(struct rtw89_dev *rtwdev,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta)
 {
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 
 	if (rtw89_sta_has_beamformer_cap(sta)) {
 		rtw89_debug(rtwdev, RTW89_DBG_BF,
 			    "initialize bfee for new association\n");
-		rtw89_mac_init_bfee(rtwdev, rtwvif->mac_idx);
-		rtw89_mac_set_csi_para_reg(rtwdev, vif, sta);
-		rtw89_mac_csi_rrsc(rtwdev, vif, sta);
+		rtw89_mac_init_bfee_ax(rtwdev, rtwvif->mac_idx);
+		rtw89_mac_set_csi_para_reg_ax(rtwdev, vif, sta);
+		rtw89_mac_csi_rrsc_ax(rtwdev, vif, sta);
 	}
 }
 
@@ -5765,6 +5766,8 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 			B_AX_BFMEE_HE_NDPA_EN,
 	},
 
+	.bf_assoc = rtw89_mac_bf_assoc_ax,
+
 	.disable_cpu = rtw89_mac_disable_cpu_ax,
 	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
 	.fwdl_get_status = rtw89_fw_get_rdy_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 6c043259c5e0..2ddf1f8d0a42 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -864,6 +864,9 @@ struct rtw89_mac_gen_def {
 	struct rtw89_reg_def muedca_ctrl;
 	struct rtw89_reg_def bfee_ctrl;
 
+	void (*bf_assoc)(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta);
+
 	void (*disable_cpu)(struct rtw89_dev *rtwdev);
 	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason,
 				bool dlfw, bool include_bb);
@@ -1038,8 +1041,17 @@ int rtw89_mac_cfg_ctrl_path(struct rtw89_dev *rtwdev, bool wl);
 int rtw89_mac_cfg_ctrl_path_v1(struct rtw89_dev *rtwdev, bool wl);
 void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter);
 void rtw89_mac_notify_wake(struct rtw89_dev *rtwdev);
+
+static inline
 void rtw89_mac_bf_assoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta);
+			struct ieee80211_sta *sta)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	if (mac->bf_assoc)
+		mac->bf_assoc(rtwdev, vif, sta);
+}
+
 void rtw89_mac_bf_disassoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void rtw89_mac_bf_set_gid_table(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
@@ -1047,6 +1059,7 @@ void rtw89_mac_bf_set_gid_table(struct rtw89_dev *rtwdev, struct ieee80211_vif *
 void rtw89_mac_bf_monitor_calc(struct rtw89_dev *rtwdev,
 			       struct ieee80211_sta *sta, bool disconnect);
 void _rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev);
+void rtw89_mac_bfee_ctrl(struct rtw89_dev *rtwdev, u8 mac_idx, bool en);
 int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_mac_vif_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_mac_set_hw_muedca_ctrl(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 7cf67020c6e6..3278f241db6e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -243,6 +243,167 @@ static bool rtw89_mac_get_txpwr_cr_be(struct rtw89_dev *rtwdev,
 	return true;
 }
 
+static int rtw89_mac_init_bfee_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 reg;
+	u32 val;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	rtw89_mac_bfee_ctrl(rtwdev, mac_idx, true);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
+	rtw89_write32_set(rtwdev, reg, B_BE_BFMEE_BFPARAM_SEL |
+				       B_BE_BFMEE_USE_NSTS |
+				       B_BE_BFMEE_CSI_GID_SEL |
+				       B_BE_BFMEE_CSI_FORCE_RETE_EN);
+	rtw89_write32_mask(rtwdev, reg, B_BE_BFMEE_CSI_RSC_MASK, CSI_RX_BW_CFG);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CSIRPT_OPTION, mac_idx);
+	rtw89_write32_set(rtwdev, reg, B_BE_CSIPRT_VHTSU_AID_EN |
+				       B_BE_CSIPRT_HESU_AID_EN |
+				       B_BE_CSIPRT_EHTSU_AID_EN);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_CSI_RRSC, mac_idx);
+	rtw89_write32(rtwdev, reg, CSI_RRSC_BMAP_BE);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_CSI_CTRL_1, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BE_BFMEE_BE_CSI_RRSC_BITMAP_MASK,
+			   CSI_RRSC_BITMAP_CFG);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_CSI_RATE, mac_idx);
+	val = u32_encode_bits(CSI_INIT_RATE_HT, B_BE_BFMEE_HT_CSI_RATE_MASK) |
+	      u32_encode_bits(CSI_INIT_RATE_VHT, B_BE_BFMEE_VHT_CSI_RATE_MASK) |
+	      u32_encode_bits(CSI_INIT_RATE_HE, B_BE_BFMEE_HE_CSI_RATE_MASK) |
+	      u32_encode_bits(CSI_INIT_RATE_EHT, B_BE_BFMEE_EHT_CSI_RATE_MASK);
+
+	rtw89_write32(rtwdev, reg, val);
+
+	return 0;
+}
+
+static int rtw89_mac_set_csi_para_reg_be(struct rtw89_dev *rtwdev,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	u8 nc = 1, nr = 3, ng = 0, cb = 1, cs = 1, ldpc_en = 1, stbc_en = 1;
+	u8 mac_idx = rtwvif->mac_idx;
+	u8 port_sel = rtwvif->port;
+	u8 sound_dim = 3, t;
+	u8 *phy_cap;
+	u32 reg;
+	u16 val;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	phy_cap = sta->deflink.he_cap.he_cap_elem.phy_cap_info;
+
+	if ((phy_cap[3] & IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER) ||
+	    (phy_cap[4] & IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER)) {
+		ldpc_en &= !!(phy_cap[1] & IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD);
+		stbc_en &= !!(phy_cap[2] & IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ);
+		t = u8_get_bits(phy_cap[5],
+				IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK);
+		sound_dim = min(sound_dim, t);
+	}
+
+	if ((sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) ||
+	    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)) {
+		ldpc_en &= !!(sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
+		stbc_en &= !!(sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_MASK);
+		t = u32_get_bits(sta->deflink.vht_cap.cap,
+				 IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK);
+		sound_dim = min(sound_dim, t);
+	}
+
+	nc = min(nc, sound_dim);
+	nr = min(nr, sound_dim);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
+	rtw89_write32_set(rtwdev, reg, B_BE_BFMEE_BFPARAM_SEL);
+
+	val = u16_encode_bits(nc, B_BE_BFMEE_CSIINFO0_NC_MASK) |
+	      u16_encode_bits(nr, B_BE_BFMEE_CSIINFO0_NR_MASK) |
+	      u16_encode_bits(ng, B_BE_BFMEE_CSIINFO0_NG_MASK) |
+	      u16_encode_bits(cb, B_BE_BFMEE_CSIINFO0_CB_MASK) |
+	      u16_encode_bits(cs, B_BE_BFMEE_CSIINFO0_CS_MASK) |
+	      u16_encode_bits(ldpc_en, B_BE_BFMEE_CSIINFO0_LDPC_EN) |
+	      u16_encode_bits(stbc_en, B_BE_BFMEE_CSIINFO0_STBC_EN);
+
+	if (port_sel == 0)
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_CSI_CTRL_0,
+					   mac_idx);
+	else
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_CSI_CTRL_1,
+					   mac_idx);
+
+	rtw89_write16(rtwdev, reg, val);
+
+	return 0;
+}
+
+static int rtw89_mac_csi_rrsc_be(struct rtw89_dev *rtwdev,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	u32 rrsc = BIT(RTW89_MAC_BF_RRSC_6M) | BIT(RTW89_MAC_BF_RRSC_24M);
+	u8 mac_idx = rtwvif->mac_idx;
+	int ret;
+	u32 reg;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	if (sta->deflink.he_cap.has_he) {
+		rrsc |= (BIT(RTW89_MAC_BF_RRSC_HE_MSC0) |
+			 BIT(RTW89_MAC_BF_RRSC_HE_MSC3) |
+			 BIT(RTW89_MAC_BF_RRSC_HE_MSC5));
+	}
+	if (sta->deflink.vht_cap.vht_supported) {
+		rrsc |= (BIT(RTW89_MAC_BF_RRSC_VHT_MSC0) |
+			 BIT(RTW89_MAC_BF_RRSC_VHT_MSC3) |
+			 BIT(RTW89_MAC_BF_RRSC_VHT_MSC5));
+	}
+	if (sta->deflink.ht_cap.ht_supported) {
+		rrsc |= (BIT(RTW89_MAC_BF_RRSC_HT_MSC0) |
+			 BIT(RTW89_MAC_BF_RRSC_HT_MSC3) |
+			 BIT(RTW89_MAC_BF_RRSC_HT_MSC5));
+	}
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
+	rtw89_write32_set(rtwdev, reg, B_BE_BFMEE_BFPARAM_SEL);
+	rtw89_write32_clr(rtwdev, reg, B_BE_BFMEE_CSI_FORCE_RETE_EN);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_CSI_RRSC, mac_idx);
+	rtw89_write32(rtwdev, reg, rrsc);
+
+	return 0;
+}
+
+static void rtw89_mac_bf_assoc_be(struct rtw89_dev *rtwdev,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+
+	if (rtw89_sta_has_beamformer_cap(sta)) {
+		rtw89_debug(rtwdev, RTW89_DBG_BF,
+			    "initialize bfee for new association\n");
+		rtw89_mac_init_bfee_be(rtwdev, rtwvif->mac_idx);
+		rtw89_mac_set_csi_para_reg_be(rtwdev, vif, sta);
+		rtw89_mac_csi_rrsc_be(rtwdev, vif, sta);
+	}
+}
+
 const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.band1_offset = RTW89_MAC_BE_BAND_REG_OFFSET,
 	.filter_model_addr = R_BE_FILTER_MODEL_ADDR,
@@ -262,6 +423,8 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 			B_BE_BFMEE_HE_NDPA_EN | B_BE_BFMEE_EHT_NDPA_EN,
 	},
 
+	.bf_assoc = rtw89_mac_bf_assoc_be,
+
 	.disable_cpu = rtw89_mac_disable_cpu_be,
 	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
 	.fwdl_get_status = fwdl_get_status_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index aee54859f92b..2bf3c1bed6a2 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3953,6 +3953,45 @@
 #define B_BE_BFMEE_VHT_NDPA_EN BIT(1)
 #define B_BE_BFMEE_HT_NDPA_EN BIT(0)
 
+#define R_BE_TRXPTCL_RESP_CSI_CTRL_0 0x11188
+#define R_BE_TRXPTCL_RESP_CSI_CTRL_0_C1 0x15188
+#define B_BE_BFMEE_CSISEQ_SEL BIT(29)
+#define B_BE_BFMEE_BFPARAM_SEL BIT(28)
+#define B_BE_BFMEE_OFDM_LEN_TH_MASK GENMASK(27, 24)
+#define B_BE_BFMEE_BF_PORT_SEL BIT(23)
+#define B_BE_BFMEE_USE_NSTS BIT(22)
+#define B_BE_BFMEE_CSI_RATE_FB_EN BIT(21)
+#define B_BE_BFMEE_CSI_GID_SEL BIT(20)
+#define B_BE_BFMEE_CSI_RSC_MASK GENMASK(19, 18)
+#define B_BE_BFMEE_CSI_FORCE_RETE_EN BIT(17)
+#define B_BE_BFMEE_CSI_USE_NDPARATE BIT(16)
+#define B_BE_BFMEE_CSI_WITHHTC_EN BIT(15)
+#define B_BE_BFMEE_CSIINFO0_BF_EN BIT(14)
+#define B_BE_BFMEE_CSIINFO0_STBC_EN BIT(13)
+#define B_BE_BFMEE_CSIINFO0_LDPC_EN BIT(12)
+#define B_BE_BFMEE_CSIINFO0_CS_MASK GENMASK(11, 10)
+#define B_BE_BFMEE_CSIINFO0_CB_MASK GENMASK(9, 8)
+#define B_BE_BFMEE_CSIINFO0_NG_MASK GENMASK(7, 6)
+#define B_BE_BFMEE_CSIINFO0_NR_MASK GENMASK(5, 3)
+#define B_BE_BFMEE_CSIINFO0_NC_MASK GENMASK(2, 0)
+#define CSI_RX_BW_CFG 0x1
+#define R_BE_TRXPTCL_RESP_CSI_CTRL_1 0x11194
+#define R_BE_TRXPTCL_RESP_CSI_CTRL_1_C1 0x15194
+#define B_BE_BFMEE_BE_CSI_RRSC_BITMAP_MASK GENMASK(31, 24)
+#define CSI_RRSC_BITMAP_CFG 0x2A
+
+#define R_BE_TRXPTCL_RESP_CSI_RRSC 0x1118C
+#define R_BE_TRXPTCL_RESP_CSI_RRSC_C1 0x1518C
+#define CSI_RRSC_BMAP_BE 0x2A2AFF
+
+#define R_BE_TRXPTCL_RESP_CSI_RATE 0x11190
+#define R_BE_TRXPTCL_RESP_CSI_RATE_C1 0x15190
+#define B_BE_BFMEE_EHT_CSI_RATE_MASK GENMASK(31, 24)
+#define B_BE_BFMEE_HE_CSI_RATE_MASK GENMASK(23, 16)
+#define B_BE_BFMEE_VHT_CSI_RATE_MASK GENMASK(15, 8)
+#define B_BE_BFMEE_HT_CSI_RATE_MASK GENMASK(7, 0)
+#define CSI_INIT_RATE_EHT 0x3
+
 #define R_BE_RX_FLTR_OPT 0x11420
 #define R_BE_RX_FLTR_OPT_C1 0x15420
 #define B_BE_UID_FILTER_MASK GENMASK(31, 24)
@@ -3972,6 +4011,12 @@
 #define B_BE_A_A1_MATCH BIT(1)
 #define B_BE_SNIFFER_MODE BIT(0)
 
+#define R_BE_CSIRPT_OPTION 0x11464
+#define R_BE_CSIRPT_OPTION_C1 0x15464
+#define B_BE_CSIPRT_EHTSU_AID_EN BIT(26)
+#define B_BE_CSIPRT_HESU_AID_EN BIT(25)
+#define B_BE_CSIPRT_VHTSU_AID_EN BIT(24)
+
 #define R_BE_PWR_MODULE 0x11900
 #define R_BE_PWR_MODULE_C1 0x15900
 
-- 
2.25.1

