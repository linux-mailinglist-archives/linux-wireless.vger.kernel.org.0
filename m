Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9B96CB8ED
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjC1IAM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjC1IAK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E7420A
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990406; x=1711526406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NeaXlQYE3NEG2nPnLEkx+3n1plhwisNkhAxEARHzLdk=;
  b=hnUdbw+MFySDZasv6ccSQn25nTfQq6RQvZLEFKT6MvdltfbUjcSH/cZt
   cuEqB6O8qi+APRrviM8VmznVmkYrjwqON6nVmAGkkBUMacOlOF1IS/6XF
   UP1DJDDiSApsVz2b0nkGqTRP3nYnvQNf9RJdWCLv5RXiiiymk8RQs8poH
   Xmmw20sAVUNoC7iK77TzOdxw49FX1hDuH5Ecwv4vq/SawabE/1/6O+V6x
   wY8+WtzJe+Mb/qFmWl2B+Tmym4OCt7tPCjPBg1U5C18ZJ/Ax/t3shuo+k
   IWLvSx2dOge7QYk5Soda/QXJnLRmL9hLsse6rQoBUwIxrC8OVdAdwFalT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958114"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958114"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045135"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045135"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:42 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/31] wifi: iwlwifi: mvm: add support for post_channel_switch in MLD mode
Date:   Tue, 28 Mar 2023 10:58:49 +0300
Message-Id: <20230328104948.fa3992f7dfd2.Ie298a9b1522e956d7b699f0432795548bc6e47f9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Adjust the existing iwl_mvm_post_channel_switch()
to the new MLD API and use it in the new MLD ieee80211_ops

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c     | 10 ++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h          |  2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ce2f502bfff8..631d1becc6ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1317,8 +1317,8 @@ static int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
 }
 
-static int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif)
+int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
@@ -1339,8 +1339,10 @@ static int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 		}
 
 		iwl_mvm_sta_modify_disable_tx(mvm, mvmsta, false);
-
-		iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
+		if (mvm->mld_api_is_used)
+			iwl_mvm_mld_mac_ctxt_changed(mvm, vif, false);
+		else
+			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
 
 		if (!fw_has_capa(&mvm->fw->ucode_capa,
 				 IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 92f174231f60..818aed050b73 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -640,6 +640,7 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.switch_vif_chanctx = iwl_mvm_mld_switch_vif_chanctx,
 	.join_ibss = iwl_mvm_mld_start_ap_ibss,
 	.leave_ibss = iwl_mvm_mld_stop_ap_ibss,
+	.post_channel_switch = iwl_mvm_post_channel_switch,
 	.sta_state = iwl_mvm_mld_mac_sta_state,
 	.conf_tx = iwl_mvm_mld_mac_conf_tx,
 	.bss_info_changed = iwl_mvm_mld_bss_info_changed,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ba59a6c30529..bf1de6405cd6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2298,6 +2298,8 @@ static inline u8 iwl_mvm_phy_band_from_nl80211(enum nl80211_band band)
 
 /* Channel Switch */
 void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk);
+int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif);
 
 /* Channel Context */
 /**
-- 
2.38.1

