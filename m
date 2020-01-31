Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C25EB14EBB1
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgAaL1C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:27:02 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55922 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728374AbgAaL1C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:27:02 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEf-0002GC-EI; Fri, 31 Jan 2020 13:13:20 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:51 +0200
Message-Id: <20200131111300.891737-15-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 14/23] mac80211: fix quiet mode activation in action frames
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

Previously I intended to ignore quiet mode in probe response, however
I ended up ignoring it instead for action frames. As a matter of fact,
this path isn't invoked for probe responses to start with. Just revert
this patch.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Fixes: 7976b1e9e3bf ("mac80211: ignore quiet mode in probe")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 92efc3676c70..f78e7aa67991 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8,7 +8,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -1338,7 +1338,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	if (!res) {
 		ch_switch.timestamp = timestamp;
 		ch_switch.device_timestamp = device_timestamp;
-		ch_switch.block_tx =  beacon ? csa_ie.mode : 0;
+		ch_switch.block_tx = csa_ie.mode;
 		ch_switch.chandef = csa_ie.chandef;
 		ch_switch.count = csa_ie.count;
 		ch_switch.delay = csa_ie.max_switch_time;
@@ -1431,7 +1431,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 
 	sdata->vif.csa_active = true;
 	sdata->csa_chandef = csa_ie.chandef;
-	sdata->csa_block_tx = ch_switch.block_tx;
+	sdata->csa_block_tx = csa_ie.mode;
 	ifmgd->csa_ignored_same_chan = false;
 
 	if (sdata->csa_block_tx)
@@ -1465,7 +1465,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	 * reset when the disconnection worker runs.
 	 */
 	sdata->vif.csa_active = true;
-	sdata->csa_block_tx = ch_switch.block_tx;
+	sdata->csa_block_tx = csa_ie.mode;
 
 	ieee80211_queue_work(&local->hw, &ifmgd->csa_connection_drop_work);
 	mutex_unlock(&local->chanctx_mtx);
-- 
2.24.1

