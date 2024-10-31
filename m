Return-Path: <linux-wireless+bounces-14756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6529B70DF
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 01:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B10A2843A9
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 00:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA4819;
	Thu, 31 Oct 2024 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YrbfxZ5q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C346360;
	Thu, 31 Oct 2024 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730333177; cv=none; b=AHwjfiChXRWLSc+yhvctOvOdXiSDQRH7xQdVsYHnjwG3OEBMucAq5SYOHdJylDt5MFxrx58jfBxn41BkvGc4688FBp7iwbNVSuUkqPxdIeNOy/qp+209PDpZ5U1qk5UiNVI++tkq4BOvZh5zKfgN3FesdvEJYqADszjA+EXWMF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730333177; c=relaxed/simple;
	bh=VgqGqBWzQNnoOa7tSUK/E3WohvnlLcWAeqAyQDnlsq4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r+fX/kZEEzqg/Sa9YW2eBagje5CT6hpdDlLXBbn07xwROFtkQ+SJf0kHojoQgXUKnwrVjLTNvwMTx6Db0iC9xRxYKUxBrJPaDTRunkSGxXqN6uIoPJRC0dVrc7wpRvWadlRViOCTHiyh+n//GRa66i2R1KlTFTDqNa/3Mlk3iZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YrbfxZ5q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UDHvvr027500;
	Thu, 31 Oct 2024 00:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Xgt8vpa5ZkFXfZJU5MN+ra
	pPRoKRHw0wEGUMzYQCp6A=; b=YrbfxZ5q84c0Ygo3qSBSzhKOR4ZnmNcqKjBMvg
	RN+gDyNKQXcpdCpUH4uqGp8kq1W1GKm+O7QRH1CFQLLSJYxHXX7/sKd+/tKo9aE+
	h+c4JwtOzPRt3gpTTHhZnsMj6Fg/mL12cbSj+rrdXFlnmuDaCRvPfscYk/mpXO7y
	MX+a3IU0EjUAU2cfqllnBPi+oIbspFz2hbM685/FEum2urXwpRqca5pkBt7K8E6l
	2kPm+ENfkoCWNDHxIg4EtzCk9w6oDZH7m/IM8PdzrF6mc0YQKMwqHRo93WioT5Z6
	FD/hUtNY4gLhr9r9NLl00sW0IX0x+iVS6kixae/sJsRYSH3Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42k1p350fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 00:06:04 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49V063hq022882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 00:06:03 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 17:06:01 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Miaoqing
 Pan" <quic_miaoqing@quicinc.com>
Subject: [PATCH] wifi: ath11k: add support for QCA6698AQ
Date: Thu, 31 Oct 2024 08:05:41 +0800
Message-ID: <20241031000541.3331606-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: -DTfQI27SQ8japcyAzuH5NsxGvEl41qY
X-Proofpoint-ORIG-GUID: -DTfQI27SQ8japcyAzuH5NsxGvEl41qY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300182

QCA6698AQ IP core is the same as WCN6855 hw2.1, they share the same
PCI device ID, the same major and minor version numbers, the same
register address, and same HAL descriptors, etc. The most significant
difference is that QCA6698AQ has different RF, IPA, thermal, etc.

Follow the approach done in commit 5dc9d1a55e95 ("wifi: ath11k: add
support for QCA2066"), enumerate the subversion number to identify the
specific card.

Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 87 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mhi.c  |  1 +
 drivers/net/wireless/ath/ath11k/pci.c  |  3 +
 drivers/net/wireless/ath/ath11k/pcic.c | 13 +++-
 5 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index be67382c00f6..f8c57c074423 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -803,6 +803,93 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 			.end = 0x0177ffff,
 		},
 
