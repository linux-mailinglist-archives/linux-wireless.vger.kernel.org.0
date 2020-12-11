Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E582D7D17
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 18:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405577AbgLKRiN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 12:38:13 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:31578 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395323AbgLKRhH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 12:37:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607708203; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=EUjVLOm9H70OfH/V2weWB9IQ1ChH6bcyjVQIyD5TMk4=; b=nktjAfv7TVeIWmcsIrQ0ZcI2aUWVZI+YBg55+R/XSXl05AQ+vJTOYX4dq4/bFeDW5jDRQ/Fw
 J8Um1weN/gZ05H1hGM9OfZLaiODUUdkZkrZyzx/EYqesjzZkufKHJHfGNuLPnI+6G2hbjwxQ
 36iNErQPVPZv2en5Kh5piFcCVKg=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fd3ae0465f116f2878561f0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 17:36:04
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C76A5C433ED; Fri, 11 Dec 2020 17:36:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66FEBC43461;
        Fri, 11 Dec 2020 17:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66FEBC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 06/10] ath11k: dp: stop rx pktlog before suspend
Date:   Fri, 11 Dec 2020 19:35:46 +0200
Message-Id: <1607708150-21066-7-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
References: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Stop dp rx pktlog when entering suspend and reap the mon_status buffer to keep
it empty. During resume restart the reap timer.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.h    |  1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c | 48 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/dp_rx.h |  3 +++
 drivers/net/wireless/ath/ath11k/mac.c   |  4 +++
 4 files changed, 56 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index d4fd02375fad..1d9e2d6de3ae 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -40,6 +40,7 @@ struct dp_rx_tid {
 
 #define DP_REO_DESC_FREE_THRESHOLD  64
 #define DP_REO_DESC_FREE_TIMEOUT_MS 1000
+#define DP_MON_PURGE_TIMEOUT_MS     100
 #define DP_MON_SERVICE_BUDGET       128
 
 struct dp_reo_cache_flush_elem {
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 5de619d5c4e2..205c0f1a40e9 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -274,6 +274,28 @@ static void ath11k_dp_service_mon_ring(struct timer_list *t)
 		  msecs_to_jiffies(ATH11K_MON_TIMER_INTERVAL));
 }
 
+static int ath11k_dp_purge_mon_ring(struct ath11k_base *ab)
+{
+	int i, reaped = 0;
+	unsigned long timeout = jiffies + msecs_to_jiffies(DP_MON_PURGE_TIMEOUT_MS);
+
+	do {
+		for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++)
+			reaped += ath11k_dp_rx_process_mon_rings(ab, i,
+								 NULL,
+								 DP_MON_SERVICE_BUDGET);
+
+		/* nothing more to reap */
+		if (reaped < DP_MON_SERVICE_BUDGET)
+			return 0;
+
+	} while (time_before(jiffies, timeout));
+
+	ath11k_warn(ab, "dp mon ring purge timeout");
+
+	return -ETIMEDOUT;
+}
+
 /* Returns number of Rx buffers replenished */
 int ath11k_dp_rxbufs_replenish(struct ath11k_base *ab, int mac_id,
 			       struct dp_rxdma_ring *rx_ring,
@@ -5026,3 +5048,29 @@ int ath11k_dp_rx_pdev_mon_detach(struct ath11k *ar)
 	ath11k_dp_mon_link_free(ar);
 	return 0;
 }
+
+int ath11k_dp_rx_pktlog_start(struct ath11k_base *ab)
+{
+	/* start reap timer */
+	mod_timer(&ab->mon_reap_timer,
+		  jiffies + msecs_to_jiffies(ATH11K_MON_TIMER_INTERVAL));
+
+	return 0;
+}
+
+int ath11k_dp_rx_pktlog_stop(struct ath11k_base *ab, bool stop_timer)
+{
+	int ret;
+
+	if (stop_timer)
+		del_timer_sync(&ab->mon_reap_timer);
+
+	/* reap all the monitor related rings */
+	ret = ath11k_dp_purge_mon_ring(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to purge dp mon ring: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
index fbea45f79c9b..bf399312b5ff 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.h
@@ -91,4 +91,7 @@ int ath11k_dp_rx_pdev_mon_detach(struct ath11k *ar);
 int ath11k_dp_rx_pdev_mon_attach(struct ath11k *ar);
 int ath11k_peer_rx_frag_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id);
 
+int ath11k_dp_rx_pktlog_start(struct ath11k_base *ab);
+int ath11k_dp_rx_pktlog_stop(struct ath11k_base *ab, bool stop_timer);
+
 #endif /* ATH11K_DP_RX_H */
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d08afa111647..5c175e3e09b2 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4146,6 +4146,10 @@ static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 						       &tlv_filter);
 	}
 
+	if (enable && !ar->ab->hw_params.rxdma1_enable)
+		mod_timer(&ar->ab->mon_reap_timer, jiffies +
+			  msecs_to_jiffies(ATH11K_MON_TIMER_INTERVAL));
+
 	return ret;
 }
 
-- 
2.7.4

