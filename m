Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E1B6FA228
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjEHIZd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjEHIZF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:25:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06501A488
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534301; x=1715070301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GCMaTa5WPa6WII0naMm5bvYXE2VraBVjlRmVJrviYeA=;
  b=P9s8ncxNrbc/Eho4sQtbPI4SzfDZasw252aDRenORaj/9oiq5ZowmcFw
   K/qoayPQsPN6QZ95pS+6XdUc0CZj1CiThnQdCXwt2Gk0tw6D5i0JICylz
   tj1PjLDTL+4K8dG3mtTtBnzDudc8uHeoOgypRDkxB5DrMIxx7V4vOnZOe
   tr8jCn78K3bXHI3cGxkKRWEVoTlLk4X72mGaVVz3GkKlyBCF2NLNEpZPE
   XksK49YpiidKut786WlJ6rcJz8CDl6CwGQhFr5OB0KecUJ/PDJyzTDlki
   gbhAGUe7ZB7sHd50cRynLeDEAww107VLlzsYY0qSNxoLQy/exKXmpp3wG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329949891"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329949891"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767982647"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767982647"
Received: from shemert-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.224.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:24:59 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/14] wifi: iwlwifi: mvm: support PASN for MLO
Date:   Mon,  8 May 2023 11:24:27 +0300
Message-Id: <20230508082433.1349733-9-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508082433.1349733-1-gregory.greenman@intel.com>
References: <20230508082433.1349733-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When adding a PASN station, the non MLD API was used. This results
in assert when operating as MLD. Fix it to use the MLD API when
operating as MLD. For now, the default link is used for the added
station.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  | 27 ++++++++-----
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 10 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 +++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 39 +++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  5 +++
 5 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 8853821b3716..3e6f86f644b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -51,10 +51,10 @@ static u32 iwl_mvm_get_sec_sta_mask(struct iwl_mvm *mvm,
 	return iwl_mvm_sta_fw_id_mask(mvm, sta, keyconf->link_id);
 }
 
-static u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_sta *sta,
-				 struct ieee80211_key_conf *keyconf)
+u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *keyconf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u32 flags = 0;
@@ -164,13 +164,9 @@ static int __iwl_mvm_sec_key_del(struct iwl_mvm *mvm, u32 sta_mask,
 	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, flags, sizeof(cmd), &cmd);
 }
 
