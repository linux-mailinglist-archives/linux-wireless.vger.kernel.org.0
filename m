Return-Path: <linux-wireless+bounces-23871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5541AD2575
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341777A6E71
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894021D3DC;
	Mon,  9 Jun 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw223ZhG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5D21CC79
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493326; cv=none; b=k5pCtDFcZ/tVRpxcJaCdvKyiM+LdJpLCKxALRsXYHOUR2iy3bXJE2CfnKhgR+U0ZMQjyF7r2oxQw0kN6LNvzmcS2tkWCELfHbqQXHNyKzsn1q5Oiz5Bm2DrS9H/OOJGj0veFltn+fNSwy6Xe1LXhDQ8OSCVgrVO8fr1g4ZqI/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493326; c=relaxed/simple;
	bh=keoQroPYz90GAjM4Q3F2sLDDH17aIfGTxA/GUhggGBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hy6I+kBy2t63094hd841Nc04TsWTOJafPXuC7teS+3k4BTO2sLyWF3gg13dKBXvy6H1uKbL1iD6tHswAYdj1aZ8rtH1rQ/5YCCQd6YKQQGr8bI8MUgnimJXpCugoxK6feErynDclP19j75X7QkMsGWECVUFhJ68hX1AzoCCHxbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw223ZhG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493325; x=1781029325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=keoQroPYz90GAjM4Q3F2sLDDH17aIfGTxA/GUhggGBw=;
  b=Iw223ZhGiYHdIOoewY5RAE6g+chpvWSQTznHEgIWpop1XAkR4ByLTGXh
   DK6bcKcLpaKvSYABKJ5frD7u6kml+DuXKT14XnZV/E2M6BcvAkPQT8NwB
   GxiFq8asTsNaSGGGb3pxlEe+Jc0Lj7GGA4sBL8TqoRrFJiNYTnoj21xQV
   o7SRpLmeAAEgfx1qELVTywxaE0Gv5/tGY52WfcjxiYGVPPh8woQBmWU70
   LgNyfeCONDsnucVrDZK9b3V//k+5APNaimdF4PLfoc2EGIDf1IZbB4Xlo
   JiKTdRJsG4u+vgqenXF5wn2zK/hVHxBrXXn7w05VeRVbgYWlvL3gwSZy3
   w==;
X-CSE-ConnectionGUID: PS1e25P5Sw2t+zNsw/LPyQ==
X-CSE-MsgGUID: SUoBqzi3SO674ai/7nqZjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237692"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237692"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:22:03 -0700
X-CSE-ConnectionGUID: mKI7KnxOTwCgX9za+DyBVA==
X-CSE-MsgGUID: LT5ntq8TR2OfMIvunu7Qbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510375"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:22:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: move dBm averaging function into utils
Date: Mon,  9 Jun 2025 21:21:18 +0300
Message-Id: <20250609211928.8cc965af6990.I09bb2137863e888efe756c92d8eb0271ec95456c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The function really is just a simple math helper. Move it into
iwl-utils.c so that it can also be used by iwlmld.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Kconfig    |   1 +
 .../net/wireless/intel/iwlwifi/iwl-utils.c    | 113 ++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-utils.h    |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   1 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 117 +-----------------
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |   2 +-
 .../net/wireless/intel/iwlwifi/tests/Makefile |   2 +-
 .../{mvm/tests/scan.c => tests/utils.c}       |  43 ++++---
 8 files changed, 143 insertions(+), 140 deletions(-)
 rename drivers/net/wireless/intel/iwlwifi/{mvm/tests/scan.c => tests/utils.c} (63%)

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 82f577da1a8b..153a8368b412 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -97,6 +97,7 @@ config IWLWIFI_OPMODE_MODULAR
 	default y if IWLDVM=m
 	default y if IWLMVM=m
 	default y if IWLMLD=m
+	default y if IWLWIFI_KUNIT_TESTS=m
 
 comment "WARNING: iwlwifi is useless without IWLDVM or IWLMVM or IWLMLD"
 	depends on IWLDVM=n && IWLMVM=n && IWLMLD=n
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-utils.c b/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
index c5b49851e4b9..d503544fda40 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 #include <net/gso.h>
 #include <linux/ieee80211.h>
@@ -82,3 +82,114 @@ int iwl_tx_tso_segment(struct sk_buff *skb, unsigned int num_subframes,
 }
 IWL_EXPORT_SYMBOL(iwl_tx_tso_segment);
 #endif /* CONFIG_INET */
