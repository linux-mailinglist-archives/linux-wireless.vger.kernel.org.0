Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653C5129BE1
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 00:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLWXrk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 18:47:40 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54726 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726861AbfLWXrk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 18:47:40 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ijXQI-00010j-3Q; Tue, 24 Dec 2019 01:47:38 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 24 Dec 2019 01:47:19 +0200
Message-Id: <20191223234721.1513938-6-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223234721.1513938-1-luca@coelho.fi>
References: <20191223234721.1513938-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 5/7] iwlwifi: dbg: force stop the debug monitor HW
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

The driver is required to stop the debug monitor HW recording regardless
of the debug configuration since the driver is responsible to halt the
FW DBGC.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ed90dd104366..4c60f9959f7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2669,12 +2669,7 @@ int iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 {
 	int ret = 0;
 
-	/* if the FW crashed or not debug monitor cfg was given, there is
-	 * no point in changing the recording state
-	 */
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status) ||
-	    (!fwrt->trans->dbg.dest_tlv &&
-	     fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID))
+	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
 		return 0;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
-- 
2.24.0

