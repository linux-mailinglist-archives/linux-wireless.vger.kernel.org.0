Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC1A6FA22F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjEHIZ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjEHIZX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:25:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433F619D5C
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534319; x=1715070319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cMwx1kn3P5ygp/EMddgaSnCrovvvDEhJtvgZP5XBy4Y=;
  b=hYqc2vRPBkwV2tIXgctCqdHnGZdQb542PnzwlvfEy5m1fNXVouzeCyGq
   pg0/ibmCfunkHtA96ohtW6fIz0g2655BBxlBAQoQRExVuED8KXtbOiz1C
   oHJX4gi+6XG814u1Uyq126n+tbNJ3DkayzD7j9ivGz+LQgPq5gCYH1oO8
   QqETdb2YkLpfAYQeitoQtQYAvAM1D3cL9/biaJuuY7FkjSKjyJU+Q9qQI
   KDL8/OAQarPUaE/hbOaM2AOuQe/ajofukrozBJPZUa14km9jheqvYLWrv
   63GIJLwR5ol5hTHcykNLhMMuKOTGzFsZIBXnELjo22/5+oCJUCN1mNcsI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329949935"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329949935"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767982691"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767982691"
Received: from shemert-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.224.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:11 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/14] wifi: iwlwifi: pass the esr_transition_timeout to the firmware
Date:   Mon,  8 May 2023 11:24:33 +0300
Message-Id: <20230508082433.1349733-15-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508082433.1349733-1-gregory.greenman@intel.com>
References: <20230508082433.1349733-1-gregory.greenman@intel.com>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware needs to know the esr_transtition_timeout to time the
transition between EMLSR and single radio with the AP.
Add the EMLSR support bit to the wiphy extended capabilities so that
it'll be sent in our association request frame.
We can set this field unconditionally since it'll be used only if the
MLO is supported.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 2ae665ba2ac9..c9c072a3c832 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -251,6 +251,8 @@ static const struct wiphy_iftype_ext_capab add_iftypes_ext_capa[] = {
 		.extended_capabilities = he_if_types_ext_capa_sta,
 		.extended_capabilities_mask = he_if_types_ext_capa_sta,
 		.extended_capabilities_len = sizeof(he_if_types_ext_capa_sta),
+		/* relevant only if EHT is supported */
+		.eml_capabilities = IEEE80211_EML_CAP_EMLSR_SUPP,
 	},
 	{
 		.iftype = NL80211_IFTYPE_STATION,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index 99bf71a2b690..f55b08d9642f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -133,6 +133,9 @@ static int iwl_mvm_mld_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 	}
 
 	cmd.client.assoc_id = cpu_to_le16(vif->cfg.aid);
+	cmd.client.esr_transition_timeout =
+		u16_get_bits(vif->cfg.eml_cap,
+			     IEEE80211_EML_CAP_TRANSITION_TIMEOUT);
 
 	if (vif->probe_req_reg && vif->cfg.assoc && vif->p2p)
 		cmd.filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_PROBE_REQ);
-- 
2.38.1

