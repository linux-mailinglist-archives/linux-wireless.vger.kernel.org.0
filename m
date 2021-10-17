Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80F243074B
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 10:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245103AbhJQIqL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 04:46:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53592 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245109AbhJQIqI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 04:46:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc1lt-000YRM-MI; Sun, 17 Oct 2021 11:43:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 11:43:46 +0300
Message-Id: <iwlwifi.20211017113927.022a9f87fdbd.Iae7b8a0196b6e94f9dc525e92a541a28374b0cac@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017084348.401570-1-luca@coelho.fi>
References: <20211017084348.401570-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
Subject: [PATCH 08/10] iwlwifi: api: remove unused RX status bits
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

These bits are unused and don't actually exist in the firmware
API any longer. Remove them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 88d600b376dc..aa43ef67a2b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -125,14 +125,12 @@ enum iwl_rx_phy_flags {
  * @RX_MPDU_RES_STATUS_OVERRUN_OK: there was no RXE overflow
  * @RX_MPDU_RES_STATUS_SRC_STA_FOUND: station was found
  * @RX_MPDU_RES_STATUS_KEY_VALID: key was valid
- * @RX_MPDU_RES_STATUS_KEY_PARAM_OK: key parameters were usable
  * @RX_MPDU_RES_STATUS_ICV_OK: ICV is fine, if not, the packet is destroyed
  * @RX_MPDU_RES_STATUS_MIC_OK: used for CCM alg only. TKIP MIC is checked
  *	in the driver.
  * @RX_MPDU_RES_STATUS_TTAK_OK: TTAK is fine
  * @RX_MPDU_RES_STATUS_MNG_FRAME_REPLAY_ERR:  valid for alg = CCM_CMAC or
- *	alg = CCM only. Checks replay attack for 11w frames. Relevant only if
- *	%RX_MPDU_RES_STATUS_ROBUST_MNG_FRAME is set.
+ *	alg = CCM only. Checks replay attack for 11w frames.
  * @RX_MPDU_RES_STATUS_SEC_NO_ENC: this frame is not encrypted
  * @RX_MPDU_RES_STATUS_SEC_WEP_ENC: this frame is encrypted using WEP
  * @RX_MPDU_RES_STATUS_SEC_CCM_ENC: this frame is encrypted using CCM
@@ -144,9 +142,6 @@ enum iwl_rx_phy_flags {
  * @RX_MPDU_RES_STATUS_SEC_ENC_ERR: this frame couldn't be decrypted
  * @RX_MPDU_RES_STATUS_SEC_ENC_MSK: bitmask of the encryption algorithm
  * @RX_MPDU_RES_STATUS_DEC_DONE: this frame has been successfully decrypted
- * @RX_MPDU_RES_STATUS_EXT_IV_BIT_CMP: extended IV (set with TKIP)
- * @RX_MPDU_RES_STATUS_KEY_ID_CMP_BIT: key ID comparison done
- * @RX_MPDU_RES_STATUS_ROBUST_MNG_FRAME: this frame is an 11w management frame
  * @RX_MPDU_RES_STATUS_CSUM_DONE: checksum was done by the hw
  * @RX_MPDU_RES_STATUS_CSUM_OK: checksum found no errors
  * @RX_MPDU_RES_STATUS_STA_ID_MSK: station ID mask
@@ -157,7 +152,6 @@ enum iwl_mvm_rx_status {
 	RX_MPDU_RES_STATUS_OVERRUN_OK			= BIT(1),
 	RX_MPDU_RES_STATUS_SRC_STA_FOUND		= BIT(2),
 	RX_MPDU_RES_STATUS_KEY_VALID			= BIT(3),
-	RX_MPDU_RES_STATUS_KEY_PARAM_OK			= BIT(4),
 	RX_MPDU_RES_STATUS_ICV_OK			= BIT(5),
 	RX_MPDU_RES_STATUS_MIC_OK			= BIT(6),
 	RX_MPDU_RES_STATUS_TTAK_OK			= BIT(7),
@@ -171,9 +165,6 @@ enum iwl_mvm_rx_status {
 	RX_MPDU_RES_STATUS_SEC_ENC_ERR			= (7 << 8),
 	RX_MPDU_RES_STATUS_SEC_ENC_MSK			= (7 << 8),
 	RX_MPDU_RES_STATUS_DEC_DONE			= BIT(11),
-	RX_MPDU_RES_STATUS_EXT_IV_BIT_CMP		= BIT(13),
-	RX_MPDU_RES_STATUS_KEY_ID_CMP_BIT		= BIT(14),
-	RX_MPDU_RES_STATUS_ROBUST_MNG_FRAME		= BIT(15),
 	RX_MPDU_RES_STATUS_CSUM_DONE			= BIT(16),
 	RX_MPDU_RES_STATUS_CSUM_OK			= BIT(17),
 	RX_MDPU_RES_STATUS_STA_ID_SHIFT			= 24,
@@ -235,7 +226,6 @@ enum iwl_rx_mpdu_status {
 	IWL_RX_MPDU_STATUS_OVERRUN_OK		= BIT(1),
 	IWL_RX_MPDU_STATUS_SRC_STA_FOUND	= BIT(2),
 	IWL_RX_MPDU_STATUS_KEY_VALID		= BIT(3),
-	IWL_RX_MPDU_STATUS_KEY_PARAM_OK		= BIT(4),
 	IWL_RX_MPDU_STATUS_ICV_OK		= BIT(5),
 	IWL_RX_MPDU_STATUS_MIC_OK		= BIT(6),
 	IWL_RX_MPDU_RES_STATUS_TTAK_OK		= BIT(7),
@@ -250,12 +240,8 @@ enum iwl_rx_mpdu_status {
 	IWL_RX_MPDU_STATUS_SEC_EXT_ENC		= 0x4 << 8,
 	IWL_RX_MPDU_STATUS_SEC_GCM		= 0x5 << 8,
 	IWL_RX_MPDU_STATUS_DECRYPTED		= BIT(11),
-	IWL_RX_MPDU_STATUS_WEP_MATCH		= BIT(12),
-	IWL_RX_MPDU_STATUS_EXT_IV_MATCH		= BIT(13),
-	IWL_RX_MPDU_STATUS_KEY_ID_MATCH		= BIT(14),
 	IWL_RX_MPDU_STATUS_ROBUST_MNG_FRAME	= BIT(15),
 
-	IWL_RX_MPDU_STATUS_KEY			= 0x3f0000,
 	IWL_RX_MPDU_STATUS_DUPLICATE		= BIT(22),
 
 	IWL_RX_MPDU_STATUS_STA_ID		= 0x1f000000,
-- 
2.33.0

