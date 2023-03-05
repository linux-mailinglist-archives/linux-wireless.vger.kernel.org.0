Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416B26AAF6C
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCEMRo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCEMRm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D0C12875
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018654; x=1709554654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2sy7sKzOityDbmW9OKV9vS/mD/skUJEvakuSRrkz8P8=;
  b=EWuz7tgX9cLeUJIpsTCU5G34BOZd+CZlgW+20QYduaUOS4WNABXI4J7d
   We6KioyupOPlxwIrMQdNqJ5+RoayMliUN3HALiFHb2YzdS8fXMt/Rhs8J
   v22476/uc06aFmx8s9eopTLY6du4xAQGvtcZ/vpG/2vTX7fqumNH++zR/
   AGbHBmKDAzMNRJvPY/tbPAbgxIE9sOm7D7W42Gy/1VywsLsxp+Hkvmmfv
   ThzORC3ySapRLU8W3QiqADpJo4/2TN97UAdAGXYN+CZSTBnbTtYFUXw0n
   ozjv1fFfAvJjAkfbqCuB8Ptki1LgJaR9KCfoFWW3OPhL4QqrnxDAgYYzU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193270"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193270"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355197"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355197"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:32 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/21] wifi: iwlwifi: rs-fw: break out for unsupported bandwidth
Date:   Sun,  5 Mar 2023 14:16:30 +0200
Message-Id: <20230305124407.0264ba9df63b.I6c7c9efc806e0ffb7cb3b6051b2d109646e8708c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230305121635.301451-1-gregory.greenman@intel.com>
References: <20230305121635.301451-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Currently the for loop runs also over unsupported bandwidth in the
command, shorten the path in case we don't support it.

Also use the right macro for setting BW20.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index f30eeab5505b..e3fb1b2cea6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -337,10 +337,14 @@ static void rs_fw_eht_set_enabled_rates(const struct ieee80211_sta *sta,
 		const struct ieee80211_eht_mcs_nss_supp_bw *mcs_tx =
 			rs_fw_rs_mcs2eht_mcs(bw, eht_tx_mcs);
 
-		/* got unsuppored index for bw */
+		/* got unsupported index for bw */
 		if (!mcs_rx || !mcs_tx)
 			continue;
 
+		/* break out if we don't support the bandwidth */
+		if (cmd->max_ch_width < (bw + IWL_TLC_MNG_CH_WIDTH_80MHZ))
+			break;
+
 		rs_fw_set_eht_mcs_nss(cmd->ht_rates, bw,
 				      MAX_NSS_MCS(9, mcs_rx, mcs_tx), GENMASK(9, 0));
 		rs_fw_set_eht_mcs_nss(cmd->ht_rates, bw,
@@ -550,7 +554,7 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	struct iwl_tlc_config_cmd_v4 cfg_cmd = {
 		.sta_id = mvmsta->sta_id,
 		.max_ch_width = update ?
-			rs_fw_bw_from_sta_bw(sta) : RATE_MCS_CHAN_WIDTH_20,
+			rs_fw_bw_from_sta_bw(sta) : IWL_TLC_MNG_CH_WIDTH_20MHZ,
 		.flags = cpu_to_le16(rs_fw_get_config_flags(mvm, sta, sband)),
 		.chains = rs_fw_set_active_chains(iwl_mvm_get_valid_tx_ant(mvm)),
 		.sgi_ch_width_supp = rs_fw_sgi_cw_support(sta),
-- 
2.38.1

