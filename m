Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1834D7A481D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbjIRLMU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbjIRLLq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50B294
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035500; x=1726571500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=awU3IC5lzIZEWuNaKximpASNqq2AJJgi98GItNMgIzg=;
  b=nCy9qke8DAW+QRoQSzBHmswRkiJoc12+sZVI33ZFfBuN6/HmZXIl7fmO
   xD/W65tUZaDH/kLBoaVGkVELLsvMT8AffL6cO/f3O1nyVLDHl0EJhrbuX
   YPBSE31w6GQgmJRwSblvBbdfidc7TdZo5j2VSZEhb76IWKl2Hi1IsjTRE
   s3HTbeSSBBkFjD9/ff6Kvgbbmhsg8vDJ1mFGT4KutqJJjX3P4q50Oj3H7
   jAGUdcW51KewqCZH1SDIxN8/HYQPyc0HKjGYz1MVXvK0BHTtvzpW0tMtN
   vWzvfjy8udwYeS+OenPfbbXn8bY4XHnC8WnqIofWptRpkTDCMaMUnbezX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535748"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535748"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025280"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025280"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:30 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/18] wifi: mac80211: allow for_each_sta_active_link() under RCU
Date:   Mon, 18 Sep 2023 14:10:50 +0300
Message-Id: <20230918140607.25b2a5c0fd63.I52ef396d693e0e381a73eade06850137d8900948@changeid>
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

