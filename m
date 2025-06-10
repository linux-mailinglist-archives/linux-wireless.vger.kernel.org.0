Return-Path: <linux-wireless+bounces-23916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD86AD2C16
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 05:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD301891B27
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 03:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79C71A23B0;
	Tue, 10 Jun 2025 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPn/JFa2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F939460;
	Tue, 10 Jun 2025 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749524784; cv=none; b=JtVESOzczsy2dvQVT364IK0FTiY14/1X56WXByJc7+xH/AOdFDqMMhxzckDh8R88IJiCVi6PKeIPlx6QfdksTM/icrcCR2OobpOaML+WuzgPGX5c1E6mdp0txKkBpN/yA30vZu1sQiIWOPk6T0RIVA5zkoehbg506jeoBDdv9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749524784; c=relaxed/simple;
	bh=AoTaZLGzoqqkmNSAL5T91ZptQFroksDGcKIxLU9z7y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rnBWl6auOEH7tzgyvdO8u/oV6KivqYE8WlyW7cJDucrckpG9KkPe6zAJrpbPVihgiDVvEttjvFZaZbU32UIyFACCCzUfBxNryC4M+DvZg///lyKFLvpZ9rT2bPuwAecsfXyoTt4MfH1ZJFwPqXmKdrJVGIoduTIq7TKh5OxwxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPn/JFa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D8AEC4CEEB;
	Tue, 10 Jun 2025 03:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749524784;
	bh=AoTaZLGzoqqkmNSAL5T91ZptQFroksDGcKIxLU9z7y0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=sPn/JFa2C+jD12SM0IdloQfuMVprrNmTbuXTdNnSWeU1jz3vgxRRHSVquMTXuXIFb
	 OXVKPWzUiSS4FIqLZDvlCV/dLgI3bG4LC2AA+cH/F+6gthxfcI19WWvzV2Er3gAJCZ
	 d2Fh1J/6SE5Yo07HR3FFyE6ldtZj3A39AbsWFSsYrcQAyX6l+Bv3zPbCEFPSHiKmr0
	 Ax6L3iCYnuuCq2IhLjBfXUy4bSTr5+GhQEoJkACBQY3uM7T0iehEPzwvYPkMqQIfQl
	 P+uY/tPozHOQYKf/K7vL+r5O2nmlEpHZTIH7ieO+lE4Ahmsc1VI9hToIZBj+mn6NiO
	 AWHCWt0Ba0Nlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CDFC5B552;
	Tue, 10 Jun 2025 03:06:24 +0000 (UTC)
From: Bjorn Andersson via B4 Relay <devnull+bjorn.andersson.oss.qualcomm.com@kernel.org>
Date: Mon, 09 Jun 2025 22:06:22 -0500
Subject: [PATCH] wifi: ath12k: Avoid CPU busy-wait by handling VDEV_STAT
 and BCN_STAT
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-ath12k-fw-stats-done-v1-1-2b3624656697@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAC2hR2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwNL3cSSDEOjbN20ct3iksSSYt2U/LxU3ZTkRIukNHPzRPOURCWg1oK
 i1LTMCrCx0bG1tQAE2LaZZgAAAA==
X-Change-ID: 20250609-ath12k-fw-stats-done-dca8bf77a7da
To: Jeff Johnson <jjohnson@kernel.org>, 
 Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>, 
 Mahendran P <quic_mahep@quicinc.com>, 
 Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749524783; l=7583;
 i=bjorn.andersson@oss.qualcomm.com; s=20250318; h=from:subject:message-id;
 bh=4ab2pBSyw77wiRpufdGeMp8wcqCAzZr9bUoFTeou1RE=;
 b=XZRCzCTURtCBkIL9HPyWVc/+jQFZXV9YNjI1Sy0fn1SVZHZoKi101zfOA3aHUXaqviDqMX869
 evaNCoyIKhQB4UPZAlRy/WMe/VJor5UgjV6CQicgYpEjbjv4gF/oNlp
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=ed25519;
 pk=rD3O9C9Erg+mUPBRBNw91AGaIaDVqquHZbnn6N6xh6s=
