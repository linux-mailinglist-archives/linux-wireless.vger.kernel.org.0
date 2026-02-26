Return-Path: <linux-wireless+bounces-32216-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEeUOUaToGllkwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32216-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 19:39:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0101ADCF3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 19:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 451513158BD0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B64C332629;
	Thu, 26 Feb 2026 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Zi4EnvUM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2D2C0268
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127377; cv=none; b=kWUsP8S7rQ2U6T1EJdfhekxSxH9PUncwp053488iWTBzcZ7lpW3gQziimRrqZSmf4w2eIb4Qq5+RdX67XjLrICIIrryW+jZ+g0CWRvk1Mb6f5xX3zEmj6047im1ujdRmSxABQSDWHjLmJXQdRY/WjdFkiDrYpRF2AVFbLll4HVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127377; c=relaxed/simple;
	bh=pM3tKWLdiTvzFLmbrsvUhDcp1sc19Hr08Jx2k27/02k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VWeEJCqYdZgtDwsk5TD0gI6Vg/z7gswUBTXHsjzpD8XNCMEkTdBGGAxQF31GlIemesNGG5ZJ/pk9gOEupZjB+rnkUe8fsXGd783UnK7G1Y2CeUHkuVYGyP+1F+wieNyetDIdGh1vGh5k+vGOLjSNtrNFsxaZvDJVt3q02uwatA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Zi4EnvUM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=VZcxz6rS+TUHRgqw9I6MZ9ft/rSfDQNnbg/XSzI/EWo=; t=1772127373; x=1773336973; 
	b=Zi4EnvUMtIKwkJh5CSvTeQI07/T2geLdJZJa+1/44SCdy3ITmEAwfkBOBU/nPeQLSSKc7UzG5ei
	cqaT81+X/Nl9vnkwnVQPVEWK4XrrChw8K3vq4aOo+8S8lP7jRw57qi4P/lOxwXVAZepMH4SUK20Oq
	JAUnOxSt5T5fnbdnJ6O4Lnrh9NyZRoNDZbNQsdngMdeW0uLH+K9/uRC+zhHAwzINKJo1JLXdX/ZCx
	W9LWuE2inpAhrBsyqCRdCivEZVUUCpOgtkHwPL5juqU5J4fpPWSQmMc7OykOQJKfJ4pA8/CbNwCEJ
	bP4PbiF9Or8UXplxU+9T6OwXhvXWZ/PmvXqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vvfHW-00000002W37-0wPQ;
	Thu, 26 Feb 2026 18:36:10 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] wifi: move action code from per-type frame structs
Date: Thu, 26 Feb 2026 18:36:07 +0100
Message-ID: <20260226183607.67e71846b59e.I9a24328e3ffcaae179466a935f1c3345029f9961@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32216-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 2B0101ADCF3
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

The action code actually serves to identify the type of action
frame, so it really isn't part of the per-type structure. Pull
it out and have it in the general action frame format.

In theory, whether or not the action code is present in this
way is up to each category, but all categories that are defined
right now all have that value.

While at it, and since this change requires changing all users,
remove the 'u' and make it an anonymous union in this case, so
that all code using this changes.

Change IEEE80211_MIN_ACTION_SIZE to take an argument which says
how much of the frame is needed, e.g. category, action_code or
the specific frame type that's defined in the union. Again this
also ensures that all code is updated.

