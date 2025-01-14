Return-Path: <linux-wireless+bounces-17499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A6A1083F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 14:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F067A3BBA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024324502F;
	Tue, 14 Jan 2025 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n1NcJWuN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C393F9D5
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863066; cv=none; b=ADy+LbeIQ6YXVU5rNqA3EIyW4LttVt24h3DAGFskJynW4LN1Nj1cv5Y5FrzIJ8Bl5UDL1/M+BMz/OLtHQqQjmGzZ9O8fekJdIOBl5+vFKVjB2GH8uXlm7QPaLp14sstLpXaFWgTTxo9oBpdf47p+pPVRhdDQ+bassPaC+VA0rhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863066; c=relaxed/simple;
	bh=hTe87ql372QicnFqXfKl4gOrnKyPyZlqzoCHB2xHV5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7pG9TXLtNyVNZNRdBo954duPdppAhEz73F6RRSWTXnsaU7Xa7C1CFYtzuc1SgLE4LWQHm14UDuImtnkEdiJ2LRRR+T3Ff8qT7xJxgOBfOAzuuVg2X+DkU0BEGYfY8NscqmMEVI/G77cr4kXzxn/4T9dZlGyWBsjwm65dnhCwTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n1NcJWuN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50E2rZWu008376;
	Tue, 14 Jan 2025 13:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U+yoGf3ga1UcHrtSj6N7EGYYOZGnCpvRCtABQwyokxQ=; b=n1NcJWuNhysjGL2h
	IubihANCWqaw+t2mLfcNEk8pGvQhOkmuO1S1dYDj/QW2BAhVuRtKll/5VGC5r6EL
	7M0LgeLmhDQ5qCHAbZQ942mLORNt/ELQgW2oy5DdihJf+xF7shc8xppKOqVUX9v1
	7tWjjMGVBR1y8hSzqsqLfNeBNXYO/CCUzi80KSyqsnZ/DpcFNkmOkecOBfruvLay
	5ooYeQ0N0rRcQzkaITNe877Y2z0wBaEpsQA9rqBtYkoGCEgHZomRYbUUjjvHU3Wg
	+zsN2N1+V35bImy4Wd9MPc02jw0Lp5f4i26ArRQ0BaF8A6Cm9DcCFFWA/ssA1tEs
	mRhlrg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445fhtsaq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 13:57:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50EDvdhl010380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 13:57:39 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 05:57:37 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v3 2/2] wifi: ath12k: Add Support to Calculate and Display TPC Values
Date: Tue, 14 Jan 2025 19:27:08 +0530
Message-ID: <20250114135708.966170-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114135708.966170-1-quic_rdevanat@quicinc.com>
References: <20250114135708.966170-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uZBg4I5FroAm-1Fx3G6ej1CFX1eRdVdL
X-Proofpoint-ORIG-GUID: uZBg4I5FroAm-1Fx3G6ej1CFX1eRdVdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501140112

From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

Transmit Power Control(TPC) stats should display per chain TPC value per
radio. Add debugfs support to read and display TPC stats type and TPC
stats. Take power values for each preamble type, rate and NSS combination
from a particular index from each power arrays based on number of chains,
NSS, modes, MCS and tx beamforming enabled/disabled parameters. Minimum
of the values taken from reg power table, rates and Conformance Test
Limit(CTL) array table should give the TPC which is in 0.25 dBm steps.

Sample Output:
-------------
echo 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/tpc_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/tpc_stats

*************** TPC config **************
* powers are in 0.25 dBm steps
reg domain-22           chan freq-5955
power limit-126         max reg-domain Power-252
No.of tx chain-4        No.of rates-1164
**************** SU WITH TXBF ****************
                                TPC values for Active chains
