Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BDF59759
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfF1JVr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:21:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54800 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726502AbfF1JVr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:21:47 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3U-0001ny-LA; Fri, 28 Jun 2019 12:20:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 18/20] iwlwifi: dbg: don't stop dbg recording before entering D3 from 9000 devices
Date:   Fri, 28 Jun 2019 12:20:06 +0300
Message-Id: <20190628092008.11049-19-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

From 9000 device family the FW automatically stops the debug
recording and the driver should not stop it as well.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 3a5710d32acf..47f1529b6491 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1078,11 +1078,12 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 #endif
 
 	/*
-	 * TODO: this is needed because the firmware is not stopping
-	 * the recording automatically before entering D3.  This can
-	 * be removed once the FW starts doing that.
+	 * Prior to 9000 device family the driver needs to stop the dbg
+	 * recording before entering D3. In later devices the FW stops the
+	 * recording automatically.
 	 */
-	_iwl_fw_dbg_stop_recording(mvm->fwrt.trans, NULL);
+	if (mvm->trans->cfg->device_family < IWL_DEVICE_FAMILY_9000)
+		_iwl_fw_dbg_stop_recording(mvm->trans, NULL);
 
 	/* must be last -- this switches firmware state */
 	ret = iwl_mvm_send_cmd(mvm, &d3_cfg_cmd);
-- 
2.20.1

