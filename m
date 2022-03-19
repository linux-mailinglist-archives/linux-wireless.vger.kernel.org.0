Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5A4DE533
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Mar 2022 03:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbiCSCha (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Mar 2022 22:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiCSCh3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Mar 2022 22:37:29 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1152BB7CD
        for <linux-wireless@vger.kernel.org>; Fri, 18 Mar 2022 19:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647657369; x=1679193369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/YRh0Wl/MfP6VFWDYfPSddCmwgK5+A6B+EopgyZ83rs=;
  b=PZJnzPWElPqZcBa0TG5jq0hST4Zbc8mAK5rJcTKUlRfKD5zBRGO8vat4
   rBQCxfh6qWeRMVv2zkSj4r6c2C4BWf2wB4u/yZIhGCDFosQ1WcExhXmHW
   QuvORVEjgoV3b89g52oDkX4KdOORCJ6hPlFj5TtNTb8Fm7QZPc7JcOCwC
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Mar 2022 19:36:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 19:36:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 18 Mar 2022 19:36:09 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 18 Mar 2022 19:36:07 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 3/3] ath11k: add support to search regdb data in board-2.bin for WCN6855
Date:   Fri, 18 Mar 2022 22:35:43 -0400
Message-ID: <20220319023543.14288-4-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220319023543.14288-1-quic_wgong@quicinc.com>
References: <20220319023543.14288-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently ath11k only download the same regdb.bin file for all WCN6855
chips, actually ath11k needs to distinguish all different WCN6855 chips.

This is to re-use the string type which include bus, chip id, board id,
vendor, device, subsystem-vendor, subsystem-device and variant for
WCN6855 to distinguish different regdb in board-2.bin.

ath11k will first load board-2.bin and search in it for the regdb data
with the above parameters, if matched one regdb data, then download it
to firmware, if not matched any one, then ath11k will download the file
regdb.bin to firmware.

Add enum value ATH11K_BD_IE_REGDB and enum type ath11k_bd_ie_regdb_type
to distinguish regdb data and board data since they are in the same file
board-2.bin.

This only take effect for WCN6855 which supports regdb in hardware parameters.

