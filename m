Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003623E127A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbhHEKUB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:20:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51236 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240215AbhHEKT6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:19:58 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBaTW-00240Q-D5; Thu, 05 Aug 2021 13:19:43 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 13:19:29 +0300
Message-Id: <iwlwifi.20210805130823.a751177743c6.I5607504dade88ba461508643f58390dd661c05ba@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805101934.431479-1-luca@coelho.fi>
References: <20210805101934.431479-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 07/12] iwlwifi: mvm: silently drop encrypted frames for unknown station
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When a station is removed, the driver-mac80211 station mapping is removed
before the station is actually deleted from the FW. As a result, it is
reasonable that the FW will continue to pass frames although the driver
doesn't have a station for them anymore. Thus change the message
severity level from ERR to DEBUG_DROP.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index c0babb8d5b5c..06cc03820dd5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -69,8 +69,8 @@ static inline int iwl_mvm_check_pn(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	/* if we are here - this for sure is either CCMP or GCMP */
 	if (IS_ERR_OR_NULL(sta)) {
-		IWL_ERR(mvm,
-			"expected hw-decrypted unicast frame for station\n");
+		IWL_DEBUG_DROP(mvm,
+			       "expected hw-decrypted unicast frame for station\n");
 		return -1;
 	}
 
-- 
2.32.0

