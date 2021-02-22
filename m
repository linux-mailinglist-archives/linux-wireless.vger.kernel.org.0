Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EF6321B22
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 16:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhBVPRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 10:17:02 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:35793 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhBVPPM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 10:15:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614006885; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MSV/THMzoBnQi6LSC3Z/xQNg2Rkhgq33GnztMeXgZEc=; b=mKaDShiEb4PI78q4RSfXomcbkiW/mncU3U3HjX4cPCjnVqimc3z34Gp44WFCSYRyiiz+44BN
 W8dUYOI8tA1HQ046wsOBdFKy0G2qd1H3tqCdsV0303t8A/T1wS75kZ1x1lAX73FbU56KeWll
 NkdiU7BpAXDJQVbL1+SL2gtzpTg=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6033ca463bd0a42cc9a32491 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 15:14:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F289C43462; Mon, 22 Feb 2021 15:14:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1020DC43461;
        Mon, 22 Feb 2021 15:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1020DC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 5.12] ath11k: fix AP mode for QCA6390
Date:   Mon, 22 Feb 2021 17:14:09 +0200
Message-Id: <1614006849-25764-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit c134d1f8c436 ("ath11k: Handle errors if peer creation fails") completely
broke AP mode on QCA6390:

kernel: [  151.230734] ath11k_pci 0000:06:00.0: failed to create peer after vdev start delay: -22
wpa_supplicant[2307]: Failed to set beacon parameters
wpa_supplicant[2307]: Interface initialization failed
wpa_supplicant[2307]: wlan0: interface state UNINITIALIZED->DISABLED
wpa_supplicant[2307]: wlan0: AP-DISABLED
wpa_supplicant[2307]: wlan0: Unable to setup interface.
wpa_supplicant[2307]: Failed to initialize AP interface

This was because commit c134d1f8c436 ("ath11k: Handle errors if peer creation
fails") added error handling for ath11k_peer_create(), which had been failing
all along but was unnoticed due to the missing error handling. The actual bug
was introduced already in commit aa44b2f3ecd4 ("ath11k: start vdev if a bss peer is
already created").

ath11k_peer_create() was failing because for AP mode the peer is created
already earlier op_add_interface() and we should skip creation here, but the
check for modes was wrong.  Fixing that makes AP mode work again.

This shouldn't affect IPQ8074 nor QCN9074 as they have hw_params.vdev_start_delay disabled.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Fixes: c134d1f8c436 ("ath11k: Handle errors if peer creation fails")
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 335d49af7dd5..76f3343183fe 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5450,8 +5450,8 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	}
 
 	if (ab->hw_params.vdev_start_delay &&
-	    (arvif->vdev_type == WMI_VDEV_TYPE_AP ||
-	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR)) {
+	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&
+	    arvif->vdev_type != WMI_VDEV_TYPE_MONITOR) {
 		param.vdev_id = arvif->vdev_id;
 		param.peer_type = WMI_PEER_TYPE_DEFAULT;
 		param.peer_addr = ar->mac_addr;
-- 
2.7.4

