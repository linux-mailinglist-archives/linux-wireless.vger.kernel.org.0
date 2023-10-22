Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBD27D2371
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 16:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjJVO42 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 10:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjJVO40 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 10:56:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F305124
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697986585; x=1729522585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YO7PfPZC43Y7b5fo7CnjpkDRUfR51Ue1oSBb1PzIujA=;
  b=Gvvwyt3tlZOUD7oo3lCXN2nf732IXTwoOUOzZKzOfknbYSs/0KVgFny9
   S2EGxVSwdsV3kxQ4UXqO4JAkAKv9JHRCgxoM68vHyePz3aqZPORPXe5DO
   yBVB1wFm1o1si1FBZeVRVtz6/N3Ga7Ok6V6BmYxXHeo8300WnTAFvFgfv
   7Ye027Mso3kaDJ+XRsp7VqqnWvS/s3O0R68zjf+oi+traz1mEYMWKjKBQ
   1QhahUwxsObJ245P32qA8frAaNik2ReXnKyguW20n2KDqmjwEay76Ek4s
   IhItKweBLcfzHEpKzTelvLUn8Ful4xUfdHbahK5hkXMiLaSjHJXUma7aR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="472925860"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="472925860"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="5556212"
Received: from umark-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.231.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:55:08 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/10] wifi: iwlwifi: mvm: cycle FW link on chanctx removal
Date:   Sun, 22 Oct 2023 17:55:53 +0300
Message-Id: <20231022173519.90c82837ba4d.I341fa30c480f7673b14b48a0e29a2241472c2e13@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231022145556.244202-1-gregory.greenman@intel.com>
References: <20231022145556.244202-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When the vif is in MLD mode, we'll get a vif links change from
non-zero to zero on disassociation, which removes all links in
the firmware and adds the 'deflink' the driver/mac80211 has.
This causes the firmware to clear some internal state.

However, in non-MLD mode, this doesn't happen, and causes some
state to be left around in firmware, which can particularly
cause trouble with the ref-BSSID in multi-BSSID, leading to an
assert later if immediately making a new multi-BSSID connection
with a different ref-BSSID.

Fix this by removing/re-adding the link in the non-MLD case
when the channel is removed from the vif. This way, all of the
state will get cleared out, even if we need the deflink, which
is more for software architecture purposes than otherwise.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index c953824f55ef..ff6cb064051b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -462,10 +462,17 @@ static void iwl_mvm_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 					     struct ieee80211_bss_conf *link_conf,
 					     struct ieee80211_chanctx_conf *ctx)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
 	mutex_lock(&mvm->mutex);
 	__iwl_mvm_mld_unassign_vif_chanctx(mvm, vif, link_conf, ctx, false);
+	/* in the non-MLD case, remove/re-add the link to clean up FW state */
+	if (!ieee80211_vif_is_mld(vif) && !mvmvif->ap_sta &&
+	    !WARN_ON_ONCE(vif->cfg.assoc)) {
+		iwl_mvm_remove_link(mvm, vif, link_conf);
+		iwl_mvm_add_link(mvm, vif, link_conf);
+	}
 	mutex_unlock(&mvm->mutex);
 }
 
-- 
2.38.1

