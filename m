Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C95461699
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbhK2NiZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:38:25 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49802 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1377758AbhK2NgT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:19 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mrgmB-0012xo-WF; Mon, 29 Nov 2021 15:33:00 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:32:39 +0200
Message-Id: <iwlwifi.20211129152938.4573a221c0e1.I0d1d5daea3089be3fc0dccc92991b0f8c5677f0c@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129133248.83829-1-luca@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/16] mac80211: mark TX-during-stop for TX in in_reconfig
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Mark TXQs as having seen transmit while they were stopped if
we bail out of drv_wake_tx_queue() due to reconfig, so that
the queue wake after this will make them catch up. This is
particularly necessary for when TXQs are used for management
packets since those TXQs won't see a lot of traffic that'd
make them catch up later.

Cc: stable@vger.kernel.org
Fixes: 4856bfd23098 ("mac80211: do not call driver wake_tx_queue op during reconfig")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/driver-ops.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index cd3731cbf6c6..c336267f4599 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1219,8 +1219,11 @@ static inline void drv_wake_tx_queue(struct ieee80211_local *local,
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(txq->txq.vif);
 
-	if (local->in_reconfig)
+	/* In reconfig don't transmit now, but mark for waking later */
+	if (local->in_reconfig) {
+		set_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txq->flags);
 		return;
+	}
 
 	if (!check_sdata_in_driver(sdata))
 		return;
-- 
2.33.1

