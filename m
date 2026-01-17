Return-Path: <linux-wireless+bounces-30923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0D2D38C4A
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 05:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AA3E302782C
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 04:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C732FE567;
	Sat, 17 Jan 2026 04:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DBaMCQUy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33FD18C02E
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624937; cv=none; b=Kt2eySTiJcW1rGGZqspap4r4TRTYWmK2TRT34CwUAn3O2XpFCrVfOpbb8CmWsgtBXPQgYQzKF/DtvwR4Ml/RjtuR3OE0x7PnmydXqh3smN0ziJ3DUNi0FuRbVdcwz7Z4uYXNCShoeVU9pVCFUSgtqxnOvj/2w3M30+plwC6zOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624937; c=relaxed/simple;
	bh=lfz8FwMlunvgudH6U/6gIHDXlRupGaNBJ0vk6fJzRf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPWVHD2LrGQh93kQd0SFLp3p/egprPm5No9FU1h2PBXo7Pk0Xwzp0S+6VKbfwV0bNram3v4uVGtVCd9gO1QR5Bp6SYoHbQupnHlrkv3an7S6cURaIAmSe/HG8CiZajaBqh222SuSvD8lnqmsr3ORE1EMJpwWxtPnaXgNZas9JC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DBaMCQUy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60H4gD8912464459, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768624933; bh=NGX2lhDa+gvfNlar8GFIo42slLHCuFfY0eLP1fBGMwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DBaMCQUyVXQS/F4vSdqYV9e6BxCdRhhnOjK/5RN6ppLjcH+n3Q/6lfx5uS5O/E5PB
	 ZYOZQpieZfB/tHeUc1v2enXjXMDFsJFushhOq5ocZcUsksPuaa957cd1Uzd1mCKR++
	 9t6cKMvSNnygSDBVJJM9KKH3/Vl9YkCr8lwZgyXTBO/SmH3EzbEDbVH/493w9ZJ1j4
	 0JiDN34lcqCD+lacRqoLMAbDgjtG+cRDaS7HOXSenmwr7IjfxMBBIkiKn06mvqBXBv
	 RMy1cbuoFuVrD5faGkPNzHg26yYjgeruHEyRxlGZLemnxff4tnYx5we4C8LaNwCaOa
	 INi03zaq5E9Hg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60H4gD8912464459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 12:42:13 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:42:13 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 12:42:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 3/9] wifi: rtw89: phy: add H2C command to send detail RX gain and link parameters for PS mode
Date: Sat, 17 Jan 2026 12:41:51 +0800
Message-ID: <20260117044157.2392958-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117044157.2392958-1-pkshih@realtek.com>
References: <20260117044157.2392958-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Eric Huang <echuang@realtek.com>

Introduce support for a new PS multi-link common info version (v1)
for RTL8922D, enabling the driver to send detailed RX gain and link
parameters to firmware via a new H2C command.

A dedicated 20 MHz beacon channel (chan_bcn) that replicates the primary
channel and band type of the original channel but forces a 20 MHz width.
This ensures that beacon mode always reference the 20 MHz gain table,
fixing the mis-assignment that could degrade signal strength or cause
incorrect RSSI calibration.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 155 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  65 +++++++++
 drivers/net/wireless/realtek/rtw89/ps.c   |   2 +
 drivers/net/wireless/realtek/rtw89/reg.h  |   1 +
 5 files changed, 224 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5c3684064d38..509357a1c072 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4767,6 +4767,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_ADDR_CAM_V0,
 	RTW89_FW_FEATURE_SER_L1_BY_EVENT,
 	RTW89_FW_FEATURE_SIM_SER_L0L1_BY_HALT_H2C,
