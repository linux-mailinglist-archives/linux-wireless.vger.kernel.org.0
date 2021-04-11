Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885AD35B324
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhDKK0I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 06:26:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44524 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235234AbhDKK0I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 06:26:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVXHp-000K0H-C9; Sun, 11 Apr 2021 13:25:50 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 13:25:42 +0300
Message-Id: <iwlwifi.20210411132130.5bd095dc579a.Id1f3b746ac61497951638ba7ce70fc4b63dd87d1@changeid>
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
Subject: [PATCH 5/8] iwlwifi: fw: print out trigger delay when collecting data
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

It can be confusing to see "Collecting data: ..." followed by
that not actually happening immediately so print out the delay
in that message.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 504729663c35..cc4e18ca9566 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2559,7 +2559,9 @@ int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 
 	fwrt->dump.wks[idx].dump_data = *dump_data;
 
-	IWL_WARN(fwrt, "WRT: Collecting data: ini trigger %d fired.\n", tp_id);
+	IWL_WARN(fwrt,
+		 "WRT: Collecting data: ini trigger %d fired (delay=%dms).\n",
+		 tp_id, (u32)(delay / USEC_PER_MSEC));
 
 	schedule_delayed_work(&fwrt->dump.wks[idx].wk, usecs_to_jiffies(delay));
 
-- 
2.31.0

