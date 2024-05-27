Return-Path: <linux-wireless+bounces-8124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6F8D07FA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8ED1F21A6B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C4315EFC4;
	Mon, 27 May 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RIWL2OHK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF59C73452
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826000; cv=none; b=iHaVEjoImgB+fyeZfhNO8ClJcHjzby0AirebSFy8qjPQjhCYHVvagdONb1368QiOS+XpDVF5vlVF2ncXkysbwJpXNBnkK0VUgyNp2I/OnE815DS25at6N94qNTQQu6spt4D1vJwHX9daumE0HGUFXgN8x57xX2kplOUbCzdN+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826000; c=relaxed/simple;
	bh=vEUKNlzzJmbrrxSACtO66t3DOJ+wNTHog6bm7AT4qiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YSHIQxJgXhwJWC/Hyyw/8nzzRoswoQ7um8EUWde8NxV9XViCiOJ9EWC9ubrMIt25/4y98j7KD2FOv2OWcT4NZE7FRIzTX2B07VFQeEwUT6kQLG2HJMdQD+LRl8t+H+jAc7Dfk9Pv0Rp98GOYrH7aroq0cCO/pYy4NE0vlFPCOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RIWL2OHK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716825999; x=1748361999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vEUKNlzzJmbrrxSACtO66t3DOJ+wNTHog6bm7AT4qiA=;
  b=RIWL2OHKqns5l9ZFdfUIZKhjT3LCzBDetvAyoHVdWOzlDtxsNt1ySNrB
   2T9AyNvy9WOfdBxipcscJx5Z3CpMkyHdBHUu6rLXoNNi9jenpgnMcrJ2I
   ZpOo3/jJaaXb6q3ByvBvrxeC50At9vrE1kTh6pXHzpR9N7pntLwaFr6BH
   GwK7Kp8SssTIKuMSiV4Gjj//V3pvii2jWK0+Qz5muYsJ56w7U4102BOLe
   LwJfOyWbZf6flQFng7R30s2H6CHMP5ZbiXuCAc11UxcaiCJkBjMs5IaqQ
   cjqp8KT+gBWX16YgWtxJ15Sl67ikFppD8m+v139zU16PPE3wPxdt0gwx+
   A==;
X-CSE-ConnectionGUID: ib78Dt3UT0Gq1qWlxonnBA==
X-CSE-MsgGUID: QAxkKfx8Qgy4e5bngVmVzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002092"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002092"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:39 -0700
X-CSE-ConnectionGUID: Q7HD5+FcTvazZM92MGebQA==
X-CSE-MsgGUID: N/FgTf9VSOOgFF5Vm0nk9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407102"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 10/20] wifi: iwlwifi: mvm: modify iwl_mvm_ftm_set_secured_ranging() parameters
Date: Mon, 27 May 2024 19:06:05 +0300
Message-Id: <20240527190228.56d6aee320b3.I5a52fa93cd791d0229b392a20f076b7cebb110cd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Modify iwl_mvm_ftm_set_secured_ranging() parameters to support
multiple versions of the target struct.
This is done as preparation for moving to the new range request
version.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 54 ++++++++++++-------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 8596e6f7d1dc..f5bf99f7fc2e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -40,6 +40,12 @@ struct iwl_mvm_ftm_pasn_entry {
 	u32 flags;
 };
 
+struct iwl_mvm_ftm_iter_data {
+	u8 *cipher;
+	u8 *bssid;
+	u8 *tk;
+};
+
 int iwl_mvm_ftm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			     u8 *addr, u32 cipher, u8 *tk, u32 tk_len,
 			     u8 *hltk, u32 hltk_len)
