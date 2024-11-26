Return-Path: <linux-wireless+bounces-15726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D2C9D9C2D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 18:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82432B274E9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AC91DC74A;
	Tue, 26 Nov 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaLabdOC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134051DA2E5
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641109; cv=none; b=RkVJ92mzRiyDNcMApahS2e0qq+djy+NzPWdc6JaH8/WrKo8kvAjspGT12g/TnQxdqOXY5YK2HEjr+aGLXkGM6BjuEnQBia4Qo8d3Hu+O/rVbLtBPWPEda7og6r1p8/H98TV1pe90zVM9VJlRZLzPvirxXBCDqv3A9CQ5nDFyimU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641109; c=relaxed/simple;
	bh=dKyR14jlI4jTxrksJj2zGzFi2HqMkz290uKkjN12qho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsMPCZUvZI+dz3UTLIHHD+S1EF+vsWfMhdPrKKHy/QSAhLFVAfc5VU0E0Z5nyTsth0ak1lFEofVDrEtu/YYRFTYHmoxJmBtYcODDsIOCwEXYD4ZXdqxdZu98Cyhbc6ogPtOP3BD5rk5OUDH75JRUXmdYjvsM+5agSlh7JunP1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaLabdOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BDBC4CECF;
	Tue, 26 Nov 2024 17:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641108;
	bh=dKyR14jlI4jTxrksJj2zGzFi2HqMkz290uKkjN12qho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaLabdOCwT2lF0IMU291GEPd76x2SPIRABIHgPCeP5zqeHoO+biE7Cncpi7LlVZk1
	 UZFIfA5YeVPwZfJp6fenPS9b3OCKgqkddUMYowWL7ZGdyGpKdGPx7PVhO+YGQbtA80
	 jpHsN9ifh9PCQvCNKBJ4YZL1jyg5FwTxWET9XwMeOrO+MHLVZ3jnNTbQGXTXqyD2/0
	 pZkMl5dzKaIR24nb3mv+Nxwlr5rclbHc5ZgcOe6xOFWr6pkj42m27ta1S/CUQBXiwE
	 XevrdqTm+gRP5bUR9bxKieYfSKW5aAR8V5wcq3lAEZ+JSK4Pvd6WmFtuBlJbMecyw8
	 0TErdMpGfd5CA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 06/10] wifi: ath12k: do not return invalid link id for scan link
Date: Tue, 26 Nov 2024 19:11:35 +0200
Message-Id: <20241126171139.2350704-7-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241126171139.2350704-1-kvalo@kernel.org>
References: <20241126171139.2350704-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

When a scan request is received, driver selects a link id for which the arvif
can be mapped. Same link is also used for getting the link conf address.
Currently, we return 0 as link id for a non ML vif, which is correct since that
is the default link id. Also when any of the link vif is active and the scan
request is for a channel in the active link we return its link id. But, when we
don't hit both of the above cases (i.e not a ML vif or no active link vif for
the channel is present) we currently return 0 as the link id.

Bu the problemis that this might not work out always, eg., when only one link
(eg. linkid = 1) is added to vif, then we won't find any link conf for link id
0 in the vif resulting in scan failure. During AP bringup, such scan failure
causes bringup issues.  Hence avoid sending link id 0 as default. Rather use a
default link for scan and default link address for the same. This scan vdev
will either be deleted if another scan is requested on same vif or when AP is
broughtup on same link or during interface cleanup.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  3 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 65 +++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/mac.h  |  6 +++
 3 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index e246e3d3c162..f4a710d49584 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -322,10 +322,11 @@ struct ath12k_vif {
 	bool ps;
 
 	struct ath12k_link_vif deflink;
-	struct ath12k_link_vif __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct ath12k_link_vif __rcu *link[ATH12K_NUM_MAX_LINKS];
 	struct ath12k_vif_cache *cache[IEEE80211_MLD_MAX_NUM_LINKS];
 	/* indicates bitmap of link vif created in FW */
 	u16 links_map;
+	u8 last_scan_link;
 
 	/* Must be last - ends in a flexible-array member.
 	 *
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8287c2e6b765..85cfbe1e4b9f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3792,6 +3792,9 @@ static void ath12k_ahvif_put_link_key_cache(struct ath12k_vif_cache *cache)
 
 static void ath12k_ahvif_put_link_cache(struct ath12k_vif *ahvif, u8 link_id)
 {
+	if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+		return;
+
 	ath12k_ahvif_put_link_key_cache(ahvif->cache[link_id]);
 	kfree(ahvif->cache[link_id]);
 	ahvif->cache[link_id] = NULL;
@@ -3852,9 +3855,9 @@ static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
 		arvif = &ahvif->deflink;
 	} else {
 		/* If this is the first link arvif being created for an ML VIF
-		 * use the preallocated deflink memory
+		 * use the preallocated deflink memory except for scan arvifs
 		 */
-		if (!ahvif->links_map) {
+		if (!ahvif->links_map && link_id != ATH12K_DEFAULT_SCAN_LINK) {
 			arvif = &ahvif->deflink;
 		} else {
 			arvif = (struct ath12k_link_vif *)
@@ -4154,10 +4157,10 @@ ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
 			return link_id;
 	}
 
-	/* input ar is not assigned to any of the links, use link id
-	 * 0 for scan vdev creation.
+	/* input ar is not assigned to any of the links of ML VIF, use scan
+	 * link (15) for scan vdev creation.
 	 */
-	return 0;
+	return ATH12K_DEFAULT_SCAN_LINK;
 }
 
 static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
@@ -4188,7 +4191,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	/* check if any of the links of ML VIF is already started on
 	 * radio(ar) correpsondig to given scan frequency and use it,
-	 * if not use deflink(link 0) for scan purpose.
+	 * if not use scan link (link 15) for scan purpose.
 	 */
 	link_id = ath12k_mac_find_link_id_by_ar(ahvif, ar);
 	arvif = ath12k_mac_assign_link_vif(ah, vif, link_id);
@@ -4298,6 +4301,13 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		spin_unlock_bh(&ar->data_lock);
 	}
 
