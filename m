Return-Path: <linux-wireless+bounces-24065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5424FAD6F74
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096453B1E79
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FCF23E226;
	Thu, 12 Jun 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mode+mG1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1FE2417C6
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728970; cv=none; b=XgRqzenZAs+3Pl43W9ooFt1iDKzVOqm0AyI15ZXFM2GH2kzfApK3ltv6RfQPzmTmOyQbxSDaHTwdQFe4xSVD4cmY3+bjFyjcGvDRtrLr4JFinD3bx1WPiNDaOWFo3Dxda7X7rt5QRZvqBfAD3AaXlSLJtY/E1nY2EPEcYHJqnic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728970; c=relaxed/simple;
	bh=DLFcisTYx+sKUi9H0/sbzaYWAWff26U8DExTF8bXn34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHgJ4+3wBKwkpa33h80Zb9Vx58fTaASw62sNBGx365kRDt3/saoomKca3tNYrsF5V44Zn14ARwf2IE1fDLCxFx7SUiGDsLUYHPk4MkI1jXRQzt8QEQN9iVqSZ95nwovvEIzS+NYqd2Sy80cJeP9KN5FCbb+DfqKA3oUwChQkdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mode+mG1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728969; x=1781264969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DLFcisTYx+sKUi9H0/sbzaYWAWff26U8DExTF8bXn34=;
  b=Mode+mG1rLlXhzL/3o4AHOYjuhTUv2MLatDrrizy0MaQduCF6VO5TG/y
   OVpQ2FgASrr78EyMRv+wzRxvj8/boQjbbjNxNIT61BpXng6U10RwdwR72
   pa0HFmdEyvZwCFfFeqwHMIpVjRVDQ6Q733MlM+sIFNg5zyrMZzihom5J0
   WqacAB1UlYCmEmjWhEzlQfA2m5Bm7ku43G4I1XDmmC4UP9xHNMBphzdpf
   efnhgnJmd4/DVXRkbqbxvDqVaI+Ih2ty6k4nH1ZjyuY33OUX6Bu9tueX/
   Aeg7Y40a1evAf/+fWH4thnE0hFTjQAomRCvhSj7AdqkGeZJ1v5MdB0Ims
   w==;
X-CSE-ConnectionGUID: fGiD/XYkRgSITlmkOVjthQ==
X-CSE-MsgGUID: hFr0U4vaS9achmbPJ8xSIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248348"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248348"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:29 -0700
X-CSE-ConnectionGUID: WGPcv+O9SS26Jbr12YTC6g==
X-CSE-MsgGUID: pyNAHrVBQCe5FD5O6yVibg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382178"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/13] wifi: iwlwifi: mld: don't exit EMLSR when we shouldn't
Date: Thu, 12 Jun 2025 14:48:57 +0300
Message-Id: <20250612144708.c680f8d7dc37.I8a02d1e8d99df3789da8d5714f19b31a865a61ff@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
References: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

There is a requirement to exit EMLSR if there wasn't enough throughput
in the secondary link.
This is checked in check_tpt_wk, which runs every 5 seconds in a high
throughput scenario (when the throughput blocker isn't set)

It can happen that this worker is running immediately after we entered
EMLSR, and in that case the secondary link didn't have a chance to have
throughput. In that case we will exit EMLSR for no good reason.

Fix this by tracking the time we entered EMLSR, and in the worker make
sure that 5 seconds passed from when we entered EMLSR. If not, don't
check the secondary link throughput.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.h    | 3 +++
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 1 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c      | 8 +++++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 874e9ef9e798..05dcb63701b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -87,6 +87,8 @@ enum iwl_mld_emlsr_exit {
  * @last_exit_reason: Reason for the last EMLSR exit
  * @last_exit_ts: Time of the last EMLSR exit (if @last_exit_reason is non-zero)
  * @exit_repeat_count: Number of times EMLSR was exited for the same reason
+ * @last_entry_ts: the time of the last EMLSR entry (if iwl_mld_emlsr_active()
+ *	is true)
  * @unblock_tpt_wk: Unblock EMLSR because the throughput limit was reached
  * @check_tpt_wk: a worker to check if IWL_MLD_EMLSR_BLOCKED_TPT should be
  *	added, for example if there is no longer enough traffic.
@@ -105,6 +107,7 @@ struct iwl_mld_emlsr {
 		enum iwl_mld_emlsr_exit last_exit_reason;
 		unsigned long last_exit_ts;
 		u8 exit_repeat_count;
+		unsigned long last_entry_ts;
 	);
 
 	struct wiphy_work unblock_tpt_wk;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index a8b2e2046d76..8a24ca0e1e89 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1009,6 +1009,7 @@ int iwl_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 		/* Indicate to mac80211 that EML is enabled */
 		vif->driver_flags |= IEEE80211_VIF_EML_ACTIVE;
+		mld_vif->emlsr.last_entry_ts = jiffies;
 
 		if (vif->active_links & BIT(mld_vif->emlsr.selected_links))
 			mld_vif->emlsr.primary = mld_vif->emlsr.selected_primary;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 8ed2c6de1282..be66a71a0fd7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -560,10 +560,12 @@ void iwl_mld_emlsr_check_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
 	/*
 	 * TPT is unblocked, need to check if the TPT criteria is still met.
 	 *
-	 * If EMLSR is active, then we also need to check the secondar link
-	 * requirements.
+	 * If EMLSR is active for at least 5 seconds, then we also
+	 * need to check the secondary link requirements.
 	 */
-	if (iwl_mld_emlsr_active(vif)) {
+	if (iwl_mld_emlsr_active(vif) &&
+	    time_is_before_jiffies(mld_vif->emlsr.last_entry_ts +
+				   IWL_MLD_TPT_COUNT_WINDOW)) {
 		sec_link_id = iwl_mld_get_other_link(vif, iwl_mld_get_primary_link(vif));
 		sec_link = iwl_mld_link_dereference_check(mld_vif, sec_link_id);
 		if (WARN_ON_ONCE(!sec_link))
-- 
2.34.1


