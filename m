Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81012C795B
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 14:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgK2NPj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 08:15:39 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33448 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727927AbgK2NPi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 08:15:38 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjMXT-0035gF-3X; Sun, 29 Nov 2020 15:14:51 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 15:14:39 +0200
Message-Id: <iwlwifi.20201129151117.a651ea399468.Id7a17985f5bf6a03d3850f445ccdc611f97776ce@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129131442.1857561-1-luca@coelho.fi>
References: <20201129131442.1857561-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/12] iwlwifi: mvm: Init error table memory to zero
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

If case we have an error reading FW memory we get garbage (stack old
data) in the report, so just initialize the table to zero.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 3123036978a5..60d972a63577 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -422,7 +422,7 @@ struct iwl_umac_error_event_table {
 static void iwl_mvm_dump_umac_error_log(struct iwl_mvm *mvm)
 {
 	struct iwl_trans *trans = mvm->trans;
-	struct iwl_umac_error_event_table table;
+	struct iwl_umac_error_event_table table = {};
 	u32 base = mvm->trans->dbg.umac_error_event_table;
 
 	if (!base &&
@@ -461,7 +461,7 @@ static void iwl_mvm_dump_umac_error_log(struct iwl_mvm *mvm)
 static void iwl_mvm_dump_lmac_error_log(struct iwl_mvm *mvm, u8 lmac_num)
 {
 	struct iwl_trans *trans = mvm->trans;
-	struct iwl_error_event_table table;
+	struct iwl_error_event_table table = {};
 	u32 val, base = mvm->trans->dbg.lmac_error_event_table[lmac_num];
 
 	if (mvm->fwrt.cur_fw_img == IWL_UCODE_INIT) {
-- 
2.29.2

