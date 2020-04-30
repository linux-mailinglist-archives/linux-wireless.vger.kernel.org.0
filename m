Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F011D1BF04A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 08:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD3G3X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 02:29:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:25173 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgD3G3X (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 02:29:23 -0400
IronPort-SDR: humlRVR2/wG9kZkf4ty1L8fxdPQ7h+ZnCJQn1jDoOQ4WnBTNEWB9hJSLgnMj/eXWbCWc+Riok8
 JETJzOBTbXuw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 23:29:23 -0700
IronPort-SDR: +wKeSGww6JJPXvbSKLDQ+YoYIinGq8FxPE5drQ1kzWax6Iuc8J7HyVspAyOlefGZJ90jj/8IL1
 Lm5hl2FN4q7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="282751693"
Received: from power-sh.sh.intel.com ([10.239.48.5])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2020 23:29:21 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        andrzej.p@collabora.com, b.zolnierkie@samsung.com, luca@coelho.fi,
        rui.zhang@intel.com
Subject: [PATCH RFC 6/6] iwlwifi: enable thermal zone only when firmware loaded
Date:   Thu, 30 Apr 2020 14:32:29 +0800
Message-Id: <20200430063229.6182-7-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430063229.6182-1-rui.zhang@intel.com>
References: <20200430063229.6182-1-rui.zhang@intel.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

in iwl_mvm_thermal_zone_register(), when registering a thermal zone, the
thermal subsystem will evaluate its temperature.
But iwl_mvm_tzone_get_temp() fails at this time because
iwl_mvm_firmware_running() returns false.
And that's why many users report that they see
"thermal thermal_zoneX: failed to read out thermal zone (-61)"
message during wifi driver probing.

With the changes made earlier in this patch series, the problem can be
solved by registering the iwlwifi thermal zone as disabled, and enable it
later when the firmware is ready.

*NOTE*
This is just a prototype patch to illustrate the problem and
how we can fix it based on the new thermal changes.

I'm not sure what is the proper place to enable/disable the thermal zone.
The solution in this patch causes a deadlock issue because
a) thermal_zone_device_enable() is invoked with mvm->mutex locked.
b) .get_temp() callback is invoked when enabling the thermal zone.
c) iwl_mvm_tzone_get_temp() also needs to hold mvm->mutex.
And that's why I hacked iwl_mvm_tzone_get_temp() to avoid this.

So if you have ideas on how to fix this, please feel free to propose it.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=201761
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |  4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c  | 12 +++++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a4038f2..ff47fc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1222,6 +1222,8 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 #ifdef CONFIG_THERMAL
 	/* TODO: read the budget from BIOS / Platform NVM */
 
+	if (mvm->tz_device.tzone && tz_disabled(mvm->tz_device.tzone))
+		thermal_zone_device_enable(mvm->tz_device.tzone);
 	/*
 	 * In case there is no budget from BIOS / Platform NVM the default
 	 * budget should be 2000mW (cooling state 0).
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index afcf2b9..b964c01 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1946,6 +1946,10 @@ static inline u32 iwl_mvm_flushable_queues(struct iwl_mvm *mvm)
 
 static inline void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 {
+#ifdef CONFIG_THERMAL
+	if (mvm->tz_device.tzone && !tz_disabled(mvm->tz_device.tzone))
+		thermal_zone_device_disable(mvm->tz_device.tzone);
+#endif
 	lockdep_assert_held(&mvm->mutex);
 	iwl_fw_cancel_timestamp(&mvm->fwrt);
 	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 6344b6b..819dcaf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -620,8 +620,9 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
 	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
 	int ret;
 	int temp;
+	int locked;
 
-	mutex_lock(&mvm->mutex);
+	locked = mutex_trylock(&mvm->mutex);
 
 	if (!iwl_mvm_firmware_running(mvm) ||
 	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
@@ -636,7 +637,8 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
 	*temperature = temp * 1000;
 
 out:
-	mutex_unlock(&mvm->mutex);
+	if (locked)
+		mutex_unlock(&mvm->mutex);
 	return ret;
 }
 
@@ -730,6 +732,10 @@ static  struct thermal_zone_device_ops tzone_ops = {
 /* make all trips writable */
 #define IWL_WRITABLE_TRIPS_MSK (BIT(IWL_MAX_DTS_TRIPS) - 1)
 
+static struct thermal_zone_params tz_params = {
+	.initial_mode   = THERMAL_DEVICE_DISABLED,
+};
+
 static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 {
 	int i;
@@ -749,7 +755,7 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 							IWL_MAX_DTS_TRIPS,
 							IWL_WRITABLE_TRIPS_MSK,
 							mvm, &tzone_ops,
-							NULL, 0, 0);
+							&tz_params, 0, 0);
 	if (IS_ERR(mvm->tz_device.tzone)) {
 		IWL_DEBUG_TEMP(mvm,
 			       "Failed to register to thermal zone (err = %ld)\n",
-- 
2.7.4

