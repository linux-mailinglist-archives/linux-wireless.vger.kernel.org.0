Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9652127A56
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 12:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLTL4t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 06:56:49 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:53970 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727177AbfLTL4t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 06:56:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiGti-0007ip-HI; Fri, 20 Dec 2019 13:56:47 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 13:56:32 +0200
Message-Id: <20191220115638.1299888-5-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220115638.1299888-1-luca@coelho.fi>
References: <20191220115638.1299888-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 04/10] iwlwifi: pcie: detect the DMA bug and warn if it happens
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Warn if the DMA bug is going to happen. We don't have a good
way of actually aborting in this case and we have workarounds
in place for the cases where it happens, but in order to not
be surprised add a safety-check and warn.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index b2a3a1c18bec..090c1156bc21 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -231,6 +231,17 @@ static int iwl_pcie_gen2_set_tb(struct iwl_trans *trans,
 	int idx = iwl_pcie_gen2_get_num_tbs(trans, tfd);
 	struct iwl_tfh_tb *tb;
 
+	/*
+	 * Only WARN here so we know about the issue, but we mess up our
+	 * unmap path because not every place currently checks for errors
+	 * returned from this function - it can only return an error if
+	 * there's no more space, and so when we know there is enough we
+	 * don't always check ...
+	 */
+	WARN(crosses_4g_boundary(addr, len),
+	     "possible DMA problem with iova:0x%llx, len:%d\n",
+	     (unsigned long long)addr, len);
+
 	if (WARN_ON(idx >= IWL_TFH_NUM_TBS))
 		return -EINVAL;
 	tb = &tfd->tbs[idx];
-- 
2.24.0

