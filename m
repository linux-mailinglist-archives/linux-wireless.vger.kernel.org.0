Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734B572CAB9
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjFLPw1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbjFLPwY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:52:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC9010F6
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585142; x=1718121142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1QwlslkwrejgzGVZd+Tc7c5mfVGhH6USQTg0tUOPsCk=;
  b=f4yafAdYyFAuvE+esxGbd/pB9s39aJQgFEpY0taO0KPC/kugIO13gWBr
   4fRlWHUtWbwo2ct2l+vAXN7Cnu7wtkuwosrPa/taWhIhAu+gPb9PGHUvX
   NJmtaOUkDULhjX8UO0TrIzUwSRzxtA/ivO/8UVoqdW+jHoXNmQJW72Qq5
   eJp2mbtHwvidR5UgPtBPylkffHTvHns2xILdKh+lSKWm0RfDQNjRORfJ3
   cgQ1rboUauNAL2zdkCYR+DGMCiOVTdIcOILM1dOR7TkQgsLMDO8ZzLy8b
   SBCuLDKt/25j5IryB02JjdaaEQX3SxyexcuHzSFO1GzHdDS+xT7QlrzXt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674310"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674310"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499435"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499435"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:52:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: Propagate ERP slot changes to FW
Date:   Mon, 12 Jun 2023 18:51:16 +0300
Message-Id: <20230612184434.ef242b8ce245.I01eddee9d3a9a3208499c223eb8e70fe6663f42c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612155116.168000-1-gregory.greenman@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

In AP mode, ERP slot changes weren't properly indicated to the FW.
Fix it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index ff99bf91f931..cb4df8c6f9de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -697,7 +697,11 @@ iwl_mvm_mld_link_info_changed_ap_ibss(struct iwl_mvm *mvm,
 	if (link_conf->he_support)
 		link_changes |= LINK_CONTEXT_MODIFY_HE_PARAMS;
 
-	if (changes & (BSS_CHANGED_ERP_CTS_PROT | BSS_CHANGED_HT |
+	if (changes & BSS_CHANGED_ERP_SLOT)
+		link_changes |= LINK_CONTEXT_MODIFY_RATES_INFO;
+
+	if (changes & (BSS_CHANGED_ERP_CTS_PROT | BSS_CHANGED_ERP_SLOT |
+		       BSS_CHANGED_HT |
 		       BSS_CHANGED_BANDWIDTH | BSS_CHANGED_QOS |
 		       BSS_CHANGED_HE_BSS_COLOR) &&
 		       iwl_mvm_link_changed(mvm, vif, link_conf,
-- 
2.38.1

