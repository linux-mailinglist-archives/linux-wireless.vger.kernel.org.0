Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD3682C9F
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 13:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjAaMeq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 07:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAaMep (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 07:34:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2510430297
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 04:34:43 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VC7BtQ021934;
        Tue, 31 Jan 2023 12:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=tink1d0jo9oImFxgxkeWSXXSx83+J60vmVx65kr7tqw=;
 b=MepIoquCHfiCPbntSiTAQzBwRCRGxzFJ6Tn1fyH+6STNahmTCX/6PMYAhdwjHbeZSQr3
 TSlS4FKyA+3ASSU0UDW+FERiJFkPYcjUaZgaWg12olHm80KZXQHiPzvDxrmpcoLQwQre
 uISFuWopcyXQC2UqMxrvlmU7AHAVX7t+erHkJitFBeanBJFtOrG/WEcjNYOhYPF+fPx9
 M4uPKWJzi6EF2GbDkwaByi984SS7gtfEF2D+r432Uba/5gbOLFznxjaxX3dIBy3mxn3+
 RtERqGR3KldMaXDxB7KWjUE/sXR5aQMRa3MM/cIsiFW3DLHgSBFAL+jdF/VixYdUI0fx Jg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nexn8gj33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 12:34:34 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30VCYYIs006329
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 12:34:34 GMT
Received: from karm-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 04:34:32 -0800
From:   Karthik M <quic_karm@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, Karthik M <quic_karm@quicinc.com>
Subject: [PATCH] wifi: ath12k: Encoding regdb.bin in board-2.bin
Date:   Tue, 31 Jan 2023 18:04:22 +0530
Message-ID: <20230131123422.24985-1-quic_karm@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JNfEKVvj1DHSD97yvS6HZxCUro8GV5ux
X-Proofpoint-ORIG-GUID: JNfEKVvj1DHSD97yvS6HZxCUro8GV5ux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_07,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310111
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently regulatory database information are in regdb.bin outside
the board-2.bin.

In this implementation, Add support to encode the secured regdb.bin
in board-2.bin along with the bdf files.

New api(ath12k_core_fetch_regdb) fetches the board specific regdb
from board-2.bin. If it fails, it downloads the default regdb.

Firmware receives the binary over QMI and verifies the signing.
If it is authentic, the binary will be used.

Renumbered the enum ATH12K_BD_IE_BOARD_EXT to '2' since it is
not used in the code. ATH12K_BD_IE_REGDB enum will take the value '1'
as per the ath11k upstream design.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthik M <quic_karm@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 212 +++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/core.h |  23 +++
 drivers/net/wireless/ath/ath12k/hw.h   |  23 ++-
 drivers/net/wireless/ath/ath12k/qmi.c  |   6 +-
 4 files changed, 213 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index a89e66653f04..6b447244d0d3 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -83,8 +83,9 @@ int ath12k_core_resume(struct ath12k_base *ab)
 	return 0;
 }
 
