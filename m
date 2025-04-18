Return-Path: <linux-wireless+bounces-21710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF7A9305B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 05:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2EB1B656F9
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051A268FED;
	Fri, 18 Apr 2025 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Trut2AnU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FABF268C7C;
	Fri, 18 Apr 2025 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744945173; cv=none; b=pA1Z3eRMUtTmUMUEyHXdwKCSXKyU7uyWIEdhso8T1kYRRIxJ6SP3NgYrRMWgHUpIuxyzUOX7dkkexT40IVY1H0PSmCGFEQ3DJlyL7zZLXudC9zacjJSbsF+eJi9jC0o/ncEOZRdXh1VcBk04EgOHEnO1r+5BNMNCCvj4+BT1so4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744945173; c=relaxed/simple;
	bh=xDlA933+86jwD8GfbBfiPUe9S9xmELU33QWtBSQJQiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EN+GbyCiog3jOzx7meIcjlz0yk5H1qBi6Qp/+otaIyhLnH7sc/yx044Zzn7XyOEtu1w7A4JMRmB/XOd88FUK2n6H4piFnkxg7a6IXRrJPy2L4Thkh+CMuxfWSPcwhpunf0pzrx0d+JG3/PSGz1bJqW0B3feqZnDJqJ0wUJJgd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Trut2AnU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClNEm015930;
	Fri, 18 Apr 2025 02:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ogKk7Ch4n5KRdey7TSKOBxUhF8fwc5Le2tMxYatMVrc=; b=Trut2AnUgVUx+l8l
	/IJbyOuFIXOAaT7gzOKYHjrmb+L6fbGkiXsv51UCR0X2i/OappfYkoYYvNqTczgY
	5s3ZC/o9OkJQ+7dftrpvbCym7y56qRNW1So3MVX5DZ+iNrtUK4Ajl8OOpPijAkJi
	UE4LGFweo/Arcs7uHtSn3RAilXJ7aLQNaFm6gP12aKRtaQkUp94BduI8xwpdEva8
	EWo+qhtiwpq5bY21oxVGWwx6bx4eWwaYhor+8WfZ4atNaYNpQDp+gTbwhfyIwhL3
	kloneoW2lKOWNEBR0piiVZnS45TgvgmheERM29iDppvHDuxZOKf+3fVjT+SSgkuz
	bVQArQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydhqh1jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I2uFTJ021569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:15 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 19:56:13 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 18 Apr 2025 10:55:44 +0800
Subject: [PATCH ath-next 11/15] wifi: ath12k: add parse of transmit power
 envelope element
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250418-ath12k-6g-lp-vlp-v1-11-c869c86cad60@quicinc.com>
References: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
In-Reply-To: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T_w57GWg5TQfDpAFtD5gLAzYx6Y53No0
X-Authority-Analysis: v=2.4 cv=C7DpyRP+ c=1 sm=1 tr=0 ts=6801bf50 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=BOI7iK2FISCZ2k_OSdsA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: T_w57GWg5TQfDpAFtD5gLAzYx6Y53No0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180020

The Transmit Power Envelope element conveys the local maximum transmit
power for various transmission bandwidths, this element is present in
various frames, e.g. beacon and probe response etc, transmitted by AP.
A station shall determine a local maximum transmit power from it.

