Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6992E27FC87
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 11:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbgJAJfF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 05:35:05 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:52198 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731782AbgJAJfD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 05:35:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601544903; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=mlQ37xHUY1o75ushLy3ApNni9A0rmocxc8ZIJ66VmF0=; b=NAF26Ecug6BHkJJ2fYW0ioUYnzgkb4cVxcO4Ga70X2J+W8wGlcBDJSXtMPeZ2X9tHnFV+slR
 TWNMLbUA3wCr78brRYmt9O2985+5pGTkrZeAlWNHfq2Ozh6zyHLnxy0gLYXGSER8yIyo2RfF
 AqdoMlOcxQCqB9pw+sBapxUuvA0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f75a2c6213a72d9e547baf4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 09:35:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D3CD0C43382; Thu,  1 Oct 2020 09:35:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0BC07C433CB;
        Thu,  1 Oct 2020 09:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BC07C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/8] ath11k: start a timer to update REO cmd ring
Date:   Thu,  1 Oct 2020 12:34:47 +0300
Message-Id: <1601544890-13450-6-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
References: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Start a timer to update REO HP if HP isn't updated to target.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.c     | 6 ++++++
 drivers/net/wireless/ath/ath11k/dp.h     | 2 ++
 drivers/net/wireless/ath/ath11k/hal_rx.c | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 868bfa00c8b1..59dd185a0cfc 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -313,6 +313,8 @@ static void ath11k_dp_stop_shadow_timers(struct ath11k_base *ab)
 
 	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++)
 		ath11k_dp_shadow_stop_timer(ab, &ab->dp.tx_ring_timer[i]);
+
+	ath11k_dp_shadow_stop_timer(ab, &ab->dp.reo_cmd_timer);
 }
 
 static void ath11k_dp_srng_common_cleanup(struct ath11k_base *ab)
@@ -425,6 +427,10 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 	srng = &ab->hal.srng_list[dp->reo_cmd_ring.ring_id];
 	ath11k_hal_reo_init_cmd_ring(ab, srng);
 
+	ath11k_dp_shadow_init_timer(ab, &dp->reo_cmd_timer,
+				    ATH11K_SHADOW_CTRL_TIMER_INTERVAL,
+				    dp->reo_cmd_ring.ring_id);
+
 	ret = ath11k_dp_srng_setup(ab, &dp->reo_status_ring, HAL_REO_STATUS,
 				   0, 0, DP_REO_STATUS_RING_SIZE);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 43fa229ccccd..ee8db812589b 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -207,6 +207,7 @@ struct ath11k_pdev_dp {
 #define DP_TX_DESC_ID_POOL_ID GENMASK(20, 19)
 
 #define ATH11K_SHADOW_DP_TIMER_INTERVAL 20
+#define ATH11K_SHADOW_CTRL_TIMER_INTERVAL 10
 
 struct ath11k_hp_update_timer {
 	struct timer_list timer;
@@ -248,6 +249,7 @@ struct ath11k_dp {
 	 * - reo_cmd_cache_flush_count
 	 */
 	spinlock_t reo_cmd_lock;
+	struct ath11k_hp_update_timer reo_cmd_timer;
 	struct ath11k_hp_update_timer tx_ring_timer[DP_TCL_NUM_RING_MAX];
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index b0d6ece145be..fac2396edf32 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -256,6 +256,8 @@ int ath11k_hal_reo_cmd_send(struct ath11k_base *ab, struct hal_srng *srng,
 		break;
 	}
 
+	ath11k_dp_shadow_start_timer(ab, srng, &ab->dp.reo_cmd_timer);
+
 out:
 	ath11k_hal_srng_access_end(ab, srng);
 	spin_unlock_bh(&srng->lock);
-- 
2.7.4

