Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91C78D9CC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjH3SeI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242430AbjH3IbZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D041A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384283; x=1724920283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZAvWmqAftpBWLkzzPpUsQWm/unBswqzR5+sZEdBqg/E=;
  b=KcDy0iELgmnafwtrhpRGjyQKjeZPdQ3UDU3xLdImiNK5UjVLNoph04aI
   5RXhIqnwIKuCspjv+DYB8jelxVOdv4u8F6ntchTn4VCOykf26QPFYVHI1
   1kZRqiNwWKdMlO0b3MLwlId4TY1rZMCeTR0TWw5wWMPo3prqhTb3PAlXk
   Bi/5J5HuVfGKDbABQZtPhQnk2wAzEaeNZsDtfCBHFtDCB9npacND3gTrW
   Uan2lPbhWMBU0IxP9Ux1HQDSCnPKajV7FxJi5HUU31D378XCSBrle2/54
   xOlB3MbyyG8nZccknyvgZBju+zZXKJH0G31mZEtPPMyShSpg4ING/nnTY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461958837"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461958837"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829151998"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829151998"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:21 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/16] wifi: iwlwifi: mvm: support CSA with MLD
Date:   Wed, 30 Aug 2023 11:30:49 +0300
Message-Id: <20230830112059.19470584fa51.Iad38b5369bededaa126b3eb3cff79f23d61bd783@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230830083104.546619-1-gregory.greenman@intel.com>
References: <20230830083104.546619-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Pass the right link_id to ieee80211_chswitch_done.
Use the link_conf parameter passed to post_channel_switch() to get the
right ap_sta_id.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index b28d998c65c5..b97b805d3486 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1761,6 +1761,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 	u32 id_n_color, csa_id;
 	/* save mac_id or link_id to use later to cancel csa if needed */
 	u32 id;
+	u32 mac_link_id = 0;
 	u8 notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
 					       CHANNEL_SWITCH_START_NOTIF, 0);
 	bool csa_active;
@@ -1790,6 +1791,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 			goto out_unlock;
 
 		id = link_id;
+		mac_link_id = bss_conf->link_id;
 		vif = bss_conf->vif;
 		csa_active = bss_conf->csa_active;
 	}
@@ -1839,7 +1841,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 
 		iwl_mvm_csa_client_absent(mvm, vif);
 		cancel_delayed_work(&mvmvif->csa_work);
-		ieee80211_chswitch_done(vif, true, 0);
+		ieee80211_chswitch_done(vif, true, mac_link_id);
 		break;
 	default:
 		/* should never happen */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 921f72dcddac..4b3d84213466 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1381,10 +1381,11 @@ int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct iwl_mvm_sta *mvmsta;
+		unsigned int link_id = link_conf->link_id;
+		u8 ap_sta_id = mvmvif->link[link_id]->ap_sta_id;
 
 		mvmvif->csa_bcn_pending = false;
-		mvmsta = iwl_mvm_sta_from_staid_protected(mvm,
-							  mvmvif->deflink.ap_sta_id);
+		mvmsta = iwl_mvm_sta_from_staid_protected(mvm, ap_sta_id);
 
 		if (WARN_ON(!mvmsta)) {
 			ret = -EIO;
-- 
2.38.1

