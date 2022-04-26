Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256F751012A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 16:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351824AbiDZO7I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Apr 2022 10:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351858AbiDZO66 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Apr 2022 10:58:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F8919293;
        Tue, 26 Apr 2022 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650984951; x=1682520951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v2LA6dbIM00i5LHfY48GOdkd+e9kfNvDBfsprYopumQ=;
  b=Y/JCNri+rdcQU8+NK7eIJ7Jl9RhYEnr65lYXNtjF0Fur/48dQ8SQcB4a
   l7nuL7dRjVXTORXaV5tbeN3gjhQ2A4K2MR9BNYcNxgEgEtLHTxrGM+Xrh
   EF1QROuVoTSeJZjoI72wB8N05YgKE6ixJvqizFcImXsr8dOBggiaA1EOL
   Y=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Apr 2022 07:55:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:55:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 07:55:50 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 07:55:47 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <mka@chromium.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v5 10/12] ath11k: WMI changes to support WCN6750
Date:   Tue, 26 Apr 2022 20:24:54 +0530
Message-ID: <20220426145456.8055-11-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426145456.8055-1-quic_mpubbise@quicinc.com>
References: <20220426145456.8055-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WCN6750 is a single PDEV non-DBS chip which supports 2G, 5G and 6G bands.
It is a single LMAC device which can be either hooked to 2G/5G/6G bands.
Add WMI changes to support WCN6750.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index d7243819d9bd..3c0ac1e29479 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -391,6 +391,10 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
 	ab->target_pdev_ids[ab->target_pdev_count].pdev_id = mac_phy_caps->pdev_id;
 	ab->target_pdev_count++;
 
+	if (!(mac_phy_caps->supported_bands & WMI_HOST_WLAN_2G_CAP) &&
+	    !(mac_phy_caps->supported_bands & WMI_HOST_WLAN_5G_CAP))
+		return -EINVAL;
+
 	/* Take non-zero tx/rx chainmask. If tx/rx chainmask differs from
 	 * band to band for a single radio, need to see how this should be
 	 * handled.
@@ -398,7 +402,9 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
 	if (mac_phy_caps->supported_bands & WMI_HOST_WLAN_2G_CAP) {
 		pdev_cap->tx_chain_mask = mac_phy_caps->tx_chain_mask_2g;
 		pdev_cap->rx_chain_mask = mac_phy_caps->rx_chain_mask_2g;
-	} else if (mac_phy_caps->supported_bands & WMI_HOST_WLAN_5G_CAP) {
+	}
+
+	if (mac_phy_caps->supported_bands & WMI_HOST_WLAN_5G_CAP) {
 		pdev_cap->vht_cap = mac_phy_caps->vht_cap_info_5g;
 		pdev_cap->vht_mcs = mac_phy_caps->vht_supp_mcs_5g;
 		pdev_cap->he_mcs = mac_phy_caps->he_supp_mcs_5g;
@@ -408,8 +414,6 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
 			WMI_NSS_RATIO_ENABLE_DISABLE_GET(mac_phy_caps->nss_ratio);
 		pdev_cap->nss_ratio_info =
 			WMI_NSS_RATIO_INFO_GET(mac_phy_caps->nss_ratio);
-	} else {
-		return -EINVAL;
 	}
 
 	/* tx/rx chainmask reported from fw depends on the actual hw chains used,
-- 
2.35.1

