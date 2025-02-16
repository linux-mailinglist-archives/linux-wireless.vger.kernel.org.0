Return-Path: <linux-wireless+bounces-18982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEB3A3737E
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78897A1B1E
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F2518FDB9;
	Sun, 16 Feb 2025 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GN5pEDRu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB118DB15
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699032; cv=none; b=bqx8hwnniKSgL4E9kZNBqD9qSM12gMG3EdKZSplJV9DC+c0ghPs9y67zkDWrypWyO/gO03q6yX14TdWte0AUo5L28+SdnxhFkzt/CwkZmVttfEXNOoDSMRxXephemVAE9+Uci2TRCavXfyhTHM7Lt7O5opqDqmdIm5rNezsj108=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699032; c=relaxed/simple;
	bh=3eGnRSDmtddUYSxt71Y9uR0KQ0kZJsW9xdxRQMX1YOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L/eMEWh8uAYo9V/s0cj4s3vHrWoUny/D5d3mjRrAevvxLdnPswU+AUvBuCGFHVjvKTlO5CIciuFOistVIIh+TP8CxN4ATsHBtsi+Lg41YI49GIYVXnmoUyi8IwdHBS3eMs4KGlNjUGV1CHt66Yyb9e3JuSbGpvhuP/O+6LCwk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GN5pEDRu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699031; x=1771235031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3eGnRSDmtddUYSxt71Y9uR0KQ0kZJsW9xdxRQMX1YOo=;
  b=GN5pEDRugohxU2Cs4sOzYv0rPboM4bMwWSz/wWnOmtENwhPjXMkhid+x
   KcncAknmyyGJ2vEaYiA4wX/TYQSd+Pv2CxF8Z2+a/HJsUFOO1hYXz+L7F
   hezImfiHR9qXPDJYUa5vcy7nsEhD7a/lO9F776/+X5BFNQ/5V4RQwfQt0
   3Eu+9U/2cUPMGA7shpFHO0sz1pDs2ITCEVwnigiNUBNADYqE2zLULouCM
   C2442cbZQ0g2hlGqewa4XRtKi1wSAxSWNxTVdgsd23ON8/2JAdyQcYgzA
   SJZEPmT2e7bUecYiyuHk2O64zCmAmD77sOerItEcYrqJGC9A9ujS3BT9p
   Q==;
X-CSE-ConnectionGUID: 2ywGA57TTWeIOTS5DDT/lw==
X-CSE-MsgGUID: d2are35tTROD4vGzoyXuRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323380"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323380"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:51 -0800
X-CSE-ConnectionGUID: d/H3ZntSQd+JClHOndH6iw==
X-CSE-MsgGUID: MGzOUbLXRhGt2wP2BOdobQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785237"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 12/42] wifi: iwlwifi: mld: add file led.h/c
Date: Sun, 16 Feb 2025 11:42:51 +0200
Message-Id: <20250216111648.5c4e79133b8e.Ieb8e31005b91875e20d069920b5bbb56c8feba6c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

this file is handling a led functionality

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/led.c | 100 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/led.h |  29 ++++++
 2 files changed, 129 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/led.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/led.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/led.c b/drivers/net/wireless/intel/iwlwifi/mld/led.c
new file mode 100644
index 000000000000..a37b32cbc6e6
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/led.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <linux/leds.h>
+#include <net/mac80211.h>
+
+#include "fw/api/led.h"
+#include "mld.h"
+#include "led.h"
+#include "hcmd.h"
+
+static void iwl_mld_send_led_fw_cmd(struct iwl_mld *mld, bool on)
+{
+	struct iwl_led_cmd led_cmd = {
+		.status = cpu_to_le32(on),
+	};
+	int err;
+
+	if (WARN_ON(!mld->fw_status.running))
+		return;
+
+	err = iwl_mld_send_cmd_with_flags_pdu(mld, WIDE_ID(LONG_GROUP,
+							   LEDS_CMD),
+					      CMD_ASYNC, &led_cmd);
+
+	if (err)
+		IWL_WARN(mld, "LED command failed: %d\n", err);
+}
+
+static void iwl_led_brightness_set(struct led_classdev *led_cdev,
+				   enum led_brightness brightness)
+{
+	struct iwl_mld *mld = container_of(led_cdev, struct iwl_mld, led);
+
+	if (!mld->fw_status.running)
+		return;
+
+	iwl_mld_send_led_fw_cmd(mld, brightness > 0);
+}
+
+int iwl_mld_leds_init(struct iwl_mld *mld)
+{
+	int mode = iwlwifi_mod_params.led_mode;
+	int ret;
+
+	switch (mode) {
+	case IWL_LED_BLINK:
+		IWL_ERR(mld, "Blink led mode not supported, used default\n");
+		fallthrough;
+	case IWL_LED_DEFAULT:
+	case IWL_LED_RF_STATE:
+		mode = IWL_LED_RF_STATE;
+		break;
+	case IWL_LED_DISABLE:
+		IWL_INFO(mld, "Led disabled\n");
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	mld->led.name = kasprintf(GFP_KERNEL, "%s-led",
+				  wiphy_name(mld->hw->wiphy));
+	if (!mld->led.name)
+		return -ENOMEM;
+
+	mld->led.brightness_set = iwl_led_brightness_set;
+	mld->led.max_brightness = 1;
+
+	if (mode == IWL_LED_RF_STATE)
+		mld->led.default_trigger =
+			ieee80211_get_radio_led_name(mld->hw);
+
+	ret = led_classdev_register(mld->trans->dev, &mld->led);
+	if (ret) {
+		kfree(mld->led.name);
+		mld->led.name = NULL;
+		IWL_INFO(mld, "Failed to enable led\n");
+	}
+
+	return ret;
+}
+
+void iwl_mld_led_config_fw(struct iwl_mld *mld)
+{
+	if (!mld->led.name)
+		return;
+
+	iwl_mld_send_led_fw_cmd(mld, mld->led.brightness > 0);
+}
+
+void iwl_mld_leds_exit(struct iwl_mld *mld)
+{
+	if (!mld->led.name)
+		return;
+
+	led_classdev_unregister(&mld->led);
+	kfree(mld->led.name);
+	mld->led.name = NULL;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/led.h b/drivers/net/wireless/intel/iwlwifi/mld/led.h
new file mode 100644
index 000000000000..e4ab22e58de6
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/led.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#ifndef __iwl_mld_led_h__
+#define __iwl_mld_led_h__
+
+#include "mld.h"
+
+#ifdef CONFIG_IWLWIFI_LEDS
+int iwl_mld_leds_init(struct iwl_mld *mld);
+void iwl_mld_leds_exit(struct iwl_mld *mld);
+void iwl_mld_led_config_fw(struct iwl_mld *mld);
+#else
+static inline int iwl_mld_leds_init(struct iwl_mld *mld)
+{
+	return 0;
+}
+
+static inline void iwl_mld_leds_exit(struct iwl_mld *mld)
+{
+}
+
+static inline void iwl_mld_led_config_fw(struct iwl_mld *mld)
+{
+}
+#endif
+
+#endif /* __iwl_mld_led_h__ */
-- 
2.34.1