-static int ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
-					 size_t name_len)
+static int ath12k_core_create_board_name(struct ath12k_base *ab,
+					 char *boardname,
+					 char *defaultboardname)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
 	char variant[9 + ATH12K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
@@ -92,15 +93,70 @@ static int ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 	if (ab->qmi.target.bdf_ext[0] != '\0')
 		scnprintf(variant, sizeof(variant), ",variant=%s",
 			  ab->qmi.target.bdf_ext);
+	switch (ab->id.bdf_search) {
+	case ATH12K_BDF_SEARCH_BUS_AND_BOARD:
+		if (snprintf(boardname, BOARD_NAME_SIZE,
+				     "bus=%s,vendor=%04x,device=%04x,"
+				     "subsystem-vendor=%04x,"
+				     "subsystem-device=%04x,qmi-chip-id=%d,"
+				     "qmi-board-id=%d%s",
+				     ath12k_bus_str(ab->hif.bus),
+				     ab->id.vendor, ab->id.device,
+				     ab->id.subsystem_vendor,
+				     ab->id.subsystem_device,
+				     ab->qmi.target.chip_id,
+				     ab->qmi.target.board_id,
+				     variant) >= BOARD_NAME_SIZE) {
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "buffer overflowed for boardname\n");
+			return -EOVERFLOW;
+		}
+		if (snprintf(defaultboardname, BOARD_NAME_SIZE,
+				     "bus=%s,vendor=%04x,device=%04x,"
+				     "subsystem-vendor=%04x,"
+				     "subsystem-device=%04x,qmi-chip-id=%d,"
+				     "qmi-board-id=%d%s",
+				     ath12k_bus_str(ab->hif.bus),
+				     ab->id.vendor, ab->id.device,
+				     ab->id.subsystem_vendor,
+				     ab->id.subsystem_device,
+				     ab->qmi.target.chip_id,
+				     ab->qmi.target.board_id,
+				     variant) >= BOARD_NAME_SIZE) {
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "buffer overflowed for default boardname\n");
+			return -EOVERFLOW;
+		}
+		break;
+	default:
+		if (snprintf(boardname, BOARD_NAME_SIZE,
+				     "bus=%s,qmi-chip-id=%d,"
+				     "qmi-board-id=%d%s",
+				     ath12k_bus_str(ab->hif.bus),
+				     ab->qmi.target.chip_id,
+				     ab->qmi.target.board_id,
+				     variant) >= BOARD_NAME_SIZE) {
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "buffer overflowed for boardname\n");
+			return -EOVERFLOW;
+		}
+		if (snprintf(defaultboardname, BOARD_NAME_SIZE,
+				     "bus=%s,qmi-chip-id=%d,"
+				     "qmi-board-id=%d%s",
+				     ath12k_bus_str(ab->hif.bus),
+				     ab->qmi.target.chip_id,
+				     ATH12K_DEFAULT_ID,
+				     variant) >= BOARD_NAME_SIZE) {
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "buffer overflowed for default boardname\n");
+			return -EOVERFLOW;
+		}
+		break;
+	}
 
-	scnprintf(name, name_len,
-		  "bus=%s,qmi-chip-id=%d,qmi-board-id=%d%s",
-		  ath12k_bus_str(ab->hif.bus),
-		  ab->qmi.target.chip_id,
-		  ab->qmi.target.board_id, variant);
-
-	ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot using board name '%s'\n", name);
-
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot using board name : '%s'\t"
+		   "default boardname : '%s'\n", boardname,
+		   defaultboardname);
 	return 0;
 }
 
