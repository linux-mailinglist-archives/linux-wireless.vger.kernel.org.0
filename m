Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4112876C9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbgJHPKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:10:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54474 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730880AbgJHPJ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:09:59 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXYK-002Qut-VZ; Thu, 08 Oct 2020 18:09:57 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:09:41 +0300
Message-Id: <iwlwifi.20201008180656.3b8936035273.I7799caa225295de44558e9da093b720afe606359@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008150949.331882-1-luca@coelho.fi>
References: <20201008150949.331882-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/13] iwlwifi: mvm: stop claiming NL80211_EXT_FEATURE_SET_SCAN_DWELL
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We've removed the code that handles it appropriately, so stop
claiming we support it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d1ba9d11244f..8695041ec3a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -677,8 +677,6 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 				      NL80211_EXT_FEATURE_SCAN_START_TIME);
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_BSS_PARENT_TSF);
-		wiphy_ext_feature_set(hw->wiphy,
-				      NL80211_EXT_FEATURE_SET_SCAN_DWELL);
 	}
 
 	if (iwl_mvm_is_oce_supported(mvm)) {
-- 
2.28.0