X-Endpoint-Received: by B4 Relay for
 bjorn.andersson@oss.qualcomm.com/20250318 with auth_id=362
X-Original-From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Reply-To: bjorn.andersson@oss.qualcomm.com

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

When the ath12k driver is built without CONFIG_ATH12K_DEBUG, the
recently refactored stats code can cause any user space application
(such at NetworkManager) to consume 100% CPU for 3 seconds, every time
stats are read.

Commit 'b8a0d83fe4c7 ("wifi: ath12k: move firmware stats out of
debugfs")' moved ath12k_debugfs_fw_stats_request() out of debugfs, by
merging the additional logic into ath12k_mac_get_fw_stats().

Among the added responsibility of ath12k_mac_get_fw_stats() was the
busy-wait for `fw_stats_done`.

Signalling of `fw_stats_done` happens when one of the
WMI_REQUEST_PDEV_STAT, WMI_REQUEST_VDEV_STAT, and WMI_REQUEST_BCN_STAT
messages are received, but the handling of the latter two commands remained
in the debugfs code. As `fw_stats_done` isn't signalled, the calling
processes will spin until the timeout (3 seconds) is reached.

Moving the handling of these two additional responses out of debugfs
resolves the issue.

Fixes: b8a0d83fe4c7 ("wifi: ath12k: move firmware stats out of debugfs")
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/debugfs.c | 58 --------------------------
 drivers/net/wireless/ath/ath12k/debugfs.h |  7 ----
 drivers/net/wireless/ath/ath12k/wmi.c     | 67 +++++++++++++++++++++++++++----
 3 files changed, 60 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index dd624d73b8b2714e77c9d89b5a52f7b3fcb02951..23da93afaa5c25e806c9859dbbdd796afd23d78a 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -1251,64 +1251,6 @@ void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
 	 */
 }
 
-void
-ath12k_debugfs_fw_stats_process(struct ath12k *ar,
-				struct ath12k_fw_stats *stats)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_pdev *pdev;
-	bool is_end;
-	static unsigned int num_vdev, num_bcn;
-	size_t total_vdevs_started = 0;
-	int i;
-
-	if (stats->stats_id == WMI_REQUEST_VDEV_STAT) {
-		if (list_empty(&stats->vdevs)) {
-			ath12k_warn(ab, "empty vdev stats");
-			return;
-		}
-		/* FW sends all the active VDEV stats irrespective of PDEV,
-		 * hence limit until the count of all VDEVs started
-		 */
-		rcu_read_lock();
-		for (i = 0; i < ab->num_radios; i++) {
-			pdev = rcu_dereference(ab->pdevs_active[i]);
-			if (pdev && pdev->ar)
-				total_vdevs_started += pdev->ar->num_started_vdevs;
-		}
-		rcu_read_unlock();
-
-		is_end = ((++num_vdev) == total_vdevs_started);
-
-		list_splice_tail_init(&stats->vdevs,
-				      &ar->fw_stats.vdevs);
-
-		if (is_end) {
-			ar->fw_stats.fw_stats_done = true;
-			num_vdev = 0;
-		}
-		return;
-	}
-	if (stats->stats_id == WMI_REQUEST_BCN_STAT) {
-		if (list_empty(&stats->bcn)) {
-			ath12k_warn(ab, "empty beacon stats");
-			return;
-		}
-		/* Mark end until we reached the count of all started VDEVs
-		 * within the PDEV
-		 */
-		is_end = ((++num_bcn) == ar->num_started_vdevs);
-
-		list_splice_tail_init(&stats->bcn,
-				      &ar->fw_stats.bcn);
-
-		if (is_end) {
-			ar->fw_stats.fw_stats_done = true;
-			num_bcn = 0;
-		}
-	}
-}
-
 static int ath12k_open_vdev_stats(struct inode *inode, struct file *file)
 {
 	struct ath12k *ar = inode->i_private;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
index ebef7dace3448e4bdf2d6cb155d089267315172c..21641a8a03460c6cc1b34929a353e5605bb834ce 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -12,8 +12,6 @@ void ath12k_debugfs_soc_create(struct ath12k_base *ab);
 void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
 void ath12k_debugfs_register(struct ath12k *ar);
 void ath12k_debugfs_unregister(struct ath12k *ar);
-void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
-				     struct ath12k_fw_stats *stats);
 void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif);
 void ath12k_debugfs_pdev_create(struct ath12k_base *ab);
