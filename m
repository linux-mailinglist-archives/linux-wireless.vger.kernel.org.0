Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACA6464CF8
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 12:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348968AbhLALhw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 06:37:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:46248 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349043AbhLALhn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 06:37:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="233942408"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="233942408"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 03:34:22 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="500213133"
Received: from vkerner-mobl2.ger.corp.intel.com (HELO egrumbac-mobl1.intel.com) ([10.255.204.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 03:34:20 -0800
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] iwlwifi: mei: fix linking when tracing is not enabled
Date:   Wed,  1 Dec 2021 13:34:10 +0200
Message-Id: <20211201113411.130409-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I forgot to add stubs in case tracing is disabled.

Reported-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 .../net/wireless/intel/iwlwifi/mei/trace-data.h    | 13 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/mei/trace.h     | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h b/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
index 0a0078a79c7e..83639c6225ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
@@ -3,6 +3,12 @@
  * Copyright(c) 2021        Intel Corporation
  */
 
+#if !defined(CONFIG_IWLWIFI_DEVICE_TRACING)
+
+#define trace_iwlmei_sap_data(...)
+
+#else
+
 #if !defined(__IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_DATA) || defined(TRACE_HEADER_MULTI_READ)
 
 #ifndef __IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_DATA
@@ -60,6 +66,11 @@ TRACE_EVENT(iwlmei_sap_data,
 		  __entry->trace_type, __get_dynamic_array_len(data))
 );
 
+/*
+ * If you add something here, add a stub in case
+ * !defined(CONFIG_IWLWIFI_DEVICE_TRACING)
+ */
+
 #endif /* __IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_DATA */
 
 #undef TRACE_INCLUDE_PATH
@@ -67,3 +78,5 @@ TRACE_EVENT(iwlmei_sap_data,
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace-data
 #include <trace/define_trace.h>
+
+#endif /* CONFIG_IWLWIFI_DEVICE_TRACING */
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/trace.h b/drivers/net/wireless/intel/iwlwifi/mei/trace.h
index 6f673f2817ad..45ecb22ec84a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/trace.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/trace.h
@@ -3,6 +3,13 @@
  * Copyright(c) 2021        Intel Corporation
  */
 
+#if !defined(CONFIG_IWLWIFI_DEVICE_TRACING)
+
+#define trace_iwlmei_sap_cmd(...)
+#define trace_iwlmei_me_msg(...)
+
+#else
+
 #if !defined(__IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_CMD) || defined(TRACE_HEADER_MULTI_READ)
 #define __IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_CMD
 
@@ -53,6 +60,11 @@ TRACE_EVENT(iwlmei_me_msg,
 		  __entry->type, __entry->seq_num)
 );
 
+/*
+ * If you add something here, add a stub in case
+ * !defined(CONFIG_IWLWIFI_DEVICE_TRACING)
+ */
+
 #endif /* __IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_CMD */
 
 #undef TRACE_INCLUDE_PATH
@@ -60,3 +72,5 @@ TRACE_EVENT(iwlmei_me_msg,
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace
 #include <trace/define_trace.h>
+
+#endif /* CONFIG_IWLWIFI_DEVICE_TRACING */
-- 
2.25.1

