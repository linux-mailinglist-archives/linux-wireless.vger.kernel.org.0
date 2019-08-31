Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97199A43CE
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfHaJw6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:52:58 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39750 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbfHaJw6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:52:58 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400Q-0002OQ-EO; Sat, 31 Aug 2019 12:49:14 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:53 +0300
Message-Id: <20190831094859.6391-14-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 13/19] iwlwifi: allocate bigger nvm data in case of UHB
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

In case of Ultra-high-band (UHB), need to allocate nvm data structure in
size of UHB channels array.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index fd386bfbd5df..6d95941f56a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -942,7 +942,11 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	u16 lar_config;
 	const __le16 *ch_section;
 
-	if (cfg->nvm_type != IWL_NVM_EXT)
+	if (cfg->uhb_supported)
+		data = kzalloc(struct_size(data, channels,
+					   IWL_NVM_NUM_CHANNELS_UHB),
+					   GFP_KERNEL);
+	else if (cfg->nvm_type != IWL_NVM_EXT)
 		data = kzalloc(struct_size(data, channels,
 					   IWL_NVM_NUM_CHANNELS),
 					   GFP_KERNEL);
-- 
2.23.0.rc1

