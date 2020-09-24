Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FDB277287
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgIXNh1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 09:37:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52100 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727993AbgIXNh1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 09:37:27 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLRDq-002IGj-SU; Thu, 24 Sep 2020 16:23:43 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 24 Sep 2020 16:23:33 +0300
Message-Id: <iwlwifi.20200924162105.c12a9b75da6b.I181fc5c80988e7ecea281c60e57a22ae7ec86716@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924132339.337310-1-luca@coelho.fi>
References: <20200924132339.337310-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 1/7] iwlwifi: enable twt by default
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Golan Ben Ami <golan.ben.ami@intel.com>

In a previous patch, a flag for disabling twt by a dbg-cfg
was added. This will be useful for disabling twt on specific
cores, after branch-out.
However, we'd like twt to be enabled on master.

So, enable twt on master.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index b0268f44b2ea..426ca1f86500 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -152,7 +152,7 @@
 #define IWL_MVM_FTM_INITIATOR_ALGO		IWL_TOF_ALGO_TYPE_MAX_LIKE
 #define IWL_MVM_FTM_INITIATOR_DYNACK		true
 #define IWL_MVM_D3_DEBUG			false
-#define IWL_MVM_USE_TWT				false
+#define IWL_MVM_USE_TWT				true
 #define IWL_MVM_AMPDU_CONSEC_DROPS_DELBA	10
 #define IWL_MVM_USE_NSSN_SYNC			0
 #define IWL_MVM_PHY_FILTER_CHAIN_A		0
-- 
2.28.0

