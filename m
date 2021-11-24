Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A0045B7A3
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 10:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbhKXJqd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 04:46:33 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:42346 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbhKXJqb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 04:46:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637747002; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=gh2eGdVVS3Fhz9zyR93hdCvwmppUaxt3IIvamklUmqE=; b=aUv0E4au7R8Hl9I1wzq4pYZHT4NkMlgcbUadjRDZiHCy716fwryKYkNAej+8fZuvBmiN0bdL
 J5al5CXo+rE98wG157ANyRCDcySqt8KoxFlmOGkHjweTNBrVeflI4axKCUJqXiXHL6QCDBT4
 WNZkbn+Knj0M3y6dtOfLHS5nl9I=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 619e0939db3ac5552a9e0d64 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Nov 2021 09:43:21
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 958FFC43616; Wed, 24 Nov 2021 09:43:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 31569C4338F;
        Wed, 24 Nov 2021 09:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 31569C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] Revert "ath11k: add read variant from SMBIOS for download board data"
Date:   Wed, 24 Nov 2021 11:43:16 +0200
Message-Id: <20211124094316.9096-1-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 46e46db313a2bf3c48cac4eb8bdb613b762f301b. Mark reported
that it breaks QCA6390 hw2.0 on Dell XPS 13 9310:

[    5.537034] ath11k_pci 0000:72:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
[    5.537038] ath11k_pci 0000:72:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50 fw_build_id
[    5.537236] ath11k_pci 0000:72:00.0: failed to fetch board data for bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=DE_1901 from ath11k/QCA6390/hw2.0/board-2.bin
[    5.537255] ath11k_pci 0000:72:00.0: failed to fetch board-2.bin or board.bin from QCA6390/hw2.0
[    5.537257] ath11k_pci 0000:72:00.0: qmi failed to fetch board file: -2
[    5.537258] ath11k_pci 0000:72:00.0: failed to load board data file: -2

So we need to back to the drawing board and implement it so that backwards
compatiblity is not broken.

Reported-by: Mark Herbert <mark.herbert42@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 79 --------------------------
 drivers/net/wireless/ath/ath11k/core.h | 13 -----
 drivers/net/wireless/ath/ath11k/qmi.c  |  4 --
 3 files changed, 96 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index a3a9bfef0c38..dd1a1bb078c3 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -8,9 +8,6 @@
 #include <linux/remoteproc.h>
 #include <linux/firmware.h>
 #include <linux/of.h>
-#include <linux/dmi.h>
-#include <linux/ctype.h>
-
 #include "core.h"
 #include "dp_tx.h"
 #include "dp_rx.h"
@@ -387,82 +384,6 @@ int ath11k_core_resume(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_core_resume);
 
