Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08BD24454C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 09:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgHNHLE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 03:11:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57192 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgHNHK6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 03:10:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597389057; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=tAf1WoFnokZphJV/CmBmP4ZxScedK9LMPjc/6T6UXHM=; b=SwHw6+kg98DJlyRffI4Xk4qV++TOXKA+UJTinoDxlew429RHRNJ21LwS7Si16n91gpdlBFn/
 85EhXLAMTiuEztg+zr0tWt4hhJPuW7v4he4AJE9Tao+DzPoCzchHKatd3ZEojR+ACc+gqDX2
 JziXNeib5V8xg7Q3iPSJsM/oNOo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5f3638f93f2ce110208a3aea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 07:10:49
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 34C5CC433C9; Fri, 14 Aug 2020 07:10:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B4B95C433CB;
        Fri, 14 Aug 2020 07:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4B95C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 10/11] ath11k: enable internal sleep clock
Date:   Fri, 14 Aug 2020 10:10:29 +0300
Message-Id: <1597389030-13887-11-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
References: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

On x86 and other non-qcom platforms, host needs to explicitly tell the firmware
to use the internal sleep clock. Some QCA6390 modules have OTP burnt with
external sleep clock selected, and these modules can't work expectedly unless
firmware selects internal sleep clock.

Add a field to hw_params to support this difference.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |  2 ++
 drivers/net/wireless/ath/ath11k/hw.h   |  2 ++
 drivers/net/wireless/ath/ath11k/qmi.c  | 17 +++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index a3a53debc24f..f1c07583836f 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -31,6 +31,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.bdf_addr = 0x4B0C0000,
 		.hw_ops = &ipq8074_ops,
 		.ring_mask = &ath11k_hw_ring_mask_ipq8074,
+		.internal_sleep_clock = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -44,6 +45,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.bdf_addr = 0x4B0C0000,
 		.hw_ops = &qca6390_ops,
 		.ring_mask = &ath11k_hw_ring_mask_ipq8074,
+		.internal_sleep_clock = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 5b443a212c85..aacd092dbddb 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -133,6 +133,8 @@ struct ath11k_hw_params {
 	const struct ath11k_hw_ops *hw_ops;
 
 	const struct ath11k_hw_ring_mask *ring_mask;
+
+	bool internal_sleep_clock;
 };
 
 extern const struct ath11k_hw_ops ipq8074_ops;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 12991a835b8b..b81897131f0a 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -9,6 +9,9 @@
 #include <linux/of.h>
 #include <linux/firmware.h>
 
+#define SLEEP_CLOCK_SELECT_INTERNAL_BIT	0x02
+#define HOST_CSTATE_BIT			0x04
+
 static struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_OPT_FLAG,
@@ -1531,6 +1534,20 @@ static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 	req.cal_done_valid = 1;
 	req.cal_done = ab->qmi.cal_done;
 
+	if (ab->hw_params.internal_sleep_clock) {
+		req.nm_modem_valid = 1;
+
+		/* Notify firmware that this is non-qualcomm platform. */
+		req.nm_modem |= HOST_CSTATE_BIT;
+
+		/* Notify firmware about the sleep clock selection,
+		 * nm_modem_bit[1] is used for this purpose. Host driver on
+		 * non-qualcomm platforms should select internal sleep
+		 * clock.
+		 */
+		req.nm_modem |= SLEEP_CLOCK_SELECT_INTERNAL_BIT;
+	}
+
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
 	if (ret < 0)
-- 
2.7.4

