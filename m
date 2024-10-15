Return-Path: <linux-wireless+bounces-13974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D299F3C6
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038E0B2277B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 17:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D2B1FAEFF;
	Tue, 15 Oct 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3PiQOV6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7086A1FAEFD
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012467; cv=none; b=gWlbVazu8UM+BZnIMxNdJz9vxZ58XLndm1UoduPeUIweDq/88AldgZj1GcCaK652nzTJLhXsKfaTQNr29tRN83NyAwOF1fJMUHFHV8JJDpnUHfF5HG2YwwO3RXbMNDQgKGSbqcn5rNDTSrOav7K/cMWNxWZuwi28GL9NvKTYLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012467; c=relaxed/simple;
	bh=L4JXM+1KunNHBc8a7dM4iQIojzcYVY8fZs6p55n8CwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOOakoMFETOYxDLGgyvFyvYON+Y26pwsz9Ap+FmOmcU+hX0LepRr4z8HhmBMwVhf2R7L438Apj8EHk7uNcMWITK3HVsN9qgU9T4Mu6uWv/kFkWr7XguQehtLbZmpkNzQvouJe0oS4fYi84jgkCG87i+lpO70Xz7E+HJjPXby820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3PiQOV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B612BC4CECD;
	Tue, 15 Oct 2024 17:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012467;
	bh=L4JXM+1KunNHBc8a7dM4iQIojzcYVY8fZs6p55n8CwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3PiQOV6hScDy+snYq+u5sM4d3/lz20ohkbtRhXDQyNToH+SZ5FvR3frGS/Wjw79L
	 B/p/OY8ijcFacUNuk8SGO1wIo1Z8/R5S+6nnzJz2CbKXDlqJ/7yEfL0w7TKQeo1LK1
	 PIT1S5XRqrv2y0ci8K1+bgtLXNnmTCGOf15IS9SRczTFUizdQMqHsR3EZ6JH/bGOyx
	 r+cKCh358hNkAZBdkxm8+RAmbLQitPNETNsilqUGooDX9PsOcTQxftZVOp58gHp1Sl
	 1TCW6bao5mUEqlHPyCQ0M8a1IY6+ZNJehgqj+aWxqJIOuwVWpUh9lmgVI2JNVB6hLA
	 J5CWuxZwDQCAQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 07/11] wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO
Date: Tue, 15 Oct 2024 20:14:12 +0300
Message-Id: <20241015171416.518022-8-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015171416.518022-1-kvalo@kernel.org>
References: <20241015171416.518022-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Currently bss_info_changed callback (which is registered with
ath12k_mac_op_bss_info_changed()) is used to inform vif (struct ieee80211_vif) and bss
(struct ieee80211_bss_conf) level configuration changes to driver.

With MLO, vif level config as well each link config changes inside vif needs to
be updated and mac80211 uses vif_cfg_changed() and link_info_changed() callback
ops for the same, this is also backward compatible where mac80211 will update
default link conf changes in case VIF is non-MLO.

Rename ath12k_mac_op_bss_info_changed() to ath12k_mac_op_link_info_changed()
and register the same to link_info_changed callback.  Register
ath12k_mac_op_vif_cfg_changed() to vif_cfg_changed() callback and handle all
vif level configuration changes there.

Also, currently ath12k_mac_op_bss_info_changed() uses deflink to apply the
config or to cache the config based on the availability of corresponding vdev.
With MLO multiple links can be affiliated to a vif/BSS, so use the link id
provided by mac80211 to fetch the corresponding link to which the bss change
was intended.

For non-MLO link id 0 will be provided by mac80211 and deflink (which is mapped
to ahvif->links[0]) will be used.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 61 ++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fb4b800435f8..c8a330eb0d4b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3150,6 +3150,40 @@ static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
 	return ret;
 }
 
+static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
+					  struct ieee80211_vif *vif,
+					  u64 changed)
+{
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	unsigned long links = ahvif->links_map;
+	struct ath12k_link_vif *arvif;
+	struct ath12k *ar;
+	u8 link_id;
+
+	lockdep_assert_wiphy(hw->wiphy);
+
+	if (changed & BSS_CHANGED_SSID && vif->type == NL80211_IFTYPE_AP) {
+		ahvif->u.ap.ssid_len = vif->cfg.ssid_len;
+		if (vif->cfg.ssid_len)
+			memcpy(ahvif->u.ap.ssid, vif->cfg.ssid, vif->cfg.ssid_len);
+	}
+
+	if (changed & BSS_CHANGED_ASSOC) {
+		for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+			if (!arvif || !arvif->ar)
+				continue;
+
+			ar = arvif->ar;
+
+			if (vif->cfg.assoc)
+				ath12k_bss_assoc(ar, arvif, &vif->bss_conf);
+			else
+				ath12k_bss_disassoc(ar, arvif);
+		}
+	}
+}
+
 static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
 {
 	struct ath12k *ar = arvif->ar;
@@ -3497,33 +3531,27 @@ static void ath12k_ahvif_put_link_cache(struct ath12k_vif *ahvif, u8 link_id)
 	ahvif->cache[link_id] = NULL;
 }
 
-static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
-					   struct ieee80211_vif *vif,
-					   struct ieee80211_bss_conf *info,
-					   u64 changed)
+static void ath12k_mac_op_link_info_changed(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif,
+					    struct ieee80211_bss_conf *info,
+					    u64 changed)
 {
 	struct ath12k *ar;
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_vif_cache *cache;
 	struct ath12k_link_vif *arvif;
+	u8 link_id = info->link_id;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	/* TODO use info->link_id and fetch corresponding ahvif->link[]
-	 * with MLO support.
-	 */
-	arvif = &ahvif->deflink;
-	ar = ath12k_get_ar_by_vif(hw, vif);
+	arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
 
 	/* if the vdev is not created on a certain radio,
 	 * cache the info to be updated later on vdev creation
 	 */
 
-	if (!ar) {
-		/* TODO Once link vif is fetched based on link id from
-		 * info, avoid using ATH12K_DEFAULT_LINK_ID.
-		 */
-		cache = ath12k_ahvif_get_link_cache(ahvif, ATH12K_DEFAULT_LINK_ID);
+	if (!arvif || !arvif->is_created) {
+		cache = ath12k_ahvif_get_link_cache(ahvif, link_id);
 		if (!cache)
 			return;
 
@@ -3532,6 +3560,8 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		return;
 	}
 
+	ar = arvif->ar;
+
 	ath12k_mac_bss_info_changed(ar, arvif, info, changed);
 }
 
@@ -8888,7 +8918,8 @@ static const struct ieee80211_ops ath12k_ops = {
 	.remove_interface		= ath12k_mac_op_remove_interface,
 	.update_vif_offload		= ath12k_mac_op_update_vif_offload,
 	.config                         = ath12k_mac_op_config,
-	.bss_info_changed               = ath12k_mac_op_bss_info_changed,
+	.link_info_changed              = ath12k_mac_op_link_info_changed,
+	.vif_cfg_changed		= ath12k_mac_op_vif_cfg_changed,
 	.configure_filter		= ath12k_mac_op_configure_filter,
 	.hw_scan                        = ath12k_mac_op_hw_scan,
 	.cancel_hw_scan                 = ath12k_mac_op_cancel_hw_scan,
-- 
2.39.5


