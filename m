Return-Path: <linux-wireless+bounces-25150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B38ADAFF7FD
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FFD1C48235
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192882F3E;
	Thu, 10 Jul 2025 04:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="h7huind/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874C22B8A4
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121495; cv=none; b=u/imkYelPh4nzgC4PqLfPyr82U4/Op2H1VIcJXyFjO4o/BlRhtZKAizHO6uCex6RpPbaDjudYhbAOrKMfEdZlZi+OuA1Qnjws9/CNcUJ3YYbl3ADlsbXpnEDogbZYPHql4u93+W8Kh4tZHWWbdEphGVqvkHhIC6GPYCYWVYevnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121495; c=relaxed/simple;
	bh=klk0TjuoE9azlf0fsSUm5MonvltYUJvu5nJrvWB4lxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/+0NyECbQ7rk3C2x7+S9CqIyiUFVbEBY9DVBeMrPsLG+v2TwEgngB/cjOT6pHzFuUr8tbmm2rxfjeddZwIJK6ckoFXuqtRu4RISg/roKatdWc+VhTIo8oz4wFPu7YLeVCJphiYruNRj4O+Y7EgBtIXjaK5jZrrs5KJHZu9F9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=h7huind/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4OnabE2455770, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121489; bh=MhV+zQSBJ4e5cKzAmI52BA18pw3ltnBe4bYDatcAgpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=h7huind/Ua2uc4lnBrp4IatlnAR6MsFgHrY872NDnBCFxysxN5eV/Rdsk1pIEcJK9
	 SU8Pe0Loawrk89qQ/cuVawPke3QRE+k+KuGJK/1/mE4skelc/C1A56QMEIcK6bmuq9
	 fYlSHe+jouqJT0VEy6bpN10l0lVQaMjmELO7zjo9lwZEk7wsHe1sH1Y2Ml1nawL0Xk
	 vYeLd1wFYAayPL80Amf1q/HKWI5yO7WGr2d3rDz7DYo05tjVW/28ej7RkK/d/yGC8U
	 0J1TVmbTtXOFeiCetAncF5hsfMaU4DPnxbEFpjJ7xWWO5VlLOIS1m4q9tkeoWlZRnW
	 UHBgNL3zCmDmg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4OnabE2455770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:24:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:24:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:24:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/14] wifi: rtw89: mcc: add H2C command to support different PD level in MCC
Date: Thu, 10 Jul 2025 12:24:10 +0800
Message-ID: <20250710042423.73617-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710042423.73617-1-pkshih@realtek.com>
References: <20250710042423.73617-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chih-Kang Chang <gary.chang@realtek.com>

Packet detection(PD) lower bound is the threshold for sensing packet,
and it is dynamically calculated based on RSSI. In MCC, the two
interfaces have different RSSI values, so it is necessary to set
different values to ensure packets can be received. Therefore, add
H2C command to let firmware to switch PD lower bound when MCC mode.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c |  25 ++++
 drivers/net/wireless/realtek/rtw89/chan.h |   5 +
 drivers/net/wireless/realtek/rtw89/fw.c   |  53 +++++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  25 ++++
 drivers/net/wireless/realtek/rtw89/phy.c  | 172 +++++++++++++++++++---
 5 files changed, 257 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 6f10235647a1..32cd09f77e37 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2371,6 +2371,7 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev,
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_STOP);
 
 	rtw89_mcc_stop_beacon_noa(rtwdev);
+	rtw89_fw_h2c_mcc_dig(rtwdev, RTW89_CHANCTX_0, 0, 0, false);
 
 	rtw89_mcc_prepare(rtwdev, false);
 }
@@ -2622,6 +2623,30 @@ static void rtw89_mcc_update_limit(struct rtw89_dev *rtwdev)
 	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_upd_lmt_iterator, NULL);
 }
 
