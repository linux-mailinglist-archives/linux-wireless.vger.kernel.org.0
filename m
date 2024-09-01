Return-Path: <linux-wireless+bounces-12296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F81D9674F3
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 06:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26216282E6D
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 04:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C83CF63;
	Sun,  1 Sep 2024 04:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="No0Dh5tK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8E40BE3
	for <linux-wireless@vger.kernel.org>; Sun,  1 Sep 2024 04:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725164297; cv=none; b=qFlWPcyx0ihapr2FV2TigbPe3xGVxzO5sG6WlzvJLCn/q6MLobPi601TOmj76VZQyuLhY7gdR0OnvRgntSANSdxItnAu3I9pni0BOFh+ZBT59CbtQpr4rHJehZHeHBry4L0/6LHdhKfJc5ZL0dldoviPYWZB7hPEnjzt9qTVJpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725164297; c=relaxed/simple;
	bh=TisG3zjq5ihDEB60Ly65pEjCxy9xOzbdfqofYP4Ng8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJqWtwhfj9oWN15zA92qcLnsJRFk+InAoSr39++0QI7ielMc7vMrrRRWyALKaYE0W5xyZOYS47XwM8rU5UNFmufHuPFn8/1d9xOc0dwTeq6xNKj0f0b6cbVDsiCfB4LqPuTMgZmrYLpDPjeJwq4ekryAV3ioJ7OH0gfq3Cf0VCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=No0Dh5tK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725164296; x=1756700296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TisG3zjq5ihDEB60Ly65pEjCxy9xOzbdfqofYP4Ng8g=;
  b=No0Dh5tK1ltXaqyKbQxC8zW0x6QNkcvkX7H3xNjInz8Zz0meHAY5k9pp
   lszSkuK1u7HRIoJrVbwD11DBVoQPj6wF5YAqdQ0yMyoqG5X6NBhIJFJi2
   71x/VVyM8dRFJNDPIVeL9leIhtGvIPLSFJo7YnQ+02PlGlGBC1O2GDIKz
   yUg1atAWDlF4lzwEVQ2kA/uBwsJqVunP0vIJNgMsBhrWbXRfa87+8lyVu
   urIsbiNNNmJEtdtnOt1J9w7hpzzEJJlEE37i3ywi+WTiESlcTIRPQqnbW
   MW7WfOvw8+kNKkDgtUiNLqDeoSxm85o+fARLtCDjH2Tinnaysup/dfunk
   A==;
X-CSE-ConnectionGUID: Z4NKOw4LRFyri3mEwWGbIw==
X-CSE-MsgGUID: 9OTlnRwsTV+OeewY+BaH0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="27559526"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="27559526"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:16 -0700
X-CSE-ConnectionGUID: +G/JyxyIS+KfM+nbqjMV3A==
X-CSE-MsgGUID: TbR2/TiKTm6L1H1krEnyDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64276320"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 6/8] wifi: iwlwifi: mvm: remove mvm prefix from iwl_mvm_tx_resp*
Date: Sun,  1 Sep 2024 07:17:55 +0300
Message-Id: <20240901071542.22e28b56da2c.Ib859a05ed133fa5a1426c5feffa8999a18bba6f2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
References: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

