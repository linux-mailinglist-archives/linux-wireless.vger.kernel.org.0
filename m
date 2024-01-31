Return-Path: <linux-wireless+bounces-2913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255CD844971
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CECE5289331
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C7208C1;
	Wed, 31 Jan 2024 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtAqAqVU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773238F97
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735311; cv=none; b=P+sZPeYQQHNsLDOQwWrLWBib4O982cCne5TIesNWZKa/8ghSElroTc79Y5ZqH6MxaPxUu1vT6jxas2DC1IfjkCVdedth3Ho0B7aWf1Qg8EWSiGdvybVe4UopegpS3EAqIFpRqRdJ0mTxbOYQUYvPbqUNTGoJFpbmEGslvKA9yZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735311; c=relaxed/simple;
	bh=2eEoEcIq7XhxDUUuPs2RvmEfaRwkAE9TyA89Kbkcc5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TlzjH/YRxGF3lQGwdgHAPE1uFyPGyBx4Wmld+le4pc3B790/L4I4w6DPrhBnkqPEhyvWNIkclbvR83DkM++oT3wTbuImnFWHG/6DY358qmEHGZRRHQFptWt/QZlTnwoBW1LOjJ3G6SAaf3kX+bpL7rn6BJSE0InGM8DQqTCMlqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtAqAqVU; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706735309; x=1738271309;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2eEoEcIq7XhxDUUuPs2RvmEfaRwkAE9TyA89Kbkcc5Q=;
  b=OtAqAqVUI+PL+mHvm1nfY0EXvSSATjCY/XZfFEBWZfSOeAb/HEwC5QHr
   3RABTqon5ThVDhtfxBscZDwOImjEM9PWh21yu2mkm1ItPUQyLzTBX6+rw
   95QpCoNi7l+EYxkUwT7QY5OlGSAnb+Ew62qfQXamnm22rCFL0c4eoI6NR
   Pftr4dxY9ECMkFH8Tbfy82NifPsBvQZGvRvJFkJQlW/0yJ1vATRXCXk6E
   rnSzhwPOccnhsd+zTPyzksWK6YIPzhWq5VHVIwrnbjZ3s7UG/TGicb7oy
   pPLVYPAunfXyOwf0xnkIbuBPBjo5iX/oGU5ZN45plZxSnELx7JzfssyXs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="467961346"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="467961346"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4205904"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:08:25 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2] wifi: iwlwifi: mvm: Add support for removing responder TKs
Date: Wed, 31 Jan 2024 23:08:16 +0200
Message-Id: <20240131230734.3e6364730c04.Ia76dc4a9d399f1f68ac6b157d844b63f74d5159f@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When removing a PASN station, the TK must be removed before
the station is removed as otherwise the FW would assert.