+	/* As per cfg80211/mac80211 scan design, it allows only one
+	 * scan at a time. Hence last_scan link id is used for
+	 * tracking the link id on which the scan is been done on
+	 * this vif.
+	 */
+	ahvif->last_scan_link = arvif->link_id;
+
 	/* Add a margin to account for event/command processing */
 	ieee80211_queue_delayed_work(ath12k_ar_to_hw(ar), &ar->scan.timeout,
 				     msecs_to_jiffies(arg->max_scan_time +
@@ -4317,14 +4327,14 @@ static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	u16 link_id = ahvif->last_scan_link;
 	struct ath12k_link_vif *arvif;
 	struct ath12k *ar;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	arvif = &ahvif->deflink;
-
-	if (!arvif->is_created)
+	arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+	if (!arvif || arvif->is_created)
 		return;
 
 	ar = arvif->ar;
@@ -7688,10 +7698,19 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	u16 nss;
 	int i;
 	int ret, vdev_id;
+	u8 link_id;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[arvif->link_id]);
+	/* If no link is active and scan vdev is requested
+	 * use a default link conf for scan address purpose.
+	 */
+	if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
+		link_id = ffs(vif->valid_links) - 1;
+	else
+		link_id = arvif->link_id;
+
+	link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[link_id]);
 	if (!link_conf) {
 		ath12k_warn(ar->ab, "unable to access bss link conf in vdev create for vif %pM link %u\n",
 			    vif->addr, arvif->link_id);
@@ -7971,7 +7990,9 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 						    struct ath12k_link_vif *arvif,
 						    struct ieee80211_chanctx_conf *ctx)
 {
-	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
+	struct ath12k_link_vif *scan_arvif;
 	struct ath12k_hw *ah = hw->priv;
 	struct ath12k *ar;
 	struct ath12k_base *ab;
@@ -7990,6 +8011,19 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 	if (!ar)
 		return NULL;
 
+	/* cleanup the scan vdev if we are done scan on that ar
+	 * and now we want to create for actual usage.
+	 */
+	if (vif->valid_links) {
+		scan_arvif = wiphy_dereference(hw->wiphy,
+					       ahvif->link[ATH12K_DEFAULT_SCAN_LINK]);
+		if (scan_arvif && scan_arvif->ar == ar) {
+			ar->scan.vdev_id = -1;
+			ath12k_mac_remove_link_interface(hw, scan_arvif);
+			ath12k_mac_unassign_link_vif(scan_arvif);
+		}
+	}
+
 	if (arvif->ar) {
 		/* This is not expected really */
 		if (WARN_ON(!arvif->is_created)) {
@@ -8194,7 +8228,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+	for (link_id = 0; link_id < ATH12K_NUM_MAX_LINKS; link_id++) {
 		/* if we cached some config but never received assign chanctx,
 		 * free the allocated cache.
 		 */
@@ -9042,11 +9076,8 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		return -ENOMEM;
 	}
 
-	if (!arvif->is_started) {
-		ar = ath12k_mac_assign_vif_to_vdev(hw, arvif, ctx);
-		if (!ar)
-			return -EINVAL;
-	} else {
+	ar = ath12k_mac_assign_vif_to_vdev(hw, arvif, ctx);
+	if (!ar) {
 		ath12k_warn(arvif->ar->ab, "failed to assign chanctx for vif %pM link id %u link vif is already started",
 			    vif->addr, link_id);
 		return -EINVAL;
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index c13630ee479a..abdc9a6c0740 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -44,6 +44,12 @@ struct ath12k_generic_iter {
 #define ATH12K_DEFAULT_LINK_ID	0
 #define ATH12K_INVALID_LINK_ID	255
 
+/* Default link after the IEEE802.11 defined Max link id limit
+ * for driver usage purpose.
+ */
+#define ATH12K_DEFAULT_SCAN_LINK	IEEE80211_MLD_MAX_NUM_LINKS
+#define ATH12K_NUM_MAX_LINKS		(IEEE80211_MLD_MAX_NUM_LINKS + 1)
+
 enum ath12k_supported_bw {
 	ATH12K_BW_20    = 0,
 	ATH12K_BW_40    = 1,
-- 
2.39.5


