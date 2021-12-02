Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF61F465F93
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 09:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhLBIkT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 03:40:19 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:19206 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbhLBIkF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 03:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638434203; x=1669970203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JXveHdo2NanSwyJKUg6M4GaejzAJwxakgF2GaMRdF4Y=;
  b=moWLweWGOUfruMQ0Da/RqnRl0qEbpZqQOinugVmI/ZGebvp1QsH3LlVD
   KApJvb6NHq+bYIAnVuTZzHUCZ0AyiGwOuq3BM3cg8UCWASIH0PQpZlhRZ
   O/eVtU40okIQveiqPas0fUIIS0CvUWXXi2qZeGHW4fyla4lwazBQchWKk
   4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 02 Dec 2021 00:36:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:36:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 00:36:42 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 00:36:40 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: add regdb.bin download for regdb offload
Date:   Thu, 2 Dec 2021 03:36:16 -0500
Message-ID: <20211202083616.15406-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The regdomain is self-managed type for ath11k, the regdomain info is
reported from firmware, it is not from wireless regdb. Firmware fetch
the regdomain info from board data file before. Currently most of the
regdomain info has moved to another file regdb.bin from board data
file for some chips such as QCA6390 and WCN6855, so the regdomain info
left in board data file is not enough to support the feature which need
more reg rules such as 6 GHz LPI, SP and VLP.

After download regdb.bin, firmware will fetch the regdomain info from
regdb.bin instead of board data file and report to ath11k. If it does
not have the file regdb.bin, it also can initialize wlan success and
firmware then fetch regdomain info from board data file.

Add download the regdb.bin before download board data for some specific
chip which support supports_regdb in hardware parameters.

download regdb.bin log:
[430082.334162] ath11k_pci 0000:05:00.0: chip_id 0x2 chip_family 0xb board_id 0x106 soc_id 0x400c0200
[430082.334169] ath11k_pci 0000:05:00.0: fw_version 0x110c8b4c fw_build_timestamp 2021-10-25 07:41 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HSP.1.1-02892-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
[430082.334414] ath11k_pci 0000:05:00.0: boot firmware request ath11k/WCN6855/hw2.0/regdb.bin size 24310

output of "iw reg get"
global
country US: DFS-FCC
        (2402 - 2472 @ 40), (N/A, 30), (N/A)
        (5170 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
        (5250 - 5330 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
        (5490 - 5730 @ 160), (N/A, 23), (0 ms), DFS
        (5735 - 5835 @ 80), (N/A, 30), (N/A)
        (57240 - 63720 @ 2160), (N/A, 40), (N/A)

phy#0 (self-managed)
country US: DFS-FCC
        (2402 - 2472 @ 40), (6, 30), (N/A)
        (5170 - 5250 @ 80), (N/A, 24), (N/A), AUTO-BW
        (5250 - 5330 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
        (5490 - 5730 @ 160), (N/A, 24), (0 ms), DFS, AUTO-BW
        (5735 - 5895 @ 160), (N/A, 30), (N/A), AUTO-BW
        (5945 - 7125 @ 160), (N/A, 24), (N/A), NO-OUTDOOR, AUTO-BW

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 15 +++++++++++----
 drivers/net/wireless/ath/ath11k/core.h |  3 +++
 drivers/net/wireless/ath/ath11k/hw.h   |  2 ++
 drivers/net/wireless/ath/ath11k/qmi.c  | 24 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/qmi.h  |  1 +
 5 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index dd1a1bb078c3..42a147063502 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -87,6 +87,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = true,
 		.wakeup_mhi = false,
+		.supports_regdb = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -141,6 +142,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = true,
 		.wakeup_mhi = false,
+		.supports_regdb = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -194,6 +196,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
 		.wakeup_mhi = true,
+		.supports_regdb = true,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -247,6 +250,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = true,
 		.alloc_cacheable_memory = true,
 		.wakeup_mhi = false,
+		.supports_regdb = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -300,6 +304,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
 		.wakeup_mhi = true,
+		.supports_regdb = true,
 	},
 };
 
@@ -660,10 +665,12 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 	return ret;
 }
 