Rate idx Preamble Rate code     1-Chain 2-Chain 3-Chain 4-Chain
4        OFDM    0x000          39      15      1       -9
5        OFDM    0x001          39      15      1       -9
.....
12       HT20    0x200          40      16      2       -8
13       HT20    0x201          40      16      2       -8
.....
44       HT40    0x200          88      88      88      88
45       HT40    0x201          88      88      88      88
.....
76       VHT20   0x300          40      16      2       -8
77       VHT20   0x301          40      16      2       -8
.....
172      VHT40   0x300          88      88      88      88
173      VHT40   0x301          88      88      88      88
.....
412      HE20    0x400          88      88      88      88
413      HE20    0x401          88      88      88      88
.....
508      HE40    0x400          76      76      76      76
509      HE40    0x401          76      76      76      76
.....
748      EHT20   0x50e          88      88      88      88
749      EHT20   0x50f          88      88      88      88
.....
812      EHT40   0x50e          88      88      88      88
813      EHT40   0x50f          88      88      88      88
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Co-developed-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h    |   1 +
 drivers/net/wireless/ath/ath12k/debugfs.c | 619 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/debugfs.h |  85 ++-
 drivers/net/wireless/ath/ath12k/wmi.h     |   1 +
 4 files changed, 703 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 8521b641fa8a..425a4b7c3441 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -87,6 +87,7 @@ enum wme_ac {
 #define ATH12K_HT_MCS_MAX	7
 #define ATH12K_VHT_MCS_MAX	9
 #define ATH12K_HE_MCS_MAX	11
+#define ATH12K_EHT_MCS_MAX	15
 
 enum ath12k_crypt_mode {
 	/* Only use hardware crypto engine */
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index dcfab65053a5..ece1ca337329 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -32,6 +32,28 @@ static const struct file_operations fops_simulate_radar = {
 	.open = simple_open
 };
 
+static ssize_t ath12k_write_tpc_stats_type(struct file *file,
+					   const char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct ath12k *ar = file->private_data;
+	u8 type;
+	int ret;
+
+	ret = kstrtou8_from_user(user_buf, count, 0, &type);
+	if (ret)
+		return ret;
+
+	if (type >= WMI_HALPHY_PDEV_TX_STATS_MAX)
+		return -EINVAL;
+
+	spin_lock_bh(&ar->data_lock);
+	ar->debug.tpc_stats_type = type;
+	spin_unlock_bh(&ar->data_lock);
+
+	return count;
+}
+
 static int ath12k_debug_tpc_stats_request(struct ath12k *ar)
 {
 	enum wmi_halphy_ctrl_path_stats_id tpc_stats_sub_id;
@@ -59,6 +81,593 @@ static int ath12k_debug_tpc_stats_request(struct ath12k *ar)
 	return 0;
 }
 
+static int ath12k_get_tpc_ctl_mode_idx(struct wmi_tpc_stats_info *tpc_stats,
+				       enum wmi_tpc_pream_bw pream_bw, int *mode_idx)
+{
+	u32 chan_freq = le32_to_cpu(tpc_stats->tpc_config.chan_freq);
+	u8 band;
+
+	band = ((chan_freq > ATH12K_MIN_6G_FREQ) ? NL80211_BAND_6GHZ :
+		((chan_freq > ATH12K_MIN_5G_FREQ) ? NL80211_BAND_5GHZ :
+		NL80211_BAND_2GHZ));
+
+	if (band == NL80211_BAND_5GHZ || band == NL80211_BAND_6GHZ) {
+		switch (pream_bw) {
+		case WMI_TPC_PREAM_HT20:
+		case WMI_TPC_PREAM_VHT20:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_HT_VHT20_5GHZ_6GHZ;
+			break;
+		case WMI_TPC_PREAM_HE20:
+		case WMI_TPC_PREAM_EHT20:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_HE_EHT20_5GHZ_6GHZ;
+			break;
+		case WMI_TPC_PREAM_HT40:
+		case WMI_TPC_PREAM_VHT40:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_HT_VHT40_5GHZ_6GHZ;
+			break;
+		case WMI_TPC_PREAM_HE40:
+		case WMI_TPC_PREAM_EHT40:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_HE_EHT40_5GHZ_6GHZ;
+			break;
+		case WMI_TPC_PREAM_VHT80:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_VHT80_5GHZ_6GHZ;
+			break;
+		case WMI_TPC_PREAM_EHT60:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_EHT80_SU_PUNC20;
+			break;
+		case WMI_TPC_PREAM_HE80:
+		case WMI_TPC_PREAM_EHT80:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_HE_EHT80_5GHZ_6GHZ;
+			break;
+		case WMI_TPC_PREAM_VHT160:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_VHT160_5GHZ_6GHZ;
+			break;
+		case WMI_TPC_PREAM_EHT120:
+		case WMI_TPC_PREAM_EHT140:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_EHT160_SU_PUNC20;
+			break;
+		case WMI_TPC_PREAM_HE160:
+		case WMI_TPC_PREAM_EHT160:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_HE_EHT160_5GHZ_6GHZ;
+			break;
+		case WMI_TPC_PREAM_EHT200:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_EHT320_SU_PUNC120;
+			break;
+		case WMI_TPC_PREAM_EHT240:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_EHT320_SU_PUNC80;
+			break;
+		case WMI_TPC_PREAM_EHT280:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_EHT320_SU_PUNC40;
+			break;
+		case WMI_TPC_PREAM_EHT320:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_HE_EHT320_5GHZ_6GHZ;
+			break;
+		default:
+			/* for 5GHZ and 6GHZ, default case will be for OFDM */
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_LEGACY_5GHZ_6GHZ;
+			break;
+		}
+	} else {
+		switch (pream_bw) {
+		case WMI_TPC_PREAM_OFDM:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_LEGACY_2GHZ;
+			break;
+		case WMI_TPC_PREAM_HT20:
+		case WMI_TPC_PREAM_VHT20:
+		case WMI_TPC_PREAM_HE20:
+		case WMI_TPC_PREAM_EHT20:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_HT20_2GHZ;
+			break;
+		case WMI_TPC_PREAM_HT40:
+		case WMI_TPC_PREAM_VHT40:
+		case WMI_TPC_PREAM_HE40:
+		case WMI_TPC_PREAM_EHT40:
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_HT40_2GHZ;
+			break;
+		default:
+			/* for 2GHZ, default case will be CCK */
+			*mode_idx = ATH12K_TPC_STATS_CTL_MODE_CCK_2GHZ;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static s16 ath12k_tpc_get_rate(struct ath12k *ar,
+			       struct wmi_tpc_stats_info *tpc_stats,
+			       u32 rate_idx, u32 num_chains, u32 rate_code,
+			       enum wmi_tpc_pream_bw pream_bw,
+			       enum wmi_halphy_ctrl_path_stats_id type,
+			       u32 eht_rate_idx)
+{
+	u32 tot_nss, tot_modes, txbf_on_off, index_offset1, index_offset2, index_offset3;
+	u8 chain_idx, stm_idx, num_streams;
+	bool is_mu, txbf_enabled = 0;
+	s8 rates_ctl_min, tpc_ctl;
+	s16 rates, tpc, reg_pwr;
+	u16 rate1, rate2;
+	int mode, ret;
+
+	num_streams = 1 + ATH12K_HW_NSS(rate_code);
+	chain_idx = num_chains - 1;
+	stm_idx = num_streams - 1;
+	mode = -1;
+
+	ret = ath12k_get_tpc_ctl_mode_idx(tpc_stats, pream_bw, &mode);
+	if (ret) {
+		ath12k_warn(ar->ab, "Invalid mode index received\n");
+		tpc = TPC_INVAL;
+		goto out;
+	}
+
+	if (num_chains < num_streams) {
+		tpc = TPC_INVAL;
+		goto out;
+	}
+
+	if (le32_to_cpu(tpc_stats->tpc_config.num_tx_chain) <= 1) {
+		tpc = TPC_INVAL;
+		goto out;
+	}
+
+	if (type == WMI_HALPHY_PDEV_TX_SUTXBF_STATS ||
+	    type == WMI_HALPHY_PDEV_TX_MUTXBF_STATS)
+		txbf_enabled = 1;
+
+	if (type == WMI_HALPHY_PDEV_TX_MU_STATS ||
+	    type == WMI_HALPHY_PDEV_TX_MUTXBF_STATS) {
+		is_mu = true;
+	} else {
+		is_mu = false;
+	}
+
+	/* Below is the min calculation of ctl array, rates array and
+	 * regulator power table. tpc is minimum of all 3
+	 */
+	if (pream_bw >= WMI_TPC_PREAM_EHT20 && pream_bw <= WMI_TPC_PREAM_EHT320) {
+		rate2 = tpc_stats->rates_array2.rate_array[eht_rate_idx];
+		if (is_mu)
+			rates = u32_get_bits(rate2, ATH12K_TPC_RATE_ARRAY_MU);
+		else
+			rates = u32_get_bits(rate2, ATH12K_TPC_RATE_ARRAY_SU);
+	} else {
+		rate1 = tpc_stats->rates_array1.rate_array[rate_idx];
+		if (is_mu)
+			rates = u32_get_bits(rate1, ATH12K_TPC_RATE_ARRAY_MU);
+		else
+			rates = u32_get_bits(rate1, ATH12K_TPC_RATE_ARRAY_SU);
+	}
+
+	if (tpc_stats->tlvs_rcvd & WMI_TPC_CTL_PWR_ARRAY) {
+		tot_nss = le32_to_cpu(tpc_stats->ctl_array.tpc_ctl_pwr.d1);
+		tot_modes = le32_to_cpu(tpc_stats->ctl_array.tpc_ctl_pwr.d2);
+		txbf_on_off = le32_to_cpu(tpc_stats->ctl_array.tpc_ctl_pwr.d3);
+		index_offset1 = txbf_on_off * tot_modes * tot_nss;
+		index_offset2 = tot_modes * tot_nss;
+		index_offset3 = tot_nss;
+
+		tpc_ctl = *(tpc_stats->ctl_array.ctl_pwr_table +
+			    chain_idx * index_offset1 + txbf_enabled * index_offset2
+			    + mode * index_offset3 + stm_idx);
+	} else {
+		tpc_ctl = TPC_MAX;
+		ath12k_info(ar->ab,
+			    "ctl array for tpc stats not received from fw\n");
+	}
+
+	rates_ctl_min = min_t(s16, rates, tpc_ctl);
+
+	reg_pwr = tpc_stats->max_reg_allowed_power.reg_pwr_array[chain_idx];
+
+	if (reg_pwr < 0)
+		reg_pwr = TPC_INVAL;
+
+	tpc = min_t(s16, rates_ctl_min, reg_pwr);
+
+	/* MODULATION_LIMIT is the maximum power limit,tpc should not exceed
+	 * modulation limit even if min tpc of all three array is greater
+	 * modulation limit
+	 */
+	tpc = min_t(s16, tpc, MODULATION_LIMIT);
+
+out:
+	return tpc;
+}
+
+static u16 ath12k_get_ratecode(u16 pream_idx, u16 nss, u16 mcs_rate)
+{
+	u16 mode_type = ~0;
+
+	/* Below assignments are just for printing purpose only */
+	switch (pream_idx) {
+	case WMI_TPC_PREAM_CCK:
+		mode_type = WMI_RATE_PREAMBLE_CCK;
+		break;
+	case WMI_TPC_PREAM_OFDM:
+		mode_type = WMI_RATE_PREAMBLE_OFDM;
+		break;
+	case WMI_TPC_PREAM_HT20:
+	case WMI_TPC_PREAM_HT40:
+		mode_type = WMI_RATE_PREAMBLE_HT;
+		break;
+	case WMI_TPC_PREAM_VHT20:
+	case WMI_TPC_PREAM_VHT40:
+	case WMI_TPC_PREAM_VHT80:
+	case WMI_TPC_PREAM_VHT160:
+		mode_type = WMI_RATE_PREAMBLE_VHT;
+		break;
+	case WMI_TPC_PREAM_HE20:
+	case WMI_TPC_PREAM_HE40:
+	case WMI_TPC_PREAM_HE80:
+	case WMI_TPC_PREAM_HE160:
+		mode_type = WMI_RATE_PREAMBLE_HE;
+		break;
+	case WMI_TPC_PREAM_EHT20:
+	case WMI_TPC_PREAM_EHT40:
+	case WMI_TPC_PREAM_EHT60:
+	case WMI_TPC_PREAM_EHT80:
+	case WMI_TPC_PREAM_EHT120:
+	case WMI_TPC_PREAM_EHT140:
+	case WMI_TPC_PREAM_EHT160:
+	case WMI_TPC_PREAM_EHT200:
+	case WMI_TPC_PREAM_EHT240:
+	case WMI_TPC_PREAM_EHT280:
+	case WMI_TPC_PREAM_EHT320:
+		mode_type = WMI_RATE_PREAMBLE_EHT;
+		if (mcs_rate == 0 || mcs_rate == 1)
+			mcs_rate += 14;
+		else
+			mcs_rate -= 2;
+		break;
+	default:
+		return mode_type;
+	}
+	return ((mode_type << 8) | ((nss & 0x7) << 5) | (mcs_rate & 0x1F));
+}
+
+static bool ath12k_he_supports_extra_mcs(struct ath12k *ar, int freq)
+{
+	struct ath12k_pdev_cap *cap = &ar->pdev->cap;
+	struct ath12k_band_cap *cap_band;
+	bool extra_mcs_supported;
+
+	if (freq <= ATH12K_2GHZ_MAX_FREQUENCY)
+		cap_band = &cap->band[NL80211_BAND_2GHZ];
+	else if (freq <= ATH12K_5GHZ_MAX_FREQUENCY)
+		cap_band = &cap->band[NL80211_BAND_5GHZ];
+	else
+		cap_band = &cap->band[NL80211_BAND_6GHZ];
+
+	extra_mcs_supported = u32_get_bits(cap_band->he_cap_info[1],
+					   HE_EXTRA_MCS_SUPPORT);
+	return extra_mcs_supported;
+}
+
+static int ath12k_tpc_fill_pream(struct ath12k *ar, char *buf, int buf_len, int len,
+				 enum wmi_tpc_pream_bw pream_bw, u32 max_rix,
+				 int max_nss, int max_rates, int pream_type,
+				 enum wmi_halphy_ctrl_path_stats_id tpc_type,
+				 int rate_idx, int eht_rate_idx)
+{
+	struct wmi_tpc_stats_info *tpc_stats = ar->debug.tpc_stats;
+	int nss, rates, chains;
+	u8 active_tx_chains;
+	u16 rate_code;
+	s16 tpc;
+
+	static const char *const pream_str[] = {
+		[WMI_TPC_PREAM_CCK]     = "CCK",
+		[WMI_TPC_PREAM_OFDM]    = "OFDM",
+		[WMI_TPC_PREAM_HT20]    = "HT20",
+		[WMI_TPC_PREAM_HT40]    = "HT40",
+		[WMI_TPC_PREAM_VHT20]   = "VHT20",
+		[WMI_TPC_PREAM_VHT40]   = "VHT40",
+		[WMI_TPC_PREAM_VHT80]   = "VHT80",
+		[WMI_TPC_PREAM_VHT160]  = "VHT160",
+		[WMI_TPC_PREAM_HE20]    = "HE20",
+		[WMI_TPC_PREAM_HE40]    = "HE40",
+		[WMI_TPC_PREAM_HE80]    = "HE80",
+		[WMI_TPC_PREAM_HE160]   = "HE160",
+		[WMI_TPC_PREAM_EHT20]   = "EHT20",
+
+		[WMI_TPC_PREAM_EHT40]   = "EHT40",
+		[WMI_TPC_PREAM_EHT60]   = "EHT60",
+		[WMI_TPC_PREAM_EHT80]   = "EHT80",
+		[WMI_TPC_PREAM_EHT120]   = "EHT120",
+		[WMI_TPC_PREAM_EHT140]   = "EHT140",
+		[WMI_TPC_PREAM_EHT160]   = "EHT160",
+		[WMI_TPC_PREAM_EHT200]   = "EHT200",
+		[WMI_TPC_PREAM_EHT240]   = "EHT240",
+		[WMI_TPC_PREAM_EHT280]   = "EHT280",
+		[WMI_TPC_PREAM_EHT320]   = "EHT320"};
+
+	active_tx_chains = ar->num_tx_chains;
+
+	for (nss = 0; nss < max_nss; nss++) {
+		for (rates = 0; rates < max_rates; rates++, rate_idx++, max_rix++) {
+			/* FW send extra MCS(10&11) for VHT and HE rates,
+			 *  this is not used. Hence skipping it here
+			 */
+			if (pream_type == WMI_RATE_PREAMBLE_VHT &&
+			    rates > ATH12K_VHT_MCS_MAX)
+				continue;
+
+			if (pream_type == WMI_RATE_PREAMBLE_HE &&
+			    rates > ATH12K_HE_MCS_MAX)
+				continue;
+
+			if (pream_type == WMI_RATE_PREAMBLE_EHT &&
+			    rates > ATH12K_EHT_MCS_MAX)
+				continue;
+
+			rate_code = ath12k_get_ratecode(pream_bw, nss, rates);
+			len += scnprintf(buf + len, buf_len - len,
+				 "%d\t %s\t 0x%03x\t", max_rix,
+				 pream_str[pream_bw], rate_code);
+
+			for (chains = 0; chains < active_tx_chains; chains++) {
+				if (nss > chains) {
+					len += scnprintf(buf + len,
+							 buf_len - len,
+							 "\t%s", "NA");
+				} else {
+					tpc = ath12k_tpc_get_rate(ar, tpc_stats, rate_idx,
+								  chains + 1, rate_code,
+								  pream_bw, tpc_type,
+								  eht_rate_idx);
+
+					if (tpc == TPC_INVAL) {
+						len += scnprintf(buf + len,
+						       buf_len - len, "\tNA");
+					} else {
+						len += scnprintf(buf + len,
+						       buf_len - len, "\t%d",
+						       tpc);
+					}
+				}
+			}
+			len += scnprintf(buf + len, buf_len - len, "\n");
+
+			if (pream_type == WMI_RATE_PREAMBLE_EHT)
+				/*For fetching the next eht rates pwr from rates array2*/
+				++eht_rate_idx;
+		}
+	}
+
+	return len;
+}
+
+static int ath12k_tpc_stats_print(struct ath12k *ar,
+				  struct wmi_tpc_stats_info *tpc_stats,
+				  char *buf, size_t len,
+				  enum wmi_halphy_ctrl_path_stats_id type)
+{
+	u32 eht_idx = 0, pream_idx = 0, rate_pream_idx = 0, total_rates = 0, max_rix = 0;
+	u32 chan_freq, num_tx_chain, caps, i, j = 1;
+	size_t buf_len = ATH12K_TPC_STATS_BUF_SIZE;
+	u8 nss, active_tx_chains;
+	bool he_ext_mcs;
+	static const char *const type_str[WMI_HALPHY_PDEV_TX_STATS_MAX] = {
+		[WMI_HALPHY_PDEV_TX_SU_STATS]		= "SU",
+		[WMI_HALPHY_PDEV_TX_SUTXBF_STATS]	= "SU WITH TXBF",
+		[WMI_HALPHY_PDEV_TX_MU_STATS]		= "MU",
+		[WMI_HALPHY_PDEV_TX_MUTXBF_STATS]	= "MU WITH TXBF"};
+
+	u8 max_rates[WMI_TPC_PREAM_MAX] = {
+		[WMI_TPC_PREAM_CCK]     = ATH12K_CCK_RATES,
+		[WMI_TPC_PREAM_OFDM]    = ATH12K_OFDM_RATES,
+		[WMI_TPC_PREAM_HT20]    = ATH12K_HT_RATES,
+		[WMI_TPC_PREAM_HT40]    = ATH12K_HT_RATES,
+		[WMI_TPC_PREAM_VHT20]   = ATH12K_VHT_RATES,
+		[WMI_TPC_PREAM_VHT40]   = ATH12K_VHT_RATES,
+		[WMI_TPC_PREAM_VHT80]   = ATH12K_VHT_RATES,
+		[WMI_TPC_PREAM_VHT160]  = ATH12K_VHT_RATES,
+		[WMI_TPC_PREAM_HE20]    = ATH12K_HE_RATES,
+		[WMI_TPC_PREAM_HE40]    = ATH12K_HE_RATES,
+		[WMI_TPC_PREAM_HE80]    = ATH12K_HE_RATES,
+		[WMI_TPC_PREAM_HE160]   = ATH12K_HE_RATES,
+		[WMI_TPC_PREAM_EHT20]   = ATH12K_EHT_RATES,
+		[WMI_TPC_PREAM_EHT40]   = ATH12K_EHT_RATES,
+		[WMI_TPC_PREAM_EHT60]   = ATH12K_EHT_RATES,
+		[WMI_TPC_PREAM_EHT80]   = ATH12K_EHT_RATES,
+		[WMI_TPC_PREAM_EHT120]  = ATH12K_EHT_RATES,
+		[WMI_TPC_PREAM_EHT140]  = ATH12K_EHT_RATES,
+		[WMI_TPC_PREAM_EHT160]  = ATH12K_EHT_RATES,
+		[WMI_TPC_PREAM_EHT200]  = ATH12K_EHT_RATES,
+		[WMI_TPC_PREAM_EHT240]  = ATH12K_EHT_RATES,
+		[WMI_TPC_PREAM_EHT280]  = ATH12K_EHT_RATES,
+		[WMI_TPC_PREAM_EHT320]  = ATH12K_EHT_RATES};
+	static const u8 max_nss[WMI_TPC_PREAM_MAX] = {
+		[WMI_TPC_PREAM_CCK]     = ATH12K_NSS_1,
+		[WMI_TPC_PREAM_OFDM]    = ATH12K_NSS_1,
+		[WMI_TPC_PREAM_HT20]    = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_HT40]    = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_VHT20]   = ATH12K_NSS_8,
+		[WMI_TPC_PREAM_VHT40]   = ATH12K_NSS_8,
+		[WMI_TPC_PREAM_VHT80]   = ATH12K_NSS_8,
+		[WMI_TPC_PREAM_VHT160]  = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_HE20]    = ATH12K_NSS_8,
+		[WMI_TPC_PREAM_HE40]    = ATH12K_NSS_8,
+		[WMI_TPC_PREAM_HE80]    = ATH12K_NSS_8,
+		[WMI_TPC_PREAM_HE160]   = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_EHT20]   = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_EHT40]   = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_EHT60]   = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_EHT80]   = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_EHT120]  = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_EHT140]  = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_EHT160]  = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_EHT200]  = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_EHT240]  = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_EHT280]  = ATH12K_NSS_4,
+		[WMI_TPC_PREAM_EHT320]  = ATH12K_NSS_4};
+
+	u16 rate_idx[WMI_TPC_PREAM_MAX] = {0},
+	    eht_rate_idx[WMI_TPC_PREAM_MAX] = {0};
+	static const u8 pream_type[WMI_TPC_PREAM_MAX] = {
+		[WMI_TPC_PREAM_CCK]     = WMI_RATE_PREAMBLE_CCK,
+		[WMI_TPC_PREAM_OFDM]    = WMI_RATE_PREAMBLE_OFDM,
+		[WMI_TPC_PREAM_HT20]    = WMI_RATE_PREAMBLE_HT,
+		[WMI_TPC_PREAM_HT40]    = WMI_RATE_PREAMBLE_HT,
+		[WMI_TPC_PREAM_VHT20]   = WMI_RATE_PREAMBLE_VHT,
+		[WMI_TPC_PREAM_VHT40]   = WMI_RATE_PREAMBLE_VHT,
+		[WMI_TPC_PREAM_VHT80]   = WMI_RATE_PREAMBLE_VHT,
+		[WMI_TPC_PREAM_VHT160]  = WMI_RATE_PREAMBLE_VHT,
+		[WMI_TPC_PREAM_HE20]    = WMI_RATE_PREAMBLE_HE,
+		[WMI_TPC_PREAM_HE40]    = WMI_RATE_PREAMBLE_HE,
+		[WMI_TPC_PREAM_HE80]    = WMI_RATE_PREAMBLE_HE,
+		[WMI_TPC_PREAM_HE160]   = WMI_RATE_PREAMBLE_HE,
+		[WMI_TPC_PREAM_EHT20]   = WMI_RATE_PREAMBLE_EHT,
+		[WMI_TPC_PREAM_EHT40]   = WMI_RATE_PREAMBLE_EHT,
+		[WMI_TPC_PREAM_EHT60]   = WMI_RATE_PREAMBLE_EHT,
+		[WMI_TPC_PREAM_EHT80]   = WMI_RATE_PREAMBLE_EHT,
+		[WMI_TPC_PREAM_EHT120]  = WMI_RATE_PREAMBLE_EHT,
+		[WMI_TPC_PREAM_EHT140]  = WMI_RATE_PREAMBLE_EHT,
+		[WMI_TPC_PREAM_EHT160]  = WMI_RATE_PREAMBLE_EHT,
+		[WMI_TPC_PREAM_EHT200]  = WMI_RATE_PREAMBLE_EHT,
+		[WMI_TPC_PREAM_EHT240]  = WMI_RATE_PREAMBLE_EHT,
+		[WMI_TPC_PREAM_EHT280]  = WMI_RATE_PREAMBLE_EHT,
+		[WMI_TPC_PREAM_EHT320]  = WMI_RATE_PREAMBLE_EHT};
+
+	chan_freq = le32_to_cpu(tpc_stats->tpc_config.chan_freq);
+	num_tx_chain = le32_to_cpu(tpc_stats->tpc_config.num_tx_chain);
+	caps = le32_to_cpu(tpc_stats->tpc_config.caps);
+
+	active_tx_chains = ar->num_tx_chains;
+	he_ext_mcs = ath12k_he_supports_extra_mcs(ar, chan_freq);
+
+	/* mcs 12&13 is sent by FW for certain HWs in rate array, skipping it as
+	 * it is not supported
+	 */
+	if (he_ext_mcs) {
+		for (i = WMI_TPC_PREAM_HE20; i <= WMI_TPC_PREAM_HE160;  ++i)
+			max_rates[i] = ATH12K_HE_RATES;
+	}
+
+	if (type == WMI_HALPHY_PDEV_TX_MU_STATS ||
+	    type == WMI_HALPHY_PDEV_TX_MUTXBF_STATS) {
+		pream_idx = WMI_TPC_PREAM_VHT20;
+
+		for (i = WMI_TPC_PREAM_CCK; i <= WMI_TPC_PREAM_HT40; ++i)
+			max_rix += max_nss[i] * max_rates[i];
+	}
+	/* Enumerate all the rate indices */
+	for (i = rate_pream_idx + 1 ; i < WMI_TPC_PREAM_MAX; i++) {
+		nss = (max_nss[i - 1] < num_tx_chain ?
+		       max_nss[i - 1] : num_tx_chain);
+
+		rate_idx[i] = rate_idx[i - 1] + max_rates[i - 1] * nss;
+
+		if (pream_type[i] == WMI_RATE_PREAMBLE_EHT) {
+			eht_rate_idx[j] = eht_rate_idx[j - 1] + max_rates[i] * nss;
+			++j;
+		}
+	}
+
+	for (i = 0 ; i < WMI_TPC_PREAM_MAX; i++) {
+		nss = (max_nss[i] < num_tx_chain ?
+		       max_nss[i] : num_tx_chain);
+		total_rates += max_rates[i] * nss;
+	}
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "No.of rates-%d\n", total_rates);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "**************** %s ****************\n",
+			 type_str[type]);
+	len += scnprintf(buf + len, buf_len - len,
+			 "\t\t\t\tTPC values for Active chains\n");
+	len += scnprintf(buf + len, buf_len - len,
+			 "Rate idx Preamble Rate code");
+
+	for (i = 1; i <= active_tx_chains; ++i) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "\t%d-Chain", i);
+	}
+
+	len += scnprintf(buf + len, buf_len - len, "\n");
+	for (i = pream_idx; i < WMI_TPC_PREAM_MAX; i++) {
+		if (chan_freq <= 2483) {
+			if (i == WMI_TPC_PREAM_VHT80 ||
+			    i == WMI_TPC_PREAM_VHT160 ||
+			    i == WMI_TPC_PREAM_HE80 ||
+			    i == WMI_TPC_PREAM_HE160 ||
+			    (i >= WMI_TPC_PREAM_EHT60 &&
+			     i <= WMI_TPC_PREAM_EHT320)) {
+				max_rix += max_nss[i] * max_rates[i];
+				continue;
+			}
+		} else {
+			if (i == WMI_TPC_PREAM_CCK) {
+				max_rix += max_rates[i];
+				continue;
+			}
+		}
+
+		nss = (max_nss[i] < ar->num_tx_chains ? max_nss[i] : ar->num_tx_chains);
+
+		if (!(caps &
+		    (1 << ATH12K_TPC_STATS_SUPPORT_BE_PUNC))) {
+			if (i == WMI_TPC_PREAM_EHT60 || i == WMI_TPC_PREAM_EHT120 ||
+			    i == WMI_TPC_PREAM_EHT140 || i == WMI_TPC_PREAM_EHT200 ||
+			    i == WMI_TPC_PREAM_EHT240 || i == WMI_TPC_PREAM_EHT280) {
+				max_rix += max_nss[i] * max_rates[i];
+				continue;
+			}
+		}
+
+		len = ath12k_tpc_fill_pream(ar, buf, buf_len, len, i, max_rix, nss,
+					    max_rates[i], pream_type[i],
+					    type, rate_idx[i], eht_rate_idx[eht_idx]);
+
+		if (pream_type[i] == WMI_RATE_PREAMBLE_EHT)
+			/*For fetch the next index eht rates from rates array2*/
+			++eht_idx;
+
+		max_rix += max_nss[i] * max_rates[i];
+	}
+	return len;
+}
+
+static void ath12k_tpc_stats_fill(struct ath12k *ar,
+				  struct wmi_tpc_stats_info *tpc_stats,
+				  char *buf)
+{
+	size_t buf_len = ATH12K_TPC_STATS_BUF_SIZE;
+	struct wmi_tpc_config_params *tpc;
+	size_t len = 0;
+
+	spin_lock_bh(&ar->data_lock);
+	if (!tpc_stats) {
+		ath12k_warn(ar->ab, "failed to find tpc stats\n");
+		goto unlock;
+	}
+
+	tpc = &tpc_stats->tpc_config;
+	len += scnprintf(buf + len, buf_len - len, "\n");
+	len += scnprintf(buf + len, buf_len - len,
+			 "*************** TPC config **************\n");
+	len += scnprintf(buf + len, buf_len - len,
+			 "* powers are in 0.25 dBm steps\n");
+	len += scnprintf(buf + len, buf_len - len,
+			 "reg domain-%d\t\tchan freq-%d\n",
+			 tpc->reg_domain, tpc->chan_freq);
+	len += scnprintf(buf + len, buf_len - len,
+			 "power limit-%d\t\tmax reg-domain Power-%d\n",
+			 le32_to_cpu(tpc->twice_max_reg_power) / 2, tpc->power_limit);
+	len += scnprintf(buf + len, buf_len - len,
+			 "No.of tx chain-%d\t",
+			 ar->num_tx_chains);
+
+	ath12k_tpc_stats_print(ar, tpc_stats, buf, len,
+			       ar->debug.tpc_stats_type);
+
+unlock:
+	spin_unlock_bh(&ar->data_lock);
+}
+
 static int ath12k_open_tpc_stats(struct inode *inode, struct file *file)
 {
 	struct ath12k *ar = inode->i_private;
@@ -91,6 +700,7 @@ static int ath12k_open_tpc_stats(struct inode *inode, struct file *file)
 		return -ETIMEDOUT;
 	}
 
