Return-Path: <linux-wireless+bounces-20063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282EFA57F2F
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9FB3ABAAD
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3701AA1DA;
	Sat,  8 Mar 2025 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJD9Ujm/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B720E00D
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471304; cv=none; b=LBooPj8IjQP5E6O8Xn3AMCCjVMohZoE+uNMNHJGjwMtT2x3V6CXr6g+DtjdYX3S6Liqp2n0p5s7J4qbig2jbWFfVdcm/Apy39JmczAwAwblz/b9u3PQzE5dkjFMe8XVmc6Te4tIzKuTD2Gpimcr6LdkpCcXLyylm5BuqBBS5+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471304; c=relaxed/simple;
	bh=pFSKozayYzeopL8FBkry1CrTE6r4uQjei3FrFIixpis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=On+4UAKx6W7iuegbj9J6+Qxvl4NwmyxPidRKrFP70+5Vi9wAVw8IG8VEcVALLfD/GpfRPQ8FwxJKv97jdDKPMhSOdPD2XJOQ9MbobFDoGBFva/zTcmpVJ3nsqyjNWod1hw3SvwIWBZEMVIByte25Y/e3QKRqGetswk50zH5K6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJD9Ujm/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471302; x=1773007302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pFSKozayYzeopL8FBkry1CrTE6r4uQjei3FrFIixpis=;
  b=RJD9Ujm/5OnErdSb0h6uymwAiZaw+dLRlEgG/IA2MmwgwIc9F9RNAtoO
   W75S19pLI8bQGcNQyepnsyPiPFpeHnfpNr0mg0sAtsqRyxGoGZQbW3i/i
   bP3UpwjQASbO4p3nX5eZMpE8smlAA0la5hUWfJJEFjjQMhoYPKcCJ5ALD
   alFmt3wXx6DAb5SUyhf4I4DDTj5o4EIQn6Vw8TyAKdnAfhBE0dOHLQDBH
   nl1dFRPdGzWNfWkEY0jCTHi93NTSzhvDirC7YhUFTzAmVDj8E74bd02cQ
   1XSiDeQ3Rpa3VeUUKFnOEy9MGu1BZSuqkhT1KqG8TtiLt31BB4XuIraGT
   g==;
X-CSE-ConnectionGUID: 0EY2X3L9SRGashjKx5MFjQ==
X-CSE-MsgGUID: 65GBCyBzR0mkRaSpvlrnZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540617"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540617"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:42 -0800
X-CSE-ConnectionGUID: WPlLO7SoT52iMIRr0GIcFQ==
X-CSE-MsgGUID: Z8XblgaxSBiExDhHT5oVwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352083"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 03/15] wifi: iwlwifi: mld: track channel_load_not_by_us
Date: Sun,  9 Mar 2025 00:01:13 +0200
Message-Id: <20250308235203.dd443fc5b178.I68b2fed197aae14888159b7a73bf40c2f346f41f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

For each channel context, track the avarage channel load by others in the
driver specific phy data, to be used by EMLSR.
Due to FW limitations, this value is incorrect in EMLSR, so it is
shouldn't be used in EMLSR.
On EMLSR exit, clear it so the wrong value won't be used.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 21 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/phy.h  |  5 +++++
 .../net/wireless/intel/iwlwifi/mld/stats.c    | 10 ++++++++-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |  1 +
 5 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index ba149581e25d..b01a41f9b013 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -847,6 +847,7 @@ int iwl_mld_add_chanctx(struct ieee80211_hw *hw,
 	if (fw_id < 0)
 		return fw_id;
 
+	phy->mld = mld;
 	phy->fw_id = fw_id;
 	phy->chandef = *iwl_mld_get_chandef_from_chanctx(ctx);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 99c8501129b8..b68092be9aed 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2024-2025 Intel Corporation
  */
 #include "mlo.h"
+#include "phy.h"
 
 /* Block reasons helper */
 #define HANDLE_EMLSR_BLOCKED_REASONS(HOW)	\
@@ -177,6 +178,19 @@ static void iwl_mld_check_emlsr_prevention(struct iwl_mld *mld,
 				 &mld_vif->emlsr.prevent_done_wk, delay);
 }
 
