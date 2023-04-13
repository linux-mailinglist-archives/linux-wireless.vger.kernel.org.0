Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2B6E144A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDMSln (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDMSll (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:41:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6606599
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411299; x=1712947299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y+WRHwzUYy8l9NwU2ZzcfEnK0VJ2A+uhegmWj6dS7mc=;
  b=IEz7QwjUIUrZwYPAqxpPPcWP1ruavEVT1SI9rhPBRNw9CZvfe5NktSxC
   Uv0pGyC/dXprtts0rlX11LzcCcJ7AodVjU0Hz+h6UEfK2x5RwtQW+uBc4
   n4xii+xp4BySBEos3sQ05fYZYrbvmFvgsKeZhcJxVVzm344GCwAAxwrTh
   z+uFC4QfabR8ttTMS5ypxj3LZ1bGTBWDqjHcG35AIJTIcEhKHQEgsTxaF
   jEtYS02lrIGiAv2u3rQxJbJ2h/F63L2e9SpSZ6Qr3Kojxoxwdiy9oD6El
   RvUFToNSHxKrE76+Lscm1u9k2Gux6x/QEAPTAtLKBN3dpqkS7re59B6ZN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372127037"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372127037"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984355"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984355"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:07 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: mvm: cleanup beacon_inject_active during hw restart
Date:   Thu, 13 Apr 2023 21:40:28 +0300
Message-Id: <20230413213309.b021bce5e162.Ia5a0a0b5d8734f63077ceaac936176a345f8d3d1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413184035.1140892-1-gregory.greenman@intel.com>
References: <20230413184035.1140892-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

beacon_inject_active turns true and false via debugfs when we inject a
beacon. During the time of the beacon injection we can't configure the
FW with a beacon cmd. If we have a hw restart during the beacon injection
then in the recovery flow we will not be able to configure the beacon
cmd to the FW. Fix this by cleaning up this variable after an hw restart.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ac5c4799fa7e..d6f29aa2a66f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1065,6 +1065,9 @@ static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 	mvm->rx_ba_sessions = 0;
 	mvm->fwrt.dump.conf = FW_DBG_INVALID;
 	mvm->monitor_on = false;
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	mvm->beacon_inject_active = false;
+#endif
 
 	/* keep statistics ticking */
 	iwl_mvm_accu_radio_stats(mvm);
-- 
2.38.1