+	ath12k_tpc_stats_fill(ar, ar->debug.tpc_stats, buf);
 	file->private_data = no_free_ptr(buf);
 
 	spin_lock_bh(&ar->data_lock);
@@ -125,6 +735,12 @@ static const struct file_operations fops_tpc_stats = {
 	.llseek = default_llseek,
 };
 
+static const struct file_operations fops_tpc_stats_type = {
+	.write = ath12k_write_tpc_stats_type,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
 void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
 	bool dput_needed;
@@ -187,6 +803,9 @@ void ath12k_debugfs_register(struct ath12k *ar)
 
 	debugfs_create_file("tpc_stats", 0400, ar->debug.debugfs_pdev, ar,
 			    &fops_tpc_stats);
+	debugfs_create_file("tpc_stats_type", 0200, ar->debug.debugfs_pdev,
+			    ar, &fops_tpc_stats_type);
+	init_completion(&ar->debug.tpc_complete);
 
 	ath12k_debugfs_htt_stats_register(ar);
 }
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
index d086dd1d5011..d9d91cc8cd1e 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -13,11 +13,90 @@ void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
 void ath12k_debugfs_register(struct ath12k *ar);
 void ath12k_debugfs_unregister(struct ath12k *ar);
 
-#define TPC_STATS_WAIT_TIME		(1 * HZ)
-#define TPC_STATS_TOT_ROW		700
-#define TPC_STATS_TOT_COLUMN		100
+#define ATH12K_CCK_RATES			4
+#define ATH12K_OFDM_RATES			8
+#define ATH12K_HT_RATES				8
+#define ATH12K_VHT_RATES			12
+#define ATH12K_HE_RATES				12
+#define ATH12K_HE_RATES_WITH_EXTRA_MCS		14
+#define ATH12K_EHT_RATES			16
+#define HE_EXTRA_MCS_SUPPORT			GENMASK(31, 16)
+#define ATH12K_NSS_1				1
+#define ATH12K_NSS_4				4
+#define ATH12K_NSS_8				8
+#define ATH12K_HW_NSS(_rcode)			(((_rcode) >> 5) & 0x7)
+#define TPC_STATS_WAIT_TIME			(1 * HZ)
+#define MAX_TPC_PREAM_STR_LEN			7
+#define TPC_INVAL				-128
+#define TPC_MAX					127
+#define TPC_STATS_WAIT_TIME			(1 * HZ)
+#define TPC_STATS_TOT_ROW			700
+#define TPC_STATS_TOT_COLUMN			100
+#define MODULATION_LIMIT			126
+
+#define ATH12K_2GHZ_MAX_FREQUENCY		2495
+#define ATH12K_5GHZ_MAX_FREQUENCY		5920
 #define ATH12K_TPC_STATS_BUF_SIZE	(TPC_STATS_TOT_ROW * TPC_STATS_TOT_COLUMN)
 