+		.tcl_ring_retry = true,
+		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
+		.smp2p_wow_exit = false,
+		.support_fw_mac_sequence = true,
+		.support_dual_stations = true,
+	},
+	{
+		.name = "qca6698aq hw2.1",
+		.hw_rev = ATH11K_HW_QCA6698AQ_HW21,
+		.fw = {
+			.dir = "QCA6698AQ/hw2.1",
+			.board_size = 256 * 1024,
+			.cal_offset = 128 * 1024,
+		},
+		.max_radios = 3,
+		.bdf_addr = 0x4B0C0000,
+		.hw_ops = &wcn6855_ops,
+		.ring_mask = &ath11k_hw_ring_mask_qca6390,
+		.internal_sleep_clock = true,
+		.regs = &wcn6855_regs,
+		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390,
+		.host_ce_config = ath11k_host_ce_config_qca6390,
+		.ce_count = 9,
+		.target_ce_config = ath11k_target_ce_config_wlan_qca6390,
+		.target_ce_count = 9,
+		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
+		.svc_to_ce_map_len = 14,
+		.single_pdev_only = true,
+		.rxdma1_enable = false,
+		.num_rxdma_per_pdev = 2,
+		.rx_mac_buf_ring = true,
+		.vdev_start_delay = true,
+		.htt_peer_map_v2 = false,
+
+		.spectral = {
+			.fft_sz = 0,
+			.fft_pad_sz = 0,
+			.summary_pad_sz = 0,
+			.fft_hdr_len = 0,
+			.max_fft_bins = 0,
+			.fragment_160mhz = false,
+		},
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_P2P_DEVICE) |
+					BIT(NL80211_IFTYPE_P2P_CLIENT) |
+					BIT(NL80211_IFTYPE_P2P_GO),
+		.supports_monitor = false,
+		.supports_shadow_regs = true,
+		.idle_ps = true,
+		.supports_sta_ps = true,
+		.coldboot_cal_mm = false,
+		.coldboot_cal_ftm = false,
+		.cbcal_restart_fw = false,
+		.fw_mem_mode = 0,
+		.num_vdevs = 2 + 1,
+		.num_peers = 512,
+		.supports_suspend = true,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
+		.supports_regdb = true,
+		.fix_l1ss = false,
+		.credit_flow = true,
+		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
+		.hal_params = &ath11k_hw_hal_params_qca6390,
+		.supports_dynamic_smps_6ghz = false,
+		.alloc_cacheable_memory = false,
+		.supports_rssi_stats = true,
+		.fw_wmi_diag_event = true,
+		.current_cc_support = true,
+		.dbr_debug_support = false,
+		.global_reset = true,
+		.bios_sar_capa = &ath11k_hw_sar_capa_wcn6855,
+		.m3_fw_support = true,
+		.fixed_bdf_addr = false,
+		.fixed_mem_region = false,
+		.static_window_map = false,
+		.hybrid_bus_type = false,
+		.fixed_fw_mem = false,
+		.support_off_channel_tx = true,
+		.supports_multi_bssid = true,
+
+		.sram_dump = {
+			.start = 0x01400000,
+			.end = 0x0177ffff,
+		},
+
 		.tcl_ring_retry = true,
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 09c37e19a168..4764ded58610 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -148,6 +148,7 @@ enum ath11k_hw_rev {
 	ATH11K_HW_WCN6750_HW10,
 	ATH11K_HW_IPQ5018_HW10,
 	ATH11K_HW_QCA2066_HW21,
+	ATH11K_HW_QCA6698AQ_HW21,
 };
 
 enum ath11k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 6974a551883f..6e45f464a429 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -398,6 +398,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	case ATH11K_HW_WCN6855_HW20:
 	case ATH11K_HW_WCN6855_HW21:
 	case ATH11K_HW_QCA2066_HW21:
+	case ATH11K_HW_QCA6698AQ_HW21:
 		ath11k_mhi_config = &ath11k_mhi_config_qca6390;
 		break;
 	default:
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index be9d2c69cc41..b93f04973ad7 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -846,6 +846,9 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 				case 0x1019D0E1:
 					ab->hw_rev = ATH11K_HW_QCA2066_HW21;
 					break;
+				case 0x001e60e1:
+					ab->hw_rev = ATH11K_HW_QCA6698AQ_HW21;
+					break;
 				default:
 					ab->hw_rev = ATH11K_HW_WCN6855_HW21;
 				}
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index debe7c5919ef..3fe77310c71f 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -126,6 +126,17 @@ static const struct ath11k_msi_config ath11k_msi_config[] = {
 		},
 		.hw_rev = ATH11K_HW_QCA2066_HW21,
 	},
+	{
+		.total_vectors = 32,
+		.total_users = 4,
+		.users = (struct ath11k_msi_user[]) {
+			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
+			{ .name = "CE", .num_vectors = 10, .base_vector = 3 },
+			{ .name = "WAKE", .num_vectors = 1, .base_vector = 13 },
+			{ .name = "DP", .num_vectors = 18, .base_vector = 14 },
+		},
+		.hw_rev = ATH11K_HW_QCA6698AQ_HW21,
+	},
 };
 
 int ath11k_pcic_init_msi_config(struct ath11k_base *ab)
-- 
2.25.1


