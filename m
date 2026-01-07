Return-Path: <linux-wireless+bounces-30495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D416CFE53C
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 339FB300A6C4
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C1343D7D;
	Wed,  7 Jan 2026 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KU1iRcxV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A66343D88
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795848; cv=none; b=Xts/pGsqi45DpJlVtRCKdn6I4mwlV5hVBRMlVSBCM/8FTD/1z2KUTxadK7B1osAW6S633FkXjDTZCb64jfbfamuyRxMEmyMKVgILqhsS0yhV+TNH/3n3Hjx2ywfoC39rbrH8wFf3rzjKsGil2xUmoB69T1KBlevNds95jc8Nd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795848; c=relaxed/simple;
	bh=ESdyjP38IdDn+PikL5vcdxNXmD5LOcya4DB9O0Pxga8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3duTSv2S42IhxqgfcSm45s4Bf1I/8X1DeX+C0mfboSHwn491goK90/XNwxUgxEDsn7i/SChi1GSMa6IA4alYU79t+73uBHDV2gA5Jp8u6qsRSNlSlxe2MmVnt3otvY7Ka4vZno3XQGwfKCn6w7egEsCMaw7fXFcNG4dtpIiFig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KU1iRcxV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NGTH7ZwQqUnIFdwS5BHNa3U7gz3x1W0yHw2Ds4Mn9Ww=;
	t=1767795846; x=1769005446; b=KU1iRcxVrXLEqTlbxuP0+U4BSuMu2seCzMcUGkugiHbNeuY
	CG4GKehjE/giHHFCVR9N+/EKsPGxOpVt/0dAGLtZ/qZk7LbZL74TkbjMWCQ/WQ1zmCtsUBocSjVqK
	MD0NtpwiWdHsoOWmCBotrQh99gjZ5pIiKkR+FXRSwesiRQi1pV/nCkrpgKTAROWOLOMpkfY5PZDUq
	NkY/lfhYhcRf+FOkauCY8et6u16WinUznc3gNw9yzb754RBVhpvA2btngvCrAVY02cQBVMcZtT5Hf
	MKxxdKqFrT29RRgrT0sB21RmK35CeDd51NHgnXNHSsTolezoQcfdL67FZlkeF+SQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSA-00000005agF-1tQt;
	Wed, 07 Jan 2026 15:24:03 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 33/46] wifi: mac80211: update NAN data path state on schedule changes
Date: Wed,  7 Jan 2026 15:22:32 +0100
Message-ID: <20260107152325.e3b9371a7737.Ie796487ab9eb23cda819b0afac57e7267b134911@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

A carrier of an NDI interface is turned on when there is at least one NDI
station that: (1) correlates to this interface (2) is authorized (3) the
NAN peer to which this station belongs has at least one common slot with
the local schedule. Otherwise, it is turned off.
(common slots are slots where both schedules are active on compatible
 channels.)

Implement the calculation of the carrier state and trigger it when
needed.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         |  10 +++-
 net/mac80211/ieee80211_i.h |   1 +
 net/mac80211/nan.c         | 107 +++++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.c    |   4 ++
 4 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e87f58a148bc..def6b89b8db9 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2477,7 +2477,15 @@ static int ieee80211_add_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 	    test_sta_flag(sta, WLAN_STA_ASSOC))
 		rate_control_rate_init_all_links(sta);
 
-	return sta_info_insert(sta);
+	err = sta_info_insert(sta);
+
+	/*
+	 * ieee80211_nan_update_ndi_carrier was called from sta_apply_parameters,
+	 * but then we did not have the STA in the list.
+	 */
+	if (!err && sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+		ieee80211_nan_update_ndi_carrier(sta->sdata);
+	return err;
 }
 
 static int ieee80211_del_station(struct wiphy *wiphy, struct wireless_dev *wdev,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index fc17c2e6a009..92e409c74177 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2036,6 +2036,7 @@ int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
 				 struct cfg80211_nan_peer_sched *sched);
 void ieee80211_nan_free_peer_sched(struct ieee80211_nan_peer_sched *sched);
+void ieee80211_nan_update_ndi_carrier(struct ieee80211_sub_if_data *ndi_sdata);
 
 /* scan/BSS handling */
 void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work);
diff --git a/net/mac80211/nan.c b/net/mac80211/nan.c
index be0c6c41da95..f502a60a0e16 100644
--- a/net/mac80211/nan.c
+++ b/net/mac80211/nan.c
@@ -165,6 +165,23 @@ ieee80211_nan_find_existing_channel(struct ieee80211_nan_channel *channels,
 	return -ENOENT;
 }
 
+static void
+ieee80211_nan_update_all_ndi_carriers(struct ieee80211_local *local)
+{
+	struct ieee80211_sub_if_data *sdata;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	/* Iterate all interfaces and update carrier for NDI interfaces */
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		if (!ieee80211_sdata_running(sdata) ||
+		    sdata->vif.type != NL80211_IFTYPE_NAN_DATA)
+			continue;
+
+		ieee80211_nan_update_ndi_carrier(sdata);
+	}
+}
+
 int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 				  struct cfg80211_nan_local_sched *sched)
 {
@@ -244,6 +261,8 @@ int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 
 	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
 
+	ieee80211_nan_update_all_ndi_carriers(sdata->local);
+
 	return 0;
 err:
 	/* Remove newly added channels */
@@ -302,6 +321,7 @@ int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 	}
 
 	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
