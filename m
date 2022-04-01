Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD1A4EF8F9
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 19:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350065AbiDARck (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350082AbiDARci (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 13:32:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E781AA8E2
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 10:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DDF361D49
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 17:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E707AC340F2;
        Fri,  1 Apr 2022 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648834247;
        bh=Vq5ZcotMnOIsFOE2qHwHRxVIuW6lIkZiCPSMh1eHLMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2A4qBnidwr+oN9rwauWn8ugOh/JfT0vl4ezM9HkvuiG47hXBHUeeNAShHIV3YH+O
         InVig1/RNTRAc0umI7/ZRR9gszODhaLvgqbGI7BHSX+WWSyu8jMgaRwEDDO8TKEJyB
         SGJXXU/vZkXYNf8vTXBFyXMc0WsaaD3BL+GPBxAUF8r8z2IefLf5CP3Ca9Ao+rr24q
         t56iKsR4G7zLz0gr/uCZxkytwrDGtcjuoLkZOPxDPcw2PhNE6O79SNIYiGT1lb1mpF
         WpeeAfjlGaQN+1JBJbOnhYzGcaa0m51YNNaJNO1nz4EncTuLXc8/SM4/biywB8/JYI
         VPa18ZBYTQcuQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] ath11k: mhi: remove state machine
Date:   Fri,  1 Apr 2022 20:30:40 +0300
Message-Id: <20220401173042.17467-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220401173042.17467-1-kvalo@kernel.org>
References: <20220401173042.17467-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

State machines are difficult to understand and in this case it's just useless,
which is shown by the diffstat. So remove it entirely to make the code simpler.

No functional changes.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 194 ++------------------------
 drivers/net/wireless/ath/ath11k/mhi.h |  13 --
 drivers/net/wireless/ath/ath11k/pci.h |   1 -
 3 files changed, 10 insertions(+), 198 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 61d83be4841f..d9b63a1f8219 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -461,195 +461,17 @@ void ath11k_mhi_unregister(struct ath11k_pci *ab_pci)
 	mhi_free_controller(mhi_ctrl);
 }
 