-static void ath11k_core_check_bdfext(const struct dmi_header *hdr, void *data)
-{
-	struct ath11k_base *ab = data;
-	const char *bdf_ext;
-	const char *magic = ATH11K_SMBIOS_BDF_EXT_MAGIC;
-	u8 bdf_enabled;
-	int i;
-	size_t len;
-
-	if (ab->qmi.target.bdf_ext[0] != '\0')
-		return;
-
-	if (hdr->type != ATH11K_SMBIOS_BDF_EXT_TYPE)
-		return;
-
-	if (hdr->length != ATH11K_SMBIOS_BDF_EXT_LENGTH) {
-		ath11k_dbg(ab, ATH11K_DBG_BOOT,
-			   "wrong smbios bdf ext type length (%d).\n",
-			   hdr->length);
-		return;
-	}
-
-	bdf_enabled = *((u8 *)hdr + ATH11K_SMBIOS_BDF_EXT_OFFSET);
-	if (!bdf_enabled) {
-		ath11k_dbg(ab, ATH11K_DBG_BOOT, "bdf variant name not found.\n");
-		return;
-	}
-
-	/* Only one string exists (per spec) */
-	bdf_ext = (char *)hdr + hdr->length;
-
-	if (memcmp(bdf_ext, magic, strlen(magic)) != 0) {
-		ath11k_dbg(ab, ATH11K_DBG_BOOT,
-			   "bdf variant magic does not match.\n");
-		return;
-	}
-
-	len = strlen(bdf_ext);
-	for (i = 0; i < len; i++) {
-		if (!isascii(bdf_ext[i]) || !isprint(bdf_ext[i])) {
-			ath11k_dbg(ab, ATH11K_DBG_BOOT,
-				   "bdf variant name contains non ascii chars.\n");
-			return;
-		}
-	}
-
-	/* Copy extension name without magic prefix */
-	if (strscpy(ab->qmi.target.bdf_ext, bdf_ext + strlen(magic),
-		    sizeof(ab->qmi.target.bdf_ext)) < 0) {
-		ath11k_dbg(ab, ATH11K_DBG_BOOT,
-			   "bdf variant string is longer than the buffer can accommodate (variant: %s)\n",
-			    bdf_ext);
-		return;
-	}
-
-	ath11k_dbg(ab, ATH11K_DBG_BOOT,
-		   "found and validated bdf variant smbios_type 0x%x bdf %s\n",
-		   ATH11K_SMBIOS_BDF_EXT_TYPE, bdf_ext);
-}
-
-int ath11k_core_check_smbios(struct ath11k_base *ab)
-{
-	int ret;
-
-	ab->qmi.target.bdf_ext[0] = '\0';
-
-	ret = dmi_walk(ath11k_core_check_bdfext, ab);
-	if (ret)
-		return ret;
-
-	if (ab->qmi.target.bdf_ext[0] == '\0')
-		return -ENODATA;
-
-	return 0;
-}
-
 int ath11k_core_check_dt(struct ath11k_base *ab)
 {
 	size_t max_len = sizeof(ab->qmi.target.bdf_ext);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 7b1770ae0e7c..0103cfd0508d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -938,18 +938,6 @@ struct ath11k_fw_stats_bcn {
 	u32 tx_bcn_outage_cnt;
 };
 
-/* SMBIOS type containing Board Data File Name Extension */
-#define ATH11K_SMBIOS_BDF_EXT_TYPE 0xF8
-
-/* SMBIOS type structure length (excluding strings-set) */
-#define ATH11K_SMBIOS_BDF_EXT_LENGTH 0x9
-
-/* Offset pointing to Board Data File Name Extension */
-#define ATH11K_SMBIOS_BDF_EXT_OFFSET 0x8
-
-/* The magic used by QCA spec */
-#define ATH11K_SMBIOS_BDF_EXT_MAGIC "BDF_"
-
 extern const struct ce_pipe_config ath11k_target_ce_config_wlan_ipq8074[];
 extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_ipq8074[];
 extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_ipq6018[];
@@ -971,7 +959,6 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ath11k,
 			  struct ath11k_board_data *bd);
 void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
 int ath11k_core_check_dt(struct ath11k_base *ath11k);
-int ath11k_core_check_smbios(struct ath11k_base *ab);
 
 void ath11k_core_halt(struct ath11k *ar);
 int ath11k_core_resume(struct ath11k_base *ab);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 700a9c137018..25eb22cbeaeb 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1991,10 +1991,6 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 		    ab->qmi.target.fw_build_timestamp,
 		    ab->qmi.target.fw_build_id);
 
-	r = ath11k_core_check_smbios(ab);
-	if (r)
-		ath11k_dbg(ab, ATH11K_DBG_QMI, "SMBIOS bdf variant name not set.\n");
-
 	r = ath11k_core_check_dt(ab);
 	if (r)
 		ath11k_dbg(ab, ATH11K_DBG_QMI, "DT bdf variant name not set.\n");

base-commit: e5118670f6edde897ab17c3467efd24ad334fe7b
-- 
2.20.1

