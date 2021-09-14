Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C9F40B509
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 18:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhINQjH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 12:39:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11370 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhINQjA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 12:39:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631637460; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=wIoJOvqF8dE6kwZEz+Y+D1Dd0q2DEPU/2+Tzin+CbL0=; b=scEJUovgfPzaK7tBTiow142m3o77XJoRmHZIdLLE4EYDySVeQw8TeMncd4iT3tGnBI8WxPDM
 9EiWhuVfwBUAmD9Uy0P5yytXBzEeYp7c5xme2GQbiuLJpbqBv5ZgCXxtxc1+dF9FdYhWgGzd
 JMEfpCMWwCyACdeGVTYhi4mj3B0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6140cfd3c1b30e2f02fd69a7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Sep 2021 16:37:39
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83957C4338F; Tue, 14 Sep 2021 16:37:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A46D4C43460;
        Tue, 14 Sep 2021 16:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A46D4C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <wgong@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/3] ath11k: set correct NL80211_FEATURE_DYNAMIC_SMPS for WCN6855
Date:   Tue, 14 Sep 2021 19:37:26 +0300
Message-Id: <20210914163726.38604-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914163726.38604-1-jouni@codeaurora.org>
References: <20210914163726.38604-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

Commit "ath11k: support SMPS configuration for 6 GHz" changed "if
(ht_cap & WMI_HT_CAP_DYNAMIC_SMPS)" to "if (ht_cap &
WMI_HT_CAP_DYNAMIC_SMPS || ar->supports_6ghz)" which means
NL80211_FEATURE_DYNAMIC_SMPS is enabled for all chips which support 6
GHz. However, WCN6855 supports 6 GHz but it does not support feature
NL80211_FEATURE_DYNAMIC_SMPS, and this can lead to MU-MIMO test failures
for WCN6855.

Disable NL80211_FEATURE_DYNAMIC_SMPS for WCN6855 since its ht_cap does
not support WMI_HT_CAP_DYNAMIC_SMPS.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 1 +
 drivers/net/wireless/ath/ath11k/hw.h   | 1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 265ff225bd81..2bae8c5184d4 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -279,6 +279,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.sram_dump = &sram_dump_wcn6855,
 		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
 		.hal_params = &ath11k_hal_params_qca6390,
+		.check_dynamic_smps = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index c6831fb110ba..7463b96770b7 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -180,6 +180,7 @@ struct ath11k_hw_params {
 	const struct ath11k_hw_sram_dump *sram_dump;
 	u8 max_tx_ring;
 	const struct hal_param *hal_params;
+	bool check_dynamic_smps;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1f4765e43546..97a2c92b7b9b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7570,7 +7570,8 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	 * for each band for a dual band capable radio. It will be tricky to
 	 * handle it when the ht capability different for each band.
 	 */
-	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS || ar->supports_6ghz)
+	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS ||
+	    (ar->supports_6ghz && !ab->hw_params.check_dynamic_smps))
 		ar->hw->wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
 
 	ar->hw->wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;
-- 
2.25.1

