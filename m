Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7642335B321
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhDKK0G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 06:26:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44506 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235166AbhDKK0F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 06:26:05 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVXHm-000K0H-Rq; Sun, 11 Apr 2021 13:25:48 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 13:25:39 +0300
Message-Id: <iwlwifi.20210411132130.0324abc169c8.I4f9b769bc38d68f8ed43f77d2cd75e8f1993e964@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210411102545.438654-1-luca@coelho.fi>
References: <20210411102545.438654-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 2/8] iwlwifi: mvm: don't WARN if we can't remove a time event
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

It is not very useful to WARN if we can't send a host command
The firmware is likely in a bad situation and the fact that
we didn't send the host command has an impact on the firmware
only, not on the driver. The driver could clean up all its
state.

Don't WARN in this case, but just leave a smaller note.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 76c36f5cf9a3..83342a6a6d5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -734,8 +734,8 @@ void iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 	IWL_DEBUG_TE(mvm, "Removing TE 0x%x\n", le32_to_cpu(time_cmd.id));
 	ret = iwl_mvm_send_cmd_pdu(mvm, TIME_EVENT_CMD, 0,
 				   sizeof(time_cmd), &time_cmd);
-	if (WARN_ON(ret))
-		return;
+	if (ret)
+		IWL_ERR(mvm, "Couldn't remove the time event\n");
 }
 
 /*
-- 
2.31.0

