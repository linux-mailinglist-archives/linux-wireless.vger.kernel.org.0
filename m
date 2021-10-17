Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40392430957
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbhJQN20 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 09:28:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53882 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343709AbhJQN2Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 09:28:24 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6B2-000YdS-VC; Sun, 17 Oct 2021 16:26:13 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:26:00 +0300
Message-Id: <iwlwifi.20211017162352.b5aaabb04432.I999f86ed6a9d9b99e63a33f724963f83f85fbb44@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017132604.480251-1-luca@coelho.fi>
References: <20211017132604.480251-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/12] iwlwifi: mvm: Add RTS and CTS flags to iwl_tx_cmd_flags.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As part of the new rate_n_flags, the RTS and CTS flags
are being removed from it. Instead, we have these flags
in the flags field in the TX command.
Add to new flags to the iwl_tx_cmd_flags enum.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index b7090ae95cfb..9b3bce83efb6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -81,6 +81,10 @@ enum iwl_tx_cmd_flags {
 	IWL_TX_FLAGS_CMD_RATE		= BIT(0),
 	IWL_TX_FLAGS_ENCRYPT_DIS	= BIT(1),
 	IWL_TX_FLAGS_HIGH_PRI		= BIT(2),
+	/* Use these flags only from
+	 * TX_FLAGS_BITS_API_S_VER_4 and above */
+	IWL_TX_FLAGS_RTS		= BIT(3),
+	IWL_TX_FLAGS_CTS		= BIT(4),
 }; /* TX_FLAGS_BITS_API_S_VER_3 */
 
 /**
-- 
2.33.0

