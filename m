Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9277CBEC6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjJQJRf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjJQJRd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDECFB
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534251; x=1729070251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3qzVT5oIfZ44dbUYJSI1X7CaeoNzwsxLWjD/B7udzho=;
  b=jMI31NeuWu7hzO2UXcVuVU6x9ALRQLkeHPDkwPbUUfD5uuTkl3fX5kQI
   Uonkzbt8OPtCa+bjbPs7gRI7NvUDJ8bxzQzQjssxCmtQsOYxUlzTo170o
   eNzfKjtobtKVwgdLaQdpmvnwZZUtjgej30+56KPenEBuR+3u/XpCTosXT
   v9Aa7p5kZGEXpR6gPbPKQcbWEb2QuqRiufFTDQfbtb6WRNO0FKSAkBw4k
   PzBqSRM9Jlr/RCk/dPOepczeLFHUh6aRkemaG8Egv3u4RlkuNL9DmFsEy
   3pc1CecyNeE/Xe92cup+OdNIyA9db+VXg8gZaQHhbWqTrzj4/BZkt9Set
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808566"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808566"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731964"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731964"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/14] wifi: iwlwifi: mvm: update IGTK in mvmvif upon D3 resume
Date:   Tue, 17 Oct 2023 12:16:48 +0300
Message-Id: <20231017115047.8ceaf7e5ece7.Ief444f6a2703ed76648b4d414f12bb4130bab36e@changeid>
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

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

During the D3 resume flow, all new rekeys are passed from the FW.
Because the FW supports only one IGTK at a time, every IGTK rekey
update should be done by removing the last IGTK. The mvmvif holds a
pointer to the last IGTK for that reason and thus should be updated
when a new IGTK is passed upon resume.

Fixes: 04f78e242fff ("wifi: iwlwifi: mvm: Add support for IGTK in D3 resume flow")
Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index ffb1fdd7ee32..46ee280231ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2031,6 +2031,16 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
 	if (IS_ERR(key_config))
 		return false;
 	ieee80211_set_key_rx_seq(key_config, 0, &seq);
+
+	if (key_config->keyidx == 4 || key_config->keyidx == 5) {
+		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+		int link_id = vif->active_links ? __ffs(vif->active_links) : 0;
+		struct iwl_mvm_vif_link_info *mvm_link =
+			mvmvif->link[link_id];
+
+		mvm_link->igtk = key_config;
+	}
+
 	return true;
 }
 
-- 
2.38.1

