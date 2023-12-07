Return-Path: <linux-wireless+bounces-477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE1806A17
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F54D281BC1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886422D7B6;
	Wed,  6 Dec 2023 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPj1p7/5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B61999
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852584; x=1733388584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FWwAuqLWHJNe+v+l01WL2+v0UHdBKo53jWlmim3ySkE=;
  b=DPj1p7/5TIwS+B0XWl4PEIIwZgkmaUD0X8X3gGU3ZBwGknAcynySj1Yn
   FNihb/FUnKzE1SeHnJT75KDIgBbbUlpPJDZ0wT7fJFlV18lDWbXbVMB47
   P1toEPBL+P5Oj3QCljEzT151JmllrOlQmbmOyGeuP3ouuF79YsYgYGLhK
   s1qlgtmmrtNMnGwWEFpv69iql7JE7908zsvRs4V+Fwb0egi4SrjbDJ7xt
   cvfNY3RUNmwHrZx2IzVGGHf/3mBOfcs+uG3KL+n/YRV7EINk17mVttnZC
   6d4V4YH4jVWCrt4MWO0KOIb3crHcPVPaWZDkgRZxiD4Op9oEQ+Vxu059d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916523"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916523"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575389"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575389"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:42 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 04/13] wifi: iwlwifi: refactor RX tracing
Date: Thu,  7 Dec 2023 04:50:09 +0200
Message-Id: <20231207044813.13325a4848d2.Ic9e7d794fc4aebfe5ac5136b539ee62789f210f3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

From: Johannes Berg <johannes.berg@intel.com>

When there's not going to be any data in the data event, we
don't need to add it at all (unlike the TX version, it has
no data at all.)

Also combine the tracing into a separate inline so we only
call iwl_rx_trace_len() once, which also simplifies things,
and lets us have a single place to later add other checks.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/iwl-devtrace-data.h         | 15 ++++++-------
 .../intel/iwlwifi/iwl-devtrace-iwlwifi.h      | 17 +++++++--------
 .../net/wireless/intel/iwlwifi/iwl-devtrace.c | 17 +++++++++++++--
 .../net/wireless/intel/iwlwifi/iwl-devtrace.h | 21 +++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  3 +--
 5 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h
index 347fd95c4e3a..2c280a2fe3df 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h
@@ -3,7 +3,7 @@
  *
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015        Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2019, 2023 Intel Corporation
  *****************************************************************************/
 
 #if !defined(__IWLWIFI_DEVICE_TRACE_DATA) || defined(TRACE_HEADER_MULTI_READ)
@@ -36,20 +36,17 @@ TRACE_EVENT(iwlwifi_dev_tx_tb,
 
 TRACE_EVENT(iwlwifi_dev_rx_data,
 	TP_PROTO(const struct device *dev,
-		 const struct iwl_trans *trans,
-		 void *rxbuf, size_t len),
-	TP_ARGS(dev, trans, rxbuf, len),
+		 void *rxbuf, size_t len, size_t start),
+	TP_ARGS(dev, rxbuf, len, start),
 	TP_STRUCT__entry(
 		DEV_ENTRY
-		__dynamic_array(u8, data,
-				len - iwl_rx_trace_len(trans, rxbuf, len, NULL))
+		__dynamic_array(u8, data, len - start)
 	),
 	TP_fast_assign(
-		size_t offs = iwl_rx_trace_len(trans, rxbuf, len, NULL);
 		DEV_ASSIGN;
-		if (offs < len)
+		if (start < len)
 			memcpy(__get_dynamic_array(data),
-			       ((u8 *)rxbuf) + offs, len - offs);
+			       ((u8 *)rxbuf) + start, len - start);
 	),
 	TP_printk("[%s] RX frame data", __get_str(dev))
 );
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h
index 46ed723f138a..e656bf6bc003 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h
@@ -4,7 +4,7 @@
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018, 2023  Intel Corporation
  *****************************************************************************/
 
 #if !defined(__IWLWIFI_DEVICE_TRACE_IWLWIFI) || defined(TRACE_HEADER_MULTI_READ)
