Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F442AA3F8
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 09:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgKGIuR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 03:50:17 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58782 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728011AbgKGIuQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 03:50:16 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kbJvJ-002on9-Va; Sat, 07 Nov 2020 10:50:14 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat,  7 Nov 2020 10:50:06 +0200
Message-Id: <iwlwifi.20201107104557.4486852ebb56.I9eb0d028e31f183597fb90120e7d4ca87e0dd6cb@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107085011.57943-1-luca@coelho.fi>
References: <20201107085011.57943-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 1/6] iwlwifi: sta: set max HE max A-MPDU according to HE capa
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Currently, our max tpt is limited to max HT A-MPDU for LB,
and max VHT A-MPDU for HB. Configure HE exponent value correctly to
achieve HE max A-MPDU, both on LB and HB.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/sta.h    | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c   | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
index d43e0d3f3a12..052413eef059 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012-2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012-2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -128,7 +126,9 @@ enum iwl_sta_flags {
 	STA_FLG_MAX_AGG_SIZE_256K	= (5 << STA_FLG_MAX_AGG_SIZE_SHIFT),
 	STA_FLG_MAX_AGG_SIZE_512K	= (6 << STA_FLG_MAX_AGG_SIZE_SHIFT),
 	STA_FLG_MAX_AGG_SIZE_1024K	= (7 << STA_FLG_MAX_AGG_SIZE_SHIFT),
-	STA_FLG_MAX_AGG_SIZE_MSK	= (7 << STA_FLG_MAX_AGG_SIZE_SHIFT),
+	STA_FLG_MAX_AGG_SIZE_2M		= (8 << STA_FLG_MAX_AGG_SIZE_SHIFT),
+	STA_FLG_MAX_AGG_SIZE_4M		= (9 << STA_FLG_MAX_AGG_SIZE_SHIFT),
+	STA_FLG_MAX_AGG_SIZE_MSK	= (0xf << STA_FLG_MAX_AGG_SIZE_SHIFT),
 
 	STA_FLG_AGG_MPDU_DENS_SHIFT	= 23,
 	STA_FLG_AGG_MPDU_DENS_2US	= (4 << STA_FLG_AGG_MPDU_DENS_SHIFT),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 017537944fd0..799d8219463c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -196,6 +196,7 @@ int iwl_mvm_sta_send_to_fw(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		mpdu_dens = sta->ht_cap.ampdu_density;
 	}
 
+
 	if (sta->vht_cap.vht_supported) {
 		agg_size = sta->vht_cap.cap &
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
@@ -205,6 +206,23 @@ int iwl_mvm_sta_send_to_fw(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		agg_size = sta->ht_cap.ampdu_factor;
 	}
 
+	/* D6.0 10.12.2 A-MPDU length limit rules
+	 * A STA indicates the maximum length of the A-MPDU preEOF padding
+	 * that it can receive in an HE PPDU in the Maximum A-MPDU Length
+	 * Exponent field in its HT Capabilities, VHT Capabilities,
+	 * and HE 6 GHz Band Capabilities elements (if present) and the
+	 * Maximum AMPDU Length Exponent Extension field in its HE
+	 * Capabilities element
+	 */
+	if (sta->he_cap.has_he)
+		agg_size += u8_get_bits(sta->he_cap.he_cap_elem.mac_cap_info[3],
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
+
+	/* Limit to max A-MPDU supported by FW */
+	if (agg_size > (STA_FLG_MAX_AGG_SIZE_4M >> STA_FLG_MAX_AGG_SIZE_SHIFT))
+		agg_size = (STA_FLG_MAX_AGG_SIZE_4M >>
+			    STA_FLG_MAX_AGG_SIZE_SHIFT);
+
 	add_sta_cmd.station_flags |=
 		cpu_to_le32(agg_size << STA_FLG_MAX_AGG_SIZE_SHIFT);
 	add_sta_cmd.station_flags |=
-- 
2.28.0

