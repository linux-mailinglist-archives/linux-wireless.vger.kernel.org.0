Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861096CD292
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjC2HHw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjC2HHu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8473340C4
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073648; x=1711609648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=joXRlOe1nGFz7DPedMPTPS2HDlJ4u2ukbuY/BRM6gAg=;
  b=miRQTFpbTKt3g3ZeBHjGnGeTnaGma8kfFPitu6vtoC9hK1IVSOq0Nfcl
   4GpzVVwdwjtH0S+jg94EfXYyVWwCdXusLExt8h2ZN3F1XCSRuWvCtu2u7
   zzHvWvDeNuFFXJry6u6Hiily1LWd8vHoM1vu2aA389KMRg71puLhh5qDv
   8Gr8skUdiwg48uhPYzjI2iM+e7sCtIKs7cBYqXPtSUylEFmQHHi+ydKwt
   6iTb1r2P0NbcUSnM3DB4+BuOPiiWc0CzfayKw0BEgX/lS1YEgUwO8WG6g
   x0SQAMSHOudcsA/9k5ZqUjbyD/+tgjm5UKcMf4qisMjxYXYwOjvORLxs3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450850"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450850"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111339"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111339"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:26 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/34] wifi: iwlwifi: mvm: skip inactive links
Date:   Wed, 29 Mar 2023 10:05:23 +0300
Message-Id: <20230329100039.bd9b4e64c478.Ie21422c3bf2589d22942c3c57d26e6330d2e3afc@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When iterating station links, skip the links that are not
yet active by checking for mvmvif->link[] existence.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 568f0eaeb0fb..1fd7e5bf594d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3657,7 +3657,7 @@ static void iwl_mvm_vif_set_he_support(struct ieee80211_hw *hw,
 		struct ieee80211_bss_conf *link_conf =
 			rcu_dereference_protected(vif->link_conf[i], 1);
 
-		if (!link_conf || !link_sta)
+		if (!link_conf || !link_sta || !mvmvif->link[i])
 			continue;
 
 		link_conf->he_support = link_sta->he_cap.has_he;
@@ -3757,6 +3757,8 @@ iwl_mvm_sta_state_auth_to_assoc(struct ieee80211_hw *hw,
 
 			if (WARN_ON(!link_conf))
 				return -EINVAL;
+			if (!mvmvif->link[i])
+				continue;
 
 			iwl_mvm_link_changed(mvm, vif, link_conf,
 					     LINK_CONTEXT_MODIFY_ALL &
-- 
2.38.1

