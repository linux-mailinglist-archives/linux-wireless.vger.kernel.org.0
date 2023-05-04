Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B76F6D27
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 15:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjEDNpr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 09:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjEDNpp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 09:45:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC317EC5
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683207942; x=1714743942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HvaAqA13vJXhSlXuQyBaDNlie/dLJ60DefoE4qrwVBM=;
  b=GIctvAT9UW95+TfM0Yl9UkkxFt5QuEbUNOoGyus6lPg5fjGDkq2AAlpE
   Oe+l+Ijc6k7L6lYyEZ1PfQmswJ9byMHq6tfhIUsLhNbg+NqXqzaa9y8VN
   JiRlcdVJ8hGGMWJIBFQks1O8gO5XrRduSTtytuzUkv6ardx7d0Kxqe/da
   srIm/QWVAWBzy4S1O5QLxTS6mLxm2+GRd4MwNt8XesazD+wwrosD6iSSl
   D51J40b04RD1VMddvXFJhopTCJlmcUAWmn5ODMum3kawR5gReTA1x6Rcv
   /YbOL2X7I3g8j4zZlSNHoPzX4l77RoyHMHXTuPitEc+kKAKOYek5pAOyR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435242651"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="435242651"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766591780"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766591780"
Received: from haddadra-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.238.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:40 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/11] wifi: mac80211_hwsim: avoid warning with MLO PS stations
Date:   Thu,  4 May 2023 16:45:07 +0300
Message-Id: <20230504134511.828474-8-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230504134511.828474-1-gregory.greenman@intel.com>
References: <20230504134511.828474-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the station disables all links it's in powersave and
we shouldn't transmit anything to it, but we don't handle
that correctly yet. For now, just avoid the warning, once
we really add support for this case we can revert to the
old warning.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 2211fa58fe41..4f44d87a5c13 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1940,7 +1940,14 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 								 hdr, &link_sta);
 		}
 
-		if (WARN_ON(!bss_conf)) {
+		if (unlikely(!bss_conf)) {
+			/* if it's an MLO STA, it might have deactivated all
+			 * links temporarily - but we don't handle real PS in
+			 * this code yet, so just drop the frame in that case
+			 */
+			WARN(link != IEEE80211_LINK_UNSPECIFIED || !sta || !sta->mlo,
+			     "link:%d, sta:%pM, sta->mlo:%d\n",
+			     link, sta ? sta->addr : NULL, sta ? sta->mlo : -1);
 			ieee80211_free_txskb(hw, skb);
 			return;
 		}
-- 
2.38.1

