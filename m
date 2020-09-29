Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07A327D440
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgI2RPx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 13:15:53 -0400
Received: from z5.mailgun.us ([104.130.96.5]:42360 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbgI2RPx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 13:15:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601399752; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=cicqSf6Z92fEZMCgnp+GEDvr6OgPKH0CAS2kkBx0jow=; b=ByFiwkeqCX7q+8rkGgrbi0ZS2z+6RiOQoW8pjEvxR/d9w6VTx1IJgfuBOcfXsScUn5jRjPQW
 Ix6oSfMCHHVxLHuH4rNycC2lZ9QiPnXa4KXlnc3mBCIs3dji/9dNKf1KXXjwoXNyaP938y25
 nGOkmG15i3YnHNNouqBTSeHrGs8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f736bc097ca3ed0fb9c7fe7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 17:15:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88CDFC433F1; Tue, 29 Sep 2020 17:15:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E058C433FF;
        Tue, 29 Sep 2020 17:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E058C433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/8] ath11k: fix AP mode for QCA6390
Date:   Tue, 29 Sep 2020 20:15:30 +0300
Message-Id: <1601399736-3210-3-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601399736-3210-1-git-send-email-kvalo@codeaurora.org>
References: <1601399736-3210-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For QCA6390, station vdev needs to delay startup but not for AP mode. On AP
mode vdev starts up immediately after bss peer is created in chanctx assignment
context.

This patch does not affect IPQ8074 family of devices.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 86a1b984859f..32cbe643f734 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2994,7 +2994,8 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 		goto free_tx_stats;
 	}
 
-	if (ab->hw_params.vdev_start_delay) {
+	if (ab->hw_params.vdev_start_delay &&
+	    arvif->vdev_type != WMI_VDEV_TYPE_AP) {
 		ret = ath11k_start_vdev_delay(ar->hw, vif);
 		if (ret) {
 			ath11k_warn(ab, "failed to delay vdev start: %d\n", ret);
@@ -5210,7 +5211,8 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		   ctx, arvif->vdev_id);
 
 	/* for QCA6390 bss peer must be created before vdev_start */
-	if (ab->hw_params.vdev_start_delay) {
+	if (ab->hw_params.vdev_start_delay &&
+	    arvif->vdev_type != WMI_VDEV_TYPE_AP) {
 		memcpy(&arvif->chanctx, ctx, sizeof(*ctx));
 		mutex_unlock(&ar->conf_mutex);
 		return 0;
-- 
2.7.4

