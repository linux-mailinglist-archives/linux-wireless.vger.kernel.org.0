Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0C07B1FC4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjI1Og3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjI1OgZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D771B7
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911780; x=1727447780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gf3Bn3Nj5Ir041VfXwlX+imo490jm0GcWJ9SWJTdM+4=;
  b=darQcAkaOqWZ/7S7kBnfx2exroibyXNfEbfuhKBNhMwvZj+zjkA8yKCA
   8o0/P8muflPM/a64er7U+Xb6DGZ6mSHjfYIdiJxnvVqYR3/XEk0bfVTUI
   e1WVtn+7yF6dftTqgaiEMd21UIGFSZIswyKhX4tUwf3c1sdBDvD414+Qg
   0iBDlbYwemPfHjX4lKpLyM33MpoJH+iEB6pp1k0l+UAmIr1VpDFcuxHjo
   N5Wp5/vaND4jN2eKLqv6mBDA2l5PNvMfHSYactBDxNIR+1CPu8dOm39iK
   Y8bvrDO086lJvgf97RNi6wTs2z7I6j7yPgFn46RxnqS5opL0jyit8sazU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688470"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688470"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590481"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590481"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:17 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/18] wifi: cfg80211: Fix typo in documentation
Date:   Thu, 28 Sep 2023 17:35:32 +0300
Message-Id: <20230928172905.9dce226e393f.I929bfb9371e31c9e8d2bb1c1a96e9b1f3d02f2d0@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230928143539.1037500-1-gregory.greenman@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
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

From: Ilan Peer <ilan.peer@intel.com>

Fix a small typo in a comment.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 34c50f7273d1..f4cba7e601e2 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2661,7 +2661,7 @@ static inline void get_random_mask_addr(u8 *buf, const u8 *addr, const u8 *mask)
  *	or no match (RSSI only)
  * @rssi_thold: don't report scan results below this threshold (in s32 dBm)
  * @per_band_rssi_thold: Minimum rssi threshold for each band to be applied
- *	for filtering out scan results received. Drivers advertize this support
+ *	for filtering out scan results received. Drivers advertise this support
  *	of band specific rssi based filtering through the feature capability
  *	%NL80211_EXT_FEATURE_SCHED_SCAN_BAND_SPECIFIC_RSSI_THOLD. These band
  *	specific rssi thresholds take precedence over rssi_thold, if specified.
-- 
2.38.1

