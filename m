Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0881E438952
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhJXN5d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 09:57:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58506 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231485AbhJXN5c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 09:57:32 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1medxt-000cvJ-ME; Sun, 24 Oct 2021 16:55:10 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 16:54:56 +0300
Message-Id: <iwlwifi.20211024165252.fecbcd7c2fcc.I7419f102b798ba0cecd93c80f345b241670e0683@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024135506.285102-1-luca@coelho.fi>
References: <20211024135506.285102-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 01/11] iwlwifi: mvm: fix some kerneldoc issues
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

A few fields were missing their kerneldoc in the station
capabilities.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Fixes: c8a2e7a29702 ("iwlwifi: sta: set max HE max A-MPDU according to HE capa")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
index f1a3e14880e7..5edbe27c0922 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
@@ -28,6 +28,8 @@
  * @STA_FLG_MAX_AGG_SIZE_256K: maximal size for A-MPDU (256k supported)
  * @STA_FLG_MAX_AGG_SIZE_512K: maximal size for A-MPDU (512k supported)
  * @STA_FLG_MAX_AGG_SIZE_1024K: maximal size for A-MPDU (1024k supported)
+ * @STA_FLG_MAX_AGG_SIZE_2M: maximal size for A-MPDU (2M supported)
+ * @STA_FLG_MAX_AGG_SIZE_4M: maximal size for A-MPDU (4M supported)
  * @STA_FLG_AGG_MPDU_DENS_MSK: maximal MPDU density for Tx aggregation
  * @STA_FLG_FAT_EN_MSK: support for channel width (for Tx). This flag is
  *	initialised by driver and can be updated by fw upon reception of
-- 
2.33.0

