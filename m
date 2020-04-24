Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9525E1B7C12
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 18:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgDXQr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 12:47:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57992 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728609AbgDXQrY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:24 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS1U1-000OcH-Oq; Fri, 24 Apr 2020 19:47:22 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 19:46:59 +0300
Message-Id: <iwlwifi.20200424194456.e10482b9eed7.I15da7bb25d9b9e3eef1c1b117dc585e703ce756a@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424164707.2715869-1-luca@coelho.fi>
References: <20200424164707.2715869-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/11] iwlwifi: yoyo: remove magic number
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The for loop is iterating over active regions so iterate only
over the len of the active regions buffer size.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 4df10f3d99d2..04de7688884d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2119,7 +2119,11 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 	u32 size = 0;
 	u64 regions_mask = le64_to_cpu(trigger->regions_mask);
 
-	for (i = 0; i < 64; i++) {
+	BUILD_BUG_ON(sizeof(trigger->regions_mask) != sizeof(regions_mask));
+	BUILD_BUG_ON((sizeof(trigger->regions_mask) * BITS_PER_BYTE) <
+		     ARRAY_SIZE(fwrt->trans->dbg.active_regions));
+
+	for (i = 0; i < ARRAY_SIZE(fwrt->trans->dbg.active_regions); i++) {
 		u32 reg_type;
 		struct iwl_fw_ini_region_tlv *reg;
 
-- 
2.26.2

