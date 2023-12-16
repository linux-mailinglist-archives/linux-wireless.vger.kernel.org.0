Return-Path: <linux-wireless+bounces-853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555658157F1
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 07:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0ED51F2384C
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 06:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE7317982;
	Sat, 16 Dec 2023 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OpbHsgZM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF815487
	for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG5lilZ013972;
	Sat, 16 Dec 2023 06:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tzNH8qDsZphDTuj9bpNQLGQ3WMYKjPaDePbEm6R12Kg=; b=Op
	bHsgZMNKOTk5MtVcz65SjS9ptN6yn/7OnT0HxyeyHueTnKPMRE+cSP/BBPFdkb5/
	59UdVyu7IUjCsabDE7K3ObZfQ8t5tKdeEZiYPMbU2pghgmj1idTZPd+FZhdsUYrV
	WlVNpuH0E83BlynppDCRxAfnwAFwnB3mlOzmImP+ZnhNraJZoaaJYYAoe/bpaO59
	h9XqiSc2LSBHQfCWDNiQMouuqlY+7Mo9W+eQGwF37qDUEVTYK+ujZgbL5B7YBPGJ
	stLyCSL+eHoHQNWBl2sNcyaUsDauis2R+LmDiRxc3PDH/kJ0NLLGyDv/9bLZXfo3
	l2DbtqsYwQfD+O2wlSYg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14vj83sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 06:02:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG62Fj6007491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 06:02:16 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 22:02:14 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: ath12k: add support to search regdb data in board-2.bin for WCN7850
Date: Sat, 16 Dec 2023 14:01:39 +0800
Message-ID: <20231216060140.30611-5-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: RRkNFCyJ_9PEghlf5YM8efOMBWmec8Nu
X-Proofpoint-GUID: RRkNFCyJ_9PEghlf5YM8efOMBWmec8Nu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160043

From: Wen Gong <quic_wgong@quicinc.com>

Currently ath12k only downloads the same regdb.bin file for all WCN7850
chips, actually ath12k needs to distinguish all different WCN7850 chips.

This is to re-use the string type which includes bus, chip id, board id,
vendor, device, subsystem-vendor, subsystem-device and variant for
WCN7850 to distinguish different regdb in board-2.bin.

ath12k will first load board-2.bin and search in it for the regdb data
with the above parameters. If matched with one regdb data, download it
to firmware. And if not, download regdb.bin instead.

Add enum value ATH12K_BD_IE_REGDB and enum type ath12k_bd_ie_regdb_type
to distinguish regdb data and board data since they are in the same file
board-2.bin.

