Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB626737FD8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjFUKOY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjFUKOB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:14:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D745E1FCA
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342430; x=1718878430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRqhuneCkPkLRV1+8+aN8AqlC2XTHlJ+4qoXokhtlRk=;
  b=hGTR+Y8B0DFa/IgxTukzXplkrsoktLby3eA4NrjPmwTCz4zhgVq0ZQUb
   l+hwnjQFznSBBFfPJVw0LSiXCONxozYAymQoByAQj9LIfz4iOQapFrPJS
   ocet8piGGeF+6waPfmYFWf8LL1eUnwOrNwpJhK0i1z+/grCWKQqE8dy1v
   cCB4J9yd3pZW65802pUzsUascnVpG2YXwSXbW1ZwvMzc/rROoxqFRpN7X
   aXuOYR5RdxgPlzHhH/esTt9zYyLKqjZg04hNRWhOJyJpVt8fuPfo2ys5J
   Mx3B0Be5QI8uTtEy33T4GbDXt8VodYoDjWHBTIZm6j9wWq+vameoV9P3o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506397"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506397"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:12:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599149"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599149"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:12:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/18] wifi: iwlwifi: don't load old firmware for ax210
Date:   Wed, 21 Jun 2023 13:12:11 +0300
Message-Id: <20230621130443.ebe02b5dbddb.I51484ebb6c89256b0e6e7f9bb24f597c4ebead67@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230621101222.218083-1-gregory.greenman@intel.com>
References: <20230621101222.218083-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The earliest firmware released for these products is with
API version 59 (for 'ty' only), so no point trying to go
back in time even further than that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index cc6761e46bee..1159c0e551b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -13,7 +13,7 @@
 #define IWL_AX210_UCODE_API_MAX	82
 
 /* Lowest firmware API version supported */
-#define IWL_AX210_UCODE_API_MIN	39
+#define IWL_AX210_UCODE_API_MIN	59
 
 /* NVM versions */
 #define IWL_AX210_NVM_VERSION		0x0a1d
-- 
2.38.1

