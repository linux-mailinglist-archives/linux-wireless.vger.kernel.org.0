Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9B7631554
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 18:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiKTRBj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 12:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiKTRBh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 12:01:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610482EF3B
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 09:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668963697; x=1700499697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d6gNVfjhueUE5h+nRmlojDxwzPFU3ByCW9XzpG4EIns=;
  b=nvw7ELNqZFO/V0nVdBZUrSSn7aHijVYrpU06MNBYYKk6IKHyLBmfFOCA
   Ewx5zztIbkAb2OwLO6Daekniuxh+gm2zOgkQDOkguIYx0YAG6sV3CZNQD
   +163RpT/6XBNvuA4rn0L2dJ64091br3EJEzb/2XmS4O0wlf7hmr31nRvk
   G30D/cLBHvoX82f4PVZ9fU0Lwa6/zIeM0qqv56v2n3TAAoA61h8TpdSBK
   biNvirzY+O+jFxuHhJnlwDKVA0b4Y5He6t3KwlbsG77Dc2kBtj0FzQPVf
   PCzaU7Y0V01tQgCoTTWHlGskoldhnlB8tHJ7AOvBx+uBdIApLomCJnxJO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="315234879"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="315234879"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="765719476"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="765719476"
Received: from dwiener-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.87.2])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:33 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 4/9] wifi: iwlwifi: mvm: add support for EHT 1K aggregation size
Date:   Sun, 20 Nov 2022 19:00:34 +0200
Message-Id: <20221120185147.d82e3d7bf651.Ie4d90c376c822694f4523ff0fb5731f20004c24d@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221120170039.1788067-1-gregory.greenman@intel.com>
References: <20221120170039.1788067-1-gregory.greenman@intel.com>
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
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 9699433137bc..310eb3fde386 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1077,6 +1077,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	static const u8 no_reclaim_cmds[] = {
 		TX_CMD,
 	};
+	u32 max_agg = trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ ?
+			   IEEE80211_MAX_AMPDU_BUF_EHT : IEEE80211_MAX_AMPDU_BUF_HE;
 	size_t scan_size;
 	u32 min_backoff;
 	struct iwl_mvm_csme_conn_info *csme_conn_info __maybe_unused;
@@ -1098,12 +1100,12 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (!hw)
 		return NULL;
 
-	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	hw->max_rx_aggregation_subframes = max_agg;
 
 	if (cfg->max_tx_agg_size)
 		hw->max_tx_aggregation_subframes = cfg->max_tx_agg_size;
 	else
-		hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+		hw->max_tx_aggregation_subframes = max_agg;
 
 	op_mode = hw->priv;
 
-- 
2.35.3

