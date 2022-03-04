Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7214CD34B
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 12:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbiCDLWk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 06:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbiCDLWe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 06:22:34 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573D91B0C51
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 03:21:46 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nQ60F-000QSW-Ra;
        Fri, 04 Mar 2022 13:21:44 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Mar 2022 13:21:27 +0200
Message-Id: <iwlwifi.20220304131517.5fb34fb1f0eb.I4d7f2a4d162e80474540c5caf1194ed7d32977bc@changeid>
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
Subject: [PATCH 11/13] iwlwifi: dbg: check trigger data before access
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Without trigger data set, no point in any collection.
so check that we have the info for collecting the data.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index d3ac8ea049a4..abf49022edbe 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2905,6 +2905,11 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	if (!test_bit(wk_idx, &fwrt->dump.active_wks))
 		return;
 
+	if (!dump_data->trig) {
+		IWL_ERR(fwrt, "dump trigger data is not set\n");
+		goto out;
+	}
+
 	if (!test_bit(STATUS_DEVICE_ENABLED, &fwrt->trans->status)) {
 		IWL_ERR(fwrt, "Device is not enabled - cannot dump error\n");
 		goto out;
-- 
2.35.1

