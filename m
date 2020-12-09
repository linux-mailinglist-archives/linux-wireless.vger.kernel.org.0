Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953D02D4CE3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbgLIVcm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:32:42 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35852 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388045AbgLIVcl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:32:41 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pq-003Drx-D1; Wed, 09 Dec 2020 23:17:18 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:37 +0200
Message-Id: <iwlwifi.20201209231352.c0105ddffa74.I1ddb243053ff763c91b663748b6a593ecc3b5634@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 33/47] iwlwifi: dbg-tlv: fix old length in is_trig_data_contained()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's a bug in the lengths - the 'old length' needs to be calculated
using the 'old' pointer, of course, likely a copy/paste mistake. Fix
this.

Reported-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: cf29c5b66b9f ("iwlwifi: dbg_ini: implement time point handling")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 51ce93d21ffe..8fa1c22fd96d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -808,7 +808,7 @@ static bool is_trig_data_contained(struct iwl_ucode_tlv *new,
 	struct iwl_fw_ini_trigger_tlv *old_trig = (void *)old->data;
 	__le32 *new_data = new_trig->data, *old_data = old_trig->data;
 	u32 new_dwords_num = iwl_tlv_array_len(new, new_trig, data);
-	u32 old_dwords_num = iwl_tlv_array_len(new, new_trig, data);
+	u32 old_dwords_num = iwl_tlv_array_len(old, old_trig, data);
 	int i, j;
 
 	for (i = 0; i < new_dwords_num; i++) {
-- 
2.29.2

