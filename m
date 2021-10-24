Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E3438954
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhJXN5f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 09:57:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58518 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231524AbhJXN5e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 09:57:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1medxw-000cvJ-9L; Sun, 24 Oct 2021 16:55:13 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 16:54:58 +0300
Message-Id: <iwlwifi.20211024165252.239f82fc3737.I5fef3a20fbce77e201dc35d45be0ee526bcd3cd3@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024135506.285102-1-luca@coelho.fi>
References: <20211024135506.285102-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/11] iwlwifi: pcie: remove duplicate entry
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This entry is literally duplicated, remove one of them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index aeac1b3997ab..fec1620bd593 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1074,11 +1074,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
-- 
2.33.0

