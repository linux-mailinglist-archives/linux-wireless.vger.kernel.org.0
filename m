Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE043F2A82
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 13:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbhHTLEV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 07:04:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57546 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239257AbhHTLEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 07:04:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mH2J4-002IL4-9o; Fri, 20 Aug 2021 14:03:27 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 20 Aug 2021 14:03:12 +0300
Message-Id: <iwlwifi.20210820140104.bdcd8f4a1620.Ie7331a8b94004d308f6cbde44e519155a5be91dd@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210820110318.260751-1-luca@coelho.fi>
References: <20210820110318.260751-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 06/12] iwlwifi: mvm: Fix scan channel flags settings
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The iwl_mvm_scan_ch_n_aps_flag() is called with a variable
before the value of the variable is set. Fix it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index e1b436e805b1..d78e436fa8b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1648,7 +1648,7 @@ iwl_mvm_umac_scan_cfg_channels_v6(struct iwl_mvm *mvm,
 		struct iwl_scan_channel_cfg_umac *cfg = &cp->channel_config[i];
 		u32 n_aps_flag =
 			iwl_mvm_scan_ch_n_aps_flag(vif_type,
-						   cfg->v2.channel_num);
+						   channels[i]->hw_value);
 
 		cfg->flags = cpu_to_le32(flags | n_aps_flag);
 		cfg->v2.channel_num = channels[i]->hw_value;
-- 
2.33.0

