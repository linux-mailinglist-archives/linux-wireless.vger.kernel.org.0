Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800596CD294
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjC2HHy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjC2HHu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469840C3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073648; x=1711609648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kUwXX+C0ssDAQMmJ2Cb06PGyQvVyIkfoDN66xnwjV5Q=;
  b=ZhC+9BntlI+SwkcqajsGyEq1SYmudGQu8iMaE40InpYNjPN2xCEnSDp0
   Mk5NRPo8GwYQ6n2/EvGZUe8KawmqgOVaFcWNLRaThziuuXhuJb96rBPeC
   QltbbA9NlmzOU6PuSq9CoA+PdEuYVKdSyrihAYiu7nGUPzg9+YtdUygAn
   Fr6GdpX/d+1y1jpfhgbJop7vuOomMvVir3KREjTjxcIis0KRCa2w0mxXg
   Fwil82h7lKwfNLKRdmoyhRZUZbUkQ6pGNtbBLQW8g5yxv8/4LXkkf/VpX
   nR4MtYR12fWfSWsQoVK2l6U5aKOtdtod8IdJo5Ov/NZRHl4Sulg7RQQUS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450860"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450860"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111350"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111350"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:30 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 19/34] wifi: iwlwifi: mvm: avoid sending MAC context for idle
Date:   Wed, 29 Mar 2023 10:05:25 +0300
Message-Id: <20230329100039.f5218f8453ec.I1325ff14ec07a27dd7ea2c1c210a1721d969839f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we change only idle, avoid sending the MAC context
command since it doesn't depend on idle state. This
also fixes an issue with the firmware because without
this we send the command during link switching, as we
just deactivated the first link, and we cannot send
this command when there's no active link.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 1a97bf925817..8ed76fc83702 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -563,6 +563,12 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 	unsigned int i;
 	int ret;
 
+	/* This might get called without active links during the
+	 * chanctx switch, but we don't care about it anyway.
+	 */
+	if (changes == BSS_CHANGED_IDLE)
+		return;
+
 	ret = iwl_mvm_mld_mac_ctxt_changed(mvm, vif, false);
 	if (ret)
 		IWL_ERR(mvm, "failed to update MAC %pM\n", vif->addr);
-- 
2.38.1