+
+static u32 iwl_div_by_db(u32 value, u8 db)
+{
+	/*
+	 * 2^32 * 10**(i / 10) for i = [1, 10], skipping 0 and simply stopping
+	 * at 10 dB and looping instead of using a much larger table.
+	 *
+	 * Using 64 bit math is overkill, but means the helper does not require
+	 * a limit on the input range.
+	 */
+	static const u32 db_to_val[] = {
+		0xcb59185e, 0xa1866ba8, 0x804dce7a, 0x65ea59fe, 0x50f44d89,
+		0x404de61f, 0x331426af, 0x2892c18b, 0x203a7e5b, 0x1999999a,
+	};
+
+	while (value && db > 0) {
+		u8 change = min_t(u8, db, ARRAY_SIZE(db_to_val));
+
+		value = (((u64)value) * db_to_val[change - 1]) >> 32;
+
+		db -= change;
+	}
+
+	return value;
+}
+
+s8 iwl_average_neg_dbm(const u8 *neg_dbm_values, u8 len)
+{
+	int average_magnitude;
+	u32 average_factor;
+	int sum_magnitude = -128;
+	u32 sum_factor = 0;
+	int i, count = 0;
+
+	/*
+	 * To properly average the decibel values (signal values given in dBm)
+	 * we need to do the math in linear space.  Doing a linear average of
+	 * dB (dBm) values is a bit annoying though due to the large range of
+	 * at least -10 to -110 dBm that will not fit into a 32 bit integer.
+	 *
+	 * A 64 bit integer should be sufficient, but then we still have the
+	 * problem that there are no directly usable utility functions
+	 * available.
+	 *
+	 * So, lets not deal with that and instead do much of the calculation
+	 * with a 16.16 fixed point integer along with a base in dBm. 16.16 bit
+	 * gives us plenty of head-room for adding up a few values and even
+	 * doing some math on it. And the tail should be accurate enough too
+	 * (1/2^16 is somewhere around -48 dB, so effectively zero).
+	 *
+	 * i.e. the real value of sum is:
+	 *      sum = sum_factor / 2^16 * 10^(sum_magnitude / 10) mW
+	 *
+	 * However, that does mean we need to be able to bring two values to
+	 * a common base, so we need a helper for that.
+	 *
+	 * Note that this function takes an input with unsigned negative dBm
+	 * values but returns a signed dBm (i.e. a negative value).
+	 */
+
+	for (i = 0; i < len; i++) {
+		int val_magnitude;
+		u32 val_factor;
+
+		/* Assume invalid */
+		if (neg_dbm_values[i] == 0xff)
+			continue;
+
+		val_factor = 0x10000;
+		val_magnitude = -neg_dbm_values[i];
+
+		if (val_magnitude <= sum_magnitude) {
+			u8 div_db = sum_magnitude - val_magnitude;
+
+			val_factor = iwl_div_by_db(val_factor, div_db);
+			val_magnitude = sum_magnitude;
+		} else {
+			u8 div_db = val_magnitude - sum_magnitude;
+
+			sum_factor = iwl_div_by_db(sum_factor, div_db);
+			sum_magnitude = val_magnitude;
+		}
+
+		sum_factor += val_factor;
+		count++;
+	}
+
+	/* No valid noise measurement, return a very high noise level */
+	if (count == 0)
+		return 0;
+
+	average_magnitude = sum_magnitude;
+	average_factor = sum_factor / count;
+
+	/*
+	 * average_factor will be a number smaller than 1.0 (0x10000) at this
+	 * point. What we need to do now is to adjust average_magnitude so that
+	 * average_factor is between -0.5 dB and 0.5 dB.
+	 *
+	 * Just do -1 dB steps and find the point where
+	 *   -0.5 dB * -i dB = 0x10000 * 10^(-0.5/10) / i dB
+	 *                   = div_by_db(0xe429, i)
+	 * is smaller than average_factor.
+	 */
+	for (i = 0; average_factor < iwl_div_by_db(0xe429, i); i++) {
+		/* nothing */
+	}
+
+	return clamp(average_magnitude - i, -128, 0);
+}
+IWL_EXPORT_SYMBOL(iwl_average_neg_dbm);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-utils.h b/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
index 8f1f11d06fbe..5172035e4d26 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 #ifndef __iwl_utils_h__
 #define __iwl_utils_h__
@@ -53,4 +53,6 @@ u32 iwl_find_ie_offset(u8 *beacon, u8 eid, u32 frame_size)
 	return ie - beacon;
 }
 
+s8 iwl_average_neg_dbm(const u8 *neg_dbm_values, u8 len);
+
 #endif /* __iwl_utils_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a4f412e750d0..e8419a2e4c4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2133,7 +2133,6 @@ bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
 
 s8 iwl_mvm_average_dbm_values(const struct iwl_umac_scan_channel_survey_notif *notif);
 
