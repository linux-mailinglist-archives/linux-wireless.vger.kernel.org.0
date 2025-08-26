Return-Path: <linux-wireless+bounces-26642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5EEB36F69
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988F33BAF92
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F71E2F6597;
	Tue, 26 Aug 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqzWUX02"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8D30AD15
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223749; cv=none; b=JCM96dxJFsiMDEc3TU68JIH07l23mucuUweEyGfFtEGtP2PDubUseX2uX0H0cOGShIjsW0znEx7/yVIWzr1RwY4sghUgTi0zBHuxdbu5PCIBCjpedXf1f4lovwL+bl8QKiFfsfbPm06IV5eULAJL0xaRTx4DKDghTsvW9wSIXxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223749; c=relaxed/simple;
	bh=f9qK4kN+0TmSIkGo6hC2sokpt3hQvPGIEH9rh5nsKqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V9kMugtQogwgF3ROzkKRIFTosDbjvb7dUdxaE5ZNBbn/aW6IgZsA2C8UxP84YVvmwQ8m9TEKZ2DVAizrmJKtHvBd9XyOnyx7+Z7JeYm3/iMglvMc3Zy40iDChZV2R7WABQRjtVFOAoRymVhfaotvx8t1rqZS2FygdAYFTIcrR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqzWUX02; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223747; x=1787759747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f9qK4kN+0TmSIkGo6hC2sokpt3hQvPGIEH9rh5nsKqo=;
  b=AqzWUX02mu9wf1Y+UL5L0CNDRZciZrGb9HNAccHIvx+BKFcnbiJWaF67
   vsbJMm/W6/4kDKPVLevo5h03T6zbwvGkkafJjuVBoPx+Z1lGnUdcgbgq2
   r0x50oWh9zu63obYssGM5SvgYUvSJdZD39/YIBCCAH7wIYzjIxOKFIID2
   BytZndBQYeoTxy5Gp/cHIbmWu/q/dMek0fR3fZjuVdMz0LSXW6RKn5278
   0znBDPvZtrbPicY0kFXAG8TzJf+lr2AlUF9//R6BiURHo4gfvKMubpbVV
   vrzVOVSD2pUPVN4oetRh8um7NSusLTmZS8U//t4cGD5Afr82LFEpuf2DE
   g==;
X-CSE-ConnectionGUID: kN2xKC7nRISRIVuLwu60Mw==
X-CSE-MsgGUID: /b+VtRsxRLO2LoxQXypwyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108418"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108418"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:37 -0700
X-CSE-ConnectionGUID: cZfGr4afQQecg7BoTemFMw==
X-CSE-MsgGUID: YUTpQreRScyM2qcO0GL2yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218243"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: mld: Add debug log for second link
Date: Tue, 26 Aug 2025 18:54:54 +0300
Message-Id: <20250826184046.70366c88907e.I39b5c121f9884cd572a19bf89f7cca02ce79eb33@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>

When there is a missed beacon scenario its
not clear how many times beacon missed,
log this data.

Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index dfaa6fbf8a54..6135da34a9c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -532,7 +532,8 @@ void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
 		le32_to_cpu(notif->consec_missed_beacons_other_link);
 	struct ieee80211_bss_conf *link_conf =
 		iwl_mld_fw_id_to_link_conf(mld, fw_link_id);
-	u32 bss_param_ch_cnt_link_id;
+	struct ieee80211_bss_conf *other_link;
+	u32 bss_param_ch_cnt_link_id, other_link_fw_id;
 	struct ieee80211_vif *vif;
 	u8 link_id;
 
@@ -587,6 +588,17 @@ void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
 	if (le32_to_cpu(notif->other_link_id) == FW_CTXT_ID_INVALID)
 		return;
 
+	other_link_fw_id = le32_to_cpu(notif->other_link_id);
+	other_link = iwl_mld_fw_id_to_link_conf(mld, other_link_fw_id);
+
+	if (IWL_FW_CHECK(mld, !other_link, "link doesn't exist for: %d\n",
+			 other_link_fw_id))
+		return;
+
+	IWL_DEBUG_EHT(mld,
+		      "missed bcn on the other link (link_id=%u): %u\n",
+		      other_link->link_id, scnd_lnk_bcn_lost);
+
 	/* Exit EMLSR if we lost more than
 	 * IWL_MLD_MISSED_BEACONS_EXIT_ESR_THRESH beacons on boths links
 	 * OR more than IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH on current link.
-- 
2.34.1


