Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75ED6A05CE
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjBWKMd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjBWKMU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE2A515DA
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147138; x=1708683138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mwS6qbBxI8qN8B7lyLijGs9EPck9d1pZxhjcgbC9+cs=;
  b=O53WSxzFyLTxML18ACoTpP1vE7I+xBdMZAXrqSmknxWme/ztKBJ3Pui/
   1PV2PzcRDUs62d5ao2WPREpkd+VewemSMY7teH0PdhQ0lmupjsvMnGykI
   rT/uzEPjlIJPBm7isq1gzWn8KVdZ4wWFEjTv+QVdZOUtQktN0NgyD7FVC
   57Q2beiZceOXM81vGsskQpQalrRy4XpJ32Gyqcn13UMYzZogLCenl8yTU
   vQlHQc2UaS5qCPLWLXQMjrRVpaQy9OhIvpGgwav2bln0cca5n9mt9IgzV
   6n7YxO87xnKbZFV92bzJUe/P2u2xLPTKJh2ZeOD6oigK0RlIFKZQJSE5f
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396494"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396494"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:11:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245732"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245732"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:11:12 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 20/21] wifi: mac80211: fix ieee80211_link_set_associated() type
Date:   Thu, 23 Feb 2023 12:09:41 +0200
Message-Id: <20230223114629.ba5caaccbd8d.Ia4768e547ba8b1deb2b84ce3bbfbe216d5bfff6a@changeid>
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

The return type here should be u64 for the flags, even
if it doesn't matter right now because it doesn't return
any flags that don't fit into u32.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 78adbacf8538..e13a0354c397 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2744,7 +2744,7 @@ static u32 ieee80211_handle_bss_capability(struct ieee80211_link_data *link,
 	return changed;
 }
 
-static u32 ieee80211_link_set_associated(struct ieee80211_link_data *link,
+static u64 ieee80211_link_set_associated(struct ieee80211_link_data *link,
 					 struct cfg80211_bss *cbss)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
-- 
2.38.1

