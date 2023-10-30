Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE797DC276
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 23:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjJ3W2M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 18:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjJ3W2L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 18:28:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74790C6
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 15:28:06 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMNYoC016939;
        Mon, 30 Oct 2023 22:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qGDyLBd+xHampmqP58LbPyFf8Ev5fAUOi5ZLNMMtUMw=;
 b=N8f4VHr+dGcJ44xKT7DxQsIzPyhEA57G7aSPx2KRST2G1BAQtPaJbmKozLn52lyy5g9x
 5mORNEIBtvgpHmKEJPv94meNJSuZlKpWGGD1b9/rdNSAc/q+vnJtOGCMASo57zl6syDw
 yFSUWzFtMvsGFJfchDc+1qStBmFBm4E7JqcwAeqN9mOzVOlVsT8twlYUKuR3yyZ79gid
 jZvxomEYEpUcNGRdzSsI8c94zgSSRJuaDM4mAoKjbQhm7xwQaWEyAWlfHq2fQHm0CUUB
 iRPPb/LLgrS9pXNu+cIX8ZLVCNOnftU3H2L/iNl8qjZvrzs0mqlPIQpqEugmGid/sUeG Mw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0sw7w3w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:28:03 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UMS2u8020813
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:28:02 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 15:28:00 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Ganesh Babu Jothiram <quic_gjothira@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 13/13] wifi: ath12k: Read board id to support split-PHY QCN9274
Date:   Tue, 31 Oct 2023 03:57:00 +0530
Message-ID: <20231030222700.18914-14-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rMb5741wz597rtQWJ5lHuLIG-kNk65r_
X-Proofpoint-GUID: rMb5741wz597rtQWJ5lHuLIG-kNk65r_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ganesh Babu Jothiram <quic_gjothira@quicinc.com>

QCN9274 can support single-PHY or split-PHY architecture. Currently,
only the single-PHY architecture is supported in ath12k.

The split-PHY QCN9274 requires different AMSS firmware binary
"amss_dualmac.bin".

Hence, add support to read board id from OTP. Based on board id
decide whether single-mac / dual-mac firmware needs to be downloaded
to the target. Also, update HW param max_radios to support split-PHY
in QCN9274.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ganesh Babu Jothiram <quic_gjothira@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  |  5 ++++-
 drivers/net/wireless/ath/ath12k/hw.h  |  3 +++
 drivers/net/wireless/ath/ath12k/mac.c |  3 ++-
 drivers/net/wireless/ath/ath12k/mhi.c | 21 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/pci.h |  3 +++
 5 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 9f3681bd5..fe7ab72da 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -913,6 +913,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rfkill_on_level = 0,
 
 		.rddm_size = 0,
+		.otp_board_id_register = QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -975,6 +976,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rfkill_on_level = 1,
 
 		.rddm_size = 0x780000,
+		.otp_board_id_register = 0,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -984,7 +986,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 128 * 1024,
 		},
-		.max_radios = 1,
+		.max_radios = 2,
 		.single_pdev_only = false,
 		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_QCN9274,
 		.internal_sleep_clock = false,
@@ -1036,6 +1038,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rfkill_on_level = 0,
 
 		.rddm_size = 0,
+		.otp_board_id_register = QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index c3754a9a5..acb1f4f4e 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -92,6 +92,7 @@
 #define ATH12K_DEFAULT_BOARD_FILE	"board.bin"
 #define ATH12K_DEFAULT_CAL_FILE		"caldata.bin"
 #define ATH12K_AMSS_FILE		"amss.bin"
+#define ATH12K_AMSS_DUALMAC_FILE	"amss_dualmac.bin"
 #define ATH12K_M3_FILE			"m3.bin"
 #define ATH12K_REGDB_FILE_NAME		"regdb.bin"
 
@@ -204,6 +205,8 @@ struct ath12k_hw_params {
 	u32 rfkill_on_level;
 
 	u32 rddm_size;
+
+	u32 otp_board_id_register;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1170801f2..e49715a54 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -558,7 +558,8 @@ struct ath12k_vif *ath12k_mac_get_arvif_by_vdev_id(struct ath12k_base *ab,
 
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = rcu_dereference(ab->pdevs_active[i]);
-		if (pdev && pdev->ar) {
+		if (pdev && pdev->ar &&
+		    (pdev->ar->allocated_vdev_map & (1LL << vdev_id))) {
 			arvif = ath12k_mac_get_arvif(pdev->ar, vdev_id);
 			if (arvif)
 				return arvif;
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 39e640293..60ab3fd5c 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -13,6 +13,8 @@
 #include "pci.h"
 
 #define MHI_TIMEOUT_DEFAULT_MS	90000
+#define OTP_INVALID_BOARD_ID	0xFFFF
+#define OTP_VALID_DUALMAC_BOARD_ID_MASK	0x1000
 
 static const struct mhi_channel_config ath12k_mhi_channels_qcn9274[] = {
 	{
@@ -351,13 +353,30 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 {
 	struct ath12k_base *ab = ab_pci->ab;
 	struct mhi_controller *mhi_ctrl;
+	unsigned int board_id, otp_board_id;
+	const char *filename = ATH12K_AMSS_FILE;
 	int ret;
 
 	mhi_ctrl = mhi_alloc_controller();
 	if (!mhi_ctrl)
 		return -ENOMEM;
 
-	ath12k_core_create_firmware_path(ab, ATH12K_AMSS_FILE,
+	if (ab->hw_params->otp_board_id_register) {
+		otp_board_id =
+			ath12k_pci_read32(ab, ab->hw_params->otp_board_id_register);
+		board_id = u32_get_bits(otp_board_id, OTP_BOARD_ID_MASK);
+
+		if (!board_id || (board_id == OTP_INVALID_BOARD_ID)) {
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "failed to read board id\n");
+		} else if (board_id & OTP_VALID_DUALMAC_BOARD_ID_MASK) {
+			filename = ATH12K_AMSS_DUALMAC_FILE;
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "dualmac fw selected for board id: %x\n", board_id);
+		}
+	}
+
+	ath12k_core_create_firmware_path(ab, filename,
 					 ab_pci->amss_path,
 					 sizeof(ab_pci->amss_path));
 
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 6d971a367..521b57d6e 100644
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
2.17.1

