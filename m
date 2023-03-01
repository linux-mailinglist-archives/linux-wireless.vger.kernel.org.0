Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84F6A6AA2
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCAKLd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCAKK6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB4A3B841
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665457; x=1709201457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mwS6qbBxI8qN8B7lyLijGs9EPck9d1pZxhjcgbC9+cs=;
  b=PreNkOTsEk6IMwQcjJex9HMf2vFEnWiyHfhxK/9uXF8HEU7+zfufBToa
   LEm0mUto32CYSiqMyyy9Mv9XjU6QEM5wrDzl/aWNvVh0QALulQhVZ3QBo
   8cgq6BtqnJnAa7HvlbSahfY6ki0DikAlEnCE0o0z1P9kMtcyy/r+RqEB8
   ie+PpjfKbAOoAUEBmL6pvVMq1P1jSe963WNY1E1UEXJA4crvhchLJmywq
   2Dseq79Jl1UlAFgsaLVLBn7Qkv0/qob2GeW2eBTxTeH83IL4Xz8XG05Z2
   cpFqxfKkmrpLqG1Pa9QzEUYZqWQamI4ndxCIL8E/MO/+9JHOhUUHrYt5h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662957"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662957"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589237"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589237"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:49 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 20/23] wifi: mac80211: fix ieee80211_link_set_associated() type
Date:   Wed,  1 Mar 2023 12:09:32 +0200
Message-Id: <20230301115906.d67ccae57d60.Ia4768e547ba8b1deb2b84ce3bbfbe216d5bfff6a@changeid>
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

