Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FA779E753
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbjIML52 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbjIML50 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:57:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDBA19B0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606243; x=1726142243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CvzUfSNv78pjNKjSfaY6YOpDkJLGWTWfHCICJpoQyeU=;
  b=aHn6r32XWrdqF8ubZIUm1pPiwsxE3uabWvs4G7CSnMArj6Zp5OGsXwqk
   cYYoppgDsrFzEncyET1rxYYI/quLTC7zECrMf0D/v8oA9Ex55l5mo0sDd
   P5Ruse4s1IrqWP7JmX63DDa/Lg1oqBKOUd0r1o2Mt6iAMFjeP2iTOchKQ
   8YTjDSjLulWqpUDCY3stcjBC6L1ytM8EViLYW3MiOwlNBTv6Ur+TsT4XB
   pfWv7s25cZee/Sb53+Oe5t5S6cVAdpU8aUfu1xgNldWLG/JDLVV0XUyml
   WnrLGyA7jmPuvVC2DTdMS2aelEoeuCGYVwA/Sdgg4CltoicdG5AR6wr5a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368903029"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368903029"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470935"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470935"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:14 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: remove dead-code
Date:   Wed, 13 Sep 2023 14:56:40 +0300
Message-Id: <20230913145231.56ff0569d16c.I455839fad0f4f05043815aee884fab9ec7323f7d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

This condition will never be true.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/rs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/rs.c b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
index b09e68dbf5a9..8f99e501629e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
@@ -208,7 +208,6 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 
 		return scnprintf(buf, bufsz, "Legacy | ANT: %s Rate: %s Mbps",
 				 iwl_rs_pretty_ant(ant),
-				 index == IWL_RATE_INVALID ? "BAD" :
 				 iwl_rate_mcs(index)->mbps);
 	}
 
-- 
2.38.1

