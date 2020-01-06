Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E215130EF2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAFIzL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:55:11 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51352 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725821AbgAFIzL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:55:11 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ioOAH-0007qa-1N; Mon, 06 Jan 2020 10:55:09 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  6 Jan 2020 10:54:51 +0200
Message-Id: <20200106085502.363205-2-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106085502.363205-1-luca@coelho.fi>
References: <20200106085502.363205-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 01/12] iwlwifi: mvm: Update BEACON_TEMPLATE_CMD firmware API
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

The new API version adds support for FILS discovery frames.
It adds a new flag and a field for short SSID configuration.
The new API is backward compatible, so we can just switch to it.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index f89a9e16a8c0..f1d1fe96fecc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -813,6 +813,7 @@ enum iwl_mac_beacon_flags {
 	IWL_MAC_BEACON_ANT_A	= BIT(9),
 	IWL_MAC_BEACON_ANT_B	= BIT(10),
 	IWL_MAC_BEACON_ANT_C	= BIT(11),
+	IWL_MAC_BEACON_FILS	= BIT(12),
 };
 
 /**
@@ -820,6 +821,7 @@ enum iwl_mac_beacon_flags {
  * @byte_cnt: byte count of the beacon frame.
  * @flags: least significant byte for rate code. The most significant byte
  *	is &enum iwl_mac_beacon_flags.
+ * @short_ssid: Short SSID
  * @reserved: reserved
  * @template_id: currently equal to the mac context id of the coresponding mac.
  * @tim_idx: the offset of the tim IE in the beacon
@@ -831,14 +833,15 @@ enum iwl_mac_beacon_flags {
 struct iwl_mac_beacon_cmd {
 	__le16 byte_cnt;
 	__le16 flags;
-	__le64 reserved;
+	__le32 short_ssid;
+	__le32 reserved;
 	__le32 template_id;
 	__le32 tim_idx;
 	__le32 tim_size;
 	__le32 ecsa_offset;
 	__le32 csa_offset;
 	struct ieee80211_hdr frame[0];
-} __packed; /* BEACON_TEMPLATE_CMD_API_S_VER_9 */
+} __packed; /* BEACON_TEMPLATE_CMD_API_S_VER_10 */
 
 struct iwl_beacon_notif {
 	struct iwl_mvm_tx_resp beacon_notify_hdr;
-- 
2.24.1

