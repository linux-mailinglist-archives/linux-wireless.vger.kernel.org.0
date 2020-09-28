Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD88327A799
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 08:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1Gfn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 02:35:43 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52694 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725308AbgI1Gfn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 02:35:43 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMml9-002KaM-Vf; Mon, 28 Sep 2020 09:35:41 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 09:35:38 +0300
Message-Id: <iwlwifi.20200928093526.44c9093fc632.I181fc5c80988e7ecea281c60e57a22ae7ec86716@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <iwlwifi.20200924162105.c12a9b75da6b.I181fc5c80988e7ecea281c60e57a22ae7ec86716@changeid>
References: <iwlwifi.20200924162105.c12a9b75da6b.I181fc5c80988e7ecea281c60e57a22ae7ec86716@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 1/7] iwlwifi: enable twt by default
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Golan Ben Ami <golan.ben.ami@intel.com>

TWT has been disabled during stabilization and further testing of the
FW code.  It is now considered stable, so TWT can be enabled in the
driver.

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