+static int rtw89_mcc_get_links_iterator(struct rtw89_dev *rtwdev,
+					struct rtw89_mcc_role *mcc_role,
+					unsigned int ordered_idx,
+					void *data)
+{
+	struct rtw89_mcc_links_info *info = data;
+
+	info->links[ordered_idx] = mcc_role->rtwvif_link;
+	return 0;
+}
+
+void rtw89_mcc_get_links(struct rtw89_dev *rtwdev, struct rtw89_mcc_links_info *info)
+{
+	enum rtw89_entity_mode mode;
+
+	memset(info, 0, sizeof(*info));
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	if (unlikely(mode != RTW89_ENTITY_MODE_MCC))
+		return;
+
+	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_get_links_iterator, info);
+}
+
 void rtw89_chanctx_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 57355cb3d765..0e2ffb920455 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -178,6 +178,11 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 #define rtw89_mgnt_chan_get(rtwdev, link_index) \
 	__rtw89_mgnt_chan_get(rtwdev, __func__, link_index)
 
+struct rtw89_mcc_links_info {
+	struct rtw89_vif_link *links[NUM_OF_RTW89_MCC_ROLES];
+};
+
+void rtw89_mcc_get_links(struct rtw89_dev *rtwdev, struct rtw89_mcc_links_info *info);
 void rtw89_mcc_prepare_done_work(struct wiphy *wiphy, struct wiphy_work *work);
 
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c613431e754f..3a3109ab7111 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5985,6 +5985,59 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_rf_ntfy_mcc);
 
+int rtw89_fw_h2c_mcc_dig(struct rtw89_dev *rtwdev,
+			 enum rtw89_chanctx_idx chanctx_idx,
+			 u8 mcc_role_idx, u8 pd_val, bool en)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
+	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
+	struct rtw89_h2c_mcc_dig *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c mcc_dig\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_mcc_dig *)skb->data;
+
+	h2c->w0 = le32_encode_bits(1, RTW89_H2C_MCC_DIG_W0_REG_CNT) |
+		  le32_encode_bits(en, RTW89_H2C_MCC_DIG_W0_DM_EN) |
+		  le32_encode_bits(mcc_role_idx, RTW89_H2C_MCC_DIG_W0_IDX) |
+		  le32_encode_bits(1, RTW89_H2C_MCC_DIG_W0_SET) |
+		  le32_encode_bits(1, RTW89_H2C_MCC_DIG_W0_PHY0_EN) |
+		  le32_encode_bits(chan->channel, RTW89_H2C_MCC_DIG_W0_CENTER_CH) |
+		  le32_encode_bits(chan->band_type, RTW89_H2C_MCC_DIG_W0_BAND_TYPE);
+	h2c->w1 = le32_encode_bits(dig_regs->seg0_pd_reg,
+				   RTW89_H2C_MCC_DIG_W1_ADDR_LSB) |
+		  le32_encode_bits(dig_regs->seg0_pd_reg >> 8,
+				   RTW89_H2C_MCC_DIG_W1_ADDR_MSB) |
+		  le32_encode_bits(dig_regs->pd_lower_bound_mask,
+				   RTW89_H2C_MCC_DIG_W1_BMASK_LSB) |
+		  le32_encode_bits(dig_regs->pd_lower_bound_mask >> 8,
+				   RTW89_H2C_MCC_DIG_W1_BMASK_MSB);
+	h2c->w2 = le32_encode_bits(pd_val, RTW89_H2C_MCC_DIG_W2_VAL_LSB);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_DM,
+			      H2C_FUNC_FW_MCC_DIG, 0, 0, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 int rtw89_fw_h2c_rf_ps_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 24d2e8b0d079..22b2b2a716ef 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4341,6 +4341,7 @@ enum rtw89_mrc_h2c_func {
 #define H2C_FUNC_OUTSRC_RA_MACIDCFG	0x0
 
 #define H2C_CL_OUTSRC_DM		0x2
+#define H2C_FUNC_FW_MCC_DIG		0x6
 #define H2C_FUNC_FW_LPS_CH_INFO		0xb
 #define H2C_FUNC_FW_LPS_ML_CMN_INFO	0xe
 
@@ -4378,6 +4379,27 @@ struct rtw89_fw_h2c_rf_get_mccch_v0 {
 	__le32 current_band_type;
 } __packed;
 
+struct rtw89_h2c_mcc_dig {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+} __packed;
+
+#define RTW89_H2C_MCC_DIG_W0_REG_CNT GENMASK(7, 0)
+#define RTW89_H2C_MCC_DIG_W0_DM_EN BIT(8)
+#define RTW89_H2C_MCC_DIG_W0_IDX GENMASK(10, 9)
+#define RTW89_H2C_MCC_DIG_W0_SET BIT(11)
+#define RTW89_H2C_MCC_DIG_W0_PHY0_EN BIT(12)
+#define RTW89_H2C_MCC_DIG_W0_PHY1_EN BIT(13)
+#define RTW89_H2C_MCC_DIG_W0_CENTER_CH GENMASK(23, 16)
+#define RTW89_H2C_MCC_DIG_W0_BAND_TYPE GENMASK(31, 24)
+#define RTW89_H2C_MCC_DIG_W1_ADDR_LSB GENMASK(7, 0)
+#define RTW89_H2C_MCC_DIG_W1_ADDR_MSB GENMASK(15, 8)
+#define RTW89_H2C_MCC_DIG_W1_BMASK_LSB GENMASK(23, 16)
+#define RTW89_H2C_MCC_DIG_W1_BMASK_MSB GENMASK(31, 24)
+#define RTW89_H2C_MCC_DIG_W2_VAL_LSB GENMASK(7, 0)
+#define RTW89_H2C_MCC_DIG_W2_VAL_MSB GENMASK(15, 8)
+
 #define NUM_OF_RTW89_FW_RFK_PATH 2
 #define NUM_OF_RTW89_FW_RFK_TBL 3
 
@@ -4774,6 +4796,9 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_rf_ps_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx);
+int rtw89_fw_h2c_mcc_dig(struct rtw89_dev *rtwdev,
+			 enum rtw89_chanctx_idx chanctx_idx,
+			 u8 mcc_role_idx, u8 pd_val, bool en);
 int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			 const struct rtw89_chan *chan, enum rtw89_tssi_mode tssi_mode);
 int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 7d005db211e5..a7412d139902 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6316,18 +6316,13 @@ static void rtw89_phy_dig_config_igi(struct rtw89_dev *rtwdev,
 	}
 }
 
