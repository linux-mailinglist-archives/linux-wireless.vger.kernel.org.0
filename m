Return-Path: <linux-wireless+bounces-852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8288157F0
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 07:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C99B23A7E
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 06:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B748215E98;
	Sat, 16 Dec 2023 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mKNQE3EM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B914A91
	for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG5is4o026656;
	Sat, 16 Dec 2023 06:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=HhFgjoMP6fq6L+iwBHuYXH3q0X7JBpfz97qKMUIowmo=; b=mK
	NQE3EMVueesEhaQ9jGmPDt3g32CzQ1MaPXfE4gP3+I43ndSUYTBdeJ9YZETIiUSJ
	WJJ4PC6Ba8N7nSK8LIhWiNk7zAREEFUExmHa5J2Tvb0IMt5TfEuoWVAouiBOa/3r
	6N7h19ERVxfHfPw7m+aF2qI26H1C9NDdlZ/20IvfvL3EGhltXRSTMHx60GDybVsi
	BBMX+MlwSaX+8/8U0QszBfJ88H2W7nS0yZWLMzLbM40LsjHAv0S0qrO2uJoAdLSk
	mI1oFzDOLs3+HuYoe2GdlOIsncbkuPe7Y6aLwc2nyrPtTikDqA7iEBT95CbpMK7a
	yPvBICMG1zHN2oIZKQcw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v156dg2v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 06:02:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG62Ch8007067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 06:02:12 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 22:02:10 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: ath12k: add string type to search board data in board-2.bin for WCN7850
Date: Sat, 16 Dec 2023 14:01:36 +0800
Message-ID: <20231216060140.30611-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231216060140.30611-1-quic_bqiang@quicinc.com>
References: <20231216060140.30611-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RMq7RtKfKA8z0AA4Ow5Cfa5mIod8NJ8i
X-Proofpoint-GUID: RMq7RtKfKA8z0AA4Ow5Cfa5mIod8NJ8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160043

From: Wen Gong <quic_wgong@quicinc.com>

Currently ath12k only supports string type with bus, chip id and board id
such as "bus=ahb,qmi-chip-id=1,qmi-board-id=4" for AHB bus chip and
"bus=pci,qmi-chip-id=0,qmi-board-id=255" for PCI bus chip in board-2.bin.
For WCN7850, it is not enough to distinguish all different chips.

Add a new string type which includes bus, chip id, board id, vendor,
device, subsystem-vendor and subsystem-device for WCN7850.

ath12k will first load board-2.bin and searches in it for the board data
with the above parameters. If matched with one board data, ath12k downloads
it to firmware. And if not, downloads board.bin instead.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 27 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/core.h | 13 +++++++++++++
 drivers/net/wireless/ath/ath12k/pci.c  | 10 ++++++++++
 3 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 6c01b282fcd3..b8027f76a02e 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -114,11 +114,26 @@ static int ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 		scnprintf(variant, sizeof(variant), ",variant=%s",
 			  ab->qmi.target.bdf_ext);
 
-	scnprintf(name, name_len,
-		  "bus=%s,qmi-chip-id=%d,qmi-board-id=%d%s",
-		  ath12k_bus_str(ab->hif.bus),
-		  ab->qmi.target.chip_id,
-		  ab->qmi.target.board_id, variant);
+	switch (ab->id.bdf_search) {
+	case ATH12K_BDF_SEARCH_BUS_AND_BOARD:
+		scnprintf(name, name_len,
+			  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",
+			  ath12k_bus_str(ab->hif.bus),
+			  ab->id.vendor, ab->id.device,
+			  ab->id.subsystem_vendor,
+			  ab->id.subsystem_device,
+			  ab->qmi.target.chip_id,
+			  ab->qmi.target.board_id,
+			  variant);
+		break;
+	default:
+		scnprintf(name, name_len,
+			  "bus=%s,qmi-chip-id=%d,qmi-board-id=%d%s",
+			  ath12k_bus_str(ab->hif.bus),
+			  ab->qmi.target.chip_id,
+			  ab->qmi.target.board_id, variant);
+		break;
+	}
 
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot using board name '%s'\n", name);
 
@@ -356,7 +371,7 @@ int ath12k_core_fetch_board_data_api_1(struct ath12k_base *ab,
 	return 0;
 }
 
-#define BOARD_NAME_SIZE 100
+#define BOARD_NAME_SIZE 200
 int ath12k_core_fetch_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 {
 	char boardname[BOARD_NAME_SIZE];
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 8458dc292821..385fda03e913 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -55,6 +55,11 @@
 #define ATH12K_RECONFIGURE_TIMEOUT_HZ		(10 * HZ)
 #define ATH12K_RECOVER_START_TIMEOUT_HZ		(20 * HZ)
 
+enum ath12k_bdf_search {
+	ATH12K_BDF_SEARCH_DEFAULT,
+	ATH12K_BDF_SEARCH_BUS_AND_BOARD,
+};
+
 enum wme_ac {
 	WME_AC_BE,
 	WME_AC_BK,
@@ -793,6 +798,14 @@ struct ath12k_base {
 	/* true means radio is on */
 	bool rfkill_radio_on;
 
+	struct {
+		enum ath12k_bdf_search bdf_search;
+		u32 vendor;
+		u32 device;
+		u32 subsystem_vendor;
+		u32 subsystem_device;
+	} id;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index b11563754d16..5598dc530bd4 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1310,6 +1310,15 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		goto err_free_core;
 	}
 
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "pci probe %04x:%04x %04x:%04x\n",
+		   pdev->vendor, pdev->device,
+		   pdev->subsystem_vendor, pdev->subsystem_device);
+
+	ab->id.vendor = pdev->vendor;
+	ab->id.device = pdev->device;
+	ab->id.subsystem_vendor = pdev->subsystem_vendor;
+	ab->id.subsystem_device = pdev->subsystem_device;
+
 	switch (pci_dev->device) {
 	case QCN9274_DEVICE_ID:
 		ab_pci->msi_config = &ath12k_msi_config[0];
@@ -1333,6 +1342,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		}
 		break;
 	case WCN7850_DEVICE_ID:
+		ab->id.bdf_search = ATH12K_BDF_SEARCH_BUS_AND_BOARD;
 		ab_pci->msi_config = &ath12k_msi_config[0];
 		ab->static_window_map = false;
 		ab_pci->pci_ops = &ath12k_pci_ops_wcn7850;
-- 
2.25.1


