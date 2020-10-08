Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EACA2876E0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbgJHPNC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:13:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54608 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729833AbgJHPNB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:13:01 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXbH-002QxQ-84; Thu, 08 Oct 2020 18:12:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:12:45 +0300
Message-Id: <iwlwifi.20201008181047.bb31ce80fc55.I8a272d1da1334b1805761c0731e5d0c76ca2ef29@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008151250.332346-1-luca@coelho.fi>
References: <20201008151250.332346-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/13] iwlwifi: rs: align to new TLC config command API
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The new API adds 4 bytes at end of the struct.  We just need to make
sure that we don't break compatibility with old FWs.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h | 7 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 8 +++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 73b839c3cac1..1ea54f643030 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -193,6 +193,8 @@ enum IWL_TLC_HT_BW_RATES {
  * @sgi_ch_width_supp: bitmap of SGI support per channel width
  *		       use BIT(@enum iwl_tlc_mng_cfg_cw)
  * @reserved2: reserved
+ * @max_tx_op: max TXOP in uSecs for all AC (BK, BE, VO, VI),
+ *	       set zero for no limit.
  */
 struct iwl_tlc_config_cmd {
 	u8 sta_id;
@@ -206,8 +208,9 @@ struct iwl_tlc_config_cmd {
 	__le16 ht_rates[IWL_TLC_NSS_MAX][2];
 	__le16 max_mpdu_len;
 	u8 sgi_ch_width_supp;
-	u8 reserved2[1];
-} __packed; /* TLC_MNG_CONFIG_CMD_API_S_VER_2 */
+	u8 reserved2;
+	__le32 max_tx_op;
+} __packed; /* TLC_MNG_CONFIG_CMD_API_S_VER_3 */
 
 /**
  * enum iwl_tlc_update_flags - updated fields
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 012123268ba9..e0e80906fdc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -468,6 +468,12 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		.amsdu = iwl_mvm_is_csum_supported(mvm),
 	};
 	int ret;
+	u16 cmd_size = sizeof(cfg_cmd);
+
+	/* In old versions of the API the struct is 4 bytes smaller */
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
+				  TLC_MNG_CONFIG_CMD, 0) < 3)
+		cmd_size -= 4;
 
 	memset(lq_sta, 0, offsetof(typeof(*lq_sta), pers));
 
@@ -482,7 +488,7 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	 */
 	sta->max_amsdu_len = max_amsdu_len;
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC, sizeof(cfg_cmd),
+	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC, cmd_size,
 				   &cfg_cmd);
 	if (ret)
 		IWL_ERR(mvm, "Failed to send rate scale config (%d)\n", ret);
-- 
2.28.0

