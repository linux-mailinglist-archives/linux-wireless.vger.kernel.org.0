Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF4DD7B2
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 11:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfJSJjP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 05:39:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50424 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726275AbfJSJjO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 05:39:14 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlCb-0002fy-0c; Sat, 19 Oct 2019 12:39:13 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 12:38:56 +0300
Message-Id: <20191019093902.29823-5-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019093902.29823-1-luca@coelho.fi>
References: <20191019093902.29823-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 06/12] iwlwifi: dbg_ini: support dump collection upon assert during D3
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

add assert time point in the D3 resume flow in case there was an assert
during D3.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 1a9d83d6230f..43ebb2149b63 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1939,6 +1939,8 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	if (iwl_mvm_check_rt_status(mvm, vif)) {
 		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
 		iwl_mvm_dump_nic_error_log(mvm);
+		iwl_dbg_tlv_time_point(&mvm->fwrt,
+				       IWL_FW_INI_TIME_POINT_FW_ASSERT, NULL);
 		iwl_fw_dbg_collect_desc(&mvm->fwrt, &iwl_dump_desc_assert,
 					false, 0);
 		ret = 1;
-- 
2.23.0

