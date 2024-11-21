Return-Path: <linux-wireless+bounces-15555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40439D503B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 16:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F328377D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2CF19DFAC;
	Thu, 21 Nov 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inMrrCIi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B019DF66
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204690; cv=none; b=QksKXJQq6CEWYV5pAd7SN4Nu1BHdsns4cIq4l4bJSwyvSroNEVoLLVEicZuQMxLnQ5tsW3XPU1omImGLfC1zd+WCDC5Bnr2sEKsuoIEmjiKW9mM6Rfv1uSYsdg5IQ2LwHCATEFxno4idzBqCVTS4Rb3dBwFqfI8NUWbvA8lvsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204690; c=relaxed/simple;
	bh=Zf6zgHwrTaC4gB3fGdR9UTcGCwprQF28h7NNBvnDxb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qiaCARch0VhcjcgZ4F1CmUnvcnUyXxHc5DyTfIm5HcIG7im93AExzx0tr0c66LIvPXL3UTjNgCqHZ2VuiS0IMVhkz8R8rYbt2ab9v7poywC5nG3WJudd7tz0kxPkgbgqqLDUHSO/H9Yg18f+/QdkFzeRjCSQoco9DqDZYR1eNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inMrrCIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1845C4CED0;
	Thu, 21 Nov 2024 15:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732204690;
	bh=Zf6zgHwrTaC4gB3fGdR9UTcGCwprQF28h7NNBvnDxb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=inMrrCIiv+Xm4W1HeTPa9luqzBL8ktIWv1EItegN2UERfD0g3WBNs0k1BWoisgJjw
	 ycpxsVAapRQ9DRqh7m1/eN/xY9ON6eqF+TLPJEr0ownL1xtUgkV588JFWeLs2OE91O
	 PSZZbUEeBSjgckDliyP+jCQ1EX+SE8trDQXc5N+nhmSHXcNhsKLLH/xVyZuxJeGNEK
	 bZdN3pRKtAOGMZnEAVESSKT9xJT5JGjNSVzpotofPOkPcKZ7Aq3j+bkh0wDi1nWhSq
	 PDs7cXOy0Wm0wgRJ4G4Je8oqUDdlzUJknPg5c/NpWArwvBt5FJxRXHop2ZFTTrh2oo
	 Q3sm5GVvphh3w==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 2/8] wifi: ath12k: support change_sta_links() mac80211 op
Date: Thu, 21 Nov 2024 17:58:00 +0200
Message-Id: <20241121155806.1862733-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121155806.1862733-1-kvalo@kernel.org>
References: <20241121155806.1862733-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Add ath12k_mac_op_change_sta_links() for adding and removing
link station.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 97 ++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d796185c8431..d92a5e0afe2e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5554,6 +5554,101 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	rcu_read_unlock();
 }
 
+static struct ath12k_link_sta *ath12k_mac_alloc_assign_link_sta(struct ath12k_hw *ah,
+								struct ath12k_sta *ahsta,
+								struct ath12k_vif *ahvif,
+								u8 link_id)
+{
+	struct ath12k_link_sta *arsta;
+	int ret;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+		return NULL;
+
+	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
+	if (arsta)
+		return NULL;
+
+	arsta = kmalloc(sizeof(*arsta), GFP_KERNEL);
+	if (!arsta)
+		return NULL;
+
+	ret = ath12k_mac_assign_link_sta(ah, ahsta, arsta, ahvif, link_id);
+	if (ret) {
+		kfree(arsta);
+		return NULL;
+	}
+
+	return arsta;
+}
+
+static int ath12k_mac_op_change_sta_links(struct ieee80211_hw *hw,
+					  struct ieee80211_vif *vif,
+					  struct ieee80211_sta *sta,
+					  u16 old_links, u16 new_links)
+{
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+	struct ath12k_hw *ah = hw->priv;
+	struct ath12k_link_vif *arvif;
+	struct ath12k_link_sta *arsta;
+	unsigned long valid_links;
+	struct ath12k *ar;
+	u8 link_id;
+	int ret;
+
+	lockdep_assert_wiphy(hw->wiphy);
+
+	if (!sta->valid_links)
+		return -EINVAL;
+
+	/* Firmware does not support removal of one of link stas. All sta
+	 * would be removed during ML STA delete in sta_state(), hence link
+	 * sta removal is not handled here.
+	 */
+	if (new_links < old_links)
+		return 0;
+
+	if (ahsta->ml_peer_id == ATH12K_MLO_PEER_ID_INVALID) {
+		ath12k_hw_warn(ah, "unable to add link for ml sta %pM", sta->addr);
+		return -EINVAL;
+	}
+
+	/* this op is expected only after initial sta insertion with default link */
+	if (WARN_ON(ahsta->links_map == 0))
+		return -EINVAL;
+
+	valid_links = new_links;
+	for_each_set_bit(link_id, &valid_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		if (ahsta->links_map & BIT(link_id))
+			continue;
+
+		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+		arsta = ath12k_mac_alloc_assign_link_sta(ah, ahsta, ahvif, link_id);
+
+		if (!arvif || !arsta) {
+			ath12k_hw_warn(ah, "Failed to alloc/assign link sta");
+			continue;
+		}
+
+		ar = arvif->ar;
+		if (!ar)
+			continue;
+
+		ret = ath12k_mac_station_add(ar, arvif, arsta);
+		if (ret) {
+			ath12k_warn(ar->ab, "Failed to add station: %pM for VDEV: %d\n",
+				    arsta->addr, arvif->vdev_id);
+			ath12k_mac_free_unassign_link_sta(ah, ahsta, link_id);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int ath12k_conf_tx_uapsd(struct ath12k_link_vif *arvif,
 				u16 ac, bool enable)
 {
@@ -9604,7 +9699,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.sta_statistics			= ath12k_mac_op_sta_statistics,
 	.remain_on_channel              = ath12k_mac_op_remain_on_channel,
 	.cancel_remain_on_channel       = ath12k_mac_op_cancel_remain_on_channel,
-
+	.change_sta_links               = ath12k_mac_op_change_sta_links,
 #ifdef CONFIG_PM
 	.suspend			= ath12k_wow_op_suspend,
 	.resume				= ath12k_wow_op_resume,
-- 
2.39.5


