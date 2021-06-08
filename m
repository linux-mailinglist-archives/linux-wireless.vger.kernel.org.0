Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B27039F9F7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhFHPKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 11:10:04 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21708 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhFHPKD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 11:10:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623164890; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=LdH9dMt351k7jR/jOuZZM3Ht82yzzZWUmQdPkXHvpFY=; b=PhGIGDhZe9ddbMPeNhg6aLBA8RcknBVgTVCb8obS3+tUAZlJy+uNaMim0F5U4Mg4k1bVtSDg
 O12yXMUJubHXnekRYDOSVdtjQpoFTz3dtKAKILTij1kNMK1HWsdZKiy05s205AzUVFMFBdnY
 5Rh2syS3myKQ+oP3DqjUSga0kcs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60bf87caed59bf69cca9fa6f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Jun 2021 15:07:54
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EFF54C433F1; Tue,  8 Jun 2021 15:07:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2205FC4338A;
        Tue,  8 Jun 2021 15:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2205FC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH v4 3/3] ath11k: Add support for beacon tx mode
Date:   Tue,  8 Jun 2021 20:37:35 +0530
Message-Id: <1623164855-15910-4-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623164855-15910-1-git-send-email-mkenna@codeaurora.org>
References: <1623164855-15910-1-git-send-email-mkenna@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to configure the beacon tx mode in
the driver.

Beacons can be sent out in burst(continuously in a single shot
one after another) or staggered (equally spread out over beacon
interval) mode.

Use the below configuration in the hostapd/wpa_supplicant
for AP/MESH mode to configure the beacon tx mode.

"beacon_tx_mode=N", where N = 1 for STAGGERED beacon mode
and N = 2 for BURST beacon mode.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00480-QCAHKSWPL_SILICONZ-1

Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9d0ff15..dfc8644 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2130,7 +2130,10 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_BEACON) {
 		param_id = WMI_PDEV_PARAM_BEACON_TX_MODE;
-		param_value = WMI_BEACON_STAGGERED_MODE;
+		if (info->beacon_tx_mode == NL80211_BEACON_BURST_MODE)
+			param_value = WMI_BEACON_BURST_MODE;
+		else
+			param_value = WMI_BEACON_STAGGERED_MODE;
 		ret = ath11k_wmi_pdev_set_param(ar, param_id,
 						param_value, ar->pdev->pdev_id);
 		if (ret)
@@ -2138,8 +2141,9 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 				    arvif->vdev_id);
 		else
 			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-				   "Set staggered beacon mode for VDEV: %d\n",
-				   arvif->vdev_id);
+				   "Set %s beacon mode for VDEV: %d mode: %d\n",
+				   param_value ? "burst" : "staggered",
+				   arvif->vdev_id, param_value);
 
 		ret = ath11k_mac_setup_bcn_tmpl(arvif);
 		if (ret)
-- 
2.7.4

