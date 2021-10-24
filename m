Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849A64389C0
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhJXPXG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 11:23:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58614 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229564AbhJXPXG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mefIh-000czj-5z; Sun, 24 Oct 2021 18:20:44 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 18:20:26 +0300
Message-Id: <iwlwifi.20211024181719.7fc9988ed49b.I87e300fab664047581e51fb9b02744c75320d08c@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024152037.332948-1-luca@coelho.fi>
References: <20211024152037.332948-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 01/12] iwlwifi: fw: uefi: add missing include guards
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We still don't use #pragma once in the kernel, but even if
we did it'd be missing. Add the missing include guards.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 84c3c9952afb ("iwlwifi: move UEFI code to a separate file")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 45d0b36d79b5..d552c656ac9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -2,7 +2,8 @@
 /*
  * Copyright(c) 2021 Intel Corporation
  */
-
+#ifndef __iwl_fw_uefi__
+#define __iwl_fw_uefi__
 
 #define IWL_UEFI_OEM_PNVM_NAME		L"UefiCnvWlanOemSignedPnvm"
 #define IWL_UEFI_REDUCED_POWER_NAME	L"UefiCnvWlanReducedPower"
@@ -40,3 +41,5 @@ void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 	return ERR_PTR(-EOPNOTSUPP);
 }
 #endif /* CONFIG_EFI */
+
+#endif /* __iwl_fw_uefi__ */
-- 
2.33.0

