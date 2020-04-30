Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7491BF040
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 08:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgD3G3F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 02:29:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:25173 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgD3G3F (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 02:29:05 -0400
IronPort-SDR: 8tJ0NoLQMLiptGC6qo8SoCnIRiIFXL4wpfSDgkEYvlKQB57lhpTLxVqKqpNm22oRTWoc5tUhk8
 mXy0HuPLVrog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 23:29:05 -0700
IronPort-SDR: X/uXpcJX/nLM4/qqgTQfQC2PsJvrP7P9FeQKTnEo1xLkEnceo/HygM82/K6sZ7VzTZEtRoCAeU
 DVuNucgxLpag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="282751610"
Received: from power-sh.sh.intel.com ([10.239.48.5])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2020 23:29:03 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        andrzej.p@collabora.com, b.zolnierkie@samsung.com, luca@coelho.fi,
        rui.zhang@intel.com
Subject: [PATCH 1/6] iwlwifi: use thermal_zone_device_update() for temperature change
Date:   Thu, 30 Apr 2020 14:32:24 +0800
Message-Id: <20200430063229.6182-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430063229.6182-1-rui.zhang@intel.com>
References: <20200430063229.6182-1-rui.zhang@intel.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

thermal_notify_framework() is an obsolete API, and iwlwifi is the only
user of it.
Convert iwlwifi driver to use thermal_zone_device_update() instead.

Note that, thermal_zone_device_update() is able to handle the crossed
threshold by comparing the current temperature with every trip point, so
ths_crossed variant in iwl_mvm_temp_notif() is probably not needed.
It is still left there in this patch, in case the debug information is
still needed.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 418e59b..6344b6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -203,9 +203,8 @@ void iwl_mvm_temp_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 
 	if (mvm->tz_device.tzone) {
 		struct iwl_mvm_thermal_device *tz_dev = &mvm->tz_device;
-
-		thermal_notify_framework(tz_dev->tzone,
-					 tz_dev->fw_trips_index[ths_crossed]);
+		thermal_zone_device_update(tz_dev->tzone,
+					   THERMAL_EVENT_UNSPECIFIED);
 	}
 #endif /* CONFIG_THERMAL */
 }
-- 
2.7.4