@@ -719,7 +725,7 @@ static void iter(struct ieee80211_hw *hw,
 		 struct ieee80211_key_conf *key,
 		 void *data)
 {
-	struct iwl_tof_range_req_ap_entry_v6 *target = data;
+	struct iwl_mvm_ftm_iter_data *target = data;
 
 	if (!sta || memcmp(sta->addr, target->bssid, ETH_ALEN))
 		return;
@@ -730,16 +736,16 @@ static void iter(struct ieee80211_hw *hw,
 		return;
 
 	memcpy(target->tk, key->key, key->keylen);
-	target->cipher = iwl_mvm_cipher_to_location_cipher(key->cipher);
-	WARN_ON(target->cipher == IWL_LOCATION_CIPHER_INVALID);
+	*target->cipher = iwl_mvm_cipher_to_location_cipher(key->cipher);
+	WARN_ON(*target->cipher == IWL_LOCATION_CIPHER_INVALID);
 }
 
 static void
 iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-				struct iwl_tof_range_req_ap_entry_v7 *target)
+				u8 *bssid, u8 *cipher, u8 *hltk, u8 *tk,
+				u8 *rx_pn, u8 *tx_pn, __le32 *flags)
 {
 	struct iwl_mvm_ftm_pasn_entry *entry;
-	u32 flags = le32_to_cpu(target->initiator_ap_flags);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
@@ -747,35 +753,39 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return;
 #endif
 
-	if (!(flags & (IWL_INITIATOR_AP_FLAGS_NON_TB |
+	if (!(le32_to_cpu(*flags) & (IWL_INITIATOR_AP_FLAGS_NON_TB |
 		       IWL_INITIATOR_AP_FLAGS_TB)))
 		return;
 
 	lockdep_assert_held(&mvm->mutex);
 
 	list_for_each_entry(entry, &mvm->ftm_initiator.pasn_list, list) {
-		if (memcmp(entry->addr, target->bssid, sizeof(entry->addr)))
+		if (memcmp(entry->addr, bssid, sizeof(entry->addr)))
 			continue;
 
-		target->cipher = entry->cipher;
+		*cipher = entry->cipher;
 
 		if (entry->flags & IWL_MVM_PASN_FLAG_HAS_HLTK)
-			memcpy(target->hltk, entry->hltk, sizeof(target->hltk));
+			memcpy(hltk, entry->hltk, sizeof(entry->hltk));
 		else
-			memset(target->hltk, 0, sizeof(target->hltk));
+			memset(hltk, 0, sizeof(entry->hltk));
 
 		if (vif->cfg.assoc &&
-		    !memcmp(vif->bss_conf.bssid, target->bssid,
-			    sizeof(target->bssid)))
-			ieee80211_iter_keys(mvm->hw, vif, iter, target);
-		else
-			memcpy(target->tk, entry->tk, sizeof(target->tk));
+		    !memcmp(vif->bss_conf.bssid, bssid, ETH_ALEN)) {
+			struct iwl_mvm_ftm_iter_data target;
+
+			target.cipher = cipher;
+			target.bssid = bssid;
+			target.tk = tk;
+			ieee80211_iter_keys(mvm->hw, vif, iter, &target);
+		} else {
+			memcpy(tk, entry->tk, sizeof(entry->tk));
+		}
 
-		memcpy(target->rx_pn, entry->rx_pn, sizeof(target->rx_pn));
-		memcpy(target->tx_pn, entry->tx_pn, sizeof(target->tx_pn));
+		memcpy(rx_pn, entry->rx_pn, sizeof(entry->rx_pn));
+		memcpy(tx_pn, entry->tx_pn, sizeof(entry->tx_pn));
 
-		target->initiator_ap_flags |=
-			cpu_to_le32(IWL_INITIATOR_AP_FLAGS_SECURED);
+		FTM_SET_FLAG(SECURED);
 		return;
 	}
 }
@@ -789,7 +799,11 @@ iwl_mvm_ftm_put_target_v7(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (err)
 		return err;
 
-	iwl_mvm_ftm_set_secured_ranging(mvm, vif, target);
+	iwl_mvm_ftm_set_secured_ranging(mvm, vif, target->bssid,
+					&target->cipher, target->hltk,
+					target->tk, target->rx_pn,
+					target->tx_pn,
+					&target->initiator_ap_flags);
 	return err;
 }
 
-- 
2.34.1


