Return-Path: <linux-wireless+bounces-2964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B47845A04
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D09C28E069
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA885D499;
	Thu,  1 Feb 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edl2oorJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E65F483
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797230; cv=none; b=r0EtAMhSyKd1prVjcvSkHnh1Elv0KGxVyNmQgkGLPNei5uy8kmx55wcm8gwuNi0Ha7v0y+fGSWfcrCfKsxhMCr4YhRe7DjqiXbTc3ryOjPa2c4wDEBAuGRGVDkT6QG7kDM0c103VHmBbheuMqNNx01k3vomCq/038DAqc10gGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797230; c=relaxed/simple;
	bh=i//aRA4/VuLwALd/zm5LXaw7HG/QK9RymDaPuuvKP4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fpKEKzuKJCqveWRPb8vxmXQGtUdhX+6JNSIOKjZe7v+8rz9mMiYdnCaBOmJcfyr5pcz7dIPO8BSMTvAYP9XRnIDNmmvNt2dSPiuk7uf8Yum+DSb5NjABAtrwnwztWfT+xX6ll2vD9YJzMZlKd25Kb0GDp7nyBk2+TRhc7ZpuddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edl2oorJ; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797228; x=1738333228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i//aRA4/VuLwALd/zm5LXaw7HG/QK9RymDaPuuvKP4Q=;
  b=edl2oorJJR/UPYYbSzwn9iZtL0g8t96VX7EV0cqmU/VEmlthubudXYdL
   FcA4560iS5/V5DD1J8FCb5KMBe+NxDg5IVz2H9fcHM0GX6fk+9MW2OnfC
   khWndLu1rvMvJ7cTcZL10QguZSYq6R5ChLD9Qsu5ki1gjJwHERecfvhmx
   X6cpMqhXmHTEFVCUDORu/dDY61pRwtUi2syklfgjImZYSt4Sd94DKazp7
   S3XGKLec7S9s+MNuQsS3FcQXUn56Qt+QJ1wcmkVQlNLMcdI0I3UM/murP
   OFPETJFNHCC6YhILlcYDLSlcTfbyIMBjk4PukljZHGT1W1bv73E5oit6V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435063036"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435063036"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94593"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 17/17] wifi: iwlwifi: mvm: make functions public
Date: Thu,  1 Feb 2024 16:17:41 +0200
Message-Id: <20240201155157.3edafc4d59aa.Ic68e90758bcad9ae00e0aa602101842dac60e1a1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
References: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

In the following patch, iwl_mvm_roc_duration_and_delay and
iwl_mvm_roc_add_cmd will be called also from time-event.c.
Move then there (where they more belong) and make then
public.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 80 -------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  8 ++
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 80 +++++++++++++++++++
 3 files changed, 88 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index dbad30e61451..93baec9bb3fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4429,44 +4429,6 @@ static bool iwl_mvm_rx_aux_roc(struct iwl_notif_wait_data *notif_wait,
 	return true;
 }
 
-#define AUX_ROC_MIN_DURATION MSEC_TO_TU(100)
-#define AUX_ROC_MIN_DELAY MSEC_TO_TU(200)
-#define AUX_ROC_MAX_DELAY MSEC_TO_TU(600)
-#define AUX_ROC_SAFETY_BUFFER MSEC_TO_TU(20)
-#define AUX_ROC_MIN_SAFETY_BUFFER MSEC_TO_TU(10)
-
-static void iwl_mvm_roc_duration_and_delay(struct ieee80211_vif *vif,
-					   u32 duration_ms,
-					   u32 *duration_tu,
-					   u32 *delay)
-{
-	u32 dtim_interval = vif->bss_conf.dtim_period *
-		vif->bss_conf.beacon_int;
-
-	*delay = AUX_ROC_MIN_DELAY;
-	*duration_tu = MSEC_TO_TU(duration_ms);
-
-	/*
-	 * If we are associated we want the delay time to be at least one
-	 * dtim interval so that the FW can wait until after the DTIM and
-	 * then start the time event, this will potentially allow us to
-	 * remain off-channel for the max duration.
-	 * Since we want to use almost a whole dtim interval we would also
-	 * like the delay to be for 2-3 dtim intervals, in case there are
-	 * other time events with higher priority.
-	 */
-	if (vif->cfg.assoc) {
-		*delay = min_t(u32, dtim_interval * 3, AUX_ROC_MAX_DELAY);
-		/* We cannot remain off-channel longer than the DTIM interval */
-		if (dtim_interval <= *duration_tu) {
-			*duration_tu = dtim_interval - AUX_ROC_SAFETY_BUFFER;
-			if (*duration_tu <= AUX_ROC_MIN_DURATION)
-				*duration_tu = dtim_interval -
-					AUX_ROC_MIN_SAFETY_BUFFER;
-		}
-	}
-}
-
 static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 				    struct ieee80211_channel *channel,
 				    struct ieee80211_vif *vif,
@@ -4564,48 +4526,6 @@ static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 	return res;
 }
 