@@ -50,23 +50,20 @@ TRACE_EVENT(iwlwifi_dev_hcmd,
 );
 
 TRACE_EVENT(iwlwifi_dev_rx,
-	TP_PROTO(const struct device *dev, const struct iwl_trans *trans,
-		 struct iwl_rx_packet *pkt, size_t len),
-	TP_ARGS(dev, trans, pkt, len),
+	TP_PROTO(const struct device *dev,
+		 struct iwl_rx_packet *pkt, size_t len, size_t trace_len,
+		 size_t hdr_offset),
+	TP_ARGS(dev, pkt, len, trace_len, hdr_offset),
 	TP_STRUCT__entry(
 		DEV_ENTRY
 		__field(u16, cmd)
 		__field(u8, hdr_offset)
-		__dynamic_array(u8, rxbuf,
-				iwl_rx_trace_len(trans, pkt, len, NULL))
+		__dynamic_array(u8, rxbuf, trace_len)
 	),
 	TP_fast_assign(
-		size_t hdr_offset = 0;
-
 		DEV_ASSIGN;
 		__entry->cmd = WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd);
-		memcpy(__get_dynamic_array(rxbuf), pkt,
-		       iwl_rx_trace_len(trans, pkt, len, &hdr_offset));
+		memcpy(__get_dynamic_array(rxbuf), pkt, trace_len);
 		__entry->hdr_offset = hdr_offset;
 	),
 	TP_printk("[%s] RX cmd %#.2x",
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c
index e46639b097f4..7e686297963d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018, 2023 Intel Corporation
  *****************************************************************************/
 
 #include <linux/module.h>
@@ -20,4 +20,17 @@
 EXPORT_TRACEPOINT_SYMBOL(iwlwifi_dev_ucode_event);
 EXPORT_TRACEPOINT_SYMBOL(iwlwifi_dev_ucode_cont_event);
 EXPORT_TRACEPOINT_SYMBOL(iwlwifi_dev_ucode_wrap_event);
-#endif
+#else
+#include "iwl-devtrace.h"
+#endif /* __CHECKER__ */
+
+void __trace_iwlwifi_dev_rx(struct iwl_trans *trans, void *pkt, size_t len)
+{
+	size_t hdr_offset = 0, trace_len;
+
+	trace_len = iwl_rx_trace_len(trans, pkt, len, &hdr_offset);
+	trace_iwlwifi_dev_rx(trans->dev, pkt, len, trace_len, hdr_offset);
+
+	if (trace_len < len)
+		trace_iwlwifi_dev_rx_data(trans->dev, pkt, len, trace_len);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
index 01fb7b900a6d..c3e09f4fefeb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
@@ -7,12 +7,12 @@
  *****************************************************************************/
 
 #ifndef __IWLWIFI_DEVICE_TRACE
+#define __IWLWIFI_DEVICE_TRACE
 #include <linux/skbuff.h>
 #include <linux/ieee80211.h>
 #include <net/cfg80211.h>
 #include <net/mac80211.h>
 #include "iwl-trans.h"
-#if !defined(__IWLWIFI_DEVICE_TRACE)
 static inline bool iwl_trace_data(struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -70,9 +70,6 @@ static inline size_t iwl_rx_trace_len(const struct iwl_trans *trans,
 	return sizeof(__le32) + sizeof(*cmd) + trans->rx_mpdu_cmd_hdr_size +
 		ieee80211_hdrlen(hdr->frame_control);
 }
-#endif
-
-#define __IWLWIFI_DEVICE_TRACE
 
 #include <linux/tracepoint.h>
 #include <linux/device.h>
@@ -98,4 +95,20 @@ static inline void trace_ ## name(proto) {}
 #include "iwl-devtrace-data.h"
 #include "iwl-devtrace-iwlwifi.h"
 
+#ifdef CONFIG_IWLWIFI_DEVICE_TRACING
+DECLARE_TRACEPOINT(iwlwifi_dev_rx);
+DECLARE_TRACEPOINT(iwlwifi_dev_rx_data);
+#endif
+
+void __trace_iwlwifi_dev_rx(struct iwl_trans *trans, void *pkt, size_t len);
+
+static inline void maybe_trace_iwlwifi_dev_rx(struct iwl_trans *trans,
+					      void *pkt, size_t len)
+{
+#ifdef CONFIG_IWLWIFI_DEVICE_TRACING
+	if (tracepoint_enabled(iwlwifi_dev_rx) ||
+	    tracepoint_enabled(iwlwifi_dev_rx_data))
+		__trace_iwlwifi_dev_rx(trans, pkt, len);
+#endif
+}
 #endif /* __IWLWIFI_DEVICE_TRACE */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 146bc7bd14fb..ab0c72c55b2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1351,8 +1351,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		if (len < sizeof(*pkt) || offset > max_len)
 			break;
 
-		trace_iwlwifi_dev_rx(trans->dev, trans, pkt, len);
-		trace_iwlwifi_dev_rx_data(trans->dev, trans, pkt, len);
+		maybe_trace_iwlwifi_dev_rx(trans, pkt, len);
 
 		/* Reclaim a command buffer only if this packet is a response
 		 *   to a (driver-originated) command.
-- 
2.34.1


