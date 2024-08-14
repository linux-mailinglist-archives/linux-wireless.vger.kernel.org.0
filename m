Return-Path: <linux-wireless+bounces-11404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C529517F0
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4221C21AA2
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E62166F3F;
	Wed, 14 Aug 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kt7oV+bn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337416B396
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628671; cv=none; b=Ti5+m7QUG8dZxO6y+lAxNy7RyXoYp1yIuz3j9iK4OsK/h2J/PzHw+Q4pspanHXGkn/n2uAZX8ch/AHeIUmtZdY62gXzwEyR/ZnCns6qrcBI+wxVRjCk3q1nJfxW8OuaXzyIdCIE8k1NQ8gr28HvY5qKLUJyO/Y2ud1jqqoQpgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628671; c=relaxed/simple;
	bh=MLD9CyOn2MFY3pB536WrAfoXRgSZR/aN1IMy5JRZFFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFyNG8a7v1/7iM3TyMv0wCl2zFeJDxkFtR4gh9OATtHVEc+pRHr5JLyr69WPL5xGVIJ2/7chkhtNCgYmcci6qgepH3JDsO16qZXyXAH+luLZQCXxw2WoFEHgAWTL4ofk0xJxuF4JU5k9/aWMR3P8ScOsskOHmRe9zSUKu5cDk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kt7oV+bn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DNAS0b009043;
	Wed, 14 Aug 2024 09:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I95jQD0iwIx8Iz3fGR3TFsjdqn8Acsvqxiy48EDocWk=; b=Kt7oV+bn4HXqSvm2
	F20LcRva7D8ryGPhqZXr8plYeEkAbAlzJ35w1k/nOkkRxqsJVmXxPTYkWVm1b8dk
	sr/JuGMrJpTatTdb5LI9QHtbz+BvJm1XisAz2Td8J9DP5u6QOf1oXDyVWbAoE90R
	1xLLIijbzYG2ddgR2q8rlWdTGzgZ+0/5AI/3WtO75AO5v87DjdkhRVknFWvQfRt9
	5H7meYdOY+fo+WvN35BWFt7/r5JQFNvDCQ3nZy/3ydSeDdEz6Jche0jrEwBMxMxq
	HhECdZm7J5fCnSGZUsZrpsZGByUwbdMhWOtkAscKVZtyWFzflqtZw2vwu80CASd8
	xmzefQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4108bc2vrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47E9iPY1017208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:25 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 02:44:23 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 03/18] wifi: ath12k: add ath12k_hw_params for IPQ5332
Date: Wed, 14 Aug 2024 15:13:08 +0530
Message-ID: <20240814094323.3927603-4-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Etx4nuaitEgsx4IVwANu03aII73s-Sus
X-Proofpoint-GUID: Etx4nuaitEgsx4IVwANu03aII73s-Sus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=777 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140067

From: Balamurugan S <quic_bselvara@quicinc.com>

Add ath12k_hw_params for new ath12k AHB based WiFi device IPQ5332.
Some hardware parameters like hw_ops, wmi_init & hal_ops are same
between IPQ5332 and QCN9274, hence use these same parameters for
IPQ5332. Other parameters are specific to IPQ5332, and those are
initially set to 0 or NULL, and will be populated in subsequent
patches.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  3 +-
 drivers/net/wireless/ath/ath12k/hw.c   | 71 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/qmi.h  |  1 +
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index cdfd43a7321a..6fa13165149d 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -128,7 +128,8 @@ struct ath12k_skb_rxcb {
 enum ath12k_hw_rev {
 	ATH12K_HW_QCN9274_HW10,
 	ATH12K_HW_QCN9274_HW20,
-	ATH12K_HW_WCN7850_HW20
+	ATH12K_HW_WCN7850_HW20,
+	ATH12K_HW_IPQ5332_HW10,
 };
 
 enum ath12k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index f2a0f28b27d2..a58c9b9193b4 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1082,6 +1082,77 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.iova_mask = 0,
 		.supports_aspm = false,
 	},
+	{
+		.name = "ipq5332 hw1.0",
+		.hw_rev = ATH12K_HW_IPQ5332_HW10,
+		.fw = {
+			.dir = "IPQ5332/hw1.0",
+			.board_size = 256 * 1024,
+			.cal_offset = 128 * 1024,
+		},
+		.max_radios = 1,
+		.single_pdev_only = false,
+		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ5332,
+		.internal_sleep_clock = false,
+
+		.hw_ops = &qcn9274_ops,
+		.regs = NULL,
+		.ring_mask = NULL,
+
+		.host_ce_config = NULL,
+		.ce_count = 0,
+		.target_ce_config = NULL,
+		.target_ce_count = 0,
+		.svc_to_ce_map = NULL,
+		.svc_to_ce_map_len = 0,
+
+		.hal_params = NULL,
+
+		.rxdma1_enable = false,
+		.num_rxdma_per_pdev = 1,
+		.num_rxdma_dst_ring = 0,
+		.rx_mac_buf_ring = false,
+		.vdev_start_delay = false,
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				   BIT(NL80211_IFTYPE_AP) |
+				   BIT(NL80211_IFTYPE_MESH_POINT),
+		.supports_monitor = false,
+
+		.idle_ps = false,
+		.download_calib = true,
+		.supports_suspend = false,
+		.tcl_ring_retry = true,
+		.reoq_lut_support = false,
+		.supports_shadow_regs = false,
+
+		.num_tcl_banks = 48,
+		.max_tx_ring = 4,
+
+		.wmi_init = &ath12k_wmi_init_qcn9274,
+
+		.hal_ops = &hal_qcn9274_ops,
+
+		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
+
+		.rddm_size = 0,
+
+		.def_num_link = 0,
+		.max_mlo_peer = 256,
+
+		.otp_board_id_register = 0,
+
+		.supports_sta_ps = false,
+
+		.acpi_guid = NULL,
+		.supports_dynamic_smps_6ghz = false,
+		.iova_mask = 0,
+		.supports_aspm = false,
+	},
 };
 
 int ath12k_hw_init(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 0dfcbd8cb59b..6ce11060f1aa 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -21,6 +21,7 @@
 #define ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_WCN7850 0x1
 
 #define ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_QCN9274	0x07
+#define ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ5332	0x2
 #define ATH12K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01	32
 #define ATH12K_QMI_RESP_LEN_MAX			8192
 #define ATH12K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01	52
-- 
2.34.1


