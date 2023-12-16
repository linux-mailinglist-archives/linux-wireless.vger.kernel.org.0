Return-Path: <linux-wireless+bounces-854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B438157F2
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 07:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E191C24B22
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 06:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC6A1798D;
	Sat, 16 Dec 2023 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D4R0NJa8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886C15AC0
	for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG5lQiF002505;
	Sat, 16 Dec 2023 06:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ccnYDzYCh/CkO1D7uGW3fKax017MNZlWbhfQtq3XnfY=; b=D4
	R0NJa8+3VTs10cqhXvs5pWX9lrk1D0UE1+rHkKQmXMVdleFc2xH6ZjmrLZ7OBKJw
	cAvSb1BNxQShvOikDB77lkOmWvfkx6jLTmkpG0l/33hlYAxgMhnqJD2yM67nSJ09
	NouZn78wiScDCsf3SGSuZnpPOfH1F+YRSUctNR86zA1WBn4OGdhvpuCLMLaR28Wm
	093dyjELNwFcOXzQfKmIkTBbEafYC9LR0MAEYFA5EVG0uKXdW/fXLX6QJrcxfNaD
	wuzQstxE0VNztprm8TEGC5Pqkv8pPltHiyTqJ+8LVa794yTUEumsEjcfTKPOyvUE
	E2xmGu/Ksy75eQqerfpw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v151jg3ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 06:02:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG62H32005539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 06:02:17 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 22:02:16 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: ath12k: support default regdb while searching board-2.bin for WCN7850
Date: Sat, 16 Dec 2023 14:01:40 +0800
Message-ID: <20231216060140.30611-6-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 3ee4Qrq9GzQZf2PLutlesFnRGQIiKIRn
X-Proofpoint-GUID: 3ee4Qrq9GzQZf2PLutlesFnRGQIiKIRn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312160043

Sometimes board-2.bin does not have the regdb data which matches the
parameters such as vendor, device, subsystem-vendor, subsystem-device
etc. Add default regdb data with only 'bus=%s' into board-2.bin for
WCN7850, then ath12k uses 'bus=pci' to search regdb data in board-2.bin
for WCN7850.

[   46.114895] ath12k_pci 0000:03:00.0: boot using board name 'bus=pci,vendor=17cb,device=1107,subsystem-vendor=17cb,subsystem-device=3378,qmi-chip-id=2,qmi-board-id=260'
[   46.118167] ath12k_pci 0000:03:00.0: boot firmware request ath12k/WCN7850/hw2.0/board-2.bin size 380280
[   46.118173] ath12k_pci 0000:03:00.0: board name
[   46.118176] ath12k_pci 0000:03:00.0: 00000000: 62 75 73 3d 70 63 69                             bus=pci
[   46.118179] ath12k_pci 0000:03:00.0: failed to fetch regdb data for bus=pci,vendor=17cb,device=1107,subsystem-vendor=17cb,subsystem-device=3378,qmi-chip-id=2,qmi-board-id=260 from ath12k/WCN7850/hw2.0/board-2.bin
[   46.118239] ath12k_pci 0000:03:00.0: boot using board name 'bus=pci'
[   46.119842] ath12k_pci 0000:03:00.0: boot firmware request ath12k/WCN7850/hw2.0/board-2.bin size 380280
[   46.119847] ath12k_pci 0000:03:00.0: board name
[   46.119849] ath12k_pci 0000:03:00.0: 00000000: 62 75 73 3d 70 63 69                             bus=pci
[   46.119852] ath12k_pci 0000:03:00.0: boot found match regdb data for name 'bus=pci'
[   46.119855] ath12k_pci 0000:03:00.0: boot found regdb data for 'bus=pci'
[   46.119857] ath12k_pci 0000:03:00.0: fetched regdb

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 53 +++++++++++++++++++-------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 80fce8099bdf..d73e2d33a41e 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -105,7 +105,8 @@ int ath12k_core_resume(struct ath12k_base *ab)
 }
 
 static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
-					   size_t name_len, bool with_variant)
+					   size_t name_len, bool with_variant,
+					   bool bus_type_mode)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
 	char variant[9 + ATH12K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
@@ -116,15 +117,20 @@ static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 
 	switch (ab->id.bdf_search) {
 	case ATH12K_BDF_SEARCH_BUS_AND_BOARD:
-		scnprintf(name, name_len,
-			  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",
-			  ath12k_bus_str(ab->hif.bus),
-			  ab->id.vendor, ab->id.device,
-			  ab->id.subsystem_vendor,
-			  ab->id.subsystem_device,
-			  ab->qmi.target.chip_id,
-			  ab->qmi.target.board_id,
-			  variant);
+		if (bus_type_mode)
+			scnprintf(name, name_len,
+				  "bus=%s",
+				  ath12k_bus_str(ab->hif.bus));
+		else
+			scnprintf(name, name_len,
+				  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",
+				  ath12k_bus_str(ab->hif.bus),
+				  ab->id.vendor, ab->id.device,
+				  ab->id.subsystem_vendor,
+				  ab->id.subsystem_device,
+				  ab->qmi.target.chip_id,
+				  ab->qmi.target.board_id,
+				  variant);
 		break;
 	default:
 		scnprintf(name, name_len,
@@ -143,13 +149,19 @@ static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 static int ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 					 size_t name_len)
 {
-	return __ath12k_core_create_board_name(ab, name, name_len, true);
+	return __ath12k_core_create_board_name(ab, name, name_len, true, false);
 }
 
 static int ath12k_core_create_fallback_board_name(struct ath12k_base *ab, char *name,
 						  size_t name_len)
 {
-	return __ath12k_core_create_board_name(ab, name, name_len, false);
+	return __ath12k_core_create_board_name(ab, name, name_len, false, false);
+}
+
+static int ath12k_core_create_bus_type_board_name(struct ath12k_base *ab, char *name,
+						  size_t name_len)
+{
+	return __ath12k_core_create_board_name(ab, name, name_len, false, true);
 }
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
@@ -453,7 +465,7 @@ int ath12k_core_fetch_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 
 int ath12k_core_fetch_regdb(struct ath12k_base *ab, struct ath12k_board_data *bd)
 {
-	char boardname[BOARD_NAME_SIZE];
+	char boardname[BOARD_NAME_SIZE], default_boardname[BOARD_NAME_SIZE];
 	int ret;
 
 	ret = ath12k_core_create_board_name(ab, boardname, BOARD_NAME_SIZE);
@@ -470,6 +482,21 @@ int ath12k_core_fetch_regdb(struct ath12k_base *ab, struct ath12k_board_data *bd
 	if (!ret)
 		goto exit;
 
+	ret = ath12k_core_create_bus_type_board_name(ab, default_boardname,
+						     BOARD_NAME_SIZE);
+	if (ret) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT,
+			   "failed to create default board name for regdb: %d", ret);
+		goto exit;
+	}
+
+	ret = ath12k_core_fetch_board_data_api_n(ab, bd, default_boardname,
+						 ATH12K_BD_IE_REGDB,
+						 ATH12K_BD_IE_REGDB_NAME,
+						 ATH12K_BD_IE_REGDB_DATA);
+	if (!ret)
+		goto exit;
+
 	ret = ath12k_core_fetch_board_data_api_1(ab, bd, ATH12K_REGDB_FILE_NAME);
 	if (ret)
 		ath12k_dbg(ab, ATH12K_DBG_BOOT, "failed to fetch %s from %s\n",
-- 
2.25.1


