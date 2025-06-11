Return-Path: <linux-wireless+bounces-23970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC140AD4972
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAFA189C066
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CC52253FB;
	Wed, 11 Jun 2025 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPowC284"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962B222577C
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612889; cv=none; b=RVuMTMP4pZPAe3CEk8ZGOlJjoo32xiz3DvZX+kfMQxDHY0lRwGwb2+EnUpcnV9IFhN2X906dWgd0dJj9QesyE/UlkcRFdLzfUpJqOhsnraCFMWMJGKggEMaWmj+wx8kj95pqmM55/6Gw2RRgWVFidKWl81+6UpYynSS0oVzONwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612889; c=relaxed/simple;
	bh=K1fwQ+ny+hLfh5lBzL06SfD1jI6wciOFuLggQJAQNEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gIhlBQwveMufn2z1jtiCNobvYbClwThimXNjnLSLbYn75/o+advO8ywtsLWUFz2BmCtJarseX5Gwpu/r9mi5KAVbInUgguDfM/7xPlAIzQJPyTis9s4KpBEfq2IF/AyYpxe08ch1qCDaKapUJEzmC513XMWVa2LlC5H9y7nVWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPowC284; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612887; x=1781148887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1fwQ+ny+hLfh5lBzL06SfD1jI6wciOFuLggQJAQNEM=;
  b=KPowC284QFxdkdQ3+1aXgutMgQnw95hPP22bgeMs2o+dsr33/TBBwYIT
   D8mjRYn+cVX3LrjBEeQ655MwSxTIAWruoOiTnAhjylUWOtO3K/B3jLcAt
   f3dDpm9z/mJWwXOXKVAV0D0PwhUooGInO38Ntfss4gbq0TH6YxXeYETpk
   i09ztG8r6WFlZPV62H8HuTCDAb2PlPFxYG8QBGO0TTEuyItOnyK4EPbbp
   Qc/+earoYe5NbeBXSde7CXb1Xf07WgUKCCMW/A0uXvuABFZweD79xTm/6
   U7hbqvwQDx2bLdrzwuo8/Iw19D+5UFzibKebzlf9qqufMMVsuTeNH7C0O
   w==;
X-CSE-ConnectionGUID: 92PdqcPpQH2Q8kf8C8W6Xw==
X-CSE-MsgGUID: 3i8uRguBRyOq0fGbmMxWJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094897"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094897"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:47 -0700
X-CSE-ConnectionGUID: anHdlgGCQby1FoFYcuK90g==
X-CSE-MsgGUID: 0nd0+a/vSw+l0uGRaQTH8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880978"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mvm: fix kernel-doc warnings
Date: Wed, 11 Jun 2025 06:34:13 +0300
Message-Id: <20250611063124.b4d451c00af5.I1b42df920b0f057a7d7ac01e61201621229a444c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
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


