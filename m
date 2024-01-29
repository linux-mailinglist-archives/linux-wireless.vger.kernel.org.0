Return-Path: <linux-wireless+bounces-2646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFAF83FEC3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 07:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4CD1C210C4
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F947524B4;
	Mon, 29 Jan 2024 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ONcrcx9b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3382524BA
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511496; cv=none; b=ifG5ePi6FNkx/79jDQ2u90OXenNZKjNET218ktxayujJZ3NRqhIhFSoSq7n4TxipFLONaqDIINhJYeBky3pS8zNeB+GRUv4YRKAHW12MDXnVJOCgzFKlMpn7d/Bb5paB81QwJRa4ABMqJp13JGRgnRLP1Sp4TEdSI29Z/tXqJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511496; c=relaxed/simple;
	bh=qCgRfs2s9BEdoGfILxNuXSGttba849g73lilEy8e6yI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3BM6TPLn8lD2l00DCgNl28yNEuBN9Bu3IwJNuEBMdQw1TOXTEDghIP9/f8Vl40HPwj1mWSJHE/Abf3LWZ7mKaqugwUXIj+QzZqMKqnpgtjvRdkm9LxTEh2eF0iT4q9tiQXjkJt6XDtm2enMVNNFJqEbzrOsejGSggHkOIeK70g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ONcrcx9b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5vOHp024681;
	Mon, 29 Jan 2024 06:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=1lG1cSpptXRyugKN7krkqTjETF6Q1vqWBeNmjQFDipY=; b=ON
	crcx9bRI8hZU5tahGLT6rpIbHVxhzW3YE89R/vKdekspT/do3kkJJlsRn0heLCWn
	mqhJ/is+R4JWweT850wCW4YV/cGzqRjNfj87CLDaB1MnyTTMpK4RNdDXJQumi2K+
	xbJNvxyF5uaRvtlrCslQOauuAXkY7d0K9o5ycoKUq0vU6QeMUs5gMkUBkNZ/ueLb
	3jJMRFI81Tt0g4HgWQokswAvNjyPPyNp9d3kyEDJ+650vr4riKZovCMw6Q7iGxch
	pR6A2b+G3LqrKoPYd9ffImqGxukuGnvWUhviDe9tgPK/JlMvAYqN4uROqr4bk7Y5
	O+OmmVElvpipUwwAJyKQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvqhmu6fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:58:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6wBJo017329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:58:11 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 22:58:09 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Ganesh Babu Jothiram
	<quic_gjothira@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 12/13] wifi: ath12k: Read board id to support split-PHY QCN9274
Date: Mon, 29 Jan 2024 12:27:23 +0530
Message-ID: <20240129065724.2310207-13-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mn6mOpTbp3_IysC5uyrMbjWiNi1Qj_Yi
X-Proofpoint-ORIG-GUID: mn6mOpTbp3_IysC5uyrMbjWiNi1Qj_Yi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_03,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290049

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
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ganesh Babu Jothiram <quic_gjothira@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 ++
 drivers/net/wireless/ath/ath12k/fw.c   |  7 ++++
 drivers/net/wireless/ath/ath12k/fw.h   |  1 +
 drivers/net/wireless/ath/ath12k/hw.c   |  8 ++++-
 drivers/net/wireless/ath/ath12k/hw.h   |  2 ++
 drivers/net/wireless/ath/ath12k/mac.c  |  3 +-
 drivers/net/wireless/ath/ath12k/mhi.c  | 49 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/pci.h  |  3 ++
 8 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 67bf8d840b00..f0a319ea57c1 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -832,6 +832,8 @@ struct ath12k_base {
 		const struct firmware *fw;
 		const u8 *amss_data;
 		size_t amss_len;
+		const u8 *amss_dualmac_data;
+		size_t amss_dualmac_len;
 		const u8 *m3_data;
 		size_t m3_len;
 
diff --git a/drivers/net/wireless/ath/ath12k/fw.c b/drivers/net/wireless/ath/ath12k/fw.c
index fbcf40c97792..5be4b2d4a19d 100644
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
index 28dc1423df70..3ff041f15fa0 100644
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
index f399511746a8..a9adb547c83d 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -916,6 +916,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.def_num_link = 0,
 		.max_mlo_peer = 256,
+
+		.otp_board_id_register = QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -982,6 +984,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.def_num_link = 2,
 		.max_mlo_peer = 32,
+
+		.otp_board_id_register = 0,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -991,7 +995,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 128 * 1024,
 		},
-		.max_radios = 1,
+		.max_radios = 2,
 		.single_pdev_only = false,
 		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_QCN9274,
 		.internal_sleep_clock = false,
@@ -1046,6 +1050,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.def_num_link = 0,
 		.max_mlo_peer = 256,
+
+		.otp_board_id_register = QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 987188f56b29..2e9c3b05d75a 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -207,6 +207,8 @@ struct ath12k_hw_params {
 
 	u8 def_num_link;
 	u16 max_mlo_peer;
+
+	u32 otp_board_id_register;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 046bb466a391..6ef55876e7df 100644
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


