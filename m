Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F663DDFB0
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhHBS7N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 14:59:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51006 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229663AbhHBS7M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 14:59:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAd9P-001ySl-NQ; Mon, 02 Aug 2021 21:59:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 21:58:48 +0300
Message-Id: <iwlwifi.20210802215208.90257303559f.I4c4342229dcb9513099a3152605f0947423e86dc@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802185856.175567-1-luca@coelho.fi>
References: <20210802185856.175567-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 02/10] iwlwifi: split off Bz devices into their own family
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

These devices have some places with different behaviour
required, so split them off into their own family as they
should be.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 33 ++++++++++++++++---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 7f1faa9d97b4..fb0ad4e19cc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -215,6 +215,29 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 		},							\
 	}
 
+#define IWL_DEVICE_BZ							\
+	IWL_DEVICE_22000_COMMON,					\
+	.trans.umac_prph_offset = 0x300000,				\
+	.trans.device_family = IWL_DEVICE_FAMILY_BZ,			\
+	.trans.base_params = &iwl_ax210_base_params,			\
+	.min_txq_size = 128,						\
+	.gp2_reg_addr = 0xd02c68,					\
+	.min_256_ba_txq_size = 1024,					\
+	.mon_dram_regs = {						\
+		.write_ptr = {						\
+			.addr = DBGC_CUR_DBGBUF_STATUS,			\
+			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,	\
+		},							\
+		.cycle_cnt = {						\
+			.addr = DBGC_DBGBUF_WRAP_AROUND,		\
+			.mask = 0xffffffff,				\
+		},							\
+		.cur_frag = {						\
+			.addr = DBGC_CUR_DBGBUF_STATUS,			\
+			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
+		},							\
+	}
+
 const struct iwl_cfg_trans_params iwl_qnj_trans_cfg = {
 	.mq_rx_supported = true,
 	.use_tfh = true,
@@ -373,7 +396,7 @@ const struct iwl_cfg_trans_params iwl_ma_trans_cfg = {
 };
 
 const struct iwl_cfg_trans_params iwl_bz_trans_cfg = {
-	.device_family = IWL_DEVICE_FAMILY_AX210,
+	.device_family = IWL_DEVICE_FAMILY_BZ,
 	.base_params = &iwl_ax210_base_params,
 	.mq_rx_supported = true,
 	.use_tfh = true,
@@ -763,28 +786,28 @@ const struct iwl_cfg iwl_cfg_quz_a0_hr_b0 = {
 const struct iwl_cfg iwl_cfg_bz_a0_hr_b0 = {
 	.fw_name_pre = IWL_BZ_A_HR_B_FW_PRE,
 	.uhb_supported = true,
-	IWL_DEVICE_AX210,
+	IWL_DEVICE_BZ,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
 const struct iwl_cfg iwl_cfg_bz_a0_gf_a0 = {
 	.fw_name_pre = IWL_BZ_A_GF_A_FW_PRE,
 	.uhb_supported = true,
-	IWL_DEVICE_AX210,
+	IWL_DEVICE_BZ,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
 const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0 = {
 	.fw_name_pre = IWL_BZ_A_GF4_A_FW_PRE,
 	.uhb_supported = true,
-	IWL_DEVICE_AX210,
+	IWL_DEVICE_BZ,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
 const struct iwl_cfg iwl_cfg_bz_a0_mr_a0 = {
 	.fw_name_pre = IWL_BZ_A_MR_A_FW_PRE,
 	.uhb_supported = true,
-	IWL_DEVICE_AX210,
+	IWL_DEVICE_BZ,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index bf6ee56d4d96..999c6a4ab60e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -33,6 +33,7 @@ enum iwl_device_family {
 	IWL_DEVICE_FAMILY_9000,
 	IWL_DEVICE_FAMILY_22000,
 	IWL_DEVICE_FAMILY_AX210,
+	IWL_DEVICE_FAMILY_BZ,
 };
 
 /*
-- 
2.32.0

