Return-Path: <linux-wireless+bounces-8538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5018FC9A9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B612851F5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3550B1922F1;
	Wed,  5 Jun 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8QAInNp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4AA1922FC
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585521; cv=none; b=DcMM8Eyyzua+kBuNbpWUY0zVNqDcVJR1kOL6DG0A9Iqh5c8YVW7CnY4uW3mdR6kdQZjUi/OtI2rFU7hXaBNrgJIRhW3VJ01Fbpg2v8dU1V2ZFWoj25RS6R6wDdmnGIsKh/H+n2/YqP0Evt1zkb6IdZcZ+XbT9vwpuHH/qK14rx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585521; c=relaxed/simple;
	bh=poRTMSvlRnCZKmJ/M2sASzkvEwp62t8qdwEFWW+5vtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=krFhq2bJ8sgQZy+I+aRdwmrE82UPid71Ak4I5D4oK+GaX9WLBJ3uhq7of2UN/HJbBrvUohMTOn86UxaJC+aITyWs2n2AVC5wh6rw6yBtLbRL+HRI0QP962v8Tj35S8zMbR1YC4gdtvkizRPl115wa9HCROpUalUjBQyZLrInC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8QAInNp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585519; x=1749121519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=poRTMSvlRnCZKmJ/M2sASzkvEwp62t8qdwEFWW+5vtM=;
  b=d8QAInNpCFiUuokIQbPZSWvm5QEzkvqLe7Gk4r3+pZQ2mkyJEHdAoPFU
   R9KNxm8KMMFp02O+k6LY17WoWaTiaFvecF0Bgd64pyG+ZB/8/tnRAA14q
   UvCN9whQlqjYI+PsUxiSdC4ShnKiuEExN8/mxIjynqTaRb6fJTjlJLL/0
   +ekLNqy9bZOwo3af4du6+p1+MF9pKuVHGrMOb8A2O1GsY0PyJvTsZ8OAQ
   WMugDtZ9NsQ8yfqSC5tKehxmp9Zo60QMhZ/NyHA1OH+3QJoUtVsiJEtWO
   IGEgiI4eR4F9oBiF1ff9JZkCV4oUjSUL1et8In9kFsN8x0pxh6M6PNVmm
   Q==;
X-CSE-ConnectionGUID: aH9NboCARtKVPU87+L8qoQ==
X-CSE-MsgGUID: kpZIjw1LR52r9aTytuiGBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14402176"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14402176"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:19 -0700
X-CSE-ConnectionGUID: h7zWM9EgSiiHYHcBD1bhKQ==
X-CSE-MsgGUID: RnZuhXRGQlG3am1Qx+Dmeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41997349"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/11] wifi: iwlwifi: mvm: fix DTIM skip powersave config
Date: Wed,  5 Jun 2024 14:04:59 +0300
Message-Id: <20240605140327.bccf980fadb4.Idc98b9f3634f39d2fae9bd9916f5d050ccd48f95@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
References: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When entering D3 we want to configure skip over DTIM, but
it can't use the deflink configuration, that will not even
exist. Adjust the code to handle multiple links by taking
the min skip, even if we should only have a single active
link at this point.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 64 ++++++++++---------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index cc7176b0be4f..bc363e8427e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -282,62 +282,64 @@ static bool iwl_mvm_power_allow_uapsd(struct iwl_mvm *mvm,
 	return data.allow_uapsd;
 }
 
-static bool iwl_mvm_power_is_radar(struct ieee80211_vif *vif)
+static bool iwl_mvm_power_is_radar(struct ieee80211_bss_conf *link_conf)
 {
 	struct ieee80211_chanctx_conf *chanctx_conf;
-	struct ieee80211_bss_conf *link_conf;
-	bool radar_detect = false;
-	unsigned int link_id;
 
-	rcu_read_lock();
-	for_each_vif_active_link(vif, link_conf, link_id) {
-		chanctx_conf = rcu_dereference(link_conf->chanctx_conf);
-		/* this happens on link switching, just ignore inactive ones */
-		if (!chanctx_conf)
-			continue;
+	chanctx_conf = rcu_dereference(link_conf->chanctx_conf);
 
-		radar_detect = !!(chanctx_conf->def.chan->flags &
-				  IEEE80211_CHAN_RADAR);
-		if (radar_detect)
-			goto out;
-	}
+	/* this happens on link switching, just ignore inactive ones */
+	if (!chanctx_conf)
+		return false;
 
-out:
-	rcu_read_unlock();
-	return radar_detect;
+	return chanctx_conf->def.chan->flags & IEEE80211_CHAN_RADAR;
 }
 
 static void iwl_mvm_power_config_skip_dtim(struct iwl_mvm *mvm,
 					   struct ieee80211_vif *vif,
 					   struct iwl_mac_power_cmd *cmd)
 {
-	int dtimper = vif->bss_conf.dtim_period ?: 1;
-	int skip;
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int min_link_skip = ~0;
+	unsigned int link_id;
 
 	/* disable, in case we're supposed to override */
 	cmd->skip_dtim_periods = 0;
 	cmd->flags &= ~cpu_to_le16(POWER_FLAGS_SKIP_OVER_DTIM_MSK);
 
-	if (iwl_mvm_power_is_radar(vif))
+	if (!test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status)) {
+		if (iwlmvm_mod_params.power_scheme != IWL_POWER_SCHEME_LP)
+			return;
+		cmd->skip_dtim_periods = 2;
+		cmd->flags |= cpu_to_le16(POWER_FLAGS_SKIP_OVER_DTIM_MSK);
 		return;
+	}
 
-	if (dtimper >= 10)
-		return;
+	rcu_read_lock();
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		unsigned int dtimper = link_conf->dtim_period ?: 1;
+		unsigned int dtimper_tu = dtimper * link_conf->beacon_int;
+		unsigned int skip;
 
-	if (!test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status)) {
-		if (iwlmvm_mod_params.power_scheme != IWL_POWER_SCHEME_LP)
+		if (dtimper >= 10 || iwl_mvm_power_is_radar(link_conf)) {
+			rcu_read_unlock();
 			return;
-		skip = 2;
-	} else {
-		int dtimper_tu = dtimper * vif->bss_conf.beacon_int;
+		}
 
 		if (WARN_ON(!dtimper_tu))
-			return;
+			continue;
+
 		/* configure skip over dtim up to 900 TU DTIM interval */
-		skip = max_t(u8, 1, 900 / dtimper_tu);
+		skip = max_t(int, 1, 900 / dtimper_tu);
+		min_link_skip = min(min_link_skip, skip);
 	}
+	rcu_read_unlock();
+
+	/* no WARN_ON, can only happen with WARN_ON above */
+	if (min_link_skip == ~0)
+		return;
 
-	cmd->skip_dtim_periods = skip;
+	cmd->skip_dtim_periods = min_link_skip;
 	cmd->flags |= cpu_to_le16(POWER_FLAGS_SKIP_OVER_DTIM_MSK);
 }
 
-- 
2.34.1


