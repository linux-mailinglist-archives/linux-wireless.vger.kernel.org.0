Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7192E1397
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Dec 2020 03:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgLWCbz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Dec 2020 21:31:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbgLWCZZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Dec 2020 21:25:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA93A2256F;
        Wed, 23 Dec 2020 02:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690305;
        bh=uOn4KuImGI6YWXKxFLzAQRXB6bKZf/q2T+OvJ/Btyac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I06+xGprfhd+DgIR5iQAlsMXCNPYaQhhuo+oeHAMiZLuagiH8AJ/lHmXa1F6oulQG
         yUMhY/YzFyvpA3dinqJqBHWwarQu8Sjnu1n0F/f/swXlU/YczQd+vFJQKBPqGx2bKo
         F48Z1YUmR8pt5IWggcQn6MIvJiFSNlryE3p9tszLIe0YFYIGQgGh+dJ/1JEpTM62Kx
         PzorIJ+BRoT09cbkZVDNtqSxzHoy/gTj2j8K+Epi4TMJYdvwVTOq5fZyQW6wycPCxo
         WoFS9KaB4UeLJG4qu3LdgseMrJaiPaxQQLGCqbjmuXcKN84VTUvuI6H9R3VYYNwZI7
         krqJrFrcF6uPQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 40/48] iwlwifi: add an extra firmware state in the transport
Date:   Tue, 22 Dec 2020 21:24:08 -0500
Message-Id: <20201223022417.2794032-40-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223022417.2794032-1-sashal@kernel.org>
References: <20201223022417.2794032-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit b2ed841ed070ccbe908016537f429a3a8f0221bf ]

Start tracking not just if the firmware is dead or alive,
but also if it's starting.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20201209231352.33e50d40b688.I8bbd41af7aa5e769273a6fc1c06fbf548dd2eb26@changeid
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 360554727a817..b1cc2b9f82ab6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -681,12 +681,14 @@ struct iwl_trans_ops {
 /**
  * enum iwl_trans_state - state of the transport layer
  *
- * @IWL_TRANS_NO_FW: no fw has sent an alive response
- * @IWL_TRANS_FW_ALIVE: a fw has sent an alive response
+ * @IWL_TRANS_NO_FW: firmware wasn't started yet, or crashed
+ * @IWL_TRANS_FW_STARTED: FW was started, but not alive yet
+ * @IWL_TRANS_FW_ALIVE: FW has sent an alive response
  */
 enum iwl_trans_state {
-	IWL_TRANS_NO_FW = 0,
-	IWL_TRANS_FW_ALIVE	= 1,
+	IWL_TRANS_NO_FW,
+	IWL_TRANS_FW_STARTED,
+	IWL_TRANS_FW_ALIVE,
 };
 
 /**
@@ -909,12 +911,18 @@ static inline int iwl_trans_start_fw(struct iwl_trans *trans,
 				     const struct fw_img *fw,
 				     bool run_in_rfkill)
 {
+	int ret;
+
 	might_sleep();
 
 	WARN_ON_ONCE(!trans->rx_mpdu_cmd);
 
 	clear_bit(STATUS_FW_ERROR, &trans->status);
-	return trans->ops->start_fw(trans, fw, run_in_rfkill);
+	ret = trans->ops->start_fw(trans, fw, run_in_rfkill);
+	if (ret == 0)
+		trans->state = IWL_TRANS_FW_STARTED;
+
+	return ret;
 }
 
 static inline int iwl_trans_update_sf(struct iwl_trans *trans,
-- 
2.27.0

