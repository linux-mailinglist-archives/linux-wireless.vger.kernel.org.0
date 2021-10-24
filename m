Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C9C438956
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJXN5i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 09:57:38 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58530 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231699AbhJXN5h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 09:57:37 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1medxy-000cvJ-VD; Sun, 24 Oct 2021 16:55:15 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 16:55:00 +0300
Message-Id: <iwlwifi.20211024165252.0ca7c9322e69.Id2f32427795d0713fd7d2722567e604808b219dd@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024135506.285102-1-luca@coelho.fi>
References: <20211024135506.285102-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/11] iwlwifi: pcie: remove two duplicate PNJ device entries
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since PNJ and TH have the same ID (0x32), there are duplicate
entries. Remove the duplicates with PNJ since PNJ is only the
test device in the first place.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index adb3ad26b712..ab7a1a090b36 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -725,17 +725,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9462_name),
 
-	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
-		      iwl9260_2ac_cfg, iwl9560_160_name),
-	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
-		      iwl9260_2ac_cfg, iwl9560_name),
-
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
-- 
2.33.0