So parse and save them for later use.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +
 drivers/net/wireless/ath/ath12k/mac.c  | 71 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h  | 40 +++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ef65e8b35b8cdac395ef456d0d9aa0c338b7da03..9f64fa00b131357c5c1b75f4eacae912f563416d 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -317,6 +317,8 @@ struct ath12k_link_vif {
 
 	/* only used in station mode */
 	bool is_sta_assoc_link;
+
+	struct ath12k_reg_tpc_power_info reg_tpc_info;
 };
 
 struct ath12k_vif {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4d59572ff207dd084b32bff51fa973e525f2aa70..c2f3aa3ce60a32b288590bd81cdcdabe6fab547e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9742,6 +9742,72 @@ static int ath12k_start_vdev_delay(struct ath12k *ar,
 	return 0;
 }
 
+static void ath12k_mac_parse_tx_pwr_env(struct ath12k *ar,
+					struct ath12k_link_vif *arvif)
+{
+	struct ieee80211_bss_conf *bss_conf = ath12k_mac_get_link_bss_conf(arvif);
+	struct ath12k_reg_tpc_power_info *tpc_info = &arvif->reg_tpc_info;
+	struct ieee80211_parsed_tpe_eirp *local_non_psd, *reg_non_psd;
+	struct ieee80211_parsed_tpe_psd *local_psd, *reg_psd;
+	struct ieee80211_parsed_tpe *tpe = &bss_conf->tpe;
+	enum wmi_reg_6g_client_type client_type;
+	struct ath12k_reg_info *reg_info;
+	struct ath12k_base *ab = ar->ab;
+	bool psd_valid, non_psd_valid;
+	int i;
+
+	reg_info = ab->reg_info[ar->pdev_idx];
+	client_type = reg_info->client_type;
+
+	local_psd = &tpe->psd_local[client_type];
+	reg_psd = &tpe->psd_reg_client[client_type];
+	local_non_psd = &tpe->max_local[client_type];
+	reg_non_psd = &tpe->max_reg_client[client_type];
+
+	psd_valid = local_psd->valid | reg_psd->valid;
+	non_psd_valid = local_non_psd->valid | reg_non_psd->valid;
+
+	if (!psd_valid && !non_psd_valid) {
+		ath12k_warn(ab,
+			    "no transmit power envelope match client power type %d\n",
+			    client_type);
+		return;
+	};
+
+	if (psd_valid) {
+		tpc_info->is_psd_power = true;
+
+		tpc_info->num_pwr_levels = max(local_psd->count,
+					       reg_psd->count);
+		if (tpc_info->num_pwr_levels > ATH12K_NUM_PWR_LEVELS)
+			tpc_info->num_pwr_levels = ATH12K_NUM_PWR_LEVELS;
+
+		for (i = 0; i < tpc_info->num_pwr_levels; i++) {
+			tpc_info->tpe[i] = min(local_psd->power[i],
+					       reg_psd->power[i]) / 2;
+			ath12k_dbg(ab, ATH12K_DBG_MAC,
+				   "TPE PSD power[%d] : %d\n",
+				   i, tpc_info->tpe[i]);
+		}
+	} else {
+		tpc_info->is_psd_power = false;
+		tpc_info->eirp_power = 0;
+
+		tpc_info->num_pwr_levels = max(local_non_psd->count,
+					       reg_non_psd->count);
+		if (tpc_info->num_pwr_levels > ATH12K_NUM_PWR_LEVELS)
+			tpc_info->num_pwr_levels = ATH12K_NUM_PWR_LEVELS;
+
+		for (i = 0; i < tpc_info->num_pwr_levels; i++) {
+			tpc_info->tpe[i] = min(local_non_psd->power[i],
+					       reg_non_psd->power[i]) / 2;
+			ath12k_dbg(ab, ATH12K_DBG_MAC,
+				   "non PSD power[%d] : %d\n",
+				   i, tpc_info->tpe[i]);
+		}
+	}
+}
+
 static int
 ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
@@ -9780,6 +9846,11 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		   "mac chanctx assign ptr %p vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
+	if (ath12k_wmi_supports_6ghz_cc_ext(ar) &&
+	    ctx->def.chan->band == NL80211_BAND_6GHZ &&
+	    ahvif->vdev_type == WMI_VDEV_TYPE_STA)
+		ath12k_mac_parse_tx_pwr_env(ar, arvif);
+
 	arvif->punct_bitmap = ctx->def.punctured;
 
 	/* for some targets bss peer must be created before vdev_start */
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index da37332352fe66c350bbe8d2285ba3f76bfc9d81..d167b969406b071e95d5d2812288657f22d9092e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -67,6 +67,46 @@ struct ath12k_mac_get_any_chanctx_conf_arg {
 	struct ieee80211_chanctx_conf *chanctx_conf;
 };
 
+/**
+ * struct ath12k_chan_power_info - TPE containing power info per channel chunk
+ * @chan_cfreq: channel center freq (MHz)
+ * e.g.
+ * channel 37/20 MHz,  it is 6135
+ * channel 37/40 MHz,  it is 6125
+ * channel 37/80 MHz,  it is 6145
+ * channel 37/160 MHz, it is 6185
+ * @tx_power: transmit power (dBm)
+ */
+struct ath12k_chan_power_info {
+	u16 chan_cfreq;
+	s8 tx_power;
+};
+
+/* ath12k only deals with 320 MHz, so 16 subchannels */
+#define ATH12K_NUM_PWR_LEVELS  16
+
+/**
+ * struct ath12k_reg_tpc_power_info - regulatory TPC power info
+ * @is_psd_power: is PSD power or not
+ * @eirp_power: Maximum EIRP power (dBm), valid only if power is PSD
+ * @ap_power_type: type of power (SP/LPI/VLP)
+ * @num_pwr_levels: number of power levels
+ * @reg_max: Array of maximum TX power (dBm) per PSD value
+ * @ap_constraint_power: AP constraint power (dBm)
+ * @tpe: TPE values processed from TPE IE
+ * @chan_power_info: power info to send to firmware
+ */
+struct ath12k_reg_tpc_power_info {
+	bool is_psd_power;
+	u8 eirp_power;
+	enum wmi_reg_6g_ap_type ap_power_type;
+	u8 num_pwr_levels;
+	u8 reg_max[ATH12K_NUM_PWR_LEVELS];
+	u8 ap_constraint_power;
+	s8 tpe[ATH12K_NUM_PWR_LEVELS];
+	struct ath12k_chan_power_info chan_power_info[ATH12K_NUM_PWR_LEVELS];
+};
+
 extern const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default;
 
 #define ATH12K_SCAN_11D_INTERVAL		600000

-- 
2.34.1


