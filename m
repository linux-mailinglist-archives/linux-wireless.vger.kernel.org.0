Return-Path: <linux-wireless+bounces-22395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B97AA85F8
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564DB1899D1A
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021641A3172;
	Sun,  4 May 2025 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyuYosuz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409001AAE28
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354427; cv=none; b=FSYqVr4e/dcL0V/a9l+eAYCbEqiNyrP3tcyR1rTAPumjNM/taaYe1Qlc+2FzqJ60tP03qfMEqqmdj+gAxAb3q0jb4ZvxcDE9hBZfJue6ZVBTGA73XXfzkrnbB0uFCBUy8z/84L+SXW/WG3loXlJCnKAk/rqaH5QcJQC9YIRN9M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354427; c=relaxed/simple;
	bh=F2ud+Jwy5y5V9xMC9qCSwbX0DzEJTybNAX+ouWQkh0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrB7ZCdBJK0ORsXT4IvovslXq6FKIajgNvm+vR54hwCC4HScXghPDkofqyCHWTcuihaWWUazA363QUb2kOyod+BS556lZmwDq4ygfzBOkV/mC2SWfyFYYr5UXdxZs5t/8Gj2ST3bmkztFNj9Tnm3GL4cQjEfRBBre9+mqruoBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyuYosuz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354426; x=1777890426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F2ud+Jwy5y5V9xMC9qCSwbX0DzEJTybNAX+ouWQkh0Y=;
  b=eyuYosuzj4Cg2ajOJVf32IWAyeno1/YCDwcP7Q/docUjSRjUR1gh1zZ2
   D6CbLz+ugdqNMstTTgxgEHV9UVlwA8JNWxgKuoOCqpJt2lYWeBU9OlgIk
   e1SjXe+HDF6YgpAP7HQJ5gxvx8xBxaXF8Bd+An6+wAsHROAcdTifSe6IM
   AsoZ7q9ElWfEsFo235Z4uDoHnFFTAwRHRZMhvu4LiKkpwmUhQyB7NFSpt
   olkk2gkFxNgdLiEQQ+zqYFBHA4n4ndl2rslOcmf4pOan8srdrk+0gDoTz
   27Koqvv/OrvD1qED1jfOIo6Jqfnj8lX/tDV6m2ulMaGtFpb2cd+7ah+dm
   g==;
X-CSE-ConnectionGUID: O4gCZVf6RByWGZG5NOUsVA==
X-CSE-MsgGUID: lT3jJfY0T2C2bCpMo8vTsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511502"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511502"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:05 -0700
X-CSE-ConnectionGUID: dXdbHCB/T0qGUwfwXLlQEA==
X-CSE-MsgGUID: R3VRCWTjQXuhsmufaEtL3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778899"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mvm: remove HT greenfield support
Date: Sun,  4 May 2025 13:26:25 +0300
Message-Id: <20250504132447.805ec090c61f.Iafd87f62ceb463b72f861a5348078999dcaace92@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
References: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

No hardware that uses iwlmvm actually supports HT greenfield.
Remove the support and then clean up the v1 rate API by doing
a conversion to v2 rate API, the only thing v1 covered that
couldn't be done in v2 was HT greenfield.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |  3 ---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c  |  9 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c  |  2 --
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c  | 27 --------------------
 4 files changed, 5 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 37a432081995..19dcc2ed8396 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1801,9 +1801,6 @@ int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 			       enum nl80211_band band,
 			       struct ieee80211_tx_rate *r);
-void iwl_mvm_hwrate_to_tx_rate_v1(u32 rate_n_flags,
-				  enum nl80211_band band,
-				  struct ieee80211_tx_rate *r);
 u8 iwl_mvm_mac80211_idx_to_hwrate(const struct iwl_fw *fw, int rate_idx);
 u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac);
 bool iwl_mvm_is_nic_ack_enabled(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index c2729dab8e79..50496edf41f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2697,8 +2697,8 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 	lq_sta = mvm_sta;
 
 	spin_lock_bh(&lq_sta->pers.lock);
-	iwl_mvm_hwrate_to_tx_rate_v1(lq_sta->last_rate_n_flags,
-				     info->band, &info->control.rates[0]);
+	iwl_mvm_hwrate_to_tx_rate(iwl_new_rate_from_v1(lq_sta->last_rate_n_flags),
+				  info->band, &info->control.rates[0]);
 	info->control.rates[0].count = 1;
 
 	/* Report the optimal rate based on rssi and STA caps if we haven't
@@ -2708,8 +2708,9 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 		optimal_rate = rs_get_optimal_rate(mvm, lq_sta);
 		last_ucode_rate = ucode_rate_from_rs_rate(mvm,
 							  optimal_rate);
-		iwl_mvm_hwrate_to_tx_rate_v1(last_ucode_rate, info->band,
-					     &txrc->reported_rate);
+		last_ucode_rate = iwl_new_rate_from_v1(last_ucode_rate);
+		iwl_mvm_hwrate_to_tx_rate(last_ucode_rate, info->band,
+					  &txrc->reported_rate);
 		txrc->reported_rate.count = 1;
 	}
 	spin_unlock_bh(&lq_sta->pers.lock);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index a5cd0fd7a11a..8eb0aa448c85 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -490,8 +490,6 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (!(rate_n_flags & RATE_MCS_CCK_MSK_V1) &&
 	    rate_n_flags & RATE_MCS_SGI_MSK_V1)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-	if (rate_n_flags & RATE_HT_MCS_GF_MSK)
-		rx_status->enc_flags |= RX_ENC_FLAG_HT_GF;
 	if (rate_n_flags & RATE_MCS_LDPC_MSK_V1)
 		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
 	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index a9b2b846ab37..1da0a829f529 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1500,33 +1500,6 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 	}
 }
 
-void iwl_mvm_hwrate_to_tx_rate_v1(u32 rate_n_flags,
-				  enum nl80211_band band,
-				  struct ieee80211_tx_rate *r)
-{
-	if (rate_n_flags & RATE_HT_MCS_GF_MSK)
-		r->flags |= IEEE80211_TX_RC_GREEN_FIELD;
-
-	r->flags |=
-		iwl_mvm_get_hwrate_chan_width(rate_n_flags &
-					      RATE_MCS_CHAN_WIDTH_MSK_V1);
-
-	if (rate_n_flags & RATE_MCS_SGI_MSK_V1)
-		r->flags |= IEEE80211_TX_RC_SHORT_GI;
-	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
-		r->flags |= IEEE80211_TX_RC_MCS;
-		r->idx = rate_n_flags & RATE_HT_MCS_INDEX_MSK_V1;
-	} else if (rate_n_flags & RATE_MCS_VHT_MSK_V1) {
-		ieee80211_rate_set_vht(
-			r, rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK,
-			FIELD_GET(RATE_MCS_NSS_MSK, rate_n_flags) + 1);
-		r->flags |= IEEE80211_TX_RC_VHT_MCS;
-	} else {
-		r->idx = iwl_mvm_legacy_rate_to_mac80211_idx(rate_n_flags,
-							     band);
-	}
-}
-
 /*
  * translate ucode response to mac80211 tx status control values
  */
-- 
2.34.1


