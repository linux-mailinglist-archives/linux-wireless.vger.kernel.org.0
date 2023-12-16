Return-Path: <linux-wireless+bounces-850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4768157EE
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 07:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818E51C24B0D
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 06:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E853515494;
	Sat, 16 Dec 2023 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lg2BYu+B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4687C14A88
	for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG5snBS016412;
	Sat, 16 Dec 2023 06:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=qlN6m0XHRilpv72UBXuQ50MTWfjCyHIjZGntWcW6aWM=; b=Lg
	2BYu+Bf7jJCbptuuJhw6pd6VTXePCn2YGx31kSUEfdMVdDe1a/OxpYynSe8frHCz
	JPYVfem7bfYC8mv8sCIv6QkwhlMkO8TE/oZp+ESOYPgd9JvOLaqFKLzrdm+9CRG0
	0vOXU6gooOBYAfb0vtkr7ImtUU/OCJ1a+E69nZepd5sf5ca29FiwgSaLZVr7ozn6
	BFVdtvhvG4wErIBeHuLOH+SQEo159GU8rdpGtRP4hOmBbfpbFrl/f5gltyjA6Upl
	TrGkPu6oqtDVKPfmJBHcJOa9DJIbEyJVpyRyY26hufUnHelJABAjVsoqQHWslc+c
	Wi/QCHqtmIx63yp5UoSw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v151jg3ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 06:02:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG62DBq007476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 06:02:13 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 22:02:12 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] wifi: ath12k: add fallback board name without variant while searching board-2.bin
Date: Sat, 16 Dec 2023 14:01:37 +0800
Message-ID: <20231216060140.30611-3-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: dw30nF3pMBjPY85GsYZ3UY3cfBiEw8BE
X-Proofpoint-GUID: dw30nF3pMBjPY85GsYZ3UY3cfBiEw8BE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312160043

From: Wen Gong <quic_wgong@quicinc.com>

Currently a variant value read from DT or SMBIOS is considered while
searching board-2.bin, this may fail because not all board-2.bin files
contains that symbol.

Add fallback board name which removes variant value and searches again
in board-2.bin when fails to increase boot up success rate.

dmesg log after this patch:
[169547.248472] ath12k_pci 0000:05:00.0: boot using board name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262,variant=test'
[169547.248565] ath12k_pci 0000:05:00.0: boot firmware request ath12k/WCN7850/hw2.0/board-2.bin size 180324
[169547.248568] ath12k_pci 0000:05:00.0: board name
[169547.248570] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[169547.248571] ath12k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[169547.248572] ath12k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[169547.248574] ath12k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[169547.248575] ath12k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[169547.248576] ath12k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
[169547.248577] ath12k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 32                    ard-id=262
[169547.248578] ath12k_pci 0000:05:00.0: board name
[169547.248579] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[169547.248581] ath12k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[169547.248582] ath12k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[169547.248583] ath12k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[169547.248584] ath12k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[169547.248585] ath12k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
[169547.248587] ath12k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 36                    ard-id=266
[169547.248588] ath12k_pci 0000:05:00.0: board name
[169547.248589] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[169547.248590] ath12k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[169547.248591] ath12k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[169547.248592] ath12k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[169547.248594] ath12k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[169547.248595] ath12k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 31 38 2c 71 6d 69 2d 62  chip-id=18,qmi-b
[169547.248596] ath12k_pci 0000:05:00.0: 00000060: 6f 61 72 64 2d 69 64 3d 32 36 36                 oard-id=266
[169547.248597] ath12k_pci 0000:05:00.0: failed to fetch board data for bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262,variant=test from ath12k/WCN7850/hw2.0/board-2.bin
[169547.248476] ath12k_pci 0000:05:00.0: boot using board name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
[169547.248634] ath12k_pci 0000:05:00.0: boot firmware request ath12k/WCN7850/hw2.0/board-2.bin size 180324
[169547.248636] ath12k_pci 0000:05:00.0: board name
[169547.248637] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[169547.248638] ath12k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[169547.248639] ath12k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[169547.248641] ath12k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[169547.248642] ath12k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[169547.248643] ath12k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
[169547.248645] ath12k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 32                    ard-id=262
[169547.248646] ath12k_pci 0000:05:00.0: boot found match for name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
[169547.248647] ath12k_pci 0000:05:00.0: boot found board data for 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
[169547.248649] ath12k_pci 0000:05:00.0: using board api 2

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 48 ++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index b8027f76a02e..672aa174704b 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -104,13 +104,13 @@ int ath12k_core_resume(struct ath12k_base *ab)
 	return 0;
 }
 
