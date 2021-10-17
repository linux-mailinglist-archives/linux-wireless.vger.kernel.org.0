Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AC443074C
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 10:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbhJQIqM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 04:46:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53574 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245099AbhJQIqG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 04:46:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc1lq-000YRM-LM; Sun, 17 Oct 2021 11:43:55 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 11:43:43 +0300
Message-Id: <iwlwifi.20211017113927.32a13ac0f4d4.I883492648518cc5067a2f91b7ecf8bfa55f6876a@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017084348.401570-1-luca@coelho.fi>
References: <20211017084348.401570-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/10] iwlwifi: mvm: add support for 160Mhz in ranging measurements
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Add support for 160Mhz bandwidth in ranging measurements for
initiator and responder. Advertise 160Mhz in the supported
bandwidths for ranging.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/location.h  |  1 +
 .../wireless/intel/iwlwifi/mvm/ftm-initiator.c    | 12 ++++++++++++
 .../wireless/intel/iwlwifi/mvm/ftm-responder.c    | 15 ++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 ++-
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 6bbb8b8c91cd..294e733ecbc9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -629,6 +629,7 @@ enum iwl_location_bw {
 	IWL_LOCATION_BW_20MHZ,
 	IWL_LOCATION_BW_40MHZ,
 	IWL_LOCATION_BW_80MHZ,
+	IWL_LOCATION_BW_160MHZ,
 };
 
 #define TK_11AZ_LEN	32
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 03e5bf5cb909..73be95fffb95 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -324,6 +324,7 @@ iwl_mvm_ftm_target_chandef_v2(struct iwl_mvm *mvm,
 			      u8 *ctrl_ch_position)
 {
 	u32 freq = peer->chandef.chan->center_freq;
+	u8 cmd_ver;
 
 	*channel = ieee80211_frequency_to_channel(freq);
 
@@ -344,6 +345,17 @@ iwl_mvm_ftm_target_chandef_v2(struct iwl_mvm *mvm,
 		*format_bw = IWL_LOCATION_FRAME_FORMAT_VHT;
 		*format_bw |= IWL_LOCATION_BW_80MHZ << LOCATION_BW_POS;
 		break;
+	case NL80211_CHAN_WIDTH_160:
+		cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
+						TOF_RANGE_REQ_CMD,
+						IWL_FW_CMD_VER_UNKNOWN);
+
+		if (cmd_ver >= 13) {
+			*format_bw = IWL_LOCATION_FRAME_FORMAT_HE;
+			*format_bw |= IWL_LOCATION_BW_160MHZ << LOCATION_BW_POS;
+			break;
+		}
+		fallthrough;
 	default:
 		IWL_ERR(mvm, "Unsupported BW in FTM request (%d)\n",
 			peer->chandef.width);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index eba5433c2626..bda6da7d988e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -46,8 +46,8 @@ static int iwl_mvm_ftm_responder_set_bw_v1(struct cfg80211_chan_def *chandef,
 }
 
 static int iwl_mvm_ftm_responder_set_bw_v2(struct cfg80211_chan_def *chandef,
-					   u8 *format_bw,
-					   u8 *ctrl_ch_position)
+					   u8 *format_bw, u8 *ctrl_ch_position,
+					   u8 cmd_ver)
 {
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
@@ -68,6 +68,14 @@ static int iwl_mvm_ftm_responder_set_bw_v2(struct cfg80211_chan_def *chandef,
 		*format_bw |= IWL_LOCATION_BW_80MHZ << LOCATION_BW_POS;
 		*ctrl_ch_position = iwl_mvm_get_ctrl_pos(chandef);
 		break;
+	case NL80211_CHAN_WIDTH_160:
+		if (cmd_ver >= 9) {
+			*format_bw = IWL_LOCATION_FRAME_FORMAT_HE;
+			*format_bw |= IWL_LOCATION_BW_160MHZ << LOCATION_BW_POS;
+			*ctrl_ch_position = iwl_mvm_get_ctrl_pos(chandef);
+			break;
+		}
+		fallthrough;
 	default:
 		return -ENOTSUPP;
 	}
@@ -140,7 +148,8 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 
 	if (cmd_ver >= 7)
 		err = iwl_mvm_ftm_responder_set_bw_v2(chandef, &cmd.format_bw,
-						      &cmd.ctrl_ch_position);
+						      &cmd.ctrl_ch_position,
+						      cmd_ver);
 	else
 		err = iwl_mvm_ftm_responder_set_bw_v1(chandef, &cmd.format_bw,
 						      &cmd.ctrl_ch_position);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 33198be6f039..5374faa15684 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -145,7 +145,8 @@ static const struct cfg80211_pmsr_capabilities iwl_mvm_pmsr_capa = {
 		.bandwidths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
 			      BIT(NL80211_CHAN_WIDTH_20) |
 			      BIT(NL80211_CHAN_WIDTH_40) |
-			      BIT(NL80211_CHAN_WIDTH_80),
+			      BIT(NL80211_CHAN_WIDTH_80) |
+			      BIT(NL80211_CHAN_WIDTH_160),
 		.preambles = BIT(NL80211_PREAMBLE_LEGACY) |
 			     BIT(NL80211_PREAMBLE_HT) |
 			     BIT(NL80211_PREAMBLE_VHT) |
-- 
2.33.0

