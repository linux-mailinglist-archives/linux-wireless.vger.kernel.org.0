Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C467C7A8BAF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjITS0n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjITS0m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:26:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD5B102
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234393; x=1726770393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HtDJhZB2j4u2ksLhmW/LRlqH1TmIrp2WCbJFqoGS+0=;
  b=eh1NQBufX7Ml6UjRisTRiVPCoc1IxaIPcOyAqxpCke9IIqk6g79IS8Bv
   kEgnHV2RnnoGkb0ysZgnQoiQgAO1o30GpvucqGf16XIhu7P+nJx9wsz+f
   IoUEVgCPeA3eTldPyvrxrusLELfXEmBOJV5/askgVFEY7LUcGZst4gr6N
   3RnwuJI6swL4tQiMlpV7egE4BlHaKdd4T5upNSjLrJJr2P2XAB5ccfx5t
   m+k0YIWnoQmIWztI+GKh6aZqeXMkm5iUXfq88yAgG7wU/KIL/7wt+teHj
   ObntAu6kzS8OszFgAIGhu6/y2EgBEDaJUrpjeJ8CAryN16Anyobpmjrz5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556395"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556395"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424240"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424240"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:31 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 09/18] wifi: cfg80211: Fix 6GHz scan configuration
Date:   Wed, 20 Sep 2023 21:25:20 +0300
Message-Id: <20230920211508.7a593e3aff6c.I6c4e3e3075d1d1878ee41f45190fdc6b86f18708@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

When the scan request includes a non broadcast BSSID, when adding the
scan parameters for 6GHz collocated scanning, do not include entries
that do not match the given BSSID.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index a5758edf53b8..8d114faf4842 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -908,6 +908,10 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		    !cfg80211_find_ssid_match(ap, request))
 			continue;
 
+		if (!is_broadcast_ether_addr(request->bssid) &&
+		    !ether_addr_equal(request->bssid, ap->bssid))
+			continue;
+
 		if (!request->n_ssids && ap->multi_bss && !ap->transmitted_bssid)
 			continue;
 
-- 
2.38.1