-static int ath11k_core_fetch_board_data_api_1(struct ath11k_base *ab,
-					      struct ath11k_board_data *bd)
+int ath11k_core_fetch_board_data_api_1(struct ath11k_base *ab,
+				       struct ath11k_board_data *bd,
+				       const char *name)
 {
-	bd->fw = ath11k_core_firmware_request(ab, ATH11K_DEFAULT_BOARD_FILE);
+	bd->fw = ath11k_core_firmware_request(ab, name);
+
 	if (IS_ERR(bd->fw))
 		return PTR_ERR(bd->fw);
 
@@ -691,7 +698,7 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 		goto success;
 
 	ab->bd_api = 1;
-	ret = ath11k_core_fetch_board_data_api_1(ab, bd);
+	ret = ath11k_core_fetch_board_data_api_1(ab, bd, ATH11K_DEFAULT_BOARD_FILE);
 	if (ret) {
 		ath11k_err(ab, "failed to fetch board-2.bin or board.bin from %s\n",
 			   ab->hw_params.fw.dir);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0103cfd0508d..bbf7ff1f9f48 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -957,6 +957,9 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 void ath11k_core_free(struct ath11k_base *ath11k);
 int ath11k_core_fetch_bdf(struct ath11k_base *ath11k,
 			  struct ath11k_board_data *bd);
+int ath11k_core_fetch_board_data_api_1(struct ath11k_base *ab,
+				       struct ath11k_board_data *bd,
+				       const char *name);
 void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
 int ath11k_core_check_dt(struct ath11k_base *ath11k);
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 2c9d232ebfed..5cc0c5b91973 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -77,6 +77,7 @@
 #define ATH11K_DEFAULT_CAL_FILE		"caldata.bin"
 #define ATH11K_AMSS_FILE		"amss.bin"
 #define ATH11K_M3_FILE			"m3.bin"
+#define ATH11K_REGDB_FILE_NAME		"regdb.bin"
 
 enum ath11k_hw_rate_cck {
 	ATH11K_HW_RATE_CCK_LP_11M = 0,
@@ -181,6 +182,7 @@ struct ath11k_hw_params {
 	bool supports_dynamic_smps_6ghz;
 	bool alloc_cacheable_memory;
 	bool wakeup_mhi;
+	bool supports_regdb;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 25eb22cbeaeb..311beeace9b7 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2115,7 +2115,8 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 	return ret;
 }
 
-static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
+static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab,
+				   bool regdb)
 {
 	struct device *dev = ab->dev;
 	char filename[ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE];
@@ -2126,13 +2127,25 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 	const u8 *tmp;
 
 	memset(&bd, 0, sizeof(bd));
-	ret = ath11k_core_fetch_bdf(ab, &bd);
+
+	if (regdb) {
+		ret = ath11k_core_fetch_board_data_api_1(ab, &bd,
+							 ATH11K_REGDB_FILE_NAME);
+		if (ret)
+			ath11k_dbg(ab, ATH11K_DBG_QMI, "failed to fetch %s from %s\n",
+				   ATH11K_REGDB_FILE_NAME, ab->hw_params.fw.dir);
+	} else {
+		ret = ath11k_core_fetch_bdf(ab, &bd);
+	}
+
 	if (ret) {
 		ath11k_warn(ab, "qmi failed to fetch board file: %d\n", ret);
 		goto out;
 	}
 
-	if (bd.len >= SELFMAG && memcmp(bd.data, ELFMAG, SELFMAG) == 0)
+	if (regdb)
+		bdf_type = ATH11K_QMI_BDF_TYPE_REGDB;
+	else if (bd.len >= SELFMAG && memcmp(bd.data, ELFMAG, SELFMAG) == 0)
 		bdf_type = ATH11K_QMI_BDF_TYPE_ELF;
 	else
 		bdf_type = ATH11K_QMI_BDF_TYPE_BIN;
@@ -2580,7 +2593,10 @@ static int ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 		return ret;
 	}
 
-	ret = ath11k_qmi_load_bdf_qmi(ab);
+	if (ab->hw_params.supports_regdb)
+		ath11k_qmi_load_bdf_qmi(ab, true);
+
+	ret = ath11k_qmi_load_bdf_qmi(ab, false);
 	if (ret < 0) {
 		ath11k_warn(ab, "failed to load board data file: %d\n", ret);
 		return ret;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 3bb0f9ef7996..9ba499ce3b78 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -49,6 +49,7 @@ enum ath11k_qmi_file_type {
 enum ath11k_qmi_bdf_type {
 	ATH11K_QMI_BDF_TYPE_BIN			= 0,
 	ATH11K_QMI_BDF_TYPE_ELF			= 1,
+	ATH11K_QMI_BDF_TYPE_REGDB		= 4,
 };
 
 enum ath11k_qmi_event_type {
-- 
2.31.1

