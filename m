Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1D64A3585
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 10:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354566AbiA3JxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 04:53:18 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37916 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354544AbiA3JxR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 04:53:17 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nE6tX-0003JO-1S;
        Sun, 30 Jan 2022 11:53:15 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 30 Jan 2022 11:53:04 +0200
Message-Id: <iwlwifi.20220130115024.3f9de2d59929.Ib6324e93951ee877754538c89f3ab2a84998bd40@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130095306.790573-1-luca@coelho.fi>
References: <20220130095306.790573-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/12] iwlwifi: make some functions friendly to sparse
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Somehow, sparse cannot track the cond_lock() here properly,
but if we return directly from the inner basic block then
it doesn't complain. Refactor the code a bit to make it not
complain.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 253eac4cbf59..396f2c997da6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -65,14 +65,14 @@ IWL_EXPORT_SYMBOL(iwl_poll_bit);
 
 u32 iwl_read_direct32(struct iwl_trans *trans, u32 reg)
 {
-	u32 value = 0x5a5a5a5a;
-
 	if (iwl_trans_grab_nic_access(trans)) {
-		value = iwl_read32(trans, reg);
+		u32 value = iwl_read32(trans, reg);
+
 		iwl_trans_release_nic_access(trans);
+		return value;
 	}
 
-	return value;
+	return 0x5a5a5a5a;
 }
 IWL_EXPORT_SYMBOL(iwl_read_direct32);
 
@@ -135,13 +135,15 @@ IWL_EXPORT_SYMBOL(iwl_write_prph64_no_grab);
 
 u32 iwl_read_prph(struct iwl_trans *trans, u32 ofs)
 {
-	u32 val = 0x5a5a5a5a;
-
 	if (iwl_trans_grab_nic_access(trans)) {
-		val = iwl_read_prph_no_grab(trans, ofs);
+		u32 val = iwl_read_prph_no_grab(trans, ofs);
+
 		iwl_trans_release_nic_access(trans);
+
+		return val;
 	}
-	return val;
+
+	return 0x5a5a5a5a;
 }
 IWL_EXPORT_SYMBOL(iwl_read_prph);
 
-- 
2.34.1

