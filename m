Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A781F26A089
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Sep 2020 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgIOIUL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Sep 2020 04:20:11 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:52259 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726273AbgIOITm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Sep 2020 04:19:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600157981; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=UIUW1dHR5cml3n2LMnUXM45+Y7HjtAfi1SOtnIzY24w=; b=UqhUxWwb3lc4JvoHeWgD6PK3qLqfj1SB8kt7wiKHjNMYWxJBH5xGQjGO9zxZodFS/n8H9aYT
 eZ4zXjHjdo3sNcvJd6s7S6yKH1qekELNleQv2+zxg7z1aOZJr2unIc+5zvI4xZIx29EO6Auf
 hjjAlhu2iVZq6whtlzMSwdxC9Io=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f60790725e1ee75863f302a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 08:19:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B00FEC433F0; Tue, 15 Sep 2020 08:19:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9A7EC433CA;
        Tue, 15 Sep 2020 08:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9A7EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH v2] ath10k: Use bdf calibration variant for snoc targets
Date:   Tue, 15 Sep 2020 13:49:08 +0530
Message-Id: <1600157948-2042-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Board Data File (BDF) is loaded upon driver boot-up procedure.
The right board data file is identified using bus and qmi-board-id.

The problem, however, can occur when the (default) board data
file cannot fulfill with the vendor requirements and it is
necessary to use a different board data file.

Also using the chip_id for identifying the board data helps
in dealing with different variants of the board data file based
on the RF card. If the chip_id is not programmed, a default value
of 0xff will be used for parsing the board data file.

Add the support to get the variant field from DTSI and
use this information along with the chip_id to load the vendor
specific BDF.

The device tree requires addition strings to define the variant name

    wifi@a000000 {
            status = "okay";
            qcom,ath10k-calibration-variant = "xyz-v2";
    };

    wifi@a800000 {
            status = "okay";
            qcom,ath10k-calibration-variant = "xyz-v1";
    };

This would create the boarddata identifiers for the board-2.bin search

 *  bus=snoc,qmi-board-id=16,qmi-chip-id=0,variant=xyz-v1
 *  bus=snoc,qmi-board-id=17,qmi-chip-id=0,variant=xyz-v2

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
Changes from v1:
- Updated the commit text to add details about chip_id used for
  loading bdf.

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 18 +++++++++++++-----
 drivers/net/wireless/ath/ath10k/core.h |  2 ++
 drivers/net/wireless/ath/ath10k/qmi.c  |  8 ++++++++
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 5f4e121..d73ad60 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1022,7 +1022,7 @@ static int ath10k_core_check_smbios(struct ath10k *ar)
 	return 0;
 }
 
-static int ath10k_core_check_dt(struct ath10k *ar)
+int ath10k_core_check_dt(struct ath10k *ar)
 {
 	struct device_node *node;
 	const char *variant = NULL;
@@ -1043,6 +1043,7 @@ static int ath10k_core_check_dt(struct ath10k *ar)
 
 	return 0;
 }
+EXPORT_SYMBOL(ath10k_core_check_dt);
 
 static int ath10k_download_fw(struct ath10k *ar)
 {
@@ -1437,10 +1438,17 @@ static int ath10k_core_create_board_name(struct ath10k *ar, char *name,
 	}
 
 	if (ar->id.qmi_ids_valid) {
-		scnprintf(name, name_len,
-			  "bus=%s,qmi-board-id=%x",
-			  ath10k_bus_str(ar->hif.bus),
-			  ar->id.qmi_board_id);
+		if (with_variant && ar->id.bdf_ext[0] != '\0')
+			scnprintf(name, name_len,
+				  "bus=%s,qmi-board-id=%x,qmi-chip-id=%x%s",
+				  ath10k_bus_str(ar->hif.bus),
+				  ar->id.qmi_board_id, ar->id.qmi_chip_id,
+				  variant);
+		else
+			scnprintf(name, name_len,
+				  "bus=%s,qmi-board-id=%x",
+				  ath10k_bus_str(ar->hif.bus),
+				  ar->id.qmi_board_id);
 		goto out;
 	}
 
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 4cf5bd4..b50ab9e 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -1076,6 +1076,7 @@ struct ath10k {
 		bool bmi_ids_valid;
 		bool qmi_ids_valid;
 		u32 qmi_board_id;
+		u32 qmi_chip_id;
 		u8 bmi_board_id;
 		u8 bmi_eboard_id;
 		u8 bmi_chip_id;
@@ -1315,6 +1316,7 @@ int ath10k_core_register(struct ath10k *ar,
 			 const struct ath10k_bus_params *bus_params);
 void ath10k_core_unregister(struct ath10k *ar);
 int ath10k_core_fetch_board_file(struct ath10k *ar, int bd_ie_type);
+int ath10k_core_check_dt(struct ath10k *ar);
 void ath10k_core_free_board_files(struct ath10k *ar);
 
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 5468a41..ae6b1f4 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -576,6 +576,8 @@ static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
 	if (resp->chip_info_valid) {
 		qmi->chip_info.chip_id = resp->chip_info.chip_id;
 		qmi->chip_info.chip_family = resp->chip_info.chip_family;
+	} else {
+		qmi->chip_info.chip_id = 0xFF;
 	}
 
 	if (resp->board_info_valid)
@@ -817,12 +819,18 @@ static void ath10k_qmi_event_server_arrive(struct ath10k_qmi *qmi)
 static int ath10k_qmi_fetch_board_file(struct ath10k_qmi *qmi)
 {
 	struct ath10k *ar = qmi->ar;
+	int ret;
 
 	ar->hif.bus = ATH10K_BUS_SNOC;
 	ar->id.qmi_ids_valid = true;
 	ar->id.qmi_board_id = qmi->board_info.board_id;
+	ar->id.qmi_chip_id = qmi->chip_info.chip_id;
 	ar->hw_params.fw.dir = WCN3990_HW_1_0_FW_DIR;
 
+	ret = ath10k_core_check_dt(ar);
+	if (ret)
+		ath10k_dbg(ar, ATH10K_DBG_QMI, "DT bdf variant name not set.\n");
+
 	return ath10k_core_fetch_board_file(qmi->ar, ATH10K_BD_IE_BOARD);
 }
 
-- 
2.7.4

