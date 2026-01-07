Return-Path: <linux-wireless+bounces-30502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBABCFE5A4
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6DAD303D686
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614823446DA;
	Wed,  7 Jan 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gblgwbOx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD93446BD
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795854; cv=none; b=o5OhD34hW9T7r5OVsiBnrZK+57fDKxUr5jmpMfDLJsqjTgvlChkRzB26umFaPkbs3moSKM7WoerHgO7Th7Dhk5SmxclS5c/Q5DyH/Zs8V25ANGpdRZkDNUEVjKO8rdsjiNu2oomyGmoAvAeXh4i6z0tWenYPxetktD2isLxmWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795854; c=relaxed/simple;
	bh=UTGx+oWwbhmDItxw2VT6b7xfgVmHZGBV74t0IL0beFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evOyprP0LCmqAHmcUQzxVOk5+Rj/llWAH3UiTJhYm963hbBqUmpkX0kYqRT74GVDQiM9d4c++r+2wgRpwHki8saU9w1Zj6KOAWxOZCyPDaZO+LJF69/1VSKwbsJoQGVMTyGfdNpwMiqW5fxOb43Jgcer84QDEjiprywTW/sbf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gblgwbOx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ymM2bkYvB+tns+xBdar9VbYrtyuNjJOBLJIewYE8NTk=;
	t=1767795852; x=1769005452; b=gblgwbOxlR8HCklgS6ynhcsIjquvWVIZy++ZbZFgEpNPCrD
	RsQSSsFpt6X/+nbpt+mOsvkZnAjRMqZZnrAHzAJGtkB6pQ+5rKCfCvJ60YGnRSUGTDyhQyX95S/rR
	a92bF8c5Z29KiI5Ohf+GiFSF+y/J56X/zf7Z37GIftbEA7KgVplRw6/q4Xt30ck8BD1ZIrQX3QDtR
	nMV+WFyDj70zNgkktLeEqJFalcsZTMc1UhOE9Vlm+yU+md25P7D5DNJYpCpADk6OtxdclUspUsEqF
	tMlqt9pgmcEzFH9yd0NqQwmqfEcXVdJ2mCwdRdf779yKqXSQR7wN11cKSAJyp6mQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSH-00000005agF-2I73;
	Wed, 07 Jan 2026 15:24:09 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 40/46] wifi: mac80211_hwsim: implement NAN schedule callbacks
Date: Wed,  7 Jan 2026 15:22:39 +0100
Message-ID: <20260107152325.eeb21a6f3768.I75cf3555b7506d5b8bb30e70a0f3721ab73477cb@changeid>
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

From: Daniel Gabay <daniel.gabay@intel.com>

Implement mac80211 schedule callbacks for NAN Data Path support:

- Track local schedule via BSS_CHANGED_NAN_LOCAL_SCHED, caching
  the channel for each 16TU time slot.
- Copy peer schedule to driver-private storage in
  nan_peer_sched_changed callback for use in TX availability
  decisions.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   | 21 +++++
 .../wireless/virtual/mac80211_hwsim_main.c    | 70 ++++++++--------
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 80 +++++++++++++++++++
 .../net/wireless/virtual/mac80211_hwsim_nan.h | 15 +++-
 4 files changed, 149 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index 9df5aec7e7a4..ae2f44db52a5 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -14,6 +14,27 @@
 #include "mac80211_hwsim.h"
 #include "mac80211_hwsim_nan.h"
 
+struct hwsim_sta_nan_sched {
+	/* Later members are protected by this lock */
+	spinlock_t lock;
+	u16 committed_dw;
+	struct {
+		u8 map_id;
+		struct cfg80211_chan_def chans[CFG80211_NAN_SCHED_NUM_TIME_SLOTS];
+	} maps[CFG80211_NAN_MAX_PEER_MAPS];
+};
+
+struct hwsim_sta_priv {
+	u32 magic;
+	unsigned int last_link;
+	u16 active_links_rx;
+
+	/* NAN peer schedule - must be accessed under nan_sched.lock */
+	struct hwsim_sta_nan_sched nan_sched;
+};
+
+#define HWSIM_STA_MAGIC	0x6d537749
+
 struct mac80211_hwsim_link_data {
 	u32 link_id;
 	u64 beacon_int	/* beacon interval in us */;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 639a62bf0df8..f7f3edf505d0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -249,14 +249,6 @@ static inline void hwsim_clear_magic(struct ieee80211_vif *vif)
 	vp->magic = 0;
 }
 
