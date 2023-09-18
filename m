Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96057A4826
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241345AbjIRLNW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbjIRLMl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:12:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B16812D
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035538; x=1726571538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NFilMmbnn7Vd6N15dlNaVBm9ojE3sYiSH1o2VqK/saY=;
  b=Loe6bch22O1H2D6fE47HqaJivfNB43lDo1XSTnNtHtHGGIJCRhTaf31T
   Tp5BdJQ/rWOSvt+LeTklplsQWkwWTrP9D2gNytNUWjpA1ZvQwPUT6UsZA
   UkDjOICu03RnV3INBZRGpV78iqgKCRn6vyPgbWOyEA2n8LysG8pfkeIa5
   6CicUAoNui6wkhsscxbvwL+yXyLmSqpsVukgdsNp1NWxmnMhRM6r72WT9
   QBBmPPGK7wk5pC/jJI8FyopNATeWtux0575XV7NEfY54d/ts99Wt3MT6d
   6DmwYLeYmCjsGMTp6kMv4EZ75zfm+NgcES4eMlWYjp746vuK+n419bjpF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535986"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535986"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025581"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025581"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/18] wifi: mac80211: report per-link error during association
Date:   Mon, 18 Sep 2023 14:11:02 +0300
Message-Id: <20230918140607.043589fb2a4d.I8086c0fdbbf92537d6a8b8e80b33387fcfd5553d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918111103.435195-1-gregory.greenman@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

With this cfg80211 can report the link that caused the error to
userspace which is then able to react to it by e.g. removing the link
from the association and retrying.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 7d69fd2713a8..10a762816146 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7889,8 +7889,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		/* only calculate the flags, hence link == NULL */
 		err = ieee80211_prep_channel(sdata, NULL, assoc_data->link[i].bss,
 					     &assoc_data->link[i].conn_flags);
-		if (err)
+		if (err) {
+			req->links[i].error = err;
 			goto err_clear;
+		}
 	}
 
 	/* needed for transmitting the assoc frames properly */
-- 
2.38.1