+	RTW89_FW_FEATURE_LPS_ML_INFO_V1,
 
 	NUM_OF_RTW89_FW_FEATURES,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f09387e089a2..329606a5bc20 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3264,6 +3264,161 @@ int rtw89_fw_h2c_lps_ml_cmn_info(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+void rtw89_bb_lps_cmn_info_rx_gain_fill(struct rtw89_dev *rtwdev,
+					struct rtw89_bb_link_info_rx_gain *h2c_gain,
+					const struct rtw89_chan *chan, u8 phy_idx)
+{
+	const struct rtw89_phy_bb_gain_info_be *gain = &rtwdev->bb_gain.be;
+	enum rtw89_bb_link_rx_gain_table_type tab_idx;
+	struct rtw89_chan chan_bcn;
+	u8 bw = chan->band_width;
+	u8 gain_band;
+	u8 bw_idx;
+	u8 path;
+	int i;
+
+	rtw89_chan_create(&chan_bcn, chan->primary_channel, chan->primary_channel,
+			  chan->band_type, RTW89_CHANNEL_WIDTH_20);
+
+	for (tab_idx = RTW89_BB_PS_LINK_RX_GAIN_TAB_BCN_PATH_A;
+	     tab_idx < RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX; tab_idx++) {
+		struct rtw89_phy_calc_efuse_gain calc = {};
+
+		path = (tab_idx & BIT(0)) ? (RF_PATH_B) : (RF_PATH_A);
+		if (tab_idx & BIT(1)) {
+			rtw89_chip_calc_rx_gain_normal(rtwdev, chan, path, phy_idx,
+						       &calc);
+			gain_band = rtw89_subband_to_gain_band_be(chan->subband_type);
+			if (bw > RTW89_CHANNEL_WIDTH_40)
+				bw_idx = RTW89_BB_BW_80_160_320;
+			else
+				bw_idx = RTW89_BB_BW_20_40;
+		} else {
+			rtw89_chip_calc_rx_gain_normal(rtwdev, &chan_bcn, path, phy_idx,
+						       &calc);
+			gain_band = rtw89_subband_to_gain_band_be(chan_bcn.subband_type);
+			bw_idx = RTW89_BB_BW_20_40;
+		}
+
+		/* efuse ofst and comp */
+		h2c_gain->gain_ofst[tab_idx] = calc.rssi_ofst;
+		h2c_gain->cck_gain_ofst[tab_idx] = calc.cck_rpl_ofst;
+		h2c_gain->cck_rpl_bias_comp[tab_idx][0] = calc.cck_mean_gain_bias;
+		h2c_gain->cck_rpl_bias_comp[tab_idx][1] = calc.cck_mean_gain_bias;
+
+		for (i = 0; i < TIA_GAIN_NUM; i++) {
+			h2c_gain->gain_err_tia[tab_idx][i] =
+				cpu_to_le16(gain->tia_gain[gain_band][bw_idx][path][i]);
+		}
+		memcpy(h2c_gain->gain_err_lna[tab_idx],
+		       gain->lna_gain[gain_band][bw_idx][path],
+		       LNA_GAIN_NUM);
+		memcpy(h2c_gain->op1db_lna[tab_idx],
+		       gain->lna_op1db[gain_band][bw_idx][path],
+		       LNA_GAIN_NUM);
+		memcpy(h2c_gain->op1db_tia[tab_idx],
+		       gain->tia_lna_op1db[gain_band][bw_idx][path],
+		       LNA_GAIN_NUM + 1);
+
+		memcpy(h2c_gain->rpl_bias_comp_bw[tab_idx]._20M,
+		       gain->rpl_ofst_20[gain_band][path],
+		       RTW89_BW20_SC_20M);
+		memcpy(h2c_gain->rpl_bias_comp_bw[tab_idx]._40M,
+		       gain->rpl_ofst_40[gain_band][path],
+		       RTW89_BW20_SC_40M);
+		memcpy(h2c_gain->rpl_bias_comp_bw[tab_idx]._80M,
+		       gain->rpl_ofst_80[gain_band][path],
+		       RTW89_BW20_SC_80M);
+		memcpy(h2c_gain->rpl_bias_comp_bw[tab_idx]._160M,
+		       gain->rpl_ofst_160[gain_band][path],
+		       RTW89_BW20_SC_160M);
+	}
+}
+
+int rtw89_fw_h2c_lps_ml_cmn_info_v1(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif)
+{
+	static const u8 bcn_bw_ofst[] = {0, 0, 0, 3, 6, 9, 0, 12};
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	struct rtw89_h2c_lps_ml_cmn_info_v1 *h2c;
+	struct rtw89_vif_link *rtwvif_link;
+	const struct rtw89_chan *chan;
+	struct rtw89_bb_ctx *bb;
+	u32 len = sizeof(*h2c);
+	unsigned int link_id;
+	struct sk_buff *skb;
+	u8 beacon_bw_ofst;
+	u32 done;
+	int ret;
+
+	if (chip->chip_gen != RTW89_CHIP_BE)
+		return 0;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c lps_ml_cmn_info_v1\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_lps_ml_cmn_info_v1 *)skb->data;
+
+	h2c->fmt_id = 0x20;
+
+	h2c->mlo_dbcc_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
+	h2c->rfe_type = efuse->rfe_type;
+	h2c->rssi_main = U8_MAX;
+
+	memset(h2c->link_id, 0xfe, RTW89_BB_PS_LINK_BUF_MAX);
+
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+		u8 phy_idx = rtwvif_link->phy_idx;
+
+		bb = rtw89_get_bb_ctx(rtwdev, phy_idx);
+		chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+
+		h2c->link_id[phy_idx] = phy_idx;
+		h2c->central_ch[phy_idx] = chan->channel;
+		h2c->pri_ch[phy_idx] = chan->primary_channel;
+		h2c->band[phy_idx] = chan->band_type;
+		h2c->bw[phy_idx] = chan->band_width;
+
+		if (rtwvif_link->bcn_bw_idx < ARRAY_SIZE(bcn_bw_ofst)) {
+			beacon_bw_ofst = bcn_bw_ofst[rtwvif_link->bcn_bw_idx];
+			h2c->dup_bcn_ofst[phy_idx] = beacon_bw_ofst;
+		}
+
+		if (h2c->rssi_main > bb->ch_info.rssi_min)
+			h2c->rssi_main = bb->ch_info.rssi_min;
+
+		rtw89_bb_lps_cmn_info_rx_gain_fill(rtwdev,
+						   &h2c->rx_gain[phy_idx],
+						   chan, phy_idx);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_DM,
+			      H2C_FUNC_FW_LPS_ML_CMN_INFO, 0, 0, len);
+
+	rtw89_phy_write32_mask(rtwdev, R_CHK_LPS_STAT_BE4, B_CHK_LPS_STAT, 0);
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	ret = read_poll_timeout(rtw89_phy_read32_mask, done, done, 50, 5000,
+				true, rtwdev, R_CHK_LPS_STAT_BE4, B_CHK_LPS_STAT);
+	if (ret)
+		rtw89_warn(rtwdev, "h2c_lps_ml_cmn_info done polling timeout\n");
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 #define H2C_P2P_ACT_LEN 20
 int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev,
 			 struct rtw89_vif_link *rtwvif_link,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 12e798f01df7..146403d285b4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2017,6 +2017,66 @@ struct rtw89_h2c_lps_ml_cmn_info {
 	u8 dup_bcn_ofst[RTW89_PHY_NUM];
 } __packed;
 
