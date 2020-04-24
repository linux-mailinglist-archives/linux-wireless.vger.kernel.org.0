Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18201B7A89
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 17:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgDXPsy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 11:48:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57964 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726698AbgDXPsx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 11:48:53 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS0Z9-000OY2-KS; Fri, 24 Apr 2020 18:48:36 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 18:48:16 +0300
Message-Id: <iwlwifi.20200424182644.bc7230b74f93.I144f73cd6a797a7060429981fee62572861bc76b@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424154818.2657602-1-luca@coelho.fi>
References: <20200424154818.2657602-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/12] iwlwifi: mvm: set properly station flags in STA_HE_CTXT_CMD
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

For ACK_ENABLED and 32BIT_BA_BITMAP flags check the station capabilities
rather than bss_conf.ack_enabled and bss_conf.multi_sta_back_32bit.
These fields are stations capabilities and should not be in bss_conf.
Also note that the bss_conf flags are set in station mode only.
In the next patch I will remove ack_enabled and multi_sta_back_32bit
from the bss_conf structure.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ee3d2ff432f7..10df77ab1a77 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2179,6 +2179,15 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 			flags |= STA_CTXT_HE_PACKET_EXT;
 		}
 	}
+
+	if (sta->he_cap.he_cap_elem.mac_cap_info[2] &
+	    IEEE80211_HE_MAC_CAP2_32BIT_BA_BITMAP)
+		flags |= STA_CTXT_HE_32BIT_BA_BITMAP;
+
+	if (sta->he_cap.he_cap_elem.mac_cap_info[2] &
+	    IEEE80211_HE_MAC_CAP2_ACK_EN)
+		flags |= STA_CTXT_HE_ACK_ENABLED;
+
 	rcu_read_unlock();
 
 	/* Mark MU EDCA as enabled, unless none detected on some AC */
@@ -2203,11 +2212,6 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 			cpu_to_le16(mu_edca->mu_edca_timer);
 	}
 
-	if (vif->bss_conf.multi_sta_back_32bit)
-		flags |= STA_CTXT_HE_32BIT_BA_BITMAP;
-
-	if (vif->bss_conf.ack_enabled)
-		flags |= STA_CTXT_HE_ACK_ENABLED;
 
 	if (vif->bss_conf.uora_exists) {
 		flags |= STA_CTXT_HE_TRIG_RND_ALLOC;
-- 
2.26.2

