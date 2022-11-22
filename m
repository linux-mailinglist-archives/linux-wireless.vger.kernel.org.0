Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AE1634547
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 21:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiKVULe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 15:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiKVULb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 15:11:31 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7726B10CC
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 12:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669147888; x=1700683888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o6SpBYF/Q7KMARd5pNZVhxJkz/hqK/mlME/kuROYC14=;
  b=lDZz6Ud7vhhw2k6+/F9z7EgqqV5fHhIG3K1y4b3w1759LyImMjvPqfBQ
   AfVX93weSfVc1wo5y5x71PUpFqOpPNnjdlH4QjbicEpjXv4OyofBmrS23
   /0xwGW2I4682ypJL55zXTFJIQfwpKY8P0XFHXD7T8IONOXgvv+UkPlSQ9
   mT3ivJ6rKZpLqrHLbsjEXPDTrazQ29a9RdvkN7647M+eoNqmaf0A4fLEp
   D/uxvGyMEIEF0om6eu20J+Y0Zr2gWt2UvtDwqJZnfeskExIRdba+2lq4M
   BMrD2D7A98rJuJVzasQBenfg4mojb2b+PxMufnZkjQsTTZwbN4JoBKxft
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="378163472"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="378163472"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:11:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747487033"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="747487033"
Received: from mkoshili-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.209.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:11:26 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 4/9] wifi: iwlwifi: mvm: add support for EHT 1K aggregation size
Date:   Tue, 22 Nov 2022 22:10:35 +0200
Message-Id: <20221122220713.ef0431f64975.Ie4d90c376c822694f4523ff0fb5731f20004c24d@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221122201040.2618863-1-gregory.greenman@intel.com>
References: <20221122201040.2618863-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In 11be we can receive 1K aggregation size so update our max HW rx
aggregation for mac80211 usage.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 9699433137bc..2a4db13c9dcf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1077,6 +1077,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	static const u8 no_reclaim_cmds[] = {
 		TX_CMD,
 	};
+	u32 max_agg;
 	size_t scan_size;
 	u32 min_backoff;
 	struct iwl_mvm_csme_conn_info *csme_conn_info __maybe_unused;
@@ -1098,12 +1099,17 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (!hw)
 		return NULL;
 
-	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		max_agg = IEEE80211_MAX_AMPDU_BUF_EHT;
+	else
+		max_agg = IEEE80211_MAX_AMPDU_BUF_HE;
+
+	hw->max_rx_aggregation_subframes = max_agg;
 
 	if (cfg->max_tx_agg_size)
 		hw->max_tx_aggregation_subframes = cfg->max_tx_agg_size;
 	else
-		hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+		hw->max_tx_aggregation_subframes = max_agg;
 
 	op_mode = hw->priv;
 
-- 
2.35.3

