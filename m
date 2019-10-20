Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AABAEDDD64
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 10:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfJTI4C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 04:56:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50808 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbfJTI4B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 04:56:01 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iM70K-0003LY-AG; Sun, 20 Oct 2019 11:56:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 20 Oct 2019 11:55:42 +0300
Message-Id: <20191020085545.16407-8-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191020085545.16407-1-luca@coelho.fi>
References: <20191020085545.16407-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 09/12] iwlwifi: mvm: sync the iwl_mvm_session_prot_notif layout
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware API has changed a little bit but this change
has no impact on the flow and is backward compatible.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
index 416e817d7b4d..a731f28e101a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -459,6 +459,7 @@ struct iwl_mvm_session_prot_cmd {
  * @mac_id: the mac id for which the session protection started / ended
  * @status: 1 means success, 0 means failure
  * @start: 1 means the session protection started, 0 means it ended
+ * @conf_id: the configuration id of the session that started / eneded
  *
  * Note that any session protection will always get two notifications: start
  * and end even the firmware could not schedule it.
@@ -467,6 +468,7 @@ struct iwl_mvm_session_prot_notif {
 	__le32 mac_id;
 	__le32 status;
 	__le32 start;
-} __packed; /* SESSION_PROTECTION_NOTIFICATION_API_S_VER_1 */
+	__le32 conf_id;
+} __packed; /* SESSION_PROTECTION_NOTIFICATION_API_S_VER_2 */
 
 #endif /* __iwl_fw_api_time_event_h__ */
-- 
2.23.0

