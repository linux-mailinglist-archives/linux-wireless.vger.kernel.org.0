Return-Path: <linux-wireless+bounces-16709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3CB9FA900
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 02:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E8D1884E8C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 01:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B57D531;
	Mon, 23 Dec 2024 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hAjtiWKo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02605D51C;
	Mon, 23 Dec 2024 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734917540; cv=none; b=C6NiJclHe5KUZf/ZjkT85xcXzRkz3tlYg0iOCgCgNHw+tZxdCzfJ0UvKLumXvWTAWfGj1u3OWPl1lfJPaqhGrQVcXIjSWnf0D0Ngi/RlHs6SWoy7gdrPv6ZeKzzYipVW6BvJQLXTBh2BkX4M9Xe38zFOonjQ2ZuZi+CEOjCrxdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734917540; c=relaxed/simple;
	bh=Vzt2yWayyGwEtq8qqinHsCHCd+kyX4AP0wsBNlM9wGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqNST7X48PXO4sDy+kEionN5YdQgtvejlLwmcMPAtLI4kRHcD2UHyD1WRCRbXc4yU/tAQadfS0VhfxaZf0IWD5KTVFRfjQXJnZ2wMCcmRVU2ZQkHLzXVTRm1+OVc1pzm863lyu704b58K+O1fIQXyMWOY+e/t4OicQ+3TgwMl/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hAjtiWKo; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=VSlmuOAizwRPWEm5J9NFh9+rLZv8nYz4wRTA61eWOmg=; b=hAjtiWKoHUkKFM9K
	fBSrTfNFGTS1jZlshaf3Mjcwe2cBlti3uxNjy0GN7ejGgR9o/ErklSynjpyHEbbo2HM7Ym0PR5St0
	jeAQY3Lc3KnbRe9AZUEGFA0IpkV6pHaDI2zVqp12+jOLY1/UGBwG4C6EY6skJLxzb0B5kBIzo7Imo
	Gfr/c+7wj4m2Q16V2LAC9RqOqCn/rWmae5Qao8AsxgPf/Lg6jLbAgJzquhHaT0epCboUGHDl+mt+1
	hR8fzKhBfFQxvArzY7hndTxK20swJXTJPQ0sg8ofkRRTVl0GVDVFq3GzoPcGc5jbyyuP8Eug1FPg1
	S/Np++w6oKpKI+XNpQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tPXIk-006oGv-2I;
	Mon, 23 Dec 2024 01:32:06 +0000
From: linux@treblig.org
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 4/6] iwlwifi: Remove unused iwl_mvm_ftm_add_pasn_sta
Date: Mon, 23 Dec 2024 01:32:00 +0000
Message-ID: <20241223013202.340180-5-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223013202.340180-1-linux@treblig.org>
References: <20241223013202.340180-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

iwl_mvm_ftm_add_pasn_sta() was added in 2020 by
commit 0739a7d70e00 ("iwlwifi: mvm: initiator: add option for adding a
PASN responder")
but hasn't been used.

Remove it.

That was the only caller of iwl_mvm_ftm_remove_pasn_sta().

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 101 ------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   4 -
 2 files changed, 105 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index b26141c30c61..f7034fa40c26 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -46,107 +46,6 @@ struct iwl_mvm_ftm_iter_data {
 	u8 *tk;
 };
 
-int iwl_mvm_ftm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			     u8 *addr, u32 cipher, u8 *tk, u32 tk_len,
-			     u8 *hltk, u32 hltk_len)
-{
-	struct iwl_mvm_ftm_pasn_entry *pasn = kzalloc(sizeof(*pasn),
-						      GFP_KERNEL);
-	u32 expected_tk_len;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (!pasn)
-		return -ENOBUFS;
-
-	iwl_mvm_ftm_remove_pasn_sta(mvm, addr);
-
-	pasn->cipher = iwl_mvm_cipher_to_location_cipher(cipher);
-
-	switch (pasn->cipher) {
-	case IWL_LOCATION_CIPHER_CCMP_128:
-	case IWL_LOCATION_CIPHER_GCMP_128:
-		expected_tk_len = WLAN_KEY_LEN_CCMP;
-		break;
-	case IWL_LOCATION_CIPHER_GCMP_256:
-		expected_tk_len = WLAN_KEY_LEN_GCMP_256;
-		break;
-	default:
-		goto out;
-	}
-
-	/*
-	 * If associated to this AP and already have security context,
-	 * the TK is already configured for this station, so it
-	 * shouldn't be set again here.
-	 */
-	if (vif->cfg.assoc) {
-		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-		struct ieee80211_bss_conf *link_conf;
-		unsigned int link_id;
-		struct ieee80211_sta *sta;
-		u8 sta_id;
-
-		rcu_read_lock();
-		for_each_vif_active_link(vif, link_conf, link_id) {
-			if (memcmp(addr, link_conf->bssid, ETH_ALEN))
-				continue;
-
-			sta_id = mvmvif->link[link_id]->ap_sta_id;
-			sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
-			if (!IS_ERR_OR_NULL(sta) && sta->mfp)
-				expected_tk_len = 0;
-			break;
-		}
-		rcu_read_unlock();
-	}
-
-	if (tk_len != expected_tk_len ||
-	    (hltk_len && hltk_len != sizeof(pasn->hltk))) {
-		IWL_ERR(mvm, "Invalid key length: tk_len=%u hltk_len=%u\n",
-			tk_len, hltk_len);
-		goto out;
-	}
-
-	if (!expected_tk_len && !hltk_len) {
-		IWL_ERR(mvm, "TK and HLTK not set\n");
-		goto out;
-	}
-
-	memcpy(pasn->addr, addr, sizeof(pasn->addr));
-
-	if (hltk_len) {
-		memcpy(pasn->hltk, hltk, sizeof(pasn->hltk));
-		pasn->flags |= IWL_MVM_PASN_FLAG_HAS_HLTK;
-	}
-
-	if (tk && tk_len)
-		memcpy(pasn->tk, tk, sizeof(pasn->tk));
-
-	list_add_tail(&pasn->list, &mvm->ftm_initiator.pasn_list);
-	return 0;
-out:
-	kfree(pasn);
-	return -EINVAL;
-}
-
-void iwl_mvm_ftm_remove_pasn_sta(struct iwl_mvm *mvm, u8 *addr)
-{
-	struct iwl_mvm_ftm_pasn_entry *entry, *prev;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	list_for_each_entry_safe(entry, prev, &mvm->ftm_initiator.pasn_list,
-				 list) {
-		if (memcmp(entry->addr, addr, sizeof(entry->addr)))
-			continue;
-
-		list_del(&entry->list);
-		kfree(entry);
-		return;
-	}
-}
-
 static void iwl_mvm_ftm_reset(struct iwl_mvm *mvm)
 {
 	struct iwl_mvm_loc_entry *e, *t;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e8a82dc49892..fbb2cf6ab0be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2530,10 +2530,6 @@ int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 void iwl_mvm_ftm_abort(struct iwl_mvm *mvm, struct cfg80211_pmsr_request *req);
 void iwl_mvm_ftm_initiator_smooth_config(struct iwl_mvm *mvm);
 void iwl_mvm_ftm_initiator_smooth_stop(struct iwl_mvm *mvm);
-int iwl_mvm_ftm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			     u8 *addr, u32 cipher, u8 *tk, u32 tk_len,
-			     u8 *hltk, u32 hltk_len);
-void iwl_mvm_ftm_remove_pasn_sta(struct iwl_mvm *mvm, u8 *addr);
 
 /* TDLS */
 
-- 
2.47.1


