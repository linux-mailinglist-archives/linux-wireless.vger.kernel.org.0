Return-Path: <linux-wireless+bounces-25139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8D7AFF32B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED24A5653CE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D662253920;
	Wed,  9 Jul 2025 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rlv/HLlh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7DA2512E6
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093518; cv=none; b=o+lHYFGBoo+o4eMSPr+8CSehtIQlWRTCkC4ERAqN1oPV6MrfcmUsCvmDhuqq16g7V3/CF/90fQp1A4FqF9tHiwibv+vbIAyvQ+xqk4lOS6rGTs1UV0IZODM6x6uB1FMH972UBxep+FfgxUzVrgUOBtUAXeK4oTPVjOSaWu0cuqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093518; c=relaxed/simple;
	bh=PKm5sn2vl+qZkH5eqbbSiA2Z6TB1C4WF7qj24sqZ6Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etkaMERLQ/9H/CstonE2QPtspoP6lVYsQ+UvHILoPgfuFky6w03DiEpKpZShBpHt5NFW0bIcfAUuXUMCCxAyXP7VwQQmELQSzzKrwAyHLY+Geb2AsProcFXq1z9vNIGQrfNEvDH4sCg52d4MY4Benm8XjK0J0jIxznyK9FbMNH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rlv/HLlh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093516; x=1783629516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PKm5sn2vl+qZkH5eqbbSiA2Z6TB1C4WF7qj24sqZ6Vo=;
  b=Rlv/HLlhNKM+MT9VEnKtap+dy8+PJbyOFW9Fk5cZrddJrJBFeQzOR9dN
   c/H7dJNNj8JGjNkohpS/eAY70yM5THMHNlfn2V8xHE/R60HAfkAFj5cmJ
   1ijSf03M15bK/9o/zT5OdihTYz7C7GXuMcFX5jnSiLYSkmNU+Wt+uuVsH
   e/YXdteRuS8LsFskjdNz9fCFpKT2iv4KvzSzxxqZnmm6Sao1pbFqfmEit
   RkD7/eJ+TzDZJSCcJTdytHZc9s555SIZkHP1mUWF+bG1jws0RXIbaIiHa
   So7/Rjo+tcCHJnKNPYkXHB1qF1VNMGAIujd+gTP3RkZJeP7+33AXyB1Ty
   A==;
X-CSE-ConnectionGUID: GKjKWJoLTX+MLdj079ejDQ==
X-CSE-MsgGUID: wmS/UOm3RAKe1vtbGL2VDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974459"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974459"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:36 -0700
X-CSE-ConnectionGUID: ZoL+qbroTXi2A8uhw2cpxA==
X-CSE-MsgGUID: lNWxLit9TQi0YxG9/Dzr/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161533206"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 10/11] wifi: mac80211: handle WLAN_HT_ACTION_NOTIFY_CHANWIDTH async
Date: Wed,  9 Jul 2025 23:38:02 +0300
Message-Id: <20250709233537.bb9dc6f36c35.I39782d6077424e075974c3bee4277761494a1527@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
References: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If this action frame, with the value of IEEE80211_HT_CHANWIDTH_ANY,
arrives right after a beacon that changed the operational bandwidth from
20 MHz to 40 MHz, then updating the rate control bandwidth to 40 can
race with updating the chanctx width (that happens in the beacon
proccesing) back to 40 MHz:

cpu0					cpu1

ieee80211_rx_mgmt_beacon
ieee80211_config_bw
ieee80211_link_change_chanreq
(*)ieee80211_link_update_chanreq
					ieee80211_rx_h_action
					(**)ieee80211_sta_cur_vht_bw
(***) ieee80211_recalc_chanctx_chantype

in (**), the maximum between the capability width and the bss width is
returned. But the bss width was just updated to 40 in (*),
so the action frame handling code will increase the width of the rate
control before the chanctx was increased (in ***), leading to a FW error
(at least in iwlwifi driver. But this is wrong regardless).

Fix this by simply handling the action frame async, so it won't race
with the beacon proccessing.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218632
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ht.c          | 40 +++++++++++++++++++++++++++++++++++++-
 net/mac80211/ieee80211_i.h |  6 ++++++
 net/mac80211/iface.c       | 29 +++++++++++++++++++++++++++
 net/mac80211/rx.c          | 35 ++++++---------------------------
 4 files changed, 80 insertions(+), 30 deletions(-)

diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 32390d8a9d75..1c82a28b03de 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright(c) 2020-2024 Intel Corporation
+ * Copyright(c) 2020-2025 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -603,3 +603,41 @@ void ieee80211_request_smps(struct ieee80211_vif *vif, unsigned int link_id,
 }
 /* this might change ... don't want non-open drivers using it */
 EXPORT_SYMBOL_GPL(ieee80211_request_smps);
