Return-Path: <linux-wireless+bounces-15951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DAE9E670D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 06:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85254166026
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 05:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58296198E71;
	Fri,  6 Dec 2024 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KTBo44FJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00211B78E7
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464672; cv=none; b=U8JzvmHVRiV7I733tvpFPUsEN39OnjdhoS5BYq4fMDeXjY5qsa20xB1iDj0RlcUPXxl8FyO8NffWOdRoibpGPdeL7DbMBz19HsgvRBiAIXsYyupMq+j0i9m66tfn2Ux2QOGggVwgY+55UJbgKdB6GBqUG9Gy4jdiYrMxOHdtzfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464672; c=relaxed/simple;
	bh=L42tHAcW7zxnszftcjf3Nj6J9HR4nWZNcgnNGZBw/bQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNMnuqSIdMkqVs0wKSflpfSFyA0lrixMxpU3PMdn4qCG2R802uXX3P0BBk3kyzvyIpIj/410B3yjZhCC5u2ATiMAHg+NabQ5HtnUKTEjA4fUHGk6cwc8AzMmU6xJzr7v5kI6K4Bl0CJzOaB9ra/9OPxm58pR1ccOlH8Yrzts8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KTBo44FJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B65vlnM74127293, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733464667; bh=L42tHAcW7zxnszftcjf3Nj6J9HR4nWZNcgnNGZBw/bQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KTBo44FJ83g+Doi1BCX8lvVFbME/MNuf/JJL1YbSwuoK1uwTI5FjrLkKaSUwpk9e8
	 VFMtlS0GxXJLuVZPwC5jLDltTuxfwW6Tm0YpqtzgUcinOkwXpQAl7PUhHVWqf5fRUZ
	 7E6MARxs6oq89ft0lCEEfD0KNlxY6gUGvWDdA5sRr/QsabBScEpx5L7/jXdmaV0GsR
	 gfPgVteUCxs5HSslwc8kvs5rmprGBh6OYN7JSYFrfZo1FQ5dvecZgn8kHXKGb08jj/
	 c2f2fMXX+T9RE4PbSGZ/+HSss8yqUmzqGfrMmaqdtoFjeA7ZkgQDpy5Ro9HNLkyic7
	 ptmALFlclIRmw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B65vlnM74127293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Dec 2024 13:57:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 13:57:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Dec
 2024 13:57:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 3/7] wifi: rtw89: ps: update data for firmware and settings for hardware before/after PS
Date: Fri, 6 Dec 2024 13:57:12 +0800
Message-ID: <20241206055716.18598-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206055716.18598-1-pkshih@realtek.com>
References: <20241206055716.18598-1-pkshih@realtek.com>
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

From: Eric Huang <echuang@realtek.com>

For MLO supported IC, send H2C command to firmware before PS with link
information for each PHY for MLO to work properly. And re-init hardware
settings regarding to RX descriptor information after PS.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  2 +
 drivers/net/wireless/realtek/rtw89/core.h |  2 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 82 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   | 18 +++++
 drivers/net/wireless/realtek/rtw89/phy.c  |  6 ++
 drivers/net/wireless/realtek/rtw89/phy.h  |  1 +
 drivers/net/wireless/realtek/rtw89/ps.c   |  8 ++-
 7 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0519b0826281..ee6ad185135c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2189,6 +2189,8 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 
 		if (phy_ppdu)
 			ewma_rssi_add(&rtwdev->phystat.bcn_rssi, phy_ppdu->rssi_avg);
+
+		pkt_stat->beacon_rate = desc_info->data_rate;
 	}
 
 	if (!ether_addr_equal(bss_conf->addr, hdr->addr1))
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 82844e470d1b..ec2a80af04bb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4466,6 +4466,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_NO_WOW_CPU_IO_RX,
 	RTW89_FW_FEATURE_NOTIFY_AP_INFO,
 	RTW89_FW_FEATURE_CH_INFO_BE_V0,
