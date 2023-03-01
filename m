Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB926A6A9E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjCAKL3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCAKK4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1163B207
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665453; x=1709201453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eRylqIhT1d/XL/2daGECJyg/ZfHqUQ3I8B4i3ZLHyno=;
  b=LPd8YV6s9ZIdG8G5AnC7lVKlXZUqX36O5P+Uk8u+CnytElILwVnrP6qZ
   UNNkczECsz0M3XVdvGeCR3RDtFEwz8/YcyRem9xop+JRzYCGjk5LXabWn
   qCmtGl13FTkz5O5Cl77TxqjmQytYoSS7E+VkP22AlnbFFA4ZoyuBZmcxa
   hsfmdwk/f+FFwpMxJ7d0WhBT9S4wxU6M3a5e63nwzbpVNrGH+71865obF
   bhrqWdu8WpRt4A6m3psQOnCCQZ290sdSQoH7HUti7wSxZ36Es/wx9aIfK
   EqQCR2021PyZYzcj6Q9ORu1RLNsXzyhtrz0UgUZSKlqSMWvlDEmx8LFQs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662944"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662944"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589226"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589226"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:45 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 18/23] wifi: mac80211: mlme: remove pointless sta check
Date:   Wed,  1 Mar 2023 12:09:30 +0200
Message-Id: <20230301115906.4cbac9cfd03a.I21ec81c96d246afdabc2b0807d3856e6b1182cb7@changeid>
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

