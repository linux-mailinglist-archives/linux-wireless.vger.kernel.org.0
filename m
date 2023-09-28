Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343427B1FB7
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjI1Of7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI1Of6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:35:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE18F9
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911757; x=1727447757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KMTAP9t0Dkd4JWizrMpfBXG3LIrYtLKlRp1BHghxuWU=;
  b=YZ+YiPYuzwAwgJt9iU62SKDI7vMm6ievlT5H7UkIZu1cV1kX/uf8bsTV
   ggrgj/h5ETqQR1z4GjrXVVpIdGN2eNaw8jreWO8rnVLmt095BwrTn3B63
   cngBLnLSCrLE0g+D8Wr8w/ENShbyg91Lu24tlY2HCkOxpLsj+igQTuT/+
   wB1es+6ryCOVIA3jrTYBrQHrEeZtu7PLznue2uoG6sHnzjQX+Us2h0qeS
   NGRAHnpAKkGKDyKTGgf5ZC6J3hbZp7b8uBq8JwCChv/cowlmpHCA5GMUt
   /EsLD1jvQR62M8cV0/Sq8syy/PDuP2R1YIBTsnxlZ8WHXELGAkHYY+v5H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688404"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688404"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:35:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590389"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590389"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:35:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/18] wifi: mac80211: drop robust action frames before assoc
Date:   Thu, 28 Sep 2023 17:35:23 +0300
Message-Id: <20230928172905.f26784ad4601.Ie9f4906e2f6c698989bce6681956ed2f9454f27c@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

To be able to more easily understand the code, drop robust
action frames before being associated, even if there's no
MFP in the end, as they are Class 3 Frames and shouldn't
be transmitted in the first place.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index fb2d4a7436be..aec851c722f1 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2473,6 +2473,15 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 			return RX_DROP_U_UNPROT_UNICAST_PUB_ACTION;
 	}
 
+	/*
+	 * Drop robust action frames before assoc regardless of MFP state,
+	 * after assoc we also have decided on MFP or not.
+	 */
+	if (ieee80211_is_action(fc) &&
+	    ieee80211_is_robust_mgmt_frame(rx->skb) &&
+	    (!rx->sta || !test_sta_flag(rx->sta, WLAN_STA_ASSOC)))
+		return -EACCES;
+
 	return 0;
 }
 
-- 
2.38.1

