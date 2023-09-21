Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D297A9DA6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjIUTn6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjIUTnl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:43:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B74C76BE
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318632; x=1726854632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a7CqduE05xO8qh1k5tSlX+IKpKRwG8L6cqNSryhsu3s=;
  b=AGJAYaFP9z0aPqO6suCxeYdOaaSnhsfSszZdhPie3F6+PyQJmIfFMj72
   hipkbqS5UBm5nruLT2JroYxl9SdXcoDuoaThBRJ6AIlTCVnj/BRn7zPPO
   5/WYtZUyyrpK81LZRk9rWCwIaG5FFjs1PcOrKJQoOPw2ADpF2epzYYGhI
   HAsGcPnAb98+9XCaKQ2v0/+J1sQHR2+IUuHugA2nhvONvZuhVa/TRUZ2z
   xs9iDYT+awHwmDzTH1W5LB7xDuf4WXzdBX5suJjneFR5YTMujbcjDOt/J
   5+sLlfSirscVG3958IfQtXuNV8GceOaATo9lSQouK49h5gdk75pbUolyz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384305375"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384305375"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740545577"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740545577"
Received: from rchuwer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.229.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:58 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/12] wifi: iwlwifi: fail NIC access fast on dead NIC
Date:   Thu, 21 Sep 2023 11:58:05 +0300
Message-Id: <20230921110726.f3d8498c5a60.I5d0c442a731ca4c00716910d215b4bcde6963a65@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230921085810.693048-1-gregory.greenman@intel.com>
References: <20230921085810.693048-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the NIC is already dead, as detected by the transport then
there's no point to try to grab the NIC access and time out,
we can just fail fast. This may speed up recovery.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 5020ae4493c6..385e152f04fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2177,6 +2177,9 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 		   CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP;
 	u32 poll = CSR_GP_CNTRL_REG_VAL_MAC_ACCESS_EN;
 
+	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
+		return false;
+
 	spin_lock(&trans_pcie->reg_lock);
 
 	if (trans_pcie->cmd_hold_nic_awake)
-- 
2.38.1

