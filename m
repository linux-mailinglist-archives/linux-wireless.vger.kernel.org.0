Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326C5309BD4
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 13:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhAaL6G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 06:58:06 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:42916 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231579AbhAaLy6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 06:54:58 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6AXz-004131-Dh; Sun, 31 Jan 2021 13:05:39 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 13:05:25 +0200
Message-Id: <iwlwifi.20210131125921.762e50704a39.I014bc7898f90c734f8e9be2a3efaf9bf8b7db6db@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131110533.887130-1-luca@coelho.fi>
References: <20210131110533.887130-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/12] iwlwifi: mvm: slightly clean up rs_fw_set_supp_rates()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The "supp" variable doesn't need to be unsigned long, only
"tmp" is used with for_each_set_bit(). "supp" should just
be a u16, since that's how it's sent to the firmware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 490a561c71db..8772b65c9dab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -248,14 +248,13 @@ static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
 				 struct iwl_tlc_config_cmd *cmd)
 {
 	int i;
-	unsigned long tmp;
-	unsigned long supp; /* must be unsigned long for for_each_set_bit */
+	u16 supp = 0;
+	unsigned long tmp; /* must be unsigned long for for_each_set_bit */
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
 	const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
 
 	/* non HT rates */
-	supp = 0;
 	tmp = sta->supp_rates[sband->band];
 	for_each_set_bit(i, &tmp, BITS_PER_LONG)
 		supp |= BIT(sband->bitrates[i].hw_value);
-- 
2.29.2

