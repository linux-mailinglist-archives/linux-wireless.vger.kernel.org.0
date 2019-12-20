Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98892127A5B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 12:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLTL44 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 06:56:56 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54010 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727177AbfLTL4z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 06:56:55 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiGto-0007ip-7b; Fri, 20 Dec 2019 13:56:53 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 13:56:37 +0200
Message-Id: <20191220115638.1299888-10-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220115638.1299888-1-luca@coelho.fi>
References: <20191220115638.1299888-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 09/10] iwlwifi: Don't ignore the cap field upon mcc update
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

When receiving a new MCC driver get all the data about the new country
code and its regulatory information.
Mistakenly, we ignored the cap field, which includes global regulatory
information which should be applies to every channel.
Fix it.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 48 ++++++++++++++++++-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  6 +--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +-
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 1e240a2a8329..068e4924c04e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -224,6 +224,34 @@ enum iwl_nvm_channel_flags {
 	NVM_CHANNEL_DC_HIGH		= BIT(12),
 };
 
+/**
+ * enum iwl_reg_capa_flags - global flags applied for the whole regulatory
+ * domain.
+ * @REG_CAPA_BF_CCD_LOW_BAND: Beam-forming or Cyclic Delay Diversity in the
+ *	2.4Ghz band is allowed.
+ * @REG_CAPA_BF_CCD_HIGH_BAND: Beam-forming or Cyclic Delay Diversity in the
+ *	5Ghz band is allowed.
+ * @REG_CAPA_160MHZ_ALLOWED: 11ac channel with a width of 160Mhz is allowed
+ *	for this regulatory domain (valid only in 5Ghz).
+ * @REG_CAPA_80MHZ_ALLOWED: 11ac channel with a width of 80Mhz is allowed
+ *	for this regulatory domain (valid only in 5Ghz).
+ * @REG_CAPA_MCS_8_ALLOWED: 11ac with MCS 8 is allowed.
+ * @REG_CAPA_MCS_9_ALLOWED: 11ac with MCS 9 is allowed.
+ * @REG_CAPA_40MHZ_FORBIDDEN: 11n channel with a width of 40Mhz is forbidden
+ *	for this regulatory domain (valid only in 5Ghz).
+ * @REG_CAPA_DC_HIGH_ENABLED: DC HIGH allowed.
+ */
+enum iwl_reg_capa_flags {
+	REG_CAPA_BF_CCD_LOW_BAND	= BIT(0),
+	REG_CAPA_BF_CCD_HIGH_BAND	= BIT(1),
+	REG_CAPA_160MHZ_ALLOWED		= BIT(2),
+	REG_CAPA_80MHZ_ALLOWED		= BIT(3),
+	REG_CAPA_MCS_8_ALLOWED		= BIT(4),
+	REG_CAPA_MCS_9_ALLOWED		= BIT(5),
+	REG_CAPA_40MHZ_FORBIDDEN	= BIT(7),
+	REG_CAPA_DC_HIGH_ENABLED	= BIT(9),
+};
+
 static inline void iwl_nvm_print_channel_flags(struct device *dev, u32 level,
 					       int chan, u32 flags)
 {
@@ -1038,6 +1066,7 @@ IWL_EXPORT_SYMBOL(iwl_parse_nvm_data);
 
 static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 				       int ch_idx, u16 nvm_flags,
+				       u16 cap_flags,
 				       const struct iwl_cfg *cfg)
 {
 	u32 flags = NL80211_RRF_NO_HT40;
@@ -1076,13 +1105,27 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 	    (flags & NL80211_RRF_NO_IR))
 		flags |= NL80211_RRF_GO_CONCURRENT;
 
+	/*
+	 * cap_flags is per regulatory domain so apply it for every channel
+	 */
+	if (ch_idx >= NUM_2GHZ_CHANNELS) {
+		if (cap_flags & REG_CAPA_40MHZ_FORBIDDEN)
+			flags |= NL80211_RRF_NO_HT40;
+
+		if (!(cap_flags & REG_CAPA_80MHZ_ALLOWED))
+			flags |= NL80211_RRF_NO_80MHZ;
+
+		if (!(cap_flags & REG_CAPA_160MHZ_ALLOWED))
+			flags |= NL80211_RRF_NO_160MHZ;
+	}
+
 	return flags;
 }
 
 struct ieee80211_regdomain *
 iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
-		       u16 geo_info)
+		       u16 geo_info, u16 cap)
 {
 	int ch_idx;
 	u16 ch_flags;
@@ -1140,7 +1183,8 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		}
 
 		reg_rule_flags = iwl_nvm_get_regdom_bw_flags(nvm_chan, ch_idx,
-							     ch_flags, cfg);
+							     ch_flags, cap,
+							     cfg);
 
 		/* we can't continue the same rule */
 		if (ch_idx == 0 || prev_reg_rule_flags != reg_rule_flags ||
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index b7e1ddf8f177..4eeedb41e9ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -7,7 +7,7 @@
  *
  * Copyright(c) 2008 - 2015 Intel Corporation. All rights reserved.
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,7 +29,7 @@
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -103,7 +103,7 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 struct ieee80211_regdomain *
 iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
-		       u16 geo_info);
+		       u16 geo_info, u16 cap);
 
 /**
  * struct iwl_nvm_section - describes an NVM section in memory.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 481f1c9d814f..a46204b905d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -256,7 +256,8 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 				      __le32_to_cpu(resp->n_channels),
 				      resp->channels,
 				      __le16_to_cpu(resp->mcc),
-				      __le16_to_cpu(resp->geo_info));
+				      __le16_to_cpu(resp->geo_info),
+				      __le16_to_cpu(resp->cap));
 	/* Store the return source id */
 	src_id = resp->source_id;
 	kfree(resp);
-- 
2.24.0

