Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3680D428C23
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 13:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhJKLjg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 07:39:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39247 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233975AbhJKLjf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 07:39:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633952255; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=E0yPcG9FmEudpWKWHwpyoEds6JGnlNM7F5gZRlhnjPI=; b=DE+04bi2aP1jZnXrPh6tnT0GvJzU8EctPCcCXT+juD3d/wxNxyMcgfNCsD7AC3yvqbMIsmdE
 gQyIYiZZIzbRRA6wUP+JcGG3eahMVKVdBxS6o0VwJ83HgjBjkmUCHdvrh0S9oPTV8f0UX7RR
 3eKINSSmFdk1eSvtRqWmQk4p8u8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 616421faab9da96e6466edcf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 11:37:30
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C20D9C4360C; Mon, 11 Oct 2021 11:37:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F5B2C4338F;
        Mon, 11 Oct 2021 11:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7F5B2C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/6] ath11k: purge rx pktlog when entering WoW
Date:   Mon, 11 Oct 2021 15:37:48 -0400
Message-Id: <20211011193750.4891-5-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211011193750.4891-1-cjhuang@codeaurora.org>
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This change is to purge rx pktlog when entering WoW and reap
the mon_status buffer to keep it empty. When leaving WoW, host
restarts the reap timer. In WoW state, it's not allowed to feed
into mon_status rings per firmware request.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c  |  7 +------
 drivers/net/wireless/ath/ath11k/dp_rx.c |  4 +---
 drivers/net/wireless/ath/ath11k/dp_rx.h |  2 +-
 drivers/net/wireless/ath/ath11k/wow.c   | 19 +++++++++++++++++++
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index e67136b..9747659 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -327,12 +327,7 @@ int ath11k_core_resume(struct ath11k_base *ab)
 	ath11k_hif_ce_irq_enable(ab);
 	ath11k_hif_irq_enable(ab);
 
-	ret = ath11k_dp_rx_pktlog_start(ab);
-	if (ret) {
-		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",
-			    ret);
-		return ret;
-	}
+	ath11k_dp_rx_pktlog_start(ab);
 
 	ret = ath11k_wow_wakeup(ab);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 6d769ba..ae6db5d 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5105,13 +5105,11 @@ int ath11k_dp_rx_pdev_mon_detach(struct ath11k *ar)
 	return 0;
 }
 
-int ath11k_dp_rx_pktlog_start(struct ath11k_base *ab)
+void ath11k_dp_rx_pktlog_start(struct ath11k_base *ab)
 {
 	/* start reap timer */
 	mod_timer(&ab->mon_reap_timer,
 		  jiffies + msecs_to_jiffies(ATH11K_MON_TIMER_INTERVAL));
-
-	return 0;
 }
 
 int ath11k_dp_rx_pktlog_stop(struct ath11k_base *ab, bool stop_timer)
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
index 623da3b..2e63f2f 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.h
@@ -92,7 +92,7 @@ int ath11k_dp_rx_pdev_mon_detach(struct ath11k *ar);
 int ath11k_dp_rx_pdev_mon_attach(struct ath11k *ar);
 int ath11k_peer_rx_frag_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id);
 
-int ath11k_dp_rx_pktlog_start(struct ath11k_base *ab);
+void ath11k_dp_rx_pktlog_start(struct ath11k_base *ab);
 int ath11k_dp_rx_pktlog_stop(struct ath11k_base *ab, bool stop_timer);
 
 #endif /* ATH11K_DP_RX_H */
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index 35f1c5c..8bd2ca2 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -13,6 +13,7 @@
 #include "debug.h"
 #include "wmi.h"
 #include "wow.h"
+#include "dp_rx.h"
 
 static const struct wiphy_wowlan_support ath11k_wowlan_support = {
 	.flags = WIPHY_WOWLAN_DISCONNECT |
@@ -557,6 +558,14 @@ int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
 
 	mutex_lock(&ar->conf_mutex);
 
+	ret = ath11k_dp_rx_pktlog_stop(ar->ab, true);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to stop dp rx (and timer) pktlog during wow suspend: %d\n",
+			    ret);
+		goto exit;
+	}
+
 	ret =  ath11k_wow_cleanup(ar);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to clear wow wakeup events: %d\n",
@@ -590,6 +599,14 @@ int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
 		goto cleanup;
 	}
 
+	ret = ath11k_dp_rx_pktlog_stop(ar->ab, false);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to stop dp rx pktlog during wow suspend: %d\n",
+			    ret);
+		goto cleanup;
+	}
+
 	ath11k_ce_stop_shadow_timers(ar->ab);
 	ath11k_dp_stop_shadow_timers(ar->ab);
 
@@ -640,6 +657,8 @@ int ath11k_wow_op_resume(struct ieee80211_hw *hw)
 	ath11k_hif_ce_irq_enable(ar->ab);
 	ath11k_hif_irq_enable(ar->ab);
 
+	ath11k_dp_rx_pktlog_start(ar->ab);
+
 	ret = ath11k_wow_wakeup(ar->ab);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to wakeup from wow: %d\n", ret);
-- 
2.7.4

