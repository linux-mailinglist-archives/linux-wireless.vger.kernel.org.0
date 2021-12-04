Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B10F468609
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 16:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347186AbhLDPxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 10:53:18 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50466 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346966AbhLDPxR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 10:53:17 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtXIM-0017qB-4U; Sat, 04 Dec 2021 17:49:50 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 17:49:35 +0200
Message-Id: <iwlwifi.20211204174545.675781ab0da5.I5c653f4c7dd726f8ad40077e4a109b85e7c0cdb1@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204154944.914175-1-luca@coelho.fi>
References: <20211204154944.914175-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/12] iwlwifi: mvm: always use 4K RB size by default
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we use 2K RBs, we cannot receive all valid 802.11 frames,
including e.g. long beacons, since up to 2304 bytes are valid
(plus metadata and also encryption overhead etc.). Increase
the RB size to be always 4K to avoid that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 8056018600ad..9c0872b106b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1055,7 +1055,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	};
 	int scan_size;
 	u32 min_backoff;
-	enum iwl_amsdu_size rb_size_default;
 	struct iwl_mvm_csme_conn_info *csme_conn_info __maybe_unused;
 
 	/*
@@ -1198,14 +1197,9 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	trans_cfg.no_reclaim_cmds = no_reclaim_cmds;
 	trans_cfg.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds);
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		rb_size_default = IWL_AMSDU_2K;
-	else
-		rb_size_default = IWL_AMSDU_4K;
-
 	switch (iwlwifi_mod_params.amsdu_size) {
 	case IWL_AMSDU_DEF:
-		trans_cfg.rx_buf_size = rb_size_default;
+		trans_cfg.rx_buf_size = IWL_AMSDU_4K;
 		break;
 	case IWL_AMSDU_4K:
 		trans_cfg.rx_buf_size = IWL_AMSDU_4K;
@@ -1219,7 +1213,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	default:
 		pr_err("%s: Unsupported amsdu_size: %d\n", KBUILD_MODNAME,
 		       iwlwifi_mod_params.amsdu_size);
-		trans_cfg.rx_buf_size = rb_size_default;
+		trans_cfg.rx_buf_size = IWL_AMSDU_4K;
 	}
 
 	trans->wide_cmd_header = true;
-- 
2.33.1

