Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643176424B2
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 09:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiLEIgf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 03:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiLEIgb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 03:36:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C261EF5A7
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 00:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229389; x=1701765389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j9RzQRJLdjfPMMtpcrjEfnEY88LIyCJs4ahkyhyI5VE=;
  b=LffGYndYF64Y72XMa4V8US4dcUduiGIMFJnzwsvzzndRNkZ72/qMtxjT
   C+jlOkS06uSxqFdfYG84z13WiXXUn36TgEX9Y+ksAHJ9D/2ZcKXXj2PLt
   ym+0XBSEvkYK69cbz7suhCGGErvN9dfcGylXeC5TgxgZRn432vVgK76R5
   BePuQOhdkYhhqgyWlJtYR4j4k1DC0kNmeb7b/Ipu30uvcVwA1qQrGcTeH
   FBg0qdC8Ye6wC9Y8buuqlYht77TPCHnXzQuL3HonK+ApBLmcuRn7Iyvow
   Hn9ooorL48O/U+/JaFKBsnX5VECGPBvrSOrKSw3UZVG0EdqxKhyVnMK9O
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316323058"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316323058"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752100344"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="752100344"
Received: from eamit-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.181.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:12 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/11] wifi: iwlwifi: nvm-parse: enable WiFi7 for Fm radio for now
Date:   Mon,  5 Dec 2022 10:35:38 +0200
Message-Id: <20221205102808.f73face1a674.Ic62ee5c61c0ef2a5b5e9f89782b7bc82b0caa408@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205083548.236620-1-gregory.greenman@intel.com>
References: <20221205083548.236620-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We're still working out how the hardware/firmware (will) advertise
support for this - for now, assume that Fm radio supports it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 476b90f32626..aa8e08487b52 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1964,6 +1964,8 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_BAND_5_2_ENABLED);
 	nvm->sku_cap_mimo_disabled =
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_MIMO_DISABLED);
+	if (CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM)
+		nvm->sku_cap_11be_enable = true;
 
 	/* Initialize PHY sku data */
 	nvm->valid_tx_ant = (u8)le32_to_cpu(rsp->phy_sku.tx_chains);
-- 
2.35.3

