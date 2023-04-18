Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56416E5D56
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjDRJ2c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjDRJ2b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D578B59E8
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681810110; x=1713346110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3rwhI2BK2AWnoqQ3Cxr3cMa1fK5J8z/qLOzdyO5wz2Q=;
  b=CNgI0O5YOyUm91rj4UZUeE6BcoyJFliRPpuCiGh6nlM/47pZG1zxW8sN
   5bKcjvdDLgIubZz+dXMcMhPek8eqTC+Qy+6XOx/pH1FprQwCqHRPP7W9/
   BuYN7J+hisQVT/mybfTeMPEXKlhYDs2014ugT4SBEmHwHEmILxKqo4LKg
   IpWsSdJ3kVGn4zNbggFBb3vKxZrRB40uC6RkDrmpW04aep4RLWj3S95eo
   qfY/cjaWuXtqkb4SKktwxPYg1VybA1K5YypKi89+t/KTOp+xEjtjEEArm
   RaJ+b7D/UAMb1qbgPE1OnDjEdkSFwxM/gZ/MGVrmyfaFnBXp2KQPs5yxr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410341154"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410341154"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684511208"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684511208"
Received: from kadanh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/11] wifi: iwlwifi: fw: fix memory leak in debugfs
Date:   Tue, 18 Apr 2023 12:28:05 +0300
Message-Id: <20230418122405.239e501b3b8d.I4268f87809ef91209cbcd748eee0863195e70fa2@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230418092814.1438734-1-gregory.greenman@intel.com>
References: <20230418092814.1438734-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Fix a memory leak that occurs when reading the fw_info
file all the way, since we return NULL indicating no
more data, but don't free the status tracking object.

Fixes: 36dfe9ac6e8b ("iwlwifi: dump api version in yaml format")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 43e997283db0..607e07ed2477 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -317,8 +317,10 @@ static void *iwl_dbgfs_fw_info_seq_next(struct seq_file *seq,
 	const struct iwl_fw *fw = priv->fwrt->fw;
 
 	*pos = ++state->pos;
-	if (*pos >= fw->ucode_capa.n_cmd_versions)
+	if (*pos >= fw->ucode_capa.n_cmd_versions) {
+		kfree(state);
 		return NULL;
+	}
 
 	return state;
 }
-- 
2.38.1

