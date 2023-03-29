Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB726CD296
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjC2HII (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjC2HIG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285AD30C2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073670; x=1711609670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=its8sULuNJRozM7q3GQXQsBLNCIkM/hTtMRANoMLgEE=;
  b=NrJKMwWtVHzD4uEJ49XQps4dM68cCwuX4N5Yz+QSc/PZ/BN4MkuPy3sV
   u+ENVMD/hwwycn5+/YqRcmPH0U6b53D1rTY7fq2qmoSpr8imVZeH+5Ri7
   mOEXn7p47SSm1hZeFxLsRBi8iFwnRrXehGp83g9FCmWXOaX3eBzjCVn8X
   t3obuhv1mf2OTUlb4GkGgHrNycr89ykJhDH9i2qdQLE6ZnKdTo+LwcWWx
   YF/+s6VK0jPLhlLfm9CH/sZQjvIrjG+GcHoksPWWAW0ORC3YvUDgEUfp9
   KbtG918FYBqNXH+vkTGCQPoLfaNjisuqSNM+kzu9PtHD4Eqcnm+OXi7Xh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450863"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450863"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111358"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111358"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:32 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 20/34] wifi: iwlwifi: mvm: remove chanctx WARN_ON
Date:   Wed, 29 Mar 2023 10:05:26 +0300
Message-Id: <20230329100039.c629090bd5d2.If7a680d5e349d454f2122f936c21522b9528a55f@changeid>
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

During link switching there might be a link that's marked
active but has no chanctx assigned (so it's not active from
our driver's POV), skip such links in power recalculation
without any warning.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/power.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 2033d89dc9e5..ac1dae52556f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -286,7 +286,8 @@ static bool iwl_mvm_power_is_radar(struct ieee80211_vif *vif)
 	rcu_read_lock();
 	for_each_vif_active_link(vif, link_conf, link_id) {
 		chanctx_conf = rcu_dereference(link_conf->chanctx_conf);
-		if (WARN_ON(!chanctx_conf))
+		/* this happens on link switching, just ignore inactive ones */
+		if (!chanctx_conf)
 			continue;
 
 		radar_detect = !!(chanctx_conf->def.chan->flags &
-- 
2.38.1

