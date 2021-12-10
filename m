Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6036946FD7D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhLJJQd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:16:33 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50908 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239107AbhLJJQc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:16:32 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvbxY-001FED-2R; Fri, 10 Dec 2021 11:12:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 11:12:41 +0200
Message-Id: <iwlwifi.20211210110539.84848da8067f.Ifb4f80c95d283ec62e495a7928069af711b5fee2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210091245.289008-1-luca@coelho.fi>
References: <20211210091245.289008-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/10] iwlwifi: fix debug TLV parsing
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Debug TLV parsing was missing size checks, so if a valid but
too short TLV was encountered, it would attempt to read it.
If the firmware file was arranged to be a multiple of pages
long with this happening just before the end, it could crash
reading out-of-bounds of a vmalloc area.

Fix this by adding the relevant size check.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index a8ebc26d1da1..c2fbda2ffe7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -300,14 +300,21 @@ static int (*dbg_tlv_alloc[])(struct iwl_trans *trans,
 void iwl_dbg_tlv_alloc(struct iwl_trans *trans, const struct iwl_ucode_tlv *tlv,
 		       bool ext)
 {
-	const struct iwl_fw_ini_header *hdr = (const void *)&tlv->data[0];
-	u32 type = le32_to_cpu(tlv->type);
-	u32 tlv_idx = type - IWL_UCODE_TLV_DEBUG_BASE;
-	u32 domain = le32_to_cpu(hdr->domain);
 	enum iwl_ini_cfg_state *cfg_state = ext ?
 		&trans->dbg.external_ini_cfg : &trans->dbg.internal_ini_cfg;
+	const struct iwl_fw_ini_header *hdr = (const void *)&tlv->data[0];
+	u32 type;
+	u32 tlv_idx;
+	u32 domain;
 	int ret;
 
+	if (le32_to_cpu(tlv->length) < sizeof(*hdr))
+		return;
+
+	type = le32_to_cpu(tlv->type);
+	tlv_idx = type - IWL_UCODE_TLV_DEBUG_BASE;
+	domain = le32_to_cpu(hdr->domain);
+
 	if (domain != IWL_FW_INI_DOMAIN_ALWAYS_ON &&
 	    !(domain & trans->dbg.domains_bitmap)) {
 		IWL_DEBUG_FW(trans,
-- 
2.34.1

