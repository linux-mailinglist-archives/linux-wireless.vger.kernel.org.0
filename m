Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E457A5AB3
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 09:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjISHRy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 03:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjISHRw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 03:17:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86235114
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 00:17:46 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6AMhg004241;
        Tue, 19 Sep 2023 07:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bJqnVn94yNw7ttY7XcJcoWw+B4a9+oBC2b1SrrlC/Qc=;
 b=QVPXAEHwH0PYztPF5PUdeNTNk3QHgYer2HrjYD0rgW31SgRTXXPcOwbown2dwe2NhxYQ
 iQRZ7pEuav0mSkBynrKOrQagdVvyBuOcStMC+eHTRQIA1XMSz+ohd17JRdbHovC6b+Is
 a/PhWTxihbpm16LefxDmDU2xEpRXa8vjSNP/7qIkFBmNQBGQpoMkAbRejgB4ooN1DUDb
 n8Xn2LX59mO8trqepAU9RoYMGE1d/WFfFbw4sap8D+sLPQSV0JSp5zurbebiE4ZcU/G+
 6igBtNguoeIP3yrDGe/8mt9FYdAIoqnjmetpMJUIBFxNEvuvtwrx/MI7BMvAtfbVwPZi NA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6pmq1ysy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:17:44 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38J6mroY009897;
        Tue, 19 Sep 2023 07:17:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 3t55emdapw-1;
        Tue, 19 Sep 2023 07:17:43 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J7CQpX020367;
        Tue, 19 Sep 2023 07:17:43 GMT
Received: from aisr-linux.qualcomm.com (aisr-linux.qualcomm.com [10.201.124.194])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 38J7HgsH030131;
        Tue, 19 Sep 2023 07:17:43 +0000
Received: by aisr-linux.qualcomm.com (Postfix, from userid 4090849)
        id 6C99AE020C5; Tue, 19 Sep 2023 12:47:41 +0530 (IST)
From:   Aishwarya R <quic_aisr@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Aishwarya R <quic_aisr@quicinc.com>
Subject: [PATCH 5/7] wifi: ath12k: add parse of transmit power envelope element
Date:   Tue, 19 Sep 2023 12:47:22 +0530
Message-Id: <20230919071724.15505-6-quic_aisr@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230919071724.15505-1-quic_aisr@quicinc.com>
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kQEXkygNRRMtYxMHkmtbse5dJJ5pYY1s
X-Proofpoint-ORIG-GUID: kQEXkygNRRMtYxMHkmtbse5dJJ5pYY1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_01,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=954 mlxscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190060
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The transmit power envelope element has some fields for power, ath12k
should parse it according to IEEE Std 802.11ax™‐2021.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  38 +++++
 drivers/net/wireless/ath/ath12k/mac.c  | 194 +++++++++++++++++++++++++
 2 files changed, 232 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 9439052a652e..01768fe79bd6 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -187,6 +187,43 @@ enum ath12k_monitor_flags {
 	ATH12K_FLAG_MONITOR_ENABLED,
 };
 
