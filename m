Return-Path: <linux-wireless+bounces-1539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A108825B51
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 20:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A101F21342
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 19:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB8364D5;
	Fri,  5 Jan 2024 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BoKvgH4k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7923364BB
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405ClwiV002883;
	Fri, 5 Jan 2024 19:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=La4xpov3I+JtCxCGzd7fz8Qr+d24hl4TpRvEJlxPy0M=; b=Bo
	KvgH4k0BN81kYnTvc/ODBtbhB4iDojulogEMZTjwGTeN4/QGTi3gxjOnO+p2FlaG
	XGo2sZzFEVZV+7qcq0bI/zNn0xif9zVjviJx1TfVdoojHFu7WAxJtvm1IwdU1VAA
	B+LGtEYq7XAzk0ROiQuj+y4nbD2Py6z6VU78GZ9NjHxl33k8CVaYES4BJ4piK1ob
	rE9FhR9m8hrHnmpZE+hJnXgRL3r2HqCW5afdLteNMvxeVyv6FodFk3STU9EZWN74
	a+qPCDUEEKkg9z5mp7q685cWIXTfbX29A3z2pqBz1+LqCCbTo7MVP2A3XIhL2w6b
	wosNKpOTsSDkj1xWnV1A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve9a3t5nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 19:57:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405JvO8O008906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 19:57:24 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 5 Jan 2024 11:57:22 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Ganesh Babu Jothiram
	<quic_gjothira@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 12/12] wifi: ath12k: Read board id to support split-PHY QCN9274
Date: Sat, 6 Jan 2024 01:26:39 +0530
Message-ID: <20240105195639.3217739-13-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
References: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: GGGAAG3miXGQKNG-0D4VAwnbG6nPwpge
X-Proofpoint-ORIG-GUID: GGGAAG3miXGQKNG-0D4VAwnbG6nPwpge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050161

From: Ganesh Babu Jothiram <quic_gjothira@quicinc.com>

QCN9274 can support single-PHY or split-PHY architecture. Currently,
only the single-PHY architecture is supported in ath12k.

The split-PHY QCN9274 requires different AMSS firmware binary
"amss_dualmac.bin".

Hence, add support to read board id from OTP. Based on board id
decide whether single-mac / dual-mac firmware needs to be downloaded
to the target. Also, update HW param max_radios to support split-PHY
in QCN9274.

Also, add new Firmware IE for firmware_N.bin
"ATH11K_FW_IE_AMSS_DUALMAC_IMAGE" to support dualmac QCN9274.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Depends-On: wifi: ath12k: add firmware-2.bin support

