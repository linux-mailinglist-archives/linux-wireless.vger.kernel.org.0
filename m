Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B86430749
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 10:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245110AbhJQIqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 04:46:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53568 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234310AbhJQIqG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 04:46:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc1lp-000YRM-Q0; Sun, 17 Oct 2021 11:43:54 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 11:43:42 +0300
Message-Id: <iwlwifi.20211017113927.510f0ef9c2d5.If99bdb9009583ac7cc6cbb708e871a67df836dbe@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017084348.401570-1-luca@coelho.fi>
References: <20211017084348.401570-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/10] iwlwifi: add vendor specific capabilities for some RFs
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On some RFs we want to advertise vendor specific capabilities to
indicate support for improved beamforming rates and/or on 160 MHz,
some APs where Intel has collaborated with the vendor will use it
to improve behaviour. Add these elements where relevant, i.e. for
HR and GF RFs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 475f951d4b1e..f470f9aea50f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -534,6 +534,17 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 		cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE);
 }
 
+static const u8 iwl_vendor_caps[] = {
+	0xdd,			/* vendor element */
+	0x06,			/* length */
+	0x00, 0x17, 0x35,	/* Intel OUI */
+	0x08,			/* type (Intel Capabilities) */
+	/* followed by 16 bits of capabilities */
+#define IWL_VENDOR_CAP_IMPROVED_BF_FDBK_HE	BIT(0)
+	IWL_VENDOR_CAP_IMPROVED_BF_FDBK_HE,
+	0x00
+};
+
 static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 	{
 		.types_mask = BIT(NL80211_IFTYPE_STATION),
@@ -781,6 +792,12 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 	if (fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_BROADCAST_TWT))
 		iftype_data->he_cap.he_cap_elem.mac_cap_info[2] |=
 			IEEE80211_HE_MAC_CAP2_BCAST_TWT;
+
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000 &&
+	    !is_ap) {
+		iftype_data->vendor_elems.data = iwl_vendor_caps;
+		iftype_data->vendor_elems.len = ARRAY_SIZE(iwl_vendor_caps);
+	}
 }
 
 static void iwl_init_he_hw_capab(struct iwl_trans *trans,
-- 
2.33.0

