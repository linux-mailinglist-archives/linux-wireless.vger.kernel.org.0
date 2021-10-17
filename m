Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63720430746
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 10:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbhJQIqC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 04:46:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53550 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245092AbhJQIqC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 04:46:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc1ln-000YRM-2f; Sun, 17 Oct 2021 11:43:51 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 11:43:39 +0300
Message-Id: <iwlwifi.20211017113927.8e992a3beee2.I4231ac8a7ae8f844e35a1ec221baf3e2b676e765@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017084348.401570-1-luca@coelho.fi>
References: <20211017084348.401570-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 01/10] iwlwifi: mvm: fix ieee80211_get_he_iftype_cap() iftype
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We should consider the P2P interface type, which isn't in
vif->type due to mac80211's special handling of that. Use
ieee80211_vif_type_p2p() to convert appropriately.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 3a4585222d6d..33198be6f039 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2022,7 +2022,8 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	}
 
 	sband = mvm->hw->wiphy->bands[chanctx_conf->def.chan->band];
-	own_he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
+	own_he_cap = ieee80211_get_he_iftype_cap(sband,
+						 ieee80211_vif_type_p2p(vif));
 
 	sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_ctxt_cmd.sta_id]);
 	if (IS_ERR_OR_NULL(sta)) {
-- 
2.33.0