Test log:
[ 3833.091948] ath11k_pci 0000:05:00.0: boot using board name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
[ 3833.092072] ath11k_pci 0000:05:00.0: boot firmware request ath11k/WCN6855/hw2.0/board-2.bin size 205316
[ 3833.092079] ath11k_pci 0000:05:00.0: board name
[ 3833.092083] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[ 3833.092088] ath11k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 31                                   -id=1
[ 3833.092091] ath11k_pci 0000:05:00.0: board name
[ 3833.092095] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[ 3833.092099] ath11k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 32                                   -id=2
[ 3833.092102] ath11k_pci 0000:05:00.0: board name
[ 3833.092105] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[ 3833.092109] ath11k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 33                                   -id=3
[ 3833.092112] ath11k_pci 0000:05:00.0: board name
[ 3833.092116] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[ 3833.092119] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[ 3833.092123] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[ 3833.092126] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[ 3833.092130] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[ 3833.092133] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
[ 3833.092137] ath11k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 36 2c 76 61 72 69 61  ard-id=266,varia
[ 3833.092140] ath11k_pci 0000:05:00.0: 00000070: 6e 74 3d 48 50 5f 47 38 5f 4c 61 6e 63 69 61 31  nt=HP_G8_Lancia1
[ 3833.092144] ath11k_pci 0000:05:00.0: 00000080: 35                                               5
[ 3833.092147] ath11k_pci 0000:05:00.0: board name
[ 3833.092150] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[ 3833.092154] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[ 3833.092157] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[ 3833.092161] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[ 3833.092165] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[ 3833.092168] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
[ 3833.092172] ath11k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 36                    ard-id=266
[ 3833.092206] ath11k_pci 0000:05:00.0: board name
[ 3833.092209] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[ 3833.092213] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[ 3833.092216] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[ 3833.092220] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[ 3833.092223] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[ 3833.092227] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
[ 3833.092230] ath11k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 32                    ard-id=262
[ 3833.092234] ath11k_pci 0000:05:00.0: boot found match regdb data for name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
[ 3833.092238] ath11k_pci 0000:05:00.0: board name
[ 3833.092241] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[ 3833.092245] ath11k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 31 31                                -id=11
[ 3833.092248] ath11k_pci 0000:05:00.0: board name
[ 3833.092251] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[ 3833.092255] ath11k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 32 32                                -id=22
[ 3833.092258] ath11k_pci 0000:05:00.0: board name
[ 3833.092261] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[ 3833.092265] ath11k_pci 0000:05:00.0: 00000010: 2d 69 64 3d 33 33                                -id=33
[ 3833.092268] ath11k_pci 0000:05:00.0: boot found regdb data for 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
[ 3833.092272] ath11k_pci 0000:05:00.0: fetched regdb

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 79 ++++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/hw.h   | 19 +++++++
 2 files changed, 74 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 92797d7537f5..8eb2139036f7 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -602,7 +602,9 @@ static int ath11k_core_parse_bd_ie_board(struct ath11k_base *ab,
 					 struct ath11k_board_data *bd,
 					 const void *buf, size_t buf_len,
 					 const char *boardname,
-					 int bd_ie_type)
+					 int ie_id,
+					 int name_id,
+					 int data_id)
 {
 	const struct ath11k_fw_ie *hdr;
 	bool name_match_found;
@@ -612,7 +614,7 @@ static int ath11k_core_parse_bd_ie_board(struct ath11k_base *ab,
 
 	name_match_found = false;
 
-	/* go through ATH11K_BD_IE_BOARD_ elements */
+	/* go through ATH11K_BD_IE_BOARD_/ATH11K_BD_IE_REGDB_ elements */
 	while (buf_len > sizeof(struct ath11k_fw_ie)) {
 		hdr = buf;
 		board_ie_id = le32_to_cpu(hdr->id);
@@ -623,48 +625,50 @@ static int ath11k_core_parse_bd_ie_board(struct ath11k_base *ab,
 		buf += sizeof(*hdr);
 
 		if (buf_len < ALIGN(board_ie_len, 4)) {
-			ath11k_err(ab, "invalid ATH11K_BD_IE_BOARD length: %zu < %zu\n",
+			ath11k_err(ab, "invalid %s length: %zu < %zu\n",
+				   ath11k_bd_ie_type_str(ie_id),
 				   buf_len, ALIGN(board_ie_len, 4));
 			ret = -EINVAL;
 			goto out;
 		}
 
-		switch (board_ie_id) {
-		case ATH11K_BD_IE_BOARD_NAME:
+		if (board_ie_id == name_id) {
 			ath11k_dbg_dump(ab, ATH11K_DBG_BOOT, "board name", "",
 					board_ie_data, board_ie_len);
 
 			if (board_ie_len != strlen(boardname))
-				break;
+				goto next;
 
 			ret = memcmp(board_ie_data, boardname, strlen(boardname));
 			if (ret)
-				break;
+				goto next;
 
 			name_match_found = true;
 			ath11k_dbg(ab, ATH11K_DBG_BOOT,
-				   "boot found match for name '%s'",
+				   "boot found match %s for name '%s'",
+				   ath11k_bd_ie_type_str(ie_id),
 				   boardname);
-			break;
-		case ATH11K_BD_IE_BOARD_DATA:
+		} else if (board_ie_id == data_id) {
 			if (!name_match_found)
 				/* no match found */
-				break;
+				goto next;
 
 			ath11k_dbg(ab, ATH11K_DBG_BOOT,
-				   "boot found board data for '%s'", boardname);
+				   "boot found %s for '%s'",
+				   ath11k_bd_ie_type_str(ie_id),
+				   boardname);
 
 			bd->data = board_ie_data;
 			bd->len = board_ie_len;
 
 			ret = 0;
 			goto out;
-		default:
-			ath11k_warn(ab, "unknown ATH11K_BD_IE_BOARD found: %d\n",
+		} else {
+			ath11k_warn(ab, "unknown %s id found: %d\n",
+				    ath11k_bd_ie_type_str(ie_id),
 				    board_ie_id);
-			break;
 		}
-
+next:
 		/* jump over the padding */
 		board_ie_len = ALIGN(board_ie_len, 4);
 
@@ -681,7 +685,10 @@ static int ath11k_core_parse_bd_ie_board(struct ath11k_base *ab,
 
 static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 					      struct ath11k_board_data *bd,
-					      const char *boardname)
+					      const char *boardname,
+					      int ie_id_match,
+					      int name_id,
+					      int data_id)
 {
 	size_t len, magic_len;
 	const u8 *data;
@@ -746,22 +753,23 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 			goto err;
 		}
 
-		switch (ie_id) {
-		case ATH11K_BD_IE_BOARD:
+		if (ie_id == ie_id_match) {
 			ret = ath11k_core_parse_bd_ie_board(ab, bd, data,
 							    ie_len,
 							    boardname,
-							    ATH11K_BD_IE_BOARD);
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
 
@@ -772,7 +780,8 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 out:
 	if (!bd->data || !bd->len) {
 		ath11k_err(ab,
-			   "failed to fetch board data for %s from %s\n",
+			   "failed to fetch %s for %s from %s\n",
+			   ath11k_bd_ie_type_str(ie_id_match),
 			   boardname, filepath);
 		ret = -ENODATA;
 		goto err;
@@ -813,7 +822,10 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 	}
 
 	ab->bd_api = 2;
-	ret = ath11k_core_fetch_board_data_api_n(ab, bd, boardname);
+	ret = ath11k_core_fetch_board_data_api_n(ab, bd, boardname,
+						 ATH11K_BD_IE_BOARD,
+						 ATH11K_BD_IE_BOARD_NAME,
+						 ATH11K_BD_IE_BOARD_DATA);
 	if (!ret)
 		goto success;
 
@@ -832,13 +844,32 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 
 int ath11k_core_fetch_regdb(struct ath11k_base *ab, struct ath11k_board_data *bd)
 {
+	char boardname[BOARD_NAME_SIZE];
 	int ret;
 
+	ret = ath11k_core_create_board_name(ab, boardname, BOARD_NAME_SIZE);
+	if (ret) {
+		ath11k_dbg(ab, ATH11K_DBG_BOOT,
+			   "failed to create board name for regdb: %d", ret);
+		goto exit;
+	}
+
+	ret = ath11k_core_fetch_board_data_api_n(ab, bd, boardname,
+						 ATH11K_BD_IE_REGDB,
+						 ATH11K_BD_IE_REGDB_NAME,
+						 ATH11K_BD_IE_REGDB_DATA);
+	if (!ret)
+		goto exit;
+
 	ret = ath11k_core_fetch_board_data_api_1(ab, bd, ATH11K_REGDB_FILE_NAME);
 	if (ret)
 		ath11k_dbg(ab, ATH11K_DBG_BOOT, "failed to fetch %s from %s\n",
 			   ATH11K_REGDB_FILE_NAME, ab->hw_params.fw.dir);
 
+exit:
+	if (!ret)
+		ath11k_dbg(ab, ATH11K_DBG_BOOT, "fetched regdb\n");
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 1c701e16a3b5..9bd46695bec6 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -290,9 +290,16 @@ enum ath11k_bd_ie_board_type {
 	ATH11K_BD_IE_BOARD_DATA = 1,
 };
 
+enum ath11k_bd_ie_regdb_type {
+	ATH11K_BD_IE_REGDB_NAME = 0,
+	ATH11K_BD_IE_REGDB_DATA = 1,
+};
+
 enum ath11k_bd_ie_type {
 	/* contains sub IEs of enum ath11k_bd_ie_board_type */
 	ATH11K_BD_IE_BOARD = 0,
+	/* contains sub IEs of enum ath11k_bd_ie_regdb_type */
+	ATH11K_BD_IE_REGDB = 1,
 };
 
 struct ath11k_hw_regs {
@@ -360,4 +367,16 @@ extern const struct ath11k_hw_regs qca6390_regs;
 extern const struct ath11k_hw_regs qcn9074_regs;
 extern const struct ath11k_hw_regs wcn6855_regs;
 
+static inline const char *ath11k_bd_ie_type_str(enum ath11k_bd_ie_type type)
+{
+	switch (type) {
+	case ATH11K_BD_IE_BOARD:
+		return "board data";
+	case ATH11K_BD_IE_REGDB:
+		return "regdb data";
+	}
+
+	return "unknown";
+}
+
 #endif
-- 
2.31.1