To handle this, store the key configuration, and use it to remove
the key when the station is removed.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: fix the allocation size.

 .../wireless/intel/iwlwifi/mvm/ftm-responder.c    | 11 +++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c  | 15 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 15 ++++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h      |  3 ++-
 5 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 8f10590f9cdd..f72ca38d7c0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -12,6 +12,9 @@ struct iwl_mvm_pasn_sta {
 	struct list_head list;
 	struct iwl_mvm_int_sta int_sta;
 	u8 addr[ETH_ALEN];
+
+	/* must be last as it followed by buffer holding the key */
+	struct ieee80211_key_conf keyconf;
 };
 
 struct iwl_mvm_pasn_hltk_data {
@@ -303,6 +306,10 @@ static void iwl_mvm_resp_del_pasn_sta(struct iwl_mvm *mvm,
 {
 	list_del(&sta->list);
 
+	if (sta->keyconf.keylen)
+		iwl_mvm_sec_key_del_pasn(mvm, vif, BIT(sta->int_sta.sta_id),
+					 &sta->keyconf);
+
 	if (iwl_mvm_has_mld_api(mvm->fw))
 		iwl_mvm_mld_rm_sta_id(mvm, sta->int_sta.sta_id);
 	else
@@ -352,12 +359,12 @@ int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 	}
 
 	if (tk && tk_len) {
-		sta = kzalloc(sizeof(*sta), GFP_KERNEL);
+		sta = kzalloc(sizeof(*sta) + tk_len, GFP_KERNEL);
 		if (!sta)
 			return -ENOBUFS;
 
 		ret = iwl_mvm_add_pasn_sta(mvm, vif, &sta->int_sta, addr,
-					   cipher, tk, tk_len);
+					   cipher, tk, tk_len, &sta->keyconf);
 		if (ret) {
 			kfree(sta);
 			return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index ea3e9e9c6e26..a1ce08a5527c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -335,6 +335,21 @@ static int _iwl_mvm_sec_key_del(struct iwl_mvm *mvm,
 	return ret;
 }
 
+int iwl_mvm_sec_key_del_pasn(struct iwl_mvm *mvm,
+			     struct ieee80211_vif *vif,
+			     u32 sta_mask,
+			     struct ieee80211_key_conf *keyconf)
+{
+	u32 key_flags = iwl_mvm_get_sec_flags(mvm, vif, NULL, keyconf) |
+		IWL_SEC_KEY_FLAG_MFP;
+
+	if (WARN_ON(!sta_mask))
+		return -EINVAL;
+
+	return  __iwl_mvm_sec_key_del(mvm, sta_mask, key_flags, keyconf->keyidx,
+				      0);
+}
+
 int iwl_mvm_sec_key_del(struct iwl_mvm *mvm,
 			struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 9a89b91519db..e148ef02ff73 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2402,6 +2402,10 @@ int iwl_mvm_sec_key_del(struct iwl_mvm *mvm,
 			struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta,
 			struct ieee80211_key_conf *keyconf);
+int iwl_mvm_sec_key_del_pasn(struct iwl_mvm *mvm,
+			     struct ieee80211_vif *vif,
+			     u32 sta_mask,
+			     struct ieee80211_key_conf *keyconf);
 void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif,
 			       struct iwl_mvm_vif_link_info *link,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 2a3ca9785974..d57fcbe4f8ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4298,12 +4298,12 @@ u16 iwl_mvm_tid_queued(struct iwl_mvm *mvm, struct iwl_mvm_tid_data *tid_data)
 
 int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
-			 u8 *key, u32 key_len)
+			 u8 *key, u32 key_len,
+			 struct ieee80211_key_conf *keyconf)
 {
 	int ret;
 	u16 queue;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct ieee80211_key_conf *keyconf;
 	unsigned int wdg_timeout =
 		iwl_mvm_get_wd_timeout(mvm, vif, false, false);
 	bool mld = iwl_mvm_has_mld_api(mvm->fw);
@@ -4328,12 +4328,6 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (ret)
 		goto out;
 
-	keyconf = kzalloc(sizeof(*keyconf) + key_len, GFP_KERNEL);
-	if (!keyconf) {
-		ret = -ENOBUFS;
-		goto out;
-	}
-
 	keyconf->cipher = cipher;
 	memcpy(keyconf->key, key, key_len);
 	keyconf->keylen = key_len;
@@ -4354,10 +4348,9 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 					   0, NULL, 0, 0, true);
 	}
 
-	kfree(keyconf);
-	return 0;
 out:
-	iwl_mvm_dealloc_int_sta(mvm, sta);
+	if (ret)
+		iwl_mvm_dealloc_int_sta(mvm, sta);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index b33a0ce096d4..4668f413abd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -574,7 +574,8 @@ void iwl_mvm_csa_client_absent(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk);
 int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
-			 u8 *key, u32 key_len);
+			 u8 *key, u32 key_len,
+			 struct ieee80211_key_conf *key_conf_out);
 void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
 				   u32 id);
-- 
2.34.1