-static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev,
-				    struct rtw89_bb_ctx *bb,
-				    u8 rssi, bool enable)
+static u8 rtw89_phy_dig_cal_under_region(struct rtw89_dev *rtwdev,
+					 struct rtw89_bb_ctx *bb,
+					 const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_mgnt_chan_get(rtwdev, bb->phy_idx);
-	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 	enum rtw89_bandwidth cbw = chan->band_width;
 	struct rtw89_dig_info *dig = &bb->dig;
-	u8 final_rssi = 0, under_region = dig->pd_low_th_ofst;
-	u8 ofdm_cca_th;
-	s8 cck_cca_th;
-	u32 pd_val = 0;
+	u8 under_region = dig->pd_low_th_ofst;
 
 	if (rtwdev->chip->chip_gen == RTW89_CHIP_AX)
 		under_region += PD_TH_SB_FLTR_CMP_VAL;
@@ -6349,6 +6344,20 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev,
 		break;
 	}
 
+	return under_region;
+}
+
+static u32 __rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev,
+				     struct rtw89_bb_ctx *bb,
+				     u8 rssi, bool enable,
+				     const struct rtw89_chan *chan)
+{
+	struct rtw89_dig_info *dig = &bb->dig;
+	u8 ofdm_cca_th, under_region;
+	u8 final_rssi;
+	u32 pd_val;
+
+	under_region = rtw89_phy_dig_cal_under_region(rtwdev, bb, chan);
 	dig->dyn_pd_th_max = dig->igi_rssi;
 
 	final_rssi = min_t(u8, rssi, dig->igi_rssi);
@@ -6361,10 +6370,27 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev,
 			    "igi=%d, ofdm_ccaTH=%d, backoff=%d, PD_low=%d\n",
 			    final_rssi, ofdm_cca_th, under_region, pd_val);
 	} else {
+		pd_val = 0;
 		rtw89_debug(rtwdev, RTW89_DBG_DIG,
 			    "Dynamic PD th disabled, Set PD_low_bd=0\n");
 	}
 
