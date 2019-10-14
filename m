Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F59D5C3C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 09:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfJNHUs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 03:20:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:49248 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730276AbfJNHUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 03:20:48 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJuem-0007ae-Jt; Mon, 14 Oct 2019 10:20:41 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 14 Oct 2019 10:20:19 +0300
Message-Id: <20191014101813.f290bf15b9a3.I32352bb41705f21cd7fa03665ff92fde2247924c@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014072019.1254-1-luca@coelho.fi>
References: <20191014072019.1254-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 16/16] iwlwifi: dbg_ini: support FW notification dumping in case of missed beacon
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Pass the FW notification packet to the dump collection flow to allow
the driver to include it in the dump file if requested.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 1934df7fccb8..f266647dc08c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1067,6 +1067,7 @@ void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
 		break;
 	case IWL_FW_INI_TIME_POINT_FW_RSP_OR_NOTIF:
+	case IWL_FW_INI_TIME_POINT_MISSED_BEACONS:
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data,
 				       iwl_dbg_tlv_check_fw_pkt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 9c417dd06291..70bb150ee0ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1404,6 +1404,7 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	u32 rx_missed_bcon, rx_missed_bcon_since_rx;
 	struct ieee80211_vif *vif;
 	u32 id = le32_to_cpu(mb->mac_id);
+	union iwl_dbg_tlv_tp_data tp_data = { .fw_pkt = pkt };
 
 	IWL_DEBUG_INFO(mvm,
 		       "missed bcn mac_id=%u, consecutive=%u (%u, %u, %u)\n",
@@ -1432,7 +1433,7 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 		ieee80211_beacon_loss(vif);
 
 	iwl_dbg_tlv_time_point(&mvm->fwrt,
-			       IWL_FW_INI_TIME_POINT_MISSED_BEACONS, NULL);
+			       IWL_FW_INI_TIME_POINT_MISSED_BEACONS, &tp_data);
 
 	trigger = iwl_fw_dbg_trigger_on(&mvm->fwrt, ieee80211_vif_to_wdev(vif),
 					FW_DBG_TRIGGER_MISSED_BEACONS);
-- 
2.23.0

