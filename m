Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64656CB8DF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 09:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjC1H7g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 03:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjC1H7e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 03:59:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2B40CA
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990372; x=1711526372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wui1weOVzkyYD19Sz8declapxUl0QrklwqM/EXkm8rA=;
  b=KZyRJS5Gv1krVzkYk7K+Oj8EQ7/55L7qhgBCKgoQIeQo5LzBbR/w5hMk
   /3uStvO+srpn+krp/ecHfe49UBzWEc6axCrq6XjkvIWM09ZX2BCW+0t4H
   hBFDIJSagoXodpfpbvd8nwpT4UuV1wQV+7WCbj+5dDcxhV4c9Y9YjVRfp
   L4QT0pgWvMHOdlUmsWeT5Zkz+LeOWQ59plA4Z5OjaOcJFHPu5ZJc/3FiD
   6GIFPkJ1c2Nj9oZEK2y1iaWQrpOg8Km3fQno0FAm4u12+ATzsjIQMo/U3
   29YsXyIclJRokDNKUPPxrCUVREN0CypYTFCgCBATnGnrR0jlzVnx8uwWo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958052"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958052"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045108"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045108"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:30 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/31] wifi: iwlwifi: mvm: add an indication that the new MLD API is used
Date:   Tue, 28 Mar 2023 10:58:43 +0300
Message-Id: <20230328104948.5756b0907403.I0adce36d1783cce23d0e080e3c4a8953db33b515@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

WE can't mix between the new MLD API and the old API.
I.e. - we can't send one of the new cmds and then one of the old ones.
This will cause a FW assert. So we need an indication what API should be
used. We use the new API if:
1. FW supports it
2. We are registered to mac80211 with the new MLD ops
Add an indication which will only be true if both conditions are true.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 72056cccc77e..443f0b80b63e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1155,6 +1155,7 @@ struct iwl_mvm {
 	unsigned long last_reset_or_resume_time_jiffies;
 
 	bool sta_remove_requires_queue_remove;
+	bool mld_api_is_used;
 
 	bool pldr_sync;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 70926bb1df6c..5c8784ddfa66 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1295,6 +1295,9 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	mvm->sta_remove_requires_queue_remove =
 		trans_cfg.queue_alloc_cmd_ver > 0;
 
+	/* Until we register with the MLD ops - we don't use the MLD API */
+	mvm->mld_api_is_used = false;
+
 	/* Configure transport layer */
 	iwl_trans_configure(mvm->trans, &trans_cfg);
 
-- 
2.38.1

