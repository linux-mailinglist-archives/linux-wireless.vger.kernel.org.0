Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3D9316A0C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhBJPYx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:24:53 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45336 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230048AbhBJPYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:24:45 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rLR-0049nr-5U; Wed, 10 Feb 2021 17:23:57 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:23:48 +0200
Message-Id: <iwlwifi.20210210172142.dfd423b2b2ef.Icd576dc3e2e7174d3ed9c1c32f48ea0013699e72@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210152355.419776-1-luca@coelho.fi>
References: <20210210152355.419776-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 1/8] iwlwifi: mvm: reduce the print severity of failing getting NIC temp
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Golan Ben Ami <golan.ben.ami@intel.com>

Currently, for all devices and families, failing getting the temp
from the fw is indicated in the log as ERR.
This is too severe for two reasons:
1. The driver has a fall back - and schedules the next temp
read immediately after failing to read temp from the fw.
2. The temp read implementation in the fw is different between
HWs, and on older devices the flow is a-sync and may timeout.

Reducing the print severity from ERR to WARN will allow to
track the issue if it will appear many times, but not frighten users
if it appears once.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 790bc68a515a..2a7339b12b13 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -261,7 +261,7 @@ int iwl_mvm_get_temp(struct iwl_mvm *mvm, s32 *temp)
 	ret = iwl_wait_notification(&mvm->notif_wait, &wait_temp_notif,
 				    IWL_MVM_TEMP_NOTIF_WAIT_TIMEOUT);
 	if (ret)
-		IWL_ERR(mvm, "Getting the temperature timed out\n");
+		IWL_WARN(mvm, "Getting the temperature timed out\n");
 
 	return ret;
 }
-- 
2.30.0

