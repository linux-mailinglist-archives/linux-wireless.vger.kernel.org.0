Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8024CD345
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 12:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiCDLWa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 06:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239289AbiCDLW2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 06:22:28 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841111B0BE1
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 03:21:41 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nQ60A-000QSW-QI;
        Fri, 04 Mar 2022 13:21:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Mar 2022 13:21:21 +0200
Message-Id: <iwlwifi.20220304131517.2a696656a161.I99705472a8838121ffaca72977015dc2069549b9@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304112129.219513-1-luca@coelho.fi>
References: <20220304112129.219513-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 05/13] iwlwifi: yoyo: disable IMR DRAM region if IMR is disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Disable IMR region if it is enabled in the TLVs,
but disabled at runtime by the FW.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a178b83ee8a2..f4de8250696f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -124,6 +124,7 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	u32 lmac_error_event_table, umac_error_table;
 	u32 version = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
 					      UCODE_ALIVE_NTFY, 0);
+	u32 i;
 
 	if (version == 6) {
 		struct iwl_alive_ntf_v6 *palive;
@@ -146,6 +147,28 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 			     mvm->trans->dbg.imr_data.imr_enable,
 			     mvm->trans->dbg.imr_data.imr_size,
 			     le64_to_cpu(mvm->trans->dbg.imr_data.imr_base_addr));
+
+		if (!mvm->trans->dbg.imr_data.imr_enable) {
+			for (i = 0; i < ARRAY_SIZE(mvm->trans->dbg.active_regions); i++) {
+				struct iwl_ucode_tlv *reg_tlv;
+				struct iwl_fw_ini_region_tlv *reg;
+
+				reg_tlv = mvm->trans->dbg.active_regions[i];
+				if (!reg_tlv)
+					continue;
+
+				reg = (void *)reg_tlv->data;
+				/*
+				 * We have only one DRAM IMR region, so we
+				 * can break as soon as we find the first
+				 * one.
+				 */
+				if (reg->type == IWL_FW_INI_REGION_DRAM_IMR) {
+					mvm->trans->dbg.unsupported_region_msk |= BIT(i);
+					break;
+				}
+			}
+		}
 	}
 
 	if (version >= 5) {
-- 
2.35.1