+	return pd_val;
+}
+
+static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev,
+				    struct rtw89_bb_ctx *bb,
+				    u8 rssi, bool enable)
+{
+	const struct rtw89_chan *chan = rtw89_mgnt_chan_get(rtwdev, bb->phy_idx);
+	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
+	struct rtw89_dig_info *dig = &bb->dig;
+	u8 final_rssi, under_region = dig->pd_low_th_ofst;
+	s8 cck_cca_th;
+	u32 pd_val;
+
+	pd_val = __rtw89_phy_dig_dyn_pd_th(rtwdev, bb, rssi, enable, chan);
+
 	rtw89_phy_write32_idx(rtwdev, dig_regs->seg0_pd_reg,
 			      dig_regs->pd_lower_bound_mask, pd_val, bb->phy_idx);
 	rtw89_phy_write32_idx(rtwdev, dig_regs->seg0_pd_reg,
@@ -6373,6 +6399,8 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev,
 	if (!rtwdev->hal.support_cckpd)
 		return;
 
+	final_rssi = min_t(u8, rssi, dig->igi_rssi);
+	under_region = rtw89_phy_dig_cal_under_region(rtwdev, bb, chan);
 	cck_cca_th = max_t(s8, final_rssi - under_region, CCKPD_TH_MIN_RSSI);
 	pd_val = (u32)(cck_cca_th - IGI_RSSI_MAX);
 
@@ -6400,11 +6428,115 @@ void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 
 #define IGI_RSSI_MIN 10
 #define ABS_IGI_MIN 0xc
+static
+void rtw89_phy_cal_igi_fa_rssi(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
+{
+	struct rtw89_dig_info *dig = &bb->dig;
+	u8 igi_min;
+
+	rtw89_phy_dig_igi_offset_by_env(rtwdev, bb);
+
+	igi_min = max_t(int, dig->igi_rssi - IGI_RSSI_MIN, 0);
+	dig->dyn_igi_max = min(igi_min + IGI_OFFSET_MAX, igi_max_performance_mode);
+	dig->dyn_igi_min = max(igi_min, ABS_IGI_MIN);
+
+	if (dig->dyn_igi_max >= dig->dyn_igi_min) {
+		dig->igi_fa_rssi += dig->fa_rssi_ofst;
+		dig->igi_fa_rssi = clamp(dig->igi_fa_rssi, dig->dyn_igi_min,
+					 dig->dyn_igi_max);
+	} else {
+		dig->igi_fa_rssi = dig->dyn_igi_max;
+	}
+}
+
+struct rtw89_phy_iter_mcc_dig {
+	struct rtw89_vif_link *rtwvif_link;
+	bool has_sta;
+	u8 rssi_min;
+};
+
+static void rtw89_phy_set_mcc_dig(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif_link *rtwvif_link,
+				  struct rtw89_bb_ctx *bb,
+				  u8 rssi_min, u8 mcc_role_idx,
+				  bool is_linked)
+{
+	struct rtw89_dig_info *dig = &bb->dig;
+	const struct rtw89_chan *chan;
+	u8 pd_val;
+
+	if (is_linked) {
+		dig->igi_rssi = rssi_min >> 1;
+		dig->igi_fa_rssi = dig->igi_rssi;
+	} else {
+		rtw89_debug(rtwdev, RTW89_DBG_DIG, "RSSI update : NO Link\n");
+		dig->igi_rssi = rssi_nolink;
+		dig->igi_fa_rssi = dig->igi_rssi;
+	}
+
+	chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+	rtw89_phy_cal_igi_fa_rssi(rtwdev, bb);
+	pd_val = __rtw89_phy_dig_dyn_pd_th(rtwdev, bb, dig->igi_fa_rssi,
+					   is_linked, chan);
+	rtw89_fw_h2c_mcc_dig(rtwdev, rtwvif_link->chanctx_idx,
+			     mcc_role_idx, pd_val, true);
+
+	rtw89_debug(rtwdev, RTW89_DBG_DIG,
+		    "MCC chanctx_idx %d chan %d rssi %d pd_val %d",
+		    rtwvif_link->chanctx_idx, chan->primary_channel,
+		    dig->igi_rssi, pd_val);
+}
+
+static void rtw89_phy_set_mcc_dig_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw89_phy_iter_mcc_dig *mcc_dig = (struct rtw89_phy_iter_mcc_dig *)data;
+	unsigned int link_id = mcc_dig->rtwvif_link->link_id;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_sta_link *rtwsta_link;
+
+	if (rtwsta->rtwvif != mcc_dig->rtwvif_link->rtwvif)
+		return;
+
+	rtwsta_link = rtwsta->links[link_id];
+	if (!rtwsta_link)
+		return;
+
+	mcc_dig->has_sta = true;
+	if (ewma_rssi_read(&rtwsta_link->avg_rssi) < mcc_dig->rssi_min)
+		mcc_dig->rssi_min = ewma_rssi_read(&rtwsta_link->avg_rssi);
+}
+
+static void rtw89_phy_dig_mcc(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
+{
+	struct rtw89_phy_iter_mcc_dig mcc_dig;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_mcc_links_info info;
+	int i;
+
+	rtw89_mcc_get_links(rtwdev, &info);
+	for (i = 0; i < ARRAY_SIZE(info.links); i++) {
+		rtwvif_link = info.links[i];
+		if (!rtwvif_link)
+			continue;
+
+		memset(&mcc_dig, 0, sizeof(mcc_dig));
+		mcc_dig.rtwvif_link = rtwvif_link;
+		mcc_dig.has_sta = false;
+		mcc_dig.rssi_min = U8_MAX;
+		ieee80211_iterate_stations_atomic(rtwdev->hw,
+						  rtw89_phy_set_mcc_dig_iter,
+						  &mcc_dig);
+
+		rtw89_phy_set_mcc_dig(rtwdev, rtwvif_link, bb,
+				      mcc_dig.rssi_min, i, mcc_dig.has_sta);
+	}
+}
+
 static void __rtw89_phy_dig(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 {
 	struct rtw89_dig_info *dig = &bb->dig;
 	bool is_linked = rtwdev->total_sta_assoc > 0;
-	u8 igi_min;
+	enum rtw89_entity_mode mode;
 
 	if (unlikely(dig->bypass_dig)) {
 		dig->bypass_dig = false;
@@ -6415,6 +6547,12 @@ static void __rtw89_phy_dig(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 
 	rtw89_phy_dig_update_rssi_info(rtwdev, bb);
 
+	mode = rtw89_get_entity_mode(rtwdev);
+	if (mode == RTW89_ENTITY_MODE_MCC) {
+		rtw89_phy_dig_mcc(rtwdev, bb);
+		return;
+	}
+
 	if (!dig->is_linked_pre && is_linked) {
 		rtw89_debug(rtwdev, RTW89_DBG_DIG, "First connected\n");
 		rtw89_phy_dig_update_para(rtwdev, bb);
@@ -6426,19 +6564,7 @@ static void __rtw89_phy_dig(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 	}
 	dig->is_linked_pre = is_linked;
 
-	rtw89_phy_dig_igi_offset_by_env(rtwdev, bb);
-
-	igi_min = max_t(int, dig->igi_rssi - IGI_RSSI_MIN, 0);
-	dig->dyn_igi_max = min(igi_min + IGI_OFFSET_MAX, igi_max_performance_mode);
-	dig->dyn_igi_min = max(igi_min, ABS_IGI_MIN);
-
-	if (dig->dyn_igi_max >= dig->dyn_igi_min) {
-		dig->igi_fa_rssi += dig->fa_rssi_ofst;
-		dig->igi_fa_rssi = clamp(dig->igi_fa_rssi, dig->dyn_igi_min,
-					 dig->dyn_igi_max);
-	} else {
-		dig->igi_fa_rssi = dig->dyn_igi_max;
-	}
+	rtw89_phy_cal_igi_fa_rssi(rtwdev, bb);
 
 	rtw89_debug(rtwdev, RTW89_DBG_DIG,
 		    "rssi=%03d, dyn_joint(max,min)=(%d,%d), final_rssi=%d\n",
-- 
2.25.1


