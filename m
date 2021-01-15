Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE8C2F772E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 12:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhAOLGy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 06:06:54 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40302 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726278AbhAOLGy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 06:06:54 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l0Mve-003hBK-T2; Fri, 15 Jan 2021 13:06:07 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 15 Jan 2021 13:05:51 +0200
Message-Id: <iwlwifi.20210115130252.5ac6828a0bbe.I7d308358b21d3c0c84b1086999dbc7267f86e219@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115110558.1248847-1-luca@coelho.fi>
References: <20210115110558.1248847-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 05/12] iwlwifi: pnvm: don't try to load after failures
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If loading the PNVM file failed on the first try during the
interface up, the file is unlikely to show up later, and we
already don't try to reload it if it changes, so just don't
try loading it again and again.

This also fixes some issues where we may try to load it at
resume time, which may not be possible yet.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 6972592850c0 ("iwlwifi: read and parse PNVM file")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index ebd1a09a2fb8..895a907acdf0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -232,7 +232,7 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
 		return 0;
 
-	/* load from disk only if we haven't done it before */
+	/* load from disk only if we haven't done it (or tried) before */
 	if (!trans->pnvm_loaded) {
 		const struct firmware *pnvm;
 		char pnvm_name[64];
@@ -253,6 +253,12 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 		if (ret) {
 			IWL_DEBUG_FW(trans, "PNVM file %s not found %d\n",
 				     pnvm_name, ret);
+			/*
+			 * Pretend we've loaded it - at least we've tried and
+			 * couldn't load it at all, so there's no point in
+			 * trying again over and over.
+			 */
+			trans->pnvm_loaded = true;
 		} else {
 			iwl_pnvm_parse(trans, pnvm->data, pnvm->size);
 
-- 
2.29.2

