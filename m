Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36B83A43BD
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfHaJtK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:49:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39652 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726354AbfHaJtK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:49:10 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400K-0002OQ-La; Sat, 31 Aug 2019 12:49:09 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:45 +0300
Message-Id: <20190831094859.6391-6-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 05/19] iwlwifi: api: fix FTM struct documentation
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The real name is struct iwl_tof_range_req_ext_cmd, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index ec864c7b497f..7a0fe5adefa5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -82,7 +82,7 @@ enum iwl_location_subcmd_ids {
 	TOF_RANGE_ABORT_CMD = 0x2,
 	/**
 	 * @TOF_RANGE_REQ_EXT_CMD: TOF extended ranging config,
-	 *	uses &struct iwl_tof_range_request_ext_cmd
+	 *	uses &struct iwl_tof_range_req_ext_cmd
 	 */
 	TOF_RANGE_REQ_EXT_CMD = 0x3,
 	/**
@@ -292,7 +292,7 @@ struct iwl_tof_responder_dyn_config_cmd {
 } __packed; /* TOF_RESPONDER_DYN_CONFIG_CMD_API_S_VER_2 */
 
 /**
- * struct iwl_tof_range_request_ext_cmd - extended range req for WLS
+ * struct iwl_tof_range_req_ext_cmd - extended range req for WLS
  * @tsf_timer_offset_msec: the recommended time offset (mSec) from the AP's TSF
  * @reserved: reserved
  * @min_delta_ftm: Minimal time between two consecutive measurements,
-- 
2.23.0.rc1