+	ieee80211_nan_update_all_ndi_carriers(sdata->local);
 	return ret;
 }
 
@@ -375,6 +395,91 @@ ieee80211_nan_init_peer_map(struct ieee80211_nan_peer_sched *peer_sched,
 	}
 }
 
+/*
+ * Check if the local schedule and a peer schedule have at least one common
+ * slot - a slot where both schedules are active on compatible channels.
+ */
+static bool
+ieee80211_nan_has_common_slots(struct ieee80211_sub_if_data *sdata,
+			       struct ieee80211_nan_peer_sched *peer_sched)
+{
+	for (int slot = 0; slot < CFG80211_NAN_SCHED_NUM_TIME_SLOTS; slot++) {
+		struct ieee80211_nan_channel *local_chan =
+			sdata->vif.cfg.nan_schedule[slot];
+
+		if (!local_chan || !local_chan->chanctx_conf)
+			continue;
+
+		/* Check all peer maps for this slot */
+		for (int m = 0; m < CFG80211_NAN_MAX_PEER_MAPS; m++) {
+			struct ieee80211_nan_peer_map *map = &peer_sched->maps[m];
+			struct ieee80211_nan_channel *peer_chan;
+
+			if (map->map_id == CFG80211_NAN_INVALID_MAP_ID)
+				continue;
+
+			peer_chan = map->slots[slot];
+			if (!peer_chan)
+				continue;
+
+			if (local_chan->chanctx_conf == peer_chan->chanctx_conf)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+void ieee80211_nan_update_ndi_carrier(struct ieee80211_sub_if_data *ndi_sdata)
+{
+	struct ieee80211_local *local = ndi_sdata->local;
+	struct ieee80211_sub_if_data *nmi_sdata;
+	struct sta_info *sta;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (WARN_ON(ndi_sdata->vif.type != NL80211_IFTYPE_NAN_DATA ||
+		    !ndi_sdata->dev) || !ieee80211_sdata_running(ndi_sdata))
+		return;
+
+	nmi_sdata = wiphy_dereference(local->hw.wiphy, ndi_sdata->u.nan_data.nmi);
+	if (WARN_ON(!nmi_sdata))
+		return;
+
+	list_for_each_entry(sta, &local->sta_list, list) {
+		struct ieee80211_sta *nmi_sta;
+
+		if (sta->sdata != ndi_sdata ||
+		    !test_sta_flag(sta, WLAN_STA_AUTHORIZED))
+			continue;
+
+		nmi_sta = wiphy_dereference(local->hw.wiphy, sta->sta.nmi);
+		if (WARN_ON(!nmi_sta) || !nmi_sta->nan_sched)
+			continue;
+
+		if (ieee80211_nan_has_common_slots(nmi_sdata, nmi_sta->nan_sched)) {
+			netif_carrier_on(ndi_sdata->dev);
+			return;
+		}
+	}
+
+	netif_carrier_off(ndi_sdata->dev);
+}
+
+static void
+ieee80211_nan_update_peer_ndis_carrier(struct ieee80211_local *local,
+				       struct sta_info *nmi_sta)
+{
+	struct sta_info *sta;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	list_for_each_entry(sta, &local->sta_list, list) {
+		if (rcu_access_pointer(sta->sta.nmi) == &nmi_sta->sta)
+			ieee80211_nan_update_ndi_carrier(sta->sdata);
+	}
+}
+
 int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
 				 struct cfg80211_nan_peer_sched *sched)
 {
@@ -436,6 +541,8 @@ int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
+	ieee80211_nan_update_peer_ndis_carrier(sdata->local, sta);
+
 	/* Success - free old schedule */
 	to_free = old_sched;
 	ret = 0;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 8fdcc6fadc94..35a5fa66bb43 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1442,6 +1442,8 @@ static int _sta_info_move_state(struct sta_info *sta,
 		} else if (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
 			ieee80211_vif_dec_num_mcast(sta->sdata);
 			clear_bit(WLAN_STA_AUTHORIZED, &sta->_flags);
+			if (sta->sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+				ieee80211_nan_update_ndi_carrier(sta->sdata);
 
 			/*
 			 * If we have encryption offload, flush (station) queues
@@ -1470,6 +1472,8 @@ static int _sta_info_move_state(struct sta_info *sta,
 			set_bit(WLAN_STA_AUTHORIZED, &sta->_flags);
 			ieee80211_check_fast_xmit(sta);
 			ieee80211_check_fast_rx(sta);
+			if (sta->sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+				ieee80211_nan_update_ndi_carrier(sta->sdata);
 		}
 		if (sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
 		    sta->sdata->vif.type == NL80211_IFTYPE_AP)
-- 
2.52.0


