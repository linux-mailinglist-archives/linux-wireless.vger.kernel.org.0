Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82C97C4FBE
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjJKKKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345805AbjJKKJg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:09:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58672134
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018895; x=1728554895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8FMhd4RO5KDInkk9YkMQ2aB7b64ajBL3L45W1zWaTnY=;
  b=NJfPjBMZUJz0X1P7IqlK108uWaXCeGiUm1Pseal3sn3q//xOZECCIADD
   BWxiqyFX1GLfNGLFVgVzeG4E8gsLiQf5zxd4wASq2pLONbypbHkyS8uoj
   6v1prwSLs/n3gZc7RnIfXdNMkQ65/NFYgeA1Eo4NzuNg2ZU0iSXq4uz8Q
   kmmuxtD7S+MnmnzfmrN+68DxF/jUtuPQnEAVPycXC9kQSexnd8sZB1zSf
   KGDbL+EsEku9Iz47xAfzxYwPzKS3yNHNBKwWREwkkhDZLHCh6RxeTJ07Q
   pVlIM81LlOObdX/N5ZZnMssTqLyTEJ0JWezqgJZ51Wir1b+Scv/k8e5Uk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670683"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670683"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050327"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050327"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:14 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/16] wifi: iwlwifi: mvm: fix iwl_mvm_mac_flush_sta()
Date:   Wed, 11 Oct 2023 13:07:29 +0300
Message-Id: <20231011130030.0b5878e93118.I1093e60163052e7be64d2b01424097cd6a272979@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011100731.361200-1-gregory.greenman@intel.com>
References: <20231011100731.361200-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When I implemented iwl_mvm_mac_flush_sta() I completely botched it;
it basically always happens after the iwl_mvm_sta_pre_rcu_remove()
call, and that already clears mvm->fw_id_to_mac_id[] entries, so we
cannot rely on those at iwl_mvm_mac_flush_sta() time. This means it
never did anything.

Fix this by just going through the station IDs and now with the new
API for iwl_mvm_flush_sta(), call those.

Fixes: a6cc6ccb1c8a ("wifi: iwlwifi: mvm: support new flush_sta method")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c142d5d0d414..ba087c5ba6e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5697,22 +5697,20 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 void iwl_mvm_mac_flush_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
 {
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int i;
+	struct iwl_mvm_link_sta *mvm_link_sta;
+	struct ieee80211_link_sta *link_sta;
+	int link_id;
 
 	mutex_lock(&mvm->mutex);
-	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
-		struct iwl_mvm_sta *mvmsta;
-		struct ieee80211_sta *tmp;
-
-		tmp = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
-						lockdep_is_held(&mvm->mutex));
-		if (tmp != sta)
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		mvm_link_sta = rcu_dereference_protected(mvmsta->link[link_id],
+							 lockdep_is_held(&mvm->mutex));
+		if (!mvm_link_sta)
 			continue;
 
-		mvmsta = iwl_mvm_sta_from_mac80211(sta);
-
-		if (iwl_mvm_flush_sta(mvm, mvmsta->deflink.sta_id,
+		if (iwl_mvm_flush_sta(mvm, mvm_link_sta->sta_id,
 				      mvmsta->tfd_queue_msk))
 			IWL_ERR(mvm, "flush request fail\n");
 	}
-- 
2.38.1