+enum wmi_tpc_pream_bw {
+	WMI_TPC_PREAM_CCK,
+	WMI_TPC_PREAM_OFDM,
+	WMI_TPC_PREAM_HT20,
+	WMI_TPC_PREAM_HT40,
+	WMI_TPC_PREAM_VHT20,
+	WMI_TPC_PREAM_VHT40,
+	WMI_TPC_PREAM_VHT80,
+	WMI_TPC_PREAM_VHT160,
+	WMI_TPC_PREAM_HE20,
+	WMI_TPC_PREAM_HE40,
+	WMI_TPC_PREAM_HE80,
+	WMI_TPC_PREAM_HE160,
+	WMI_TPC_PREAM_EHT20,
+	WMI_TPC_PREAM_EHT40,
+	WMI_TPC_PREAM_EHT60,
+	WMI_TPC_PREAM_EHT80,
+	WMI_TPC_PREAM_EHT120,
+	WMI_TPC_PREAM_EHT140,
+	WMI_TPC_PREAM_EHT160,
+	WMI_TPC_PREAM_EHT200,
+	WMI_TPC_PREAM_EHT240,
+	WMI_TPC_PREAM_EHT280,
+	WMI_TPC_PREAM_EHT320,
+	WMI_TPC_PREAM_MAX
+};
+
+enum ath12k_debug_tpc_stats_ctl_mode {
+	ATH12K_TPC_STATS_CTL_MODE_LEGACY_5GHZ_6GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_HT_VHT20_5GHZ_6GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_HE_EHT20_5GHZ_6GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_HT_VHT40_5GHZ_6GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_HE_EHT40_5GHZ_6GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_VHT80_5GHZ_6GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_HE_EHT80_5GHZ_6GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_VHT160_5GHZ_6GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_HE_EHT160_5GHZ_6GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_HE_EHT320_5GHZ_6GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_CCK_2GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_LEGACY_2GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_HT20_2GHZ,
+	ATH12K_TPC_STATS_CTL_MODE_HT40_2GHZ,
+
+	ATH12K_TPC_STATS_CTL_MODE_EHT80_SU_PUNC20 = 23,
+	ATH12K_TPC_STATS_CTL_MODE_EHT160_SU_PUNC20,
+	ATH12K_TPC_STATS_CTL_MODE_EHT320_SU_PUNC40,
+	ATH12K_TPC_STATS_CTL_MODE_EHT320_SU_PUNC80,
+	ATH12K_TPC_STATS_CTL_MODE_EHT320_SU_PUNC120
+};
+
+enum ath12k_debug_tpc_stats_support_modes {
+	ATH12K_TPC_STATS_SUPPORT_160 = 0,
+	ATH12K_TPC_STATS_SUPPORT_320,
+	ATH12K_TPC_STATS_SUPPORT_AX,
+	ATH12K_TPC_STATS_SUPPORT_AX_EXTRA_MCS,
+	ATH12K_TPC_STATS_SUPPORT_BE,
+	ATH12K_TPC_STATS_SUPPORT_BE_PUNC,
+};
+
 #else
 static inline void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 5193f4a7fed1..ae3d62fefd3f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4620,6 +4620,7 @@ enum wmi_rate_preamble {
 	WMI_RATE_PREAMBLE_HT,
 	WMI_RATE_PREAMBLE_VHT,
 	WMI_RATE_PREAMBLE_HE,
+	WMI_RATE_PREAMBLE_EHT
 };
 
 /**
-- 
2.25.1


