Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9778C6FA224
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjEHIZ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjEHIYy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:24:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07921C0F4
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534293; x=1715070293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NLXzg2/gO5gz0IW3tJk2T41Em80wtEuvZX5AuArDlt0=;
  b=U151TvGcDCAEEcuIUJ05QJXO+RZuCQwjL3ikSaqfM7QMDtMDbbrqcJg1
   r98CysrBtAckkXKs2mV0u1rrQOdo4PGXCaIXazHn2a2oZL/4WOLm3Bvxk
   P8oosMxdFr6lolz5vlxLSp8PK6w4pX1iN/rDUMwpX5fsf6289hi5sruVB
   wXOx5Ep7WacEZL2i1I4BsjBAG1Cb0ZCnfGJu9CDhDDhspRPvNkWUQVdIt
   k3+Z1Z3i0UPQ/he8rdhgh7x1RudQxhyiYwXvOenOgMUq/7RM8P70Areck
   Xk22przvU/4PzfqYYOlC/NTMvKCbyI5fhwJlOxcrGAN5q1TOr947mx4h7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329949866"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329949866"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767982596"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767982596"
Received: from shemert-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.224.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:24:52 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/14] wifi: iwlwifi: mvm: always free dup_data
Date:   Mon,  8 May 2023 11:24:23 +0300
Message-Id: <20230508082433.1349733-5-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

There are some assertions in the STA removal code that can
fail, and in that case we may leak memory since we skip
the freeing.

Fix this by freeing the dup_data earlier in the function,
we already have a check for when we free the station, and
this we don't need to do it with and without MLD API, so
it's a win all around.

Fixes: a571f5f635ef ("iwlwifi: mvm: add duplicate packet detection per rx queue")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 2 --
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 3 ---
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5e28a53dad26..13bbc9a627b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3889,6 +3889,9 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 		 * from the AP now.
 		 */
 		iwl_mvm_reset_cca_40mhz_workaround(mvm, vif);
+
+		/* Also free dup data just in case any assertions below fail */
+		kfree(mvm_sta->dup_data);
 	}
 
 	mutex_lock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 0bfdf4462755..f877be850589 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -791,8 +791,6 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	kfree(mvm_sta->dup_data);
-
 	/* flush its queues here since we are freeing mvm_sta */
 	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		struct iwl_mvm_link_sta *mvm_link_sta =
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 5469d634e289..1e8592d3bcd6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2089,9 +2089,6 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (iwl_mvm_has_new_rx_api(mvm))
-		kfree(mvm_sta->dup_data);
-
 	ret = iwl_mvm_drain_sta(mvm, mvm_sta, true);
 	if (ret)
 		return ret;
-- 
2.38.1

