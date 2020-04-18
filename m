Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D086F1AEABA
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDRIJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56752 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725970AbgDRIJT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXL-000L3r-Mn; Sat, 18 Apr 2020 11:09:16 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:48 +0300
Message-Id: <iwlwifi.20200418110539.93860da2d12a.Ifeca3b3313e3f14330317bc3e3d62f7d991ec955@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418080857.2232093-1-luca@coelho.fi>
References: <20200418080857.2232093-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/12] iwlwifi: remove deprecated and unused iwl_mvm_keyinfo struct
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This struct hasn't been used in years and is just a remnant of an API
support removal that missed this structured.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   | 26 -------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
index 970e9e508ad0..c010e6febbf4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
@@ -245,32 +245,6 @@ enum iwl_sta_sleep_flag {
 #define STA_KEY_LEN_WEP40 (5)
 #define STA_KEY_LEN_WEP104 (13)
 
-/**
- * struct iwl_mvm_keyinfo - key information
- * @key_flags: type &enum iwl_sta_key_flag
- * @tkip_rx_tsc_byte2: TSC[2] for key mix ph1 detection
- * @reserved1: reserved
- * @tkip_rx_ttak: 10-byte unicast TKIP TTAK for Rx
- * @key_offset: key offset in the fw's key table
- * @reserved2: reserved
- * @key: 16-byte unicast decryption key
- * @tx_secur_seq_cnt: initial RSC / PN needed for replay check
- * @hw_tkip_mic_rx_key: byte: MIC Rx Key - used for TKIP only
- * @hw_tkip_mic_tx_key: byte: MIC Tx Key - used for TKIP only
- */
-struct iwl_mvm_keyinfo {
-	__le16 key_flags;
-	u8 tkip_rx_tsc_byte2;
-	u8 reserved1;
-	__le16 tkip_rx_ttak[5];
-	u8 key_offset;
-	u8 reserved2;
-	u8 key[16];
-	__le64 tx_secur_seq_cnt;
-	__le64 hw_tkip_mic_rx_key;
-	__le64 hw_tkip_mic_tx_key;
-} __packed;
-
 #define IWL_ADD_STA_STATUS_MASK		0xFF
 #define IWL_ADD_STA_BAID_VALID_MASK	0x8000
 #define IWL_ADD_STA_BAID_MASK		0x7F00
-- 
2.25.1