+#define BB_RX_GAIN_TB_RSSI_COMP_NUM 3
+#define BB_RX_GAIN_CCK_RPL_BIAS_COMP_NUM 2
+#define BB_GT2_GS_IDX_NUM 11
+#define BB_GT2_WB_GIDX_ELNA_NUM 16
+#define BB_GT2_G_ELNA_NUM 2
+
+enum rtw89_bb_link_rx_gain_table_type {
+	RTW89_BB_PS_LINK_RX_GAIN_TAB_BCN_PATH_A = 0x00,
+	RTW89_BB_PS_LINK_RX_GAIN_TAB_BCN_PATH_B = 0x01,
+	RTW89_BB_PS_LINK_RX_GAIN_TAB_NOR_PATH_A = 0x02,
+	RTW89_BB_PS_LINK_RX_GAIN_TAB_NOR_PATH_B = 0x03,
+	RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX,
+};
+
+enum rtw89_bb_ps_link_buf_id {
+	RTW89_BB_PS_LINK_BUF_0 = 0x00,
+	RTW89_BB_PS_LINK_BUF_1 = 0x01,
+	RTW89_BB_PS_LINK_BUF_2 = 0x02,
+	RTW89_BB_PS_LINK_BUF_MAX,
+};
+
+struct rtw89_bb_link_info_rx_gain {
+	u8 gain_ofst[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX];
+	__le16 rpl_bias_comp[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX];
+	u8 tb_rssi_m_bias_comp[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX]
+			      [BB_RX_GAIN_TB_RSSI_COMP_NUM];
+	u8 cck_gain_ofst[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX];
+	u8 cck_rpl_bias_comp[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX]
+			    [BB_RX_GAIN_CCK_RPL_BIAS_COMP_NUM];
+	u8 gain_err_lna[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX][LNA_GAIN_NUM];
+	__le16 gain_err_tia[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX][TIA_GAIN_NUM];
+	u8 op1db_lna[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX][LNA_GAIN_NUM];
+	u8 op1db_tia[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX][TIA_LNA_OP1DB_NUM];
+	struct {
+		u8 _20M[RTW89_BW20_SC_20M];
+		u8 _40M[RTW89_BW20_SC_40M];
+		u8 _80M[RTW89_BW20_SC_80M];
+		u8 _160M[RTW89_BW20_SC_160M];
+	} rpl_bias_comp_bw[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX];
+	u8 wb_gs[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX][BB_GT2_GS_IDX_NUM];
+	u8 bypass_lna[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX][LNA_GAIN_NUM];
+	u8 wb_lna_tia[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX][BB_GT2_WB_GIDX_ELNA_NUM];
+	u8 wb_g_elna[RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX][BB_GT2_G_ELNA_NUM];
+} __packed;
+
+struct rtw89_h2c_lps_ml_cmn_info_v1 {
+	u8 fmt_id;
+	u8 rfe_type;
+	u8 rssi_main;
+	u8 rsvd0;
+	__le32 mlo_dbcc_mode;
+	u8 link_id[RTW89_BB_PS_LINK_BUF_MAX];
+	u8 central_ch[RTW89_BB_PS_LINK_BUF_MAX];
+	u8 pri_ch[RTW89_BB_PS_LINK_BUF_MAX];
+	u8 bw[RTW89_BB_PS_LINK_BUF_MAX];
+	u8 band[RTW89_BB_PS_LINK_BUF_MAX];
+	u8 dup_bcn_ofst[RTW89_BB_PS_LINK_BUF_MAX];
+	struct rtw89_bb_link_info_rx_gain rx_gain[RTW89_BB_PS_LINK_BUF_MAX];
+} __packed;
+
 struct rtw89_h2c_trig_cpu_except {
 	__le32 w0;
 } __packed;