-int iwl_mvm_sec_key_add(struct iwl_mvm *mvm,
-			struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta,
-			struct ieee80211_key_conf *keyconf)
+int iwl_mvm_mld_send_key(struct iwl_mvm *mvm, u32 sta_mask, u32 key_flags,
+			 struct ieee80211_key_conf *keyconf)
 {
-	u32 sta_mask = iwl_mvm_get_sec_sta_mask(mvm, vif, sta, keyconf);
-	u32 key_flags = iwl_mvm_get_sec_flags(mvm, vif, sta, keyconf);
 	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
 	struct iwl_sec_key_cmd cmd = {
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
@@ -223,6 +219,17 @@ int iwl_mvm_sec_key_add(struct iwl_mvm *mvm,
 	return ret;
 }
 
+int iwl_mvm_sec_key_add(struct iwl_mvm *mvm,
+			struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta,
+			struct ieee80211_key_conf *keyconf)
+{
+	u32 sta_mask = iwl_mvm_get_sec_sta_mask(mvm, vif, sta, keyconf);
+	u32 key_flags = iwl_mvm_get_sec_flags(mvm, vif, sta, keyconf);
+
+	return iwl_mvm_mld_send_key(mvm, sta_mask, key_flags, keyconf);
+}
+
 static int _iwl_mvm_sec_key_del(struct iwl_mvm *mvm,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 19f1545b3c7e..36bbe92d2696 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -128,11 +128,11 @@ static int iwl_mvm_add_aux_sta_to_fw(struct iwl_mvm *mvm,
 /*
  * Adds an internal sta to the FW table with its queues
  */
-static int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
-					      struct iwl_mvm_int_sta *sta,
-					      const u8 *addr, int link_id,
-					      u16 *queue, u8 tid,
-					      unsigned int *_wdg_timeout)
+int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
+				       struct iwl_mvm_int_sta *sta,
+				       const u8 *addr, int link_id,
+				       u16 *queue, u8 tid,
+				       unsigned int *_wdg_timeout)
 {
 	int ret, txq;
 	unsigned int wdg_timeout = _wdg_timeout ? *_wdg_timeout :
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 0f278a73a997..5f7469cfd092 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2361,6 +2361,12 @@ int iwl_mvm_mld_update_sta_keys(struct iwl_mvm *mvm,
 				struct ieee80211_sta *sta,
 				u32 old_sta_mask,
 				u32 new_sta_mask);
+int iwl_mvm_mld_send_key(struct iwl_mvm *mvm, u32 sta_mask, u32 key_flags,
+			 struct ieee80211_key_conf *keyconf);
+u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *keyconf);
 
 int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm,
 			    struct iwl_rfi_lut_entry *rfi_table);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 1e8592d3bcd6..54bcd65cde2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4298,16 +4298,27 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	u16 queue;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_key_conf *keyconf;
+	unsigned int wdg_timeout =
+		iwl_mvm_get_wd_timeout(mvm, vif, false, false);
+	bool mld = iwl_mvm_has_mld_api(mvm->fw);
+	u32 type = mld ? STATION_TYPE_PEER : IWL_STA_LINK;
 
 	ret = iwl_mvm_allocate_int_sta(mvm, sta, 0,
-				       NL80211_IFTYPE_UNSPECIFIED,
-				       IWL_STA_LINK);
+				       NL80211_IFTYPE_UNSPECIFIED, type);
 	if (ret)
 		return ret;
 
-	ret = iwl_mvm_add_int_sta_with_queue(mvm, mvmvif->id, mvmvif->color,
-					     addr, sta, &queue,
-					     IWL_MVM_TX_FIFO_BE);
+	if (mld)
+		ret = iwl_mvm_mld_add_int_sta_with_queue(mvm, sta, addr,
+							 mvmvif->deflink.fw_link_id,
+							 &queue,
+							 IWL_MAX_TID_COUNT,
+							 &wdg_timeout);
+	else
+		ret = iwl_mvm_add_int_sta_with_queue(mvm, mvmvif->id,
+						     mvmvif->color, addr, sta,
+						     &queue,
+						     IWL_MVM_TX_FIFO_BE);
 	if (ret)
 		goto out;
 
@@ -4320,9 +4331,23 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	keyconf->cipher = cipher;
 	memcpy(keyconf->key, key, key_len);
 	keyconf->keylen = key_len;
+	keyconf->flags = IEEE80211_KEY_FLAG_PAIRWISE;
+
+	if (mld) {
+		/* The MFP flag is set according to the station mfp field. Since
+		 * we don't have a station, set it manually.
+		 */
+		u32 key_flags =
+			iwl_mvm_get_sec_flags(mvm, vif, NULL, keyconf) |
+			IWL_SEC_KEY_FLAG_MFP;
+		u32 sta_mask = BIT(sta->sta_id);
+
+		ret = iwl_mvm_mld_send_key(mvm, sta_mask, key_flags, keyconf);
+	} else {
+		ret = iwl_mvm_send_sta_key(mvm, sta->sta_id, keyconf, false,
+					   0, NULL, 0, 0, true);
+	}
 
-	ret = iwl_mvm_send_sta_key(mvm, sta->sta_id, keyconf, false,
-				   0, NULL, 0, 0, true);
 	kfree(keyconf);
 	return 0;
 out:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index f5f8d41f5134..e396034b8795 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -646,6 +646,11 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 				 u16 old_links, u16 new_links);
 u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			   int filter_link_id);
+int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
+				       struct iwl_mvm_int_sta *sta,
+				       const u8 *addr, int link_id,
+				       u16 *queue, u8 tid,
+				       unsigned int *_wdg_timeout);
 
 /* Queues */
 void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
-- 
2.38.1

