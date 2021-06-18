Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E6A3AC5AD
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhFRIFj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:05:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48072 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232808AbhFRID7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:03:59 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lu9RO-001YIf-3f; Fri, 18 Jun 2021 11:01:27 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 11:01:15 +0300
Message-Id: <iwlwifi.20210618105614.cd6f4e421430.Iec07c746c8e65bc267e4750f38e4f74f2010ca45@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618080121.588233-1-luca@coelho.fi>
References: <20210618080121.588233-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 04/10] iwlwifi: mvm: support LONG_GROUP for WOWLAN_GET_STATUSES version
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

It's been a while that the firmware uses LONG_GROUP by default
and not LEGACY_GROUP.
Until now the firmware wrongly advertise the WOWLAN_GET_STATUS
command's version with LEGACY_GROUP, but it is now being fixed.
In order to support both firmwares, first try to get the version
number of the command with the LONG_GROUP and if the firmware
didn't advertise the command version with LONG_GROUP, try to get
the command version with LEGACY_GROUP.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index e86f0e949b86..6617fe5a7ece 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1614,8 +1614,11 @@ struct iwl_wowlan_status *iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm)
 	len = iwl_rx_packet_payload_len(cmd.resp_pkt);
 
 	/* default to 7 (when we have IWL_UCODE_TLV_API_WOWLAN_KEY_MATERIAL) */
-	notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
-					    WOWLAN_GET_STATUSES, 7);
+	notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
+					    WOWLAN_GET_STATUSES, 0);
+	if (!notif_ver)
+		notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+						    WOWLAN_GET_STATUSES, 7);
 
 	if (!fw_has_api(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_API_WOWLAN_KEY_MATERIAL)) {
-- 
2.32.0

