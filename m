Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1406946845E
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 12:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353891AbhLDLO2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 06:14:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50396 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1384733AbhLDLO1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 06:14:27 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtSwW-0017RD-FW; Sat, 04 Dec 2021 13:11:00 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 13:10:47 +0200
Message-Id: <iwlwifi.20211204130722.b0743a588d14.I098fef6677d0dab3ef1b6183ed206a10bab01eb2@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204111053.852455-1-luca@coelho.fi>
References: <20211204111053.852455-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/12] iwlwifi: mvm: avoid clearing a just saved session protection id
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

When scheduling a session protection the id is saved but
then it may be cleared when calling iwl_mvm_te_clear_data
(if a previous session protection is currently active).
Fix it by saving the id after calling iwl_mvm_te_clear_data.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index e91f8e889df7..e6813317edf3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1158,15 +1158,10 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
 							mvmvif->color)),
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
+		.conf_id = cpu_to_le32(SESSION_PROTECT_CONF_ASSOC),
 		.duration_tu = cpu_to_le32(MSEC_TO_TU(duration)),
 	};
 
-	/* The time_event_data.id field is reused to save session
-	 * protection's configuration.
-	 */
-	mvmvif->time_event_data.id = SESSION_PROTECT_CONF_ASSOC;
-	cmd.conf_id = cpu_to_le32(mvmvif->time_event_data.id);
-
 	lockdep_assert_held(&mvm->mutex);
 
 	spin_lock_bh(&mvm->time_event_lock);
@@ -1180,6 +1175,11 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 	}
 
 	iwl_mvm_te_clear_data(mvm, te_data);
+	/*
+	 * The time_event_data.id field is reused to save session
+	 * protection's configuration.
+	 */
+	te_data->id = le32_to_cpu(cmd.conf_id);
 	te_data->duration = le32_to_cpu(cmd.duration_tu);
 	te_data->vif = vif;
 	spin_unlock_bh(&mvm->time_event_lock);
-- 
2.33.1

