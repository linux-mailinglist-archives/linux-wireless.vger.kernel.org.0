Return-Path: <linux-wireless+bounces-24013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED28AD5F11
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81311BC0F0E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C68A2BEC25;
	Wed, 11 Jun 2025 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxTeJnbI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA8A2BE7D7
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670028; cv=none; b=b6zn4yXHWO649Wc5OOLFn+NrHo67DZxAey1LPuThzle6aktYyTxmHjFAXeGyXSEXSyj5CrfRqo6Urv1pCoCyIKzEAVYr/yVHVBWSXoxoPGbcXD3A686zhVkSa7HrUGbr5UVq5I6ZLQsB+05TAokIW+Bg+ixODqmfLJzC9lb1d10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670028; c=relaxed/simple;
	bh=K1fwQ+ny+hLfh5lBzL06SfD1jI6wciOFuLggQJAQNEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7KcwloFjp3Tn0GdPddlhSsVBXkeZ8F7Diz1snVq/zlhOQXdNz/GB7xjjPdKSnb1ZyAz+Y3yzxPmPgkokH1Ej7pDvnuk0AAlIqhLiPHkP+pA7GF4MLN7PQhDZrmq9caJjo3+Eg5GmVrIWaTXAP5bqgjTMbpON1Hy8P+41gs0Ptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxTeJnbI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670027; x=1781206027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1fwQ+ny+hLfh5lBzL06SfD1jI6wciOFuLggQJAQNEM=;
  b=NxTeJnbIf/pMjvJbBqMIw3P2YX3ONzp6A9A+W6cHIyW1c9C2pkra0bXt
   xtwNyThuI+GR7WU0MSx1x7RSUOVCojWCn6D2EpqxNe2lmE+T0qv91avle
   lfYI7vmGA8ZRHYImFNio1tJVTbLuJ7DDq2YLQI+5SijC7nbIFpviLOkmN
   anHoDqvcMJO0p7BPHbSEfSfDNEz5LO3AdW0LVhxN5jnjrS2Y24IFyJcv4
   DT3A+PS58ly1Q4xLO6sq2qoaOsch+qeNEA7YLp+VW84+O6M0lrRq5lIll
   gfN3qniYtZCdY38mbBNqw6aoqLPM2+9SD3hsmN6G2pAh8xOE2+7S3MPIE
   g==;
X-CSE-ConnectionGUID: YwgHsLRUQYSKJnaqPk7PZg==
X-CSE-MsgGUID: qrFpWy9dQWa5SMGETPJKNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360902"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360902"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:27:07 -0700
X-CSE-ConnectionGUID: hK32OEpaRHSTw47sQpciJQ==
X-CSE-MsgGUID: 6GASE0IjRfKsEGU5PpBFUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165886"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:27:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v2 13/15] wifi: iwlwifi: mvm: fix kernel-doc warnings
Date: Wed, 11 Jun 2025 22:26:32 +0300
Message-Id: <20250611222325.f238dd2937ed.I1b42df920b0f057a7d7ac01e61201621229a444c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
References: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Some kernel-doc warnings remain, fix them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h         | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h        | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.h | 8 ++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index 69259ebb966b..dfb062b7c5c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -411,6 +411,7 @@ void iwl_mvm_rs_tx_status(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
  * with the mac80211 subsystem.  This should be performed prior to calling
  * ieee80211_register_hw
  *
+ * Return: negative error code, or 0 on success
  */
 int iwl_mvm_rate_control_register(void);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 6b183f5e9bbc..f6906061510b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -214,7 +214,7 @@ struct iwl_mvm_vif;
  */
 
 /**
- * enum iwl_mvm_agg_state
+ * enum iwl_mvm_agg_state - aggregation session state
  *
  * The state machine of the BA agreement establishment / tear down.
  * These states relate to a specific RA / TID.
@@ -483,6 +483,7 @@ struct iwl_mvm_int_sta {
  *	about. Otherwise (if this is a new STA), this should be false.
  * @flags: if update==true, this marks what is being changed via ORs of values
  *	from enum iwl_sta_modify_flag. Otherwise, this is ignored.
+ * Return: negative error code or 0 on success
  */
 int iwl_mvm_sta_send_to_fw(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			   bool update, unsigned int flags);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
index 49256ba4cf58..1ef8768756db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2019-2020, 2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2019-2020, 2023, 2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  */
 #ifndef __time_event_h__
@@ -124,6 +124,8 @@ void iwl_mvm_rx_roc_notif(struct iwl_mvm *mvm,
  * ROC request, it will issue a notification to the driver that it is on the
  * requested channel. Once the FW completes the ROC request it will issue
  * another notification to the driver.
+ *
+ * Return: negative error code or 0 on success
  */
 int iwl_mvm_start_p2p_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			  int duration, enum ieee80211_roc_type type);
@@ -179,6 +181,8 @@ void iwl_mvm_remove_csa_period(struct iwl_mvm *mvm,
  *
  * This function is used to schedule NoA time event and is used to perform
  * the channel switch flow.
+ *
+ * Return: negative error code or 0 on success
  */
 int iwl_mvm_schedule_csa_period(struct iwl_mvm *mvm,
 				struct ieee80211_vif *vif,
@@ -188,7 +192,7 @@ int iwl_mvm_schedule_csa_period(struct iwl_mvm *mvm,
  * iwl_mvm_te_scheduled - check if the fw received the TE cmd
  * @te_data: the time event data that corresponds to that time event
  *
- * This function returns true iff this TE is added to the fw.
+ * Return: %true if this TE is added to the fw, %false otherwise
  */
 static inline bool
 iwl_mvm_te_scheduled(struct iwl_mvm_time_event_data *te_data)
-- 
2.34.1


