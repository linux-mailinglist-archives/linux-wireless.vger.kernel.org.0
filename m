Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AEA7CBEC4
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjJQJRa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343508AbjJQJR1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7246EB0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534245; x=1729070245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YjDBcJ9lxtjmWAl5dbvTFGrgMYaSpW5zBbg7zkYOezo=;
  b=Ae+qmfvt0KBKLqoWhjlpag9LbP/iCsjIv099Ef+mOUc1sIElHzxXQQ3l
   ZfqonVlMeN6uP38lvgJPn3y4l4TCmehEA9qocV2oRcNhpRC9i8wg2xzg/
   6BiCHbginpMQZ++ufTw7GYnk2F7Di9Alce5PPnp45BjEHstkbARN2cbgV
   r6Df5FPy7yGhLUb7J7rti7xYmreeEkmLTxMT7BQ7wkaojyhsheTUTYk4B
   QyCIxTVpSLY3RezRQxrZg4MQ9EuPeNk0UAX8u7ZU9gEzl5k4MxpfExBw8
   /wbLEK06GXRrxtHuF7gjHOe03Ovtj4XOso2Kgasr07jFPaJsUdpGfhEAW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808557"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808557"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731945"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731945"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:22 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/14] wifi: iwlwifi: mvm: Return success if link could not be removed
Date:   Tue, 17 Oct 2023 12:16:45 +0300
Message-Id: <20231017115047.f89bc05aadf6.Idc8fbd671362d962c02b1df87fa6258733631580@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231017091649.65090-1-gregory.greenman@intel.com>
References: <20231017091649.65090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

iwl_mvm_remove_link would return an error if the link could not be
removed. However, doing so prevents recovery if a link was not uploaded
to the FW in the first place and the link_info was not allocated or
fw_link_id is not set.

Returning success means that we can still try to continue with adding
new links in change_vif_links.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index c3831440a019..be48b0fc9cb6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -242,9 +242,10 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_link_config_cmd cmd = {};
 	int ret;
 
+	/* mac80211 thought we have the link, but it was never configured */
 	if (WARN_ON(!link_info ||
 		    link_info->fw_link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf)))
-		return -EINVAL;
+		return 0;
 
 	RCU_INIT_POINTER(mvm->link_id_to_link_conf[link_info->fw_link_id],
 			 NULL);
-- 
2.38.1

