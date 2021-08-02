Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A323DDAFB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbhHBO2o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:28:44 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50906 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233959AbhHBO2n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:28:43 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYvf-001xts-4d; Mon, 02 Aug 2021 17:28:32 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:28:18 +0300
Message-Id: <iwlwifi.20210802172232.2ff350d85eab.I02c5b5d29c0d5c2e014bd1081b07ed33772ae04d@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802142829.109448-1-luca@coelho.fi>
References: <20210802142829.109448-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 01/12] iwlwifi: mvm: remove trigger EAPOL time event
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

EAPOL failure results in deauthentication with various reasons, not
related to AUTH failure specifically, so we just merge AUTH failure
with failed to assoc to AP.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 70ebecb73c24..3a7f756c4545 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5035,22 +5035,14 @@ static void iwl_mvm_event_mlme_callback_ini(struct iwl_mvm *mvm,
 					    struct ieee80211_vif *vif,
 					    const  struct ieee80211_mlme_event *mlme)
 {
-	if (mlme->data == ASSOC_EVENT && (mlme->status == MLME_DENIED ||
-					  mlme->status == MLME_TIMEOUT)) {
+	if ((mlme->data == ASSOC_EVENT || mlme->data == AUTH_EVENT) &&
+	    (mlme->status == MLME_DENIED || mlme->status == MLME_TIMEOUT)) {
 		iwl_dbg_tlv_time_point(&mvm->fwrt,
 				       IWL_FW_INI_TIME_POINT_ASSOC_FAILED,
 				       NULL);
 		return;
 	}
 
-	if (mlme->data == AUTH_EVENT && (mlme->status == MLME_DENIED ||
-					 mlme->status == MLME_TIMEOUT)) {
-		iwl_dbg_tlv_time_point(&mvm->fwrt,
-				       IWL_FW_INI_TIME_POINT_EAPOL_FAILED,
-				       NULL);
-		return;
-	}
-
 	if (mlme->data == DEAUTH_RX_EVENT || mlme->data == DEAUTH_TX_EVENT) {
 		iwl_dbg_tlv_time_point(&mvm->fwrt,
 				       IWL_FW_INI_TIME_POINT_DEASSOC,
-- 
2.32.0

