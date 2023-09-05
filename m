Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0574792533
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjIEQBr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 12:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354677AbjIENae (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 09:30:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D624BC
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693920631; x=1725456631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BuJNLD7HZyMp+eJCPhXLFf7eLbcQSwMgrLiNnJT51xo=;
  b=epG/OpZpbFp5JMLdqIhq9fVMv/x2rDYuVVos4/rnz+yRFBTMqiAsr6SF
   tPFeXSPpAJYjPLuboWyaDeV+667htfAv4Nldx2Lohvv6LP1Ku/VOztfvV
   e4eWDklVlwxlBvmkcbeHyGOwSPmwSUl6Yi7vhFi9gYv460nTeB85Ekcdq
   PwCPgutFCW8JVpDOF24PVuCl2i84dGDVtNsyObdvJjRcXdrz2nr3zvyBr
   l8Fsw6QolWcW8nacXhLLi+kyoLDnblnHi9n/JQ1TGzeCoUz4YBKZHNL1C
   DnpnjUZEH+n5t/R2daKUhYgsA3A/BZxPcbRmVop0+a8zTW4sHt8LnuDpj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="443189291"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="443189291"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 06:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="864690331"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="864690331"
Received: from gilz-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.181.138])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 06:30:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH v2] iwlwifi: mvm: handle PS changes in vif_cfg_changed
Date:   Tue,  5 Sep 2023 16:29:57 +0300
Message-Id: <20230905162939.5ef0c8230de6.Ieed265014988c50ec68fbff6d33821e4215f987f@changeid>
X-Mailer: git-send-email 2.38.1
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

From: Gregory Greenman <gregory.greenman@intel.com>

Handling of BSS_CHANGED_PS was missing in vif_cfg_changed
callback. Fix it.

Fixes: 22c588343529 ("wifi: iwlwifi: mvm: replace bss_info_changed() with vif_cfg/link_info_changed()")
Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 121 +++++++++---------
 1 file changed, 63 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 9615bfff7f7d..778a311b500b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -731,73 +731,78 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 
 	mvmvif->associated = vif->cfg.assoc;
 
-	if (!(changes & BSS_CHANGED_ASSOC))
-		return;
-
-	if (vif->cfg.assoc) {
-		/* clear statistics to get clean beacon counter */
-		iwl_mvm_request_statistics(mvm, true);
-		iwl_mvm_sf_update(mvm, vif, false);
-		iwl_mvm_power_vif_assoc(mvm, vif);
-
-		for_each_mvm_vif_valid_link(mvmvif, i) {
-			memset(&mvmvif->link[i]->beacon_stats, 0,
-			       sizeof(mvmvif->link[i]->beacon_stats));
+	if (changes & BSS_CHANGED_ASSOC) {
+		if (vif->cfg.assoc) {
+			/* clear statistics to get clean beacon counter */
+			iwl_mvm_request_statistics(mvm, true);
+			iwl_mvm_sf_update(mvm, vif, false);
+			iwl_mvm_power_vif_assoc(mvm, vif);
+
+			for_each_mvm_vif_valid_link(mvmvif, i) {
+				memset(&mvmvif->link[i]->beacon_stats, 0,
+				       sizeof(mvmvif->link[i]->beacon_stats));
+
+				if (vif->p2p) {
+					iwl_mvm_update_smps(mvm, vif,
+							    IWL_MVM_SMPS_REQ_PROT,
+							    IEEE80211_SMPS_DYNAMIC, i);
+				}
+
+				rcu_read_lock();
+				link_conf = rcu_dereference(vif->link_conf[i]);
+				if (link_conf && !link_conf->dtim_period)
+					protect = true;
+				rcu_read_unlock();
+			}
 
-			if (vif->p2p) {
-				iwl_mvm_update_smps(mvm, vif,
-						    IWL_MVM_SMPS_REQ_PROT,
-						    IEEE80211_SMPS_DYNAMIC, i);
+			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
+			    protect) {
+				/* If we're not restarting and still haven't
+				 * heard a beacon (dtim period unknown) then
+				 * make sure we still have enough minimum time
+				 * remaining in the time event, since the auth
+				 * might actually have taken quite a while
+				 * (especially for SAE) and so the remaining
+				 * time could be small without us having heard
+				 * a beacon yet.
+				 */
+				iwl_mvm_protect_assoc(mvm, vif, 0);
 			}
 
-			rcu_read_lock();
-			link_conf = rcu_dereference(vif->link_conf[i]);
-			if (link_conf && !link_conf->dtim_period)
-				protect = true;
-			rcu_read_unlock();
-		}
+			iwl_mvm_sf_update(mvm, vif, false);
+
+			/* FIXME: need to decide about misbehaving AP handling */
+			iwl_mvm_power_vif_assoc(mvm, vif);
+		} else if (iwl_mvm_mld_vif_have_valid_ap_sta(mvmvif)) {
+			iwl_mvm_mei_host_disassociated(mvm);
 
-		if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
-		    protect) {
-			/* If we're not restarting and still haven't
-			 * heard a beacon (dtim period unknown) then
-			 * make sure we still have enough minimum time
-			 * remaining in the time event, since the auth
-			 * might actually have taken quite a while
-			 * (especially for SAE) and so the remaining
-			 * time could be small without us having heard
-			 * a beacon yet.
+			/* If update fails - SF might be running in associated
+			 * mode while disassociated - which is forbidden.
 			 */
-			iwl_mvm_protect_assoc(mvm, vif, 0);
+			ret = iwl_mvm_sf_update(mvm, vif, false);
+			WARN_ONCE(ret &&
+				  !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+					    &mvm->status),
+				  "Failed to update SF upon disassociation\n");
+
+			/* If we get an assert during the connection (after the
+			 * station has been added, but before the vif is set
+			 * to associated), mac80211 will re-add the station and
+			 * then configure the vif. Since the vif is not
+			 * associated, we would remove the station here and
+			 * this would fail the recovery.
+			 */
+			iwl_mvm_mld_vif_delete_all_stas(mvm, vif);
 		}
 
-		iwl_mvm_sf_update(mvm, vif, false);
-
-		/* FIXME: need to decide about misbehaving AP handling */
-		iwl_mvm_power_vif_assoc(mvm, vif);
-	} else if (iwl_mvm_mld_vif_have_valid_ap_sta(mvmvif)) {
-		iwl_mvm_mei_host_disassociated(mvm);
-
-		/* If update fails - SF might be running in associated
-		 * mode while disassociated - which is forbidden.
-		 */
-		ret = iwl_mvm_sf_update(mvm, vif, false);
-		WARN_ONCE(ret &&
-			  !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
-				    &mvm->status),
-			  "Failed to update SF upon disassociation\n");
-
-		/* If we get an assert during the connection (after the
-		 * station has been added, but before the vif is set
-		 * to associated), mac80211 will re-add the station and
-		 * then configure the vif. Since the vif is not
-		 * associated, we would remove the station here and
-		 * this would fail the recovery.
-		 */
-		iwl_mvm_mld_vif_delete_all_stas(mvm, vif);
+		iwl_mvm_bss_info_changed_station_assoc(mvm, vif, changes);
 	}
 
-	iwl_mvm_bss_info_changed_station_assoc(mvm, vif, changes);
+	if (changes & BSS_CHANGED_PS) {
+		ret = iwl_mvm_power_update_mac(mvm);
+		if (ret)
+			IWL_ERR(mvm, "failed to update power mode\n");
+	}
 }
 
 static void
-- 
2.38.1

