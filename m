Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C8027FC85
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 11:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgJAJfE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 05:35:04 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:52198 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731611AbgJAJfC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 05:35:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601544901; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Hb5gUsJ2bXVAmv9sbmb/InaYrwlhJMbag5c4pz3WKpY=; b=HX92gVa19D8kBirqMYldws88IvU22hwX5RAh5bwaJ0MQYrNTxkaWkVQfl1EYAFuKO7CuRbUP
 +jzFEsDhnhpNy3Zq8axVOK2h/BO7cZjkp1KYOnUizZr5bfB/xLLuKvsIM1rUazeBO3d3CxSd
 zObs3LYAjI5IRrbLQuF3U2/Khds=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f75a2c58246bdcb55f57456 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 09:35:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 166EBC433FE; Thu,  1 Oct 2020 09:35:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C236C433CA;
        Thu,  1 Oct 2020 09:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C236C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/8] ath11k: start a timer to update TCL HP
Date:   Thu,  1 Oct 2020 12:34:46 +0300
Message-Id: <1601544890-13450-5-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
References: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

The timer is to check if TCL HP isn't updated to target.
The timer will postpone itself if there are TX operations
during the interval, otherwise the timer handler updates
the HP again so the index value in HP register will be
forwarded to target register, and the timer stops afterwards.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.c    | 91 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/dp.h    | 22 ++++++++
 drivers/net/wireless/ath/ath11k/dp_tx.c |  2 +
 drivers/net/wireless/ath/ath11k/hal.c   | 13 +++++
 drivers/net/wireless/ath/ath11k/hal.h   |  2 +
 5 files changed, 130 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 0802f5b05fe8..868bfa00c8b1 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -304,11 +304,23 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 	return 0;
 }
 
+static void ath11k_dp_stop_shadow_timers(struct ath11k_base *ab)
+{
+	int i;
+
+	if (!ab->hw_params.supports_shadow_regs)
+		return;
+
+	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++)
+		ath11k_dp_shadow_stop_timer(ab, &ab->dp.tx_ring_timer[i]);
+}
+
 static void ath11k_dp_srng_common_cleanup(struct ath11k_base *ab)
 {
 	struct ath11k_dp *dp = &ab->dp;
 	int i;
 
+	ath11k_dp_stop_shadow_timers(ab);
 	ath11k_dp_srng_cleanup(ab, &dp->wbm_desc_rel_ring);
 	ath11k_dp_srng_cleanup(ab, &dp->tcl_cmd_ring);
 	ath11k_dp_srng_cleanup(ab, &dp->tcl_status_ring);
@@ -374,6 +386,10 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 
 		srng = &ab->hal.srng_list[dp->tx_ring[i].tcl_data_ring.ring_id];
 		ath11k_hal_tx_init_data_ring(ab, srng);
+
+		ath11k_dp_shadow_init_timer(ab, &dp->tx_ring_timer[i],
+					    ATH11K_SHADOW_DP_TIMER_INTERVAL,
+					    dp->tx_ring[i].tcl_data_ring.ring_id);
 	}
 
 	ret = ath11k_dp_srng_setup(ab, &dp->reo_reinject_ring, HAL_REO_REINJECT,
@@ -1066,3 +1082,78 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 
 	return ret;
 }