Test log:
[ 3833.091948] ath12k_pci 0000:05:00.0: boot using board name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
[ 3833.092072] ath12k_pci 0000:05:00.0: boot firmware request ath12k/WCN7850/hw2.0/board-2.bin size 205316
[ 3833.092079] ath12k_pci 0000:05:00.0: board name
[ 3833.092083] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[ 3833.092088] ath12k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 31                                   -id=1
[ 3833.092091] ath12k_pci 0000:05:00.0: board name
[ 3833.092095] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[ 3833.092099] ath12k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 32                                   -id=2
[ 3833.092102] ath12k_pci 0000:05:00.0: board name
[ 3833.092105] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[ 3833.092109] ath12k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 33                                   -id=3
[ 3833.092112] ath12k_pci 0000:05:00.0: board name
[ 3833.092116] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[ 3833.092119] ath12k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[ 3833.092123] ath12k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[ 3833.092126] ath12k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[ 3833.092130] ath12k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[ 3833.092133] ath12k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
[ 3833.092137] ath12k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 36 2c 76 61 72 69 61  ard-id=266,varia
[ 3833.092140] ath12k_pci 0000:05:00.0: 00000070: 6e 74 3d 48 50 5f 47 38 5f 4c 61 6e 63 69 61 31  nt=HP_G8_Lancia1
[ 3833.092144] ath12k_pci 0000:05:00.0: 00000080: 35                                               5
[ 3833.092147] ath12k_pci 0000:05:00.0: board name
[ 3833.092150] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[ 3833.092154] ath12k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[ 3833.092157] ath12k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[ 3833.092161] ath12k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[ 3833.092165] ath12k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[ 3833.092168] ath12k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
[ 3833.092172] ath12k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 36                    ard-id=266
[ 3833.092206] ath12k_pci 0000:05:00.0: board name
[ 3833.092209] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[ 3833.092213] ath12k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[ 3833.092216] ath12k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[ 3833.092220] ath12k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[ 3833.092223] ath12k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[ 3833.092227] ath12k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
[ 3833.092230] ath12k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 32                    ard-id=262
[ 3833.092234] ath12k_pci 0000:05:00.0: boot found match regdb data for name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
[ 3833.092238] ath12k_pci 0000:05:00.0: board name
[ 3833.092241] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[ 3833.092245] ath12k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 31 31                                -id=11
[ 3833.092248] ath12k_pci 0000:05:00.0: board name
[ 3833.092251] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[ 3833.092255] ath12k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 32 32                                -id=22
[ 3833.092258] ath12k_pci 0000:05:00.0: board name
[ 3833.092261] ath12k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[ 3833.092265] ath12k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 33 33                                -id=33
[ 3833.092268] ath12k_pci 0000:05:00.0: boot found regdb data for 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
[ 3833.092272] ath12k_pci 0000:05:00.0: fetched regdb

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 96 +++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/hw.h   | 19 +++++
 drivers/net/wireless/ath/ath12k/qmi.c  |  3 +-
 4 files changed, 92 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 672aa174704b..80fce8099bdf 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -186,7 +186,9 @@ static int ath12k_core_parse_bd_ie_board(struct ath12k_base *ab,
 					 struct ath12k_board_data *bd,
 					 const void *buf, size_t buf_len,
 					 const char *boardname,
-					 int bd_ie_type)
+					 int ie_id,
+					 int name_id,
+					 int data_id)
 {
 	const struct ath12k_fw_ie *hdr;
 	bool name_match_found;
@@ -196,7 +198,7 @@ static int ath12k_core_parse_bd_ie_board(struct ath12k_base *ab,
 
 	name_match_found = false;
 
-	/* go through ATH12K_BD_IE_BOARD_ elements */
+	/* go through ATH12K_BD_IE_BOARD_/ATH12K_BD_IE_REGDB_ elements */
 	while (buf_len > sizeof(struct ath12k_fw_ie)) {
 		hdr = buf;
 		board_ie_id = le32_to_cpu(hdr->id);
@@ -207,48 +209,50 @@ static int ath12k_core_parse_bd_ie_board(struct ath12k_base *ab,
 		buf += sizeof(*hdr);
 
 		if (buf_len < ALIGN(board_ie_len, 4)) {
-			ath12k_err(ab, "invalid ATH12K_BD_IE_BOARD length: %zu < %zu\n",
+			ath12k_err(ab, "invalid %s length: %zu < %zu\n",
+				   ath12k_bd_ie_type_str(ie_id),
 				   buf_len, ALIGN(board_ie_len, 4));
 			ret = -EINVAL;
 			goto out;
 		}
 
-		switch (board_ie_id) {
-		case ATH12K_BD_IE_BOARD_NAME:
+		if (board_ie_id == name_id) {
 			ath12k_dbg_dump(ab, ATH12K_DBG_BOOT, "board name", "",
 					board_ie_data, board_ie_len);
 
 			if (board_ie_len != strlen(boardname))
-				break;
+				goto next;
 
 			ret = memcmp(board_ie_data, boardname, strlen(boardname));
 			if (ret)
-				break;
+				goto next;
 
 			name_match_found = true;
 			ath12k_dbg(ab, ATH12K_DBG_BOOT,
-				   "boot found match for name '%s'",
+				   "boot found match %s for name '%s'",
+				   ath12k_bd_ie_type_str(ie_id),
 				   boardname);
-			break;
-		case ATH12K_BD_IE_BOARD_DATA:
+		} else if (board_ie_id == data_id) {
 			if (!name_match_found)
 				/* no match found */
-				break;
+				goto next;
 
 			ath12k_dbg(ab, ATH12K_DBG_BOOT,
-				   "boot found board data for '%s'", boardname);
+				   "boot found %s for '%s'",
+				   ath12k_bd_ie_type_str(ie_id),
+				   boardname);
 
 			bd->data = board_ie_data;
 			bd->len = board_ie_len;
 
 			ret = 0;
 			goto out;
-		default:
-			ath12k_warn(ab, "unknown ATH12K_BD_IE_BOARD found: %d\n",
+		} else {
+			ath12k_warn(ab, "unknown %s id found: %d\n",
+				    ath12k_bd_ie_type_str(ie_id),
 				    board_ie_id);
-			break;
 		}
-
+next:
 		/* jump over the padding */
 		board_ie_len = ALIGN(board_ie_len, 4);
 
@@ -265,7 +269,10 @@ static int ath12k_core_parse_bd_ie_board(struct ath12k_base *ab,
 
 static int ath12k_core_fetch_board_data_api_n(struct ath12k_base *ab,
 					      struct ath12k_board_data *bd,
-					      const char *boardname)
+					      const char *boardname,
+					      int ie_id_match,
+					      int name_id,
+					      int data_id)
 {
 	size_t len, magic_len;
 	const u8 *data;
@@ -330,22 +337,23 @@ static int ath12k_core_fetch_board_data_api_n(struct ath12k_base *ab,
 			goto err;
 		}
 
-		switch (ie_id) {
-		case ATH12K_BD_IE_BOARD:
+		if (ie_id == ie_id_match) {
 			ret = ath12k_core_parse_bd_ie_board(ab, bd, data,
 							    ie_len,
 							    boardname,
-							    ATH12K_BD_IE_BOARD);
+							    ie_id_match,
+							    name_id,
+							    data_id);
 			if (ret == -ENOENT)
 				/* no match found, continue */
-				break;
+				goto next;
 			else if (ret)
 				/* there was an error, bail out */
 				goto err;
 			/* either found or error, so stop searching */
 			goto out;
 		}
-
+next:
 		/* jump over the padding */
 		ie_len = ALIGN(ie_len, 4);
 
@@ -356,7 +364,8 @@ static int ath12k_core_fetch_board_data_api_n(struct ath12k_base *ab,
 out:
 	if (!bd->data || !bd->len) {
 		ath12k_dbg(ab, ATH12K_DBG_BOOT,
-			   "failed to fetch board data for %s from %s\n",
+			   "failed to fetch %s for %s from %s\n",
+			   ath12k_bd_ie_type_str(ie_id_match),
 			   boardname, filepath);
 		ret = -ENODATA;
 		goto err;
@@ -400,7 +409,10 @@ int ath12k_core_fetch_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 	}
 
 	bd_api = 2;
-	ret = ath12k_core_fetch_board_data_api_n(ab, bd, boardname);
+	ret = ath12k_core_fetch_board_data_api_n(ab, bd, boardname,
+						 ATH12K_BD_IE_BOARD,
+						 ATH12K_BD_IE_BOARD_NAME,
+						 ATH12K_BD_IE_BOARD_DATA);
 	if (!ret)
 		goto success;
 
@@ -411,7 +423,10 @@ int ath12k_core_fetch_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 		return ret;
 	}
 
-	ret = ath12k_core_fetch_board_data_api_n(ab, bd, fallback_boardname);
+	ret = ath12k_core_fetch_board_data_api_n(ab, bd, fallback_boardname,
+						 ATH12K_BD_IE_BOARD,
+						 ATH12K_BD_IE_BOARD_NAME,
+						 ATH12K_BD_IE_BOARD_DATA);
 	if (!ret)
 		goto success;
 
@@ -436,6 +451,37 @@ int ath12k_core_fetch_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 	return 0;
 }
 
+int ath12k_core_fetch_regdb(struct ath12k_base *ab, struct ath12k_board_data *bd)
+{
+	char boardname[BOARD_NAME_SIZE];
+	int ret;
+
+	ret = ath12k_core_create_board_name(ab, boardname, BOARD_NAME_SIZE);
+	if (ret) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT,
+			   "failed to create board name for regdb: %d", ret);
+		goto exit;
+	}
+
+	ret = ath12k_core_fetch_board_data_api_n(ab, bd, boardname,
+						 ATH12K_BD_IE_REGDB,
+						 ATH12K_BD_IE_REGDB_NAME,
+						 ATH12K_BD_IE_REGDB_DATA);
+	if (!ret)
+		goto exit;
+
+	ret = ath12k_core_fetch_board_data_api_1(ab, bd, ATH12K_REGDB_FILE_NAME);
+	if (ret)
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "failed to fetch %s from %s\n",
+			   ATH12K_REGDB_FILE_NAME, ab->hw_params->fw.dir);
+
+exit:
+	if (!ret)
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "fetched regdb\n");
+
+	return ret;
+}
+
 static void ath12k_core_stop(struct ath12k_base *ab)
 {
 	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 385fda03e913..ba0a30f1ea29 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -823,6 +823,7 @@ int ath12k_core_fetch_board_data_api_1(struct ath12k_base *ab,
 int ath12k_core_fetch_bdf(struct ath12k_base *ath12k,
 			  struct ath12k_board_data *bd);
 void ath12k_core_free_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd);
+int ath12k_core_fetch_regdb(struct ath12k_base *ab, struct ath12k_board_data *bd);
 int ath12k_core_check_dt(struct ath12k_base *ath12k);
 int ath12k_core_check_smbios(struct ath12k_base *ab);
 void ath12k_core_halt(struct ath12k *ar);
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 130d99f7e426..fa8230def22b 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -242,9 +242,16 @@ enum ath12k_bd_ie_board_type {
 	ATH12K_BD_IE_BOARD_DATA = 1,
 };
 
+enum ath12k_bd_ie_regdb_type {
+	ATH12K_BD_IE_REGDB_NAME = 0,
+	ATH12K_BD_IE_REGDB_DATA = 1,
+};
+
 enum ath12k_bd_ie_type {
 	/* contains sub IEs of enum ath12k_bd_ie_board_type */
 	ATH12K_BD_IE_BOARD = 0,
+	/* contains sub IEs of enum ath12k_bd_ie_regdb_type */
+	ATH12K_BD_IE_REGDB = 1,
 };
 
 struct ath12k_hw_regs {
@@ -314,6 +321,18 @@ struct ath12k_hw_regs {
 	u32 hal_reo_status_ring_base;
 };
 
+static inline const char *ath12k_bd_ie_type_str(enum ath12k_bd_ie_type type)
+{
+	switch (type) {
+	case ATH12K_BD_IE_BOARD:
+		return "board data";
+	case ATH12K_BD_IE_REGDB:
+		return "regdb data";
+	}
+
+	return "unknown";
+}
+
 int ath12k_hw_init(struct ath12k_base *ab);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 77a132f6bbd1..f29291064e20 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2423,8 +2423,7 @@ static int ath12k_qmi_load_bdf_qmi(struct ath12k_base *ab,
 
 		break;
 	case ATH12K_QMI_BDF_TYPE_REGDB:
-		ret = ath12k_core_fetch_board_data_api_1(ab, &bd,
-							 ATH12K_REGDB_FILE_NAME);
+		ret = ath12k_core_fetch_regdb(ab, &bd);
 		if (ret) {
 			ath12k_warn(ab, "qmi failed to load regdb bin:\n");
 			goto out;
-- 
2.25.1


