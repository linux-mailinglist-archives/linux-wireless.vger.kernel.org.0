Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900AC43095A
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbhJQN21 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 09:28:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53900 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343705AbhJQN20 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 09:28:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6B5-000YdS-Dp; Sun, 17 Oct 2021 16:26:15 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:26:03 +0300
Message-Id: <iwlwifi.20211017162352.2cb1e6b75672.Iec5b1c1bcc6ebc87c586921a6c5c2a937f49e83c@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017132604.480251-1-luca@coelho.fi>
References: <20211017132604.480251-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH 11/12] iwlwifi: allow rate-limited error messages
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Sometimes we might want to have an error message for something
related to TX/RX, but if that somehow happens frequently it'll
overwhelm the logs. Add IWL_ERR_LIMIT() to alleviate that by
rate-limiting those messages.

To do this, rework __iwl_err() a bit to have a mode argument
instead of passing yet another (bool) argument to it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  | 11 +++++----
 .../net/wireless/intel/iwlwifi/iwl-debug.c    | 24 +++++++++++++------
 .../net/wireless/intel/iwlwifi/iwl-debug.h    | 21 ++++++++++++----
 3 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
index 1276df1c7a55..abb8696ba294 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014 Intel Corporation
+ * Copyright (C) 2005-2014, 2021 Intel Corporation
  */
 #ifndef __iwl_agn_h__
 #define __iwl_agn_h__
@@ -398,8 +398,10 @@ do {									\
 	if (!iwl_is_rfkill((m)))					\
 		IWL_ERR(m, fmt, ##args);				\
 	else								\
-		__iwl_err((m)->dev, true,				\
-			  !iwl_have_debug_level(IWL_DL_RADIO),		\
+		__iwl_err((m)->dev,					\
+			  iwl_have_debug_level(IWL_DL_RADIO) ?		\
+				IWL_ERR_MODE_RFKILL :			\
+				IWL_ERR_MODE_TRACE_ONLY,		\
 			  fmt, ##args);					\
 } while (0)
 #else
@@ -408,7 +410,8 @@ do {									\
 	if (!iwl_is_rfkill((m)))					\
 		IWL_ERR(m, fmt, ##args);				\
 	else								\
-		__iwl_err((m)->dev, true, true, fmt, ##args);	\
+		__iwl_err((m)->dev, IWL_ERR_MODE_TRACE_ONLY,		\
+			  fmt, ##args);					\
 } while (0)
 #endif				/* CONFIG_IWLWIFI_DEBUG */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
index f6ca2fc37c40..ae4c2a3d63d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2011 Intel Corporation
+ * Copyright (C) 2005-2011, 2021 Intel Corporation
  */
 #include <linux/device.h>
 #include <linux/interrupt.h>
@@ -31,21 +31,31 @@ IWL_EXPORT_SYMBOL(__iwl_info);
 __iwl_fn(crit)
 IWL_EXPORT_SYMBOL(__iwl_crit);
 
-void __iwl_err(struct device *dev, bool rfkill_prefix, bool trace_only,
-		const char *fmt, ...)
+void __iwl_err(struct device *dev, enum iwl_err_mode mode, const char *fmt, ...)
 {
 	struct va_format vaf = {
 		.fmt = fmt,
 	};
-	va_list args;
+	va_list args, args2;
 
 	va_start(args, fmt);
-	vaf.va = &args;
-	if (!trace_only) {
-		if (rfkill_prefix)
+	switch (mode) {
+	case IWL_ERR_MODE_RATELIMIT:
+		if (net_ratelimit())
+			break;
+		fallthrough;
+	case IWL_ERR_MODE_REGULAR:
+	case IWL_ERR_MODE_RFKILL:
+		va_copy(args2, args);
+		vaf.va = &args2;
+		if (mode == IWL_ERR_MODE_RFKILL)
 			dev_err(dev, "(RFKILL) %pV", &vaf);
 		else
 			dev_err(dev, "%pV", &vaf);
+		va_end(args2);
+		break;
+	default:
+		break;
 	}
 	trace_iwlwifi_err(&vaf);
 	va_end(args);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
index 8db7aeddfd05..1b9f16a31b54 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2020 Intel Corporation
+ * Copyright(c) 2018 - 2021 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project.
  *****************************************************************************/
@@ -22,9 +22,16 @@ static inline bool iwl_have_debug_level(u32 level)
 #endif
 }
 
+enum iwl_err_mode {
+	IWL_ERR_MODE_REGULAR,
+	IWL_ERR_MODE_RFKILL,
+	IWL_ERR_MODE_TRACE_ONLY,
+	IWL_ERR_MODE_RATELIMIT,
+};
+
 struct device;
-void __iwl_err(struct device *dev, bool rfkill_prefix, bool only_trace,
-		const char *fmt, ...) __printf(4, 5);
+void __iwl_err(struct device *dev, enum iwl_err_mode mode, const char *fmt, ...)
+	__printf(3, 4);
 void __iwl_warn(struct device *dev, const char *fmt, ...) __printf(2, 3);
 void __iwl_info(struct device *dev, const char *fmt, ...) __printf(2, 3);
 void __iwl_crit(struct device *dev, const char *fmt, ...) __printf(2, 3);
@@ -33,13 +40,17 @@ void __iwl_crit(struct device *dev, const char *fmt, ...) __printf(2, 3);
 #define CHECK_FOR_NEWLINE(f) BUILD_BUG_ON(f[sizeof(f) - 2] != '\n')
 
 /* No matter what is m (priv, bus, trans), this will work */
-#define IWL_ERR_DEV(d, f, a...)						\
+#define __IWL_ERR_DEV(d, mode, f, a...)					\
 	do {								\
 		CHECK_FOR_NEWLINE(f);					\
-		__iwl_err((d), false, false, f, ## a);			\
+		__iwl_err((d), mode, f, ## a);				\
 	} while (0)
+#define IWL_ERR_DEV(d, f, a...)						\
+	__IWL_ERR_DEV(d, IWL_ERR_MODE_REGULAR, f, ## a)
 #define IWL_ERR(m, f, a...)						\
 	IWL_ERR_DEV((m)->dev, f, ## a)
+#define IWL_ERR_LIMIT(m, f, a...)					\
+	__IWL_ERR_DEV((m)->dev, IWL_ERR_MODE_RATELIMIT, f, ## a)
 #define IWL_WARN(m, f, a...)						\
 	do {								\
 		CHECK_FOR_NEWLINE(f);					\
-- 
2.33.0

