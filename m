Return-Path: <linux-wireless+bounces-25215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BD7B00B64
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DC65C1172
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D17B2FCFCC;
	Thu, 10 Jul 2025 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQGP2wNu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D12FD590
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172149; cv=none; b=Sa/nLhKcGYuinOW+eNSY4MnwtnrW4x3x6+406pFNxvVfnvCjQUbnqud468P9TPlEz9hz7K8aCkdU47qsv/5MEtt8esEVYwqJ/K/wUsNRGfXV+FsarmdLdKLXjTr4mh0O0hznnb67VMLcW7BQ4/sdWrSBUwWLGbujmxMw2dRwJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172149; c=relaxed/simple;
	bh=rb4FQL8Lcv9T7SmuvWOkhyJyysROwEl5jUudlXFd1OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pwVQiPKEwl7aS7Lnl1tBpReW/C409irFyeL1rVVTNUwY0ilfD+9oowvx0MFqeEMboxgblkJFZW3AJytDCgkJvoQJQ84uDD0mqCC+Z5JUcw5Fg8WlgMyCvz5u+idTUBomxz9B+5WxNojSz98ZpT3AswLP1kRG2P/8x8UucwRtM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQGP2wNu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172147; x=1783708147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rb4FQL8Lcv9T7SmuvWOkhyJyysROwEl5jUudlXFd1OQ=;
  b=UQGP2wNuvlgOYId2cnHrP7Oqm7Ka0GKD0Qd4S+jEUiE2RzM500/g7dhu
   1tEx+di2mXGZv7NPu1fraPUUSBP/PgcC4ibEs8R0fKj5tiR2ahTXGiZa4
   FRYQlJ9edQCAPlmBZG/ioStW0ddl+wKALTxUD7Ux8HMfCZq1owqzsCmQK
   X94Bq/dfDIHRltZg0s+Mc2ngrLWit5xap0DO1F1EC3UkxwtFj8wbkzBzx
   pVDR/GH5inzMlFl005KD/I3W7GaRRxXLYJfzqcfeoUTUG8CJKm5FcIKfB
   5Vclkk+pvYpWayXXA/FZ28sgdxND6DGZqZSEU3Torgj5p57mhBQ922TYD
   w==;
X-CSE-ConnectionGUID: a9Mi7GBCQx6JgcxeTefZZg==
X-CSE-MsgGUID: Y6HKvbUKQ4uP+sNTeBOxQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077808"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077808"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:07 -0700
X-CSE-ConnectionGUID: 22knJaImSvqUeoZ1lzFYkA==
X-CSE-MsgGUID: A0fAcQthSReDOnq5vjuyRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718742"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: mvm: always set the key idx in gtk_seq
Date: Thu, 10 Jul 2025 21:28:28 +0300
Message-Id: <20250710212632.2a5a5e4d7b19.Ib795751119070495c0c95526cd36bd7f87594f56@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
References: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
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


