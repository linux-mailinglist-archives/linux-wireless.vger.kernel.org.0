Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB5F4D9969
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 11:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347617AbiCOKuV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 06:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348649AbiCOKtm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 06:49:42 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0697369E6
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 03:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647341261; x=1678877261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1FEF9c8UikgpcXE4OrmFehuK2TUFX6iGEK8FhxKy+h4=;
  b=j4npWPBZJIOXS01YhHdtRH3Cp9vCDfF5XYhwJ8F4bD3HjAeT0cwcM4Z7
   dVYsbZ/mj4GIuULUNvk4xyFjK7saF9Efg2TFZtHSlw057ama0OXJMXNXK
   sqM7sRkNgG6p4krAud2Q9LdYGMS9n1tD2STgWSBMlRP1ztVcRiF/kiJ5A
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Mar 2022 03:47:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 03:47:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Mar 2022 03:47:40 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 15 Mar 2022 03:47:39 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v6 1/2] ath11k: add fallback board name without variant while searching board-2.bin
Date:   Tue, 15 Mar 2022 06:47:20 -0400
Message-ID: <20220315104721.26649-2-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220315104721.26649-1-quic_wgong@quicinc.com>
References: <20220315104721.26649-1-quic_wgong@quicinc.com>
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

Sometimes it has a variant value which read from DT or SMBIOS by
ath11k, and meanwhile it does not have the matched board name in
board-2.bin, then it will failed at boot up phase.

Add fallback board name which removed variant value and search again
in board-2.bin when failed with variant and try to load the board
data again to increase boot up success rate.

dmesg log after this patch:
[169547.248472] ath11k_pci 0000:05:00.0: boot using board name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262,variant=test'
[169547.248565] ath11k_pci 0000:05:00.0: boot firmware request ath11k/WCN6855/hw2.0/board-2.bin size 180324
[169547.248568] ath11k_pci 0000:05:00.0: board name
[169547.248570] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[169547.248571] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[169547.248572] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[169547.248574] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[169547.248575] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[169547.248576] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
[169547.248577] ath11k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 32                    ard-id=262
[169547.248578] ath11k_pci 0000:05:00.0: board name
[169547.248579] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[169547.248581] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[169547.248582] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[169547.248583] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[169547.248584] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[169547.248585] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
[169547.248587] ath11k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 36                    ard-id=266
[169547.248588] ath11k_pci 0000:05:00.0: board name
[169547.248589] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[169547.248590] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[169547.248591] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[169547.248592] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[169547.248594] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[169547.248595] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 31 38 2c 71 6d 69 2d 62  chip-id=18,qmi-b
[169547.248596] ath11k_pci 0000:05:00.0: 00000060: 6f 61 72 64 2d 69 64 3d 32 36 36                 oard-id=266
[169547.248597] ath11k_pci 0000:05:00.0: failed to fetch board data for bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262,variant=test from ath11k/WCN6855/hw2.0/board-2.bin
[169547.248476] ath11k_pci 0000:05:00.0: boot using board name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
[169547.248634] ath11k_pci 0000:05:00.0: boot firmware request ath11k/WCN6855/hw2.0/board-2.bin size 180324
[169547.248636] ath11k_pci 0000:05:00.0: board name
[169547.248637] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
[169547.248638] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
[169547.248639] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
[169547.248641] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
[169547.248642] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
[169547.248643] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
[169547.248645] ath11k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 32                    ard-id=262
[169547.248646] ath11k_pci 0000:05:00.0: boot found match for name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
[169547.248647] ath11k_pci 0000:05:00.0: boot found board data for 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
[169547.248649] ath11k_pci 0000:05:00.0: using board api 2

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 48 ++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 71eb7d04c3bf..7711bdb36170 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -532,13 +532,13 @@ int ath11k_core_check_dt(struct ath11k_base *ab)
 	return 0;
 }
 
-static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
-					 size_t name_len)
+static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
+					   size_t name_len, bool with_variant)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
 	char variant[9 + ATH11K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
 
-	if (ab->qmi.target.bdf_ext[0] != '\0')
+	if (with_variant && ab->qmi.target.bdf_ext[0] != '\0')
 		scnprintf(variant, sizeof(variant), ",variant=%s",
 			  ab->qmi.target.bdf_ext);
 
@@ -568,6 +568,18 @@ static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 	return 0;
 }
 
+static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
+					 size_t name_len)
+{
+	return __ath11k_core_create_board_name(ab, name, name_len, true);
+}
+
+static int ath11k_core_create_fallback_board_name(struct ath11k_base *ab, char *name,
+						  size_t name_len)
+{
+	return __ath11k_core_create_board_name(ab, name, name_len, false);
+}
+
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *file)
 {
@@ -771,7 +783,7 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 
 out:
 	if (!bd->data || !bd->len) {
-		ath11k_err(ab,
+		ath11k_dbg(ab, ATH11K_DBG_BOOT,
 			   "failed to fetch board data for %s from %s\n",
 			   boardname, filepath);
 		ret = -ENODATA;
@@ -803,10 +815,13 @@ int ath11k_core_fetch_board_data_api_1(struct ath11k_base *ab,
 #define BOARD_NAME_SIZE 200
 int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 {
-	char boardname[BOARD_NAME_SIZE];
+	char boardname[BOARD_NAME_SIZE], fallback_boardname[BOARD_NAME_SIZE];
+	char *filename, filepath[100];
 	int ret;
 
-	ret = ath11k_core_create_board_name(ab, boardname, BOARD_NAME_SIZE);
+	filename = ATH11K_BOARD_API2_FILE;
+
+	ret = ath11k_core_create_board_name(ab, boardname, sizeof(boardname));
 	if (ret) {
 		ath11k_err(ab, "failed to create board name: %d", ret);
 		return ret;
@@ -817,10 +832,29 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 	if (!ret)
 		goto success;
 
+	ret = ath11k_core_create_fallback_board_name(ab, fallback_boardname,
+						     sizeof(fallback_boardname));
+	if (ret) {
+		ath11k_err(ab, "failed to create fallback board name: %d", ret);
+		return ret;
+	}
+
+	ret = ath11k_core_fetch_board_data_api_n(ab, bd, fallback_boardname);
+	if (!ret)
+		goto success;
+
 	ab->bd_api = 1;
 	ret = ath11k_core_fetch_board_data_api_1(ab, bd, ATH11K_DEFAULT_BOARD_FILE);
 	if (ret) {
-		ath11k_err(ab, "failed to fetch board-2.bin or board.bin from %s\n",
+		ath11k_core_create_firmware_path(ab, filename,
+						 filepath, sizeof(filepath));
+		ath11k_err(ab, "failed to fetch board data for %s from %s\n",
+			   boardname, filepath);
+		if (memcmp(boardname, fallback_boardname, strlen(boardname)))
+			ath11k_err(ab, "failed to fetch board data for %s from %s\n",
+				   fallback_boardname, filepath);
+
+		ath11k_err(ab, "failed to fetch board.bin from %s\n",
 			   ab->hw_params.fw.dir);
 		return ret;
 	}
-- 
2.31.1

