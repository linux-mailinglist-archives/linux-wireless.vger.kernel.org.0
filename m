Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360166FA229
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjEHIZe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjEHIZG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:25:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868DD1FAA0
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534303; x=1715070303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GdnDifGCq605v24mSJbVHN2idq5dUI+5r+hWnGkWoXQ=;
  b=Z58za41y6eORjs+enwdxrEe+ejONwQdeyMeV9nxJ7AcDNvzX0yyabHbK
   tZGVZZWYLDsVDn4MdMmc6V1NQJIUAjpyB3yx8eqd8KReY2dKPZQkj6T28
   KVIVlSn9fzfQIOKNOMEIx1UyCZ5r7tnT/Nx3ViqEsMkAOGVjDR5UQVJxP
   ZtZ4hX0nL+jbFjhFHqwhOahJIT+T4pG15Jgs3r/of5ASdfB1bd0VHCJmt
   pC+rcqo5Hv5h/Pa8VtTMIcl+JZSxasifDVC0i5nzOIfEFvTWJ4vm7j/NZ
   9aH0XwPrXHHxNEPEarpzPFsjNQ7994WLoy33e6SxYi2SRmO9cKTHNVsOC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329949894"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329949894"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767982660"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767982660"
Received: from shemert-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.224.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/14] wifi: iwlwifi: don't silently ignore missing suspend or resume ops
Date:   Mon,  8 May 2023 11:24:28 +0300
Message-Id: <20230508082433.1349733-10-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508082433.1349733-1-gregory.greenman@intel.com>
References: <20230508082433.1349733-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

In case the driver doesn't implement suspend or resume operations
on the transport layer, notify the driver's upper layer.
Otherwise, we might access d3_status uninitialized.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 9f1228b5a384..885581e636c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1160,7 +1160,7 @@ static inline int iwl_trans_d3_suspend(struct iwl_trans *trans, bool test,
 {
 	might_sleep();
 	if (!trans->ops->d3_suspend)
-		return 0;
+		return -EOPNOTSUPP;
 
 	return trans->ops->d3_suspend(trans, test, reset);
 }
@@ -1171,7 +1171,7 @@ static inline int iwl_trans_d3_resume(struct iwl_trans *trans,
 {
 	might_sleep();
 	if (!trans->ops->d3_resume)
-		return 0;
+		return -EOPNOTSUPP;
 
 	return trans->ops->d3_resume(trans, status, test, reset);
 }
-- 
2.38.1

