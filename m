Return-Path: <linux-wireless+bounces-9887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19212924FE3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 05:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A03F1C228FD
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 03:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4739E17BCA;
	Wed,  3 Jul 2024 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKdkKrpA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4511944D
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 03:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978217; cv=none; b=Uq8KgfZPViYdEw3mnI6pup/6VXQLZHCGSosB7BSTNhAf9dRiHxaZVf30JAl03ihK6wWkJuDGWuZuYKewIfFV1u4pYheOz2oHcI53Y/haSPG7DVuSPudDOoj9KUiuHNi05dTvXvEhD/GSPBJUyvZXNehWVZCsCOR/c3i1bgIp+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978217; c=relaxed/simple;
	bh=ORu4esC9TC6tZAAg/yPCb6rBYdG0EYVV9zFvby4edIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DvXa8jZFWvEe9xom8chewvJCFmvcXHEuB2KNgfgnwwrMmPR8LUB6N95ht4Qzj2aaf4ajMZIKrEIYZMuudxoJMZlz9f+kW/fNuhGHGat2B1ZaXk1rg8QkJw1uhY09NkPy9EMZ3FYjoxkJlReOgNpWu8JhA0x+CAJQOaA9FiIe5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKdkKrpA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719978216; x=1751514216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ORu4esC9TC6tZAAg/yPCb6rBYdG0EYVV9zFvby4edIo=;
  b=LKdkKrpAFjXpomCmIYc8tOcGyoAupxISJFka/Lc7TIfHxFLNN9Nb+zav
   9rUiEUWXpxPITbmjXYM7yR2bRZCaTYN38tApWXnIR+Y5TFIrl8V2ZdIai
   xuaC+tW+jNpwGNEtFVIx1an+ZQb3PPKtosyUTZAo0gtJQCM6b5RY0OpFg
   uNNvV8WXwdmUZ3n7xRfdg/wXaxxyl7JFR4WbSjb18yW3ACuR6/TpaU/Gp
   mdaqncC8Nnj1GWYwPjy+wHyfp3MoHTVm9noTtD/Kaoq/klbJgyJRe6H2L
   Ip1ma9pk9KPGeCyXaV/HNqgVdy0J6yWPVEkdum/OC6cafd8/XmOp9CSyr
   Q==;
X-CSE-ConnectionGUID: UZdLzIgSTwmhMFOKeuACcA==
X-CSE-MsgGUID: 8rQee/XnRLanF1fJoAcIZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17304049"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17304049"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 20:43:35 -0700
X-CSE-ConnectionGUID: HRBiT78HSoKubnaaGeBnOA==
X-CSE-MsgGUID: YVR9NZF5TsODEyh/TUJSRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="51291080"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 20:43:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/5] wifi: iwlwifi: mvm: don't send an ROC command with max_delay = 0
Date: Wed,  3 Jul 2024 06:43:17 +0300
Message-Id: <20240703064027.e12f8d84c8fd.I3dd9f720c678c06ec7a5bf7ca56e21cf0b614c8c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703034317.595020-1-miriam.rachel.korenblit@intel.com>
References: <20240703034317.595020-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware can't handle that (it will crash with ASSERT 300A).
This happened because we looked at vif->bss_conf which is not
the right bss_conf to look at in case of an MLD connection.
Fix iwl_mvm_roc_duration_and_delay to iterate on the active links to
get the right value for the dtim_interval.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/time-event.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 31bc80cdcb7d..97cfd72312f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -984,12 +984,21 @@ void iwl_mvm_roc_duration_and_delay(struct ieee80211_vif *vif,
 				    u32 *duration_tu,
 				    u32 *delay)
 {
-	u32 dtim_interval = vif->bss_conf.dtim_period *
-		vif->bss_conf.beacon_int;
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
+	u32 dtim_interval = 0;
 
 	*delay = AUX_ROC_MIN_DELAY;
 	*duration_tu = MSEC_TO_TU(duration_ms);
 
+	rcu_read_lock();
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		dtim_interval =
+			max_t(u32, dtim_interval,
+			      link_conf->dtim_period * link_conf->beacon_int);
+	}
+	rcu_read_unlock();
+
 	/*
 	 * If we are associated we want the delay time to be at least one
 	 * dtim interval so that the FW can wait until after the DTIM and
@@ -998,8 +1007,10 @@ void iwl_mvm_roc_duration_and_delay(struct ieee80211_vif *vif,
 	 * Since we want to use almost a whole dtim interval we would also
 	 * like the delay to be for 2-3 dtim intervals, in case there are
 	 * other time events with higher priority.
+	 * dtim_interval should never be 0, it can be 1 if we don't know it
+	 * (we haven't heard any beacon yet).
 	 */
-	if (vif->cfg.assoc) {
+	if (vif->cfg.assoc && !WARN_ON(!dtim_interval)) {
 		*delay = min_t(u32, dtim_interval * 3, AUX_ROC_MAX_DELAY);
 		/* We cannot remain off-channel longer than the DTIM interval */
 		if (dtim_interval <= *duration_tu) {
-- 
2.34.1