-static char *ath11k_mhi_state_to_str(enum ath11k_mhi_state mhi_state)
-{
-	switch (mhi_state) {
-	case ATH11K_MHI_INIT:
-		return "INIT";
-	case ATH11K_MHI_DEINIT:
-		return "DEINIT";
-	case ATH11K_MHI_POWER_ON:
-		return "POWER_ON";
-	case ATH11K_MHI_POWER_OFF:
-		return "POWER_OFF";
-	case ATH11K_MHI_FORCE_POWER_OFF:
-		return "FORCE_POWER_OFF";
-	case ATH11K_MHI_SUSPEND:
-		return "SUSPEND";
-	case ATH11K_MHI_RESUME:
-		return "RESUME";
-	case ATH11K_MHI_TRIGGER_RDDM:
-		return "TRIGGER_RDDM";
-	case ATH11K_MHI_RDDM_DONE:
-		return "RDDM_DONE";
-	default:
-		return "UNKNOWN";
-	}
-};
-
-static void ath11k_mhi_set_state_bit(struct ath11k_pci *ab_pci,
-				     enum ath11k_mhi_state mhi_state)
-{
-	struct ath11k_base *ab = ab_pci->ab;
-
-	switch (mhi_state) {
-	case ATH11K_MHI_INIT:
-		set_bit(ATH11K_MHI_INIT, &ab_pci->mhi_state);
-		break;
-	case ATH11K_MHI_DEINIT:
-		clear_bit(ATH11K_MHI_INIT, &ab_pci->mhi_state);
-		break;
-	case ATH11K_MHI_POWER_ON:
-		set_bit(ATH11K_MHI_POWER_ON, &ab_pci->mhi_state);
-		break;
-	case ATH11K_MHI_POWER_OFF:
-	case ATH11K_MHI_FORCE_POWER_OFF:
-		clear_bit(ATH11K_MHI_POWER_ON, &ab_pci->mhi_state);
-		clear_bit(ATH11K_MHI_TRIGGER_RDDM, &ab_pci->mhi_state);
-		clear_bit(ATH11K_MHI_RDDM_DONE, &ab_pci->mhi_state);
-		break;
-	case ATH11K_MHI_SUSPEND:
-		set_bit(ATH11K_MHI_SUSPEND, &ab_pci->mhi_state);
-		break;
-	case ATH11K_MHI_RESUME:
-		clear_bit(ATH11K_MHI_SUSPEND, &ab_pci->mhi_state);
-		break;
-	case ATH11K_MHI_TRIGGER_RDDM:
-		set_bit(ATH11K_MHI_TRIGGER_RDDM, &ab_pci->mhi_state);
-		break;
-	case ATH11K_MHI_RDDM_DONE:
-		set_bit(ATH11K_MHI_RDDM_DONE, &ab_pci->mhi_state);
-		break;
-	default:
-		ath11k_err(ab, "unhandled mhi state (%d)\n", mhi_state);
-	}
-}
-
-static int ath11k_mhi_check_state_bit(struct ath11k_pci *ab_pci,
-				      enum ath11k_mhi_state mhi_state)
-{
-	struct ath11k_base *ab = ab_pci->ab;
-
-	switch (mhi_state) {
-	case ATH11K_MHI_INIT:
-		if (!test_bit(ATH11K_MHI_INIT, &ab_pci->mhi_state))
-			return 0;
-		break;
-	case ATH11K_MHI_DEINIT:
-	case ATH11K_MHI_POWER_ON:
-		if (test_bit(ATH11K_MHI_INIT, &ab_pci->mhi_state) &&
-		    !test_bit(ATH11K_MHI_POWER_ON, &ab_pci->mhi_state))
-			return 0;
-		break;
-	case ATH11K_MHI_FORCE_POWER_OFF:
-		if (test_bit(ATH11K_MHI_POWER_ON, &ab_pci->mhi_state))
-			return 0;
-		break;
-	case ATH11K_MHI_POWER_OFF:
-	case ATH11K_MHI_SUSPEND:
-		if (test_bit(ATH11K_MHI_POWER_ON, &ab_pci->mhi_state) &&
-		    !test_bit(ATH11K_MHI_SUSPEND, &ab_pci->mhi_state))
-			return 0;
-		break;
-	case ATH11K_MHI_RESUME:
-		if (test_bit(ATH11K_MHI_SUSPEND, &ab_pci->mhi_state))
-			return 0;
-		break;
-	case ATH11K_MHI_TRIGGER_RDDM:
-		if (test_bit(ATH11K_MHI_POWER_ON, &ab_pci->mhi_state) &&
-		    !test_bit(ATH11K_MHI_TRIGGER_RDDM, &ab_pci->mhi_state))
-			return 0;
-		break;
-	case ATH11K_MHI_RDDM_DONE:
-		return 0;
-	default:
-		ath11k_err(ab, "unhandled mhi state: %s(%d)\n",
-			   ath11k_mhi_state_to_str(mhi_state), mhi_state);
-	}
-
-	ath11k_err(ab, "failed to set mhi state %s(%d) in current mhi state (0x%lx)\n",
-		   ath11k_mhi_state_to_str(mhi_state), mhi_state,
-		   ab_pci->mhi_state);
-
-	return -EINVAL;
-}
-
-static int ath11k_mhi_set_state(struct ath11k_pci *ab_pci,
-				enum ath11k_mhi_state mhi_state)
-{
-	struct ath11k_base *ab = ab_pci->ab;
-	int ret;
-
-	ret = ath11k_mhi_check_state_bit(ab_pci, mhi_state);
-	if (ret)
-		goto out;
-
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "setting mhi state: %s(%d)\n",
-		   ath11k_mhi_state_to_str(mhi_state), mhi_state);
-
-	switch (mhi_state) {
-	case ATH11K_MHI_INIT:
-		ret = mhi_prepare_for_power_up(ab_pci->mhi_ctrl);
-		break;
-	case ATH11K_MHI_DEINIT:
-		mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
-		ret = 0;
-		break;
-	case ATH11K_MHI_POWER_ON:
-		ret = mhi_sync_power_up(ab_pci->mhi_ctrl);
-		break;
-	case ATH11K_MHI_POWER_OFF:
-		mhi_power_down(ab_pci->mhi_ctrl, true);
-		ret = 0;
-		break;
-	case ATH11K_MHI_FORCE_POWER_OFF:
-		mhi_power_down(ab_pci->mhi_ctrl, false);
-		ret = 0;
-		break;
-	case ATH11K_MHI_SUSPEND:
-		ret = mhi_pm_suspend(ab_pci->mhi_ctrl);
-		break;
-	case ATH11K_MHI_RESUME:
-		/* Do force MHI resume as some devices like QCA6390, WCN6855
-		 * are not in M3 state but they are functional. So just ignore
-		 * the MHI state while resuming.
-		 */
-		ret = mhi_pm_resume_force(ab_pci->mhi_ctrl);
-		break;
-	case ATH11K_MHI_TRIGGER_RDDM:
-		ret = mhi_force_rddm_mode(ab_pci->mhi_ctrl);
-		break;
-	case ATH11K_MHI_RDDM_DONE:
-		break;
-	default:
-		ath11k_err(ab, "unhandled MHI state (%d)\n", mhi_state);
-		ret = -EINVAL;
-	}
-
-	if (ret)
-		goto out;
-
-	ath11k_mhi_set_state_bit(ab_pci, mhi_state);
-
-	return 0;
-
-out:
-	ath11k_err(ab, "failed to set mhi state: %s(%d)\n",
-		   ath11k_mhi_state_to_str(mhi_state), mhi_state);
-	return ret;
-}
-
 int ath11k_mhi_start(struct ath11k_pci *ab_pci)
 {
 	int ret;
 
 	ab_pci->mhi_ctrl->timeout_ms = MHI_TIMEOUT_DEFAULT_MS;
 
-	ret = ath11k_mhi_set_state(ab_pci, ATH11K_MHI_INIT);
+	ret = mhi_prepare_for_power_up(ab_pci->mhi_ctrl);
 	if (ret)
 		goto out;
 
-	ret = ath11k_mhi_set_state(ab_pci, ATH11K_MHI_POWER_ON);
+	ret = mhi_sync_power_up(ab_pci->mhi_ctrl);
 	if (ret)
 		goto out;
 
@@ -661,16 +483,20 @@ int ath11k_mhi_start(struct ath11k_pci *ab_pci)
 
 void ath11k_mhi_stop(struct ath11k_pci *ab_pci)
 {
-	ath11k_mhi_set_state(ab_pci, ATH11K_MHI_POWER_OFF);
-	ath11k_mhi_set_state(ab_pci, ATH11K_MHI_DEINIT);
+	mhi_power_down(ab_pci->mhi_ctrl, true);
+	mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
 }
 
 void ath11k_mhi_suspend(struct ath11k_pci *ab_pci)
 {
-	ath11k_mhi_set_state(ab_pci, ATH11K_MHI_SUSPEND);
+	mhi_pm_suspend(ab_pci->mhi_ctrl);
 }
 
 void ath11k_mhi_resume(struct ath11k_pci *ab_pci)
 {
-	ath11k_mhi_set_state(ab_pci, ATH11K_MHI_RESUME);
+	/* Do force MHI resume as some devices like QCA6390, WCN6855
+	 * are not in M3 state but they are functional. So just ignore
+	 * the MHI state while resuming.
+	 */
+	mhi_pm_resume_force(ab_pci->mhi_ctrl);
 }
diff --git a/drivers/net/wireless/ath/ath11k/mhi.h b/drivers/net/wireless/ath/ath11k/mhi.h
index 488dada5d31c..5dd024f879c4 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.h
+++ b/drivers/net/wireless/ath/ath11k/mhi.h
@@ -16,19 +16,6 @@
 #define MHICTRL					0x38
 #define MHICTRL_RESET_MASK			0x2
 
-enum ath11k_mhi_state {
-	ATH11K_MHI_INIT,
-	ATH11K_MHI_DEINIT,
-	ATH11K_MHI_POWER_ON,
-	ATH11K_MHI_POWER_OFF,
-	ATH11K_MHI_FORCE_POWER_OFF,
-	ATH11K_MHI_SUSPEND,
-	ATH11K_MHI_RESUME,
-	ATH11K_MHI_TRIGGER_RDDM,
-	ATH11K_MHI_RDDM,
-	ATH11K_MHI_RDDM_DONE,
-};
-
 int ath11k_mhi_start(struct ath11k_pci *ar_pci);
 void ath11k_mhi_stop(struct ath11k_pci *ar_pci);
 int ath11k_mhi_register(struct ath11k_pci *ar_pci);
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 61d67b20a0eb..2a28a9e8cda5 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -79,7 +79,6 @@ struct ath11k_pci {
 	u32 msi_ep_base_data;
 	struct mhi_controller *mhi_ctrl;
 	const struct ath11k_msi_config *msi_config;
-	unsigned long mhi_state;
 	u32 register_window;
 
 	/* protects register_window above */
-- 
2.30.2

