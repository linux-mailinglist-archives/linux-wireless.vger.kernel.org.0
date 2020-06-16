Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC61FB33D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgFPOBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:01:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23983 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbgFPOBa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:01:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592316088; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=nl3kHGzlEvXmI27GJhLh3trjy9hfmJOJqFLV+1Rs4Wg=; b=vugPSBEv3PFMnK5ldf2d2oUjb3xwvTBLvRKi2oVptpMiEpaOaWk5tBmLTHIZH2qGFGhNKg84
 +iLlCmEIQu9JL+Nvn49M5/SSHUAzBgHE9bF8wCIcawuZOsOHqTCiAkan5xSHFl87z5vCCtWm
 ccB/8TUf0Wax/mHY6qHZh8f/DHU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ee8d0ab6bebe35deb8ef3b1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 14:01:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BF648C43395; Tue, 16 Jun 2020 14:01:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D3C0C4339C;
        Tue, 16 Jun 2020 14:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D3C0C4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 07/12] ath11k: don't use defines for hw specific firmware directories
Date:   Tue, 16 Jun 2020 17:00:50 +0300
Message-Id: <1592316055-24958-8-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
References: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The downside of using defines in struct ath11k_hw_params.fw.dir is that it's
easy to get it wrong as the full path is not visible. So drop the use of
defines and instead create the patch runtime using a static inline function
ath11k_core_create_firmware_path(). Hopefully this reduces the chances of using
incorrect firmware path.

No functional changes. Compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 23 ++++++++---------------
 drivers/net/wireless/ath/ath11k/core.h | 11 +++++++++--
 drivers/net/wireless/ath/ath11k/hw.h   |  1 -
 drivers/net/wireless/ath/ath11k/qmi.c  |  2 +-
 4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 7e29977c23b4..de5b1d20771a 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -22,7 +22,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hw_rev = ATH11K_HW_IPQ8074,
 		.name = "ipq8074 hw2.0",
 		.fw = {
-			.dir = IPQ8074_FW_DIR,
+			.dir = "IPQ8074/hw2.0",
 			.board_size = IPQ8074_MAX_BOARD_DATA_SZ,
 			.cal_size =  IPQ8074_MAX_CAL_DATA_SZ,
 		},
@@ -49,27 +49,23 @@ static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 }
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
-						    const char *dir,
 						    const char *file)
 {
-	char filename[100];
 	const struct firmware *fw;
+	char path[100];
 	int ret;
 
 	if (file == NULL)
 		return ERR_PTR(-ENOENT);
 
-	if (dir == NULL)
-		dir = ".";
+	ath11k_core_create_firmware_path(ab, file, path, sizeof(path));
 
-	snprintf(filename, sizeof(filename), "%s/%s", dir, file);
-
-	ret = firmware_request_nowarn(&fw, filename, ab->dev);
+	ret = firmware_request_nowarn(&fw, path, ab->dev);
 	if (ret)
 		return ERR_PTR(ret);
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot firmware request %s size %zu\n",
-		   filename, fw->size);
+		   path, fw->size);
 
 	return fw;
 }
@@ -175,9 +171,8 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 	int ret, ie_id;
 
 	if (!bd->fw)
-		bd->fw = ath11k_core_firmware_request(ab,
-						      ab->hw_params.fw.dir,
-						      filename);
+		bd->fw = ath11k_core_firmware_request(ab, filename);
+
 	if (IS_ERR(bd->fw))
 		return PTR_ERR(bd->fw);
 
@@ -267,9 +262,7 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 static int ath11k_core_fetch_board_data_api_1(struct ath11k_base *ab,
 					      struct ath11k_board_data *bd)
 {
-	bd->fw = ath11k_core_firmware_request(ab,
-					      ab->hw_params.fw.dir,
-					      ATH11K_DEFAULT_BOARD_FILE);
+	bd->fw = ath11k_core_firmware_request(ab, ATH11K_DEFAULT_BOARD_FILE);
 	if (IS_ERR(bd->fw))
 		return PTR_ERR(bd->fw);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index be1339a5ea0a..b6ccd9f93853 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -862,8 +862,7 @@ void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
 void ath11k_core_halt(struct ath11k *ar);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
-						    const char *dir,
-						    const char *file);
+						    const char *filename);
 
 static inline const char *ath11k_scan_state_str(enum ath11k_scan_state state)
 {
@@ -897,4 +896,12 @@ static inline struct ath11k_vif *ath11k_vif_to_arvif(struct ieee80211_vif *vif)
 	return (struct ath11k_vif *)vif->drv_priv;
 }
 
+static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
+						    const char *filename,
+						    void *buf, size_t buf_len)
+{
+	snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
+		 ab->hw_params.fw.dir, filename);
+}
+
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 78518e3f773d..828c8c076218 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -69,7 +69,6 @@
 #define ATH11K_FW_DIR			"ath11k"
 
 /* IPQ8074 definitions */
-#define IPQ8074_FW_DIR			ATH11K_FW_DIR "/IPQ8074/hw2.0"
 #define IPQ8074_MAX_BOARD_DATA_SZ	(256 * 1024)
 #define IPQ8074_MAX_CAL_DATA_SZ		IPQ8074_MAX_BOARD_DATA_SZ
 
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 0cd3fb8eeece..d9ffdf84ccae 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1810,7 +1810,7 @@ ath11k_qmi_prepare_bdf_download(struct ath11k_base *ab, int type,
 		ath11k_core_free_bdf(ab, &bd);
 		break;
 	case ATH11K_QMI_FILE_TYPE_CALDATA:
-		fw_entry = ath11k_core_firmware_request(ab, ab->hw_params.fw.dir,
+		fw_entry = ath11k_core_firmware_request(ab,
 							ATH11K_QMI_DEFAULT_CAL_FILE_NAME);
 		if (ret) {
 			ath11k_warn(ab, "failed to load %s: %d\n",
-- 
2.7.4