-static int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
-			       struct ieee80211_channel *channel,
-			       struct ieee80211_vif *vif,
-			       int duration, u32 activity)
-{
-	int res;
-	u32 duration_tu, delay;
-	struct iwl_roc_req roc_req = {
-		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
-		.activity = cpu_to_le32(activity),
-		.sta_id = cpu_to_le32(mvm->aux_sta.sta_id),
-	};
-
-	lockdep_assert_held(&mvm->mutex);
-
-	/* Set the channel info data */
-	iwl_mvm_set_chan_info(mvm, &roc_req.channel_info,
-			      channel->hw_value,
-			      iwl_mvm_phy_band_from_nl80211(channel->band),
-			      IWL_PHY_CHANNEL_MODE20, 0);
-
-	iwl_mvm_roc_duration_and_delay(vif, duration, &duration_tu,
-				       &delay);
-	roc_req.duration = cpu_to_le32(duration_tu);
-	roc_req.max_delay = cpu_to_le32(delay);
-
-	IWL_DEBUG_TE(mvm,
-		     "\t(requested = %ums, max_delay = %ums)\n",
-		     duration, delay);
-	IWL_DEBUG_TE(mvm,
-		     "Requesting to remain on channel %u for %utu\n",
-		     channel->hw_value, duration_tu);
-
-	/* Set the node address */
-	memcpy(roc_req.node_addr, vif->addr, ETH_ALEN);
-
-	res = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(MAC_CONF_GROUP, ROC_CMD),
-				   0, sizeof(roc_req), &roc_req);
-
-	return res;
-}
-
 static int iwl_mvm_add_aux_sta_for_hs20(struct iwl_mvm *mvm, u32 lmac_id)
 {
 	int ret = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index c76ce6b1fa72..eb30c299a71e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2764,4 +2764,12 @@ iwl_mvm_chanctx_def(struct iwl_mvm *mvm, struct ieee80211_chanctx_conf *ctx)
 	return use_def ? &ctx->def : &ctx->min_def;
 }
 
+void iwl_mvm_roc_duration_and_delay(struct ieee80211_vif *vif,
+				    u32 duration_ms,
+				    u32 *duration_tu,
+				    u32 *delay);
+int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
+			struct ieee80211_channel *channel,
+			struct ieee80211_vif *vif,
+			int duration, u32 activity);
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 703ccdd4d967..60ec5ca6927c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -986,6 +986,86 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 	rcu_read_unlock();
 }
 
+#define AUX_ROC_MIN_DURATION MSEC_TO_TU(100)
+#define AUX_ROC_MIN_DELAY MSEC_TO_TU(200)
+#define AUX_ROC_MAX_DELAY MSEC_TO_TU(600)
+#define AUX_ROC_SAFETY_BUFFER MSEC_TO_TU(20)
+#define AUX_ROC_MIN_SAFETY_BUFFER MSEC_TO_TU(10)
+
+void iwl_mvm_roc_duration_and_delay(struct ieee80211_vif *vif,
+				    u32 duration_ms,
+				    u32 *duration_tu,
+				    u32 *delay)
+{
+	u32 dtim_interval = vif->bss_conf.dtim_period *
+		vif->bss_conf.beacon_int;
+
+	*delay = AUX_ROC_MIN_DELAY;
+	*duration_tu = MSEC_TO_TU(duration_ms);
+
+	/*
+	 * If we are associated we want the delay time to be at least one
+	 * dtim interval so that the FW can wait until after the DTIM and
+	 * then start the time event, this will potentially allow us to
+	 * remain off-channel for the max duration.
+	 * Since we want to use almost a whole dtim interval we would also
+	 * like the delay to be for 2-3 dtim intervals, in case there are
+	 * other time events with higher priority.
+	 */
+	if (vif->cfg.assoc) {
+		*delay = min_t(u32, dtim_interval * 3, AUX_ROC_MAX_DELAY);
+		/* We cannot remain off-channel longer than the DTIM interval */
+		if (dtim_interval <= *duration_tu) {
+			*duration_tu = dtim_interval - AUX_ROC_SAFETY_BUFFER;
+			if (*duration_tu <= AUX_ROC_MIN_DURATION)
+				*duration_tu = dtim_interval -
+					AUX_ROC_MIN_SAFETY_BUFFER;
+		}
+	}
+}
+
+int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
+			struct ieee80211_channel *channel,
+			struct ieee80211_vif *vif,
+			int duration, u32 activity)
+{
+	int res;
+	u32 duration_tu, delay;
+	struct iwl_roc_req roc_req = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
+		.activity = cpu_to_le32(activity),
+		.sta_id = cpu_to_le32(mvm->aux_sta.sta_id),
+	};
+
+	lockdep_assert_held(&mvm->mutex);
+
+	/* Set the channel info data */
+	iwl_mvm_set_chan_info(mvm, &roc_req.channel_info,
+			      channel->hw_value,
+			      iwl_mvm_phy_band_from_nl80211(channel->band),
+			      IWL_PHY_CHANNEL_MODE20, 0);
+
+	iwl_mvm_roc_duration_and_delay(vif, duration, &duration_tu,
+				       &delay);
+	roc_req.duration = cpu_to_le32(duration_tu);
+	roc_req.max_delay = cpu_to_le32(delay);
+
+	IWL_DEBUG_TE(mvm,
+		     "\t(requested = %ums, max_delay = %ums)\n",
+		     duration, delay);
+	IWL_DEBUG_TE(mvm,
+		     "Requesting to remain on channel %u for %utu\n",
+		     channel->hw_value, duration_tu);
+
+	/* Set the node address */
+	memcpy(roc_req.node_addr, vif->addr, ETH_ALEN);
+
+	res = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(MAC_CONF_GROUP, ROC_CMD),
+				   0, sizeof(roc_req), &roc_req);
+
+	return res;
+}
+
 static int
 iwl_mvm_start_p2p_roc_session_protection(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
-- 
2.34.1