+static void iwl_mld_clear_avg_chan_load_iter(struct ieee80211_hw *hw,
+					     struct ieee80211_chanctx_conf *ctx,
+					     void *dat)
+{
+	struct iwl_mld_phy *phy = iwl_mld_phy_from_mac80211(ctx);
+
+	/* It is ok to do it for all chanctx (and not only for the ones that
+	 * belong to the EMLSR vif) since EMLSR is not allowed if there is
+	 * another vif.
+	 */
+	phy->avg_channel_load_not_by_us = 0;
+}
+
 static int _iwl_mld_exit_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
 			       enum iwl_mld_emlsr_exit exit, u8 link_to_keep,
 			       bool sync)
@@ -215,6 +229,13 @@ static int _iwl_mld_exit_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
 	/* Update latest exit reason and check EMLSR prevention */
 	iwl_mld_check_emlsr_prevention(mld, mld_vif, exit);
 
+	/* channel_load_not_by_us is invalid when in EMLSR.
+	 * Clear it so wrong values won't be used.
+	 */
+	ieee80211_iter_chan_contexts_atomic(mld->hw,
+					    iwl_mld_clear_avg_chan_load_iter,
+					    NULL);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.h b/drivers/net/wireless/intel/iwlwifi/mld/phy.h
index 3dfb8ca994e2..357bc9fe9624 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.h
@@ -15,6 +15,9 @@
  *	with. Used to detect a no-op when the chanctx changes.
  * @channel_load_by_us: channel load on this channel caused by
  *	the NIC itself, as indicated by firmware
+ * @avg_channel_load_not_by_us: averaged channel load on this channel caused by
+ *	others. This value is invalid when in EMLSR (due to FW limitations)
+ * @mld: pointer to the MLD context
  */
 struct iwl_mld_phy {
 	/* Add here fields that need clean up on hw restart */
@@ -24,6 +27,8 @@ struct iwl_mld_phy {
 	);
 	/* And here fields that survive a hw restart */
 	u32 channel_load_by_us;
+	u32 avg_channel_load_not_by_us;
+	struct iwl_mld *mld;
 };
 
 static inline struct iwl_mld_phy *
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index 842b9b9fdd8c..5633885c49ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -461,6 +461,7 @@ static void iwl_mld_fill_chanctx_stats(struct ieee80211_hw *hw,
 {
 	struct iwl_mld_phy *phy = iwl_mld_phy_from_mac80211(ctx);
 	const struct iwl_stats_ntfy_per_phy *per_phy = data;
+	u32 new_load;
 
 	if (WARN_ON(phy->fw_id >= IWL_STATS_MAX_PHY_OPERATIONAL))
 		return;
@@ -468,7 +469,14 @@ static void iwl_mld_fill_chanctx_stats(struct ieee80211_hw *hw,
 	phy->channel_load_by_us =
 		le32_to_cpu(per_phy[phy->fw_id].channel_load_by_us);
 
-	/* TODO: channel load not by us (task=statistics) */
+	new_load = le32_to_cpu(per_phy[phy->fw_id].channel_load_not_by_us);
+	if (IWL_FW_CHECK(phy->mld, new_load > 100, "Invalid channel load %u\n",
+			 new_load))
+		return;
+
+	/* give a weight of 0.5 for the old value */
+	phy->avg_channel_load_not_by_us =
+		(new_load >> 1) + (phy->avg_channel_load_not_by_us >> 1);
 }
 
 static void
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
index a8c1e6c72138..b6049918b5db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
@@ -168,6 +168,7 @@ iwlmld_kunit_add_chanctx_from_def(struct cfg80211_chan_def *def)
 	KUNIT_ASSERT_GE(test, fw_id, 0);
 
 	phy->fw_id = fw_id;
+	phy->mld = mld;
 	phy->chandef = *iwl_mld_get_chandef_from_chanctx(ctx);
 
 	return ctx;
-- 
2.34.1


