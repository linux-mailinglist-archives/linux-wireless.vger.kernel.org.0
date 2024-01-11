Return-Path: <linux-wireless+bounces-1743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D09A82B3A8
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 18:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947B41C233E0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB3C5100A;
	Thu, 11 Jan 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="b9EGrJ+E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4C50256
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=MUPfQ1ltrkCMHHlk6nRsyP1Xr8tffTbfH7wb2Ran8CU=; t=1704992804; x=1706202404; 
	b=b9EGrJ+EuHjEuxhq8ALp6Rj9im0kGNGMeUN565Vz5O4IqT8s+o70dG8Bc9omV3ny9CCsd/cYzbO
	nYYtj9UFUEws6Xn0zRChSPJuSpuK/9cI6xuF3poieWKTUtiw+2QNUYNERdFmy+5DD5S/JBoVmI7nm
	YTxrQGYZubIvw5L4NCVRpurhEi/4MZ6X1p+S8ARgMcUFnmKzILPwImXS/aKDLa4eT8VEipbrMZbtV
	i8BvChwTYi/8LrxjhettUnb1IPK9Rd2Fi8GgKPuhVQnrzw8SjRHSwKjwevh3HpuytbeC/B0dmwBzN
	dId73rTQYdizng70fAxv09Q7w1JknL9dpONw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rNyVs-0000000FIRj-33y3;
	Thu, 11 Jan 2024 18:06:41 +0100
From: benjamin@sipsolutions.net
To: linux-wireless@vger.kernel.org
Cc: lenb@kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH] wifi: ath11k: rely on mac80211 debugfs handling for vif
Date: Thu, 11 Jan 2024 18:06:29 +0100
Message-ID: <20240111170629.1257217-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

mac80211 started to delete debugfs entries in certain cases, causing a
conflict between ath11k also trying to delete them later on. Fix this by
relying on mac80211 to delete the entries when appropriate and adding
them from the vif_add_debugfs handler.

Fixes: 0a3d898ee9a8 ("wifi: mac80211: add/remove driver debugfs entries as appropriate")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218364
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 drivers/net/wireless/ath/ath11k/core.h    |  4 ----
 drivers/net/wireless/ath/ath11k/debugfs.c | 25 +++++++++--------------
 drivers/net/wireless/ath/ath11k/debugfs.h | 12 ++---------
 drivers/net/wireless/ath/ath11k/mac.c     | 12 +----------
 4 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 7e3b6779f4e9..02e160d831be 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -368,10 +368,6 @@ struct ath11k_vif {
 	struct ieee80211_chanctx_conf chanctx;
 	struct ath11k_arp_ns_offload arp_ns_offload;
 	struct ath11k_rekey_data rekey_data;
-
-#ifdef CONFIG_ATH11K_DEBUGFS
-	struct dentry *debugfs_twt;
-#endif /* CONFIG_ATH11K_DEBUGFS */
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index a847bc0d50c0..af6fdb4b6497 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1894,35 +1894,30 @@ static const struct file_operations ath11k_fops_twt_resume_dialog = {
 	.open = simple_open
 };
 
-void ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
+void ath11k_debugfs_op_add_interface(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif)
 {
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_base *ab = arvif->ar->ab;
+	struct dentry *debugfs_twt;
 
 	if (arvif->vif->type != NL80211_IFTYPE_AP &&
 	    !(arvif->vif->type == NL80211_IFTYPE_STATION &&
 	      test_bit(WMI_TLV_SERVICE_STA_TWT, ab->wmi_ab.svc_map)))
 		return;
 
-	arvif->debugfs_twt = debugfs_create_dir("twt",
-						arvif->vif->debugfs_dir);
-	debugfs_create_file("add_dialog", 0200, arvif->debugfs_twt,
+	debugfs_twt = debugfs_create_dir("twt",
+					 arvif->vif->debugfs_dir);
+	debugfs_create_file("add_dialog", 0200, debugfs_twt,
 			    arvif, &ath11k_fops_twt_add_dialog);
 
-	debugfs_create_file("del_dialog", 0200, arvif->debugfs_twt,
+	debugfs_create_file("del_dialog", 0200, debugfs_twt,
 			    arvif, &ath11k_fops_twt_del_dialog);
 
-	debugfs_create_file("pause_dialog", 0200, arvif->debugfs_twt,
+	debugfs_create_file("pause_dialog", 0200, debugfs_twt,
 			    arvif, &ath11k_fops_twt_pause_dialog);
 
-	debugfs_create_file("resume_dialog", 0200, arvif->debugfs_twt,
+	debugfs_create_file("resume_dialog", 0200, debugfs_twt,
 			    arvif, &ath11k_fops_twt_resume_dialog);
 }
 
-void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif)
-{
-	if (!arvif->debugfs_twt)
-		return;
-
-	debugfs_remove_recursive(arvif->debugfs_twt);
-	arvif->debugfs_twt = NULL;
-}
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index 44d15845f39a..325151ec8d4f 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -307,8 +307,8 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return ar->debug.rx_filter;
 }
 
-void ath11k_debugfs_add_interface(struct ath11k_vif *arvif);
-void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif);
+void ath11k_debugfs_op_add_interface(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif);
 void ath11k_debugfs_add_dbring_entry(struct ath11k *ar,
 				     enum wmi_direct_buffer_module id,
 				     enum ath11k_dbg_dbr_event event,
@@ -387,14 +387,6 @@ static inline int ath11k_debugfs_get_fw_stats(struct ath11k *ar,
 	return 0;
 }
 
-static inline void ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
-{
-}
-
-static inline void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif)
-{
-}
-
 static inline void
 ath11k_debugfs_add_dbring_entry(struct ath11k *ar,
 				enum wmi_direct_buffer_module id,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index db241589424d..cd99246303dd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6756,13 +6756,6 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 		goto err;
 	}
 
-	/* In the case of hardware recovery, debugfs files are
-	 * not deleted since ieee80211_ops.remove_interface() is
-	 * not invoked. In such cases, try to delete the files.
-	 * These will be re-created later.
-	 */
-	ath11k_debugfs_remove_interface(arvif);
-
 	memset(arvif, 0, sizeof(*arvif));
 
 	arvif->ar = ar;
@@ -6939,8 +6932,6 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 	ath11k_dp_vdev_tx_attach(ar, arvif);
 
-	ath11k_debugfs_add_interface(arvif);
-
 	if (vif->type != NL80211_IFTYPE_MONITOR &&
 	    test_bit(ATH11K_FLAG_MONITOR_CONF_ENABLED, &ar->monitor_flags)) {
 		ret = ath11k_mac_monitor_vdev_create(ar);
@@ -7056,8 +7047,6 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	/* Recalc txpower for remaining vdev */
 	ath11k_mac_txpower_recalc(ar);
 
-	ath11k_debugfs_remove_interface(arvif);
-
 	/* TODO: recal traffic pause state based on the available vdevs */
 
 	mutex_unlock(&ar->conf_mutex);
@@ -9153,6 +9142,7 @@ static const struct ieee80211_ops ath11k_ops = {
 #endif
 
 #ifdef CONFIG_ATH11K_DEBUGFS
+	.vif_add_debugfs		= ath11k_debugfs_op_add_interface,
 	.sta_add_debugfs		= ath11k_debugfs_sta_op_add,
 #endif
 
-- 
2.43.0


