Return-Path: <linux-wireless+bounces-4159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E94F686AA92
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AC21F24F1E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676732C8E;
	Wed, 28 Feb 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gT5vPMks"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAB2E651
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110648; cv=none; b=Y98BFCiwpqM9w35vVVutJJDBOaqsD3gy+7baSBDe3CbPsFuFJ0XTvP1BmtemyMjtdIzPhy6gwIuBd704FZHDf9OK9vDZbt3ymL4JT9GE/QYRCI11kL/G39d2BhVU2bBHESSG0hJbr1+B/H0F07mupVDzofuG1P7eekOBN1GdERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110648; c=relaxed/simple;
	bh=650PPsvft2YyZ7jmtgeC/Dq0A/EHfel5jAE7O+vw9Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkAmJ0YcIZD8UivwVoMA545ewzvIBMTgwnibKw2OJWBbuZjq/htVg+iEoB40rCP+sHvk68+2SPtti2zgjhkFPwl91tY77Wo1ybvkqo3I3JOrZfx5U7M6qvWqbRB9Y6UXCh5qt5Orr/ummmOrD486sTHh20LoX28bPWnCElnwBbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gT5vPMks; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3cMkLevo0s1vjcVfk3tBXSs920k/b5PoFUICXnk0NI0=;
	t=1709110646; x=1710320246; b=gT5vPMksZ/fKM0id286JnkurrHQaJLdeV/ei8yr/JrMdKWR
	dIDdDa5XPIT2gLU2a8kvxFk9IW2SOujC/WSKSqTcencqb1vgg+TOO+Mp9SvuinbwYjni/9uhz+iYR
	ni1GWLcYrstjWbL4j48/d6JAHkscMTNWcJMlvwVh233Tfu/vsVfax62oI1y6HFYMWrp7PpAPlYztL
	J+Y4h+GjRerx43Cmv9h+T0aVduNT2BxGY5qLU8zlr5nBIfP4htyFIQStBwM4I6m3sV396W7vqnUdy
	U8uoJBYeFdN1FsZq7v8Gs5CVT3w152BGR4/pL2G8dzEWMPuk/AwYQQlFOQ6OLNEw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFkh-0000000C0hJ-4BFD;
	Wed, 28 Feb 2024 09:57:24 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 4/8] wifi: mac80211: pass link conf to abort_channel_switch
Date: Wed, 28 Feb 2024 09:55:44 +0100
Message-ID: <20240228095718.27f621106ddd.Iadd3d69b722ffe5934779a32a0e4e596a4e33ed4@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228085718.21171-10-johannes@sipsolutions.net>
References: <20240228085718.21171-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Pass the link conf to the abort_channel_switch driver
method so the driver can handle things correctly.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 +++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  3 ++-
 include/net/mac80211.h                            |  5 +++--
 net/mac80211/driver-ops.h                         |  8 +++++---
 net/mac80211/mlme.c                               |  2 +-
 5 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 69f6a96b0cfb..1935630d3def 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1470,7 +1470,8 @@ int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 }
 
 void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
-				  struct ieee80211_vif *vif)
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -5551,8 +5552,16 @@ void iwl_mvm_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 
 	if (chsw->count >= mvmvif->csa_count && chsw->block_tx) {
 		if (mvmvif->csa_misbehave) {
+			struct ieee80211_bss_conf *link_conf;
+
 			/* Second time, give up on this AP*/
-			iwl_mvm_abort_channel_switch(hw, vif);
+
+			link_conf = wiphy_dereference(hw->wiphy,
+						      vif->link_conf[chsw->link_id]);
+			if (WARN_ON(!link_conf))
+				return;
+
+			iwl_mvm_abort_channel_switch(hw, vif, link_conf);
 			ieee80211_chswitch_done(vif, false, 0);
 			mvmvif->csa_misbehave = false;
 			return;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index c85d9e460ad2..63c802712596 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2709,7 +2709,8 @@ int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
 			       struct ieee80211_channel_switch *chsw);
 void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
-				  struct ieee80211_vif *vif);
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_bss_conf *link_conf);
 void iwl_mvm_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_channel_switch *chsw);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 8ea9fa81e68c..c622450ac012 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4268,7 +4268,7 @@ struct ieee80211_prep_tx_info {
  *	after a channel switch procedure is completed, allowing the
  *	driver to go back to a normal configuration.
  * @abort_channel_switch: This is an optional callback that is called
- *	when channel switch procedure was completed, allowing the
+ *	when channel switch procedure was aborted, allowing the
  *	driver to go back to a normal configuration.
  * @channel_switch_rx_beacon: This is an optional callback that is called
  *	when channel switch procedure is in progress and additional beacon with
@@ -4664,7 +4664,8 @@ struct ieee80211_ops {
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_bss_conf *link_conf);
 	void (*abort_channel_switch)(struct ieee80211_hw *hw,
-				     struct ieee80211_vif *vif);
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *link_conf);
 	void (*channel_switch_rx_beacon)(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_channel_switch *ch_switch);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index e20c64edb880..5d078c0a2323 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -2,7 +2,7 @@
 /*
 * Portions of this file
 * Copyright(c) 2016 Intel Deutschland GmbH
-* Copyright (C) 2018 - 2019, 2021 - 2023 Intel Corporation
+* Copyright (C) 2018-2019, 2021-2024 Intel Corporation
 */
 
 #ifndef __MAC80211_DRIVER_OPS
@@ -1180,8 +1180,9 @@ drv_post_channel_switch(struct ieee80211_link_data *link)
 }
 
 static inline void
-drv_abort_channel_switch(struct ieee80211_sub_if_data *sdata)
+drv_abort_channel_switch(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 
 	might_sleep();
@@ -1193,7 +1194,8 @@ drv_abort_channel_switch(struct ieee80211_sub_if_data *sdata)
 	trace_drv_abort_channel_switch(local, sdata);
 
 	if (local->ops->abort_channel_switch)
-		local->ops->abort_channel_switch(&local->hw, &sdata->vif);
+		local->ops->abort_channel_switch(&local->hw, &sdata->vif,
+						 link->conf);
 }
 
 static inline void
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f32ed57c83ba..e359c196de77 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2004,7 +2004,7 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 	link->csa_block_tx = false;
 	link->conf->csa_active = false;
 
-	drv_abort_channel_switch(sdata);
+	drv_abort_channel_switch(link);
 }
 
 static void
-- 
2.43.2


