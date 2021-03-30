Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF1634E904
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhC3NZs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 09:25:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43606 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232017AbhC3NZI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 09:25:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lREMh-0007fg-FC; Tue, 30 Mar 2021 16:25:05 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Mar 2021 16:24:52 +0300
Message-Id: <iwlwifi.20210330162204.9adaedeb59e4.Idaad6aaf3f9759d023b8e00b10064915c0db9aa3@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210330132500.468321-1-luca@coelho.fi>
References: <20210330132500.468321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 04/12] iwlwifi: mvm: don't allow CSA if we haven't been fully associated
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

"Fully associated" means that we heard a beacon with the DTIM
information and the firmware is configured to track the beacons.
Since the firmware needs to track the beacons for the CSA, we
can't configure the firmware for CSA before it knows when the
beacons are expected otherwise we'd get ASSERT 301D.
If we are required to start CSA before we told the firmware
when the beacons are expected to arrive, just report a
failure and let mac80211 disconnect.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index baf7404c137d..9ed6e2783cc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4610,6 +4610,16 @@ static int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 
 		break;
 	case NL80211_IFTYPE_STATION:
+		/*
+		 * We haven't configured the firmware to be associated yet since
+		 * we don't know the dtim period. In this case, the firmware can't
+		 * track the beacons.
+		 */
+		if (!vif->bss_conf.assoc || !vif->bss_conf.dtim_period) {
+			ret = -EBUSY;
+			goto out_unlock;
+		}
+
 		if (chsw->delay > IWL_MAX_CSA_BLOCK_TX)
 			schedule_delayed_work(&mvmvif->csa_work, 0);
 
-- 
2.31.0

