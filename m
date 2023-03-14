Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578A06B9D91
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCNRxy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCNRxx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:53:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F99EABB06
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816385; x=1710352385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ac1hmINEHBiQvV5ztr/bTf4SK9qiCTJeUiBrAKWPHE=;
  b=PuwivSn3lXmCimYpk2MZbEt+sLvF8TN1tiNuldK+5HFMbVV8xXKflp4e
   nw+1SCPAs+vJouPXKAdgxBJEAIugBfa3wY0Z5kDLX4bbdb4qquMLqTxkj
   jO+oc//TKaupB1AdefLbfRuNosmZQZ5GLBluhEmh29zX508yWXYB+dKLa
   5G6zsxWwHoynagwz1e/d0Y2aIIrN7xteLl8Wy2SyN5D4yV0O9CpS0UfbN
   uCu+LXXclqZJqGL/qYMQ1VWhCNmPzxplZ7PVGNL5KUrq/xqiOsC0eDPqJ
   zjUOSlHV+S0LdQC6gdDWMJC6z2yRDljhCGPtGS27qkl/o07O5D8eM1JN2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149663"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149663"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200561"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200561"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:23 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/22] wifi: iwlwifi: mvm: remove setting of 'sta' parameter
Date:   Tue, 14 Mar 2023 19:49:27 +0200
Message-Id: <20230314194113.711fe28cfdd6.I2f723f9d44f65720baaf3e84b72109759350a8f5@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

cppcheck reports
[drivers/net/wireless/intel/iwlwifi/mvm/rs.c:2686]: (warning) Assignment of function parameter has no effect outside the function. Did you forget dereferencing it?

The setting of the 'sta' parameter is not needed.  In the if-check that sets it
to NULL, mvm_sta is also set to NULL.  Then the next statement checks if
mvm_sta is NULL and does an early return. So remove setting sta.

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 1f81dff71bc4..7c976b7f1cd7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2682,7 +2682,6 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 		/* if vif isn't initialized mvm doesn't know about
 		 * this station, so don't do anything with the it
 		 */
-		sta = NULL;
 		mvm_sta = NULL;
 	}
 
-- 
2.38.1

