Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102EA316A11
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhBJPZE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:25:04 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45360 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231708AbhBJPYy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:24:54 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rLT-0049nr-EG; Wed, 10 Feb 2021 17:23:59 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:23:52 +0200
Message-Id: <iwlwifi.20210210172142.de94d366f3ff.I9a5a54906cf0f4ec8af981d6066bfd771152ffb9@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210152355.419776-1-luca@coelho.fi>
References: <20210210152355.419776-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 5/8] iwlwifi: pnvm: increment the pointer before checking the TLV
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

If the SKU_ID doesn't match, we don't increment the pointer and keep
checking the same TLV over and over again.

We need to increment the pointer in all situtations, namely if the TLV
is not a SKU_ID, if the SKU_ID matched or if the SKU_ID didn't match.
So we can increment the pointer already before checking for these
conditions to solve the problem.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: 6972592850c0 ("iwlwifi: read and parse PNVM file")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 1e16f83b402b..37ce4fe136c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -198,14 +198,14 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 				     le32_to_cpu(sku_id->data[1]),
 				     le32_to_cpu(sku_id->data[2]));
 
+			data += sizeof(*tlv) + ALIGN(tlv_len, 4);
+			len -= ALIGN(tlv_len, 4);
+
 			if (trans->sku_id[0] == le32_to_cpu(sku_id->data[0]) &&
 			    trans->sku_id[1] == le32_to_cpu(sku_id->data[1]) &&
 			    trans->sku_id[2] == le32_to_cpu(sku_id->data[2])) {
 				int ret;
 
-				data += sizeof(*tlv) + ALIGN(tlv_len, 4);
-				len -= ALIGN(tlv_len, 4);
-
 				ret = iwl_pnvm_handle_section(trans, data, len);
 				if (!ret)
 					return 0;
-- 
2.30.0

