Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADFF6E42CF
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjDQImV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjDQImU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D59E5267
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720937; x=1713256937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F1WrcDEnFeu8L1Xqix/ktc5byVbreTBRYP314cTt0ow=;
  b=d9nKF10ozidufyROVfXJ7spF5z2qfdEMR7Rv1eI5b+onit3O82c52gN/
   chWOjtEG41lXZ7H0LdD6SbDHxIgE7w08T7AxCcoC3CfFij4rdvMJamcMb
   tbkm+BBMP24792etDIrVRkEMCzBhc02OKPH4Q6B3wjV5eOCMp0lFfU8ji
   G8McYAwDhCzIKq8gH7q+QUHsU2u3NEi9GfQ0ggyxcI6tsHX1BiLNIL0lU
   hUb2WKUd8HMYirB2nMqXP+ADwQ1gHWYSVxq+K2emQdOCfrkyYzPtB+G1e
   CO+rx2ip1vLoI0aXXGSWmrpJusDS8MQwpmWHcJ3eRF2pNslFqYLC8oKTC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634436"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634436"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173891"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173891"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:15 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: mvm: configure TLC on link activation
Date:   Mon, 17 Apr 2023 11:41:31 +0300
Message-Id: <20230417113648.1a93de9b7c1f.I42022f24bbe3572f5a082da8c99794ae14281875@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417084134.1338976-1-gregory.greenman@intel.com>
References: <20230417084134.1338976-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

If the AP station already exists on link activation (which
means we're during link switch), configure the TLC in FW so
we can immediately transmit once the link is activated.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 99ef12c530ea..fbc2d5ed1006 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -256,6 +256,30 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	if (ret)
 		goto out;
 
+	/* Initialize rate control for the AP station, since we might be
+	 * doing a link switch here - we cannot initialize it before since
+	 * this needs the phy context assigned (and in FW?), and we cannot
+	 * do it later because it needs to be initialized as soon as we're
+	 * able to TX on the link, i.e. when active.
+	 *
+	 * Firmware restart isn't quite correct yet for MLO, but we don't
+	 * need to do it in that case anyway since it will happen from the
+	 * normal station state callback.
+	 */
+	if (mvmvif->ap_sta &&
+	    !test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
+		struct ieee80211_link_sta *link_sta;
+
+		rcu_read_lock();
+		link_sta = rcu_dereference(mvmvif->ap_sta->link[link_id]);
+
+		if (!WARN_ON_ONCE(!link_sta))
+			iwl_mvm_rs_rate_init(mvm, vif, mvmvif->ap_sta,
+					     link_conf, link_sta,
+					     phy_ctxt->channel->band);
+		rcu_read_unlock();
+	}
+
 	/* then activate */
 	ret = iwl_mvm_link_changed(mvm, vif, link_conf,
 				   LINK_CONTEXT_MODIFY_ACTIVE |
-- 
2.38.1