@@ -126,11 +124,6 @@ static inline void ath12k_debugfs_unregister(struct ath12k *ar)
 {
 }
 
-static inline void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
-						   struct ath12k_fw_stats *stats)
-{
-}
-
 static inline bool ath12k_debugfs_is_extd_rx_stats_enabled(struct ath12k *ar)
 {
 	return false;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 60e2444fe08cefa39ae218d07eb9736d2a0c982b..2d2444417e2b2d9281754d113f2b073034e27739 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7626,6 +7626,63 @@ static int ath12k_wmi_pull_fw_stats(struct ath12k_base *ab, struct sk_buff *skb,
 				   &parse);
 }
 
+static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
+					struct ath12k_fw_stats *stats)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_pdev *pdev;
+	bool is_end;
+	static unsigned int num_vdev, num_bcn;
+	size_t total_vdevs_started = 0;
+	int i;
+
+	if (stats->stats_id == WMI_REQUEST_VDEV_STAT) {
+		if (list_empty(&stats->vdevs)) {
+			ath12k_warn(ab, "empty vdev stats");
+			return;
+		}
+		/* FW sends all the active VDEV stats irrespective of PDEV,
+		 * hence limit until the count of all VDEVs started
+		 */
+		rcu_read_lock();
+		for (i = 0; i < ab->num_radios; i++) {
+			pdev = rcu_dereference(ab->pdevs_active[i]);
+			if (pdev && pdev->ar)
+				total_vdevs_started += pdev->ar->num_started_vdevs;
+		}
+		rcu_read_unlock();
+
+		is_end = ((++num_vdev) == total_vdevs_started);
+
+		list_splice_tail_init(&stats->vdevs,
+				      &ar->fw_stats.vdevs);
+
+		if (is_end) {
+			ar->fw_stats.fw_stats_done = true;
+			num_vdev = 0;
+		}
+		return;
+	}
+	if (stats->stats_id == WMI_REQUEST_BCN_STAT) {
+		if (list_empty(&stats->bcn)) {
+			ath12k_warn(ab, "empty beacon stats");
+			return;
+		}
+		/* Mark end until we reached the count of all started VDEVs
+		 * within the PDEV
+		 */
+		is_end = ((++num_bcn) == ar->num_started_vdevs);
+
+		list_splice_tail_init(&stats->bcn,
+				      &ar->fw_stats.bcn);
+
+		if (is_end) {
+			ar->fw_stats.fw_stats_done = true;
+			num_bcn = 0;
+		}
+	}
+}
+
 static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct ath12k_fw_stats stats = {};
@@ -7655,19 +7712,15 @@ static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *sk
 
 	spin_lock_bh(&ar->data_lock);
 
-	/* WMI_REQUEST_PDEV_STAT can be requested via .get_txpower mac ops or via
-	 * debugfs fw stats. Therefore, processing it separately.
-	 */
+	/* Handle WMI_REQUEST_PDEV_STAT status update */
 	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
 		list_splice_tail_init(&stats.pdevs, &ar->fw_stats.pdevs);
 		ar->fw_stats.fw_stats_done = true;
 		goto complete;
 	}
 
-	/* WMI_REQUEST_VDEV_STAT and WMI_REQUEST_BCN_STAT are currently requested only
-	 * via debugfs fw stats. Hence, processing these in debugfs context.
-	 */
-	ath12k_debugfs_fw_stats_process(ar, &stats);
+	/* Handle WMI_REQUEST_VDEV_STAT and WMI_REQUEST_BCN_STAT updates. */
+	ath12k_wmi_fw_stats_process(ar, &stats);
 
 complete:
 	complete(&ar->fw_stats_complete);

---
base-commit: 4f27f06ec12190c7c62c722e99ab6243dea81a94
change-id: 20250609-ath12k-fw-stats-done-dca8bf77a7da

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>