+/**
+ * struct chan_power_info - TPE containing power info per channel chunk
+ * @chan_cfreq: channel center freq (MHz)
+ * e.g.
+ * channel 37/20MHz,  it is 6135
+ * channel 37/40MHz,  it is 6125
+ * channel 37/80MHz,  it is 6145
+ * channel 37/160MHz, it is 6185
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
+ * @power_type_6ghz: type of power (SP/LPI/VLP)
+ * @num_pwr_levels: number of power levels
+ * @reg_max: Array of maximum TX power (dBm) per PSD value
+ * @ap_constraint_power: AP constraint power (dBm)
+ * @tpe: TPE values processed from TPE IE
+ * @chan_power_info: power info to send to FW
+ */
+struct ath12k_reg_tpc_power_info {
+	bool is_psd_power;
+	u8 eirp_power;
+	enum wmi_reg_6g_ap_type power_type_6ghz;
+	u8 num_pwr_levels;
+	u8 reg_max[IEEE80211_MAX_NUM_PWR_LEVEL];
+	u8 ap_constraint_power;
+	s8 tpe[IEEE80211_MAX_NUM_PWR_LEVEL];
+	struct chan_power_info chan_power_info[IEEE80211_MAX_NUM_PWR_LEVEL];
+};
+
 struct ath12k_vif {
 	u32 vdev_id;
 	enum wmi_vdev_type vdev_type;
@@ -235,6 +272,7 @@ struct ath12k_vif {
 	bool rsnie_present;
 	bool wpaie_present;
 	struct ieee80211_chanctx_conf chanctx;
+	struct ath12k_reg_tpc_power_info reg_tpc_info;
 	u32 key_cipher;
 	u8 tx_encap_type;
 	u8 vdev_stats_id;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 01f81b087fa2..0683b22137b0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5812,6 +5812,197 @@ static int ath12k_start_vdev_delay(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static u8 ath12k_mac_get_tpe_count(u8 txpwr_intrprt, u8 txpwr_cnt)
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
+static u8 ath12k_mac_get_num_pwr_levels(struct cfg80211_chan_def *chan_def)
+{
+	u8 num_pwr_levels;
+
+	if (chan_def->chan->flags & IEEE80211_CHAN_PSD) {
+		switch (chan_def->width) {
+		case NL80211_CHAN_WIDTH_20:
+			num_pwr_levels = 1;
+			break;
+		case NL80211_CHAN_WIDTH_40:
+			num_pwr_levels = 2;
+			break;
+		case NL80211_CHAN_WIDTH_80:
+			num_pwr_levels = 4;
+			break;
+		case NL80211_CHAN_WIDTH_80P80:
+		case NL80211_CHAN_WIDTH_160:
+			num_pwr_levels = 8;
+			break;
+		default:
+			return 1;
+		}
+	} else {
+		switch (chan_def->width) {
+		case NL80211_CHAN_WIDTH_20:
+			num_pwr_levels = 1;
+			break;
+		case NL80211_CHAN_WIDTH_40:
+			num_pwr_levels = 2;
+			break;
+		case NL80211_CHAN_WIDTH_80:
+			num_pwr_levels = 3;
+			break;
+		case NL80211_CHAN_WIDTH_80P80:
+		case NL80211_CHAN_WIDTH_160:
+			num_pwr_levels = 4;
+			break;
+		default:
+			return 1;
+		}
+	}
+
+	return num_pwr_levels;
+}
+
+static void ath12k_mac_parse_tx_pwr_env(struct ath12k *ar,
+					struct ieee80211_vif *vif,
+					struct ieee80211_chanctx_conf *ctx)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_vif *arvif = (void *)vif->drv_priv;
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	struct ieee80211_tx_pwr_env *single_tpe;
+	enum wmi_reg_6g_client_type client_type;
+	int i;
+	u8 pwr_count, pwr_interpret, pwr_category;
+	u8 psd_index = 0, non_psd_index = 0, local_tpe_count = 0, reg_tpe_count = 0;
+	bool use_local_tpe, non_psd_set = false, psd_set = false;
+
+	client_type = WMI_REG_DEFAULT_CLIENT;
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
+		ath12k_warn(ab,
+			    "no transmit power envelope match client power type %d\n",
+			    client_type);
+		return;
+	} else if (!reg_tpe_count) {
+		use_local_tpe = true;
+	} else {
+		use_local_tpe = false;
+	}
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
+			ath12k_mac_get_tpe_count(pwr_interpret, pwr_count);
+		for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++) {
+			ath12k_dbg(ab, ATH12K_DBG_MAC,
+				   "non PSD power[%d] : %d\n",
+				   i, single_tpe->tx_power[i]);
+		arvif->reg_tpc_info.tpe[i] = single_tpe->tx_power[i] / 2;
+		}
+	}
+	if (psd_set) {
+		single_tpe = &bss_conf->tx_pwr_env[psd_index];
+		pwr_count = u8_get_bits(single_tpe->tx_power_info,
+					IEEE80211_TX_PWR_ENV_INFO_COUNT);
+		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
+					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
+		arvif->reg_tpc_info.is_psd_power = true;
+
+		if (pwr_count == 0) {
+			ath12k_dbg(ab, ATH12K_DBG_MAC,
+				   "TPE PSD power : %d\n", single_tpe->tx_power[0]);
+			arvif->reg_tpc_info.num_pwr_levels =
+				ath12k_mac_get_num_pwr_levels(&ctx->def);
+			for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++)
+				arvif->reg_tpc_info.tpe[i] = single_tpe->tx_power[0] / 2;
+		} else {
+			arvif->reg_tpc_info.num_pwr_levels =
+				ath12k_mac_get_tpe_count(pwr_interpret, pwr_count);
+			for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++) {
+				ath12k_dbg(ab, ATH12K_DBG_MAC,
+					   "TPE PSD power[%d] : %d\n",
+					   i, single_tpe->tx_power[i]);
+			arvif->reg_tpc_info.tpe[i] = single_tpe->tx_power[i] / 2;
+			}
+		}
+	}
+}
+
 static int
 ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
@@ -5839,6 +6030,9 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 			   power_type);
 		if (power_type == IEEE80211_REG_UNSET_AP)
 			power_type = IEEE80211_REG_LPI_AP;
+
+		if (arvif->vdev_type == WMI_VDEV_TYPE_STA)
+			ath12k_mac_parse_tx_pwr_env(ar, vif, ctx);
 	}
 
 	/* for some targets bss peer must be created before vdev_start */
-- 
2.17.1

