Return-Path: <linux-wireless+bounces-35974-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPVZLGe5+mnASAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35974-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF14D5F9B
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06DEA3056FC8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 03:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DA42820A9;
	Wed,  6 May 2026 03:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtVfE9V3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305222E7F2C
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039098; cv=none; b=gw0BUhREmiunoOKitXFSZN+fu33Rr9ylRmAy+Y5lD1o5TJoM/9dkV+YRYimHzrzN17oXS1Rjs1ipsG89J/b5RgBDVD3AYrlDrdWV+zUrVRT8I9mjZbNecCHdF9+pi9Lv6dyN0Y4BrA+LNnMCMQ+NfZgVFykwlruB9kCZgLgInfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039098; c=relaxed/simple;
	bh=+RufibweACO2MM6njvGrrruEzu3EdQNikKfFawavdb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BUDr8bJAy4r2+J0UVo8nnHdcxwgCxRTS6vz9idsdmV4gtv8WFq2fImylx4G5py6LWIu9yRMoRo+tFOL4qJUild+Uoj0j1iOxSJblz6kJmDuynh41YXvbpqxfQSPZrkdr/mCuVj5aU0SSzhY970dJ/GSviQ9wuFlurBk2vjDtZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtVfE9V3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778039097; x=1809575097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+RufibweACO2MM6njvGrrruEzu3EdQNikKfFawavdb0=;
  b=KtVfE9V37aJxxZWRf0rI6i6vBM/ZCmmyCGnm9vIP+VqoFSxNDk/dj/sZ
   Hpg5GWjgWe5F2+GkN6d9+M+pNQ9i+m5MT3X7YsvGCreY7tuFxvstCZU7R
   jmQvLtZhnlOEZILUUMnRScogF+CF2jZWJJw2czrvnB/Z6YFoLUn34SPxp
   fvX2AgWqLOb7DVPwt+ovrpuWr85AKdpZZP8BnGV1Y21vJ488XnA+eJx/P
   lLuxfyVhcrN58PB6DZLu/9aYZAvt+UQtBdT/MdRaScQLrT2vDa3a8LxGo
   ar+wg9+syTLUE8eUu5s5pL81EqgmdALi4GbY+CDW8WSNrj0GR5eWttPTj
   A==;
X-CSE-ConnectionGUID: hJd+cSRYRqeNluiqPTAXXQ==
X-CSE-MsgGUID: PLCg8+2xStyYrUFZKS2cHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82791293"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="82791293"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:57 -0700
X-CSE-ConnectionGUID: xe6vYBt0QYy9WN/kr56zqg==
X-CSE-MsgGUID: hOreEyimSQWoVzC6sBO6og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="237777798"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH v2 wireless-next 08/14] wifi: mac80211_hwsim: implement NAN schedule callbacks
Date: Wed,  6 May 2026 06:44:27 +0300
Message-Id: <20260506064301.f3ad9e3dc9d4.I75cf3555b7506d5b8bb30e70a0f3721ab73477cb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506034433.3328362-1-miriam.rachel.korenblit@intel.com>
References: <20260506034433.3328362-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 35FF14D5F9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35974-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Daniel Gabay <daniel.gabay@intel.com>

Implement mac80211 schedule callbacks for NAN Data Path support:

- Track local schedule via BSS_CHANGED_NAN_LOCAL_SCHED, caching
  the channel for each 16TU time slot.
- Copy peer schedule to driver-private storage in
  nan_peer_sched_changed callback for use in TX availability
  decisions.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   | 21 +++++
 .../wireless/virtual/mac80211_hwsim_main.c    | 14 ++--
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 80 +++++++++++++++++++
 .../net/wireless/virtual/mac80211_hwsim_nan.h | 15 +++-
 4 files changed, 121 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index d182b5117bfb..0f0f2ac6d80e 100644
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
index fc940b38c52c..1ea33ec577dd 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -252,14 +252,6 @@ static inline void hwsim_clear_magic(struct ieee80211_vif *vif)
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
@@ -2652,6 +2644,9 @@ static void mac80211_hwsim_vif_info_changed(struct ieee80211_hw *hw,
 		vp->aid = vif->cfg.aid;
 	}
 
+	if (changed & BSS_CHANGED_NAN_LOCAL_SCHED)
+		mac80211_hwsim_nan_local_sched_changed(hw, vif);
+
 	if (vif->type == NL80211_IFTYPE_STATION &&
 	    changed & (BSS_CHANGED_MLD_VALID_LINKS | BSS_CHANGED_MLD_TTLM)) {
 		u16 usable_links = ieee80211_vif_usable_links(vif);
@@ -2818,6 +2813,8 @@ static int mac80211_hwsim_sta_add(struct ieee80211_hw *hw,
 		sp->active_links_rx = sta->valid_links;
 	}
 
+	spin_lock_init(&sp->nan_sched.lock);
+
 	return 0;
 }
 
@@ -4245,6 +4242,7 @@ static int mac80211_hwsim_set_radar_background(struct ieee80211_hw *hw,
 	.start_nan = mac80211_hwsim_nan_start,			\
 	.stop_nan = mac80211_hwsim_nan_stop,			\
 	.nan_change_conf = mac80211_hwsim_nan_change_config,	\
+	.nan_peer_sched_changed = mac80211_hwsim_nan_peer_sched_changed, \
 	HWSIM_DEBUGFS_OPS
 
 #define HWSIM_NON_MLO_OPS					\
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index 6053b6f8f91f..16883edd2215 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
@@ -1008,3 +1008,83 @@ bool mac80211_hwsim_nan_receive(struct ieee80211_hw *hw,
 
 	return false;
 }
+
+void mac80211_hwsim_nan_local_sched_changed(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	struct ieee80211_nan_channel **slots = vif->cfg.nan_sched.schedule;
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
2.34.1


