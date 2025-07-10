Return-Path: <linux-wireless+bounces-25198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AAEB0095B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE5D3B7D01
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D4A2F1988;
	Thu, 10 Jul 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPZrPHsH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE82F0C4B
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166524; cv=none; b=TdHE/6s9Ny6C+8+GkwxmNfeB/3NKrRNA85Tb389Gdme2TKHX3xnJG5lEpp2+wIqQtfL/d+tvUg13LOCn4JfmHARcupBhJ6DwmgIXf6rFvbnowZGgJkUG0D/q0m67WoHUsjNXev16svwSgPoRZtuPua5P2Xyd3eUsT38TsAsKAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166524; c=relaxed/simple;
	bh=rb4FQL8Lcv9T7SmuvWOkhyJyysROwEl5jUudlXFd1OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StR/5VGe4sb5QG0u0k71Z1lFjapWpm4aJB7nM6ns+mLp4l2odRmexrbgGuo6zzX8tPKozQ9kNeAYMixIv3pVRh+NZpoqc9GP4w91Pd9Ubyx8UR6YD70QTh0hjXvYZmwqXji7TSZJ3UiGqPal77ZQoxIExDLRSdtbN+uOkWNGEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPZrPHsH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166523; x=1783702523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rb4FQL8Lcv9T7SmuvWOkhyJyysROwEl5jUudlXFd1OQ=;
  b=nPZrPHsHTGskjFO72K+xsubOlIaySMtiO0ZKnz5f1ns5+S1SwbkCGwNm
   1Q5UPMYEUv/g3u5D3tUl1AbY6VFZqsSWeDQ6baIOAPYx9pU8Vn+rSUuXe
   ogLyH3+SDTRS6gVJlYg7bxOaPnR1EfaGJNOCT2r6YSq0Fjgx3lCHagZCK
   anydKNwhb3iLzMVKfuJCeglvTX/PnLUmgOcsu4C8JYwDUVc+P9oCgOfv0
   VlH6Q9mi4y7e1ObcUIufDIknpMV+/pb+yINu/4bFIa+kvVJCbmRQdsNmI
   1pgGnQiQM8NuAnml+OMTsb34K4dWpSfJilb9vagqYfAtVRp49e1wJOg9n
   w==;
X-CSE-ConnectionGUID: OQ4MkJNYRa+AUaYByPdZKQ==
X-CSE-MsgGUID: 4xgXey80RVuj0SHbc7Ml3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54610021"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54610021"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:23 -0700
X-CSE-ConnectionGUID: 6sWNxqEFRPeR8T0ue70YLw==
X-CSE-MsgGUID: nG4qTgGPRyOGZKKxOd+W0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156277079"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 11/15] wifi: iwlwifi: mvm: always set the key idx in gtk_seq
Date: Thu, 10 Jul 2025 19:54:44 +0300
Message-Id: <20250710195219.2a5a5e4d7b19.Ib795751119070495c0c95526cd36bd7f87594f56@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

For older APIs, gtk_seq[0].key_id will be set to -1, while other code
assumes that it will always be a valid gtk key idx.
Since the FW does provide the idx for those APIs, simply set it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 546fda8de5de..e6806ef56e73 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1689,7 +1689,7 @@ static void iwl_mvm_set_aes_ptk_rx_seq(struct iwl_mvm *mvm,
 }
 
 static void iwl_mvm_convert_key_counters(struct iwl_wowlan_status_data *status,
-					 union iwl_all_tsc_rsc *sc)
+					 union iwl_all_tsc_rsc *sc, u8 key_idx)
 {
 	int i;
 
@@ -1704,7 +1704,7 @@ static void iwl_mvm_convert_key_counters(struct iwl_wowlan_status_data *status,
 				      &status->gtk_seq[0].aes.seq[i]);
 	}
 	status->gtk_seq[0].valid = true;
-	status->gtk_seq[0].key_id = -1;
+	status->gtk_seq[0].key_id = key_idx;
 
 	/* PTK TX counter */
 	status->ptk.tkip.tx_pn = (u64)le16_to_cpu(sc->tkip.tsc.iv16) |
@@ -1795,7 +1795,6 @@ static void iwl_mvm_set_key_rx_seq(struct ieee80211_key_conf *key,
 		if (!status->gtk_seq[i].valid)
 			continue;
 
-		/* Handle the case where we know the key ID */
 		if (status->gtk_seq[i].key_id == key->keyidx) {
 			s8 new_key_id = -1;
 
@@ -1806,13 +1805,7 @@ static void iwl_mvm_set_key_rx_seq(struct ieee80211_key_conf *key,
 			/* Don't install a new key's value to an old key */
 			if (new_key_id != key->keyidx)
 				iwl_mvm_set_key_rx_seq_idx(key, status, i);
-			continue;
 		}
-
-		/* handle the case where we didn't, last key only */
-		if (status->gtk_seq[i].key_id == -1 &&
-		    (!status->num_of_gtk_rekeys))
-			iwl_mvm_set_key_rx_seq_idx(key, status, i);
 	}
 }
 
@@ -2522,7 +2515,8 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 		       v6->gtk.tkip_mic_key,
 		       sizeof(v6->gtk.tkip_mic_key));
 
-		iwl_mvm_convert_key_counters(status, &v6->gtk.rsc.all_tsc_rsc);
+		iwl_mvm_convert_key_counters(status, &v6->gtk.rsc.all_tsc_rsc,
+					     v6->gtk.key_index);
 
 		/* hardcode the key length to 16 since v6 only supports 16 */
 		status->gtk[0].len = 16;
@@ -2541,7 +2535,8 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 		if (!status)
 			goto out_free_resp;
 
-		iwl_mvm_convert_key_counters(status, &v7->gtk[0].rsc.all_tsc_rsc);
+		iwl_mvm_convert_key_counters(status, &v7->gtk[0].rsc.all_tsc_rsc,
+					     v7->gtk[0].key_flags & IWL_WOWLAN_GTK_IDX_MASK);
 		iwl_mvm_convert_gtk_v2(status, &v7->gtk[0]);
 		iwl_mvm_convert_igtk(status, &v7->igtk[0]);
 	} else {
-- 
2.34.1


