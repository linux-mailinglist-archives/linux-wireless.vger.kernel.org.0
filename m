Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410B16CD2A0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjC2HIp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjC2HIm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EB13ABB
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073707; x=1711609707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O2WCSVtPbJiKIjVuLMEAdNGe6zP7h/cVgVcbag/PfAk=;
  b=HqLGV3DxpohF3nWVQopcOD1S0vf+auFJqjWDhvnM2ZhPVWxvG1FimLVj
   WRFWgfvObntsV7pVhA3Ra1h+wcq0c37JHDOxPurx/AuAktoo8zYseQHmz
   E0coB6EY9VynwVzCjyqPul5/HlnCGXMaO5xCByVRofHPvZY8liRv6H8yr
   dmzK6pwgo6lz2ea04vgd8sLgnc+ad/acLjUWIcv+MPsZFepHxtpZKtee6
   7j2OKQRl66t/SxWEhIG1ldpYSMAOHbFw89m+gWQZfxFuvg8nHvYr3Wm/f
   R1gAblEHOqjkXB+8nZx8JXZibYYzJrdpOw4PWWNY3rHj1gdHrjkiOFVTb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320451015"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320451015"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111505"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111505"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:52 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 30/34] wifi: iwlwifi: mvm: move max_agg_bufsize into host TLC lq_sta
Date:   Wed, 29 Mar 2023 10:05:36 +0300
Message-Id: <20230329100040.d55361064e39.Ib79d30f27d94607d097f0192af2aacd455a17958@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

This field is used only for host TLC, so it can reside inside
the corresponding lq_sta struct. Also, TLC lq_sta is cleared
in iwl_mvm_rs_rate_init() upon association, but max_agg_bufsize
is set earlier in iwl_mvm_sta_init(). Thus, place this field
in the persistent part of lq_sta to retain its value.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h  |  6 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 11 ++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h |  2 --
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 161a32929848..ab82965bc0f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3607,7 +3607,7 @@ static void rs_fill_lq_cmd(struct iwl_mvm *mvm,
 	    num_of_ant(initial_rate->ant) == 1)
 		lq_cmd->single_stream_ant_msk = initial_rate->ant;
 
-	lq_cmd->agg_frame_cnt_limit = mvmsta->max_agg_bufsize;
+	lq_cmd->agg_frame_cnt_limit = lq_sta->pers.max_agg_bufsize;
 
 	/*
 	 * In case of low latency, tell the firmware to leave a frame in the
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index c3145cb8f354..f99603b0f693 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -1,10 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
- * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2003 - 2014, 2018 - 2022 Intel Corporation
  *****************************************************************************/
 
 #ifndef __rs_h__
@@ -204,6 +203,7 @@ struct rs_rate {
 /**
  * struct iwl_lq_sta_rs_fw - rate and related statistics for RS in FW
  * @last_rate_n_flags: last rate reported by FW
+ * @max_agg_bufsize: the maximal size of the AGG buffer for this station
  * @sta_id: the id of the station
 #ifdef CONFIG_MAC80211_DEBUGFS
  * @dbg_fixed_rate: for debug, use fixed rate if not 0
@@ -353,6 +353,7 @@ struct iwl_lq_sta {
 
 	/* last tx rate_n_flags */
 	u32 last_rate_n_flags;
+
 	/* packets destined for this STA are aggregated */
 	u8 is_agg;
 
@@ -371,6 +372,7 @@ struct iwl_lq_sta {
 		u8 chains;
 		s8 chain_signal[IEEE80211_MAX_CHAINS];
 		s8 last_rssi;
+		u16 max_agg_bufsize;
 		struct rs_rate_stats tx_stats[RS_COLUMN_COUNT][IWL_RATE_COUNT];
 		struct iwl_mvm *drv;
 		spinlock_t lock; /* for races in reinit/update table */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 9a3a7eabded8..db6a3419bd31 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1719,10 +1719,10 @@ int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		rcu_assign_pointer(mvm_sta->link[0], &mvm_sta->deflink);
 
 		if (!mvm->trans->trans_cfg->gen2)
-			mvm_sta->max_agg_bufsize =
+			mvm_sta->deflink.lq_sta.rs_drv.pers.max_agg_bufsize =
 				LINK_QUAL_AGG_FRAME_LIMIT_DEF;
 		else
-			mvm_sta->max_agg_bufsize =
+			mvm_sta->deflink.lq_sta.rs_drv.pers.max_agg_bufsize =
 				LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF;
 	}
 
@@ -3258,10 +3258,11 @@ int iwl_mvm_sta_tx_agg_oper(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * for each station. Therefore, use the minimum of all the
 	 * aggregation sessions and our default value.
 	 */
-	mvmsta->max_agg_bufsize =
-		min(mvmsta->max_agg_bufsize, buf_size);
+	mvmsta->deflink.lq_sta.rs_drv.pers.max_agg_bufsize =
+		min(mvmsta->deflink.lq_sta.rs_drv.pers.max_agg_bufsize,
+		    buf_size);
 	mvmsta->deflink.lq_sta.rs_drv.lq.agg_frame_cnt_limit =
-		mvmsta->max_agg_bufsize;
+		mvmsta->deflink.lq_sta.rs_drv.pers.max_agg_bufsize;
 
 	IWL_DEBUG_HT(mvm, "Tx aggregation enabled on ra = %pM tid = %d\n",
 		     sta->addr, tid);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 824d12047019..625e1dfd47a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -355,7 +355,6 @@ struct iwl_mvm_link_sta {
  * @mac_id_n_color: the MAC context this station is linked to
  * @tid_disable_agg: bitmap: if bit(tid) is set, the fw won't send ampdus for
  *	tid.
- * @max_agg_bufsize: the maximal size of the AGG buffer for this station
  * @sta_type: station type
  * @sta_state: station state according to enum %ieee80211_sta_state
  * @bt_reduced_txpower: is reduced tx power enabled for this station
@@ -406,7 +405,6 @@ struct iwl_mvm_sta {
 	u32 tfd_queue_msk;
 	u32 mac_id_n_color;
 	u16 tid_disable_agg;
-	u16 max_agg_bufsize;
 	u8 sta_type;
 	enum ieee80211_sta_state sta_state;
 	bool bt_reduced_txpower;
-- 
2.38.1