In some cases, fix bugs where the SKB length was checked after
having accessed beyond the checked length, in particular in FTM
code, e.g. ieee80211_is_ftm().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: fix public action frame handling
---
 drivers/net/wireless/ath/ath11k/mac.c         |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c         |   4 +-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |   2 +-
 .../wireless/intel/iwlwifi/mld/time_sync.c    |   6 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |   7 +-
 .../wireless/intel/iwlwifi/mvm/time-sync.c    |   6 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c   |  12 +-
 drivers/net/wireless/marvell/mwl8k.c          |   4 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |   2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |  14 +-
 drivers/net/wireless/realtek/rtlwifi/base.c   |  28 ++--
 drivers/net/wireless/realtek/rtlwifi/pci.c    |   2 +-
 include/linux/ieee80211.h                     |  83 +++++-------
 net/mac80211/agg-rx.c                         |  27 ++--
 net/mac80211/agg-tx.c                         |  28 ++--
 net/mac80211/eht.c                            |  21 ++-
 net/mac80211/ht.c                             |  31 ++---
 net/mac80211/ibss.c                           |  18 +--
 net/mac80211/iface.c                          |  18 +--
 net/mac80211/mesh.c                           |  14 +-
 net/mac80211/mesh_hwmp.c                      |  20 ++-
 net/mac80211/mesh_plink.c                     |  21 ++-
 net/mac80211/mlme.c                           |  82 +++++-------
 net/mac80211/rx.c                             | 123 ++++++++----------
 net/mac80211/s1g.c                            |  28 ++--
 net/mac80211/spectmgmt.c                      |  31 ++---
 net/mac80211/tdls.c                           |  29 ++---
 net/mac80211/util.c                           |   5 +-
 net/mac80211/vht.c                            |  10 +-
 31 files changed, 301 insertions(+), 385 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4dfd08b58416..4abdbfb9c595 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6282,10 +6282,10 @@ static int ath11k_mac_mgmt_action_frame_fill_elem_data(struct ath11k_vif *arvif,
 	lockdep_assert_held(&ar->conf_mutex);
 
 	/* make sure category field is present */
-	if (skb->len < IEEE80211_MIN_ACTION_SIZE)
+	if (skb->len < IEEE80211_MIN_ACTION_SIZE(category))
 		return -EINVAL;
 
-	remaining_len = skb->len - IEEE80211_MIN_ACTION_SIZE;
+	remaining_len = skb->len - IEEE80211_MIN_ACTION_SIZE(category);
 	has_protected = ieee80211_has_protected(hdr->frame_control);
 
 	/* In case of SW crypto and hdr protected (PMF), packet will already be encrypted,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 68431a0e128e..4bd0044b1e80 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9117,10 +9117,10 @@ static int ath12k_mac_mgmt_action_frame_fill_elem_data(struct ath12k_link_vif *a
 	lockdep_assert_wiphy(wiphy);
 
 	/* make sure category field is present */
-	if (skb->len < IEEE80211_MIN_ACTION_SIZE)
+	if (skb->len < IEEE80211_MIN_ACTION_SIZE(category))
 		return -EINVAL;
 
-	remaining_len = skb->len - IEEE80211_MIN_ACTION_SIZE;
+	remaining_len = skb->len - IEEE80211_MIN_ACTION_SIZE(category);
 	has_protected = ieee80211_has_protected(hdr->frame_control);
 
 	/* In case of SW crypto and hdr protected (PMF), packet will already be encrypted,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index df045ddf42da..b1231d04fc2c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -104,7 +104,7 @@ static bool ath12k_is_addba_resp_action_code(struct ieee80211_mgmt *mgmt)
 	if (mgmt->u.action.category != WLAN_CATEGORY_BACK)
 		return false;
 
-	if (mgmt->u.action.u.addba_resp.action_code != WLAN_ACTION_ADDBA_RESP)
+	if (mgmt->u.action.action_code != WLAN_ACTION_ADDBA_RESP)
 		return false;
 
 	return true;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/time_sync.c b/drivers/net/wireless/intel/iwlwifi/mld/time_sync.c
index 50799f9bfccb..76880bbae1df 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/time_sync.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/time_sync.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2025 Intel Corporation
+ * Copyright (C) 2025-2026 Intel Corporation
  */
 
 #include "mld.h"
@@ -117,9 +117,9 @@ static bool iwl_mld_is_skb_match(struct sk_buff *skb, u8 *addr, u8 dialog_token)
 	u8 skb_dialog_token;
 
 	if (ieee80211_is_timing_measurement(skb))
-		skb_dialog_token = mgmt->u.action.u.wnm_timing_msr.dialog_token;
+		skb_dialog_token = mgmt->u.action.wnm_timing_msr.dialog_token;
 	else
-		skb_dialog_token = mgmt->u.action.u.ftm.dialog_token;
+		skb_dialog_token = mgmt->u.action.ftm.dialog_token;
 
 	if ((ether_addr_equal(mgmt->sa, addr) ||
 	     ether_addr_equal(mgmt->da, addr)) &&
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index a493ef6bedc3..7227df1c653a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #include <linux/etherdevice.h>
 #include <linux/math64.h>
@@ -1409,8 +1409,7 @@ void iwl_mvm_ftm_lc_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	struct iwl_mvm_loc_entry *entry;
 	const u8 *ies, *lci, *civic, *msr_ie;
 	size_t ies_len, lci_len = 0, civic_len = 0;
-	size_t baselen = IEEE80211_MIN_ACTION_SIZE +
-			 sizeof(mgmt->u.action.u.ftm);
+	size_t baselen = IEEE80211_MIN_ACTION_SIZE(ftm);
 	static const u8 rprt_type_lci = IEEE80211_SPCT_MSR_RPRT_TYPE_LCI;
 	static const u8 rprt_type_civic = IEEE80211_SPCT_MSR_RPRT_TYPE_CIVIC;
 
@@ -1419,7 +1418,7 @@ void iwl_mvm_ftm_lc_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	ies = mgmt->u.action.u.ftm.variable;
+	ies = mgmt->u.action.ftm.variable;
 	ies_len = len - baselen;
 
 	msr_ie = cfg80211_find_ie_match(WLAN_EID_MEASURE_REPORT, ies, ies_len,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
index edae3e24192b..039b4daac73f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022, 2026 Intel Corporation
  */
 
 #include "mvm.h"
@@ -18,9 +18,9 @@ static bool iwl_mvm_is_skb_match(struct sk_buff *skb, u8 *addr, u8 dialog_token)
 	u8 skb_dialog_token;
 
 	if (ieee80211_is_timing_measurement(skb))
-		skb_dialog_token = mgmt->u.action.u.wnm_timing_msr.dialog_token;
+		skb_dialog_token = mgmt->u.action.wnm_timing_msr.dialog_token;
 	else
-		skb_dialog_token = mgmt->u.action.u.ftm.dialog_token;
+		skb_dialog_token = mgmt->u.action.ftm.dialog_token;
 
 	if ((ether_addr_equal(mgmt->sa, addr) ||
 	     ether_addr_equal(mgmt->da, addr)) &&
diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 77a9a6de636d..95fd5a924226 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -755,16 +755,12 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 	switch (action_code) {
 	case WLAN_PUB_ACTION_TDLS_DISCOVER_RES:
 		/* See the layout of 'struct ieee80211_mgmt'. */
-		extra = sizeof(mgmt->u.action.u.tdls_discover_resp) +
-			sizeof(mgmt->u.action.category);
+		extra = IEEE80211_MIN_ACTION_SIZE(tdls_discover_resp) - 24;
 		skb_put(skb, extra);
 		mgmt->u.action.category = WLAN_CATEGORY_PUBLIC;
-		mgmt->u.action.u.tdls_discover_resp.action_code =
-					      WLAN_PUB_ACTION_TDLS_DISCOVER_RES;
-		mgmt->u.action.u.tdls_discover_resp.dialog_token =
-								   dialog_token;
-		mgmt->u.action.u.tdls_discover_resp.capability =
-							     cpu_to_le16(capab);
+		mgmt->u.action.action_code = WLAN_PUB_ACTION_TDLS_DISCOVER_RES;
+		mgmt->u.action.tdls_discover_resp.dialog_token = dialog_token;
+		mgmt->u.action.tdls_discover_resp.capability = cpu_to_le16(capab);
 		/* move back for addr4 */
 		memmove(pos + ETH_ALEN, &mgmt->u.action, extra);
 		/* init address 4 */
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 54d6d00ecdf1..e43614df2164 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -1985,9 +1985,9 @@ mwl8k_txq_xmit(struct ieee80211_hw *hw,
 	 */
 	if (unlikely(ieee80211_is_action(wh->frame_control) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
-	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ &&
+	    mgmt->u.action.action_code == WLAN_ACTION_ADDBA_REQ &&
 	    priv->ap_fw)) {
-		u16 capab = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
+		u16 capab = le16_to_cpu(mgmt->u.action.addba_req.capab);
 		tid = (capab & IEEE80211_ADDBA_PARAM_TID_MASK) >> 2;
 		index = mwl8k_tid_queue_mapping(tid);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 3304b5971be0..38e17f0da1a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -414,8 +414,8 @@ mt76_connac2_mac_write_txwi_80211(struct mt76_dev *dev, __le32 *txwi,
 
 	if (ieee80211_is_action(fc) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
-	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ) {
-		u16 capab = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
+	    mgmt->u.action.action_code == WLAN_ACTION_ADDBA_REQ) {
+		u16 capab = le16_to_cpu(mgmt->u.action.addba_req.capab);
 
 		txwi[5] |= cpu_to_le32(MT_TXD5_ADD_BA);
 		tid = (capab >> 2) & IEEE80211_QOS_CTL_TID_MASK;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 871b67101976..01dfdb687af5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -669,7 +669,7 @@ mt7925_mac_write_txwi_80211(struct mt76_dev *dev, __le32 *txwi,
 
 	if (ieee80211_is_action(fc) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
-	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ)
+	    mgmt->u.action.action_code == WLAN_ACTION_ADDBA_REQ)
 		tid = MT_TX_ADDBA;
 	else if (ieee80211_is_mgmt(hdr->frame_control))
 		tid = MT_TX_NORMAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2560e2f46e89..e78febee9721 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -801,7 +801,7 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 
 	if (ieee80211_is_action(fc) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
-	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ) {
+	    mgmt->u.action.action_code == WLAN_ACTION_ADDBA_REQ) {
 		if (is_mt7990(&dev->mt76))
 			txwi[6] |= cpu_to_le32(FIELD_PREP(MT_TXD6_TID_ADDBA, tid));
 		else
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index f9a527f6a175..7b1080df8dfc 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -5146,10 +5146,10 @@ static void rtl8xxxu_dump_action(struct device *dev,
 	if (!(rtl8xxxu_debug & RTL8XXXU_DEBUG_ACTION))
 		return;
 
-	switch (mgmt->u.action.u.addba_resp.action_code) {
+	switch (mgmt->u.action.action_code) {
 	case WLAN_ACTION_ADDBA_RESP:
-		cap = le16_to_cpu(mgmt->u.action.u.addba_resp.capab);
-		timeout = le16_to_cpu(mgmt->u.action.u.addba_resp.timeout);
+		cap = le16_to_cpu(mgmt->u.action.addba_resp.capab);
+		timeout = le16_to_cpu(mgmt->u.action.addba_resp.timeout);
 		dev_info(dev, "WLAN_ACTION_ADDBA_RESP: "
 			 "timeout %i, tid %02x, buf_size %02x, policy %02x, "
 			 "status %02x\n",
@@ -5157,11 +5157,11 @@ static void rtl8xxxu_dump_action(struct device *dev,
 			 (cap & IEEE80211_ADDBA_PARAM_TID_MASK) >> 2,
 			 (cap & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK) >> 6,
 			 (cap >> 1) & 0x1,
-			 le16_to_cpu(mgmt->u.action.u.addba_resp.status));
+			 le16_to_cpu(mgmt->u.action.addba_resp.status));
 		break;
 	case WLAN_ACTION_ADDBA_REQ:
-		cap = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
-		timeout = le16_to_cpu(mgmt->u.action.u.addba_req.timeout);
+		cap = le16_to_cpu(mgmt->u.action.addba_req.capab);
+		timeout = le16_to_cpu(mgmt->u.action.addba_req.timeout);
 		dev_info(dev, "WLAN_ACTION_ADDBA_REQ: "
 			 "timeout %i, tid %02x, buf_size %02x, policy %02x\n",
 			 timeout,
@@ -5171,7 +5171,7 @@ static void rtl8xxxu_dump_action(struct device *dev,
 		break;
 	default:
 		dev_info(dev, "action frame %02x\n",
-			 mgmt->u.action.u.addba_resp.action_code);
+			 mgmt->u.action.action_code);
 		break;
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index 09e5a16d7252..fdf482233d5e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -1409,7 +1409,7 @@ bool rtl_action_proc(struct ieee80211_hw *hw, struct sk_buff *skb, u8 is_tx)
 				sta_entry =
 					(struct rtl_sta_info *)sta->drv_priv;
 				capab =
-				  le16_to_cpu(mgmt->u.action.u.addba_req.capab);
+				  le16_to_cpu(mgmt->u.action.addba_req.capab);
 				tid = (capab &
 				       IEEE80211_ADDBA_PARAM_TID_MASK) >> 2;
 				if (tid >= MAX_TID_COUNT) {
@@ -2392,35 +2392,35 @@ static struct sk_buff *rtl_make_smps_action(struct ieee80211_hw *hw,
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *action_frame;
 
-	/* 27 = header + category + action + smps mode */
-	skb = dev_alloc_skb(27 + hw->extra_tx_headroom);
+	skb = dev_alloc_skb(IEEE80211_MIN_ACTION_SIZE(ht_smps) +
+			    hw->extra_tx_headroom);
 	if (!skb)
 		return NULL;
 
 	skb_reserve(skb, hw->extra_tx_headroom);
-	action_frame = skb_put_zero(skb, 27);
+	action_frame = skb_put_zero(skb, IEEE80211_MIN_ACTION_SIZE(ht_smps));
 	memcpy(action_frame->da, da, ETH_ALEN);
 	memcpy(action_frame->sa, rtlefuse->dev_addr, ETH_ALEN);
 	memcpy(action_frame->bssid, bssid, ETH_ALEN);
 	action_frame->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 						  IEEE80211_STYPE_ACTION);
 	action_frame->u.action.category = WLAN_CATEGORY_HT;
-	action_frame->u.action.u.ht_smps.action = WLAN_HT_ACTION_SMPS;
+	action_frame->u.action.action_code = WLAN_HT_ACTION_SMPS;
 	switch (smps) {
 	case IEEE80211_SMPS_AUTOMATIC:/* 0 */
 	case IEEE80211_SMPS_NUM_MODES:/* 4 */
 		WARN_ON(1);
 		fallthrough;
 	case IEEE80211_SMPS_OFF:/* 1 */ /*MIMO_PS_NOLIMIT*/
-		action_frame->u.action.u.ht_smps.smps_control =
+		action_frame->u.action.ht_smps.smps_control =
 				WLAN_HT_SMPS_CONTROL_DISABLED;/* 0 */
 		break;
 	case IEEE80211_SMPS_STATIC:/* 2 */ /*MIMO_PS_STATIC*/
-		action_frame->u.action.u.ht_smps.smps_control =
+		action_frame->u.action.ht_smps.smps_control =
 				WLAN_HT_SMPS_CONTROL_STATIC;/* 1 */
 		break;
 	case IEEE80211_SMPS_DYNAMIC:/* 3 */ /*MIMO_PS_DYNAMIC*/
-		action_frame->u.action.u.ht_smps.smps_control =
+		action_frame->u.action.ht_smps.smps_control =
 				WLAN_HT_SMPS_CONTROL_DYNAMIC;/* 3 */
 		break;
 	}
@@ -2519,25 +2519,25 @@ struct sk_buff *rtl_make_del_ba(struct ieee80211_hw *hw,
 	struct ieee80211_mgmt *action_frame;
 	u16 params;
 
-	/* 27 = header + category + action + smps mode */
-	skb = dev_alloc_skb(34 + hw->extra_tx_headroom);
+	skb = dev_alloc_skb(IEEE80211_MIN_ACTION_SIZE(delba) +
+			    hw->extra_tx_headroom);
 	if (!skb)
 		return NULL;
 
 	skb_reserve(skb, hw->extra_tx_headroom);
-	action_frame = skb_put_zero(skb, 34);
+	action_frame = skb_put_zero(skb, IEEE80211_MIN_ACTION_SIZE(delba));
 	memcpy(action_frame->sa, sa, ETH_ALEN);
 	memcpy(action_frame->da, rtlefuse->dev_addr, ETH_ALEN);
 	memcpy(action_frame->bssid, bssid, ETH_ALEN);
 	action_frame->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 						  IEEE80211_STYPE_ACTION);
 	action_frame->u.action.category = WLAN_CATEGORY_BACK;
-	action_frame->u.action.u.delba.action_code = WLAN_ACTION_DELBA;
+	action_frame->u.action.action_code = WLAN_ACTION_DELBA;
 	params = (u16)(1 << 11);	/* bit 11 initiator */
 	params |= (u16)(tid << 12);	/* bit 15:12 TID number */
 
-	action_frame->u.action.u.delba.params = cpu_to_le16(params);
-	action_frame->u.action.u.delba.reason_code =
+	action_frame->u.action.delba.params = cpu_to_le16(params);
+	action_frame->u.action.delba.reason_code =
 		cpu_to_le16(WLAN_REASON_QSTA_TIMEOUT);
 
 	return skb;
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index d080469264cf..19e2ff62d9f1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -507,7 +507,7 @@ static void _rtl_pci_tx_isr(struct ieee80211_hw *hw, int prio)
 		if (ieee80211_is_action(fc)) {
 			struct ieee80211_mgmt *action_frame =
 				(struct ieee80211_mgmt *)skb->data;
-			if (action_frame->u.action.u.ht_smps.action ==
+			if (action_frame->u.action.action_code ==
 			    WLAN_HT_ACTION_SMPS) {
 				dev_kfree_skb(skb);
 				goto tx_status_ok;
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 0aa2fb8f88de..0c5c847f72a8 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1046,31 +1046,28 @@ struct ieee80211_mgmt {
 		} __packed probe_resp;
 		struct {
 			u8 category;
+			u8 action_code;
 			union {
 				struct {
-					u8 action_code;
 					u8 dialog_token;
 					u8 status_code;
 					u8 variable[];
 				} __packed wme_action;
 				struct{
-					u8 action_code;
+					u8 no_fixed_fields[0];
 					u8 variable[];
 				} __packed chan_switch;
 				struct{
-					u8 action_code;
 					struct ieee80211_ext_chansw_ie data;
 					u8 variable[];
 				} __packed ext_chan_switch;
 				struct{
-					u8 action_code;
 					u8 dialog_token;
 					u8 element_id;
 					u8 length;
 					struct ieee80211_msrment_ie msr_elem;
 				} __packed measurement;
 				struct{
-					u8 action_code;
 					u8 dialog_token;
 					__le16 capab;
 					__le16 timeout;
@@ -1079,7 +1076,6 @@ struct ieee80211_mgmt {
 					u8 variable[];
 				} __packed addba_req;
 				struct{
-					u8 action_code;
 					u8 dialog_token;
 					__le16 status;
 					__le16 capab;
@@ -1088,54 +1084,45 @@ struct ieee80211_mgmt {
 					u8 variable[];
 				} __packed addba_resp;
 				struct{
-					u8 action_code;
 					__le16 params;
 					__le16 reason_code;
 				} __packed delba;
 				struct {
-					u8 action_code;
+					u8 no_fixed_fields[0];
 					u8 variable[];
 				} __packed self_prot;
 				struct{
-					u8 action_code;
+					u8 no_fixed_fields[0];
 					u8 variable[];
 				} __packed mesh_action;
 				struct {
-					u8 action;
 					u8 trans_id[WLAN_SA_QUERY_TR_ID_LEN];
 				} __packed sa_query;
 				struct {
-					u8 action;
 					u8 smps_control;
 				} __packed ht_smps;
 				struct {
-					u8 action_code;
 					u8 chanwidth;
 				} __packed ht_notify_cw;
 				struct {
-					u8 action_code;
 					u8 dialog_token;
 					__le16 capability;
 					u8 variable[];
 				} __packed tdls_discover_resp;
 				struct {
-					u8 action_code;
 					u8 operating_mode;
 				} __packed vht_opmode_notif;
 				struct {
-					u8 action_code;
 					u8 membership[WLAN_MEMBERSHIP_LEN];
 					u8 position[WLAN_USER_POSITION_LEN];
 				} __packed vht_group_notif;
 				struct {
-					u8 action_code;
 					u8 dialog_token;
 					u8 tpc_elem_id;
 					u8 tpc_elem_length;
 					struct ieee80211_tpc_report_ie tpc;
 				} __packed tpc_report;
 				struct {
-					u8 action_code;
 					u8 dialog_token;
 					u8 follow_up;
 					u8 tod[6];
@@ -1145,11 +1132,10 @@ struct ieee80211_mgmt {
 					u8 variable[];
 				} __packed ftm;
 				struct {
-					u8 action_code;
+					u8 no_fixed_fields[0];
 					u8 variable[];
 				} __packed s1g;
 				struct {
-					u8 action_code;
 					u8 dialog_token;
 					u8 follow_up;
 					u32 tod;
@@ -1158,41 +1144,37 @@ struct ieee80211_mgmt {
 					u8 max_toa_error;
 				} __packed wnm_timing_msr;
 				struct {
-					u8 action_code;
 					u8 dialog_token;
 					u8 variable[];
 				} __packed ttlm_req;
 				struct {
-					u8 action_code;
 					u8 dialog_token;
 					__le16 status_code;
 					u8 variable[];
 				} __packed ttlm_res;
 				struct {
-					u8 action_code;
+					u8 no_fixed_fields[0];
+					/* no variable fields either */
 				} __packed ttlm_tear_down;
 				struct {
-					u8 action_code;
 					u8 dialog_token;
 					u8 variable[];
 				} __packed ml_reconf_req;
 				struct {
-					u8 action_code;
 					u8 dialog_token;
 					u8 count;
 					u8 variable[];
 				} __packed ml_reconf_resp;
 				struct {
-					u8 action_code;
+					u8 no_fixed_fields[0];
 					u8 variable[];
 				} __packed epcs;
 				struct {
-					u8 action_code;
 					u8 dialog_token;
 					u8 control;
 					u8 variable[];
 				} __packed eml_omn;
-			} u;
+			};
 		} __packed action;
 		DECLARE_FLEX_ARRAY(u8, body); /* Generic frame body */
 	} u;
@@ -1210,8 +1192,7 @@ struct ieee80211_mgmt {
 
 #define BSS_MEMBERSHIP_SELECTOR_MIN	BSS_MEMBERSHIP_SELECTOR_UHR_PHY
 
-/* mgmt header + 1 byte category code */
-#define IEEE80211_MIN_ACTION_SIZE offsetof(struct ieee80211_mgmt, u.action.u)
+#define IEEE80211_MIN_ACTION_SIZE(type)	offsetofend(struct ieee80211_mgmt, u.action.type)
 
 
 /* Management MIC information element (IEEE 802.11w) for CMAC */
@@ -2389,7 +2370,7 @@ static inline bool ieee80211_is_bufferable_mmpdu(struct sk_buff *skb)
 	if (!ieee80211_is_action(fc))
 		return false;
 
-	if (skb->len < offsetofend(typeof(*mgmt), u.action.u.ftm.action_code))
+	if (skb->len < IEEE80211_MIN_ACTION_SIZE(action_code))
 		return true;
 
 	/* action frame - additionally check for non-bufferable FTM */
@@ -2398,8 +2379,8 @@ static inline bool ieee80211_is_bufferable_mmpdu(struct sk_buff *skb)
 	    mgmt->u.action.category != WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION)
 		return true;
 
-	if (mgmt->u.action.u.ftm.action_code == WLAN_PUB_ACTION_FTM_REQUEST ||
-	    mgmt->u.action.u.ftm.action_code == WLAN_PUB_ACTION_FTM_RESPONSE)
+	if (mgmt->u.action.action_code == WLAN_PUB_ACTION_FTM_REQUEST ||
+	    mgmt->u.action.action_code == WLAN_PUB_ACTION_FTM_RESPONSE)
 		return false;
 
 	return true;
@@ -2449,7 +2430,7 @@ static inline bool _ieee80211_is_robust_mgmt_frame(struct ieee80211_hdr *hdr)
  */
 static inline bool ieee80211_is_robust_mgmt_frame(struct sk_buff *skb)
 {
-	if (skb->len < IEEE80211_MIN_ACTION_SIZE)
+	if (skb->len < IEEE80211_MIN_ACTION_SIZE(category))
 		return false;
 	return _ieee80211_is_robust_mgmt_frame((void *)skb->data);
 }
@@ -2465,7 +2446,7 @@ static inline bool ieee80211_is_public_action(struct ieee80211_hdr *hdr,
 {
 	struct ieee80211_mgmt *mgmt = (void *)hdr;
 
-	if (len < IEEE80211_MIN_ACTION_SIZE)
+	if (len < IEEE80211_MIN_ACTION_SIZE(category))
 		return false;
 	if (!ieee80211_is_action(hdr->frame_control))
 		return false;
@@ -2483,13 +2464,14 @@ static inline bool ieee80211_is_public_action(struct ieee80211_hdr *hdr,
 static inline bool
 ieee80211_is_protected_dual_of_public_action(struct sk_buff *skb)
 {
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 	u8 action;
 
 	if (!ieee80211_is_public_action((void *)skb->data, skb->len) ||
-	    skb->len < IEEE80211_MIN_ACTION_SIZE + 1)
+	    skb->len < IEEE80211_MIN_ACTION_SIZE(action_code))
 		return false;
 
-	action = *(u8 *)(skb->data + IEEE80211_MIN_ACTION_SIZE);
+	action = mgmt->u.action.action_code;
 
 	return action != WLAN_PUB_ACTION_20_40_BSS_COEX &&
 		action != WLAN_PUB_ACTION_DSE_REG_LOC_ANN &&
@@ -2528,7 +2510,7 @@ static inline bool _ieee80211_is_group_privacy_action(struct ieee80211_hdr *hdr)
  */
 static inline bool ieee80211_is_group_privacy_action(struct sk_buff *skb)
 {
-	if (skb->len < IEEE80211_MIN_ACTION_SIZE)
+	if (skb->len < IEEE80211_MIN_ACTION_SIZE(category))
 		return false;
 	return _ieee80211_is_group_privacy_action((void *)skb->data);
 }
@@ -2624,8 +2606,7 @@ static inline bool ieee80211_action_contains_tpc(struct sk_buff *skb)
 	if (!ieee80211_is_action(mgmt->frame_control))
 		return false;
 
-	if (skb->len < IEEE80211_MIN_ACTION_SIZE +
-		       sizeof(mgmt->u.action.u.tpc_report))
+	if (skb->len < IEEE80211_MIN_ACTION_SIZE(tpc_report))
 		return false;
 
 	/*
@@ -2644,12 +2625,11 @@ static inline bool ieee80211_action_contains_tpc(struct sk_buff *skb)
 		return false;
 
 	/* both spectrum mgmt and link measurement have same action code */
-	if (mgmt->u.action.u.tpc_report.action_code !=
-	    WLAN_ACTION_SPCT_TPC_RPRT)
+	if (mgmt->u.action.action_code != WLAN_ACTION_SPCT_TPC_RPRT)
 		return false;
 
-	if (mgmt->u.action.u.tpc_report.tpc_elem_id != WLAN_EID_TPC_REPORT ||
-	    mgmt->u.action.u.tpc_report.tpc_elem_length !=
+	if (mgmt->u.action.tpc_report.tpc_elem_id != WLAN_EID_TPC_REPORT ||
+	    mgmt->u.action.tpc_report.tpc_elem_length !=
 	    sizeof(struct ieee80211_tpc_report_ie))
 		return false;
 
@@ -2665,16 +2645,15 @@ static inline bool ieee80211_is_timing_measurement(struct sk_buff *skb)
 {
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 
-	if (skb->len < IEEE80211_MIN_ACTION_SIZE)
+	if (skb->len < IEEE80211_MIN_ACTION_SIZE(wnm_timing_msr))
 		return false;
 
 	if (!ieee80211_is_action(mgmt->frame_control))
 		return false;
 
 	if (mgmt->u.action.category == WLAN_CATEGORY_WNM_UNPROTECTED &&
-	    mgmt->u.action.u.wnm_timing_msr.action_code ==
-		WLAN_UNPROTECTED_WNM_ACTION_TIMING_MEASUREMENT_RESPONSE &&
-	    skb->len >= offsetofend(typeof(*mgmt), u.action.u.wnm_timing_msr))
+	    mgmt->u.action.action_code ==
+			WLAN_UNPROTECTED_WNM_ACTION_TIMING_MEASUREMENT_RESPONSE)
 		return true;
 
 	return false;
@@ -2689,15 +2668,13 @@ static inline bool ieee80211_is_ftm(struct sk_buff *skb)
 {
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 
+	if (skb->len < IEEE80211_MIN_ACTION_SIZE(ftm))
+		return false;
+
 	if (!ieee80211_is_public_action((void *)mgmt, skb->len))
 		return false;
 
-	if (mgmt->u.action.u.ftm.action_code ==
-		WLAN_PUB_ACTION_FTM_RESPONSE &&
-	    skb->len >= offsetofend(typeof(*mgmt), u.action.u.ftm))
-		return true;
-
-	return false;
+	return mgmt->u.action.action_code == WLAN_PUB_ACTION_FTM_RESPONSE;
 }
 
 struct element {
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 7da909d78c68..45e3a5d7b93d 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 
 /**
@@ -251,19 +251,20 @@ static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 	skb_reserve(skb, local->hw.extra_tx_headroom);
 	mgmt = ieee80211_mgmt_ba(skb, da, sdata);
 
-	skb_put(skb, 1 + sizeof(mgmt->u.action.u.addba_resp));
+	skb_put(skb, 2 + sizeof(mgmt->u.action.addba_resp));
 	mgmt->u.action.category = WLAN_CATEGORY_BACK;
-	mgmt->u.action.u.addba_resp.action_code = WLAN_ACTION_ADDBA_RESP;
-	mgmt->u.action.u.addba_resp.dialog_token = dialog_token;
+	mgmt->u.action.action_code = WLAN_ACTION_ADDBA_RESP;
+
+	mgmt->u.action.addba_resp.dialog_token = dialog_token;
 
 	capab = u16_encode_bits(amsdu, IEEE80211_ADDBA_PARAM_AMSDU_MASK);
 	capab |= u16_encode_bits(policy, IEEE80211_ADDBA_PARAM_POLICY_MASK);
 	capab |= u16_encode_bits(tid, IEEE80211_ADDBA_PARAM_TID_MASK);
 	capab |= u16_encode_bits(buf_size, IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK);
 
-	mgmt->u.action.u.addba_resp.capab = cpu_to_le16(capab);
-	mgmt->u.action.u.addba_resp.timeout = cpu_to_le16(timeout);
-	mgmt->u.action.u.addba_resp.status = cpu_to_le16(status);
+	mgmt->u.action.addba_resp.capab = cpu_to_le16(capab);
+	mgmt->u.action.addba_resp.timeout = cpu_to_le16(timeout);
+	mgmt->u.action.addba_resp.status = cpu_to_le16(status);
 
 	if (sta->sta.valid_links || sta->sta.deflink.he_cap.has_he)
 		ieee80211_add_addbaext(skb, req_addba_ext_data, buf_size);
@@ -477,22 +478,22 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 	u8 dialog_token, addba_ext_data;
 
 	/* extract session parameters from addba request frame */
-	dialog_token = mgmt->u.action.u.addba_req.dialog_token;
-	timeout = le16_to_cpu(mgmt->u.action.u.addba_req.timeout);
+	dialog_token = mgmt->u.action.addba_req.dialog_token;
+	timeout = le16_to_cpu(mgmt->u.action.addba_req.timeout);
 	start_seq_num =
-		le16_to_cpu(mgmt->u.action.u.addba_req.start_seq_num) >> 4;
+		le16_to_cpu(mgmt->u.action.addba_req.start_seq_num) >> 4;
 
-	capab = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
+	capab = le16_to_cpu(mgmt->u.action.addba_req.capab);
 	ba_policy = (capab & IEEE80211_ADDBA_PARAM_POLICY_MASK) >> 1;
 	tid = (capab & IEEE80211_ADDBA_PARAM_TID_MASK) >> 2;
 	buf_size = (capab & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK) >> 6;
 
 	addba_ext_data =
 		ieee80211_retrieve_addba_ext_data(sta,
-						  mgmt->u.action.u.addba_req.variable,
+						  mgmt->u.action.addba_req.variable,
 						  len -
 						  offsetof(typeof(*mgmt),
-							   u.action.u.addba_req.variable),
+							   u.action.addba_req.variable),
 						  &buf_size);
 
 	__ieee80211_start_rx_ba_session(sta, dialog_token, timeout,
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index d981b0fc57bf..de68f7da6f39 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -68,7 +68,7 @@ static void ieee80211_send_addba_request(struct sta_info *sta, u16 tid,
 	struct ieee80211_mgmt *mgmt;
 	u16 capab;
 
-	skb = dev_alloc_skb(sizeof(*mgmt) +
+	skb = dev_alloc_skb(IEEE80211_MIN_ACTION_SIZE(addba_req) +
 			    2 + sizeof(struct ieee80211_addba_ext_ie) +
 			    local->hw.extra_tx_headroom);
 	if (!skb)
@@ -77,21 +77,21 @@ static void ieee80211_send_addba_request(struct sta_info *sta, u16 tid,
 	skb_reserve(skb, local->hw.extra_tx_headroom);
 	mgmt = ieee80211_mgmt_ba(skb, sta->sta.addr, sdata);
 
-	skb_put(skb, 1 + sizeof(mgmt->u.action.u.addba_req));
+	skb_put(skb, 2 + sizeof(mgmt->u.action.addba_req));
 
 	mgmt->u.action.category = WLAN_CATEGORY_BACK;
-	mgmt->u.action.u.addba_req.action_code = WLAN_ACTION_ADDBA_REQ;
+	mgmt->u.action.action_code = WLAN_ACTION_ADDBA_REQ;
 
-	mgmt->u.action.u.addba_req.dialog_token = dialog_token;
+	mgmt->u.action.addba_req.dialog_token = dialog_token;
 	capab = IEEE80211_ADDBA_PARAM_AMSDU_MASK;
 	capab |= IEEE80211_ADDBA_PARAM_POLICY_MASK;
 	capab |= u16_encode_bits(tid, IEEE80211_ADDBA_PARAM_TID_MASK);
 	capab |= u16_encode_bits(agg_size, IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK);
 
-	mgmt->u.action.u.addba_req.capab = cpu_to_le16(capab);
+	mgmt->u.action.addba_req.capab = cpu_to_le16(capab);
 
-	mgmt->u.action.u.addba_req.timeout = cpu_to_le16(timeout);
-	mgmt->u.action.u.addba_req.start_seq_num =
+	mgmt->u.action.addba_req.timeout = cpu_to_le16(timeout);
+	mgmt->u.action.addba_req.start_seq_num =
 					cpu_to_le16(start_seq_num << 4);
 
 	if (sta->sta.deflink.he_cap.has_he)
@@ -978,15 +978,15 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(sta->local->hw.wiphy);
 
-	capab = le16_to_cpu(mgmt->u.action.u.addba_resp.capab);
+	capab = le16_to_cpu(mgmt->u.action.addba_resp.capab);
 	amsdu = capab & IEEE80211_ADDBA_PARAM_AMSDU_MASK;
 	tid = u16_get_bits(capab, IEEE80211_ADDBA_PARAM_TID_MASK);
 	buf_size = u16_get_bits(capab, IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK);
 
 	ieee80211_retrieve_addba_ext_data(sta,
-					  mgmt->u.action.u.addba_resp.variable,
+					  mgmt->u.action.addba_resp.variable,
 					  len - offsetof(typeof(*mgmt),
-							 u.action.u.addba_resp.variable),
+							 u.action.addba_resp.variable),
 					  &buf_size);
 
 	buf_size = min(buf_size, local->hw.max_tx_aggregation_subframes);
@@ -999,7 +999,7 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 	if (!tid_tx)
 		return;
 
-	if (mgmt->u.action.u.addba_resp.dialog_token != tid_tx->dialog_token) {
+	if (mgmt->u.action.addba_resp.dialog_token != tid_tx->dialog_token) {
 		ht_dbg(sta->sdata, "wrong addBA response token, %pM tid %d\n",
 		       sta->sta.addr, tid);
 		return;
@@ -1029,7 +1029,7 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 	 * is set to 0, the Buffer Size subfield is set to a value
 	 * of at least 1.
 	 */
-	if (le16_to_cpu(mgmt->u.action.u.addba_resp.status)
+	if (le16_to_cpu(mgmt->u.action.addba_resp.status)
 			== WLAN_STATUS_SUCCESS && buf_size) {
 		if (test_and_set_bit(HT_AGG_STATE_RESPONSE_RECEIVED,
 				     &tid_tx->state)) {
@@ -1046,7 +1046,7 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 		sta->ampdu_mlme.addba_req_num[tid] = 0;
 
 		tid_tx->timeout =
-			le16_to_cpu(mgmt->u.action.u.addba_resp.timeout);
+			le16_to_cpu(mgmt->u.action.addba_resp.timeout);
 
 		if (tid_tx->timeout) {
 			mod_timer(&tid_tx->session_timer,
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 75096b2195d2..ae594e77dbef 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -108,7 +108,7 @@ static void
 ieee80211_send_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 				 struct ieee80211_mgmt *req, int opt_len)
 {
-	int len = offsetofend(struct ieee80211_mgmt, u.action.u.eml_omn);
+	int len = IEEE80211_MIN_ACTION_SIZE(eml_omn);
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_mgmt *mgmt;
 	struct sk_buff *skb;
@@ -127,16 +127,15 @@ ieee80211_send_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 	memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
 
 	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
-	mgmt->u.action.u.eml_omn.action_code =
-		WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF;
-	mgmt->u.action.u.eml_omn.dialog_token =
-		req->u.action.u.eml_omn.dialog_token;
-	mgmt->u.action.u.eml_omn.control = req->u.action.u.eml_omn.control &
+	mgmt->u.action.action_code = WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF;
+	mgmt->u.action.eml_omn.dialog_token =
+		req->u.action.eml_omn.dialog_token;
+	mgmt->u.action.eml_omn.control = req->u.action.eml_omn.control &
 		~(IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE |
 		  IEEE80211_EML_CTRL_INDEV_COEX_ACT);
 	/* Copy optional fields from the received notification frame */
-	memcpy(mgmt->u.action.u.eml_omn.variable,
-	       req->u.action.u.eml_omn.variable, opt_len);
+	memcpy(mgmt->u.action.eml_omn.variable,
+	       req->u.action.eml_omn.variable, opt_len);
 
 	ieee80211_tx_skb(sdata, skb);
 }
@@ -144,14 +143,14 @@ ieee80211_send_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 				    struct sk_buff *skb)
 {
-	int len = offsetofend(struct ieee80211_mgmt, u.action.u.eml_omn);
+	int len = IEEE80211_MIN_ACTION_SIZE(eml_omn);
 	enum nl80211_iftype type = ieee80211_vif_type_p2p(&sdata->vif);
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	const struct wiphy_iftype_ext_capab *ift_ext_capa;
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 	struct ieee80211_local *local = sdata->local;
-	u8 control = mgmt->u.action.u.eml_omn.control;
-	u8 *ptr = mgmt->u.action.u.eml_omn.variable;
+	u8 control = mgmt->u.action.eml_omn.control;
+	u8 *ptr = mgmt->u.action.eml_omn.variable;
 	struct ieee80211_eml_params eml_params = {
 		.link_id = status->link_id,
 	};
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 1c82a28b03de..9e2469a8ce64 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright(c) 2020-2025 Intel Corporation
+ * Copyright(c) 2020-2026 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -462,22 +462,23 @@ void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgmt *mgmt;
 	u16 params;
 
-	skb = dev_alloc_skb(sizeof(*mgmt) + local->hw.extra_tx_headroom);
+	skb = dev_alloc_skb(IEEE80211_MIN_ACTION_SIZE(delba) +
+			    local->hw.extra_tx_headroom);
 	if (!skb)
 		return;
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
 	mgmt = ieee80211_mgmt_ba(skb, da, sdata);
 
-	skb_put(skb, 1 + sizeof(mgmt->u.action.u.delba));
+	skb_put(skb, 2 + sizeof(mgmt->u.action.delba));
 
 	mgmt->u.action.category = WLAN_CATEGORY_BACK;
-	mgmt->u.action.u.delba.action_code = WLAN_ACTION_DELBA;
+	mgmt->u.action.action_code = WLAN_ACTION_DELBA;
 	params = (u16)(initiator << 11); 	/* bit 11 initiator */
 	params |= (u16)(tid << 12); 		/* bit 15:12 TID number */
 
-	mgmt->u.action.u.delba.params = cpu_to_le16(params);
-	mgmt->u.action.u.delba.reason_code = cpu_to_le16(reason_code);
+	mgmt->u.action.delba.params = cpu_to_le16(params);
+	mgmt->u.action.delba.reason_code = cpu_to_le16(reason_code);
 
 	ieee80211_tx_skb(sdata, skb);
 }
@@ -489,14 +490,14 @@ void ieee80211_process_delba(struct ieee80211_sub_if_data *sdata,
 	u16 tid, params;
 	u16 initiator;
 
-	params = le16_to_cpu(mgmt->u.action.u.delba.params);
+	params = le16_to_cpu(mgmt->u.action.delba.params);
 	tid = (params & IEEE80211_DELBA_PARAM_TID_MASK) >> 12;
 	initiator = (params & IEEE80211_DELBA_PARAM_INITIATOR_MASK) >> 11;
 
 	ht_dbg_ratelimited(sdata, "delba from %pM (%s) tid %d reason code %d\n",
 			   mgmt->sa, initiator ? "initiator" : "recipient",
 			   tid,
-			   le16_to_cpu(mgmt->u.action.u.delba.reason_code));
+			   le16_to_cpu(mgmt->u.action.delba.reason_code));
 
 	if (initiator == WLAN_BACK_INITIATOR)
 		__ieee80211_stop_rx_ba_session(sta, tid, WLAN_BACK_INITIATOR, 0,
@@ -530,20 +531,20 @@ int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_tx_info *info;
 	u8 status_link_id = link_id < 0 ? 0 : link_id;
 
-	/* 27 = header + category + action + smps mode */
-	skb = dev_alloc_skb(27 + local->hw.extra_tx_headroom);
+	skb = dev_alloc_skb(IEEE80211_MIN_ACTION_SIZE(ht_smps) +
+			    local->hw.extra_tx_headroom);
 	if (!skb)
 		return -ENOMEM;
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
-	action_frame = skb_put(skb, 27);
+	action_frame = skb_put_zero(skb, IEEE80211_MIN_ACTION_SIZE(ht_smps));
 	memcpy(action_frame->da, da, ETH_ALEN);
 	memcpy(action_frame->sa, sdata->dev->dev_addr, ETH_ALEN);
 	memcpy(action_frame->bssid, bssid, ETH_ALEN);
 	action_frame->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 						  IEEE80211_STYPE_ACTION);
 	action_frame->u.action.category = WLAN_CATEGORY_HT;
-	action_frame->u.action.u.ht_smps.action = WLAN_HT_ACTION_SMPS;
+	action_frame->u.action.action_code = WLAN_HT_ACTION_SMPS;
 	switch (smps) {
 	case IEEE80211_SMPS_AUTOMATIC:
 	case IEEE80211_SMPS_NUM_MODES:
@@ -551,15 +552,15 @@ int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 		smps = IEEE80211_SMPS_OFF;
 		fallthrough;
 	case IEEE80211_SMPS_OFF:
-		action_frame->u.action.u.ht_smps.smps_control =
+		action_frame->u.action.ht_smps.smps_control =
 				WLAN_HT_SMPS_CONTROL_DISABLED;
 		break;
 	case IEEE80211_SMPS_STATIC:
-		action_frame->u.action.u.ht_smps.smps_control =
+		action_frame->u.action.ht_smps.smps_control =
 				WLAN_HT_SMPS_CONTROL_STATIC;
 		break;
 	case IEEE80211_SMPS_DYNAMIC:
-		action_frame->u.action.u.ht_smps.smps_control =
+		action_frame->u.action.ht_smps.smps_control =
 				WLAN_HT_SMPS_CONTROL_DYNAMIC;
 		break;
 	}
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 168f84a1353b..0298272c37ec 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -9,7 +9,7 @@
  * Copyright 2009, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2016 Intel Deutschland GmbH
- * Copyright(c) 2018-2025 Intel Corporation
+ * Copyright(c) 2018-2026 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -888,19 +888,11 @@ ieee80211_rx_mgmt_spectrum_mgmt(struct ieee80211_sub_if_data *sdata,
 				struct ieee80211_rx_status *rx_status,
 				struct ieee802_11_elems *elems)
 {
-	int required_len;
-
-	if (len < IEEE80211_MIN_ACTION_SIZE + 1)
+	if (len < IEEE80211_MIN_ACTION_SIZE(chan_switch))
 		return;
 
 	/* CSA is the only action we handle for now */
-	if (mgmt->u.action.u.measurement.action_code !=
-	    WLAN_ACTION_SPCT_CHL_SWITCH)
-		return;
-
-	required_len = IEEE80211_MIN_ACTION_SIZE +
-		       sizeof(mgmt->u.action.u.chan_switch);
-	if (len < required_len)
+	if (mgmt->u.action.action_code != WLAN_ACTION_SPCT_CHL_SWITCH)
 		return;
 
 	if (!sdata->vif.bss_conf.csa_active)
@@ -1613,12 +1605,12 @@ void ieee80211_ibss_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 		case WLAN_CATEGORY_SPECTRUM_MGMT:
 			ies_len = skb->len -
 				  offsetof(struct ieee80211_mgmt,
-					   u.action.u.chan_switch.variable);
+					   u.action.chan_switch.variable);
 
 			if (ies_len < 0)
 				break;
 
-			elems = ieee802_11_parse_elems(mgmt->u.action.u.chan_switch.variable,
+			elems = ieee802_11_parse_elems(mgmt->u.action.chan_switch.variable,
 						       ies_len,
 						       IEEE80211_FTYPE_MGMT |
 						       IEEE80211_STYPE_ACTION,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 676b2a43c9f2..2e391cec73a0 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1579,7 +1579,7 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 
 		sta = sta_info_get_bss(sdata, mgmt->sa);
 		if (sta) {
-			switch (mgmt->u.action.u.addba_req.action_code) {
+			switch (mgmt->u.action.action_code) {
 			case WLAN_ACTION_ADDBA_REQ:
 				ieee80211_process_addba_request(local, sta,
 								mgmt, len);
@@ -1599,9 +1599,9 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 		}
 	} else if (ieee80211_is_action(mgmt->frame_control) &&
 		   mgmt->u.action.category == WLAN_CATEGORY_HT) {
-		switch (mgmt->u.action.u.ht_smps.action) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_HT_ACTION_NOTIFY_CHANWIDTH: {
-			u8 chanwidth = mgmt->u.action.u.ht_notify_cw.chanwidth;
+			u8 chanwidth = mgmt->u.action.ht_notify_cw.chanwidth;
 			struct ieee80211_rx_status *status;
 			struct link_sta_info *link_sta;
 			struct sta_info *sta;
@@ -1628,7 +1628,7 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 		}
 	} else if (ieee80211_is_action(mgmt->frame_control) &&
 		   mgmt->u.action.category == WLAN_CATEGORY_VHT) {
-		switch (mgmt->u.action.u.vht_group_notif.action_code) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_VHT_ACTION_OPMODE_NOTIF: {
 			struct ieee80211_rx_status *status;
 			enum nl80211_band band;
@@ -1637,7 +1637,7 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 
 			status = IEEE80211_SKB_RXCB(skb);
 			band = status->band;
-			opmode = mgmt->u.action.u.vht_opmode_notif.operating_mode;
+			opmode = mgmt->u.action.vht_opmode_notif.operating_mode;
 
 			sta = sta_info_get_bss(sdata, mgmt->sa);
 
@@ -1658,7 +1658,7 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 		}
 	} else if (ieee80211_is_action(mgmt->frame_control) &&
 		   mgmt->u.action.category == WLAN_CATEGORY_S1G) {
-		switch (mgmt->u.action.u.s1g.action_code) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_S1G_TWT_TEARDOWN:
 		case WLAN_S1G_TWT_SETUP:
 			ieee80211_s1g_rx_twt_action(sdata, skb);
@@ -1669,7 +1669,7 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 	} else if (ieee80211_is_action(mgmt->frame_control) &&
 		   mgmt->u.action.category == WLAN_CATEGORY_PROTECTED_EHT) {
 		if (sdata->vif.type == NL80211_IFTYPE_AP) {
-			switch (mgmt->u.action.u.eml_omn.action_code) {
+			switch (mgmt->u.action.action_code) {
 			case WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF:
 				ieee80211_rx_eml_op_mode_notif(sdata, skb);
 				break;
@@ -1677,7 +1677,7 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 				break;
 			}
 		} else if (sdata->vif.type == NL80211_IFTYPE_STATION) {
-			switch (mgmt->u.action.u.ttlm_req.action_code) {
+			switch (mgmt->u.action.action_code) {
 			case WLAN_PROTECTED_EHT_ACTION_TTLM_REQ:
 				ieee80211_process_neg_ttlm_req(sdata, mgmt,
 							       skb->len);
@@ -1765,7 +1765,7 @@ static void ieee80211_iface_process_status(struct ieee80211_sub_if_data *sdata,
 
 	if (ieee80211_is_action(mgmt->frame_control) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_S1G) {
-		switch (mgmt->u.action.u.s1g.action_code) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_S1G_TWT_TEARDOWN:
 		case WLAN_S1G_TWT_SETUP:
 			ieee80211_s1g_status_twt_action(sdata, skb);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 68901f1def0d..ccbf33fb23bd 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2018 - 2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  * Authors:    Luis Carlos Cobo <luisca@cozybit.com>
  * 	       Javier Cardona <javier@cozybit.com>
  */
@@ -19,8 +19,7 @@ static struct kmem_cache *rm_cache;
 
 bool mesh_action_is_path_sel(struct ieee80211_mgmt *mgmt)
 {
-	return (mgmt->u.action.u.mesh_action.action_code ==
-			WLAN_MESH_ACTION_HWMP_PATH_SELECTION);
+	return mgmt->u.action.action_code == WLAN_MESH_ACTION_HWMP_PATH_SELECTION;
 }
 
 void ieee80211s_init(void)
@@ -1619,13 +1618,12 @@ static void mesh_rx_csa_frame(struct ieee80211_sub_if_data *sdata,
 	size_t baselen;
 	u8 *pos;
 
-	if (mgmt->u.action.u.measurement.action_code !=
-	    WLAN_ACTION_SPCT_CHL_SWITCH)
+	if (mgmt->u.action.action_code != WLAN_ACTION_SPCT_CHL_SWITCH)
 		return;
 
-	pos = mgmt->u.action.u.chan_switch.variable;
+	pos = mgmt->u.action.chan_switch.variable;
 	baselen = offsetof(struct ieee80211_mgmt,
-			   u.action.u.chan_switch.variable);
+			   u.action.chan_switch.variable);
 	elems = ieee802_11_parse_elems(pos, len - baselen,
 				       IEEE80211_FTYPE_MGMT |
 				       IEEE80211_STYPE_ACTION,
@@ -1668,7 +1666,7 @@ static void ieee80211_mesh_rx_mgmt_action(struct ieee80211_sub_if_data *sdata,
 {
 	switch (mgmt->u.action.category) {
 	case WLAN_CATEGORY_SELF_PROTECTED:
-		switch (mgmt->u.action.u.self_prot.action_code) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_SP_MESH_PEERING_OPEN:
 		case WLAN_SP_MESH_PEERING_CLOSE:
 		case WLAN_SP_MESH_PEERING_CONFIRM:
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index a41b57bd11ff..dad311e0833a 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2019, 2021-2023, 2025 Intel Corporation
+ * Copyright (C) 2019, 2021-2023, 2025-2026 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 
@@ -105,12 +105,11 @@ static int mesh_path_sel_frame_tx(enum mpath_frame_type action, u8 flags,
 				  u32 lifetime, u32 metric, u32 preq_id,
 				  struct ieee80211_sub_if_data *sdata)
 {
+	int hdr_len = IEEE80211_MIN_ACTION_SIZE(mesh_action);
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *mgmt;
 	u8 *pos, ie_len;
-	int hdr_len = offsetofend(struct ieee80211_mgmt,
-				  u.action.u.mesh_action);
 
 	skb = dev_alloc_skb(local->tx_headroom +
 			    hdr_len +
@@ -127,8 +126,7 @@ static int mesh_path_sel_frame_tx(enum mpath_frame_type action, u8 flags,
 	/* BSSID == SA */
 	memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
 	mgmt->u.action.category = WLAN_CATEGORY_MESH_ACTION;
-	mgmt->u.action.u.mesh_action.action_code =
-					WLAN_MESH_ACTION_HWMP_PATH_SELECTION;
+	mgmt->u.action.action_code = WLAN_MESH_ACTION_HWMP_PATH_SELECTION;
 
 	switch (action) {
 	case MPATH_PREQ:
@@ -237,13 +235,12 @@ int mesh_path_error_tx(struct ieee80211_sub_if_data *sdata,
 		       u8 ttl, const u8 *target, u32 target_sn,
 		       u16 target_rcode, const u8 *ra)
 {
+	int hdr_len = IEEE80211_MIN_ACTION_SIZE(mesh_action);
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	struct ieee80211_mgmt *mgmt;
 	u8 *pos, ie_len;
-	int hdr_len = offsetofend(struct ieee80211_mgmt,
-				  u.action.u.mesh_action);
 
 	if (time_before(jiffies, ifmsh->next_perr))
 		return -EAGAIN;
@@ -265,8 +262,7 @@ int mesh_path_error_tx(struct ieee80211_sub_if_data *sdata,
 	/* BSSID == SA */
 	memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
 	mgmt->u.action.category = WLAN_CATEGORY_MESH_ACTION;
-	mgmt->u.action.u.mesh_action.action_code =
-					WLAN_MESH_ACTION_HWMP_PATH_SELECTION;
+	mgmt->u.action.action_code = WLAN_MESH_ACTION_HWMP_PATH_SELECTION;
 	ie_len = 15;
 	pos = skb_put(skb, 2 + ie_len);
 	*pos++ = WLAN_EID_PERR;
@@ -938,7 +934,7 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 	struct sta_info *sta;
 
 	/* need action_code */
-	if (len < IEEE80211_MIN_ACTION_SIZE + 1)
+	if (len < IEEE80211_MIN_ACTION_SIZE(mesh_action))
 		return;
 
 	rcu_read_lock();
@@ -949,8 +945,8 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 	}
 	rcu_read_unlock();
 
-	baselen = (u8 *) mgmt->u.action.u.mesh_action.variable - (u8 *) mgmt;
-	elems = ieee802_11_parse_elems(mgmt->u.action.u.mesh_action.variable,
+	baselen = mgmt->u.action.mesh_action.variable - (u8 *)mgmt;
+	elems = ieee802_11_parse_elems(mgmt->u.action.mesh_action.variable,
 				       len - baselen,
 				       IEEE80211_FTYPE_MGMT |
 				       IEEE80211_STYPE_ACTION,
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 04c931cd2063..7d823a55636f 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2019, 2021-2025 Intel Corporation
+ * Copyright (C) 2019, 2021-2026 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 #include <linux/gfp.h>
@@ -13,7 +13,7 @@
 #include "rate.h"
 #include "mesh.h"
 
-#define PLINK_CNF_AID(mgmt) ((mgmt)->u.action.u.self_prot.variable + 2)
+#define PLINK_CNF_AID(mgmt) ((mgmt)->u.action.self_prot.variable + 2)
 #define PLINK_GET_LLID(p) (p + 2)
 #define PLINK_GET_PLID(p) (p + 4)
 
@@ -215,6 +215,7 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 			       enum ieee80211_self_protected_actioncode action,
 			       u8 *da, u16 llid, u16 plid, u16 reason)
 {
+	int hdr_len = IEEE80211_MIN_ACTION_SIZE(self_prot);
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
 	struct ieee80211_tx_info *info;
@@ -223,7 +224,6 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 	u16 peering_proto = 0;
 	u8 *pos, ie_len = 4;
 	u8 ie_len_he_cap, ie_len_eht_cap;
-	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.self_prot);
 	int err = -ENOMEM;
 
 	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata);
@@ -260,7 +260,7 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
 	memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
 	mgmt->u.action.category = WLAN_CATEGORY_SELF_PROTECTED;
-	mgmt->u.action.u.self_prot.action_code = action;
+	mgmt->u.action.action_code = action;
 
 	if (action != WLAN_SP_MESH_PEERING_CLOSE) {
 		struct ieee80211_supported_band *sband;
@@ -1141,7 +1141,7 @@ mesh_process_plink_frame(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	ftype = mgmt->u.action.u.self_prot.action_code;
+	ftype = mgmt->u.action.action_code;
 	if ((ftype == WLAN_SP_MESH_PEERING_OPEN && ie_len != 4) ||
 	    (ftype == WLAN_SP_MESH_PEERING_CONFIRM && ie_len != 6) ||
 	    (ftype == WLAN_SP_MESH_PEERING_CLOSE && ie_len != 6
@@ -1224,8 +1224,8 @@ void mesh_rx_plink_frame(struct ieee80211_sub_if_data *sdata,
 	size_t baselen;
 	u8 *baseaddr;
 
-	/* need action_code, aux */
-	if (len < IEEE80211_MIN_ACTION_SIZE + 3)
+	/* need aux */
+	if (len < IEEE80211_MIN_ACTION_SIZE(self_prot) + 1)
 		return;
 
 	if (sdata->u.mesh.user_mpm)
@@ -1238,10 +1238,9 @@ void mesh_rx_plink_frame(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	baseaddr = mgmt->u.action.u.self_prot.variable;
-	baselen = (u8 *) mgmt->u.action.u.self_prot.variable - (u8 *) mgmt;
-	if (mgmt->u.action.u.self_prot.action_code ==
-						WLAN_SP_MESH_PEERING_CONFIRM) {
+	baseaddr = mgmt->u.action.self_prot.variable;
+	baselen = mgmt->u.action.self_prot.variable - (u8 *)mgmt;
+	if (mgmt->u.action.action_code == WLAN_SP_MESH_PEERING_CONFIRM) {
 		baseaddr += 4;
 		baselen += 4;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e83582b2c377..995855d49822 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7897,7 +7897,7 @@ ieee80211_send_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_mgmt *mgmt;
 	struct sk_buff *skb;
-	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.ttlm_req);
+	int hdr_len = IEEE80211_MIN_ACTION_SIZE(ttlm_req);
 	int ttlm_max_len = 2 + 1 + sizeof(struct ieee80211_ttlm_elem) + 1 +
 		2 * 2 * IEEE80211_TTLM_NUM_TIDS;
 
@@ -7914,9 +7914,8 @@ ieee80211_send_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
 	memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
 
 	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
-	mgmt->u.action.u.ttlm_req.action_code =
-		WLAN_PROTECTED_EHT_ACTION_TTLM_REQ;
-	mgmt->u.action.u.ttlm_req.dialog_token = dialog_token;
+	mgmt->u.action.action_code = WLAN_PROTECTED_EHT_ACTION_TTLM_REQ;
+	mgmt->u.action.ttlm_req.dialog_token = dialog_token;
 	ieee80211_neg_ttlm_add_suggested_map(skb, neg_ttlm);
 	ieee80211_tx_skb(sdata, skb);
 }
@@ -7966,7 +7965,7 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_mgmt *mgmt;
 	struct sk_buff *skb;
-	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.ttlm_res);
+	int hdr_len = IEEE80211_MIN_ACTION_SIZE(ttlm_res);
 	int ttlm_max_len = 2 + 1 + sizeof(struct ieee80211_ttlm_elem) + 1 +
 		2 * 2 * IEEE80211_TTLM_NUM_TIDS;
 	u16 status_code;
@@ -7984,9 +7983,8 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 	memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
 
 	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
-	mgmt->u.action.u.ttlm_res.action_code =
-		WLAN_PROTECTED_EHT_ACTION_TTLM_RES;
-	mgmt->u.action.u.ttlm_res.dialog_token = dialog_token;
+	mgmt->u.action.action_code = WLAN_PROTECTED_EHT_ACTION_TTLM_RES;
+	mgmt->u.action.ttlm_res.dialog_token = dialog_token;
 	switch (ttlm_res) {
 	default:
 		WARN_ON(1);
@@ -8003,7 +8001,7 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	mgmt->u.action.u.ttlm_res.status_code = cpu_to_le16(status_code);
+	mgmt->u.action.ttlm_res.status_code = cpu_to_le16(status_code);
 	ieee80211_tx_skb(sdata, skb);
 }
 
@@ -8103,10 +8101,9 @@ void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
 	if (!ieee80211_vif_is_mld(&sdata->vif))
 		return;
 
-	dialog_token = mgmt->u.action.u.ttlm_req.dialog_token;
-	ies_len  = len - offsetof(struct ieee80211_mgmt,
-				  u.action.u.ttlm_req.variable);
-	elems = ieee802_11_parse_elems(mgmt->u.action.u.ttlm_req.variable,
+	dialog_token = mgmt->u.action.ttlm_req.dialog_token;
+	ies_len  = len - IEEE80211_MIN_ACTION_SIZE(ttlm_req);
+	elems = ieee802_11_parse_elems(mgmt->u.action.ttlm_req.variable,
 				       ies_len,
 				       IEEE80211_FTYPE_MGMT |
 				       IEEE80211_STYPE_ACTION,
@@ -8157,8 +8154,7 @@ void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_mgmt *mgmt, size_t len)
 {
 	if (!ieee80211_vif_is_mld(&sdata->vif) ||
-	    mgmt->u.action.u.ttlm_req.dialog_token !=
-	    sdata->u.mgd.dialog_token_alloc)
+	    mgmt->u.action.ttlm_res.dialog_token != sdata->u.mgd.dialog_token_alloc)
 		return;
 
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
@@ -8172,7 +8168,7 @@ void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 	 * This can be better implemented in the future, to handle request
 	 * rejections.
 	 */
-	if (le16_to_cpu(mgmt->u.action.u.ttlm_res.status_code) != WLAN_STATUS_SUCCESS)
+	if (le16_to_cpu(mgmt->u.action.ttlm_res.status_code) != WLAN_STATUS_SUCCESS)
 		__ieee80211_disconnect(sdata);
 }
 
@@ -8205,12 +8201,11 @@ static void ieee80211_teardown_ttlm_work(struct wiphy *wiphy,
 
 void ieee80211_send_teardown_neg_ttlm(struct ieee80211_vif *vif)
 {
+	int frame_len = IEEE80211_MIN_ACTION_SIZE(ttlm_tear_down);
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_mgmt *mgmt;
 	struct sk_buff *skb;
-	int frame_len = offsetofend(struct ieee80211_mgmt,
-				  u.action.u.ttlm_tear_down);
 	struct ieee80211_tx_info *info;
 
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom + frame_len);
@@ -8226,8 +8221,7 @@ void ieee80211_send_teardown_neg_ttlm(struct ieee80211_vif *vif)
 	memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
 
 	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
-	mgmt->u.action.u.ttlm_tear_down.action_code =
-		WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN;
+	mgmt->u.action.action_code = WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN;
 
 	info = IEEE80211_SKB_CB(skb);
 	info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
@@ -8310,13 +8304,13 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 		case WLAN_CATEGORY_SPECTRUM_MGMT:
 			ies_len = skb->len -
 				  offsetof(struct ieee80211_mgmt,
-					   u.action.u.chan_switch.variable);
+					   u.action.chan_switch.variable);
 
 			if (ies_len < 0)
 				break;
 
 			/* CSA IE cannot be overridden, no need for BSSID */
-			elems = ieee802_11_parse_elems(mgmt->u.action.u.chan_switch.variable,
+			elems = ieee802_11_parse_elems(mgmt->u.action.chan_switch.variable,
 						       ies_len,
 						       IEEE80211_FTYPE_MGMT |
 						       IEEE80211_STYPE_ACTION,
@@ -8338,7 +8332,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 		case WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION:
 			ies_len = skb->len -
 				  offsetof(struct ieee80211_mgmt,
-					   u.action.u.ext_chan_switch.variable);
+					   u.action.ext_chan_switch.variable);
 
 			if (ies_len < 0)
 				break;
@@ -8347,7 +8341,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 			 * extended CSA IE can't be overridden, no need for
 			 * BSSID
 			 */
-			elems = ieee802_11_parse_elems(mgmt->u.action.u.ext_chan_switch.variable,
+			elems = ieee802_11_parse_elems(mgmt->u.action.ext_chan_switch.variable,
 						       ies_len,
 						       IEEE80211_FTYPE_MGMT |
 						       IEEE80211_STYPE_ACTION,
@@ -8364,7 +8358,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 
 				/* for the handling code pretend it was an IE */
 				elems->ext_chansw_ie =
-					&mgmt->u.action.u.ext_chan_switch.data;
+					&mgmt->u.action.ext_chan_switch.data;
 
 				ieee80211_sta_process_chanswitch(link,
 								 rx_status->mactime,
@@ -10356,25 +10350,25 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 	u8 *pos;
 
 	if (!ieee80211_vif_is_mld(&sdata->vif) ||
-	    len < offsetofend(typeof(*mgmt), u.action.u.ml_reconf_resp) ||
-	    mgmt->u.action.u.ml_reconf_resp.dialog_token !=
-	    sdata->u.mgd.reconf.dialog_token ||
+	    len < IEEE80211_MIN_ACTION_SIZE(ml_reconf_resp) ||
+	    mgmt->u.action.ml_reconf_resp.dialog_token !=
+		sdata->u.mgd.reconf.dialog_token ||
 	    !sta_changed_links)
 		return;
 
-	pos = mgmt->u.action.u.ml_reconf_resp.variable;
-	len -= offsetofend(typeof(*mgmt), u.action.u.ml_reconf_resp);
+	pos = mgmt->u.action.ml_reconf_resp.variable;
+	len -= offsetofend(typeof(*mgmt), u.action.ml_reconf_resp);
 
 	/* each status duple is 3 octets */
-	if (len < mgmt->u.action.u.ml_reconf_resp.count * 3) {
+	if (len < mgmt->u.action.ml_reconf_resp.count * 3) {
 		sdata_info(sdata,
 			   "mlo: reconf: unexpected len=%zu, count=%u\n",
-			   len, mgmt->u.action.u.ml_reconf_resp.count);
+			   len, mgmt->u.action.ml_reconf_resp.count);
 		goto disconnect;
 	}
 
 	link_mask = sta_changed_links;
-	for (i = 0; i < mgmt->u.action.u.ml_reconf_resp.count; i++) {
+	for (i = 0; i < mgmt->u.action.ml_reconf_resp.count; i++) {
 		u16 status = get_unaligned_le16(pos + 1);
 
 		link_id = *pos;
@@ -10659,8 +10653,7 @@ ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
 		return NULL;
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
-	mgmt = skb_put_zero(skb, offsetofend(struct ieee80211_mgmt,
-					     u.action.u.ml_reconf_req));
+	mgmt = skb_put_zero(skb, IEEE80211_MIN_ACTION_SIZE(ml_reconf_req));
 
 	/* Add the MAC header */
 	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
@@ -10671,12 +10664,11 @@ ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
 
 	/* Add the action frame fixed fields */
 	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
-	mgmt->u.action.u.ml_reconf_req.action_code =
-		WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_REQ;
+	mgmt->u.action.action_code = WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_REQ;
 
 	/* allocate a dialog token and store it */
 	sdata->u.mgd.reconf.dialog_token = ++sdata->u.mgd.dialog_token_alloc;
-	mgmt->u.action.u.ml_reconf_req.dialog_token =
+	mgmt->u.action.ml_reconf_req.dialog_token =
 		sdata->u.mgd.reconf.dialog_token;
 
 	/* Add the ML reconfiguration element and the common information  */
@@ -11046,11 +11038,10 @@ static bool ieee80211_mgd_epcs_supp(struct ieee80211_sub_if_data *sdata)
 
 int ieee80211_mgd_set_epcs(struct ieee80211_sub_if_data *sdata, bool enable)
 {
+	int frame_len = IEEE80211_MIN_ACTION_SIZE(epcs) + (enable ? 1 : 0);
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_mgmt *mgmt;
 	struct sk_buff *skb;
-	int frame_len = offsetofend(struct ieee80211_mgmt,
-				    u.action.u.epcs) + (enable ? 1 : 0);
 
 	if (!ieee80211_mgd_epcs_supp(sdata))
 		return -EINVAL;
@@ -11079,15 +11070,15 @@ int ieee80211_mgd_set_epcs(struct ieee80211_sub_if_data *sdata, bool enable)
 
 	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
 	if (enable) {
-		u8 *pos = mgmt->u.action.u.epcs.variable;
+		u8 *pos = mgmt->u.action.epcs.variable;
 
-		mgmt->u.action.u.epcs.action_code =
+		mgmt->u.action.action_code =
 			WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_REQ;
 
 		*pos = ++sdata->u.mgd.dialog_token_alloc;
 		sdata->u.mgd.epcs.dialog_token = *pos;
 	} else {
-		mgmt->u.action.u.epcs.action_code =
+		mgmt->u.action.action_code =
 			WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_TEARDOWN;
 
 		ieee80211_epcs_teardown(sdata);
@@ -11176,7 +11167,7 @@ void ieee80211_process_epcs_ena_resp(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	/* Handle dialog token and status code */
-	pos = mgmt->u.action.u.epcs.variable;
+	pos = mgmt->u.action.epcs.variable;
 	dialog_token = *pos;
 	status_code = get_unaligned_le16(pos + 1);
 
@@ -11198,8 +11189,7 @@ void ieee80211_process_epcs_ena_resp(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	pos += IEEE80211_EPCS_ENA_RESP_BODY_LEN;
-	ies_len = len - offsetof(struct ieee80211_mgmt,
-				 u.action.u.epcs.variable) -
+	ies_len = len - IEEE80211_MIN_ACTION_SIZE(epcs) -
 		IEEE80211_EPCS_ENA_RESP_BODY_LEN;
 
 	elems = ieee802_11_parse_elems(pos, ies_len,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 11d6c56c9d7e..7537ad4e1529 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -274,7 +274,7 @@ static void ieee80211_handle_mu_mimo_mon(struct ieee80211_sub_if_data *sdata,
 	if (!sdata)
 		return;
 
-	BUILD_BUG_ON(sizeof(action) != IEEE80211_MIN_ACTION_SIZE + 1);
+	BUILD_BUG_ON(sizeof(action) != IEEE80211_MIN_ACTION_SIZE(action_code));
 
 	if (skb->len < rtap_space + sizeof(action) +
 		       VHT_MUMIMO_GROUPS_DATA_LEN)
@@ -1162,7 +1162,7 @@ static ieee80211_rx_result ieee80211_rx_mesh_check(struct ieee80211_rx_data *rx)
 			u8 category;
 
 			/* make sure category field is present */
-			if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE)
+			if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE(category))
 				return RX_DROP_U_RUNT_ACTION;
 
 			mgmt = (struct ieee80211_mgmt *)hdr;
@@ -3422,7 +3422,7 @@ static void ieee80211_process_sa_query_req(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	if (len < 24 + 1 + sizeof(resp->u.action.u.sa_query)) {
+	if (len < IEEE80211_MIN_ACTION_SIZE(sa_query)) {
 		/* Too short SA Query request frame */
 		return;
 	}
@@ -3432,17 +3432,16 @@ static void ieee80211_process_sa_query_req(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
-	resp = skb_put_zero(skb, 24);
+	resp = skb_put_zero(skb, IEEE80211_MIN_ACTION_SIZE(sa_query));
 	memcpy(resp->da, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	memcpy(resp->sa, sdata->vif.addr, ETH_ALEN);
 	memcpy(resp->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	resp->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 					  IEEE80211_STYPE_ACTION);
-	skb_put(skb, 1 + sizeof(resp->u.action.u.sa_query));
 	resp->u.action.category = WLAN_CATEGORY_SA_QUERY;
-	resp->u.action.u.sa_query.action = WLAN_ACTION_SA_QUERY_RESPONSE;
-	memcpy(resp->u.action.u.sa_query.trans_id,
-	       mgmt->u.action.u.sa_query.trans_id,
+	resp->u.action.action_code = WLAN_ACTION_SA_QUERY_RESPONSE;
+	memcpy(resp->u.action.sa_query.trans_id,
+	       mgmt->u.action.sa_query.trans_id,
 	       WLAN_SA_QUERY_TR_ID_LEN);
 
 	ieee80211_tx_skb(sdata, skb);
@@ -3516,7 +3515,7 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 
 	/* drop too small action frames */
 	if (ieee80211_is_action(mgmt->frame_control) &&
-	    rx->skb->len < IEEE80211_MIN_ACTION_SIZE)
+	    rx->skb->len < IEEE80211_MIN_ACTION_SIZE(category))
 		return RX_DROP_U_RUNT_ACTION;
 
 	/* Drop non-broadcast Beacon frames */
@@ -3565,29 +3564,28 @@ ieee80211_process_rx_twt_action(struct ieee80211_rx_data *rx)
 	if (!rx->sta)
 		return false;
 
-	switch (mgmt->u.action.u.s1g.action_code) {
+	switch (mgmt->u.action.action_code) {
 	case WLAN_S1G_TWT_SETUP: {
 		struct ieee80211_twt_setup *twt;
 
-		if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE +
-				   1 + /* action code */
+		if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE(action_code) +
 				   sizeof(struct ieee80211_twt_setup) +
 				   2 /* TWT req_type agrt */)
 			break;
 
-		twt = (void *)mgmt->u.action.u.s1g.variable;
+		twt = (void *)mgmt->u.action.s1g.variable;
 		if (twt->element_id != WLAN_EID_S1G_TWT)
 			break;
 
-		if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE +
-				   4 + /* action code + token + tlv */
+		if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE(action_code) +
+				   3 + /* token + tlv */
 				   twt->length)
 			break;
 
 		return true; /* queue the frame */
 	}
 	case WLAN_S1G_TWT_TEARDOWN:
-		if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE + 2)
+		if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE(action_code) + 1)
 			break;
 
 		return true; /* queue the frame */
@@ -3632,10 +3630,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 
 		/* verify action & smps_control/chanwidth are present */
-		if (len < IEEE80211_MIN_ACTION_SIZE + 2)
+		if (len < IEEE80211_MIN_ACTION_SIZE(ht_smps))
 			goto invalid;
 
-		switch (mgmt->u.action.u.ht_smps.action) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_HT_ACTION_SMPS: {
 			struct ieee80211_supported_band *sband;
 			enum ieee80211_smps_mode smps_mode;
@@ -3646,7 +3644,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 				goto handled;
 
 			/* convert to HT capability */
-			switch (mgmt->u.action.u.ht_smps.smps_control) {
+			switch (mgmt->u.action.ht_smps.smps_control) {
 			case WLAN_HT_SMPS_CONTROL_DISABLED:
 				smps_mode = IEEE80211_SMPS_OFF;
 				break;
@@ -3679,7 +3677,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			goto handled;
 		}
 		case WLAN_HT_ACTION_NOTIFY_CHANWIDTH: {
-			u8 chanwidth = mgmt->u.action.u.ht_notify_cw.chanwidth;
+			u8 chanwidth = mgmt->u.action.ht_notify_cw.chanwidth;
 
 			if (chanwidth != IEEE80211_HT_CHANWIDTH_20MHZ &&
 			    chanwidth != IEEE80211_HT_CHANWIDTH_ANY)
@@ -3699,7 +3697,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 		break;
 	case WLAN_CATEGORY_PUBLIC:
 	case WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION:
-		if (len < IEEE80211_MIN_ACTION_SIZE + 1)
+		if (len < IEEE80211_MIN_ACTION_SIZE(action_code))
 			goto invalid;
 		if (sdata->vif.type != NL80211_IFTYPE_STATION)
 			break;
@@ -3707,11 +3705,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 		if (!ether_addr_equal(mgmt->bssid, sdata->deflink.u.mgd.bssid))
 			break;
-		if (mgmt->u.action.u.ext_chan_switch.action_code !=
+		if (mgmt->u.action.action_code !=
 				WLAN_PUB_ACTION_EXT_CHANSW_ANN)
 			break;
-		if (len < offsetof(struct ieee80211_mgmt,
-				   u.action.u.ext_chan_switch.variable))
+		if (len < IEEE80211_MIN_ACTION_SIZE(ext_chan_switch))
 			goto invalid;
 		goto queue;
 	case WLAN_CATEGORY_VHT:
@@ -3723,18 +3720,18 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 
 		/* verify action code is present */
-		if (len < IEEE80211_MIN_ACTION_SIZE + 1)
+		if (len < IEEE80211_MIN_ACTION_SIZE(action_code))
 			goto invalid;
 
-		switch (mgmt->u.action.u.vht_opmode_notif.action_code) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_VHT_ACTION_OPMODE_NOTIF: {
 			/* verify opmode is present */
-			if (len < IEEE80211_MIN_ACTION_SIZE + 2)
+			if (len < IEEE80211_MIN_ACTION_SIZE(vht_opmode_notif))
 				goto invalid;
 			goto queue;
 		}
 		case WLAN_VHT_ACTION_GROUPID_MGMT: {
-			if (len < IEEE80211_MIN_ACTION_SIZE + 25)
+			if (len < IEEE80211_MIN_ACTION_SIZE(vht_group_notif))
 				goto invalid;
 			goto queue;
 		}
@@ -3751,23 +3748,20 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 
 		/* verify action_code is present */
-		if (len < IEEE80211_MIN_ACTION_SIZE + 1)
+		if (len < IEEE80211_MIN_ACTION_SIZE(action_code))
 			break;
 
-		switch (mgmt->u.action.u.addba_req.action_code) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_ACTION_ADDBA_REQ:
-			if (len < (IEEE80211_MIN_ACTION_SIZE +
-				   sizeof(mgmt->u.action.u.addba_req)))
+			if (len < IEEE80211_MIN_ACTION_SIZE(addba_req))
 				goto invalid;
 			break;
 		case WLAN_ACTION_ADDBA_RESP:
-			if (len < (IEEE80211_MIN_ACTION_SIZE +
-				   sizeof(mgmt->u.action.u.addba_resp)))
+			if (len < IEEE80211_MIN_ACTION_SIZE(addba_resp))
 				goto invalid;
 			break;
 		case WLAN_ACTION_DELBA:
-			if (len < (IEEE80211_MIN_ACTION_SIZE +
-				   sizeof(mgmt->u.action.u.delba)))
+			if (len < IEEE80211_MIN_ACTION_SIZE(delba))
 				goto invalid;
 			break;
 		default:
@@ -3777,16 +3771,15 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 		goto queue;
 	case WLAN_CATEGORY_SPECTRUM_MGMT:
 		/* verify action_code is present */
-		if (len < IEEE80211_MIN_ACTION_SIZE + 1)
+		if (len < IEEE80211_MIN_ACTION_SIZE(action_code))
 			break;
 
-		switch (mgmt->u.action.u.measurement.action_code) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_ACTION_SPCT_MSR_REQ:
 			if (status->band != NL80211_BAND_5GHZ)
 				break;
 
-			if (len < (IEEE80211_MIN_ACTION_SIZE +
-				   sizeof(mgmt->u.action.u.measurement)))
+			if (len < IEEE80211_MIN_ACTION_SIZE(measurement))
 				break;
 
 			if (sdata->vif.type != NL80211_IFTYPE_STATION)
@@ -3796,8 +3789,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			goto handled;
 		case WLAN_ACTION_SPCT_CHL_SWITCH: {
 			u8 *bssid;
-			if (len < (IEEE80211_MIN_ACTION_SIZE +
-				   sizeof(mgmt->u.action.u.chan_switch)))
+			if (len < IEEE80211_MIN_ACTION_SIZE(chan_switch))
 				break;
 
 			if (sdata->vif.type != NL80211_IFTYPE_STATION &&
@@ -3822,11 +3814,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 		}
 		break;
 	case WLAN_CATEGORY_SELF_PROTECTED:
-		if (len < (IEEE80211_MIN_ACTION_SIZE +
-			   sizeof(mgmt->u.action.u.self_prot.action_code)))
+		if (len < IEEE80211_MIN_ACTION_SIZE(self_prot))
 			break;
 
-		switch (mgmt->u.action.u.self_prot.action_code) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_SP_MESH_PEERING_OPEN:
 		case WLAN_SP_MESH_PEERING_CLOSE:
 		case WLAN_SP_MESH_PEERING_CONFIRM:
@@ -3844,8 +3835,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 		}
 		break;
 	case WLAN_CATEGORY_MESH_ACTION:
-		if (len < (IEEE80211_MIN_ACTION_SIZE +
-			   sizeof(mgmt->u.action.u.mesh_action.action_code)))
+		if (len < IEEE80211_MIN_ACTION_SIZE(action_code))
 			break;
 
 		if (!ieee80211_vif_is_mesh(&sdata->vif))
@@ -3855,11 +3845,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 		goto queue;
 	case WLAN_CATEGORY_S1G:
-		if (len < offsetofend(typeof(*mgmt),
-				      u.action.u.s1g.action_code))
+		if (len < IEEE80211_MIN_ACTION_SIZE(action_code))
 			break;
 
-		switch (mgmt->u.action.u.s1g.action_code) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_S1G_TWT_SETUP:
 		case WLAN_S1G_TWT_TEARDOWN:
 			if (ieee80211_process_rx_twt_action(rx))
@@ -3870,33 +3859,29 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 		}
 		break;
 	case WLAN_CATEGORY_PROTECTED_EHT:
-		if (len < offsetofend(typeof(*mgmt),
-				      u.action.u.ttlm_req.action_code))
+		if (len < IEEE80211_MIN_ACTION_SIZE(action_code))
 			break;
 
-		switch (mgmt->u.action.u.ttlm_req.action_code) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_PROTECTED_EHT_ACTION_TTLM_REQ:
 			if (sdata->vif.type != NL80211_IFTYPE_STATION)
 				break;
 
-			if (len < offsetofend(typeof(*mgmt),
-					      u.action.u.ttlm_req))
+			if (len < IEEE80211_MIN_ACTION_SIZE(ttlm_req))
 				goto invalid;
 			goto queue;
 		case WLAN_PROTECTED_EHT_ACTION_TTLM_RES:
 			if (sdata->vif.type != NL80211_IFTYPE_STATION)
 				break;
 
-			if (len < offsetofend(typeof(*mgmt),
-					      u.action.u.ttlm_res))
+			if (len < IEEE80211_MIN_ACTION_SIZE(ttlm_res))
 				goto invalid;
 			goto queue;
 		case WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN:
 			if (sdata->vif.type != NL80211_IFTYPE_STATION)
 				break;
 
-			if (len < offsetofend(typeof(*mgmt),
-					      u.action.u.ttlm_tear_down))
+			if (len < IEEE80211_MIN_ACTION_SIZE(ttlm_tear_down))
 				goto invalid;
 			goto queue;
 		case WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_RESP:
@@ -3906,34 +3891,29 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			/* The reconfiguration response action frame must
 			 * least one 'Status Duple' entry (3 octets)
 			 */
-			if (len <
-			    offsetofend(typeof(*mgmt),
-					u.action.u.ml_reconf_resp) + 3)
+			if (len < IEEE80211_MIN_ACTION_SIZE(ml_reconf_resp) + 3)
 				goto invalid;
 			goto queue;
 		case WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_RESP:
 			if (sdata->vif.type != NL80211_IFTYPE_STATION)
 				break;
 
-			if (len < offsetofend(typeof(*mgmt),
-					      u.action.u.epcs) +
-			    IEEE80211_EPCS_ENA_RESP_BODY_LEN)
+			if (len < IEEE80211_MIN_ACTION_SIZE(epcs) +
+				  IEEE80211_EPCS_ENA_RESP_BODY_LEN)
 				goto invalid;
 			goto queue;
 		case WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_TEARDOWN:
 			if (sdata->vif.type != NL80211_IFTYPE_STATION)
 				break;
 
-			if (len < offsetofend(typeof(*mgmt),
-					      u.action.u.epcs))
+			if (len < IEEE80211_MIN_ACTION_SIZE(epcs))
 				goto invalid;
 			goto queue;
 		case WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF:
 			if (sdata->vif.type != NL80211_IFTYPE_AP)
 				break;
 
-			if (len < offsetofend(typeof(*mgmt),
-					      u.action.u.eml_omn))
+			if (len < IEEE80211_MIN_ACTION_SIZE(eml_omn))
 				goto invalid;
 			goto queue;
 		default:
@@ -4015,11 +3995,10 @@ ieee80211_rx_h_action_post_userspace(struct ieee80211_rx_data *rx)
 
 	switch (mgmt->u.action.category) {
 	case WLAN_CATEGORY_SA_QUERY:
-		if (len < (IEEE80211_MIN_ACTION_SIZE +
-			   sizeof(mgmt->u.action.u.sa_query)))
+		if (len < IEEE80211_MIN_ACTION_SIZE(sa_query))
 			break;
 
-		switch (mgmt->u.action.u.sa_query.action) {
+		switch (mgmt->u.action.action_code) {
 		case WLAN_ACTION_SA_QUERY_REQUEST:
 			if (sdata->vif.type != NL80211_IFTYPE_STATION)
 				break;
diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
index 1f68df6e8067..297abaa6fecf 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -2,7 +2,7 @@
 /*
  * S1G handling
  * Copyright(c) 2020 Adapt-IP
- * Copyright (C) 2023 Intel Corporation
+ * Copyright (C) 2023, 2026 Intel Corporation
  */
 #include <linux/ieee80211.h>
 #include <net/mac80211.h>
@@ -27,14 +27,14 @@ bool ieee80211_s1g_is_twt_setup(struct sk_buff *skb)
 	if (likely(mgmt->u.action.category != WLAN_CATEGORY_S1G))
 		return false;
 
-	return mgmt->u.action.u.s1g.action_code == WLAN_S1G_TWT_SETUP;
+	return mgmt->u.action.action_code == WLAN_S1G_TWT_SETUP;
 }
 
 static void
 ieee80211_s1g_send_twt_setup(struct ieee80211_sub_if_data *sdata, const u8 *da,
 			     const u8 *bssid, struct ieee80211_twt_setup *twt)
 {
-	int len = IEEE80211_MIN_ACTION_SIZE + 4 + twt->length;
+	int len = IEEE80211_MIN_ACTION_SIZE(s1g) + 3 + twt->length;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_mgmt *mgmt;
 	struct sk_buff *skb;
@@ -52,8 +52,8 @@ ieee80211_s1g_send_twt_setup(struct ieee80211_sub_if_data *sdata, const u8 *da,
 	memcpy(mgmt->bssid, bssid, ETH_ALEN);
 
 	mgmt->u.action.category = WLAN_CATEGORY_S1G;
-	mgmt->u.action.u.s1g.action_code = WLAN_S1G_TWT_SETUP;
-	memcpy(mgmt->u.action.u.s1g.variable, twt, 3 + twt->length);
+	mgmt->u.action.action_code = WLAN_S1G_TWT_SETUP;
+	memcpy(mgmt->u.action.s1g.variable, twt, 3 + twt->length);
 
 	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT |
 					IEEE80211_TX_INTFL_MLME_CONN_TX |
@@ -71,12 +71,12 @@ ieee80211_s1g_send_twt_teardown(struct ieee80211_sub_if_data *sdata,
 	u8 *id;
 
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom +
-			    IEEE80211_MIN_ACTION_SIZE + 2);
+			    IEEE80211_MIN_ACTION_SIZE(s1g) + 1);
 	if (!skb)
 		return;
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
-	mgmt = skb_put_zero(skb, IEEE80211_MIN_ACTION_SIZE + 2);
+	mgmt = skb_put_zero(skb, IEEE80211_MIN_ACTION_SIZE(s1g) + 1);
 	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 					  IEEE80211_STYPE_ACTION);
 	memcpy(mgmt->da, da, ETH_ALEN);
@@ -84,8 +84,8 @@ ieee80211_s1g_send_twt_teardown(struct ieee80211_sub_if_data *sdata,
 	memcpy(mgmt->bssid, bssid, ETH_ALEN);
 
 	mgmt->u.action.category = WLAN_CATEGORY_S1G;
-	mgmt->u.action.u.s1g.action_code = WLAN_S1G_TWT_TEARDOWN;
-	id = (u8 *)mgmt->u.action.u.s1g.variable;
+	mgmt->u.action.action_code = WLAN_S1G_TWT_TEARDOWN;
+	id = (u8 *)mgmt->u.action.s1g.variable;
 	*id = flowid;
 
 	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT |
@@ -98,7 +98,7 @@ ieee80211_s1g_rx_twt_setup(struct ieee80211_sub_if_data *sdata,
 			   struct sta_info *sta, struct sk_buff *skb)
 {
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
-	struct ieee80211_twt_setup *twt = (void *)mgmt->u.action.u.s1g.variable;
+	struct ieee80211_twt_setup *twt = (void *)mgmt->u.action.s1g.variable;
 	struct ieee80211_twt_params *twt_agrt = (void *)twt->params;
 
 	twt_agrt->req_type &= cpu_to_le16(~IEEE80211_TWT_REQTYPE_REQUEST);
@@ -128,7 +128,7 @@ ieee80211_s1g_rx_twt_teardown(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
 
 	drv_twt_teardown_request(sdata->local, sdata, &sta->sta,
-				 mgmt->u.action.u.s1g.variable[0]);
+				 mgmt->u.action.s1g.variable[0]);
 }
 
 static void
@@ -136,7 +136,7 @@ ieee80211_s1g_tx_twt_setup_fail(struct ieee80211_sub_if_data *sdata,
 				struct sta_info *sta, struct sk_buff *skb)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
-	struct ieee80211_twt_setup *twt = (void *)mgmt->u.action.u.s1g.variable;
+	struct ieee80211_twt_setup *twt = (void *)mgmt->u.action.s1g.variable;
 	struct ieee80211_twt_params *twt_agrt = (void *)twt->params;
 	u8 flowid = le16_get_bits(twt_agrt->req_type,
 				  IEEE80211_TWT_REQTYPE_FLOWID);
@@ -160,7 +160,7 @@ void ieee80211_s1g_rx_twt_action(struct ieee80211_sub_if_data *sdata,
 	if (!sta)
 		return;
 
-	switch (mgmt->u.action.u.s1g.action_code) {
+	switch (mgmt->u.action.action_code) {
 	case WLAN_S1G_TWT_SETUP:
 		ieee80211_s1g_rx_twt_setup(sdata, sta, skb);
 		break;
@@ -185,7 +185,7 @@ void ieee80211_s1g_status_twt_action(struct ieee80211_sub_if_data *sdata,
 	if (!sta)
 		return;
 
-	switch (mgmt->u.action.u.s1g.action_code) {
+	switch (mgmt->u.action.action_code) {
 	case WLAN_S1G_TWT_SETUP:
 		/* process failed twt setup frames */
 		ieee80211_s1g_tx_twt_setup_fail(sdata, sta, skb);
diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index 7422888d3640..e2eaf8d8d7ff 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2008, Intel Corporation
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018, 2020, 2022-2024 Intel Corporation
+ * Copyright (C) 2018, 2020, 2022-2024, 2026 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -409,35 +409,30 @@ static void ieee80211_send_refuse_measurement_request(struct ieee80211_sub_if_da
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *msr_report;
 
-	skb = dev_alloc_skb(sizeof(*msr_report) + local->hw.extra_tx_headroom +
-				sizeof(struct ieee80211_msrment_ie));
+	skb = dev_alloc_skb(IEEE80211_MIN_ACTION_SIZE(measurement) +
+			    local->hw.extra_tx_headroom);
 	if (!skb)
 		return;
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
-	msr_report = skb_put_zero(skb, 24);
+	msr_report = skb_put_zero(skb, IEEE80211_MIN_ACTION_SIZE(measurement));
 	memcpy(msr_report->da, da, ETH_ALEN);
 	memcpy(msr_report->sa, sdata->vif.addr, ETH_ALEN);
 	memcpy(msr_report->bssid, bssid, ETH_ALEN);
 	msr_report->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 						IEEE80211_STYPE_ACTION);
 
-	skb_put(skb, 1 + sizeof(msr_report->u.action.u.measurement));
 	msr_report->u.action.category = WLAN_CATEGORY_SPECTRUM_MGMT;
-	msr_report->u.action.u.measurement.action_code =
-				WLAN_ACTION_SPCT_MSR_RPRT;
-	msr_report->u.action.u.measurement.dialog_token = dialog_token;
+	msr_report->u.action.action_code = WLAN_ACTION_SPCT_MSR_RPRT;
 
-	msr_report->u.action.u.measurement.element_id = WLAN_EID_MEASURE_REPORT;
-	msr_report->u.action.u.measurement.length =
+	msr_report->u.action.measurement.dialog_token = dialog_token;
+	msr_report->u.action.measurement.element_id = WLAN_EID_MEASURE_REPORT;
+	msr_report->u.action.measurement.length =
 			sizeof(struct ieee80211_msrment_ie);
-
-	memset(&msr_report->u.action.u.measurement.msr_elem, 0,
-		sizeof(struct ieee80211_msrment_ie));
-	msr_report->u.action.u.measurement.msr_elem.token = request_ie->token;
-	msr_report->u.action.u.measurement.msr_elem.mode |=
+	msr_report->u.action.measurement.msr_elem.token = request_ie->token;
+	msr_report->u.action.measurement.msr_elem.mode |=
 			IEEE80211_SPCT_MSR_RPRT_MODE_REFUSED;
-	msr_report->u.action.u.measurement.msr_elem.type = request_ie->type;
+	msr_report->u.action.measurement.msr_elem.type = request_ie->type;
 
 	ieee80211_tx_skb(sdata, skb);
 }
@@ -454,7 +449,7 @@ void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
 	 * TODO: Answer basic measurement as unmeasured
 	 */
 	ieee80211_send_refuse_measurement_request(sdata,
-			&mgmt->u.action.u.measurement.msr_elem,
+			&mgmt->u.action.measurement.msr_elem,
 			mgmt->sa, mgmt->bssid,
-			mgmt->u.action.u.measurement.dialog_token);
+			mgmt->u.action.measurement.dialog_token);
 }
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index dbbfe2d6842f..1f30a4eda374 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -6,7 +6,7 @@
  * Copyright 2014, Intel Corporation
  * Copyright 2014  Intel Mobile Communications GmbH
  * Copyright 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2019, 2021-2025 Intel Corporation
+ * Copyright (C) 2019, 2021-2026 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -879,28 +879,23 @@ ieee80211_prep_tdls_direct(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_mgmt *mgmt;
 
-	mgmt = skb_put_zero(skb, 24);
+	if (action_code != WLAN_PUB_ACTION_TDLS_DISCOVER_RES)
+		return -EINVAL;
+
+	mgmt = skb_put_zero(skb, IEEE80211_MIN_ACTION_SIZE(tdls_discover_resp));
 	memcpy(mgmt->da, peer, ETH_ALEN);
 	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
 	memcpy(mgmt->bssid, link->u.mgd.bssid, ETH_ALEN);
 	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 					  IEEE80211_STYPE_ACTION);
 
-	switch (action_code) {
-	case WLAN_PUB_ACTION_TDLS_DISCOVER_RES:
-		skb_put(skb, 1 + sizeof(mgmt->u.action.u.tdls_discover_resp));
-		mgmt->u.action.category = WLAN_CATEGORY_PUBLIC;
-		mgmt->u.action.u.tdls_discover_resp.action_code =
-			WLAN_PUB_ACTION_TDLS_DISCOVER_RES;
-		mgmt->u.action.u.tdls_discover_resp.dialog_token =
-			dialog_token;
-		mgmt->u.action.u.tdls_discover_resp.capability =
-			cpu_to_le16(ieee80211_get_tdls_sta_capab(link,
-								 status_code));
-		break;
-	default:
-		return -EINVAL;
-	}
+	mgmt->u.action.category = WLAN_CATEGORY_PUBLIC;
+	mgmt->u.action.action_code = WLAN_PUB_ACTION_TDLS_DISCOVER_RES;
+
+	mgmt->u.action.tdls_discover_resp.dialog_token = dialog_token;
+	mgmt->u.action.tdls_discover_resp.capability =
+		cpu_to_le16(ieee80211_get_tdls_sta_capab(link,
+							 status_code));
 
 	return 0;
 }
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a5e09c0fa6b3..f44d9cb35b0e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3768,12 +3768,11 @@ void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
 			      struct cfg80211_csa_settings *csa_settings)
 {
+	int hdr_len = IEEE80211_MIN_ACTION_SIZE(chan_switch);
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *mgmt;
 	struct ieee80211_local *local = sdata->local;
 	int freq;
-	int hdr_len = offsetofend(struct ieee80211_mgmt,
-				  u.action.u.chan_switch);
 	u8 *pos;
 
 	if (sdata->vif.type != NL80211_IFTYPE_ADHOC &&
@@ -3802,7 +3801,7 @@ int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
 		memcpy(mgmt->bssid, ifibss->bssid, ETH_ALEN);
 	}
 	mgmt->u.action.category = WLAN_CATEGORY_SPECTRUM_MGMT;
-	mgmt->u.action.u.chan_switch.action_code = WLAN_ACTION_SPCT_CHL_SWITCH;
+	mgmt->u.action.action_code = WLAN_ACTION_SPCT_CHL_SWITCH;
 	pos = skb_put(skb, 5);
 	*pos++ = WLAN_EID_CHANNEL_SWITCH;			/* EID */
 	*pos++ = 3;						/* IE length */
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index b099d79e8fbb..80120f9f17b6 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -4,7 +4,7 @@
  *
  * Portions of this file
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -723,17 +723,17 @@ void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
 	if (!link_conf->mu_mimo_owner)
 		return;
 
-	if (!memcmp(mgmt->u.action.u.vht_group_notif.position,
+	if (!memcmp(mgmt->u.action.vht_group_notif.position,
 		    link_conf->mu_group.position, WLAN_USER_POSITION_LEN) &&
-	    !memcmp(mgmt->u.action.u.vht_group_notif.membership,
+	    !memcmp(mgmt->u.action.vht_group_notif.membership,
 		    link_conf->mu_group.membership, WLAN_MEMBERSHIP_LEN))
 		return;
 
 	memcpy(link_conf->mu_group.membership,
-	       mgmt->u.action.u.vht_group_notif.membership,
+	       mgmt->u.action.vht_group_notif.membership,
 	       WLAN_MEMBERSHIP_LEN);
 	memcpy(link_conf->mu_group.position,
-	       mgmt->u.action.u.vht_group_notif.position,
+	       mgmt->u.action.vht_group_notif.position,
 	       WLAN_USER_POSITION_LEN);
 
 	ieee80211_link_info_change_notify(sdata, link,
-- 
2.53.0


