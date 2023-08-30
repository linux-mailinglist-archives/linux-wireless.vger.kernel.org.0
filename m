Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F76078D31D
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 08:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbjH3GDW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 02:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbjH3GCt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 02:02:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3FC1B3
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 23:02:47 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U3drJW004425;
        Wed, 30 Aug 2023 06:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Ml8t3nnQHRYeqMVuulwzLoBmhRYccTq3nJKwsZ7gD0k=;
 b=l9EJmK3y2g3F0wncM2soOCqi+ozHyMY1BGVWWSxPdVR6JUPn2iflBenOv3u4zajqvzSh
 nKx8IO+UI7dOzZOnIBUFA3M+VLIdnjnFKfuzJmHdfDgM/6sBzwsQ7LITpVidnVaZolgi
 BgHcoae5eTbXy6WBrImMP/AIy48cfm5jC8qUIvvP4j4/dbRCWE6BjiuHzxbTdD8rdYhZ
 JvFsSIAt+nVIf6aavxH+qHKzOuwVvs/nQvskyQD+eTSZTRZiAjtO41oWThBsWWySU8X4
 Q3BQiVolhyufBoFl67FlHdUKRoxpTSle0M3YHPsItGUtLc9CmwBn1FvpEndTWRpk+GgQ xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssv008err-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:02:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U62hMw026595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:02:43 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 23:02:42 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath11k: add chip id board name while searching board-2.bin for WCN6855
Date:   Wed, 30 Aug 2023 02:02:26 -0400
Message-ID: <20230830060226.18664-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dhS0xzqy3n8oX39AIVPUEvEfXsXY8cZu
X-Proofpoint-GUID: dhS0xzqy3n8oX39AIVPUEvEfXsXY8cZu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sometimes board-2.bin does not have the board data which matched the
parameters such as bus type, vendor, device, subsystem-vendor,
subsystem-device, qmi-chip-id and qmi-board-id, then wlan will load fail.

Hence add another type which only matches the bus type and qmi-chip-id,
then the ratio of missing board data reduced.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 108 ++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index fc7c4564a715..c3a0dd15d8ea 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -985,9 +985,15 @@ int ath11k_core_check_dt(struct ath11k_base *ab)
 	return 0;
 }
 
+enum ath11k_bdf_name_type {
+	ATH11K_BDF_NAME_FULL,
+	ATH11K_BDF_NAME_BUS_NAME,
+	ATH11K_BDF_NAME_CHIP_ID,
+};
+
 static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 					   size_t name_len, bool with_variant,
