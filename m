Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 130B6926D0
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 16:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfHSOfX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 10:35:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36774 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726464AbfHSOfW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 10:35:22 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzikg-0007sP-NX; Mon, 19 Aug 2019 17:35:20 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 17:34:47 +0300
Message-Id: <20190819143507.6989-3-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819143507.6989-1-luca@coelho.fi>
References: <20190819143507.6989-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 02/22] iwlwifi: Send DQA enable command only if TVL is on
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilia Lin <ilia.lin@intel.com>

The newer targets don't support the DQA enablement command
and will return error status, while older targets need it.
The feature is defined by the corresponding TLV.
Send the command only if the TLV is enabled.

Signed-off-by: Ilia Lin <ilia.lin@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5de54d1559dd..a57fc6198a72 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1246,9 +1246,11 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	/* reset quota debouncing buffer - 0xff will yield invalid data */
 	memset(&mvm->last_quota_cmd, 0xff, sizeof(mvm->last_quota_cmd));
 
-	ret = iwl_mvm_send_dqa_cmd(mvm);
-	if (ret)
-		goto error;
+	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_DQA_SUPPORT)) {
+		ret = iwl_mvm_send_dqa_cmd(mvm);
+		if (ret)
+			goto error;
+	}
 
 	/* Add auxiliary station for scanning */
 	ret = iwl_mvm_add_aux_sta(mvm);
-- 
2.23.0.rc1

