Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9818C7A8BAB
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjITS0c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjITS0b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:26:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F47C6
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234385; x=1726770385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=awU3IC5lzIZEWuNaKximpASNqq2AJJgi98GItNMgIzg=;
  b=c8qvEu+cW2ZdF9h20bQbUMMKtLaISD0Evj2Cpfs5oxHlRE2gAWSvW1xr
   bML4LM+WThCH+/2RpPB52HdD6SsCefeFZU6aKJ1mQ8dZ+ry1GbNkfegb4
   XJNkIsKtdaw06P7iaX0dQvCqNrnPR6IWBMTn+GUlbJFYbAEv++kG/gMfr
   2YxNSUwh7NS66nuFgmHwR8IcMtPOTRwTjnoT4apTV0FC/v3IY5/yv+efZ
   JlKl24D2H9ZrDGTiYestWNxpU3xw67FDB1UPqT/pzL3foHAY0Gn3xCVsz
   bzNffdRjEYiNTVTlVHcIXpUR9xjO795SaiJbrS6uJ4mAqUZCDcXcxY/Vb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556321"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556321"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424222"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424222"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:22 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 05/18] wifi: mac80211: allow for_each_sta_active_link() under RCU
Date:   Wed, 20 Sep 2023 21:25:16 +0300
Message-Id: <20230920211508.73c3e04985f4.I52ef396d693e0e381a73eade06850137d8900948@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920182529.659973-1-gregory.greenman@intel.com>
References: <20230920182529.659973-1-gregory.greenman@intel.com>
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

Since we only use this to protect the dereference and with
STA mutex, we can also allow this with just RCU.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7aea4787e62b..be3d74942a4a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2393,7 +2393,7 @@ static inline bool lockdep_sta_mutex_held(struct ieee80211_sta *pubsta)
 	for (link_id = 0; link_id < ARRAY_SIZE((sta)->link); link_id++)		\
 		if ((!(vif)->active_links ||					\
 		     (vif)->active_links & BIT(link_id)) &&			\
-		    ((link_sta) = link_sta_dereference_protected(sta, link_id)))
+		    ((link_sta) = link_sta_dereference_check(sta, link_id)))
 
 /**
  * enum sta_notify_cmd - sta notify command
-- 
2.38.1

