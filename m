Return-Path: <linux-wireless+bounces-23127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D11AABB138
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 20:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28136174CC6
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30BD20D509;
	Sun, 18 May 2025 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YbzA4eNs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0A2F43;
	Sun, 18 May 2025 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747592594; cv=none; b=BJwSomGVRaNxKxH4RXr04we9Y7jCqcPow3CnvcSboJFTVRcrJNNZLLHXAouG/l0xV27WqaKj2EAm8u7iI4DBWqaXahIKHxdO+Aay0s+ouXb537cXIX+Vnw7KTdws0PwsJrJu4iXe5h02fZSa2hccGQU5v42eAf2Jna2oiph5hRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747592594; c=relaxed/simple;
	bh=1as0HLR/0Fxxv/GCKtQEV7Pvofd9roAIEzxAPzygrgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TveURZjMFVm5GaYTZEkupN2dd3fmuMx2fqsjOf//B0a2iPjmb3dTE4dFfnyV8p8o95WRfj3v5bv6BFsz3DVRMHtgOqeheibBCDadJTtXNWU43K2xVEAn8e+OHYhsM5wV6zhCA/T85ONw9y5ed1OSyPtoA5MG+NbNUUNT06d7VF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YbzA4eNs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54IH9uix026671;
	Sun, 18 May 2025 18:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GqeUiYTeqFmaZ0dMTksqDFraKydvUwwGRWWpIbnQRU4=; b=YbzA4eNsWTSbpsR4
	MWx4+6cECoyl2RervNdMizS4nT9o0zNo+ofhrKk50tyPCNNiURi+MZnjESV64/O2
	BV/ZPLPfcn+loDyfSAlJ+xWTxyfaiIISicS4WIq6Z2VN0T+1Rfl0VpRoqQq/51+X
	thVs8Q3cip9yIWhGXYP0ELjJ7aS8/Ldfn8OU4JITGvq93Gpzl76WSAo3vnWgcM9v
	Mf2s8OgLVlHhfnCWnOvLMBhJRy1mUtlYm1FrEUYnurug9GFfVDl5A9My6zk8XZHF
	A4xygo2caSbHnXhE87B70hMaHy60eN8upgA8nx7d1i/NHeKih9chdmfEilEo3MOF
	qeiKsA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjm4j9h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 18:23:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54IIN1xi005383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 18:23:01 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 18 May 2025 11:22:58 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Sun, 18 May 2025 23:52:29 +0530
Subject: [PATCH ath-next v2 2/5] wifi: ath12k: Add ath12k_hw_params for
 IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250518-ath12k-ipq5424-v2-2-ef81b833dc97@quicinc.com>
References: <20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com>
In-Reply-To: <20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Saravanakumar
 Duraisamy" <quic_saradura@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pNzUPMjbSuds1JJIQpfaxyWp4ykPDJBB
X-Authority-Analysis: v=2.4 cv=C4bpyRP+ c=1 sm=1 tr=0 ts=682a2586 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=vBmMNsOPyRzkxF6eNBIA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pNzUPMjbSuds1JJIQpfaxyWp4ykPDJBB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDE3OSBTYWx0ZWRfX6guSw3aYqEmX
 ulYISIh7idTqXWL1NA1jHDCJlOpYSDah4siRfeVFKbaNXP5ZO/JVvWjP8CkM3Ma7WoXygNdaEom
 jF+7uu2KWsrH0J8MhZoNBgHBU2B8FvYbpjEW5DxB5AIbLXC8iblebaLv4ufiygcLnAWcUghZRgT
 vF87fYx9eTqZh4i/Sq4WV0r145XJVFQQyzxX03AYT74iaNEuuMfzaXtplmcsr4XAn8E77l50YCc
 C8SiWeiVEx6ivGKKt7aNmILnO4Sy7EeCI09vXcsVATnkjeSoBneaRwq+xEx8a47wSanbQ8BbHCY
 C8H1S0vZVhYLC2qkDgN7G0vsIzpRlDlDTX5ro05YAizlFn8IBYePGWaN0zvKMg2mDN7rsp0HZPi
 nhl4ECuPqxKzX45uZmj0zd9wi4aXr+ccpLUPogm1JIccfV36PDfkM3T1z38KN+RzU4eFF9p2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_09,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=983 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505180179

From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>

Add ath12k_hw_params for the new ath12k AHB-based WiFi device IPQ5424.
The WiFi device IPQ5424 is similar to IPQ5332. Most of the hardware
parameters like hw_ops, wmi_init, hal_ops, etc., are the same between
IPQ5424 and IPQ5332, hence use these same parameters for IPQ5424.
Some parameters are specific to IPQ5424; initially set these to
0 or NULL, and populate them in subsequent patches.

Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.5-01053-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/hw.c   | 78 ++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3aafbac46e81af9ed2da34201522fb9e73650205..b45f40f92f615dbfb2dd5f95f308865d42ea5bdc 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -150,6 +150,7 @@ enum ath12k_hw_rev {
 	ATH12K_HW_QCN9274_HW20,
 	ATH12K_HW_WCN7850_HW20,
 	ATH12K_HW_IPQ5332_HW10,
+	ATH12K_HW_IPQ5424_HW10,
 };
 
 enum ath12k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 7e2cf0fb2085ab014fc14a5c81074802674b154e..866de53f37bb5af94e16c796a0052fda39eb4ea8 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1590,6 +1590,84 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.ce_remap = &ath12k_ce_remap_ipq5332,
 		.bdf_addr_offset = 0xC00000,
 
+		.dp_primary_link_only = true,
+	},
+	{
+		.name = "ipq5424 hw1.0",
+		.hw_rev = ATH12K_HW_IPQ5424_HW10,
+		.fw = {
+			.dir = "IPQ5424/hw1.0",
+			.board_size = 256 * 1024,
+			.cal_offset = 128 * 1024,
+			.m3_loader = ath12k_m3_fw_loader_remoteproc,
+		},
+		.max_radios = 1,
+		.single_pdev_only = false,
+		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ5332,
+		.internal_sleep_clock = false,
+
+		.hw_ops = &qcn9274_ops,
+		.regs = NULL,
+		.ring_mask = &ath12k_hw_ring_mask_ipq5332,
+
+		.host_ce_config = ath12k_host_ce_config_ipq5332,
+		.ce_count = 12,
+		.target_ce_config = ath12k_target_ce_config_wlan_ipq5332,
+		.target_ce_count = 12,
+		.svc_to_ce_map = ath12k_target_service_to_ce_map_wlan_ipq5332,
+		.svc_to_ce_map_len = 18,
+
+		.hal_params = &ath12k_hw_hal_params_ipq5332,
+
+		.rxdma1_enable = false,
+		.num_rxdma_per_pdev = 1,
+		.num_rxdma_dst_ring = 0,
+		.rx_mac_buf_ring = false,
+		.vdev_start_delay = false,
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_MESH_POINT),
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
+
+		.ce_ie_addr = NULL,
+		.ce_remap = NULL,
+		.bdf_addr_offset = 0x940000,
+
 		.dp_primary_link_only = true,
 	},
 };

-- 
2.34.1


