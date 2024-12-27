Return-Path: <linux-wireless+bounces-16835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7202B9FD1BE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24005160706
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B58A920;
	Fri, 27 Dec 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRJFbzpn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C01552E0
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286508; cv=none; b=Dh1680AiLeDCug3EhfpTx6ACGAlpgB32VIu9jchb1jdxwG5s768G5rfwygR61zXYQ/PTPz8uCWnITlwSMGarsSICUQD+XbCevEIWMlZ1NRlObVE2gk+vegDRjE3Gi9L+IBfeWR0Os7IXubTt+QQIcwCRoT9DOrDdkQvZm6BWEWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286508; c=relaxed/simple;
	bh=1M0hPQBjZutLl/U++CNoIvpelQwiHgBMwQrcC6PG/Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjgChX4ubYGw27wi/T5TMr9TQYry3P4RpZbkTUZ2drSpTQeCv5hRcdFmbx1vP9UqGRdZKCV52J8q22u1o7zB/BvQ1vdw5FgZ0Cnqkgq37TMaZV2n+U7rKc1d7KGHp97QjbEvWHLYgngyGk2O9naMbdf0qYKrUGORvSbYVdzOLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRJFbzpn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286507; x=1766822507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1M0hPQBjZutLl/U++CNoIvpelQwiHgBMwQrcC6PG/Gw=;
  b=bRJFbzpn5YMEy0eFsw0jN5W5heC0wKZcSMOfu4moolvmZLegmtk6IsEl
   gDKSN4iD6+mOjzY6PM9Oh/Hi2Pk8iL4xAoO7tTNKVqEXVsSrOO2bVBbds
   LVFLO+gDJ0mGukA32O/BEHU5z0ivFs3dh124Px3wdPscOW3iBYcShfdXs
   7lG7ewC64ElIn3kRQrigZILlBUO+ush+WywKfswYq9Y1hHBazZpFxSwh4
   BeGDvkcdtu3imFzSERC0umlRRI5nUmRI8c8JlFrmgJ4ylxzSDBzwMegdG
   KcqQ/GbKz06c+GCOqJh6E/87NjQOH6F2/WPDoL1TuQR0Q/vA17le1m4Mt
   Q==;
X-CSE-ConnectionGUID: AHzaBGJDSCyzuDoLGl3GWA==
X-CSE-MsgGUID: n7u7h6XPSnGx7Lqxqy8ERw==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46691001"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46691001"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:47 -0800
X-CSE-ConnectionGUID: 8NrTtivYT6KhDPNer8XYaQ==
X-CSE-MsgGUID: bi+E0SuuQPytrcFul0WGYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858456"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:45 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/17] wifi: iwlwifi: mvm: restart device through NMI
Date: Fri, 27 Dec 2024 10:01:10 +0200
Message-Id: <20241227095718.96b732029d20.I2e729f402db58a76cea620b6f62a02da49a10b48@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When some channel context manipulations fail, the device
is going to be restarted to try to recover. Make this go
through a real FW restart via an NMI so the transport is
aware of it and can later handle escalation, and to make
it easier to restructure the code later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 1 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 9a6dd59fbc6c..039d0d6ed61d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5412,7 +5412,7 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 
 out_restart:
 	/* things keep failing, better restart the hw */
-	iwl_mvm_nic_restart(mvm);
+	iwl_force_nmi(mvm->trans);
 	return ret;
 }
 
@@ -5448,7 +5448,7 @@ iwl_mvm_switch_vif_chanctx_reassign(struct iwl_mvm *mvm,
 
 out_restart:
 	/* things keep failing, better restart the hw */
-	iwl_mvm_nic_restart(mvm);
+	iwl_force_nmi(mvm->trans);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 40a609533eb2..dbf32bf5760b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2586,7 +2586,6 @@ void iwl_mvm_tcm_add_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 void iwl_mvm_tcm_rm_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 u8 iwl_mvm_tcm_load_percentage(u32 airtime, u32 elapsed);
 
-void iwl_mvm_nic_restart(struct iwl_mvm *mvm);
 unsigned int iwl_mvm_get_wd_timeout(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif);
 void iwl_mvm_connection_loss(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 13a24030acdb..ef54ba818d1f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2025,7 +2025,7 @@ static void iwl_mvm_reprobe_wk(struct work_struct *wk)
 	module_put(THIS_MODULE);
 }
 
-void iwl_mvm_nic_restart(struct iwl_mvm *mvm)
+static void iwl_mvm_nic_restart(struct iwl_mvm *mvm)
 {
 	iwl_abort_notification_waits(&mvm->notif_wait);
 	iwl_dbg_tlv_del_timers(mvm->trans);
-- 
2.34.1


