Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3D18F598
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 14:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgCWNUW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 09:20:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43466 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728372AbgCWNUW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 09:20:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jGMzV-00023f-U8; Mon, 23 Mar 2020 15:19:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 15:19:21 +0200
Message-Id: <iwlwifi.20200323151304.0032c72bd479.I79745e440ed5a0a90db61b0daaae374ecef09e86@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323131925.208376-1-luca@coelho.fi>
References: <20200323131925.208376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/14] iwlwifi: remove some unused extern declarations from iwl-config.h
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

After the refactoring, a few extern declarations were accidentally
left in the iwl-config.h file.  Remove them

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 2e9a85a9ee67..09eec2ef1b07 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -588,9 +588,6 @@ extern const struct iwl_cfg iwl8265_2ac_cfg;
 extern const struct iwl_cfg iwl8275_2ac_cfg;
 extern const struct iwl_cfg iwl4165_2ac_cfg;
 extern const struct iwl_cfg iwl9260_2ac_cfg;
-extern const struct iwl_cfg iwl9260_2ac_160_cfg;
-extern const struct iwl_cfg iwl9260_killer_2ac_cfg;
-extern const struct iwl_cfg iwl9270_2ac_cfg;
 extern const struct iwl_cfg iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
@@ -598,15 +595,9 @@ extern const struct iwl_cfg iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
 extern const struct iwl_cfg iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc;
-extern const struct iwl_cfg iwl9461_2ac_cfg_shared_clk;
-extern const struct iwl_cfg iwl9462_2ac_cfg_shared_clk;
-extern const struct iwl_cfg iwl9560_2ac_160_cfg_shared_clk;
-extern const struct iwl_cfg iwl9560_killer_2ac_cfg_shared_clk;
-extern const struct iwl_cfg iwl9560_killer_s_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwl_ax101_cfg_qu_hr;
 extern const struct iwl_cfg iwl_ax101_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg iwl_ax101_cfg_quz_hr;
-extern const struct iwl_cfg iwl22000_2ax_cfg_hr;
 extern const struct iwl_cfg iwl_ax200_cfg_cc;
 extern const struct iwl_cfg iwl_ax201_cfg_qu_hr;
 extern const struct iwl_cfg iwl_ax201_cfg_qu_hr;
-- 
2.25.1

