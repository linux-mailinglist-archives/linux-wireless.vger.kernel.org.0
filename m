Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A2170FCFC
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjEXRp5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjEXRpx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 13:45:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1BE122
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950317; x=1716486317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GdnDifGCq605v24mSJbVHN2idq5dUI+5r+hWnGkWoXQ=;
  b=U/4t0VPBNgF0O7Y46zennTOGMHaQ5Ugh/nXuLQWkWP+f7yO3L4tMnIUC
   4WK5p50qd0ZimboPUyoPd9sMGu+Sto4PRpN8KYtKygVnVd7RRMrd/Rxwa
   wXp9Lz2q1EhYlj8Fe1POnLV6JUCvhhZCzTHBiOFzrBLCsL1teBqjq5XZ4
   DIh0wKHE3hYb3W/jfPhZo11xfF3NLKNuU+2lYbRIO6ikL8e0zis7JvUPn
   BNhC9r4qLMaXIsqGiKPAAsrDGy19566ODqRMg1MNAIKO6OFPGqvGW+NRt
   oONFq1H28ZqxjIPzO2IpPQDg7hsgNO/Bek9BXHnhfz0V/JHAP3xybi9c/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440000404"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="440000404"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769547925"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769547925"
Received: from hmozes-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.89.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:46 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/14] wifi: iwlwifi: don't silently ignore missing suspend or resume ops
Date:   Wed, 24 May 2023 20:42:03 +0300
Message-Id: <20230524203151.0c55e0ca92f1.I6870fe1683215e65d3d036f9b576b03b7b7257be@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524174211.1482360-1-gregory.greenman@intel.com>
References: <20230524174211.1482360-1-gregory.greenman@intel.com>
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