+	RTW89_FW_FEATURE_LPS_CH_INFO,
 };
 
 struct rtw89_fw_suit {
@@ -4835,6 +4836,7 @@ struct rtw89_pkt_drop_params {
 
 struct rtw89_pkt_stat {
 	u16 beacon_nr;
+	u8 beacon_rate;
 	u32 rx_rate_cnt[RTW89_HW_RATE_NR];
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d17c6037c9a6..e5f3efe3a7e6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -729,6 +729,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 12, 0, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 22, 0, WOW_REASON_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 31, 0, RFK_PRE_NOTIFY_V0),
+	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 31, 0, LPS_CH_INFO),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 42, 0, RFK_RXDCK_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 46, 0, NOTIFY_AP_INFO),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 47, 0, CH_INFO_BE_V0),
@@ -2664,6 +2665,87 @@ int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	return ret;
 }
 
+int rtw89_fw_h2c_lps_ml_cmn_info(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif)
+{
+	const struct rtw89_phy_bb_gain_info_be *gain = &rtwdev->bb_gain.be;
+	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_h2c_lps_ml_cmn_info *h2c;
+	struct rtw89_vif_link *rtwvif_link;
+	const struct rtw89_chan *chan;
+	u8 bw_idx = RTW89_BB_BW_20_40;
+	u32 len = sizeof(*h2c);
+	unsigned int link_id;
+	struct sk_buff *skb;
+	u8 gain_band;
+	u32 done;
+	u8 path;
+	int ret;
+	int i;
+
+	if (chip->chip_gen != RTW89_CHIP_BE)
+		return 0;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c lps_ml_cmn_info\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_lps_ml_cmn_info *)skb->data;
+
+	h2c->fmt_id = 0x1;
+
+	h2c->mlo_dbcc_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
+
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+		path = rtwvif_link->phy_idx == RTW89_PHY_1 ? RF_PATH_B : RF_PATH_A;
+		chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+		gain_band = rtw89_subband_to_gain_band_be(chan->subband_type);
+
+		h2c->central_ch[rtwvif_link->phy_idx] = chan->channel;
+		h2c->pri_ch[rtwvif_link->phy_idx] = chan->primary_channel;
+		h2c->band[rtwvif_link->phy_idx] = chan->band_type;
+		h2c->bw[rtwvif_link->phy_idx] = chan->band_width;
+		if (pkt_stat->beacon_rate < RTW89_HW_RATE_OFDM6)
+			h2c->bcn_rate_type[rtwvif_link->phy_idx] = 0x1;
+		else
+			h2c->bcn_rate_type[rtwvif_link->phy_idx] = 0x2;
+
+		/* Fill BW20 RX gain table for beacon mode */
+		for (i = 0; i < TIA_GAIN_NUM; i++) {
+			h2c->tia_gain[rtwvif_link->phy_idx][i] =
+				cpu_to_le16(gain->tia_gain[gain_band][bw_idx][path][i]);
+		}
+		memcpy(h2c->lna_gain[rtwvif_link->phy_idx],
+		       gain->lna_gain[gain_band][bw_idx][path],
+		       LNA_GAIN_NUM);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_DM,
+			      H2C_FUNC_FW_LPS_ML_CMN_INFO, 0, 0, len);
+
+	rtw89_phy_write32_mask(rtwdev, R_CHK_LPS_STAT, B_CHK_LPS_STAT, 0);
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	ret = read_poll_timeout(rtw89_phy_read32_mask, done, done, 50, 5000,
+				true, rtwdev, R_CHK_LPS_STAT, B_CHK_LPS_STAT);
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
index b38705868caa..2dfc584da7d6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1783,6 +1783,21 @@ struct rtw89_h2c_lps_ch_info {
 	__le32 mlo_dbcc_mode_lps;
 } __packed;
 
