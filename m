Return-Path: <linux-wireless+bounces-7546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C9F8C367E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD9CB21E3E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148E1446B4;
	Sun, 12 May 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwRmBIg4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346D3E47E
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516734; cv=none; b=PbISKbJ4Fru1HfpxJSWZADUIKE4fcMPzDjmpjR1uuoqvAQqvzKcbQWHDsl1UglNLhHsD0DHDKBK64xGraLB3TN5776sgIPJVUvqxrx90+zip5MjbwuGc3EmeWIP4z2WH6Yg3ZZzJ9Wndrh0Eogx9ALK5YygpLqkEHAqG/ZcljKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516734; c=relaxed/simple;
	bh=TrjakMfmJ3M/ZBIH7MTxatyBHPx5iOMovR432cb9DF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qfkZJq4RUKLJT240fqLcdbkgu1Jjd3daXPRSQIDn38TJP7bVlWRNMxEFtEcpyERCeyuqMjhPZKmZtr56e9VqkowNBHrUfTeZbjDZv3RSusq0FyuMR1LbgHQ3whScSscUe/wntHb17RBRXJ0quRpyg9JgKDB1ws7xhxnbmJlzRWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwRmBIg4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516730; x=1747052730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TrjakMfmJ3M/ZBIH7MTxatyBHPx5iOMovR432cb9DF4=;
  b=fwRmBIg4CJpnY0Z6S0qm5kMg5miyRyWBbPJta0uMrSGAt+QI8Sc39Jzs
   lhXZSjfkymHnPesqUzOakFJVkLM/aRQGhoCCb4JjYOFMwUDSSWe1HuJ7Q
   XA5ZrjgfzhKGqkDiLXlu/LWzIdkIbquxq9Lb3AkiAQcqgqs1m1V9DQj2E
   mELTFFG1TJ1zog5lZKx6c5Cs0Kpics1pwFh6Gv+sYSNuA94moIzDmKQuV
   SGrxAaBQOuhtkTrKR68z5W4MKmvzq45Atvo9s9kv3UGdQMWwgSejQ0uLJ
   vf74Vp5EaYfviyjY/6fIAKXPgjqBfqv8wYQ1Lu4T/YRTQvbVjUfwp0T2G
   g==;
X-CSE-ConnectionGUID: zferosS3RNmJCR5GNIjj7g==
X-CSE-MsgGUID: ZkzSkHfdR7KVa6D1j42DQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397213"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397213"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:30 -0700
X-CSE-ConnectionGUID: IWYS2T+mTTuRGZqR6iuumQ==
X-CSE-MsgGUID: yGLsWq9OQ+uVKMIJyZKV8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761337"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 10/14] wifi: iwlwifi: move code from iwl-eeprom-parse to dvm
Date: Sun, 12 May 2024 15:25:03 +0300
Message-Id: <20240512152312.9a1b6ef116e0.I217a513f544d5288a7760d265f51419e81abfd9d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
References: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Move code that is DVM only to dvm

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |  17 +
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h  |   2 +-
 .../net/wireless/intel/iwlwifi/dvm/devices.c  |   2 +-
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   | 757 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   2 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   2 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c | 882 ------------------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |   2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-utils.c    | 118 +++
 .../{iwl-eeprom-parse.h => iwl-nvm-utils.h}   |  17 -
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   2 +-
 16 files changed, 903 insertions(+), 910 deletions(-)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
 rename drivers/net/wireless/intel/iwlwifi/{iwl-eeprom-parse.h => iwl-nvm-utils.h} (73%)

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 2c2c18cef9ff..93cce88f2e27 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_IWLWIFI)	+= iwlwifi.o
 iwlwifi-objs		+= iwl-io.o
 iwlwifi-objs		+= iwl-drv.o
 iwlwifi-objs		+= iwl-debug.o
-iwlwifi-objs		+= iwl-eeprom-parse.o
+iwlwifi-objs		+= iwl-nvm-utils.o
 iwlwifi-objs		+= iwl-phy-db.o iwl-nvm-parse.o
 iwlwifi-objs		+= pcie/drv.o pcie/rx.o pcie/tx.o pcie/trans.o
 iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-gen3.o
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
index 47d21413ba59..a13add556a7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
@@ -385,6 +385,23 @@ static inline void iwl_dvm_set_pmi(struct iwl_priv *priv, bool state)
 	iwl_trans_set_pmi(priv->trans, state);
 }
 
+/**
+ * iwl_parse_eeprom_data - parse EEPROM data and return values
+ *
+ * @trans: ransport we're parsing for, for debug only
+ * @cfg: device configuration for parsing and overrides
+ * @eeprom: the EEPROM data
+ * @eeprom_size: length of the EEPROM data
+ *
+ * This function parses all EEPROM values we need and then
+ * returns a (newly allocated) struct containing all the
+ * relevant values for driver use. The struct must be freed
+ * later with iwl_free_nvm_data().
+ */
+struct iwl_nvm_data *
+iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+		      const u8 *eeprom, size_t eeprom_size);
+
 int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
index 25283e4b849f..4ac8b862ad41 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
@@ -19,7 +19,7 @@
 #include <linux/mutex.h>
 
 #include "fw/img.h"
-#include "iwl-eeprom-parse.h"
+#include "iwl-nvm-utils.h"
 #include "iwl-csr.h"
 #include "iwl-debug.h"
 #include "iwl-agn-hw.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
index 39e40901fa46..48a8349680fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
@@ -12,7 +12,7 @@
  */
 #include "iwl-io.h"
 #include "iwl-prph.h"
-#include "iwl-eeprom-parse.h"
+#include "iwl-nvm-utils.h"
 
 #include "agn.h"
 #include "dev.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
index 3972775fc133..931aa3f5798d 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
@@ -13,6 +13,641 @@
 #include "iwl-csr.h"
 #include "agn.h"
 
