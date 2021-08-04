Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFD53E074D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 20:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhHDSNI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 14:13:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14340 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhHDSNI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 14:13:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628100775; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3/DgNzMjlr5AhtAejF7QwvtDRT1kV61NpQRnue6gGxc=; b=bsQeoDLr41ou60+YWoBwdSKt65ksX/P9e2ihaTx46VQ6nQTj9c0Ako3/jRIBufFfTp7In/XY
 VMeXwfLYZdQWoLOUu3VwftD/97M54pnyUZdZrK2rIWvbWEppS3/aFCDeoTyy1d6Ulp/TJTHP
 3r5CBkaw4TLJ35Yf63vVDGyk/Ps=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 610ad8968c78eaf808e9d808 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Aug 2021 18:12:38
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 09783C4323A; Wed,  4 Aug 2021 18:12:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-77-199-nat.elisa-mobile.fi [85.76.77.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38F14C433D3;
        Wed,  4 Aug 2021 18:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38F14C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <wgong@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/3] ath11k: copy cap info of 6G band under WMI_HOST_WLAN_5G_CAP for WCN6855
Date:   Wed,  4 Aug 2021 21:12:17 +0300
Message-Id: <20210804181217.88751-4-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804181217.88751-1-jouni@codeaurora.org>
References: <20210804181217.88751-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

WCN6855 has 2 phys, one is 2G, another is 5G/6G, so it should copy the
cap info of 6G band under the check of WMI_HOST_WLAN_5G_CAP as well as
for the 5G band. Some chips like QCN9074 only have 6G, not have 2G and
5G, and this 6G capability is also under WMI_HOST_WLAN_5G_CAP, so this
change will not disturb it.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index e7429d17030b..ec46e06aace9 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -407,18 +407,18 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
 		       sizeof(u32) * PSOC_HOST_MAX_PHY_SIZE);
 		memcpy(&cap_band->he_ppet, &mac_phy_caps->he_ppet5g,
 		       sizeof(struct ath11k_ppe_threshold));
-	}
 
-	cap_band = &pdev_cap->band[NL80211_BAND_6GHZ];
-	cap_band->max_bw_supported = mac_phy_caps->max_bw_supported_5g;
-	cap_band->ht_cap_info = mac_phy_caps->ht_cap_info_5g;
-	cap_band->he_cap_info[0] = mac_phy_caps->he_cap_info_5g;
-	cap_band->he_cap_info[1] = mac_phy_caps->he_cap_info_5g_ext;
-	cap_band->he_mcs = mac_phy_caps->he_supp_mcs_5g;
-	memcpy(cap_band->he_cap_phy_info, &mac_phy_caps->he_cap_phy_info_5g,
-	       sizeof(u32) * PSOC_HOST_MAX_PHY_SIZE);
-	memcpy(&cap_band->he_ppet, &mac_phy_caps->he_ppet5g,
-	       sizeof(struct ath11k_ppe_threshold));
+		cap_band = &pdev_cap->band[NL80211_BAND_6GHZ];
+		cap_band->max_bw_supported = mac_phy_caps->max_bw_supported_5g;
+		cap_band->ht_cap_info = mac_phy_caps->ht_cap_info_5g;
+		cap_band->he_cap_info[0] = mac_phy_caps->he_cap_info_5g;
+		cap_band->he_cap_info[1] = mac_phy_caps->he_cap_info_5g_ext;
+		cap_band->he_mcs = mac_phy_caps->he_supp_mcs_5g;
+		memcpy(cap_band->he_cap_phy_info, &mac_phy_caps->he_cap_phy_info_5g,
+		       sizeof(u32) * PSOC_HOST_MAX_PHY_SIZE);
+		memcpy(&cap_band->he_ppet, &mac_phy_caps->he_ppet5g,
+		       sizeof(struct ath11k_ppe_threshold));
+	}
 
 	return 0;
 }
-- 
2.25.1

