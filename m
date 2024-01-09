Return-Path: <linux-wireless+bounces-1607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93A0827CCA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 03:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CBD4B23357
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 02:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DD528FE;
	Tue,  9 Jan 2024 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c16AGZPF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698AE2115
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jan 2024 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40918Jr7010102;
	Tue, 9 Jan 2024 02:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=fT4tuj9V8MwcnxW+uUrmdJfAhd5xHHK6fMJ4Ww+7EZQ=; b=c1
	6AGZPFd9iCBuCumHnbBuqfy/R8y7COvpUVjUpcoY9LnJSNGvLJXGzw46TqWjLzrS
	ffwWSLh4Yf4CNBH3NAKO7SaffqYt9G1mNiWgIQsw7pjFdUI8lRS+tG6a/Cb6zSmW
	4izN9ToNVgbPEL/7NrdAF7ROqouUP8nzEDgn37DjXjW435GHYbVtBLQvm8DeF2zL
	GwdjGg27uefLIjGSYaeDYZU2lQy0ola66kBECxyjCCog/TFN+Rdx+WDO8D20U7ZT
	XSlV3XvewfUkvffmF+N5Wc8XsqeOJ4kKxf7l2buhq95cVasK3Y0kmeWR2au7Jng1
	Exs9e/xRMNwdaK1BI8Dw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgkkh994s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 02:13:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4092Dwrf024639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 02:13:58 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 18:13:57 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 2/2] wifi: ath11k: add support for QCA2066
Date: Tue, 9 Jan 2024 10:13:36 +0800
Message-ID: <20240109021336.4143-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240109021336.4143-1-quic_bqiang@quicinc.com>
References: <20240109021336.4143-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wMORPzX2jPqk832TnnAQCn5Mld1XOhYX
X-Proofpoint-ORIG-GUID: wMORPzX2jPqk832TnnAQCn5Mld1XOhYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090011

QCA2066 is a PCI based DBS device. It is very similar to WCN6855
overall: they share the same PCI device ID, the same major and
minor version numbers, the same register address, and same HAL
descriptors etc. The most significant difference is that QCA2066
supports 3-antenna configuration while WCN6855 does not. To differentiate
them, subversion numbers are used. Currently four numbers are used
by QCA2066: 0x1019A0E1, 0x1019B0E1, 0x1019C0E1 and 0x1019D0E1.

Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03737-QCAHSPSWPL_V2_SILICONZ_CE-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v2:
 - Rebased on ToT.

 drivers/net/wireless/ath/ath11k/core.c | 86 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mhi.c  |  1 +
 drivers/net/wireless/ath/ath11k/pci.c  | 17 ++++-
 drivers/net/wireless/ath/ath11k/pcic.c | 11 ++++
 5 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3c1ba8fd28f4..922e67f8e04f 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -711,6 +711,92 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = false,
 		.support_dual_stations = false,
 	},
+	{
+		.name = "qca2066 hw2.1",
+		.hw_rev = ATH11K_HW_QCA2066_HW21,
+		.fw = {
+			.dir = "QCA2066/hw2.1",
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
+		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
+		.single_pdev_only = true,
+		.rxdma1_enable = false,
+		.num_rxmda_per_pdev = 2,
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
+					BIT(NL80211_IFTYPE_AP),
+		.supports_monitor = false,
+		.full_monitor_mode = false,
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
+		.tcl_ring_retry = true,
+		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
+		.smp2p_wow_exit = false,
+		.support_fw_mac_sequence = true,
+		.support_dual_stations = true,
+	},
 };
 
 static inline struct ath11k_pdev *ath11k_core_get_single_pdev(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 7e3b6779f4e9..38c66cc73092 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -147,6 +147,7 @@ enum ath11k_hw_rev {
 	ATH11K_HW_WCN6855_HW21,
 	ATH11K_HW_WCN6750_HW10,
 	ATH11K_HW_IPQ5018_HW10,
+	ATH11K_HW_QCA2066_HW21,
 };
 
 enum ath11k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 6835c14b82cc..1f0eb5cba8d4 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -443,6 +443,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	case ATH11K_HW_QCA6390_HW20:
 	case ATH11K_HW_WCN6855_HW20:
 	case ATH11K_HW_WCN6855_HW21:
+	case ATH11K_HW_QCA2066_HW21:
 		ath11k_mhi_config = &ath11k_mhi_config_qca6390;
 		break;
 	default:
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 1159c00f9411..13b53f2979df 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -28,6 +28,8 @@
 #define QCN9074_DEVICE_ID		0x1104
 #define WCN6855_DEVICE_ID		0x1103
 
+#define TCSR_SOC_HW_SUB_VER	0x1910010
+
 static const struct pci_device_id ath11k_pci_id_table[] = {
 	{ PCI_VDEVICE(QCOM, QCA6390_DEVICE_ID) },
 	{ PCI_VDEVICE(QCOM, WCN6855_DEVICE_ID) },
@@ -732,6 +734,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	struct ath11k_pci *ab_pci;
 	u32 soc_hw_version_major, soc_hw_version_minor, addr;
 	int ret;
+	u32 sub_version;
 
 	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI);
 
@@ -822,7 +825,19 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 				break;
 			case 0x10:
 			case 0x11:
-				ab->hw_rev = ATH11K_HW_WCN6855_HW21;
+				sub_version = ath11k_pcic_read32(ab, TCSR_SOC_HW_SUB_VER);
+				ath11k_dbg(ab, ATH11K_DBG_PCI, "sub_version 0x%x\n",
+					   sub_version);
+				switch (sub_version) {
+				case 0x1019A0E1:
+				case 0x1019B0E1:
+				case 0x1019C0E1:
+				case 0x1019D0E1:
+					ab->hw_rev = ATH11K_HW_QCA2066_HW21;
+					break;
+				default:
+					ab->hw_rev = ATH11K_HW_WCN6855_HW21;
+				}
 				break;
 			default:
 				goto unsupported_wcn6855_soc;
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index 15e2ceb22a44..add4db4c50bc 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -115,6 +115,17 @@ static const struct ath11k_msi_config ath11k_msi_config[] = {
 		},
 		.hw_rev = ATH11K_HW_WCN6750_HW10,
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
+		.hw_rev = ATH11K_HW_QCA2066_HW21,
+	},
 };
 
 int ath11k_pcic_init_msi_config(struct ath11k_base *ab)
-- 
2.25.1