@@ -5204,6 +5264,11 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_lps_ml_cmn_info(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif);
+void rtw89_bb_lps_cmn_info_rx_gain_fill(struct rtw89_dev *rtwdev,
+					struct rtw89_bb_link_info_rx_gain *h2c_gain,
+					const struct rtw89_chan *chan, u8 phy_idx);
+int rtw89_fw_h2c_lps_ml_cmn_info_v1(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       bool enable);
 struct sk_buff *rtw89_fw_h2c_alloc_skb_with_hdr(struct rtw89_dev *rtwdev, u32 len);
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index abd8aee02b47..aad2ee7926d6 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -189,6 +189,8 @@ void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 	if (RTW89_CHK_FW_FEATURE(LPS_CH_INFO, &rtwdev->fw))
 		rtw89_fw_h2c_lps_ch_info(rtwdev, rtwvif);
+	else if (RTW89_CHK_FW_FEATURE(LPS_ML_INFO_V1, &rtwdev->fw))
+		rtw89_fw_h2c_lps_ml_cmn_info_v1(rtwdev, rtwvif);
 	else
 		rtw89_fw_h2c_lps_ml_cmn_info(rtwdev, rtwvif);
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index efeb4507b1a9..14f4f9f7f10d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8551,6 +8551,7 @@
 #define B_UPD_P0_EN BIT(31)
 #define R_EMLSR 0x0044
 #define B_EMLSR_PARM GENMASK(27, 12)
+#define R_CHK_LPS_STAT_BE4 0x3007C
 #define R_CHK_LPS_STAT 0x0058
 #define B_CHK_LPS_STAT BIT(0)
 #define R_SPOOF_CG 0x00B4
-- 
2.25.1


