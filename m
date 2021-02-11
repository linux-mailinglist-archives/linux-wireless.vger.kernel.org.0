Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9DF319486
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 21:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhBKUb6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 15:31:58 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45628 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231360AbhBKUbs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 15:31:48 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1lAIc4-004DFW-Bn; Thu, 11 Feb 2021 22:30:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 11 Feb 2021 22:30:55 +0200
Message-Id: <iwlwifi.20210211223049.40d545a0fa89.I04793aaa5312b926335c8db32131f000432df511@changeid>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH] iwlwifi: remove incorrect comment in pnvm
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We use this driver as a backport that also runs on older kernels (as
part of the backports project).  So we use some checks to backport or
prevent code from compiling in incompatible kernel version.

When I took one of the PNVM patches from the backport, I accidentally
left the comment that a certain part of the code doesn't work in older
kernels.  This obviously should never be valid for the mainline.
Remove this comment.

Reported-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 2cd07d2690e0..fd070ca5e517 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -220,11 +220,6 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 	return -ENOENT;
 }
 
-/*
- * This is known to be broken on v4.19 and to work on v5.4.  Until we
- * figure out why this is the case and how to make it work, simply
- * disable the feature in old kernels.
- */
 #if defined(CONFIG_EFI)
 
 #define IWL_EFI_VAR_GUID EFI_GUID(0x92daaf2f, 0xc02b, 0x455b,	\
-- 
2.30.0

