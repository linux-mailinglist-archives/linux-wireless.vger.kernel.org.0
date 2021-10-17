Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B06430782
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 11:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245119AbhJQJme (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 05:42:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53646 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241723AbhJQJme (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 05:42:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc2eU-000YUg-JX; Sun, 17 Oct 2021 12:40:22 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 12:40:09 +0300
Message-Id: <iwlwifi.20211017123741.f2ff92fcbe4d.Id2b8edd2160d9a703a7a2744e1139017cfd958c0@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017094019.442271-1-luca@coelho.fi>
References: <20211017094019.442271-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/12] iwlwifi: api: fix struct iwl_wowlan_status_v7 kernel-doc
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This was mislabeled as struct iwl_wowlan_status, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 3ec82cae3981..e199d1813a61 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -624,7 +624,7 @@ struct iwl_wowlan_status_v6 {
 } __packed; /* WOWLAN_STATUSES_API_S_VER_6 */
 
 /**
- * struct iwl_wowlan_status - WoWLAN status
+ * struct iwl_wowlan_status_v7 - WoWLAN status
  * @gtk: GTK data
  * @igtk: IGTK data
  * @replay_ctr: GTK rekey replay counter
-- 
2.33.0

