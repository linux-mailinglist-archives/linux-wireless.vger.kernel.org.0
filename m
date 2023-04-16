Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822186E385B
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjDPMs2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjDPMs1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A252111
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649298; x=1713185298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZM94AJ2QnP5NwFcsIGEA+Xs+cKQC0bAndni2hxgTMec=;
  b=Pn4IU0nLejOMY/BXP3P6lFyOqvm3YQ0PIogO5cjxQuHZ2KIK9pj8ygwx
   Fi+Q/X7cy5hjEg++dLsepT8S0XmD5XmOkZaG9CnDEWVUgf2uW4RSAIR5g
   8gMy0Lys4pB6QBiwA5weYOwdIkDqzuGUolAeaPLHBrL/JSjvaQOc4mLVI
   bgBw1GnrQ+CBpN/Y9i7h3AiXAeA03AD/iCF3R18jn/sH/CrkEjixd2IwH
   Q5nQsWXdQIxh7PII89/Y8eLX/oWKrPZRnwZcUhSckhJcWe4PVEMpkPtVf
   iNr5qsoFihlsQ6rwBnw0Kg4tdcFbhqidwq3YYFAkukiDmvirx8u3v6MhX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520573"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520573"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670449"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670449"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: mvm: implement key link switching
Date:   Sun, 16 Apr 2023 15:47:36 +0300
Message-Id: <20230416154301.c6a777dd5e47.I693f7fd7c52fe8b51a58af69d45488511367f49e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230416124739.1260800-1-gregory.greenman@intel.com>
References: <20230416124739.1260800-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Implement switching keys from one set of firmware station IDs
to another set, during link switch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  | 53 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 11 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  5 ++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index a8ab35473924..8853821b3716 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -97,6 +97,59 @@ static u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 	return flags;
 }
 
+struct iwl_mvm_sta_key_update_data {
+	struct ieee80211_sta *sta;
+	u32 old_sta_mask;
+	u32 new_sta_mask;
+	int err;
+};
+
+static void iwl_mvm_mld_update_sta_key(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_sta *sta,
+				       struct ieee80211_key_conf *key,
+				       void *_data)
+{
+	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
+	struct iwl_mvm_sta_key_update_data *data = _data;
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct iwl_sec_key_cmd cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_MODIFY),
+		.u.modify.old_sta_mask = cpu_to_le32(data->old_sta_mask),
+		.u.modify.new_sta_mask = cpu_to_le32(data->new_sta_mask),
+		.u.modify.key_id = cpu_to_le32(key->keyidx),
+		.u.modify.key_flags =
+			cpu_to_le32(iwl_mvm_get_sec_flags(mvm, vif, sta, key)),
+	};
+	int err;
+
+	/* only need to do this for pairwise keys (link_id == -1) */
+	if (sta != data->sta || key->link_id >= 0)
+		return;
+
+	err = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC, sizeof(cmd), &cmd);
+
+	if (err)
+		data->err = err;
+}
+
+int iwl_mvm_mld_update_sta_keys(struct iwl_mvm *mvm,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				u32 old_sta_mask,
+				u32 new_sta_mask)
+{
+	struct iwl_mvm_sta_key_update_data data = {
+		.sta = sta,
+		.old_sta_mask = old_sta_mask,
+		.new_sta_mask = new_sta_mask,
+	};
+
+	ieee80211_iter_keys_rcu(mvm->hw, vif, iwl_mvm_mld_update_sta_key,
+				&data);
+	return data.err;
+}
+
 static int __iwl_mvm_sec_key_del(struct iwl_mvm *mvm, u32 sta_mask,
 				 u32 key_flags, u32 keyidx, u32 flags)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 36d83e22f0af..65436736f87f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -994,6 +994,7 @@ static int iwl_mvm_mld_update_sta_baids(struct iwl_mvm *mvm,
 }
 
 static int iwl_mvm_mld_update_sta_resources(struct iwl_mvm *mvm,
+					    struct ieee80211_vif *vif,
 					    struct ieee80211_sta *sta,
 					    u32 old_sta_mask,
 					    u32 new_sta_mask)
@@ -1006,6 +1007,12 @@ static int iwl_mvm_mld_update_sta_resources(struct iwl_mvm *mvm,
 	if (ret)
 		return ret;
 
+	ret = iwl_mvm_mld_update_sta_keys(mvm, vif, sta,
+					  old_sta_mask,
+					  new_sta_mask);
+	if (ret)
+		return ret;
+
 	return iwl_mvm_mld_update_sta_baids(mvm, old_sta_mask, new_sta_mask);
 }
 
@@ -1045,7 +1052,7 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 	}
 
 	if (sta_mask_to_rem) {
-		ret = iwl_mvm_mld_update_sta_resources(mvm, sta,
+		ret = iwl_mvm_mld_update_sta_resources(mvm, vif, sta,
 						       current_sta_mask,
 						       current_sta_mask &
 							~sta_mask_to_rem);
@@ -1123,7 +1130,7 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 	}
 
 	if (sta_mask_added) {
-		ret = iwl_mvm_mld_update_sta_resources(mvm, sta,
+		ret = iwl_mvm_mld_update_sta_resources(mvm, vif, sta,
 						       current_sta_mask,
 						       current_sta_mask |
 							sta_mask_added);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 29a87d1ba343..203eb7233c77 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2332,6 +2332,11 @@ void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif,
 			       struct iwl_mvm_vif_link_info *link,
 			       unsigned int link_id);
+int iwl_mvm_mld_update_sta_keys(struct iwl_mvm *mvm,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				u32 old_sta_mask,
+				u32 new_sta_mask);
 
 int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm,
 			    struct iwl_rfi_lut_entry *rfi_table);
-- 
2.38.1