Signed-off-by: Ganesh Babu Jothiram <quic_gjothira@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 ++
 drivers/net/wireless/ath/ath12k/fw.c   |  7 ++++
 drivers/net/wireless/ath/ath12k/fw.h   |  1 +
 drivers/net/wireless/ath/ath12k/hw.c   |  5 ++-
 drivers/net/wireless/ath/ath12k/hw.h   |  2 ++
 drivers/net/wireless/ath/ath12k/mac.c  |  3 +-
 drivers/net/wireless/ath/ath12k/mhi.c  | 49 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/pci.h  |  3 ++
 8 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 36c9dcd57bdc..293eae9849fe 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -814,6 +814,8 @@ struct ath12k_base {
 		const struct firmware *fw;
 		const u8 *amss_data;
 		size_t amss_len;
+		const u8 *amss_dualmac_data;
+		size_t amss_dualmac_len;
 		const u8 *m3_data;
 		size_t m3_len;
 
diff --git a/drivers/net/wireless/ath/ath12k/fw.c b/drivers/net/wireless/ath/ath12k/fw.c
index 85caa1074499..0f4db594700f 100644
--- a/drivers/net/wireless/ath/ath12k/fw.c
+++ b/drivers/net/wireless/ath/ath12k/fw.c
@@ -119,6 +119,13 @@ static int ath12k_fw_request_firmware_api_n(struct ath12k_base *ab,
 			ab->fw.m3_data = data;
 			ab->fw.m3_len = ie_len;
 			break;
+		case ATH12K_FW_IE_AMSS_DUALMAC_IMAGE:
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "found dualmac fw image ie (%zd B)\n",
+				   ie_len);
+			ab->fw.amss_dualmac_data = data;
+			ab->fw.amss_dualmac_len = ie_len;
+			break;
 		default:
 			ath12k_warn(ab, "Unknown FW IE: %u\n", ie_id);
 			break;
diff --git a/drivers/net/wireless/ath/ath12k/fw.h b/drivers/net/wireless/ath/ath12k/fw.h
index 687b0d22fce3..f79ce86b3bc9 100644
--- a/drivers/net/wireless/ath/ath12k/fw.h
+++ b/drivers/net/wireless/ath/ath12k/fw.h
@@ -14,6 +14,7 @@ enum ath12k_fw_ie_type {
 	ATH12K_FW_IE_FEATURES = 1,
 	ATH12K_FW_IE_AMSS_IMAGE = 2,
 	ATH12K_FW_IE_M3_IMAGE = 3,
+	ATH12K_FW_IE_AMSS_DUALMAC_IMAGE = 4,
 };
 
 enum ath12k_fw_features {
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index c4a79167b9f4..60938a8c6967 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -913,6 +913,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rfkill_on_level = 0,
 
 		.rddm_size = 0,
+		.otp_board_id_register = QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -976,6 +977,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rfkill_on_level = 1,
 
 		.rddm_size = 0x780000,
+		.otp_board_id_register = 0,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -985,7 +987,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 128 * 1024,
 		},
-		.max_radios = 1,
+		.max_radios = 2,
 		.single_pdev_only = false,
 		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_QCN9274,
 		.internal_sleep_clock = false,
@@ -1037,6 +1039,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rfkill_on_level = 0,
 
 		.rddm_size = 0,
+		.otp_board_id_register = QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index c82d3a27b4b4..abccdfdddfd8 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -204,6 +204,8 @@ struct ath12k_hw_params {
 	u32 rfkill_on_level;
 
 	u32 rddm_size;
+
+	u32 otp_board_id_register;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 55fcd3c560b9..d978210e32e0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -563,7 +563,8 @@ struct ath12k_vif *ath12k_mac_get_arvif_by_vdev_id(struct ath12k_base *ab,
 
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = rcu_dereference(ab->pdevs_active[i]);
-		if (pdev && pdev->ar) {
+		if (pdev && pdev->ar &&
+		    (pdev->ar->allocated_vdev_map & (1LL << vdev_id))) {
 			arvif = ath12k_mac_get_arvif(pdev->ar, vdev_id);
 			if (arvif)
 				return arvif;
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index b7b31978a434..50b9e44504f7 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -14,6 +14,8 @@
 #include "pci.h"
 
 #define MHI_TIMEOUT_DEFAULT_MS	90000
+#define OTP_INVALID_BOARD_ID	0xFFFF
+#define OTP_VALID_DUALMAC_BOARD_ID_MASK		0x1000
 
 static const struct mhi_channel_config ath12k_mhi_channels_qcn9274[] = {
 	{
@@ -359,7 +361,9 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 {
 	struct ath12k_base *ab = ab_pci->ab;
 	struct mhi_controller *mhi_ctrl;
+	unsigned int board_id;
 	int ret;
+	bool dualmac = false;
 
 	mhi_ctrl = mhi_alloc_controller();
 	if (!mhi_ctrl)
@@ -371,16 +375,43 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	mhi_ctrl->reg_len = ab->mem_len;
 	mhi_ctrl->rddm_size = ab->hw_params->rddm_size;
 
-	if (ab->fw.amss_data && ab->fw.amss_len > 0) {
-		/* use MHI firmware file from firmware-N.bin */
-		mhi_ctrl->fw_data = ab->fw.amss_data;
-		mhi_ctrl->fw_sz = ab->fw.amss_len;
+	if (ab->hw_params->otp_board_id_register) {
+		board_id =
+			ath12k_pci_read32(ab, ab->hw_params->otp_board_id_register);
+		board_id = u32_get_bits(board_id, OTP_BOARD_ID_MASK);
+
+		if (!board_id || (board_id == OTP_INVALID_BOARD_ID)) {
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "failed to read board id\n");
+		} else if (board_id & OTP_VALID_DUALMAC_BOARD_ID_MASK) {
+			dualmac = true;
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "dualmac fw selected for board id: %x\n", board_id);
+		}
+	}
+
+	if (dualmac) {
+		if (ab->fw.amss_dualmac_data && ab->fw.amss_dualmac_len > 0) {
+			/* use MHI firmware file from firmware-N.bin */
+			mhi_ctrl->fw_data = ab->fw.amss_dualmac_data;
+			mhi_ctrl->fw_sz = ab->fw.amss_dualmac_len;
+		} else {
+			ath12k_warn(ab, "dualmac firmware IE not present in firmware-N.bin\n");
+			ret = -ENOENT;
+			goto free_controller;
+		}
 	} else {
-		/* use the old separate mhi.bin MHI firmware file */
-		ath12k_core_create_firmware_path(ab, ATH12K_AMSS_FILE,
-						 ab_pci->amss_path,
-						 sizeof(ab_pci->amss_path));
-		mhi_ctrl->fw_image = ab_pci->amss_path;
+		if (ab->fw.amss_data && ab->fw.amss_len > 0) {
+			/* use MHI firmware file from firmware-N.bin */
+			mhi_ctrl->fw_data = ab->fw.amss_data;
+			mhi_ctrl->fw_sz = ab->fw.amss_len;
+		} else {
+			/* use the old separate mhi.bin MHI firmware file */
+			ath12k_core_create_firmware_path(ab, ATH12K_AMSS_FILE,
+							 ab_pci->amss_path,
+							 sizeof(ab_pci->amss_path));
+			mhi_ctrl->fw_image = ab_pci->amss_path;
+		}
 	}
 
 	ret = ath12k_mhi_get_msi(ab_pci);
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 023616928f03..ca93693ba4e9 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -53,6 +53,9 @@
 #define WLAON_QFPROM_PWR_CTRL_REG		0x01f8031c
 #define QFPROM_PWR_CTRL_VDD4BLOW_MASK		0x4
 
+#define QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB	0x1E20338
+#define OTP_BOARD_ID_MASK			GENMASK(15, 0)
+
 #define PCI_BAR_WINDOW0_BASE	0x1E00000
 #define PCI_BAR_WINDOW0_END	0x1E7FFFC
 #define PCI_SOC_RANGE_MASK	0x3FFF
-- 
2.34.1


