Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D86427EEE4
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbgI3QUP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 12:20:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53460 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730737AbgI3QUM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 12:20:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNept-002MPc-Kd; Wed, 30 Sep 2020 19:20:10 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 19:19:56 +0300
Message-Id: <iwlwifi.20200930191738.b56248653e12.I0a15c61aa1f1b4e91aa83ec5eb082337da4e9547@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930161959.983283-1-luca@coelho.fi>
References: <20200930161959.983283-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/12] iwlwifi: use correct group for alive notification
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Alive notification belongs to LEGACY_GROUP. Fix it.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index ccacf1576617..4ea1032d8263 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -217,7 +217,7 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	u32 lmac_error_event_table, umac_error_table;
 
 	/* we don't use the SKU ID from v5 yet, so handle it as v4 */
-	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
+	if (iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
 				    UCODE_ALIVE_NTFY, 0) == 5 ||
 	    iwl_rx_packet_payload_len(pkt) == sizeof(struct iwl_alive_ntf_v4)) {
 		struct iwl_alive_ntf_v4 *palive;
-- 
2.28.0