These are not mvm specific

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h |  4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h       | 12 ++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h         |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c          | 12 ++++++------
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 852ea5d14051..2f40e69db318 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -147,8 +147,8 @@ enum iwl_legacy_cmds {
 	/**
 	 * @TX_CMD: uses &struct iwl_tx_cmd or &struct iwl_tx_cmd_gen2 or
 	 *	&struct iwl_tx_cmd_gen3,
-	 *	response in &struct iwl_mvm_tx_resp or
-	 *	&struct iwl_mvm_tx_resp_v3
+	 *	response in &struct iwl_tx_resp or
+	 *	&struct iwl_tx_resp_v3
 	 */
 	TX_CMD = 0x1c,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index c5277e2f8cd4..f3bf2e087a40 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -486,7 +486,7 @@ struct agg_tx_status {
 #define IWL_MVM_TX_RES_GET_RA(_ra_tid) ((_ra_tid) >> 4)
 
 /**
- * struct iwl_mvm_tx_resp_v3 - notifies that fw is TXing a packet
+ * struct iwl_tx_resp_v3 - notifies that fw is TXing a packet
  * ( REPLY_TX = 0x1c )
  * @frame_count: 1 no aggregation, >1 aggregation
  * @bt_kill_count: num of times blocked by bluetooth (unused for agg)
@@ -517,7 +517,7 @@ struct agg_tx_status {
  * After the array of statuses comes the SSN of the SCD. Look at
  * %iwl_mvm_get_scd_ssn for more details.
  */
-struct iwl_mvm_tx_resp_v3 {
+struct iwl_tx_resp_v3 {
 	u8 frame_count;
 	u8 bt_kill_count;
 	u8 failure_rts;
@@ -543,7 +543,7 @@ struct iwl_mvm_tx_resp_v3 {
 } __packed; /* TX_RSP_API_S_VER_3 */
 
 /**
- * struct iwl_mvm_tx_resp - notifies that fw is TXing a packet
+ * struct iwl_tx_resp - notifies that fw is TXing a packet
  * ( REPLY_TX = 0x1c )
  * @frame_count: 1 no aggregation, >1 aggregation
  * @bt_kill_count: num of times blocked by bluetooth (unused for agg)
@@ -575,7 +575,7 @@ struct iwl_mvm_tx_resp_v3 {
  * After the array of statuses comes the SSN of the SCD. Look at
  * %iwl_mvm_get_scd_ssn for more details.
  */
-struct iwl_mvm_tx_resp {
+struct iwl_tx_resp {
 	u8 frame_count;
 	u8 bt_kill_count;
 	u8 failure_rts;
@@ -823,7 +823,7 @@ struct iwl_mac_beacon_cmd {
 	     */
 
 struct iwl_beacon_notif {
-	struct iwl_mvm_tx_resp beacon_notify_hdr;
+	struct iwl_tx_resp beacon_notify_hdr;
 	__le64 tsf;
 	__le32 ibss_mgr_status;
 } __packed;
@@ -836,7 +836,7 @@ struct iwl_beacon_notif {
  * @gp2: last beacon time in gp2
  */
 struct iwl_extended_beacon_notif_v5 {
-	struct iwl_mvm_tx_resp beacon_notify_hdr;
+	struct iwl_tx_resp beacon_notify_hdr;
 	__le64 tsf;
 	__le32 ibss_mgr_status;
 	__le32 gp2;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index bb864ec2e22a..bbddd984ddf9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1528,7 +1528,7 @@ void iwl_mvm_rx_beacon_notif(struct iwl_mvm *mvm,
 	mvm->ap_last_beacon_gp2 = le32_to_cpu(beacon->gp2);
 
 	if (!iwl_mvm_is_short_beacon_notif_supported(mvm)) {
-		struct iwl_mvm_tx_resp *beacon_notify_hdr =
+		struct iwl_tx_resp *beacon_notify_hdr =
 			&beacon_v5->beacon_notify_hdr;
 
 		if (unlikely(pkt_len < sizeof(*beacon_v5)))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ec9b8be12766..be637f6e4074 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1708,9 +1708,9 @@ static inline struct agg_tx_status *
 iwl_mvm_get_agg_status(struct iwl_mvm *mvm, void *tx_resp)
 {
 	if (iwl_mvm_has_new_tx_api(mvm))
-		return &((struct iwl_mvm_tx_resp *)tx_resp)->status;
+		return &((struct iwl_tx_resp *)tx_resp)->status;
 	else
-		return ((struct iwl_mvm_tx_resp_v3 *)tx_resp)->status;
+		return ((struct iwl_tx_resp_v3 *)tx_resp)->status;
 }
 
 static inline bool iwl_mvm_is_tt_in_fw(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index d3ab959f497a..42b94c504041 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -368,7 +368,7 @@ struct iwl_rx_handlers {
  */
 static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER(TX_CMD, iwl_mvm_rx_tx_cmd, RX_HANDLER_SYNC,
-		   struct iwl_mvm_tx_resp),
+		   struct iwl_tx_resp),
 	RX_HANDLER(BA_NOTIF, iwl_mvm_rx_ba_notif, RX_HANDLER_SYNC,
 		   struct iwl_mvm_ba_notif),
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index db926b2f4d8d..ca026b5256ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1680,7 +1680,7 @@ static void iwl_mvm_tx_status_check_trigger(struct iwl_mvm *mvm,
  * For 22000-series and lower, this is just 12 bits. For later, 16 bits.
  */
 static inline u32 iwl_mvm_get_scd_ssn(struct iwl_mvm *mvm,
-				      struct iwl_mvm_tx_resp *tx_resp)
+				      struct iwl_tx_resp *tx_resp)
 {
 	u32 val = le32_to_cpup((__le32 *)iwl_mvm_get_agg_status(mvm, tx_resp) +
 			       tx_resp->frame_count);
@@ -1696,8 +1696,8 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	struct ieee80211_sta *sta;
 	u16 sequence = le16_to_cpu(pkt->hdr.sequence);
 	int txq_id = SEQ_TO_QUEUE(sequence);
-	/* struct iwl_mvm_tx_resp_v3 is almost the same */
-	struct iwl_mvm_tx_resp *tx_resp = (void *)pkt->data;
+	/* struct iwl_tx_resp_v3 is almost the same */
+	struct iwl_tx_resp *tx_resp = (void *)pkt->data;
 	int sta_id = IWL_MVM_TX_RES_GET_RA(tx_resp->ra_tid);
 	int tid = IWL_MVM_TX_RES_GET_TID(tx_resp->ra_tid);
 	struct agg_tx_status *agg_status =
@@ -1954,7 +1954,7 @@ static const char *iwl_get_agg_tx_status(u16 status)
 static void iwl_mvm_rx_tx_cmd_agg_dbg(struct iwl_mvm *mvm,
 				      struct iwl_rx_packet *pkt)
 {
-	struct iwl_mvm_tx_resp *tx_resp = (void *)pkt->data;
+	struct iwl_tx_resp *tx_resp = (void *)pkt->data;
 	struct agg_tx_status *frame_status =
 		iwl_mvm_get_agg_status(mvm, tx_resp);
 	int i;
@@ -1988,7 +1988,7 @@ static void iwl_mvm_rx_tx_cmd_agg_dbg(struct iwl_mvm *mvm,
 static void iwl_mvm_rx_tx_cmd_agg(struct iwl_mvm *mvm,
 				  struct iwl_rx_packet *pkt)
 {
-	struct iwl_mvm_tx_resp *tx_resp = (void *)pkt->data;
+	struct iwl_tx_resp *tx_resp = (void *)pkt->data;
 	int sta_id = IWL_MVM_TX_RES_GET_RA(tx_resp->ra_tid);
 	int tid = IWL_MVM_TX_RES_GET_TID(tx_resp->ra_tid);
 	u16 sequence = le16_to_cpu(pkt->hdr.sequence);
@@ -2029,7 +2029,7 @@ static void iwl_mvm_rx_tx_cmd_agg(struct iwl_mvm *mvm,
 void iwl_mvm_rx_tx_cmd(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_mvm_tx_resp *tx_resp = (void *)pkt->data;
+	struct iwl_tx_resp *tx_resp = (void *)pkt->data;
 
 	if (tx_resp->frame_count == 1)
 		iwl_mvm_rx_tx_cmd_single(mvm, pkt);
-- 
2.34.1


