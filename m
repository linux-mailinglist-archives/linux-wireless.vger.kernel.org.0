Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CBC6A05CC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjBWKMb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbjBWKMT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:19 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDC451937
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147138; x=1708683138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eRylqIhT1d/XL/2daGECJyg/ZfHqUQ3I8B4i3ZLHyno=;
  b=E3s4t9uPuFAocJxHhPowWxz1Hmk0xciedyYGswvPUac2qiAEzHwhMFZ2
   Fsx/SAAE2tLO8++VI0hCNlhRNBXPflSfWE5NUUL7uC3XCZaLp8H9ZCZWc
   WLX+MSfeOOyBy1WkPX7lpggByA7K2FHVdAUVsyH7d1P/GcjqbeAZcOZp6
   qJmqrjH0Pn5rMHpv0WKDMfrVxRIGSGdk3YmtRg21HPv46pGJsd5YDef6g
   DbaCEdn7xgSkwE+0QiFrMYuFB/y7BHxheZg0wZ77QZsHyxQAifXHBQn93
   PD6PMoUeJ/ybxwrV+QkyePkVzJYF7oNaGrNYpu7DUZ7Kqk73RKXRchHOO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396470"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396470"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:11:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245678"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245678"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:11:07 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/21] wifi: mac80211: mlme: remove pointless sta check
Date:   Thu, 23 Feb 2023 12:09:39 +0200
Message-Id: <20230223114629.5a60f5da8a1a.I21ec81c96d246afdabc2b0807d3856e6b1182cb7@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230223100942.767589-1-gregory.greenman@intel.com>
References: <20230223100942.767589-1-gregory.greenman@intel.com>
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

We already exited the function if sta ended up NULL,
so just remove the extra check.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cdf842c0849b..78adbacf8538 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5893,7 +5893,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		goto free;
 	}
 
-	if (sta && elems->opmode_notif)
+	if (elems->opmode_notif)
 		ieee80211_vht_handle_opmode(sdata, link_sta,
 					    *elems->opmode_notif,
 					    rx_status->band);
-- 
2.38.1

