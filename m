Return-Path: <linux-wireless+bounces-365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D131A802CE3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898FD280F01
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15B3111BB;
	Mon,  4 Dec 2023 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X/MJL9iJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED348CB
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 00:13:48 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B44mINV018535;
	Mon, 4 Dec 2023 08:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+6MQzBZcPePjFKp/PXkJIF0XPcv0wNKzudrBs//zQok=;
 b=X/MJL9iJarPrvvpR22ecScE+r9gbXCGSzQ+uKmVaKij73FcNmEZkl0yg5LW5AX5CpUtv
 NWMCbV7vYFoJoU8Nn480rEDMy6SM21u29IRXyD5KFIYobyhkQ30qRePxRfB0kQjTsDR7
 oM4V9bmgBHBh9lFYy++im+hsDYpBI1epUN/VESST4cdsFUvSINvIN/388chxit0+Nd9y
 JFalPvO0k3G8qpQ1hSUqehSBBlX0BuygrdsFQ6wjx8ioseTjcrna6ucqydR7Rz0Jd4x7
 pSP1aJQgJKQQpKNNyxMEsOsmCs4oRnXY+kW2Dvnqbl/CQr9Gljx78rW752LaJKepnSN4 Hg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqwrvu7r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 08:13:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B48DjW9002098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Dec 2023 08:13:45 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 00:13:44 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v8 07/12] wifi: ath11k: add parse of transmit power envelope element
Date: Mon, 4 Dec 2023 16:13:18 +0800
Message-ID: <20231204081323.5582-8-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204081323.5582-1-quic_bqiang@quicinc.com>
References: <20231204081323.5582-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -e0ciY8su4o_0_LcVJp9EiRyuyOvhR9r
X-Proofpoint-GUID: -e0ciY8su4o_0_LcVJp9EiRyuyOvhR9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040061

From: Wen Gong <quic_wgong@quicinc.com>

The transmit power envelope element has some fields for power, ath11k
should parse it according to IEEE Std 802.11ax™‐2021.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v8:
 add s-o-b tag
v7:
 no change.

 drivers/net/wireless/ath/ath11k/core.h |  38 +++++
 drivers/net/wireless/ath/ath11k/mac.c  | 185 +++++++++++++++++++++++++
 2 files changed, 223 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index cc91f7d3ca8e..7774e487abcf 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -314,6 +314,43 @@ struct ath11k_rekey_data {
 	bool enable_offload;
 };
 
