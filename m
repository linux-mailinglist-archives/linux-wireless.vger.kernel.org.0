Return-Path: <linux-wireless+bounces-4882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE6D87F90F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12051C218A0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF4065190;
	Tue, 19 Mar 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVttem/y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D253814
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835847; cv=none; b=TtFmySVa7V8FYK/HHRWqRr+08E7arxk9f1pfR4q1QoUC1TAGlzfK/M6yX0DV/Ly6phaWVCKndMQr8BqOd9Rk4THtZ/RpraZsVVsnDbSg3bPIFmfSIeNk/H7VyMBsPNE9cyHJaQYrjbHynB3nLlVrYppSnugLFgH8PwqMhyB0Q8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835847; c=relaxed/simple;
	bh=pozbJHoxw9jFIbXWHkfN9Y1LgMzeAdYghmwfzLemInE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ano1o9bvHiQdErbN+rWGclXxFythceYFvGte5H+GkTimTIIOFJ4nCONntS16KXhXYtwYIumc3yZwK0+7whx+9VY3Qk+25yoJOZzc1Z0CcUpXO9HH1fNoWuoS+qCN94fb/jIb3sk7hfUoRiONCNk/6iJfRQlcWMkCyVXZfYFbBJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVttem/y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835844; x=1742371844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pozbJHoxw9jFIbXWHkfN9Y1LgMzeAdYghmwfzLemInE=;
  b=GVttem/yxeMW4uWisrl9jpQ8c49fHHhrR91EpOu3UUQKwu7LjHPeEwT0
   HupVClwMc2VUtb0j8cyOaI14ydtqv1PmOsE3DihD5J9oLyDgmX49QJpKP
   VdrFm6KBWoDV9m++he/91RjLXSyZDShlYSWu9tKSYd/BWSMep99jO5Tj0
   BDNXzKug6814bC4H4YCmX/QFOq87B9zccwQBVWPIAv4ouhnN3wwOddz9z
   bkI6WowDU/tsmKRGMwdLOgMsX1bdbvqrAAGCAMqWUVmUFfFipOhwo0uT/
   M5oeOiqXqVN6oC181lQr40FqcxFnAqlJyIC/aKvvaaf2fVMgc4ajL/hIg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810519"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810519"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447564"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: mvm: Add debugfs entry for triggering internal MLO scan
Date: Tue, 19 Mar 2024 10:10:14 +0200
Message-Id: <20240319100755.3dd3e8c42c27.I9434dc641b837601c72f10684fbfad2c0fb31a99@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index ea5488721977..3d272b3bed4e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -692,6 +692,60 @@ static ssize_t iwl_dbgfs_quota_min_read(struct file *file,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
 }
 
+static ssize_t iwl_dbgfs_int_mlo_scan_write(struct ieee80211_vif *vif,
+					    char *buf, size_t count,
+					    loff_t *ppos)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	u32 action;
+	int ret;
+
+	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif))
+		return -EINVAL;
+
+	if (kstrtou32(buf, 0, &action))
+		return -EINVAL;
+
+	mutex_lock(&mvm->mutex);
+
+	if (!action) {
+		ret = iwl_mvm_scan_stop(mvm, IWL_MVM_SCAN_INT_MLO, false);
+	} else if (action == 1) {
+		struct ieee80211_channel *channels[IEEE80211_MLD_MAX_NUM_LINKS];
+		unsigned long usable_links = ieee80211_vif_usable_links(vif);
+		size_t n_channels = 0;
+		u8 link_id;
+
+		rcu_read_lock();
+
+		for_each_set_bit(link_id, &usable_links,
+				 IEEE80211_MLD_MAX_NUM_LINKS) {
+			struct ieee80211_bss_conf *link_conf =
+				rcu_dereference(vif->link_conf[link_id]);
+
+			if (WARN_ON_ONCE(!link_conf))
+				continue;
+
+			channels[n_channels++] = link_conf->chanreq.oper.chan;
+		}
+
+		rcu_read_unlock();
+
+		if (n_channels)
+			ret = iwl_mvm_int_mlo_scan_start(mvm, vif, channels,
+							 n_channels);
+		else
+			ret = -EINVAL;
+	} else {
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&mvm->mutex);
+
+	return ret ?: count;
+}
+
 #define MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz) \
 	_MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz, struct ieee80211_vif)
 #define MVM_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz) \
@@ -711,6 +765,7 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(uapsd_misbehaving, 20);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(rx_phyinfo, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(quota_min, 32);
 MVM_DEBUGFS_READ_FILE_OPS(os_device_timediff);
+MVM_DEBUGFS_WRITE_FILE_OPS(int_mlo_scan, 32);
 
 void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
@@ -738,6 +793,7 @@ void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	MVM_DEBUGFS_ADD_FILE_VIF(rx_phyinfo, mvmvif->dbgfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE_VIF(quota_min, mvmvif->dbgfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE_VIF(os_device_timediff, mvmvif->dbgfs_dir, 0400);
+	MVM_DEBUGFS_ADD_FILE_VIF(int_mlo_scan, mvmvif->dbgfs_dir, 0200);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
 	    mvmvif == mvm->bf_allowed_vif)
-- 
2.34.1