+
+void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
+					 struct ieee80211_sub_if_data *sdata,
+					 struct sta_info *sta,
+					 struct link_sta_info *link_sta,
+					 u8 chanwidth, enum nl80211_band band)
+{
+	enum ieee80211_sta_rx_bandwidth max_bw, new_bw;
+	struct ieee80211_supported_band *sband;
+	struct sta_opmode_info sta_opmode = {};
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (chanwidth == IEEE80211_HT_CHANWIDTH_20MHZ)
+		max_bw = IEEE80211_STA_RX_BW_20;
+	else
+		max_bw = ieee80211_sta_cap_rx_bw(link_sta);
+
+	/* set cur_max_bandwidth and recalc sta bw */
+	link_sta->cur_max_bandwidth = max_bw;
+	new_bw = ieee80211_sta_cur_vht_bw(link_sta);
+
+	if (link_sta->pub->bandwidth == new_bw)
+		return;
+
+	link_sta->pub->bandwidth = new_bw;
+	sband = local->hw.wiphy->bands[band];
+	sta_opmode.bw =
+		ieee80211_sta_rx_bw_to_chan_width(link_sta);
+	sta_opmode.changed = STA_OPMODE_MAX_BW_CHANGED;
+
+	rate_control_rate_update(local, sband, link_sta,
+				 IEEE80211_RC_BW_CHANGED);
+	cfg80211_sta_opmode_change_notify(sdata->dev,
+					  sta->addr,
+					  &sta_opmode,
+					  GFP_KERNEL);
+}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2a482089f9e1..83172eb964c8 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2204,6 +2204,12 @@ u8 ieee80211_mcs_to_chains(const struct ieee80211_mcs_info *mcs);
 enum nl80211_smps_mode
 ieee80211_smps_mode_to_smps_mode(enum ieee80211_smps_mode smps);
 
+void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
+					 struct ieee80211_sub_if_data *sdata,
+					 struct sta_info *sta,
+					 struct link_sta_info *link_sta,
+					 u8 chanwidth, enum nl80211_band band);
+
 /* VHT */
 void
 ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7b2baebb8644..0b5cfe3a5ebe 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1554,6 +1554,35 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 				break;
 			}
 		}
+	} else if (ieee80211_is_action(mgmt->frame_control) &&
+		   mgmt->u.action.category == WLAN_CATEGORY_HT) {
+		switch (mgmt->u.action.u.ht_smps.action) {
+		case WLAN_HT_ACTION_NOTIFY_CHANWIDTH: {
+			u8 chanwidth = mgmt->u.action.u.ht_notify_cw.chanwidth;
+			struct ieee80211_rx_status *status;
+			struct link_sta_info *link_sta;
+			struct sta_info *sta;
+
+			sta = sta_info_get_bss(sdata, mgmt->sa);
+			if (!sta)
+				break;
+
+			status = IEEE80211_SKB_RXCB(skb);
+			if (!status->link_valid)
+				link_sta = &sta->deflink;
+			else
+				link_sta = rcu_dereference_protected(sta->link[status->link_id],
+							lockdep_is_held(&local->hw.wiphy->mtx));
+			if (link_sta)
+				ieee80211_ht_handle_chanwidth_notif(local, sdata, sta,
+								    link_sta, chanwidth,
+								    status->band);
+			break;
+		}
+		default:
+			WARN_ON(1);
+			break;
+		}
 	} else if (ieee80211_is_action(mgmt->frame_control) &&
 		   mgmt->u.action.category == WLAN_CATEGORY_VHT) {
 		switch (mgmt->u.action.u.vht_group_notif.action_code) {
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 9bca5e0a41b0..b414c9e6e61b 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3580,41 +3580,18 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			goto handled;
 		}
 		case WLAN_HT_ACTION_NOTIFY_CHANWIDTH: {
-			struct ieee80211_supported_band *sband;
 			u8 chanwidth = mgmt->u.action.u.ht_notify_cw.chanwidth;
-			enum ieee80211_sta_rx_bandwidth max_bw, new_bw;
-			struct sta_opmode_info sta_opmode = {};
+
+			if (chanwidth != IEEE80211_HT_CHANWIDTH_20MHZ &&
+			    chanwidth != IEEE80211_HT_CHANWIDTH_ANY)
+				goto invalid;
 
 			/* If it doesn't support 40 MHz it can't change ... */
 			if (!(rx->link_sta->pub->ht_cap.cap &
-					IEEE80211_HT_CAP_SUP_WIDTH_20_40))
-				goto handled;
-
-			if (chanwidth == IEEE80211_HT_CHANWIDTH_20MHZ)
-				max_bw = IEEE80211_STA_RX_BW_20;
-			else
-				max_bw = ieee80211_sta_cap_rx_bw(rx->link_sta);
-
-			/* set cur_max_bandwidth and recalc sta bw */
-			rx->link_sta->cur_max_bandwidth = max_bw;
-			new_bw = ieee80211_sta_cur_vht_bw(rx->link_sta);
-
-			if (rx->link_sta->pub->bandwidth == new_bw)
+				IEEE80211_HT_CAP_SUP_WIDTH_20_40))
 				goto handled;
 
-			rx->link_sta->pub->bandwidth = new_bw;
-			sband = rx->local->hw.wiphy->bands[status->band];
-			sta_opmode.bw =
-				ieee80211_sta_rx_bw_to_chan_width(rx->link_sta);
-			sta_opmode.changed = STA_OPMODE_MAX_BW_CHANGED;
-
-			rate_control_rate_update(local, sband, rx->link_sta,
-						 IEEE80211_RC_BW_CHANGED);
-			cfg80211_sta_opmode_change_notify(sdata->dev,
-							  rx->sta->addr,
-							  &sta_opmode,
-							  GFP_ATOMIC);
-			goto handled;
+			goto queue;
 		}
 		default:
 			goto invalid;
-- 
2.34.1