-struct hwsim_sta_priv {
-	u32 magic;
-	unsigned int last_link;
-	u16 active_links_rx;
-};
-
-#define HWSIM_STA_MAGIC	0x6d537749
-
 static inline void hwsim_check_sta_magic(struct ieee80211_sta *sta)
 {
 	struct hwsim_sta_priv *sp = (void *)sta->drv_priv;
@@ -2477,6 +2469,9 @@ static void mac80211_hwsim_vif_info_changed(struct ieee80211_hw *hw,
 		vp->aid = vif->cfg.aid;
 	}
 
+	if (changed & BSS_CHANGED_NAN_LOCAL_SCHED)
+		mac80211_hwsim_nan_local_sched_changed(hw, vif);
+
 	if (vif->type == NL80211_IFTYPE_STATION &&
 	    changed & (BSS_CHANGED_MLD_VALID_LINKS | BSS_CHANGED_MLD_TTLM)) {
 		u16 usable_links = ieee80211_vif_usable_links(vif);
@@ -2643,6 +2638,8 @@ static int mac80211_hwsim_sta_add(struct ieee80211_hw *hw,
 		sp->active_links_rx = sta->valid_links;
 	}
 
+	spin_lock_init(&sp->nan_sched.lock);
+
 	return 0;
 }
 
@@ -3919,34 +3916,35 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
 #define HWSIM_DEBUGFS_OPS
 #endif
 
-#define HWSIM_COMMON_OPS					\
-	.tx = mac80211_hwsim_tx,				\
-	.wake_tx_queue = ieee80211_hwsim_wake_tx_queue,		\
-	.start = mac80211_hwsim_start,				\
-	.stop = mac80211_hwsim_stop,				\
-	.add_interface = mac80211_hwsim_add_interface,		\
-	.change_interface = mac80211_hwsim_change_interface,	\
-	.remove_interface = mac80211_hwsim_remove_interface,	\
-	.config = mac80211_hwsim_config,			\
-	.configure_filter = mac80211_hwsim_configure_filter,	\
-	.vif_cfg_changed = mac80211_hwsim_vif_info_changed,	\
-	.link_info_changed = mac80211_hwsim_link_info_changed,  \
-	.tx_last_beacon = mac80211_hwsim_tx_last_beacon,	\
-	.sta_notify = mac80211_hwsim_sta_notify,		\
-	.link_sta_rc_update = mac80211_hwsim_sta_rc_update,	\
-	.conf_tx = mac80211_hwsim_conf_tx,			\
-	.get_survey = mac80211_hwsim_get_survey,		\
-	CFG80211_TESTMODE_CMD(mac80211_hwsim_testmode_cmd)	\
-	.ampdu_action = mac80211_hwsim_ampdu_action,		\
-	.flush = mac80211_hwsim_flush,				\
-	.get_et_sset_count = mac80211_hwsim_get_et_sset_count,	\
-	.get_et_stats = mac80211_hwsim_get_et_stats,		\
-	.get_et_strings = mac80211_hwsim_get_et_strings,	\
-	.start_pmsr = mac80211_hwsim_start_pmsr,		\
-	.abort_pmsr = mac80211_hwsim_abort_pmsr,		\
-	.start_nan = mac80211_hwsim_nan_start,			\
-	.stop_nan = mac80211_hwsim_nan_stop,			\
-	.nan_change_conf = mac80211_hwsim_nan_change_config,	\
+#define HWSIM_COMMON_OPS						 \
+	.tx = mac80211_hwsim_tx,					 \
+	.wake_tx_queue = ieee80211_hwsim_wake_tx_queue,			 \
+	.start = mac80211_hwsim_start,					 \
+	.stop = mac80211_hwsim_stop,					 \
+	.add_interface = mac80211_hwsim_add_interface,			 \
+	.change_interface = mac80211_hwsim_change_interface,		 \
+	.remove_interface = mac80211_hwsim_remove_interface,		 \
+	.config = mac80211_hwsim_config,				 \
+	.configure_filter = mac80211_hwsim_configure_filter,		 \
+	.vif_cfg_changed = mac80211_hwsim_vif_info_changed,		 \
+	.link_info_changed = mac80211_hwsim_link_info_changed,		 \
+	.tx_last_beacon = mac80211_hwsim_tx_last_beacon,		 \
+	.sta_notify = mac80211_hwsim_sta_notify,			 \
+	.link_sta_rc_update = mac80211_hwsim_sta_rc_update,		 \
+	.conf_tx = mac80211_hwsim_conf_tx,				 \
+	.get_survey = mac80211_hwsim_get_survey,			 \
+	CFG80211_TESTMODE_CMD(mac80211_hwsim_testmode_cmd)		 \
+	.ampdu_action = mac80211_hwsim_ampdu_action,			 \
+	.flush = mac80211_hwsim_flush,					 \
+	.get_et_sset_count = mac80211_hwsim_get_et_sset_count,		 \
+	.get_et_stats = mac80211_hwsim_get_et_stats,			 \
+	.get_et_strings = mac80211_hwsim_get_et_strings,		 \
+	.start_pmsr = mac80211_hwsim_start_pmsr,			 \
+	.abort_pmsr = mac80211_hwsim_abort_pmsr,			 \
+	.start_nan = mac80211_hwsim_nan_start,				 \
+	.stop_nan = mac80211_hwsim_nan_stop,				 \
+	.nan_change_conf = mac80211_hwsim_nan_change_config,		 \
+	.nan_peer_sched_changed = mac80211_hwsim_nan_peer_sched_changed, \
 	HWSIM_DEBUGFS_OPS
 
 #define HWSIM_NON_MLO_OPS					\
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index 2be256e4f7bd..0fb97710b61e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
@@ -1019,3 +1019,83 @@ bool mac80211_hwsim_nan_receive(struct ieee80211_hw *hw,
 
 	return false;
 }
+
+void mac80211_hwsim_nan_local_sched_changed(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	struct ieee80211_nan_channel **slots = vif->cfg.nan_schedule;
+
+	if (WARN_ON(vif->type != NL80211_IFTYPE_NAN))
+		return;
+
+	spin_lock_bh(&data->nan.state_lock);
+
+	for (int i = 0; i < ARRAY_SIZE(data->nan.local_sched); i++) {
+		struct ieee80211_chanctx_conf *chanctx;
+
+		if (!slots[i] || IS_ERR(slots[i])) {
+			memset(&data->nan.local_sched[i], 0,
+			       sizeof(data->nan.local_sched[i]));
+			continue;
+		}
+
+		chanctx = slots[i]->chanctx_conf;
+		if (!chanctx) {
+			memset(&data->nan.local_sched[i], 0,
+			       sizeof(data->nan.local_sched[i]));
+			continue;
+		}
+
+		data->nan.local_sched[i] = chanctx->def;
+	}
+
+	spin_unlock_bh(&data->nan.state_lock);
+}
+
+int mac80211_hwsim_nan_peer_sched_changed(struct ieee80211_hw *hw,
+					  struct ieee80211_sta *sta)
+{
+	struct hwsim_sta_priv *sp = (void *)sta->drv_priv;
+	struct ieee80211_nan_peer_sched *sched = sta->nan_sched;
+
+	spin_lock_bh(&sp->nan_sched.lock);
+
+	/* Clear existing schedule */
+	sp->nan_sched.committed_dw = 0;
+	for (int i = 0; i < CFG80211_NAN_MAX_PEER_MAPS; i++) {
+		sp->nan_sched.maps[i].map_id = CFG80211_NAN_INVALID_MAP_ID;
+		memset(sp->nan_sched.maps[i].chans, 0,
+		       sizeof(sp->nan_sched.maps[i].chans));
+	}
+
+	if (!sched)
+		goto out;
+
+	sp->nan_sched.committed_dw = sched->committed_dw;
+
+	for (int i = 0; i < CFG80211_NAN_MAX_PEER_MAPS; i++) {
+		struct ieee80211_nan_peer_map *map = &sched->maps[i];
+
+		if (map->map_id == CFG80211_NAN_INVALID_MAP_ID)
+			continue;
+
+		sp->nan_sched.maps[i].map_id = map->map_id;
+
+		for (int j = 0; j < CFG80211_NAN_SCHED_NUM_TIME_SLOTS; j++) {
+			struct ieee80211_nan_channel *peer_chan =
+				map->slots[j];
+
+			if (peer_chan && peer_chan->chanreq.oper.chan)
+				sp->nan_sched.maps[i].chans[j] =
+					peer_chan->chanreq.oper;
+			else
+				memset(&sp->nan_sched.maps[i].chans[j], 0,
+				       sizeof(sp->nan_sched.maps[i].chans[j]));
+		}
+	}
+
+out:
+	spin_unlock_bh(&sp->nan_sched.lock);
+	return 0;
+}
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
index 3199e5c5376b..eb53bacee206 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * mac80211_hwsim_nan - NAN software simulation for mac80211_hwsim
- * Copyright (C) 2025 Intel Corporation
+ * Copyright (C) 2025-2026 Intel Corporation
  */
 
 #ifndef __MAC80211_HWSIM_NAN_H
@@ -52,6 +52,13 @@ struct mac80211_hwsim_nan_data {
 
 	bool tsf_adjusted;
 	bool tsf_discontinuity;
+
+	/*
+	 * Local schedule - stores channel definition for each 16TU slot.
+	 * Derived from NMI vif->cfg.nan_schedule. chan == NULL means not
+	 * available in that slot (except DW which is implicit).
+	 */
+	struct cfg80211_chan_def local_sched[CFG80211_NAN_SCHED_NUM_TIME_SLOTS];
 };
 
 enum hrtimer_restart
@@ -73,6 +80,9 @@ int mac80211_hwsim_nan_change_config(struct ieee80211_hw *hw,
 				     struct cfg80211_nan_conf *conf,
 				     u32 changes);
 
+int mac80211_hwsim_nan_peer_sched_changed(struct ieee80211_hw *hw,
+					  struct ieee80211_sta *sta);
+
 bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
 					 struct ieee80211_txq *txq);
 
@@ -86,4 +96,7 @@ bool mac80211_hwsim_nan_receive(struct ieee80211_hw *hw,
 void mac80211_hwsim_nan_rx(struct ieee80211_hw *hw,
 			   struct sk_buff *skb);
 
+void mac80211_hwsim_nan_local_sched_changed(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif);
+
 #endif /* __MAC80211_HWSIM_NAN_H */
-- 
2.52.0


