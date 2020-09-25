Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521A727938B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgIYVbA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:00 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52290 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727183AbgIYVbA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:00 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvIv-002J1P-Mn; Sat, 26 Sep 2020 00:30:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:39 +0300
Message-Id: <iwlwifi.20200926002540.a451fdd0a0ab.Idd8f59a49816d8484fe7dea3f1cec7a36cbf86f7@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/15] iwlwifi: dbg: remove IWL_FW_INI_TIME_POINT_WDG_TIMEOUT
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This timepoint was removed from the FW, so we remove it from here too
for consistency.  It's now marked as reserved to preserve the
enumeration.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 74ac65bd545a..8e34b509e6cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -368,7 +368,7 @@ enum iwl_fw_ini_region_type {
  * @IWL_FW_INI_TIME_POINT_USER_TRIGGER: user trigger time point
  * @IWL_FW_INI_TIME_POINT_PERIODIC: periodic timepoint that fires in constant
  *	intervals. data field holds the interval time in msec
- * @IWL_FW_INI_TIME_POINT_WDG_TIMEOUT: watchdog timeout
+ * @IWL_FW_INI_TIME_POINT_RESERVED: reserved
  * @IWL_FW_INI_TIME_POINT_HOST_ASSERT: Unused
  * @IWL_FW_INI_TIME_POINT_HOST_ALIVE_TIMEOUT: alive timeout
  * @IWL_FW_INI_TIME_POINT_HOST_DEVICE_ENABLE: device enable
@@ -399,7 +399,7 @@ enum iwl_fw_ini_time_point {
 	IWL_FW_INI_TIME_POINT_FW_RSP_OR_NOTIF,
 	IWL_FW_INI_TIME_POINT_USER_TRIGGER,
 	IWL_FW_INI_TIME_POINT_PERIODIC,
-	IWL_FW_INI_TIME_POINT_WDG_TIMEOUT,
+	IWL_FW_INI_TIME_POINT_RESERVED,
 	IWL_FW_INI_TIME_POINT_HOST_ASSERT,
 	IWL_FW_INI_TIME_POINT_HOST_ALIVE_TIMEOUT,
 	IWL_FW_INI_TIME_POINT_HOST_DEVICE_ENABLE,
-- 
2.28.0

