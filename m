Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1454A97B2
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 11:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358274AbiBDKZY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 05:25:24 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37966 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1358268AbiBDKZX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 05:25:23 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFvmL-0005zM-CZ;
        Fri, 04 Feb 2022 12:25:22 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Feb 2022 12:25:06 +0200
Message-Id: <iwlwifi.20220204122220.a28df852f70d.Icaf6556d81bc137a459aabf0511d46c3861b0413@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204102511.606112-1-luca@coelho.fi>
References: <20220204102511.606112-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/12] iwlwifi: drv: load tlv debug data earlier
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's no good reason to pick the opmode first and load this
under the mutex, so just load it before continuing. This will
let us load it asynchronously more easily later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 5a9e644a791c..ab52136cffb4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1647,6 +1647,8 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	/* We have our copies now, allow OS release its copies */
 	release_firmware(ucode_raw);
 
+	iwl_dbg_tlv_load_bin(drv->trans->dev, drv->trans);
+
 	mutex_lock(&iwlwifi_opmode_table_mtx);
 	switch (fw->type) {
 	case IWL_FW_DVM:
@@ -1663,8 +1665,6 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	IWL_INFO(drv, "loaded firmware version %s op_mode %s\n",
 		 drv->fw.fw_version, op->name);
 
-	iwl_dbg_tlv_load_bin(drv->trans->dev, drv->trans);
-
 	/* add this device to the list of devices using this op_mode */
 	list_add_tail(&drv->list, &op->drv);
 
-- 
2.34.1

