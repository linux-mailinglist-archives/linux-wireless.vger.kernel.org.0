Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630B972F9A0
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbjFNJpf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244320AbjFNJou (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B164271F
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735835; x=1718271835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/LGUbBgzNX1PIxlKIWtkrruGew6ptfFdD1yaXmcePHQ=;
  b=kPZXZAyKoyzMgNgxVv2gdyVkx10HVwhmvMTA82gzIpZVGCiA/ZIXnm0t
   EwH/FJ5K5SPxJvF9Nb97CDVEdww0L0xrT4FcSDZzpX0WwNnuNxlKZ2CLO
   yUSY+pNt++4A6MzySxC7xDCPlQQ2c8WcYpgEvP3htDG2h7QpbsgESDGbQ
   xrZmaJ4k58dp7Pr+JTeCVxVSjyhyWzHEQqw8my3iVbYDF6X7zqJRXlpdN
   2PG5oGqYQxiuFMBt7zNByeiA7adoG8X9dyv8IBlPIYQB40l5L1oOlNlio
   LhrvdJywzG/BNzLjfl/2sYtgfHDQ64f5szpQqjehtxjSovQFr7DbBl+Qf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049881"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049881"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989891"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989891"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:24 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/20] wifi: iwlwifi: add some FW misbehaviour check infrastructure
Date:   Wed, 14 Jun 2023 12:41:31 +0300
Message-Id: <20230614123446.2e12ac670cea.Ia0198036b7a626876d836bd41a4b2d2b1e65c5ca@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When the firmware misbehaves (according to the driver), we
often either ignore that, or WARN_ON, which is very noisy
but doesn't really help.

Add a little helper macro IWL_FW_CHECK() that can be used
in place of WARN_ON() in conditions, and make it take a
message that's printed in this case. We can also add more
behaviour to this in the future.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   | 16 +++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 10 ++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 15 ++++++++++++---
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index be7806407de8..dcba0eefe70d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2019, 2021-2022 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2019, 2021-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -327,4 +327,18 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt);
 void iwl_send_dbg_dump_complete_cmd(struct iwl_fw_runtime *fwrt,
 				    u32 timepoint,
 				    u32 timepoint_data);
+
+#define IWL_FW_CHECK_FAILED(_obj, _fmt, ...)				\
+	IWL_ERR_LIMIT(_obj, _fmt, __VA_ARGS__)
+
+#define IWL_FW_CHECK(_obj, _cond, _fmt, ...)				\
+	({								\
+		bool __cond = (_cond);					\
+									\
+		if (unlikely(__cond))					\
+			IWL_FW_CHECK_FAILED(_obj, _fmt, __VA_ARGS__);	\
+									\
+		unlikely(__cond);					\
+	})
+
 #endif  /* __iwl_fw_dbg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index cc04d7cad715..5336a4afde4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1601,7 +1601,9 @@ static void iwl_mvm_rx_common(struct iwl_mvm *mvm,
 		if (rx_h->cmd_id != WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd))
 			continue;
 
-		if (unlikely(pkt_len < rx_h->min_size))
+		if (IWL_FW_CHECK(mvm, pkt_len < rx_h->min_size,
+				 "unexpected notification 0x%04x size %d, need %d\n",
+				 rx_h->cmd_id, pkt_len, rx_h->min_size))
 			return;
 
 		if (rx_h->context == RX_HANDLER_SYNC) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 9d8d9def9391..5c06839b87c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -985,10 +985,12 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	sta_mask = iwl_mvm_sta_fw_id_mask(mvm, sta, -1);
 	rcu_read_unlock();
 
-	if (WARN(tid != baid_data->tid ||
-		 !(sta_mask & baid_data->sta_mask),
-		 "baid 0x%x is mapped to sta_mask:0x%x tid:%d, but was received for sta_mask:0x%x tid:%d\n",
-		 baid, baid_data->sta_mask, baid_data->tid, sta_mask, tid))
+	if (IWL_FW_CHECK(mvm,
+			 tid != baid_data->tid ||
+			 !(sta_mask & baid_data->sta_mask),
+			 "baid 0x%x is mapped to sta_mask:0x%x tid:%d, but was received for sta_mask:0x%x tid:%d\n",
+			 baid, baid_data->sta_mask, baid_data->tid,
+			 sta_mask, tid))
 		return false;
 
 	nssn = reorder & IWL_RX_MPDU_REORDER_NSSN_MASK;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 06fb4b72ee9b..a04ce7d555d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -2123,7 +2123,8 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 		u16 tfd_cnt;
 		int i;
 
-		if (unlikely(sizeof(*ba_res) > pkt_len))
+		if (IWL_FW_CHECK(mvm, sizeof(*ba_res) > pkt_len,
+				 "short BA notification (%d)\n", pkt_len))
 			return;
 
 		sta_id = ba_res->sta_id;
@@ -2135,7 +2136,13 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 			(void *)(uintptr_t)ba_res->reduced_txp;
 
 		tfd_cnt = le16_to_cpu(ba_res->tfd_cnt);
-		if (!tfd_cnt || struct_size(ba_res, tfd, tfd_cnt) > pkt_len)
+		if (!tfd_cnt)
+			return;
+
+		if (IWL_FW_CHECK(mvm,
+				 struct_size(ba_res, tfd, tfd_cnt) > pkt_len,
+				 "short BA notification (tfds:%d, size:%d)\n",
+				 tfd_cnt, pkt_len))
 			return;
 
 		rcu_read_lock();
@@ -2193,7 +2200,9 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 
 	rcu_read_lock();
 	mvmsta = iwl_mvm_sta_from_staid_rcu(mvm, sta_id);
-	if (WARN_ON_ONCE(!mvmsta)) {
+	if (IWL_FW_CHECK(mvm, !mvmsta,
+			 "invalid STA ID %d in BA notif\n",
+			 sta_id)) {
 		rcu_read_unlock();
 		return;
 	}
-- 
2.38.1

