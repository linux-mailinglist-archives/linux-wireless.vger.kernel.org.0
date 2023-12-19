Return-Path: <linux-wireless+bounces-1040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A3E819129
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 21:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA42728717F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2F3C46D;
	Tue, 19 Dec 2023 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ex1E6FIF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F993C068
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703016000; x=1734552000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lEyT9XudBa09mjLleIm6mXtUDigywoaHeJAT1HS4N2E=;
  b=Ex1E6FIFC7JVGdfauA4uXkhsvOVYnDIK9DeJR8VpCqTzhVtLoQjO8ip3
   OxJ9msSB9vsjCUFB5tlBUND783rCd2v4NZSjoza9dHaWYY71ixyAV4/KR
   TPU0KjHiCbAIXUzC+ZeJ8oMkZMuV3VbYx5/GiPytOi0zcU3qS9KSX5FtO
   KB8pR9oeDJtpGaHFQAJ/wmK1aMYSf+A8UgtfOrLv/bMnrF5EKHBt8Pabh
   AUyF5Now0mbHGygKRokQ20ojoRhiYPjqUKh8ctrNKR58ZPE5wCIWbg0uo
   WQanliPrSg+VgYVc6DQdwn8EyYA5zjcySDFmSaJkbbc7Q5SQ29hH1fuuA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380694985"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380694985"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 12:00:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779589164"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779589164"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/14] wifi: iwlwifi: replace ENOTSUPP with EOPNOTSUPP
Date: Tue, 19 Dec 2023 21:59:02 +0200
Message-Id: <20231219215605.a69f4347b5f8.I88429d5de8251287ec0b58ff26a588465b9049a5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
References: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

ENOTSUPP isn't a standard error code, don't use it. Replace with
EOPNOTSUPP instead.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h         | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c           | 4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index ef7dc0a7b56c..5789a8735976 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1316,7 +1316,7 @@ iwl_trans_get_rxq_dma_data(struct iwl_trans *trans, int queue,
 			   struct iwl_trans_rxq_dma_data *data)
 {
 	if (WARN_ON_ONCE(!trans->ops->rxq_dma_data))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	return trans->ops->rxq_dma_data(trans, queue, data);
 }
@@ -1338,7 +1338,7 @@ iwl_trans_txq_alloc(struct iwl_trans *trans,
 	might_sleep();
 
 	if (WARN_ON_ONCE(!trans->ops->txq_alloc))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
 		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
@@ -1404,7 +1404,7 @@ static inline int iwl_trans_wait_tx_queues_empty(struct iwl_trans *trans,
 						 u32 txqs)
 {
 	if (WARN_ON_ONCE(!trans->ops->wait_tx_queues_empty))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/* No need to wait if the firmware is not alive */
 	if (trans->state != IWL_TRANS_FW_ALIVE) {
@@ -1418,7 +1418,7 @@ static inline int iwl_trans_wait_tx_queues_empty(struct iwl_trans *trans,
 static inline int iwl_trans_wait_txq_empty(struct iwl_trans *trans, int queue)
 {
 	if (WARN_ON_ONCE(!trans->ops->wait_txq_empty))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
 		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 16a104de8371..edc8204f7c0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1521,7 +1521,7 @@ static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mvm *mvm,
 
 	/* supporting only MQ RX */
 	if (!mvm->trans->trans_cfg->mq_rx_supported)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	rxb._page = alloc_pages(GFP_ATOMIC, 0);
 	if (!rxb._page)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 10b9219b3bfd..8f10590f9cdd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -39,7 +39,7 @@ static int iwl_mvm_ftm_responder_set_bw_v1(struct cfg80211_chan_def *chandef,
 		*ctrl_ch_position = iwl_mvm_get_ctrl_pos(chandef);
 		break;
 	default:
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -77,7 +77,7 @@ static int iwl_mvm_ftm_responder_set_bw_v2(struct cfg80211_chan_def *chandef,
 		}
 		fallthrough;
 	default:
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -291,7 +291,7 @@ iwl_mvm_ftm_responder_dyn_cfg_cmd(struct iwl_mvm *mvm,
 	default:
 		IWL_ERR(mvm, "Unsupported DYN_CONFIG_CMD version %u\n",
 			cmd_ver);
-		ret = -ENOTSUPP;
+		ret = -EOPNOTSUPP;
 	}
 
 	return ret;
@@ -333,7 +333,7 @@ int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 
 	if (cmd_ver < 3) {
 		IWL_ERR(mvm, "Adding PASN station not supported by FW\n");
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if ((!hltk || !hltk_len) && (!tk || !tk_len)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5276df717ca1..7f13dff04b26 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -298,7 +298,7 @@ int iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	/* This has been tested on those devices only */
 	if (mvm->trans->trans_cfg->device_family != IWL_DEVICE_FAMILY_9000 &&
 	    mvm->trans->trans_cfg->device_family != IWL_DEVICE_FAMILY_22000)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (!mvm->nvm_data)
 		return -EBUSY;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index efe3e111ea0a..2a3ca9785974 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2550,7 +2550,7 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	if (WARN_ON(vif->type != NL80211_IFTYPE_AP &&
 		    vif->type != NL80211_IFTYPE_ADHOC))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/*
 	 * In IBSS, ieee80211_check_queues() sets the cab_queue to be
@@ -3234,7 +3234,7 @@ int iwl_mvm_sta_tx_agg_oper(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		 * should be updated as well.
 		 */
 		if (buf_size < IWL_FRAME_LIMIT)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		ret = iwl_mvm_sta_tx_agg(mvm, sta, tid, queue, true);
 		if (ret)
-- 
2.34.1


