Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8F727E9FD
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 15:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgI3Nbc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 09:31:32 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53308 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730378AbgI3Nbb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 09:31:31 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNcCf-002MJ5-6g; Wed, 30 Sep 2020 16:31:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 16:31:14 +0300
Message-Id: <iwlwifi.20200930161256.fcebaa5c9bc8.Ic584cc47fee717d0bdb43965798dbdf45d89910a@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930133123.924256-1-luca@coelho.fi>
References: <20200930133123.924256-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/12] iwlwifi: mvm: responder: allow to set only the HLTK for an associated station
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

For secure ranging with an associated station, the driver only needs
to set the HLTK. There is no need to add an internal station for PMF
since the FW will use the existing station which already has the TK
installed.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/mvm/ftm-responder.c         | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index e940ef138f55..c794612c41d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -322,7 +322,7 @@ int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 				      u8 *hltk, u32 hltk_len)
 {
 	int ret;
-	struct iwl_mvm_pasn_sta *sta;
+	struct iwl_mvm_pasn_sta *sta = NULL;
 	struct iwl_mvm_pasn_hltk_data hltk_data = {
 		.addr = addr,
 		.hltk = hltk,
@@ -343,20 +343,23 @@ int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 		return -EINVAL;
 	}
 
-	sta = kmalloc(sizeof(*sta), GFP_KERNEL);
-	if (!sta)
-		return -ENOBUFS;
+	if (tk && tk_len) {
+		sta = kzalloc(sizeof(*sta), GFP_KERNEL);
+		if (!sta)
+			return -ENOBUFS;
 
-	ret = iwl_mvm_add_pasn_sta(mvm, vif, &sta->int_sta, addr, cipher, tk,
-				   tk_len);
-	if (ret) {
-		kfree(sta);
-		return ret;
+		ret = iwl_mvm_add_pasn_sta(mvm, vif, &sta->int_sta, addr,
+					   cipher, tk, tk_len);
+		if (ret) {
+			kfree(sta);
+			return ret;
+		}
 	}
 
 	ret = iwl_mvm_ftm_responder_dyn_cfg_v3(mvm, vif, NULL, &hltk_data);
 	if (ret) {
-		iwl_mvm_resp_del_pasn_sta(mvm, vif, sta);
+		if (sta)
+			iwl_mvm_resp_del_pasn_sta(mvm, vif, sta);
 		return ret;
 	}
 
-- 
2.28.0

