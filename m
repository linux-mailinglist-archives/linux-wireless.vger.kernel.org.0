Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA233AAD10
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 09:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFQHLM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 03:11:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47900 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230205AbhFQHLJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 03:11:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ltm94-001XeC-Vf; Thu, 17 Jun 2021 10:09:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 17 Jun 2021 10:08:46 +0300
Message-Id: <iwlwifi.20210617100544.597f4246c79d.Ia0a1bbc2e66b4e849174db685208fc2b8bd5732e@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617070852.496985-1-luca@coelho.fi>
References: <20210617070852.496985-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 06/12] iwlwifi: mvm: Call NMI instead of REPLY_ERROR
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Harish Mitty <harish.mitty@intel.com>

For IWL_DEVICE_FAMILY_22000 & greater, driver will call
NMI instead of REPLY_ERROR as FW->Infra does not support
this command for this family onwards.

Signed-off-by: Harish Mitty <harish.mitty@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 63d65018d098..95f883aba148 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1023,7 +1023,9 @@ static ssize_t iwl_dbgfs_fw_restart_write(struct iwl_mvm *mvm, char *buf,
 		mvm->fw_restart++;
 
 	/* take the return value to make compiler happy - it will fail anyway */
-	ret = iwl_mvm_send_cmd_pdu(mvm, REPLY_ERROR, 0, 0, NULL);
+	ret = iwl_mvm_send_cmd_pdu(mvm,
+				   WIDE_ID(LONG_GROUP, REPLY_ERROR),
+				   0, 0, NULL);
 
 	mutex_unlock(&mvm->mutex);
 
-- 
2.32.0

