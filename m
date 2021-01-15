Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543852F77B2
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 12:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbhAOLdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 06:33:49 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40418 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726019AbhAOLdt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 06:33:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l0Mvi-003hBK-Qs; Fri, 15 Jan 2021 13:06:11 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 15 Jan 2021 13:05:56 +0200
Message-Id: <iwlwifi.20210115130252.97172cbaa67c.I3473233d0ad01a71aa9400832fb2b9f494d88a11@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115110558.1248847-1-luca@coelho.fi>
References: <20210115110558.1248847-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 10/12] iwlwifi: pcie: fix context info memory leak
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the image loader allocation fails, we leak all the previously
allocated memory. Fix this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c  | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 342a53e4488c..5b5134dd49af 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -198,8 +198,10 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	/* Allocate IML */
 	iml_img = dma_alloc_coherent(trans->dev, trans->iml_len,
 				     &trans_pcie->iml_dma_addr, GFP_KERNEL);
-	if (!iml_img)
-		return -ENOMEM;
+	if (!iml_img) {
+		ret = -ENOMEM;
+		goto err_free_ctxt_info;
+	}
 
 	memcpy(iml_img, trans->iml, trans->iml_len);
 
@@ -237,6 +239,11 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 
 	return 0;
 
+err_free_ctxt_info:
+	dma_free_coherent(trans->dev, sizeof(*trans_pcie->ctxt_info_gen3),
+			  trans_pcie->ctxt_info_gen3,
+			  trans_pcie->ctxt_info_dma_addr);
+	trans_pcie->ctxt_info_gen3 = NULL;
 err_free_prph_info:
 	dma_free_coherent(trans->dev,
 			  sizeof(*prph_info),
-- 
2.29.2

