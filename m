Return-Path: <linux-wireless+bounces-24691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CB8AEEBC5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 03:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E651BC1305
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 01:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579E71B424F;
	Tue,  1 Jul 2025 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bekpfyBr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9889F78F43
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331868; cv=none; b=IX/yHlatOt7A2SOsf2xb72HSNmRB+bnQXkVH9YDB84QQ6X9G02ErM0y2iIZ3HTzsJvpuDnlx9zg6K/oHQ+Dh5OfEv6tAenWXfi4B2eIQy9koVB0L5juW7O62VE0acEdrAWme5fv5v+hv/GAuq5BCoC8oZc+WplSW8nvNr4yeAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331868; c=relaxed/simple;
	bh=ZZQ54A9t5kDKBYTlHbs//c8DQ2XfELlIo3G4OoalzhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qF/Z1NTWg4cErClUctE2ebRzsEDUwLINiR0wvQqhgiRH4rlWU9uPeyKkzdAf6VtRetkJBrKb6XDD8TkyqeNFKvkUC1W0aPY+BXtxwd8fQGDsl9jzq6CLQ9Lopqko8RJouRcw32NOWyPapL0joUt7Gq5DcuS3Jj6s+JnGSn2wmrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bekpfyBr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFq6XL007047;
	Tue, 1 Jul 2025 01:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cObFJKY9NPJh9rBuDrGRFScjuoc5QxdFlLkR7voA8A8=; b=bekpfyBr6uMXngvM
	hn/8GsJ6hL8p0hGqLH7DlQToC+phKToP+HRajs3zINRfEruNmojw0nUe3bHobVm4
	+kB72U9L1tc9l+hO21w3J2nlTNU+TbRqjFyEkykP1vdWPTHVtFgHK9kWLMJPHAgY
	ANNJ+JRtQEZuHKGtqcsfeWL/1LmKzmgASd9nnihs0Df8r5toz/fr3MdTvTvH1b0a
	GP8VNnl0cvihAK1Umu7sX/S8MC9XnWmt6QGMR10cznguPh5k3acQtoi8+DAGPOb9
	Vs/jD/4H4fnfZPc52rDQSy2uW324mzFu0ih4kZKX8969qtQquO9NdFBoKRE+Aul3
	0YFTFg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5jaymw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 01:04:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56114NZF014986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 01:04:23 GMT
Received: from ath12k-linux2.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 18:04:23 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Subject: [PATCH ath-next V15 5/9] wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
Date: Mon, 30 Jun 2025 18:04:04 -0700
Message-ID: <20250701010408.1257201-6-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
References: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=68633418 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=5xRv96JrbLoegENK7BkA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: g_9PDfemps-LyBWNpefMI7hWB9mVlPY1
X-Proofpoint-GUID: g_9PDfemps-LyBWNpefMI7hWB9mVlPY1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAwMyBTYWx0ZWRfX0EDaCUGNUeKg
 YNrZ+8Pabvdk2MlXv7g5Ew02nZoTuVuMnWQAI8U61yQEkeCvboRs1jzV2NYzvqt36kh3iM7qO1i
 qMVqAhwwORNmWrRtlZXQljMQ3+FsJTBdImKNyU4KUdDoOaiefeNNUHPq+8MVy1Q+2A+ThQvZeKl
 xaOkbYOux4Q8Wi5GM82oxNcIxrZx+JCFKZ9MQ6/Bzolo7DE3FW1Z6AuqO+NRg7U73/OD2huDj3d
 aA6kUKi0/OD38tvo7DSTjuaJUxls8LA7mVy92jYoH5mHNik6fOO4R6nrS0Kax3+z39rNm26K4IQ
 UkOLfWmPIi/4/pAuqAt3NLYFvYaBoFCQ42v7k2SZUja6M+Nr61+OLairbkQBSNX9MYm2iWteMg0
 hA6GGKSwR/XFen5zY49oJ17284tL0sXma+EgUYncsNH93Pdeb3O5lVZzTKmDX16QBJ0OPC6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_06,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010003

Currently, the TX and RX MCS rate configurations per peer are
reversed when sent to the firmware. As a result, RX MCS rates
are configured for TX, and vice versa. This commit rectifies
the configuration to match what the firmware expects.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 19 +++++++++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 6c6354b3e18e..cdf3406302ee 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2183,6 +2183,8 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 				   struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_link_vif *arvif;
 	struct wmi_peer_assoc_complete_cmd *cmd;
 	struct ath12k_wmi_vht_rate_set_params *mcs;
 	struct ath12k_wmi_he_rate_set_params *he_mcs;
@@ -2198,6 +2200,13 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 	u16 eml_cap;
 	__le32 v;
 
+	arvif = ath12k_mac_get_arvif(ar, arg->vdev_id);
+	if (!arvif) {
+		ath12k_warn(ab, "failed to find arvif with vdev id %d\n",
+			    arg->vdev_id);
+		return -EINVAL;
+	}
+
 	peer_legacy_rates_align = roundup(arg->peer_legacy_rates.num_rates,
 					  sizeof(u32));
 	peer_ht_rates_align = roundup(arg->peer_ht_rates.num_rates,
@@ -2333,8 +2342,14 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 		he_mcs->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_HE_RATE_SET,
 							    sizeof(*he_mcs));
 
-		he_mcs->rx_mcs_set = cpu_to_le32(arg->peer_he_rx_mcs_set[i]);
-		he_mcs->tx_mcs_set = cpu_to_le32(arg->peer_he_tx_mcs_set[i]);
+		if (arvif->ahvif->vdev_type == WMI_VDEV_TYPE_STA) {
+			he_mcs->rx_mcs_set = cpu_to_le32(arg->peer_he_rx_mcs_set[i]);
+			he_mcs->tx_mcs_set = cpu_to_le32(arg->peer_he_tx_mcs_set[i]);
+
+		} else {
+			he_mcs->rx_mcs_set = cpu_to_le32(arg->peer_he_tx_mcs_set[i]);
+			he_mcs->tx_mcs_set = cpu_to_le32(arg->peer_he_rx_mcs_set[i]);
+		}
 		ptr += sizeof(*he_mcs);
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 0964ca03069a..7ad84624600d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4162,7 +4162,9 @@ struct ath12k_wmi_vht_rate_set_params {
 
 struct ath12k_wmi_he_rate_set_params {
 	__le32 tlv_header;
+	/* MCS at which the peer can receive */
 	__le32 rx_mcs_set;
+	/* MCS at which the peer can transmit */
 	__le32 tx_mcs_set;
 } __packed;
 
-- 
2.43.0


