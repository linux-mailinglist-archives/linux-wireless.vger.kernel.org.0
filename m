Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5014A17BE0C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2020 14:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgCFNQq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Mar 2020 08:16:46 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:60922 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727401AbgCFNQp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Mar 2020 08:16:45 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jACqK-0005yR-7i; Fri, 06 Mar 2020 15:16:44 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  6 Mar 2020 15:16:22 +0200
Message-Id: <iwlwifi.20200306151128.492d167c1a25.I1ad1353dbbf6c99ae57814be750f41a1c9f7f4ac@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306131627.503176-1-luca@coelho.fi>
References: <20200306131627.503176-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.6 2/7] iwlwifi: consider HE capability when setting LDPC
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The AP may set the LDPC capability only in HE (IEEE80211_HE_PHY_CAP1),
but we were checking it only in the HT capabilities.

If we don't use this capability when required, the DSP gets the wrong
configuration in HE and doesn't work properly.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Fixes: befebbb30af0 ("iwlwifi: rs: consider LDPC capability in case of HE")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index e2cf9e015ef8..80ef238a8488 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -147,7 +147,11 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 	     (vht_ena && (vht_cap->cap & IEEE80211_VHT_CAP_RXLDPC))))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
-	/* consider our LDPC support in case of HE */
+	/* consider LDPC support in case of HE */
+	if (he_cap->has_he && (he_cap->he_cap_elem.phy_cap_info[1] &
+	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
+		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
+
 	if (sband->iftype_data && sband->iftype_data->he_cap.has_he &&
 	    !(sband->iftype_data->he_cap.he_cap_elem.phy_cap_info[1] &
 	     IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
-- 
2.25.1

