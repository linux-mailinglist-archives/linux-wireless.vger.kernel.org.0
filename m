Return-Path: <linux-wireless+bounces-3107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57798490FB
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77D21C21DE0
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0663A1A0;
	Sun,  4 Feb 2024 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feCOSJsj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB936B0E
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084405; cv=none; b=r3q7xQ4WdQTwj3/v12b0W9HBWshBNoSiF5khlrY/5ehJNo55z0YGnx/tdgObTnPiMLTHLo0bjp8+deJiaiuHfJFzkti16WeZuorVG7ldcQ1M1RBF172nNG+oa1yaLIOdvq6LOgRWY7Dm5Yn/FEfbuS/kKm2uEySmio0x/r5aQ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084405; c=relaxed/simple;
	bh=5lpOTNex6thT4BEcXtAxVwOC38D1maeSPGRTgoVI7jE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bUzPK20myDn63gjdARAoo9aW8gryiPz4verGYyL6/JQY35tLq9A/DR7x0BZ2EWhwgm4rWGUbi1UrWMwFzMmAqTdwofrYaN7EmxHqi70vLIywc7Mfyza3i1JU693GLpgpODm1sIfsOfgIYK/rnY9+tPllQ9HwdFwHNI9mjaHamC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=feCOSJsj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084404; x=1738620404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5lpOTNex6thT4BEcXtAxVwOC38D1maeSPGRTgoVI7jE=;
  b=feCOSJsj9ycZ4tbaSlfj/22E7NF6IYarzXyymqJNaaP/SnT7lp78BJma
   x7P3ywBWtUh8HeK2aCPHzDIwYWSH/k0eqNnqcQ/LWn6gsUNTy6t2fyVGy
   N/YjWNox1UKcnuWbmyooC4ZKv3TbCZxnFQR4jLzMX/PnUft1oq2LKepC1
   OgTfb00/VnBoawK8evnCvRYrHBVvU9AM427Img18dOVALEp1VzM56ViXO
   BDX+KzYeRSLYNe7Cmw0YCcXCypsBPXiy+FAMgPMRV1oPXmLWJ1SEcncGP
   3wQK4O2oa8ciTsoOwh8ER8lrxzhF0T8KKdoCYXqekVTo+mnvfYBshP8w5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869374"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869374"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815877"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: adjust rx_phyinfo debugfs to MLO
Date: Mon,  5 Feb 2024 00:06:08 +0200
Message-Id: <20240204235836.a68ee2b6cb58.Iddc47c608ec990b12be0ae5b1ee89bcf6beb0f6a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This debugfs entry is used to configure the rx_phyinfo.
Currently we are sending the phy cmd only for the deflink.
Change it to send the cmd for all active links of the vif

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 44 ++++++++++++-------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index e8b881596baf..2b96cf9eac72 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -578,34 +578,46 @@ static ssize_t iwl_dbgfs_rx_phyinfo_write(struct ieee80211_vif *vif, char *buf,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = mvmvif->mvm;
-	struct ieee80211_chanctx_conf *chanctx_conf;
-	struct iwl_mvm_phy_ctxt *phy_ctxt;
+	struct ieee80211_bss_conf *link_conf;
 	u16 value;
-	int ret;
+	int link_id, ret = -EINVAL;
 
 	ret = kstrtou16(buf, 0, &value);
 	if (ret)
 		return ret;
 
 	mutex_lock(&mvm->mutex);
-	rcu_read_lock();
 
-	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
-	/* make sure the channel context is assigned */
-	if (!chanctx_conf) {
+	mvm->dbgfs_rx_phyinfo = value;
+
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		struct ieee80211_chanctx_conf *chanctx_conf;
+		struct cfg80211_chan_def min_def;
+		struct iwl_mvm_phy_ctxt *phy_ctxt;
+		u8 chains_static, chains_dynamic;
+
+		rcu_read_lock();
+		chanctx_conf = rcu_dereference(link_conf->chanctx_conf);
+		if (!chanctx_conf) {
+			rcu_read_unlock();
+			continue;
+		}
+		/* A command can't be sent with RCU lock held, so copy
+		 * everything here and use it after unlocking
+		 */
+		min_def = chanctx_conf->min_def;
+		chains_static = chanctx_conf->rx_chains_static;
+		chains_dynamic = chanctx_conf->rx_chains_dynamic;
 		rcu_read_unlock();
-		mutex_unlock(&mvm->mutex);
-		return -EINVAL;
-	}
 
-	phy_ctxt = &mvm->phy_ctxts[*(u16 *)chanctx_conf->drv_priv];
-	rcu_read_unlock();
+		phy_ctxt = mvmvif->link[link_id]->phy_ctxt;
+		if (!phy_ctxt)
+			continue;
 
-	mvm->dbgfs_rx_phyinfo = value;
+		ret = iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, &min_def,
+					       chains_static, chains_dynamic);
+	}
 
-	ret = iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, &chanctx_conf->min_def,
-				       chanctx_conf->rx_chains_static,
-				       chanctx_conf->rx_chains_dynamic);
 	mutex_unlock(&mvm->mutex);
 
 	return ret ?: count;
-- 
2.34.1


