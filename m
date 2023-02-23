Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231C36A05C6
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjBWKMY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjBWKMS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6765192A
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147136; x=1708683136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LuJaVpdCXMu/KaQOh50oshAsvojkyJk7VFMsfNGbXHs=;
  b=kq3tCQSSCgA8kyEcn97Yxb6XjnpCdQ2S44EHU9VyU8+Zv3KI1w4y0uqi
   WAAsrtStbmICFOWWQRYFZCTQtdSQWqiz19oqC9QX05aMh23e7/1Er2gVl
   B3Xbqef3RUzGyTCsoRS9s2TzciypNyz5+OydLqe6SHkU7cwdb05BC+84g
   V74A8ACAf+Ho8jl9UbBERr/gFo7LGQFlK5fLr5e40MO2qRGxR2p7sQjs/
   152YjCxN6mHNyC9zEFJzbsrHQFB1kiQJm0JrJgCcUg5q0vnk/ZU8XqZTj
   oIhdu9TiZ4TuT0EbpcnqG9s96KR+zSectFswPCoT3M39BaqQ18bwXceK/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396387"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396387"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245439"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245439"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:51 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/21] wifi: mac80211: warn only once on AP probe
Date:   Thu, 23 Feb 2023 12:09:33 +0200
Message-Id: <20230223114629.689d03bcc3d2.I1a76a2be3b42ff93904870ac069f0319507adc23@changeid>
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

