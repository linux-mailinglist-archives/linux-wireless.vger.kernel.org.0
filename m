Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972D46A6A91
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCAKKd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCAKKP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B623A851
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665414; x=1709201414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1/KMh69t+L8zZyEtu4p8BjqqlZYCQSXNJlW7awKFn9g=;
  b=VcW8eSY9MQDX3hqqu8QYLuxGVzx+tjCpfR1jPqr/Zhou29uKrxfkkwRU
   JErLRf4aOd9K7uOhOtivE6UH1GV/0QO40LCWBhkACnZZ1h5SHFtKLaU/A
   M85Zsrae1rPRqpy8UbwTemzGQJ1YS5CR3jFYmrrQ8cI9riurUBIIEXwaf
   /Mt7xz9yJZseIqDQNvhUE/E/rBo3FTPyWsMbbK0h5ZWhIg2QqZaUZGBxt
   55wXxWvx196reHSjElyLpnxzmn/1YREK07Ey6Z3IxkE57M2+Y+otbyf/6
   R2gQ9aB4qIgdjsW8eCiIRhaEDtt+zyl7Uv21jbXHGKN1TQV2Sgj13am0a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662822"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662822"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589041"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589041"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:09 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 07/23] wifi: wireless: correct validation 6G Band for primary channel
Date:   Wed,  1 Mar 2023 12:09:19 +0200
Message-Id: <20230301115906.314faf725255.I5e27251ac558297553b590d3917a7b6d1aae0e74@changeid>
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

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Current check that beacon primary channel is in the range of 80Mhz
(abs < 80) is invalid for EHT 320Mhz due to 6G DUP beacon means that
AP transmits on all the sub 20Mhz channels the beacon.

9.4.2.249 HE Operation element - ... AP transmits Beacon frames in
non-HT duplicate PPDU with a TXVECTOR parameter CH_BANDWIDTH value
that is up to the BSS bandwidth.

So in case of 320Mhz the DUP beacon can be in upper 160 for primary
channel in the lower 160 giving possibly a absolute range of over
80Mhz.

Also this check is redundant all together, if AP has a wrong primary
channel in the beacon it's a fluty AP, and we would fail in next
steps to connect.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 72e9af6158ef..0cdfbb104b80 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1885,23 +1885,21 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
 
 	freq = ieee80211_channel_to_freq_khz(channel_number, channel->band);
 
-	/*
-	 * In 6GHz, duplicated beacon indication is relevant for
-	 * beacons only.
+	/* Frame info (beacon/prob res) is the same as resieved channel, no need
+	 * for forther process.
 	 */
-	if (channel->band == NL80211_BAND_6GHZ &&
-	    (freq == channel->center_freq ||
-	     abs(freq - channel->center_freq) > 80))
+	if (freq == channel->center_freq)
 		return channel;
 
 	alt_channel = ieee80211_get_channel_khz(wiphy, freq);
 	if (!alt_channel) {
-		if (channel->band == NL80211_BAND_2GHZ) {
+		if (channel->band == NL80211_BAND_2GHZ ||
+		    channel->band == NL80211_BAND_60GHZ) {
 			/*
 			 * Better not allow unexpected channels when that could
 			 * be going beyond the 1-11 range (e.g., discovering
 			 * BSS on channel 12 when radio is configured for
-			 * channel 11.
+			 * channel 11) or beyond the 6G channel range.
 			 */
 			return NULL;
 		}
-- 
2.38.1

