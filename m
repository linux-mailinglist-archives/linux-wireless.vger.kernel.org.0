Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39595CBA99
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbfJDMhX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 08:37:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:46528 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387573AbfJDMhW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 08:37:22 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iGMpk-0000k1-D8; Fri, 04 Oct 2019 15:37:20 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  4 Oct 2019 15:37:05 +0300
Message-Id: <20191004123706.15768-2-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004123706.15768-1-luca@coelho.fi>
References: <20191004123706.15768-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 1/2] mac80211: accept deauth frames in IBSS mode
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We can process deauth frames and all, but we drop them very
early in the RX path today - this could never have worked.

Fixes: 2cc59e784b54 ("mac80211: reply to AUTH with DEAUTH if sta allocation fails in IBSS")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/rx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 768d14c9a716..0e05ff037672 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3467,9 +3467,18 @@ ieee80211_rx_h_mgmt(struct ieee80211_rx_data *rx)
 	case cpu_to_le16(IEEE80211_STYPE_PROBE_RESP):
 		/* process for all: mesh, mlme, ibss */
 		break;
+	case cpu_to_le16(IEEE80211_STYPE_DEAUTH):
+		if (is_multicast_ether_addr(mgmt->da) &&
+		    !is_broadcast_ether_addr(mgmt->da))
+			return RX_DROP_MONITOR;
+
+		/* process only for station/IBSS */
+		if (sdata->vif.type != NL80211_IFTYPE_STATION &&
+		    sdata->vif.type != NL80211_IFTYPE_ADHOC)
+			return RX_DROP_MONITOR;
+		break;
 	case cpu_to_le16(IEEE80211_STYPE_ASSOC_RESP):
 	case cpu_to_le16(IEEE80211_STYPE_REASSOC_RESP):
-	case cpu_to_le16(IEEE80211_STYPE_DEAUTH):
 	case cpu_to_le16(IEEE80211_STYPE_DISASSOC):
 		if (is_multicast_ether_addr(mgmt->da) &&
 		    !is_broadcast_ether_addr(mgmt->da))
-- 
2.23.0

