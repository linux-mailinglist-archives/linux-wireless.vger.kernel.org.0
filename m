Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FE34AA7E1
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Feb 2022 10:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354682AbiBEJVz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Feb 2022 04:21:55 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:38002 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1347508AbiBEJVy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Feb 2022 04:21:54 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nGHGS-0006b7-HH;
        Sat, 05 Feb 2022 11:21:53 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  5 Feb 2022 11:21:38 +0200
Message-Id: <iwlwifi.20220205112029.9fd32da15220.Ia88357dcf9f7ec7860f6111e41411868739cc9aa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205092140.751171-1-luca@coelho.fi>
References: <20220205092140.751171-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/12] iwlwifi: mvm: always remove the session protection after association
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware will soon stop removing the session protection for us after
association. While this was convenient, it was not symmetric.
Always remove the session protection after association, even for devices
that support the new API.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 8b0124a40ee9..6a9d9ce0007a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2628,11 +2628,8 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 		/*
 		 * We received a beacon from the associated AP so
 		 * remove the session protection.
-		 * A firmware with the new API will remove it automatically.
 		 */
-		if (!fw_has_capa(&mvm->fw->ucode_capa,
-				 IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
-			iwl_mvm_stop_session_protection(mvm, vif);
+		iwl_mvm_stop_session_protection(mvm, vif);
 
 		iwl_mvm_sf_update(mvm, vif, false);
 		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
-- 
2.34.1

