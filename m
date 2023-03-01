Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163A96A6A9D
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCAKLa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCAKK5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D143B3B0CE
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665454; x=1709201454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r62uH3sdVqE6J5c5+puxa6H9aaTzV+A11gimufUyV4A=;
  b=k6GcAu2shEik1WbGQnGn3f4oL3xdF/A8Mb9T7da7Z+Ji5E2GVt/0Rtw4
   jJkzwM1j9bLwM0Pg81PqL4fUsV8rkdkD/DhaIAezgJZJDxowaZgDd8y5d
   r4wzbdEUhwMEPlRYy4+zBSs2fStRbAK9vtZ+JzaWCVtvCYvE6/sLC6K0f
   hdybgLMCzsUr0MvkhuC1tdTviB7cJCvyFJ/m9wHSC67cS6Gp+2pcrHm9m
   rI6WNH+CmrfcvRb1wa6GvIq5Uo6maZDOM0x+uZSF6P2l5PoOY0/YtCqKA
   gJh10uxzAqNsyucyHshLvPVkK5Fb1rPtHn9Pj0eBta4U2krzzmG3Ai7m9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662951"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662951"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589233"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589233"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:47 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 19/23] wifi: mac80211: simplify reasoning about EHT capa handling
Date:   Wed,  1 Mar 2023 12:09:31 +0200
Message-Id: <20230301115906.7413d50d23bc.I6fef7484721be9bd5364f64921fc5e9168495f62@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230301100935.170922-1-gregory.greenman@intel.com>
References: <20230301100935.170922-1-gregory.greenman@intel.com>
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

Given the code in cfg80211, EHT capa cannot be non-NULL when
HE capa is NULL, but it's easier to reason about it if both
are checked and the compiler will likely integrate the check
with the previous one for HE capa anyway.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7e90f4a81962..2c8fa19c2f24 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1788,7 +1788,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 						  (void *)params->he_6ghz_capa,
 						  link_sta);
 
-	if (params->eht_capa)
+	if (params->he_capa && params->eht_capa)
 		ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
 						    (u8 *)params->he_capa,
 						    params->he_capa_len,
-- 
2.38.1

