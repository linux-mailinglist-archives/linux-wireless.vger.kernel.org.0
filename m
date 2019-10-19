Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36976DD7AD
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 11:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfJSJjM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 05:39:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50400 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbfJSJjL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 05:39:11 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlCX-0002fy-TC; Sat, 19 Oct 2019 12:39:10 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 12:38:52 +0300
Message-Id: <20191019123747.2ee90c430c5b.I793862b611507a827393d544ffbd4fa7cce3c79c@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019093902.29823-1-luca@coelho.fi>
References: <20191019093902.29823-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 02/12] iwlwifi: mvm: remove else-if in iwl_send_phy_cfg_cmd()
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We return in the if block, so it's unnecessary to have an else
statement.  Remove it.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 7afdf0c1b1e9..aa644b82e93c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -512,9 +512,10 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 	enum iwl_ucode_type ucode_type = mvm->fwrt.cur_fw_img;
 
 	if (iwl_mvm_has_unified_ucode(mvm) &&
-	    !mvm->trans->cfg->tx_with_siso_diversity) {
+	    !mvm->trans->cfg->tx_with_siso_diversity)
 		return 0;
-	} else if (mvm->trans->cfg->tx_with_siso_diversity) {
+
+	if (mvm->trans->cfg->tx_with_siso_diversity) {
 		/*
 		 * TODO: currently we don't set the antenna but letting the NIC
 		 * to decide which antenna to use. This should come from BIOS.
-- 
2.23.0

