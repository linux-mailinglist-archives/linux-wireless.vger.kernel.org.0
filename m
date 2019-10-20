Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35340DDD60
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 10:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfJTI4A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 04:56:00 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50790 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbfJTI4A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 04:56:00 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iM70I-0003LY-9d; Sun, 20 Oct 2019 11:55:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 20 Oct 2019 11:55:39 +0300
Message-Id: <20191020085545.16407-5-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191020085545.16407-1-luca@coelho.fi>
References: <20191020085545.16407-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 06/12] iwlwifi: mvm: scan: enable adaptive dwell in p2p
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Align to the requirement update and support adaptive dwell in p2p scan.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index adfaa5d01206..0ee8f4af940e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1639,8 +1639,7 @@ static u16 iwl_mvm_scan_umac_flags_v2(struct iwl_mvm *mvm,
 	    mvm->sched_scan_pass_all == SCHED_SCAN_PASS_ALL_ENABLED)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_NTFY_ITER_COMPLETE;
 
-	if (IWL_MVM_ADWELL_ENABLE &&
-	    vif->type != NL80211_IFTYPE_P2P_DEVICE)
+	if (IWL_MVM_ADWELL_ENABLE)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_ADAPTIVE_DWELL;
 
 	if (type == IWL_MVM_SCAN_SCHED || type == IWL_MVM_SCAN_NETDETECT)
@@ -1692,8 +1691,7 @@ static u16 iwl_mvm_scan_umac_flags(struct iwl_mvm *mvm,
 	if (mvm->sched_scan_pass_all == SCHED_SCAN_PASS_ALL_ENABLED)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_ITER_COMPLETE;
 
-	if (iwl_mvm_is_adaptive_dwell_supported(mvm) && IWL_MVM_ADWELL_ENABLE &&
-	    vif->type != NL80211_IFTYPE_P2P_DEVICE)
+	if (iwl_mvm_is_adaptive_dwell_supported(mvm) && IWL_MVM_ADWELL_ENABLE)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_ADAPTIVE_DWELL;
 
 	/*
-- 
2.23.0

