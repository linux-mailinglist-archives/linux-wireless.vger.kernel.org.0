Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B98A4682FD
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 07:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbhLDGjn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 01:39:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50332 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241661AbhLDGjn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 01:39:43 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtOee-0017AH-ID; Sat, 04 Dec 2021 08:36:17 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 08:35:54 +0200
Message-Id: <iwlwifi.20211204083238.aca5bd78518e.I2f1b4b38899717851ea9f5b6dd23cde27e10387a@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204063555.769822-1-luca@coelho.fi>
References: <20211204063555.769822-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/12] iwlwifi: mvm: add support for PHY context command v4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

A new version of this command deprecates the rxchain_info field
but is otherwise the same, so treat it the same way. We already
leave the rxchain_info zeroed since the RLC command is supported.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h | 9 +++++----
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c    | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
index 68b788b92b7a..e66f77924f83 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -150,11 +150,12 @@ struct iwl_phy_context_cmd {
 	/* COMMON_INDEX_HDR_API_S_VER_1 */
 	__le32 id_and_color;
 	__le32 action;
-	/* PHY_CONTEXT_DATA_API_S_VER_3 */
+	/* PHY_CONTEXT_DATA_API_S_VER_3, PHY_CONTEXT_DATA_API_S_VER_4 */
 	struct iwl_fw_channel_info ci;
 	__le32 lmac_id;
-	__le32 rxchain_info;
+	__le32 rxchain_info; /* reserved in _VER_4 */
 	__le32 dsp_cfg_flags;
 	__le32 reserved;
-} __packed; /* PHY_CONTEXT_CMD_API_VER_3 */
+} __packed; /* PHY_CONTEXT_CMD_API_VER_3, PHY_CONTEXT_CMD_API_VER_4 */
+
 #endif /* __iwl_fw_api_phy_ctxt_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 6feb2f664d2c..9af40b0fa37a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -212,7 +212,7 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
 					PHY_CONTEXT_CMD, 1);
 
-	if (ver == 3) {
+	if (ver == 3 || ver == 4) {
 		struct iwl_phy_context_cmd cmd = {};
 
 		/* Set the command header fields */
-- 
2.33.1

