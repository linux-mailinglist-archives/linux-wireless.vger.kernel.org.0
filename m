Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7837B7C55
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbjJDJhb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242055AbjJDJha (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F68E5
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412243; x=1727948243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+BoPivn/2n2aRFyjul/I4IlFz2cIZjszNzL27RiQgA=;
  b=iej4nw7HxbxNwSdaSMqDPOqrp85onMZMxMc7njGyu70Nx/kyL8eZpTHS
   JO13BJ8zH0x1M/I3DjXym10YwzDBe0f4Et7LkaQIHdNZIWOSg/6AJ/MLG
   K0EMFw6w/L0KrOuel4jZiDod8IyrMHcI8FBun6aCxNo0IqFrpWFM7pe1z
   SeVnlCbss4wGcf4WE1VMBffhCC4YOlgYY0Mm8XYFolTy/aFMWTPrKq6pd
   elCLsl+BFo01TGSEgYnFrQIrlRktEevjLRqww6wrtMj7UlquxzGl3/uBX
   GGNGrHhTbAOgddFEPf7L5QkLGqlB0LLVrUUN+KWYDSTxXJR1wyHbUWAG3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611916"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611916"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415207"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415207"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:17 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: Correctly set link configuration
Date:   Wed,  4 Oct 2023 12:36:34 +0300
Message-Id: <20231004123422.2666ef86e032.I4b0e95722660acc5345ceefba7e8866a69572e8e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004093634.131303-1-gregory.greenman@intel.com>
References: <20231004093634.131303-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

In case the link puncturing is changed such that the channel
is no longer punctured, configure the FW correctly indicating
the EHT parameters changed (with a 0 punctured map).

Allow EHT parameters configuration only when the link really
supports EHT.

Fixes: 55eb1c5fa4b2 ("wifi: iwlwifi: mvm: add support for the new LINK command")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c       | 13 ++++++++-----
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c   |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index e76f57d78125..6e1ad65527d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -189,11 +189,14 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		flags_mask |= LINK_FLG_MU_EDCA_CW;
 	}
 
-	if (link_conf->eht_puncturing && !iwlwifi_mod_params.disable_11be)
-		cmd.puncture_mask = cpu_to_le16(link_conf->eht_puncturing);
-	else
-		/* This flag can be set only if the MAC has eht support */
-		changes &= ~LINK_CONTEXT_MODIFY_EHT_PARAMS;
+	if (changes & LINK_CONTEXT_MODIFY_EHT_PARAMS) {
+		if (iwlwifi_mod_params.disable_11be ||
+		    !link_conf->eht_support)
+			changes &= ~LINK_CONTEXT_MODIFY_EHT_PARAMS;
+		else
+			cmd.puncture_mask =
+				cpu_to_le16(link_conf->eht_puncturing);
+	}
 
 	cmd.bss_color = link_conf->he_bss_color.color;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 1e311eec9d5f..1154a6001b65 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -744,7 +744,7 @@ iwl_mvm_mld_link_info_changed_station(struct iwl_mvm *mvm,
 	}
 
 	/* Update EHT Puncturing info */
-	if (changes & BSS_CHANGED_EHT_PUNCTURING && vif->cfg.assoc && has_eht)
+	if (changes & BSS_CHANGED_EHT_PUNCTURING && vif->cfg.assoc)
 		link_changes |= LINK_CONTEXT_MODIFY_EHT_PARAMS;
 
 	if (link_changes) {
-- 
2.38.1

