Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDFED5C30
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 09:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfJNHU2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 03:20:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:49152 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729928AbfJNHU1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 03:20:27 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJueX-0007ae-TN; Mon, 14 Oct 2019 10:20:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 14 Oct 2019 10:20:04 +0300
Message-Id: <20191014101813.5e5cf637d18a.I918d7240a425d5904677c2b95d1446cb643ce5db@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014072019.1254-1-luca@coelho.fi>
References: <20191014072019.1254-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 01/16] iwlwifi: dbg_ini: load external dbg cfg after internal cfg is loaded
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

In the new API implementation the driver does not keep the internal and
external debug configurations in separate structs so the last
configuration that is loaded overrides the previous ones (this is true
only in some of the TLVs e.g. the buffer allocation TLV).
Load the external configuration after the internal is loaded so that
user configuration will override the default coming with the FW.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index ff0519ea00a5..b0881e713b48 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1560,6 +1560,8 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	IWL_INFO(drv, "loaded firmware version %s op_mode %s\n",
 		 drv->fw.fw_version, op->name);
 
+	iwl_dbg_tlv_load_bin(drv->trans->dev, drv->trans);
+
 	/* add this device to the list of devices using this op_mode */
 	list_add_tail(&drv->list, &op->drv);
 
@@ -1636,8 +1638,6 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 	init_completion(&drv->request_firmware_complete);
 	INIT_LIST_HEAD(&drv->list);
 
-	iwl_dbg_tlv_load_bin(drv->trans->dev, drv->trans);
-
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	/* Create the device debugfs entries. */
 	drv->dbgfs_drv = debugfs_create_dir(dev_name(trans->dev),
-- 
2.23.0

