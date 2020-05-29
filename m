Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22EB1E7609
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 08:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgE2Gjm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 02:39:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:34980 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgE2Gjm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 02:39:42 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jeYg8-000jvb-5s; Fri, 29 May 2020 09:39:40 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 29 May 2020 09:39:21 +0300
Message-Id: <iwlwifi.20200529092401.c3e50c36c628.I991bfa662c0ef35de5be9eaf5b78ef190b67cb56@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529063931.80551-1-luca@coelho.fi>
References: <20200529063931.80551-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/11] iwlwifi: set NO_HE if the regulatory domain forbids it
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

If the firmware's regulatory domain forbids HE operation, set it
in the cfg80211 regdomain.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index d91a8e8349e6..ee410417761d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -240,6 +240,7 @@ enum iwl_nvm_channel_flags {
  * @REG_CAPA_40MHZ_FORBIDDEN: 11n channel with a width of 40Mhz is forbidden
  *	for this regulatory domain (valid only in 5Ghz).
  * @REG_CAPA_DC_HIGH_ENABLED: DC HIGH allowed.
+ * @REG_CAPA_11AX_DISABLED: 11ax is forbidden for this regulatory domain.
  */
 enum iwl_reg_capa_flags {
 	REG_CAPA_BF_CCD_LOW_BAND	= BIT(0),
@@ -250,6 +251,7 @@ enum iwl_reg_capa_flags {
 	REG_CAPA_MCS_9_ALLOWED		= BIT(5),
 	REG_CAPA_40MHZ_FORBIDDEN	= BIT(7),
 	REG_CAPA_DC_HIGH_ENABLED	= BIT(9),
+	REG_CAPA_11AX_DISABLED		= BIT(10),
 };
 
 static inline void iwl_nvm_print_channel_flags(struct device *dev, u32 level,
@@ -1115,6 +1117,9 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 			flags |= NL80211_RRF_NO_160MHZ;
 	}
 
+	if (cap_flags & REG_CAPA_11AX_DISABLED)
+		flags |= NL80211_RRF_NO_HE;
+
 	return flags;
 }
 
-- 
2.26.2

