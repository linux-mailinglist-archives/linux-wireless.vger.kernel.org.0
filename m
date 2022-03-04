Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B677C4CD34A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 12:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiCDLWj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 06:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbiCDLWd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 06:22:33 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53081B0C4A
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 03:21:45 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nQ60F-000QSW-7X;
        Fri, 04 Mar 2022 13:21:44 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Mar 2022 13:21:26 +0200
Message-Id: <iwlwifi.20220304131517.88574097ce1b.I1b42297619d638d677a2300ed9a95105c1262101@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304112129.219513-1-luca@coelho.fi>
References: <20220304112129.219513-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 10/13] iwlwifi: dbg: in sync mode don't call schedule
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Today in the code we have two options for collecting data sync/schedule,
the two options call the same function and can lead to racing in free
resources after done.

So we call only one of two sync/schedule, and in case of sync only
call sync function without also schedule to immediately run as a side
job.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 53f0fe77aa10..d3ac8ea049a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2992,10 +2992,10 @@ int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 		 "WRT: Collecting data: ini trigger %d fired (delay=%dms).\n",
 		 tp_id, (u32)(delay / USEC_PER_MSEC));
 
-	schedule_delayed_work(&fwrt->dump.wks[idx].wk, usecs_to_jiffies(delay));
-
 	if (sync)
 		iwl_fw_dbg_collect_sync(fwrt, idx);
+	else
+		schedule_delayed_work(&fwrt->dump.wks[idx].wk, usecs_to_jiffies(delay));
 
 	return 0;
 }
-- 
2.35.1

