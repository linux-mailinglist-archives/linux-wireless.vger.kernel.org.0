Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD22948FCF7
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 13:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiAPMsL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 07:48:11 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:3360 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235181AbiAPMsK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 07:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642337290; x=1673873290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ZEcr5senfgLyK2SvOB4TxRZU925sThRM+jAVn6WT390=;
  b=Jcfz+dBrIotTEETeVBphaCfVmjIpq+DPucWf+HmWHxggP51uk7cvnPvX
   bqDMgE0Sw+wwsina98GDcqyG3EdfFNY7jNSO+zpi00F1AeU+TyeJgx25e
   82nnIc5EAAT44QyWFii50h7cMzOi3IbMYtMXTYhlZ2hBMlLk2vfc5IyhG
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Jan 2022 04:48:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 04:48:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 04:48:10 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 04:48:07 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 15/19] ath11k: WMI changes to support WCN6750
Date:   Sun, 16 Jan 2022 18:17:11 +0530
Message-ID: <1642337235-8618-16-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WCN6750 is a single PDEV non-DBS chip which supports 2G, 5G and 6G bands.
It is a single LMAC device which can be either hooked to 2G/5G/6G bands.
Add WMI changes to support WCN6750.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 0cc8957..ca7bb11 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -389,6 +389,10 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
 	ab->target_pdev_ids[ab->target_pdev_count].pdev_id = mac_phy_caps->pdev_id;
 	ab->target_pdev_count++;
 
+	if (!(mac_phy_caps->supported_bands & WMI_HOST_WLAN_2G_CAP) &&
+	    !(mac_phy_caps->supported_bands & WMI_HOST_WLAN_5G_CAP))
+		return -EINVAL;
+
 	/* Take non-zero tx/rx chainmask. If tx/rx chainmask differs from
 	 * band to band for a single radio, need to see how this should be
 	 * handled.
@@ -396,7 +400,9 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
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
@@ -406,8 +412,6 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
 			WMI_NSS_RATIO_ENABLE_DISABLE_GET(mac_phy_caps->nss_ratio);
 		pdev_cap->nss_ratio_info =
 			WMI_NSS_RATIO_INFO_GET(mac_phy_caps->nss_ratio);
-	} else {
-		return -EINVAL;
 	}
 
 	/* tx/rx chainmask reported from fw depends on the actual hw chains used,
-- 
2.7.4

