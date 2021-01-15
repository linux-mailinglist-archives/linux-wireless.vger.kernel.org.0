Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0D2F7735
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 12:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhAOLGw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 06:06:52 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40288 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726278AbhAOLGw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 06:06:52 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l0Mvd-003hBK-A1; Fri, 15 Jan 2021 13:06:05 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 15 Jan 2021 13:05:49 +0200
Message-Id: <iwlwifi.20210115130252.929c2d680429.I086b9490e6c005f3bcaa881b617e9f61908160f3@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115110558.1248847-1-luca@coelho.fi>
References: <20210115110558.1248847-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 03/12] iwlwifi: pcie: avoid potential PNVM leaks
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we erroneously try to set the PNVM data again after it has
already been set, we could leak the old DMA memory. Avoid that
and warn, we shouldn't be doing this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 6972592850c0 ("iwlwifi: read and parse PNVM file")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 36bf414a388a..afe585228435 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -294,6 +294,9 @@ int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 		return ret;
 	}
 
+	if (WARN_ON(prph_sc_ctrl->pnvm_cfg.pnvm_size))
+		return -EBUSY;
+
 	prph_sc_ctrl->pnvm_cfg.pnvm_base_addr =
 		cpu_to_le64(trans_pcie->pnvm_dram.physical);
 	prph_sc_ctrl->pnvm_cfg.pnvm_size =
-- 
2.29.2

