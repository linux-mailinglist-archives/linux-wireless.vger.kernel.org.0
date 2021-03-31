Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18D34FC58
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 11:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhCaJPH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 05:15:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43742 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234684AbhCaJO6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 05:14:58 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lRWwB-00087q-8d; Wed, 31 Mar 2021 12:14:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Mar 2021 12:14:43 +0300
Message-Id: <iwlwifi.20210331121101.e7982c72e12b.Ib6db362d01a31132c638e194d49476cd8e3ff430@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210331091452.543321-1-luca@coelho.fi>
References: <20210331091452.543321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 03/12] iwlwifi: mvm: when associated with PMF, use protected NDP ranging negotiation
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When associated to the resonder with PMF, request to protect the NDP
ranging negotiation with PMF.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 24ca2934bea0..a456b8a0ae58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -490,6 +490,15 @@ iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (vif->bss_conf.assoc &&
 	    !memcmp(peer->addr, vif->bss_conf.bssid, ETH_ALEN)) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+		struct ieee80211_sta *sta;
+
+		rcu_read_lock();
+
+		sta = rcu_dereference(mvm->fw_id_to_mac_id[mvmvif->ap_sta_id]);
+		if (sta->mfp)
+			FTM_PUT_FLAG(PMF);
+
+		rcu_read_unlock();
 
 		target->sta_id = mvmvif->ap_sta_id;
 	} else {
-- 
2.31.0

