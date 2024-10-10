Return-Path: <linux-wireless+bounces-13845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE4399846A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 13:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490B0B2497A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 11:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C15F1C2DA3;
	Thu, 10 Oct 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+KDtyq/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C8E1C2440
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558327; cv=none; b=lUwk9Hqa+NbsO28mjOUMK8SHqycKcPKnje+vi4AYhHyPogogv/ByJC8IyAMKOwMpA+9FuwpJTZm14U1m0iFtf7kHjn2ByYfS1nFzyk1UfL51OCI0WuUnrxeSZoGHruQWD3FXjTdVO9R18e9P8t9sFFp6NvG3BXqcrMAFh+Aob/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558327; c=relaxed/simple;
	bh=ps94RmKSdbuIVQBNiIeANIEj0is8vWU/iN9oCSwTRTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZMINgCYpguc0bO6oAN6wY+yPn3eP1XLmhQzMZenx4oBpshaeI80v9p72mI0uw5Xc+ik3nzSvWSCTRk29mBjozdoxGItk6StFh5F83+SuFR+x1pCZnmAz+xiriy0BK2U8lyVrMicQEELGAjV527TxJk4OMLjOc7+2djGmi51Mg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+KDtyq/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728558326; x=1760094326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ps94RmKSdbuIVQBNiIeANIEj0is8vWU/iN9oCSwTRTY=;
  b=S+KDtyq/PIulLvTIEsHNJVKtvaKM/q32BAlme6X0jOuiSWsd1mTxzK3c
   C1RTQvFjIo0T4xDLcxDFeY791Ie1y/OSGNWR3tsnmxCRquppZJ1egB6uX
   xRH/jhdJyBZTbRnD9F26o22kQRi79/DI3SwjFOgsxP5RyLYJHH1MFI0Nk
   4r6j5q8dryEIGthaFfCCubaTikzYsDPfFyQAtW5lXtTiMHqwqlLGnXGPy
   1TQdRUtzMvtlfzZynUOSGkd03mbX8+KikCYov/MoQm3NlCkFeJYPGWTMg
   xf0UEehFlb68P1lp4lGjupiKVTHsIZngLWW3AswD4Sjc9P5QlozbDh8Kl
   A==;
X-CSE-ConnectionGUID: KRP2OsY4QeeA+m6yPp//vw==
X-CSE-MsgGUID: m261vDogQhGN2+1NXPCzsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31697734"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31697734"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:26 -0700
X-CSE-ConnectionGUID: LcW4wbujTuCkNWPgEN6DbQ==
X-CSE-MsgGUID: 0MHzHB4rRF2Xix4GC6HO3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81362314"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/9] wifi: iwlwifi: mvm: really send iwl_txpower_constraints_cmd
Date: Thu, 10 Oct 2024 14:05:01 +0300
Message-Id: <20241010140328.5c235fccd3f1.I2d40dea21e5547eba458565edcb4c354d094d82a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
References: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_mvm_send_ap_tx_power_constraint_cmd is a no-op if the link is not
active (we need to know the band etc.)
However, for the station case it will be called just before we set the
link to active (by calling iwl_mvm_link_changed with
the LINK_CONTEXT_MODIFY_ACTIVE bit set in the 'changed' flags and
active = true), so it will end up doing nothing.

Fix this by calling iwl_mvm_send_ap_tx_power_constraint_cmd before
iwl_mvm_link_changed.

Fixes: 6b82f4e119d1 ("wifi: iwlwifi: mvm: handle TPE advertised by AP")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index f2378e0fb2fb..bd043db906db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -350,11 +350,6 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 		rcu_read_unlock();
 	}
 
-	if (vif->type == NL80211_IFTYPE_STATION)
-		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
-							link_conf,
-							false);
-
 	/* then activate */
 	ret = iwl_mvm_link_changed(mvm, vif, link_conf,
 				   LINK_CONTEXT_MODIFY_ACTIVE |
@@ -363,6 +358,11 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	if (ret)
 		goto out;
 
+	if (vif->type == NL80211_IFTYPE_STATION)
+		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
+							link_conf,
+							false);
+
 	/*
 	 * Power state must be updated before quotas,
 	 * otherwise fw will complain.
-- 
2.34.1