+/* EEPROM offset definitions */
+
+/* indirect access definitions */
+#define ADDRESS_MSK                 0x0000FFFF
+#define INDIRECT_TYPE_MSK           0x000F0000
+#define INDIRECT_HOST               0x00010000
+#define INDIRECT_GENERAL            0x00020000
+#define INDIRECT_REGULATORY         0x00030000
+#define INDIRECT_CALIBRATION        0x00040000
+#define INDIRECT_PROCESS_ADJST      0x00050000
+#define INDIRECT_OTHERS             0x00060000
+#define INDIRECT_TXP_LIMIT          0x00070000
+#define INDIRECT_TXP_LIMIT_SIZE     0x00080000
+#define INDIRECT_ADDRESS            0x00100000
+
+/* corresponding link offsets in EEPROM */
+#define EEPROM_LINK_HOST             (2*0x64)
+#define EEPROM_LINK_GENERAL          (2*0x65)
+#define EEPROM_LINK_REGULATORY       (2*0x66)
+#define EEPROM_LINK_CALIBRATION      (2*0x67)
+#define EEPROM_LINK_PROCESS_ADJST    (2*0x68)
+#define EEPROM_LINK_OTHERS           (2*0x69)
+#define EEPROM_LINK_TXP_LIMIT        (2*0x6a)
+#define EEPROM_LINK_TXP_LIMIT_SIZE   (2*0x6b)
+
+/* General */
+#define EEPROM_DEVICE_ID                    (2*0x08)	/* 2 bytes */
+#define EEPROM_SUBSYSTEM_ID		    (2*0x0A)	/* 2 bytes */
+#define EEPROM_MAC_ADDRESS                  (2*0x15)	/* 6  bytes */
+#define EEPROM_BOARD_REVISION               (2*0x35)	/* 2  bytes */
+#define EEPROM_BOARD_PBA_NUMBER             (2*0x3B+1)	/* 9  bytes */
+#define EEPROM_VERSION                      (2*0x44)	/* 2  bytes */
+#define EEPROM_SKU_CAP                      (2*0x45)	/* 2  bytes */
+#define EEPROM_OEM_MODE                     (2*0x46)	/* 2  bytes */
+#define EEPROM_RADIO_CONFIG                 (2*0x48)	/* 2  bytes */
+#define EEPROM_NUM_MAC_ADDRESS              (2*0x4C)	/* 2  bytes */
+
+/* calibration */
+struct iwl_eeprom_calib_hdr {
+	u8 version;
+	u8 pa_type;
+	__le16 voltage;
+} __packed;
+
+#define EEPROM_CALIB_ALL	(INDIRECT_ADDRESS | INDIRECT_CALIBRATION)
+#define EEPROM_XTAL		((2*0x128) | EEPROM_CALIB_ALL)
+
+/* temperature */
+#define EEPROM_KELVIN_TEMPERATURE	((2*0x12A) | EEPROM_CALIB_ALL)
+#define EEPROM_RAW_TEMPERATURE		((2*0x12B) | EEPROM_CALIB_ALL)
+
+/* SKU Capabilities (actual values from EEPROM definition) */
+enum eeprom_sku_bits {
+	EEPROM_SKU_CAP_BAND_24GHZ	= BIT(4),
+	EEPROM_SKU_CAP_BAND_52GHZ	= BIT(5),
+	EEPROM_SKU_CAP_11N_ENABLE	= BIT(6),
+	EEPROM_SKU_CAP_AMT_ENABLE	= BIT(7),
+	EEPROM_SKU_CAP_IPAN_ENABLE	= BIT(8)
+};
+
+/* radio config bits (actual values from EEPROM definition) */
+#define EEPROM_RF_CFG_TYPE_MSK(x)   (x & 0x3)         /* bits 0-1   */
+#define EEPROM_RF_CFG_STEP_MSK(x)   ((x >> 2)  & 0x3) /* bits 2-3   */
+#define EEPROM_RF_CFG_DASH_MSK(x)   ((x >> 4)  & 0x3) /* bits 4-5   */
+#define EEPROM_RF_CFG_PNUM_MSK(x)   ((x >> 6)  & 0x3) /* bits 6-7   */
+#define EEPROM_RF_CFG_TX_ANT_MSK(x) ((x >> 8)  & 0xF) /* bits 8-11  */
+#define EEPROM_RF_CFG_RX_ANT_MSK(x) ((x >> 12) & 0xF) /* bits 12-15 */
+
+/*
+ * EEPROM bands
+ * These are the channel numbers from each band in the order
+ * that they are stored in the EEPROM band information. Note
+ * that EEPROM bands aren't the same as mac80211 bands, and
+ * there are even special "ht40 bands" in the EEPROM.
+ */
+static const u8 iwl_eeprom_band_1[14] = { /* 2.4 GHz */
+	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
+};
+
+static const u8 iwl_eeprom_band_2[] = {	/* 4915-5080MHz */
+	183, 184, 185, 187, 188, 189, 192, 196, 7, 8, 11, 12, 16
+};
+
+static const u8 iwl_eeprom_band_3[] = {	/* 5170-5320MHz */
+	34, 36, 38, 40, 42, 44, 46, 48, 52, 56, 60, 64
+};
+
+static const u8 iwl_eeprom_band_4[] = {	/* 5500-5700MHz */
+	100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140
+};
+
+static const u8 iwl_eeprom_band_5[] = {	/* 5725-5825MHz */
+	145, 149, 153, 157, 161, 165
+};
+
+static const u8 iwl_eeprom_band_6[] = {	/* 2.4 ht40 channel */
+	1, 2, 3, 4, 5, 6, 7
+};
+
+static const u8 iwl_eeprom_band_7[] = {	/* 5.2 ht40 channel */
+	36, 44, 52, 60, 100, 108, 116, 124, 132, 149, 157
+};
+
+#define IWL_NUM_CHANNELS	(ARRAY_SIZE(iwl_eeprom_band_1) + \
+				 ARRAY_SIZE(iwl_eeprom_band_2) + \
+				 ARRAY_SIZE(iwl_eeprom_band_3) + \
+				 ARRAY_SIZE(iwl_eeprom_band_4) + \
+				 ARRAY_SIZE(iwl_eeprom_band_5))
+
+/* rate data (static) */
+static struct ieee80211_rate iwl_cfg80211_rates[] = {
+	{ .bitrate = 1 * 10, .hw_value = 0, .hw_value_short = 0, },
+	{ .bitrate = 2 * 10, .hw_value = 1, .hw_value_short = 1,
+	  .flags = IEEE80211_RATE_SHORT_PREAMBLE, },
+	{ .bitrate = 5.5 * 10, .hw_value = 2, .hw_value_short = 2,
+	  .flags = IEEE80211_RATE_SHORT_PREAMBLE, },
+	{ .bitrate = 11 * 10, .hw_value = 3, .hw_value_short = 3,
+	  .flags = IEEE80211_RATE_SHORT_PREAMBLE, },
+	{ .bitrate = 6 * 10, .hw_value = 4, .hw_value_short = 4, },
+	{ .bitrate = 9 * 10, .hw_value = 5, .hw_value_short = 5, },
+	{ .bitrate = 12 * 10, .hw_value = 6, .hw_value_short = 6, },
+	{ .bitrate = 18 * 10, .hw_value = 7, .hw_value_short = 7, },
+	{ .bitrate = 24 * 10, .hw_value = 8, .hw_value_short = 8, },
+	{ .bitrate = 36 * 10, .hw_value = 9, .hw_value_short = 9, },
+	{ .bitrate = 48 * 10, .hw_value = 10, .hw_value_short = 10, },
+	{ .bitrate = 54 * 10, .hw_value = 11, .hw_value_short = 11, },
+};
+#define RATES_24_OFFS	0
+#define N_RATES_24	ARRAY_SIZE(iwl_cfg80211_rates)
+#define RATES_52_OFFS	4
+#define N_RATES_52	(N_RATES_24 - RATES_52_OFFS)
+
+/* EEPROM reading functions */
+
+static u16 iwl_eeprom_query16(const u8 *eeprom, size_t eeprom_size, int offset)
+{
+	if (WARN_ON(offset + sizeof(u16) > eeprom_size))
+		return 0;
+	return le16_to_cpup((__le16 *)(eeprom + offset));
+}
+
+static u32 eeprom_indirect_address(const u8 *eeprom, size_t eeprom_size,
+				   u32 address)
+{
+	u16 offset = 0;
+
+	if ((address & INDIRECT_ADDRESS) == 0)
+		return address;
+
+	switch (address & INDIRECT_TYPE_MSK) {
+	case INDIRECT_HOST:
+		offset = iwl_eeprom_query16(eeprom, eeprom_size,
+					    EEPROM_LINK_HOST);
+		break;
+	case INDIRECT_GENERAL:
+		offset = iwl_eeprom_query16(eeprom, eeprom_size,
+					    EEPROM_LINK_GENERAL);
+		break;
+	case INDIRECT_REGULATORY:
+		offset = iwl_eeprom_query16(eeprom, eeprom_size,
+					    EEPROM_LINK_REGULATORY);
+		break;
+	case INDIRECT_TXP_LIMIT:
+		offset = iwl_eeprom_query16(eeprom, eeprom_size,
+					    EEPROM_LINK_TXP_LIMIT);
+		break;
+	case INDIRECT_TXP_LIMIT_SIZE:
+		offset = iwl_eeprom_query16(eeprom, eeprom_size,
+					    EEPROM_LINK_TXP_LIMIT_SIZE);
+		break;
+	case INDIRECT_CALIBRATION:
+		offset = iwl_eeprom_query16(eeprom, eeprom_size,
+					    EEPROM_LINK_CALIBRATION);
+		break;
+	case INDIRECT_PROCESS_ADJST:
+		offset = iwl_eeprom_query16(eeprom, eeprom_size,
+					    EEPROM_LINK_PROCESS_ADJST);
+		break;
+	case INDIRECT_OTHERS:
+		offset = iwl_eeprom_query16(eeprom, eeprom_size,
+					    EEPROM_LINK_OTHERS);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	/* translate the offset from words to byte */
+	return (address & ADDRESS_MSK) + (offset << 1);
+}
+
+static const u8 *iwl_eeprom_query_addr(const u8 *eeprom, size_t eeprom_size,
+				       u32 offset)
+{
+	u32 address = eeprom_indirect_address(eeprom, eeprom_size, offset);
+
+	if (WARN_ON(address >= eeprom_size))
+		return NULL;
+
+	return &eeprom[address];
+}
+
+static int iwl_eeprom_read_calib(const u8 *eeprom, size_t eeprom_size,
+				 struct iwl_nvm_data *data)
+{
+	struct iwl_eeprom_calib_hdr *hdr;
+
+	hdr = (void *)iwl_eeprom_query_addr(eeprom, eeprom_size,
+					    EEPROM_CALIB_ALL);
+	if (!hdr)
+		return -ENODATA;
+	data->calib_version = hdr->version;
+	data->calib_voltage = hdr->voltage;
+
+	return 0;
+}
+
+/**
+ * enum iwl_eeprom_channel_flags - channel flags in EEPROM
+ * @EEPROM_CHANNEL_VALID: channel is usable for this SKU/geo
+ * @EEPROM_CHANNEL_IBSS: usable as an IBSS channel
+ * @EEPROM_CHANNEL_ACTIVE: active scanning allowed
+ * @EEPROM_CHANNEL_RADAR: radar detection required
+ * @EEPROM_CHANNEL_WIDE: 20 MHz channel okay (?)
+ * @EEPROM_CHANNEL_DFS: dynamic freq selection candidate
+ */
+enum iwl_eeprom_channel_flags {
+	EEPROM_CHANNEL_VALID = BIT(0),
+	EEPROM_CHANNEL_IBSS = BIT(1),
+	EEPROM_CHANNEL_ACTIVE = BIT(3),
+	EEPROM_CHANNEL_RADAR = BIT(4),
+	EEPROM_CHANNEL_WIDE = BIT(5),
+	EEPROM_CHANNEL_DFS = BIT(7),
+};
+
+/**
+ * struct iwl_eeprom_channel - EEPROM channel data
+ * @flags: %EEPROM_CHANNEL_* flags
+ * @max_power_avg: max power (in dBm) on this channel, at most 31 dBm
+ */
+struct iwl_eeprom_channel {
+	u8 flags;
+	s8 max_power_avg;
+} __packed;
+
+enum iwl_eeprom_enhanced_txpwr_flags {
+	IWL_EEPROM_ENH_TXP_FL_VALID = BIT(0),
+	IWL_EEPROM_ENH_TXP_FL_BAND_52G = BIT(1),
+	IWL_EEPROM_ENH_TXP_FL_OFDM = BIT(2),
+	IWL_EEPROM_ENH_TXP_FL_40MHZ = BIT(3),
+	IWL_EEPROM_ENH_TXP_FL_HT_AP = BIT(4),
+	IWL_EEPROM_ENH_TXP_FL_RES1 = BIT(5),
+	IWL_EEPROM_ENH_TXP_FL_RES2 = BIT(6),
+	IWL_EEPROM_ENH_TXP_FL_COMMON_TYPE = BIT(7),
+};
+
+/**
+ * struct iwl_eeprom_enhanced_txpwr - enhanced regulatory TX power limits
+ * @flags: entry flags
+ * @channel: channel number
+ * @chain_a_max: chain a max power in 1/2 dBm
+ * @chain_b_max: chain b max power in 1/2 dBm
+ * @chain_c_max: chain c max power in 1/2 dBm
+ * @delta_20_in_40: 20-in-40 deltas (hi/lo)
+ * @mimo2_max: mimo2 max power in 1/2 dBm
+ * @mimo3_max: mimo3 max power in 1/2 dBm
+ *
+ * This structure presents the enhanced regulatory tx power limit layout
+ * in an EEPROM image.
+ */
+struct iwl_eeprom_enhanced_txpwr {
+	u8 flags;
+	u8 channel;
+	s8 chain_a_max;
+	s8 chain_b_max;
+	s8 chain_c_max;
+	u8 delta_20_in_40;
+	s8 mimo2_max;
+	s8 mimo3_max;
+} __packed;
+
+static s8 iwl_get_max_txpwr_half_dbm(const struct iwl_nvm_data *data,
+				     struct iwl_eeprom_enhanced_txpwr *txp)
+{
+	s8 result = 0; /* (.5 dBm) */
+
+	/* Take the highest tx power from any valid chains */
+	if (data->valid_tx_ant & ANT_A && txp->chain_a_max > result)
+		result = txp->chain_a_max;
+
+	if (data->valid_tx_ant & ANT_B && txp->chain_b_max > result)
+		result = txp->chain_b_max;
+
+	if (data->valid_tx_ant & ANT_C && txp->chain_c_max > result)
+		result = txp->chain_c_max;
+
+	if ((data->valid_tx_ant == ANT_AB ||
+	     data->valid_tx_ant == ANT_BC ||
+	     data->valid_tx_ant == ANT_AC) && txp->mimo2_max > result)
+		result = txp->mimo2_max;
+
+	if (data->valid_tx_ant == ANT_ABC && txp->mimo3_max > result)
+		result = txp->mimo3_max;
+
+	return result;
+}
+
+#define EEPROM_TXP_OFFS	(0x00 | INDIRECT_ADDRESS | INDIRECT_TXP_LIMIT)
+#define EEPROM_TXP_ENTRY_LEN sizeof(struct iwl_eeprom_enhanced_txpwr)
+#define EEPROM_TXP_SZ_OFFS (0x00 | INDIRECT_ADDRESS | INDIRECT_TXP_LIMIT_SIZE)
+
+#define TXP_CHECK_AND_PRINT(x) \
+	((txp->flags & IWL_EEPROM_ENH_TXP_FL_##x) ? # x " " : "")
+
+static void
+iwl_eeprom_enh_txp_read_element(struct iwl_nvm_data *data,
+				struct iwl_eeprom_enhanced_txpwr *txp,
+				int n_channels, s8 max_txpower_avg)
+{
+	int ch_idx;
+	enum nl80211_band band;
+
+	band = txp->flags & IWL_EEPROM_ENH_TXP_FL_BAND_52G ?
+		NL80211_BAND_5GHZ : NL80211_BAND_2GHZ;
+
+	for (ch_idx = 0; ch_idx < n_channels; ch_idx++) {
+		struct ieee80211_channel *chan = &data->channels[ch_idx];
+
+		/* update matching channel or from common data only */
+		if (txp->channel != 0 && chan->hw_value != txp->channel)
+			continue;
+
+		/* update matching band only */
+		if (band != chan->band)
+			continue;
+
+		if (chan->max_power < max_txpower_avg &&
+		    !(txp->flags & IWL_EEPROM_ENH_TXP_FL_40MHZ))
+			chan->max_power = max_txpower_avg;
+	}
+}
+
+static void iwl_eeprom_enhanced_txpower(struct device *dev,
+					struct iwl_nvm_data *data,
+					const u8 *eeprom, size_t eeprom_size,
+					int n_channels)
+{
+	struct iwl_eeprom_enhanced_txpwr *txp_array, *txp;
+	int idx, entries;
+	__le16 *txp_len;
+	s8 max_txp_avg_halfdbm;
+
+	BUILD_BUG_ON(sizeof(struct iwl_eeprom_enhanced_txpwr) != 8);
+
+	/* the length is in 16-bit words, but we want entries */
+	txp_len = (__le16 *)iwl_eeprom_query_addr(eeprom, eeprom_size,
+						  EEPROM_TXP_SZ_OFFS);
+	entries = le16_to_cpup(txp_len) * 2 / EEPROM_TXP_ENTRY_LEN;
+
+	txp_array = (void *)iwl_eeprom_query_addr(eeprom, eeprom_size,
+						  EEPROM_TXP_OFFS);
+
+	for (idx = 0; idx < entries; idx++) {
+		txp = &txp_array[idx];
+		/* skip invalid entries */
+		if (!(txp->flags & IWL_EEPROM_ENH_TXP_FL_VALID))
+			continue;
+
+		IWL_DEBUG_EEPROM(dev, "%s %d:\t %s%s%s%s%s%s%s%s (0x%02x)\n",
+				 (txp->channel && (txp->flags &
+					IWL_EEPROM_ENH_TXP_FL_COMMON_TYPE)) ?
+					"Common " : (txp->channel) ?
+					"Channel" : "Common",
+				 (txp->channel),
+				 TXP_CHECK_AND_PRINT(VALID),
+				 TXP_CHECK_AND_PRINT(BAND_52G),
+				 TXP_CHECK_AND_PRINT(OFDM),
+				 TXP_CHECK_AND_PRINT(40MHZ),
+				 TXP_CHECK_AND_PRINT(HT_AP),
+				 TXP_CHECK_AND_PRINT(RES1),
+				 TXP_CHECK_AND_PRINT(RES2),
+				 TXP_CHECK_AND_PRINT(COMMON_TYPE),
+				 txp->flags);
+		IWL_DEBUG_EEPROM(dev,
+				 "\t\t chain_A: %d chain_B: %d chain_C: %d\n",
+				 txp->chain_a_max, txp->chain_b_max,
+				 txp->chain_c_max);
+		IWL_DEBUG_EEPROM(dev,
+				 "\t\t MIMO2: %d MIMO3: %d High 20_on_40: 0x%02x Low 20_on_40: 0x%02x\n",
+				 txp->mimo2_max, txp->mimo3_max,
+				 ((txp->delta_20_in_40 & 0xf0) >> 4),
+				 (txp->delta_20_in_40 & 0x0f));
+
+		max_txp_avg_halfdbm = iwl_get_max_txpwr_half_dbm(data, txp);
+
+		iwl_eeprom_enh_txp_read_element(data, txp, n_channels,
+				DIV_ROUND_UP(max_txp_avg_halfdbm, 2));
+
+		if (max_txp_avg_halfdbm > data->max_tx_pwr_half_dbm)
+			data->max_tx_pwr_half_dbm = max_txp_avg_halfdbm;
+	}
+}
+
+static void iwl_init_band_reference(const struct iwl_cfg *cfg,
+				    const u8 *eeprom, size_t eeprom_size,
+				    int eeprom_band, int *eeprom_ch_count,
+				    const struct iwl_eeprom_channel **ch_info,
+				    const u8 **eeprom_ch_array)
+{
+	u32 offset = cfg->eeprom_params->regulatory_bands[eeprom_band - 1];
+
+	offset |= INDIRECT_ADDRESS | INDIRECT_REGULATORY;
+
+	*ch_info = (void *)iwl_eeprom_query_addr(eeprom, eeprom_size, offset);
+
+	switch (eeprom_band) {
+	case 1:		/* 2.4GHz band */
+		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_1);
+		*eeprom_ch_array = iwl_eeprom_band_1;
+		break;
+	case 2:		/* 4.9GHz band */
+		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_2);
+		*eeprom_ch_array = iwl_eeprom_band_2;
+		break;
+	case 3:		/* 5.2GHz band */
+		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_3);
+		*eeprom_ch_array = iwl_eeprom_band_3;
+		break;
+	case 4:		/* 5.5GHz band */
+		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_4);
+		*eeprom_ch_array = iwl_eeprom_band_4;
+		break;
+	case 5:		/* 5.7GHz band */
+		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_5);
+		*eeprom_ch_array = iwl_eeprom_band_5;
+		break;
+	case 6:		/* 2.4GHz ht40 channels */
+		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_6);
+		*eeprom_ch_array = iwl_eeprom_band_6;
+		break;
+	case 7:		/* 5 GHz ht40 channels */
+		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_7);
+		*eeprom_ch_array = iwl_eeprom_band_7;
+		break;
+	default:
+		*eeprom_ch_count = 0;
+		*eeprom_ch_array = NULL;
+		WARN_ON(1);
+	}
+}
+
+#define CHECK_AND_PRINT(x) \
+	((eeprom_ch->flags & EEPROM_CHANNEL_##x) ? # x " " : "")
+
+static void iwl_mod_ht40_chan_info(struct device *dev,
+				   struct iwl_nvm_data *data, int n_channels,
+				   enum nl80211_band band, u16 channel,
+				   const struct iwl_eeprom_channel *eeprom_ch,
+				   u8 clear_ht40_extension_channel)
+{
+	struct ieee80211_channel *chan = NULL;
+	int i;
+
+	for (i = 0; i < n_channels; i++) {
+		if (data->channels[i].band != band)
+			continue;
+		if (data->channels[i].hw_value != channel)
+			continue;
+		chan = &data->channels[i];
+		break;
+	}
+
+	if (!chan)
+		return;
+
+	IWL_DEBUG_EEPROM(dev,
+			 "HT40 Ch. %d [%sGHz] %s%s%s%s%s(0x%02x %ddBm): Ad-Hoc %ssupported\n",
+			 channel,
+			 band == NL80211_BAND_5GHZ ? "5.2" : "2.4",
+			 CHECK_AND_PRINT(IBSS),
+			 CHECK_AND_PRINT(ACTIVE),
+			 CHECK_AND_PRINT(RADAR),
+			 CHECK_AND_PRINT(WIDE),
+			 CHECK_AND_PRINT(DFS),
+			 eeprom_ch->flags,
+			 eeprom_ch->max_power_avg,
+			 ((eeprom_ch->flags & EEPROM_CHANNEL_IBSS) &&
+			  !(eeprom_ch->flags & EEPROM_CHANNEL_RADAR)) ? ""
+								      : "not ");
+
+	if (eeprom_ch->flags & EEPROM_CHANNEL_VALID)
+		chan->flags &= ~clear_ht40_extension_channel;
+}
+
+#define CHECK_AND_PRINT_I(x)	\
+	((eeprom_ch_info[ch_idx].flags & EEPROM_CHANNEL_##x) ? # x " " : "")
+
+static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
+				struct iwl_nvm_data *data,
+				const u8 *eeprom, size_t eeprom_size)
+{
+	int band, ch_idx;
+	const struct iwl_eeprom_channel *eeprom_ch_info;
+	const u8 *eeprom_ch_array;
+	int eeprom_ch_count;
+	int n_channels = 0;
+
+	/*
+	 * Loop through the 5 EEPROM bands and add them to the parse list
+	 */
+	for (band = 1; band <= 5; band++) {
+		struct ieee80211_channel *channel;
+
+		iwl_init_band_reference(cfg, eeprom, eeprom_size, band,
+					&eeprom_ch_count, &eeprom_ch_info,
+					&eeprom_ch_array);
+
+		/* Loop through each band adding each of the channels */
+		for (ch_idx = 0; ch_idx < eeprom_ch_count; ch_idx++) {
+			const struct iwl_eeprom_channel *eeprom_ch;
+
+			eeprom_ch = &eeprom_ch_info[ch_idx];
+
+			if (!(eeprom_ch->flags & EEPROM_CHANNEL_VALID)) {
+				IWL_DEBUG_EEPROM(dev,
+						 "Ch. %d Flags %x [%sGHz] - No traffic\n",
+						 eeprom_ch_array[ch_idx],
+						 eeprom_ch_info[ch_idx].flags,
+						 (band != 1) ? "5.2" : "2.4");
+				continue;
+			}
+
+			channel = &data->channels[n_channels];
+			n_channels++;
+
+			channel->hw_value = eeprom_ch_array[ch_idx];
+			channel->band = (band == 1) ? NL80211_BAND_2GHZ
+						    : NL80211_BAND_5GHZ;
+			channel->center_freq =
+				ieee80211_channel_to_frequency(
+					channel->hw_value, channel->band);
+
+			/* set no-HT40, will enable as appropriate later */
+			channel->flags = IEEE80211_CHAN_NO_HT40;
+
+			if (!(eeprom_ch->flags & EEPROM_CHANNEL_IBSS))
+				channel->flags |= IEEE80211_CHAN_NO_IR;
+
+			if (!(eeprom_ch->flags & EEPROM_CHANNEL_ACTIVE))
+				channel->flags |= IEEE80211_CHAN_NO_IR;
+
+			if (eeprom_ch->flags & EEPROM_CHANNEL_RADAR)
+				channel->flags |= IEEE80211_CHAN_RADAR;
+
+			/* Initialize regulatory-based run-time data */
+			channel->max_power =
+				eeprom_ch_info[ch_idx].max_power_avg;
+			IWL_DEBUG_EEPROM(dev,
+					 "Ch. %d [%sGHz] %s%s%s%s%s%s(0x%02x %ddBm): Ad-Hoc %ssupported\n",
+					 channel->hw_value,
+					 (band != 1) ? "5.2" : "2.4",
+					 CHECK_AND_PRINT_I(VALID),
+					 CHECK_AND_PRINT_I(IBSS),
+					 CHECK_AND_PRINT_I(ACTIVE),
+					 CHECK_AND_PRINT_I(RADAR),
+					 CHECK_AND_PRINT_I(WIDE),
+					 CHECK_AND_PRINT_I(DFS),
+					 eeprom_ch_info[ch_idx].flags,
+					 eeprom_ch_info[ch_idx].max_power_avg,
+					 ((eeprom_ch_info[ch_idx].flags &
+							EEPROM_CHANNEL_IBSS) &&
+					  !(eeprom_ch_info[ch_idx].flags &
+							EEPROM_CHANNEL_RADAR))
+						? "" : "not ");
+		}
+	}
+
+	if (cfg->eeprom_params->enhanced_txpower) {
+		/*
+		 * for newer device (6000 series and up)
+		 * EEPROM contain enhanced tx power information
+		 * driver need to process addition information
+		 * to determine the max channel tx power limits
+		 */
+		iwl_eeprom_enhanced_txpower(dev, data, eeprom, eeprom_size,
+					    n_channels);
+	} else {
+		/* All others use data from channel map */
+		int i;
+
+		data->max_tx_pwr_half_dbm = -128;
+
+		for (i = 0; i < n_channels; i++)
+			data->max_tx_pwr_half_dbm =
+				max_t(s8, data->max_tx_pwr_half_dbm,
+				      data->channels[i].max_power * 2);
+	}
+
+	/* Check if we do have HT40 channels */
+	if (cfg->eeprom_params->regulatory_bands[5] ==
+				EEPROM_REGULATORY_BAND_NO_HT40 &&
+	    cfg->eeprom_params->regulatory_bands[6] ==
+				EEPROM_REGULATORY_BAND_NO_HT40)
+		return n_channels;
+
+	/* Two additional EEPROM bands for 2.4 and 5 GHz HT40 channels */
+	for (band = 6; band <= 7; band++) {
+		enum nl80211_band ieeeband;
+
+		iwl_init_band_reference(cfg, eeprom, eeprom_size, band,
+					&eeprom_ch_count, &eeprom_ch_info,
+					&eeprom_ch_array);
+
+		/* EEPROM band 6 is 2.4, band 7 is 5 GHz */
+		ieeeband = (band == 6) ? NL80211_BAND_2GHZ
+				       : NL80211_BAND_5GHZ;
+
+		/* Loop through each band adding each of the channels */
+		for (ch_idx = 0; ch_idx < eeprom_ch_count; ch_idx++) {
+			/* Set up driver's info for lower half */
+			iwl_mod_ht40_chan_info(dev, data, n_channels, ieeeband,
+					       eeprom_ch_array[ch_idx],
+					       &eeprom_ch_info[ch_idx],
+					       IEEE80211_CHAN_NO_HT40PLUS);
+
+			/* Set up driver's info for upper half */
+			iwl_mod_ht40_chan_info(dev, data, n_channels, ieeeband,
+					       eeprom_ch_array[ch_idx] + 4,
+					       &eeprom_ch_info[ch_idx],
+					       IEEE80211_CHAN_NO_HT40MINUS);
+		}
+	}
+
+	return n_channels;
+}
 /*
  * EEPROM access time values:
  *
@@ -391,3 +1026,125 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 
 	return ret;
 }
+
+static void iwl_init_sbands(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+			    struct iwl_nvm_data *data,
+			    const u8 *eeprom, size_t eeprom_size)
+{
+	struct device *dev = trans->dev;
+	int n_channels = iwl_init_channel_map(dev, cfg, data,
+					      eeprom, eeprom_size);
+	int n_used = 0;
+	struct ieee80211_supported_band *sband;
+
+	sband = &data->bands[NL80211_BAND_2GHZ];
+	sband->band = NL80211_BAND_2GHZ;
+	sband->bitrates = &iwl_cfg80211_rates[RATES_24_OFFS];
+	sband->n_bitrates = N_RATES_24;
+	n_used += iwl_init_sband_channels(data, sband, n_channels,
+					  NL80211_BAND_2GHZ);
+	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_2GHZ,
+			     data->valid_tx_ant, data->valid_rx_ant);
+
+	sband = &data->bands[NL80211_BAND_5GHZ];
+	sband->band = NL80211_BAND_5GHZ;
+	sband->bitrates = &iwl_cfg80211_rates[RATES_52_OFFS];
+	sband->n_bitrates = N_RATES_52;
+	n_used += iwl_init_sband_channels(data, sband, n_channels,
+					  NL80211_BAND_5GHZ);
+	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_5GHZ,
+			     data->valid_tx_ant, data->valid_rx_ant);
+
+	if (n_channels != n_used)
+		IWL_ERR_DEV(dev, "EEPROM: used only %d of %d channels\n",
+			    n_used, n_channels);
+}
+
+/* EEPROM data functions */
+struct iwl_nvm_data *
+iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+		      const u8 *eeprom, size_t eeprom_size)
+{
+	struct iwl_nvm_data *data;
+	struct device *dev = trans->dev;
+	const void *tmp;
+	u16 radio_cfg, sku;
+
+	if (WARN_ON(!cfg || !cfg->eeprom_params))
+		return NULL;
+
+	data = kzalloc(struct_size(data, channels, IWL_NUM_CHANNELS),
+		       GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	/* get MAC address(es) */
+	tmp = iwl_eeprom_query_addr(eeprom, eeprom_size, EEPROM_MAC_ADDRESS);
+	if (!tmp)
+		goto err_free;
+	memcpy(data->hw_addr, tmp, ETH_ALEN);
+	data->n_hw_addrs = iwl_eeprom_query16(eeprom, eeprom_size,
+					      EEPROM_NUM_MAC_ADDRESS);
+
+	if (iwl_eeprom_read_calib(eeprom, eeprom_size, data))
+		goto err_free;
+
+	tmp = iwl_eeprom_query_addr(eeprom, eeprom_size, EEPROM_XTAL);
+	if (!tmp)
+		goto err_free;
+	memcpy(data->xtal_calib, tmp, sizeof(data->xtal_calib));
+
+	tmp = iwl_eeprom_query_addr(eeprom, eeprom_size,
+				    EEPROM_RAW_TEMPERATURE);
+	if (!tmp)
+		goto err_free;
+	data->raw_temperature = *(__le16 *)tmp;
+
+	tmp = iwl_eeprom_query_addr(eeprom, eeprom_size,
+				    EEPROM_KELVIN_TEMPERATURE);
+	if (!tmp)
+		goto err_free;
+	data->kelvin_temperature = *(__le16 *)tmp;
+	data->kelvin_voltage = *((__le16 *)tmp + 1);
+
+	radio_cfg =
+		iwl_eeprom_query16(eeprom, eeprom_size, EEPROM_RADIO_CONFIG);
+	data->radio_cfg_dash = EEPROM_RF_CFG_DASH_MSK(radio_cfg);
+	data->radio_cfg_pnum = EEPROM_RF_CFG_PNUM_MSK(radio_cfg);
+	data->radio_cfg_step = EEPROM_RF_CFG_STEP_MSK(radio_cfg);
+	data->radio_cfg_type = EEPROM_RF_CFG_TYPE_MSK(radio_cfg);
+	data->valid_rx_ant = EEPROM_RF_CFG_RX_ANT_MSK(radio_cfg);
+	data->valid_tx_ant = EEPROM_RF_CFG_TX_ANT_MSK(radio_cfg);
+
+	sku = iwl_eeprom_query16(eeprom, eeprom_size,
+				 EEPROM_SKU_CAP);
+	data->sku_cap_11n_enable = sku & EEPROM_SKU_CAP_11N_ENABLE;
+	data->sku_cap_amt_enable = sku & EEPROM_SKU_CAP_AMT_ENABLE;
+	data->sku_cap_band_24ghz_enable = sku & EEPROM_SKU_CAP_BAND_24GHZ;
+	data->sku_cap_band_52ghz_enable = sku & EEPROM_SKU_CAP_BAND_52GHZ;
+	data->sku_cap_ipan_enable = sku & EEPROM_SKU_CAP_IPAN_ENABLE;
+	if (iwlwifi_mod_params.disable_11n & IWL_DISABLE_HT_ALL)
+		data->sku_cap_11n_enable = false;
+
+	data->nvm_version = iwl_eeprom_query16(eeprom, eeprom_size,
+					       EEPROM_VERSION);
+
+	/* check overrides (some devices have wrong EEPROM) */
+	if (cfg->valid_tx_ant)
+		data->valid_tx_ant = cfg->valid_tx_ant;
+	if (cfg->valid_rx_ant)
+		data->valid_rx_ant = cfg->valid_rx_ant;
+
+	if (!data->valid_tx_ant || !data->valid_rx_ant) {
+		IWL_ERR_DEV(dev, "invalid antennas (0x%x, 0x%x)\n",
+			    data->valid_tx_ant, data->valid_rx_ant);
+		goto err_free;
+	}
+
+	iwl_init_sbands(trans, cfg, data, eeprom, eeprom_size);
+
+	return data;
+ err_free:
+	kfree(data);
+	return NULL;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 7bb3011e12e3..65b7c68e5ca7 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -26,7 +26,7 @@
 
 #include <asm/div64.h>
 
-#include "iwl-eeprom-parse.h"
+#include "iwl-nvm-utils.h"
 #include "iwl-io.h"
 #include "iwl-trans.h"
 #include "iwl-op-mode.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index d201440066ea..3fcc08b3c0db 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -12,7 +12,7 @@
 #include "fw/api/debug.h"
 #include "fw/api/paging.h"
 #include "fw/api/power.h"
-#include "iwl-eeprom-parse.h"
+#include "iwl-nvm-utils.h"
 #include "fw/acpi.h"
 #include "fw/regulatory.h"
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
deleted file mode 100644
index 2b290fab1ef2..000000000000
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
+++ /dev/null
@@ -1,882 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
-/*
- * Copyright (C) 2005-2014, 2018-2021, 2023 Intel Corporation
- * Copyright (C) 2015 Intel Mobile Communications GmbH
- */
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/export.h>
-#include "iwl-drv.h"
-#include "iwl-modparams.h"
-#include "iwl-eeprom-parse.h"
-
-#if IS_ENABLED(CONFIG_IWLDVM)
-/* EEPROM offset definitions */
-
-/* indirect access definitions */
-#define ADDRESS_MSK                 0x0000FFFF
-#define INDIRECT_TYPE_MSK           0x000F0000
-#define INDIRECT_HOST               0x00010000
-#define INDIRECT_GENERAL            0x00020000
-#define INDIRECT_REGULATORY         0x00030000
-#define INDIRECT_CALIBRATION        0x00040000
-#define INDIRECT_PROCESS_ADJST      0x00050000
-#define INDIRECT_OTHERS             0x00060000
-#define INDIRECT_TXP_LIMIT          0x00070000
-#define INDIRECT_TXP_LIMIT_SIZE     0x00080000
-#define INDIRECT_ADDRESS            0x00100000
-
-/* corresponding link offsets in EEPROM */
-#define EEPROM_LINK_HOST             (2*0x64)
-#define EEPROM_LINK_GENERAL          (2*0x65)
-#define EEPROM_LINK_REGULATORY       (2*0x66)
-#define EEPROM_LINK_CALIBRATION      (2*0x67)
-#define EEPROM_LINK_PROCESS_ADJST    (2*0x68)
-#define EEPROM_LINK_OTHERS           (2*0x69)
-#define EEPROM_LINK_TXP_LIMIT        (2*0x6a)
-#define EEPROM_LINK_TXP_LIMIT_SIZE   (2*0x6b)
-
-/* General */
-#define EEPROM_DEVICE_ID                    (2*0x08)	/* 2 bytes */
-#define EEPROM_SUBSYSTEM_ID		    (2*0x0A)	/* 2 bytes */
-#define EEPROM_MAC_ADDRESS                  (2*0x15)	/* 6  bytes */
-#define EEPROM_BOARD_REVISION               (2*0x35)	/* 2  bytes */
-#define EEPROM_BOARD_PBA_NUMBER             (2*0x3B+1)	/* 9  bytes */
-#define EEPROM_VERSION                      (2*0x44)	/* 2  bytes */
-#define EEPROM_SKU_CAP                      (2*0x45)	/* 2  bytes */
-#define EEPROM_OEM_MODE                     (2*0x46)	/* 2  bytes */
-#define EEPROM_RADIO_CONFIG                 (2*0x48)	/* 2  bytes */
-#define EEPROM_NUM_MAC_ADDRESS              (2*0x4C)	/* 2  bytes */
-
-/* calibration */
-struct iwl_eeprom_calib_hdr {
-	u8 version;
-	u8 pa_type;
-	__le16 voltage;
-} __packed;
-
-#define EEPROM_CALIB_ALL	(INDIRECT_ADDRESS | INDIRECT_CALIBRATION)
-#define EEPROM_XTAL		((2*0x128) | EEPROM_CALIB_ALL)
-
-/* temperature */
-#define EEPROM_KELVIN_TEMPERATURE	((2*0x12A) | EEPROM_CALIB_ALL)
-#define EEPROM_RAW_TEMPERATURE		((2*0x12B) | EEPROM_CALIB_ALL)
-
-/* SKU Capabilities (actual values from EEPROM definition) */
-enum eeprom_sku_bits {
-	EEPROM_SKU_CAP_BAND_24GHZ	= BIT(4),
-	EEPROM_SKU_CAP_BAND_52GHZ	= BIT(5),
-	EEPROM_SKU_CAP_11N_ENABLE	= BIT(6),
-	EEPROM_SKU_CAP_AMT_ENABLE	= BIT(7),
-	EEPROM_SKU_CAP_IPAN_ENABLE	= BIT(8)
-};
-
-/* radio config bits (actual values from EEPROM definition) */
-#define EEPROM_RF_CFG_TYPE_MSK(x)   (x & 0x3)         /* bits 0-1   */
-#define EEPROM_RF_CFG_STEP_MSK(x)   ((x >> 2)  & 0x3) /* bits 2-3   */
-#define EEPROM_RF_CFG_DASH_MSK(x)   ((x >> 4)  & 0x3) /* bits 4-5   */
-#define EEPROM_RF_CFG_PNUM_MSK(x)   ((x >> 6)  & 0x3) /* bits 6-7   */
-#define EEPROM_RF_CFG_TX_ANT_MSK(x) ((x >> 8)  & 0xF) /* bits 8-11  */
-#define EEPROM_RF_CFG_RX_ANT_MSK(x) ((x >> 12) & 0xF) /* bits 12-15 */
-
-
-/*
- * EEPROM bands
- * These are the channel numbers from each band in the order
- * that they are stored in the EEPROM band information. Note
- * that EEPROM bands aren't the same as mac80211 bands, and
- * there are even special "ht40 bands" in the EEPROM.
- */
-static const u8 iwl_eeprom_band_1[14] = { /* 2.4 GHz */
-	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
-};
-
-static const u8 iwl_eeprom_band_2[] = {	/* 4915-5080MHz */
-	183, 184, 185, 187, 188, 189, 192, 196, 7, 8, 11, 12, 16
-};
-
-static const u8 iwl_eeprom_band_3[] = {	/* 5170-5320MHz */
-	34, 36, 38, 40, 42, 44, 46, 48, 52, 56, 60, 64
-};
-
-static const u8 iwl_eeprom_band_4[] = {	/* 5500-5700MHz */
-	100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140
-};
-
-static const u8 iwl_eeprom_band_5[] = {	/* 5725-5825MHz */
-	145, 149, 153, 157, 161, 165
-};
-
-static const u8 iwl_eeprom_band_6[] = {	/* 2.4 ht40 channel */
-	1, 2, 3, 4, 5, 6, 7
-};
-
-static const u8 iwl_eeprom_band_7[] = {	/* 5.2 ht40 channel */
-	36, 44, 52, 60, 100, 108, 116, 124, 132, 149, 157
-};
-
-#define IWL_NUM_CHANNELS	(ARRAY_SIZE(iwl_eeprom_band_1) + \
-				 ARRAY_SIZE(iwl_eeprom_band_2) + \
-				 ARRAY_SIZE(iwl_eeprom_band_3) + \
-				 ARRAY_SIZE(iwl_eeprom_band_4) + \
-				 ARRAY_SIZE(iwl_eeprom_band_5))
-
-/* rate data (static) */
-static struct ieee80211_rate iwl_cfg80211_rates[] = {
-	{ .bitrate = 1 * 10, .hw_value = 0, .hw_value_short = 0, },
-	{ .bitrate = 2 * 10, .hw_value = 1, .hw_value_short = 1,
-	  .flags = IEEE80211_RATE_SHORT_PREAMBLE, },
-	{ .bitrate = 5.5 * 10, .hw_value = 2, .hw_value_short = 2,
-	  .flags = IEEE80211_RATE_SHORT_PREAMBLE, },
-	{ .bitrate = 11 * 10, .hw_value = 3, .hw_value_short = 3,
-	  .flags = IEEE80211_RATE_SHORT_PREAMBLE, },
-	{ .bitrate = 6 * 10, .hw_value = 4, .hw_value_short = 4, },
-	{ .bitrate = 9 * 10, .hw_value = 5, .hw_value_short = 5, },
-	{ .bitrate = 12 * 10, .hw_value = 6, .hw_value_short = 6, },
-	{ .bitrate = 18 * 10, .hw_value = 7, .hw_value_short = 7, },
-	{ .bitrate = 24 * 10, .hw_value = 8, .hw_value_short = 8, },
-	{ .bitrate = 36 * 10, .hw_value = 9, .hw_value_short = 9, },
-	{ .bitrate = 48 * 10, .hw_value = 10, .hw_value_short = 10, },
-	{ .bitrate = 54 * 10, .hw_value = 11, .hw_value_short = 11, },
-};
-#define RATES_24_OFFS	0
-#define N_RATES_24	ARRAY_SIZE(iwl_cfg80211_rates)
-#define RATES_52_OFFS	4
-#define N_RATES_52	(N_RATES_24 - RATES_52_OFFS)
-
-/* EEPROM reading functions */
-
-static u16 iwl_eeprom_query16(const u8 *eeprom, size_t eeprom_size, int offset)
-{
-	if (WARN_ON(offset + sizeof(u16) > eeprom_size))
-		return 0;
-	return le16_to_cpup((__le16 *)(eeprom + offset));
-}
-
-static u32 eeprom_indirect_address(const u8 *eeprom, size_t eeprom_size,
-				   u32 address)
-{
-	u16 offset = 0;
-
-	if ((address & INDIRECT_ADDRESS) == 0)
-		return address;
-
-	switch (address & INDIRECT_TYPE_MSK) {
-	case INDIRECT_HOST:
-		offset = iwl_eeprom_query16(eeprom, eeprom_size,
-					    EEPROM_LINK_HOST);
-		break;
-	case INDIRECT_GENERAL:
-		offset = iwl_eeprom_query16(eeprom, eeprom_size,
-					    EEPROM_LINK_GENERAL);
-		break;
-	case INDIRECT_REGULATORY:
-		offset = iwl_eeprom_query16(eeprom, eeprom_size,
-					    EEPROM_LINK_REGULATORY);
-		break;
-	case INDIRECT_TXP_LIMIT:
-		offset = iwl_eeprom_query16(eeprom, eeprom_size,
-					    EEPROM_LINK_TXP_LIMIT);
-		break;
-	case INDIRECT_TXP_LIMIT_SIZE:
-		offset = iwl_eeprom_query16(eeprom, eeprom_size,
-					    EEPROM_LINK_TXP_LIMIT_SIZE);
-		break;
-	case INDIRECT_CALIBRATION:
-		offset = iwl_eeprom_query16(eeprom, eeprom_size,
-					    EEPROM_LINK_CALIBRATION);
-		break;
-	case INDIRECT_PROCESS_ADJST:
-		offset = iwl_eeprom_query16(eeprom, eeprom_size,
-					    EEPROM_LINK_PROCESS_ADJST);
-		break;
-	case INDIRECT_OTHERS:
-		offset = iwl_eeprom_query16(eeprom, eeprom_size,
-					    EEPROM_LINK_OTHERS);
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	/* translate the offset from words to byte */
-	return (address & ADDRESS_MSK) + (offset << 1);
-}
-
-static const u8 *iwl_eeprom_query_addr(const u8 *eeprom, size_t eeprom_size,
-				       u32 offset)
-{
-	u32 address = eeprom_indirect_address(eeprom, eeprom_size, offset);
-
-	if (WARN_ON(address >= eeprom_size))
-		return NULL;
-
-	return &eeprom[address];
-}
-
-static int iwl_eeprom_read_calib(const u8 *eeprom, size_t eeprom_size,
-				 struct iwl_nvm_data *data)
-{
-	struct iwl_eeprom_calib_hdr *hdr;
-
-	hdr = (void *)iwl_eeprom_query_addr(eeprom, eeprom_size,
-					    EEPROM_CALIB_ALL);
-	if (!hdr)
-		return -ENODATA;
-	data->calib_version = hdr->version;
-	data->calib_voltage = hdr->voltage;
-
-	return 0;
-}
-
-/**
- * enum iwl_eeprom_channel_flags - channel flags in EEPROM
- * @EEPROM_CHANNEL_VALID: channel is usable for this SKU/geo
- * @EEPROM_CHANNEL_IBSS: usable as an IBSS channel
- * @EEPROM_CHANNEL_ACTIVE: active scanning allowed
- * @EEPROM_CHANNEL_RADAR: radar detection required
- * @EEPROM_CHANNEL_WIDE: 20 MHz channel okay (?)
- * @EEPROM_CHANNEL_DFS: dynamic freq selection candidate
- */
-enum iwl_eeprom_channel_flags {
-	EEPROM_CHANNEL_VALID = BIT(0),
-	EEPROM_CHANNEL_IBSS = BIT(1),
-	EEPROM_CHANNEL_ACTIVE = BIT(3),
-	EEPROM_CHANNEL_RADAR = BIT(4),
-	EEPROM_CHANNEL_WIDE = BIT(5),
-	EEPROM_CHANNEL_DFS = BIT(7),
-};
-
-/**
- * struct iwl_eeprom_channel - EEPROM channel data
- * @flags: %EEPROM_CHANNEL_* flags
- * @max_power_avg: max power (in dBm) on this channel, at most 31 dBm
- */
-struct iwl_eeprom_channel {
-	u8 flags;
-	s8 max_power_avg;
-} __packed;
-
-
-enum iwl_eeprom_enhanced_txpwr_flags {
-	IWL_EEPROM_ENH_TXP_FL_VALID = BIT(0),
-	IWL_EEPROM_ENH_TXP_FL_BAND_52G = BIT(1),
-	IWL_EEPROM_ENH_TXP_FL_OFDM = BIT(2),
-	IWL_EEPROM_ENH_TXP_FL_40MHZ = BIT(3),
-	IWL_EEPROM_ENH_TXP_FL_HT_AP = BIT(4),
-	IWL_EEPROM_ENH_TXP_FL_RES1 = BIT(5),
-	IWL_EEPROM_ENH_TXP_FL_RES2 = BIT(6),
-	IWL_EEPROM_ENH_TXP_FL_COMMON_TYPE = BIT(7),
-};
-
-/**
- * struct iwl_eeprom_enhanced_txpwr - enhanced regulatory TX power limits
- * @flags: entry flags
- * @channel: channel number
- * @chain_a_max: chain a max power in 1/2 dBm
- * @chain_b_max: chain b max power in 1/2 dBm
- * @chain_c_max: chain c max power in 1/2 dBm
- * @delta_20_in_40: 20-in-40 deltas (hi/lo)
- * @mimo2_max: mimo2 max power in 1/2 dBm
- * @mimo3_max: mimo3 max power in 1/2 dBm
- *
- * This structure presents the enhanced regulatory tx power limit layout
- * in an EEPROM image.
- */
-struct iwl_eeprom_enhanced_txpwr {
-	u8 flags;
-	u8 channel;
-	s8 chain_a_max;
-	s8 chain_b_max;
-	s8 chain_c_max;
-	u8 delta_20_in_40;
-	s8 mimo2_max;
-	s8 mimo3_max;
-} __packed;
-
-static s8 iwl_get_max_txpwr_half_dbm(const struct iwl_nvm_data *data,
-				     struct iwl_eeprom_enhanced_txpwr *txp)
-{
-	s8 result = 0; /* (.5 dBm) */
-
-	/* Take the highest tx power from any valid chains */
-	if (data->valid_tx_ant & ANT_A && txp->chain_a_max > result)
-		result = txp->chain_a_max;
-
-	if (data->valid_tx_ant & ANT_B && txp->chain_b_max > result)
-		result = txp->chain_b_max;
-
-	if (data->valid_tx_ant & ANT_C && txp->chain_c_max > result)
-		result = txp->chain_c_max;
-
-	if ((data->valid_tx_ant == ANT_AB ||
-	     data->valid_tx_ant == ANT_BC ||
-	     data->valid_tx_ant == ANT_AC) && txp->mimo2_max > result)
-		result = txp->mimo2_max;
-
-	if (data->valid_tx_ant == ANT_ABC && txp->mimo3_max > result)
-		result = txp->mimo3_max;
-
-	return result;
-}
-
-#define EEPROM_TXP_OFFS	(0x00 | INDIRECT_ADDRESS | INDIRECT_TXP_LIMIT)
-#define EEPROM_TXP_ENTRY_LEN sizeof(struct iwl_eeprom_enhanced_txpwr)
-#define EEPROM_TXP_SZ_OFFS (0x00 | INDIRECT_ADDRESS | INDIRECT_TXP_LIMIT_SIZE)
-
-#define TXP_CHECK_AND_PRINT(x) \
-	((txp->flags & IWL_EEPROM_ENH_TXP_FL_##x) ? # x " " : "")
-
-static void
-iwl_eeprom_enh_txp_read_element(struct iwl_nvm_data *data,
-				struct iwl_eeprom_enhanced_txpwr *txp,
-				int n_channels, s8 max_txpower_avg)
-{
-	int ch_idx;
-	enum nl80211_band band;
-
-	band = txp->flags & IWL_EEPROM_ENH_TXP_FL_BAND_52G ?
-		NL80211_BAND_5GHZ : NL80211_BAND_2GHZ;
-
-	for (ch_idx = 0; ch_idx < n_channels; ch_idx++) {
-		struct ieee80211_channel *chan = &data->channels[ch_idx];
-
-		/* update matching channel or from common data only */
-		if (txp->channel != 0 && chan->hw_value != txp->channel)
-			continue;
-
-		/* update matching band only */
-		if (band != chan->band)
-			continue;
-
-		if (chan->max_power < max_txpower_avg &&
-		    !(txp->flags & IWL_EEPROM_ENH_TXP_FL_40MHZ))
-			chan->max_power = max_txpower_avg;
-	}
-}
-
-static void iwl_eeprom_enhanced_txpower(struct device *dev,
-					struct iwl_nvm_data *data,
-					const u8 *eeprom, size_t eeprom_size,
-					int n_channels)
-{
-	struct iwl_eeprom_enhanced_txpwr *txp_array, *txp;
-	int idx, entries;
-	__le16 *txp_len;
-	s8 max_txp_avg_halfdbm;
-
-	BUILD_BUG_ON(sizeof(struct iwl_eeprom_enhanced_txpwr) != 8);
-
-	/* the length is in 16-bit words, but we want entries */
-	txp_len = (__le16 *)iwl_eeprom_query_addr(eeprom, eeprom_size,
-						  EEPROM_TXP_SZ_OFFS);
-	entries = le16_to_cpup(txp_len) * 2 / EEPROM_TXP_ENTRY_LEN;
-
-	txp_array = (void *)iwl_eeprom_query_addr(eeprom, eeprom_size,
-						  EEPROM_TXP_OFFS);
-
-	for (idx = 0; idx < entries; idx++) {
-		txp = &txp_array[idx];
-		/* skip invalid entries */
-		if (!(txp->flags & IWL_EEPROM_ENH_TXP_FL_VALID))
-			continue;
-
-		IWL_DEBUG_EEPROM(dev, "%s %d:\t %s%s%s%s%s%s%s%s (0x%02x)\n",
-				 (txp->channel && (txp->flags &
-					IWL_EEPROM_ENH_TXP_FL_COMMON_TYPE)) ?
-					"Common " : (txp->channel) ?
-					"Channel" : "Common",
-				 (txp->channel),
-				 TXP_CHECK_AND_PRINT(VALID),
-				 TXP_CHECK_AND_PRINT(BAND_52G),
-				 TXP_CHECK_AND_PRINT(OFDM),
-				 TXP_CHECK_AND_PRINT(40MHZ),
-				 TXP_CHECK_AND_PRINT(HT_AP),
-				 TXP_CHECK_AND_PRINT(RES1),
-				 TXP_CHECK_AND_PRINT(RES2),
-				 TXP_CHECK_AND_PRINT(COMMON_TYPE),
-				 txp->flags);
-		IWL_DEBUG_EEPROM(dev,
-				 "\t\t chain_A: %d chain_B: %d chain_C: %d\n",
-				 txp->chain_a_max, txp->chain_b_max,
-				 txp->chain_c_max);
-		IWL_DEBUG_EEPROM(dev,
-				 "\t\t MIMO2: %d MIMO3: %d High 20_on_40: 0x%02x Low 20_on_40: 0x%02x\n",
-				 txp->mimo2_max, txp->mimo3_max,
-				 ((txp->delta_20_in_40 & 0xf0) >> 4),
-				 (txp->delta_20_in_40 & 0x0f));
-
-		max_txp_avg_halfdbm = iwl_get_max_txpwr_half_dbm(data, txp);
-
-		iwl_eeprom_enh_txp_read_element(data, txp, n_channels,
-				DIV_ROUND_UP(max_txp_avg_halfdbm, 2));
-
-		if (max_txp_avg_halfdbm > data->max_tx_pwr_half_dbm)
-			data->max_tx_pwr_half_dbm = max_txp_avg_halfdbm;
-	}
-}
-
-static void iwl_init_band_reference(const struct iwl_cfg *cfg,
-				    const u8 *eeprom, size_t eeprom_size,
-				    int eeprom_band, int *eeprom_ch_count,
-				    const struct iwl_eeprom_channel **ch_info,
-				    const u8 **eeprom_ch_array)
-{
-	u32 offset = cfg->eeprom_params->regulatory_bands[eeprom_band - 1];
-
-	offset |= INDIRECT_ADDRESS | INDIRECT_REGULATORY;
-
-	*ch_info = (void *)iwl_eeprom_query_addr(eeprom, eeprom_size, offset);
-
-	switch (eeprom_band) {
-	case 1:		/* 2.4GHz band */
-		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_1);
-		*eeprom_ch_array = iwl_eeprom_band_1;
-		break;
-	case 2:		/* 4.9GHz band */
-		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_2);
-		*eeprom_ch_array = iwl_eeprom_band_2;
-		break;
-	case 3:		/* 5.2GHz band */
-		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_3);
-		*eeprom_ch_array = iwl_eeprom_band_3;
-		break;
-	case 4:		/* 5.5GHz band */
-		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_4);
-		*eeprom_ch_array = iwl_eeprom_band_4;
-		break;
-	case 5:		/* 5.7GHz band */
-		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_5);
-		*eeprom_ch_array = iwl_eeprom_band_5;
-		break;
-	case 6:		/* 2.4GHz ht40 channels */
-		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_6);
-		*eeprom_ch_array = iwl_eeprom_band_6;
-		break;
-	case 7:		/* 5 GHz ht40 channels */
-		*eeprom_ch_count = ARRAY_SIZE(iwl_eeprom_band_7);
-		*eeprom_ch_array = iwl_eeprom_band_7;
-		break;
-	default:
-		*eeprom_ch_count = 0;
-		*eeprom_ch_array = NULL;
-		WARN_ON(1);
-	}
-}
-
-#define CHECK_AND_PRINT(x) \
-	((eeprom_ch->flags & EEPROM_CHANNEL_##x) ? # x " " : "")
-
-static void iwl_mod_ht40_chan_info(struct device *dev,
-				   struct iwl_nvm_data *data, int n_channels,
-				   enum nl80211_band band, u16 channel,
-				   const struct iwl_eeprom_channel *eeprom_ch,
-				   u8 clear_ht40_extension_channel)
-{
-	struct ieee80211_channel *chan = NULL;
-	int i;
-
-	for (i = 0; i < n_channels; i++) {
-		if (data->channels[i].band != band)
-			continue;
-		if (data->channels[i].hw_value != channel)
-			continue;
-		chan = &data->channels[i];
-		break;
-	}
-
-	if (!chan)
-		return;
-
-	IWL_DEBUG_EEPROM(dev,
-			 "HT40 Ch. %d [%sGHz] %s%s%s%s%s(0x%02x %ddBm): Ad-Hoc %ssupported\n",
-			 channel,
-			 band == NL80211_BAND_5GHZ ? "5.2" : "2.4",
-			 CHECK_AND_PRINT(IBSS),
-			 CHECK_AND_PRINT(ACTIVE),
-			 CHECK_AND_PRINT(RADAR),
-			 CHECK_AND_PRINT(WIDE),
-			 CHECK_AND_PRINT(DFS),
-			 eeprom_ch->flags,
-			 eeprom_ch->max_power_avg,
-			 ((eeprom_ch->flags & EEPROM_CHANNEL_IBSS) &&
-			  !(eeprom_ch->flags & EEPROM_CHANNEL_RADAR)) ? ""
-								      : "not ");
-
-	if (eeprom_ch->flags & EEPROM_CHANNEL_VALID)
-		chan->flags &= ~clear_ht40_extension_channel;
-}
-
-#define CHECK_AND_PRINT_I(x)	\
-	((eeprom_ch_info[ch_idx].flags & EEPROM_CHANNEL_##x) ? # x " " : "")
-
-static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
-				struct iwl_nvm_data *data,
-				const u8 *eeprom, size_t eeprom_size)
-{
-	int band, ch_idx;
-	const struct iwl_eeprom_channel *eeprom_ch_info;
-	const u8 *eeprom_ch_array;
-	int eeprom_ch_count;
-	int n_channels = 0;
-
-	/*
-	 * Loop through the 5 EEPROM bands and add them to the parse list
-	 */
-	for (band = 1; band <= 5; band++) {
-		struct ieee80211_channel *channel;
-
-		iwl_init_band_reference(cfg, eeprom, eeprom_size, band,
-					&eeprom_ch_count, &eeprom_ch_info,
-					&eeprom_ch_array);
-
-		/* Loop through each band adding each of the channels */
-		for (ch_idx = 0; ch_idx < eeprom_ch_count; ch_idx++) {
-			const struct iwl_eeprom_channel *eeprom_ch;
-
-			eeprom_ch = &eeprom_ch_info[ch_idx];
-
-			if (!(eeprom_ch->flags & EEPROM_CHANNEL_VALID)) {
-				IWL_DEBUG_EEPROM(dev,
-						 "Ch. %d Flags %x [%sGHz] - No traffic\n",
-						 eeprom_ch_array[ch_idx],
-						 eeprom_ch_info[ch_idx].flags,
-						 (band != 1) ? "5.2" : "2.4");
-				continue;
-			}
-
-			channel = &data->channels[n_channels];
-			n_channels++;
-
-			channel->hw_value = eeprom_ch_array[ch_idx];
-			channel->band = (band == 1) ? NL80211_BAND_2GHZ
-						    : NL80211_BAND_5GHZ;
-			channel->center_freq =
-				ieee80211_channel_to_frequency(
-					channel->hw_value, channel->band);
-
-			/* set no-HT40, will enable as appropriate later */
-			channel->flags = IEEE80211_CHAN_NO_HT40;
-
-			if (!(eeprom_ch->flags & EEPROM_CHANNEL_IBSS))
-				channel->flags |= IEEE80211_CHAN_NO_IR;
-
-			if (!(eeprom_ch->flags & EEPROM_CHANNEL_ACTIVE))
-				channel->flags |= IEEE80211_CHAN_NO_IR;
-
-			if (eeprom_ch->flags & EEPROM_CHANNEL_RADAR)
-				channel->flags |= IEEE80211_CHAN_RADAR;
-
-			/* Initialize regulatory-based run-time data */
-			channel->max_power =
-				eeprom_ch_info[ch_idx].max_power_avg;
-			IWL_DEBUG_EEPROM(dev,
-					 "Ch. %d [%sGHz] %s%s%s%s%s%s(0x%02x %ddBm): Ad-Hoc %ssupported\n",
-					 channel->hw_value,
-					 (band != 1) ? "5.2" : "2.4",
-					 CHECK_AND_PRINT_I(VALID),
-					 CHECK_AND_PRINT_I(IBSS),
-					 CHECK_AND_PRINT_I(ACTIVE),
-					 CHECK_AND_PRINT_I(RADAR),
-					 CHECK_AND_PRINT_I(WIDE),
-					 CHECK_AND_PRINT_I(DFS),
-					 eeprom_ch_info[ch_idx].flags,
-					 eeprom_ch_info[ch_idx].max_power_avg,
-					 ((eeprom_ch_info[ch_idx].flags &
-							EEPROM_CHANNEL_IBSS) &&
-					  !(eeprom_ch_info[ch_idx].flags &
-							EEPROM_CHANNEL_RADAR))
-						? "" : "not ");
-		}
-	}
-
-	if (cfg->eeprom_params->enhanced_txpower) {
-		/*
-		 * for newer device (6000 series and up)
-		 * EEPROM contain enhanced tx power information
-		 * driver need to process addition information
-		 * to determine the max channel tx power limits
-		 */
-		iwl_eeprom_enhanced_txpower(dev, data, eeprom, eeprom_size,
-					    n_channels);
-	} else {
-		/* All others use data from channel map */
-		int i;
-
-		data->max_tx_pwr_half_dbm = -128;
-
-		for (i = 0; i < n_channels; i++)
-			data->max_tx_pwr_half_dbm =
-				max_t(s8, data->max_tx_pwr_half_dbm,
-				      data->channels[i].max_power * 2);
-	}
-
-	/* Check if we do have HT40 channels */
-	if (cfg->eeprom_params->regulatory_bands[5] ==
-				EEPROM_REGULATORY_BAND_NO_HT40 &&
-	    cfg->eeprom_params->regulatory_bands[6] ==
-				EEPROM_REGULATORY_BAND_NO_HT40)
-		return n_channels;
-
-	/* Two additional EEPROM bands for 2.4 and 5 GHz HT40 channels */
-	for (band = 6; band <= 7; band++) {
-		enum nl80211_band ieeeband;
-
-		iwl_init_band_reference(cfg, eeprom, eeprom_size, band,
-					&eeprom_ch_count, &eeprom_ch_info,
-					&eeprom_ch_array);
-
-		/* EEPROM band 6 is 2.4, band 7 is 5 GHz */
-		ieeeband = (band == 6) ? NL80211_BAND_2GHZ
-				       : NL80211_BAND_5GHZ;
-
-		/* Loop through each band adding each of the channels */
-		for (ch_idx = 0; ch_idx < eeprom_ch_count; ch_idx++) {
-			/* Set up driver's info for lower half */
-			iwl_mod_ht40_chan_info(dev, data, n_channels, ieeeband,
-					       eeprom_ch_array[ch_idx],
-					       &eeprom_ch_info[ch_idx],
-					       IEEE80211_CHAN_NO_HT40PLUS);
-
-			/* Set up driver's info for upper half */
-			iwl_mod_ht40_chan_info(dev, data, n_channels, ieeeband,
-					       eeprom_ch_array[ch_idx] + 4,
-					       &eeprom_ch_info[ch_idx],
-					       IEEE80211_CHAN_NO_HT40MINUS);
-		}
-	}
-
-	return n_channels;
-}
-#endif
-
-int iwl_init_sband_channels(struct iwl_nvm_data *data,
-			    struct ieee80211_supported_band *sband,
-			    int n_channels, enum nl80211_band band)
-{
-	struct ieee80211_channel *chan = &data->channels[0];
-	int n = 0, idx = 0;
-
-	while (idx < n_channels && chan->band != band)
-		chan = &data->channels[++idx];
-
-	sband->channels = &data->channels[idx];
-
-	while (idx < n_channels && chan->band == band) {
-		chan = &data->channels[++idx];
-		n++;
-	}
-
-	sband->n_channels = n;
-
-	return n;
-}
-
-#define MAX_BIT_RATE_40_MHZ	150 /* Mbps */
-#define MAX_BIT_RATE_20_MHZ	72 /* Mbps */
-
-void iwl_init_ht_hw_capab(struct iwl_trans *trans,
-			  struct iwl_nvm_data *data,
-			  struct ieee80211_sta_ht_cap *ht_info,
-			  enum nl80211_band band,
-			  u8 tx_chains, u8 rx_chains)
-{
-	const struct iwl_cfg *cfg = trans->cfg;
-	int max_bit_rate = 0;
-
-	tx_chains = hweight8(tx_chains);
-	if (cfg->rx_with_siso_diversity)
-		rx_chains = 1;
-	else
-		rx_chains = hweight8(rx_chains);
-
-	if (!(data->sku_cap_11n_enable) ||
-	    (iwlwifi_mod_params.disable_11n & IWL_DISABLE_HT_ALL) ||
-	    !cfg->ht_params) {
-		ht_info->ht_supported = false;
-		return;
-	}
-
-	if (data->sku_cap_mimo_disabled)
-		rx_chains = 1;
-
-	ht_info->ht_supported = true;
-	ht_info->cap = IEEE80211_HT_CAP_DSSSCCK40;
-
-	if (cfg->ht_params->stbc) {
-		ht_info->cap |= (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
-
-		if (tx_chains > 1)
-			ht_info->cap |= IEEE80211_HT_CAP_TX_STBC;
-	}
-
-	if (cfg->ht_params->ldpc)
-		ht_info->cap |= IEEE80211_HT_CAP_LDPC_CODING;
-
-	if (trans->trans_cfg->mq_rx_supported ||
-	    iwlwifi_mod_params.amsdu_size >= IWL_AMSDU_8K)
-		ht_info->cap |= IEEE80211_HT_CAP_MAX_AMSDU;
-
-	ht_info->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
-	ht_info->ampdu_density = IEEE80211_HT_MPDU_DENSITY_4;
-
-	ht_info->mcs.rx_mask[0] = 0xFF;
-	ht_info->mcs.rx_mask[1] = 0x00;
-	ht_info->mcs.rx_mask[2] = 0x00;
-
-	if (rx_chains >= 2)
-		ht_info->mcs.rx_mask[1] = 0xFF;
-	if (rx_chains >= 3)
-		ht_info->mcs.rx_mask[2] = 0xFF;
-
-	if (cfg->ht_params->ht_greenfield_support)
-		ht_info->cap |= IEEE80211_HT_CAP_GRN_FLD;
-	ht_info->cap |= IEEE80211_HT_CAP_SGI_20;
-
-	max_bit_rate = MAX_BIT_RATE_20_MHZ;
-
-	if (cfg->ht_params->ht40_bands & BIT(band)) {
-		ht_info->cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
-		ht_info->cap |= IEEE80211_HT_CAP_SGI_40;
-		max_bit_rate = MAX_BIT_RATE_40_MHZ;
-	}
-
-	/* Highest supported Rx data rate */
-	max_bit_rate *= rx_chains;
-	WARN_ON(max_bit_rate & ~IEEE80211_HT_MCS_RX_HIGHEST_MASK);
-	ht_info->mcs.rx_highest = cpu_to_le16(max_bit_rate);
-
-	/* Tx MCS capabilities */
-	ht_info->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
-	if (tx_chains != rx_chains) {
-		ht_info->mcs.tx_params |= IEEE80211_HT_MCS_TX_RX_DIFF;
-		ht_info->mcs.tx_params |= ((tx_chains - 1) <<
-				IEEE80211_HT_MCS_TX_MAX_STREAMS_SHIFT);
-	}
-}
-
-#if IS_ENABLED(CONFIG_IWLDVM)
-static void iwl_init_sbands(struct iwl_trans *trans, const struct iwl_cfg *cfg,
-			    struct iwl_nvm_data *data,
-			    const u8 *eeprom, size_t eeprom_size)
-{
-	struct device *dev = trans->dev;
-	int n_channels = iwl_init_channel_map(dev, cfg, data,
-					      eeprom, eeprom_size);
-	int n_used = 0;
-	struct ieee80211_supported_band *sband;
-
-	sband = &data->bands[NL80211_BAND_2GHZ];
-	sband->band = NL80211_BAND_2GHZ;
-	sband->bitrates = &iwl_cfg80211_rates[RATES_24_OFFS];
-	sband->n_bitrates = N_RATES_24;
-	n_used += iwl_init_sband_channels(data, sband, n_channels,
-					  NL80211_BAND_2GHZ);
-	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_2GHZ,
-			     data->valid_tx_ant, data->valid_rx_ant);
-
-	sband = &data->bands[NL80211_BAND_5GHZ];
-	sband->band = NL80211_BAND_5GHZ;
-	sband->bitrates = &iwl_cfg80211_rates[RATES_52_OFFS];
-	sband->n_bitrates = N_RATES_52;
-	n_used += iwl_init_sband_channels(data, sband, n_channels,
-					  NL80211_BAND_5GHZ);
-	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_5GHZ,
-			     data->valid_tx_ant, data->valid_rx_ant);
-
-	if (n_channels != n_used)
-		IWL_ERR_DEV(dev, "EEPROM: used only %d of %d channels\n",
-			    n_used, n_channels);
-}
-
-/* EEPROM data functions */
-
-struct iwl_nvm_data *
-iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
-		      const u8 *eeprom, size_t eeprom_size)
-{
-	struct iwl_nvm_data *data;
-	struct device *dev = trans->dev;
-	const void *tmp;
-	u16 radio_cfg, sku;
-
-	if (WARN_ON(!cfg || !cfg->eeprom_params))
-		return NULL;
-
-	data = kzalloc(struct_size(data, channels, IWL_NUM_CHANNELS),
-		       GFP_KERNEL);
-	if (!data)
-		return NULL;
-
-	/* get MAC address(es) */
-	tmp = iwl_eeprom_query_addr(eeprom, eeprom_size, EEPROM_MAC_ADDRESS);
-	if (!tmp)
-		goto err_free;
-	memcpy(data->hw_addr, tmp, ETH_ALEN);
-	data->n_hw_addrs = iwl_eeprom_query16(eeprom, eeprom_size,
-					      EEPROM_NUM_MAC_ADDRESS);
-
-	if (iwl_eeprom_read_calib(eeprom, eeprom_size, data))
-		goto err_free;
-
-	tmp = iwl_eeprom_query_addr(eeprom, eeprom_size, EEPROM_XTAL);
-	if (!tmp)
-		goto err_free;
-	memcpy(data->xtal_calib, tmp, sizeof(data->xtal_calib));
-
-	tmp = iwl_eeprom_query_addr(eeprom, eeprom_size,
-				    EEPROM_RAW_TEMPERATURE);
-	if (!tmp)
-		goto err_free;
-	data->raw_temperature = *(__le16 *)tmp;
-
-	tmp = iwl_eeprom_query_addr(eeprom, eeprom_size,
-				    EEPROM_KELVIN_TEMPERATURE);
-	if (!tmp)
-		goto err_free;
-	data->kelvin_temperature = *(__le16 *)tmp;
-	data->kelvin_voltage = *((__le16 *)tmp + 1);
-
-	radio_cfg = iwl_eeprom_query16(eeprom, eeprom_size,
-					     EEPROM_RADIO_CONFIG);
-	data->radio_cfg_dash = EEPROM_RF_CFG_DASH_MSK(radio_cfg);
-	data->radio_cfg_pnum = EEPROM_RF_CFG_PNUM_MSK(radio_cfg);
-	data->radio_cfg_step = EEPROM_RF_CFG_STEP_MSK(radio_cfg);
-	data->radio_cfg_type = EEPROM_RF_CFG_TYPE_MSK(radio_cfg);
-	data->valid_rx_ant = EEPROM_RF_CFG_RX_ANT_MSK(radio_cfg);
-	data->valid_tx_ant = EEPROM_RF_CFG_TX_ANT_MSK(radio_cfg);
-
-	sku = iwl_eeprom_query16(eeprom, eeprom_size,
-				 EEPROM_SKU_CAP);
-	data->sku_cap_11n_enable = sku & EEPROM_SKU_CAP_11N_ENABLE;
-	data->sku_cap_amt_enable = sku & EEPROM_SKU_CAP_AMT_ENABLE;
-	data->sku_cap_band_24ghz_enable = sku & EEPROM_SKU_CAP_BAND_24GHZ;
-	data->sku_cap_band_52ghz_enable = sku & EEPROM_SKU_CAP_BAND_52GHZ;
-	data->sku_cap_ipan_enable = sku & EEPROM_SKU_CAP_IPAN_ENABLE;
-	if (iwlwifi_mod_params.disable_11n & IWL_DISABLE_HT_ALL)
-		data->sku_cap_11n_enable = false;
-
-	data->nvm_version = iwl_eeprom_query16(eeprom, eeprom_size,
-					       EEPROM_VERSION);
-
-	/* check overrides (some devices have wrong EEPROM) */
-	if (cfg->valid_tx_ant)
-		data->valid_tx_ant = cfg->valid_tx_ant;
-	if (cfg->valid_rx_ant)
-		data->valid_rx_ant = cfg->valid_rx_ant;
-
-	if (!data->valid_tx_ant || !data->valid_rx_ant) {
-		IWL_ERR_DEV(dev, "invalid antennas (0x%x, 0x%x)\n",
-			    data->valid_tx_ant, data->valid_rx_ant);
-		goto err_free;
-	}
-
-	iwl_init_sbands(trans, cfg, data, eeprom, eeprom_size);
-
-	return data;
- err_free:
-	kfree(data);
-	return NULL;
-}
-IWL_EXPORT_SYMBOL(iwl_parse_eeprom_data);
-#endif
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index fd9c3bed9407..5a1b5ab62de1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -7,7 +7,7 @@
 #define __iwl_nvm_parse_h__
 
 #include <net/cfg80211.h>
-#include "iwl-eeprom-parse.h"
+#include "iwl-nvm-utils.h"
 #include "mei/iwl-mei.h"
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
new file mode 100644
index 000000000000..b3c25acd3691
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2005-2014, 2018-2021, 2023 Intel Corporation
+ * Copyright (C) 2015 Intel Mobile Communications GmbH
+ */
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/export.h>
+#include "iwl-drv.h"
+#include "iwl-modparams.h"
+#include "iwl-nvm-utils.h"
+
+int iwl_init_sband_channels(struct iwl_nvm_data *data,
+			    struct ieee80211_supported_band *sband,
+			    int n_channels, enum nl80211_band band)
+{
+	struct ieee80211_channel *chan = &data->channels[0];
+	int n = 0, idx = 0;
+
+	while (idx < n_channels && chan->band != band)
+		chan = &data->channels[++idx];
+
+	sband->channels = &data->channels[idx];
+
+	while (idx < n_channels && chan->band == band) {
+		chan = &data->channels[++idx];
+		n++;
+	}
+
+	sband->n_channels = n;
+
+	return n;
+}
+IWL_EXPORT_SYMBOL(iwl_init_sband_channels);
+
+#define MAX_BIT_RATE_40_MHZ	150 /* Mbps */
+#define MAX_BIT_RATE_20_MHZ	72 /* Mbps */
+
+void iwl_init_ht_hw_capab(struct iwl_trans *trans,
+			  struct iwl_nvm_data *data,
+			  struct ieee80211_sta_ht_cap *ht_info,
+			  enum nl80211_band band,
+			  u8 tx_chains, u8 rx_chains)
+{
+	const struct iwl_cfg *cfg = trans->cfg;
+	int max_bit_rate = 0;
+
+	tx_chains = hweight8(tx_chains);
+	if (cfg->rx_with_siso_diversity)
+		rx_chains = 1;
+	else
+		rx_chains = hweight8(rx_chains);
+
+	if (!(data->sku_cap_11n_enable) ||
+	    (iwlwifi_mod_params.disable_11n & IWL_DISABLE_HT_ALL) ||
+	    !cfg->ht_params) {
+		ht_info->ht_supported = false;
+		return;
+	}
+
+	if (data->sku_cap_mimo_disabled)
+		rx_chains = 1;
+
+	ht_info->ht_supported = true;
+	ht_info->cap = IEEE80211_HT_CAP_DSSSCCK40;
+
+	if (cfg->ht_params->stbc) {
+		ht_info->cap |= (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
+
+		if (tx_chains > 1)
+			ht_info->cap |= IEEE80211_HT_CAP_TX_STBC;
+	}
+
+	if (cfg->ht_params->ldpc)
+		ht_info->cap |= IEEE80211_HT_CAP_LDPC_CODING;
+
+	if (trans->trans_cfg->mq_rx_supported ||
+	    iwlwifi_mod_params.amsdu_size >= IWL_AMSDU_8K)
+		ht_info->cap |= IEEE80211_HT_CAP_MAX_AMSDU;
+
+	ht_info->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
+	ht_info->ampdu_density = IEEE80211_HT_MPDU_DENSITY_4;
+
+	ht_info->mcs.rx_mask[0] = 0xFF;
+	ht_info->mcs.rx_mask[1] = 0x00;
+	ht_info->mcs.rx_mask[2] = 0x00;
+
+	if (rx_chains >= 2)
+		ht_info->mcs.rx_mask[1] = 0xFF;
+	if (rx_chains >= 3)
+		ht_info->mcs.rx_mask[2] = 0xFF;
+
+	if (cfg->ht_params->ht_greenfield_support)
+		ht_info->cap |= IEEE80211_HT_CAP_GRN_FLD;
+	ht_info->cap |= IEEE80211_HT_CAP_SGI_20;
+
+	max_bit_rate = MAX_BIT_RATE_20_MHZ;
+
+	if (cfg->ht_params->ht40_bands & BIT(band)) {
+		ht_info->cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+		ht_info->cap |= IEEE80211_HT_CAP_SGI_40;
+		max_bit_rate = MAX_BIT_RATE_40_MHZ;
+	}
+
+	/* Highest supported Rx data rate */
+	max_bit_rate *= rx_chains;
+	WARN_ON(max_bit_rate & ~IEEE80211_HT_MCS_RX_HIGHEST_MASK);
+	ht_info->mcs.rx_highest = cpu_to_le16(max_bit_rate);
+
+	/* Tx MCS capabilities */
+	ht_info->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
+	if (tx_chains != rx_chains) {
+		ht_info->mcs.tx_params |= IEEE80211_HT_MCS_TX_RX_DIFF;
+		ht_info->mcs.tx_params |= ((tx_chains - 1) <<
+				IEEE80211_HT_MCS_TX_MAX_STREAMS_SHIFT);
+	}
+}
+IWL_EXPORT_SYMBOL(iwl_init_ht_hw_capab);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h
similarity index 73%
rename from drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
rename to drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h
index 34a178a2eb5d..ac0a29a1c31f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h
@@ -58,23 +58,6 @@ struct iwl_nvm_data {
 	struct ieee80211_channel channels[];
 };
 
-/**
- * iwl_parse_eeprom_data - parse EEPROM data and return values
- *
- * @trans: ransport we're parsing for, for debug only
- * @cfg: device configuration for parsing and overrides
- * @eeprom: the EEPROM data
- * @eeprom_size: length of the EEPROM data
- *
- * This function parses all EEPROM values we need and then
- * returns a (newly allocated) struct containing all the
- * relevant values for driver use. The struct must be freed
- * later with iwl_free_nvm_data().
- */
-struct iwl_nvm_data *
-iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
-		      const u8 *eeprom, size_t eeprom_size);
-
 int iwl_init_sband_channels(struct iwl_nvm_data *data,
 			    struct ieee80211_supported_band *sband,
 			    int n_channels, enum nl80211_band band);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4267b8ed6790..87825fb496bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -22,7 +22,7 @@
 #include "mvm.h"
 #include "sta.h"
 #include "time-event.h"
-#include "iwl-eeprom-parse.h"
+#include "iwl-nvm-utils.h"
 #include "iwl-phy-db.h"
 #include "testmode.h"
 #include "fw/error-dump.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index dd4599ca1f45..770a7098b0f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -24,7 +24,7 @@
 #include "iwl-op-mode.h"
 #include "iwl-trans.h"
 #include "fw/notif-wait.h"
-#include "iwl-eeprom-parse.h"
+#include "iwl-nvm-utils.h"
 #include "fw/file.h"
 #include "iwl-config.h"
 #include "sta.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 1e949b48188e..836ca22597bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -9,7 +9,7 @@
 #include "iwl-trans.h"
 #include "iwl-csr.h"
 #include "mvm.h"
-#include "iwl-eeprom-parse.h"
+#include "iwl-nvm-utils.h"
 #include "iwl-nvm-parse.h"
 #include "iwl-prph.h"
 #include "fw/acpi.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 160bb619ba9b..516decc647dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -18,7 +18,7 @@
 #include "iwl-modparams.h"
 #include "mvm.h"
 #include "iwl-phy-db.h"
-#include "iwl-eeprom-parse.h"
+#include "iwl-nvm-utils.h"
 #include "iwl-csr.h"
 #include "iwl-io.h"
 #include "iwl-prph.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 1d695ece93e9..599550f311de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -12,7 +12,7 @@
 #include <net/ipv6.h>
 
 #include "iwl-trans.h"
-#include "iwl-eeprom-parse.h"
+#include "iwl-nvm-utils.h"
 #include "mvm.h"
 #include "sta.h"
 #include "time-sync.h"
-- 
2.34.1


