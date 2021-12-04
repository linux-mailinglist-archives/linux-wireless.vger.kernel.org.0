Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA80E4682F9
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 07:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbhLDGjj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 01:39:39 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50308 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240718AbhLDGjj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 01:39:39 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtOeV-0017AH-RR; Sat, 04 Dec 2021 08:36:13 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 08:35:50 +0200
Message-Id: <iwlwifi.20211204083238.f856cb190a4e.I77e3ff5a92b1bcc3e81c1344b046dade0a8b6a24@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204063555.769822-1-luca@coelho.fi>
References: <20211204063555.769822-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/12] iwlwifi: mvm: parse firmware alive message version 6
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's a new version with some addition, we'll need to
do something with the additional data later, but for now
just parse it so we don't fail with the newer firmware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/alive.h   | 17 ++++++++++++++++-
 .../wireless/intel/iwlwifi/fw/api/commands.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c     |  6 ++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
index c840a97e6a62..7dd984fbe0f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -97,6 +97,21 @@ struct iwl_alive_ntf_v5 {
 	struct iwl_sku_id sku_id;
 } __packed; /* UCODE_ALIVE_NTFY_API_S_VER_5 */
 
+struct iwl_imr_alive_info {
+	__le64 base_addr;
+	__le32 size;
+	__le32 enabled;
+} __packed; /* IMR_ALIVE_INFO_API_S_VER_1 */
+
+struct iwl_alive_ntf_v6 {
+	__le16 status;
+	__le16 flags;
+	struct iwl_lmac_alive lmac_data[2];
+	struct iwl_umac_alive umac_data;
+	struct iwl_sku_id sku_id;
+	struct iwl_imr_alive_info imr;
+} __packed; /* UCODE_ALIVE_NTFY_API_S_VER_6 */
+
 /**
  * enum iwl_extended_cfg_flag - commands driver may send before
  *	finishing init flow
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index ee6b5844a871..8a90acbd0db9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -51,7 +51,7 @@ enum iwl_legacy_cmds {
 	 * @UCODE_ALIVE_NTFY:
 	 * Alive data from the firmware, as described in
 	 * &struct iwl_alive_ntf_v3 or &struct iwl_alive_ntf_v4 or
-	 * &struct iwl_alive_ntf_v5.
+	 * &struct iwl_alive_ntf_v5 or &struct iwl_alive_ntf_v6.
 	 */
 	UCODE_ALIVE_NTFY = 0x1,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6ce78c03e51f..7608b1e486c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -123,13 +123,15 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	struct iwl_lmac_alive *lmac2 = NULL;
 	u16 status;
 	u32 lmac_error_event_table, umac_error_table;
+	u32 version = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+					      UCODE_ALIVE_NTFY, 0);
 
 	/*
 	 * For v5 and above, we can check the version, for older
 	 * versions we need to check the size.
 	 */
-	if (iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
-				    UCODE_ALIVE_NTFY, 0) == 5) {
+	if (version == 5 || version == 6) {
+		/* v5 and v6 are compatible (only IMR addition) */
 		struct iwl_alive_ntf_v5 *palive;
 
 		if (pkt_len < sizeof(*palive))
-- 
2.33.1

