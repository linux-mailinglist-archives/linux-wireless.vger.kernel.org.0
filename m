Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E51B8583
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgDYKFS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:05:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58242 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726116AbgDYKFQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:05:16 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jSHgP-000P3t-Gh; Sat, 25 Apr 2020 13:05:13 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 25 Apr 2020 13:04:54 +0300
Message-Id: <iwlwifi.20200425130140.851866c7e4c4.I13fa678929431f1694fd202c1da40aa476ab70fe@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200425100459.2778317-1-luca@coelho.fi>
References: <20200425100459.2778317-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/11] iwlwifi: use longer queues for 256-BA
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we have 256 block-ack support, we may need to be very fast
to provide a lot of frames to the hardware to transmit, but that
cannot be guaranteed. Use a longer queue size to have more time,
and the next possible queue size is 1024 since it must be a power
of two.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 1fcc346ba425..1daa653bcb99 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -211,7 +211,7 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.trans.base_params = &iwl_ax210_base_params,			\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
-	.min_256_ba_txq_size = 512,					\
+	.min_256_ba_txq_size = 1024,					\
 	.mon_dram_regs = {						\
 		.write_ptr = {						\
 			.addr = DBGC_CUR_DBGBUF_STATUS,			\
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index a8e988281eaf..e77d8d13cb51 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -646,7 +646,7 @@ struct iwl_rb_status {
 #define TFD_QUEUE_CB_SIZE(x)	(ilog2(x) - 3)
 #define TFD_QUEUE_SIZE_BC_DUP	(64)
 #define TFD_QUEUE_BC_SIZE	(TFD_QUEUE_SIZE_MAX + TFD_QUEUE_SIZE_BC_DUP)
-#define TFD_QUEUE_BC_SIZE_GEN3	512
+#define TFD_QUEUE_BC_SIZE_GEN3	1024
 #define IWL_TX_DMA_MASK        DMA_BIT_MASK(36)
 #define IWL_NUM_OF_TBS		20
 #define IWL_TFH_NUM_TBS		25
-- 
2.26.2

