Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F286646E6DA
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 11:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhLIKrd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 05:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhLIKrc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 05:47:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7854AC061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 02:43:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4095BB82436
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 10:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA89C341C3;
        Thu,  9 Dec 2021 10:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639046637;
        bh=Y4B+46AH6qdxtUp7sQehFIYYUpB5SS3/P2h8QBoORCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/OMcOJB3AZ4gmN2aRrecnWkO0vuy57sf4lwht6MuYLvYp689armdqYkCdrHGW9kg
         +rHaZ/iXpmR2G9Onk1kSyKxUE+8PwrELgR8TFM5Y3WvzBBi8OMJhi4DvK5lOLxDylE
         sHpGVzvFRHlq2PFk6MG+nEzVCu93+8VLGdhcv19Qyas6xBI0YnGoDnJ23DPeseZteN
         Lff7jF8N/StHQvyhQU3CicayjiaVOurEBtnFlPYSHCQsmr6O/ujfvkQL/gzPRCtNNH
         SGwR8TeGrUfevNXbT3TQhPmlRT+rhBOsNnn4UYB37Wb7FZ5ePBZ65IyW2k4MrhxfaY
         g1MDIBZSBfLtQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v3 1/2] ath11k: add ab to TARGET_NUM_VDEVS & co
Date:   Thu,  9 Dec 2021 12:43:50 +0200
Message-Id: <20211209104351.9811-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211209104351.9811-1-kvalo@kernel.org>
References: <20211209104351.9811-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

The next patch changes TARGET_NUM_VDEVS to be dynamic and need access to ab.
Add ab separately to keep the next patch simple.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  2 +-
 drivers/net/wireless/ath/ath11k/hw.c   | 14 +++++++-------
 drivers/net/wireless/ath/ath11k/hw.h   | 18 +++++++++---------
 drivers/net/wireless/ath/ath11k/mac.c  | 10 +++++-----
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 1d983fde6fc9..c08e96522332 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1067,7 +1067,7 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	ath11k_dp_free(ab);
 	ath11k_hal_srng_deinit(ab);
 
-	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
+	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
 
 	ret = ath11k_hal_srng_init(ab);
 	if (ret)
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 2f0b526188e4..3b0fdc1a6b3f 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -150,18 +150,18 @@ static void ath11k_hw_ipq8074_reo_setup(struct ath11k_base *ab)
 static void ath11k_init_wmi_config_ipq8074(struct ath11k_base *ab,
 					   struct target_resource_config *config)
 {
-	config->num_vdevs = ab->num_radios * TARGET_NUM_VDEVS;
+	config->num_vdevs = ab->num_radios * TARGET_NUM_VDEVS(ab);
 
 	if (ab->num_radios == 2) {
-		config->num_peers = TARGET_NUM_PEERS(DBS);
-		config->num_tids = TARGET_NUM_TIDS(DBS);
+		config->num_peers = TARGET_NUM_PEERS(ab, DBS);
+		config->num_tids = TARGET_NUM_TIDS(ab, DBS);
 	} else if (ab->num_radios == 3) {
-		config->num_peers = TARGET_NUM_PEERS(DBS_SBS);
-		config->num_tids = TARGET_NUM_TIDS(DBS_SBS);
+		config->num_peers = TARGET_NUM_PEERS(ab, DBS_SBS);
+		config->num_tids = TARGET_NUM_TIDS(ab, DBS_SBS);
 	} else {
 		/* Control should not reach here */
-		config->num_peers = TARGET_NUM_PEERS(SINGLE);
-		config->num_tids = TARGET_NUM_TIDS(SINGLE);
+		config->num_peers = TARGET_NUM_PEERS(ab, SINGLE);
+		config->num_tids = TARGET_NUM_TIDS(ab, SINGLE);
 	}
 	config->num_offload_peers = TARGET_NUM_OFFLD_PEERS;
 	config->num_offload_reorder_buffs = TARGET_NUM_OFFLD_REORDER_BUFFS;
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index fe6e0cb9476c..7ea3207692dc 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -12,26 +12,26 @@
 /* Target configuration defines */
 
 /* Num VDEVS per radio */
-#define TARGET_NUM_VDEVS	(16 + 1)
+#define TARGET_NUM_VDEVS(ab)	(16 + 1)
 
-#define TARGET_NUM_PEERS_PDEV	(512 + TARGET_NUM_VDEVS)
+#define TARGET_NUM_PEERS_PDEV(ab) (512 + TARGET_NUM_VDEVS(ab))
 
 /* Num of peers for Single Radio mode */
-#define TARGET_NUM_PEERS_SINGLE		(TARGET_NUM_PEERS_PDEV)
+#define TARGET_NUM_PEERS_SINGLE(ab) (TARGET_NUM_PEERS_PDEV(ab))
 
 /* Num of peers for DBS */
-#define TARGET_NUM_PEERS_DBS		(2 * TARGET_NUM_PEERS_PDEV)
+#define TARGET_NUM_PEERS_DBS(ab) (2 * TARGET_NUM_PEERS_PDEV(ab))
 
 /* Num of peers for DBS_SBS */
-#define TARGET_NUM_PEERS_DBS_SBS	(3 * TARGET_NUM_PEERS_PDEV)
+#define TARGET_NUM_PEERS_DBS_SBS(ab)	(3 * TARGET_NUM_PEERS_PDEV(ab))
 
 /* Max num of stations (per radio) */
-#define TARGET_NUM_STATIONS	512
+#define TARGET_NUM_STATIONS(ab)	512
 
-#define TARGET_NUM_PEERS(x)	TARGET_NUM_PEERS_##x
+#define TARGET_NUM_PEERS(ab, x)	TARGET_NUM_PEERS_##x(ab)
 #define TARGET_NUM_PEER_KEYS	2
-#define TARGET_NUM_TIDS(x)	(2 * TARGET_NUM_PEERS(x) + \
-				 4 * TARGET_NUM_VDEVS + 8)
+#define TARGET_NUM_TIDS(ab, x)	(2 * TARGET_NUM_PEERS(ab, x) +	\
+				 4 * TARGET_NUM_VDEVS(ab) + 8)
 
 #define TARGET_AST_SKID_LIMIT	16
 #define TARGET_NUM_OFFLD_PEERS	4
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b7ab82f4572b..c5968cf1e87a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5980,9 +5980,9 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 		goto err;
 	}
 
-	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
+	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS(ab) - 1)) {
 		ath11k_warn(ab, "failed to create vdev %u, reached max vdev limit %d\n",
-			    ar->num_created_vdevs, TARGET_NUM_VDEVS);
+			    ar->num_created_vdevs, TARGET_NUM_VDEVS(ab));
 		ret = -EBUSY;
 		goto err;
 	}
@@ -8178,8 +8178,8 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ar->hw->wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
-	ar->max_num_stations = TARGET_NUM_STATIONS;
-	ar->max_num_peers = TARGET_NUM_PEERS_PDEV;
+	ar->max_num_stations = TARGET_NUM_STATIONS(ab);
+	ar->max_num_peers = TARGET_NUM_PEERS_PDEV(ab);
 
 	ar->hw->wiphy->max_ap_assoc_sta = ar->max_num_stations;
 
@@ -8277,7 +8277,7 @@ int ath11k_mac_register(struct ath11k_base *ab)
 
 	/* Initialize channel counters frequency value in hertz */
 	ab->cc_freq_hz = IPQ8074_CC_FREQ_HERTZ;
-	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
+	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
 
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
-- 
2.20.1