-static int ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
-					 size_t name_len)
+static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
+					   size_t name_len, bool with_variant)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
 	char variant[9 + ATH12K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
 
-	if (ab->qmi.target.bdf_ext[0] != '\0')
+	if (with_variant && ab->qmi.target.bdf_ext[0] != '\0')
 		scnprintf(variant, sizeof(variant), ",variant=%s",
 			  ab->qmi.target.bdf_ext);
 
@@ -140,6 +140,18 @@ static int ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 	return 0;
 }
 
+static int ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
+					 size_t name_len)
+{
+	return __ath12k_core_create_board_name(ab, name, name_len, true);
+}
+
+static int ath12k_core_create_fallback_board_name(struct ath12k_base *ab, char *name,
+						  size_t name_len)
+{
+	return __ath12k_core_create_board_name(ab, name, name_len, false);
+}
+
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
 						    const char *file)
 {
@@ -343,7 +355,7 @@ static int ath12k_core_fetch_board_data_api_n(struct ath12k_base *ab,
 
 out:
 	if (!bd->data || !bd->len) {
-		ath12k_err(ab,
+		ath12k_dbg(ab, ATH12K_DBG_BOOT,
 			   "failed to fetch board data for %s from %s\n",
 			   boardname, filepath);
 		ret = -ENODATA;
@@ -374,11 +386,14 @@ int ath12k_core_fetch_board_data_api_1(struct ath12k_base *ab,
 #define BOARD_NAME_SIZE 200
 int ath12k_core_fetch_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 {
-	char boardname[BOARD_NAME_SIZE];
+	char boardname[BOARD_NAME_SIZE], fallback_boardname[BOARD_NAME_SIZE];
+	char *filename, filepath[100];
 	int bd_api;
 	int ret;
 
-	ret = ath12k_core_create_board_name(ab, boardname, BOARD_NAME_SIZE);
+	filename = ATH12K_BOARD_API2_FILE;
+
+	ret = ath12k_core_create_board_name(ab, boardname, sizeof(boardname));
 	if (ret) {
 		ath12k_err(ab, "failed to create board name: %d", ret);
 		return ret;
@@ -389,10 +404,29 @@ int ath12k_core_fetch_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 	if (!ret)
 		goto success;
 
+	ret = ath12k_core_create_fallback_board_name(ab, fallback_boardname,
+						     sizeof(fallback_boardname));
+	if (ret) {
+		ath12k_err(ab, "failed to create fallback board name: %d", ret);
+		return ret;
+	}
+
+	ret = ath12k_core_fetch_board_data_api_n(ab, bd, fallback_boardname);
+	if (!ret)
+		goto success;
+
 	bd_api = 1;
 	ret = ath12k_core_fetch_board_data_api_1(ab, bd, ATH12K_DEFAULT_BOARD_FILE);
 	if (ret) {
-		ath12k_err(ab, "failed to fetch board-2.bin or board.bin from %s\n",
+		ath12k_core_create_firmware_path(ab, filename,
+						 filepath, sizeof(filepath));
+		ath12k_err(ab, "failed to fetch board data for %s from %s\n",
+			   boardname, filepath);
+		if (memcmp(boardname, fallback_boardname, strlen(boardname)))
+			ath12k_err(ab, "failed to fetch board data for %s from %s\n",
+				   fallback_boardname, filepath);
+
+		ath12k_err(ab, "failed to fetch board.bin from %s\n",
 			   ab->hw_params->fw.dir);
 		return ret;
 	}
-- 
2.25.1