-					   bool bus_type_mode)
+					   enum ath11k_bdf_name_type name_type)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
 	char variant[9 + ATH11K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
@@ -998,11 +1004,8 @@ static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 
 	switch (ab->id.bdf_search) {
 	case ATH11K_BDF_SEARCH_BUS_AND_BOARD:
-		if (bus_type_mode)
-			scnprintf(name, name_len,
-				  "bus=%s",
-				  ath11k_bus_str(ab->hif.bus));
-		else
+		switch (name_type) {
+		case ATH11K_BDF_NAME_FULL:
 			scnprintf(name, name_len,
 				  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",
 				  ath11k_bus_str(ab->hif.bus),
@@ -1012,6 +1015,19 @@ static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 				  ab->qmi.target.chip_id,
 				  ab->qmi.target.board_id,
 				  variant);
+			break;
+		case ATH11K_BDF_NAME_BUS_NAME:
+			scnprintf(name, name_len,
+				  "bus=%s",
+				  ath11k_bus_str(ab->hif.bus));
+			break;
+		case ATH11K_BDF_NAME_CHIP_ID:
+			scnprintf(name, name_len,
+				  "bus=%s,qmi-chip-id=%d",
+				  ath11k_bus_str(ab->hif.bus),
+				  ab->qmi.target.chip_id);
+			break;
+		}
 		break;
 	default:
 		scnprintf(name, name_len,
@@ -1030,19 +1046,29 @@ static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 					 size_t name_len)
 {
-	return __ath11k_core_create_board_name(ab, name, name_len, true, false);
+	return __ath11k_core_create_board_name(ab, name, name_len, true,
+					       ATH11K_BDF_NAME_FULL);
 }
 
 static int ath11k_core_create_fallback_board_name(struct ath11k_base *ab, char *name,
 						  size_t name_len)
 {
-	return __ath11k_core_create_board_name(ab, name, name_len, false, false);
+	return __ath11k_core_create_board_name(ab, name, name_len, false,
+					       ATH11K_BDF_NAME_FULL);
 }
 
 static int ath11k_core_create_bus_type_board_name(struct ath11k_base *ab, char *name,
 						  size_t name_len)
 {
-	return __ath11k_core_create_board_name(ab, name, name_len, false, true);
+	return __ath11k_core_create_board_name(ab, name, name_len, false,
+					       ATH11K_BDF_NAME_BUS_NAME);
+}
+
+static int ath11k_core_create_chip_id_board_name(struct ath11k_base *ab, char *name,
+						 size_t name_len)
+{
+	return __ath11k_core_create_board_name(ab, name, name_len, false,
+					       ATH11K_BDF_NAME_CHIP_ID);
 }
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
@@ -1289,16 +1315,21 @@ int ath11k_core_fetch_board_data_api_1(struct ath11k_base *ab,
 #define BOARD_NAME_SIZE 200
 int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 {
-	char boardname[BOARD_NAME_SIZE], fallback_boardname[BOARD_NAME_SIZE];
+	char *boardname = NULL, *fallback_boardname = NULL, *chip_id_boardname = NULL;
 	char *filename, filepath[100];
-	int ret;
+	int ret = 0;
 
 	filename = ATH11K_BOARD_API2_FILE;
+	boardname = kzalloc(BOARD_NAME_SIZE, GFP_KERNEL);
+	if (!boardname) {
+		ret = -ENOMEM;
+		goto exit;
+	}
 
-	ret = ath11k_core_create_board_name(ab, boardname, sizeof(boardname));
+	ret = ath11k_core_create_board_name(ab, boardname, BOARD_NAME_SIZE);
 	if (ret) {
 		ath11k_err(ab, "failed to create board name: %d", ret);
-		return ret;
+		goto exit;
 	}
 
 	ab->bd_api = 2;
@@ -1307,13 +1338,19 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 						 ATH11K_BD_IE_BOARD_NAME,
 						 ATH11K_BD_IE_BOARD_DATA);
 	if (!ret)
-		goto success;
+		goto exit;
+
+	fallback_boardname = kzalloc(BOARD_NAME_SIZE, GFP_KERNEL);
+	if (!fallback_boardname) {
+		ret = -ENOMEM;
+		goto exit;
+	}
 
 	ret = ath11k_core_create_fallback_board_name(ab, fallback_boardname,
-						     sizeof(fallback_boardname));
+						     BOARD_NAME_SIZE);
 	if (ret) {
 		ath11k_err(ab, "failed to create fallback board name: %d", ret);
-		return ret;
+		goto exit;
 	}
 
 	ret = ath11k_core_fetch_board_data_api_n(ab, bd, fallback_boardname,
@@ -1321,7 +1358,28 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 						 ATH11K_BD_IE_BOARD_NAME,
 						 ATH11K_BD_IE_BOARD_DATA);
 	if (!ret)
-		goto success;
+		goto exit;
+
+	chip_id_boardname = kzalloc(BOARD_NAME_SIZE, GFP_KERNEL);
+	if (!chip_id_boardname) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = ath11k_core_create_chip_id_board_name(ab, chip_id_boardname,
+						    BOARD_NAME_SIZE);
+	if (ret) {
+		ath11k_err(ab, "failed to create chip id board name: %d", ret);
+		goto exit;
+	}
+
+	ret = ath11k_core_fetch_board_data_api_n(ab, bd, chip_id_boardname,
+						 ATH11K_BD_IE_BOARD,
+						 ATH11K_BD_IE_BOARD_NAME,
+						 ATH11K_BD_IE_BOARD_DATA);
+
+	if (!ret)
+		goto exit;
 
 	ab->bd_api = 1;
 	ret = ath11k_core_fetch_board_data_api_1(ab, bd, ATH11K_DEFAULT_BOARD_FILE);
@@ -1334,14 +1392,22 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 			ath11k_err(ab, "failed to fetch board data for %s from %s\n",
 				   fallback_boardname, filepath);
 
+		ath11k_err(ab, "failed to fetch board data for %s from %s\n",
+			   chip_id_boardname, filepath);
+
 		ath11k_err(ab, "failed to fetch board.bin from %s\n",
 			   ab->hw_params.fw.dir);
-		return ret;
 	}
 
-success:
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "using board api %d\n", ab->bd_api);
-	return 0;
+exit:
+	kfree(boardname);
+	kfree(fallback_boardname);
+	kfree(chip_id_boardname);
+
+	if (!ret)
+		ath11k_dbg(ab, ATH11K_DBG_BOOT, "using board api %d\n", ab->bd_api);
+
+	return ret;
 }
 
 int ath11k_core_fetch_regdb(struct ath11k_base *ab, struct ath11k_board_data *bd)

base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1

