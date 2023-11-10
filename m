Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9757E7FA1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 18:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjKJR4o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 12:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjKJRz7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213552812E
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 02:22:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36980C433CA;
        Fri, 10 Nov 2023 10:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699611729;
        bh=5ou17yiktRU9nagkHXi6c6F9I8XPQs9jzQuZICUzCw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kd2bZGTTww+NHdBdmpixjeUbted6II9Zmcrm1Y1tUbHnmuxVbsY+zZXeZx7h+vCem
         UOVVaGTqAgDgIYeeHfOui1/hpCTLy9CzyO0aGhzFNF5zVqemBWVlxvribKdvfNdZy7
         q50zCxJiOlesEpZKVWVjwWnOadJQpZMfLsP6MOCzGGNaPkzrRmS2L35QNph9FAFyCW
         GwOjCR/eF32U5jhFEPo1u9dlB43KDYGCstJhrDd/PHM9YI32s5QoULPrVH4yXj2dT9
         kxIb6q6lWNe4P4DewJ6PVCAKpN8RETVgqj9PcVDNS14YgKiT0YDIdo1bQyXM0KGAnZ
         6Fd1lIZOMl5JA==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 3/8] wifi: ath11k: handle irq enable/disable in several code path
Date:   Fri, 10 Nov 2023 12:21:57 +0200
Message-Id: <20231110102202.3168243-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110102202.3168243-1-kvalo@kernel.org>
References: <20231110102202.3168243-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <quic_bqiang@quicinc.com>

For non WoW suspend/resume, ath11k host powers down whole hardware
when suspend and power up it when resume, the code path it goes
through is very like the ath11k reset logic.

In order to reuse that logic, do some IRQ management work to make
it work.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 0c6ecbb9a066..fbd6b6a0e12c 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -852,9 +852,6 @@ int ath11k_core_resume(struct ath11k_base *ab)
 		return ret;
 	}
 
-	ath11k_hif_ce_irq_enable(ab);
-	ath11k_hif_irq_enable(ab);
-
 	ret = ath11k_dp_rx_pktlog_start(ab);
 	if (ret) {
 		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",
@@ -1775,10 +1772,9 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 
 	mutex_lock(&ab->core_lock);
 	ath11k_thermal_unregister(ab);
-	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
 	ath11k_spectral_deinit(ab);
-	ath11k_hif_stop(ab);
+	ath11k_ce_cleanup_pipes(ab);
 	ath11k_wmi_detach(ab);
 	ath11k_dp_pdev_reo_cleanup(ab);
 	mutex_unlock(&ab->core_lock);
@@ -2033,8 +2029,8 @@ static void ath11k_core_reset(struct work_struct *work)
 	time_left = wait_for_completion_timeout(&ab->recovery_start,
 						ATH11K_RECOVER_START_TIMEOUT_HZ);
 
-	ath11k_hif_power_down(ab);
-	ath11k_hif_power_up(ab);
+	ath11k_hif_irq_disable(ab);
+	ath11k_hif_ce_irq_disable(ab);
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset started\n");
 }
-- 
2.39.2

