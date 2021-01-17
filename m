Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C702F9317
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 15:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbhAQOxm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 09:53:42 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40766 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729076AbhAQOxa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 09:53:30 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l19Q2-003sgA-9I; Sun, 17 Jan 2021 16:52:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 16:52:33 +0200
Message-Id: <iwlwifi.20210117164916.5184dfc2a445.I0631d2e4f6ffb93cf06618edb035c45bd6d1d7b9@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117145234.1435324-1-luca@coelho.fi>
References: <20210117145234.1435324-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 8/9] iwlwifi: mvm: debugfs: check length precisely in inject_packet
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we check the length, we only check that the advertised
data length fits into the data we have, but currently not
that it actually matches correctly.

This should be harmless, but if the first two bytes are zero,
then the iwl_rx_packet_payload_len() ends up negative, and
that might later cause issues if unsigned variables are used,
as this is not something that's normally expected.

Change the validation here to precisely validate the lengths
match, to avoid such issues.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 231c3489cc31..3834d7197e11 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1169,9 +1169,9 @@ static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mvm *mvm,
 	if (ret)
 		goto out;
 
-	/* avoid invalid memory access */
+	/* avoid invalid memory access and malformed packet */
 	if (bin_len < sizeof(*pkt) ||
-	    bin_len < sizeof(*pkt) + iwl_rx_packet_payload_len(pkt))
+	    bin_len != sizeof(*pkt) + iwl_rx_packet_payload_len(pkt))
 		goto out;
 
 	local_bh_disable();
-- 
2.29.2

