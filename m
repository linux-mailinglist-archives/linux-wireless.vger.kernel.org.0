Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6937B6B9D98
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCNRyd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCNRyc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:54:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE7DBE6
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816460; x=1710352460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zNZPIi+EZFXjVxrHicad7epaBEgTYXrhlg5PCaE1nLY=;
  b=Gqkj2kyu01cp55efEAd6fFIrM78RQVMF/xSqRxBcubt8JzXKVaB1kWeg
   uP5jgNNMGcq7toaQZZnKjRsWmSmhHczCu1z9O1iU/TzTxDHh9FuBm+020
   srnpoeITb5S0r7srg5OdzUJ02etgzgm/IUfj4pN+Yg2v0GvEaUPo3BMil
   vstZ7ptM3VAcviitxmadzYgXa6k+HGsx3bIPXP+SiEMTMdMcnS2NAoxsp
   oxX1CmfpCjwGZuAaFG88zHySKglSYS2lVvjgwNllyRReDNfWVOWSH8M8q
   BQjhM1o6FapdtR9OWYrjWy55Td+GhzkdMSkAN3876FPz/w90OzshjecJU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149706"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149706"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200584"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200584"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Solomon Tan <solomonbstoner@protonmail.ch>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/22] wifi: iwlwifi: Add required space before open '('
Date:   Tue, 14 Mar 2023 19:49:30 +0200
Message-Id: <20230314194113.a21ba1967d94.Iaa52fc6517ea9efb3efc7b1b98f4df2a288de1c3@changeid>
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

From: Solomon Tan <solomonbstoner@protonmail.ch>

This patch addresses the error from checkpatch.pl that a space is
required before an open parenthesis.

Signed-off-by: Solomon Tan <solomonbstoner@protonmail.ch>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 3e9e9f13506b..fe7dfdcd531b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1037,7 +1037,7 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 
 	ret = iwl_read_ppag_table(&mvm->fwrt, &cmd, &cmd_size);
 	/* Not supporting PPAG table is a valid scenario */
-	if(ret < 0)
+	if (ret < 0)
 		return 0;
 
 	IWL_DEBUG_RADIO(mvm, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
-- 
2.38.1

