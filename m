Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E365E701C7B
	for <lists+linux-wireless@lfdr.de>; Sun, 14 May 2023 11:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjENJQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 May 2023 05:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjENJQa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 May 2023 05:16:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A7D1FC8
        for <linux-wireless@vger.kernel.org>; Sun, 14 May 2023 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684055788; x=1715591788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PySQWSqmWjCeTEBKy1IafIImr9pto9tf7byTIKeNhSY=;
  b=D9pGCw04PPpnsWIMM8SgAAqfYfvKBYS/y/yJet+wsYq+d4YZNi5TY1ju
   rBBIIeV6oJvxFPGiaO9I3Eo2YOJTOPZBkPg1wZpO9y+p7bWl+3A2t6e0h
   adwFdsmlm+MsiEMmG+zbPGJcng8FjDPOfzo9k4QjqIw7wdm7YXWCHPrKH
   BsWXPODDPIVl0yF7hdMA1uZelTBeajPjRvf//8wwTd+Gm9Cmdtsxxd32F
   QkYXLBIXMrQMHHI4emsP53DIS6DgTwGgxLfr/WjtlLqhlHfQrkmEiW8S3
   BP5PRF1cyhyCBEw92NWOzMOGoHEXC5R+6JspUudL/NMR2Zj9KMFNhb8sv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="340366846"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="340366846"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731300391"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="731300391"
Received: from seran-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.239.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:27 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH wireless 06/12] wifi: iwlwifi: mvm: fix access to fw_id_to_mac_id
Date:   Sun, 14 May 2023 12:15:49 +0300
Message-Id: <20230514120631.ec5f2880e81c.Ifa8c0f451df2835bde800f5c3670cc46238a3bd8@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230514091555.168392-1-gregory.greenman@intel.com>
References: <20230514091555.168392-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

RCU protected fw_id_to_mac_id can be initialized with either
an error code or NULL. Thus, after dereferencing need to check
the value with IS_ERR_OR_NULL() and not only that it is not NULL.
Fix it.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  5 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c          |  7 +++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c           | 10 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c            |  2 +-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 3963a0d4ed04..652a603c4500 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -526,6 +526,11 @@ iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		rcu_read_lock();
 
 		sta = rcu_dereference(mvm->fw_id_to_mac_id[mvmvif->deflink.ap_sta_id]);
+		if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta))) {
+			rcu_read_unlock();
+			return PTR_ERR_OR_ZERO(sta);
+		}
+
 		if (sta->mfp && (peer->ftm.trigger_based || peer->ftm.non_trigger_based))
 			FTM_PUT_FLAG(PMF);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 01432274a6da..6226e4e54a51 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -691,6 +691,11 @@ void iwl_mvm_reorder_timer_expired(struct timer_list *t)
 
 		rcu_read_lock();
 		sta = rcu_dereference(buf->mvm->fw_id_to_mac_id[sta_id]);
+		if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta))) {
+			rcu_read_unlock();
+			goto out;
+		}
+
 		mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
 		/* SN is set to the last expired frame + 1 */
@@ -712,6 +717,8 @@ void iwl_mvm_reorder_timer_expired(struct timer_list *t)
 			  entries[index].e.reorder_time +
 			  1 + RX_REORDER_BUF_TIMEOUT_MQ);
 	}
+
+out:
 	spin_unlock(&buf->lock);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 1e8592d3bcd6..05a54a69c135 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -281,7 +281,7 @@ static void iwl_mvm_rx_agg_session_expired(struct timer_list *t)
 	 * A-MDPU and hence the timer continues to run. Then, the
 	 * timer expires and sta is NULL.
 	 */
-	if (!sta)
+	if (IS_ERR_OR_NULL(sta))
 		goto unlock;
 
 	mvm_sta = iwl_mvm_sta_from_mac80211(sta);
@@ -3782,6 +3782,9 @@ static inline u8 *iwl_mvm_get_mac_addr(struct iwl_mvm *mvm,
 		u8 sta_id = mvmvif->deflink.ap_sta_id;
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[sta_id],
 						lockdep_is_held(&mvm->mutex));
+		if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta)))
+			return NULL;
+
 		return sta->addr;
 	}
 
@@ -3819,6 +3822,11 @@ static int __iwl_mvm_set_sta_key(struct iwl_mvm *mvm,
 
 	if (keyconf->cipher == WLAN_CIPHER_SUITE_TKIP) {
 		addr = iwl_mvm_get_mac_addr(mvm, vif, sta);
+		if (!addr) {
+			IWL_ERR(mvm, "Failed to find mac address\n");
+			return -EINVAL;
+		}
+
 		/* get phase 1 key from mac80211 */
 		ieee80211_get_key_rx_seq(keyconf, 0, &seq);
 		ieee80211_get_tkip_rx_p1k(keyconf, addr, seq.tkip.iv32, p1k);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 10d7178f1071..00719e130438 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1875,7 +1875,7 @@ static void iwl_mvm_rx_tx_cmd_agg(struct iwl_mvm *mvm,
 	mvmsta = iwl_mvm_sta_from_staid_rcu(mvm, sta_id);
 
 	sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
-	if (WARN_ON_ONCE(!sta || !sta->wme)) {
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta) || !sta->wme)) {
 		rcu_read_unlock();
 		return;
 	}
-- 
2.38.1

