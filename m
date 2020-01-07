Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1F5131FC2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2020 07:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgAGGXY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 01:23:24 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:13906 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbgAGGXX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 01:23:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578378203; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/5Cj4kGBRUTN/E1SEncRP8qPjJOV4btr6EY3RJAXrPE=; b=B073zNThg88rkch1IErlVPqKAm9JcC4w1YPjtv3W0Ybug7pGlz3J/V35jhOb4fdy/llJ2ztS
 B3kkngWb0Sz8Jyi9VlsTy+XY4yw4SlEM9yngeM07rppXDsY3doCXvkEAui1pNFqzNLsZNixu
 6p15N1+dPPMyi9hTlb8MCv9PBRA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1423d6.7f0161be7a78-smtp-out-n02;
 Tue, 07 Jan 2020 06:23:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 543C5C4479C; Tue,  7 Jan 2020 06:23:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from che-swdbs-01.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55525C43383;
        Tue,  7 Jan 2020 06:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55525C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Vikas Patel <vikpatel@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH] ath10k: avoid consecutive OTP download to reduce boot time
Date:   Tue,  7 Jan 2020 11:53:15 +0530
Message-Id: <1578378195-25780-1-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vikas Patel <vikpatel@codeaurora.org>

Currently, OTP is downloaded twice in case of "pre-cal-dt"
and "pre-cal-file" to fetch the board ID and takes around
~2 sec more boot uptime.

First OTP download happens in "ath10k_core_probe_fw" and
second in ath10k_core_start. First boot does not need OTP
download in core start when valid board id acquired.

The second OTP download is required upon core stop/start.

This patch skips the OTP download when first OTP download
has acquired a valid board id. This patch also marks board
id invalid in "ath10k_core_stop", which will force the OTP
download in ath10k_core_start and fetches valid board id.

Tested HW: QCA9984
Tested FW: 10.4-3.6-00104

Signed-off-by: Vikas Patel <vikpatel@codeaurora.org>
Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 5ec16ce..8fef991 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -874,6 +874,13 @@ static int ath10k_core_get_board_id_from_otp(struct ath10k *ar)
 		return -ENODATA;
 	}
 
+	if (ar->id.bmi_ids_valid) {
+		ath10k_dbg(ar, ATH10K_DBG_BOOT,
+			   "boot already acquired valid otp board id,skip download, board_id %d chip_id %d\n",
+			   ar->id.bmi_board_id, ar->id.bmi_chip_id);
+		goto skip_otp_download;
+	}
+
 	ath10k_dbg(ar, ATH10K_DBG_BOOT,
 		   "boot upload otp to 0x%x len %zd for board id\n",
 		   address, ar->normal_mode_fw.fw_file.otp_len);
@@ -921,6 +928,8 @@ static int ath10k_core_get_board_id_from_otp(struct ath10k *ar)
 	ar->id.bmi_board_id = board_id;
 	ar->id.bmi_chip_id = chip_id;
 
+skip_otp_download:
+
 	return 0;
 }
 
@@ -2863,6 +2872,8 @@ void ath10k_core_stop(struct ath10k *ar)
 	ath10k_htt_tx_stop(&ar->htt);
 	ath10k_htt_rx_free(&ar->htt);
 	ath10k_wmi_detach(ar);
+
+	ar->id.bmi_ids_valid = false;
 }
 EXPORT_SYMBOL(ath10k_core_stop);
 
-- 
1.9.1