@@ -136,9 +192,7 @@ void ath12k_core_free_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 
 static int ath12k_core_parse_bd_ie_board(struct ath12k_base *ab,
 					 struct ath12k_board_data *bd,
-					 const void *buf, size_t buf_len,
-					 const char *boardname,
-					 int bd_ie_type)
+					 const void *buf, size_t buf_len)
 {
 	const struct ath12k_fw_ie *hdr;
 	bool name_match_found;
@@ -148,7 +202,7 @@ static int ath12k_core_parse_bd_ie_board(struct ath12k_base *ab,
 
 	name_match_found = false;
 
-	/* go through ATH12K_BD_IE_BOARD_ elements */
+	/* go through ATH12K_BD_IE_BOARD_/ATH12K_BD_IE_REGDB_ elements */
 	while (buf_len > sizeof(struct ath12k_fw_ie)) {
 		hdr = buf;
 		board_ie_id = le32_to_cpu(hdr->id);
@@ -159,48 +213,51 @@ static int ath12k_core_parse_bd_ie_board(struct ath12k_base *ab,
 		buf += sizeof(*hdr);
 
 		if (buf_len < ALIGN(board_ie_len, 4)) {
-			ath12k_err(ab, "invalid ATH12K_BD_IE_BOARD length: %zu < %zu\n",
+			ath12k_err(ab, "invalid %s length: %zu < %zu\n",
+				   ath12k_bd_ie_type_str(bd->ie_id),
 				   buf_len, ALIGN(board_ie_len, 4));
 			ret = -EINVAL;
 			goto out;
 		}
 
-		switch (board_ie_id) {
-		case ATH12K_BD_IE_BOARD_NAME:
+		if (board_ie_id == bd->name_id) {
 			ath12k_dbg_dump(ab, ATH12K_DBG_BOOT, "board name", "",
 					board_ie_data, board_ie_len);
 
-			if (board_ie_len != strlen(boardname))
-				break;
+			if (board_ie_len != strlen(bd->boardname))
+				goto next;
 
-			ret = memcmp(board_ie_data, boardname, strlen(boardname));
+			ret = memcmp(board_ie_data, bd->boardname, strlen(bd->boardname));
 			if (ret)
-				break;
+				goto next;
 
 			name_match_found = true;
 			ath12k_dbg(ab, ATH12K_DBG_BOOT,
-				   "boot found match for name '%s'",
-				   boardname);
-			break;
-		case ATH12K_BD_IE_BOARD_DATA:
+				   "boot found match %s for name '%s'",
+				   ath12k_bd_ie_type_str(bd->ie_id),
+				   bd->boardname);
+		} else if (board_ie_id == bd->data_id) {
 			if (!name_match_found)
 				/* no match found */
-				break;
+				goto next;
 
 			ath12k_dbg(ab, ATH12K_DBG_BOOT,
-				   "boot found board data for '%s'", boardname);
+				   "boot found %s for '%s'",
+				   ath12k_bd_ie_type_str(bd->ie_id),
+				   bd->boardname);
 
 			bd->data = board_ie_data;
 			bd->len = board_ie_len;
 
 			ret = 0;
 			goto out;
-		default:
-			ath12k_warn(ab, "unknown ATH12K_BD_IE_BOARD found: %d\n",
+		} else {
+			ath12k_warn(ab, "unknown %s id found: %d\n",
+				    ath12k_bd_ie_type_str(bd->ie_id),
 				    board_ie_id);
-			break;
 		}
 
+next:
 		/* jump over the padding */
 		board_ie_len = ALIGN(board_ie_len, 4);
 
@@ -216,8 +273,7 @@ static int ath12k_core_parse_bd_ie_board(struct ath12k_base *ab,
 }
 
 static int ath12k_core_fetch_board_data_api_n(struct ath12k_base *ab,
-					      struct ath12k_board_data *bd,
-					      const char *boardname)
+					      struct ath12k_board_data *bd)
 {
 	size_t len, magic_len;
 	const u8 *data;
@@ -282,15 +338,12 @@ static int ath12k_core_fetch_board_data_api_n(struct ath12k_base *ab,
 			goto err;
 		}
 
-		switch (ie_id) {
-		case ATH12K_BD_IE_BOARD:
+		if (ie_id == bd->ie_id) {
 			ret = ath12k_core_parse_bd_ie_board(ab, bd, data,
-							    ie_len,
-							    boardname,
-							    ATH12K_BD_IE_BOARD);
+							    ie_len);
 			if (ret == -ENOENT)
 				/* no match found, continue */
-				break;
+				goto next;
 			else if (ret)
 				/* there was an error, bail out */
 				goto err;
@@ -298,6 +351,7 @@ static int ath12k_core_fetch_board_data_api_n(struct ath12k_base *ab,
 			goto out;
 		}
 
+next:
 		/* jump over the padding */
 		ie_len = ALIGN(ie_len, 4);
 
@@ -307,9 +361,10 @@ static int ath12k_core_fetch_board_data_api_n(struct ath12k_base *ab,
 
 out:
 	if (!bd->data || !bd->len) {
-		ath12k_err(ab,
-			   "failed to fetch board data for %s from %s\n",
-			   boardname, filepath);
+		ath12k_dbg(ab, ATH12K_DBG_BOOT,
+			   "failed to fetch %s for %s from %s\n",
+			   ath12k_bd_ie_type_str(bd->ie_id),
+			   bd->boardname, filepath);
 		ret = -ENODATA;
 		goto err;
 	}
@@ -317,7 +372,8 @@ static int ath12k_core_fetch_board_data_api_n(struct ath12k_base *ab,
 	return 0;
 
 err:
-	ath12k_core_free_bdf(ab, bd);
+	if (bd->retry)
+		ath12k_core_free_bdf(ab, bd);
 	return ret;
 }
 
@@ -326,6 +382,7 @@ int ath12k_core_fetch_board_data_api_1(struct ath12k_base *ab,
 				       char *filename)
 {
 	bd->fw = ath12k_core_firmware_request(ab, filename);
+
 	if (IS_ERR(bd->fw))
 		return PTR_ERR(bd->fw);
 
@@ -335,28 +392,89 @@ int ath12k_core_fetch_board_data_api_1(struct ath12k_base *ab,
 	return 0;
 }
 
-#define BOARD_NAME_SIZE 100
 int ath12k_core_fetch_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 {
-	char boardname[BOARD_NAME_SIZE];
+	char boardname[BOARD_NAME_SIZE] = {0},
+	     defaultboardname[BOARD_NAME_SIZE] = {0};
 	int ret;
 
-	ret = ath12k_core_create_board_name(ab, boardname, BOARD_NAME_SIZE);
+	ret = ath12k_core_create_board_name(ab, boardname,
+					    defaultboardname);
 	if (ret) {
 		ath12k_err(ab, "failed to create board name: %d", ret);
 		return ret;
 	}
 
 	ab->bd_api = 2;
-	ret = ath12k_core_fetch_board_data_api_n(ab, bd, boardname);
+	bd->ie_id = ATH12K_BD_IE_BOARD;
+	bd->name_id = ATH12K_BD_IE_BOARD_NAME;
+	bd->data_id = ATH12K_BD_IE_BOARD_DATA;
+	memcpy(bd->boardname, boardname, BOARD_NAME_SIZE);
+
+	ret = ath12k_core_fetch_board_data_api_n(ab, bd);
+	if (!ret)
+		goto success;
+
+	bd->retry = 1;
+	memcpy(bd->boardname, defaultboardname, BOARD_NAME_SIZE);
+
+	ret = ath12k_core_fetch_board_data_api_n(ab, bd);
 	if (!ret)
 		goto success;
 
 	ab->bd_api = 1;
 	ret = ath12k_core_fetch_board_data_api_1(ab, bd, ATH12K_DEFAULT_BOARD_FILE);
 	if (ret) {
-		ath12k_err(ab, "failed to fetch board-2.bin or board.bin from %s\n",
+		ath12k_err(ab, "failed to fetch board.bin from %s\n",
 			   ab->hw_params->fw.dir);
+	} else {
+		ret = ath12k_core_fetch_board_data_api_1(ab, bd, ATH12K_BOARD_API2_FILE);
+		if (ret)
+			ath12k_err(ab, "failed to fetch board-2.bin from %s\n",
+				   ab->hw_params->fw.dir);
+		return ret;
+	}
+
+success:
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "using board api %d\n", ab->bd_api);
+	return 0;
+}
+
+int ath12k_core_fetch_regdb(struct ath12k_base *ab, struct ath12k_board_data *bd)
+{
+	char regdbname[BOARD_NAME_SIZE] = {0},
+	     defaultregdbname[BOARD_NAME_SIZE] = {0};
+	int ret;
+
+	ret = ath12k_core_create_board_name(ab, regdbname,
+					    defaultregdbname);
+	if (ret) {
+		ath12k_err(ab, "failed to create regdb name: %d", ret);
+		return ret;
+	}
+
+	ab->bd_api = 2;
+	bd->ie_id = ATH12K_BD_IE_REGDB;
+	bd->name_id = ATH12K_BD_IE_REGDB_NAME;
+	bd->data_id = ATH12K_BD_IE_REGDB_DATA;
+	memcpy(bd->boardname, regdbname, BOARD_NAME_SIZE);
+
+	ret = ath12k_core_fetch_board_data_api_n(ab, bd);
+	if (!ret)
+		goto success;
+
+	bd->retry = 1;
+	memcpy(bd->boardname, defaultregdbname, BOARD_NAME_SIZE);
+
+	ret = ath12k_core_fetch_board_data_api_n(ab, bd);
+	if (!ret)
+		goto success;
+
+	ab->bd_api = 1;
+	ret = ath12k_core_fetch_board_data_api_1(ab, bd, ATH12K_REGDB_FILE_NAME);
+	if (ret) {
+		ath12k_err(ab, "failed to fetch %s file from %s\n",
+			   ATH12K_REGDB_FILE_NAME, ab->hw_params->fw.dir);
 		return ret;
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index a54ae74543c1..361d23406a58 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -44,6 +44,11 @@
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
@@ -612,10 +617,24 @@ struct ath12k_pdev {
 	struct mlo_timestamp timestamp;
 };
 
+#define BOARD_NAME_SIZE 100
 struct ath12k_board_data {
 	const struct firmware *fw;
 	const void *data;
 	size_t len;
+	char boardname[BOARD_NAME_SIZE];
+	u32 ie_id;
+	u32 name_id;
+	u32 data_id;
+	u32 retry;
+};
+
+struct vendor_info {
+	enum ath12k_bdf_search bdf_search;
+	u32 vendor;
+	u32 device;
+	u32 subsystem_vendor;
+	u32 subsystem_device;
 };
 
 struct ath12k_soc_dp_tx_err_stats {
@@ -735,6 +754,8 @@ struct ath12k_base {
 	u64 fw_soc_drop_count;
 	bool static_window_map;
 
+	struct vendor_info id;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -751,6 +772,8 @@ int ath12k_core_fetch_board_data_api_1(struct ath12k_base *ab,
 				       char *filename);
 int ath12k_core_fetch_bdf(struct ath12k_base *ath12k,
 			  struct ath12k_board_data *bd);
+int ath12k_core_fetch_regdb(struct ath12k_base *ath12k,
+			    struct ath12k_board_data *bd);
 void ath12k_core_free_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd);
 int ath12k_core_check_dt(struct ath12k_base *ath12k);
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index e3461004188b..2e3108a518a3 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -81,6 +81,7 @@
 #define ATH12K_AMSS_FILE		"amss.bin"
 #define ATH12K_M3_FILE			"m3.bin"
 #define ATH12K_REGDB_FILE_NAME		"regdb.bin"
+#define ATH12K_DEFAULT_ID		255
 
 enum ath12k_hw_rate_cck {
 	ATH12K_HW_RATE_CCK_LP_11M = 0,
@@ -234,12 +235,32 @@ enum ath12k_bd_ie_board_type {
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
-	ATH12K_BD_IE_BOARD_EXT = 1,
+	ATH12K_BD_IE_REGDB = 1,
+	ATH12K_BD_IE_BOARD_EXT = 2,
 };
 
+static inline const char *ath12k_bd_ie_type_str(enum ath12k_bd_ie_type type)
+{
+	switch (type) {
+	case ATH12K_BD_IE_BOARD:
+		return "board data";
+	case ATH12K_BD_IE_REGDB:
+		return "regdb data";
+	case ATH12K_BD_IE_BOARD_EXT:
+		return "board data ext";
+	}
+
+	return "unknown";
+}
+
 struct ath12k_hw_regs {
 	u32 hal_tcl1_ring_id;
 	u32 hal_tcl1_ring_misc;
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 979a63f2e2ab..457ae1be41ee 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2416,12 +2416,12 @@ static int ath12k_qmi_load_bdf_qmi(struct ath12k_base *ab,
 
 		break;
 	case ATH12K_QMI_BDF_TYPE_REGDB:
-		ret = ath12k_core_fetch_board_data_api_1(ab, &bd,
-							 ATH12K_REGDB_FILE_NAME);
+		ret = ath12k_core_fetch_regdb(ab, &bd);
 		if (ret) {
-			ath12k_warn(ab, "qmi failed to load regdb bin:\n");
+			ath12k_warn(ab, "qmi failed to load regdb:\n");
 			goto out;
 		}
+		type = ATH12K_QMI_BDF_TYPE_REGDB;
 		break;
 	case ATH12K_QMI_BDF_TYPE_CALIBRATION:
 
-- 
2.17.1

