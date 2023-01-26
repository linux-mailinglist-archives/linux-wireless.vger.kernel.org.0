Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC3B67D885
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 23:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjAZWgi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 17:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjAZWgg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:36 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305B428D3F
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772591; x=1706308591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EAlsSsLB0FPgaK/RkGLdRnXMAa/FSc3D1M/TioHjOTA=;
  b=BFpHIcdzzI578b0hpTswPIhxwHCty8MWA4YsN5S5dWrQC88cao2xeFIy
   2X6wiDRGDgPkFUccsnaLWlbJyzf5Ra/pg54RXrZlfR0wmuY8B3SMLYJ37
   DSPycMMqGI5viTu6cR3qJl8DilM0MlUtTju9ocYfkn7G7AZiTPEfWFZuR
   e60u9zHW1t1zBvPeFcxY6bOOqNc2o5rU+G6Fa9/iBb1w3HlVOc2buXkFK
   Y2GLOOXl6Kx9eD07+81EXSp2cEAus99DrK2l6MhEqQeLj5v4GtHXCQYBg
   JWLofnJXYxnNAhbnKNxwAqvh/5057ISohBcLVYo/rgDbU+wYiq3myKSiT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329098602"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329098602"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612986210"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="612986210"
Received: from razgilad-mobl7.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.211.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:03 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/12] wifi: iwlwifi: mention the response structure in the kerneldoc
Date:   Fri, 27 Jan 2023 00:28:11 +0200
Message-Id: <20230127002430.422c9fbac12c.I2da0954d1c62007b5f01faf06df3e4081e52204f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230126222821.305122-1-gregory.greenman@intel.com>
References: <20230126222821.305122-1-gregory.greenman@intel.com>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Add a comment to mention the structure used for the response for the
flush command.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 8d83985aeabe..bbfb44be099e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -153,6 +153,7 @@ enum iwl_legacy_cmds {
 
 	/**
 	 * @TXPATH_FLUSH: &struct iwl_tx_path_flush_cmd
+	 *	response in &struct iwl_tx_path_flush_cmd_rsp
 	 */
 	TXPATH_FLUSH = 0x1e,
 
-- 
2.38.1

