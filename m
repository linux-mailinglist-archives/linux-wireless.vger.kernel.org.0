Return-Path: <linux-wireless+bounces-20064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DE4A57F32
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC3316B2A2
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3653C212B01;
	Sat,  8 Mar 2025 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0og1UyB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234720FAA2
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471305; cv=none; b=N9lXWjqz3O5fxF6pWxGZ36XLbhv8mQ1iDq8LWuLE/wQQzW6vptVxX0oNr3LE+rkixpU7aAbtcvbT9zizoIZIWmWRK2qtA3s7p5g5P2S8D2P23ODzseXLn6L5wkGqzWTCRMVxKVDwzHYE7K8tzJkh4wqw4TTJ007FT+7RNk035NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471305; c=relaxed/simple;
	bh=ppb6Tdxwu9zik7hUyKIif6LlLEkF6pu6cGPBD1TsbjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tD98NWoWTcPHwsfz8aU8bTbKlmyIY8mrydpqeGC42uvb1toqoN5/aUQrV0r0H5f0o7aKDFEdQ/ceGHyArYHGufyMPvaAgcobhPa/kI1iH7xm7X5Uv14M782p5DCI3uYgFcJjBAfkmiyoKGBtCQxs2slmVWnE/X2ueBwkQcaxSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0og1UyB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471303; x=1773007303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ppb6Tdxwu9zik7hUyKIif6LlLEkF6pu6cGPBD1TsbjY=;
  b=U0og1UyBqh76+++3yl4gYH+ib2FTKsgFEZlLlqmBlbUdcwb1ycLZ4X/6
   1Ry/LLQDXQFo+PzxR8aJPk6No83862JGFx9hF0o7W2Bq8xVreTdyFTfPj
   VYFF6WB6EVeDfQv5trzurV9QOpsn04Nl4LRupQKgwiOt7deMcNTrH7YmX
   dr70Z2+XDxq1tj0igAtlvR2oEIgQW80NY+ZEY/9yqBTNQZa2nhYdpjTKT
   Byj6NDH7/kiSDGsKA/m7mzzfklPESeUSigYAJ2q3EzTaZh2gvERAjK9q5
   Qxyprhzq1PqxvHkoxuTBAg3t8UcV1oSBIdnd5ATZ9zq23Egu2Y8lKOMWE
   g==;
X-CSE-ConnectionGUID: KO6zPjm3QBimxM8Ed+2/3Q==
X-CSE-MsgGUID: C5ai6/BFSDWeZf0Mtm2TOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540619"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540619"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:43 -0800
X-CSE-ConnectionGUID: TbD2W73wS76ENfWJdmG66A==
X-CSE-MsgGUID: K3PcF23HRaWsWaZl0DoFIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352093"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 04/15] wifi: iwlwifi: mld: refactor iwl_mld_valid_emlsr_pair
Date: Sun,  9 Mar 2025 00:01:14 +0200
Message-Id: <20250308235203.0a3b2f88fbbf.I0152bc39e828488451e85135feb044ce1f7a85d3@changeid>
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

- Change reasons enum to a bitmask and rename it
- Don't use 'else if' so all reasons will be set in the reasons bitmask

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index b68092be9aed..bbaf9ad0e9eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -748,23 +748,23 @@ iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 	struct iwl_mld *mld = mld_vif->mld;
-	enum iwl_mld_emlsr_exit ret = 0;
+	u32 reason_mask = 0;
 
 	/* Per-link considerations */
 	if (iwl_mld_emlsr_disallowed_with_link(mld, vif, a, true) ||
 	    iwl_mld_emlsr_disallowed_with_link(mld, vif, b, false))
 		return false;
 
-	if (a->chandef->chan->band == b->chandef->chan->band) {
-		ret |= IWL_MLD_EMLSR_EXIT_EQUAL_BAND;
-	} else if (a->chandef->width != b->chandef->width) {
+	if (a->chandef->chan->band == b->chandef->chan->band)
+		reason_mask |= IWL_MLD_EMLSR_EXIT_EQUAL_BAND;
+	if (a->chandef->width != b->chandef->width) {
 		/* TODO: task=EMLSR task=statistics
 		 * replace BANDWIDTH exit reason with channel load criteria
 		 */
-		ret |= IWL_MLD_EMLSR_EXIT_BANDWIDTH;
+		reason_mask |= IWL_MLD_EMLSR_EXIT_BANDWIDTH;
 	}
 
-	if (ret) {
+	if (reason_mask) {
 		IWL_DEBUG_INFO(mld,
 			       "Links %d and %d are not a valid pair for EMLSR\n",
 			       a->link_id, b->link_id);
@@ -772,7 +772,7 @@ iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
 			       "Links bandwidth are: %d and %d\n",
 			       nl80211_chan_width_to_mhz(a->chandef->width),
 			       nl80211_chan_width_to_mhz(b->chandef->width));
-		iwl_mld_print_emlsr_exit(mld, ret);
+		iwl_mld_print_emlsr_exit(mld, reason_mask);
 		return false;
 	}
 
-- 
2.34.1


