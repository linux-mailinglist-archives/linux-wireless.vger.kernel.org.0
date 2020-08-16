Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB324575C
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgHPLbp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 07:31:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:47928 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729020AbgHPLaA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 07:30:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597577381; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=1u+DQGe2pb1MfVt3DFmkllplevgch3b8U72VlMBF1Tg=; b=QO/If3+CA18v20Twoz1JdQz1WQq4VzlYBbIG11BiNap+5PvF0vmX/fhJ+5K8xyZmLRh/tHFy
 BU1BP1fEsXjgSAgFbn9bgjiIVUjmuij4IBKswmXaYc8rdSmi86PjthvGUYen/tcU4g/cQBNg
 2fJp2dl+L+qW5QJ68ZZ1VAt/I7I=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f3915ac2f4952907db1a6b0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 11:17:00
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D457AC433CA; Sun, 16 Aug 2020 11:16:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14F47C433C6;
        Sun, 16 Aug 2020 11:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14F47C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 11/12] ath11k: wmi: put hardware to DBS mode
Date:   Sun, 16 Aug 2020 14:16:38 +0300
Message-Id: <1597576599-8857-12-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
References: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For QCA6390, host puts hardware to Dual Band Simultaneous (DBS) mode by default
so both 2G and 5G bands can be used. Otherwise only the 5G band can be used.
QCA6390 doesn't provide band_to_mac configuration and firmware will do the
band_to_mac map.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |  2 ++
 drivers/net/wireless/ath/ath11k/hw.h   |  6 ++++++
 drivers/net/wireless/ath/ath11k/wmi.c  | 10 +++++-----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 62fac8bbf221..b94630822d1e 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -36,6 +36,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.host_ce_config = ath11k_host_ce_config_ipq8074,
 		.ce_count = 12,
 		.single_pdev_only = false,
+		.needs_band_to_mac = true,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -54,6 +55,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.host_ce_config = ath11k_host_ce_config_qca6390,
 		.ce_count = 9,
 		.single_pdev_only = true,
+		.needs_band_to_mac = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 4651aed2eaf0..8db9534b176b 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -145,6 +145,12 @@ struct ath11k_hw_params {
 	u32 ce_count;
 
 	bool single_pdev_only;
+
+	/* For example on QCA6390 struct
+	 * wmi_init_cmd_param::band_to_mac_config needs to be false as the
+	 * firmware creates the mapping.
+	 */
+	bool needs_band_to_mac;
 };
 
 extern const struct ath11k_hw_ops ipq8074_ops;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 21f9070a1300..4e100407fea6 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -3396,13 +3396,13 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 	init_param.hw_mode_id = wmi_sc->preferred_hw_mode;
 	init_param.mem_chunks = wmi_sc->mem_chunks;
 
-	if (wmi_sc->preferred_hw_mode == WMI_HOST_HW_MODE_SINGLE ||
-	    ab->hw_params.single_pdev_only)
+	if (wmi_sc->preferred_hw_mode == WMI_HOST_HW_MODE_SINGLE)
 		init_param.hw_mode_id = WMI_HOST_HW_MODE_MAX;
 
-	init_param.num_band_to_mac = ab->num_radios;
-
-	ath11k_fill_band_to_mac_param(ab, init_param.band_to_mac);
+	if (ab->hw_params.needs_band_to_mac) {
+		init_param.num_band_to_mac = ab->num_radios;
+		ath11k_fill_band_to_mac_param(ab, init_param.band_to_mac);
+	}
 
 	return ath11k_init_cmd_send(&wmi_sc->wmi[0], &init_param);
 }
-- 
2.7.4