+
+static void ath11k_dp_shadow_timer_handler(struct timer_list *t)
+{
+	struct ath11k_hp_update_timer *update_timer = from_timer(update_timer,
+								 t, timer);
+	struct ath11k_base *ab = update_timer->ab;
+	struct hal_srng	*srng = &ab->hal.srng_list[update_timer->ring_id];
+
+	spin_lock_bh(&srng->lock);
+
+	/* when the timer is fired, the handler checks whether there
+	 * are new TX happened. The handler updates HP only when there
+	 * are no TX operations during the timeout interval, and stop
+	 * the timer. Timer will be started again when TX happens again.
+	 */
+	if (update_timer->timer_tx_num != update_timer->tx_num) {
+		update_timer->timer_tx_num = update_timer->tx_num;
+		mod_timer(&update_timer->timer, jiffies +
+		  msecs_to_jiffies(update_timer->interval));
+	} else {
+		update_timer->started = false;
+		ath11k_hal_srng_shadow_update_hp_tp(ab, srng);
+	}
+
+	spin_unlock_bh(&srng->lock);
+}
+
+void ath11k_dp_shadow_start_timer(struct ath11k_base *ab,
+				  struct hal_srng *srng,
+				  struct ath11k_hp_update_timer *update_timer)
+{
+	lockdep_assert_held(&srng->lock);
+
+	if (!ab->hw_params.supports_shadow_regs)
+		return;
+
+	update_timer->tx_num++;
+
+	if (update_timer->started)
+		return;
+
+	update_timer->started = true;
+	update_timer->timer_tx_num = update_timer->tx_num;
+	mod_timer(&update_timer->timer, jiffies +
+		  msecs_to_jiffies(update_timer->interval));
+}
+
+void ath11k_dp_shadow_stop_timer(struct ath11k_base *ab,
+				 struct ath11k_hp_update_timer *update_timer)
+{
+	if (!ab->hw_params.supports_shadow_regs)
+		return;
+
+	if (!update_timer->init)
+		return;
+
+	del_timer_sync(&update_timer->timer);
+}
+
+void ath11k_dp_shadow_init_timer(struct ath11k_base *ab,
+				 struct ath11k_hp_update_timer *update_timer,
+				 u32 interval, u32 ring_id)
+{
+	if (!ab->hw_params.supports_shadow_regs)
+		return;
+
+	update_timer->tx_num = 0;
+	update_timer->timer_tx_num = 0;
+	update_timer->ab = ab;
+	update_timer->ring_id = ring_id;
+	update_timer->interval = interval;
+	update_timer->init = true;
+	timer_setup(&update_timer->timer,
+		    ath11k_dp_shadow_timer_handler, 0);
+}
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 5402d5ad2e5a..43fa229ccccd 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -206,6 +206,19 @@ struct ath11k_pdev_dp {
 #define DP_TX_DESC_ID_MSDU_ID GENMASK(18, 2)
 #define DP_TX_DESC_ID_POOL_ID GENMASK(20, 19)
 
+#define ATH11K_SHADOW_DP_TIMER_INTERVAL 20
+
+struct ath11k_hp_update_timer {
+	struct timer_list timer;
+	bool started;
+	bool init;
+	u32 tx_num;
+	u32 timer_tx_num;
+	u32 ring_id;
+	u32 interval;
+	struct ath11k_base *ab;
+};
+
 struct ath11k_dp {
 	struct ath11k_base *ab;
 	enum ath11k_htc_ep_id eid;
@@ -235,6 +248,7 @@ struct ath11k_dp {
 	 * - reo_cmd_cache_flush_count
 	 */
 	spinlock_t reo_cmd_lock;
+	struct ath11k_hp_update_timer tx_ring_timer[DP_TCL_NUM_RING_MAX];
 };
 
 /* HTT definitions */
@@ -1616,5 +1630,13 @@ int ath11k_dp_link_desc_setup(struct ath11k_base *ab,
 			      struct dp_link_desc_bank *link_desc_banks,
 			      u32 ring_type, struct hal_srng *srng,
 			      u32 n_link_desc);
+void ath11k_dp_shadow_start_timer(struct ath11k_base *ab,
+				  struct hal_srng	*srng,
+				  struct ath11k_hp_update_timer *update_timer);
+void ath11k_dp_shadow_stop_timer(struct ath11k_base *ab,
+				 struct ath11k_hp_update_timer *update_timer);
+void ath11k_dp_shadow_init_timer(struct ath11k_base *ab,
+				 struct ath11k_hp_update_timer *update_timer,
+				 u32 interval, u32 ring_id);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index d329ff75221b..eb5eddc5a7aa 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -254,6 +254,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 
 	ath11k_hal_srng_access_end(ab, tcl_ring);
 
+	ath11k_dp_shadow_start_timer(ab, tcl_ring, &dp->tx_ring_timer[ti.ring_id]);
+
 	spin_unlock_bh(&tcl_ring->lock);
 
 	ath11k_dbg_dump(ab, ATH11K_DBG_DP_TX, NULL, "dp tx msdu: ",
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index d58dfdfe7860..20f9cebc86d2 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1174,6 +1174,19 @@ void ath11k_hal_srng_get_shadow_config(struct ath11k_base *ab,
 	*cfg = hal->shadow_reg_addr;
 }
 
+void ath11k_hal_srng_shadow_update_hp_tp(struct ath11k_base *ab,
+					 struct hal_srng *srng)
+{
+	lockdep_assert_held(&srng->lock);
+
+	/* check whether the ring is emptry. Update the shadow
+	 * HP only when then ring isn't' empty.
+	 */
+	if (srng->ring_dir == HAL_SRNG_DIR_SRC &&
+	    *srng->u.src_ring.tp_addr != srng->u.src_ring.hp)
+		ath11k_hal_srng_access_end(ab, srng);
+}
+
 static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
 {
 	struct ath11k_hal *hal = &ab->hal;
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index fe2448b52a7d..1f1b29cd0aa3 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -945,4 +945,6 @@ int ath11k_hal_srng_update_shadow_config(struct ath11k_base *ab,
 					 enum hal_ring_type ring_type,
 					int ring_num);
 void ath11k_hal_srng_shadow_config(struct ath11k_base *ab);
+void ath11k_hal_srng_shadow_update_hp_tp(struct ath11k_base *ab,
+					 struct hal_srng *srng);
 #endif
-- 
2.7.4