+struct rtw89_h2c_lps_ml_cmn_info {
+	u8 fmt_id;
+	u8 rsvd0[3];
+	__le32 mlo_dbcc_mode;
+	u8 central_ch[RTW89_PHY_MAX];
+	u8 pri_ch[RTW89_PHY_MAX];
+	u8 bw[RTW89_PHY_MAX];
+	u8 band[RTW89_PHY_MAX];
+	u8 bcn_rate_type[RTW89_PHY_MAX];
+	u8 rsvd1[2];
+	__le16 tia_gain[RTW89_PHY_MAX][TIA_GAIN_NUM];
+	u8 lna_gain[RTW89_PHY_MAX][LNA_GAIN_NUM];
+	u8 rsvd2[2];
+} __packed;
+
 static inline void RTW89_SET_FWCMD_CPU_EXCEPTION_TYPE(void *cmd, u32 val)
 {
 	le32p_replace_bits((__le32 *)cmd, val, GENMASK(31, 0));
@@ -4211,6 +4226,7 @@ enum rtw89_mrc_h2c_func {
 
 #define H2C_CL_OUTSRC_DM		0x2
 #define H2C_FUNC_FW_LPS_CH_INFO		0xb
+#define H2C_FUNC_FW_LPS_ML_CMN_INFO	0xe
 
 #define H2C_CL_OUTSRC_RF_REG_A		0x8
 #define H2C_CL_OUTSRC_RF_REG_B		0x9
@@ -4639,6 +4655,8 @@ int rtw89_fw_h2c_init_ba_cam_users(struct rtw89_dev *rtwdev, u8 users,
 int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 			  struct rtw89_lps_parm *lps_param);
 int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+int rtw89_fw_h2c_lps_ml_cmn_info(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       bool enable);
 struct sk_buff *rtw89_fw_h2c_alloc_skb_with_hdr(struct rtw89_dev *rtwdev, u32 len);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 8d36bf962732..1d4d3dcce060 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6519,6 +6519,12 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 	rtw89_chip_cfg_txrx_path(rtwdev);
 }
 
+void rtw89_phy_dm_reinit(struct rtw89_dev *rtwdev)
+{
+	rtw89_phy_env_monitor_init(rtwdev);
+	rtw89_physts_parsing_init(rtwdev);
+}
+
 void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif_link *rtwvif_link)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index e6d06f0a6c09..cf33c1655b7a 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -813,6 +813,7 @@ void rtw89_phy_config_rf_reg_v1(struct rtw89_dev *rtwdev,
 				enum rtw89_rf_path rf_path,
 				void *extra_data);
 void rtw89_phy_dm_init(struct rtw89_dev *rtwdev);
+void rtw89_phy_dm_reinit(struct rtw89_dev *rtwdev);
 void rtw89_phy_write32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			   u32 data, enum rtw89_phy_idx phy_idx);
 void rtw89_phy_write32_idx_set(struct rtw89_dev *rtwdev, u32 addr, u32 bits,
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index a8b4b9095dc8..96ea04d90cd3 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -8,6 +8,7 @@
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
+#include "phy.h"
 #include "ps.h"
 #include "reg.h"
 #include "util.h"
@@ -136,7 +137,10 @@ void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			can_ps_mode = false;
 	}
 
-	rtw89_fw_h2c_lps_ch_info(rtwdev, rtwvif);
+	if (RTW89_CHK_FW_FEATURE(LPS_CH_INFO, &rtwdev->fw))
+		rtw89_fw_h2c_lps_ch_info(rtwdev, rtwvif);
+	else
+		rtw89_fw_h2c_lps_ml_cmn_info(rtwdev, rtwvif);
 
 	if (ps_mode && can_ps_mode)
 		__rtw89_enter_ps_mode(rtwdev);
@@ -165,6 +169,8 @@ void rtw89_leave_lps(struct rtw89_dev *rtwdev)
 
 	__rtw89_leave_ps_mode(rtwdev);
 
+	rtw89_phy_dm_reinit(rtwdev);
+
 	rtw89_for_each_rtwvif(rtwdev, rtwvif)
 		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
 			rtw89_leave_lps_vif(rtwdev, rtwvif_link);
-- 
2.25.1


