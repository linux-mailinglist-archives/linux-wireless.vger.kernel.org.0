Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF4A1FB33B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgFPOB3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:01:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45013 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbgFPOB1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:01:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592316085; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=omUXAbmcG7hko7bEjjh22MxAMPW6cqcvdemm6WXA+fg=; b=pBHfL6iroiWFxVfzl8FxpbAvGJpYscLGEnfpvFMXW9Mj3x3pYWHFOtlYMI+rf3/iyvImn+Q0
 PSyxDioYvDpnk7cCCrSh1OQHbI/LCR2QU1duVVIIv/Ji72ha/WZeBHXhgZ9+OOdjzDBkPuoA
 DLP0TxLxLcmfS5DJdF5KzhdyopM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5ee8d0aa5866879c76974f9a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 14:01:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 051DEC433CB; Tue, 16 Jun 2020 14:01:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 69BF4C433C8;
        Tue, 16 Jun 2020 14:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69BF4C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 06/12] ath11k: create a common function to request all firmware files
Date:   Tue, 16 Jun 2020 17:00:49 +0300
Message-Id: <1592316055-24958-7-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
References: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To avoid duplicating the logic how the full firmware path is created create a
common function ath11k_core_firmware_request() and convert also qmi.c to use it.

Also remove a useless info print, it's more like a debug message anyway.

No functional changes. Compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 27 +++++++++++++--------------
 drivers/net/wireless/ath/ath11k/core.h |  4 ++++
 drivers/net/wireless/ath/ath11k/qmi.c  | 12 ++++--------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 5232a355ac12..7e29977c23b4 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -48,9 +48,9 @@ static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 	return 0;
 }
 
-static const struct firmware *ath11k_fetch_fw_file(struct ath11k_base *ab,
-						   const char *dir,
-						   const char *file)
+const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
+						    const char *dir,
+						    const char *file)
 {
 	char filename[100];
 	const struct firmware *fw;
@@ -63,14 +63,13 @@ static const struct firmware *ath11k_fetch_fw_file(struct ath11k_base *ab,
 		dir = ".";
 
 	snprintf(filename, sizeof(filename), "%s/%s", dir, file);
-	ret = firmware_request_nowarn(&fw, filename, ab->dev);
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot fw request '%s': %d\n",
-		   filename, ret);
 
+	ret = firmware_request_nowarn(&fw, filename, ab->dev);
 	if (ret)
 		return ERR_PTR(ret);
-	ath11k_warn(ab, "Downloading BDF: %s, size: %zu\n",
-		    filename, fw->size);
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot firmware request %s size %zu\n",
+		   filename, fw->size);
 
 	return fw;
 }
@@ -176,9 +175,9 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 	int ret, ie_id;
 
 	if (!bd->fw)
-		bd->fw = ath11k_fetch_fw_file(ab,
-					      ab->hw_params.fw.dir,
-					      filename);
+		bd->fw = ath11k_core_firmware_request(ab,
+						      ab->hw_params.fw.dir,
+						      filename);
 	if (IS_ERR(bd->fw))
 		return PTR_ERR(bd->fw);
 
@@ -268,9 +267,9 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 static int ath11k_core_fetch_board_data_api_1(struct ath11k_base *ab,
 					      struct ath11k_board_data *bd)
 {
-	bd->fw = ath11k_fetch_fw_file(ab,
-				      ab->hw_params.fw.dir,
-				      ATH11K_DEFAULT_BOARD_FILE);
+	bd->fw = ath11k_core_firmware_request(ab,
+					      ab->hw_params.fw.dir,
+					      ATH11K_DEFAULT_BOARD_FILE);
 	if (IS_ERR(bd->fw))
 		return PTR_ERR(bd->fw);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 98de9c35e178..be1339a5ea0a 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -861,6 +861,10 @@ void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
 
 void ath11k_core_halt(struct ath11k *ar);
 
+const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
+						    const char *dir,
+						    const char *file);
+
 static inline const char *ath11k_scan_state_str(enum ath11k_scan_state state)
 {
 	switch (state) {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index e4198d3b0bae..0cd3fb8eeece 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1790,8 +1790,6 @@ ath11k_qmi_prepare_bdf_download(struct ath11k_base *ab, int type,
 				struct qmi_wlanfw_bdf_download_req_msg_v01 *req,
 				void __iomem *bdf_addr)
 {
-	struct device *dev = ab->dev;
-	char filename[ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE];
 	const struct firmware *fw_entry;
 	struct ath11k_board_data bd;
 	u32 fw_size;
@@ -1812,11 +1810,11 @@ ath11k_qmi_prepare_bdf_download(struct ath11k_base *ab, int type,
 		ath11k_core_free_bdf(ab, &bd);
 		break;
 	case ATH11K_QMI_FILE_TYPE_CALDATA:
-		snprintf(filename, sizeof(filename),
-			 "%s/%s", ab->hw_params.fw.dir, ATH11K_QMI_DEFAULT_CAL_FILE_NAME);
-		ret = request_firmware(&fw_entry, filename, dev);
+		fw_entry = ath11k_core_firmware_request(ab, ab->hw_params.fw.dir,
+							ATH11K_QMI_DEFAULT_CAL_FILE_NAME);
 		if (ret) {
-			ath11k_warn(ab, "qmi failed to load CAL: %s\n", filename);
+			ath11k_warn(ab, "failed to load %s: %d\n",
+				    ATH11K_QMI_DEFAULT_CAL_FILE_NAME, ret);
 			goto out;
 		}
 
@@ -1825,8 +1823,6 @@ ath11k_qmi_prepare_bdf_download(struct ath11k_base *ab, int type,
 
 		memcpy_toio(bdf_addr + ATH11K_QMI_CALDATA_OFFSET,
 			    fw_entry->data, fw_size);
-		ath11k_info(ab, "qmi downloading BDF: %s, size: %zu\n",
-			    filename, fw_entry->size);
 
 		release_firmware(fw_entry);
 		break;
-- 
2.7.4

