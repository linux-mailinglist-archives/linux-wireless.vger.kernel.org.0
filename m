Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BE17B7C54
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241908AbjJDJh1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242053AbjJDJhZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD9DD
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412238; x=1727948238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mX1UB7wOFXxgXZPqjJzatDR5/UMnKT2f6w9HFe3hT0k=;
  b=ShkPn//+eaD1L3iMGPSFKDK91NyHYX7Kl58sI5csdyJIOoo5qF/bB+Hn
   xpD3eXfQub5hjSMgaHlG6RMLNueihExW5IDbnorR6n63T0zKGgIFCAWv9
   f6Mu3+h3cRJDP4/sVQhcMRFW2vNZWole/Cd+mr7gesNR0lsxQ5cElJrV1
   Vc3eltf1BgFnUxYcsoJYp7nOGO/TUK67HQ5JNlaeW2U5kWUa1LxDZc580
   ZoSnpg7tZEWCj4ypgRYEMKDVctj70HHI41eHUKCCsd/ddEuKUHJVLRWlH
   SUuCq85nmtaHuNeNxbEV97DC+GTMv+bs5+3o0ICEiu0sOCENkSdNe6H+e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611887"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611887"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415201"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415201"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:13 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: fw: Fix debugfs command sending
Date:   Wed,  4 Oct 2023 12:36:32 +0300
Message-Id: <20231004123422.4f80ac90658a.Ia1dfa1195c919f3002fe08db3eefbd2bfa921bbf@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004093634.131303-1-gregory.greenman@intel.com>
References: <20231004093634.131303-1-gregory.greenman@intel.com>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

During debugfs command handling transport function is used directly,
this bypasses the locking used by runtime operation function
and leads to a kernel warning when two commands are
sent in parallel.

Fix it by using runtime operations function when sending
debugfs command.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index b8d4a4d571e7..751a125a1566 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -141,7 +141,11 @@ static int iwl_dbgfs_enabled_severities_write(struct iwl_fw_runtime *fwrt,
 
 	event_cfg.enabled_severities = cpu_to_le32(enabled_severities);
 
-	ret = iwl_trans_send_cmd(fwrt->trans, &hcmd);
+	if (fwrt->ops && fwrt->ops->send_hcmd)
+		ret = fwrt->ops->send_hcmd(fwrt->ops_ctx, &hcmd);
+	else
+		ret = -EPERM;
+
 	IWL_INFO(fwrt,
 		 "sent host event cfg with enabled_severities: %u, ret: %d\n",
 		 enabled_severities, ret);
-- 
2.38.1

