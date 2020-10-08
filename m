Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7A2876DD
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgJHPM6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:12:58 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54578 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730874AbgJHPM5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:12:57 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXbD-002QxQ-Nb; Thu, 08 Oct 2020 18:12:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:12:41 +0300
Message-Id: <iwlwifi.20201008181047.0f355b4578c5.Ifbb76a2814925f215a2c889c1792d46d5bd66ab8@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008151250.332346-1-luca@coelho.fi>
References: <20201008151250.332346-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/13] iwlwifi: mvm: remove memset of kek_kck command
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

iwl_mvm_wowlan_program_keys is now setting data directly in
the KEK_KCK command, and the memset is clearing this later,
causing the data to be incomplete.

Just remove the memory clearing, the structure is local and
cleared in the declaration.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index e47c0be28656..9987172a9e01 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -870,7 +870,6 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		else
 			cmd_size = sizeof(struct iwl_wowlan_kek_kck_material_cmd_v2);
 
-		memset(&kek_kck_cmd, 0, sizeof(kek_kck_cmd));
 		memcpy(kek_kck_cmd.kck, mvmvif->rekey_data.kck,
 		       mvmvif->rekey_data.kck_len);
 		kek_kck_cmd.kck_len = cpu_to_le16(mvmvif->rekey_data.kck_len);
-- 
2.28.0

