Return-Path: <linux-wireless+bounces-4895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A2487F91E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DA31C21ACA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D37D410;
	Tue, 19 Mar 2024 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjWDR1JX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3A7D405
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835876; cv=none; b=KEDOkXEy9Lrl33ueCCPKIChWdso5NoJm/EYfVMo/NOtRcVEBDupZdBoEVcrGPkgaUvXTzpXdodTKg0h8n2g6bQ3aQUORM0p2oRGydRdIelqQXh4sAMbWApqTePfkMb3xJRqUw03Ryru/HbYiaZdxkSU/KVoo0DKNHl2vEjqOuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835876; c=relaxed/simple;
	bh=m4gdu3SsjGZk0Mj7gnTHpz00AgyeI8RSwfsICw7jdAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SSoyN7o0Oox4qwYeNVVVXt+2DLEhsOREgMXZpCdhwsCYwluytOuAZ+Ap5pQcHVvYlPbgWSo9XiN+PjQ++VnL0ckwOLwQFotrfM+SvpZ6FdsgdczbGzaRIspmJ6GPeJ2EtmVB2PS9U6Ko2O9JqGysSmrvN9uE2bR1xplWQbyXV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjWDR1JX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835875; x=1742371875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m4gdu3SsjGZk0Mj7gnTHpz00AgyeI8RSwfsICw7jdAE=;
  b=fjWDR1JXNtD/jyIuNXkl/D9krqWx3FAcxCV44J1ngbZVJiS48dVyFlR1
   9uJ0zQvm+3KW+XT3tGiUufpXsrk9h/21I+ei942H7hcTDBNx8lSLKV9Ec
   bnGxOQyABeddZ9epk8xCBDr59JJW8FZFW9JhO5eKWg+wq02vtjz/urAte
   rr3xsz9+CLKC92eBzwFw4TH1bEZ2kYEzoPbv6IVl8cBoZYHJLq45xr0LB
   jwEbptF+acxyj6LGl4V8n4Vdt1/yiLiUHYYxTDGo2eSwhZpTDCcBvLfVu
   DLAAwq+0fIKwTrtk2WZf2zQYPLvpfTIjStbYQ0AnNGI4DzANS0BRdWtcq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810594"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810594"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447682"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: allocate STA links only for active links
Date: Tue, 19 Mar 2024 10:10:27 +0200
Message-Id: <20240319100755.f2093ff73465.Ie891e1cc9c9df09ae22be6aad5c143e376f40f0e@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

For the mvm driver, data structures match what's in the firmware,
we allocate FW IDs for them already etc. During link switch we
already allocate/free the STA links appropriately, but initially
we'd allocate them always. Fix this to allocate memory, a STA ID,
etc. only for active links.

Fixes: 57974a55d995 ("wifi: iwlwifi: mvm: refactor iwl_mvm_mac_sta_state_common()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 1628bf55458f..6f9ba0c18fa3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -582,14 +582,14 @@ static int iwl_mvm_mld_alloc_sta_links(struct iwl_mvm *mvm,
 				       struct ieee80211_sta *sta)
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	struct ieee80211_link_sta *link_sta;
 	unsigned int link_id;
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	for (link_id = 0; link_id < ARRAY_SIZE(sta->link); link_id++) {
-		if (!rcu_access_pointer(sta->link[link_id]) ||
-		    mvm_sta->link[link_id])
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		if (WARN_ON(mvm_sta->link[link_id]))
 			continue;
 
 		ret = iwl_mvm_mld_alloc_sta_link(mvm, vif, sta, link_id);
-- 
2.34.1


