Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE63D17FB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 22:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhGUTjk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 15:39:40 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:15055 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhGUTjj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 15:39:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626898815; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zUf+qNoI5wXRIPUqFqapB0CxcB8l5/hPYDWvyfn9EB0=; b=AgJPIjSfnaVGE7qa/KxMhcRbP+B3GhZnlKWRqV1SpgMyr9uhXpU0lEJhyVb5XCHfPXSLBONs
 yJn5AHvQ7ZaGQqnrFSOYiZLZqA8TNsKbHRM5ysYUPwNPfl5SKYxFOcPWXpvp/rxGmSNlr52b
 ZVBbM/GF51AEn33UTdu2hxc1tDQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60f88171d0100c7cf9878bf3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 20:20:01
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D1F7EC433F1; Wed, 21 Jul 2021 20:20:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D9790C43217;
        Wed, 21 Jul 2021 20:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9790C43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/4] ath11k: add caldata file for multiple radios
Date:   Wed, 21 Jul 2021 23:19:26 +0300
Message-Id: <20210721201927.100369-4-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721201927.100369-1-jouni@codeaurora.org>
References: <20210721201927.100369-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

If multiple PCI cards are attached, each needs its own caldata file.

Added new Caldata file name,
PCI Bus:
        cal-pci-0001:01:00.0.bin
        cal-pci-0000:01:00.0.bin
AHB Bus:
	cal-ahb-c000000.wifi1.bin

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index a24a6647ba52..381ae70e45ff 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2027,6 +2027,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 
 static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 {
+	struct device *dev = ab->dev;
 	char filename[ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE];
 	const struct firmware *fw_entry;
 	struct ath11k_board_data bd;
@@ -2061,6 +2062,14 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 		goto out;
 
 	file_type = ATH11K_QMI_FILE_TYPE_CALDATA;
+
+	/* cal-<bus>-<id>.bin */
+	snprintf(filename, sizeof(filename), "cal-%s-%s.bin",
+		 ath11k_bus_str(ab->hif.bus), dev_name(dev));
+	fw_entry = ath11k_core_firmware_request(ab, filename);
+	if (!IS_ERR(fw_entry))
+		goto success;
+
 	fw_entry = ath11k_core_firmware_request(ab, ATH11K_DEFAULT_CAL_FILE);
 	if (IS_ERR(fw_entry)) {
 		ret = PTR_ERR(fw_entry);
@@ -2070,6 +2079,7 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 		goto out;
 	}
 
+success:
 	fw_size = min_t(u32, ab->hw_params.fw.board_size, fw_entry->size);
 	ret = ath11k_qmi_load_file_target_mem(ab, fw_entry->data, fw_size, file_type);
 	if (ret < 0) {
@@ -2077,8 +2087,7 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 		goto out_qmi_cal;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi caldata downloaded: type: %u\n",
-		   file_type);
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi caldata type: %u\n", file_type);
 
 out_qmi_cal:
 	release_firmware(fw_entry);
-- 
2.25.1

