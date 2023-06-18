Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E87F7347CD
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjFRSvM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFRSvK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:51:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCA8E5F
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114261; x=1718650261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zsNpiMabLs8u62pNVbGnhnNcXF6dOk4m++EFd6Fn0/M=;
  b=ZgojAemhOsEegqWoOg6IBVWihbg6NriwDdRsDudSNrbnN9muwr9/3tP6
   xRaL2nIh8DaPGz7+q+L68D0EVEwxi9qip2ATeZuvIVHCb44mpToxtnJm7
   yyiXjIC+1eNFZjC1uzqBYi+3AgkvTZSZGuvJ/3EPsVz+zgPycqAym+Wtf
   9TAhI1Ce5H7qNVIE+QRwcVb4rBlrRqd2xu6U+lnm6p4d85abkDZtMDlxh
   OOrz0SXeeFGoFUs2MumvZeHNlkZzF2XeFvuh9d2x3xCvlPQQdbeRI9E0+
   zlc+9YMs4X0bUmQhTDIxoN+Ukd1Fu+BL5Na9FyjDvLA+E64vTwi3VnIyp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116675"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116675"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:51:00 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747234106"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747234106"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:58 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/20] wifi: cfg80211: stop parsing after allocation failure
Date:   Sun, 18 Jun 2023 21:50:00 +0300
Message-Id: <20230618214436.0ffac98475cf.I6f5c08a09f5c9fced01497b95a9841ffd1b039f8@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230618185002.817236-1-gregory.greenman@intel.com>
References: <20230618185002.817236-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

The error handling code would break out of the loop incorrectly,
causing the rest of the message to be misinterpreted. Fix this by
also jumping out of the surrounding while loop, which will trigger
the error detection code.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index cf0ad544cb99..b2cf7abd5ad0 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -707,7 +707,7 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 					GFP_ATOMIC);
 
 			if (!entry)
-				break;
+				goto error;
 
 			entry->center_freq = freq;
 
@@ -723,6 +723,7 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 		}
 	}
 
+error:
 	if (pos != end) {
 		cfg80211_free_coloc_ap_list(&ap_list);
 		return 0;
-- 
2.38.1

