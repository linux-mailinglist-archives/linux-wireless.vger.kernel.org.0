Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D57D2370
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjJVO40 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 10:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJVO4Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 10:56:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3764013E
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 07:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697986583; x=1729522583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R4zcQcXEX8V7LqL+1TPJb4P0UPTtT+imZWMP8RW0mV8=;
  b=J6MJHik008sAvRQ5UkxTCCcJoZYs4uYck9rqrc7SvxfpocScXVTq8fAH
   Z9mMY2OhTm4SkwI6aoZBBpMhTkazTFkhQoGLOYcQS/yCmnUg6zxjK9ZXG
   pmNDm8nrsW5QQKt6QU/SU0VAQGZQ7qUdV6hyYeNgWvNf8hOB7NPCOuI4K
   4odxx9oXHgvqMsY5aFb0o4dGMcVxJvF/HRHKDe1uQus4S3YVrhEGo9How
   u8nbqRuhqI5G7JBrIVbECvALO9Rtyvzz/vbcqhQCvDWfLd+/frCGOejkr
   IYKIklou2rqlDvPbBi7tMDaNFUHRNa3fzI5Fv3/QsouLaiIqd7KTDB5GY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="472925857"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="472925857"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="5556206"
Received: from umark-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.231.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:55:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/10] wifi: iwlwifi: trace full frames with TX status request
Date:   Sun, 22 Oct 2023 17:55:52 +0300
Message-Id: <20231022173519.0dfb60a2eaec.I3c3e46ed0eb05700a4d05d293f80d727354a402f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231022145556.244202-1-gregory.greenman@intel.com>
References: <20231022145556.244202-1-gregory.greenman@intel.com>
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

If upper layers requested a TX status, then the frames are
more important, so trace frames in that case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
index 1455b578358b..01fb7b900a6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
@@ -3,17 +3,19 @@
  *
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
  * Copyright(C) 2016        Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018, 2023  Intel Corporation
  *****************************************************************************/
 
 #ifndef __IWLWIFI_DEVICE_TRACE
 #include <linux/skbuff.h>
 #include <linux/ieee80211.h>
 #include <net/cfg80211.h>
+#include <net/mac80211.h>
 #include "iwl-trans.h"
 #if !defined(__IWLWIFI_DEVICE_TRACE)
 static inline bool iwl_trace_data(struct sk_buff *skb)
 {
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	__le16 fc = hdr->frame_control;
 	int offs = 24; /* start with normal header length */
@@ -21,6 +23,10 @@ static inline bool iwl_trace_data(struct sk_buff *skb)
 	if (!ieee80211_is_data(fc))
 		return false;
 
+	/* If upper layers wanted TX status it's an important frame */
+	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)
+		return false;
+
 	/* Try to determine if the frame is EAPOL. This might have false
 	 * positives (if there's no RFC 1042 header and we compare to some
 	 * payload instead) but since we're only doing tracing that's not
-- 
2.38.1