+/**
+ * struct chan_power_info - TPE containing power info per channel chunk
+ * @chan_cfreq: channel center freq (MHz)
+ * e.g.
+ * channel 37/20 MHz,  it is 6135
+ * channel 37/40 MHz,  it is 6125
+ * channel 37/80 MHz,  it is 6145
+ * channel 37/160 MHz, it is 6185
+ * @tx_power: transmit power (dBm)
+ */
+struct chan_power_info {
+	u16 chan_cfreq;
+	s8 tx_power;
+};
+
+/**
+ * struct reg_tpc_power_info - regulatory TPC power info
+ * @is_psd_power: is PSD power or not
+ * @eirp_power: Maximum EIRP power (dBm), valid only if power is PSD
+ * @ap_power_type: type of power (SP/LPI/VLP)
+ * @num_pwr_levels: number of power levels
+ * @reg_max: Array of maximum TX power (dBm) per PSD value
+ * @ap_constraint_power: AP constraint power (dBm)
+ * @tpe: TPE values processed from TPE IE
+ * @chan_power_info: power info to send to firmware
+ */
+struct ath11k_reg_tpc_power_info {
+	bool is_psd_power;
+	u8 eirp_power;
+	enum wmi_reg_6ghz_ap_type ap_power_type;
+	u8 num_pwr_levels;
+	u8 reg_max[IEEE80211_MAX_NUM_PWR_LEVEL];
+	u8 ap_constraint_power;
+	s8 tpe[IEEE80211_MAX_NUM_PWR_LEVEL];
+	struct chan_power_info chan_power_info[IEEE80211_MAX_NUM_PWR_LEVEL];
+};
+
 struct ath11k_vif {
 	u32 vdev_id;
 	enum wmi_vdev_type vdev_type;
@@ -372,6 +409,7 @@ struct ath11k_vif {
 #ifdef CONFIG_ATH11K_DEBUGFS
 	struct dentry *debugfs_twt;
 #endif /* CONFIG_ATH11K_DEBUGFS */
+	struct ath11k_reg_tpc_power_info reg_tpc_info;
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b6ca6fb801f8..7707aec48c1d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7602,6 +7602,189 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static u8 ath11k_mac_get_tpe_count(u8 txpwr_intrprt, u8 txpwr_cnt)
+{
+	switch (txpwr_intrprt) {
+	/* Refer "Table 9-276-Meaning of Maximum Transmit Power Count subfield
+	 * if the Maximum Transmit Power Interpretation subfield is 0 or 2" of
+	 * "IEEE Std 802.11ax 2021".
+	 */
+	case IEEE80211_TPE_LOCAL_EIRP:
+	case IEEE80211_TPE_REG_CLIENT_EIRP:
+		txpwr_cnt = txpwr_cnt <= 3 ? txpwr_cnt : 3;
+		txpwr_cnt = txpwr_cnt + 1;
+		break;
+	/* Refer "Table 9-277-Meaning of Maximum Transmit Power Count subfield
+	 * if Maximum Transmit Power Interpretation subfield is 1 or 3" of
+	 * "IEEE Std 802.11ax 2021".
+	 */
+	case IEEE80211_TPE_LOCAL_EIRP_PSD:
+	case IEEE80211_TPE_REG_CLIENT_EIRP_PSD:
+		txpwr_cnt = txpwr_cnt <= 4 ? txpwr_cnt : 4;
+		txpwr_cnt = txpwr_cnt ? (BIT(txpwr_cnt - 1)) : 1;
+		break;
+	}
+
+	return txpwr_cnt;
+}
+
+static u8 ath11k_mac_get_num_pwr_levels(struct cfg80211_chan_def *chan_def)
+{
+	if (chan_def->chan->flags & IEEE80211_CHAN_PSD) {
+		switch (chan_def->width) {
+		case NL80211_CHAN_WIDTH_20:
+			return 1;
+		case NL80211_CHAN_WIDTH_40:
+			return 2;
+		case NL80211_CHAN_WIDTH_80:
+			return 4;
+		case NL80211_CHAN_WIDTH_80P80:
+		case NL80211_CHAN_WIDTH_160:
+			return 8;
+		default:
+			return 1;
+		}
+	} else {
+		switch (chan_def->width) {
+		case NL80211_CHAN_WIDTH_20:
+			return 1;
+		case NL80211_CHAN_WIDTH_40:
+			return 2;
+		case NL80211_CHAN_WIDTH_80:
+			return 3;
+		case NL80211_CHAN_WIDTH_80P80:
+		case NL80211_CHAN_WIDTH_160:
+			return 4;
+		default:
+			return 1;
+		}
+	}
+}
+
+static void ath11k_mac_parse_tx_pwr_env(struct ath11k *ar,
+					struct ieee80211_vif *vif,
+					struct ieee80211_chanctx_conf *ctx)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	struct ieee80211_tx_pwr_env *single_tpe;
+	enum wmi_reg_6ghz_client_type client_type;
+	struct cur_regulatory_info *reg_info;
+	int i;
+	u8 pwr_count, pwr_interpret, pwr_category;
+	u8 psd_index = 0, non_psd_index = 0, local_tpe_count = 0, reg_tpe_count = 0;
+	bool use_local_tpe, non_psd_set = false, psd_set = false;
+
+	reg_info = &ab->reg_info_store[ar->pdev_idx];
+	client_type = reg_info->client_type;
+
+	for (i = 0; i < bss_conf->tx_pwr_env_num; i++) {
+		single_tpe = &bss_conf->tx_pwr_env[i];
+		pwr_category = u8_get_bits(single_tpe->tx_power_info,
+					   IEEE80211_TX_PWR_ENV_INFO_CATEGORY);
+		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
+					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
+
+		if (pwr_category == client_type) {
+			if (pwr_interpret == IEEE80211_TPE_LOCAL_EIRP ||
+			    pwr_interpret == IEEE80211_TPE_LOCAL_EIRP_PSD)
+				local_tpe_count++;
+			else if (pwr_interpret == IEEE80211_TPE_REG_CLIENT_EIRP ||
+				 pwr_interpret == IEEE80211_TPE_REG_CLIENT_EIRP_PSD)
+				reg_tpe_count++;
+		}
+	}
+
+	if (!reg_tpe_count && !local_tpe_count) {
+		ath11k_warn(ab,
+			    "no transmit power envelope match client power type %d\n",
+			    client_type);
+		return;
+	} else if (!reg_tpe_count) {
+		use_local_tpe = true;
+	} else {
+		use_local_tpe = false;
+	}
+
+	for (i = 0; i < bss_conf->tx_pwr_env_num; i++) {
+		single_tpe = &bss_conf->tx_pwr_env[i];
+		pwr_category = u8_get_bits(single_tpe->tx_power_info,
+					   IEEE80211_TX_PWR_ENV_INFO_CATEGORY);
+		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
+					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
+
+		if (pwr_category != client_type)
+			continue;
+
+		/* get local transmit power envelope */
+		if (use_local_tpe) {
+			if (pwr_interpret == IEEE80211_TPE_LOCAL_EIRP) {
+				non_psd_index = i;
+				non_psd_set = true;
+			} else if (pwr_interpret == IEEE80211_TPE_LOCAL_EIRP_PSD) {
+				psd_index = i;
+				psd_set = true;
+			}
+		/* get regulatory transmit power envelope */
+		} else {
+			if (pwr_interpret == IEEE80211_TPE_REG_CLIENT_EIRP) {
+				non_psd_index = i;
+				non_psd_set = true;
+			} else if (pwr_interpret == IEEE80211_TPE_REG_CLIENT_EIRP_PSD) {
+				psd_index = i;
+				psd_set = true;
+			}
+		}
+	}
+
+	if (non_psd_set && !psd_set) {
+		single_tpe = &bss_conf->tx_pwr_env[non_psd_index];
+		pwr_count = u8_get_bits(single_tpe->tx_power_info,
+					IEEE80211_TX_PWR_ENV_INFO_COUNT);
+		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
+					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
+		arvif->reg_tpc_info.is_psd_power = false;
+		arvif->reg_tpc_info.eirp_power = 0;
+
+		arvif->reg_tpc_info.num_pwr_levels =
+			ath11k_mac_get_tpe_count(pwr_interpret, pwr_count);
+		for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++) {
+			ath11k_dbg(ab, ATH11K_DBG_MAC,
+				   "non PSD power[%d] : %d\n",
+				   i, single_tpe->tx_power[i]);
+			arvif->reg_tpc_info.tpe[i] = single_tpe->tx_power[i] / 2;
+		}
+	}
+
+	if (psd_set) {
+		single_tpe = &bss_conf->tx_pwr_env[psd_index];
+		pwr_count = u8_get_bits(single_tpe->tx_power_info,
+					IEEE80211_TX_PWR_ENV_INFO_COUNT);
+		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
+					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
+		arvif->reg_tpc_info.is_psd_power = true;
+
+		if (pwr_count == 0) {
+			ath11k_dbg(ab, ATH11K_DBG_MAC,
+				   "TPE PSD power : %d\n", single_tpe->tx_power[0]);
+			arvif->reg_tpc_info.num_pwr_levels =
+				ath11k_mac_get_num_pwr_levels(&ctx->def);
+			for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++)
+				arvif->reg_tpc_info.tpe[i] = single_tpe->tx_power[0] / 2;
+		} else {
+			arvif->reg_tpc_info.num_pwr_levels =
+				ath11k_mac_get_tpe_count(pwr_interpret, pwr_count);
+			for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++) {
+				ath11k_dbg(ab, ATH11K_DBG_MAC,
+					   "TPE PSD power[%d] : %d\n",
+					   i, single_tpe->tx_power[i]);
+				arvif->reg_tpc_info.tpe[i] = single_tpe->tx_power[i] / 2;
+			}
+		}
+	}
+}
+
 static int
 ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
@@ -7634,6 +7817,8 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 			goto out;
 		}
 		ath11k_reg_handle_chan_list(ab, reg_info, power_type);
+
+		ath11k_mac_parse_tx_pwr_env(ar, vif, ctx);
 	}
 
 	/* for QCA6390 bss peer must be created before vdev_start */
-- 
2.25.1


