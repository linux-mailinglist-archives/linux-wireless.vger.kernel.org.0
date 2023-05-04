Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DC56F6D22
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 15:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjEDNpe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 09:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjEDNpc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 09:45:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759C87D9C
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683207931; x=1714743931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xoFpV5sNFzrWwQXQhffevupVk/eKIEqrP6bR2ykDYeM=;
  b=XN/xRu/DLYurXVLV7D4Wdga1ZJgvVeDKh0PsTxI4P8rjzv1cGNdcF+7j
   0hhdC8f4VxFD7hJhFDpYsQ8SCOApJ6sQXfqUEGdoOI50icl7cK/dnto8e
   XXAfaTFyd/sxfNUKx+ePCpRgF/pOMcsWeW3DkktUrOJ4tjKAv6k7nICK1
   ylKeG3sbS2bjIEtQckSuX4LCyHhn+7EKSgdClHEE/LfNtrxhJsXTWaH/3
   L94hd7YjFVRm5Hu7tXx1lkuufKXEDrBjwsFah+U2/V2E5/rtRFfCQvXEh
   dTlVO/Jhlj7FHPSDgMfLZkua7/rswURA2hOj755maN4PmBws/MDnDdWbW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435242592"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="435242592"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766591669"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766591669"
Received: from haddadra-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.238.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/11] wifi: mac80211: simplify chanctx allocation
Date:   Thu,  4 May 2023 16:45:02 +0300
Message-Id: <20230504134511.828474-3-gregory.greenman@intel.com>
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

There's no need to call ieee80211_recalc_chanctx_min_def()
since it cannot and won't call the driver anyway; just use
_ieee80211_recalc_chanctx_min_def() instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/chan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index dbc34fbe7c8f..d23d1a7b4cc3 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -638,7 +638,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	ctx->conf.rx_chains_dynamic = 1;
 	ctx->mode = mode;
 	ctx->conf.radar_enabled = false;
-	ieee80211_recalc_chanctx_min_def(local, ctx);
+	_ieee80211_recalc_chanctx_min_def(local, ctx);
 
 	return ctx;
 }
-- 
2.38.1

