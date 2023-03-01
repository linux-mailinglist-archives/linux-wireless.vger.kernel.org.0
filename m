Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD776A6A96
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCAKK6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCAKKm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761913B0F0
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665432; x=1709201432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LuJaVpdCXMu/KaQOh50oshAsvojkyJk7VFMsfNGbXHs=;
  b=TKz/0fHLZeBUwNnbzLuRCtA9dKu8PVSu6HEpPlsRL5YROgq1FYulEx2j
   OmpQt+17CIrt9xzI6cHOOhxFQA5eJpz9HwDzspsssBtKYCi3at4lSYJCM
   IP7Ch6wa5IsP3jC43r/lgDZwjU4UF5vulA62JXrAv2TYa4bUWF3otgYis
   XOiNrZ7ZKw/1Z4uXWfMhnVI3zW/qaUerJ8Xnr1CSbzP8ewmj5ZNQ1wm6n
   mryJo289BXGXp1owRRIUqPW60Xa/4IysBGkk4n2O8i4wSf/qgOzs6ZuZh
   dO8QPnrMY9U0y7RbLZ9djYTNvnLlSVma18swpem0o9uDKqfI9a4fG1V0o
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662883"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662883"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589122"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589122"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:30 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 12/23] wifi: mac80211: warn only once on AP probe
Date:   Wed,  1 Mar 2023 12:09:24 +0200
Message-Id: <20230301115906.1c8499b6fbe6.I1a76a2be3b42ff93904870ac069f0319507adc23@changeid>
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

We should perhaps support this API for MLO, but it's not
clear that it makes sense, in any case then we'd have to
update it to probe the correct BSS.

For now, if it happens, warn only once so that we don't
get flooded with messages if the driver misbehaves and
calls this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 60792dfabc9d..cdf842c0849b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3227,7 +3227,7 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	bool already = false;
 
-	if (WARN_ON(sdata->vif.valid_links))
+	if (WARN_ON_ONCE(sdata->vif.valid_links))
 		return;
 
 	if (!ieee80211_sdata_running(sdata))
-- 
2.38.1

