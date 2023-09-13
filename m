Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4458479E75F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbjIML6M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbjIML6J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:58:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B1119B4
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606285; x=1726142285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NrZb+2IlSMB6ZR0/JqwFifr8HyPpgWpIhDG39AGkfWs=;
  b=fWHSlbPXu4LKpyvVMSYXAwKAMsy0f5mndp5zrUBe6UKHv7a3l7ZPRNPT
   ZSN6FJ22gzsQZZRWQPzmMmjaVmL7mhXMgQXwz1caUfltvd8wNx8i59PAf
   6mU4fIB+P73OwyJ5MSZ6+accDaeShYIiY+mPLVm44QmmR3pHIf/OvGZiq
   sWh6ivkGdB7klbjVKhgHwmnSo2MKdLl2RFeEu6UqYWp+ELIWKn0qwSFGZ
   L5BffUK4B4zxEM2rTOOlWEGhvTN4uAT5L5SWrxDedGYWwRXhg6xbv/Qqz
   oatb3YZBnNL7GkGdWQC00Y7YTEVGbOhng4zaXL0yCykCw5sKaCsL7V+SO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368903070"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368903070"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470965"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470965"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:30 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mvm: fix recovery flow in CSA
Date:   Wed, 13 Sep 2023 14:56:46 +0300
Message-Id: <20230913145231.2651e6f6a55a.I4cd50e88ee5c23c1c8dd5b157a800e4b4c96f236@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

If the firmware crashes in the de-activation / re-activation
of the link during CSA, we will not have a valid phy_ctxt
pointer in mvmvif. This is a legit case, but when mac80211
removes the station to cleanup our state during the
re-configuration, we need to make sure we clear ap_sta
otherwise we won't re-add the station after the firmware has
been restarted. Later on, we'd activate the link, try to send
a TLC command crash again on ASSERT 3508.

Fix this by properly cleaning up our state.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 2fb5fb41f508..98172da346fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1033,6 +1033,7 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 	spin_unlock_bh(&mvm->time_event_lock);
 
 	memset(&mvmvif->bf_data, 0, sizeof(mvmvif->bf_data));
+	mvmvif->ap_sta = NULL;
 
 	for_each_mvm_vif_valid_link(mvmvif, link_id) {
 		mvmvif->link[link_id]->ap_sta_id = IWL_MVM_INVALID_STA;
@@ -3871,7 +3872,11 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
-	/* this would be a mac80211 bug ... but don't crash */
+	/* this would be a mac80211 bug ... but don't crash, unless we had a
+	 * firmware crash while we were activating a link, in which case it is
+	 * legit to have phy_ctxt = NULL. Don't bother not to WARN if we are in
+	 * recovery flow since we spit tons of error messages anyway.
+	 */
 	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		if (WARN_ON_ONCE(!mvmvif->link[link_id] ||
 				 !mvmvif->link[link_id]->phy_ctxt)) {
-- 
2.38.1