-
 extern const struct iwl_hcmd_arr iwl_mvm_groups[];
 extern const unsigned int iwl_mvm_groups_size;
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 60bd9c7e5f03..5f30109ca18f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -11,6 +11,7 @@
 #include "mvm.h"
 #include "fw/api/scan.h"
 #include "iwl-io.h"
+#include "iwl-utils.h"
 
 #define IWL_DENSE_EBS_SCAN_RATIO 5
 #define IWL_SPARSE_EBS_SCAN_RATIO 1
@@ -3685,117 +3686,6 @@ static int iwl_mvm_chanidx_from_phy(struct iwl_mvm *mvm,
 	return -EINVAL;
 }
 
-static u32 iwl_mvm_div_by_db(u32 value, u8 db)
-{
-	/*
-	 * 2^32 * 10**(i / 10) for i = [1, 10], skipping 0 and simply stopping
-	 * at 10 dB and looping instead of using a much larger table.
-	 *
-	 * Using 64 bit math is overkill, but means the helper does not require
-	 * a limit on the input range.
-	 */
-	static const u32 db_to_val[] = {
-		0xcb59185e, 0xa1866ba8, 0x804dce7a, 0x65ea59fe, 0x50f44d89,
-		0x404de61f, 0x331426af, 0x2892c18b, 0x203a7e5b, 0x1999999a,
-	};
-
-	while (value && db > 0) {
-		u8 change = min_t(u8, db, ARRAY_SIZE(db_to_val));
-
-		value = (((u64)value) * db_to_val[change - 1]) >> 32;
-
-		db -= change;
-	}
-
-	return value;
-}
-
-VISIBLE_IF_IWLWIFI_KUNIT s8
-iwl_mvm_average_dbm_values(const struct iwl_umac_scan_channel_survey_notif *notif)
-{
-	s8 average_magnitude;
-	u32 average_factor;
-	s8 sum_magnitude = -128;
-	u32 sum_factor = 0;
-	int i, count = 0;
-
-	/*
-	 * To properly average the decibel values (signal values given in dBm)
-	 * we need to do the math in linear space.  Doing a linear average of
-	 * dB (dBm) values is a bit annoying though due to the large range of
-	 * at least -10 to -110 dBm that will not fit into a 32 bit integer.
-	 *
-	 * A 64 bit integer should be sufficient, but then we still have the
-	 * problem that there are no directly usable utility functions
-	 * available.
-	 *
-	 * So, lets not deal with that and instead do much of the calculation
-	 * with a 16.16 fixed point integer along with a base in dBm. 16.16 bit
-	 * gives us plenty of head-room for adding up a few values and even
-	 * doing some math on it. And the tail should be accurate enough too
-	 * (1/2^16 is somewhere around -48 dB, so effectively zero).
-	 *
-	 * i.e. the real value of sum is:
-	 *      sum = sum_factor / 2^16 * 10^(sum_magnitude / 10) mW
-	 *
-	 * However, that does mean we need to be able to bring two values to
-	 * a common base, so we need a helper for that.
-	 *
-	 * Note that this function takes an input with unsigned negative dBm
-	 * values but returns a signed dBm (i.e. a negative value).
-	 */
-
-	for (i = 0; i < ARRAY_SIZE(notif->noise); i++) {
-		s8 val_magnitude;
-		u32 val_factor;
-
-		if (notif->noise[i] == 0xff)
-			continue;
-
-		val_factor = 0x10000;
-		val_magnitude = -notif->noise[i];
-
-		if (val_magnitude <= sum_magnitude) {
-			u8 div_db = sum_magnitude - val_magnitude;
-
-			val_factor = iwl_mvm_div_by_db(val_factor, div_db);
-			val_magnitude = sum_magnitude;
-		} else {
-			u8 div_db = val_magnitude - sum_magnitude;
-
-			sum_factor = iwl_mvm_div_by_db(sum_factor, div_db);
-			sum_magnitude = val_magnitude;
-		}
-
-		sum_factor += val_factor;
-		count++;
-	}
-
-	/* No valid noise measurement, return a very high noise level */
-	if (count == 0)
-		return 0;
-
-	average_magnitude = sum_magnitude;
-	average_factor = sum_factor / count;
-
-	/*
-	 * average_factor will be a number smaller than 1.0 (0x10000) at this
-	 * point. What we need to do now is to adjust average_magnitude so that
-	 * average_factor is between -0.5 dB and 0.5 dB.
-	 *
-	 * Just do -1 dB steps and find the point where
-	 *   -0.5 dB * -i dB = 0x10000 * 10^(-0.5/10) / i dB
-	 *                   = div_by_db(0xe429, i)
-	 * is smaller than average_factor.
-	 */
-	for (i = 0; average_factor < iwl_mvm_div_by_db(0xe429, i); i++) {
-		/* nothing */
-	}
-
-	return average_magnitude - i;
-}
-EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_average_dbm_values);
-
 void iwl_mvm_rx_channel_survey_notif(struct iwl_mvm *mvm,
 				     struct iwl_rx_cmd_buffer *rxb)
 {
@@ -3853,5 +3743,6 @@ void iwl_mvm_rx_channel_survey_notif(struct iwl_mvm *mvm,
 	info->time_busy = le32_to_cpu(notif->busy_time);
 	info->time_rx = le32_to_cpu(notif->rx_time);
 	info->time_tx = le32_to_cpu(notif->tx_time);
-	info->noise = iwl_mvm_average_dbm_values(notif);
+	info->noise =
+		iwl_average_neg_dbm(notif->noise, ARRAY_SIZE(notif->noise));
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
index 895d53f223e9..bb33f4a06f1c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
@@ -1,3 +1,3 @@
-iwlmvm-tests-y += module.o links.o scan.o hcmd.o
+iwlmvm-tests-y += module.o links.o hcmd.o
 
 obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlmvm-tests.o
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/tests/Makefile
index 84491488f589..1b49241c578f 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/tests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
-iwlwifi-tests-y += module.o devinfo.o
+iwlwifi-tests-y += module.o devinfo.o utils.o
 
 ccflags-y += -I$(src)/../
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/scan.c b/drivers/net/wireless/intel/iwlwifi/tests/utils.c
similarity index 63%
rename from drivers/net/wireless/intel/iwlwifi/mvm/tests/scan.c
rename to drivers/net/wireless/intel/iwlwifi/tests/utils.c
index 7a3275199ace..df2c3a891e7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/utils.c
@@ -1,20 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * KUnit tests for channel helper functions
+ * KUnit tests for utilities
  *
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
-#include <net/mac80211.h>
-#include "../mvm.h"
+#include "../iwl-utils.h"
 #include <kunit/test.h>
 
-MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+MODULE_IMPORT_NS("IWLWIFI");
 
-static const struct acs_average_db_case {
+static const struct average_neg_db_case {
 	const char *desc;
 	u8 neg_dbm[22];
 	s8 result;
-} acs_average_db_cases[] = {
+} average_neg_db_cases[] = {
 	{
 		.desc = "Smallest possible value, all filled",
 		.neg_dbm = {
@@ -73,38 +72,38 @@ static const struct acs_average_db_case {
 	},
 };
 
-KUNIT_ARRAY_PARAM_DESC(acs_average_db, acs_average_db_cases, desc)
+KUNIT_ARRAY_PARAM_DESC(average_neg_db, average_neg_db_cases, desc)
 
-static void test_acs_average_db(struct kunit *test)
+static void test_average_neg_db(struct kunit *test)
 {
-	const struct acs_average_db_case *params = test->param_value;
-	struct iwl_umac_scan_channel_survey_notif notif;
+	const struct average_neg_db_case *params = test->param_value;
+	u8 reversed[ARRAY_SIZE(params->neg_dbm)];
 	int i;
 
 	/* Test the values in the given order */
-	for (i = 0; i < ARRAY_SIZE(params->neg_dbm); i++)
-		notif.noise[i] = params->neg_dbm[i];
 	KUNIT_ASSERT_EQ(test,
-			iwl_mvm_average_dbm_values(&notif),
+			iwl_average_neg_dbm(params->neg_dbm,
+					    ARRAY_SIZE(params->neg_dbm)),
 			params->result);
 
 	/* Test in reverse order */
 	for (i = 0; i < ARRAY_SIZE(params->neg_dbm); i++)
-		notif.noise[ARRAY_SIZE(params->neg_dbm) - i - 1] =
+		reversed[ARRAY_SIZE(params->neg_dbm) - i - 1] =
 			params->neg_dbm[i];
 	KUNIT_ASSERT_EQ(test,
-			iwl_mvm_average_dbm_values(&notif),
+			iwl_average_neg_dbm(reversed,
+					    ARRAY_SIZE(params->neg_dbm)),
 			params->result);
 }
 
-static struct kunit_case acs_average_db_case[] = {
-	KUNIT_CASE_PARAM(test_acs_average_db, acs_average_db_gen_params),
+static struct kunit_case average_db_case[] = {
+	KUNIT_CASE_PARAM(test_average_neg_db, average_neg_db_gen_params),
 	{}
 };
 
-static struct kunit_suite acs_average_db = {
-	.name = "iwlmvm-acs-average-db",
-	.test_cases = acs_average_db_case,
+static struct kunit_suite average_db = {
+	.name = "iwl-average-db",
+	.test_cases = average_db_case,
 };
 
-kunit_test_suite(acs_average_db);
+kunit_test_suite(average_db);
-- 
2.34.1


